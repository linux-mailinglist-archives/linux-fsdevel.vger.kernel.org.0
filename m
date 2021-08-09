Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81A63E4011
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhHIGdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhHIGdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:33:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA7C0613CF;
        Sun,  8 Aug 2021 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nYO7cnuv0Th0s4KtBKiBkzxE8Vhba6ah/Rs5J4rme2A=; b=RzpCdfIFzm0U4yAgygK7bC7afc
        oETa9AreGInO4ce6I5WmI5i54DRoPe9l7I85N04BgbQCeZu+0rM1uBBokotGnbKbMPlREIoXKjqBc
        40Ksc+8rp/CTxbO43VlbU2z4tx85/U2Rgiy+3UTVggDy/cU0FamTxjaNEB96u0lwd6jd0wZBTA0MX
        hnJ1zrrAGQz404FBrwgUoVnxFPdWmqC2psYK7vs0utDqvoQZw4hcdZICGj189ifQlBgmLqHHkNw9K
        /xh6NICxdpAgUhulYZN01m/iMlnCRU/c4lycKyneWUJS1rE5KosNfyZMkQUciEmVnc2kXetrsMlcG
        hUg7JvjA==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyo8-00Ahix-Ga; Mon, 09 Aug 2021 06:30:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 22/30] iomap: switch iomap_swapfile_activate to use iomap_iter
Date:   Mon,  9 Aug 2021 08:12:36 +0200
Message-Id: <20210809061244.1196573-23-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch iomap_swapfile_activate to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/swapfile.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 6250ca6a1f851d..7069606eca85b2 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -88,13 +88,9 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
  * swap only cares about contiguous page-aligned physical extents and makes no
  * distinction between written and unwritten extents.
  */
-static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
-		loff_t count, void *data, struct iomap *iomap,
-		struct iomap *srcmap)
+static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap_swapfile_info *isi)
 {
-	struct iomap_swapfile_info *isi = data;
-	int error;
-
 	switch (iomap->type) {
 	case IOMAP_MAPPED:
 	case IOMAP_UNWRITTEN:
@@ -125,12 +121,12 @@ static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
 		isi->iomap.length += iomap->length;
 	} else {
 		/* Otherwise, add the retained iomap and store this one. */
-		error = iomap_swapfile_add_extent(isi);
+		int error = iomap_swapfile_add_extent(isi);
 		if (error)
 			return error;
 		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
 	}
-	return count;
+	return iomap_length(iter);
 }
 
 /*
@@ -141,16 +137,19 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 		struct file *swap_file, sector_t *pagespan,
 		const struct iomap_ops *ops)
 {
+	struct inode *inode = swap_file->f_mapping->host;
+	struct iomap_iter iter = {
+		.inode	= inode,
+		.pos	= 0,
+		.len	= ALIGN_DOWN(i_size_read(inode), PAGE_SIZE),
+		.flags	= IOMAP_REPORT,
+	};
 	struct iomap_swapfile_info isi = {
 		.sis = sis,
 		.lowest_ppage = (sector_t)-1ULL,
 		.file = swap_file,
 	};
-	struct address_space *mapping = swap_file->f_mapping;
-	struct inode *inode = mapping->host;
-	loff_t pos = 0;
-	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
-	loff_t ret;
+	int ret;
 
 	/*
 	 * Persist all file mapping metadata so that we won't have any
@@ -160,15 +159,10 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 	if (ret)
 		return ret;
 
-	while (len > 0) {
-		ret = iomap_apply(inode, pos, len, IOMAP_REPORT,
-				ops, &isi, iomap_swapfile_activate_actor);
-		if (ret <= 0)
-			return ret;
-
-		pos += ret;
-		len -= ret;
-	}
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
+	if (ret < 0)
+		return ret;
 
 	if (isi.iomap.length) {
 		ret = iomap_swapfile_add_extent(&isi);
-- 
2.30.2

