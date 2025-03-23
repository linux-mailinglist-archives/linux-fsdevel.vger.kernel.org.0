Return-Path: <linux-fsdevel+bounces-44824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67049A6CE2D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 08:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7188170643
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E320297B;
	Sun, 23 Mar 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ3dOfVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6920127F;
	Sun, 23 Mar 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742713351; cv=none; b=VGbE0kNFRdglL09OVt8tO7VZlSX4Y2BFmWbqBvZBfoIxi2k9JeKWcdTgN/wajTL7FWIRH0QCxPhDM/Ck8/zKO0B/kJhpYpc77c0hi0wZtKc3Ntj70EhHtaeTFbjwxcW3i4xZKuySVKYHGeVbJh83XGGO0/2nuMd7iygVjmiR0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742713351; c=relaxed/simple;
	bh=g0HhcUvi3h43mpX6YclPZ4YNxHm5ucruPLBM3q4312s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQJSJm9W2FbvOdlWYQV690iPV0yXsacyLkrnNHtu4G+Xc4m5ESOEaBVRBEDjZ+wkeIGUL7DXWT6efi9FHIO4nxY55WOmgStPyUf+G5lNLMkS2XH0um5bHUC+rnIcTheJnMfE8XvEFvtOZHV/TjPuDSVLwSGbVYGpbyEENAyuod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ3dOfVK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fb0f619dso66767155ad.1;
        Sun, 23 Mar 2025 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742713349; x=1743318149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4RXegz01jmIND++90wQM9qaUECiHSM93MWBrYRkjoY=;
        b=IJ3dOfVKs7b1N5AFgWWn4KyT5rTPYIHfl1rqHArd/VPjD4r/lUq+uZGudmQhQmiN7h
         K1JQa6RVqZzKlbUXlSOQVOaiWoAK96+rMYb1FCQiXI6pE3cwakoMF5iyhzvunNrGB8d8
         l1mXLo8Ia9SVc/ZbMHW3+Huzkr43g+/PJLwYVuRrTpmH3sVl9loXrI7HSeOr7LTTlF4S
         WC69Dg+Y8cwBYWa9obZz6tk/sDURmxD2GBWBlABDZY4YTrA0QlB/q127GRZHB34nUqnd
         iaqtHsJrj8qQY2+iACsAqdxo/8LA8EfdZqxc5EOYzoxPKHEAZzGa9e+Rbzx2e3oMbxf9
         vfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742713349; x=1743318149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4RXegz01jmIND++90wQM9qaUECiHSM93MWBrYRkjoY=;
        b=SYgw0eWxbcb/ijd9R2Z6oUZtyjBYy9lvFuP4NXa2PAdjY7d6wm50bn9pxa3GHncXMB
         b8DQnc+YtBMZGl3pkJF/k5nw3VGaoXklQuEhFXWwVr9sLCjJIOxGczbHOzh8ZhRTNu/6
         jS9ezSNewGPb2lREeEyXWdhb25B2kJ9mSqzlFXHjwpXJ6sLFsbJxI9Rd+06VNo51/Ui5
         A2RGLDsd3+YhXMKOeSm+xTsQ+Rt7WNsOItwV1ocpQQM3zUaUYNXC8gO/UYSFU9QwtAsM
         RADwMHV8GKzomOVNkIKfQKxtHIGzTiTGtUK/SPa0PpwHQp+LwgMckZKzwYxYoeQpkKXX
         QolA==
X-Forwarded-Encrypted: i=1; AJvYcCUclVi4HRIb5LUpA55jNHrTMa20XVhzxBgzh4XnorcjhwhOJkB61CFQnup7Csw7nmsJyfHWm/sGC7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMe1XV107mQloWLqpRETlOHH8BGG8ba5IOVJLO3qQqCqSyUGpp
	iwFhmXGk0vrjFifryLoZod7epY3D3aB9hgcZWcF+XJQJyPz63q+TxTb+aw==
X-Gm-Gg: ASbGncsL+QPVbEhTiA9ymEeY0ucPxzrrHeAwzFhf1RsR7RoP5do6jTbJU8Xw8Kspjhl
	KFxER+/ggRWgR33ckPNN9z/eDOywRvCF6CAgrSjtXUfc3OQnuTykVPn6gXlwxAXUR+oQypfmocG
	2FvFrtPdFLZvFfeioA/bltuFsRAuQVQV4cywuxZu+S9ESr4DjrHyK16WTHXhHh72SO0Ah0QG2FA
	qHz7HrisHoXKF9uNOJMyjtsaeHRHGORQzby2f5ZRsC/IBcFSBxTFXJNdRBRyQwvo8c9c8VSG+8D
	BP911EXXZ9ULMUQw3Khem7lQnFB6EQGkcSPZ6sBH
