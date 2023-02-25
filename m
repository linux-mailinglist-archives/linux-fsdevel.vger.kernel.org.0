Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813B6A2644
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBYBRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBYBQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:48 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198F15CA6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:41 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s41so6004oiw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVp52myVQBoHKKJ7zEqsDlHvv8dniF0ze345V4RXKyg=;
        b=pQ0/NK5hld3N2RvzIIHID45NiMcgIFw0i9jHrXxHTVkSlVKphpESHfk9ITzjiTUvg/
         mpGLFEAVN33j1SSbmGEiseozwMJP8vw0JH6ijfgFEbpHps1v8UNOynHl0lS3uWF4YpIS
         +tH2cXRKbGWIDCSsjVgctVQ3+9S3azbEi8l/uDIq1OHtBPU0is6gEx2F+RMzNCPWzulh
         eCR9GHNAsr7tBznkv76y3tHQns40VwUibJwUBi6iYlnvnlwsAW2sgq+CZKPA99fruEWd
         V5JGwJy3eIJCglpPoJFm5ckjLgpvrTIgCiLjvTjvVWZdNW2DbIo2cyxrD9tAReI6MKXR
         RNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVp52myVQBoHKKJ7zEqsDlHvv8dniF0ze345V4RXKyg=;
        b=X3m640Z3pG8reLyrJwer8kWXR66ser1TJzg/P8zDvRgSItK/778NB7aFIkwEK7YoVd
         PTq8wAqkLOOmFbq3tPFx4CEP7gVJ0mEYgUxfYH/aWv41/19jJOyS5UORjrbj62gQh6vR
         qbkYtHynas1SqW8PepR9OUFu80pez2c5NGCR8wH666OwelOFSeLVcU5l9wHGgMIWRvMW
         gHIwB2KLXrf7L87r7IDHoOmV10HRzk37HXXQuptv2ZgUlujQb3NLc64o9Yftbmtpcfib
         N9s8FEcpV8BRf0xQ5QhYsRdyK9yxi/nFGKmDazGuXpbUwyUiIOvlSTVd3X9FrZxq5kRU
         m0XA==
X-Gm-Message-State: AO0yUKVIhqIyo3cPFwT2msrKUCvg9AB2vd6KJVafRaSyFkI/U6Y5mWCO
        Dds9/cOTkuN69oKGPDUQ4ZcFW83m1qTcfobS
X-Google-Smtp-Source: AK7set+2FxorP3gb7Bqp40zlNLqJ2QIaI3TO+x8M4Temmx5986GscahmlN1ScgoDT+HRS6Db2ZPj+w==
X-Received: by 2002:a05:6808:6242:b0:378:12b9:b31e with SMTP id dt2-20020a056808624200b0037812b9b31emr4238905oib.27.1677287799937;
        Fri, 24 Feb 2023 17:16:39 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:39 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 31/76] ssdfs: process update request
Date:   Fri, 24 Feb 2023 17:08:42 -0800
Message-Id: <20230225010927.813929-32-slava@dubeyko.com>
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

Flush thread can receive several types of update requests:
(1) update block or extent,
(2) prepare diff of b-tree node,
(3) prepare diff of user data logical block,
(4) commit log now,
(5) start migration now,
(6) process invalidated extent,
(7) migrate range, pre-allocated page, or fragment.

Update block or extent implies to store updated user data or
metadata under Copy-On-Write (COW) policy in compressed or
non-compressed state. Prepare diff means to use a delta-encoding
technique to store updated user data or metadata under
Copy-On-Write (COW) policy. Commit log now operation requests
the execution of log commit right now. The start migration now
operation is dedicated to mapping table case. This operation is
requested before mapping table flush with the goal to check
the necessity to finish/start migration. Because, start/finish
migration requires the modification of mapping table. However,
mapping table's flush operation needs to be finished without
any modifications of mapping table itself. Process invalidates
extent operation is executed after operation of file truncate or
b-tree node deletion operation. This operation executes with
the goal to finish migration operation and correct the state of
PEB container. The migrate range operation can be received from
global GC thread(s) as a recommendation for flush thread to
execute migration of valid blocks from source (exhausted) erase
block into destination (clean or "using") erase block if a pair
of erase block is stuck in migration process.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_flush_thread.c | 2426 +++++++++++++++++++++++++++++++++++
 1 file changed, 2426 insertions(+)

diff --git a/fs/ssdfs/peb_flush_thread.c b/fs/ssdfs/peb_flush_thread.c
index 2de4bb806678..7e6a8a67e142 100644
--- a/fs/ssdfs/peb_flush_thread.c
+++ b/fs/ssdfs/peb_flush_thread.c
@@ -109,10 +109,2436 @@ void ssdfs_flush_check_memory_leaks(void)
 #endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
 }
 
