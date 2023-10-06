Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5347BBF1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjJFSx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJFSx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDDEB
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7XPmH44P+ap8pothWdhiZlYSUyho8+XNKckKHFJIOg=;
        b=A2jXL6r9vavJ37mVc+uxSk0348PziDIzO9QmTNYSzHPTB9bYM9UEPCjDNxFiD7pAdQ1yi/
        R6t0bJZ8lyKoskE7ozsv5zF+S66Bhz/XOtTfKeQb/ja/HEXpfBBPqC7KYg55hNCQoxDns2
        8Q55OqNN8s25vegVvAyFLHgruUDsCUk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Z6y9Td8_OfOsRAA_fqLH2g-1; Fri, 06 Oct 2023 14:52:28 -0400
X-MC-Unique: Z6y9Td8_OfOsRAA_fqLH2g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9adad8f306fso197836666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618347; x=1697223147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7XPmH44P+ap8pothWdhiZlYSUyho8+XNKckKHFJIOg=;
        b=QytnEfDPaVSFkBZsYq9NH/RB5hjyP3n6g7X3adAqjkyDah/QQvhO+MeUkJ5ocRepZg
         7KfxsAjNIi1rO930CzXBDbIrBuEO/75dqGpxyjy/bOeKoENGJvQ6OuUJxv1SmWRH4s1X
         umtNaAeO2jl+PJP7ZJirFRadj5Z51bgFvSZrzbUFvY+cFEZa9nwYnJqPdSP3sXSFXJvv
         u2tL+NyrfSoLp9fgRaLCLZuJGieImHNg73eRsd7d6w+bwlH12GS+1ejiOvco4tD4m0b3
         iY3dVQyUC7kzO6FUCXHpa3UPH8PYKGNtB9Hf1jSapp5oYQRCUbeFa0e22GpGPz/KBNgq
         OQcQ==
X-Gm-Message-State: AOJu0YzS/PM3NTsDZpeuFgJuDN8gnJN12fcEPb1fjZdAB1yuunM8IkdQ
        teGJAxA+AVM7iwWwwGOWJo0W7JoXw7+WNzaiVyPpkZk6l2GUHUb4Xc2aW5KUzKPvBG255seaudo
        srAlr1uyWxoewQbV63oIn3yUpRLbTmOZq
X-Received: by 2002:a17:906:9c1:b0:9ae:5aa4:9fa with SMTP id r1-20020a17090609c100b009ae5aa409famr8090440eje.42.1696618347060;
        Fri, 06 Oct 2023 11:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUhTkv6Y3ms1dW1sNfvoG2u1LCutOMUQtjoa3WTTMfsWftHZEKYPqcdq3cLzDayMSeNmLAOA==
X-Received: by 2002:a17:906:9c1:b0:9ae:5aa4:9fa with SMTP id r1-20020a17090609c100b009ae5aa409famr8090433eje.42.1696618346871;
        Fri, 06 Oct 2023 11:52:26 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:26 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 09/28] fsverity: pass log_blocksize to end_enable_verity()
Date:   Fri,  6 Oct 2023 20:49:03 +0200
Message-Id: <20231006184922.252188-10-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index b39199b57a69..2b34796f68d3 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -621,6 +621,7 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * @desc:              verity descriptor to write out (NULL in error conditions)
  * @desc_size:         size of the verity descriptor (variable with signatures)
  * @merkle_tree_size:  size of the merkle tree in bytes
+ * @log_blocksize:     log size of the Merkle tree block
  *
  * If desc is null, then VFS is signaling an error occurred during verity
  * enable, and we should try to rollback. Otherwise, attempt to finish verity.
@@ -628,7 +629,8 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * Returns 0 on success, negative error code on error.
  */
 static int btrfs_end_enable_verity(struct file *filp, const void *desc,
-				   size_t desc_size, u64 merkle_tree_size)
+				   size_t desc_size, u64 merkle_tree_size,
+				   u8 log_blocksize)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(filp));
 	int ret = 0;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 4eb77cefdbe1..4e2f01f048c0 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -189,7 +189,8 @@ static int ext4_write_verity_descriptor(struct inode *inode, const void *desc,
 }
 
 static int ext4_end_enable_verity(struct file *filp, const void *desc,
-				  size_t desc_size, u64 merkle_tree_size)
+				  size_t desc_size, u64 merkle_tree_size,
+				  u8 log_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	const int credits = 2; /* superblock and inode for ext4_orphan_del() */
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index bb354ab8ca5a..601ab9f0c024 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -144,7 +144,8 @@ static int f2fs_begin_enable_verity(struct file *filp)
 }
 
 static int f2fs_end_enable_verity(struct file *filp, const void *desc,
-				  size_t desc_size, u64 merkle_tree_size)
+				  size_t desc_size, u64 merkle_tree_size,
+				  u8 log_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..c87cab796f0b 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -274,7 +274,8 @@ static int enable_verity(struct file *filp,
 	 * Serialized with ->begin_enable_verity() by the inode lock.
 	 */
 	inode_lock(inode);
-	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
+	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size,
+				      desc->log_blocksize);
 	inode_unlock(inode);
 	if (err) {
 		fsverity_err(inode, "%ps() failed with err %d",
@@ -300,7 +301,8 @@ static int enable_verity(struct file *filp,
 
 rollback:
 	inode_lock(inode);
-	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size);
+	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size,
+				      desc->log_blocksize);
 	inode_unlock(inode);
 	goto out;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 252b2668894c..cac012d4c86a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -51,6 +51,7 @@ struct fsverity_operations {
 	 * @desc: the verity descriptor to write, or NULL on failure
 	 * @desc_size: size of verity descriptor, or 0 on failure
 	 * @merkle_tree_size: total bytes the Merkle tree took up
+	 * @log_blocksize: log size of the Merkle tree block
 	 *
 	 * If desc == NULL, then enabling verity failed and the filesystem only
 	 * must do any necessary cleanups.  Else, it must also store the given
@@ -65,7 +66,8 @@ struct fsverity_operations {
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*end_enable_verity)(struct file *filp, const void *desc,
-				 size_t desc_size, u64 merkle_tree_size);
+				 size_t desc_size, u64 merkle_tree_size,
+				 u8 log_blocksize);
 
 	/**
 	 * Get the verity descriptor of the given inode.
-- 
2.40.1

