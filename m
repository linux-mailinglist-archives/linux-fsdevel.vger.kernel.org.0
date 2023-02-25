Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDEA6A2641
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBYBRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBYBQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:34 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2712848
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:29 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bg11so810094oib.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+oc8VyWeDYkD3EcU5LUBCQGg3XnApkJQ4I3CKTKmEM=;
        b=snJQfisqrg4G7/+MXR1D51TWD2aaV7SQm6hrdaKDTOf8K7F4UoXtj3ZOH+zJ8WFOiO
         dlspvCW9FP3bWfY1IQzRLxiU8wSVrJBnveHPBwV5hxhQ7hURnPXwYnD8/VArcy9KVU8P
         ucg4CtSsy6/s5skLz/IzuIbiNsCscimPmoOv57uZWRJUcbabD8KfEQK8FO15AbxpUpIm
         Vw4UEiewIepHfsOuYza3ItgVtHlVoJ8G354VFyMXpKVaZKp5VGJiIF1N3dB+knDYt9ge
         wBhuC1KkdqO98yZhuW5FWJBlUpJYntJjkYVpxdBlvtkGnitAgJtfifpph3EW1p21f/AI
         8hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+oc8VyWeDYkD3EcU5LUBCQGg3XnApkJQ4I3CKTKmEM=;
        b=BM4EwmkwgfdxUovPKjHeGn8r0q3qwZUxa684E2Tmk/U91DuE6yStcy8eUipLQhO3YK
         0nwOwXKy5eImXLlsEuYs4TkW0B7cslf/9YImGIyFSciXfTs/7ssyWeqf1ZsGOl9A+l6U
         GfAi96MdLOIy0fPT52XsEH/clp35echkRoPpUtrIs6wuFB5yazP9QMU7/6vWDGtkT4FV
         2FBXSigacQ6fxGm5hTdENYA8aBd0YgqDrGRs4D6dVvzpDJdLHAM83SHP0dqmJAB1nC+p
         z4UJPSQf8J+IDKwgZ+5x9H9hEzN4J+zZev6Dh1FWagzJ2juyRwnyG97FrAwmZOblKWcD
         4kKA==
X-Gm-Message-State: AO0yUKVhogKNLWqeX7KbHZlg4OZjWralP12P64fYqeqQBz7CnrriGv/n
        JtsYrfpZToZYTHLuFYXymqKImvPGHFOTSzWl
X-Google-Smtp-Source: AK7set+JgYokM40AbQnHJHP+KxorRCT+GsCIZUFXdz9bEgaVfR/gNyggT1ClK7ekSY1PrrYlW1h2sQ==
X-Received: by 2002:a05:6808:114a:b0:37f:7cf3:a952 with SMTP id u10-20020a056808114a00b0037f7cf3a952mr1040497oiu.0.1677287787375;
        Fri, 24 Feb 2023 17:16:27 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:26 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 25/76] ssdfs: block bitmap initialization logic
Date:   Fri, 24 Feb 2023 17:08:36 -0800
Message-Id: <20230225010927.813929-26-slava@dubeyko.com>
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

Erase block contains sequence of logs. Every log starts with
header that represents a metadata describing content of the log.
Log content can include as metadata as user data payload.
One of the important log's metadata structure is block bitmap.
Block bitmap tracks the state (free, pre-allocated, allocated,
invalid) of logical blocks and accounts distribution of physical
space among metadata and user data payload. Header includes
metadata information that desribes offset or location block
bitmap in the log. Usually, block bitmap is stored after log's
header. Block bitmap could be compressed. Also, log can store
source and destination block bitmaps in the case of migration.
Initialization logic requires to read block bitmap(s) from the
volume, decompress it, and initialize PEB block bitmap object.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_read_thread.c | 2255 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2255 insertions(+)

