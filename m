Return-Path: <linux-fsdevel+bounces-32849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421079AF86B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EF0282BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0B1B0F07;
	Fri, 25 Oct 2024 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChVnDbTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5D1ACDF0;
	Fri, 25 Oct 2024 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827994; cv=none; b=WMt6PSKivEVZM8+kRIM7Pt6Gp7dhUU4qfKU1Qx5olTdVY/wDil37rmD7fnNJMhRzPgSG8cXe/lBtP5gdmLsPhKv4288rPlZokVwVojV5op7yCd5XiwWzYyivpe5o+sgUbUFwRs7twKSJV25yIh3vBO8uyzvmfMyqXM2rMd5alPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827994; c=relaxed/simple;
	bh=+jbFavYt3S3M0UFG+Y++ADSwSWXABL573iBs3QaczNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1mCNfDLyXHfF6YuiTE/c/k1q77PtsloR6m1PUFGvqTM96xJtwUZh5zMWgp6yVVteWkTJ8NV/TX3DRp820DWGu4SxEHqPX53KIXiimJgK3wltzqWhl7xA2wI95QqkIng1ZcR4hz5ORu6c9NOZyvfEjDtmyPRDHKZq0zfteZqdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChVnDbTf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso1142968b3a.3;
        Thu, 24 Oct 2024 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827991; x=1730432791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV8eyMIG0H3BsY07DI6PZhHnOjAhFRubne0dZ3+5bLE=;
        b=ChVnDbTfmGIPomXH3WduPk/qUQCxYuqG95MP46kzW0xeIZGBInLZPiUZYxhcY6ci6z
         4LwiExHtP43MM2jCfJNRgEIa2gvnF2wLi52FyaWwMJE5QUHGmRqpkC4s+HNdN8w/gPSJ
         LCO3cEuR7boehgFJpa4NETpqB3NJkLb5R4PKzl9fbZz3NI5k8nfBNOeUaJV8g6D9E4Sh
         TChcb6M5IDQbWxTKpskGcwrk40zjnGvKEw3IH1IxIUamScAQVpiQXojYefcmDzuaj+C7
         JDwkzMjcudYXVS0k2u34stvLP+wYoe6dMNh8KAKRd1j5r4bD0QoRpRpmGmWsdLx2zLwh
         fR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827991; x=1730432791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV8eyMIG0H3BsY07DI6PZhHnOjAhFRubne0dZ3+5bLE=;
        b=NyPdox3RvDLGj4DYI9zdC+t2ue1SlVsW7ss3IYFyy+X9o+yJMgY+skQnoAE1poCTnZ
         1ZZNFzJkOBLd5xmnY3ray4J02hw2XTmdwti3KJuUY6pS/yTj6vETjYqUSDg7qOPoIyzi
         rdzmuBjgih9ccmt7R0Znb9adLuhxNcJpA/TH1AT++BbERo8pUVflj4zBiWXA2OU3vxMa
         0uP9sT0dxbQbeC+qQmKe3B78TudArn0Yj2qTEQUq1pVqFutGjGDe0cIZ7+hfWFtNugHJ
         ewQRJXy9AoVMD/SckJQ/1KEIva6xdLv+we7fgEhciWpzCJQRQfoolgrmgypwpZ9oNJ0A
         6ByQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV6MUPGo+wOdFGU8x7UBSa+vGpv8WVkifmaFIRA3/AkleXHQIbcgvaysFDX6VJioG4XKFrXMbIwGoA@vger.kernel.org, AJvYcCVetRgFO1FHpMm0iTS5XOV57TKBG5njWHQ0HNNGSEHQO1Y8I1LegiLVyhiXhZwNeZbHK8WAfR51sZ1wNVmy@vger.kernel.org, AJvYcCVwLSSbLcBdyZepaDT733kuUph/F4bHdaiyI8QEVCoYw8NPeVfQK56HOv2g1z4gqUf1g7r5NaUyjJVDOI6u@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2gwe2ACvMYREE+4iNVm1KnILwc5fGi9oZ8/fHo8NFLsfO7fF
	zAVLRNeK6tZpxe0ApGRvljnYA28rLNnEFD1WZi9N5mXqQVvFosC1coep2g==
X-Google-Smtp-Source: AGHT+IHNv3nj9RCbYdpMn4CGatYSbVnL4coPHNxRpjeEP5ig4aeDgBKitBPLznyv9qpb0xdXrjrzzg==
X-Received: by 2002:a05:6a21:6801:b0:1d9:76a3:a208 with SMTP id adf61e73a8af0-1d978bd6201mr10915868637.47.1729827991027;
        Thu, 24 Oct 2024 20:46:31 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:30 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 6/6] ext4: Add atomic write support for bigalloc
Date: Fri, 25 Oct 2024 09:15:55 +0530
Message-ID: <37baa9f4c6c2994df7383d8b719078a527e521b9.1729825985.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729825985.git.ritesh.list@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com>
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
create FS using -
    mkfs.ext4 -F -O bigalloc -b 4096 -C 16384 <dev>

EXT4 can then adjust it's atomic write unit max value to cluster size.
This can then support atomic write of size anywhere between
[blocksize, clustersize].

Note: bigalloc can support writes of the pattern [0 16k] followed by [0 8k].
However, if there is a write pattern detected of type [0 8k] followed by
[0 16k], then we return an error (-EINVAL). It is ok to return an error here
to avoid splitting of atomic write request. This is ok because anyways
atomic write requests has many constraints to follow for e.g. writes of
form which does not follow natural alignment [4k, 12k] ([start, end]) can
also return -EINVAL (check generic_atomic_write_valid()).
Hence the current patch adds the base support needed to support
atomic writes with bigalloc. This is helpful for systems with 4k
pagesize to support atomic writes.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 13 +++++++++++++
 fs/ext4/super.c |  9 +++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 897c028d5bc9..2dee8514d2f8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3423,6 +3423,19 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 */
 	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
 
+	/*
+	 * [0 16k] followed by [0 8k] can work with bigalloc. However,
+	 * For now we don't support atomic writes of the pattern
+	 * [0 8k] followed by [0 16k] in case of bigalloc. This is because it
+	 * can cause the atomic writes to split in the iomap layer.
+	 * Atomic writes anyways has many constraints, so as a base support to
+	 * enable atomic writes using bigalloc, it is ok to return an error for
+	 * an unsupported write request.
+	 */
+	if (flags & IOMAP_ATOMIC) {
+		if (map.m_len < (length >> blkbits))
+			return -EINVAL;
+	}
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 
 	return 0;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f5c075aff060..eba16989ce36 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4428,12 +4428,14 @@ static int ext4_handle_clustersize(struct super_block *sb)
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
+
 
 	if (!bdev_can_atomic_write(bdev))
 		return;
@@ -4441,9 +4443,12 @@ static void ext4_atomic_write_init(struct super_block *sb)
 	if (!ext4_has_feature_extents(sb))
 		return;
 
+	if (ext4_has_feature_bigalloc(sb))
+		clustersize = 1U << (sbi->s_cluster_bits + blkbits);
+
 	sbi->fs_awu_min = max(sb->s_blocksize,
 			      bdev_atomic_write_unit_min_bytes(bdev));
-	sbi->fs_awu_max = min(sb->s_blocksize,
+	sbi->fs_awu_max = min(clustersize,
 			      bdev_atomic_write_unit_max_bytes(bdev));
 	if (sbi->fs_awu_min && sbi->fs_awu_max &&
 			sbi->fs_awu_min <= sbi->fs_awu_max) {
-- 
2.46.0


