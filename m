Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C63469F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhCWUiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233398AbhCWUit (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:38:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEB8A61574;
        Tue, 23 Mar 2021 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616531929;
        bh=PHJ7bufV+TaD1YdzVkwIq0u+qfsXtCC6wFFXm1BrkVU=;
        h=From:To:Cc:Subject:Date:From;
        b=a2TPsMtGvtSK96m0BNuIuZOeVbh0kQqTbtoQyGcpoiME9es4625fbvMZqa8dlQQkq
         iooQ0oD6seCVeIn1lMs98C+54pG54mvCvHRmE9WkSCiXbIZUfUGtc5nDAOvTly8XOB
         aIs6q+5He7jM0ZKeVoM/uYWpiSRFLcenHyvyenEkDNcxSdKeyFIKlW5t5Yqv1fccL8
         PGBUv2shKjX1DWC8vACi3Z1og/N/T5AU9R6U3Hsuue3hO98i7NN/9eTxR5WDsKlCUV
         3EWcmtDVtblNQkglNA2TBYpJxOF+cyFNcgC4M9Zmk6kP+915otk/kGr7DJ6u78ku4J
         u7+/y4qpSCQrQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com
Subject: [PATCH] ceph: use attach/detach_page_private for tracking snap context
Date:   Tue, 23 Mar 2021 16:38:47 -0400
Message-Id: <20210323203847.218500-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is some ambiguity around the use of PagePrivate. It's
generally expected in core code that if PagePrivate is set then
you have a reference to it. It's not clear that ceph always
does (and I believe it may not).

Change ceph to use attach/detach_page_private so that we keep a
reference to the page until the snap context is detached.

Lore: https://lore.kernel.org/ceph-devel/2503810.1616508988@warthog.procyon.org.uk/T/#u
Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b476133353ae..db1f5667fc42 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -128,8 +128,7 @@ static int ceph_set_page_dirty(struct page *page)
 	 * PagePrivate so that we get invalidatepage callback.
 	 */
 	BUG_ON(PagePrivate(page));
-	page->private = (unsigned long)snapc;
-	SetPagePrivate(page);
+	attach_page_private(page, snapc);
 
 	ret = __set_page_dirty_nobuffers(page);
 	WARN_ON(!PageLocked(page));
@@ -148,7 +147,7 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 {
 	struct inode *inode;
 	struct ceph_inode_info *ci;
-	struct ceph_snap_context *snapc = page_snap_context(page);
+	struct ceph_snap_context *snapc;
 
 	wait_on_page_fscache(page);
 
@@ -168,10 +167,9 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	dout("%p invalidatepage %p idx %lu full dirty page\n",
 	     inode, page, page->index);
 
+	snapc = detach_page_private(page);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);
-	page->private = 0;
-	ClearPagePrivate(page);
 }
 
 static int ceph_releasepage(struct page *page, gfp_t gfp)
@@ -588,8 +586,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		dout("writepage cleaned page %p\n", page);
 		err = 0;  /* vfs expects us to return 0 */
 	}
-	page->private = 0;
-	ClearPagePrivate(page);
+	oldest = detach_page_private(page);
+	WARN_ON_ONCE(oldest != snapc);
 	end_page_writeback(page);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
@@ -681,11 +679,9 @@ static void writepages_finish(struct ceph_osd_request *req)
 				clear_bdi_congested(inode_to_bdi(inode),
 						    BLK_RW_ASYNC);
 
-			ceph_put_snap_context(page_snap_context(page));
-			page->private = 0;
-			ClearPagePrivate(page);
-			dout("unlocking %p\n", page);
+			ceph_put_snap_context(detach_page_private(page));
 			end_page_writeback(page);
+			dout("unlocking %p\n", page);
 
 			if (remove_page)
 				generic_error_remove_page(inode->i_mapping,
-- 
2.30.2

