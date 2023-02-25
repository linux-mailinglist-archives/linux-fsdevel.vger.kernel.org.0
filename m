Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B06A2647
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBYBRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBYBQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:48 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5312879
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s41so5936oiw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjqG8CyOgJaOW/X4m7IOU9xnMCFRPpnm81JOAFbDQdM=;
        b=yZ/GwWugZjfV+CSDUO6YYm2vu/waVlvoBO49C2Ur9ZsA4mPK0IISyhWbCw5UqjGM/C
         3hoXp1AY3zTHQFxEbFY6/1qWSnPzvTsADvAPkE3OfOZOfMESKg1aDpHMeuZDQ+/ml+Ys
         NNiQt/AIjKIs4vXDCpDtpmtlogJlX0QKKsZovCSVzxM/XpHlZ9jUnyZNBsNREhHiHPoP
         4qLieT1TQ498UqFwH5/MgIVW2n/OJh6j2fn2+GgVwmIqpCxQ2V73dbzYg9iRYviQj9V+
         yYIWdawEUbEWTZDmXW8bcyCNmf0z5WraHmMHOFwVQi/JAKP/xcG83faBWjWcqZU6it95
         fyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjqG8CyOgJaOW/X4m7IOU9xnMCFRPpnm81JOAFbDQdM=;
        b=eQ7lQ2aH6nz4aY2cdSuyDkJtjZzGXLRye02pimx21klSZ2WOJWp7Nt3+KYgco3mlX5
         x+vnsVD7WT6HLzeASWhTcmAqFAhvXuGY5yoAvu7tf4eP8mdGDdduk+4qG83UubJT0bzT
         FCI/QIMNQiY43FzOfS+vN8+4k67oofyIWNRfh5LzYZN9ViVBv7NJQJSeokqM6IhYYV29
         6Y5sbibstIglwYNykspLAMSgnMj91bE9Suojy7fVy97+mzATSScUyj0lWL5LGBLBxbpz
         iP2lhkhdfFolHk/MugFBL6d54kiJiYZakkLTxe8Oz2nV3SGhi/IgSPdtG4YOGYoMt2Ot
         3mjg==
X-Gm-Message-State: AO0yUKUUqGDRjSNHdItsUmN2aechvDumiwSazLE1D886DjZr8vaNuyBn
        8fVuQO5wO9nvQTj/h2//OTWvE/8x6k5qnRku
X-Google-Smtp-Source: AK7set8fy66UL162BGmZDf+Scp1Eyqpig59AHfHxhNP9QFnABWfiCXECk/rPP7Sq4tYijFJU0WGUNw==
X-Received: by 2002:aca:1c0a:0:b0:384:232:2a4f with SMTP id c10-20020aca1c0a000000b0038402322a4fmr1289235oic.4.1677287798021;
        Fri, 24 Feb 2023 17:16:38 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:37 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 30/76] ssdfs: commit log payload
Date:   Fri, 24 Feb 2023 17:08:41 -0800
Message-Id: <20230225010927.813929-31-slava@dubeyko.com>
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

Log can be imagined like a container that keeps user data or
metadata of SSDFS metadata structures. Every log starts from
header (and can be finished by footer). Header and footer are
log's metadata structures that describes the structure of
log's payload. Initially, flush thread processes create and
update requests and payload of these requests is compressed
and then is compacted (ot aggregated) into contigous sequence
of memory pages. When full log is ready or commit request has
been received, flush thread executes commit log logic. This logic
includes the steps: (1) reserve space for header, (2) define
commit strategy (full or partial log), (3) store block bitmap,
(4) store offset translation table, (5) copy content of main,
journal, or diff-on-write areas into log's payload, (6) create
and store log's footer (optional logic), (7) create and store
header into reserved space.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_flush_thread.c | 3341 +++++++++++++++++++++++++++++++++++
 1 file changed, 3341 insertions(+)

diff --git a/fs/ssdfs/peb_flush_thread.c b/fs/ssdfs/peb_flush_thread.c
index d9352804f6b9..2de4bb806678 100644
--- a/fs/ssdfs/peb_flush_thread.c
+++ b/fs/ssdfs/peb_flush_thread.c
@@ -113,6 +113,3347 @@ void ssdfs_flush_check_memory_leaks(void)
  *                         FLUSH THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * ssdfs_peb_has_dirty_pages() - check that PEB has dirty pages
