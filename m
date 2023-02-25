Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74AD6A2652
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBYBTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBYBRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:14 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602DA16895
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:09 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t22so778214oiw.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxqfg0pAZ3cOAY4/hBS56hwzdP+psN8rKZhDrbnMzbU=;
        b=fe2e0GIiMubAuMVg9+ZTMUdqeLJ2hmR4k28L2WHxqKlOd//SywMThwhRHjuqDkjAXA
         joS/lZuqv++bmJMysqMg0CZjvH7D336GWwcOgS8TJi4pwmfMdp9wsxSAWjKqCM2Ysvn/
         8D8ylLOmOu4t+1tBrjXFi95YtSiqKmvazuwayTPnODI8wzbYXiBrfxDDtavJ/GifEBNR
         HxcFUhLikphgHYfG3O63X7BWqFDo8EN6lD40/TzPjLFz2LlOdntZDl8Q2F/Y0LjOArm4
         r3/pNfDYGUvyt5km5ryFsAOkmnmaWiXzM7Gir+LWL7NhQgbPbRZsnicUvS4+Y72I7/WV
         nd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxqfg0pAZ3cOAY4/hBS56hwzdP+psN8rKZhDrbnMzbU=;
        b=urvaE7s/o3PxAIEgqotXx/8AnBINEAJWPsWOs7HMOp2KdledkzK9EzLa5PVqcVjMVF
         Nwzb1fWTzlmupSigQIriUCTpR/fXJ3lNTBdpQ4ZWb+DVOv+oxCZL3W1aaiz5JK0A6OvJ
         Ds7NRlcFmVOuW4tISv5WReY4jhK7I6b868hbHIT743y0DGFWrPlGLg57FjMRfUAoLAI/
         QDnxj+7hMqFJXtMlaD1XQdeWwtGzhoDxkI5awCGwtwMdTHaXBgqoFV89fwuIJh0rlXR6
         HXO7hqBHIpvQt9rt+ZKRmDUM12wmmKVBTDLr0HMjW2GtDDIIo4JEzna4oWU9O5ickb9I
         sKFQ==
X-Gm-Message-State: AO0yUKUQCAZnsFPoiXFcYvfx5TYVZn6Nyr868jh+ngkx+AjbjMnc9FIg
        NQJECdmcnLHg/IFmj88WvtrD0XbJYa5CqQdW
X-Google-Smtp-Source: AK7set87mBJZOKDZ7xeY5lq9X2WoFn7LtZgS7U1RIKk/FZbfh1XMKFnH/S2yZy/bTLlMU+NcsWdhyA==
X-Received: by 2002:aca:d06:0:b0:36e:b7bf:e3d7 with SMTP id 6-20020aca0d06000000b0036eb7bfe3d7mr4538413oin.52.1677287828052;
        Fri, 24 Feb 2023 17:17:08 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:07 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 44/76] ssdfs: PEB mapping table cache's modification operations
Date:   Fri, 24 Feb 2023 17:08:55 -0800
Message-Id: <20230225010927.813929-45-slava@dubeyko.com>
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

"Physical" Erase Block (PEB) mapping table cache supports
operations:
(1) convert LEB to PEB - convert LEB to PEB if mapping table
                         is not initialized yet
(2) map LEB to PEB - cache information about LEB to PEB mapping
(3) forget LEB to PEB - exclude information about LEB to PEB mapping
                        from the cache
(4) change PEB state - update cached information about LEB to PEB mapping
(5) add migration PEB - cache information about migration destination
(6) exclude migration PEB - exclude information about migration destination

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_mapping_table_cache.c | 3205 ++++++++++++++++++++++++++++
 1 file changed, 3205 insertions(+)

diff --git a/fs/ssdfs/peb_mapping_table_cache.c b/fs/ssdfs/peb_mapping_table_cache.c
index e83e07947743..4242d4a5f9ac 100644
--- a/fs/ssdfs/peb_mapping_table_cache.c
+++ b/fs/ssdfs/peb_mapping_table_cache.c
@@ -1495,3 +1495,3208 @@ int ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
 finish_leb2peb_conversion:
 	return err;
 }
