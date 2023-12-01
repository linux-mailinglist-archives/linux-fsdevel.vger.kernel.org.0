Return-Path: <linux-fsdevel+bounces-4654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29438801662
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37261F21042
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3B3F8CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dawyIGX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7B10D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:42 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5cd81e76164so29420457b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468761; x=1702073561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4BaCdes/ph+FBDRPrYEBu7SdLjcMrWxDC5DvBg0S2c=;
        b=dawyIGX+/j59Fp3QrYmEvDcVaU+x2kXvhW57+7o2teFoRRIUe5UUg4PP1GMybleo8h
         bdTOZJ560HzLFn4sjfMrSTYQZojfoTzgRjcodOdyWIVaK/wApesL8uHs6Ed8LC3XNGfO
         TSnyNBzT38z7BhtFCG9S0+3B2l+oIl3EjO8XvCeDwCCIdBRar/j9akjTgEbsGLfZv7OE
         xlHBi/Ble4+ZQLacQc57d0hqUhw1x6Wz2x1wxWJsNGHPazp1ywwXOx0igi47gootvv2h
         QgkTOcOwjlYtpqbsOBgwLxhEq/N6JOAwBaIemaqnBw3Mil6Fd4ZHWPljw/Vh3RXR30LI
         mApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468761; x=1702073561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4BaCdes/ph+FBDRPrYEBu7SdLjcMrWxDC5DvBg0S2c=;
        b=lB0Xfj+G7Rd3bbFB3M6WqXtCgQcFg00kLqLt+5fxPP4wmh/9LbJ1+Fqc2psrJAELSN
         cMJhHNT+FC8OtX1HZjQRBzPOMkaluxj0Hw+tAz2vYrjQAwIF5Tx4OyrnOW3n2/kxsFAn
         ulN2Z2sHyOHaDvlJ9bp0RXGtUqseUMFTUVM/UZpYjBSocaqAu6c7ZGuHKl5ysM/8KeNg
         egTU3s/ZV4nlMfHFbtya86QE7o27T40u/WJnMUGvdkLJqU82z20TEx3llU+WINKafrca
         ekByEkVtzSNV0LBjCk+ZiM4lQTxLS8A3sM3XMbyxLTEFCkzrgermCAEZJZaAvmhsPLtS
         621A==
X-Gm-Message-State: AOJu0YwZTLqgvMc1MIeB9DT4CCiw3lG8SS2ztd0RTQZ+rv14KPUvaYH0
	1SoniTZZwMSNz/0oVIes8ALqCA==
X-Google-Smtp-Source: AGHT+IHv1vmVGzBHq4wlGFfWaZrQW10oFqCawez4SOwK+6gJ8tnHa9ANJDCH21YK3W74zvVznRBvSQ==
X-Received: by 2002:a05:690c:3607:b0:5d0:edf:9bc4 with SMTP id ft7-20020a05690c360700b005d00edf9bc4mr339063ywb.18.1701468761646;
        Fri, 01 Dec 2023 14:12:41 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y16-20020a81a110000000b005cf1ce8b96dsm1040981ywg.5.2023.12.01.14.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 35/46] btrfs: add a bio argument to btrfs_csum_one_bio
Date: Fri,  1 Dec 2023 17:11:32 -0500
Message-ID: <cfb734cef46d432d6dcf5a19e68e64310102a7cd.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only ever needed the bbio in btrfs_csum_one_bio, since that has the
bio embedded in it.  However with encryption we'll have a different bio
with the encrypted data in it, and the original bbio.  Update
btrfs_csum_one_bio to take the bio we're going to csum as an argument,
which will allow us to csum the encrypted bio and stuff the csums into
the corresponding bbio to be used later when the IO completes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/file-item.c | 3 +--
 fs/btrfs/file-item.h | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4f3b693a16b1..90e4d4709fa3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -533,7 +533,7 @@ static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
-	return btrfs_csum_one_bio(bbio);
+	return btrfs_csum_one_bio(bbio, &bbio->bio);
 }
 
 /*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 35036fab58c4..d925d6d98bf4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -730,13 +730,12 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 /*
  * Calculate checksums of the data contained inside a bio.
  */
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 {
 	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
 	char *data;
 	struct bvec_iter iter;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index bb79014024bd..e52d5d71d533 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -51,7 +51,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio);
 blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
-- 
2.41.0


