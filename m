Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BEE3CD34F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhGSKT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSKTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:19:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDDC061574;
        Mon, 19 Jul 2021 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nYO7cnuv0Th0s4KtBKiBkzxE8Vhba6ah/Rs5J4rme2A=; b=bbsCa/JcSFcTo3GXncZIBTVlJM
        eYlBY32FXiorkPQW99sKgykI7spb7CufJ/UaokhfLIvl8+bprGz1W51WrXF3m7sV3JK7l9hKgs5zL
        dhnwX1r0tMR3dwjPhwKhRcMwn4qSJstXlZqEhHOjj8c4AmKFlTz8DaFmKenXuJ7lCNZqr3jkMT+BL
        MTwWVEY8yefUOUBD1jQpRBL4Qww1y0nYBoB6ThIM15JU69ST1UJl9kgJkAKLIKa6E4TDI9jtpJjhZ
        G3G/AfHHeZ3Wmd1/pVuM8/OjOzimSjjwWBqLgRwsO+CpNulyQGjyletlGaAGgazrN2gbf2OcJXcsk
        4HOKKALQ==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Qxi-006m4i-Fb; Mon, 19 Jul 2021 10:57:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 19/27] iomap: switch iomap_swapfile_activate to use iomap_iter
Date:   Mon, 19 Jul 2021 12:35:12 +0200
Message-Id: <20210719103520.495450-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
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

