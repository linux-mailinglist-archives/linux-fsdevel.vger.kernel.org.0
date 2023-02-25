Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A89D6A262B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBYBQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBYBQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:04 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAE012BE7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:59 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bm20so798498oib.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1MzfL9njinVXGzkkO+L0kaA19mWqqXlNNrD94cIGqw=;
        b=jV42U2HzsDPEaPk/W/W9zugYvHELWWxUPvFN9yfIGMXISdlAMJhE5//2CRIvmt2Gg9
         rzQQI0sJdLotedWbTfz+SOVJFRIIAQr2+3LA9+45Fau9yuA4D1vUGHpJaHOVMea4NS82
         imlvQOPpFK5qmOhkcE7cbHK2/zg1hh0ITRgJgATnDyEWmI56LGd2HgwjzUpqtHxJnCS7
         T2Hh4pbRk3y7RRFOaPGvOf6aiDW4yhGjcoJDf3U9c0+Sr0CL6M3rHiQXD8ICKvmV+lue
         F5wd3LJ7fLbKZCeaLd5BjULlEHBoTFMY5QZrU0G3468z6QgR2uanlkhoD2LfOtkkbj0C
         qiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1MzfL9njinVXGzkkO+L0kaA19mWqqXlNNrD94cIGqw=;
        b=qsypAloyNobItBm+t97+6dc43QlYwfsXahjwZOQLfX2aPSWwtNTmum4eutf9mxvrl1
         nSkKYmHRYWn2fLbc1obNJjNCe5NIpn+Gw6BCgDI+qOAagCBwbcUoL0AbKBjdQ/ea0AgX
         EiO3Z1Oq3mSEMH+IyNiXOJRDV71kIYLbyb6sekd1Cl2/i2v/OWCsWvMPRqG25Q1JRuID
         ljCVEbdusDISFQfL8lXQ2HkQKVqFKI/pMKYFfWKoFrn41sWt3qz8f8JbarXg/r4/QwMH
         6w/vkKDavDR6FPoo7EnCs8xl8d2Iib3kkobo8X9BC9T4EcFPMJWElT35IjcHm0juYvzj
         WTYQ==
X-Gm-Message-State: AO0yUKUUV2LBf515jb83J6/zdYdyBvIeUd7YKTuaO6wa06X4FLbo8xSs
        VTE1bPwu6AFq/pHTVX4BynwE0jE8hEJgD1BW
X-Google-Smtp-Source: AK7set/tFzIU3eRtOrLWWiyzlFUja+2k1s5Aa1ymIypbx17QdTasSMzYDhSaW7OYMuRLXUYfLAbtHw==
X-Received: by 2002:a05:6808:68f:b0:37e:c9d4:ca3d with SMTP id k15-20020a056808068f00b0037ec9d4ca3dmr4509384oig.27.1677287757836;
        Fri, 24 Feb 2023 17:15:57 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:57 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 11/76] ssdfs: block bitmap search operations implementation
Date:   Fri, 24 Feb 2023 17:08:22 -0800
Message-Id: <20230225010927.813929-12-slava@dubeyko.com>
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

Implement internal block bitmap's search operations for
pre_allocate, allocate, and collect_garbage operations.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/block_bitmap.c | 3401 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 3401 insertions(+)

diff --git a/fs/ssdfs/block_bitmap.c b/fs/ssdfs/block_bitmap.c
index fd7e84258cf0..3e3ddb6ff745 100644
--- a/fs/ssdfs/block_bitmap.c
+++ b/fs/ssdfs/block_bitmap.c
@@ -1207,3 +1207,3404 @@ void ssdfs_block_bmap_forget_snapshot(struct ssdfs_page_vector *snapshot)
 
 	ssdfs_page_vector_release(snapshot);
 }
