Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35F029DCE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgJ2AdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733150AbgJ1WXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoiOCU+qWolYiRHq1xBD529LxEgjxZ8BMPvyGjvZBwg=;
        b=JBHWVPez+TLOs9MLrEjrMbasGk5+yFKTJl2oIfiylwU3RxeDzMdfbtCyUfvdl+BnjcexgX
        libjeMiU2A2Bq/oIISU+mBXZ/8mMlvMZlGtzuH9K4eLKEDBCu+3x6p6hzQqcb8B9dTeykB
        a72vQ2jouxqFXNt6IpjKvhY27dDwhi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-5A7Qh6hRNnyuJlRb0_nntA-1; Wed, 28 Oct 2020 18:23:14 -0400
X-MC-Unique: 5A7Qh6hRNnyuJlRb0_nntA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 386E1107AFA5;
        Wed, 28 Oct 2020 22:23:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2043F5C1D0;
        Wed, 28 Oct 2020 22:23:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/11] afs: Fix to take ref on page when PG_private is set
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:23:11 +0000
Message-ID: <160392379129.592578.15917327277370370590.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs to take a ref on a page when it sets PG_private on it and to drop
the ref when removing the flag.

Note that in afs_write_begin(), a lot of the time, PG_private is already
set on a page to which we're going to add some data.  In such a case, we
leave the bit set and mustn't increment the page count.

As suggested by Matthew Wilcox, use attach/detach_page_private() where
possible.

Fixes: 31143d5d515e ("AFS: implement basic file write support")
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |   12 ++++--------
 fs/afs/dir_edit.c |    6 ++----
 fs/afs/file.c     |    6 ++----
 fs/afs/write.c    |   17 ++++++++++-------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1d2e61e0ab04..1bb5b9d7f0a2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -281,8 +281,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 			if (ret < 0)
 				goto error;
 
-			set_page_private(req->pages[i], 1);
-			SetPagePrivate(req->pages[i]);
+			attach_page_private(req->pages[i], (void *)1);
 			unlock_page(req->pages[i]);
 			i++;
 		} else {
@@ -1975,8 +1974,7 @@ static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
 
 	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, page->index);
 
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	detach_page_private(page);
 
 	/* The directory will need reloading. */
 	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
@@ -2003,8 +2001,6 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 		afs_stat_v(dvnode, n_inval);
 
 	/* we clean up only if the entire page is being invalidated */
-	if (offset == 0 && length == PAGE_SIZE) {
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-	}
+	if (offset == 0 && length == PAGE_SIZE)
+		detach_page_private(page);
 }
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index b108528bf010..2ffe09abae7f 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -243,10 +243,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 						   index, gfp);
 			if (!page)
 				goto error;
-			if (!PagePrivate(page)) {
-				set_page_private(page, 1);
-				SetPagePrivate(page);
-			}
+			if (!PagePrivate(page))
+				attach_page_private(page, (void *)1);
 			dir_page = kmap(page);
 		}
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 91225421ad37..4503c493dddb 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -630,8 +630,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 			priv = page_private(page);
 			trace_afs_page_dirty(vnode, tracepoint_string("inval"),
 					     page->index, priv);
-			set_page_private(page, 0);
-			ClearPagePrivate(page);
+			detach_page_private(page);
 		}
 	}
 
@@ -664,8 +663,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 		priv = page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"),
 				     page->index, priv);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
+		detach_page_private(page);
 	}
 
 	/* indicate that the page can be released */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index b937ec047ec9..50d5ff4ad70d 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -151,8 +151,10 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	priv |= f;
 	trace_afs_page_dirty(vnode, tracepoint_string("begin"),
 			     page->index, priv);
-	SetPagePrivate(page);
-	set_page_private(page, priv);
+	if (PagePrivate(page))
+		set_page_private(page, priv);
+	else
+		attach_page_private(page, (void *)priv);
 	_leave(" = 0");
 	return 0;
 
@@ -337,7 +339,7 @@ static void afs_pages_written_back(struct afs_vnode *vnode,
 			priv = page_private(pv.pages[loop]);
 			trace_afs_page_dirty(vnode, tracepoint_string("clear"),
 					     pv.pages[loop]->index, priv);
-			set_page_private(pv.pages[loop], 0);
+			detach_page_private(pv.pages[loop]);
 			end_page_writeback(pv.pages[loop]);
 		}
 		first += count;
@@ -863,8 +865,10 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	priv |= 0; /* From */
 	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
 			     vmf->page->index, priv);
-	SetPagePrivate(vmf->page);
-	set_page_private(vmf->page, priv);
+	if (PagePrivate(vmf->page))
+		set_page_private(vmf->page, priv);
+	else
+		attach_page_private(vmf->page, (void *)priv);
 	file_update_time(file);
 
 	sb_end_pagefault(inode->i_sb);
@@ -928,8 +932,7 @@ int afs_launder_page(struct page *page)
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"),
 			     page->index, priv);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	detach_page_private(page);
 
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page)) {


