Return-Path: <linux-fsdevel+bounces-13526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD0870A40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831631F216BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0A7A73C;
	Mon,  4 Mar 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSSonr+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D779B7C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579542; cv=none; b=ecrhfgVpnPwOZqxHbeNPh+Y9B+iDtsKChqGQoCPd+cciqdmcHHNhTknwobFnsPYH7kI5FgDg6dyvrNGIhjVqrmAtJpaRZfnIwyxJV8OFcPTnftuJIH16JnEDrwiICRjsxmSDksujuBuYuPAjVafa9FCVeHcE1T6DqAOUKQ4EPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579542; c=relaxed/simple;
	bh=SStO3MOW2u5KsO8/UusGE2i9sPUyuTxbXlOJN7+jtOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPAsyt4tZax98jKL2TzoZMa1PrHzG3Uuv8hN9NsNN4BRXDJEbq7eicAsviuyGVhh77SqiMEYoTdCTet2IHBHJINTzKgvPXjP1kPg7JONBdniXfZoMPsa3ClIbZYov10nDisEakSlez6lldAfQzq0Qj9mz9kplXIZ37A0de14i54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSSonr+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw7Hqds3kjPV691CMfHa/B2Ot566kYEuH+bc7CPQnG4=;
	b=FSSonr+MRaqYae8CrihHUtnzvOOa96Gf3otxzdLqLAKfQN+n2ZYPbp3JAn5dqaGlmsvidF
	RiKx7Ei19YnT0s+NP0BKGihI4bp/+Qr2uyhe+cqA2kzPGA0LNHCbWVs6N3jMJJiwXRBWSc
	pUvQRex86jDCMb7DKjKTFBaANav5mqc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-IyXV5eeeNIiXiRLRZscxTQ-1; Mon, 04 Mar 2024 14:12:18 -0500
X-MC-Unique: IyXV5eeeNIiXiRLRZscxTQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5133f0f1b9bso1694161e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579536; x=1710184336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw7Hqds3kjPV691CMfHa/B2Ot566kYEuH+bc7CPQnG4=;
        b=c2qCVzDhkEDMJjh32SaotwwWf0FaTZm+1/+DGniHL92Q2KXC4+Le7kZ+UWbxsyPfj4
         SAgf/WFptnX2+LuyOAhPBxUNThWRRJqFtDdvTVLGEJFGN26M7M1ng/0hWZd7bgIXPxAl
         qaLijJMnjG1b8mjgHXkj7zd3s3/ZFG1Q5MgilkziLLyEm5YJ1A6AhTxlwCC0STpD6kZ9
         Y9tXFgaylDwdT+YbFtMk/cYRctFiBJodNVMW8zo6rGTuQ5NnQ2YOiuKzFB0EfcHs4cIw
         wdmBsjG9g7Bbxdev3YaShkle+FQ2ofd6XPCCeWa+rBAKR4tK873iwqxO6AoQhes0gxev
         Xt9A==
X-Forwarded-Encrypted: i=1; AJvYcCWLHd+pHzPvssQclJnpcPENdsh877oHu9uOzU590UmtJBiGc3OM4GB0T6w4g+zbiCuBsz0g+LRfV2wQ+QuSgMuvDkBfNAAqGWf2O6LeQw==
X-Gm-Message-State: AOJu0Yw+OzkJIG8smvARFlaUlE3XfG3DKREf4VawmzwZVpDcilueQK78
	8ooxlfrVe5CArJRiXFtXbJpA71gs7nDSV4ZSNuKFoqF3T4xBjDZOSruRnemuQwH8WYIBQmfuXq5
	uOVY9T6BJkgR3FobMWo96uiOcLw9MllGrOpy/2G8awCwYcE0Sw0FzGSc1/iZR4Cp8zdRwww==
X-Received: by 2002:ac2:42c3:0:b0:513:3f16:25d6 with SMTP id n3-20020ac242c3000000b005133f1625d6mr3805653lfl.34.1709579536594;
        Mon, 04 Mar 2024 11:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDSbClFcafmZzQTfNNN+PHTRYEIEdcmRoCaXYEzSwLMrvqR4HZHhRmpoF1p1meXKQT+foAQ==