+
+/*
+ * ssdfs_block_bmap_lock() - lock segment's block bitmap
+ * @blk_bmap: pointer on block bitmap
+ */
+int ssdfs_block_bmap_lock(struct ssdfs_block_bmap *blk_bmap)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk_bmap %p\n", blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = mutex_lock_killable(&blk_bmap->lock);
+	if (err) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_is_locked() - check that block bitmap is locked
+ * @blk_bmap: pointer on block bitmap
+ */
+bool ssdfs_block_bmap_is_locked(struct ssdfs_block_bmap *blk_bmap)
+{
+	return mutex_is_locked(&blk_bmap->lock);
+}
+
+/*
+ * ssdfs_block_bmap_unlock() - unlock segment's block bitmap
+ * @blk_bmap: pointer on block bitmap
+ */
+void ssdfs_block_bmap_unlock(struct ssdfs_block_bmap *blk_bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk_bmap %p\n", blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_unlock(&blk_bmap->lock);
+}
+
+/*
+ * ssdfs_get_cache_type() - define cache type for block
+ * @blk_bmap: pointer on block bitmap
+ * @blk: block number
+ *
+ * RETURN:
+ * [success] - cache type
+ * [failure] - SSDFS_SEARCH_TYPE_MAX
+ */
+static
+int ssdfs_get_cache_type(struct ssdfs_block_bmap *blk_bmap,
+			 u32 blk)
+{
+	int page_index;
+	u16 offset;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	SSDFS_DBG("blk_bmap %p, block %u\n", blk_bmap, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = SSDFS_BLK2PAGE(blk, SSDFS_BLK_STATE_BITS, &offset);
+
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		struct ssdfs_last_bmap_search *last;
+
+		last = &blk_bmap->last_search[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("last->page_index %d, page_index %d, "
+			  "last->offset %u, offset %u, "
+			  "search_type %#x\n",
+			  last->page_index, page_index,
+			  last->offset, offset, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (last->page_index == page_index &&
+		    last->offset == offset)
+			return i;
+	}
+
+	return SSDFS_SEARCH_TYPE_MAX;
+}
+
+/*
+ * is_block_state_cached() - check that block state is in cache
+ * @blk_bmap: pointer on block bitmap
+ * @blk: block number
+ *
+ * RETURN:
+ * [true]  - block state is in cache
+ * [false] - cache doesn't contain block state
+ */
+static
+bool is_block_state_cached(struct ssdfs_block_bmap *blk_bmap,
+			   u32 blk)
+{
+	int cache_type;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	SSDFS_DBG("blk_bmap %p, block %u\n", blk_bmap, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cache_type = ssdfs_get_cache_type(blk_bmap, blk);
+
+	if (cache_type < 0) {
+		SSDFS_ERR("invalid cache type %d\n", cache_type);
+		return false;
+	}
+
+	if (cache_type >= SSDFS_SEARCH_TYPE_MAX)
+		return false;
+
+	return true;
+}
+
+/*
+ * ssdfs_determine_cache_type() - detect type of cache for value
+ * @cache: value for caching
+ *
+ * RETURN: suggested type of cache
+ */
+static
+int ssdfs_determine_cache_type(unsigned long cache)
+{
+	size_t bytes_per_long = sizeof(cache);
+	size_t criterion = bytes_per_long / 2;
+	u8 bytes[SSDFS_BLK_STATE_MAX] = {0};
+	int i;
+
+	for (i = 0; i < bytes_per_long; i++) {
+		int cur_state = (int)((cache >> (i * BITS_PER_BYTE)) & 0xFF);
+
+		switch (cur_state) {
+		case SSDFS_FREE_STATES_BYTE:
+			bytes[SSDFS_BLK_FREE]++;
+			break;
+
+		case SSDFS_PRE_ALLOC_STATES_BYTE:
+			bytes[SSDFS_BLK_PRE_ALLOCATED]++;
+			break;
+
+		case SSDFS_VALID_STATES_BYTE:
+			bytes[SSDFS_BLK_VALID]++;
+			break;
+
+		case SSDFS_INVALID_STATES_BYTE:
+			bytes[SSDFS_BLK_INVALID]++;
+			break;
+
+		default:
+			/* mix of block states */
+			break;
+		};
+	}
+
+	if (bytes[SSDFS_BLK_FREE] > criterion)
+		return SSDFS_FREE_BLK_SEARCH;
+	else if (bytes[SSDFS_BLK_VALID] > criterion)
+		return SSDFS_VALID_BLK_SEARCH;
+
+	return SSDFS_OTHER_BLK_SEARCH;
+}
+
+/*
+ * ssdfs_cache_block_state() - cache block state from pagevec
+ * @blk_bmap: pointer on block bitmap
+ * @blk: segment's block
+ * @blk_state: state as hint for cache type determination
+ *
+ * This function retrieves state of @blk from pagevec
+ * and  save retrieved value for requested type of cache.
+ * If @blk_state has SSDFS_BLK_STATE_MAX value then function
+ * defines block state and to cache value in proper place.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-EOPNOTSUPP - invalid page index.
+ */
+static
+int ssdfs_cache_block_state(struct ssdfs_block_bmap *blk_bmap,
+			    u32 blk, int blk_state)
+{
+	struct ssdfs_page_vector *array;
+	int page_index;
+	u16 offset;
+	void *kaddr;
+	unsigned long cache;
+	int cache_type;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	SSDFS_DBG("blk_bmap %p, block %u, state %#x\n",
+		  blk_bmap, blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (is_block_state_cached(blk_bmap, blk)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("block %u has been cached already\n", blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	page_index = SSDFS_BLK2PAGE(blk, SSDFS_BLK_STATE_BITS, &offset);
+
+	switch (blk_bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		array = &blk_bmap->storage.array;
+
+		if (page_index >= ssdfs_page_vector_capacity(array)) {
+			SSDFS_ERR("invalid page index %d\n", page_index);
+			return -EOPNOTSUPP;
+		}
+
+		if (page_index >= ssdfs_page_vector_count(array)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("absent page index %d\n", page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOENT;
+		}
+
+		err = ssdfs_memcpy_from_page(&cache,
+					     0, sizeof(unsigned long),
+					     array->pages[page_index],
+					     offset, PAGE_SIZE,
+					     sizeof(unsigned long));
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			return err;
+		}
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		if (page_index > 0) {
+			SSDFS_ERR("invalid page_index %d\n", page_index);
+			return -ERANGE;
+		}
+
+		kaddr = blk_bmap->storage.buf;
+		err = ssdfs_memcpy(&cache, 0, sizeof(unsigned long),
+				   kaddr, offset, blk_bmap->bytes_count,
+				   sizeof(unsigned long));
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n", blk_bmap->storage.state);
+		return -ERANGE;
+	}
+
+	cache_type = ssdfs_determine_cache_type(cache);
+	BUG_ON(cache_type >= SSDFS_SEARCH_TYPE_MAX);
+
+	blk_bmap->last_search[cache_type].page_index = page_index;
+	blk_bmap->last_search[cache_type].offset = offset;
+	blk_bmap->last_search[cache_type].cache = cache;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_search.cache %lx, cache_type %#x, "
+		  "page_index %d, offset %u\n",
+		  cache, cache_type,
+		  page_index, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_bits_shift_in_cache() - calculate bit shift of block in cache
+ * @blk_bmap: pointer on block bitmap
+ * @cache_type: type of cache
+ * @blk: segment's block
+ *
+ * This function calculates bit shift of @blk in cache of
+ * @cache_type.
+ *
+ * RETURN:
+ * [success] - bit shift
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_define_bits_shift_in_cache(struct ssdfs_block_bmap *blk_bmap,
+				     int cache_type, u32 blk)
+{
+	struct ssdfs_last_bmap_search *last_search;
+	u32 first_cached_block, diff;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid block %u\n", blk);
+		return -EINVAL;
+	}
+
+	if (cache_type < 0) {
+		SSDFS_ERR("invalid cache type %d\n", cache_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, cache_type %#x, blk %u\n",
+		  blk_bmap, cache_type, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (cache_type >= SSDFS_SEARCH_TYPE_MAX) {
+		SSDFS_ERR("cache doesn't contain block %u\n", blk);
+		return -EINVAL;
+	}
+
+	last_search = &blk_bmap->last_search[cache_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_search.cache %lx\n", last_search->cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	first_cached_block = SSDFS_FIRST_CACHED_BLOCK(last_search);
+
+	if (first_cached_block > blk) {
+		SSDFS_ERR("first_cached_block %u > blk %u\n",
+			  first_cached_block, blk);
+		return -EINVAL;
+	}
+
+	diff = blk - first_cached_block;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (diff >= (U32_MAX / SSDFS_BLK_STATE_BITS)) {
+		SSDFS_ERR("invalid diff %u; blk %u, first_cached_block %u\n",
+			  diff, blk, first_cached_block);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	diff *= SSDFS_BLK_STATE_BITS;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (diff > (BITS_PER_LONG - SSDFS_BLK_STATE_BITS)) {
+		SSDFS_ERR("invalid diff %u; bits_per_long %u, "
+			  "bits_per_state %u\n",
+			  diff, BITS_PER_LONG, SSDFS_BLK_STATE_BITS);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("diff %u\n", diff);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (int)diff;
+}
+
+/*
+ * ssdfs_get_block_state_from_cache() - retrieve block state from cache
+ * @blk_bmap: pointer on block bitmap
+ * @blk: segment's block
+ *
+ * This function retrieve state of @blk from cache.
+ *
+ * RETURN:
+ * [success] - state of block
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_get_block_state_from_cache(struct ssdfs_block_bmap *blk_bmap,
+				     u32 blk)
+{
+	int cache_type;
+	struct ssdfs_last_bmap_search *last_search;
+	int shift;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid block %u\n", blk);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, block %u\n", blk_bmap, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cache_type = ssdfs_get_cache_type(blk_bmap, blk);
+	shift = ssdfs_define_bits_shift_in_cache(blk_bmap, cache_type, blk);
+	if (unlikely(shift < 0)) {
+		SSDFS_ERR("fail to define bits shift: "
+			  "cache_type %d, blk %u, err %d\n",
+			  cache_type, blk, shift);
+		return shift;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(cache_type >= SSDFS_SEARCH_TYPE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	last_search = &blk_bmap->last_search[cache_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_search.cache %lx\n", last_search->cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (int)((last_search->cache >> shift) & SSDFS_BLK_STATE_MASK);
+}
+
+/*
+ * ssdfs_set_block_state_in_cache() - set block state in cache
+ * @blk_bmap: pointer on block bitmap
+ * @blk: segment's block
+ * @blk_state: new state of @blk
+ *
+ * This function sets state @blk_state of @blk in cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_set_block_state_in_cache(struct ssdfs_block_bmap *blk_bmap,
+				   u32 blk, int blk_state)
+{
+	int cache_type;
+	int shift;
+	unsigned long value, *cached_value;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid block %u\n", blk);
+		return -EINVAL;
+	}
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, block %u, blk_state %#x\n",
+		  blk_bmap, blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cache_type = ssdfs_get_cache_type(blk_bmap, blk);
+	shift = ssdfs_define_bits_shift_in_cache(blk_bmap, cache_type, blk);
+	if (unlikely(shift < 0)) {
+		SSDFS_ERR("fail to define bits shift: "
+			  "cache_type %d, blk %u, err %d\n",
+			  cache_type, blk, shift);
+		return shift;
+	}
+
+	value = blk_state & SSDFS_BLK_STATE_MASK;
+	value <<= shift;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(cache_type >= SSDFS_SEARCH_TYPE_MAX);
+
+	SSDFS_DBG("value %lx, cache %lx\n",
+		  value,
+		  blk_bmap->last_search[cache_type].cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cached_value = &blk_bmap->last_search[cache_type].cache;
+	*cached_value &= ~((unsigned long)SSDFS_BLK_STATE_MASK << shift);
+	*cached_value |= value;
+
+	return 0;
+}
+
+/*
+ * ssdfs_save_cache_in_storage() - save cached values in storage
+ * @blk_bmap: pointer on block bitmap
+ *
+ * This function saves cached values in storage.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_save_cache_in_storage(struct ssdfs_block_bmap *blk_bmap)
+{
+	struct ssdfs_page_vector *array;
+	void *kaddr;
+	int max_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	SSDFS_DBG("blk_bmap %p\n", blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		int page_index = blk_bmap->last_search[i].page_index;
+		u16 offset = blk_bmap->last_search[i].offset;
+		unsigned long cache = blk_bmap->last_search[i].cache;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("search_type %d, page_index %d, offset %u\n",
+			  i, page_index, offset);
+		SSDFS_DBG("last_search.cache %lx\n", cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index == max_capacity || offset == U16_MAX)
+			continue;
+
+		switch (blk_bmap->storage.state) {
+		case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+			array = &blk_bmap->storage.array;
+
+			if (page_index >= ssdfs_page_vector_capacity(array)) {
+				SSDFS_ERR("block bmap's cache is corrupted: "
+					  "page_index %d, offset %u\n",
+					  page_index, (u32)offset);
+				return -EINVAL;
+			}
+
+			while (page_index >= ssdfs_page_vector_count(array)) {
+				struct page *page;
+
+				page = ssdfs_page_vector_allocate(array);
+				if (IS_ERR_OR_NULL(page)) {
+					err = (page == NULL ? -ENOMEM :
+								PTR_ERR(page));
+					SSDFS_ERR("unable to allocate page\n");
+					return err;
+				}
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("page %p, count %d\n",
+					  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+			}
+
+			err = ssdfs_memcpy_to_page(array->pages[page_index],
+						   offset, PAGE_SIZE,
+						   &cache,
+						   0, sizeof(unsigned long),
+						   sizeof(unsigned long));
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				return err;
+			}
+			break;
+
+		case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+			if (page_index > 0) {
+				SSDFS_ERR("invalid page_index %d\n", page_index);
+				return -ERANGE;
+			}
+
+			kaddr = blk_bmap->storage.buf;
+			err = ssdfs_memcpy(kaddr, offset, blk_bmap->bytes_count,
+					   &cache, 0, sizeof(unsigned long),
+					   sizeof(unsigned long));
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				return err;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("unexpected state %#x\n",
+					blk_bmap->storage.state);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * is_cache_invalid() - check that cache is invalid for requested state
+ * @blk_bmap: pointer on block bitmap
+ * @blk_state: requested block's state
+ *
+ * RETURN:
+ * [true]  - cache doesn't been initialized yet.
+ * [false] - cache is valid.
+ */
+static inline
+bool is_cache_invalid(struct ssdfs_block_bmap *blk_bmap, int blk_state)
+{
+	struct ssdfs_last_bmap_search *last_search;
+	int cache_type = SSDFS_GET_CACHE_TYPE(blk_state);
+	int max_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+
+	if (cache_type >= SSDFS_SEARCH_TYPE_MAX) {
+		SSDFS_ERR("invalid cache type %#x, blk_state %#x\n",
+			  cache_type, blk_state);
+		return true;
+	}
+
+	last_search = &blk_bmap->last_search[cache_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_search.cache %lx\n", last_search->cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (last_search->page_index >= max_capacity ||
+	    last_search->offset == U16_MAX)
+		return true;
+
+	return false;
+}
+
+/*
+ * BYTE_CONTAINS_STATE() - check that provided byte contains state
+ * @value: pointer on analysed byte
+ * @blk_state: requested block's state
+ *
+ * RETURN:
+ * [true]  - @value contains @blk_state.
+ * [false] - @value hasn't @blk_state.
+ */
+static inline
+bool BYTE_CONTAINS_STATE(u8 *value, int blk_state)
+{
+	switch (blk_state) {
+	case SSDFS_BLK_FREE:
+		return detect_free_blk[*value];
+
+	case SSDFS_BLK_PRE_ALLOCATED:
+		return detect_pre_allocated_blk[*value];
+
+	case SSDFS_BLK_VALID:
+		return detect_valid_blk[*value];
+
+	case SSDFS_BLK_INVALID:
+		return detect_invalid_blk[*value];
+	};
+
+	return false;
+}
+
+/*
+ * ssdfs_block_bmap_find_block_in_cache() - find block for state in cache
+ * @blk_bmap: pointer on block bitmap
+ * @start: starting block for search
+ * @max_blk: upper bound for search
+ * @blk_state: requested block's state
+ * @found_blk: pointer on found block for requested state [out]
+ *
+ * This function tries to find in block block bitmap with @blk_state
+ * in range [@start, @max_blk).
+ *
+ * RETURN:
+ * [success] - @found_blk contains found block number for @blk_state.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - requested range [@start, @max_blk) doesn't contain
+ *                any block with @blk_state.
+ */
+static
+int ssdfs_block_bmap_find_block_in_cache(struct ssdfs_block_bmap *blk_bmap,
+					 u32 start, u32 max_blk,
+					 int blk_state, u32 *found_blk)
+{
+	int cache_type = SSDFS_GET_CACHE_TYPE(blk_state);
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	struct ssdfs_last_bmap_search *last_search;
+	u32 first_cached_blk;
+	u32 byte_index;
+	u8 blks_diff;
+	size_t bytes_per_long = sizeof(unsigned long);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !found_blk);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+
+	if (!is_block_state_cached(blk_bmap, start)) {
+		SSDFS_ERR("cache doesn't contain start %u\n", start);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, max_blk %u, "
+		  "state %#x, found_blk %p\n",
+		  blk_bmap, start, max_blk, blk_state, found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (cache_type >= SSDFS_SEARCH_TYPE_MAX) {
+		SSDFS_ERR("invalid cache type %#x, blk_state %#x\n",
+			  cache_type, blk_state);
+		return -EINVAL;
+	}
+
+	*found_blk = max_blk;
+	last_search = &blk_bmap->last_search[cache_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_search.cache %lx\n", last_search->cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	first_cached_blk = SSDFS_FIRST_CACHED_BLOCK(last_search);
+	blks_diff = start - first_cached_blk;
+	byte_index = blks_diff / items_per_byte;
+	blks_diff = blks_diff % items_per_byte;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("first_cached_blk %u, start %u, "
+		  "byte_index %u, bytes_per_long %zu\n",
+		  first_cached_blk, start,
+		  byte_index, bytes_per_long);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (; byte_index < bytes_per_long; byte_index++) {
+		u8 *value = (u8 *)&last_search->cache + byte_index;
+		u8 found_off;
+
+		err = FIND_FIRST_ITEM_IN_BYTE(value, blk_state,
+					      SSDFS_BLK_STATE_BITS,
+					      SSDFS_BLK_STATE_MASK,
+					      blks_diff,
+					      BYTE_CONTAINS_STATE,
+					      FIRST_STATE_IN_BYTE,
+					      &found_off);
+		if (err == -ENODATA) {
+			blks_diff = 0;
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find block in byte: "
+				  "start_off %u, blk_state %#x, err %d\n",
+				  blks_diff, blk_state, err);
+			return err;
+		}
+
+		*found_blk = first_cached_blk;
+		*found_blk += byte_index * items_per_byte;
+		*found_blk += found_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("block %u has been found for state %#x\n",
+			  *found_blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+static inline
+int ssdfs_block_bmap_define_start_item(int page_index,
+					u32 start,
+					u32 aligned_start,
+					u32 aligned_end,
+					u32 *start_byte,
+					u32 *rest_bytes,
+					u8 *item_offset)
+{
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	u32 items_per_page = PAGE_SIZE * items_per_byte;
+	u32 items;
+	u32 offset;
+
+	if ((page_index * items_per_page) <= aligned_start)
+		offset = aligned_start % items_per_page;
+	else
+		offset = aligned_start;
+
+	*start_byte = offset / items_per_byte;
+
+	items = items_per_page - offset;
+
+	if (aligned_end <= start) {
+		SSDFS_ERR("page_index %d, start %u, "
+			  "aligned_start %u, aligned_end %u, "
+			  "start_byte %u, rest_bytes %u, item_offset %u\n",
+			  page_index, start,
+			  aligned_start, aligned_end,
+			  *start_byte, *rest_bytes, *item_offset);
+		SSDFS_WARN("aligned_end %u <= start %u\n",
+			   aligned_end, start);
+		return -ERANGE;
+	} else
+		items = min_t(u32, items, aligned_end);
+
+	*rest_bytes = items + items_per_byte - 1;
+	*rest_bytes /= items_per_byte;
+
+	*item_offset = (u8)(start - aligned_start);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %d, start %u, "
+		  "aligned_start %u, aligned_end %u, "
+		  "start_byte %u, rest_bytes %u, item_offset %u\n",
+		  page_index, start,
+		  aligned_start, aligned_end,
+		  *start_byte, *rest_bytes, *item_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_find_block_in_memory_range() - find block in memory range
+ * @kaddr: pointer on memory range
+ * @blk_state: requested state of searching block
+ * @byte_index: index of byte in memory range [in|out]
+ * @search_bytes: upper bound for search
+ * @start_off: starting bit offset in byte
+ * @found_off: pointer on found byte's offset [out]
+ *
+ * This function searches a block with requested @blk_state
+ * into memory range.
+ *
+ * RETURN:
+ * [success] - found byte's offset in @found_off.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - block with requested state is not found.
+ */
+static
+int ssdfs_block_bmap_find_block_in_memory_range(void *kaddr,
+						int blk_state,
+						u32 *byte_index,
+						u32 search_bytes,
+						u8 start_off,
+						u8 *found_off)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !byte_index || !found_off);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_state %#x, byte_index %u, "
+		  "search_bytes %u, start_off %u\n",
+		  blk_state, *byte_index,
+		  search_bytes, start_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (; *byte_index < search_bytes; ++(*byte_index)) {
+		u8 *value = (u8 *)kaddr + *byte_index;
+
+		err = FIND_FIRST_ITEM_IN_BYTE(value, blk_state,
+					      SSDFS_BLK_STATE_BITS,
+					      SSDFS_BLK_STATE_MASK,
+					      start_off,
+					      BYTE_CONTAINS_STATE,
+					      FIRST_STATE_IN_BYTE,
+					      found_off);
+		if (err == -ENODATA) {
+			start_off = 0;
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find block in byte: "
+				  "start_off %u, blk_state %#x, "
+				  "err %d\n",
+				  start_off, blk_state, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %u has been found for state %#x, "
+			  "err %d\n",
+			  *found_off, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+/*
+ * ssdfs_block_bmap_find_block_in_buffer() - find block in buffer with state
+ * @blk_bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: requested state of searching block
+ * @found_blk: pointer on found block number [out]
+ *
+ * This function searches a block with requested @blk_state
+ * from @start till @max_blk (not inclusive) into buffer.
+ * The found block's number is returned via @found_blk.
+ *
+ * RETURN:
+ * [success] - found block number in @found_blk.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - block with requested state is not found.
+ */
+static
+int ssdfs_block_bmap_find_block_in_buffer(struct ssdfs_block_bmap *blk_bmap,
+					  u32 start, u32 max_blk,
+					  int blk_state, u32 *found_blk)
+{
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	u32 aligned_start, aligned_end;
+	u32 byte_index, search_bytes = U32_MAX;
+	u32 rest_bytes = U32_MAX;
+	u8 start_off = U8_MAX;
+	void *kaddr;
+	u8 found_off = U8_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !found_blk);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, max_blk %u, "
+		  "state %#x, found_blk %p\n",
+		  blk_bmap, start, max_blk, blk_state, found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_blk = max_blk;
+
+	aligned_start = ALIGNED_START_BLK(start);
+	aligned_end = ALIGNED_END_BLK(max_blk);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk_state %#x, start %u, max_blk %u, "
+		  "aligned_start %u, aligned_end %u\n",
+		  blk_state, start, max_blk,
+		  aligned_start, aligned_end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_block_bmap_define_start_item(0,
+						 start,
+						 aligned_start,
+						 aligned_end,
+						 &byte_index,
+						 &rest_bytes,
+						 &start_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define start item: "
+			  "blk_state %#x, start %u, max_blk %u, "
+			  "aligned_start %u, aligned_end %u\n",
+			  blk_state, start, max_blk,
+			  aligned_start, aligned_end);
+		return err;
+	}
+
+	kaddr = blk_bmap->storage.buf;
+	search_bytes = byte_index + rest_bytes;
+
+	err = ssdfs_block_bmap_find_block_in_memory_range(kaddr, blk_state,
+							  &byte_index,
+							  search_bytes,
+							  start_off,
+							  &found_off);
+	if (err == -ENODATA) {
+		/* no item has been found */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find block: "
+			  "start_off %u, blk_state %#x, "
+			  "err %d\n",
+			  start_off, blk_state, err);
+		return err;
+	}
+
+	*found_blk = byte_index * items_per_byte;
+	*found_blk += found_off;
+
+	if (*found_blk >= max_blk)
+		err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("block %u has been found for state %#x, "
+		  "err %d\n",
+		  *found_blk, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_block_bmap_find_block_in_pagevec() - find block in pagevec with state
+ * @blk_bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: requested state of searching block
+ * @found_blk: pointer on found block number [out]
+ *
+ * This function searches a block with requested @blk_state
+ * from @start till @max_blk (not inclusive) into pagevec.
+ * The found block's number is returned via @found_blk.
+ *
+ * RETURN:
+ * [success] - found block number in @found_blk.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - block with requested state is not found.
+ */
+static
+int ssdfs_block_bmap_find_block_in_pagevec(struct ssdfs_block_bmap *blk_bmap,
+					   u32 start, u32 max_blk,
+					   int blk_state, u32 *found_blk)
+{
+	struct ssdfs_page_vector *array;
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	size_t items_per_page = PAGE_SIZE * items_per_byte;
+	u32 aligned_start, aligned_end;
+	struct page *page;
+	void *kaddr;
+	int page_index;
+	u8 found_off = U8_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !found_blk);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, max_blk %u, "
+		  "state %#x, found_blk %p\n",
+		  blk_bmap, start, max_blk, blk_state, found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_blk = max_blk;
+
+	array = &blk_bmap->storage.array;
+
+	aligned_start = ALIGNED_START_BLK(start);
+	aligned_end = ALIGNED_END_BLK(max_blk);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk_state %#x, start %u, max_blk %u, "
+		  "aligned_start %u, aligned_end %u\n",
+		  blk_state, start, max_blk,
+		  aligned_start, aligned_end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = aligned_start / items_per_page;
+
+	if (page_index >= ssdfs_page_vector_capacity(array)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %d >= capacity %u\n",
+			  page_index,
+			  ssdfs_page_vector_capacity(array));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	if (page_index >= ssdfs_page_vector_count(array)) {
+		if (blk_state != SSDFS_BLK_FREE)
+			return -ENODATA;
+
+		while (page_index >= ssdfs_page_vector_count(array)) {
+			page = ssdfs_page_vector_allocate(array);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate page\n");
+				return err;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		*found_blk = page_index * items_per_page;
+
+		if (*found_blk >= max_blk)
+			err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("block %u has been found for state %#x, "
+			  "err %d\n",
+			  *found_blk, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return err;
+	}
+
+	for (; page_index < ssdfs_page_vector_capacity(array); page_index++) {
+		u32 byte_index, search_bytes = U32_MAX;
+		u32 rest_bytes = U32_MAX;
+		u8 start_off = U8_MAX;
+
+		if (page_index == ssdfs_page_vector_count(array)) {
+			if (blk_state != SSDFS_BLK_FREE)
+				return -ENODATA;
+
+			page = ssdfs_page_vector_allocate(array);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate page\n");
+				return err;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			*found_blk = page_index * items_per_page;
+
+			if (*found_blk >= max_blk)
+				err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("block %u has been found for state %#x, "
+				  "err %d\n",
+				  *found_blk, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return err;
+		}
+
+		err = ssdfs_block_bmap_define_start_item(page_index, start,
+							 aligned_start,
+							 aligned_end,
+							 &byte_index,
+							 &rest_bytes,
+							 &start_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define start item: "
+				  "blk_state %#x, start %u, max_blk %u, "
+				  "aligned_start %u, aligned_end %u\n",
+				  blk_state, start, max_blk,
+				  aligned_start, aligned_end);
+			return err;
+		}
+
+		search_bytes = byte_index + rest_bytes;
+
+		kaddr = kmap_local_page(array->pages[page_index]);
+		err = ssdfs_block_bmap_find_block_in_memory_range(kaddr,
+								  blk_state,
+								  &byte_index,
+								  search_bytes,
+								  start_off,
+								  &found_off);
+		kunmap_local(kaddr);
+
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("no item has been found: "
+				  "page_index %d, "
+				  "page_vector_count %u, "
+				  "page_vector_capacity %u\n",
+				  page_index,
+				  ssdfs_page_vector_count(array),
+				  ssdfs_page_vector_capacity(array));
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find block: "
+				  "start_off %u, blk_state %#x, "
+				  "err %d\n",
+				  start_off, blk_state, err);
+			return err;
+		}
+
+		*found_blk = page_index * items_per_page;
+		*found_blk += byte_index * items_per_byte;
+		*found_blk += found_off;
+
+		if (*found_blk >= max_blk)
+			err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("block %u has been found for state %#x, "
+			  "err %d\n",
+			  *found_blk, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return err;
+	}
+
+	return -ENODATA;
+}
+
+/*
+ * ssdfs_block_bmap_find_block_in_storage() - find block in storage with state
+ * @blk_bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: requested state of searching block
+ * @found_blk: pointer on found block number [out]
+ *
+ * This function searches a block with requested @blk_state
+ * from @start till @max_blk (not inclusive) into storage.
+ * The found block's number is returned via @found_blk.
+ *
+ * RETURN:
+ * [success] - found block number in @found_blk.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - block with requested state is not found.
+ */
+static
+int ssdfs_block_bmap_find_block_in_storage(struct ssdfs_block_bmap *blk_bmap,
+					   u32 start, u32 max_blk,
+					   int blk_state, u32 *found_blk)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !found_blk);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, max_blk %u, "
+		  "state %#x, found_blk %p\n",
+		  blk_bmap, start, max_blk, blk_state, found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (blk_bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		err = ssdfs_block_bmap_find_block_in_pagevec(blk_bmap,
+							     start,
+							     max_blk,
+							     blk_state,
+							     found_blk);
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		err = ssdfs_block_bmap_find_block_in_buffer(blk_bmap,
+							    start,
+							    max_blk,
+							    blk_state,
+							    found_blk);
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n",
+				blk_bmap->storage.state);
+		return -ERANGE;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_block_bmap_find_block() - find block with requested state
+ * @blk_bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: requested state of searching block
+ * @found_blk: pointer on found block number [out]
+ *
+ * This function searches a block with requested @blk_state
+ * from @start till @max_blk (not inclusive). The found block's
+ * number is returned via @found_blk. If @blk_state has
+ * SSDFS_BLK_STATE_MAX then it needs to get block state
+ * for @start block number, simply.
+ *
+ * RETURN:
+ * [success] - found block number in @found_blk.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - block with requested state is not found.
+ */
+static
+int ssdfs_block_bmap_find_block(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 max_blk, int blk_state,
+				u32 *found_blk)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !found_blk);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, max_blk %u, "
+		  "state %#x, found_blk %p\n",
+		  blk_bmap, start, max_blk, blk_state, found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blk_state == SSDFS_BLK_STATE_MAX) {
+		err = ssdfs_cache_block_state(blk_bmap, start, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to cache block %u state: err %d\n",
+				  start, err);
+			return err;
+		}
+
+		*found_blk = start;
+		return 0;
+	}
+
+	*found_blk = max_blk;
+	max_blk = min_t(u32, max_blk, blk_bmap->items_count);
+
+	if (is_cache_invalid(blk_bmap, blk_state)) {
+		err = ssdfs_block_bmap_find_block_in_storage(blk_bmap,
+							     start, max_blk,
+							     blk_state,
+							     found_blk);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find block in pagevec: "
+				  "start %u, max_blk %u, state %#x\n",
+				  0, max_blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find block in pagevec: "
+				  "start %u, max_blk %u, state %#x, err %d\n",
+				  0, max_blk, blk_state, err);
+			goto fail_find;
+		}
+
+		err = ssdfs_cache_block_state(blk_bmap, *found_blk, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to cache block: "
+				  "found_blk %u, state %#x, err %d\n",
+				  *found_blk, blk_state, err);
+			goto fail_find;
+		}
+	}
+
+	if (*found_blk >= start && *found_blk < max_blk)
+		goto end_search;
+
+	if (is_block_state_cached(blk_bmap, start)) {
+		err = ssdfs_block_bmap_find_block_in_cache(blk_bmap,
+							   start, max_blk,
+							   blk_state,
+							   found_blk);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find block in cache: "
+				  "start %u, max_blk %u, state %#x\n",
+				  start, max_blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+			/*
+			 * Continue to search in pagevec
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find block in cache: "
+				  "start %u, max_blk %u, state %#x, err %d\n",
+				  start, max_blk, blk_state, err);
+			goto fail_find;
+		} else if (*found_blk >= start && *found_blk < max_blk)
+			goto end_search;
+	}
+
+	err = ssdfs_block_bmap_find_block_in_storage(blk_bmap, start, max_blk,
+						     blk_state, found_blk);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find block in pagevec: "
+			  "start %u, max_blk %u, state %#x\n",
+			  start, max_blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find block in pagevec: "
+			  "start %u, max_blk %u, state %#x, err %d\n",
+			  start, max_blk, blk_state, err);
+		goto fail_find;
+	}
+
+	switch (SSDFS_GET_CACHE_TYPE(blk_state)) {
+	case SSDFS_FREE_BLK_SEARCH:
+	case SSDFS_OTHER_BLK_SEARCH:
+		err = ssdfs_cache_block_state(blk_bmap, *found_blk, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to cache block: "
+				  "found_blk %u, state %#x, err %d\n",
+				  *found_blk, blk_state, err);
+			goto fail_find;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+end_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("block %u has been found for state %#x\n",
+		  *found_blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+fail_find:
+	return err;
+}
+
+/*
+ * BYTE_CONTAIN_DIVERSE_STATES() - check that byte contains diverse state
+ * @value: pointer on analysed byte
+ * @blk_state: requested block's state
+ *
+ * RETURN:
+ * [true]  - @value contains diverse states.
+ * [false] - @value contains @blk_state only.
+ */
+static inline
+bool BYTE_CONTAIN_DIVERSE_STATES(u8 *value, int blk_state)
+{
+	switch (blk_state) {
+	case SSDFS_BLK_FREE:
+		return *value != SSDFS_FREE_STATES_BYTE;
+
+	case SSDFS_BLK_PRE_ALLOCATED:
+		return *value != SSDFS_PRE_ALLOC_STATES_BYTE;
+
+	case SSDFS_BLK_VALID:
+		return *value != SSDFS_VALID_STATES_BYTE;
+
+	case SSDFS_BLK_INVALID:
+		return *value != SSDFS_INVALID_STATES_BYTE;
+	};
+
+	return false;
+}
+
+/*
+ * GET_FIRST_DIFF_STATE() - determine first block offset for different state
+ * @value: pointer on analysed byte
+ * @blk_state: requested block's state
+ * @start_off: starting block offset for analysis beginning
+ *
+ * This function tries to determine an item with different that @blk_state in
+ * @value starting from @start_off.
+ *
+ * RETURN:
+ * [success] - found block offset.
+ * [failure] - BITS_PER_BYTE.
+ */
+static inline
+u8 GET_FIRST_DIFF_STATE(u8 *value, int blk_state, u8 start_off)
+{
+	u8 i;
+	u8 bits_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!value);
+	BUG_ON(start_off >= (BITS_PER_BYTE / SSDFS_BLK_STATE_BITS));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bits_off = start_off * SSDFS_BLK_STATE_BITS;
+
+	for (i = bits_off; i < BITS_PER_BYTE; i += SSDFS_BLK_STATE_BITS) {
+		if (((*value >> i) & SSDFS_BLK_STATE_MASK) != blk_state) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("blk_state %#x, start_off %u, blk_off %u\n",
+				  blk_state, start_off, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return i / SSDFS_BLK_STATE_BITS;
+		}
+	}
+
+	return BITS_PER_BYTE;
+}
+
+/*
+ * ssdfs_find_state_area_end_in_byte() - find end block for state area in byte
+ * @value: pointer on analysed byte
+ * @blk_state: requested block's state
+ * @start_off: starting block offset for search
+ * @found_off: pointer on found end block [out]
+ *
+ * RETURN:
+ * [success] - @found_off contains found end offset.
+ * [failure] - error code:
+ *
+ * %-ENODATA    - analyzed @value contains @blk_state only.
+ */
+static inline
+int ssdfs_find_state_area_end_in_byte(u8 *value, int blk_state,
+					u8 start_off, u8 *found_off)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("value %p, blk_state %#x, "
+		  "start_off %u, found_off %p\n",
+		  value, blk_state, start_off, found_off);
+
+	BUG_ON(!value || !found_off);
+	BUG_ON(start_off >= (BITS_PER_BYTE / SSDFS_BLK_STATE_BITS));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_off = BITS_PER_BYTE;
+
+	if (BYTE_CONTAIN_DIVERSE_STATES(value, blk_state)) {
+		u8 blk_offset = GET_FIRST_DIFF_STATE(value, blk_state,
+							start_off);
+
+		if (blk_offset < BITS_PER_BYTE) {
+			*found_off = blk_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("block offset %u for *NOT* state %#x\n",
+				  *found_off, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return 0;
+		}
+	}
+
+	return -ENODATA;
+}
+
+/*
+ * ssdfs_block_bmap_find_state_area_end_in_memory() - find state area end
+ * @kaddr: pointer on memory range
+ * @blk_state: requested state of searching block
+ * @byte_index: index of byte in memory range [in|out]
+ * @search_bytes: upper bound for search
+ * @start_off: starting bit offset in byte
+ * @found_off: pointer on found end block [out]
+ *
+ * This function tries to find @blk_state area end
+ * in range [@start, @max_blk).
+ *
+ * RETURN:
+ * [success] - found byte's offset in @found_off.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - nothing has been found.
+ */
+static
+int ssdfs_block_bmap_find_state_area_end_in_memory(void *kaddr,
+						   int blk_state,
+						   u32 *byte_index,
+						   u32 search_bytes,
+						   u8 start_off,
+						   u8 *found_off)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !byte_index || !found_off);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (; *byte_index < search_bytes; ++(*byte_index)) {
+		u8 *value = (u8 *)kaddr + *byte_index;
+
+		err = ssdfs_find_state_area_end_in_byte(value,
+							blk_state,
+							start_off,
+							found_off);
+		if (err == -ENODATA) {
+			start_off = 0;
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find state area's end: "
+				  "start_off %u, blk_state %#x, "
+				  "err %d\n",
+				  start_off, blk_state, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %u has been found for state %#x, "
+			  "err %d\n",
+			  *found_off, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+/*
+ * ssdfs_block_bmap_find_state_area_end_in_buffer() - find state area end
+ * @bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: area state
+ * @found_end: pointer on found end block [out]
+ *
+ * This function tries to find @blk_state area end
+ * in range [@start, @max_blk).
+ *
+ * RETURN:
+ * [success] - @found_end contains found end block.
+ * [failure] - items count in block bitmap or error:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static int
+ssdfs_block_bmap_find_state_area_end_in_buffer(struct ssdfs_block_bmap *bmap,
+						u32 start, u32 max_blk,
+						int blk_state, u32 *found_end)
+{
+	u32 aligned_start, aligned_end;
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	u32 byte_index, search_bytes = U32_MAX;
+	u32 rest_bytes = U32_MAX;
+	u8 start_off = U8_MAX;
+	void *kaddr;
+	u8 found_off = U8_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start %u, max_blk %u, blk_state %#x\n",
+		  start, max_blk, blk_state);
+
+	BUG_ON(!bmap || !found_end);
+
+	if (start >= bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_end = U32_MAX;
+
+	aligned_start = ALIGNED_START_BLK(start);
+	aligned_end = ALIGNED_END_BLK(max_blk);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk_state %#x, start %u, max_blk %u, "
+		  "aligned_start %u, aligned_end %u\n",
+		  blk_state, start, max_blk,
+		  aligned_start, aligned_end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_block_bmap_define_start_item(0,
+						 start,
+						 aligned_start,
+						 aligned_end,
+						 &byte_index,
+						 &rest_bytes,
+						 &start_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define start item: "
+			  "blk_state %#x, start %u, max_blk %u, "
+			  "aligned_start %u, aligned_end %u\n",
+			  blk_state, start, max_blk,
+			  aligned_start, aligned_end);
+		return err;
+	}
+
+	kaddr = bmap->storage.buf;
+	search_bytes = byte_index + rest_bytes;
+
+	err = ssdfs_block_bmap_find_state_area_end_in_memory(kaddr, blk_state,
+							     &byte_index,
+							     search_bytes,
+							     start_off,
+							     &found_off);
+	if (err == -ENODATA) {
+		*found_end = max_blk;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("area end %u has been found for state %#x\n",
+			  *found_end, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find state area's end: "
+			  "start_off %u, blk_state %#x, "
+			  "err %d\n",
+			  start_off, blk_state, err);
+		return err;
+	}
+
+	*found_end = byte_index * items_per_byte;
+	*found_end += found_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start %u, aligned_start %u, "
+		  "aligned_end %u, byte_index %u, "
+		  "items_per_byte %u, start_off %u, "
+		  "found_off %u\n",
+		  start, aligned_start, aligned_end, byte_index,
+		  items_per_byte, start_off, found_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*found_end > max_blk)
+		*found_end = max_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area end %u has been found for state %#x\n",
+		  *found_end, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_find_state_area_end_in_pagevec() - find state area end
+ * @bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: area state
+ * @found_end: pointer on found end block [out]
+ *
+ * This function tries to find @blk_state area end
+ * in range [@start, @max_blk).
+ *
+ * RETURN:
+ * [success] - @found_end contains found end block.
+ * [failure] - items count in block bitmap or error:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static int
+ssdfs_block_bmap_find_state_area_end_in_pagevec(struct ssdfs_block_bmap *bmap,
+						u32 start, u32 max_blk,
+						int blk_state, u32 *found_end)
+{
+	struct ssdfs_page_vector *array;
+	u32 aligned_start, aligned_end;
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	size_t items_per_page = PAGE_SIZE * items_per_byte;
+	void *kaddr;
+	int page_index;
+	u8 found_off = U8_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start %u, max_blk %u, blk_state %#x\n",
+		  start, max_blk, blk_state);
+
+	BUG_ON(!bmap || !found_end);
+
+	if (start >= bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_end = U32_MAX;
+
+	array = &bmap->storage.array;
+
+	aligned_start = ALIGNED_START_BLK(start);
+	aligned_end = ALIGNED_END_BLK(max_blk);
+
+	page_index = aligned_start / items_per_page;
+
+	if (page_index >= ssdfs_page_vector_count(array)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %d >= count %u\n",
+			  page_index,
+			  ssdfs_page_vector_count(array));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		*found_end = max_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("area end %u has been found for state %#x\n",
+			  *found_end, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return 0;
+	}
+
+	for (; page_index < ssdfs_page_vector_count(array); page_index++) {
+		u32 byte_index, search_bytes = U32_MAX;
+		u32 rest_bytes = U32_MAX;
+		u8 start_off = U8_MAX;
+
+		err = ssdfs_block_bmap_define_start_item(page_index, start,
+							 aligned_start,
+							 aligned_end,
+							 &byte_index,
+							 &rest_bytes,
+							 &start_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define start item: "
+				  "blk_state %#x, start %u, max_blk %u, "
+				  "aligned_start %u, aligned_end %u\n",
+				  blk_state, start, max_blk,
+				  aligned_start, aligned_end);
+			return err;
+		}
+
+		search_bytes = byte_index + rest_bytes;
+
+		kaddr = kmap_local_page(array->pages[page_index]);
+		err = ssdfs_block_bmap_find_state_area_end_in_memory(kaddr,
+								blk_state,
+								&byte_index,
+								search_bytes,
+								start_off,
+								&found_off);
+		kunmap_local(kaddr);
+
+		if (err == -ENODATA) {
+			/* nothing has been found */
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find state area's end: "
+				  "start_off %u, blk_state %#x, "
+				  "err %d\n",
+				  start_off, blk_state, err);
+			return err;
+		}
+
+		*found_end = page_index * items_per_page;
+		*found_end += byte_index * items_per_byte;
+		*found_end += found_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %u, aligned_start %u, "
+			  "aligned_end %u, "
+			  "page_index %d, items_per_page %zu, "
+			  "byte_index %u, "
+			  "items_per_byte %u, start_off %u, "
+			  "found_off %u\n",
+			  start, aligned_start, aligned_end,
+			  page_index, items_per_page, byte_index,
+			  items_per_byte, start_off, found_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (*found_end > max_blk)
+			*found_end = max_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("area end %u has been found for state %#x\n",
+			  *found_end, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return 0;
+	}
+
+	*found_end = max_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area end %u has been found for state %#x\n",
+		  *found_end, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_find_state_area_end() - find state area end
+ * @blk_bmap: pointer on block bitmap
+ * @start: start position for search
+ * @max_blk: upper bound for search
+ * @blk_state: area state
+ * @found_end: pointer on found end block [out]
+ *
+ * This function tries to find @blk_state area end
+ * in range [@start, @max_blk).
+ *
+ * RETURN:
+ * [success] - @found_end contains found end block.
+ * [failure] - items count in block bitmap or error:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_block_bmap_find_state_area_end(struct ssdfs_block_bmap *blk_bmap,
+					 u32 start, u32 max_blk, int blk_state,
+					 u32 *found_end)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start %u, max_blk %u, blk_state %#x\n",
+		  start, max_blk, blk_state);
+
+	BUG_ON(!blk_bmap || !found_end);
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	if (start > max_blk) {
+		SSDFS_ERR("start %u > max_blk %u\n", start, max_blk);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blk_state == SSDFS_BLK_FREE) {
+		*found_end = blk_bmap->items_count;
+		return 0;
+	}
+
+	switch (blk_bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		err = ssdfs_block_bmap_find_state_area_end_in_pagevec(blk_bmap,
+								     start,
+								     max_blk,
+								     blk_state,
+								     found_end);
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		err = ssdfs_block_bmap_find_state_area_end_in_buffer(blk_bmap,
+								     start,
+								     max_blk,
+								     blk_state,
+								     found_end);
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n",
+				blk_bmap->storage.state);
+		return -ERANGE;
+	}
+
+	return err;
+}
+
+/*
+ * range_corrupted() - check that range is corrupted
+ * @blk_bmap: pointer on block bitmap
+ * @range: range for check
+ *
+ * RETURN:
+ * [true]  - range is invalid
+ * [false] - range is valid
+ */
+static inline
+bool range_corrupted(struct ssdfs_block_bmap *blk_bmap,
+		     struct ssdfs_block_bmap_range *range)
+{
+	if (range->len > blk_bmap->items_count)
+		return true;
+	if (range->start > (blk_bmap->items_count - range->len))
+		return true;
+	return false;
+}
+
+/*
+ * is_whole_range_cached() - check that cache contains requested range
+ * @blk_bmap: pointer on block bitmap
+ * @range: range for check
+ *
+ * RETURN:
+ * [true]  - cache contains the whole range
+ * [false] - cache doesn't include the whole range
+ */
+static
+bool is_whole_range_cached(struct ssdfs_block_bmap *blk_bmap,
+			   struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_block_bmap_range cached_range;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u)\n",
+		  blk_bmap, range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		struct ssdfs_last_bmap_search *last_search;
+		int cmp;
+
+		last_search = &blk_bmap->last_search[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("last_search.cache %lx\n", last_search->cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		cached_range.start = SSDFS_FIRST_CACHED_BLOCK(last_search);
+		cached_range.len = SSDFS_ITEMS_PER_LONG(SSDFS_BLK_STATE_BITS);
+
+		cmp = compare_block_bmap_ranges(&cached_range, range);
+
+		if (cmp >= 0)
+			return true;
+		else if (ranges_have_intersection(&cached_range, range))
+			return false;
+	}
+
+	return false;
+}
+
+/*
+ * ssdfs_set_range_in_cache() - set small range in cache
+ * @blk_bmap: pointer on block bitmap
+ * @range: requested range
+ * @blk_state: state for set
+ *
+ * This function sets small range in cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_set_range_in_cache(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range,
+				int blk_state)
+{
+	u32 blk, index;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u), state %#x\n",
+		  blk_bmap, range->start, range->len, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (index = 0; index < range->len; index++) {
+		blk = range->start + index;
+		err = ssdfs_set_block_state_in_cache(blk_bmap, blk, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set block %u in cache: err %d\n",
+				  blk, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_set_uncached_tiny_range() - set tiny uncached range by state
+ * @blk_bmap: pointer on block bitmap
+ * @range: range for set
+ * @blk_state: state for set
+ *
+ * This function caches @range, to set @range in cache by @blk_state
+ * and to save the cache in pagevec.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_set_uncached_tiny_range(struct ssdfs_block_bmap *blk_bmap,
+				  struct ssdfs_block_bmap_range *range,
+				  int blk_state)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	if (range->len > SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS)) {
+		SSDFS_ERR("range (start %u, len %u) is not tiny\n",
+			  range->start, range->len);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u), state %#x\n",
+		  blk_bmap, range->start, range->len, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_cache_block_state(blk_bmap, range->start, blk_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to cache block %u: err %d\n",
+			  range->start, err);
+		return err;
+	}
+
+	err = ssdfs_set_range_in_cache(blk_bmap, range, blk_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set (start %u, len %u): err %d\n",
+			  range->start, range->len, err);
+		return err;
+	}
+
+	err = ssdfs_save_cache_in_storage(blk_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to save cache in pagevec: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_set_range_in_memory() - set range of bits in memory
+ * @blk_bmap: pointer on block bitmap
+ * @page_index: index of memory page
+ * @byte_offset: offset in bytes from the page's beginning
+ * @byte_value: byte value for setting
+ * @init_size: size in bytes for setting
+ *
+ * This function sets range of bits in memory.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_set_range_in_memory(struct ssdfs_block_bmap *blk_bmap,
+				int page_index, u32 byte_offset,
+				int byte_value, size_t init_size)
+{
+	struct ssdfs_page_vector *array;
+	void *kaddr;
+	int max_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	SSDFS_DBG("blk_bmap %p, page_index %d, byte_offset %u, "
+		  "byte_value %#x, init_size %zu\n",
+		  blk_bmap, page_index, byte_offset,
+		  byte_value, init_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (blk_bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		array = &blk_bmap->storage.array;
+
+		if (page_index >= ssdfs_page_vector_count(array)) {
+			SSDFS_ERR("invalid page index %d, pagevec size %d\n",
+				  page_index,
+				  ssdfs_page_vector_count(array));
+			return -EINVAL;
+		}
+
+		if (page_index >= ssdfs_page_vector_capacity(array)) {
+			SSDFS_ERR("invalid page index %d, pagevec capacity %d\n",
+				  page_index,
+				  ssdfs_page_vector_capacity(array));
+			return -EINVAL;
+		}
+
+		while (page_index >= ssdfs_page_vector_count(array)) {
+			struct page *page;
+
+			page = ssdfs_page_vector_allocate(array);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate page\n");
+				return err;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		if ((byte_offset + init_size) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "byte_offset %u, init_size %zu\n",
+				   byte_offset, init_size);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_memset_page(array->pages[page_index],
+				  byte_offset, PAGE_SIZE,
+				  byte_value, init_size);
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		if (page_index != 0) {
+			SSDFS_ERR("invalid page index %d\n",
+				  page_index);
+			return -EINVAL;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		if ((byte_offset + init_size) > blk_bmap->bytes_count) {
+			SSDFS_WARN("invalid offset: "
+				   "byte_offset %u, init_size %zu\n",
+				   byte_offset, init_size);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		kaddr = blk_bmap->storage.buf;
+		memset((u8 *)kaddr + byte_offset, byte_value, init_size);
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk_bmap->storage.state);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		blk_bmap->last_search[i].page_index = max_capacity;
+		blk_bmap->last_search[i].offset = U16_MAX;
+		blk_bmap->last_search[i].cache = 0;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_set_range_in_storage() - set range in storage by state
+ * @blk_bmap: pointer on block bitmap
+ * @range: range for set
+ * @blk_state: state for set
+ *
+ * This function sets @range in storage by @blk_state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_set_range_in_storage(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range,
+				int blk_state)
+{
+	u32 aligned_start, aligned_end;
+	size_t items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	int byte_value;
+	size_t rest_items, items_per_page;
+	u32 blk;
+	int page_index;
+	u32 item_offset, byte_offset;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u), state %#x\n",
+		  blk_bmap, range->start, range->len, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	aligned_start = range->start + items_per_byte - 1;
+	aligned_start >>= SSDFS_BLK_STATE_BITS;
+	aligned_start <<= SSDFS_BLK_STATE_BITS;
+
+	aligned_end = range->start + range->len;
+	aligned_end >>= SSDFS_BLK_STATE_BITS;
+	aligned_end <<= SSDFS_BLK_STATE_BITS;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("aligned_start %u, aligned_end %u\n",
+		  aligned_start, aligned_end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range->start != aligned_start) {
+		struct ssdfs_block_bmap_range unaligned;
+
+		unaligned.start = range->start;
+		unaligned.len = aligned_start - range->start;
+
+		err = ssdfs_set_uncached_tiny_range(blk_bmap, &unaligned,
+						    blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set (start %u, len %u): err %d\n",
+				  unaligned.start, unaligned.len, err);
+			return err;
+		}
+	}
+
+	byte_value = SSDFS_BLK_BMAP_BYTE(blk_state);
+	items_per_page = PAGE_SIZE * items_per_byte;
+	rest_items = aligned_end - aligned_start;
+	page_index = aligned_start / items_per_page;
+	item_offset = aligned_start % items_per_page;
+	byte_offset = item_offset / items_per_byte;
+
+	blk = aligned_start;
+	while (blk < aligned_end) {
+		size_t iter_items, init_size;
+
+		if (rest_items == 0) {
+			SSDFS_WARN("unexpected items absence: blk %u\n",
+				   blk);
+			break;
+		}
+
+		if (byte_offset >= PAGE_SIZE) {
+			SSDFS_ERR("invalid byte offset %u\n", byte_offset);
+			return -EINVAL;
+		}
+
+		iter_items = items_per_page - item_offset;
+		iter_items = min_t(size_t, iter_items, rest_items);
+		if (iter_items < items_per_page) {
+			init_size = iter_items + items_per_byte - 1;
+			init_size /= items_per_byte;
+		} else
+			init_size = PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_per_page %zu, item_offset %u, "
+			  "rest_items %zu, iter_items %zu, "
+			  "init_size %zu\n",
+			  items_per_page, item_offset,
+			  rest_items, iter_items,
+			  init_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = __ssdfs_set_range_in_memory(blk_bmap, page_index,
+						  byte_offset, byte_value,
+						  init_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set range in memory: "
+				  "page_index %d, byte_offset %u, "
+				  "byte_value %#x, init_size %zu, "
+				  "err %d\n",
+				  page_index, byte_offset,
+				  byte_value, init_size,
+				  err);
+			return err;
+		}
+
+		item_offset = 0;
+		byte_offset = 0;
+		page_index++;
+		blk += iter_items;
+		rest_items -= iter_items;
+	};
+
+	if (aligned_end != range->start + range->len) {
+		struct ssdfs_block_bmap_range unaligned;
+
+		unaligned.start = aligned_end;
+		unaligned.len = (range->start + range->len) - aligned_end;
+
+		err = ssdfs_set_uncached_tiny_range(blk_bmap, &unaligned,
+						    blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set (start %u, len %u): err %d\n",
+				  unaligned.start, unaligned.len, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_find_range() - find range of block of requested state
+ * @blk_bmap: pointer on block bitmap
+ * @start: start block for search
+ * @len: requested length of range
+ * @max_blk: upper bound for search
+ * @blk_state: requested state of blocks in range
+ * @range: found range [out]
+ *
+ * This function searches @range of blocks with requested
+ * @blk_state. If @blk_state has SSDFS_BLK_STATE_MAX value
+ * then it needs to get a continuous @range of blocks
+ * for detecting state of @range is began from @start
+ * block.
+ *
+ * RETURN:
+ * [success] - @range of found blocks.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_block_bmap_find_range(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 len, u32 max_blk,
+				int blk_state,
+				struct ssdfs_block_bmap_range *range)
+{
+	u32 found_start, found_end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (blk_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid start block %u\n", start);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, start %u, len %u, max_blk %u, "
+		  "state %#x, range %p\n",
+		  blk_bmap, start, len, max_blk, blk_state, range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	range->start = U32_MAX;
+	range->len = 0;
+
+	if (start >= max_blk) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %u >= max_blk %u\n", start, max_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	err = ssdfs_block_bmap_find_block(blk_bmap, start, max_blk,
+					  blk_state, &found_start);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find block: "
+			  "start %u, max_blk %u, state %#x, err %d\n",
+			  start, max_blk, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find block: "
+			  "start %u, max_blk %u, state %#x, err %d\n",
+			  start, max_blk, blk_state, err);
+		return err;
+	}
+
+	if (found_start >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid found start %u, items count %zu\n",
+			  found_start, blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	err = ssdfs_block_bmap_find_state_area_end(blk_bmap, found_start,
+						   found_start + len,
+						   blk_state,
+						   &found_end);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find block: "
+			  "start %u, max_blk %u, state %#x, err %d\n",
+			  start, max_blk, blk_state, err);
+		return err;
+	}
+
+	if (found_end <= found_start) {
+		SSDFS_ERR("invalid found (start %u, end %u), items count %zu\n",
+			  found_start, found_end, blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	if (found_end > blk_bmap->items_count)
+		found_end = blk_bmap->items_count;
+
+	range->start = found_start;
+	range->len = min_t(u32, len, found_end - found_start);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_start %u, found_end %u, len %u, "
+		  "range (start %u, len %u)\n",
+		  found_start, found_end, len,
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_set_block_state() - set state of block
+ * @blk_bmap: pointer on block bitmap
+ * @blk: segment's block
+ * @blk_state: state for set
+ *
+ * This function sets @blk by @blk_state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_block_bmap_set_block_state(struct ssdfs_block_bmap *blk_bmap,
+					u32 blk, int blk_state)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (blk >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid block %u\n", blk);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, block %u, state %#x\n",
+		  blk_bmap, blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_state_cached(blk_bmap, blk)) {
+		err = ssdfs_cache_block_state(blk_bmap, blk, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to cache block %u state: err %d\n",
+				  blk, err);
+			return err;
+		}
+	}
+
+	err = ssdfs_set_block_state_in_cache(blk_bmap, blk, blk_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to set block %u state in cache: err %d\n",
+			  blk, err);
+		return err;
+	}
+
+	err = ssdfs_save_cache_in_storage(blk_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to save the cache in storage: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_set_range() - set state of blocks' range
+ * @blk_bmap: pointer on block bitmap
+ * @range: requested range
+ * @blk_state: state for set
+ *
+ * This function sets blocks' @range by @blk_state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+static
+int ssdfs_block_bmap_set_range(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range,
+				int blk_state)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return -EINVAL;
+	}
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u), state %#x\n",
+		  blk_bmap, range->start, range->len, blk_state);
+
+	ssdfs_debug_block_bitmap(blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range->len == 1) {
+		err = ssdfs_block_bmap_set_block_state(blk_bmap, range->start,
+							blk_state);
+		if (err) {
+			SSDFS_ERR("fail to set (start %u, len %u) state %#x: "
+				  "err %d\n",
+				  range->start, range->len, blk_state, err);
+			return err;
+		}
+	} else if (is_whole_range_cached(blk_bmap, range)) {
+		err = ssdfs_set_range_in_cache(blk_bmap, range, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to set (start %u, len %u) state %#x "
+				  "in cache: err %d\n",
+				  range->start, range->len, blk_state, err);
+			return err;
+		}
+
+		err = ssdfs_save_cache_in_storage(blk_bmap);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to save the cache in storage: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else {
+		u32 next_blk;
+
+		err = ssdfs_set_range_in_storage(blk_bmap, range, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to set (start %u, len %u) state %#x "
+				  "in storage: err %d\n",
+				  range->start, range->len, blk_state, err);
+			return err;
+		}
+
+		next_blk = range->start + range->len;
+		if (next_blk == blk_bmap->items_count)
+			next_blk--;
+
+		err = ssdfs_cache_block_state(blk_bmap, next_blk, blk_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to cache block %u state: err %d\n",
+				  next_blk, err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	ssdfs_debug_block_bitmap(blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_test_block() - check state of block
+ * @blk_bmap: pointer on block bitmap
+ * @blk: segment's block
+ * @blk_state: checked state
+ *
+ * This function checks that requested @blk has @blk_state.
+ *
+ * RETURN:
+ * [true]  - requested @blk has @blk_state
+ * [false] - requested @blk hasn't @blk_state or it took place
+ *           some failure during checking.
+ */
+bool ssdfs_block_bmap_test_block(struct ssdfs_block_bmap *blk_bmap,
+				 u32 blk, int blk_state)
+{
+	u32 found;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return false;
+	}
+
+	if (blk >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid block %u\n", blk);
+		return false;
+	}
+
+	BUG_ON(!mutex_is_locked(&blk_bmap->lock));
+
+	SSDFS_DBG("blk_bmap %p, block %u, state %#x\n",
+		  blk_bmap, blk, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(!is_block_bmap_initialized(blk_bmap));
+
+	err = ssdfs_block_bmap_find_block(blk_bmap, blk, blk + 1, blk_state,
+					  &found);
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find block %u, state %#x, err %d\n",
+			  blk, blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	return (found != blk) ? false : true;
+}
+
+/*
+ * ssdfs_block_bmap_test_range() - check state of blocks' range
+ * @blk_bmap: pointer on block bitmap
+ * @range: segment's blocks' range
+ * @blk_state: checked state
+ *
+ * This function checks that all blocks in requested @range have
+ * @blk_state.
+ *
+ * RETURN:
+ * [true]  - all blocks in requested @range have @blk_state
+ * [false] - requested @range contains blocks with various states or
+ *           it took place some failure during checking.
+ */
+bool ssdfs_block_bmap_test_range(struct ssdfs_block_bmap *blk_bmap,
+				 struct ssdfs_block_bmap_range *range,
+				 int blk_state)
+{
+	struct ssdfs_block_bmap_range found;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (blk_state >= SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", blk_state);
+		return false;
+	}
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range (start %u, len %u); items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return false;
+	}
+
+	BUG_ON(!mutex_is_locked(&blk_bmap->lock));
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u), state %#x\n",
+		  blk_bmap, range->start, range->len, blk_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(!is_block_bmap_initialized(blk_bmap));
+
+	err = ssdfs_block_bmap_find_range(blk_bmap, range->start, range->len,
+					  range->start + range->len,
+					  blk_state, &found);
+	if (unlikely(err)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find range: err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	if (compare_block_bmap_ranges(&found, range) == 0)
+		return true;
+
+	return false;
+}
+
+/*
+ * ssdfs_get_block_state() - detect state of block
+ * @blk_bmap: pointer on block bitmap
+ * @blk: segment's block
+ *
+ * This function retrieve state of @blk from block bitmap.
+ *
+ * RETURN:
+ * [success] - state of block
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENODATA    - requsted @blk hasn't been found.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_get_block_state(struct ssdfs_block_bmap *blk_bmap, u32 blk)
+{
+	u32 found;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (blk >= blk_bmap->items_count) {
+		SSDFS_ERR("invalid block %u\n", blk);
+		return -EINVAL;
+	}
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, block %u\n", blk_bmap, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+	err = ssdfs_block_bmap_find_block(blk_bmap, blk, blk + 1,
+					    SSDFS_BLK_STATE_MAX,
+					    &found);
+	if (err) {
+		SSDFS_ERR("fail to find block %u, err %d\n",
+			  blk, err);
+		return err;
+	}
+
+	if (found != blk) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found (%u) != blk (%u)\n", found, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	return ssdfs_get_block_state_from_cache(blk_bmap, blk);
+}
+
+/*
+ * ssdfs_get_range_state() - detect state of blocks' range
+ * @blk_bmap: pointer on block bitmap
+ * @range: pointer on blocks' range
+ *
+ * This function retrieve state of @range from block bitmap.
+ *
+ * RETURN:
+ * [success] - state of blocks' range
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-EOPNOTSUPP - requsted @range contains various state of blocks.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_get_range_state(struct ssdfs_block_bmap *blk_bmap,
+			  struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_block_bmap_range found;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !range);
+
+	if (range_corrupted(blk_bmap, range)) {
+		SSDFS_ERR("invalid range: start %u, len %u; items count %zu\n",
+			  range->start, range->len,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, range (start %u, len %u)\n",
+		  blk_bmap, range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -ENOENT;
+	}
+
+	err = ssdfs_block_bmap_find_range(blk_bmap, range->start, range->len,
+					  range->start + range->len,
+					  SSDFS_BLK_STATE_MAX, &found);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find range: err %d\n", err);
+		return err;
+	}
+
+	if (compare_block_bmap_ranges(&found, range) != 0) {
+		SSDFS_ERR("range contains various state of blocks\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = ssdfs_cache_block_state(blk_bmap, range->start,
+					SSDFS_BLK_STATE_MAX);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to cache block %u: err %d\n",
+			  range->start, err);
+		return err;
+	}
+
+	return ssdfs_get_block_state_from_cache(blk_bmap, range->start);
+}
+
+/*
+ * ssdfs_block_bmap_reserve_metadata_pages() - reserve metadata pages
+ * @blk_bmap: pointer on block bitmap
+ * @count: count of reserved metadata pages
+ *
+ * This function tries to reserve @count of metadata pages in
+ * block bitmap's space.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_block_bmap_reserve_metadata_pages(struct ssdfs_block_bmap *blk_bmap,
+					    u32 count)
+{
+	u32 reserved_items;
+	u32 calculated_items;
+	int free_pages = 0;
+	int used_pages = 0;
+	int invalid_pages = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, count %u\n",
+		  blk_bmap, count);
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
+	if (free_pages < count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to reserve metadata pages: "
+			  "free_pages %d, count %u\n",
+			  free_pages, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get used pages: err %d\n", err);
+		return err;
+	} else {
+		used_pages = err;
+		err = 0;
+	}
+
+	err  = ssdfs_block_bmap_get_invalid_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get invalid pages: err %d\n", err);
+		return err;
+	} else {
+		invalid_pages = err;
+		err = 0;
+	}
+
+	reserved_items = blk_bmap->metadata_items + count;
+	calculated_items = used_pages + invalid_pages + reserved_items;
+	if (calculated_items > blk_bmap->items_count) {
+		SSDFS_ERR("fail to reserve metadata pages: "
+			  "used_pages %d, invalid_pages %d, "
+			  "metadata_items %u, "
+			  "count %u, items_count %zu\n",
+			  used_pages, invalid_pages,
+			  blk_bmap->metadata_items,
+			  count, blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	blk_bmap->metadata_items += count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(blk_bmap->metadata_items == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_free_metadata_pages() - free metadata pages
+ * @blk_bmap: pointer on block bitmap
+ * @count: count of metadata pages for freeing
+ *
+ * This function tries to free @count of metadata pages in
+ * block bitmap's space.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_block_bmap_free_metadata_pages(struct ssdfs_block_bmap *blk_bmap,
+					 u32 count)
+{
+	u32 metadata_items;
+	u32 freed_items;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, count %u\n",
+		  blk_bmap, count);
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
+	metadata_items = blk_bmap->metadata_items;
+	freed_items = count;
+
+	if (blk_bmap->metadata_items < count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("correct value: metadata_items %u < count %u\n",
+			  blk_bmap->metadata_items, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		freed_items = blk_bmap->metadata_items;
+	}
+
+	blk_bmap->metadata_items -= freed_items;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (blk_bmap->metadata_items == 0) {
+		SSDFS_ERR("BEFORE: metadata_items %u, count %u, "
+			  "items_count %zu, used_blks %u, "
+			  "invalid_blks %u\n",
+			  metadata_items, count,
+			  blk_bmap->items_count,
+			  blk_bmap->used_blks,
+			  blk_bmap->invalid_blks);
+		SSDFS_ERR("AFTER: metadata_items %u, freed_items %u\n",
+			  blk_bmap->metadata_items, freed_items);
+	}
+	BUG_ON(blk_bmap->metadata_items == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_get_free_pages() - determine current free pages count
+ * @blk_bmap: pointer on block bitmap
+ *
+ * This function tries to detect current free pages count
+ * in block bitmap.
+ *
+ * RETURN:
+ * [success] - count of free pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_block_bmap_get_free_pages(struct ssdfs_block_bmap *blk_bmap)
+{
+	u32 found_blk;
+	u32 used_blks;
+	u32 metadata_items;
+	u32 invalid_blks;
+	int free_blks;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
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
+	if (is_cache_invalid(blk_bmap, SSDFS_BLK_FREE)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cache for free states is invalid!!!\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_block_bmap_find_block(blk_bmap,
+						  0, blk_bmap->items_count,
+						  SSDFS_BLK_FREE, &found_blk);
+	} else
+		err = ssdfs_define_last_free_page(blk_bmap, &found_blk);
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find last free block: "
+			  "found_blk %u\n",
+			  found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find last free block: err %d\n",
+			  err);
+		return err;
+	}
+
+	used_blks = blk_bmap->used_blks;
+	metadata_items = blk_bmap->metadata_items;
+	invalid_blks = blk_bmap->invalid_blks;
+
+	free_blks = blk_bmap->items_count;
+	free_blks -= used_blks + metadata_items + invalid_blks;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %zu, used_blks %u, "
+		  "invalid_blks %u, "
+		  "metadata_items %u, free_blks %d\n",
+		  blk_bmap->items_count,
+		  used_blks, invalid_blks, metadata_items,
+		  free_blks);
+
+	if (unlikely(found_blk > blk_bmap->items_count)) {
+		SSDFS_ERR("found_blk %u > items_count %zu\n",
+			  found_blk, blk_bmap->items_count);
+		return -ERANGE;
+	}
+
+	WARN_ON(INT_MAX < (blk_bmap->items_count - found_blk));
+
+	if (unlikely((used_blks + metadata_items) > blk_bmap->items_count)) {
+		SSDFS_ERR("used_blks %u, metadata_items %u, "
+			  "items_count %zu\n",
+			  used_blks, metadata_items,
+			  blk_bmap->items_count);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (free_blks < 0) {
+		SSDFS_ERR("items_count %zu, used_blks %u, "
+			  "invalid_blks %u, "
+			  "metadata_items %u, free_blks %d\n",
+			  blk_bmap->items_count,
+			  used_blks, invalid_blks, metadata_items,
+			  free_blks);
+		return -ERANGE;
+	}
+
+	return free_blks;
+}
+
+/*
+ * ssdfs_block_bmap_get_used_pages() - determine current used pages count
+ * @blk_bmap: pointer on block bitmap
+ *
+ * This function tries to detect current used pages count
+ * in block bitmap.
+ *
+ * RETURN:
+ * [success] - count of used pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_block_bmap_get_used_pages(struct ssdfs_block_bmap *blk_bmap)
+{
+	u32 found_blk;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p\n", blk_bmap);
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
+	err = ssdfs_define_last_free_page(blk_bmap, &found_blk);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find last free block: "
+			  "found_blk %u\n",
+			  found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find last free block: err %d\n",
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (unlikely(found_blk > blk_bmap->items_count)) {
+		SSDFS_ERR("found_blk %u > items_count %zu\n",
+			  found_blk, blk_bmap->items_count);
+		return -ERANGE;
+	}
+
+	if (unlikely(blk_bmap->used_blks > blk_bmap->items_count)) {
+		SSDFS_ERR("used_blks %u > items_count %zu\n",
+			  blk_bmap->used_blks,
+			  blk_bmap->items_count);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return blk_bmap->used_blks;
+}
+
+/*
+ * ssdfs_block_bmap_get_invalid_pages() - determine current invalid pages count
+ * @blk_bmap: pointer on block bitmap
+ *
+ * This function tries to detect current invalid pages count
+ * in block bitmap.
+ *
+ * RETURN:
+ * [success] - count of invalid pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ENOENT     - block bitmap doesn't initialized.
+ */
+int ssdfs_block_bmap_get_invalid_pages(struct ssdfs_block_bmap *blk_bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p\n", blk_bmap);
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
+	return blk_bmap->invalid_blks;
+}
-- 
2.34.1