+/*
+ * struct ssdfs_fragment_source - fragment source descriptor
+ * @page: memory page that contains uncompressed fragment
+ * @start_offset: offset into page to fragment's begin
+ * @data_bytes: size of fragment in bytes
+ * @sequence_id: fragment's sequence number
+ * @fragment_type: fragment type
+ * @fragment_flags: fragment's flags
+ */
+struct ssdfs_fragment_source {
+	struct page *page;
+	u32 start_offset;
+	size_t data_bytes;
+	u8 sequence_id;
+	u8 fragment_type;
+	u8 fragment_flags;
+};
+
+/*
+ * struct ssdfs_fragment_destination - fragment destination descriptor
+ * @area_offset: offset of area from log's beginning
+ * @write_offset: offset of @store pointer from area's begin
+ * @store: pointer for storing fragment
+ * @free_space: available space in bytes for fragment storing [in|out]
+ * @compr_size: size of fragment in bytes after compression [out]
+ * @desc: fragment descriptor [out]
+ */
+struct ssdfs_fragment_destination {
+	u32 area_offset;
+	u32 write_offset;
+	unsigned char *store;
+	size_t free_space;
+	size_t compr_size;
+	struct ssdfs_fragment_desc *desc;
+};
+
+/*
+ * struct ssdfs_byte_stream_descriptor - byte stream descriptor
+ * @pvec: pagevec that contains byte stream
+ * @start_offset: offset in bytes of byte stream in pagevec
+ * @data_bytes: size of uncompressed byte stream
+ * @write_offset: write offset of byte stream in area [out]
+ * @compr_bytes: size of byte stream after compression [out]
+ */
+struct ssdfs_byte_stream_descriptor {
+	struct pagevec *pvec;
+	u32 start_offset;
+	u32 data_bytes;
+	u32 write_offset;
+	u32 compr_bytes;
+};
+
+/*
+ * struct ssdfs_bmap_descriptor - block bitmap flush descriptor
+ * @pebi: pointer on PEB object
+ * @snapshot: block bitmap snapshot
+ * @peb_index: PEB index of bitmap owner
+ * @flags: fragment flags
+ * @type: fragment type
+ * @compression_type: type of compression
+ * @last_free_blk: last logical free block
+ * @metadata_blks: count of physical pages are used by metadata
+ * @invalid_blks: count of invalid blocks
+ * @frag_id: pointer on fragment counter
+ * @cur_page: pointer on current page value
+ * @write_offset: pointer on write offset value
+ */
+struct ssdfs_bmap_descriptor {
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_page_vector *snapshot;
+	u16 peb_index;
+	u8 flags;
+	u8 type;
+	u8 compression_type;
+	u32 last_free_blk;
+	u32 metadata_blks;
+	u32 invalid_blks;
+	size_t bytes_count;
+	u8 *frag_id;
+	pgoff_t *cur_page;
+	u32 *write_offset;
+};
+
+/*
+ * struct ssdfs_pagevec_descriptor - pagevec descriptor
+ * @pebi: pointer on PEB object
+ * @page_vec: pagevec with saving data
+ * @start_sequence_id: start sequence id
+ * @area_offset: offset of area
+ * @bytes_count: size in bytes of valid data in pagevec
+ * @desc_array: array of fragment descriptors
+ * @array_capacity: capacity of fragment descriptors' array
+ * @compression_type: type of compression
+ * @compr_size: whole size of all compressed fragments [out]
+ * @uncompr_size: whole size of all fragments in uncompressed state [out]
+ * @fragments_count: count of saved fragments
+ * @cur_page: pointer on current page value
+ * @write_offset: pointer on write offset value
+ */
+struct ssdfs_pagevec_descriptor {
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_page_vector *page_vec;
+	u16 start_sequence_id;
+	u32 area_offset;
+	size_t bytes_count;
+	struct ssdfs_fragment_desc *desc_array;
+	size_t array_capacity;
+	u8 compression_type;
+	u32 compr_size;
+	u32 uncompr_size;
+	u16 fragments_count;
+	pgoff_t *cur_page;
+	u32 *write_offset;
+};
+
 /******************************************************************************
  *                         FLUSH THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * ssdfs_peb_read_from_offset() - read in buffer from offset
+ * @pebi: pointer on PEB object
+ * @off: offset in PEB
+ * @buf: pointer on buffer
+ * @buf_size: size of the buffer
+ *
+ * This function tries to read from volume into buffer.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+#ifdef CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC
+static
+int ssdfs_peb_read_from_offset(struct ssdfs_peb_info *pebi,
+			       struct ssdfs_phys_offset_descriptor *off,
+			       void *buf, size_t buf_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor desc_array[SSDFS_SEG_HDR_DESC_MAX];
+	u16 log_start_page;
+	u32 byte_offset;
+	u16 log_index;
+	int area_index;
+	u32 area_offset;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!off || !buf);
+	BUG_ON(buf_size == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	log_start_page = le16_to_cpu(off->blk_state.log_start_page);
+	byte_offset = le32_to_cpu(off->blk_state.byte_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "log_start_page %u, log_area %#x, "
+		  "peb_migration_id %u, byte_offset %u, "
+		  "buf %p, buf_size %zu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  log_start_page, off->blk_state.log_area,
+		  off->blk_state.peb_migration_id,
+		  byte_offset, buf, buf_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_index = log_start_page / pebi->log_pages;
+
+	if (log_index >= (fsi->pages_per_peb / pebi->log_pages)) {
+		SSDFS_ERR("invalid log index %u\n", log_index);
+		return -ERANGE;
+	}
+
+	area_index = SSDFS_AREA_TYPE2INDEX(off->blk_state.log_area);
+
+	if (area_index >= SSDFS_SEG_HDR_DESC_MAX) {
+		SSDFS_ERR("invalid area index %#x\n", area_index);
+		return -ERANGE;
+	}
+
+	err = ssdfs_peb_read_log_hdr_desc_array(pebi, log_index, desc_array,
+						SSDFS_SEG_HDR_DESC_MAX);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read log's header desc array: "
+			  "seg %llu, peb %llu, log_index %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  log_index, err);
+		return err;
+	}
+
+	area_offset = le32_to_cpu(desc_array[area_index].offset);
+
+	err = ssdfs_unaligned_read_buffer(fsi, pebi->peb_id,
+					  area_offset + byte_offset,
+					  buf, buf_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read buffer: "
+			  "peb %llu, area_offset %u, byte_offset %u, "
+			  "buf_size %zu, err %d\n",
+			  pebi->peb_id, area_offset, byte_offset,
+			  buf_size, err);
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC */
+
+static inline
+bool does_user_data_block_contain_diff(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 mem_pages_per_block;
+	int page_index;
+	struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_peb_containing_user_data(pebi->pebc))
+		return false;
+
+	fsi = pebi->pebc->parent_si->fsi;
+	mem_pages_per_block = fsi->pagesize / PAGE_SIZE;
+	page_index = req->result.processed_blks * mem_pages_per_block;
+	page = req->result.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_diff_page(page);
+}
+
+/*
+ * __ssdfs_peb_update_block() - update data block
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to update data block in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - try again to update data block.
+ * %-ENOENT     - need migrate base state before storing diff.
+ */
+static
+int __ssdfs_peb_update_block(struct ssdfs_peb_info *pebi,
+			     struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_phys_offset_descriptor *blk_desc_off;
+	struct ssdfs_peb_phys_offset data_off = {0};
+	struct ssdfs_peb_phys_offset desc_off = {0};
+	u16 blk;
+	u64 logical_offset;
+	struct ssdfs_block_bmap_range range;
+	int range_state;
+	u32 written_bytes;
+	u16 peb_index;
+	int migration_state = SSDFS_LBLOCK_UNKNOWN_STATE;
+	struct ssdfs_offset_position pos = {0};
+	u8 migration_id1;
+	int migration_id2;
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+	switch (req->private.class) {
+	case SSDFS_PEB_UPDATE_REQ:
+	case SSDFS_PEB_PRE_ALLOC_UPDATE_REQ:
+	case SSDFS_PEB_DIFF_ON_WRITE_REQ:
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		/* expected case */
+		break;
+	default:
+		BUG();
+		break;
+	}
+	BUG_ON(req->private.type >= SSDFS_REQ_TYPE_MAX);
+	BUG_ON(atomic_read(&req->private.refs_count) == 0);
+
+	SSDFS_DBG("ino %llu, seg %llu, peb %llu, logical_offset %llu, "
+		  "processed_blks %d, logical_block %u, data_bytes %u, "
+		  "cno %llu, parent_snapshot %llu, cmd %#x, type %#x\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->extent.logical_offset, req->result.processed_blks,
+		  req->place.start.blk_index,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebi->pebc->parent_si;
+	fsi = si->fsi;
+	table = pebi->pebc->parent_si->blk2off_table;
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+	peb_blkbmap = &seg_blkbmap->peb[pebi->pebc->peb_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (req->extent.logical_offset >= U64_MAX) {
+		SSDFS_ERR("seg %llu, peb %llu, logical_block %u, "
+			  "logical_offset %llu, "
+			  "processed_blks %d\n",
+			  req->place.start.seg_id, pebi->peb_id,
+			  req->place.start.blk_index,
+			  req->extent.logical_offset,
+			  req->result.processed_blks);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	blk = req->place.start.blk_index + req->result.processed_blks;
+	logical_offset = req->extent.logical_offset +
+			    ((u64)req->result.processed_blks * fsi->pagesize);
+	logical_offset = div64_u64(logical_offset, fsi->pagesize);
+
+	if (req->private.class == SSDFS_PEB_DIFF_ON_WRITE_REQ) {
+		u32 pvec_size = pagevec_count(&req->result.pvec);
+		u32 cur_index = req->result.processed_blks;
+
+		if (cur_index >= pvec_size) {
+			SSDFS_ERR("processed_blks %u > pagevec_size %u\n",
+				  cur_index, pvec_size);
+			return -ERANGE;
+		}
+
+		if (req->result.pvec.pages[cur_index] == NULL) {
+			req->result.processed_blks++;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("block %u hasn't diff\n",
+				  blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_update_block;
+		}
+	}
+
+	blk_desc_off = ssdfs_blk2off_table_convert(table, blk,
+						   &peb_index,
+						   &migration_state,
+						   &pos);
+	if (IS_ERR(blk_desc_off) && PTR_ERR(blk_desc_off) == -EAGAIN) {
+		struct completion *end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		blk_desc_off = ssdfs_blk2off_table_convert(table, blk,
+							   &peb_index,
+							   &migration_state,
+							   &pos);
+	}
+
+	if (IS_ERR_OR_NULL(blk_desc_off)) {
+		err = (blk_desc_off == NULL ? -ERANGE : PTR_ERR(blk_desc_off));
+		SSDFS_ERR("fail to convert: "
+			  "logical_blk %u, err %d\n",
+			  blk, err);
+		return err;
+	}
+
+	if (req->private.class == SSDFS_PEB_DIFF_ON_WRITE_REQ) {
+		migration_id1 =
+			SSDFS_GET_BLK_DESC_MIGRATION_ID(&pos.blk_desc.buf);
+		migration_id2 = ssdfs_get_peb_migration_id_checked(pebi);
+
+		if (migration_id1 < U8_MAX && migration_id1 != migration_id2) {
+			/*
+			 * Base state and diff in different PEBs
+			 */
+
+			range.start = blk;
+			range.len = 1;
+
+			ssdfs_requests_queue_add_head(&pebi->pebc->update_rq,
+							req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("range: (start %u, len %u)\n",
+				  range.start, range.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (is_ssdfs_peb_containing_user_data(pebi->pebc)) {
+				ssdfs_account_updated_user_data_pages(fsi,
+								    range.len);
+			}
+
+			err = ssdfs_peb_migrate_valid_blocks_range(si,
+								   pebi->pebc,
+								   peb_blkbmap,
+								   &range);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to migrate valid blocks: "
+					  "range (start %u, len %u), err %d\n",
+					  range.start, range.len, err);
+				return err;
+			}
+
+			return -ENOENT;
+		}
+	}
+
+	down_write(&table->translation_lock);
+
+	migration_state = ssdfs_blk2off_table_get_block_migration(table, blk,
+								  peb_index);
+	switch (migration_state) {
+	case SSDFS_LBLOCK_UNKNOWN_STATE:
+		err = -ENOENT;
+		/* logical block is not migrating */
+		break;
+
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+		switch (req->private.cmd) {
+		case SSDFS_MIGRATE_RANGE:
+		case SSDFS_MIGRATE_FRAGMENT:
+			err = 0;
+			/* continue logic */
+			break;
+
+		default:
+			err = ssdfs_blk2off_table_update_block_state(table,
+								     req);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to update block's state: "
+					  "seg %llu, logical_block %u, "
+					  "peb %llu, err %d\n",
+					  req->place.start.seg_id, blk,
+					  pebi->peb_id, err);
+			} else
+				err = -EEXIST;
+			break;
+		}
+		break;
+
+	case SSDFS_LBLOCK_UNDER_COMMIT:
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to update block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id, blk, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("unexpected migration state: "
+			  "seg %llu, logical_block %u, "
+			  "peb %llu, migration_state %#x\n",
+			  req->place.start.seg_id, blk,
+			  pebi->peb_id, migration_state);
+		break;
+	}
+
+	up_write(&table->translation_lock);
+
+	if (err == -ENOENT) {
+		/* logical block is not migrating */
+		err = 0;
+	} else if (err == -EEXIST) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("migrating block has been updated in buffer: "
+			  "seg %llu, peb %llu, logical_block %u\n",
+			  req->place.start.seg_id, pebi->peb_id,
+			  blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if (unlikely(err))
+		return err;
+
+	err = ssdfs_peb_reserve_block_descriptor(pebi, req);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to add block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id, blk, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve block descriptor: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id, blk, pebi->peb_id, err);
+		return err;
+	}
+
+	err = ssdfs_peb_add_block_into_data_area(pebi, req,
+						 blk_desc_off, &pos,
+						 &data_off,
+						 &written_bytes);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to add block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id, blk, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to add block: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id, blk, pebi->peb_id, err);
+		return err;
+	}
+
+	range.start = le16_to_cpu(blk_desc_off->page_desc.peb_page);
+	range.len = (written_bytes + fsi->pagesize - 1) >> fsi->log_pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("written_bytes %u, range (start %u, len %u)\n",
+		  written_bytes, range.start, range.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (req->private.class == SSDFS_PEB_DIFF_ON_WRITE_REQ)
+		range_state = SSDFS_BLK_VALID;
+	else if (is_ssdfs_block_full(fsi->pagesize, written_bytes))
+		range_state = SSDFS_BLK_VALID;
+	else
+		range_state = SSDFS_BLK_PRE_ALLOCATED;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, peb_page %u\n",
+		  blk, range.start);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_segment_blk_bmap_update_range(seg_blkbmap, pebi->pebc,
+				blk_desc_off->blk_state.peb_migration_id,
+				range_state, &range);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update range: "
+			  "seg %llu, peb %llu, "
+			  "range (start %u, len %u), err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, range.start, range.len,
+			  err);
+		return err;
+	}
+
+	data_off.peb_page = (u16)range.start;
+
+	if (req->private.class != SSDFS_PEB_DIFF_ON_WRITE_REQ &&
+	    !does_user_data_block_contain_diff(pebi, req))
+		SSDFS_BLK_DESC_INIT(&pos.blk_desc.buf);
+	else {
+#ifdef CONFIG_SSDFS_DEBUG
+		migration_id1 =
+			SSDFS_GET_BLK_DESC_MIGRATION_ID(&pos.blk_desc.buf);
+		if (migration_id1 >= U8_MAX) {
+			/*
+			 * continue logic
+			 */
+		} else {
+			migration_id2 =
+				ssdfs_get_peb_migration_id_checked(pebi);
+
+			if (migration_id1 != migration_id2) {
+				struct ssdfs_block_descriptor *blk_desc;
+
+				SSDFS_WARN("invalid request: "
+					   "migration_id1 %u, "
+					   "migration_id2 %d\n",
+					   migration_id1, migration_id2);
+
+				blk_desc = &pos.blk_desc.buf;
+
+				SSDFS_ERR("seg_id %llu, peb_id %llu, "
+					  "ino %llu, logical_offset %u, "
+					  "peb_index %u, peb_page %u\n",
+					  req->place.start.seg_id,
+					  pebi->peb_id,
+					  le64_to_cpu(blk_desc->ino),
+					  le32_to_cpu(blk_desc->logical_offset),
+					  le16_to_cpu(blk_desc->peb_index),
+					  le16_to_cpu(blk_desc->peb_page));
+
+				for (i = 0; i < SSDFS_BLK_STATE_OFF_MAX; i++) {
+					struct ssdfs_blk_state_offset *state;
+
+					state = &blk_desc->state[i];
+
+					SSDFS_ERR("BLK STATE OFFSET %d: "
+						  "log_start_page %u, "
+						  "log_area %#x, "
+						  "byte_offset %u, "
+						  "peb_migration_id %u\n",
+					  i,
+					  le16_to_cpu(state->log_start_page),
+					  state->log_area,
+					  le32_to_cpu(state->byte_offset),
+					  state->peb_migration_id);
+				}
+
+				BUG();
+			}
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	err = ssdfs_peb_store_block_descriptor(pebi, req,
+						&pos.blk_desc.buf,
+						&data_off, &desc_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block descriptor: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id, blk,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	err = ssdfs_peb_store_block_descriptor_offset(pebi,
+							(u32)logical_offset,
+							blk,
+							&pos.blk_desc.buf,
+							&desc_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block descriptor offset: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %llu, seg %llu, peb %llu, logical_block %u, "
+		  "migration_state %#x\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->place.start.blk_index, migration_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_ssdfs_logical_block_migrating(migration_state)) {
+		err = ssdfs_blk2off_table_set_block_commit(table, blk,
+							   peb_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set block commit: "
+				  "logical_blk %u, peb_index %u, err %d\n",
+				  blk, peb_index, err);
+			return err;
+		}
+	}
+
+	req->result.processed_blks += range.len;
+
+finish_update_block:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finish update block: "
+		  "ino %llu, seg %llu, peb %llu, logical_block %u, "
+		  "req->result.processed_blks %d\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->place.start.blk_index,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_check_zone_move_request() - check request
+ * @req: segment request
+ *
+ * This method tries to check the state of request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_check_zone_move_request(struct ssdfs_segment_request *req)
+{
+	wait_queue_head_t *wq = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p\n", req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+check_req_state:
+	switch (atomic_read(&req->result.state)) {
+	case SSDFS_REQ_CREATED:
+	case SSDFS_REQ_STARTED:
+		wq = &req->private.wait_queue;
+
+		err = wait_event_killable_timeout(*wq,
+					has_request_been_executed(req),
+					SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+
+		goto check_req_state;
+		break;
+
+	case SSDFS_REQ_FINISHED:
+		/* do nothing */
+		break;
+
+	case SSDFS_REQ_FAILED:
+		err = req->result.err;
+
+		if (!err) {
+			SSDFS_ERR("error code is absent: "
+				  "req %p, err %d\n",
+				  req, err);
+			err = -ERANGE;
+		}
+
+		SSDFS_ERR("flush request is failed: "
+			  "err %d\n", err);
+		return err;
+
+	default:
+		SSDFS_ERR("invalid result's state %#x\n",
+		    atomic_read(&req->result.state));
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_left_extent() - extract left extent
+ * @req: I/O request
+ * @migration: recommended migration extent
+ * @left_fragment: difference between recommended and requested extents [out]
+ *
+ * This function tries to extract difference between recommended
+ * and requested extents from the left.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_extract_left_extent(struct ssdfs_segment_request *req,
+			      struct ssdfs_zone_fragment *migration,
+			      struct ssdfs_zone_fragment *left_fragment)
+{
+	u64 seg_id;
+	u32 start_blk;
+	u32 len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req || !migration || !left_fragment);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu, "
+		  "seg %llu, logical_block %u, len %u, "
+		  "cmd %#x, type %#x, processed_blks %d\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->place.start.seg_id,
+		  req->place.start.blk_index,
+		  req->place.len,
+		  req->private.cmd, req->private.type,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_id = le64_to_cpu(migration->extent.seg_id);
+	start_blk = le32_to_cpu(migration->extent.logical_blk);
+	len = le32_to_cpu(migration->extent.len);
+
+	if (req->extent.ino != migration->ino) {
+		SSDFS_ERR("invalid input: "
+			  "ino1 %llu != ino2 %llu\n",
+			  req->extent.ino, migration->ino);
+		return -ERANGE;
+	}
+
+	if (req->place.start.seg_id != seg_id) {
+		SSDFS_ERR("invalid input: "
+			  "seg_id1 %llu != seg_id2 %llu\n",
+			  req->place.start.seg_id, seg_id);
+		return -ERANGE;
+	}
+
+	if (req->place.start.blk_index < start_blk) {
+		SSDFS_ERR("invalid input: "
+			  "request (seg_id %llu, logical_blk %u, len %u), "
+			  "migration (seg_id %llu, logical_blk %u, len %u)\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  req->place.len,
+			  seg_id, start_blk, len);
+		return -ERANGE;
+	}
+
+	if (req->place.start.blk_index == start_blk) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("no extent from the left: "
+			  "request (seg_id %llu, logical_blk %u, len %u), "
+			  "migration (seg_id %llu, logical_blk %u, len %u)\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  req->place.len,
+			  seg_id, start_blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	left_fragment->ino = migration->ino;
+	left_fragment->logical_blk_offset = migration->logical_blk_offset;
+	left_fragment->extent.seg_id = migration->extent.seg_id;
+	left_fragment->extent.logical_blk = migration->extent.logical_blk;
+	left_fragment->extent.len =
+			cpu_to_le32(req->place.start.blk_index - start_blk);
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_right_extent() - extract right extent
+ * @req: I/O request
+ * @migration: recommended migration extent
+ * @right_fragment: difference between recommended and requested extents [out]
+ *
+ * This function tries to extract difference between recommended
+ * and requested extents from the right.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_extract_right_extent(struct ssdfs_segment_request *req,
+			       struct ssdfs_zone_fragment *migration,
+			       struct ssdfs_zone_fragment *right_fragment)
+{
+	u64 seg_id;
+	u32 start_blk;
+	u32 len;
+	u32 upper_bound1, upper_bound2;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req || !migration || !right_fragment);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu, "
+		  "seg %llu, logical_block %u, len %u, "
+		  "cmd %#x, type %#x, processed_blks %d\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->place.start.seg_id,
+		  req->place.start.blk_index,
+		  req->place.len,
+		  req->private.cmd, req->private.type,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_id = le64_to_cpu(migration->extent.seg_id);
+	start_blk = le32_to_cpu(migration->extent.logical_blk);
+	len = le32_to_cpu(migration->extent.len);
+
+	if (req->extent.ino != migration->ino) {
+		SSDFS_ERR("invalid input: "
+			  "ino1 %llu != ino2 %llu\n",
+			  req->extent.ino, migration->ino);
+		return -ERANGE;
+	}
+
+	if (req->place.start.seg_id != seg_id) {
+		SSDFS_ERR("invalid input: "
+			  "seg_id1 %llu != seg_id2 %llu\n",
+			  req->place.start.seg_id, seg_id);
+		return -ERANGE;
+	}
+
+	upper_bound1 = req->place.start.blk_index + req->place.len;
+	upper_bound2 = start_blk + len;
+
+	if (upper_bound1 > upper_bound2) {
+		SSDFS_ERR("invalid input: "
+			  "request (seg_id %llu, logical_blk %u, len %u), "
+			  "migration (seg_id %llu, logical_blk %u, len %u)\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  req->place.len,
+			  seg_id, start_blk, len);
+		return -ERANGE;
+	}
+
+	if (upper_bound1 == upper_bound2) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("no extent from the right: "
+			  "request (seg_id %llu, logical_blk %u, len %u), "
+			  "migration (seg_id %llu, logical_blk %u, len %u)\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  req->place.len,
+			  seg_id, start_blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	right_fragment->ino = migration->ino;
+	right_fragment->logical_blk_offset =
+			migration->logical_blk_offset + upper_bound1;
+	right_fragment->extent.seg_id = migration->extent.seg_id;
+	right_fragment->extent.logical_blk = cpu_to_le32(upper_bound1);
+	right_fragment->extent.len = cpu_to_le32(upper_bound2 - upper_bound1);
+
+	return 0;
+}
+
+/*
+ * __ssdfs_zone_issue_move_request() - issue move request
+ * @pebi: pointer on PEB object
+ * @fragment: zone fragment
+ * @req_type: request type
+ * @req: I/O request
+ *
+ * This function tries to issue move request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_zone_issue_move_request(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_zone_fragment *fragment,
+				    int req_type,
+				    struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_btree_search *search;
+	struct page *page;
+	struct ssdfs_blk2off_range new_extent;
+	struct ssdfs_raw_extent old_raw_extent;
+	struct ssdfs_raw_extent new_raw_extent;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 logical_offset;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !fragment);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_blk_offset %llu, "
+		  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+		  pebi->peb_id,
+		  fragment->ino,
+		  fragment->logical_blk_offset,
+		  le64_to_cpu(fragment->extent.seg_id),
+		  le32_to_cpu(fragment->extent.logical_blk),
+		  le32_to_cpu(fragment->extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	seg_id = le64_to_cpu(fragment->extent.seg_id);
+	logical_blk = le32_to_cpu(fragment->extent.logical_blk);
+	len = le32_to_cpu(fragment->extent.len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(len > PAGEVEC_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	req->private.flags |= SSDFS_REQ_DONT_FREE_PAGES;
+
+	logical_offset = fragment->logical_blk_offset << fsi->log_pagesize;
+	ssdfs_request_prepare_logical_extent(fragment->ino, logical_offset,
+					     len, 0, 0, req);
+
+	req->place.start.seg_id = seg_id;
+	req->place.start.blk_index = logical_blk;
+	req->place.len = 0;
+
+	req->result.processed_blks = 0;
+
+	for (i = 0; i < len; i++) {
+		logical_blk += i;
+		req->place.len++;
+
+		err = ssdfs_peb_copy_page(pebi->pebc, logical_blk, req);
+		if (err == -EAGAIN) {
+			req->place.len = req->result.processed_blks;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to copy the whole range: "
+				  "seg %llu, logical_blk %u, len %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  logical_blk, req->place.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to copy page: "
+				  "seg %llu, logical_blk %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  logical_blk, err);
+			return err;
+		}
+	}
+
+	for (i = 0; i < req->result.processed_blks; i++)
+		ssdfs_peb_mark_request_block_uptodate(pebi->pebc, req, i);
+
+	for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+		page = req->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		set_page_writeback(page);
+	}
+
+	req->result.err = 0;
+	req->result.processed_blks = 0;
+	atomic_set(&req->result.state, SSDFS_UNKNOWN_REQ_RESULT);
+
+	err = ssdfs_segment_migrate_zone_extent_async(fsi,
+						      req_type,
+						      req,
+						      &seg_id,
+						      &new_extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to migrate zone extent: "
+			  "peb %llu, ino %llu, logical_blk_offset %llu, "
+			  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+			  pebi->peb_id,
+			  fragment->ino,
+			  fragment->logical_blk_offset,
+			  le64_to_cpu(fragment->extent.seg_id),
+			  le32_to_cpu(fragment->extent.logical_blk),
+			  le32_to_cpu(fragment->extent.len));
+		goto fail_issue_move_request;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_id >= U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	old_raw_extent.seg_id = fragment->extent.seg_id;
+	old_raw_extent.logical_blk = fragment->extent.logical_blk;
+	old_raw_extent.len = fragment->extent.len;
+
+	new_raw_extent.seg_id = cpu_to_le64(seg_id);
+	new_raw_extent.logical_blk = cpu_to_le32(new_extent.start_lblk);
+	new_raw_extent.len = cpu_to_le32(new_extent.len);
+
+	page = req->result.pvec.pages[0];
+	inode = page->mapping->host;
+	ii = SSDFS_I(inode);
+
+	etree = SSDFS_EXTREE(ii);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!etree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate btree search object\n");
+		goto fail_issue_move_request;
+	}
+
+	ssdfs_btree_search_init(search);
+	err = ssdfs_extents_tree_move_extent(etree,
+					     fragment->logical_blk_offset,
+					     &old_raw_extent,
+					     &new_raw_extent,
+					     search);
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move extent: "
+			  "old_extent (seg_id %llu, logical_blk %u, len %u), "
+			  "new_extent (seg_id %llu, logical_blk %u, len %u), "
+			  "err %d\n",
+			  le64_to_cpu(old_raw_extent.seg_id),
+			  le32_to_cpu(old_raw_extent.logical_blk),
+			  le32_to_cpu(old_raw_extent.len),
+			  le64_to_cpu(new_raw_extent.seg_id),
+			  le32_to_cpu(new_raw_extent.logical_blk),
+			  le32_to_cpu(new_raw_extent.len),
+			  err);
+		goto fail_issue_move_request;
+	}
+
+	return 0;
+
+fail_issue_move_request:
+	ssdfs_request_unlock_and_remove_pages(req);
+	ssdfs_put_request(req);
+
+	return err;
+}
+
+/*
+ * ssdfs_zone_issue_async_move_request() - issue async move request
+ * @pebi: pointer on PEB object
+ * @fragment: zone fragment
+ *
+ * This function tries to issue async move request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_zone_issue_async_move_request(struct ssdfs_peb_info *pebi,
+					struct ssdfs_zone_fragment *fragment)
+{
+	struct ssdfs_segment_request *req;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !fragment);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_blk_offset %llu, "
+		  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+		  pebi->peb_id,
+		  fragment->ino,
+		  fragment->logical_blk_offset,
+		  le64_to_cpu(fragment->extent.seg_id),
+		  le32_to_cpu(fragment->extent.logical_blk),
+		  le32_to_cpu(fragment->extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		return err;
+	}
+
+	err = __ssdfs_zone_issue_move_request(pebi, fragment,
+					      SSDFS_REQ_ASYNC,
+					      req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to issue move request: "
+			  "peb %llu, ino %llu, logical_blk_offset %llu, "
+			  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+			  pebi->peb_id,
+			  fragment->ino,
+			  fragment->logical_blk_offset,
+			  le64_to_cpu(fragment->extent.seg_id),
+			  le32_to_cpu(fragment->extent.logical_blk),
+			  le32_to_cpu(fragment->extent.len));
+		goto fail_issue_move_request;
+	}
+
+	return 0;
+
+fail_issue_move_request:
+	ssdfs_request_free(req);
+	return err;
+}
+
+/*
+ * ssdfs_zone_issue_move_request() - issue move request
+ * @pebi: pointer on PEB object
+ * @fragment: zone fragment
+ * @req: I/O request
+ *
+ * This function tries to issue move request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_zone_issue_move_request(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_zone_fragment *fragment,
+				  struct ssdfs_segment_request *req)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !fragment);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_blk_offset %llu, "
+		  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+		  pebi->peb_id,
+		  fragment->ino,
+		  fragment->logical_blk_offset,
+		  le64_to_cpu(fragment->extent.seg_id),
+		  le32_to_cpu(fragment->extent.logical_blk),
+		  le32_to_cpu(fragment->extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_zone_issue_move_request(pebi, fragment,
+					      SSDFS_REQ_ASYNC_NO_FREE,
+					      req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to issue move request: "
+			  "peb %llu, ino %llu, logical_blk_offset %llu, "
+			  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+			  pebi->peb_id,
+			  fragment->ino,
+			  fragment->logical_blk_offset,
+			  le64_to_cpu(fragment->extent.seg_id),
+			  le32_to_cpu(fragment->extent.logical_blk),
+			  le32_to_cpu(fragment->extent.len));
+		goto fail_issue_move_request;
+	}
+
+fail_issue_move_request:
+	return err;
+}
+
+/*
+ * ssdfs_zone_prepare_migration_request() - stimulate migration
+ * @pebi: pointer on PEB object
+ * @fragment: zone fragment
+ * @req: I/O request
+ *
+ * This function tries to prepare migration stimulation request
+ * during moving updated data from exhausted zone into current zone
+ * for updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_zone_prepare_migration_request(struct ssdfs_peb_info *pebi,
+					 struct ssdfs_zone_fragment *fragment,
+					 struct ssdfs_segment_request *req)
+{
+	struct ssdfs_zone_fragment sub_fragment;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u32 offset = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !fragment || !req);
+
+	SSDFS_DBG("peb %llu, logical_blk_offset %llu, "
+		  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+		  pebi->peb_id,
+		  fragment->logical_blk_offset,
+		  le64_to_cpu(fragment->extent.seg_id),
+		  le32_to_cpu(fragment->extent.logical_blk),
+		  le32_to_cpu(fragment->extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_id = le64_to_cpu(fragment->extent.seg_id);
+	logical_blk = le32_to_cpu(fragment->extent.logical_blk);
+	len = le32_to_cpu(fragment->extent.len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_id != pebi->pebc->parent_si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	while (len > PAGEVEC_SIZE) {
+		sub_fragment.ino = fragment->ino;
+		sub_fragment.logical_blk_offset =
+				fragment->logical_blk_offset + offset;
+		sub_fragment.extent.seg_id = fragment->extent.seg_id;
+		sub_fragment.extent.logical_blk =
+					cpu_to_le32(logical_blk + offset);
+		sub_fragment.extent.len = cpu_to_le32(PAGEVEC_SIZE);
+
+		err = ssdfs_zone_issue_async_move_request(pebi, &sub_fragment);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to issue zone async move request: "
+				  "peb %llu, logical_blk_offset %llu, "
+				  "sub_extent (seg_id %llu, "
+				  "logical_blk %u, len %u), err %d\n",
+				  pebi->peb_id,
+				  sub_fragment.logical_blk_offset,
+				  le64_to_cpu(sub_fragment.extent.seg_id),
+				  le32_to_cpu(sub_fragment.extent.logical_blk),
+				  le32_to_cpu(sub_fragment.extent.len),
+				  err);
+			return err;
+		}
+
+		offset += PAGEVEC_SIZE;
+		len -= PAGEVEC_SIZE;
+	}
+
+	sub_fragment.ino = fragment->ino;
+	sub_fragment.logical_blk_offset =
+			fragment->logical_blk_offset + offset;
+	sub_fragment.extent.seg_id = fragment->extent.seg_id;
+	sub_fragment.extent.logical_blk = cpu_to_le32(logical_blk + offset);
+	sub_fragment.extent.len = cpu_to_le32(len);
+
+	err = ssdfs_zone_issue_move_request(pebi, &sub_fragment, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to issue zone move request: "
+			  "peb %llu, logical_blk_offset %llu, "
+			  "sub_extent (seg_id %llu, "
+			  "logical_blk %u, len %u), err %d\n",
+			  pebi->peb_id,
+			  sub_fragment.logical_blk_offset,
+			  le64_to_cpu(sub_fragment.extent.seg_id),
+			  le32_to_cpu(sub_fragment.extent.logical_blk),
+			  le32_to_cpu(sub_fragment.extent.len),
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_zone_prepare_move_flush_request() - convert update into move request
+ * @pebi: pointer on PEB object
+ * @src: source I/O request
+ * @dst: destination I/O request
+ *
+ * This function tries to convert update request into
+ * move request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_zone_prepare_move_flush_request(struct ssdfs_peb_info *pebi,
+					  struct ssdfs_segment_request *src,
+					  struct ssdfs_segment_request *dst)
+{
+	struct ssdfs_fs_info *fsi;
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_btree_search *search;
+	struct page *page;
+	struct ssdfs_blk2off_range new_extent;
+	struct ssdfs_raw_extent old_raw_extent;
+	struct ssdfs_raw_extent new_raw_extent;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 logical_offset;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !src || !dst);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu, "
+		  "seg %llu, logical_block %u, cmd %#x, type %#x, "
+		  "processed_blks %d\n",
+		  pebi->peb_id, src->extent.ino, src->extent.logical_offset,
+		  src->extent.data_bytes, src->extent.cno,
+		  src->extent.parent_snapshot,
+		  src->place.start.seg_id, src->place.start.blk_index,
+		  src->private.cmd, src->private.type,
+		  src->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	seg_id = src->place.start.seg_id;
+	logical_blk = src->place.start.blk_index;
+	len = src->place.len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(len > PAGEVEC_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = src->result.pvec.pages[0];
+	inode = page->mapping->host;
+	ii = SSDFS_I(inode);
+
+	etree = SSDFS_EXTREE(ii);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!etree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_init(dst);
+	ssdfs_get_request(dst);
+
+	dst->private.flags |= SSDFS_REQ_DONT_FREE_PAGES;
+
+	logical_offset = src->extent.logical_offset;
+	ssdfs_request_prepare_logical_extent(src->extent.ino,
+					     logical_offset, len,
+					     0, 0, dst);
+
+	dst->place.start.seg_id = seg_id;
+	dst->place.start.blk_index = logical_blk;
+	dst->place.len = len;
+
+	dst->result.processed_blks = 0;
+
+	for (i = 0; i < pagevec_count(&src->result.pvec); i++) {
+		page = src->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		dst->result.pvec.pages[i] = page;
+		src->result.pvec.pages[i] = NULL;
+	}
+
+	pagevec_reinit(&src->result.pvec);
+
+	dst->result.err = 0;
+	dst->result.processed_blks = 0;
+	atomic_set(&dst->result.state, SSDFS_UNKNOWN_REQ_RESULT);
+
+	err = ssdfs_segment_migrate_zone_extent_async(fsi,
+						      SSDFS_REQ_ASYNC_NO_FREE,
+						      dst,
+						      &seg_id,
+						      &new_extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to migrate zone extent: "
+			  "peb %llu, ino %llu, logical_blk_offset %llu, "
+			  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+			  pebi->peb_id,
+			  src->extent.ino, src->extent.logical_offset,
+			  src->place.start.seg_id,
+			  src->place.start.blk_index,
+			  src->place.len);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_id >= U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	old_raw_extent.seg_id = cpu_to_le64(src->place.start.seg_id);
+	old_raw_extent.logical_blk = cpu_to_le32(src->place.start.blk_index);
+	old_raw_extent.len = cpu_to_le32(src->place.len);
+
+	new_raw_extent.seg_id = cpu_to_le64(seg_id);
+	new_raw_extent.logical_blk = cpu_to_le32(new_extent.start_lblk);
+	new_raw_extent.len = cpu_to_le32(new_extent.len);
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+	err = ssdfs_extents_tree_move_extent(etree,
+					     src->extent.logical_offset,
+					     &old_raw_extent,
+					     &new_raw_extent,
+					     search);
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move extent: "
+			  "old_extent (seg_id %llu, logical_blk %u, len %u), "
+			  "new_extent (seg_id %llu, logical_blk %u, len %u), "
+			  "err %d\n",
+			  le64_to_cpu(old_raw_extent.seg_id),
+			  le32_to_cpu(old_raw_extent.logical_blk),
+			  le32_to_cpu(old_raw_extent.len),
+			  le64_to_cpu(new_raw_extent.seg_id),
+			  le32_to_cpu(new_raw_extent.logical_blk),
+			  le32_to_cpu(new_raw_extent.len),
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+enum {
+	SSDFS_ZONE_LEFT_EXTENT,
+	SSDFS_ZONE_MAIN_EXTENT,
+	SSDFS_ZONE_RIGHT_EXTENT,
+	SSDFS_ZONE_MIGRATING_EXTENTS
+};
+
+/*
+ * ssdfs_zone_move_extent() - move extent (ZNS SSD case)
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to move extent from exhausted zone
+ * into current zone for updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_zone_move_extent(struct ssdfs_peb_info *pebi,
+			   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_invextree_info *invextree;
+	struct ssdfs_btree_search *search;
+	struct ssdfs_raw_extent extent;
+	struct ssdfs_segment_request *queue[SSDFS_ZONE_MIGRATING_EXTENTS] = {0};
+	struct ssdfs_zone_fragment migration;
+	struct ssdfs_zone_fragment left_fragment;
+	struct ssdfs_zone_fragment *left_fragment_ptr;
+	struct ssdfs_zone_fragment right_fragment;
+	struct ssdfs_zone_fragment *right_fragment_ptr;
+	size_t desc_size = sizeof(struct ssdfs_zone_fragment);
+	u32 rest_bytes;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu, "
+		  "seg %llu, logical_block %u, cmd %#x, type %#x, "
+		  "processed_blks %d\n",
+		  pebi->peb_id, req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->place.start.seg_id, req->place.start.blk_index,
+		  req->private.cmd, req->private.type,
+		  req->result.processed_blks);
+
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+	switch (req->private.class) {
+	case SSDFS_PEB_UPDATE_REQ:
+	case SSDFS_PEB_PRE_ALLOC_UPDATE_REQ:
+	case SSDFS_PEB_DIFF_ON_WRITE_REQ:
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		/* expected case */
+		break;
+	default:
+		BUG();
+		break;
+	}
+	BUG_ON(req->private.type >= SSDFS_REQ_TYPE_MAX);
+	BUG_ON(atomic_read(&req->private.refs_count) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+
+	memset(&migration, 0xFF, desc_size);
+	memset(&left_fragment, 0xFF, desc_size);
+	memset(&right_fragment, 0xFF, desc_size);
+
+	err = ssdfs_recommend_migration_extent(fsi, req,
+						&migration);
+	if (err == -ENODATA) {
+		err = 0;
+		/* do nothing */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to recommend migration extent: "
+			  "err %d\n", err);
+		goto finish_zone_move_extent;
+	} else {
+		err = ssdfs_extract_left_extent(req, &migration,
+						&left_fragment);
+		if (err == -ENODATA) {
+			err = 0;
+			SSDFS_DBG("no extent from the left\n");
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to extract left extent: "
+				  "seg_id %llu, peb_id %llu, "
+				  "logical_block %u, err %d\n",
+				  req->place.start.seg_id,
+				  pebi->peb_id,
+				  req->place.start.blk_index,
+				  err);
+			goto finish_zone_move_extent;
+		} else
+			left_fragment_ptr = &left_fragment;
+
+		err = ssdfs_extract_right_extent(req, &migration,
+						 &right_fragment);
+		if (err == -ENODATA) {
+			err = 0;
+			SSDFS_DBG("no extent from the right\n");
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to extract right extent: "
+				  "seg_id %llu, peb_id %llu, "
+				  "logical_block %u, err %d\n",
+				  req->place.start.seg_id,
+				  pebi->peb_id,
+				  req->place.start.blk_index,
+				  err);
+			goto finish_zone_move_extent;
+		} else
+			right_fragment_ptr = &right_fragment;
+	}
+
+	if (left_fragment_ptr) {
+		queue[SSDFS_ZONE_LEFT_EXTENT] = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(queue[SSDFS_ZONE_LEFT_EXTENT])) {
+			SSDFS_ERR("fail to allocate segment request\n");
+			goto free_moving_requests;
+		}
+	}
+
+	queue[SSDFS_ZONE_MAIN_EXTENT] = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(queue[SSDFS_ZONE_MAIN_EXTENT])) {
+		SSDFS_ERR("fail to allocate segment request\n");
+		goto free_moving_requests;
+	}
+
+	if (right_fragment_ptr) {
+		queue[SSDFS_ZONE_RIGHT_EXTENT] = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(queue[SSDFS_ZONE_RIGHT_EXTENT])) {
+			SSDFS_ERR("fail to allocate segment request\n");
+			goto free_moving_requests;
+		}
+	}
+
+	if (left_fragment_ptr) {
+		err = ssdfs_zone_prepare_migration_request(pebi,
+					   left_fragment_ptr,
+					   queue[SSDFS_ZONE_LEFT_EXTENT]);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare zone migration request: "
+				  "err %d\n", err);
+			goto free_moving_requests;
+		}
+	}
+
+	err = ssdfs_zone_prepare_move_flush_request(pebi, req,
+					queue[SSDFS_ZONE_MAIN_EXTENT]);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare zone move request: "
+			  "err %d\n", err);
+		goto free_moving_requests;
+	}
+
+	if (right_fragment_ptr) {
+		err = ssdfs_zone_prepare_migration_request(pebi,
+					   left_fragment_ptr,
+					   queue[SSDFS_ZONE_RIGHT_EXTENT]);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare zone migration request: "
+				  "err %d\n", err);
+			goto free_moving_requests;
+		}
+	}
+
+	for (i = 0; i < SSDFS_ZONE_MIGRATING_EXTENTS; i++) {
+		if (queue[i] == NULL)
+			continue;
+
+		err = ssdfs_check_zone_move_request(queue[i]);
+		if (unlikely(err)) {
+			SSDFS_ERR("flush request failed: "
+				  "index %d, err %d\n",
+				  i, err);
+		}
+
+		ssdfs_put_request(queue[i]);
+		ssdfs_request_free(queue[i]);
+	}
+
+	invextree = fsi->invextree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!invextree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	extent.seg_id = migration.extent.seg_id;
+	extent.logical_blk = migration.extent.logical_blk;
+	extent.len = migration.extent.len;
+
+	ssdfs_btree_search_init(search);
+	err = ssdfs_invextree_add(invextree, &extent, search);
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add invalidated extent: "
+			  "seg_id %llu, logical_blk %u, "
+			  "len %u, err %d\n",
+			  le64_to_cpu(extent.seg_id),
+			  le32_to_cpu(extent.logical_blk),
+			  le32_to_cpu(extent.len),
+			  err);
+		return err;
+	}
+
+	return 0;
+
+free_moving_requests:
+	for (i = 0; i < SSDFS_ZONE_MIGRATING_EXTENTS; i++) {
+		if (queue[i] == NULL)
+			continue;
+
+		ssdfs_put_request(queue[i]);
+		ssdfs_request_free(queue[i]);
+	}
+
+finish_zone_move_extent:
+	return err;
+}
+
+/*
+ * ssdfs_peb_update_block() - update data block
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to update data block in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - try again to update data block.
+ * %-ENOENT     - need migrate base state before storing diff.
+ */
+static
+int ssdfs_peb_update_block(struct ssdfs_peb_info *pebi,
+			   struct ssdfs_segment_request *req)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+
+	SSDFS_DBG("ino %llu, seg %llu, peb %llu, logical_offset %llu, "
+		  "processed_blks %d, logical_block %u, data_bytes %u, "
+		  "cno %llu, parent_snapshot %llu, cmd %#x, type %#x\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->extent.logical_offset, req->result.processed_blks,
+		  req->place.start.blk_index,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&pebi->pebc->migration_phase)) {
+	case SSDFS_SHARED_ZONE_RECEIVES_DATA:
+		err = ssdfs_zone_move_extent(pebi, req);
+		break;
+
+	default:
+		err = __ssdfs_peb_update_block(pebi, req);
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * __ssdfs_peb_update_extent() - update extent of blocks
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to update extent of blocks in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_peb_update_extent(struct ssdfs_peb_info *pebi,
+			      struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 blk;
+	u32 rest_bytes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu, "
+		  "seg %llu, logical_block %u, cmd %#x, type %#x, "
+		  "processed_blks %d\n",
+		  pebi->peb_id, req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->place.start.seg_id, req->place.start.blk_index,
+		  req->private.cmd, req->private.type,
+		  req->result.processed_blks);
+
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+	switch (req->private.class) {
+	case SSDFS_PEB_UPDATE_REQ:
+	case SSDFS_PEB_PRE_ALLOC_UPDATE_REQ:
+	case SSDFS_PEB_DIFF_ON_WRITE_REQ:
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		/* expected case */
+		break;
+	default:
+		BUG();
+		break;
+	}
+	BUG_ON(req->private.type >= SSDFS_REQ_TYPE_MAX);
+	BUG_ON(atomic_read(&req->private.refs_count) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+
+	while (rest_bytes > 0) {
+		blk = req->place.start.blk_index +
+				req->result.processed_blks;
+
+		err = __ssdfs_peb_update_block(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to update block: "
+				  "seg %llu, logical_block %u, "
+				  "peb %llu\n",
+				  req->place.start.seg_id, blk,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("need to migrate base state for diff: "
+				  "seg %llu, logical_block %u, "
+				  "peb %llu\n",
+				  req->place.start.seg_id, blk,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to update block: "
+				  "seg %llu, logical_block %u, "
+				  "peb %llu, err %d\n",
+				  req->place.start.seg_id, blk,
+				  pebi->peb_id, err);
+			return err;
+		}
+
+		rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_update_extent() - update extent of blocks
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to update extent of blocks in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_update_extent(struct ssdfs_peb_info *pebi,
+			    struct ssdfs_segment_request *req)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu, "
+		  "seg %llu, logical_block %u, cmd %#x, type %#x, "
+		  "processed_blks %d\n",
+		  pebi->peb_id, req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->place.start.seg_id, req->place.start.blk_index,
+		  req->private.cmd, req->private.type,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&pebi->pebc->migration_phase)) {
+	case SSDFS_SHARED_ZONE_RECEIVES_DATA:
+		err = ssdfs_zone_move_extent(pebi, req);
+		break;
+
+	default:
+		err = __ssdfs_peb_update_extent(pebi, req);
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_migrate_pre_allocated_block() - migrate pre-allocated block
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to update data block in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_migrate_pre_allocated_block(struct ssdfs_peb_info *pebi,
+					  struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_phys_offset_descriptor *blk_desc_off;
+	struct ssdfs_peb_phys_offset desc_off = {0};
+	u16 peb_index;
+	u16 logical_block;
+	int processed_blks;
+	u64 logical_offset;
+	struct ssdfs_block_bmap_range range;
+	int range_state;
+	int migration_state = SSDFS_LBLOCK_UNKNOWN_STATE;
+	struct ssdfs_offset_position pos = {0};
+	u32 len;
+	u8 id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+
+	switch (req->private.class) {
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		/* expected state */
+		break;
+	default:
+		SSDFS_ERR("unexpected request: "
+			  "req->private.class %#x\n",
+			  req->private.class);
+		BUG();
+	};
+
+	switch (req->private.cmd) {
+	case SSDFS_MIGRATE_PRE_ALLOC_PAGE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request: "
+			  "req->private.cmd %#x\n",
+			  req->private.cmd);
+		BUG();
+	};
+
+	BUG_ON(req->private.type >= SSDFS_REQ_TYPE_MAX);
+	BUG_ON(atomic_read(&req->private.refs_count) == 0);
+	BUG_ON(req->extent.data_bytes > pebi->pebc->parent_si->fsi->pagesize);
+	BUG_ON(req->result.processed_blks > 0);
+
+	SSDFS_DBG("ino %llu, seg %llu, peb %llu, logical_offset %llu, "
+		  "processed_blks %d, logical_block %u, data_bytes %u, "
+		  "cno %llu, parent_snapshot %llu, cmd %#x, type %#x\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->extent.logical_offset, req->result.processed_blks,
+		  req->place.start.blk_index,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	si = pebi->pebc->parent_si;
+	table = pebi->pebc->parent_si->blk2off_table;
+	seg_blkbmap = &pebi->pebc->parent_si->blk_bmap;
+	processed_blks = req->result.processed_blks;
+	logical_block = req->place.start.blk_index + processed_blks;
+	logical_offset = req->extent.logical_offset +
+				((u64)processed_blks * fsi->pagesize);
+	logical_offset /= fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, logical_block %u, "
+		  "logical_offset %llu, "
+		  "processed_blks %d\n",
+		  req->place.start.seg_id, pebi->peb_id,
+		  logical_block, logical_offset,
+		  processed_blks);
+
+	if (req->extent.logical_offset >= U64_MAX) {
+		SSDFS_ERR("seg %llu, peb %llu, logical_block %u, "
+			  "logical_offset %llu, "
+			  "processed_blks %d\n",
+			  req->place.start.seg_id, pebi->peb_id,
+			  logical_block, logical_offset,
+			  processed_blks);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	len = req->extent.data_bytes;
+	len -= req->result.processed_blks * si->fsi->pagesize;
+	len >>= fsi->log_pagesize;
+
+	blk_desc_off = ssdfs_blk2off_table_convert(table,
+						   logical_block,
+						   &peb_index,
+						   &migration_state,
+						   &pos);
+	if (IS_ERR(blk_desc_off) && PTR_ERR(blk_desc_off) == -EAGAIN) {
+		struct completion *end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		blk_desc_off = ssdfs_blk2off_table_convert(table,
+							   logical_block,
+							   &peb_index,
+							   &migration_state,
+							   &pos);
+	}
+
+	if (IS_ERR_OR_NULL(blk_desc_off)) {
+		err = (blk_desc_off == NULL ? -ERANGE : PTR_ERR(blk_desc_off));
+		SSDFS_ERR("fail to convert: "
+			  "logical_blk %u, err %d\n",
+			  logical_block, err);
+		return err;
+	}
+
+	if (migration_state == SSDFS_LBLOCK_UNDER_COMMIT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to add block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id, logical_block,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EAGAIN;
+	}
+
+	range.start = le16_to_cpu(blk_desc_off->page_desc.peb_page);
+	range.len = len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, peb_page %u\n",
+		  logical_block, range.start);
+	SSDFS_DBG("range (start %u, len %u)\n",
+		  range.start, range.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	range_state = SSDFS_BLK_PRE_ALLOCATED;
+
+	err = ssdfs_segment_blk_bmap_update_range(seg_blkbmap, pebi->pebc,
+				blk_desc_off->blk_state.peb_migration_id,
+				range_state, &range);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update range: "
+			  "seg %llu, peb %llu, "
+			  "range (start %u, len %u), err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, range.start, range.len,
+			  err);
+		return err;
+	}
+
+	id = ssdfs_get_peb_migration_id_checked(pebi);
+	if (unlikely(id < 0)) {
+		SSDFS_ERR("invalid peb_migration_id: "
+			  "seg %llu, peb_id %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, id);
+		return id;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(id > U8_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc_off.peb_index = pebi->peb_index;
+	desc_off.peb_migration_id = id;
+	desc_off.peb_page = (u16)range.start;
+	desc_off.log_area = SSDFS_LOG_AREA_MAX;
+	desc_off.byte_offset = U32_MAX;
+
+	err = ssdfs_peb_store_block_descriptor_offset(pebi,
+						(u32)logical_offset,
+						logical_block,
+						NULL,
+						&desc_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block descriptor offset: "
+			  "logical_block %u, logical_offset %llu, "
+			  "err %d\n",
+			  logical_block, logical_offset, err);
+		return err;
+	}
+
+	req->result.processed_blks += range.len;
+	return 0;
+}
+
+/*
+ * ssdfs_process_update_request() - process update request
+ * @pebi: pointer on PEB object
+ * @req: request
+ *
+ * This function detects command of request and
+ * to call a proper function for request processing.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EAGAIN     - unable to update block.
+ */
+static
+int ssdfs_process_update_request(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x\n",
+		  req, req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (req->private.cmd <= SSDFS_CREATE_CMD_MAX ||
+	    req->private.cmd >= SSDFS_COLLECT_GARBAGE_CMD_MAX) {
+		SSDFS_ERR("unknown update command %d, seg %llu, peb %llu\n",
+			  req->private.cmd, pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id);
+		req->result.err = -EINVAL;
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		return -EINVAL;
+	}
+
+	atomic_set(&req->result.state, SSDFS_REQ_STARTED);
+
+	switch (req->private.cmd) {
+	case SSDFS_UPDATE_BLOCK:
+	case SSDFS_UPDATE_PRE_ALLOC_BLOCK:
+		err = ssdfs_peb_update_block(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to update block: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to update block: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_UPDATE_EXTENT:
+	case SSDFS_UPDATE_PRE_ALLOC_EXTENT:
+		err = ssdfs_peb_update_extent(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to update block: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to update extent: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_BTREE_NODE_DIFF:
+		err = ssdfs_peb_update_extent(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to update extent: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("need to migrate base state for diff: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to update extent: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_USER_DATA_DIFF:
+		err = ssdfs_peb_update_block(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to update block: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to update block: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_COMMIT_LOG_NOW:
+	case SSDFS_START_MIGRATION_NOW:
+	case SSDFS_EXTENT_WAS_INVALIDATED:
+		/* simply continue logic */
+		break;
+
+	case SSDFS_MIGRATE_RANGE:
+		err = ssdfs_peb_update_extent(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to migrate extent: "
+				  "seg %llu, peb %llu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to migrate extent: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_MIGRATE_PRE_ALLOC_PAGE:
+		err = ssdfs_peb_migrate_pre_allocated_block(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to migrate pre-alloc page: "
+				  "seg %llu, peb %llu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to migrate pre-alloc page: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_MIGRATE_FRAGMENT:
+		err = ssdfs_peb_update_block(pebi, req);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to migrate fragment: "
+				  "seg %llu, peb %llu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to migrate fragment: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (unlikely(err)) {
+		/* request failed */
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+	} else if (is_ssdfs_peb_containing_user_data(pebi->pebc)) {
+		struct ssdfs_peb_container *pebc = pebi->pebc;
+		int processed_blks = req->result.processed_blks;
+		u32 pending = 0;
+
+		switch (req->private.cmd) {
+		case SSDFS_UPDATE_BLOCK:
+		case SSDFS_UPDATE_PRE_ALLOC_BLOCK:
+		case SSDFS_UPDATE_EXTENT:
+		case SSDFS_UPDATE_PRE_ALLOC_EXTENT:
+		case SSDFS_BTREE_NODE_DIFF:
+		case SSDFS_USER_DATA_DIFF:
+		case SSDFS_MIGRATE_RANGE:
+		case SSDFS_MIGRATE_PRE_ALLOC_PAGE:
+		case SSDFS_MIGRATE_FRAGMENT:
+			spin_lock(&pebc->pending_lock);
+			pending = pebc->pending_updated_user_data_pages;
+			if (pending >= processed_blks) {
+				pebc->pending_updated_user_data_pages -=
+								processed_blks;
+				pending = pebc->pending_updated_user_data_pages;
+			} else {
+				/* wrong accounting */
+				err = -ERANGE;
+			}
+			spin_unlock(&pebc->pending_lock);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("pending %u < processed_blks %d\n",
+				  pending, processed_blks);
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("seg_id %llu, peb_index %u, pending %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->pebc->peb_index,
+				  pending);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+	return err;
+}
+
 /*
  * ssdfs_peb_has_dirty_pages() - check that PEB has dirty pages
  * @pebi: pointer on PEB object
-- 
2.34.1

