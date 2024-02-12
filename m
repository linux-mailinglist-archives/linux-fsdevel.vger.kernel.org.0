Return-Path: <linux-fsdevel+bounces-11147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6C851A61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35B61C20CA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFA3EA7A;
	Mon, 12 Feb 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw2dT58X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329263E47B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757201; cv=none; b=Pktw31vRw3dxnHyO/Lk2OalKuHpyA7rXO9J8FD6e8rMBbK4BDh0UA5G7oD53sez7Vl6yRv084HXcvVNt2hgxRh0iTs9/9uh/eLZx39B7V9si3c+uCHSgQXnptZylBorPKWnHCyeIA0jK74dpDg1rojFbZcE1Na5KAAoY33bdwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757201; c=relaxed/simple;
	bh=J8eqmJ+xrgEjOXP2VKM/OiQv88UWMfaFDCsYsiGjLNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtTtuorvhTXKRhfNU+GyZ2CT5I8wYprXN3XqwE6bAE2V1hnRF6G4daL/mDlAPd54UVUqkUPS7ZGkTQCc/F4xfenphH0pGM/EaJJh2jMxCXDLBquWLTPdRNbSab0y15u4Q+f4mpRB72+VwMtjO2gJdrZHALtHHpopZgQxkFR/09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw2dT58X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tj+M9muz5Mq0wRvQVjpVNnfnNXBZ0GExMp5ECK241aI=;
	b=Sw2dT58XLRNeLL/mlkQ0M2PqrS7XWsMJde2Umg8tCuVp9XkAxHgi12fy5tTMqiv2eW5JVA
	/iytxs8xg9zuH1yAI5UtTmpxfZvV/oUXSn5GoVmYDBYArcdUylhUNXfDQxltKJGSvc5efr
	XM+AD0A1zBlCSg7u/CnJFGyx21dFxxA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-BBVLG6ixMdC7f3yaYfp76w-1; Mon, 12 Feb 2024 11:59:57 -0500
X-MC-Unique: BBVLG6ixMdC7f3yaYfp76w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-560a5f882c5so4635399a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757196; x=1708361996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj+M9muz5Mq0wRvQVjpVNnfnNXBZ0GExMp5ECK241aI=;
        b=SuAbbbUNkbugXbwzSbuM5gWtXefoOn9VuiV80KQzukKjoz/vJjPCD2TZmyF5IVYUEQ
         s2sVanyZtCp7EDI9aN9vysdDayW9Ki+Nb2N753HaQz3W0oqbcdj239UUTvYyXUhBc86c
         iBERHWzDmA1LFdUIyhIA+51pIRbodw1oNsNwEV8+nSmSTUEBWXdVVkzmnLKviDuIOFWo
         w/ROGUvwDZwcPIXDOCBNlMdOifSAWZ1M1UkORYMcnUXYZRURAtndHp+PFcBeg4jBxdtx
         wi467wBMJYqPGMJvF5+rw0pUWAwkMPK+WiWWgIjWiORb3POmUZ9hAbsCtCQV0rP/42wJ
         AKsw==
X-Forwarded-Encrypted: i=1; AJvYcCUJo8vMqUxnrngqTpUFwl3jAXERX6T7XCS9WA8v/6tqab9hDXopS7aTvGT3Lsde1MAlDqpf+bxwQxrXFN/48czj6MlfRcOZpNjU+QnqSg==
X-Gm-Message-State: AOJu0YweHaf7u3ThYsPS2mrvRSBM/SEaNn91Na2omLNcbo4W2lg1S40U
	7xWZCKIaT0FduEhTdn2+zhbaQYXy+mQmXStJstwXgB2R3q4jx6QCZphG2EKyxouT9RZJ2phq3Aq
	9N3IUNfk3/5qAjmdCkfxXaIyBv4qTG1lk9dW8tCVhk7J2oe5vghjYroHC5hYrpw==
X-Received: by 2002:a05:6402:643:b0:561:a278:db1d with SMTP id u3-20020a056402064300b00561a278db1dmr67925edx.6.1707757196581;
        Mon, 12 Feb 2024 08:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtqgz4uDExeajTYum89SlbgYY0K3Z01N1uVXi9SYRLiSvtRtku9Z+tCv2eTqpRFWJ/gbf9fg==
X-Received: by 2002:a05:6402:643:b0:561:a278:db1d with SMTP id u3-20020a056402064300b00561a278db1dmr67909edx.6.1707757196375;
        Mon, 12 Feb 2024 08:59:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXd8xaYpRWEUrz+josrTDL3E9m0a+PSI6wgXDuVhsf3ik78yVwT2Ddbg3N5a663Pq2+tpp6LpEMQlBz08yajX0H7kOwxBeuZdhVdQPzfxc+WqGEDp4BbZLcDH7J/vo26O5JT9BJQYaQ5GHeJmXRxLSTy9tSrH3cdl3PvAgFyDxa7FiOozrc3PfBWwJFQdz6ZJWpICF6sP79f5bYix07U88Jvt8Gejd0cC7N
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:55 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 06/25] fsverity: pass log_blocksize to end_enable_verity()
Date: Mon, 12 Feb 2024 17:58:03 +0100
Message-Id: <20240212165821.1901300-7-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFS will need to know log_blocksize to remove the tree in case of an
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
index 66e2270b0dae..84e9b1480241 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -621,6 +621,7 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * @desc:              verity descriptor to write out (NULL in error conditions)
  * @desc_size:         size of the verity descriptor (variable with signatures)
  * @merkle_tree_size:  size of the merkle tree in bytes
+ * @tree_blocksize:    size of the Merkle tree block
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
index 1eb7eae580be..ab7b0772899b 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -51,6 +51,7 @@ struct fsverity_operations {
 	 * @desc: the verity descriptor to write, or NULL on failure
 	 * @desc_size: size of verity descriptor, or 0 on failure
 	 * @merkle_tree_size: total bytes the Merkle tree took up
+	 * @tree_blocksize: size of the Merkle tree block
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


