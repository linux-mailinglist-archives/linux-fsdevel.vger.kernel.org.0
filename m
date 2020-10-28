Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1329D75D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgJ1WXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732546AbgJ1WXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xx76vSLLH+d7BdtHr7UtYH6UZ1OnxPJDcMo+S5PWSvQ=;
        b=cj6iWSJ+QY1fiYegZElfL4j00ILOmYadhQKMGyO8qjf6yhuSZb/d2THLMxWP/hmRIImz+R
        5VlPsZVz8v+m09SphbT7C+MGnDM7J5Y5FOAXQkVSRyODEziHdGi0iKKNf/GSeAre0EuiHN
        w3RW82ChH5BZJZYnWiYERCMzc+0Dpj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-9l9j77zEPv-Epf81OPXn9w-1; Wed, 28 Oct 2020 18:23:28 -0400
X-MC-Unique: 9l9j77zEPv-Epf81OPXn9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DCE91007464;
        Wed, 28 Oct 2020 22:23:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F5D6EF54;
        Wed, 28 Oct 2020 22:23:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/11] afs: Fix where page->private is set during write
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:23:25 +0000
Message-ID: <160392380529.592578.4152846383503818825.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

 fs/afs/write.c |   41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 6eb367d04eda..9b66e4a6be92 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -135,23 +135,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
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
-	if (PagePrivate(page))
-		set_page_private(page, priv);
-	else
-		attach_page_private(page, (void *)priv);
 	*_page = page;
 	_leave(" = 0");
 	return 0;
@@ -185,6 +170,9 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct key *key = afs_file_key(file);
+	unsigned long priv;
+	unsigned int f, from = pos & (PAGE_SIZE - 1);
+	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
 	int ret;
 
@@ -216,6 +204,29 @@ int afs_write_end(struct file *file, struct address_space *mapping,
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
+		set_page_private(page, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("dirty+"),
+				     page->index, priv);
+	} else {
+		f = from;
+		t = to;
+		priv = (unsigned long)t << AFS_PRIV_SHIFT;
+		priv |= f;
+		attach_page_private(page, (void *)priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("dirty"),
+				     page->index, priv);
+	}
+
 	set_page_dirty(page);
 	if (PageDirty(page))
 		_debug("dirtied");


