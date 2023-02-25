Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E56A262A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBYBQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBYBQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:04 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BA125AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id e21so828311oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTAo84ZIoMyDtrXC/1nqUKH+RkTcJSj7ZK53l7rSU7g=;
        b=24eKXTtqMucgXfw284B57M7L4b8IL6FVx0tB5GQM7H/K/deavsFeAQ4Iu8Pugvsipk
         HiGc0JCPgC3Ynoc8MEnYnro6j2XZNZNzy/R/fJyxpOR0+Iav0KyXgYV1uUp2hL/dhA2a
         0OLAKQZVfpbJouqmG/3ReeL6ZoNzA/Pz3jHuca/YvxVVx+qhVQC68D7eYzbmrYdH9GrL
         RCbLcNcWyscz1sbsDjE7E0/tzClF7KHvvaar06WHjbnvqSlrwNzRdYOqAxfCprXZ+kDK
         RC7RZx3Kgz0Cii5URLrOKnu/z9VtQZFWWf1bAUQ0BjmbFbKWo0rseZz3n46NThgcVVfL
         dSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTAo84ZIoMyDtrXC/1nqUKH+RkTcJSj7ZK53l7rSU7g=;
        b=pc8fMdYEq3WFtFkp9cgfjpUWoRSkEVuChRtblGX7CJk25OJe/nR314c69uaNEsw3Db
         FbHKoVSHsPIdAFa7nPGVYAQVjfY9mH/lh+6lYIqJNvDYmiwLwM4HjNoCPof8sD06fzew
         OHCDeCP9iJGmgLywX0nXLCgt5WU15yVjbjxg9xXt4FlGXbz5vVmb8kR4zjpIXjGoq/1J
         DEQhFenjZgwYtkbcSVqxVdl9aZJbUQj3t6iVMpY3pi3w3Acik3fxohTltis6zMyzsB3F
         bXxbOn2nzx6DhpL8weM3+RkKxz8tOvoQW0433OWw3/kIfaTY321Ulnj/rEk/LlIyos8U
         3oWw==
X-Gm-Message-State: AO0yUKUMuN4+gbna50WxoErXjNGYwe1RoMNzEUPCbszICqvKz7+SJ6JO
        FsIJLJICjPv1etv2jdwAyS9l6MT7qnaeZM8A
X-Google-Smtp-Source: AK7set/2lnwsMF4NCoa8bNxbdx260IZ+9yUpVuZ0FpOXcBnqzdmoxlcTJ9z0QK+loVoTldfEKFiEdw==
X-Received: by 2002:aca:1206:0:b0:383:fc9b:fb4f with SMTP id 6-20020aca1206000000b00383fc9bfb4fmr1786911ois.53.1677287759862;
        Fri, 24 Feb 2023 17:15:59 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:58 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 12/76] ssdfs: block bitmap modification operations implementation
Date:   Fri, 24 Feb 2023 17:08:23 -0800
Message-Id: <20230225010927.813929-13-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements block bitmap's modification operations:
pre_allocate - pre_allocate logical block or range of blocks
allocate - allocate logical block or range of blocks
invalidate - invalidate logical block or range of blocks
collect_garbage - get contigous range of blocks in state
clean - convert the whole block bitmap into clean state

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/block_bitmap.c | 703 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 703 insertions(+)

diff --git a/fs/ssdfs/block_bitmap.c b/fs/ssdfs/block_bitmap.c
index 3e3ddb6ff745..258d3b3856e1 100644
--- a/fs/ssdfs/block_bitmap.c
+++ b/fs/ssdfs/block_bitmap.c
@@ -4608,3 +4608,706 @@ int ssdfs_block_bmap_get_invalid_pages(struct ssdfs_block_bmap *blk_bmap)
 
 	return blk_bmap->invalid_blks;
 }
