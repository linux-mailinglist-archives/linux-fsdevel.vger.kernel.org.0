Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BE553148
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349091AbiFULqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 07:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFULqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:46:00 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D12A40D;
        Tue, 21 Jun 2022 04:45:59 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 08A901D4B;
        Tue, 21 Jun 2022 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1655811909;
        bh=RXUlCLC0RWJq8YLAPCBfAJBKfeRdqiLy5wUHx9yv11k=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Yiegb2w+TBKoW1FBrs4NLYltTdPZDLhNyBZFUZ8icMMpWYqnsaJBN68VZQAYCmmOx
         UcW0bk59jeoTB8QZpLdOoE0pgM9inOva99gBZQUa898G/suBPbBAq7Zd3g0A5qXaUV
         XuYVMGGkUB/+73OXYgQxMrOiek8dkRu2yin/TTec=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Jun 2022 14:45:57 +0300
Message-ID: <4fc73e0d-3987-1c2c-5ec7-6b3a94d18f63@paragon-software.com>
Date:   Tue, 21 Jun 2022 14:45:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 2/2] fs/ntfs3: Enable FALLOC_FL_INSERT_RANGE
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <ab1c8348-acde-114f-eb66-0074045731a4@paragon-software.com>
In-Reply-To: <ab1c8348-acde-114f-eb66-0074045731a4@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changed logic in ntfs_fallocate - more clear checks in beginning
instead of the middle of function and added FALLOC_FL_INSERT_RANGE.
Fixes xfstest generic/064
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c | 97 ++++++++++++++++++++++++++++---------------------
  1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 27c32692513c..bdffe4b8554b 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -533,21 +533,35 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
  static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  {
  	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = inode->i_mapping;
  	struct super_block *sb = inode->i_sb;
  	struct ntfs_sb_info *sbi = sb->s_fs_info;
  	struct ntfs_inode *ni = ntfs_i(inode);
  	loff_t end = vbo + len;
  	loff_t vbo_down = round_down(vbo, PAGE_SIZE);
-	loff_t i_size;
+	bool is_supported_holes = is_sparsed(ni) || is_compressed(ni);
+	loff_t i_size, new_size;
+	bool map_locked;
  	int err;
  
  	/* No support for dir. */
  	if (!S_ISREG(inode->i_mode))
  		return -EOPNOTSUPP;
  
-	/* Return error if mode is not supported. */
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-		     FALLOC_FL_COLLAPSE_RANGE)) {
+	/*
+	 * vfs_fallocate checks all possible combinations of mode.
+	 * Do additional checks here before ntfs_set_state(dirty).
+	 */
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if (!is_supported_holes)
+			return -EOPNOTSUPP;
+	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+	} else if (mode & FALLOC_FL_INSERT_RANGE) {
+		if (!is_supported_holes)
+			return -EOPNOTSUPP;
+	} else if (mode &
+		   ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) {
  		ntfs_inode_warn(inode, "fallocate(0x%x) is not supported",
  				mode);
  		return -EOPNOTSUPP;
@@ -557,6 +571,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  
  	inode_lock(inode);
  	i_size = inode->i_size;
+	new_size = max(end, i_size);
+	map_locked = false;
  
  	if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
  		/* Should never be here, see ntfs_file_open. */
@@ -564,38 +580,27 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  		goto out;
  	}
  
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		    FALLOC_FL_INSERT_RANGE)) {
+		inode_dio_wait(inode);
+		filemap_invalidate_lock(mapping);
+		map_locked = true;
+	}
+
  	if (mode & FALLOC_FL_PUNCH_HOLE) {
  		u32 frame_size;
  		loff_t mask, vbo_a, end_a, tmp;
  
-		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-			err = -EINVAL;
-			goto out;
-		}
-
-		err = filemap_write_and_wait_range(inode->i_mapping, vbo,
-						   end - 1);
+		err = filemap_write_and_wait_range(mapping, vbo, end - 1);
  		if (err)
  			goto out;
  
-		err = filemap_write_and_wait_range(inode->i_mapping, end,
-						   LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
  		if (err)
  			goto out;
  
-		inode_dio_wait(inode);
-
  		truncate_pagecache(inode, vbo_down);
  
-		if (!is_sparsed(ni) && !is_compressed(ni)) {
-			/*
-			 * Normal file, can't make hole.
-			 * TODO: Try to find way to save info about hole.
-			 */
-			err = -EOPNOTSUPP;
-			goto out;
-		}
-
  		ni_lock(ni);
  		err = attr_punch_hole(ni, vbo, len, &frame_size);
  		ni_unlock(ni);
@@ -627,17 +632,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  			ni_unlock(ni);
  		}
  	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
-		if (mode & ~FALLOC_FL_COLLAPSE_RANGE) {
-			err = -EINVAL;
-			goto out;
-		}
-
  		/*
  		 * Write tail of the last page before removed range since
  		 * it will get removed from the page cache below.
  		 */
-		err = filemap_write_and_wait_range(inode->i_mapping, vbo_down,
-						   vbo);
+		err = filemap_write_and_wait_range(mapping, vbo_down, vbo);
  		if (err)
  			goto out;
  
@@ -645,34 +644,45 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  		 * Write data that will be shifted to preserve them
  		 * when discarding page cache below.
  		 */
-		err = filemap_write_and_wait_range(inode->i_mapping, end,
-						   LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
  		if (err)
  			goto out;
  
-		/* Wait for existing dio to complete. */
-		inode_dio_wait(inode);
-
  		truncate_pagecache(inode, vbo_down);
  
  		ni_lock(ni);
  		err = attr_collapse_range(ni, vbo, len);
  		ni_unlock(ni);
-	} else {
-		/*
-		 * Normal file: Allocate clusters, do not change 'valid' size.
-		 */
-		loff_t new_size = max(end, i_size);
+	} else if (mode & FALLOC_FL_INSERT_RANGE) {
+		/* Check new size. */
+		err = inode_newsize_ok(inode, new_size);
+		if (err)
+			goto out;
+
+		/* Write out all dirty pages. */
+		err = filemap_write_and_wait_range(mapping, vbo_down,
+						   LLONG_MAX);
+		if (err)
+			goto out;
+		truncate_pagecache(inode, vbo_down);
  
+		ni_lock(ni);
+		err = attr_insert_range(ni, vbo, len);
+		ni_unlock(ni);
+	} else {
+		/* Check new size. */
  		err = inode_newsize_ok(inode, new_size);
  		if (err)
  			goto out;
  
+		/*
+		 * Allocate clusters, do not change 'valid' size.
+		 */
  		err = ntfs_set_size(inode, new_size);
  		if (err)
  			goto out;
  
-		if (is_sparsed(ni) || is_compressed(ni)) {
+		if (is_supported_holes) {
  			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
  			CLST vcn = vbo >> sbi->cluster_bits;
  			CLST cend = bytes_to_cluster(sbi, end);
@@ -720,6 +730,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  	}
  
  out:
+	if (map_locked)
+		filemap_invalidate_unlock(mapping);
+
  	if (err == -EFBIG)
  		err = -ENOSPC;
  
-- 
2.36.1