diff --git a/fs/ssdfs/peb_read_thread.c b/fs/ssdfs/peb_read_thread.c
index c5087373df8d..f6a5b67612af 100644
--- a/fs/ssdfs/peb_read_thread.c
+++ b/fs/ssdfs/peb_read_thread.c
@@ -245,6 +245,2261 @@ int ssdfs_read_blk2off_table_fragment(struct ssdfs_peb_info *pebi,
  *                          READ THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * ssdfs_read_checked_block_bitmap_header() - read and check block bitmap header
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function reads block bitmap header from the volume and
+ * to check it consistency.
+ *
+ * RETURN:
+ * [success] - block bitmap header has been read in consistent state.
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_checked_block_bitmap_header(struct ssdfs_peb_info *pebi,
+					   struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *page;
+	u32 pages_off;
+	u32 area_offset;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	size_t bmap_hdr_size = sizeof(struct ssdfs_block_bitmap_header);
+	size_t hdr_buf_size = max_t(size_t,
+				sizeof(struct ssdfs_segment_header),
+				sizeof(struct ssdfs_partial_log_header));
+	u32 pebsize;
+	u32 read_bytes = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env || !env->log_hdr || !env->footer);
+	BUG_ON(env->log_pages >
+			pebi->pebc->parent_si->fsi->pages_per_peb);
+	BUG_ON((env->log_offset) >
+			pebi->pebc->parent_si->fsi->pages_per_peb);
+	BUG_ON(!env->b_init.bmap_hdr);
+
+	SSDFS_DBG("seg %llu, peb %llu, log_offset %u, log_pages %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  env->log_offset, env->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	pages_off = env->log_offset;
+	pebsize = fsi->pages_per_peb * fsi->pagesize;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, pages_off);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to read checked segment header: "
+			  "peb %llu\n", pebi->peb_id);
+		return -ERANGE;
+	} else {
+		ssdfs_memcpy_from_page(env->log_hdr, 0, hdr_buf_size,
+					page, 0, PAGE_SIZE,
+					hdr_buf_size);
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	err = ssdfs_check_log_header(fsi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to check log header: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (env->has_seg_hdr)
+		err = ssdfs_get_segment_header_blk_bmap_desc(pebi, env, &desc);
+	else
+		err = ssdfs_get_partial_header_blk_bmap_desc(pebi, env, &desc);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get descriptor: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (!desc) {
+		SSDFS_ERR("invalid descriptor pointer\n");
+		return -ERANGE;
+	}
+
+	if (bmap_hdr_size != le16_to_cpu(desc->check.bytes)) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"bmap_hdr_size %zu != desc->check.bytes %u\n",
+				bmap_hdr_size,
+				le16_to_cpu(desc->check.bytes));
+		return -EIO;
+	}
+
+	if (le32_to_cpu(desc->offset) >= pebsize) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"desc->offset %u >= pebsize %u\n",
+				le32_to_cpu(desc->offset), pebsize);
+		return -EIO;
+	}
+
+	area_offset = le32_to_cpu(desc->offset);
+	read_bytes = le16_to_cpu(desc->check.bytes);
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 area_offset, bmap_hdr_size,
+					 env->b_init.bmap_hdr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read block bitmap's header: "
+			  "seg %llu, peb %llu, offset %u, size %zu, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  area_offset, bmap_hdr_size,
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BLOCK BITMAP HEADER: "
+		  "magic: common %#x, key %#x, version (%u.%u), "
+		  "fragments_count %u, bytes_count %u, "
+		  "flags %#x, type %#x\n",
+		  le32_to_cpu(env->b_init.bmap_hdr->magic.common),
+		  le16_to_cpu(env->b_init.bmap_hdr->magic.key),
+		  env->b_init.bmap_hdr->magic.version.major,
+		  env->b_init.bmap_hdr->magic.version.minor,
+		  le16_to_cpu(env->b_init.bmap_hdr->fragments_count),
+		  le32_to_cpu(env->b_init.bmap_hdr->bytes_count),
+		  env->b_init.bmap_hdr->flags,
+		  env->b_init.bmap_hdr->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_csum_valid(&desc->check, env->b_init.bmap_hdr, read_bytes)) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap header has invalid checksum\n");
+		return -EIO;
+	}
+
+	env->b_init.read_bytes += read_bytes;
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_checked_block_bitmap() - read and check block bitmap
+ * @pebi: pointer on PEB object
+ * @req: segment request
+ * @env: init environment [in|out]
+ *
+ * This function reads block bitmap from the volume and
+ * to check it consistency.
+ *
+ * RETURN:
+ * [success] - block bitmap has been read in consistent state.
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_checked_block_bitmap(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_segment_request *req,
+				    struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	size_t hdr_size = sizeof(struct ssdfs_block_bitmap_fragment);
+	size_t desc_size = sizeof(struct ssdfs_fragment_desc);
+	struct ssdfs_fragment_desc *frag_array = NULL;
+	struct ssdfs_block_bitmap_fragment *frag_hdr = NULL;
+	u32 area_offset;
+	void *cdata_buf;
+	u32 chain_compr_bytes, chain_uncompr_bytes;
+	u32 read_bytes, uncompr_bytes;
+	u16 fragments_count;
+	u16 last_free_blk;
+	u32 bmap_bytes = 0;
+	u32 bmap_pages = 0;
+	u32 pages_count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env || !env->log_hdr || !env->footer);
+	BUG_ON(!env->b_init.frag_hdr);
+	BUG_ON(env->log_pages >
+			pebi->pebc->parent_si->fsi->pages_per_peb);
+	BUG_ON(env->log_offset >
+			pebi->pebc->parent_si->fsi->pages_per_peb);
+	BUG_ON(ssdfs_page_vector_count(&env->b_init.array) != 0);
+
+	SSDFS_DBG("seg %llu, peb %llu, log_offset %u, log_pages %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  env->log_offset, env->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (env->has_seg_hdr)
+		err = ssdfs_get_segment_header_blk_bmap_desc(pebi, env, &desc);
+	else
+		err = ssdfs_get_partial_header_blk_bmap_desc(pebi, env, &desc);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get descriptor: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (!desc) {
+		SSDFS_ERR("invalid descriptor pointer\n");
+		return -ERANGE;
+	}
+
+	area_offset = le32_to_cpu(desc->offset);
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 area_offset + env->b_init.read_bytes,
+					 SSDFS_BLKBMAP_FRAG_HDR_CAPACITY,
+					 env->b_init.frag_hdr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read fragment's header: "
+			  "seg %llu, peb %llu, offset %u, size %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  area_offset + env->b_init.read_bytes,
+			  (u32)SSDFS_BLKBMAP_FRAG_HDR_CAPACITY,
+			  err);
+		return err;
+	}
+
+	cdata_buf = ssdfs_read_kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!cdata_buf) {
+		SSDFS_ERR("fail to allocate cdata_buf\n");
+		return -ENOMEM;
+	}
+
+	frag_hdr = env->b_init.frag_hdr;
+
+	frag_array = (struct ssdfs_fragment_desc *)((u8 *)frag_hdr + hdr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BLOCK BITMAP FRAGMENT HEADER: "
+		  "peb_index %u, sequence_id %u, flags %#x, "
+		  "type %#x, last_free_blk %u, "
+		  "metadata_blks %u, invalid_blks %u\n",
+		  le16_to_cpu(frag_hdr->peb_index),
+		  frag_hdr->sequence_id,
+		  frag_hdr->flags,
+		  frag_hdr->type,
+		  le32_to_cpu(frag_hdr->last_free_blk),
+		  le32_to_cpu(frag_hdr->metadata_blks),
+		  le32_to_cpu(frag_hdr->invalid_blks));
+
+	SSDFS_DBG("FRAGMENT CHAIN HEADER: "
+		  "compr_bytes %u, uncompr_bytes %u, "
+		  "fragments_count %u, desc_size %u, "
+		  "magic %#x, type %#x, flags %#x\n",
+		  le32_to_cpu(frag_hdr->chain_hdr.compr_bytes),
+		  le32_to_cpu(frag_hdr->chain_hdr.uncompr_bytes),
+		  le16_to_cpu(frag_hdr->chain_hdr.fragments_count),
+		  le16_to_cpu(frag_hdr->chain_hdr.desc_size),
+		  frag_hdr->chain_hdr.magic,
+		  frag_hdr->chain_hdr.type,
+		  le16_to_cpu(frag_hdr->chain_hdr.flags));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	last_free_blk = le16_to_cpu(frag_hdr->last_free_blk);
+
+	if (last_free_blk >= fsi->pages_per_peb) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"last_free_blk %u is invalid\n",
+				last_free_blk);
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	if (le16_to_cpu(frag_hdr->metadata_blks) > fsi->pages_per_peb) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"metadata_blks %u is invalid\n",
+				le16_to_cpu(frag_hdr->metadata_blks));
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	if (desc_size != le16_to_cpu(frag_hdr->chain_hdr.desc_size)) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"desc_size %u is invalid\n",
+			    le16_to_cpu(frag_hdr->chain_hdr.desc_size));
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	if (frag_hdr->chain_hdr.magic != SSDFS_CHAIN_HDR_MAGIC) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"chain header magic %#x is invalid\n",
+				frag_hdr->chain_hdr.magic);
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	if (frag_hdr->chain_hdr.type != SSDFS_BLK_BMAP_CHAIN_HDR) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"chain header type %#x is invalid\n",
+				frag_hdr->chain_hdr.type);
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	if (le16_to_cpu(frag_hdr->chain_hdr.flags) &
+	    ~SSDFS_CHAIN_HDR_FLAG_MASK) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"unknown chain header flags %#x\n",
+			    le16_to_cpu(frag_hdr->chain_hdr.flags));
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	fragments_count = le16_to_cpu(frag_hdr->chain_hdr.fragments_count);
+	if (fragments_count == 0) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"block bitmap is corrupted: "
+				"fragments count is zero\n");
+		err = -EIO;
+		goto fail_read_blk_bmap;
+	}
+
+	env->b_init.read_bytes += hdr_size + (fragments_count * desc_size);
+
+	chain_compr_bytes = le32_to_cpu(frag_hdr->chain_hdr.compr_bytes);
+	chain_uncompr_bytes = le32_to_cpu(frag_hdr->chain_hdr.uncompr_bytes);
+	read_bytes = 0;
+	uncompr_bytes = 0;
+
+	if (last_free_blk == 0) {
+		/* need to process as minumum one page */
+		bmap_pages = 1;
+	} else {
+		bmap_bytes = BLK_BMAP_BYTES(last_free_blk);
+		bmap_pages = (bmap_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+	}
+
+	pages_count = min_t(u32, (u32)fragments_count, bmap_pages);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_free_blk %u, bmap_bytes %u, "
+		  "bmap_pages %u, fragments_count %u, "
+		  "pages_count %u\n",
+		  last_free_blk, bmap_bytes,
+		  bmap_pages, fragments_count,
+		  pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < fragments_count; i++) {
+		struct ssdfs_fragment_desc *frag_desc;
+		struct page *page;
+		u16 sequence_id = i;
+
+		if (read_bytes >= chain_compr_bytes ||
+		    uncompr_bytes >= chain_uncompr_bytes) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+					"block bitmap is corrupted: "
+					"fragments header: "
+					"compr_bytes %u, "
+					"uncompr_bytes %u\n",
+					chain_compr_bytes,
+					chain_uncompr_bytes);
+			err = -EIO;
+			goto fail_read_blk_bmap;
+		}
+
+		frag_desc = &frag_array[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("FRAGMENT DESCRIPTOR: index %d, "
+			  "offset %u, compr_size %u, uncompr_size %u, "
+			  "checksum %#x, sequence_id %u, magic %#x, "
+			  "type %#x, flags %#x\n",
+			  i,
+			  le32_to_cpu(frag_desc->offset),
+			  le16_to_cpu(frag_desc->compr_size),
+			  le16_to_cpu(frag_desc->uncompr_size),
+			  le32_to_cpu(frag_desc->checksum),
+			  frag_desc->sequence_id,
+			  frag_desc->magic,
+			  frag_desc->type,
+			  frag_desc->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (i >= pages_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("account fragment bytes: "
+				  "i %d, pages_count %u\n",
+				  i, pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto account_fragment_bytes;
+		}
+
+		page = ssdfs_page_vector_allocate(&env->b_init.array);
+		if (unlikely(IS_ERR_OR_NULL(page))) {
+			err = !page ? -ENOMEM : PTR_ERR(page);
+			SSDFS_ERR("fail to add pagevec page: "
+				  "sequence_id %u, "
+				  "fragments count %u, err %d\n",
+				  sequence_id, fragments_count, err);
+			goto fail_read_blk_bmap;
+		}
+
+		ssdfs_lock_page(page);
+		err = ssdfs_read_checked_fragment(pebi, req, area_offset,
+						  sequence_id,
+						  frag_desc,
+						  cdata_buf, page);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read checked fragment: "
+				  "offset %u, compr_size %u, "
+				  "uncompr_size %u, sequence_id %u, "
+				  "flags %#x, err %d\n",
+				  le32_to_cpu(frag_desc->offset),
+				  le16_to_cpu(frag_desc->compr_size),
+				  le16_to_cpu(frag_desc->uncompr_size),
+				  le16_to_cpu(frag_desc->sequence_id),
+				  le16_to_cpu(frag_desc->flags),
+				  err);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("FRAG ARRAY DUMP: \n");
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					     frag_array,
+					     fragments_count * desc_size);
+			SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			goto fail_read_blk_bmap;
+		}
+
+account_fragment_bytes:
+		read_bytes += le16_to_cpu(frag_desc->compr_size);
+		uncompr_bytes += le16_to_cpu(frag_desc->uncompr_size);
+		env->b_init.read_bytes += le16_to_cpu(frag_desc->compr_size);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_free_blk %u, metadata_blks %u, invalid_blks %u\n",
+		  le16_to_cpu(frag_hdr->last_free_blk),
+		  le16_to_cpu(frag_hdr->metadata_blks),
+		  le16_to_cpu(frag_hdr->invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+fail_read_blk_bmap:
+	ssdfs_read_kfree(cdata_buf);
+	return err;
+}
+
+/*
+ * ssdfs_init_block_bitmap_fragment() - init block bitmap fragment
+ * @pebi: pointer on PEB object
+ * @req: segment request
+ * @env: init environment [in|out]
+ *
+ * This function reads block bitmap's fragment from the volume and
+ * try to initialize the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_init_block_bitmap_fragment(struct ssdfs_peb_info *pebi,
+				     struct ssdfs_segment_request *req,
+				     struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	u64 cno;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!env || !env->log_hdr || !env->footer);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u, "
+		  "log_offset %u, log_pages %u, "
+		  "fragment_index %d, read_bytes %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index,
+		  env->log_offset, env->log_pages,
+		  env->b_init.fragment_index,
+		  env->b_init.read_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_page_vector_init(&env->b_init.array);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init page vector: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		goto fail_init_blk_bmap_fragment;
+	}
+
+	err = ssdfs_read_checked_block_bitmap(pebi, req, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read block bitmap: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		goto fail_init_blk_bmap_fragment;
+	}
+
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+
+	if (env->has_seg_hdr) {
+		struct ssdfs_segment_header *seg_hdr = NULL;
+
+		seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+		cno = le64_to_cpu(seg_hdr->cno);
+	} else {
+		struct ssdfs_partial_log_header *pl_hdr = NULL;
+
+		pl_hdr = SSDFS_PLH(env->log_hdr);
+		cno = le64_to_cpu(pl_hdr->cno);
+	}
+
+	err = ssdfs_segment_blk_bmap_partial_init(seg_blkbmap,
+						  pebi->peb_index,
+						  &env->b_init.array,
+						  env->b_init.frag_hdr,
+						  cno);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to initialize block bitmap: "
+			  "seg %llu, peb %llu, cno %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, cno, err);
+		goto fail_init_blk_bmap_fragment;
+	}
+
+fail_init_blk_bmap_fragment:
+	ssdfs_page_vector_release(&env->b_init.array);
+
+	return err;
+}
+
+/*
+ * ssdfs_read_blk2off_table_header() - read blk2off table header
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk2off table header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_blk2off_table_header(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	struct ssdfs_blk2off_table_header *hdr = NULL;
+	size_t hdr_size = sizeof(struct ssdfs_blk2off_table_header);
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env || !env->log_hdr || !env->footer);
+	BUG_ON(pagevec_count(&env->t_init.pvec) != 0);
+
+	SSDFS_DBG("seg %llu, peb %llu, read_off %u, write_off %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  env->t_init.read_off, env->t_init.write_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (env->has_seg_hdr) {
+		err = ssdfs_get_segment_header_blk2off_tbl_desc(pebi, env,
+								&desc);
+	} else {
+		err = ssdfs_get_partial_header_blk2off_tbl_desc(pebi, env,
+								&desc);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get descriptor: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (!desc) {
+		SSDFS_ERR("invalid descriptor pointer\n");
+		return -ERANGE;
+	}
+
+	env->t_init.read_off = le32_to_cpu(desc->offset);
+	env->t_init.blk2off_tbl_hdr_off = env->t_init.read_off;
+	env->t_init.write_off = 0;
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 env->t_init.read_off, hdr_size,
+					 &env->t_init.tbl_hdr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read table's header: "
+			  "seg %llu, peb %llu, offset %u, size %zu, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  env->t_init.read_off, hdr_size, err);
+		return err;
+	}
+
+	hdr = &env->t_init.tbl_hdr;
+
+	if (le32_to_cpu(hdr->magic.common) != SSDFS_SUPER_MAGIC ||
+	    le16_to_cpu(hdr->magic.key) != SSDFS_BLK2OFF_TABLE_HDR_MAGIC) {
+		SSDFS_ERR("invalid magic of blk2off_table\n");
+		return -EIO;
+	}
+
+	page = ssdfs_read_add_pagevec_page(&env->t_init.pvec);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		err = !page ? -ENOMEM : PTR_ERR(page);
+		SSDFS_ERR("fail to add pagevec page: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_lock_page(page);
+	ssdfs_memcpy_to_page(page, 0, PAGE_SIZE,
+			     hdr, 0, hdr_size,
+			     hdr_size);
+	ssdfs_unlock_page(page);
+
+	env->t_init.read_off += offsetof(struct ssdfs_blk2off_table_header,
+					sequence);
+	env->t_init.write_off += offsetof(struct ssdfs_blk2off_table_header,
+					sequence);
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_blk2off_byte_stream() - read blk2off's byte stream
+ * @pebi: pointer on PEB object
+ * @read_bytes: amount of bytes for reading
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk2off table's byte stream.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_blk2off_byte_stream(struct ssdfs_peb_info *pebi,
+				   u32 read_bytes,
+				   struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env);
+
+	SSDFS_DBG("seg %llu, peb %llu, read_bytes %u, "
+		  "read_off %u, write_off %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  read_bytes, env->t_init.read_off,
+		  env->t_init.write_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	while (read_bytes > 0) {
+		struct page *page = NULL;
+		void *kaddr;
+		pgoff_t page_index = env->t_init.write_off >> PAGE_SHIFT;
+		u32 capacity = pagevec_count(&env->t_init.pvec) << PAGE_SHIFT;
+		u32 offset, bytes;
+
+		if (env->t_init.write_off >= capacity) {
+			page = ssdfs_read_add_pagevec_page(&env->t_init.pvec);
+			if (unlikely(IS_ERR_OR_NULL(page))) {
+				err = !page ? -ENOMEM : PTR_ERR(page);
+				SSDFS_ERR("fail to add pagevec page: err %d\n",
+					  err);
+				return err;
+			}
+		} else {
+			page = env->t_init.pvec.pages[page_index];
+			if (unlikely(!page)) {
+				err = -ERANGE;
+				SSDFS_ERR("fail to get page: err %d\n",
+					  err);
+				return err;
+			}
+		}
+
+		offset = env->t_init.write_off % PAGE_SIZE;
+		bytes = min_t(u32, read_bytes, PAGE_SIZE - offset);
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = ssdfs_unaligned_read_cache(pebi,
+						 env->t_init.read_off, bytes,
+						 (u8 *)kaddr + offset);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read page: "
+				  "seg %llu, peb %llu, offset %u, "
+				  "size %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, env->t_init.read_off,
+				  bytes, err);
+			return err;
+		}
+
+		read_bytes -= bytes;
+		env->t_init.read_off += bytes;
+		env->t_init.write_off += bytes;
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_blk2off_table_extents() - read blk2off table's extents
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk2off table's extents.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_blk2off_table_extents(struct ssdfs_peb_info *pebi,
+				     struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 extents_off;
+	u16 extent_count;
+	size_t extent_size = sizeof(struct ssdfs_translation_extent);
+	u32 offset = offsetof(struct ssdfs_blk2off_table_header, sequence);
+	u32 read_bytes;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extents_off = le16_to_cpu(env->t_init.tbl_hdr.extents_off);
+	extent_count = le16_to_cpu(env->t_init.tbl_hdr.extents_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "extents_off %u, extent_count %u, "
+		  "read_off %u, write_off %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  extents_off, extent_count,
+		  env->t_init.read_off,
+		  env->t_init.write_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (offset != extents_off) {
+		SSDFS_ERR("extents_off %u != offset %u\n",
+			  extents_off, offset);
+		return -EIO;
+	}
+
+	if (extent_count == 0 || extent_count == U16_MAX) {
+		SSDFS_ERR("invalid extent_count %u\n",
+			  extent_count);
+		return -EIO;
+	}
+
+	read_bytes = extent_size * extent_count;
+
+	err = ssdfs_read_blk2off_byte_stream(pebi, read_bytes, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read byte stream: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_blk2off_pot_fragment() - read blk2off table's POT fragment
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk2off table's Physical Offsets Table
+ * fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_blk2off_pot_fragment(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_phys_offset_table_header hdr;
+	size_t hdr_size = sizeof(struct ssdfs_phys_offset_table_header);
+	u32 fragment_start;
+	u32 next_frag_off;
+	u32 read_bytes;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "read_off %u, write_off %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  env->t_init.read_off, env->t_init.write_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment_start = env->t_init.read_off;
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 env->t_init.read_off, hdr_size,
+					 &hdr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read page: "
+			  "seg %llu, peb %llu, offset %u, "
+			  "size %zu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, env->t_init.read_off,
+			  hdr_size, err);
+		return err;
+	}
+
+	if (le32_to_cpu(hdr.magic) != SSDFS_PHYS_OFF_TABLE_MAGIC) {
+		SSDFS_ERR("invalid magic\n");
+		return -EIO;
+	}
+
+	read_bytes = le32_to_cpu(hdr.byte_size);
+
+	err = ssdfs_read_blk2off_byte_stream(pebi, read_bytes, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read byte stream: err %d\n",
+			  err);
+		return err;
+	}
+
+	next_frag_off = le16_to_cpu(hdr.next_fragment_off);
+
+	if (next_frag_off >= U16_MAX)
+		goto finish_read_blk2off_pot_fragment;
+
+	env->t_init.read_off = fragment_start + next_frag_off;
+
+finish_read_blk2off_pot_fragment:
+	return 0;
+}
+
+/*
+ * ssdfs_read_blk2off_table_fragment() - read blk2off table's log's fragments
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk2off table's log's fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_blk2off_table_fragment(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 fragment_count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!env || !env->log_hdr || !env->footer);
+	BUG_ON(pagevec_count(&env->t_init.pvec) != 0);
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	env->t_init.read_off = 0;
+	env->t_init.write_off = 0;
+
+	err = ssdfs_read_blk2off_table_header(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read translation table header: "
+			  "seg %llu, peb %llu, "
+			  "read_off %u, write_off %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  env->t_init.read_off, env->t_init.write_off,
+			  err);
+		goto fail_read_blk2off_fragments;
+	}
+
+	err = ssdfs_read_blk2off_table_extents(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read translation table's extents: "
+			  "seg %llu, peb %llu, "
+			  "read_off %u, write_off %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  env->t_init.read_off, env->t_init.write_off,
+			  err);
+		goto fail_read_blk2off_fragments;
+	}
+
+	fragment_count = le16_to_cpu(env->t_init.tbl_hdr.fragments_count);
+
+	for (i = 0; i < fragment_count; i++) {
+		err = ssdfs_read_blk2off_pot_fragment(pebi, env);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read physical offset table's "
+				  "fragment: seg %llu, peb %llu, "
+				  "fragment_index %d, "
+				  "read_off %u, write_off %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  i, env->t_init.read_off,
+				  env->t_init.write_off, err);
+			goto fail_read_blk2off_fragments;
+		}
+	}
+
+fail_read_blk2off_fragments:
+	return err;
+}
+
+/*
+ * ssdfs_correct_zone_block_bitmap() - set all migrated blocks as invalidated
+ * @pebi: pointer on PEB object
+ *
+ * This function tries to mark all migrated blocks as
+ * invalidated for the case of source zone. Actually, invalidated
+ * extents will be added into the queue. Invalidation operation
+ * happens after complete intialization of segment object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_correct_zone_block_bitmap(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_invextree_info *invextree;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_btree_search *search;
+	struct ssdfs_raw_extent extent;
+	struct ssdfs_raw_extent *found;
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+	u32 logical_blk = 0;
+	u32 len;
+	u32 count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebi->pebc->parent_si;
+	fsi = si->fsi;
+	len = fsi->pages_per_seg;
+
+	invextree = fsi->invextree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!invextree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	shextree = fsi->shextree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!shextree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	do {
+		extent.seg_id = cpu_to_le64(si->seg_id);
+		extent.logical_blk = cpu_to_le32(logical_blk);
+		extent.len = cpu_to_le32(len);
+
+		ssdfs_btree_search_init(search);
+		err = ssdfs_invextree_find(invextree, &extent, search);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find invalidated extents: "
+				  "seg_id %llu, logical_blk %u, len %u\n",
+				  si->seg_id, logical_blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find invalidated extents: "
+				  "seg_id %llu, logical_blk %u, len %u\n",
+				  si->seg_id, logical_blk, len);
+			goto finish_correct_zone_block_bmap;
+		}
+
+		count = search->result.items_in_buffer;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.buf);
+		BUG_ON(count == 0);
+		BUG_ON((count * item_size) != search->result.buf_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		for (i = 0; i < count; i++) {
+			found = (struct ssdfs_raw_extent *)search->result.buf;
+			found += i;
+
+			err = ssdfs_shextree_add_pre_invalid_extent(shextree,
+						SSDFS_INVALID_EXTENTS_BTREE_INO,
+						found);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add pre-invalid extent: "
+					  "seg_id %llu, logical_blk %u, "
+					  "len %u, err %d\n",
+					  le64_to_cpu(found->seg_id),
+					  le32_to_cpu(found->logical_blk),
+					  le32_to_cpu(found->len),
+					  err);
+				goto finish_correct_zone_block_bmap;
+			}
+		}
+
+		found = (struct ssdfs_raw_extent *)search->result.buf;
+		found += count - 1;
+
+		logical_blk = le32_to_cpu(found->logical_blk) +
+				le32_to_cpu(found->len);
+
+		if (logical_blk >= fsi->pages_per_seg)
+			len = 0;
+		else
+			len = fsi->pages_per_seg - logical_blk;
+	} while (len > 0);
+
+	if (err == -ENODATA) {
+		/* all extents have been processed */
+		err = 0;
+	}
+
+finish_correct_zone_block_bmap:
+	ssdfs_btree_search_free(search);
+	return err;
+}
+
+/*
+ * ssdfs_peb_init_using_metadata_state() - initialize "using" PEB
+ * @pebi: pointer on PEB object
+ * @env: read operation's init environment
+ * @req: read request
+ *
+ * This function tries to initialize last actual metadata state for
+ * the case of "using" state of PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_peb_init_using_metadata_state(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	u16 fragments_count;
+	u32 bytes_count;
+	u16 new_log_start_page;
+	u64 cno;
+	int sequence_id = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !req);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebi->pebc->parent_si;
+	fsi = si->fsi;
+
+	/*
+	 * Allow creating thread to continue creation logic.
+	 */
+	complete(&req->result.wait);
+
+	err = ssdfs_peb_get_log_pages_count(fsi, pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define log_pages: "
+			  "seg %llu, peb %llu\n",
+			  si->seg_id, pebi->peb_id);
+		goto fail_init_using_blk_bmap;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (fsi->pages_per_peb % env->log_pages) {
+		SSDFS_WARN("fsi->pages_per_peb %u, log_pages %u\n",
+			   fsi->pages_per_peb, env->log_pages);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->log_pages = env->log_pages;
+
+	err = ssdfs_find_last_partial_log(fsi, pebi, env,
+					  &new_log_start_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find last partial log: err %d\n", err);
+		goto fail_init_using_blk_bmap;
+	}
+
+	err = ssdfs_pre_fetch_block_bitmap(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch block bitmap: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_using_blk_bmap;
+	}
+
+	err = ssdfs_read_checked_block_bitmap_header(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read block bitmap header: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_using_blk_bmap;
+	}
+
+	fragments_count = le16_to_cpu(env->b_init.bmap_hdr->fragments_count);
+	bytes_count = le32_to_cpu(env->b_init.bmap_hdr->bytes_count);
+
+	for (i = 0; i < fragments_count; i++) {
+		env->b_init.fragment_index = i;
+		err = ssdfs_init_block_bitmap_fragment(pebi, req, env);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init block bitmap: "
+				  "peb_id %llu, peb_index %u, "
+				  "log_offset %u, fragment_index %u, "
+				  "read_bytes %u, err %d\n",
+				  pebi->peb_id, pebi->peb_index,
+				  env->log_offset, i,
+				  env->b_init.read_bytes, err);
+			goto fail_init_using_blk_bmap;
+		}
+	}
+
+	if (bytes_count != env->b_init.read_bytes) {
+		SSDFS_WARN("bytes_count %u != read_bytes %u\n",
+			   bytes_count, env->b_init.read_bytes);
+		err = -EIO;
+		goto fail_init_using_blk_bmap;
+	}
+
+	if (fsi->is_zns_device &&
+	    is_ssdfs_peb_containing_user_data(pebi->pebc)) {
+		err = ssdfs_correct_zone_block_bitmap(pebi);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to correct zone's block bitmap: "
+				  "seg %llu, peb %llu, peb_index %u, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, pebi->peb_index,
+				  err);
+			goto fail_init_using_blk_bmap;
+		}
+	}
+
+	BUG_ON(new_log_start_page >= U16_MAX);
+
+	if (env->has_seg_hdr) {
+		/* first log */
+		sequence_id = 0;
+	} else {
+		pl_hdr = SSDFS_PLH(env->log_hdr);
+		sequence_id = le32_to_cpu(pl_hdr->sequence_id);
+	}
+
+	BUG_ON((sequence_id + 1) >= INT_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("new_log_start_page %u\n", new_log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (new_log_start_page < fsi->pages_per_peb) {
+		u16 free_pages;
+		u16 min_log_pages;
+
+		/*
+		 * Set the value of log's start page
+		 * by temporary value. It needs for
+		 * estimation of min_partial_log_pages.
+		 */
+		ssdfs_peb_current_log_lock(pebi);
+		pebi->current_log.start_page = new_log_start_page;
+		ssdfs_peb_current_log_unlock(pebi);
+
+		free_pages = new_log_start_page % pebi->log_pages;
+		free_pages = pebi->log_pages - free_pages;
+		min_log_pages = ssdfs_peb_estimate_min_partial_log_pages(pebi);
+		sequence_id++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free_pages %u, min_log_pages %u, "
+			  "new_log_start_page %u\n",
+			  free_pages, min_log_pages,
+			  new_log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (free_pages == pebi->log_pages) {
+			/* start new full log */
+			sequence_id = 0;
+		} else if (free_pages < min_log_pages) {
+			SSDFS_WARN("POTENTIAL HOLE: "
+				   "seg %llu, peb %llu, "
+				   "peb_index %u, start_page %u, "
+				   "free_pages %u, min_log_pages %u, "
+				   "new_log_start_page %u\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_id, pebi->peb_index,
+				   new_log_start_page,
+				   free_pages, min_log_pages,
+				   new_log_start_page + free_pages);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			new_log_start_page += free_pages;
+			free_pages = pebi->log_pages;
+			sequence_id = 0;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free_pages %u, min_log_pages %u, "
+			  "new_log_start_page %u\n",
+			  free_pages, min_log_pages,
+			  new_log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		bytes_count = le32_to_cpu(env->b_init.bmap_hdr->bytes_count);
+		ssdfs_peb_current_log_init(pebi, free_pages,
+					   new_log_start_page,
+					   sequence_id,
+					   bytes_count);
+	} else {
+		sequence_id = 0;
+		ssdfs_peb_current_log_init(pebi,
+					   0,
+					   new_log_start_page,
+					   sequence_id,
+					   U32_MAX);
+	}
+
+fail_init_using_blk_bmap:
+	if (unlikely(err))
+		goto fail_init_using_peb;
+
+	err = ssdfs_pre_fetch_blk2off_table_area(pebi, env);
+	if (err == -ENOENT) {
+		SSDFS_DBG("blk2off table's fragment is absent\n");
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch blk2off_table area: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_using_peb;
+	}
+
+	err = ssdfs_pre_fetch_blk_desc_table_area(pebi, env);
+	if (err == -ENOENT) {
+		SSDFS_DBG("blk desc table's fragment is absent\n");
+		/* continue logic -> process free extents */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch blk desc table area: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_using_peb;
+	}
+
+	err = ssdfs_read_blk2off_table_fragment(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read translation table fragments: "
+			  "seg %llu, peb %llu, err %d\n",
+			  si->seg_id, pebi->peb_id, err);
+		goto fail_init_using_peb;
+	}
+
+	if (env->has_seg_hdr) {
+		seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+		cno = le64_to_cpu(seg_hdr->cno);
+	} else {
+		pl_hdr = SSDFS_PLH(env->log_hdr);
+		cno = le64_to_cpu(pl_hdr->cno);
+	}
+
+	err = ssdfs_blk2off_table_partial_init(si->blk2off_table,
+						&env->t_init.pvec,
+						&env->bdt_init.pvec,
+						pebi->peb_index, cno);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to start initialization of offset table: "
+			  "seg %llu, peb %llu, err %d\n",
+			  si->seg_id, pebi->peb_id, err);
+		goto fail_init_using_peb;
+	}
+
+fail_init_using_peb:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return err;
+}
+
+/*
+ * ssdfs_peb_init_used_metadata_state() - initialize "used" PEB
+ * @pebi: pointer on PEB object
+ * @env: read operation's init environment
+ * @req: read request
+ *
+ * This function tries to initialize last actual metadata state for
+ * the case of "used" state of PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_peb_init_used_metadata_state(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	u16 fragments_count;
+	u32 bytes_count;
+	u16 new_log_start_page;
+	u64 cno;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !req);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebi->pebc->parent_si;
+	fsi = si->fsi;
+
+	/*
+	 * Allow creating thread to continue creation logic.
+	 */
+	complete(&req->result.wait);
+
+	err = ssdfs_peb_get_log_pages_count(fsi, pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define log_pages: "
+			  "seg %llu, peb %llu\n",
+			  si->seg_id, pebi->peb_id);
+		goto fail_init_used_blk_bmap;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (fsi->pages_per_peb % env->log_pages) {
+		SSDFS_WARN("fsi->pages_per_peb %u, log_pages %u\n",
+			   fsi->pages_per_peb, env->log_pages);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->log_pages = env->log_pages;
+
+	err = ssdfs_find_last_partial_log(fsi, pebi, env,
+					  &new_log_start_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find last partial log: err %d\n", err);
+		goto fail_init_used_blk_bmap;
+	}
+
+	err = ssdfs_pre_fetch_block_bitmap(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch block bitmap: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_used_blk_bmap;
+	}
+
+	err = ssdfs_read_checked_block_bitmap_header(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read block bitmap header: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_used_blk_bmap;
+	}
+
+	fragments_count = le16_to_cpu(env->b_init.bmap_hdr->fragments_count);
+	bytes_count = le32_to_cpu(env->b_init.bmap_hdr->bytes_count);
+
+	for (i = 0; i < fragments_count; i++) {
+		env->b_init.fragment_index = i;
+		err = ssdfs_init_block_bitmap_fragment(pebi, req, env);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init block bitmap: "
+				  "peb_id %llu, peb_index %u, "
+				  "log_offset %u, fragment_index %u, "
+				  "read_bytes %u, err %d\n",
+				  pebi->peb_id, pebi->peb_index,
+				  env->log_offset, i,
+				  env->b_init.read_bytes, err);
+			goto fail_init_used_blk_bmap;
+		}
+	}
+
+	if (bytes_count != env->b_init.read_bytes) {
+		SSDFS_WARN("bytes_count %u != read_bytes %u\n",
+			   bytes_count, env->b_init.read_bytes);
+		err = -EIO;
+		goto fail_init_used_blk_bmap;
+	}
+
+	if (fsi->is_zns_device &&
+	    is_ssdfs_peb_containing_user_data(pebi->pebc)) {
+		err = ssdfs_correct_zone_block_bitmap(pebi);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to correct zone's block bitmap: "
+				  "seg %llu, peb %llu, peb_index %u, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, pebi->peb_index,
+				  err);
+			goto fail_init_used_blk_bmap;
+		}
+	}
+
+	ssdfs_peb_current_log_init(pebi, 0, fsi->pages_per_peb, 0, U32_MAX);
+
+fail_init_used_blk_bmap:
+	if (unlikely(err))
+		goto fail_init_used_peb;
+
+	err = ssdfs_pre_fetch_blk2off_table_area(pebi, env);
+	if (err == -ENOENT) {
+		SSDFS_DBG("blk2off table's fragment is absent\n");
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch blk2off_table area: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_used_peb;
+	}
+
+	err = ssdfs_pre_fetch_blk_desc_table_area(pebi, env);
+	if (err == -ENOENT) {
+		SSDFS_DBG("blk desc table's fragment is absent\n");
+		/* continue logic -> process free extents */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch blk desc table area: "
+			  "seg %llu, peb %llu, log_offset %u, err %d\n",
+			  si->seg_id, pebi->peb_id,
+			  env->log_offset, err);
+		goto fail_init_used_peb;
+	}
+
+	err = ssdfs_read_blk2off_table_fragment(pebi, env);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read translation table fragments: "
+			  "seg %llu, peb %llu, err %d\n",
+			  si->seg_id, pebi->peb_id, err);
+		goto fail_init_used_peb;
+	}
+
+	if (env->has_seg_hdr) {
+		seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+		cno = le64_to_cpu(seg_hdr->cno);
+	} else {
+		pl_hdr = SSDFS_PLH(env->log_hdr);
+		cno = le64_to_cpu(pl_hdr->cno);
+	}
+
+	err = ssdfs_blk2off_table_partial_init(si->blk2off_table,
+						&env->t_init.pvec,
+						&env->bdt_init.pvec,
+						pebi->peb_index,
+						cno);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to start initialization of offset table: "
+			  "seg %llu, peb %llu, err %d\n",
+			  si->seg_id, pebi->peb_id, err);
+		goto fail_init_used_peb;
+	}
+
+fail_init_used_peb:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return err;
+}
+
+/*
+ * ssdfs_src_peb_init_using_metadata_state() - init src "using" PEB container
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This function tries to initialize "using" PEB container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_src_peb_init_using_metadata_state(struct ssdfs_peb_container *pebc,
+					    struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi;
+	int items_state;
+	int id1, id2;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	items_state = atomic_read(&pebc->items_state);
+	switch(items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		/* valid states */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -ERANGE;
+	};
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->src_peb;
+	if (!pebi) {
+		SSDFS_WARN("source PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_src_init_using_metadata_state;
+	}
+
+	err = ssdfs_prepare_read_init_env(&pebi->env, fsi->pages_per_peb);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init read environment: err %d\n",
+			  err);
+		goto finish_src_init_using_metadata_state;
+	}
+
+	err = ssdfs_peb_init_using_metadata_state(pebi, &pebi->env, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init using metadata state: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		ssdfs_segment_blk_bmap_init_failed(&pebc->parent_si->blk_bmap,
+						   pebc->peb_index);
+		goto finish_src_init_using_metadata_state;
+	}
+
+	id1 = pebi->env.cur_migration_id;
+
+	if (!is_peb_migration_id_valid(id1)) {
+		err = -EIO;
+		SSDFS_ERR("invalid peb_migration_id: "
+			  "seg_id %llu, peb_index %u, "
+			  "peb_migration_id %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  id1);
+		goto finish_src_init_using_metadata_state;
+	}
+
+	id2 = ssdfs_get_peb_migration_id(pebi);
+
+	if (id2 == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+		/* it needs to initialize the migration id */
+		ssdfs_set_peb_migration_id(pebi, id1);
+	} else if (is_peb_migration_id_valid(id2)) {
+		if (id1 != id2) {
+			err = -ERANGE;
+			SSDFS_ERR("migration_id1 %d != migration_id2 %d\n",
+				  id1, id2);
+			goto finish_src_init_using_metadata_state;
+		} else {
+			/*
+			 * Do nothing.
+			 */
+		}
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("invalid migration_id %d\n", id2);
+		goto finish_src_init_using_metadata_state;
+	}
+
+	atomic_set(&pebi->state,
+		   SSDFS_PEB_OBJECT_INITIALIZED);
+	complete_all(&pebi->init_end);
+
+finish_src_init_using_metadata_state:
+	ssdfs_destroy_init_env(&pebi->env);
+	up_read(&pebc->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_dst_peb_init_using_metadata_state() - init dst "using" PEB container
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This function tries to initialize "using" PEB container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_dst_peb_init_using_metadata_state(struct ssdfs_peb_container *pebc,
+					    struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi;
+	int items_state;
+	int id1, id2;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	items_state = atomic_read(&pebc->items_state);
+	switch(items_state) {
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		/* valid states */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -ERANGE;
+	};
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->dst_peb;
+	if (!pebi) {
+		SSDFS_WARN("destination PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_dst_init_using_metadata_state;
+	}
+
+	err = ssdfs_prepare_read_init_env(&pebi->env, fsi->pages_per_peb);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init read environment: err %d\n",
+			  err);
+		goto finish_dst_init_using_metadata_state;
+	}
+
+	err = ssdfs_peb_init_using_metadata_state(pebi, &pebi->env, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init using metadata state: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		ssdfs_segment_blk_bmap_init_failed(&pebc->parent_si->blk_bmap,
+						   pebc->peb_index);
+		goto finish_dst_init_using_metadata_state;
+	}
+
+	id1 = pebi->env.cur_migration_id;
+
+	if (!is_peb_migration_id_valid(id1)) {
+		err = -EIO;
+		SSDFS_ERR("invalid peb_migration_id: "
+			  "seg_id %llu, peb_index %u, "
+			  "peb_migration_id %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  id1);
+		goto finish_dst_init_using_metadata_state;
+	}
+
+	ssdfs_set_peb_migration_id(pebc->dst_peb, id1);
+
+	atomic_set(&pebc->dst_peb->state,
+		   SSDFS_PEB_OBJECT_INITIALIZED);
+	complete_all(&pebc->dst_peb->init_end);
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		if (!pebc->src_peb) {
+			SSDFS_WARN("source PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_dst_init_using_metadata_state;
+		}
+
+		id1 = pebi->env.prev_migration_id;
+
+		if (!is_peb_migration_id_valid(id1)) {
+			err = -EIO;
+			SSDFS_ERR("invalid peb_migration_id: "
+				  "seg_id %llu, peb_index %u, "
+				  "peb_migration_id %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  id1);
+			goto finish_dst_init_using_metadata_state;
+		}
+
+		id2 = ssdfs_get_peb_migration_id(pebc->src_peb);
+
+		if (id2 == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+			/* it needs to initialize the migration id */
+			ssdfs_set_peb_migration_id(pebc->src_peb, id1);
+			atomic_set(&pebc->src_peb->state,
+				   SSDFS_PEB_OBJECT_INITIALIZED);
+			complete_all(&pebc->src_peb->init_end);
+		} else if (is_peb_migration_id_valid(id2)) {
+			if (id1 != id2) {
+				err = -ERANGE;
+				SSDFS_ERR("id1 %d != id2 %d\n",
+					  id1, id2);
+				goto finish_dst_init_using_metadata_state;
+			} else {
+				/*
+				 * Do nothing.
+				 */
+			}
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("invalid migration_id %d\n", id2);
+			goto finish_dst_init_using_metadata_state;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	};
+
+finish_dst_init_using_metadata_state:
+	ssdfs_destroy_init_env(&pebi->env);
+	up_read(&pebc->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_src_peb_init_used_metadata_state() - init src "used" PEB container
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This function tries to initialize "used" PEB container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_src_peb_init_used_metadata_state(struct ssdfs_peb_container *pebc,
+					   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi;
+	int items_state;
+	int id1, id2;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	items_state = atomic_read(&pebc->items_state);
+	switch(items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		/* valid states */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -ERANGE;
+	};
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->src_peb;
+	if (!pebi) {
+		SSDFS_WARN("source PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_src_init_used_metadata_state;
+	}
+
+	err = ssdfs_prepare_read_init_env(&pebi->env, fsi->pages_per_peb);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init read environment: err %d\n",
+			  err);
+		goto finish_src_init_used_metadata_state;
+	}
+
+	err = ssdfs_peb_init_used_metadata_state(pebi, &pebi->env, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init used metadata state: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		ssdfs_segment_blk_bmap_init_failed(&pebc->parent_si->blk_bmap,
+						   pebc->peb_index);
+		goto finish_src_init_used_metadata_state;
+	}
+
+	id1 = pebi->env.cur_migration_id;
+
+	if (!is_peb_migration_id_valid(id1)) {
+		err = -EIO;
+		SSDFS_ERR("invalid peb_migration_id: "
+			  "seg_id %llu, peb_index %u, "
+			  "peb_migration_id %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  id1);
+		goto finish_src_init_used_metadata_state;
+	}
+
+	id2 = ssdfs_get_peb_migration_id(pebi);
+
+	if (id2 == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+		/* it needs to initialize the migration id */
+		ssdfs_set_peb_migration_id(pebi, id1);
+		atomic_set(&pebi->state,
+			   SSDFS_PEB_OBJECT_INITIALIZED);
+		complete_all(&pebi->init_end);
+	} else if (is_peb_migration_id_valid(id2)) {
+		if (id1 != id2) {
+			err = -ERANGE;
+			SSDFS_ERR("migration_id1 %d != migration_id2 %d\n",
+				  id1, id2);
+			goto finish_src_init_used_metadata_state;
+		} else {
+			/*
+			 * Do nothing.
+			 */
+		}
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("invalid migration_id %d\n", id2);
+		goto finish_src_init_used_metadata_state;
+	}
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		if (!pebc->dst_peb) {
+			SSDFS_WARN("destination PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_src_init_used_metadata_state;
+		}
+
+		id1 = __ssdfs_define_next_peb_migration_id(id1);
+		if (!is_peb_migration_id_valid(id1)) {
+			err = -EIO;
+			SSDFS_ERR("invalid peb_migration_id: "
+				  "seg_id %llu, peb_index %u, "
+				  "peb_migration_id %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  id1);
+			goto finish_src_init_used_metadata_state;
+		}
+
+		id2 = ssdfs_get_peb_migration_id(pebc->dst_peb);
+
+		if (id2 == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+			/* it needs to initialize the migration id */
+			ssdfs_set_peb_migration_id(pebc->dst_peb, id1);
+			atomic_set(&pebc->dst_peb->state,
+				   SSDFS_PEB_OBJECT_INITIALIZED);
+			complete_all(&pebc->dst_peb->init_end);
+		} else if (is_peb_migration_id_valid(id2)) {
+			if (id1 != id2) {
+				err = -ERANGE;
+				SSDFS_ERR("id1 %d != id2 %d\n",
+					  id1, id2);
+				goto finish_src_init_used_metadata_state;
+			} else {
+				/*
+				 * Do nothing.
+				 */
+			}
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("invalid migration_id %d\n", id2);
+			goto finish_src_init_used_metadata_state;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	};
+
+finish_src_init_used_metadata_state:
+	ssdfs_destroy_init_env(&pebi->env);
+	up_read(&pebc->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_dst_peb_init_used_metadata_state() - init dst "used" PEB container
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This function tries to initialize "used" PEB container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_dst_peb_init_used_metadata_state(struct ssdfs_peb_container *pebc,
+					   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi;
+	int items_state;
+	int id1, id2;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	items_state = atomic_read(&pebc->items_state);
+	switch(items_state) {
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		/* valid states */
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		return -ERANGE;
+	};
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->dst_peb;
+	if (!pebi) {
+		SSDFS_WARN("destination PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_dst_init_used_metadata_state;
+	}
+
+	err = ssdfs_prepare_read_init_env(&pebi->env, fsi->pages_per_peb);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init read environment: err %d\n",
+			  err);
+		goto finish_dst_init_used_metadata_state;
+	}
+
+	err = ssdfs_peb_init_used_metadata_state(pebi, &pebi->env, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init used metadata state: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		ssdfs_segment_blk_bmap_init_failed(&pebc->parent_si->blk_bmap,
+						   pebc->peb_index);
+		goto finish_dst_init_used_metadata_state;
+	}
+
+	id1 = pebi->env.cur_migration_id;
+
+	if (!is_peb_migration_id_valid(id1)) {
+		err = -EIO;
+		SSDFS_ERR("invalid peb_migration_id: "
+			  "seg_id %llu, peb_index %u, "
+			  "peb_migration_id %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  id1);
+		goto finish_dst_init_used_metadata_state;
+	}
+
+	id2 = ssdfs_get_peb_migration_id(pebi);
+
+	if (id2 == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+		/* it needs to initialize the migration id */
+		ssdfs_set_peb_migration_id(pebi, id1);
+	} else if (is_peb_migration_id_valid(id2)) {
+		if (id1 != id2) {
+			err = -ERANGE;
+			SSDFS_ERR("migration_id1 %d != migration_id2 %d\n",
+				  id1, id2);
+			goto finish_dst_init_used_metadata_state;
+		} else {
+			/*
+			 * Do nothing.
+			 */
+		}
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("invalid migration_id %d\n", id2);
+		goto finish_dst_init_used_metadata_state;
+	}
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		if (!pebc->src_peb) {
+			SSDFS_WARN("source PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_dst_init_used_metadata_state;
+		}
+
+		id1 = pebi->env.prev_migration_id;
+
+		if (!is_peb_migration_id_valid(id1)) {
+			err = -EIO;
+			SSDFS_ERR("invalid peb_migration_id: "
+				  "seg_id %llu, peb_index %u, "
+				  "peb_migration_id %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  id1);
+			goto finish_dst_init_used_metadata_state;
+		}
+
+		id2 = ssdfs_get_peb_migration_id(pebc->src_peb);
+
+		if (id2 == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+			/* it needs to initialize the migration id */
+			ssdfs_set_peb_migration_id(pebc->src_peb, id1);
+			atomic_set(&pebc->src_peb->state,
+				   SSDFS_PEB_OBJECT_INITIALIZED);
+			complete_all(&pebc->src_peb->init_end);
+		} else if (is_peb_migration_id_valid(id2)) {
+			if (id1 != id2) {
+				err = -ERANGE;
+				SSDFS_ERR("id1 %d != id2 %d\n",
+					  id1, id2);
+				goto finish_dst_init_used_metadata_state;
+			} else {
+				/*
+				 * Do nothing.
+				 */
+			}
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("invalid migration_id %d\n", id2);
+			goto finish_dst_init_used_metadata_state;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	};
+
+	atomic_set(&pebc->dst_peb->state,
+		   SSDFS_PEB_OBJECT_INITIALIZED);
+	complete_all(&pebc->dst_peb->init_end);
+
+finish_dst_init_used_metadata_state:
+	ssdfs_destroy_init_env(&pebi->env);
+	up_read(&pebc->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
 /*
  * ssdfs_find_prev_partial_log() - find previous partial log
  * @fsi: file system info object
-- 
2.34.1

