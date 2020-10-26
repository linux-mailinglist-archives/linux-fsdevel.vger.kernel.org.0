Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1ED299528
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784283AbgJZSU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1784025AbgJZSUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603736424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ptTkFFr2gcLe9Snuv32mfp/MeRnopkFApzasgpnIT9A=;
        b=KkZJM+TwIpXHAKFj4U0vl/zGmaYsglL+2fmBJ8XEY4iQ60NYss+bEz8/CV4Fpf4IJ+TtNa
        nxhFf6PoH6Nwhl96BlvZ7mS6ZV675nFcTizRAajXlncznpRdgS24+/Q3lrDiQ8rTP8L0RA
        vYzTkR1geoftvHsv+pmwP8M1iysEzZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Ooe0c2evOYSlV1DriIfhKA-1; Mon, 26 Oct 2020 14:20:21 -0400
X-MC-Unique: Ooe0c2evOYSlV1DriIfhKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEBBD1005513;
        Mon, 26 Oct 2020 18:20:20 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7442F5D9F3;
        Mon, 26 Oct 2020 18:20:20 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: support partial page discard on writeback block mapping failure
Date:   Mon, 26 Oct 2020 14:20:19 -0400
Message-Id: <20201026182019.1547662-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap writeback mapping failure only calls into ->discard_page() if
the current page has not been added to the ioend. Accordingly, the
XFS callback assumes a full page discard and invalidation. This is
problematic for sub-page block size filesystems where some portion
of a page might have been mapped successfully before a failure to
map a delalloc block occurs. ->discard_page() is not called in that
error scenario and the bio is explicitly failed by iomap via the
error return from ->prepare_ioend(). As a result, the filesystem
leaks delalloc blocks and corrupts the filesystem block counters.

Since XFS is the only user of ->discard_page(), tweak the semantics
to invoke the callback unconditionally on mapping errors and provide
the first offset in the page that failed to map. Update
xfs_discard_page() to discard the corresponding portion of the file
and pass the range along to iomap_invalidatepage(). The latter
already properly handles both full and sub-page scenarios by not
changing any iomap or page state on sub-page invalidations.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

One additional thing I'm trying to rectify that is slightly related to
this patch is how iomap handles the page in the partial writepage error
case. The comments suggest the page should be kept dirty, but
write_cache_pages() clears the dirty state for each page before calling
into ->writepage(). iomap_writepage_map() does call
clear_page_dirty_for_io() in the success path, which seems harmless but
superfluous. That aside, we don't seem to actually redirty the page in
the partial writepage case, so the set_page_writeback_keepwrite() call
seems insufficient. I.e., even if we did cycle back into
write_cache_pages() and find the TOWRITE page, we just skip it since the
page isn't actually dirty.

Unless I'm missing something, this all seems slightly broken to me. I
think we can drop the clear_page_dirty_for_io() call from iomap, and
instead we need to add a call to redirty_page_for_writepage() in the
_keepwrite() error case. Beyond that, I'm kind of wondering if there's a
reason for using _keepwrite() to revisit pages as such at all. AFAICT
write_cache_pages() doesn't cycle around until it's invoked again, at
which point it retags a new set of dirty pages and as above, we
presumably have to redirty the page for _keepwrite() to have any
practical effect anyways. Thoughts? Am I missing something here?

Brian

 fs/iomap/buffered-io.c | 16 +++++++++-------
 fs/xfs/xfs_aops.c      | 13 +++++++------
 include/linux/iomap.h  |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..a99964c4b93f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1412,14 +1412,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * appropriately.
 	 */
 	if (unlikely(error)) {
+		unsigned int	pageoff = offset_in_page(file_offset);
+		/*
+		 * Let the filesystem know what portion of the current page
+		 * failed to map. If the page wasn't been added to ioend, it
+		 * won't be affected by I/O completion and we must unlock it
+		 * now.
+		 */
+		if (wpc->ops->discard_page)
+			wpc->ops->discard_page(page, pageoff);
 		if (!count) {
-			/*
-			 * If the current page hasn't been added to ioend, it
-			 * won't be affected by I/O completions and we must
-			 * discard and unlock it right here.
-			 */
-			if (wpc->ops->discard_page)
-				wpc->ops->discard_page(page);
 			ClearPageUptodate(page);
 			unlock_page(page);
 			goto done;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..8a17b46a3978 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -527,13 +527,14 @@ xfs_prepare_ioend(
  */
 static void
 xfs_discard_page(
-	struct page		*page)
+	struct page		*page,
+	unsigned int		pageoff)
 {
 	struct inode		*inode = page->mapping->host;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	loff_t			offset = page_offset(page);
-	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
+	loff_t			fileoff = page_offset(page) + pageoff;
+	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
 	int			error;
 
 	if (XFS_FORCED_SHUTDOWN(mp))
@@ -541,14 +542,14 @@ xfs_discard_page(
 
 	xfs_alert_ratelimited(mp,
 		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
-			page, ip->i_ino, offset);
+			page, ip->i_ino, fileoff);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			PAGE_SIZE / i_blocksize(inode));
+			(PAGE_SIZE - pageoff) / i_blocksize(inode));
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	iomap_invalidatepage(page, 0, PAGE_SIZE);
+	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..646aaefe0dae 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -220,7 +220,7 @@ struct iomap_writeback_ops {
 	 * Optional, allows the file system to discard state on a page where
 	 * we failed to submit any I/O.
 	 */
-	void (*discard_page)(struct page *page);
+	void (*discard_page)(struct page *page, unsigned int pageoff);
 };
 
 struct iomap_writepage_ctx {
-- 
2.25.4