+
+/*
+ * ssdfs_maptbl_cache_init_page() - init page of maptbl cache
+ * @kaddr: pointer on maptbl cache's fragment
+ * @sequence_id: fragment's sequence ID number
+ *
+ * This method initialize empty maptbl cache fragment's page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_maptbl_cache_init_page(void *kaddr, unsigned sequence_id)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t magic_size = peb_state_size;
+	size_t threshold_size = hdr_size + magic_size;
+	__le32 *magic;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, sequence_id %u\n",
+		  kaddr, sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sequence_id >= PAGEVEC_SIZE) {
+		SSDFS_ERR("invalid sequence_id %u\n",
+			  sequence_id);
+		return -EINVAL;
+	}
+
+	memset(kaddr, 0, PAGE_SIZE);
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	hdr->magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	hdr->magic.key = cpu_to_le16(SSDFS_MAPTBL_CACHE_MAGIC);
+	hdr->magic.version.major = SSDFS_MAJOR_REVISION;
+	hdr->magic.version.minor = SSDFS_MINOR_REVISION;
+
+	hdr->sequence_id = cpu_to_le16((u16)sequence_id);
+	hdr->items_count = 0;
+	hdr->bytes_count = cpu_to_le16((u16)threshold_size);
+
+	hdr->start_leb = cpu_to_le64(U64_MAX);
+	hdr->end_leb = cpu_to_le64(U64_MAX);
+
+	magic = (__le32 *)((u8 *)kaddr + hdr_size);
+	*magic = cpu_to_le32(SSDFS_MAPTBL_CACHE_PEB_STATE_MAGIC);
+
+	return 0;
+}
+
+/*
+ * ssdfs_shift_right_peb_state_area() - shift the whole PEB state area
+ * @kaddr: pointer on maptbl cache's fragment
+ * @shift: size of shift in bytes
+ *
+ * This method tries to shift the whole PEB state area
+ * to the right in the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_shift_right_peb_state_area(void *kaddr, size_t shift)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	void *area = NULL;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t diff_count;
+	int area_size;
+	u32 area_offset = U32_MAX;
+	size_t bytes_count, new_bytes_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, shift %zu\n", kaddr, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (shift % pair_size) {
+		SSDFS_ERR("invalid request: "
+			  "shift %zu, pair_size %zu\n",
+			  shift, pair_size);
+		return -ERANGE;
+	}
+
+	diff_count = shift / pair_size;
+
+	if (diff_count == 0) {
+		SSDFS_ERR("invalid diff_count %zu\n", diff_count);
+		return -ERANGE;
+	}
+
+	area = PEB_STATE_AREA(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(area)) {
+		err = !area ? PTR_ERR(area) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	bytes_count = le16_to_cpu(hdr->bytes_count);
+
+	area_size = ssdfs_peb_state_area_size(hdr);
+	if (area_size < 0) {
+		err = area_size;
+		SSDFS_ERR("fail to calculate PEB state area's size: "
+			  "err %d\n", err);
+		return err;
+	} else if (area_size == 0) {
+		SSDFS_ERR("invalid PEB state area's size %d\n",
+			  area_size);
+		return -ERANGE;
+	}
+
+	new_bytes_count = bytes_count;
+	new_bytes_count += diff_count * pair_size;
+	new_bytes_count += diff_count * peb_state_size;
+
+	if (new_bytes_count > PAGE_SIZE) {
+		SSDFS_ERR("shift is out of memory page: "
+			  "new_bytes_count %zu, shift %zu\n",
+			  new_bytes_count, shift);
+		return -ERANGE;
+	}
+
+	err = ssdfs_memmove(area, shift, PAGE_SIZE - area_offset,
+			    area, 0, PAGE_SIZE - area_offset,
+			    area_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move: err %d\n", err);
+		return err;
+	}
+
+	hdr->bytes_count = cpu_to_le16((u16)new_bytes_count);
+
+	return 0;
+}
+
+/*
+ * ssdfs_shift_left_peb_state_area() - shift the whole PEB state area
+ * @kaddr: pointer on maptbl cache's fragment
+ * @shift: size of shift in bytes
+ *
+ * This method tries to shift the whole PEB state area
+ * to the left in the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_shift_left_peb_state_area(void *kaddr, size_t shift)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	void *area = NULL;
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t magic_size = peb_state_size;
+	size_t threshold_size = hdr_size + magic_size;
+	size_t diff_count;
+	int area_size;
+	u32 area_offset = U32_MAX;
+	size_t bytes_count;
+	size_t calculated;
+	size_t new_bytes_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, shift %zu\n", kaddr, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (shift % pair_size) {
+		SSDFS_ERR("invalid request: "
+			  "shift %zu, pair_size %zu\n",
+			  shift, pair_size);
+		return -ERANGE;
+	}
+
+	diff_count = shift / pair_size;
+
+	if (diff_count == 0) {
+		SSDFS_ERR("invalid diff_count %zu\n", diff_count);
+		return -ERANGE;
+	}
+
+	area = PEB_STATE_AREA(kaddr, &area_offset);
+
+	if (IS_ERR_OR_NULL(area)) {
+		err = !area ? PTR_ERR(area) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	bytes_count = le16_to_cpu(hdr->bytes_count);
+
+	area_size = ssdfs_peb_state_area_size(hdr);
+	if (area_size < 0) {
+		err = area_size;
+		SSDFS_ERR("fail to calculate PEB state area's size: "
+			  "err %d\n", err);
+		return err;
+	} else if (area_size == 0) {
+		SSDFS_ERR("invalid PEB state area's size %d\n",
+			  area_size);
+		return -ERANGE;
+	}
+
+	new_bytes_count = bytes_count;
+
+	calculated = diff_count * pair_size;
+	if (new_bytes_count <= calculated) {
+		SSDFS_ERR("invalid diff_count %zu\n",
+			  diff_count);
+		return -ERANGE;
+	}
+
+	new_bytes_count -= calculated;
+
+	calculated = diff_count * peb_state_size;
+
+	if (new_bytes_count <= calculated) {
+		SSDFS_ERR("invalid diff_count %zu\n",
+			  diff_count);
+		return -ERANGE;
+	}
+
+	new_bytes_count -= calculated;
+
+	if (new_bytes_count < threshold_size) {
+		SSDFS_ERR("shift is inside of header: "
+			  "new_bytes_count %zu, threshold_size %zu\n",
+			  new_bytes_count, threshold_size);
+		return -ERANGE;
+	}
+
+	if ((threshold_size + shift) >= area_offset) {
+		SSDFS_ERR("invalid shift: "
+			  "threshold_size %zu, shift %zu, "
+			  "area_offset %u\n",
+			  threshold_size, shift, area_offset);
+		return -ERANGE;
+	}
+
+	err = ssdfs_memmove((u8 *)area - shift, 0, PAGE_SIZE - area_offset,
+			    area, 0, PAGE_SIZE - area_offset,
+			    area_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move: err %d\n", err);
+		return err;
+	}
+
+	hdr->bytes_count = cpu_to_le16((u16)new_bytes_count);
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_add_leb() - add LEB/PEB pair into maptbl cache
+ * @kaddr: pointer on maptbl cache's fragment
+ * @item_index: index of item in the fragment
+ * @src_pair: inserting LEB/PEB pair
+ * @src_state: inserting PEB state
+ *
+ * This method tries to insert LEB/PEB pair and PEB state
+ * into the maptbl cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_cache_add_leb(void *kaddr, u16 item_index,
+				struct ssdfs_leb2peb_pair *src_pair,
+				struct ssdfs_maptbl_cache_peb_state *src_state)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *dest_pair;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	struct ssdfs_maptbl_cache_peb_state *dest_state;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !src_pair || !src_state);
+
+	SSDFS_DBG("kaddr %p, item_index %u, "
+		  "leb_id %llu, peb_id %llu\n",
+		  kaddr, item_index,
+		  le64_to_cpu(src_pair->leb_id),
+		  le64_to_cpu(src_pair->peb_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (item_index != items_count) {
+		SSDFS_ERR("item_index %u != items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	err = ssdfs_shift_right_peb_state_area(kaddr, pair_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to shift the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	dest_pair = LEB2PEB_PAIR_AREA(kaddr);
+	dest_pair += item_index;
+
+	ssdfs_memcpy(dest_pair, 0, pair_size,
+		     src_pair, 0, pair_size,
+		     pair_size);
+
+	dest_state = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(dest_state)) {
+		err = !dest_state ? PTR_ERR(dest_state) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	dest_state += item_index;
+
+	ssdfs_memcpy(dest_state, 0, peb_state_size,
+		     src_state, 0, peb_state_size,
+		     peb_state_size);
+
+	items_count++;
+	hdr->items_count = cpu_to_le16(items_count);
+
+	if (item_index == 0)
+		hdr->start_leb = src_pair->leb_id;
+
+	if ((item_index + 1) == items_count)
+		hdr->end_leb = src_pair->leb_id;
+
+	return 0;
+}
+
+struct page *
+ssdfs_maptbl_cache_add_pagevec_page(struct ssdfs_maptbl_cache *cache)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+
+	SSDFS_DBG("cache %p\n", cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_map_cache_add_pagevec_page(&cache->pvec);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		err = !page ? -ENOMEM : PTR_ERR(page);
+		SSDFS_ERR("fail to add pagevec page: err %d\n",
+			  err);
+	}
+
+	return page;
+}
+
+/*
+ * ssdfs_maptbl_cache_add_page() - add fragment into maptbl cache
+ * @cache: maptbl cache object
+ * @pair: adding LEB/PEB pair
+ * @state: adding PEB state
+ *
+ * This method tries to add fragment into maptbl cache,
+ * initialize it and insert LEB/PEB pair + PEB state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to add empty page into maptbl cache.
+ */
+static
+int ssdfs_maptbl_cache_add_page(struct ssdfs_maptbl_cache *cache,
+				struct ssdfs_leb2peb_pair *pair,
+				struct ssdfs_maptbl_cache_peb_state *state)
+{
+	struct page *page;
+	void *kaddr;
+	u16 item_index;
+	unsigned page_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pair || !state);
+
+	SSDFS_DBG("cache %p, leb_id %llu, peb_id %llu\n",
+		  cache, le64_to_cpu(pair->leb_id),
+		  le64_to_cpu(pair->peb_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = 0;
+	page_index = pagevec_count(&cache->pvec);
+
+	page = ssdfs_map_cache_add_pagevec_page(&cache->pvec);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		err = !page ? -ENOMEM : PTR_ERR(page);
+		SSDFS_ERR("fail to add pagevec page: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+
+	err = ssdfs_maptbl_cache_init_page(kaddr, page_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init maptbl cache's page: "
+			  "page_index %u, err %d\n",
+			  page_index, err);
+		goto finish_add_page;
+	}
+
+	atomic_add(PAGE_SIZE, &cache->bytes_count);
+
+	err = ssdfs_maptbl_cache_add_leb(kaddr, item_index, pair, state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add leb_id: "
+			  "page_index %u, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_add_page;
+	}
+
+finish_add_page:
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	return err;
+}
+
+/*
+ * is_fragment_full() - check that fragment is full
+ * @kaddr: pointer on maptbl cache's fragment
+ */
+static inline
+bool is_fragment_full(void *kaddr)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t bytes_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	bytes_count = le16_to_cpu(hdr->bytes_count);
+	bytes_count += pair_size + peb_state_size;
+
+	return bytes_count > PAGE_SIZE;
+}
+
+/*
+ * ssdfs_maptbl_cache_get_last_item() - get last item of the fragment
+ * @kaddr: pointer on maptbl cache's fragment
+ * @pair: pointer on LEB2PEB pair's buffer [out]
+ * @state: pointer on PEB state's buffer [out]
+ *
+ * This method tries to extract the last item
+ * (LEB2PEB pair + PEB state) from the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - empty maptbl cache's page.
+ */
+static
+int ssdfs_maptbl_cache_get_last_item(void *kaddr,
+				     struct ssdfs_leb2peb_pair *pair,
+				     struct ssdfs_maptbl_cache_peb_state *state)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *found_pair = NULL;
+	struct ssdfs_maptbl_cache_peb_state *found_state = NULL;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !pair || !state);
+
+	SSDFS_DBG("kaddr %p, pair %p, peb_state %p\n",
+		  kaddr, pair, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache's page\n");
+		return -ENODATA;
+	}
+
+	found_pair = LEB2PEB_PAIR_AREA(kaddr);
+	found_pair += items_count - 1;
+
+	ssdfs_memcpy(pair, 0, pair_size,
+		     found_pair, 0, pair_size,
+		     pair_size);
+
+	found_state = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(found_state)) {
+		err = !found_state ? PTR_ERR(found_state) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	found_state += items_count - 1;
+	ssdfs_memcpy(state, 0, peb_state_size,
+		     found_state, 0, peb_state_size,
+		     peb_state_size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_move_right_leb2peb_pairs() - move LEB2PEB pairs
+ * @kaddr: pointer on maptbl cache's fragment
+ * @item_index: starting index
+ *
+ * This method tries to move LEB2PEB pairs to the right
+ * starting from @item_index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_cache_move_right_leb2peb_pairs(void *kaddr,
+						u16 item_index)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *area;
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	u16 items_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, item_index %u\n",
+		  kaddr, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache page\n");
+		return -ERANGE;
+	}
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u > items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	area = LEB2PEB_PAIR_AREA(kaddr);
+	err = ssdfs_memmove(area,
+			    (item_index + 1) * pair_size,
+			    PAGE_SIZE - hdr_size,
+			    area,
+			    item_index * pair_size,
+			    PAGE_SIZE - hdr_size,
+			    (items_count - item_index) * pair_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_move_right_peb_states() - move PEB states
+ * @kaddr: pointer on maptbl cache's fragment
+ * @item_index: starting index
+ *
+ * This method tries to move PEB states to the right
+ * starting from @item_index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_cache_move_right_peb_states(void *kaddr,
+					     u16 item_index)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_maptbl_cache_peb_state *area;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, item_index %u\n",
+		  kaddr, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache page\n");
+		return -ERANGE;
+	}
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u > items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	area = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(area)) {
+		err = !area ? PTR_ERR(area) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_memmove(area,
+			    (item_index + 1) * peb_state_size,
+			    PAGE_SIZE - area_offset,
+			    area,
+			    item_index * peb_state_size,
+			    PAGE_SIZE - area_offset,
+			    (items_count - item_index) * peb_state_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_maptbl_cache_insert_leb() - insert item into the fragment
+ * @kaddr: pointer on maptbl cache's fragment
+ * @item_index: starting index
+ * @pair: adding LEB2PEB pair
+ * @state: adding PEB state
+ *
+ * This method tries to insert the item (LEB2PEB pair + PEB state)
+ * into the fragment in @item_index position.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_maptbl_cache_insert_leb(void *kaddr, u16 item_index,
+				    struct ssdfs_leb2peb_pair *pair,
+				    struct ssdfs_maptbl_cache_peb_state *state)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *dst_pair = NULL;
+	struct ssdfs_maptbl_cache_peb_state *dst_state = NULL;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !pair || !state);
+
+	SSDFS_DBG("kaddr %p, item_index %u, pair %p, state %p\n",
+		  kaddr, item_index, pair, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache page\n");
+		return -ERANGE;
+	}
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u > items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	dst_pair = LEB2PEB_PAIR_AREA(kaddr);
+	dst_pair += item_index;
+
+	ssdfs_memcpy(dst_pair, 0, pair_size,
+		     pair, 0, pair_size,
+		     pair_size);
+
+	dst_state = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(dst_state)) {
+		err = !dst_state ? PTR_ERR(dst_state) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	dst_state += item_index;
+
+	ssdfs_memcpy(dst_state, 0, peb_state_size,
+		     state, 0, peb_state_size,
+		     peb_state_size);
+
+	items_count++;
+	hdr->items_count = cpu_to_le16(items_count);
+
+	if (item_index == 0)
+		hdr->start_leb = pair->leb_id;
+
+	if ((item_index + 1) == items_count)
+		hdr->end_leb = pair->leb_id;
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_remove_leb() - remove item from the fragment
+ * @cache: maptbl cache object
+ * @page_index: index of the page
+ * @item_index: index of the item
+ *
+ * This method tries to remove the item (LEB/PEB pair + PEB state)
+ * from the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_cache_remove_leb(struct ssdfs_maptbl_cache *cache,
+				  unsigned page_index,
+				  u16 item_index)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *cur_pair;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	struct ssdfs_maptbl_cache_peb_state *cur_state;
+	struct page *page;
+	void *kaddr;
+	u16 items_count;
+	size_t size;
+	u32 area_offset = U32_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+	BUG_ON(page_index >= pagevec_count(&cache->pvec));
+
+	SSDFS_DBG("cache %p, page_index %u, item_index %u\n",
+		  cache, page_index, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = cache->pvec.pages[page_index];
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (item_index >= items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("item_index %u >= items_count %u\n",
+			  item_index, items_count);
+		goto finish_remove_item;
+	} else if (items_count == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("items_count %u\n", items_count);
+		goto finish_remove_item;
+	}
+
+	cur_pair = LEB2PEB_PAIR_AREA(kaddr);
+	cur_pair += item_index;
+
+	if ((item_index + 1) < items_count) {
+		size = items_count - item_index;
+		size *= pair_size;
+
+		memmove(cur_pair, cur_pair + 1, size);
+	}
+
+	cur_pair = LEB2PEB_PAIR_AREA(kaddr);
+	cur_pair += items_count - 1;
+	memset(cur_pair, 0xFF, pair_size);
+
+	cur_state = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(cur_state)) {
+		err = !cur_state ? PTR_ERR(cur_state) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		goto finish_remove_item;
+	}
+
+	cur_state += item_index;
+
+	if ((item_index + 1) < items_count) {
+		size = items_count - item_index;
+		size *= sizeof(struct ssdfs_maptbl_cache_peb_state);
+
+		memmove(cur_state, cur_state + 1, size);
+	}
+
+	cur_state = FIRST_PEB_STATE(kaddr, &area_offset);
+	cur_state += items_count - 1;
+	memset(cur_state, 0xFF, sizeof(struct ssdfs_maptbl_cache_peb_state));
+
+	items_count--;
+	hdr->items_count = cpu_to_le16(items_count);
+
+	err = ssdfs_shift_left_peb_state_area(kaddr, pair_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to shift PEB state area: "
+			  "err %d\n", err);
+		goto finish_remove_item;
+	}
+
+	if (items_count == 0) {
+		hdr->start_leb = U64_MAX;
+		hdr->end_leb = U64_MAX;
+	} else {
+		cur_pair = LEB2PEB_PAIR_AREA(kaddr);
+		hdr->start_leb = cur_pair->leb_id;
+
+		cur_pair += items_count - 1;
+		hdr->end_leb = cur_pair->leb_id;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_remove_item:
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	return err;
+}
+
+/*
+ * ssdfs_check_pre_deleted_peb_state() - check pre-deleted state of the item
+ * @cache: maptbl cache object
+ * @page_index: index of the page
+ * @item_index: index of the item
+ * @pair: adding LEB2PEB pair
+ *
+ * This method tries to check that requested item for @item_index
+ * has the PRE-DELETED consistency. If it's true then this item
+ * has to be deleted.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - requested LEB is absent.
+ * %-ENOENT     - requested LEB exists and should be saved.
+ */
+static
+int ssdfs_check_pre_deleted_peb_state(struct ssdfs_maptbl_cache *cache,
+				     unsigned page_index,
+				     u16 item_index,
+				     struct ssdfs_leb2peb_pair *pair)
+{
+	struct ssdfs_leb2peb_pair *cur_pair = NULL;
+	struct ssdfs_maptbl_cache_peb_state *cur_state = NULL;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pair);
+	BUG_ON(le64_to_cpu(pair->leb_id) == U64_MAX);
+	BUG_ON(le64_to_cpu(pair->peb_id) == U64_MAX);
+
+	SSDFS_DBG("cache %p, start_page %u, item_index %u\n",
+		  cache, page_index, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = cache->pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+
+	err = ssdfs_maptbl_cache_get_leb2peb_pair(kaddr, item_index, &cur_pair);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get LEB2PEB pair: err %d\n", err);
+		goto finish_check_pre_deleted_state;
+	}
+
+	if (le64_to_cpu(pair->leb_id) != le64_to_cpu(cur_pair->leb_id)) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("pair->leb_id %llu != cur_pair->leb_id %llu\n",
+			  le64_to_cpu(pair->leb_id),
+			  le64_to_cpu(cur_pair->leb_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_check_pre_deleted_state;
+	}
+
+	err = ssdfs_maptbl_cache_get_peb_state(kaddr, item_index, &cur_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get PEB state: err %d\n", err);
+		goto finish_check_pre_deleted_state;
+	}
+
+	switch (cur_state->consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+	case SSDFS_PEB_STATE_INCONSISTENT:
+		err = -ENOENT;
+		goto finish_check_pre_deleted_state;
+
+	case SSDFS_PEB_STATE_PRE_DELETED:
+		/* continue to delete */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("unexpected PEB's state %#x\n",
+			  cur_state->state);
+		goto finish_check_pre_deleted_state;
+	}
+
+finish_check_pre_deleted_state:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	if (err)
+		return err;
+
+	err = ssdfs_maptbl_cache_remove_leb(cache,
+					    page_index,
+					    item_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete LEB: "
+			  "page_index %d, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_insert_leb() - insert item into the fragment
+ * @cache: maptbl cache object
+ * @start_page: page index
+ * @item_index: index of the item
+ * @pair: adding LEB/PEB pair
+ * @state: adding PEB state
+ *
+ * This method tries to insert the item (LEB2PEB pair + PEB state)
+ * into the mapping table cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_cache_insert_leb(struct ssdfs_maptbl_cache *cache,
+				  unsigned start_page,
+				  u16 item_index,
+				  struct ssdfs_leb2peb_pair *pair,
+				  struct ssdfs_maptbl_cache_peb_state *state)
+{
+	struct ssdfs_leb2peb_pair cur_pair, saved_pair;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	struct ssdfs_maptbl_cache_peb_state cur_state, saved_state;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pair || !state);
+	BUG_ON(le64_to_cpu(pair->leb_id) == U64_MAX);
+	BUG_ON(le64_to_cpu(pair->peb_id) == U64_MAX);
+
+	SSDFS_DBG("cache %p, start_page %u, item_index %u, "
+		  "leb_id %llu, peb_id %llu\n",
+		  cache, start_page, item_index,
+		  le64_to_cpu(pair->leb_id),
+		  le64_to_cpu(pair->peb_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_check_pre_deleted_peb_state(cache, start_page,
+						item_index, pair);
+	if (err == -ENODATA) {
+		err = 0;
+		/*
+		 * No pre-deleted item was found.
+		 * Continue the logic.
+		 */
+	} else if (err == -ENOENT) {
+		/*
+		 * Valid item was found.
+		 */
+		err = 0;
+		item_index++;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to check the pre-deleted state: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	ssdfs_memcpy(&cur_pair, 0, pair_size,
+		     pair, 0, pair_size,
+		     pair_size);
+	ssdfs_memcpy(&cur_state, 0, peb_state_size,
+		     state, 0, peb_state_size,
+		     peb_state_size);
+
+	memset(&saved_pair, 0xFF, pair_size);
+	memset(&saved_state, 0xFF, peb_state_size);
+
+	for (; start_page < pagevec_count(&cache->pvec); start_page++) {
+		bool need_move_item = false;
+
+		page = cache->pvec.pages[start_page];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+
+		need_move_item = is_fragment_full(kaddr);
+
+		if (need_move_item) {
+			err = ssdfs_maptbl_cache_get_last_item(kaddr,
+							       &saved_pair,
+							       &saved_state);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to get last item: "
+					  "err %d\n", err);
+				goto finish_page_modification;
+			}
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_shift_right_peb_state_area(kaddr, pair_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to shift the PEB state area: "
+				  "err %d\n", err);
+			goto finish_page_modification;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_maptbl_cache_move_right_leb2peb_pairs(kaddr,
+								item_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move LEB2PEB pairs: "
+				  "page_index %u, item_index %u, "
+				  "err %d\n",
+				  start_page, item_index, err);
+			goto finish_page_modification;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_maptbl_cache_move_right_peb_states(kaddr,
+								item_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB states: "
+				  "page_index %u, item_index %u, "
+				  "err %d\n",
+				  start_page, item_index, err);
+			goto finish_page_modification;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = __ssdfs_maptbl_cache_insert_leb(kaddr, item_index,
+						      &cur_pair, &cur_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert leb descriptor: "
+				  "page_index %u, item_index %u, err %d\n",
+				  start_page, item_index, err);
+			goto finish_page_modification;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_page_modification:
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (err || !need_move_item)
+			goto finish_insert_leb;
+
+		item_index = 0;
+
+		if (need_move_item) {
+			ssdfs_memcpy(&cur_pair, 0, pair_size,
+				     &saved_pair, 0, pair_size,
+				     pair_size);
+			ssdfs_memcpy(&cur_state, 0, peb_state_size,
+				     &saved_state, 0, peb_state_size,
+				     peb_state_size);
+		}
+	}
+
+	err = ssdfs_maptbl_cache_add_page(cache, &cur_pair, &cur_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add page into maptbl cache: "
+			  "err %d\n",
+			  err);
+	}
+
+finish_insert_leb:
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_map_leb2peb() - save LEB/PEB pair into maptbl cache
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @pebr: descriptor of mapped LEB/PEB pair
+ * @consistency: consistency of the item
+ *
+ * This method tries to save the item (LEB/PEB pair + PEB state)
+ * into maptbl cache. If the item is consistent then it means that
+ * as mapping table cache as mapping table contain the same
+ * information about the item. Otherwise, for the case of inconsistent
+ * state, the mapping table cache contains the actual info about
+ * the item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - LEB/PEB pair is cached already.
+ */
+int ssdfs_maptbl_cache_map_leb2peb(struct ssdfs_maptbl_cache *cache,
+				   u64 leb_id,
+				   struct ssdfs_maptbl_peb_relation *pebr,
+				   int consistency)
+{
+	struct ssdfs_maptbl_cache_search_result res;
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *tmp_pair = NULL;
+	u16 item_index = U16_MAX;
+	struct ssdfs_leb2peb_pair cur_pair;
+	struct ssdfs_maptbl_cache_peb_state cur_state;
+	struct page *page;
+	void *kaddr;
+	unsigned i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pebr);
+	BUG_ON(leb_id == U64_MAX);
+
+	SSDFS_DBG("cache %p, leb_id %llu, pebr %p, consistency %#x\n",
+		  cache, leb_id, pebr, consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&res, 0xFF, sizeof(struct ssdfs_maptbl_cache_search_result));
+	res.pebs[SSDFS_MAPTBL_MAIN_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+	res.pebs[SSDFS_MAPTBL_RELATION_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+
+	cur_pair.leb_id = cpu_to_le64(leb_id);
+	cur_pair.peb_id =
+		cpu_to_le64(pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id);
+
+	switch (consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+	case SSDFS_PEB_STATE_INCONSISTENT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected consistency %#x\n",
+			  consistency);
+		return -EINVAL;
+	}
+
+	cur_state.consistency = (u8)consistency;
+	cur_state.state = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state;
+	cur_state.flags = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].flags;
+	cur_state.shared_peb_index =
+		pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].shared_peb_index;
+
+	down_write(&cache->lock);
+
+	for (i = 0; i < pagevec_count(&cache->pvec); i++) {
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = __ssdfs_maptbl_cache_find_leb(kaddr, i, leb_id, &res);
+		item_index = res.pebs[SSDFS_MAPTBL_MAIN_INDEX].item_index;
+		tmp_pair = &res.pebs[SSDFS_MAPTBL_MAIN_INDEX].found;
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (err == -EEXIST) {
+			SSDFS_ERR("maptbl cache contains leb_id %llu\n",
+				  leb_id);
+			break;
+		} else if (err == -EFAULT) {
+			/* we've found place */
+			break;
+		} else if (!err)
+			BUG();
+	}
+
+	if (i >= pagevec_count(&cache->pvec)) {
+		if (err == -ENODATA) {
+			/* correct page index */
+			i = pagevec_count(&cache->pvec) - 1;
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("i %u >= pages_count %u\n",
+				  i, pagevec_count(&cache->pvec));
+			goto finish_leb_caching;
+		}
+	}
+
+	if (err == -EEXIST)
+		goto finish_leb_caching;
+	else if (err == -E2BIG) {
+		err = ssdfs_maptbl_cache_add_page(cache, &cur_pair, &cur_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page into maptbl cache: "
+				  "err %d\n",
+				  err);
+			goto finish_leb_caching;
+		}
+	} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(i >= pagevec_count(&cache->pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		item_index = le16_to_cpu(hdr->items_count);
+		err = ssdfs_maptbl_cache_add_leb(kaddr, item_index,
+						 &cur_pair, &cur_state);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add leb_id: "
+				  "page_index %u, item_index %u, err %d\n",
+				  i, item_index, err);
+		}
+	} else if (err == -EFAULT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(i >= pagevec_count(&cache->pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_maptbl_cache_insert_leb(cache, i, item_index,
+						    &cur_pair, &cur_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add LEB with shift: "
+				  "page_index %u, item_index %u, err %d\n",
+				  i, item_index, err);
+			goto finish_leb_caching;
+		}
+	} else
+		BUG();
+
+finish_leb_caching:
+	up_write(&cache->lock);
+
+	return err;
+}
+
+/*
+ * __ssdfs_maptbl_cache_change_peb_state() - change PEB state of the item
+ * @cache: maptbl cache object
+ * @page_index: index of memory page
+ * @item_index: index of the item in the page
+ * @peb_state: new state of the PEB
+ * @consistency: consistency of the item
+ *
+ * This method tries to change the PEB state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - unable to get peb state.
+ * %-ERANGE     - internal error.
+ */
+static inline
+int __ssdfs_maptbl_cache_change_peb_state(struct ssdfs_maptbl_cache *cache,
+					  unsigned page_index,
+					  u16 item_index,
+					  int peb_state,
+					  int consistency)
+{
+	struct ssdfs_maptbl_cache_peb_state *found_state = NULL;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+	BUG_ON(!rwsem_is_locked(&cache->lock));
+
+	SSDFS_DBG("cache %p, page_index %u, item_index %u, "
+		  "peb_state %#x, consistency %#x\n",
+		  cache, page_index, item_index,
+		  peb_state, consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&cache->pvec)) {
+		SSDFS_ERR("invalid page index %u\n", page_index);
+		return -ERANGE;
+	}
+
+	page = cache->pvec.pages[page_index];
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+
+	err = ssdfs_maptbl_cache_get_peb_state(kaddr, item_index,
+						&found_state);
+	if (err == -EINVAL) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to get peb state: "
+			  "item_index %u\n",
+			  item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_page_modification;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb state: "
+			  "item_index %u, err %d\n",
+			  item_index, err);
+		goto finish_page_modification;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!found_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+		found_state->consistency = (u8)consistency;
+		found_state->state = (u8)peb_state;
+		break;
+
+	case SSDFS_PEB_STATE_INCONSISTENT:
+		if (found_state->state != (u8)peb_state) {
+			found_state->consistency = (u8)consistency;
+			found_state->state = (u8)peb_state;
+		}
+		break;
+
+	case SSDFS_PEB_STATE_PRE_DELETED:
+		found_state->consistency = (u8)consistency;
+		found_state->state = (u8)peb_state;
+		break;
+
+	default:
+		SSDFS_ERR("unexpected consistency %#x\n",
+			  consistency);
+		return -EINVAL;
+	}
+
+finish_page_modification:
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_define_relation_index() - define relation index
+ * @pebr: descriptor of mapped LEB/PEB pair
+ * @peb_state: new state of the PEB
+ * @relation_index: index of the item in relation [out]
+ */
+static int
+ssdfs_maptbl_cache_define_relation_index(struct ssdfs_maptbl_peb_relation *pebr,
+					 int peb_state,
+					 int *relation_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebr || !relation_index);
+
+	SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*relation_index = SSDFS_MAPTBL_RELATION_MAX;
+
+	switch (peb_state) {
+	case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+	case SSDFS_MAPTBL_USING_PEB_STATE:
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+		switch (pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency) {
+		case SSDFS_PEB_STATE_CONSISTENT:
+		case SSDFS_PEB_STATE_INCONSISTENT:
+			*relation_index = SSDFS_MAPTBL_MAIN_INDEX;
+			break;
+
+		case SSDFS_PEB_STATE_PRE_DELETED:
+			*relation_index = SSDFS_MAPTBL_RELATION_INDEX;
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		switch (pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency) {
+		case SSDFS_PEB_STATE_CONSISTENT:
+		case SSDFS_PEB_STATE_INCONSISTENT:
+			*relation_index = SSDFS_MAPTBL_MAIN_INDEX;
+			break;
+
+		case SSDFS_PEB_STATE_PRE_DELETED:
+			SSDFS_ERR("main index is pre-deleted\n");
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+		switch (pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency) {
+		case SSDFS_PEB_STATE_CONSISTENT:
+		case SSDFS_PEB_STATE_INCONSISTENT:
+			*relation_index = SSDFS_MAPTBL_RELATION_INDEX;
+			break;
+
+		case SSDFS_PEB_STATE_PRE_DELETED:
+			SSDFS_ERR("main index is pre-deleted\n");
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected peb_state %#x\n", peb_state);
+		return -EINVAL;
+	}
+
+	if (*relation_index == SSDFS_MAPTBL_RELATION_MAX) {
+		SSDFS_ERR("fail to define relation index\n");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * can_peb_state_be_changed() - check that PEB state can be changed
+ * @pebr: descriptor of mapped LEB/PEB pair
+ * @peb_state: new state of the PEB
+ * @consistency: consistency of the item
+ * @relation_index: index of the item in relation
+ */
+static
+bool can_peb_state_be_changed(struct ssdfs_maptbl_peb_relation *pebr,
+				int peb_state,
+				int consistency,
+				int relation_index)
+{
+	int old_consistency = SSDFS_PEB_STATE_UNKNOWN;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebr);
+
+	SSDFS_DBG("peb_state %#x, consistency %#x, relation_index %d\n",
+		  peb_state, consistency, relation_index);
+
+	SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (relation_index) {
+	case SSDFS_MAPTBL_MAIN_INDEX:
+		old_consistency =
+			pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency;
+
+		switch (consistency) {
+		case SSDFS_PEB_STATE_CONSISTENT:
+		case SSDFS_PEB_STATE_INCONSISTENT:
+			switch (old_consistency) {
+			case SSDFS_PEB_STATE_PRE_DELETED:
+				SSDFS_WARN("invalid consistency: "
+					   "peb_state %#x, consistency %#x, "
+					   "relation_index %d\n",
+					   peb_state,
+					   consistency,
+					   relation_index);
+				return false;
+
+			case SSDFS_PEB_STATE_CONSISTENT:
+			case SSDFS_PEB_STATE_INCONSISTENT:
+				/* valid consistency */
+				break;
+
+			default:
+				SSDFS_WARN("invalid old consistency %#x\n",
+					   old_consistency);
+				return false;
+			}
+
+		case SSDFS_PEB_STATE_PRE_DELETED:
+			/* valid consistency */
+			break;
+
+		default:
+			SSDFS_WARN("invalid consistency: "
+				   "peb_state %#x, consistency %#x, "
+				   "relation_index %d\n",
+				   peb_state,
+				   consistency,
+				   relation_index);
+			return false;
+		}
+
+		switch (pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state) {
+		case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_USING_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_USED_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	case SSDFS_MAPTBL_RELATION_INDEX:
+		old_consistency =
+			pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency;
+
+		switch (consistency) {
+		case SSDFS_PEB_STATE_CONSISTENT:
+		case SSDFS_PEB_STATE_INCONSISTENT:
+			switch (old_consistency) {
+			case SSDFS_PEB_STATE_CONSISTENT:
+			case SSDFS_PEB_STATE_INCONSISTENT:
+				/* valid consistency */
+				break;
+
+			default:
+				SSDFS_WARN("invalid old consistency %#x\n",
+					   old_consistency);
+				return false;
+			}
+			break;
+
+		default:
+			SSDFS_WARN("invalid consistency: "
+				   "peb_state %#x, consistency %#x, "
+				   "relation_index %d\n",
+				   peb_state,
+				   consistency,
+				   relation_index);
+			return false;
+		}
+
+		switch (pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_USING_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_USED_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+			case SSDFS_MAPTBL_USING_PEB_STATE:
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+				goto finish_check;
+
+			default:
+				SSDFS_ERR("invalid change: "
+					  "old peb_state %#x, "
+					  "new peb_state %#x\n",
+				    pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+				    peb_state);
+				return false;
+			}
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+finish_check:
+	return true;
+}
+
+/*
+ * ssdfs_maptbl_cache_change_peb_state_nolock() - change PEB state of the item
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @peb_state: new state of the PEB
+ * @consistency: consistency of the item
+ *
+ * This method tries to change the PEB state. If the item is consistent
+ * then it means that as mapping table cache as mapping table
+ * contain the same information about the item. Otherwise,
+ * for the case of inconsistent state, the mapping table cache contains
+ * the actual info about the item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_cache_change_peb_state_nolock(struct ssdfs_maptbl_cache *cache,
+						u64 leb_id, int peb_state,
+						int consistency)
+{
+	struct ssdfs_maptbl_cache_search_result res;
+	struct ssdfs_maptbl_peb_relation pebr;
+	int relation_index = SSDFS_MAPTBL_RELATION_MAX;
+	int state;
+	unsigned page_index;
+	u16 item_index = U16_MAX;
+	unsigned i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+	BUG_ON(leb_id == U64_MAX);
+	BUG_ON(!rwsem_is_locked(&cache->lock));
+
+	SSDFS_DBG("cache %p, leb_id %llu, peb_state %#x, consistency %#x\n",
+		  cache, leb_id, peb_state, consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+	case SSDFS_PEB_STATE_INCONSISTENT:
+	case SSDFS_PEB_STATE_PRE_DELETED:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected consistency %#x\n",
+			  consistency);
+		return -EINVAL;
+	}
+
+	switch (peb_state) {
+	case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+	case SSDFS_MAPTBL_USING_PEB_STATE:
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected peb_state %#x\n", peb_state);
+		return -EINVAL;
+	}
+
+	err = ssdfs_maptbl_cache_find_leb(cache, leb_id, &res, &pebr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find: leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_peb_state_change;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MAIN_INDEX: state %#x, page_index %u, item_index %u; "
+		  "RELATION_INDEX: state %#x, page_index %u, item_index %u\n",
+		  res.pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  res.pebs[SSDFS_MAPTBL_MAIN_INDEX].page_index,
+		  res.pebs[SSDFS_MAPTBL_MAIN_INDEX].item_index,
+		  res.pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  res.pebs[SSDFS_MAPTBL_RELATION_INDEX].page_index,
+		  res.pebs[SSDFS_MAPTBL_RELATION_INDEX].item_index);
+
+	SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_cache_define_relation_index(&pebr, peb_state,
+							&relation_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define relation index: "
+			  "leb_id %llu, peb_state %#x, err %d\n",
+			  leb_id, peb_state, err);
+		goto finish_peb_state_change;
+	}
+
+	if (!can_peb_state_be_changed(&pebr, peb_state,
+					consistency, relation_index)) {
+		err = -ERANGE;
+		SSDFS_ERR("PEB state cannot be changed: "
+			  "leb_id %llu, peb_state %#x, "
+			  "consistency %#x, relation_index %d\n",
+			  leb_id, peb_state, consistency, relation_index);
+		goto finish_peb_state_change;
+	}
+
+	state = res.pebs[relation_index].state;
+	if (state != SSDFS_MAPTBL_CACHE_ITEM_FOUND) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to change peb state: "
+			  "state %#x\n",
+			  state);
+		goto finish_peb_state_change;
+	}
+
+	page_index = res.pebs[relation_index].page_index;
+	item_index = res.pebs[relation_index].item_index;
+
+	err = __ssdfs_maptbl_cache_change_peb_state(cache,
+						    page_index,
+						    item_index,
+						    peb_state,
+						    consistency);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change peb state: "
+			  "page_index %u, item_index %u, "
+			  "err %d\n",
+			  page_index, item_index, err);
+		goto finish_peb_state_change;
+	}
+
+finish_peb_state_change:
+	if (unlikely(err)) {
+		struct page *page;
+		void *kaddr;
+
+		for (i = 0; i < pagevec_count(&cache->pvec); i++) {
+			page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_lock_page(page);
+			kaddr = kmap_local_page(page);
+			ssdfs_maptbl_cache_show_items(kaddr);
+			kunmap_local(kaddr);
+			ssdfs_unlock_page(page);
+		}
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_change_peb_state() - change PEB state of the item
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @peb_state: new state of the PEB
+ * @consistency: consistency of the item
+ *
+ * This method tries to change the PEB state. If the item is consistent
+ * then it means that as mapping table cache as mapping table
+ * contain the same information about the item. Otherwise,
+ * for the case of inconsistent state, the mapping table cache contains
+ * the actual info about the item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_cache_change_peb_state(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id, int peb_state,
+					int consistency)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+	BUG_ON(leb_id == U64_MAX);
+
+	SSDFS_DBG("cache %p, leb_id %llu, peb_state %#x, consistency %#x\n",
+		  cache, leb_id, peb_state, consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&cache->lock);
+	err = ssdfs_maptbl_cache_change_peb_state_nolock(cache,
+							 leb_id,
+							 peb_state,
+							 consistency);
+	up_write(&cache->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_add_migration_peb() - add item for migration PEB
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @pebr: descriptor of mapped LEB/PEB pair
+ * @consistency: consistency of the item
+ *
+ * This method tries to add the item (LEB2PEB pair + PEB state)
+ * for the migration PEB. If the item is consistent
+ * then it means that as mapping table cache as mapping table
+ * contain the same information about the item. Otherwise,
+ * for the case of inconsistent state, the mapping table cache contains
+ * the actual info about the item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_cache_add_migration_peb(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr,
+					 int consistency)
+{
+	struct ssdfs_maptbl_cache_search_result res;
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *tmp_pair = NULL;
+	u16 item_index = U16_MAX, items_count = U16_MAX;
+	struct ssdfs_leb2peb_pair cur_pair;
+	struct ssdfs_maptbl_cache_peb_state cur_state;
+	struct page *page;
+	void *kaddr;
+	unsigned i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pebr);
+	BUG_ON(leb_id == U64_MAX);
+
+	SSDFS_DBG("cache %p, leb_id %llu, pebr %p, consistency %#x\n",
+		  cache, leb_id, pebr, consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&res, 0xFF, sizeof(struct ssdfs_maptbl_cache_search_result));
+	res.pebs[SSDFS_MAPTBL_MAIN_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+	res.pebs[SSDFS_MAPTBL_RELATION_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+
+	cur_pair.leb_id = cpu_to_le64(leb_id);
+	cur_pair.peb_id =
+		cpu_to_le64(pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id);
+
+	switch (consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+	case SSDFS_PEB_STATE_INCONSISTENT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected consistency %#x\n",
+			  consistency);
+		return -EINVAL;
+	}
+
+	cur_state.consistency = (u8)consistency;
+	cur_state.state = pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state;
+	cur_state.flags = pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].flags;
+	cur_state.shared_peb_index =
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].shared_peb_index;
+
+	down_write(&cache->lock);
+
+	for (i = 0; i < pagevec_count(&cache->pvec); i++) {
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		items_count = le16_to_cpu(hdr->items_count);
+		err = __ssdfs_maptbl_cache_find_leb(kaddr, i, leb_id, &res);
+		item_index = res.pebs[SSDFS_MAPTBL_MAIN_INDEX].item_index;
+		tmp_pair = &res.pebs[SSDFS_MAPTBL_MAIN_INDEX].found;
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (err == -EEXIST || err == -EFAULT)
+			break;
+		else if (err != -E2BIG && err != -ENODATA)
+			break;
+		else if (err == -EAGAIN)
+			continue;
+		else if (!err)
+			BUG();
+	}
+
+	if (err != -EEXIST && err != -EAGAIN) {
+		SSDFS_ERR("maptbl cache hasn't item for leb_id %llu, err %d\n",
+			  leb_id, err);
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		ssdfs_maptbl_cache_show_items(kaddr);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		goto finish_add_migration_peb;
+	}
+
+	if ((item_index + 1) >= ssdfs_maptbl_cache_fragment_capacity()) {
+		err = ssdfs_maptbl_cache_add_page(cache, &cur_pair, &cur_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page into maptbl cache: "
+				  "err %d\n",
+				  err);
+			goto finish_add_migration_peb;
+		}
+	} else if ((item_index + 1) < items_count) {
+		err = ssdfs_maptbl_cache_insert_leb(cache, i, item_index,
+						    &cur_pair, &cur_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert LEB: "
+				  "page_index %u, item_index %u, err %d\n",
+				  i, item_index, err);
+			goto finish_add_migration_peb;
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(i >= pagevec_count(&cache->pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		item_index = le16_to_cpu(hdr->items_count);
+		err = ssdfs_maptbl_cache_add_leb(kaddr, item_index,
+						 &cur_pair, &cur_state);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add leb_id: "
+				  "page_index %u, item_index %u, err %d\n",
+				  i, item_index, err);
+			goto finish_add_migration_peb;
+		}
+	}
+
+finish_add_migration_peb:
+	up_write(&cache->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_get_first_item() - get first item of the fragment
+ * @kaddr: pointer on maptbl cache's fragment
+ * @pair: pointer on LEB2PEB pair's buffer [out]
+ * @state: pointer on PEB state's buffer [out]
+ *
+ * This method tries to retrieve the first item of the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - empty maptbl cache page.
+ */
+static
+int ssdfs_maptbl_cache_get_first_item(void *kaddr,
+				     struct ssdfs_leb2peb_pair *pair,
+				     struct ssdfs_maptbl_cache_peb_state *state)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *found_pair = NULL;
+	struct ssdfs_maptbl_cache_peb_state *found_state = NULL;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !pair || !state);
+
+	SSDFS_DBG("kaddr %p, pair %p, peb_state %p\n",
+		  kaddr, pair, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache page\n");
+		return -ENODATA;
+	}
+
+	found_pair = LEB2PEB_PAIR_AREA(kaddr);
+	ssdfs_memcpy(pair, 0, pair_size,
+		     found_pair, 0, pair_size,
+		     pair_size);
+
+	found_state = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(found_state)) {
+		err = !found_state ? PTR_ERR(found_state) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	ssdfs_memcpy(state, 0, peb_state_size,
+		     found_state, 0, peb_state_size,
+		     peb_state_size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_move_left_leb2peb_pairs() - move LEB2PEB pairs
+ * @kaddr: pointer on maptbl cache's fragment
+ * @item_index: starting index
+ *
+ * This method tries to move the LEB2PEB pairs on one position
+ * to the left starting from @item_index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+#ifdef CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC
+static
+int ssdfs_maptbl_cache_move_left_leb2peb_pairs(void *kaddr,
+						u16 item_index)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *area;
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	u16 items_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, item_index %u\n",
+		  kaddr, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (item_index == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("do nothing: item_index %u\n",
+			  item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache page\n");
+		return -ERANGE;
+	}
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u > items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	area = LEB2PEB_PAIR_AREA(kaddr);
+	err = ssdfs_memmove(area,
+			    (item_index - 1) * pair_size,
+			    PAGE_SIZE - hdr_size,
+			    area,
+			    item_index * pair_size,
+			    PAGE_SIZE - hdr_size,
+			    (items_count - item_index) * pair_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC */
+
+/*
+ * ssdfs_maptbl_cache_move_left_peb_states() - move PEB states
+ * @kaddr: pointer on maptbl cache's fragment
+ * @item_index: starting index
+ *
+ * This method tries to move the PEB states on one position
+ * to the left starting from @item_index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+#ifdef CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC
+static
+int ssdfs_maptbl_cache_move_left_peb_states(void *kaddr,
+					     u16 item_index)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_maptbl_cache_peb_state *area;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, item_index %u\n",
+		  kaddr, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (item_index == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("do nothing: item_index %u\n",
+			  item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache page\n");
+		return -ERANGE;
+	}
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u > items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	area = FIRST_PEB_STATE(kaddr, &area_offset);
+	if (IS_ERR_OR_NULL(area)) {
+		err = !area ? PTR_ERR(area) : -ERANGE;
+		SSDFS_ERR("fail to get the PEB state area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_memmove(area,
+			    (item_index - 1) * peb_state_size,
+			    PAGE_SIZE - area_offset,
+			    area,
+			    item_index * peb_state_size,
+			    PAGE_SIZE - area_offset,
+			    (items_count - item_index) * peb_state_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC */
+
+/*
+ * ssdfs_maptbl_cache_forget_leb2peb_nolock() - exclude LEB/PEB pair from cache
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @consistency: consistency of the item
+ *
+ * This method tries to exclude LEB/PEB pair from the cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_cache_forget_leb2peb_nolock(struct ssdfs_maptbl_cache *cache,
+					     u64 leb_id,
+					     int consistency)
+{
+	struct ssdfs_maptbl_cache_search_result res;
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *found_pair = NULL;
+	struct ssdfs_leb2peb_pair saved_pair;
+	struct ssdfs_maptbl_cache_peb_state *found_state = NULL;
+	struct ssdfs_maptbl_cache_peb_state saved_state;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	struct page *page;
+	void *kaddr;
+	u16 item_index, items_count;
+	unsigned i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+	BUG_ON(leb_id == U64_MAX);
+	BUG_ON(!rwsem_is_locked(&cache->lock));
+
+	SSDFS_DBG("cache %p, leb_id %llu, consistency %#x\n",
+		  cache, leb_id, consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&res, 0xFF, sizeof(struct ssdfs_maptbl_cache_search_result));
+	res.pebs[SSDFS_MAPTBL_MAIN_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+	res.pebs[SSDFS_MAPTBL_RELATION_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+
+	switch (consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+	case SSDFS_PEB_STATE_PRE_DELETED:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected consistency %#x\n",
+			  consistency);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pagevec_count(&cache->pvec); i++) {
+		struct ssdfs_maptbl_cache_header *hdr;
+		int search_state;
+
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		items_count = le16_to_cpu(hdr->items_count);
+
+		err = __ssdfs_maptbl_cache_find_leb(kaddr, i, leb_id, &res);
+		item_index = res.pebs[SSDFS_MAPTBL_MAIN_INDEX].item_index;
+		found_pair = &res.pebs[SSDFS_MAPTBL_MAIN_INDEX].found;
+		search_state = res.pebs[SSDFS_MAPTBL_RELATION_INDEX].state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("MAIN_INDEX: state %#x, "
+			  "page_index %u, item_index %u; "
+			  "RELATION_INDEX: state %#x, "
+			  "page_index %u, item_index %u\n",
+			  res.pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+			  res.pebs[SSDFS_MAPTBL_MAIN_INDEX].page_index,
+			  res.pebs[SSDFS_MAPTBL_MAIN_INDEX].item_index,
+			  res.pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+			  res.pebs[SSDFS_MAPTBL_RELATION_INDEX].page_index,
+			  res.pebs[SSDFS_MAPTBL_RELATION_INDEX].item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -EEXIST || err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(le64_to_cpu(found_pair->leb_id) != leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			switch (search_state) {
+			case SSDFS_MAPTBL_CACHE_ITEM_FOUND:
+				if ((item_index + 1) >= items_count) {
+					err = -ERANGE;
+					SSDFS_ERR("invalid position found: "
+						  "item_index %u, "
+						  "items_count %u\n",
+						  item_index, items_count);
+				}
+				break;
+
+			case SSDFS_MAPTBL_CACHE_ITEM_ABSENT:
+				if ((item_index + 1) > items_count) {
+					err = -ERANGE;
+					SSDFS_ERR("invalid position found: "
+						  "item_index %u, "
+						  "items_count %u\n",
+						  item_index, items_count);
+				}
+				break;
+
+			default:
+				SSDFS_ERR("unexpected state %#x\n",
+					  search_state);
+				break;
+			}
+
+			err = ssdfs_maptbl_cache_get_peb_state(kaddr,
+							       item_index,
+							       &found_state);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to get peb state: "
+					  "item_index %u, err %d\n",
+					  item_index, err);
+			} else {
+				ssdfs_memcpy(&saved_state, 0, peb_state_size,
+					     found_state, 0, peb_state_size,
+					     peb_state_size);
+			}
+
+			/* it is expected existence of the item */
+			err = -EEXIST;
+		}
+
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (err == -EEXIST || err == -EFAULT)
+			break;
+		else if (err != -E2BIG && err != -ENODATA)
+			break;
+		else if (!err)
+			BUG();
+	}
+
+	if (err != -EEXIST)
+		goto finish_exclude_migration_peb;
+
+	if (consistency == SSDFS_PEB_STATE_PRE_DELETED) {
+		/* simply change the state */
+		goto finish_exclude_migration_peb;
+	} else {
+		unsigned page_index = i;
+		u16 deleted_item = item_index;
+		u8 new_peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
+
+		err = ssdfs_maptbl_cache_remove_leb(cache, i, item_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to remove LEB: "
+				  "page_index %u, item_index %u, err %d\n",
+				  i, item_index, err);
+			goto finish_exclude_migration_peb;
+		}
+
+		for (++i; i < pagevec_count(&cache->pvec); i++) {
+			page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_lock_page(page);
+			kaddr = kmap_local_page(page);
+			err = ssdfs_maptbl_cache_get_first_item(kaddr,
+							       &saved_pair,
+							       &saved_state);
+			kunmap_local(kaddr);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to get first item: "
+					  "err %d\n", err);
+				goto finish_exclude_migration_peb;
+			}
+
+			page = cache->pvec.pages[i - 1];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_lock_page(page);
+			kaddr = kmap_local_page(page);
+
+			hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+			items_count = le16_to_cpu(hdr->items_count);
+			if (items_count == 0)
+				item_index = 0;
+			else
+				item_index = items_count;
+
+			err = ssdfs_maptbl_cache_add_leb(kaddr, item_index,
+							 &saved_pair,
+							 &saved_state);
+
+			flush_dcache_page(page);
+			kunmap_local(kaddr);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add leb_id: "
+					  "page_index %u, item_index %u, "
+					  "err %d\n",
+					  i, item_index, err);
+				goto finish_exclude_migration_peb;
+			}
+
+			item_index = 0;
+			err = ssdfs_maptbl_cache_remove_leb(cache, i,
+							    item_index);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to remove LEB: "
+					  "page_index %u, item_index %u, "
+					  "err %d\n",
+					  i, item_index, err);
+				goto finish_exclude_migration_peb;
+			}
+		}
+
+		i = pagevec_count(&cache->pvec);
+		if (i == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid number of fragments %u\n", i);
+			goto finish_exclude_migration_peb;
+		} else
+			i--;
+
+		if (i < page_index) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid page index: "
+				  "i %u, page_index %u\n",
+				  i, page_index);
+			goto finish_exclude_migration_peb;
+		}
+
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		items_count = le16_to_cpu(hdr->items_count);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (items_count == 0) {
+			cache->pvec.pages[i] = NULL;
+			cache->pvec.nr--;
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_map_cache_free_page(page);
+			atomic_sub(PAGE_SIZE, &cache->bytes_count);
+
+			if (i == page_index) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("do nothing: "
+					  "page %u was deleted\n",
+					  page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_exclude_migration_peb;
+			}
+		}
+
+		switch (saved_state.state) {
+		case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+		case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+		case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+			/* continue logic */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("do not change PEB state: "
+				  "page_index %u, deleted_item %u, "
+				  "state %#x\n",
+				  page_index, deleted_item,
+				  saved_state.state);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_exclude_migration_peb;
+		}
+
+		if (deleted_item >= items_count) {
+			err = -ERANGE;
+			SSDFS_ERR("deleted_item %u >= items_count %u\n",
+				  deleted_item, items_count);
+			goto finish_exclude_migration_peb;
+		}
+
+		page = cache->pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = ssdfs_maptbl_cache_get_peb_state(kaddr,
+						       deleted_item,
+						       &found_state);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb state: "
+				  "item_index %u, err %d\n",
+				  deleted_item, err);
+			goto finish_exclude_migration_peb;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found_state->state %#x\n",
+			  found_state->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		switch (found_state->state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			new_peb_state = SSDFS_MAPTBL_CLEAN_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			new_peb_state = SSDFS_MAPTBL_USING_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			new_peb_state = SSDFS_MAPTBL_USED_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			new_peb_state = SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			new_peb_state = SSDFS_MAPTBL_DIRTY_PEB_STATE;
+			break;
+
+		default:
+			/* do nothing */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB not under migration: "
+				  "state %#x\n",
+				  found_state->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_exclude_migration_peb;
+		}
+
+		err = __ssdfs_maptbl_cache_change_peb_state(cache,
+							    page_index,
+							    deleted_item,
+							    new_peb_state,
+							    consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change peb state: "
+				  "page_index %u, item_index %u, "
+				  "err %d\n",
+				  page_index, deleted_item, err);
+			goto finish_exclude_migration_peb;
+		}
+	}
+
+finish_exclude_migration_peb:
+	if (consistency == SSDFS_PEB_STATE_PRE_DELETED) {
+		err = ssdfs_maptbl_cache_change_peb_state_nolock(cache, leb_id,
+							    saved_state.state,
+							    consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change PEB state: err %d\n", err);
+			return err;
+		}
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_exclude_migration_peb() - exclude migration PEB
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @consistency: consistency of the item
+ *
+ * This method tries to exclude LEB/PEB pair after
+ * finishing the migration.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_cache_exclude_migration_peb(struct ssdfs_maptbl_cache *cache,
+					     u64 leb_id,
+					     int consistency)
+{
+	int err;
+
+	down_write(&cache->lock);
+	err = ssdfs_maptbl_cache_forget_leb2peb_nolock(cache, leb_id,
+							consistency);
+	up_write(&cache->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_forget_leb2peb() - exclude LEB/PEB pair from cache
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @consistency: consistency of the item
+ *
+ * This method tries to exclude LEB/PEB pair from the cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_cache_forget_leb2peb(struct ssdfs_maptbl_cache *cache,
+				      u64 leb_id,
+				      int consistency)
+{
+	int err;
+
+	down_write(&cache->lock);
+	err = ssdfs_maptbl_cache_forget_leb2peb_nolock(cache, leb_id,
+							consistency);
+	up_write(&cache->lock);
+
+	return err;
+}
-- 
2.34.1