X-Google-Smtp-Source: AGHT+IEZ0OMMq/aaClZvY0NFB5sMNSfeukbv/nOcGfRp38YG4jdCYZOQooqJG4ocKr4axR0ucXdqRA==
X-Received: by 2002:a17:902:d58b:b0:224:1579:5e8e with SMTP id d9443c01a7336-22780c5111fmr139750095ad.1.1742713348804;
        Sun, 23 Mar 2025 00:02:28 -0700 (PDT)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da89csm46058445ad.193.2025.03.23.00.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:02:28 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 1/1] ext4: Add multi-fsblock atomic write support with bigalloc
Date: Sun, 23 Mar 2025 12:32:18 +0530
Message-ID: <6ce4303bfbccc4f5ed3be96b56eb1080b724b0da.1742699765.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742699765.git.ritesh.list@gmail.com>
References: <cover.1742699765.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXT4 supports bigalloc feature which allows the FS to work in size of
clusters (group of blocks) rather than individual blocks. This patch
adds atomic write support for bigalloc so that systems with bs = ps can
also create FS using -
    mkfs.ext4 -F -O bigalloc -b 4096 -C 16384 <dev>

With bigalloc ext4 can support multi-fsblock atomic writes. We will have to
adjust ext4's atomic write unit max value to cluster size. This can then support
atomic write of size anywhere between [blocksize, clustersize].

We first query the underlying region of the requested range by calling
ext4_map_blocks() call. Here are the various cases which we then handle
for block allocation depending upon the underlying mapping type:
1. If the underlying region for the entire requested range is a mapped extent,
   then we don't call ext4_map_blocks() to allocate anything. We don't need to
   even start the jbd2 txn in this case.
2. For an append write case, we create a mapped extent.
3. If the underlying region is entirely a hole, then we create an unwritten
   extent for the requested range.
4. If the underlying region is a large unwritten extent, then we split the
   extent into 2 unwritten extent of required size.
5. If the underlying region has any type of mixed mapping, then we call
   ext4_map_blocks() in a loop to zero out the unwritten and the hole regions
   within the requested range. This then provide a single mapped extent type
   mapping for the requested range.

Note: We invoke ext4_map_blocks() in a loop with the EXT4_GET_BLOCKS_ZERO
flag only when the underlying extent mapping of the requested range is
not entirely a hole, an unwritten extent, or a fully mapped extent. That
is, if the underlying region contains a mix of hole(s), unwritten
extent(s), and mapped extent(s), we use this loop to ensure that all the
short mappings are zeroed out. This guarantees that the entire requested
range becomes a single, uniformly mapped extent. It is ok to do so
because we know this is being done on a bigalloc enabled filesystem
where the block bitmap represents the entire cluster unit.

Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/super.c |  8 +++--
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d04d8a7f12e7..0096a597ad04 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3332,6 +3332,67 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 		iomap->addr = IOMAP_NULL_ADDR;
 	}
 }