X-Received: by 2002:ac2:42c3:0:b0:513:3f16:25d6 with SMTP id n3-20020ac242c3000000b005133f1625d6mr3805635lfl.34.1709579536148;
        Mon, 04 Mar 2024 11:12:16 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:15 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 06/24] fsverity: pass tree_blocksize to end_enable_verity()
Date: Mon,  4 Mar 2024 20:10:29 +0100
Message-ID: <20240304191046.157464-8-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFS will need to know tree_blocksize to remove the tree in case of an
error. The size is needed to calculate offsets of particular Merkle
tree blocks.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/btrfs/verity.c        | 4 +++-
 fs/ext4/verity.c         | 3 ++-
 fs/f2fs/verity.c         | 3 ++-
 fs/verity/enable.c       | 6 ++++--
 include/linux/fsverity.h | 4 +++-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..966630523502 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -621,6 +621,7 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * @desc:              verity descriptor to write out (NULL in error conditions)
  * @desc_size:         size of the verity descriptor (variable with signatures)
  * @merkle_tree_size:  size of the merkle tree in bytes
+ * @tree_blocksize:    the Merkle tree block size
  *
  * If desc is null, then VFS is signaling an error occurred during verity
  * enable, and we should try to rollback. Otherwise, attempt to finish verity.
@@ -628,7 +629,8 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * Returns 0 on success, negative error code on error.
  */
 static int btrfs_end_enable_verity(struct file *filp, const void *desc,
-				   size_t desc_size, u64 merkle_tree_size)
+				   size_t desc_size, u64 merkle_tree_size,
+				   unsigned int tree_blocksize)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(filp));
 	int ret = 0;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 2f37e1ea3955..da2095a81349 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -189,7 +189,8 @@ static int ext4_write_verity_descriptor(struct inode *inode, const void *desc,
 }
 
 static int ext4_end_enable_verity(struct file *filp, const void *desc,
-				  size_t desc_size, u64 merkle_tree_size)
+				  size_t desc_size, u64 merkle_tree_size,
+				  unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	const int credits = 2; /* superblock and inode for ext4_orphan_del() */
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4fc95f353a7a..b4461b9f47a3 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -144,7 +144,8 @@ static int f2fs_begin_enable_verity(struct file *filp)
 }
 
 static int f2fs_end_enable_verity(struct file *filp, const void *desc,
-				  size_t desc_size, u64 merkle_tree_size)
+				  size_t desc_size, u64 merkle_tree_size,
+				  unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..04e060880b79 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -274,7 +274,8 @@ static int enable_verity(struct file *filp,
 	 * Serialized with ->begin_enable_verity() by the inode lock.
 	 */
 	inode_lock(inode);
-	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
+	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size,
+				      params.block_size);
 	inode_unlock(inode);
 	if (err) {
 		fsverity_err(inode, "%ps() failed with err %d",
@@ -300,7 +301,8 @@ static int enable_verity(struct file *filp,
 
 rollback:
 	inode_lock(inode);
-	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size);
+	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size,
+				      params.block_size);
 	inode_unlock(inode);
 	goto out;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1eb7eae580be..ac58b19f23d3 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -51,6 +51,7 @@ struct fsverity_operations {
 	 * @desc: the verity descriptor to write, or NULL on failure
 	 * @desc_size: size of verity descriptor, or 0 on failure
 	 * @merkle_tree_size: total bytes the Merkle tree took up
+	 * @tree_blocksize: the Merkle tree block size
 	 *
 	 * If desc == NULL, then enabling verity failed and the filesystem only
 	 * must do any necessary cleanups.  Else, it must also store the given
@@ -65,7 +66,8 @@ struct fsverity_operations {
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*end_enable_verity)(struct file *filp, const void *desc,
-				 size_t desc_size, u64 merkle_tree_size);
+				 size_t desc_size, u64 merkle_tree_size,
+				 unsigned int tree_blocksize);
 
 	/**
 	 * Get the verity descriptor of the given inode.
-- 
2.42.0


