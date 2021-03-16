Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483DC33DDCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhCPToW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbhCPTnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:43:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C20C061765
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso1906527pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owmtLV8wh1hJqE8D0ZR3EUDep5BlONms2GPoyhoh5g8=;
        b=U4mU9dfBNpeV+lkhEPZIPlIAN0MWd0gxIesUzzo28Sa6B/tOPGXgwBS4aAvz8XJqxh
         J0xhEUDmNyr0/PgV0GFL+l0BEGR47TXQAiqUi14YTIqxRxoEvcFMket3P5OHXFA9k0rr
         65nnF2PXOmkZn05YN1MF+HhcPjcdsRrtd3TRx8R1JCNS0DPFAT3ogKtZi9VZNKcLsHZ8
         hRe8ZpMs/PQV6+16txI6yB1Xi09p1GyXna8ljZ4y9xSXKyTRUDKU6t1boe9C0EYsIG58
         KhiZuL+8H6zzqHKluxg7KHPg68hp15m5xgM5rgSJ8U5L3r3XNnn27Kzvh/yW3hmGJmIh
         1ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owmtLV8wh1hJqE8D0ZR3EUDep5BlONms2GPoyhoh5g8=;
        b=cY8GliYuGISQbQ4hIxgUctWlLN0ZgVQxTkHPqbI6jMKue+BZZy1+9v14Agc27XOh4P
         9GLIlMPgnmzsL8g+PCmIChRADoefbHv0uU4FUmrGKyIn9DNuSLP3VNxbBsqC4PGCBC7a
         rQOM/OdXEJPwegKaRm3Rsn3PcVyfsz9S0tcf2NKEl7vvbmWENWRoPhYe9kboXCKQr6GN
         sBeoLn6NCSXIX46yv6Yrn8zlpFsDtZvKTTSDZrgtahyXZbXv44AqpZmtuZ6ZRNsKf13L
         sf1ETd+3gGc9QEUESRA1JRFYHjjunzMAAfSaRVEZ5FIL5ywYpCEedV13wtwI+f9BngOr
         PVdA==
X-Gm-Message-State: AOAM531QGg7P1VWSK9jIelqfsHKNNTxQkOsGCotNpbRKYRL14J/mJ5yf
        qaNBJtSb32xPoT7PCyj7SXvvftcKRzTnwQ==
X-Google-Smtp-Source: ABdhPJxmfO0ws/aN+afVcFgqHK1gXTT2RF/Vrxaf6lJHFdPJjbLVXOref77IBRFIQjefxmjdGGvcDg==
X-Received: by 2002:a17:902:dac9:b029:e4:b52f:1d38 with SMTP id q9-20020a170902dac9b02900e4b52f1d38mr1066640plx.15.1615923819408;
        Tue, 16 Mar 2021 12:43:39 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id gm10sm217264pjb.4.2021.03.16.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:43:38 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v8 04/10] btrfs: fix check_data_csum() error message for direct I/O
Date:   Tue, 16 Mar 2021 12:43:00 -0700
Message-Id: <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1615922644.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922644.git.osandov@fb.com>
References: <cover.1615922644.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
check_data_csum()") replaced the start parameter to check_data_csum()
with page_offset(), but page_offset() is not meaningful for direct I/O
pages. Bring back the start parameter.

Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_data_csum")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef6cb7b620d0..d2ece8554416 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2947,11 +2947,13 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @page:	page where is the data to be verified
  * @pgoff:	offset inside the page
+ * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   u32 bio_offset, struct page *page, u32 pgoff)
+			   u32 bio_offset, struct page *page, u32 pgoff,
+			   u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
@@ -2978,8 +2980,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), page_offset(page) + pgoff,
-				    csum, csum_expected, io_bio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
+				    io_bio->mirror_num);
 	if (io_bio->device)
 		btrfs_dev_stat_inc_and_print(io_bio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
@@ -3032,7 +3034,8 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	     pg_off += sectorsize, bio_offset += sectorsize) {
 		int ret;
 
-		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off);
+		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
+				      page_offset(page) + pg_off);
 		if (ret < 0)
 			return -EIO;
 	}
@@ -7742,7 +7745,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
 			    (!csum || !check_data_csum(inode, io_bio,
-					bio_offset, bvec.bv_page, pgoff))) {
+						       bio_offset, bvec.bv_page,
+						       pgoff, start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
 						 start, bvec.bv_page,
 						 btrfs_ino(BTRFS_I(inode)),
-- 
2.30.2

