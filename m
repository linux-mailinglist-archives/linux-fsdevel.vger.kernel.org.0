Return-Path: <linux-fsdevel+bounces-4653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DA801661
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076DD1C209D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68136619A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2fwTnhvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF8610DB
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:40 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d3758fdd2eso23684417b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468759; x=1702073559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1p5Yi6ojA7mTkKHgcDln1Jm49x5iVqCKOwjX8lstC10=;
        b=2fwTnhvtnY/f+caeCr8GtL1s0VD0NWxGuNdtY8p5Hz5jx19KuJWYpfthiK371T2Ocm
         yxp9pBoQqoI2l151JgULKGeLmFe5rqZsXkrPIMbNE3w7hrL4Wsqd6hK4mCnMQi0xLLC+
         xjoy5s3Hk/GT7CY2NhKUorUg7BVrcEDcmQvuW75F1DmSrdG+qprGnpegk2MLiIHh7mu/
         aSq69NPufbuLMslqCZW8m8S1hZbOjmbDY5LgQsWpFHxUEgEFSWtfNZrkeRnARrbwpDXb
         SdgTyWM80ZzXc9GWGKvYS2saQg1WPLMvjV0p8jE76QnySojf7N2IKfxj6HmlJz3BemP4
         P4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468759; x=1702073559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p5Yi6ojA7mTkKHgcDln1Jm49x5iVqCKOwjX8lstC10=;
        b=driVhuIAv3s8BwoqlPW8sU4pCwcEnOjeqjI46VBeZAin2CbPHZAayaUot2FyGkuKZL
         wvfYhCvTZ+ZuXYgsYnZk6i2AJqTCzMIPcByI6vjrwTAfhlAuKfkVxytABS+grLtnsjbd
         28wjanZ+wWaAU7ghTlKMAiFH8rSCASLvB3NU0zhwsTz/Pb+oj8eOchrC5bLSYJnQ5hTm
         k0fDGw40pZjboXHKdTR5N97Y84ihCvSa9QHWTA3hLJFC2dZltoqsR7hg8hZKQnylfv5H
         h6ifFHV0z/3mQaoOyDOofV4DkpLYxTBuDd4Vdc/bXiganQ9CLNWYbaHBKd4WmWphS1wG
         +QPQ==
X-Gm-Message-State: AOJu0YyQIOJYLGfeYFJtvjF28rZZwcqQQHgQFYzQB0YjdzCtyznJZmLz
	KIKfIINXeMxJU4qTg/x1xPVs0g==
X-Google-Smtp-Source: AGHT+IF5QEaC3YRRAZNc7SjvT/tYGEj/RGHPe0RSXTibDhPYDPgkQ8ZhID16UR2qozaergXP7NZG9A==
X-Received: by 2002:a81:af68:0:b0:5d3:4b91:4ba5 with SMTP id x40-20020a81af68000000b005d34b914ba5mr313212ywj.33.1701468759621;
        Fri, 01 Dec 2023 14:12:39 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c68-20020a0dc147000000b005d6f34893dfsm247620ywd.135.2023.12.01.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:39 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 33/46] btrfs: populate ordered_extent with the orig offset
Date: Fri,  1 Dec 2023 17:11:30 -0500
Message-ID: <ebcfaf8e601046157761fb136cf27ab9dd223c2b.1701468306.git.josef@toxicpanda.com>
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

For extent encryption we have to use a logical block nr as input for the
IV.  For btrfs we're using the offset into the extent we're operating
on.  For most ordered extents this is the same as the file_offset,
however for prealloc and NOCOW we have to use the original offset.

Add this as an argument and plumb it through everywhere, this will be
used when setting up the bio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c        | 15 ++++++++++-----
 fs/btrfs/ordered-data.c | 32 ++++++++++++++++++++++----------
 fs/btrfs/ordered-data.h | 12 +++++++++---
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 60d016da1fce..3dce53601915 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1175,6 +1175,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 				       start,			/* file_offset */
+				       start,			/* orig_start */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1438,8 +1439,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
-					start, ram_size, ram_size, ins.objectid,
-					cur_alloc_size, 0,
+					start, start, ram_size, ram_size,
+					ins.objectid, cur_alloc_size, 0,
 					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
 		free_extent_map(em);
@@ -2193,7 +2194,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info,
-				cur_offset, nocow_args.num_bytes,
+				cur_offset,
+				found_key.offset - nocow_args.extent_offset,
+				nocow_args.num_bytes,
 				nocow_args.num_bytes, nocow_args.disk_bytenr,
 				nocow_args.num_bytes, 0,
 				is_prealloc
