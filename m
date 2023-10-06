Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A317BBF1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjJFSxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJFSxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614EDB
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nu0z1c/0eDrJgBAtNTkFM1hnZGQ4PO6Tjoiby57zXqo=;
        b=bZD126eOAIvAO2y3j8UWB9oqE8g/Nd+doMFA3t19D1gBF0mjEx8jaWM0dnII5fXunw6pc6
        hJ0L10nsUshh0s2oGVUBSkf1dB4sd4J6W91IcfXfvipgyDcDH7LeU7XpiL7mp+tXvfk9ZM
        vVrYTmIAWyHB9uWCOWDwN7Pwh+qADqE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-tyx8lZvEMPqWuIV5hIXw8A-1; Fri, 06 Oct 2023 14:52:26 -0400
X-MC-Unique: tyx8lZvEMPqWuIV5hIXw8A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso195392566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618345; x=1697223145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nu0z1c/0eDrJgBAtNTkFM1hnZGQ4PO6Tjoiby57zXqo=;
        b=GQ8q+TkWG/sbNGsYZhyPD5NJVK65gG8Et8HTJf8cgIY1Bywo9zhpE/DdAnsL9Qoq9C
         qMWJiyT39DNfTzBaXrNoE4/SvJo0ig+S46h5RKklMxchgi5ZLSjgxeV9Ssc34L3KHdOd
         XqbpObFXs7Q4RKB/rlrzwFOf7RkVneloyZ4WQbtwqWk19nMAVr5GAiclovlRe+M9lrYp
         MiAvyzV6nKYoyOl7hj0p4XibDZyLUyUnXY9YGrPUMoHlN6Kry8oXYXpvQLpHkNcGYLBX
         E0sRyrOQb9G7k6IZiRUkAfTLh28scQTopPU6beDZhrwWrrAcMlRwQ71ZP2yHJyS5NvXb
         5zAg==
X-Gm-Message-State: AOJu0YwMMU8UZCr6S8DgNevLTxJAF9JbsjwAumo48t34hmrgVfEzNjo8
        948vgljOZhyi3mj5ffHbx0Hug1CwLhMUM/cOEV3eXA761lnueIM8qPe3lRp1zRuPcS9v+wqc1Ca
        srxjvLMDTMHKrSS/yV1RBb2rrl+P+4MQz
X-Received: by 2002:a17:907:763b:b0:9b6:582e:be5e with SMTP id jy27-20020a170907763b00b009b6582ebe5emr8346625ejc.60.1696618345070;
        Fri, 06 Oct 2023 11:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENatGxYpE7Tp1bpesC4eUgkJNnUC/i6HuVX71rQKaEwcb3B5NgFaf4ClmswaYc3r8y8XAfKA==
X-Received: by 2002:a17:907:763b:b0:9b6:582e:be5e with SMTP id jy27-20020a170907763b00b009b6582ebe5emr8346617ejc.60.1696618344867;
        Fri, 06 Oct 2023 11:52:24 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:24 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 07/28] fsverity: always use bitmap to track verified status
Date:   Fri,  6 Oct 2023 20:49:01 +0200
Message-Id: <20231006184922.252188-8-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The bitmap is used to track verified status of the Merkle tree
blocks which are smaller than a PAGE. Blocks which fits exactly in a
page - use PageChecked() for tracking "verified" status.

This patch switches to always use bitmap to track verified status.
This is needed to move fs-verity away from page management and work
only with Merkle tree blocks.

