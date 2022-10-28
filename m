Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2366118AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJ1RDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiJ1RD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:03:29 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDAE23081F;
        Fri, 28 Oct 2022 10:01:50 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 89070218D;
        Fri, 28 Oct 2022 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976349;
        bh=XLfhoLoajHMwxGkqzmutjSB0VcGNCexWxhovGxocDdI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=EW2if9qksfM9ykb5vJ5T+0epiSG1fwqImLSQsTlJXDYcjNtWFffwQuMOhGlyFwRV8
         VyTKUkkN4oTsHM//ZvfVw2hmDlygOYMwAJUFN7E4DLDOQSSqhrx3TGENdqSlXxyMJy
         98HF+7e+WzRPqSSKloFrys6uA4apCN55EYB98MAM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 840D71D2B;
        Fri, 28 Oct 2022 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976508;
        bh=XLfhoLoajHMwxGkqzmutjSB0VcGNCexWxhovGxocDdI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=mMpJm5c+GkKRzjGX0HSF3iwKVFVVaYBhnyggovRXyg/bn0Q1waIULI89IHvQKUZfy
         c9dux2uNyDKICPgAHOZoz7hV3QHScHHxPG5wNixtPzXr7ThG5Gaf2e8qH6OKH0H46h
         QdPYy//F6Ip7e8rnGz801aOnM9hgNHAPKDdr/m9o=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:01:48 +0300
Message-ID: <f34ec7a5-0b16-6de0-509c-34c17e780db1@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:01:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 01/14] fs/ntfs3: Fixing work with sparse clusters
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify logic in ntfs_extend_initialized_size, ntfs_sparse_cluster
and ntfs_fallocate.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c  | 45 ++++++++++++---------------------------------
  fs/ntfs3/inode.c |  7 ++++++-
  2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4f2ffc7ef296..96ba3f5a8470 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -128,25 +128,9 @@ static int ntfs_extend_initialized_size(struct file *file,
  				goto out;
  
  			if (lcn == SPARSE_LCN) {
-				loff_t vbo = (loff_t)vcn << bits;
-				loff_t to = vbo + ((loff_t)clen << bits);
-
-				if (to <= new_valid) {
-					ni->i_valid = to;
-					pos = to;
-					goto next;
-				}
-
-				if (vbo < pos) {
-					pos = vbo;
-				} else {
-					to = (new_valid >> bits) << bits;
-					if (pos < to) {
-						ni->i_valid = to;
-						pos = to;
-						goto next;
-					}
-				}
+				pos = ((loff_t)clen + vcn) << bits;
+				ni->i_valid = pos;
+				goto next;
  			}
  		}
  
@@ -279,8 +263,9 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
  {
  	struct address_space *mapping = inode->i_mapping;
  	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
-	u64 vbo = (u64)vcn << sbi->cluster_bits;
-	u64 bytes = (u64)len << sbi->cluster_bits;
+	u8 cluster_bits = sbi->cluster_bits;
+	u64 vbo = (u64)vcn << cluster_bits;
+	u64 bytes = (u64)len << cluster_bits;
  	u32 blocksize = 1 << inode->i_blkbits;
  	pgoff_t idx0 = page0 ? page0->index : -1;
  	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
@@ -329,11 +314,10 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
  
  		zero_user_segment(page, from, to);
  
-		if (!partial) {
-			if (!PageUptodate(page))
-				SetPageUptodate(page);
-			set_page_dirty(page);
-		}
+		if (!partial)
+			SetPageUptodate(page);
+		flush_dcache_page(page);
+		set_page_dirty(page);
  
  		if (idx != idx0) {
  			unlock_page(page);
@@ -341,7 +325,6 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
  		}
  		cond_resched();
  	}
-	mark_inode_dirty(inode);
  }
  
  /*
@@ -588,11 +571,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  		u32 frame_size;
  		loff_t mask, vbo_a, end_a, tmp;
  
-		err = filemap_write_and_wait_range(mapping, vbo, end - 1);
-		if (err)
-			goto out;
-
-		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, vbo, LLONG_MAX);
  		if (err)
  			goto out;
  
@@ -693,7 +672,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  			goto out;
  
  		if (is_supported_holes) {
-			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
+			CLST vcn_v = bytes_to_cluster(sbi, ni->i_valid);
  			CLST vcn = vbo >> sbi->cluster_bits;
  			CLST cend = bytes_to_cluster(sbi, end);
  			CLST lcn, clen;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e9cf00d14733..f487d36c9b78 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -645,7 +645,12 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
  			bh->b_size = block_size;
  			off = vbo & (PAGE_SIZE - 1);
  			set_bh_page(bh, page, off);
-			ll_rw_block(REQ_OP_READ, 1, &bh);
+
+			lock_buffer(bh);
+			bh->b_end_io = end_buffer_read_sync;
+			get_bh(bh);
+			submit_bh(REQ_OP_READ, bh);
+
  			wait_on_buffer(bh);
  			if (!buffer_uptodate(bh)) {
  				err = -EIO;
-- 
2.37.0


