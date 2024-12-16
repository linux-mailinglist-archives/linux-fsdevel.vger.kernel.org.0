Return-Path: <linux-fsdevel+bounces-37489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6D9F3139
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA26162517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890D2063EA;
	Mon, 16 Dec 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYkkTbJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC182063CC;
	Mon, 16 Dec 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354398; cv=none; b=pvnVF34eosOmmrhpwJBhvReu0ocL06B9L4cAe1F6kTyCJwrivtXkdOVsOoANx4d/Ywz7zCzqpU+gM6GCpZDGv4DJyO/0/t5gMW9UguzNAv9zupsIX2eCoeEf1StiJG8oVwjyOSh9yDVj5MRZ9s6Co1he7XWzpuPRySyp8RoIRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354398; c=relaxed/simple;
	bh=wRsSvFVPRfgGY4acKGvTQiKD6OTAlmB+uyzhTrY0/pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbwt1LOhug1RapLzQvvtndEXQrRz7jSzfUFhLOHTU10QRMZS/VCE8QDza0TQVdhxEVTCF4jT4ECxSftESQv3KonaCtOlaB+1ynF4Zq9e3+F2w6SS/peV+plYKUFcLBO+C6C/gu9yfgDh6RVj9SiIaABkHOJjmp8LM5AnpgQLJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYkkTbJ6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so3082067b3a.2;
        Mon, 16 Dec 2024 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734354396; x=1734959196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5r2AI1rSTk78vMUPnfBS3x9c1y/UZLB1l4KtYcBGR0=;
        b=jYkkTbJ6eOb5j7lFXafVP8mU4/auNvBVI7+XRkTtWJIZA66/nmzYayKBq5vaMwMS4u
         RjEk62/pNCpZ6RFJmpaSkk077pZOcHJF6Gc6WYo+evHplzZYvFAvw+5JpGMv/xpzq++9
         PHegdu+qPISTHrJWb8ExPM3Ax1nz6NoXUIhv7uEtbUyuKWVWzxYRJe7AphIC5S3L/soQ
         u8UTK/jPDuPHlLyoRo1z8nVi0S4n+3tduOQoEHDnj4e8WxOpF1lH37ZMLGYbEneWnuQe
         3ABladQKkRk6axVUkOMXEudtB9C6wCd+7UrO/QlZT6yVQ0YlurfwwkcDgQ9ezC4RjUIe
         3M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354396; x=1734959196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5r2AI1rSTk78vMUPnfBS3x9c1y/UZLB1l4KtYcBGR0=;
        b=GzKeIitYE3tRrSX7cnj6RRPOeiQCROOuVOwBMB9wVtE7raMg3WYSQeiHKcmEO7CarB
         dXY4CkrnKwzCjEEW9ZWR/H8dcbhh8R9A9a3LQCfz91jVnd0+vHz4wbHRbXF+xXxGh9xX
         k9Ha3JukKUJdakzKRTXvnOzGNNUEI4IlaGoPRDGRZgg6wuw8k8bdJI97orCOJaz3a+BV
         pEJEZIl6Wh4vD7TpOMDuNGYhQEsHMXMRq9PMKGQQbOZxJaZE+bQGIOGKVxvs4phv/jcL
         CIjtvJ+PMMideRO5Kac5OYDJMrBZoPE0I4ka83zrjAtu4OOQ20b0iblxAy9S2N/gAPE5
         rfIA==
X-Forwarded-Encrypted: i=1; AJvYcCWEiTl1nfT7QGVaB6OJoHe98W32Vq3qYtftqWB3WHh6mgafj1WvB1rcYgvE+1Jf7PmiLNMli3tmiwU+BKHi@vger.kernel.org, AJvYcCWFE6r3PjT0C5rVjQtl2fQX3fbG2vXdsXVIBEh2ZOJp60xCg81kMzfXX9hn+31dILV2hcJzISZ+yH4Uj6c6@vger.kernel.org, AJvYcCXBkrJykqADn8oaPniR8W1w4MCE+vFtrt4OSgcdyvo6u9KUuL4EYqwB1/JBbV53LZ695wohO5zRkHwg@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe4TXnrRd26cp7nAR1UHNPV2L2zUnkRhJJ0PgzNv62+dsc9+B
	vsS0nJtn9NQO83pPJlYODZMV1QZm8IJod7+GOHHK6Imh4UhhnuLr
X-Gm-Gg: ASbGncuIwhKAYhFpTCJsVMMsfyrV9TSjBUwL++pRmCr4FRppY9RYGziZrcc/HhFsKEa
	Ijmj4bn3iXWKHpu/Lp4X/57DzB/x6PHP8R9ACC+YWVMh4G+46en+oGdl5cjgEsll9G3YqMSL4K6
	QdKEAuDqr3UROMVHgM4CFabXo7co8swzvvuGl9kJq/V8Gnsc3LlPoHySuyi12IpLn6VWSHcsuIs
	T/RsnQG+dleZzUgVP14w+IDFebQaMK3YCUCwmEJ/Q+RHkm4ucLalPmheUO69Z2f7JUd9VMwtznl
	z/0hImYkCnLz3h4=
X-Google-Smtp-Source: AGHT+IEAJxSqcyMUNnCpMLo186xhSDWzWUuvAjMBJVZ3xE04BduVQdyFNrBSLeQFSFU1Gg/zWvAbWA==
X-Received: by 2002:aa7:8b4e:0:b0:729:c7b:9385 with SMTP id d2e1a72fcca58-7290c7b9577mr14855357b3a.6.1734354396252;
        Mon, 16 Dec 2024 05:06:36 -0800 (PST)