Also, this patch removes spinlock. The lock was used to reset bits
in bitmap belonging to one page. This patch works only with one
Merkle tree block and won't reset other blocks status.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/verity/fsverity_private.h |  1 -
 fs/verity/open.c             | 49 ++++++++++++-------------
 fs/verity/verify.c           | 71 +++++-------------------------------
 3 files changed, 33 insertions(+), 88 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index d071a6e32581..9611eeae3527 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -69,7 +69,6 @@ struct fsverity_info {
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
 	const struct inode *inode;
 	unsigned long *hash_block_verified;
-	spinlock_t hash_page_init_lock;
 };
 
 #define FS_VERITY_MAX_SIGNATURE_SIZE	(FS_VERITY_MAX_DESCRIPTOR_SIZE - \
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 6c31a871b84b..dfb9fe6aaae9 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -182,6 +182,7 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 {
 	struct fsverity_info *vi;
 	int err;
+	unsigned long num_bits;
 
 	vi = kmem_cache_zalloc(fsverity_info_cachep, GFP_KERNEL);
 	if (!vi)
@@ -213,33 +214,29 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 	if (err)
 		goto fail;
 
-	if (vi->tree_params.block_size != PAGE_SIZE) {
-		/*
-		 * When the Merkle tree block size and page size differ, we use
-		 * a bitmap to keep track of which hash blocks have been
-		 * verified.  This bitmap must contain one bit per hash block,
-		 * including alignment to a page boundary at the end.
-		 *
-		 * Eventually, to support extremely large files in an efficient
-		 * way, it might be necessary to make pages of this bitmap
-		 * reclaimable.  But for now, simply allocating the whole bitmap
-		 * is a simple solution that works well on the files on which
-		 * fsverity is realistically used.  E.g., with SHA-256 and 4K
-		 * blocks, a 100MB file only needs a 24-byte bitmap, and the
-		 * bitmap for any file under 17GB fits in a 4K page.
-		 */
-		unsigned long num_bits =
-			vi->tree_params.tree_pages <<
-			vi->tree_params.log_blocks_per_page;
+	/*
+	 * We use a bitmap to keep track of which hash blocks have been
+	 * verified.  This bitmap must contain one bit per hash block,
+	 * including alignment to a page boundary at the end.
+	 *
+	 * Eventually, to support extremely large files in an efficient
+	 * way, it might be necessary to make pages of this bitmap
+	 * reclaimable.  But for now, simply allocating the whole bitmap
+	 * is a simple solution that works well on the files on which
+	 * fsverity is realistically used.  E.g., with SHA-256 and 4K
+	 * blocks, a 100MB file only needs a 24-byte bitmap, and the
+	 * bitmap for any file under 17GB fits in a 4K page.
+	 */
+	num_bits =
+		vi->tree_params.tree_pages <<
+		vi->tree_params.log_blocks_per_page;
 
-		vi->hash_block_verified = kvcalloc(BITS_TO_LONGS(num_bits),
-						   sizeof(unsigned long),
-						   GFP_KERNEL);
-		if (!vi->hash_block_verified) {
-			err = -ENOMEM;
-			goto fail;
-		}
-		spin_lock_init(&vi->hash_page_init_lock);
+	vi->hash_block_verified = kvcalloc(BITS_TO_LONGS(num_bits),
+					   sizeof(unsigned long),
+					   GFP_KERNEL);
+	if (!vi->hash_block_verified) {
+		err = -ENOMEM;
+		goto fail;
 	}
 
 	return vi;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 2fe7bd57b16e..e7b13d143ae9 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -13,69 +13,18 @@
 static struct workqueue_struct *fsverity_read_workqueue;
 
 /*
- * Returns true if the hash block with index @hblock_idx in the tree, located in
- * @hpage, has already been verified.
+ * Returns true if the hash block with index @hblock_idx in the tree has
+ * already been verified.
  */
-static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
-				   unsigned long hblock_idx)
+static bool is_hash_block_verified(struct fsverity_info *vi,
+				   unsigned long hblock_idx,
+				   bool block_cached)
 {
-	bool verified;
-	unsigned int blocks_per_page;
-	unsigned int i;
-
-	/*
-	 * When the Merkle tree block size and page size are the same, then the
-	 * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
-	 * to directly indicate whether the page's block has been verified.
-	 *
-	 * Using PG_checked also guarantees that we re-verify hash pages that
-	 * get evicted and re-instantiated from the backing storage, as new
-	 * pages always start out with PG_checked cleared.
-	 */
-	if (!vi->hash_block_verified)
-		return PageChecked(hpage);
-
-	/*
-	 * When the Merkle tree block size and page size differ, we use a bitmap
-	 * to indicate whether each hash block has been verified.
-	 *
-	 * However, we still need to ensure that hash pages that get evicted and
-	 * re-instantiated from the backing storage are re-verified.  To do
-	 * this, we use PG_checked again, but now it doesn't really mean
-	 * "checked".  Instead, now it just serves as an indicator for whether
-	 * the hash page is newly instantiated or not.
-	 *
-	 * The first thread that sees PG_checked=0 must clear the corresponding
-	 * bitmap bits, then set PG_checked=1.  This requires a spinlock.  To
-	 * avoid having to take this spinlock in the common case of
-	 * PG_checked=1, we start with an opportunistic lockless read.
-	 */
-	if (PageChecked(hpage)) {
-		/*
-		 * A read memory barrier is needed here to give ACQUIRE
-		 * semantics to the above PageChecked() test.
-		 */
-		smp_rmb();
+	if (block_cached)
 		return test_bit(hblock_idx, vi->hash_block_verified);
-	}
-	spin_lock(&vi->hash_page_init_lock);
-	if (PageChecked(hpage)) {
-		verified = test_bit(hblock_idx, vi->hash_block_verified);
-	} else {
-		blocks_per_page = vi->tree_params.blocks_per_page;
-		hblock_idx = round_down(hblock_idx, blocks_per_page);
-		for (i = 0; i < blocks_per_page; i++)
-			clear_bit(hblock_idx + i, vi->hash_block_verified);
-		/*
-		 * A write memory barrier is needed here to give RELEASE
-		 * semantics to the below SetPageChecked() operation.
-		 */
-		smp_wmb();
-		SetPageChecked(hpage);
-		verified = false;
-	}
-	spin_unlock(&vi->hash_page_init_lock);
-	return verified;
+
+	clear_bit(hblock_idx, vi->hash_block_verified);
+	return false;
 }
 
 /*
@@ -179,7 +128,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			goto error;
 		}
 		haddr = kmap_local_page(hpage) + hblock_offset_in_page;
-		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
+		if (is_hash_block_verified(vi, hblock_idx, PageChecked(hpage))) {
 			memcpy(_want_hash, haddr + hoffset, hsize);
 			want_hash = _want_hash;
 			kunmap_local(haddr);
-- 
2.40.1