+
+/*
+ * ssdfs_block_bmap_pre_allocate() - pre-allocate segment's range of blocks
+ * @blk_bmap: pointer on block bitmap
+ * @start: starting block for search
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to find contiguous range of free blocks and
+ * to set the found range in pre-allocated state.
+ *
+ * If pointer @len is NULL then it needs:
+ * (1) check that requested range contains free blocks only;
+ * (2) set the requested range of blocks in pre-allocated state.
+ *
+ * Otherwise, if pointer @len != NULL then it needs:
+ * (1) find the range of free blocks of requested length or lesser;
+ * (2) set the found range of blocks in pre-allocated state.
+ *
+ * RETURN:
+ * [success] - @range of pre-allocated blocks.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ * %-ENOSPC     - block bitmap hasn't free blocks.
+ */
+int ssdfs_block_bmap_pre_allocate(struct ssdfs_block_bmap *blk_bmap,
+				  u32 start, u32 *len,
+				  struct ssdfs_block_bmap_range *range)
+{
+	int free_pages;
+	u32 used_blks = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("start %u, len %p\n",
+		  start, len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (len) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("blk_bmap %p, start %u, len %u\n",
+			  blk_bmap, start, *len);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("blk_bmap %p, range (start %u, len %u)\n",
+			  blk_bmap, range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (range_corrupted(blk_bmap, range)) {
+			SSDFS_ERR("invalid range: start %u, len %u; "
+				  "items count %zu\n",
+				  range->start, range->len,
+				  blk_bmap->items_count);
+			return -EINVAL;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %zu, used_blks %u, "
+		  "metadata_items %u, invalid_blks %u\n",
+		  blk_bmap->items_count,
+		  blk_bmap->used_blks,
+		  blk_bmap->metadata_items,
+		  blk_bmap->invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get free pages: err %d\n", err);
+		return err;
+	} else {
+		free_pages = err;
+		err = 0;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_pages %d\n", free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (len) {
+		u32 max_blk = blk_bmap->items_count - blk_bmap->metadata_items;
+		u32 start_blk = 0;
+
+		if (free_pages < *len) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to pre_allocate: "
+				  "free_pages %d, count %u\n",
+				  free_pages, *len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		}
+
+		if (!is_cache_invalid(blk_bmap, SSDFS_BLK_FREE)) {
+			err = ssdfs_define_last_free_page(blk_bmap, &start_blk);
+			if (err) {
+				SSDFS_ERR("fail to define start block: "
+					  "err %d\n",
+					  err);
+				return err;
+			}
+		}
+
+		start_blk = max_t(u32, start_blk, start);
+
+		err = ssdfs_block_bmap_find_range(blk_bmap, start_blk, *len,
+						  max_blk,
+						  SSDFS_BLK_FREE, range);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find free blocks: "
+				  "start_blk %u, max_blk %u, len %u\n",
+				  start_blk, max_blk, *len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		} else if (err) {
+			SSDFS_ERR("fail to find free blocks: err %d\n", err);
+			return err;
+		}
+	} else {
+		if (free_pages < range->len) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to pre_allocate: "
+				  "free_pages %d, count %u\n",
+				  free_pages, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		}
+
+		if (!is_range_free(blk_bmap, range)) {
+			SSDFS_ERR("range (start %u, len %u) is not free\n",
+				  range->start, range->len);
+			return -EINVAL;
+		}
+	}
+
+	used_blks = (u32)blk_bmap->used_blks + range->len;
+
+	if (used_blks > blk_bmap->items_count) {
+		SSDFS_ERR("invalid used blocks count: "
+			  "used_blks %u, items_count %zu\n",
+			  used_blks,
+			  blk_bmap->items_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_block_bmap_set_range(blk_bmap, range,
+					 SSDFS_BLK_PRE_ALLOCATED);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set range (start %u, len %u): err %d\n",
+			  range->start, range->len, err);
+		return err;
+	}
+
+	blk_bmap->used_blks += range->len;
+
+	set_block_bmap_dirty(blk_bmap);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("range (start %u, len %u) has been pre-allocated\n",
+		  range->start, range->len);
+#else
+	SSDFS_DBG("range (start %u, len %u) has been pre-allocated\n",
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_allocate() - allocate segment's range of blocks
+ * @blk_bmap: pointer on block bitmap
+ * @start: starting block for search
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to find contiguous range of free
+ * (or pre-allocated) blocks and to set the found range in
+ * valid state.
+ *
+ * If pointer @len is NULL then it needs:
+ * (1) check that requested range contains free or pre-allocated blocks;
+ * (2) set the requested range of blocks in valid state.
+ *
+ * Otherwise, if pointer @len != NULL then it needs:
+ * (1) find the range of free blocks of requested length or lesser;
+ * (2) set the found range of blocks in valid state.
+ *
+ * RETURN:
+ * [success] - @range of valid blocks.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ * %-ENOSPC     - block bitmap hasn't free blocks.
+ */
+int ssdfs_block_bmap_allocate(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 *len,
+				struct ssdfs_block_bmap_range *range)
+{
+	int state = SSDFS_BLK_FREE;
+	int free_pages;
+	u32 used_blks = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("start %u, len %p\n",
+		  start, len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (len) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("blk_bmap %p, start %u, len %u\n",
+			  blk_bmap, start, *len);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("blk_bmap %p, range (start %u, len %u)\n",
+			  blk_bmap, range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (range_corrupted(blk_bmap, range)) {
+			SSDFS_ERR("invalid range: start %u, len %u; "
+				  "items count %zu\n",
+				  range->start, range->len,
+				  blk_bmap->items_count);
+			return -EINVAL;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %zu, used_blks %u, "
+		  "metadata_items %u\n",
+		  blk_bmap->items_count,
+		  blk_bmap->used_blks,
+		  blk_bmap->metadata_items);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get free pages: err %d\n", err);
+		return err;
+	} else {
+		free_pages = err;
+		err = 0;
+	}
+
+	if (len) {
+		u32 max_blk = blk_bmap->items_count - blk_bmap->metadata_items;
+		u32 start_blk = 0;
+
+		if (free_pages < *len) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to allocate: "
+				  "free_pages %d, count %u\n",
+				  free_pages, *len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		}
+
+		if (!is_cache_invalid(blk_bmap, SSDFS_BLK_FREE)) {
+			err = ssdfs_define_last_free_page(blk_bmap, &start_blk);
+			if (err) {
+				SSDFS_ERR("fail to define start block: "
+					  "err %d\n",
+					  err);
+				return err;
+			}
+		}
+
+		start_blk = max_t(u32, start_blk, start);
+
+		err = ssdfs_block_bmap_find_range(blk_bmap, start_blk, *len,
+						  max_blk, SSDFS_BLK_FREE,
+						  range);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find free blocks: "
+				  "start_blk %u, max_blk %u, len %u\n",
+				  start_blk, max_blk, *len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		} else if (err) {
+			SSDFS_ERR("fail to find free blocks: err %d\n", err);
+			return err;
+		}
+	} else {
+		state = ssdfs_get_range_state(blk_bmap, range);
+
+		if (state < 0) {
+			SSDFS_ERR("fail to get range "
+				  "(start %u, len %u) state: err %d\n",
+				  range->start, range->len, state);
+			return state;
+		}
+
+		if (state != SSDFS_BLK_FREE &&
+		    state != SSDFS_BLK_PRE_ALLOCATED) {
+			SSDFS_ERR("range (start %u, len %u), state %#x, "
+				  "can't be allocated\n",
+				  range->start, range->len, state);
+			return -EINVAL;
+		}
+	}
+
+	err = ssdfs_block_bmap_set_range(blk_bmap, range,
+					 SSDFS_BLK_VALID);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set range (start %u, len %u): "
+			  "err %d\n",
+			  range->start, range->len, err);
+		return err;
+	}
+
+	if (state == SSDFS_BLK_FREE) {
+		used_blks = (u32)blk_bmap->used_blks + range->len;
+
+		if (used_blks > blk_bmap->items_count) {
+			SSDFS_ERR("invalid used blocks count: "
+				  "used_blks %u, items_count %zu\n",
+				  used_blks,
+				  blk_bmap->items_count);
+			return -ERANGE;
+		}
+
+		blk_bmap->used_blks += range->len;
+	}
+
+	set_block_bmap_dirty(blk_bmap);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("range (start %u, len %u) has been allocated\n",
+		  range->start, range->len);
+#else
+	SSDFS_DBG("range (start %u, len %u) has been allocated\n",
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_invalidate() - invalidate segment's range of blocks
+ * @blk_bmap: pointer on block bitmap
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to set the requested range of blocks in
+ * invalid state. At first, it checks that requested range contains
+ * valid blocks only. And, then, it sets the requested range of blocks
+ * in invalid state.
+ *
+ * RETURN:
+ * [success] - @range of invalid blocks.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_block_bmap_invalidate(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u)\n",
+		  blk_bmap, range->start, range->len);
+	SSDFS_DBG("items_count %zu, used_blks %u, "
+		  "metadata_items %u, invalid_blks %u\n",
+		  blk_bmap->items_count,
+		  blk_bmap->used_blks,
+		  blk_bmap->metadata_items,
+		  blk_bmap->invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("range (start %u, len %u)\n",
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	ssdfs_debug_block_bitmap(blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len, blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	if (!is_range_valid(blk_bmap, range) &&
+	    !is_range_pre_allocated(blk_bmap, range)) {
+		SSDFS_ERR("range (start %u, len %u) contains not valid blocks\n",
+			  range->start, range->len);
+		return -EINVAL;
+	}
+
+	err = ssdfs_block_bmap_set_range(blk_bmap, range,
+					 SSDFS_BLK_INVALID);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set range (start %u, len %u): err %d\n",
+			  range->start, range->len, err);
+		return err;
+	}
+
+	blk_bmap->invalid_blks += range->len;
+
+	if (range->len > blk_bmap->used_blks) {
+		SSDFS_ERR("invalid range len: "
+			  "range_len %u, used_blks %u, items_count %zu\n",
+			  range->len,
+			  blk_bmap->used_blks,
+			  blk_bmap->items_count);
+		return -ERANGE;
+	} else
+		blk_bmap->used_blks -= range->len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %zu, used_blks %u, "
+		  "metadata_items %u, invalid_blks %u\n",
+		  blk_bmap->items_count,
+		  blk_bmap->used_blks,
+		  blk_bmap->metadata_items,
+		  blk_bmap->invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	set_block_bmap_dirty(blk_bmap);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	ssdfs_debug_block_bitmap(blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("range (start %u, len %u) has been invalidated\n",
+		  range->start, range->len);
+#else
+	SSDFS_DBG("range (start %u, len %u) has been invalidated\n",
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_collect_garbage() - find range of valid blocks for GC
+ * @blk_bmap: pointer on block bitmap
+ * @start: starting position for search
+ * @max_len: maximum requested length of valid blocks' range
+ * @blk_state: requested block state (pre-allocated or valid)
+ * @range: pointer on blocks' range [out]
+ *
+ * This function tries to find range of valid blocks for GC.
+ * The length of requested range is limited by @max_len.
+ *
+ * RETURN:
+ * [success] - @range of invalid blocks.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ * %-ENODATA    - requested range hasn't valid blocks.
+ */
+int ssdfs_block_bmap_collect_garbage(struct ssdfs_block_bmap *blk_bmap,
+				     u32 start, u32 max_len,
+				     int blk_state,
+				     struct ssdfs_block_bmap_range *range)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, max_len %u\n",
+		  blk_bmap, start, max_len);
+	SSDFS_DBG("items_count %zu, used_blks %u, "
+		  "metadata_items %u, invalid_blks %u\n",
+		  blk_bmap->items_count,
+		  blk_bmap->used_blks,
+		  blk_bmap->metadata_items,
+		  blk_bmap->invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("start %u, max_len %u, blk_state %#x\n",
+		  start, max_len, blk_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	ssdfs_debug_block_bitmap(blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (blk_state) {
+	case SSDFS_BLK_PRE_ALLOCATED:
+	case SSDFS_BLK_VALID:
+		/* valid block state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid block state: %#x\n",
+			  blk_state);
+		return -EINVAL;
+	};
+
+	err = ssdfs_block_bmap_find_range(blk_bmap, start, max_len, max_len,
+					  blk_state, range);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range (start %u, len %u) hasn't valid blocks\n",
+			  start, max_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (err) {
+		SSDFS_ERR("fail to find valid blocks: err %d\n", err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("range (start %u, len %u) has been collected as garbage\n",
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("range (start %u, len %u) has been collected as garbage\n",
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_clean() - set all blocks as free/clean
+ * @blk_bmap: pointer on block bitmap
+ *
+ * This function tries to clean the whole bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_block_bmap_clean(struct ssdfs_block_bmap *blk_bmap)
+{
+	struct ssdfs_block_bmap_range range;
+	int max_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p\n", blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+	blk_bmap->metadata_items = 0;
+	blk_bmap->used_blks = 0;
+	blk_bmap->invalid_blks = 0;
+
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		blk_bmap->last_search[i].page_index = max_capacity;
+		blk_bmap->last_search[i].offset = U16_MAX;
+		blk_bmap->last_search[i].cache = 0;
+	}
+
+	range.start = 0;
+	range.len = blk_bmap->items_count;
+
+	err = ssdfs_set_range_in_storage(blk_bmap, &range, SSDFS_BLK_FREE);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clean block bmap: "
+			  "range (start %u, len %u), "
+			  "err %d\n",
+			  range.start, range.len, err);
+		return err;
+	}
+
+	err = ssdfs_cache_block_state(blk_bmap, 0, SSDFS_BLK_FREE);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to cache last free page: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_SSDFS_DEBUG
+static
+void ssdfs_debug_block_bitmap(struct ssdfs_block_bmap *bmap)
+{
+	struct ssdfs_page_vector *array;
+	struct page *page;
+	void *kaddr;
+	int i;
+
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("BLOCK BITMAP: bytes_count %zu, items_count %zu, "
+		  "metadata_items %u, used_blks %u, invalid_blks %u, "
+		  "flags %#x\n",
+		  bmap->bytes_count,
+		  bmap->items_count,
+		  bmap->metadata_items,
+		  bmap->used_blks,
+		  bmap->invalid_blks,
+		  atomic_read(&bmap->flags));
+
+	SSDFS_DBG("LAST SEARCH:\n");
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		SSDFS_DBG("TYPE %d: page_index %d, offset %u, cache %lx\n",
+			  i,
+			  bmap->last_search[i].page_index,
+			  bmap->last_search[i].offset,
+			  bmap->last_search[i].cache);
+	}
+
+	switch (bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		array = &bmap->storage.array;
+
+		for (i = 0; i < ssdfs_page_vector_count(array); i++) {
+			page = array->pages[i];
+
+			if (!page) {
+				SSDFS_WARN("page %d is NULL\n", i);
+				continue;
+			}
+
+			kaddr = kmap_local_page(page);
+			SSDFS_DBG("BMAP CONTENT: page %d\n", i);
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					     kaddr, PAGE_SIZE);
+			kunmap_local(kaddr);
+		}
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		SSDFS_DBG("BMAP CONTENT:\n");
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     bmap->storage.buf,
+				     bmap->bytes_count);
+		break;
+	}
+}
+#endif /* CONFIG_SSDFS_DEBUG */
-- 
2.34.1

