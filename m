Return-Path: <linux-fsdevel+bounces-4640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54A80169C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9BAB211B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5433F8E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WUnV6Pku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB710EF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:21 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cfa3a1fb58so29164647b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468741; x=1702073541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzinTCkDfALoxVW/93SBKBIC+NFbTZc80WmEA1KnS5U=;
        b=WUnV6PkuCDym8X1mVrgDN/JsQ4eQ3oJDQE9h7LPJFoPja1CHIcOMX0hssakH2PvnQk
         C6rEx51hh9TPwDSYcDUaluUu058Sg5fdNWFXOFj8kGrFw5dwfxQoUybBHWIzzGflxU7l
         YEdpK/fPMJmu/Gg1dFIAxSXuGMUZ2LBwPco1xpdn7aPWM3dYDZTGrgMroWWJGknJwBpr
         jnzpNybm3M2pDAj3iEmqhyL3+/L4SBBvwGcmV8wa1FGDAoIqu/RZP3dcEs4Z56QRBu06
         fG3suXMzAwnBzqpWO74uCntKY4OYf+X5y6u3LJi7+ZkV0Q213VhiqNDeF8PZhJj4uPBW
         vpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468741; x=1702073541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzinTCkDfALoxVW/93SBKBIC+NFbTZc80WmEA1KnS5U=;
        b=GELda1eoo5MA49hmkVOgw01ry4WZGc1kyK3o2Bxvs7Wcxk2BWyCm1Zv2WtzN60h2br
         WSgvDRDHI4+yUwSrpd2E6XDZFNaWBMgHieh2mBHZEV59vAOLpUVazTv37ocCGELpvdW9
         Au6CebhoJD4x69FFF85P90m5aP69vtajw4iIPUwDX0WIU+PTX1KUNOiIwzLkgVkcoRYI
         wnMvBBgNNmpUTJ5ytUy/Xh3URxLxjbAvmOXv0/UzcAQ57k7dLVGkEzISIe8etJgHMToR
         dVltdxapWFwue2+N93QqQQEDhL9I1atSYenp9DUKyQ+FnMeeI8fjrsY9NSZWugjMVAmt
         2hRA==
X-Gm-Message-State: AOJu0Yw2qr0t6e6U96Ye1RFNaTmjNb5CCJ4Y/fVlRmkya1wQviOyLghZ
	W3Y9tKhDowrVi0MTKbxkZcUwYg==
X-Google-Smtp-Source: AGHT+IH8/SL3ehe18tXNjC/LUcLv0rpp8LnrsfN3yJxi/vBfvyeg3PxZcURMLxz/UEEyuMChRPHn6A==
X-Received: by 2002:a05:690c:30a:b0:5ce:1046:c85e with SMTP id bg10-20020a05690c030a00b005ce1046c85emr400921ywb.28.1701468741014;
        Fri, 01 Dec 2023 14:12:21 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n14-20020a819e4e000000b0059b2be24f88sm1344917ywj.143.2023.12.01.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 20/46] btrfs: set file extent encryption excplicitly
Date: Fri,  1 Dec 2023 17:11:17 -0500
Message-ID: <7337bfb86c3546ffedb706df0e785e2a346aa374.1701468306.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

This puts the long-preserved 1-byte encryption field to work, storing
whether the extent is encrypted.  Update the tree-checker to allow for
the encryption bit to be set to our valid types.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h            | 2 ++
 fs/btrfs/inode.c                | 8 ++++++--
 fs/btrfs/tree-checker.c         | 8 +++++---
 fs/btrfs/tree-log.c             | 2 ++
 include/uapi/linux/btrfs_tree.h | 8 +++++++-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index aa0844535644..5aaf204fa55f 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -949,6 +949,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 			 struct btrfs_file_extent_item, disk_num_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
 			 struct btrfs_file_extent_item, compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_encryption,
+			 struct btrfs_file_extent_item, encryption, 8);
 
 
 BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 60d1e93c2567..f894f5b5e786 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3001,7 +3001,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	/*
 	 * For delalloc, when completing an ordered extent we update the inode's
@@ -9671,7 +9673,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	qgroup_released = btrfs_qgroup_release_data(inode, file_offset, len);
 	if (qgroup_released < 0)
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 50fdc69fdddf..1af2c967436b 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -211,6 +211,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 policy;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -262,10 +263,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+	policy = btrfs_file_extent_encryption(leaf, fi);
+	if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
 		file_extent_err(leaf, slot,
-			"invalid encryption for file extent, have %u expect 0",
-			btrfs_file_extent_encryption(leaf, fi));
+			"invalid encryption for file extent, have %u expect range [0, %u]",
+			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
 		return -EUCLEAN;
 	}
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 89d3dc769b15..36063dc39443 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4627,6 +4627,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	u8 encryption = BTRFS_ENCRYPTION_NONE;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
@@ -4648,6 +4649,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
 	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
 	btrfs_set_stack_file_extent_compression(&fi, em->compress_type);
+	btrfs_set_stack_file_extent_encryption(&fi, encryption);
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 08f561da33cd..af56a5eb3a00 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1101,8 +1101,14 @@ struct btrfs_file_extent_item {
 	 * but not for stat.
 	 */
 	__u8 compression;
+
+	/*
+	 * Type of encryption in use. Unencrypted value is 0.
+	 */
 	__u8 encryption;
-	__le16 other_encoding; /* spare for later use */
+
+	/* spare for later use */
+	__le16 other_encoding;
 
 	/* are we inline data or a real extent? */
 	__u8 type;
-- 
2.41.0


