Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5233F3AECA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFUPmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhFUPmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624290031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTd9o0/iIYAJM8en1E5Wd0mT6Cbp04deGv4dp4XSwjk=;
        b=UROKt5uzDPAMECHe0ixwbssgawGxuFGDNTeIP6TVCCgfpq80hZQXeE/SDma6bL/UJZcoba
        A56LtKpnUxu4/c7fDFdpJecVqgllJwMNki8kM1ubJ+hp8/hSRYi1JASko1TtacA01Tt0bI
        Jcl/kqrzNyv4Ka8M/Pv/bOSJVJZWpXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Ib2u_z81Ma-ZVgxMa4qJ5A-1; Mon, 21 Jun 2021 11:40:27 -0400
X-MC-Unique: Ib2u_z81Ma-ZVgxMa4qJ5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCCC418414A0;
        Mon, 21 Jun 2021 15:40:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 706ED5D9CA;
        Mon, 21 Jun 2021 15:40:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 1/2] afs: Fix afs_write_end() to handle short writes
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 16:40:17 +0100
Message-ID: <162429001766.2770648.1072619730387446884.stgit@warthog.procyon.org.uk>
In-Reply-To: <162429000639.2770648.6368710175435880749.stgit@warthog.procyon.org.uk>
References: <162429000639.2770648.6368710175435880749.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_write_end() to correctly handle a short copy into the intended
write region of the page.  Two things are necessary:

 (1) If the page is not up to date, then we should just return 0
     (ie. indicating a zero-length copy).  The loop in
     generic_perform_write() will go around again, possibly breaking up the
     iterator into discrete chunks[1].

     This is analogous to commit b9de313cf05fe08fa59efaf19756ec5283af672a
     for ceph.

 (2) The page should not have been set uptodate if it wasn't completely set
     up by netfs_write_begin() (this will be fixed in the next patch), so
     we need to set uptodate here in such a case.

Also remove the assertion that was checking that the page was set uptodate
since it's now set uptodate if it wasn't already a few lines above.  The
assertion was from when uptodate was set elsewhere.

Changes:
v3: Remove the handling of len exceeding the end of the page.

Fixes: 3003bbd0697b ("afs: Use the netfs_write_begin() helper")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/YMwVp268KTzTf8cN@zeniv-ca.linux.org.uk/ [1]
Link: https://lore.kernel.org/r/162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/162391825688.1173366.3437507255136307904.stgit@warthog.procyon.org.uk/ # v2
---

 fs/afs/write.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index a523bb86915d..641c54679399 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -118,6 +118,15 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
 
+	if (!PageUptodate(page)) {
+		if (copied < len) {
+			copied = 0;
+			goto out;
+		}
+
+		SetPageUptodate(page);
+	}
+
 	if (copied == 0)
 		goto out;
 
@@ -132,8 +141,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		write_sequnlock(&vnode->cb_lock);
 	}
 
-	ASSERT(PageUptodate(page));
-
 	if (PagePrivate(page)) {
 		priv = page_private(page);
 		f = afs_page_dirty_from(page, priv);