Received: from localhost.localdomain ([180.101.244.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5ad0sm4651803b3a.56.2024.12.16.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:35 -0800 (PST)
From: Tianxiang Peng <luminosity1999@gmail.com>
X-Google-Original-From: Tianxiang Peng <txpeng@tencent.com>
To: chandan.babu@oracle.com,
	djwong@kernel.org,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	brauner@kernel.org,
	dchinner@redhat.com
Cc: Tianxiang Peng <txpeng@tencent.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	allexjlzheng@tencent.com,
	flyingpeng@tencent.com
Subject: [PATCH 1/2] xfs: calculate cluster_size_raw from sb when sparse alloc enabled
Date: Mon, 16 Dec 2024 21:05:48 +0800
Message-ID: <20241216130551.811305-2-txpeng@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216130551.811305-1-txpeng@tencent.com>
References: <20241216130551.811305-1-txpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sparse inode allocation enabled, use sb_spino_align read from
sb to calculate inode_cluster_size_raw. As now
inode_cluster_size_raw is not a fixed value, remove the validation
in mount code, subtitute it with some value checks.

Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
Reviewed-by: Jinliang Zheng <allexjlzheng@tencent.com>
Reviewed-by: Hao Peng <flyingpeng@tencent.com>
---
 fs/xfs/libxfs/xfs_ialloc.c | 35 ++++++++++++++++++++++-------------
 fs/xfs/xfs_mount.c         | 12 ++++++------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 271855227514..f276ccbe9d6f 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -2989,22 +2989,31 @@ xfs_ialloc_setup_geometry(
 	}
 
 	/*
-	 * Compute the desired size of an inode cluster buffer size, which
-	 * starts at 8K and (on v5 filesystems) scales up with larger inode
-	 * sizes.
+	 * If sparse inode is enabled, take its alignment as cluster size, as
+	 * mkfs may change cluster size to deal with extreme fragmentation
+	 * situations. For that case, sparse inode alignment will be set to
+	 * actual block count of cluster size.
 	 *
-	 * Preserve the desired inode cluster size because the sparse inodes
-	 * feature uses that desired size (not the actual size) to compute the
-	 * sparse inode alignment.  The mount code validates this value, so we
-	 * cannot change the behavior.
+	 * Otherwise, compute the desired size of an inode cluster buffer size,
+	 * which starts at 8K and (on v5 filesystems) scales up with larger inode
+	 * sizes.
 	 */
-	igeo->inode_cluster_size_raw = XFS_INODE_BIG_CLUSTER_SIZE;
-	if (xfs_has_v3inodes(mp)) {
-		int	new_size = igeo->inode_cluster_size_raw;
+	if (xfs_has_sparseinodes(mp)) {
+		igeo->inode_cluster_size_raw = mp->m_sb.sb_blocksize;
+		if (mp->m_sb.sb_spino_align)
+			igeo->inode_cluster_size_raw *= mp->m_sb.sb_spino_align;
+		xfs_info(mp,
+			"Calculate cluster_size_raw from sb: %u. sb_inoalignment: %u",
+			igeo->inode_cluster_size_raw, mp->m_sb.sb_inoalignmt);
+	} else {
+		igeo->inode_cluster_size_raw = XFS_INODE_BIG_CLUSTER_SIZE;
+		if (xfs_has_v3inodes(mp)) {
+			int	new_size = igeo->inode_cluster_size_raw;
 
-		new_size *= mp->m_sb.sb_inodesize / XFS_DINODE_MIN_SIZE;
-		if (mp->m_sb.sb_inoalignmt >= XFS_B_TO_FSBT(mp, new_size))
-			igeo->inode_cluster_size_raw = new_size;
+			new_size *= mp->m_sb.sb_inodesize / XFS_DINODE_MIN_SIZE;
+			if (mp->m_sb.sb_inoalignmt >= XFS_B_TO_FSBT(mp, new_size))
+				igeo->inode_cluster_size_raw = new_size;
+		}
 	}
 
 	/* Calculate inode cluster ratios. */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 1fdd79c5bfa0..47260d9c5033 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -761,12 +761,12 @@ xfs_mountfs(
 	 * but that is checked on sb read verification...
 	 */
 	if (xfs_has_sparseinodes(mp) &&
-	    mp->m_sb.sb_spino_align !=
-			XFS_B_TO_FSBT(mp, igeo->inode_cluster_size_raw)) {
-		xfs_warn(mp,
-	"Sparse inode block alignment (%u) must match cluster size (%llu).",
-			 mp->m_sb.sb_spino_align,
-			 XFS_B_TO_FSBT(mp, igeo->inode_cluster_size_raw));
+		(!is_power_of_2(igeo->inode_cluster_size_raw)
+		|| igeo->inode_cluster_size_raw < mp->m_sb.sb_inodesize
+		|| igeo->inode_cluster_size_raw >
+			XFS_INODES_PER_CHUNK * mp->m_sb.sb_inodesize)) {
+		xfs_warn(mp, "Invalid sparse inode cluster size(%u).",
+			igeo->inode_cluster_size_raw);
 		error = -EINVAL;
 		goto out_remove_uuid;
 	}
-- 
2.43.5