@@ -7113,8 +7116,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		fscrypt_info = em->fscrypt_info;
 	}
 
-	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start, len,
-					     len, block_start, block_len, 0,
+	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start,
+					     orig_start, len, len, block_start,
+					     block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -10655,6 +10659,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info, start,
+				       start - encoded->unencoded_offset,
 				       num_bytes, ram_bytes, ins.objectid,
 				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ee3138a6d11e..a9c9d9cc6ee3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -148,9 +148,9 @@ static inline struct rb_node *ordered_tree_search(struct btrfs_inode *inode,
 static struct btrfs_ordered_extent *alloc_ordered_extent(
 			struct btrfs_inode *inode,
 			struct fscrypt_extent_info *fscrypt_info,
-			u64 file_offset, u64 num_bytes, u64 ram_bytes,
-			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
-			unsigned long flags, int compress_type)
+			u64 file_offset, u64 orig_offset, u64 num_bytes,
+			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+			u64 offset, unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 	int ret;
@@ -175,6 +175,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 		return ERR_PTR(-ENOMEM);
 
 	entry->file_offset = file_offset;
+	entry->orig_offset = orig_offset;
 	entry->num_bytes = num_bytes;
 	entry->ram_bytes = ram_bytes;
 	entry->disk_bytenr = disk_bytenr;
@@ -253,6 +254,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * @inode:           Inode that this extent is for.
  * @fscrypt_info:    The fscrypt_extent_info for this extent, if necessary.
  * @file_offset:     Logical offset in file where the extent starts.
+ * @orig_offset:     Logical offset of the original extent (PREALLOC or NOCOW)
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
  * @disk_bytenr:     Offset of extent on disk.
@@ -270,17 +272,17 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode,
 			struct fscrypt_extent_info *fscrypt_info,
-			u64 file_offset, u64 num_bytes, u64 ram_bytes,
-			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
-			unsigned long flags, int compress_type)
+			u64 file_offset, u64 orig_offset, u64 num_bytes,
+			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+			u64 offset, unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
 	entry = alloc_ordered_extent(inode, fscrypt_info, file_offset,
-				     num_bytes, ram_bytes, disk_bytenr,
-				     disk_num_bytes, offset, flags,
+				     orig_offset, num_bytes, ram_bytes,
+				     disk_bytenr, disk_num_bytes, offset, flags,
 				     compress_type);
 	if (!IS_ERR(entry))
 		insert_ordered_extent(entry);
@@ -1174,8 +1176,8 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 		return ERR_PTR(-EINVAL);
 
 	new = alloc_ordered_extent(inode, ordered->fscrypt_info, file_offset,
-				   len, len, disk_bytenr, len, 0, flags,
-				   ordered->compress_type);
+				   ordered->orig_offset, len, len, disk_bytenr,
+				   len, 0, flags, ordered->compress_type);
 	if (IS_ERR(new))
 		return new;
 
@@ -1196,6 +1198,16 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	ordered->num_bytes -= len;
 	ordered->disk_num_bytes -= len;
 
+	/*
+	 * ->orig_offset is the original offset of the original extent, which
+	 * for PREALLOC or NOCOW stays the same, but if we're a regular extent
+	 * that means this is a new extent and thus ->orig_offset must equal
+	 * ->file_offset.  This is only important for encryption as we only use
+	 * it for setting the offset for the bio encryption context.
+	 */
+	if (test_bit(BTRFS_ORDERED_REGULAR, &ordered->flags))
+		ordered->orig_offset = ordered->file_offset;
+
 	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
 		ASSERT(ordered->bytes_left == 0);
 		new->bytes_left = 0;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 57ca8ce6eb6d..a8ce181288f7 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -83,6 +83,12 @@ struct btrfs_ordered_extent {
 	/* logical offset in the file */
 	u64 file_offset;
 
+	/*
+	 * The original logical offset of the extent, this is for NOCOW and
+	 * PREALLOC extents, otherwise it'll be the same as file_offset.
+	 */
+	u64 orig_offset;
+
 	/*
 	 * These fields directly correspond to the same fields in
 	 * btrfs_file_extent_item.
@@ -165,9 +171,9 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode,
 			struct fscrypt_extent_info *fscrypt_info,
-			u64 file_offset, u64 num_bytes, u64 ram_bytes,
-			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
-			unsigned long flags, int compress_type);
+			u64 file_offset, u64 orig_offset, u64 num_bytes,
+			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+			u64 offset, unsigned long flags, int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.41.0