+/*
+ * ext4_map_blocks_atomic: Helper routine to ensure the entire requested mapping
+ * [map.m_lblk, map.m_len] is one single contiguous extent with no mixed
+ * mappings. This function is only called when the bigalloc is enabled, so we
+ * know that the allocated physical extent start is always aligned properly.
+ *
+ * We call EXT4_GET_BLOCKS_ZERO only when the underlying physical extent for the
+ * requested range does not have a single mapping type (Hole, Mapped, or
+ * Unwritten) throughout. In that case we will loop over the requested range to
+ * allocate and zero out the unwritten / holes in between, to get a single
+ * mapped extent from [m_lblk, m_len]. This case is mostly non-performance
+ * critical path, so it should be ok to loop using ext4_map_blocks() with
+ * appropriate flags to allocate & zero the underlying short holes/unwritten
+ * extents within the requested range.
+ */
+static int ext4_map_blocks_atomic(handle_t *handle, struct inode *inode,
+				  struct ext4_map_blocks *map)
+{
+	ext4_lblk_t m_lblk = map->m_lblk;
+	unsigned int m_len = map->m_len;
+	unsigned int mapped_len = 0, flags = 0;
+	u8 blkbits = inode->i_blkbits;
+	int ret;
+
+	WARN_ON(!ext4_has_feature_bigalloc(inode->i_sb));
+
+	ret = ext4_map_blocks(handle, inode, map, 0);
+	if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
+		flags = EXT4_GET_BLOCKS_CREATE;
+	else if ((ret == 0 && map->m_len >= m_len) ||
+		(ret >= m_len && map->m_flags & EXT4_MAP_UNWRITTEN))
+		flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
+	else
+		flags = EXT4_GET_BLOCKS_CREATE_ZERO;
+
+	do {
+		ret = ext4_map_blocks(handle, inode, map, flags);
+		if (ret < 0)
+			return ret;
+		mapped_len += map->m_len;
+		map->m_lblk += map->m_len;
+		map->m_len = m_len - mapped_len;
+	} while (mapped_len < m_len);
+
+	map->m_lblk = m_lblk;
+	map->m_len = m_len;
+
+	/*
+	 * We might have done some work in above loop. Let's ensure we query the
+	 * start of the physical extent, based on the origin m_lblk and m_len
+	 * and also ensure we were able to allocate the required range for doing
+	 * atomic write.
+	 */
+	ret = ext4_map_blocks(handle, inode, map, 0);
+	if (ret != m_len) {
+		ext4_warning_inode(inode, "allocation failed for atomic write request pos:%u, len:%u\n",
+				m_lblk, m_len);
+		return -EINVAL;
+	}
+	return mapped_len;
+}

 static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 			    unsigned int flags)
@@ -3377,7 +3438,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;

-	ret = ext4_map_blocks(handle, inode, map, m_flags);
+	if (flags & IOMAP_ATOMIC && ext4_has_feature_bigalloc(inode->i_sb))
+		ret = ext4_map_blocks_atomic(handle, inode, map);
+	else
+		ret = ext4_map_blocks(handle, inode, map, m_flags);

 	/*
 	 * We cannot fill holes in indirect tree based inodes as that could
@@ -3401,6 +3465,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	unsigned int m_len_orig;

 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3414,6 +3479,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_lblk = offset >> blkbits;
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	m_len_orig = map.m_len;

 	if (flags & IOMAP_WRITE) {
 		/*
@@ -3424,8 +3490,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		 */
 		if (offset + length <= i_size_read(inode)) {
 			ret = ext4_map_blocks(NULL, inode, &map, 0);
-			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
-				goto out;
+			/*
+			 * For atomic writes the entire requested length should
+			 * be mapped.
+			 */
+			if (map.m_flags & EXT4_MAP_MAPPED) {
+				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
+				   (flags & IOMAP_ATOMIC && ret >= m_len_orig))
+					goto out;
+			}
+			map.m_len = m_len_orig;
 		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
@@ -3442,6 +3516,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 */
 	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);

+	/*
+	 * Before returning to iomap, let's ensure the allocated mapping
+	 * covers the entire requested length for atomic writes.
+	 */
+	if (flags & IOMAP_ATOMIC) {
+		if (map.m_len < (length >> blkbits)) {
+			WARN_ON(1);
+			return -EINVAL;
+		}
+	}
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);

 	return 0;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a50e5c31b937..cbb24d535d59 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4442,12 +4442,13 @@ static int ext4_handle_clustersize(struct super_block *sb)
 /*
  * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
  * @sb: super block
- * TODO: Later add support for bigalloc
  */
 static void ext4_atomic_write_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct block_device *bdev = sb->s_bdev;
+	unsigned int blkbits = sb->s_blocksize_bits;
+	unsigned int clustersize = sb->s_blocksize;

 	if (!bdev_can_atomic_write(bdev))
 		return;
@@ -4455,9 +4456,12 @@ static void ext4_atomic_write_init(struct super_block *sb)
 	if (!ext4_has_feature_extents(sb))
 		return;

+	if (ext4_has_feature_bigalloc(sb))
+		clustersize = 1U << (sbi->s_cluster_bits + blkbits);
+
 	sbi->s_awu_min = max(sb->s_blocksize,
 			      bdev_atomic_write_unit_min_bytes(bdev));
-	sbi->s_awu_max = min(sb->s_blocksize,
+	sbi->s_awu_max = min(clustersize,
 			      bdev_atomic_write_unit_max_bytes(bdev));
 	if (sbi->s_awu_min && sbi->s_awu_max &&
 	    sbi->s_awu_min <= sbi->s_awu_max) {
--
2.48.1


