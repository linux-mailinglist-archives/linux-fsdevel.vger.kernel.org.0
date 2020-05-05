Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC31C5BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgEEPni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgEEPnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F39C061A0F;
        Tue,  5 May 2020 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aIZUeshjJd8X6ZX6CaGTS0NOz/KCmm9NjJZIVpjb4io=; b=nqvEUzmMtp9LD8GMQhnNjJfZlT
        tyTGCRH/fDAheuIAapXr7VUgUFMK+s81XbxGQcOVNzTBBIugaqWUK6csL8m1iDmNBG9IQitdYsHEh
        3olo8yXL1RsdUEZ3v/73Q+dhpvvfCCk8GbcWSDrx0RxM+Wxg4QcjkDnZhVgnrvdjTako2O0pgVBKz
        bHcvtN2x8iCEra8qFIRD9Z+joE8JZ8+8hrkKBIKBjG7su5NMovDohrbS6s17QEeKjBYe8RT777sVP
        qUbeDqRpcwjkE6urPyoR97A0nHNMpvduzY0DIkyH/KXp2wlUvn2pizSlhbAUJQbuQ6/nHu1AkSimV
        esx/pf+g==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjM-0003zH-U7; Tue, 05 May 2020 15:43:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 03/11] ext4: split _ext4_fiemap
Date:   Tue,  5 May 2020 17:43:16 +0200
Message-Id: <20200505154324.3226743-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fiemap and EXT4_IOC_GET_ES_CACHE cases share almost no code, so split
them into entirely separate functions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2b4b94542e34d..d2a2a3ba5c44a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4854,11 +4854,9 @@ static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
 	return 0;
 }
 
-static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-			__u64 start, __u64 len, bool from_es_cache)
+int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 len)
 {
-	ext4_lblk_t start_blk;
-	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR;
 	int error = 0;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
@@ -4868,10 +4866,7 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
-	if (from_es_cache)
-		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
-
-	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
+	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
 		return -EBADR;
 
 	/*
@@ -4885,40 +4880,20 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
-		error = iomap_fiemap(inode, fieinfo, start, len,
-				     &ext4_iomap_xattr_ops);
-	} else if (!from_es_cache) {
-		error = iomap_fiemap(inode, fieinfo, start, len,
-				     &ext4_iomap_report_ops);
-	} else {
-		ext4_lblk_t len_blks;
-		__u64 last_blk;
-
-		start_blk = start >> inode->i_sb->s_blocksize_bits;
-		last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
-		if (last_blk >= EXT_MAX_BLOCKS)
-			last_blk = EXT_MAX_BLOCKS-1;
-		len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
-
-		/*
-		 * Walk the extent tree gathering extent information
-		 * and pushing extents back to the user.
-		 */
-		error = ext4_fill_es_cache_info(inode, start_blk, len_blks,
-						fieinfo);
+		return iomap_fiemap(inode, fieinfo, start, len,
+				    &ext4_iomap_xattr_ops);
 	}
-	return error;
-}
 
-int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		__u64 start, __u64 len)
-{
-	return _ext4_fiemap(inode, fieinfo, start, len, false);
+	return iomap_fiemap(inode, fieinfo, start, len, &ext4_iomap_report_ops);
 }
 
 int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      __u64 start, __u64 len)
 {
+	ext4_lblk_t start_blk, len_blks;
+	__u64 last_blk;
+	int error = 0;
+
 	if (ext4_has_inline_data(inode)) {
 		int has_inline;
 
@@ -4929,9 +4904,32 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return 0;
 	}
 
-	return _ext4_fiemap(inode, fieinfo, start, len, true);
-}
+	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
+		error = ext4_ext_precache(inode);
+		if (error)
+			return error;
+		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
+	}
+
+	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC))
+		return -EBADR;
 
+	error = ext4_fiemap_check_ranges(inode, start, &len);
+	if (error)
+		return error;
+
+	start_blk = start >> inode->i_sb->s_blocksize_bits;
+	last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
+	if (last_blk >= EXT_MAX_BLOCKS)
+		last_blk = EXT_MAX_BLOCKS-1;
+	len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
+
+	/*
+	 * Walk the extent tree gathering extent information
+	 * and pushing extents back to the user.
+	 */
+	return ext4_fill_es_cache_info(inode, start_blk, len_blks, fieinfo);
+}
 
 /*
  * ext4_access_path:
-- 
2.26.2