+ * @pebi: pointer on PEB object
+ */
+bool ssdfs_peb_has_dirty_pages(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_page_array *area_pages;
+	bool is_peb_dirty = false;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_LOG_AREA_MAX; i++) {
+		area_pages = &pebi->current_log.area[i].array;
+
+		if (atomic_read(&area_pages->state) == SSDFS_PAGE_ARRAY_DIRTY) {
+			is_peb_dirty = true;
+			break;
+		}
+	}
+
+	return is_peb_dirty;
+}
+
+/*
+ * is_full_log_ready() - check that full log is ready
+ * @pebi: pointer on PEB object
+ */
+static inline
+bool is_full_log_ready(struct ssdfs_peb_info *pebi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, free_data_pages %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return pebi->current_log.free_data_pages == 0;
+}
+
+/*
+ * should_partial_log_being_commited() - check that it's time to commit
+ * @pebi: pointer on PEB object
+ */
+static inline
+bool should_partial_log_being_commited(struct ssdfs_peb_info *pebi)
+{
+	u16 free_data_pages;
+	u16 min_partial_log_pages;
+	int log_strategy;
+	bool time_to_commit = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	free_data_pages = pebi->current_log.free_data_pages;
+	min_partial_log_pages = ssdfs_peb_estimate_min_partial_log_pages(pebi);
+
+	log_strategy = is_log_partial(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, log_strategy %#x, "
+		  "free_data_pages %u, min_partial_log_pages %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, log_strategy,
+		  free_data_pages, min_partial_log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (log_strategy) {
+	case SSDFS_START_FULL_LOG:
+	case SSDFS_START_PARTIAL_LOG:
+		if (free_data_pages <= min_partial_log_pages) {
+			time_to_commit = true;
+		} else {
+			time_to_commit = false;
+		}
+		break;
+
+	case SSDFS_CONTINUE_PARTIAL_LOG:
+	case SSDFS_FINISH_PARTIAL_LOG:
+	case SSDFS_FINISH_FULL_LOG:
+		/* do nothing */
+		time_to_commit = false;
+		break;
+
+	default:
+		SSDFS_CRIT("unexpected log strategy %#x\n",
+			   log_strategy);
+		time_to_commit = false;
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("time_to_commit %#x\n", time_to_commit);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return time_to_commit;
+}
+
+/*
+ * ssdfs_reserve_segment_header() - reserve space for segment header
+ * @pebi: pointer on PEB object
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function reserves space for segment header in PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - fail to allocate page.
+ */
+static
+int ssdfs_reserve_segment_header(struct ssdfs_peb_info *pebi,
+				 pgoff_t *cur_page, u32 *write_offset)
+{
+	struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!cur_page || !write_offset);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+
+	if (*cur_page != pebi->current_log.start_page) {
+		SSDFS_ERR("cur_page %lu != start_page %u\n",
+			  *cur_page, pebi->current_log.start_page);
+		return -EINVAL;
+	}
+
+	if (*write_offset != 0) {
+		SSDFS_ERR("write_offset %u != 0\n",
+			  *write_offset);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, *cur_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to grab cache page: index %lu\n",
+			  *cur_page);
+		return -ENOMEM;
+	}
+
+	/* prepare header space */
+	ssdfs_memset_page(page, 0, PAGE_SIZE, 0xFF, PAGE_SIZE);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*write_offset = offsetof(struct ssdfs_segment_header, payload);
+
+	return 0;
+}
+
+/*
+ * ssdfs_reserve_partial_log_header() - reserve space for partial log's header
+ * @pebi: pointer on PEB object
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function reserves space for partial log's header in PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - fail to allocate page.
+ */
+static
+int ssdfs_reserve_partial_log_header(struct ssdfs_peb_info *pebi,
+				     pgoff_t *cur_page, u32 *write_offset)
+{
+	struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!cur_page || !write_offset);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+
+	if (*cur_page != pebi->current_log.start_page) {
+		SSDFS_ERR("cur_page %lu != start_page %u\n",
+			  *cur_page, pebi->current_log.start_page);
+		return -EINVAL;
+	}
+
+	if (*write_offset != 0) {
+		SSDFS_ERR("write_offset %u != 0\n",
+			  *write_offset);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, *cur_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to grab cache page: index %lu\n",
+			  *cur_page);
+		return -ENOMEM;
+	}
+
+	/* prepare header space */
+	ssdfs_memset_page(page, 0, PAGE_SIZE, 0xFF, PAGE_SIZE);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*write_offset = offsetof(struct ssdfs_partial_log_header, payload);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_pagevec() - store pagevec into page cache
+ * @desc: descriptor of pagevec environment
+ *
+ * This function tries to store pagevec into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_pagevec(struct ssdfs_pagevec_descriptor *desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *src_page, *dst_page;
+	unsigned char *kaddr;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc);
+	BUG_ON(!desc->pebi || !desc->pebi->pebc->parent_si);
+	BUG_ON(!desc->pebi->pebc->parent_si->fsi);
+	BUG_ON(!desc->page_vec || !desc->desc_array);
+	BUG_ON(!desc->cur_page || !desc->write_offset);
+
+	switch (desc->compression_type) {
+	case SSDFS_FRAGMENT_UNCOMPR_BLOB:
+	case SSDFS_FRAGMENT_ZLIB_BLOB:
+	case SSDFS_FRAGMENT_LZO_BLOB:
+		/* valid type */
+		break;
+
+	default:
+		SSDFS_WARN("invalid compression %#x\n",
+			   desc->compression_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  desc->pebi->pebc->parent_si->seg_id,
+		  desc->pebi->peb_id,
+		  desc->pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = desc->pebi->pebc->parent_si->fsi;
+	desc->compr_size = 0;
+	desc->uncompr_size = 0;
+	desc->fragments_count = 0;
+
+	for (i = 0; i < ssdfs_page_vector_count(desc->page_vec); i++) {
+		size_t iter_bytes;
+		size_t dst_page_off;
+		size_t dst_free_space;
+		struct ssdfs_fragment_source from;
+		struct ssdfs_fragment_destination to;
+
+		BUG_ON(i >= desc->array_capacity);
+
+		if (desc->uncompr_size > desc->bytes_count) {
+			SSDFS_WARN("uncompr_size %u > bytes_count %zu\n",
+				   desc->uncompr_size,
+				   desc->bytes_count);
+			break;
+		} else if (desc->uncompr_size == desc->bytes_count)
+			break;
+
+		iter_bytes = min_t(size_t, PAGE_SIZE,
+				   desc->bytes_count - desc->uncompr_size);
+
+		src_page = desc->page_vec->pages[i];
+
+try_get_next_page:
+		dst_page = ssdfs_page_array_grab_page(&desc->pebi->cache,
+						      *desc->cur_page);
+		if (IS_ERR_OR_NULL(dst_page)) {
+			SSDFS_ERR("fail to grab cache page: index %lu\n",
+				  *desc->cur_page);
+			return -ENOMEM;
+		}
+
+		dst_page_off = *(desc->write_offset) % PAGE_SIZE;
+		dst_free_space = PAGE_SIZE - dst_page_off;
+
+		kaddr = kmap_local_page(dst_page);
+
+		from.page = src_page;
+		from.start_offset = 0;
+		from.data_bytes = iter_bytes;
+		from.sequence_id = desc->start_sequence_id + i;
+		from.fragment_type = desc->compression_type;
+		from.fragment_flags = SSDFS_FRAGMENT_HAS_CSUM;
+
+		to.area_offset = desc->area_offset;
+		to.write_offset = *desc->write_offset;
+		to.store = kaddr + dst_page_off;
+		to.free_space = dst_free_space;
+		to.compr_size = 0;
+		to.desc = &desc->desc_array[i];
+
+		err = ssdfs_peb_store_fragment(&from, &to);
+
+		flush_dcache_page(dst_page);
+		kunmap_local(kaddr);
+
+		if (!err) {
+			ssdfs_set_page_private(dst_page, 0);
+			SetPageUptodate(dst_page);
+
+			err =
+			    ssdfs_page_array_set_page_dirty(&desc->pebi->cache,
+							    *desc->cur_page);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to set page %lu dirty: "
+					  "err %d\n",
+					  *desc->cur_page, err);
+			}
+		}
+
+		ssdfs_unlock_page(dst_page);
+		ssdfs_put_page(dst_page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  dst_page, page_ref_count(dst_page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try to get next page: "
+				  "write_offset %u, dst_free_space %zu\n",
+				  *desc->write_offset,
+				  dst_free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			*desc->write_offset += dst_free_space;
+			(*desc->cur_page)++;
+			goto try_get_next_page;
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store fragment: "
+				  "sequence_id %u, write_offset %u, err %d\n",
+				  desc->start_sequence_id + i,
+				  *desc->write_offset, err);
+			return err;
+		}
+
+		desc->uncompr_size += iter_bytes;
+		*desc->write_offset += to.compr_size;
+		desc->compr_size += to.compr_size;
+		desc->fragments_count++;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_blk_bmap_fragment() - store fragment of block bitmap
+ * @desc: descriptor of block bitmap fragment environment
+ * @bmap_hdr_offset: offset of header from log's beginning
+ *
+ * This function tries to store block bitmap fragment
+ * into PEB's log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_blk_bmap_fragment(struct ssdfs_bmap_descriptor *desc,
+				      u32 bmap_hdr_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_block_bitmap_fragment *frag_hdr = NULL;
+	struct ssdfs_fragment_desc *frag_desc_array = NULL;
+	size_t frag_hdr_size = sizeof(struct ssdfs_block_bitmap_fragment);
+	size_t frag_desc_size = sizeof(struct ssdfs_fragment_desc);
+	size_t allocation_size = 0;
+	u32 frag_hdr_off;
+	struct ssdfs_pagevec_descriptor pvec_desc;
+	u32 pages_per_peb;
+	struct page *page;
+	pgoff_t index;
+	u32 page_off;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc);
+	BUG_ON(!desc->pebi || !desc->cur_page || !desc->write_offset);
+	BUG_ON(ssdfs_page_vector_count(desc->snapshot) == 0);
+
+	switch (desc->compression_type) {
+	case SSDFS_BLK_BMAP_NOCOMPR_TYPE:
+	case SSDFS_BLK_BMAP_ZLIB_COMPR_TYPE:
+	case SSDFS_BLK_BMAP_LZO_COMPR_TYPE:
+		/* valid type */
+		break;
+
+	default:
+		SSDFS_WARN("invalid compression %#x\n",
+			   desc->compression_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("peb_id %llu, peb_index %u, "
+		  "cur_page %lu, write_offset %u, "
+		  "desc->compression_type %#x\n",
+		  desc->pebi->peb_id,
+		  desc->pebi->peb_index,
+		  *(desc->cur_page), *(desc->write_offset),
+		  desc->compression_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = desc->pebi->pebc->parent_si->fsi;
+
+	allocation_size = frag_hdr_size;
+	allocation_size +=
+		ssdfs_page_vector_count(desc->snapshot) * frag_desc_size;
+
+	frag_hdr = ssdfs_flush_kzalloc(allocation_size, GFP_KERNEL);
+	if (!frag_hdr) {
+		SSDFS_ERR("unable to allocate block bmap header\n");
+		return -ENOMEM;
+	}
+
+	frag_hdr_off = *(desc->write_offset);
+	*(desc->write_offset) += allocation_size;
+
+	frag_desc_array = (struct ssdfs_fragment_desc *)((u8 *)frag_hdr +
+							  frag_hdr_size);
+
+	switch (desc->compression_type) {
+	case SSDFS_BLK_BMAP_NOCOMPR_TYPE:
+		pvec_desc.compression_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+		break;
+
+	case SSDFS_BLK_BMAP_ZLIB_COMPR_TYPE:
+		pvec_desc.compression_type = SSDFS_FRAGMENT_ZLIB_BLOB;
+		break;
+
+	case SSDFS_BLK_BMAP_LZO_COMPR_TYPE:
+		pvec_desc.compression_type = SSDFS_FRAGMENT_LZO_BLOB;
+		break;
+
+	default:
+		SSDFS_WARN("invalid compression %#x\n",
+			   desc->compression_type);
+		return -EINVAL;
+	}
+
+	pvec_desc.pebi = desc->pebi;
+	pvec_desc.start_sequence_id = 0;
+	pvec_desc.area_offset = bmap_hdr_offset;
+	pvec_desc.page_vec = desc->snapshot;
+	pvec_desc.bytes_count = desc->bytes_count;
+	pvec_desc.desc_array = frag_desc_array;
+	pvec_desc.array_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+	pvec_desc.cur_page = desc->cur_page;
+	pvec_desc.write_offset = desc->write_offset;
+
+	err = ssdfs_peb_store_pagevec(&pvec_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block bitmap in the log: "
+			  "seg %llu, peb %llu, write_offset %u, "
+			  "err %d\n",
+			  desc->pebi->pebc->parent_si->seg_id,
+			  desc->pebi->peb_id,
+			  *(desc->write_offset), err);
+		goto fail_store_bmap_fragment;
+	}
+
+	frag_hdr->peb_index = cpu_to_le16(desc->peb_index);
+	frag_hdr->sequence_id = *(desc->frag_id);
+	*(desc->frag_id) += 1;
+	frag_hdr->flags = desc->flags;
+	frag_hdr->type = desc->type;
+
+	pages_per_peb = fsi->pages_per_peb;
+
+	if (desc->last_free_blk >= pages_per_peb) {
+		SSDFS_ERR("last_free_page %u >= pages_per_peb %u\n",
+			  desc->last_free_blk, pages_per_peb);
+		err = -ERANGE;
+		goto fail_store_bmap_fragment;
+	}
+
+	if ((desc->invalid_blks + desc->metadata_blks) > pages_per_peb) {
+		SSDFS_ERR("invalid descriptor state: "
+			  "invalid_blks %u, metadata_blks %u, "
+			  "pages_per_peb %u\n",
+			  desc->invalid_blks,
+			  desc->metadata_blks,
+			  pages_per_peb);
+		err = -ERANGE;
+		goto fail_store_bmap_fragment;
+	}
+
+	frag_hdr->last_free_blk = cpu_to_le32(desc->last_free_blk);
+	frag_hdr->metadata_blks = cpu_to_le32(desc->metadata_blks);
+	frag_hdr->invalid_blks = cpu_to_le32(desc->invalid_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(pvec_desc.compr_size > pvec_desc.uncompr_size);
+	WARN_ON(pvec_desc.compr_size >
+			desc->pebi->pebc->parent_si->fsi->segsize);
+#endif /* CONFIG_SSDFS_DEBUG */
+	frag_hdr->chain_hdr.compr_bytes = cpu_to_le32(pvec_desc.compr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(pvec_desc.uncompr_size >
+			desc->pebi->pebc->parent_si->fsi->segsize);
+#endif /* CONFIG_SSDFS_DEBUG */
+	frag_hdr->chain_hdr.uncompr_bytes = cpu_to_le32(pvec_desc.uncompr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(pvec_desc.fragments_count > SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	frag_hdr->chain_hdr.fragments_count =
+		cpu_to_le16(pvec_desc.fragments_count);
+
+	frag_hdr->chain_hdr.desc_size = cpu_to_le16(frag_desc_size);
+	frag_hdr->chain_hdr.magic = SSDFS_CHAIN_HDR_MAGIC;
+	frag_hdr->chain_hdr.type = SSDFS_BLK_BMAP_CHAIN_HDR;
+	frag_hdr->chain_hdr.flags = 0;
+
+	index = ssdfs_write_offset_to_mem_page_index(fsi,
+				desc->pebi->current_log.start_page,
+				frag_hdr_off);
+
+	page = ssdfs_page_array_get_page_locked(&desc->pebi->cache, index);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %lu\n", index);
+		err = -ENOMEM;
+		goto fail_store_bmap_fragment;
+	}
+
+	page_off = frag_hdr_off % PAGE_SIZE;
+
+	err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+				   frag_hdr, 0, allocation_size,
+				   allocation_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: "
+			  "page_off %u, allocation_size %zu, err %d\n",
+			  page_off, allocation_size, err);
+		goto finish_copy;
+	}
+
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+
+	err = ssdfs_page_array_set_page_dirty(&desc->pebi->cache, index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu dirty: "
+			  "err %d\n",
+			  index, err);
+	}
+
+finish_copy:
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+fail_store_bmap_fragment:
+	ssdfs_block_bmap_forget_snapshot(desc->snapshot);
+	ssdfs_flush_kfree(frag_hdr);
+	return err;
+}
+
+/*
+ * ssdfs_peb_store_dst_blk_bmap() - store destination block bitmap
+ * @pebi: pointer on PEB object
+ * @items_state: PEB container's items state
+ * @compression: compression type
+ * @bmap_hdr_off: offset from log's beginning to bitmap header
+ * @frag_id: pointer on fragments counter [in|out]
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store destination block bitmap
+ * into destination PEB's log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_dst_blk_bmap(struct ssdfs_peb_info *pebi,
+				 int items_state,
+				 u8 compression,
+				 u32 bmap_hdr_off,
+				 u8 *frag_id,
+				 pgoff_t *cur_page,
+				 u32 *write_offset)
+{
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_block_bmap *bmap;
+	struct ssdfs_bmap_descriptor desc;
+	int buffers_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!frag_id || !cur_page || !write_offset);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -EINVAL;
+	}
+
+	switch (compression) {
+	case SSDFS_BLK_BMAP_NOCOMPR_TYPE:
+	case SSDFS_BLK_BMAP_ZLIB_COMPR_TYPE:
+	case SSDFS_BLK_BMAP_LZO_COMPR_TYPE:
+		/* valid type */
+		break;
+
+	default:
+		SSDFS_WARN("invalid compression %#x\n",
+			   compression);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_index,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc.compression_type = compression;
+	desc.flags = SSDFS_PEB_HAS_RELATION | SSDFS_MIGRATING_BLK_BMAP;
+	desc.type = SSDFS_DST_BLK_BMAP;
+	desc.frag_id = frag_id;
+	desc.cur_page = cur_page;
+	desc.write_offset = write_offset;
+
+	desc.snapshot = &pebi->current_log.bmap_snapshot;
+
+	if (!pebi->pebc->src_peb || !pebi->pebc->dst_peb) {
+		SSDFS_WARN("empty src or dst PEB pointer\n");
+		return -ERANGE;
+	}
+
+	if (pebi == pebi->pebc->src_peb)
+		desc.pebi = pebi->pebc->src_peb;
+	else
+		desc.pebi = pebi->pebc->dst_peb;
+
+	if (!desc.pebi) {
+		SSDFS_WARN("destination PEB doesn't exist\n");
+		return -ERANGE;
+	}
+
+	desc.peb_index = desc.pebi->peb_index;
+
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+	peb_blkbmap = &seg_blkbmap->peb[pebi->pebc->peb_index];
+
+	err = ssdfs_page_vector_init(desc.snapshot);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init page vector: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+		SSDFS_ERR("PEB's block bitmap isn't initialized\n");
+		return -ERANGE;
+	}
+
+	down_read(&peb_blkbmap->lock);
+
+	buffers_state = atomic_read(&peb_blkbmap->buffers_state);
+	switch (buffers_state) {
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   buffers_state);
+		goto finish_store_dst_blk_bmap;
+	}
+
+	bmap = peb_blkbmap->dst;
+	if (!bmap) {
+		err = -ERANGE;
+		SSDFS_WARN("destination bitmap doesn't exist\n");
+		goto finish_store_dst_blk_bmap;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_store_dst_blk_bmap;
+	}
+
+	err = ssdfs_block_bmap_snapshot(bmap, desc.snapshot,
+					&desc.last_free_blk,
+					&desc.metadata_blks,
+					&desc.invalid_blks,
+					&desc.bytes_count);
+
+	ssdfs_block_bmap_unlock(bmap);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to snapshot block bitmap: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->pebc->peb_index, err);
+		goto finish_store_dst_blk_bmap;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_id %llu, DST: last_free_blk %u, "
+		  "metadata_blks %u, invalid_blks %u\n",
+		  pebi->peb_id, desc.last_free_blk,
+		  desc.metadata_blks, desc.invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ssdfs_page_vector_count(desc.snapshot) == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("empty block bitmap\n");
+		goto finish_store_dst_blk_bmap;
+	}
+
+finish_store_dst_blk_bmap:
+	up_read(&peb_blkbmap->lock);
+
+	if (unlikely(err))
+		return err;
+
+	return ssdfs_peb_store_blk_bmap_fragment(&desc, bmap_hdr_off);
+}
+
+/*
+ * ssdfs_peb_store_source_blk_bmap() - store source block bitmap
+ * @pebi: pointer on PEB object
+ * @items_state: PEB container's items state
+ * @compression: compression type
+ * @bmap_hdr_off: offset from log's beginning to bitmap header
+ * @frag_id: pointer on fragments counter [in|out]
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store source block bitmap
+ * into destination PEB's log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_source_blk_bmap(struct ssdfs_peb_info *pebi,
+				    int items_state,
+				    u8 compression,
+				    u32 bmap_hdr_off,
+				    u8 *frag_id,
+				    pgoff_t *cur_page,
+				    u32 *write_offset)
+{
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_block_bmap *bmap;
+	struct ssdfs_bmap_descriptor desc;
+	int buffers_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!frag_id || !cur_page || !write_offset);
+	BUG_ON(!pebi);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -EINVAL;
+	}
+
+	switch (compression) {
+	case SSDFS_BLK_BMAP_NOCOMPR_TYPE:
+	case SSDFS_BLK_BMAP_ZLIB_COMPR_TYPE:
+	case SSDFS_BLK_BMAP_LZO_COMPR_TYPE:
+		/* valid type */
+		break;
+
+	default:
+		SSDFS_WARN("invalid compression %#x\n",
+			   compression);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_index,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc.compression_type = compression;
+	desc.frag_id = frag_id;
+	desc.cur_page = cur_page;
+	desc.write_offset = write_offset;
+
+	desc.snapshot = &pebi->current_log.bmap_snapshot;
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		desc.flags = 0;
+		desc.type = SSDFS_SRC_BLK_BMAP;
+		desc.pebi = pebi->pebc->src_peb;
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		if (!pebi->pebc->src_peb || !pebi->pebc->dst_peb) {
+			SSDFS_WARN("empty src or dst PEB pointer\n");
+			return -ERANGE;
+		}
+
+		desc.flags = SSDFS_PEB_HAS_RELATION |
+				SSDFS_MIGRATING_BLK_BMAP;
+		desc.type = SSDFS_SRC_BLK_BMAP;
+
+		if (pebi == pebi->pebc->src_peb)
+			desc.pebi = pebi->pebc->src_peb;
+		else
+			desc.pebi = pebi->pebc->dst_peb;
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		desc.flags = SSDFS_MIGRATING_BLK_BMAP;
+		desc.type = SSDFS_DST_BLK_BMAP;
+		/* log could be created in destintaion PEB only */
+		desc.pebi = pebi->pebc->dst_peb;
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (!desc.pebi) {
+		SSDFS_WARN("destination PEB doesn't exist\n");
+		return -ERANGE;
+	}
+
+	desc.peb_index = desc.pebi->peb_index;
+
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+	peb_blkbmap = &seg_blkbmap->peb[pebi->peb_index];
+
+	err = ssdfs_page_vector_init(desc.snapshot);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init page vector: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+		SSDFS_ERR("PEB's block bitmap isn't initialized\n");
+		return -ERANGE;
+	}
+
+	down_read(&peb_blkbmap->lock);
+
+	buffers_state = atomic_read(&peb_blkbmap->buffers_state);
+	switch (buffers_state) {
+	case SSDFS_PEB_BMAP1_SRC:
+	case SSDFS_PEB_BMAP2_SRC:
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   buffers_state);
+		goto finish_store_src_blk_bmap;
+	}
+
+	bmap = peb_blkbmap->src;
+	if (!bmap) {
+		err = -ERANGE;
+		SSDFS_WARN("source bitmap doesn't exist\n");
+		goto finish_store_src_blk_bmap;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_store_src_blk_bmap;
+	}
+
+	err = ssdfs_block_bmap_snapshot(bmap, desc.snapshot,
+					&desc.last_free_blk,
+					&desc.metadata_blks,
+					&desc.invalid_blks,
+					&desc.bytes_count);
+
+	ssdfs_block_bmap_unlock(bmap);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to snapshot block bitmap: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->pebc->peb_index, err);
+		goto finish_store_src_blk_bmap;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_id %llu, SRC: last_free_blk %u, "
+		  "metadata_blks %u, invalid_blks %u\n",
+		  pebi->peb_id, desc.last_free_blk,
+		  desc.metadata_blks, desc.invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (desc.metadata_blks == 0) {
+		SSDFS_WARN("peb_id %llu, SRC: last_free_blk %u, "
+			   "metadata_blks %u, invalid_blks %u\n",
+			   pebi->peb_id, desc.last_free_blk,
+			   desc.metadata_blks, desc.invalid_blks);
+		BUG();
+	}
+
+	if (ssdfs_page_vector_count(desc.snapshot) == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("empty block bitmap\n");
+		goto finish_store_src_blk_bmap;
+	}
+
+finish_store_src_blk_bmap:
+	up_read(&peb_blkbmap->lock);
+
+	if (unlikely(err))
+		return err;
+
+	return ssdfs_peb_store_blk_bmap_fragment(&desc, bmap_hdr_off);
+}
+
+/*
+ * ssdfs_peb_store_dependent_blk_bmap() - store dependent source bitmaps
+ * @pebi: pointer on PEB object
+ * @items_state: PEB container's items state
+ * @compression: compression type
+ * @bmap_hdr_off: offset from log's beginning to bitmap header
+ * @frag_id: pointer on fragments counter [in|out]
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store dependent source block bitmaps
+ * of migrating PEBs into destination PEB's log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_dependent_blk_bmap(struct ssdfs_peb_info *pebi,
+					int items_state,
+					u8 compression,
+					u32 bmap_hdr_off,
+					u8 *frag_id,
+					pgoff_t *cur_page,
+					u32 *write_offset)
+{
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_block_bmap *bmap;
+	struct ssdfs_bmap_descriptor desc;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!frag_id || !cur_page || !write_offset);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -EINVAL;
+	}
+
+	switch (compression) {
+	case SSDFS_BLK_BMAP_NOCOMPR_TYPE:
+	case SSDFS_BLK_BMAP_ZLIB_COMPR_TYPE:
+	case SSDFS_BLK_BMAP_LZO_COMPR_TYPE:
+		/* valid type */
+		break;
+
+	default:
+		SSDFS_WARN("invalid compression %#x\n",
+			   compression);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_index,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc.compression_type = compression;
+	desc.frag_id = frag_id;
+	desc.cur_page = cur_page;
+	desc.write_offset = write_offset;
+
+	desc.snapshot = &pebi->current_log.bmap_snapshot;
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		desc.flags = SSDFS_PEB_HAS_EXT_PTR | SSDFS_MIGRATING_BLK_BMAP;
+		desc.type = SSDFS_SRC_BLK_BMAP;
+		desc.pebi = pebi->pebc->dst_peb;
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (!desc.pebi) {
+		SSDFS_WARN("destination PEB doesn't exist\n");
+		return -ERANGE;
+	}
+
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+
+	for (i = 0; i < pebi->pebc->parent_si->pebs_count; i++) {
+		struct ssdfs_peb_container *cur_pebc;
+		struct ssdfs_peb_info *dst_peb;
+		int buffers_state;
+
+		cur_pebc = &pebi->pebc->parent_si->peb_array[i];
+
+		switch (atomic_read(&cur_pebc->items_state)) {
+		case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+			/* do nothing here */
+			break;
+
+		default:
+			continue;
+		};
+
+		down_read(&cur_pebc->lock);
+		dst_peb = cur_pebc->dst_peb;
+		up_read(&cur_pebc->lock);
+
+		if (dst_peb == NULL) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("dst_peb is NULL: "
+				  "peb_index %u\n",
+				  i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (dst_peb != pebi->pebc->dst_peb)
+			continue;
+
+		peb_blkbmap = &seg_blkbmap->peb[i];
+
+		err = ssdfs_page_vector_init(desc.snapshot);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init page vector: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		desc.peb_index = (u16)i;
+
+		if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+			SSDFS_ERR("PEB's block bitmap isn't initialized\n");
+			return -ERANGE;
+		}
+
+		down_read(&peb_blkbmap->lock);
+
+		buffers_state = atomic_read(&peb_blkbmap->buffers_state);
+		switch (buffers_state) {
+		case SSDFS_PEB_BMAP1_SRC:
+		case SSDFS_PEB_BMAP2_SRC:
+			/* valid state */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_WARN("invalid buffers_state %#x\n",
+				   buffers_state);
+			goto finish_store_dependent_blk_bmap;
+		}
+
+		bmap = peb_blkbmap->src;
+		if (!bmap) {
+			err = -ERANGE;
+			SSDFS_WARN("source bitmap doesn't exist\n");
+			goto finish_store_dependent_blk_bmap;
+		}
+
+		err = ssdfs_block_bmap_lock(bmap);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+			goto finish_store_dependent_blk_bmap;
+		}
+
+		err = ssdfs_block_bmap_snapshot(bmap, desc.snapshot,
+						&desc.last_free_blk,
+						&desc.metadata_blks,
+						&desc.invalid_blks,
+						&desc.bytes_count);
+
+		ssdfs_block_bmap_unlock(bmap);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to snapshot block bitmap: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  cur_pebc->parent_si->seg_id,
+				  cur_pebc->peb_index, err);
+			goto finish_store_dependent_blk_bmap;
+		}
+
+		if (ssdfs_page_vector_count(desc.snapshot) == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("empty block bitmap\n");
+			goto finish_store_dependent_blk_bmap;
+		}
+
+finish_store_dependent_blk_bmap:
+		up_read(&peb_blkbmap->lock);
+
+		if (unlikely(err))
+			return err;
+
+		err = ssdfs_peb_store_blk_bmap_fragment(&desc, bmap_hdr_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store block bitmap fragment: "
+				  "peb_index %u, err %d\n",
+				  i, err);
+			return err;
+		}
+
+		ssdfs_block_bmap_forget_snapshot(desc.snapshot);
+	}
+
+	return 0;
+}
+
+static inline
+void ssdfs_prepare_blk_bmap_options(struct ssdfs_fs_info *fsi,
+				    u16 *flags, u8 *compression)
+{
+	u8 type;
+
+	*flags = fsi->metadata_options.blk_bmap.flags;
+	type = fsi->metadata_options.blk_bmap.compression;
+
+	*compression = SSDFS_BLK_BMAP_UNCOMPRESSED_BLOB;
+
+	if (*flags & SSDFS_BLK_BMAP_MAKE_COMPRESSION) {
+		switch (type) {
+		case SSDFS_BLK_BMAP_NOCOMPR_TYPE:
+			*compression = SSDFS_BLK_BMAP_UNCOMPRESSED_BLOB;
+			break;
+
+		case SSDFS_BLK_BMAP_ZLIB_COMPR_TYPE:
+			*compression = SSDFS_BLK_BMAP_ZLIB_BLOB;
+			break;
+
+		case SSDFS_BLK_BMAP_LZO_COMPR_TYPE:
+			*compression = SSDFS_BLK_BMAP_LZO_BLOB;
+			break;
+		}
+	}
+}
+
+/*
+ * ssdfs_peb_store_block_bmap() - store block bitmap into page cache
+ * @pebi: pointer on PEB object
+ * @desc: block bitmap descriptor [out]
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store block bitmap into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_block_bmap(struct ssdfs_peb_info *pebi,
+				struct ssdfs_metadata_descriptor *desc,
+				pgoff_t *cur_page,
+				u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_block_bitmap_header *bmap_hdr = NULL;
+	size_t bmap_hdr_size = sizeof(struct ssdfs_block_bitmap_header);
+	int items_state;
+	u8 frag_id = 0;
+	u32 bmap_hdr_off;
+	u32 pages_per_peb;
+	u16 log_start_page = 0;
+	u16 flags = 0;
+	u8 compression = SSDFS_BLK_BMAP_UNCOMPRESSED_BLOB;
+	struct page *page;
+	pgoff_t index;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(flags & ~SSDFS_BLK_BMAP_FLAG_MASK);
+	BUG_ON(!desc || !cur_page || !write_offset);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_index,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+
+	pages_per_peb = min_t(u32, fsi->leb_pages_capacity,
+				   fsi->peb_pages_capacity);
+
+	ssdfs_prepare_blk_bmap_options(fsi, &flags, &compression);
+
+	bmap_hdr_off = *write_offset;
+	*write_offset += bmap_hdr_size;
+
+	items_state = atomic_read(&pebi->pebc->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		/* Prepare source bitmap only */
+		err = ssdfs_peb_store_source_blk_bmap(pebi, items_state,
+						      compression,
+						      bmap_hdr_off,
+						      &frag_id,
+						      cur_page,
+						      write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store source bitmap: "
+				  "cur_page %lu, write_offset %u, "
+				  "err %d\n",
+				  *cur_page, *write_offset, err);
+			goto finish_store_block_bitmap;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		if (!pebi->pebc->src_peb || !pebi->pebc->dst_peb) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid src or dst PEB pointer\n");
+			goto finish_store_block_bitmap;
+		}
+
+		/*
+		 * Prepare
+		 * (1) destination bitmap
+		 * (2) source bitmap
+		 * (3) all dependent bitmaps
+		 */
+		err = ssdfs_peb_store_dst_blk_bmap(pebi, items_state,
+						   compression,
+						   bmap_hdr_off,
+						   &frag_id,
+						   cur_page,
+						   write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store destination bitmap: "
+				  "cur_page %lu, write_offset %u, "
+				  "err %d\n",
+				  *cur_page, *write_offset, err);
+			goto finish_store_block_bitmap;
+		}
+
+		err = ssdfs_peb_store_source_blk_bmap(pebi, items_state,
+						      compression,
+						      bmap_hdr_off,
+						      &frag_id,
+						      cur_page,
+						      write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store source bitmap: "
+				  "cur_page %lu, write_offset %u, "
+				  "err %d\n",
+				  *cur_page, *write_offset, err);
+			goto finish_store_block_bitmap;
+		}
+
+		err = ssdfs_peb_store_dependent_blk_bmap(pebi, items_state,
+							 compression,
+							 bmap_hdr_off,
+							 &frag_id,
+							 cur_page,
+							 write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store dependent bitmaps: "
+				  "cur_page %lu, write_offset %u, "
+				  "err %d\n",
+				  *cur_page, *write_offset, err);
+			goto finish_store_block_bitmap;
+		}
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		/*
+		 * Prepare
+		 * (1) source bitmap
+		 * (2) all dependent bitmaps
+		 */
+		err = ssdfs_peb_store_source_blk_bmap(pebi, items_state,
+						      compression,
+						      bmap_hdr_off,
+						      &frag_id,
+						      cur_page,
+						      write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store source bitmap: "
+				  "cur_page %lu, write_offset %u, "
+				  "err %d\n",
+				  *cur_page, *write_offset, err);
+			goto finish_store_block_bitmap;
+		}
+
+		err = ssdfs_peb_store_dependent_blk_bmap(pebi, items_state,
+							 compression,
+							 bmap_hdr_off,
+							 &frag_id,
+							 cur_page,
+							 write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store dependent bitmaps: "
+				  "cur_page %lu, write_offset %u, "
+				  "err %d\n",
+				  *cur_page, *write_offset, err);
+			goto finish_store_block_bitmap;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		break;
+	}
+
+	if (pebi->current_log.start_page >= pages_per_peb) {
+		err = -ERANGE;
+		SSDFS_ERR("log_start_page %u >= pages_per_peb %u\n",
+			  log_start_page, pages_per_peb);
+		goto finish_store_block_bitmap;
+	}
+
+	desc->offset = cpu_to_le32(bmap_hdr_off +
+			    (pebi->current_log.start_page * fsi->pagesize));
+
+	index = ssdfs_write_offset_to_mem_page_index(fsi,
+					     pebi->current_log.start_page,
+					     bmap_hdr_off);
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, index);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %lu\n", index);
+		err = -ENOMEM;
+		goto finish_store_block_bitmap;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	bmap_hdr = SSDFS_BLKBMP_HDR((u8 *)kaddr +
+				    (bmap_hdr_off % PAGE_SIZE));
+
+	bmap_hdr->magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	bmap_hdr->magic.key = cpu_to_le16(SSDFS_BLK_BMAP_MAGIC);
+	bmap_hdr->magic.version.major = SSDFS_MAJOR_REVISION;
+	bmap_hdr->magic.version.minor = SSDFS_MINOR_REVISION;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(frag_id == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+	bmap_hdr->fragments_count = cpu_to_le16(frag_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(*write_offset <= bmap_hdr_off);
+	BUG_ON(*write_offset <= (bmap_hdr_off + bmap_hdr_size));
+#endif /* CONFIG_SSDFS_DEBUG */
+	bmap_hdr->bytes_count = cpu_to_le32(*write_offset - bmap_hdr_off);
+	desc->size = bmap_hdr->bytes_count;
+
+	pebi->current_log.prev_log_bmap_bytes =
+			le32_to_cpu(bmap_hdr->bytes_count);
+
+	bmap_hdr->flags = flags;
+	bmap_hdr->type = compression;
+
+	desc->check.bytes = cpu_to_le16(bmap_hdr_size);
+
+	switch (compression) {
+	case SSDFS_BLK_BMAP_ZLIB_BLOB:
+		desc->check.flags = cpu_to_le16(SSDFS_CRC32 |
+						SSDFS_ZLIB_COMPRESSED);
+		break;
+
+	case SSDFS_BLK_BMAP_LZO_BLOB:
+		desc->check.flags = cpu_to_le16(SSDFS_CRC32 |
+						SSDFS_LZO_COMPRESSED);
+		break;
+
+	default:
+		desc->check.flags = cpu_to_le16(SSDFS_CRC32);
+		break;
+	}
+
+	err = ssdfs_calculate_csum(&desc->check, bmap_hdr, bmap_hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to calculate checksum: err %d\n", err);
+		goto finish_bmap_hdr_preparation;
+	}
+
+	pebi->current_log.seg_flags |= SSDFS_SEG_HDR_HAS_BLK_BMAP;
+
+finish_bmap_hdr_preparation:
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+
+	err = ssdfs_page_array_set_page_dirty(&pebi->cache, index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu dirty: "
+			  "err %d\n",
+			  index, err);
+	}
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_store_block_bitmap:
+	return err;
+}
+
+/*
+ * is_peb_area_empty() - check that PEB's area is empty
+ * @pebi: pointer on PEB object
+ * @area_type: type of area
+ */
+static inline
+bool is_peb_area_empty(struct ssdfs_peb_info *pebi, int area_type)
+{
+	struct ssdfs_peb_area *area;
+	size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+	bool is_empty = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area = &pebi->current_log.area[area_type];
+
+	if (area->has_metadata)
+		is_empty = area->write_offset == blk_table_size;
+	else
+		is_empty = area->write_offset == 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_type %#x, write_offset %u, is_empty %d\n",
+		  area_type, area->write_offset, (int)is_empty);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_empty;
+}
+
+/*
+ * ssdfs_peb_copy_area_pages_into_cache() - copy area pages into cache
+ * @pebi: pointer on PEB object
+ * @area_type: type of area
+ * @desc: descriptor of metadata area
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to copy area pages into log's page cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - area is empty.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_copy_area_pages_into_cache(struct ssdfs_peb_info *pebi,
+					 int area_type,
+					 struct ssdfs_metadata_descriptor *desc,
+					 pgoff_t *cur_page,
+					 u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_area *area;
+	size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+	struct pagevec pvec;
+	struct ssdfs_page_array *smap, *dmap;
+	pgoff_t page_index, end, pages_count, range_len;
+	struct page *page;
+	u32 area_offset, area_size = 0;
+	u16 log_start_page;
+	u32 read_bytes = 0;
+	u32 area_write_offset = 0;
+	u16 flags;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!desc || !cur_page || !write_offset);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	area = &pebi->current_log.area[area_type];
+	log_start_page = pebi->current_log.start_page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "area_type %#x, area->write_offset %u, "
+		  "area->compressed_offset %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  area_type, area->write_offset,
+		  area->compressed_offset,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_peb_area_empty(pebi, area_type)) {
+		SSDFS_DBG("area %#x is empty\n", area_type);
+		return -ENODATA;
+	}
+
+	smap = &area->array;
+	dmap = &pebi->cache;
+
+	switch (area_type) {
+	case SSDFS_LOG_BLK_DESC_AREA:
+		flags = fsi->metadata_options.blk2off_tbl.flags;
+		if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION)
+			area_write_offset = area->compressed_offset;
+		else
+			area_write_offset = area->write_offset;
+		break;
+
+	default:
+		area_write_offset = area->write_offset;
+		break;
+	}
+
+	area_offset = *write_offset;
+	area_size = area_write_offset;
+
+	desc->offset = cpu_to_le32(area_offset +
+					(log_start_page * fsi->pagesize));
+	desc->size = cpu_to_le32(area_size);
+
+	if (area->has_metadata) {
+		void *kaddr;
+		u8 compression = fsi->metadata_options.blk2off_tbl.compression;
+		u16 metadata_flags = SSDFS_CRC32;
+
+		switch (area_type) {
+		case SSDFS_LOG_BLK_DESC_AREA:
+			flags = fsi->metadata_options.blk2off_tbl.flags;
+			if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+				switch (compression) {
+				case SSDFS_BLK2OFF_TBL_ZLIB_COMPR_TYPE:
+					metadata_flags |= SSDFS_ZLIB_COMPRESSED;
+					break;
+
+				case SSDFS_BLK2OFF_TBL_LZO_COMPR_TYPE:
+					metadata_flags |= SSDFS_LZO_COMPRESSED;
+					break;
+
+				default:
+					/* do nothing */
+					break;
+				}
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		page = ssdfs_page_array_get_page_locked(smap, 0);
+		if (IS_ERR_OR_NULL(page)) {
+			SSDFS_ERR("fail to get page of area %#x\n",
+				  area_type);
+			return -ERANGE;
+		}
+
+		kaddr = kmap_local_page(page);
+		desc->check.bytes = cpu_to_le16(blk_table_size);
+		desc->check.flags = cpu_to_le16(metadata_flags);
+		err = ssdfs_calculate_csum(&desc->check, kaddr, blk_table_size);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to calculate checksum: err %d\n",
+				  err);
+			return err;
+		}
+
+		err = ssdfs_page_array_set_page_dirty(smap, 0);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page dirty: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	pagevec_init(&pvec);
+
+	page_index = 0;
+	pages_count = area_write_offset + PAGE_SIZE - 1;
+	pages_count >>= PAGE_SHIFT;
+
+	while (page_index < pages_count) {
+		int i;
+
+		range_len = min_t(pgoff_t,
+				  (pgoff_t)PAGEVEC_SIZE,
+				  (pgoff_t)(pages_count - page_index));
+		end = page_index + range_len - 1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %lu, pages_count %lu\n",
+			  page_index, pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_page_array_lookup_range(smap, &page_index, end,
+						    SSDFS_DIRTY_PAGE_TAG,
+						    PAGEVEC_SIZE,
+						    &pvec);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find any dirty pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page1 = pvec.pages[i], *page2;
+			pgoff_t src_index = page1->index;
+			u32 src_len, dst_len, copy_len;
+			u32 src_off, dst_off;
+			u32 rest_len = PAGE_SIZE;
+
+			if (read_bytes == area_size)
+				goto finish_pagevec_copy;
+			else if (read_bytes > area_size) {
+				err = -E2BIG;
+				SSDFS_ERR("too many pages: "
+					  "pages_count %u, area_size %u\n",
+					  pagevec_count(&pvec),
+					  area_size);
+				goto finish_current_copy;
+			}
+
+			src_off = 0;
+
+try_copy_area_data:
+			ssdfs_lock_page(page1);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page1, page_ref_count(page1));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (*write_offset >= PAGE_SIZE)
+				dst_off = *write_offset % PAGE_SIZE;
+			else
+				dst_off = *write_offset;
+
+			src_len = min_t(u32, area_size - read_bytes, rest_len);
+			dst_len = min_t(u32, PAGE_SIZE, PAGE_SIZE - dst_off);
+			copy_len = min_t(u32, src_len, dst_len);
+
+			page2 = ssdfs_page_array_grab_page(dmap, *cur_page);
+			if (unlikely(IS_ERR_OR_NULL(page2))) {
+				err = -ENOMEM;
+				SSDFS_ERR("fail to grab page: index %lu\n",
+					  *cur_page);
+				goto unlock_page1;
+			}
+
+			err = ssdfs_memcpy_page(page2, dst_off, PAGE_SIZE,
+						page1, src_off, PAGE_SIZE,
+						copy_len);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: "
+					  "src_off %u, dst_off %u, "
+					  "copy_len %u\n",
+					  src_off, dst_off, copy_len);
+				goto unlock_page2;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("src_off %u, dst_off %u, src_len %u, "
+				  "dst_len %u, copy_len %u, "
+				  "write_offset %u, cur_page %lu, "
+				  "page_index %d\n",
+				  src_off, dst_off, src_len, dst_len, copy_len,
+				  *write_offset, *cur_page, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (PageDirty(page1)) {
+				err = ssdfs_page_array_set_page_dirty(dmap,
+								     *cur_page);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to set page dirty: "
+						  "page_index %lu, err %d\n",
+						  *cur_page, err);
+					goto unlock_page2;
+				}
+			} else {
+				err = -ERANGE;
+				SSDFS_ERR("page %d is not dirty\n", i);
+				goto unlock_page2;
+			}
+
+unlock_page2:
+			ssdfs_unlock_page(page2);
+			ssdfs_put_page(page2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page2, page_ref_count(page2));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+unlock_page1:
+			ssdfs_unlock_page(page1);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page1, page_ref_count(page1));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_current_copy:
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy page: "
+					  " from %lu to %lu, err %d\n",
+					  src_index, *cur_page, err);
+				goto fail_copy_area_pages;
+			}
+
+			read_bytes += copy_len;
+			*write_offset += copy_len;
+			rest_len -= copy_len;
+
+			if ((dst_off + copy_len) >= PAGE_SIZE)
+				++(*cur_page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("read_bytes %u, area_size %u, "
+				  "write_offset %u, copy_len %u, rest_len %u\n",
+				  read_bytes, area_size,
+				  *write_offset, copy_len, rest_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (read_bytes == area_size) {
+				err = ssdfs_page_array_clear_dirty_page(smap,
+								page_index + i);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to mark page clean: "
+						  "page_index %lu\n",
+						  page_index + i);
+					goto fail_copy_area_pages;
+				} else
+					goto finish_pagevec_copy;
+			} else if ((src_off + copy_len) < PAGE_SIZE) {
+				src_off += copy_len;
+				goto try_copy_area_data;
+			} else {
+				err = ssdfs_page_array_clear_dirty_page(smap,
+								page_index + i);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to mark page clean: "
+						  "page_index %lu\n",
+						  page_index + i);
+					goto fail_copy_area_pages;
+				}
+			}
+		}
+
+finish_pagevec_copy:
+		page_index += PAGEVEC_SIZE;
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			page = pvec.pages[i];
+			ssdfs_put_page(page);
+		}
+
+		pagevec_reinit(&pvec);
+		cond_resched();
+	};
+
+	err = ssdfs_page_array_release_all_pages(smap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to release area's pages: "
+			  "err %d\n", err);
+		goto finish_copy_area_pages;
+	}
+
+	pebi->current_log.seg_flags |= SSDFS_AREA_TYPE2FLAG(area_type);
+
+	return 0;
+
+fail_copy_area_pages:
+	for (i = 0; i < pagevec_count(&pvec); i++) {
+		page = pvec.pages[i];
+		ssdfs_put_page(page);
+	}
+
+	pagevec_reinit(&pvec);
+
+finish_copy_area_pages:
+	return err;
+}
+
+/*
+ * ssdfs_peb_move_area_pages_into_cache() - move area pages into cache
+ * @pebi: pointer on PEB object
+ * @area_type: type of area
+ * @desc: descriptor of metadata area
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to move area pages into log's page cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - area is empty.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_move_area_pages_into_cache(struct ssdfs_peb_info *pebi,
+					 int area_type,
+					 struct ssdfs_metadata_descriptor *desc,
+					 pgoff_t *cur_page,
+					 u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_area *area;
+	size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+	struct pagevec pvec;
+	struct ssdfs_page_array *smap, *dmap;
+	pgoff_t page_index, end, pages_count, range_len;
+	struct page *page;
+	u32 area_offset, area_size;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!desc || !cur_page || !write_offset);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	area = &pebi->current_log.area[area_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "area_type %#x, area->write_offset %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  area_type, area->write_offset,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_peb_area_empty(pebi, area_type)) {
+		SSDFS_DBG("area %#x is empty\n", area_type);
+		return -ENODATA;
+	}
+
+	smap = &area->array;
+	dmap = &pebi->cache;
+
+	area_offset = *write_offset;
+	area_size = area->write_offset;
+
+	desc->offset = cpu_to_le32(area_offset +
+				(pebi->current_log.start_page * fsi->pagesize));
+
+	desc->size = cpu_to_le32(area_size);
+
+	if (area->has_metadata) {
+		page = ssdfs_page_array_get_page_locked(smap, 0);
+		if (IS_ERR_OR_NULL(page)) {
+			SSDFS_ERR("fail to get page of area %#x\n",
+				  area_type);
+			return -ERANGE;
+		}
+
+		kaddr = kmap_local_page(page);
+		desc->check.bytes = cpu_to_le16(blk_table_size);
+		desc->check.flags = cpu_to_le16(SSDFS_CRC32);
+		err = ssdfs_calculate_csum(&desc->check, kaddr, blk_table_size);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to calculate checksum: err %d\n",
+				  err);
+			return err;
+		}
+
+		err = ssdfs_page_array_set_page_dirty(smap, 0);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page dirty: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	pagevec_init(&pvec);
+
+	page_index = 0;
+	pages_count = area->write_offset + PAGE_SIZE - 1;
+	pages_count >>= PAGE_SHIFT;
+
+	while (page_index < pages_count) {
+		int i;
+
+		range_len = min_t(pgoff_t,
+				  (pgoff_t)PAGEVEC_SIZE,
+				  (pgoff_t)(pages_count - page_index));
+		end = page_index + range_len - 1;
+
+		err = ssdfs_page_array_lookup_range(smap, &page_index, end,
+						    SSDFS_DIRTY_PAGE_TAG,
+						    PAGEVEC_SIZE,
+						    &pvec);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find any dirty pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i], *page2;
+			pgoff_t src_off = page->index;
+
+			ssdfs_lock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			page2 = ssdfs_page_array_delete_page(smap, src_off);
+			if (IS_ERR_OR_NULL(page2)) {
+				err = !page2 ? -ERANGE : PTR_ERR(page2);
+				SSDFS_ERR("fail to delete page %lu: err %d\n",
+					  src_off, err);
+				goto finish_current_move;
+			}
+
+			WARN_ON(page2 != page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_page %lu, write_offset %u, "
+				  "i %d, pvec_count %u\n",
+				  *cur_page, *write_offset,
+				  i, pagevec_count(&pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			page->index = *cur_page;
+
+			err = ssdfs_page_array_add_page(dmap, page, *cur_page);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add page %lu: err %d\n",
+					  *cur_page, err);
+				goto finish_current_move;
+			}
+
+			if (PageDirty(page)) {
+				err = ssdfs_page_array_set_page_dirty(dmap,
+								     *cur_page);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to set page dirty: "
+						  "page_index %lu, err %d\n",
+						  *cur_page, err);
+					goto finish_current_move;
+				}
+			} else {
+				err = -ERANGE;
+				SSDFS_ERR("page %d is not dirty\n", i);
+				goto finish_current_move;
+			}
+
+			pvec.pages[i] = NULL;
+
+finish_current_move:
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (unlikely(err)) {
+				for (i = 0; i < pagevec_count(&pvec); i++) {
+					page = pvec.pages[i];
+					if (!page)
+						continue;
+					ssdfs_put_page(page);
+				}
+
+				pagevec_reinit(&pvec);
+				SSDFS_ERR("fail to move page: "
+					  " from %lu to %lu, err %d\n",
+					  src_off, *cur_page, err);
+				return err;
+			}
+
+			(*cur_page)++;
+			*write_offset += PAGE_SIZE;
+		}
+
+		page_index += PAGEVEC_SIZE;
+
+		pagevec_reinit(&pvec);
+		cond_resched();
+	};
+
+	pebi->current_log.seg_flags |= SSDFS_AREA_TYPE2FLAG(area_type);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_blk_desc_table() - try to store block descriptor table
+ * @pebi: pointer on PEB object
+ * @desc: descriptor of metadata area
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store block descriptor into log's page cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - area is empty.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_blk_desc_table(struct ssdfs_peb_info *pebi,
+				   struct ssdfs_metadata_descriptor *desc,
+				   pgoff_t *cur_page,
+				   u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_fragment_desc *meta_desc;
+	struct ssdfs_fragments_chain_header *chain_hdr;
+	struct ssdfs_peb_temp_buffer *buf;
+	int area_type = SSDFS_LOG_BLK_DESC_AREA;
+	u16 flags;
+	size_t uncompr_size;
+	size_t compr_size = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!desc || !cur_page || !write_offset);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	area = &pebi->current_log.area[area_type];
+	chain_hdr = &area->metadata.area.blk_desc.table.chain_hdr;
+	buf = &area->metadata.area.blk_desc.flush_buf;
+	flags = fsi->metadata_options.blk2off_tbl.flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "area->write_offset %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  area->write_offset,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_peb_area_empty(pebi, area_type)) {
+		SSDFS_DBG("area %#x is empty\n", area_type);
+		return -ENODATA;
+	}
+
+	meta_desc = ssdfs_peb_get_area_cur_frag_desc(pebi, area_type);
+	if (IS_ERR(meta_desc)) {
+		SSDFS_ERR("fail to get current fragment descriptor: "
+			  "err %d\n",
+			  (int)PTR_ERR(meta_desc));
+		return PTR_ERR(meta_desc);
+	} else if (!meta_desc) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to get current fragment descriptor: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	uncompr_size = le32_to_cpu(meta_desc->uncompr_size);
+
+	if (uncompr_size == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("latest fragment of blk desc table is empty: "
+			  "seg %llu, peb %llu, current_log.start_page %u, "
+			  "area->write_offset %u, "
+			  "cur_page %lu, write_offset %u\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  pebi->current_log.start_page,
+			  area->write_offset,
+			  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto copy_area_pages_into_cache;
+	}
+
+	if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!buf->ptr);
+
+		if (buf->write_offset >= buf->size) {
+			SSDFS_ERR("invalid request: "
+				  "buf->write_offset %u, buf->size %zu\n",
+				  buf->write_offset, buf->size);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		meta_desc->flags = SSDFS_FRAGMENT_HAS_CSUM;
+
+		if (uncompr_size > buf->size) {
+			SSDFS_ERR("invalid state: "
+				  "uncompr_size %zu > buf->size %zu\n",
+				  uncompr_size, buf->size);
+			return -ERANGE;
+		}
+
+		meta_desc->checksum = ssdfs_crc32_le(buf->ptr, uncompr_size);
+
+		if (le32_to_cpu(meta_desc->checksum) == 0) {
+			SSDFS_WARN("checksum is invalid: "
+				   "seg %llu, peb %llu, bytes_count %zu\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_id,
+				   uncompr_size);
+			return -ERANGE;
+		}
+
+		err = ssdfs_peb_compress_blk_descs_fragment(pebi,
+							    uncompr_size,
+							    &compr_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to compress blk desc fragment: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		meta_desc->offset = cpu_to_le32(area->compressed_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		WARN_ON(compr_size > U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+		meta_desc->compr_size = cpu_to_le16((u16)compr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %u, compr_size %u, "
+			  "uncompr_size %u, checksum %#x\n",
+			  le32_to_cpu(meta_desc->offset),
+			  le16_to_cpu(meta_desc->compr_size),
+			  le16_to_cpu(meta_desc->uncompr_size),
+			  le32_to_cpu(meta_desc->checksum));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		area->compressed_offset += compr_size;
+		le32_add_cpu(&chain_hdr->compr_bytes, compr_size);
+	}
+
+	err = ssdfs_peb_store_area_block_table(pebi, area_type, 0);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store area's block table: "
+			  "area %#x, err %d\n",
+			  area_type, err);
+		return err;
+	}
+
+copy_area_pages_into_cache:
+	err = ssdfs_peb_copy_area_pages_into_cache(pebi, area_type,
+						   desc, cur_page,
+						   write_offset);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move pages in the cache: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_log_footer() - store log footer
+ * @pebi: pointer on PEB object
+ * @flags: log footer's flags
+ * @hdr_desc: log footer's metadata descriptor in header
+ * @lf_desc: log footer's metadata descriptors array
+ * @array_size: count of items in array
+ * @cur_segs: current segment IDs array
+ * @cur_segs_size: size of segment IDs array size in bytes
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store log footer into PEB's page cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory page.
+ */
+static
+int ssdfs_peb_store_log_footer(struct ssdfs_peb_info *pebi,
+				u32 flags,
+				struct ssdfs_metadata_descriptor *hdr_desc,
+				struct ssdfs_metadata_descriptor *lf_desc,
+				size_t array_size,
+				__le64 *cur_segs,
+				size_t cur_segs_size,
+				pgoff_t *cur_page,
+				u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_log_footer *footer;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t array_bytes = desc_size * array_size;
+	int padding;
+	u32 log_pages;
+	struct page *page;
+	u32 area_offset, area_size;
+	u64 last_log_time;
+	u64 last_log_cno;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!hdr_desc || !lf_desc || !cur_segs);
+	BUG_ON(!cur_page || !write_offset);
+	BUG_ON(array_size != SSDFS_LOG_FOOTER_DESC_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	area_offset = *write_offset;
+	area_size = sizeof(struct ssdfs_log_footer);
+
+	*write_offset += max_t(u32, PAGE_SIZE, area_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(flags & ~SSDFS_LOG_FOOTER_FLAG_MASK);
+	BUG_ON(((*write_offset + fsi->pagesize - 1) >> fsi->log_pagesize) >
+		pebi->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_pages = (*write_offset + fsi->pagesize - 1) / fsi->pagesize;
+
+	padding = *cur_page % pebi->log_pages;
+	padding = pebi->log_pages - padding;
+	padding--;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_offset %u, write_offset %u, "
+		  "log_pages %u, padding %d, "
+		  "cur_page %lu\n",
+		  area_offset, *write_offset,
+		  log_pages, padding,
+		  *cur_page);
+
+	if (padding > 1) {
+		SSDFS_WARN("padding is big: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "cur_page %lu, write_offset %u, "
+			   "padding %d\n",
+			   pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id,
+			   pebi->current_log.start_page,
+			   *cur_page, *write_offset,
+			   padding);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (padding > 0) {
+		/*
+		 * Align the log_pages and log_bytes.
+		 */
+		log_pages += padding;
+		*write_offset = log_pages * fsi->pagesize;
+		area_offset = *write_offset - fsi->pagesize;
+
+		for (i = 0; i < padding; i++) {
+			page = ssdfs_page_array_grab_page(&pebi->cache,
+							  *cur_page);
+			if (IS_ERR_OR_NULL(page)) {
+				SSDFS_ERR("fail to get cache page: index %lu\n",
+					  *cur_page);
+				return -ENOMEM;
+			}
+
+			ssdfs_memset_page(page, 0, PAGE_SIZE, 0xFF, PAGE_SIZE);
+
+			ssdfs_set_page_private(page, 0);
+			SetPageUptodate(page);
+
+			err = ssdfs_page_array_set_page_dirty(&pebi->cache,
+							      *cur_page);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to set page dirty: "
+					  "page_index %lu, err %d\n",
+					  *cur_page, err);
+			}
+
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+			if (unlikely(err))
+				return err;
+
+			(*cur_page)++;
+		}
+	}
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, *cur_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %lu\n",
+			  *cur_page);
+		return -ENOMEM;
+	}
+
+	footer = kmap_local_page(page);
+	memset(footer, 0xFF, PAGE_SIZE);
+	ssdfs_memcpy(footer->desc_array, 0, array_bytes,
+		     lf_desc, 0, array_bytes,
+		     array_bytes);
+
+	last_log_time = pebi->current_log.last_log_time;
+	last_log_cno = pebi->current_log.last_log_cno;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(pebi->peb_create_time > last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_prepare_volume_state_info_for_commit(fsi, SSDFS_MOUNTED_FS,
+							 cur_segs,
+							 cur_segs_size,
+							 last_log_time,
+							 last_log_cno,
+							 &footer->volume_state);
+
+	if (!err) {
+		err = ssdfs_prepare_log_footer_for_commit(fsi, log_pages,
+							  flags,
+							  last_log_time,
+							  last_log_cno,
+							  footer);
+
+		footer->peb_create_time = cpu_to_le64(pebi->peb_create_time);
+	}
+
+	if (!err) {
+		hdr_desc->offset = cpu_to_le32(area_offset +
+				(pebi->current_log.start_page * fsi->pagesize));
+		hdr_desc->size = cpu_to_le32(area_size);
+
+		ssdfs_memcpy(&hdr_desc->check,
+			     0, sizeof(struct ssdfs_metadata_check),
+			     &footer->volume_state.check,
+			     0, sizeof(struct ssdfs_metadata_check),
+			     sizeof(struct ssdfs_metadata_check));
+	}
+
+	flush_dcache_page(page);
+	kunmap_local(footer);
+
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+
+	err = ssdfs_page_array_set_page_dirty(&pebi->cache, *cur_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page dirty: "
+			  "page_index %lu, err %d\n",
+			  *cur_page, err);
+	}
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store log footer: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		return err;
+	}
+
+	pebi->current_log.seg_flags |= SSDFS_LOG_HAS_FOOTER;
+
+	(*cur_page)++;
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_src_peb_migration_id() - prepare src PEB's migration_id
+ * @pebi: pointer on PEB object
+ * @prev_id: pointer on previous PEB's peb_migration_id [out]
+ * @cur_id: pointer on current PEB's peb_migration_id [out]
+ */
+static inline
+int ssdfs_extract_src_peb_migration_id(struct ssdfs_peb_info *pebi,
+					u8 *prev_id, u8 *cur_id)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->src_peb);
+	BUG_ON(!prev_id || !cur_id);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*prev_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+	*cur_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+
+	if (pebi != pebi->pebc->src_peb) {
+		SSDFS_ERR("pebi %p != src_peb %p\n",
+			  pebi, pebi->pebc->src_peb);
+		return -ERANGE;
+	}
+
+	*cur_id = ssdfs_get_peb_migration_id_checked(pebi);
+	if (unlikely(*cur_id < 0)) {
+		err = *cur_id;
+		*cur_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+		SSDFS_ERR("fail to get migration_id: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  err);
+		return err;
+	}
+
+	*prev_id = ssdfs_define_prev_peb_migration_id(pebi);
+	if (!is_peb_migration_id_valid(*prev_id)) {
+		err = *prev_id;
+		*prev_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+		SSDFS_ERR("fail to define prev migration_id: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  err);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_dst_peb_migration_id() - prepare dst PEB's migration_id
+ * @pebi: pointer on PEB object
+ * @prev_id: pointer on previous PEB's peb_migration_id [out]
+ * @cur_id: pointer on current PEB's peb_migration_id [out]
+ */
+static inline
+int ssdfs_extract_dst_peb_migration_id(struct ssdfs_peb_info *pebi,
+					u8 *prev_id, u8 *cur_id)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->src_peb || !pebi->pebc->dst_peb);
+	BUG_ON(!prev_id || !cur_id);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*prev_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+	*cur_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+
+	*cur_id = ssdfs_get_peb_migration_id_checked(pebi->pebc->dst_peb);
+	if (unlikely(*cur_id < 0)) {
+		err = *cur_id;
+		*cur_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+		SSDFS_ERR("fail to get migration_id: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  err);
+		return err;
+	}
+
+	*prev_id = ssdfs_get_peb_migration_id_checked(pebi->pebc->src_peb);
+	if (unlikely(*prev_id < 0)) {
+		err = *prev_id;
+		*prev_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+		SSDFS_ERR("fail to get migration_id: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_store_peb_migration_id() - store peb_migration_id into header
+ * @pebi: pointer on PEB object
+ * @hdr: pointer on segment header [out]
+ */
+static
+int ssdfs_store_peb_migration_id(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_header *hdr)
+{
+	int items_state;
+	u8 prev_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+	u8 cur_id = SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_state = atomic_read(&pebi->pebc->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebi->pebc->src_peb || pebi->pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_extract_src_peb_migration_id(pebi,
+							 &prev_id,
+							 &cur_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract peb_migration_id: "
+				  "seg %llu, peb %llu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(pebi->pebc->src_peb || !pebi->pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (pebi != pebi->pebc->dst_peb) {
+			SSDFS_ERR("pebi %p != dst_peb %p\n",
+				  pebi, pebi->pebc->dst_peb);
+			return -ERANGE;
+		}
+
+		cur_id = ssdfs_get_peb_migration_id_checked(pebi);
+		if (unlikely(cur_id < 0)) {
+			err = cur_id;
+			SSDFS_ERR("fail to get migration_id: "
+				  "seg %llu, peb %llu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  err);
+			return err;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebi->pebc->src_peb || !pebi->pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = -ERANGE;
+
+		if (pebi == pebi->pebc->src_peb) {
+			err = ssdfs_extract_src_peb_migration_id(pebi,
+								 &prev_id,
+								 &cur_id);
+		} else if (pebi == pebi->pebc->dst_peb) {
+			err = ssdfs_extract_dst_peb_migration_id(pebi,
+								 &prev_id,
+								 &cur_id);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract peb_migration_id: "
+				  "seg %llu, peb %llu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebi->pebc->src_peb || !pebi->pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_extract_src_peb_migration_id(pebi,
+							 &prev_id,
+							 &cur_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract peb_migration_id: "
+				  "seg %llu, peb %llu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, err);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	hdr->peb_migration_id[SSDFS_PREV_MIGRATING_PEB] = prev_id;
+	hdr->peb_migration_id[SSDFS_CUR_MIGRATING_PEB] = cur_id;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_log_header() - store log's header
+ * @pebi: pointer on PEB object
+ * @desc_array: pointer on descriptors array
+ * @array_size: count of items in array
+ * @write_offset: current write offset in log
+ *
+ * This function tries to store log's header in PEB's page cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_log_header(struct ssdfs_peb_info *pebi,
+				struct ssdfs_metadata_descriptor *desc_array,
+				size_t array_size,
+				u32 write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_header *hdr;
+	struct page *page;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t array_bytes = desc_size * array_size;
+	u32 seg_flags;
+	u32 log_pages;
+	u16 seg_type;
+	u64 last_log_time;
+	u64 last_log_cno;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!desc_array);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(pebi->pebc->parent_si->seg_type > SSDFS_LAST_KNOWN_SEG_TYPE);
+	BUG_ON(pebi->current_log.seg_flags & ~SSDFS_SEG_HDR_FLAG_MASK);
+	BUG_ON(write_offset % fsi->pagesize);
+	BUG_ON((write_offset >> fsi->log_pagesize) > pebi->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_type = pebi->pebc->parent_si->seg_type;
+	log_pages = pebi->log_pages;
+	seg_flags = pebi->current_log.seg_flags;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache,
+						pebi->current_log.start_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %u\n",
+			  pebi->current_log.start_page);
+		return -ERANGE;
+	}
+
+	hdr = kmap_local_page(page);
+
+	ssdfs_memcpy(hdr->desc_array, 0, array_bytes,
+		     desc_array, 0, array_bytes,
+		     array_bytes);
+
+	ssdfs_create_volume_header(fsi, &hdr->volume_hdr);
+
+	err = ssdfs_prepare_volume_header_for_commit(fsi, &hdr->volume_hdr);
+	if (unlikely(err))
+		goto finish_segment_header_preparation;
+
+	err = ssdfs_store_peb_migration_id(pebi, hdr);
+	if (unlikely(err))
+		goto finish_segment_header_preparation;
+
+	hdr->peb_create_time = cpu_to_le64(pebi->peb_create_time);
+
+	last_log_time = pebi->current_log.last_log_time;
+	last_log_cno = pebi->current_log.last_log_cno;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "peb_create_time %llx, last_log_time %llx\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  pebi->peb_create_time,
+		  last_log_time);
+
+	BUG_ON(pebi->peb_create_time > last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_prepare_segment_header_for_commit(fsi,
+						      log_pages,
+						      seg_type,
+						      seg_flags,
+						      last_log_time,
+						      last_log_cno,
+						      hdr);
+	if (unlikely(err))
+		goto finish_segment_header_preparation;
+
+finish_segment_header_preparation:
+	flush_dcache_page(page);
+	kunmap_local(hdr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store segment header: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_flush_current_log_dirty_pages() - flush log's dirty pages
+ * @pebi: pointer on PEB object
+ * @write_offset: current write offset in log
+ *
+ * This function tries to flush the current log's dirty pages.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_flush_current_log_dirty_pages(struct ssdfs_peb_info *pebi,
+					    u32 write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	loff_t peb_offset;
+	struct pagevec pvec;
+	u32 log_bytes, written_bytes;
+	u32 log_start_off;
+	unsigned flushed_pages;
+#ifdef CONFIG_SSDFS_CHECK_LOGICAL_BLOCK_EMPTYNESS
+	u32 pages_per_block;
+#endif /* CONFIG_SSDFS_CHECK_LOGICAL_BLOCK_EMPTYNESS */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(write_offset == 0);
+	BUG_ON(write_offset % pebi->pebc->parent_si->fsi->pagesize);
+	BUG_ON(!pebi->pebc->parent_si->fsi->devops);
+	BUG_ON(!pebi->pebc->parent_si->fsi->devops->writepages);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	pagevec_init(&pvec);
+
+	peb_offset = (pebi->peb_id * fsi->pages_per_peb) << fsi->log_pagesize;
+
+	log_bytes = write_offset;
+	log_start_off = pebi->current_log.start_page << fsi->log_pagesize;
+	written_bytes = 0;
+	flushed_pages = 0;
+
+	while (written_bytes < log_bytes) {
+		pgoff_t index, end;
+		unsigned i;
+		u32 page_start_off, write_size;
+		loff_t iter_write_offset;
+		u32 pagevec_bytes;
+		pgoff_t written_pages = 0;
+
+		index = pebi->current_log.start_page + flushed_pages;
+		end = (pgoff_t)pebi->current_log.start_page + pebi->log_pages;
+		end = min_t(pgoff_t, end, (pgoff_t)(index + PAGEVEC_SIZE));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index %lu, end %lu\n",
+			  index, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_page_array_lookup_range(&pebi->cache,
+						    &index, end,
+						    SSDFS_DIRTY_PAGE_TAG,
+						    PAGEVEC_SIZE,
+						    &pvec);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find dirty pages: "
+				  "index %lu, end %lu, err %d\n",
+				  index, end, err);
+			return -ERANGE;
+		}
+
+		page_start_off = log_start_off + written_bytes;
+		page_start_off %= PAGE_SIZE;
+
+		pagevec_bytes = (u32)pagevec_count(&pvec) * PAGE_SIZE;
+
+		write_size = min_t(u32,
+				   pagevec_bytes - page_start_off,
+				   log_bytes - written_bytes);
+
+		if ((written_bytes + write_size) > log_bytes) {
+			pagevec_reinit(&pvec);
+			SSDFS_ERR("written_bytes %u > log_bytes %u\n",
+				  written_bytes + write_size,
+				  log_bytes);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(write_size % fsi->pagesize);
+		BUG_ON(written_bytes % fsi->pagesize);
+
+		for (i = 1; i < pagevec_count(&pvec); i++) {
+			struct page *page1, *page2;
+
+			page1 = pvec.pages[i - 1];
+			page2 = pvec.pages[i];
+
+			if ((page_index(page1) + 1) != page_index(page2)) {
+				SSDFS_ERR("not contiguous log: "
+					  "page_index1 %lu, page_index2 %lu\n",
+					  page_index(page1),
+					  page_index(page2));
+			}
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		iter_write_offset = peb_offset + log_start_off;
+		iter_write_offset += written_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("iter_write_offset %llu, write_size %u, "
+			  "page_start_off %u\n",
+			  iter_write_offset, write_size, page_start_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_CHECK_LOGICAL_BLOCK_EMPTYNESS
+		pages_per_block = fsi->pagesize / PAGE_SIZE;
+		for (i = 0; i < pagevec_count(&pvec); i += pages_per_block) {
+			u64 byte_off;
+
+			if (!fsi->devops->can_write_page) {
+				SSDFS_DBG("can_write_page is not supported\n");
+				break;
+			}
+
+			byte_off = iter_write_offset;
+			byte_off += i * PAGE_SIZE;
+
+			err = fsi->devops->can_write_page(fsi->sb, byte_off,
+							  true);
+			if (err) {
+				pagevec_reinit(&pvec);
+				ssdfs_fs_error(fsi->sb,
+					__FILE__, __func__, __LINE__,
+					"offset %llu err %d\n",
+					byte_off, err);
+				return err;
+			}
+		}
+#endif /* CONFIG_SSDFS_CHECK_LOGICAL_BLOCK_EMPTYNESS */
+
+		err = fsi->devops->writepages(fsi->sb, iter_write_offset,
+						&pvec,
+						page_start_off,
+						write_size);
+		if (unlikely(err)) {
+			pagevec_reinit(&pvec);
+			SSDFS_ERR("fail to flush pagevec: "
+				  "iter_write_offset %llu, write_size %u, "
+				  "err %d\n",
+				  iter_write_offset, write_size, err);
+			return err;
+		}
+
+		written_pages = write_size / PAGE_SIZE;
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (i < written_pages) {
+				ssdfs_lock_page(page);
+				ClearPageUptodate(page);
+				ssdfs_clear_page_private(page, 0);
+				pvec.pages[i] = NULL;
+				ssdfs_unlock_page(page);
+			} else {
+				ssdfs_lock_page(page);
+				pvec.pages[i] = NULL;
+				ssdfs_unlock_page(page);
+			}
+		}
+
+		end = index + written_pages - 1;
+		err = ssdfs_page_array_clear_dirty_range(&pebi->cache,
+							 index,
+							 end);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clean dirty pages: "
+				  "start %lu, end %lu, err %d\n",
+				  index, end, err);
+		}
+
+		err = ssdfs_page_array_release_pages(&pebi->cache,
+						     &index, end);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release pages: "
+				  "seg_id %llu, peb_id %llu, "
+				  "start %lu, end %lu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, index, end, err);
+		}
+
+		written_bytes += write_size;
+		flushed_pages += written_pages;
+
+		pagevec_reinit(&pvec);
+		cond_resched();
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_commit_log_payload() - commit payload of the log
+ * @pebi: pointer on PEB object
+ * @hdr_desc: log header's metadata descriptors array
+ * @log_has_data: does log contain data? [out]
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ */
+static
+int ssdfs_peb_commit_log_payload(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_metadata_descriptor *hdr_desc,
+				 bool *log_has_data,
+				 pgoff_t *cur_page, u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor *cur_hdr_desc;
+	int area_type;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!hdr_desc || !cur_page || !write_offset || !log_has_data);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	*log_has_data = false;
+
+	cur_hdr_desc = &hdr_desc[SSDFS_BLK_BMAP_INDEX];
+	err = ssdfs_peb_store_block_bmap(pebi, cur_hdr_desc,
+					 cur_page, write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store block bitmap: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   *cur_page, *write_offset, err);
+		goto finish_commit_payload;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0001-payload: cur_page %lu, write_offset %u\n",
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_hdr_desc = &hdr_desc[SSDFS_OFF_TABLE_INDEX];
+	err = ssdfs_peb_store_offsets_table(pebi, cur_hdr_desc,
+					    cur_page, write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store offsets table: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   *cur_page, *write_offset, err);
+		goto finish_commit_payload;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0002-payload: cur_page %lu, write_offset %u\n",
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area_type = SSDFS_LOG_BLK_DESC_AREA;
+	cur_hdr_desc = &hdr_desc[SSDFS_AREA_TYPE2INDEX(area_type)];
+	err = ssdfs_peb_store_blk_desc_table(pebi, cur_hdr_desc,
+					     cur_page, write_offset);
+	if (err == -ENODATA) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("block descriptor area is absent: "
+			   "seg %llu, peb %llu, "
+			   "cur_page %lu, write_offset %u\n",
+			   pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id,
+			   *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_CRIT("fail to store block descriptors table: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   *cur_page, *write_offset, err);
+		goto finish_commit_payload;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0003-payload: cur_page %lu, write_offset %u\n",
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area_type = SSDFS_LOG_DIFFS_AREA;
+	cur_hdr_desc = &hdr_desc[SSDFS_AREA_TYPE2INDEX(area_type)];
+	err = ssdfs_peb_copy_area_pages_into_cache(pebi,
+						   area_type,
+						   cur_hdr_desc,
+						   cur_page,
+						   write_offset);
+	if (err == -ENODATA) {
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_CRIT("fail to move the area %d into PEB cache: "
+			   "seg %llu, peb %llu, cur_page %lu, "
+			   "write_offset %u, err %d\n",
+			   area_type, pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id, *cur_page, *write_offset,
+			   err);
+		goto finish_commit_payload;
+	} else
+		*log_has_data = true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0004-payload: cur_page %lu, write_offset %u\n",
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area_type = SSDFS_LOG_JOURNAL_AREA;
+	cur_hdr_desc = &hdr_desc[SSDFS_AREA_TYPE2INDEX(area_type)];
+	err = ssdfs_peb_copy_area_pages_into_cache(pebi,
+						   area_type,
+						   cur_hdr_desc,
+						   cur_page,
+						   write_offset);
+	if (err == -ENODATA) {
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_CRIT("fail to move the area %d into PEB cache: "
+			   "seg %llu, peb %llu, cur_page %lu, "
+			   "write_offset %u, err %d\n",
+			   area_type, pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id, *cur_page, *write_offset,
+			   err);
+		goto finish_commit_payload;
+	} else
+		*log_has_data = true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0005-payload: cur_page %lu, write_offset %u\n",
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*write_offset % PAGE_SIZE) {
+		(*cur_page)++;
+
+		*write_offset += PAGE_SIZE - 1;
+		*write_offset >>= PAGE_SHIFT;
+		*write_offset <<= PAGE_SHIFT;
+	}
+
+	area_type = SSDFS_LOG_MAIN_AREA;
+	cur_hdr_desc = &hdr_desc[SSDFS_AREA_TYPE2INDEX(area_type)];
+	err = ssdfs_peb_move_area_pages_into_cache(pebi,
+						   area_type,
+						   cur_hdr_desc,
+						   cur_page,
+						   write_offset);
+	if (err == -ENODATA) {
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_CRIT("fail to move the area %d into PEB cache: "
+			   "seg %llu, peb %llu, cur_page %lu, "
+			   "write_offset %u, err %d\n",
+			   area_type, pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id, *cur_page, *write_offset,
+			   err);
+		goto finish_commit_payload;
+	} else
+		*log_has_data = true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0006-payload: cur_page %lu, write_offset %u\n",
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_commit_payload:
+	return err;
+}
+
 /*
  * ssdfs_peb_define_next_log_start() - define start of the next log
  * @pebi: pointer on PEB object
-- 
2.34.1

