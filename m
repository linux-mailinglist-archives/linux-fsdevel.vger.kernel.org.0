Return-Path: <linux-fsdevel+bounces-4647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CF8016AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8434B203A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D83F8CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sJUIBPvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119C10D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:34 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5d3758fdd2eso23683507b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468753; x=1702073553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2vJCSnextTkAMfB2fn+h0ylMQ7BXrKiMJBW4HR8n7Q=;
        b=sJUIBPvGF9C4zCaiW1YDSiCmXchY9n5KCqG3BewvF8Z4VRcOSLzMNwri7X4BmAHPUF
         8GLPtIjU/P9UA138fVsbjBwZ21+EefJTC+RRaJoTuGK80B6oxawu7+WBRPo/81mbxp6O
         HQVi+ZkMAsl8o5Af0LDGUVqTa5nXHQpuH9ycqhI4DGhrBzGc9hnpWu+Oz9cTwhgLwNOu
         2K643AMHLrP+c4BgYPYm4yN3YPYzZGTk9p7ZMWmTWxI5oYA3QHlzmRVe6NF3dz6We2uy
         84bZFxUeJI7fe+dxSFq8nEiuH7I2l9NubNnhdPIDnncff9RicnilxhmvIjYiXKEXLGJ0
         3RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468753; x=1702073553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2vJCSnextTkAMfB2fn+h0ylMQ7BXrKiMJBW4HR8n7Q=;
        b=gdBgLFK/ol21uPH9xDt4PEVrFLIMU/tTqf5Q6DzHz4NSlIkhUTeGv6a1AfemxB2crn
         r3ykFPADyVEfMGl4vGliu9c7wDRovGWVxI1WUxH91f1Gr62mC9EjXd1g+XqlCL5yYzln
         28NsohRtJERWuJ7LQPyFsXhQTAjxgw891OtxdLIdXbjGGl/fONDwonakrL7KFNBScCDi
         QUdIhVvrWJTxmHHEAjgRryYpgg0IVCqo53vBNaC1gZr3m7NN397Bt8aHUQI9piJpeNnM
         Msy//WEguC1VikTgWkCnfCg1+WEyXXwtzZzFiM78blvidcG7XAhmKzCvvhjtEkXNyh4p
         rhig==
X-Gm-Message-State: AOJu0YyOaUjSntg2VrW+BaRi91ctXsheU2w86TCO2kWNCKwvQ1/IhYry
	aQjfcTybv9qOkZXwA1y23mDEmw==
X-Google-Smtp-Source: AGHT+IErvnh7DqYWygk5iM6eO/eA+iBXRY6VkL6b8Nxhb5ymZYwcUOkysn34g4vJgmukhdjr0d4hSQ==
X-Received: by 2002:a05:690c:f93:b0:5d1:b53e:e6d3 with SMTP id df19-20020a05690c0f9300b005d1b53ee6d3mr383211ywb.45.1701468753599;
        Fri, 01 Dec 2023 14:12:33 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c68-20020a0dc147000000b005d6f34893dfsm247563ywd.135.2023.12.01.14.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 28/46] btrfs: explicitly track file extent length for replace and drop
Date: Fri,  1 Dec 2023 17:11:25 -0500
Message-ID: <026b3752d912cf7da484c43c3dace5f4ed0419ed.1701468306.git.josef@toxicpanda.com>
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

With the advent of storing fscrypt contexts with each encrypted extent,
extents will have a variable length depending on encryption status.
Make sure the replace and drop file extent item helpers encode this
information so that everything gets updated properly.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h    | 2 ++
 fs/btrfs/file.c     | 4 ++--
 fs/btrfs/inode.c    | 7 +++++--
 fs/btrfs/reflink.c  | 1 +
 fs/btrfs/tree-log.c | 5 +++--
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 54fd4eb92745..ba73171fb8b0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -367,6 +367,8 @@ struct btrfs_replace_extent_info {
 	u64 file_offset;
 	/* Pointer to a file extent item of type regular or prealloc. */
 	char *extent_buf;
+	/* The length of @extent_buf */
+	u32 extent_buf_size;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b4a503731e79..87d07d7985ec 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2262,14 +2262,14 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = extent_info->file_offset;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
-				      sizeof(struct btrfs_file_extent_item));
+				      extent_info->extent_buf_size);
 	if (ret)
 		return ret;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	write_extent_buffer(leaf, extent_info->extent_buf,
 			    btrfs_item_ptr_offset(leaf, slot),
-			    sizeof(struct btrfs_file_extent_item));
+			    extent_info->extent_buf_size);
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	ASSERT(btrfs_file_extent_type(leaf, extent) != BTRFS_FILE_EXTENT_INLINE);
 	btrfs_set_file_extent_offset(leaf, extent, extent_info->data_offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbdc01f25215..150ec68783c3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2913,6 +2913,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
+	size_t fscrypt_context_size = 0;
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -2932,7 +2933,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	drop_args.start = file_pos;
 	drop_args.end = file_pos + num_bytes;
 	drop_args.replace_extent = true;
-	drop_args.extent_item_size = sizeof(*stack_fi);
+	drop_args.extent_item_size = sizeof(*stack_fi) + fscrypt_context_size;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
@@ -2943,7 +2944,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
-					      sizeof(*stack_fi));
+					      sizeof(*stack_fi) + fscrypt_context_size);
 		if (ret)
 			goto out;
 	}
@@ -9717,6 +9718,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	u64 len = ins->offset;
 	int qgroup_released;
 	int ret;
+	size_t fscrypt_context_size = 0;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 
@@ -9749,6 +9751,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.data_len = len;
 	extent_info.file_offset = file_offset;
 	extent_info.extent_buf = (char *)&stack_fi;
+	extent_info.extent_buf_size = sizeof(stack_fi) + fscrypt_context_size;
 	extent_info.is_new_extent = true;
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c39de2a43a00..d01499d8bcf0 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -500,6 +500,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.data_len = datal;
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
+			clone_info.extent_buf_size = size;
 			clone_info.is_new_extent = false;
 			clone_info.update_times = !no_time_update;
 			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 36063dc39443..580974153649 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4627,6 +4627,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	size_t fscrypt_context_size = 0;
 	u8 encryption = BTRFS_ENCRYPTION_NONE;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
@@ -4669,7 +4670,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		drop_args.start = em->start;
 		drop_args.end = em->start + em->len;
 		drop_args.replace_extent = true;
-		drop_args.extent_item_size = sizeof(fi);
+		drop_args.extent_item_size = sizeof(fi) + fscrypt_context_size;
 		ret = btrfs_drop_extents(trans, log, inode, &drop_args);
 		if (ret)
 			return ret;
@@ -4681,7 +4682,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		key.offset = em->start;
 
 		ret = btrfs_insert_empty_item(trans, log, path, &key,
-					      sizeof(fi));
+					      sizeof(fi) + fscrypt_context_size);
 		if (ret)
 			return ret;
 	}
-- 
2.41.0


