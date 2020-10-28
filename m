Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9409F29D632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgJ1WLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730667AbgJ1WLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRhi7APciQrik/nT2sHzIcXgBkf/nbz0yk1cveHlULg=;
        b=FOy90ADs/mvc2UCV0c1j6IjrRSO8t/JrpxccN89mUR+K3JOAts23NGXpRlr+n0CKF8Kve1
        GOuLg+vs722XDy/IXWBsA1eWpLQK+HVjXqvM9oOo1d1Q7opLLItEFJjvnSiVDrN18PZO8I
        S2F4H8RN81w1m9oTj1Hb87MoO+9wyOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Q8iqLG76PJGsO6FMA2bR2w-1; Wed, 28 Oct 2020 10:10:42 -0400
X-MC-Unique: Q8iqLG76PJGsO6FMA2bR2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92962966B3B;
        Wed, 28 Oct 2020 14:10:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B83546266E;
        Wed, 28 Oct 2020 14:10:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/11] afs: Fix where page->private is set during write
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 14:10:38 +0000
Message-ID: <160389423890.300137.12394236104663953803.stgit@warthog.procyon.org.uk>
In-Reply-To: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In afs, page->private is set to indicate the dirty region of a page.  This
is done in afs_write_begin(), but that can't take account of whether the
copy into the page actually worked.

Fix this by moving the change of page->private into afs_write_end().

Fixes: 4343d00872e1 ("afs: Get rid of the afs_writeback record")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/write.c |   41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 16a896096ccf..5ed5df906744 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -135,22 +135,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		if (!test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags) &&
 		    (to < f || from > t))
 			goto flush_conflicting_write;
-		if (from < f)
-			f = from;
-		if (to > t)
-			t = to;
-	} else {
-		f = from;
-		t = to;
 	}
 
-	priv = (unsigned long)t << AFS_PRIV_SHIFT;
-	priv |= f;
-	trace_afs_page_dirty(vnode, tracepoint_string("begin"),
-			     page->index, priv);
-	if (!TestSetPagePrivate(page))
-		get_page(page);
-	set_page_private(page, priv);
 	*_page = page;
 	_leave(" = 0");
 	return 0;
@@ -184,6 +170,9 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct key *key = afs_file_key(file);
+	unsigned long priv;
+	unsigned int f, from = pos & (PAGE_SIZE - 1);
+	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
 	int ret;
 
@@ -215,6 +204,30 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		SetPageUptodate(page);
 	}
 
+	if (PagePrivate(page)) {
+		priv = page_private(page);
+		f = priv & AFS_PRIV_MAX;
+		t = priv >> AFS_PRIV_SHIFT;
+		if (from < f)
+			f = from;
+		if (to > t)
+			t = to;
+		priv = (unsigned long)t << AFS_PRIV_SHIFT;
+		priv |= f;
+		trace_afs_page_dirty(vnode, tracepoint_string("dirty+"),
+				     page->index, priv);
+	} else {
+		SetPagePrivate(page);
+		get_page(page);
+		f = from;
+		t = to;
+		priv = (unsigned long)t << AFS_PRIV_SHIFT;
+		priv |= f;
+		trace_afs_page_dirty(vnode, tracepoint_string("dirty"),
+				     page->index, priv);
+	}
+
+	set_page_private(page, priv);
 	set_page_dirty(page);
 	if (PageDirty(page))
 		_debug("dirtied");


