Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5027F6A264E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBYBRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBYBRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:11 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320101285B
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:59 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id c11so825133oiw.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcAuqLfB71E3lDrbDEz3uVRNCTkZ0qE5nA04DuoXHWs=;
        b=ot8vZtB+hww3G4SISDtXIlsEtPW/RPu2S7Io7w3nvjL3LEGCy7/Uj/3wsheNR71e95
         JbM/ZYbuo85i/iPhSjptIgaYiY8IpvgPZcaGFjQ7iGHjzWZAMVxOw5s+IspkY/GDnpZ9
         hnynKkES3wfKAuV3z9hWGUoSaZYmEKFu6QNvuUs/FjmsT1cwS9pSnkvzGvj10SmJnm7+
         CnKxiEz/49VIvHmIkpcVHowfhjPCRNtYEH03bHKDjuhQbd2eHvSgoCzi8UHdmXDDcxi6
         AeDfkAwGb21yK0UG2v58kl5toGsqcV8Gc3/otXVDAtyay5mMnLgGHwuQx23AioQujoG6
         06xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcAuqLfB71E3lDrbDEz3uVRNCTkZ0qE5nA04DuoXHWs=;
        b=gXs8e11IVzrSe795JegIryMqzBZaqaAOrLsmiRe12vzPES3o5JGAxeYMZyPkfUmKZw
         koGHALICYkGiiMgaqUJIjx1FmLAedtSfu9alxGv1HgyXJA1VWyEagjJ5ARDJbXa8SpzG
         Rd70JLOqjRfYQ7AYebY/nWSnojL77NG9XdR/qm4S5uk1ediJ0CIVCfGzCd4zQ7HSGr+6
         DPJFGbEhRYisFglKjMwaobWiHG110m+Pqm8uAnZRuW4MDUueNWnTExZ96uxTFqqG245/
         mtdt6KS1ymQvCtm2FDIz94AGAkBssBkhm3hlrq8wCyzV8P6R4Q8U0gvmtDnM/S/NGouR
         cgKA==
X-Gm-Message-State: AO0yUKV3GUeXL4hpRx2npQZv7Kjp0aB+7LHmcvo2MZNtr9DKVZtIqX8t
        fmSmi901L6sl2DxWj52U3eGS/2hPrKOpWaO/
X-Google-Smtp-Source: AK7set+k9kEnYJgLrhRvMRLrLTaH3VQ8hCoqd6mROGbrQpBTgEaD0tp2ndDxuQgbpz0fh/yPJciuAQ==
X-Received: by 2002:a54:461a:0:b0:378:5c2e:d8b with SMTP id p26-20020a54461a000000b003785c2e0d8bmr4359634oip.25.1677287817485;
        Fri, 24 Feb 2023 17:16:57 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:56 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 39/76] ssdfs: flush PEB mapping table
Date:   Fri, 24 Feb 2023 17:08:50 -0800
Message-Id: <20230225010927.813929-40-slava@dubeyko.com>
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

"Physical" Erase Block (PEB) mapping table is represented by
a sequence of fragments are distributed among several
segments. Every map or unmap operation marks a fragment as
dirty. Flush operation requires to check the dirty state of
all fragments and to flush dirty fragments on the volume by
means of creation of log(s) into PEB(s) is dedicated to store
mapping table's content. Flush operation is executed in several
steps: (1) prepare migration, (2) flush dirty fragments,
(3) commit logs.

Prepare migration operation is requested before mapping table
flush with the goal to check the necessity to finish/start
migration. Because, start/finish migration requires the modification of
mapping table. However, mapping table's flush operation needs to be
finished without any modifications of mapping table itself.
Flush dirty fragments step implies the searching of dirty fragments
and preparation of update requests for PEB(s) flush thread.
Finally, commit log should be requested because metadata flush
operation must be finished by storing new metadata state
persistently.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_mapping_table.c | 2811 ++++++++++++++++++++++++++++++++++
 1 file changed, 2811 insertions(+)

diff --git a/fs/ssdfs/peb_mapping_table.c b/fs/ssdfs/peb_mapping_table.c
index cd5835eb96a2..bfc11bb73360 100644
--- a/fs/ssdfs/peb_mapping_table.c
+++ b/fs/ssdfs/peb_mapping_table.c
@@ -1952,3 +1952,2814 @@ int ssdfs_maptbl_fragment_init(struct ssdfs_peb_container *pebc,
 
 	return err;
 }
+
+/*
+ * ssdfs_sb_maptbl_header_correct_state() - save maptbl's state in superblock
+ * @tbl: mapping table object
+ */
+static
+void ssdfs_sb_maptbl_header_correct_state(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_maptbl_sb_header *hdr;
+	size_t bytes_count;
+	u32 flags = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&tbl->fsi->volume_sem));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = &tbl->fsi->vh->maptbl;
+
+	hdr->fragments_count = cpu_to_le32(tbl->fragments_count);
+	hdr->fragment_bytes = cpu_to_le32(tbl->fragment_bytes);
+	hdr->last_peb_recover_cno =
+		cpu_to_le64(atomic64_read(&tbl->last_peb_recover_cno));
+	hdr->lebs_count = cpu_to_le64(tbl->lebs_count);
+	hdr->pebs_count = cpu_to_le64(tbl->pebs_count);
+	hdr->fragments_per_seg = cpu_to_le16(tbl->fragments_per_seg);
+	hdr->fragments_per_peb = cpu_to_le16(tbl->fragments_per_peb);
+
+	flags = atomic_read(&tbl->flags);
+	/* exclude run-time flags*/
+	flags &= ~SSDFS_MAPTBL_UNDER_FLUSH;
+	hdr->flags = cpu_to_le16(flags);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(atomic_read(&tbl->pre_erase_pebs) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	hdr->pre_erase_pebs = le16_to_cpu(atomic_read(&tbl->pre_erase_pebs));
+
+	hdr->lebs_per_fragment = cpu_to_le16(tbl->lebs_per_fragment);
+	hdr->pebs_per_fragment = cpu_to_le16(tbl->pebs_per_fragment);
+	hdr->pebs_per_stripe = cpu_to_le16(tbl->pebs_per_stripe);
+	hdr->stripes_per_fragment = cpu_to_le16(tbl->stripes_per_fragment);
+
+	bytes_count = sizeof(struct ssdfs_meta_area_extent);
+	bytes_count *= SSDFS_MAPTBL_RESERVED_EXTENTS;
+	bytes_count *= SSDFS_MAPTBL_SEG_COPY_MAX;
+	ssdfs_memcpy(hdr->extents, 0, bytes_count,
+		     tbl->fsi->vh->maptbl.extents, 0, bytes_count,
+		     bytes_count);
+}
+
+/*
+ * ssdfs_maptbl_copy_dirty_page() - copy dirty page into request
+ * @tbl: mapping table object
+ * @pvec: pagevec with dirty pages
+ * @spage_index: index of page in pagevec
+ * @dpage_index: index of page in request
+ * @req: segment request
+ *
+ * This method tries to copy dirty page into request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_copy_dirty_page(struct ssdfs_peb_mapping_table *tbl,
+				 struct pagevec *pvec,
+				 int spage_index, int dpage_index,
+				 struct ssdfs_segment_request *req)
+{
+	struct page *spage, *dpage;
+	void *kaddr1, *kaddr2;
+	struct ssdfs_leb_table_fragment_header *lhdr;
+	struct ssdfs_peb_table_fragment_header *phdr;
+	__le16 *magic;
+	__le32 csum;
+	u32 bytes_count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !pvec || !req);
+	BUG_ON(spage_index >= pagevec_count(pvec));
+
+	SSDFS_DBG("maptbl %p, pvec %p, spage_index %d, "
+		  "dpage_index %d, req %p\n",
+		  tbl, pvec, spage_index, dpage_index, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spage = pvec->pages[spage_index];
+
+	ssdfs_lock_page(spage);
+	kaddr1 = kmap_local_page(spage);
+
+	magic = (__le16 *)kaddr1;
+	if (*magic == cpu_to_le16(SSDFS_LEB_TABLE_MAGIC)) {
+		lhdr = (struct ssdfs_leb_table_fragment_header *)kaddr1;
+		bytes_count = le32_to_cpu(lhdr->bytes_count);
+		csum = lhdr->checksum;
+		lhdr->checksum = 0;
+		lhdr->checksum = ssdfs_crc32_le(kaddr1, bytes_count);
+		if (csum != lhdr->checksum) {
+			err = -ERANGE;
+			SSDFS_ERR("csum %#x != lhdr->checksum %#x\n",
+				  le16_to_cpu(csum),
+				  le16_to_cpu(lhdr->checksum));
+			lhdr->checksum = csum;
+			goto end_copy_dirty_page;
+		}
+	} else if (*magic == cpu_to_le16(SSDFS_PEB_TABLE_MAGIC)) {
+		phdr = (struct ssdfs_peb_table_fragment_header *)kaddr1;
+		bytes_count = le32_to_cpu(phdr->bytes_count);
+		csum = phdr->checksum;
+		phdr->checksum = 0;
+		phdr->checksum = ssdfs_crc32_le(kaddr1, bytes_count);
+		if (csum != phdr->checksum) {
+			err = -ERANGE;
+			SSDFS_ERR("csum %#x != phdr->checksum %#x\n",
+				  le16_to_cpu(csum),
+				  le16_to_cpu(phdr->checksum));
+			phdr->checksum = csum;
+			goto end_copy_dirty_page;
+		}
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("corrupted maptbl's page: index %lu\n",
+			  spage->index);
+		goto end_copy_dirty_page;
+	}
+
+	dpage = req->result.pvec.pages[dpage_index];
+
+	if (!dpage) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid page: page_index %u\n",
+			  dpage_index);
+		goto end_copy_dirty_page;
+	}
+
+	kaddr2 = kmap_local_page(dpage);
+	ssdfs_memcpy(kaddr2, 0, PAGE_SIZE,
+		     kaddr1, 0, PAGE_SIZE,
+		     PAGE_SIZE);
+	flush_dcache_page(dpage);
+	kunmap_local(kaddr2);
+
+	SetPageUptodate(dpage);
+	if (!PageDirty(dpage))
+		SetPageDirty(dpage);
+	set_page_writeback(dpage);
+
+end_copy_dirty_page:
+	flush_dcache_page(spage);
+	kunmap_local(kaddr1);
+	ssdfs_unlock_page(spage);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_replicate_dirty_page() - replicate dirty page content
+ * @req1: source request
+ * @page_index: index of replicated page in @req1
+ * @req2: destination request
+ */
+static
+void ssdfs_maptbl_replicate_dirty_page(struct ssdfs_segment_request *req1,
+					int page_index,
+					struct ssdfs_segment_request *req2)
+{
+	struct page *spage, *dpage;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req1 || !req2);
+	BUG_ON(page_index >= pagevec_count(&req1->result.pvec));
+	BUG_ON(page_index >= pagevec_count(&req2->result.pvec));
+
+	SSDFS_DBG("req1 %p, req2 %p, page_index %d\n",
+		  req1, req2, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spage = req1->result.pvec.pages[page_index];
+	dpage = req2->result.pvec.pages[page_index];
+
+	ssdfs_memcpy_page(dpage, 0, PAGE_SIZE,
+			  spage, 0, PAGE_SIZE,
+			  PAGE_SIZE);
+
+	SetPageUptodate(dpage);
+	if (!PageDirty(dpage))
+		SetPageDirty(dpage);
+	set_page_writeback(dpage);
+}
+
+/*
+ * ssdfs_check_portion_id() - check portion_id in the pagevec
+ * @pvec: checking pagevec
+ */
+static inline
+int ssdfs_check_portion_id(struct pagevec *pvec)
+{
+	struct ssdfs_leb_table_fragment_header *lhdr;
+	struct ssdfs_peb_table_fragment_header *phdr;
+	u32 portion_id = U32_MAX;
+	void *kaddr;
+	__le16 *magic;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+
+	SSDFS_DBG("pvec %p\n", pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_ERR("empty pagevec\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		kaddr = kmap_local_page(pvec->pages[i]);
+		magic = (__le16 *)kaddr;
+		if (le16_to_cpu(*magic) == SSDFS_LEB_TABLE_MAGIC) {
+			lhdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+			if (portion_id == U32_MAX)
+				portion_id = le32_to_cpu(lhdr->portion_id);
+			else if (portion_id != le32_to_cpu(lhdr->portion_id))
+				err = -ERANGE;
+		} else if (le16_to_cpu(*magic) == SSDFS_PEB_TABLE_MAGIC) {
+			phdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+			if (portion_id == U32_MAX)
+				portion_id = le32_to_cpu(phdr->portion_id);
+			else if (portion_id != le32_to_cpu(phdr->portion_id))
+				err = -ERANGE;
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("corrupted maptbl's page: index %d\n",
+				  i);
+		}
+		kunmap_local(kaddr);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_define_volume_extent() - define volume extent for request
+ * @tbl: mapping table object
+ * @req: segment request
+ * @fragment: pointer on raw fragment
+ * @area_start: index of memeory page inside of fragment
+ * @pages_count: number of memory pages in the area
+ * @seg_index: index of segment in maptbl's array [out]
+ */
+static
+int ssdfs_maptbl_define_volume_extent(struct ssdfs_peb_mapping_table *tbl,
+					struct ssdfs_segment_request *req,
+					void *fragment,
+					pgoff_t area_start,
+					u32 pages_count,
+					u16 *seg_index)
+{
+	struct ssdfs_leb_table_fragment_header *lhdr;
+	struct ssdfs_peb_table_fragment_header *phdr;
+	u32 portion_id = U32_MAX;
+	__le16 *magic;
+	u64 fragment_offset;
+	u16 item_index;
+	u32 pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !req || !fragment || !seg_index);
+
+	SSDFS_DBG("maptbl %p, req %p, fragment %p, "
+		  "area_start %lu, pages_count %u, "
+		  "seg_index %p\n",
+		  tbl, req, fragment, area_start,
+		  pages_count, seg_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pagesize = tbl->fsi->pagesize;
+
+	magic = (__le16 *)fragment;
+	if (le16_to_cpu(*magic) == SSDFS_LEB_TABLE_MAGIC) {
+		lhdr = (struct ssdfs_leb_table_fragment_header *)fragment;
+		portion_id = le32_to_cpu(lhdr->portion_id);
+	} else if (le16_to_cpu(*magic) == SSDFS_PEB_TABLE_MAGIC) {
+		phdr = (struct ssdfs_peb_table_fragment_header *)fragment;
+		portion_id = le32_to_cpu(phdr->portion_id);
+	} else {
+		SSDFS_ERR("corrupted maptbl's page\n");
+		return -ERANGE;
+	}
+
+	if (portion_id >= tbl->fragments_count) {
+		SSDFS_ERR("portion_id %u >= tbl->fragments_count %u\n",
+			  portion_id, tbl->fragments_count);
+		return -ERANGE;
+	}
+
+	*seg_index = portion_id / tbl->fragments_per_seg;
+
+	fragment_offset = portion_id % tbl->fragments_per_seg;
+	fragment_offset *= tbl->fragment_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(div_u64(fragment_offset, PAGE_SIZE) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = (u16)div_u64(fragment_offset, PAGE_SIZE);
+	item_index += area_start;
+
+	if (tbl->fsi->pagesize < PAGE_SIZE) {
+		u32 pages_per_item;
+		u32 items_count = pages_count;
+
+		pages_per_item = PAGE_SIZE + pagesize - 1;
+		pages_per_item /= pagesize;
+		req->place.start.blk_index = item_index * pages_per_item;
+		req->place.len = items_count * pages_per_item;
+	} else if (tbl->fsi->pagesize > PAGE_SIZE) {
+		u32 items_per_page;
+		u32 items_count = pages_count;
+
+		items_per_page = pagesize + PAGE_SIZE - 1;
+		items_per_page /= PAGE_SIZE;
+		req->place.start.blk_index = item_index / items_per_page;
+		req->place.len = items_count + items_per_page - 1;
+		req->place.len /= items_per_page;
+	} else {
+		req->place.start.blk_index = item_index;
+		req->place.len = pages_count;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_set_fragment_checksum() - calculate checksum of dirty fragment
+ * @pvec: pagevec with dirty pages
+ *
+ * This method tries to calculate checksum of dirty fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_fragment_checksum(struct pagevec *pvec)
+{
+	struct ssdfs_leb_table_fragment_header *lhdr;
+	struct ssdfs_peb_table_fragment_header *phdr;
+	struct page *page;
+	void *kaddr;
+	__le16 *magic;
+	u32 bytes_count;
+	unsigned count;
+	unsigned i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	count = pagevec_count(pvec);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pvec %p, pages_count %u\n",
+		  pvec, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count == 0) {
+		SSDFS_WARN("empty pagevec\n");
+		return -ERANGE;
+	}
+
+	for (i = 0; i < count; i++) {
+		page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		kaddr = kmap_local_page(page);
+		magic = (__le16 *)kaddr;
+		if (le16_to_cpu(*magic) == SSDFS_LEB_TABLE_MAGIC) {
+			lhdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+			bytes_count = le32_to_cpu(lhdr->bytes_count);
+			lhdr->checksum = 0;
+			lhdr->checksum = ssdfs_crc32_le(kaddr, bytes_count);
+		} else if (le16_to_cpu(*magic) == SSDFS_PEB_TABLE_MAGIC) {
+			phdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+			bytes_count = le32_to_cpu(phdr->bytes_count);
+			phdr->checksum = 0;
+			phdr->checksum = ssdfs_crc32_le(kaddr, bytes_count);
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("corrupted maptbl's page: index %d\n",
+				  i);
+		}
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_realloc_flush_reqs_array() - check necessity to realloc reqs array
+ * @fdesc: pointer on fragment descriptor
+ *
+ * This method checks the necessity to realloc the flush
+ * requests array. Finally, it tries to realloc the memory
+ * for the flush requests array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static inline
+int ssdfs_realloc_flush_reqs_array(struct ssdfs_maptbl_fragment_desc *fdesc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fdesc->flush_req_count > fdesc->flush_seq_size) {
+		SSDFS_ERR("request_index %u > flush_seq_size %u\n",
+			  fdesc->flush_req_count, fdesc->flush_seq_size);
+		return -ERANGE;
+	} else if (fdesc->flush_req_count == fdesc->flush_seq_size) {
+		size_t seg_req_size = sizeof(struct ssdfs_segment_request);
+
+		fdesc->flush_seq_size *= 2;
+
+		fdesc->flush_req1 = krealloc(fdesc->flush_req1,
+					fdesc->flush_seq_size * seg_req_size,
+					GFP_KERNEL | __GFP_ZERO);
+		if (!fdesc->flush_req1) {
+			SSDFS_ERR("fail to reallocate buffer\n");
+			return -ENOMEM;
+		}
+
+		fdesc->flush_req2 = krealloc(fdesc->flush_req2,
+					fdesc->flush_seq_size * seg_req_size,
+					GFP_KERNEL | __GFP_ZERO);
+		if (!fdesc->flush_req2) {
+			SSDFS_ERR("fail to reallocate buffer\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_update_fragment() - update dirty fragment
+ * @tbl: mapping table object
+ * @fragment_index: index of fragment in the array
+ *
+ * This method tries to update dirty fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_maptbl_update_fragment(struct ssdfs_peb_mapping_table *tbl,
+				 u32 fragment_index)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	struct ssdfs_segment_info *si;
+	int state;
+	struct pagevec pvec;
+	bool has_backup;
+	pgoff_t page_index, end, range_len;
+	int i, j;
+	pgoff_t area_start;
+	unsigned area_size;
+	u64 ino = SSDFS_MAPTBL_INO;
+	u64 offset;
+	u32 size;
+	u16 seg_index;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(fragment_index >= tbl->fragments_count);
+
+	SSDFS_DBG("maptbl %p, fragment_index %u\n",
+		  tbl, fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fdesc = &tbl->desc_array[fragment_index];
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	state = atomic_read(&fdesc->state);
+	if (state != SSDFS_MAPTBL_FRAG_DIRTY) {
+		SSDFS_ERR("fragment %u hasn't dirty state: state %#x\n",
+			  fragment_index, state);
+		return -ERANGE;
+	}
+
+	page_index = 0;
+	range_len = min_t(pgoff_t,
+			  (pgoff_t)PAGEVEC_SIZE,
+			  (pgoff_t)(tbl->fragment_pages - page_index));
+	end = page_index + range_len - 1;
+
+	down_write(&fdesc->lock);
+
+	fdesc->flush_req_count = 0;
+
+retrive_dirty_pages:
+	pagevec_init(&pvec);
+
+	err = ssdfs_page_array_lookup_range(&fdesc->array,
+					    &page_index, end,
+					    SSDFS_DIRTY_PAGE_TAG,
+					    tbl->fragment_pages,
+					    &pvec);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find dirty pages: "
+			  "fragment_index %u, start %lu, "
+			  "end %lu, err %d\n",
+			  fragment_index, page_index, end, err);
+		goto finish_fragment_update;
+	}
+
+	if (pagevec_count(&pvec) == 0) {
+		page_index += range_len;
+
+		if (page_index >= tbl->fragment_pages)
+			goto finish_fragment_update;
+
+		range_len = min_t(pgoff_t,
+			  (pgoff_t)PAGEVEC_SIZE,
+			  (pgoff_t)(tbl->fragment_pages - page_index));
+		end = page_index + range_len - 1;
+		goto retrive_dirty_pages;
+	}
+
+	err = ssdfs_page_array_clear_dirty_range(&fdesc->array,
+						 page_index, end);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear dirty range: "
+			  "start %lu, end %lu, err %d\n",
+			  page_index, end, err);
+		goto finish_fragment_update;
+	}
+
+	err = ssdfs_maptbl_set_fragment_checksum(&pvec);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set fragment checksum: "
+			  "fragment_index %u, err %d\n",
+			  fragment_index, err);
+		goto finish_fragment_update;
+	}
+
+	i = 0;
+
+define_update_area:
+	area_start = pvec.pages[i]->index;
+	area_size = 0;
+	for (; i < pagevec_count(&pvec); i++) {
+		if ((area_start + area_size) != pvec.pages[i]->index)
+			break;
+		else
+			area_size++;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fragment_index %u, area_start %lu, area_size %u\n",
+		  fragment_index, area_start, area_size);
+
+	BUG_ON(area_size == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_realloc_flush_reqs_array(fdesc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to realloc the reqs array\n");
+		goto finish_fragment_update;
+	}
+
+	req1 = &fdesc->flush_req1[fdesc->flush_req_count];
+	req2 = &fdesc->flush_req2[fdesc->flush_req_count];
+	fdesc->flush_req_count++;
+
+	ssdfs_request_init(req1);
+	ssdfs_get_request(req1);
+	if (has_backup) {
+		ssdfs_request_init(req2);
+		ssdfs_get_request(req2);
+	}
+
+	for (j = 0; j < area_size; j++) {
+		err = ssdfs_request_add_allocated_page_locked(req1);
+		if (!err && has_backup)
+			err = ssdfs_request_add_allocated_page_locked(req2);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail allocate memory page: err %d\n", err);
+			goto fail_issue_fragment_updates;
+		}
+
+		err = ssdfs_maptbl_copy_dirty_page(tbl, &pvec,
+						   (i - area_size) + j,
+						   j, req1);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy dirty page: "
+				  "spage_index %d, dpage_index %d, err %d\n",
+				  (i - area_size) + j, j, err);
+			goto fail_issue_fragment_updates;
+		}
+
+		if (has_backup)
+			ssdfs_maptbl_replicate_dirty_page(req1, j, req2);
+	}
+
+	offset = area_start * PAGE_SIZE;
+	offset += fragment_index * tbl->fragment_bytes;
+	size = area_size * PAGE_SIZE;
+
+	ssdfs_request_prepare_logical_extent(ino, offset, size, 0, 0, req1);
+	if (has_backup) {
+		ssdfs_request_prepare_logical_extent(ino, offset, size,
+						     0, 0, req2);
+	}
+
+	err = ssdfs_check_portion_id(&req1->result.pvec);
+	if (unlikely(err)) {
+		SSDFS_ERR("corrupted maptbl's page was found: "
+			  "err %d\n", err);
+		goto fail_issue_fragment_updates;
+	}
+
+	kaddr = kmap_local_page(req1->result.pvec.pages[0]);
+	err = ssdfs_maptbl_define_volume_extent(tbl, req1, kaddr,
+						area_start, area_size,
+						&seg_index);
+	kunmap_local(kaddr);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define volume extent: "
+			  "err %d\n",
+			  err);
+		goto fail_issue_fragment_updates;
+	}
+
+	if (has_backup) {
+		ssdfs_memcpy(&req2->place,
+			     0, sizeof(struct ssdfs_volume_extent),
+			     &req1->place,
+			     0, sizeof(struct ssdfs_volume_extent),
+			     sizeof(struct ssdfs_volume_extent));
+	}
+
+	si = tbl->segs[SSDFS_MAIN_MAPTBL_SEG][seg_index];
+	err = ssdfs_segment_update_extent_async(si,
+						SSDFS_REQ_ASYNC_NO_FREE,
+						req1);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("update extent async: seg %llu\n", si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!err && has_backup) {
+		if (!tbl->segs[SSDFS_COPY_MAPTBL_SEG]) {
+			err = -ERANGE;
+			SSDFS_ERR("copy of maptbl doesn't exist\n");
+			goto fail_issue_fragment_updates;
+		}
+
+		si = tbl->segs[SSDFS_COPY_MAPTBL_SEG][seg_index];
+		err = ssdfs_segment_update_extent_async(si,
+						SSDFS_REQ_ASYNC_NO_FREE,
+						req2);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update extent: "
+			  "seg_index %u, err %d\n",
+			  seg_index, err);
+		goto fail_issue_fragment_updates;
+	}
+
+	if (err) {
+fail_issue_fragment_updates:
+		ssdfs_request_unlock_and_remove_pages(req1);
+		ssdfs_put_request(req1);
+		if (has_backup) {
+			ssdfs_request_unlock_and_remove_pages(req2);
+			ssdfs_put_request(req2);
+		}
+		goto finish_fragment_update;
+	}
+
+	if (i < pagevec_count(&pvec))
+		goto define_update_area;
+
+	for (j = 0; j < pagevec_count(&pvec); j++) {
+		ssdfs_put_page(pvec.pages[j]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  pvec.pages[j],
+			  page_ref_count(pvec.pages[j]));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	page_index += range_len;
+
+	if (page_index < tbl->fragment_pages) {
+		range_len = min_t(pgoff_t,
+			  (pgoff_t)PAGEVEC_SIZE,
+			  (pgoff_t)(tbl->fragment_pages - page_index));
+		end = page_index + range_len - 1;
+		pagevec_reinit(&pvec);
+		goto retrive_dirty_pages;
+	}
+
+finish_fragment_update:
+	if (!err) {
+		state = atomic_cmpxchg(&fdesc->state,
+					SSDFS_MAPTBL_FRAG_DIRTY,
+					SSDFS_MAPTBL_FRAG_TOWRITE);
+		if (state != SSDFS_MAPTBL_FRAG_DIRTY) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid fragment state %#x\n", state);
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment_index %u, state %#x\n",
+			  fragment_index,
+			  atomic_read(&fdesc->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		for (j = 0; j < pagevec_count(&pvec); j++) {
+			ssdfs_put_page(pvec.pages[j]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  pvec.pages[j],
+				  page_ref_count(pvec.pages[j]));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+	up_write(&fdesc->lock);
+
+	pagevec_reinit(&pvec);
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_issue_fragments_update() - issue update of fragments
+ * @tbl: mapping table object
+ * @start_fragment: index of start fragment in the dirty bmap
+ * @dirty_bmap: bmap of dirty fragments
+ *
+ * This method tries to find the dirty fragments in @dirty_bmap.
+ * It updates the state of every found dirty fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA     - @dirty_bmap doesn't contain the dirty fragments.
+ */
+static
+int ssdfs_maptbl_issue_fragments_update(struct ssdfs_peb_mapping_table *tbl,
+					u32 start_fragment,
+					unsigned long dirty_bmap)
+{
+	bool is_bit_found;
+	int i = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p, start_fragment %u, dirty_bmap %#lx\n",
+		  tbl, start_fragment, dirty_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dirty_bmap == 0) {
+		SSDFS_DBG("bmap doesn't contain dirty bits\n");
+		return -ENODATA;
+	}
+
+	for (i = 0; i < BITS_PER_LONG; i++) {
+		is_bit_found = test_bit(i, &dirty_bmap);
+
+		if (!is_bit_found)
+			continue;
+
+		err = ssdfs_maptbl_update_fragment(tbl, start_fragment + i);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update fragment: "
+				  "fragment_index %u, err %d\n",
+				  start_fragment + i, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_flush_dirty_fragments() - find and flush dirty fragments
+ * @tbl: mapping table object
+ *
+ * This method tries to find and to flush all dirty fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_flush_dirty_fragments(struct ssdfs_peb_mapping_table *tbl)
+{
+	unsigned long *bmap;
+	int size;
+	unsigned long *found;
+	u32 start_fragment;
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t bytes_count;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_debug_maptbl_object(tbl);
+
+	mutex_lock(&tbl->bmap_lock);
+
+	bmap = tbl->dirty_bmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	bytes_count = tbl->fragments_count + BITS_PER_LONG - 1;
+	bytes_count /= BITS_PER_BYTE;
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				tbl->dirty_bmap, bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	size = tbl->fragments_count;
+	err = ssdfs_find_first_dirty_fragment(bmap, size, &found);
+	if (err == -ENODATA) {
+		SSDFS_DBG("maptbl hasn't dirty fragments\n");
+		goto finish_flush_dirty_fragments;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find dirty fragments: "
+			  "err %d\n",
+			  err);
+		goto finish_flush_dirty_fragments;
+	} else if (!found) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid bitmap pointer\n");
+		goto finish_flush_dirty_fragments;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("bmap %p, found %p\n", bmap, found);
+
+	BUG_ON(((found - bmap) * BITS_PER_LONG) >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_fragment = (u32)((found - bmap) * BITS_PER_LONG);
+
+	err = ssdfs_maptbl_issue_fragments_update(tbl, start_fragment,
+						  *found);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to issue fragments update: "
+			  "start_fragment %u, found %#lx, err %d\n",
+			  start_fragment, *found, err);
+		goto finish_flush_dirty_fragments;
+	}
+
+	err = ssdfs_clear_dirty_state(found);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear dirty state: "
+			  "err %d\n",
+			  err);
+		goto finish_flush_dirty_fragments;
+	}
+
+	if ((start_fragment + BITS_PER_LONG) >= tbl->fragments_count)
+		goto finish_flush_dirty_fragments;
+
+	size = tbl->fragments_count - (start_fragment + BITS_PER_LONG);
+	while (size > 0) {
+		err = ssdfs_find_first_dirty_fragment(++found, size, &found);
+		if (err == -ENODATA) {
+			err = 0;
+			goto finish_flush_dirty_fragments;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find dirty fragments: "
+				  "err %d\n",
+				  err);
+			goto finish_flush_dirty_fragments;
+		} else if (!found) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid bitmap pointer\n");
+			goto finish_flush_dirty_fragments;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(((found - bmap) * BITS_PER_LONG) >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		start_fragment = (u32)((found - bmap) * BITS_PER_LONG);
+
+		err = ssdfs_maptbl_issue_fragments_update(tbl, start_fragment,
+							  *found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to issue fragments update: "
+				  "start_fragment %u, found %#lx, err %d\n",
+				  start_fragment, *found, err);
+			goto finish_flush_dirty_fragments;
+		}
+
+		err = ssdfs_clear_dirty_state(found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clear dirty state: "
+				  "err %d\n",
+				  err);
+			goto finish_flush_dirty_fragments;
+		}
+
+		size = tbl->fragments_count - (start_fragment + BITS_PER_LONG);
+	}
+
+finish_flush_dirty_fragments:
+	mutex_unlock(&tbl->bmap_lock);
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_check_request() - check request
+ * @fdesc: pointer on fragment descriptor
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
+int ssdfs_maptbl_check_request(struct ssdfs_maptbl_fragment_desc *fdesc,
+				struct ssdfs_segment_request *req)
+{
+	wait_queue_head_t *wq = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !req);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("fdesc %p, req %p\n", fdesc, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+check_req_state:
+	switch (atomic_read(&req->result.state)) {
+	case SSDFS_REQ_CREATED:
+	case SSDFS_REQ_STARTED:
+		wq = &req->private.wait_queue;
+
+		up_write(&fdesc->lock);
+		err = wait_event_killable_timeout(*wq,
+					has_request_been_executed(req),
+					SSDFS_DEFAULT_TIMEOUT);
+		down_write(&fdesc->lock);
+
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
+ * ssdfs_maptbl_wait_flush_end() - wait flush ending
+ * @tbl: mapping table object
+ *
+ * This method is waiting the end of flush operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_wait_flush_end(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	bool has_backup;
+	u32 fragments_count;
+	u32 i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragments_count = tbl->fragments_count;
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		down_write(&fdesc->lock);
+
+		switch (atomic_read(&fdesc->state)) {
+		case SSDFS_MAPTBL_FRAG_DIRTY:
+			err = -ERANGE;
+			SSDFS_ERR("found unprocessed dirty fragment: "
+				  "index %d\n", i);
+			goto finish_fragment_processing;
+
+		case SSDFS_MAPTBL_FRAG_TOWRITE:
+			for (j = 0; j < fdesc->flush_req_count; j++) {
+				req1 = &fdesc->flush_req1[j];
+				req2 = &fdesc->flush_req2[j];
+
+				err = ssdfs_maptbl_check_request(fdesc, req1);
+				if (unlikely(err)) {
+					SSDFS_ERR("flush request failed: "
+						  "err %d\n", err);
+					goto finish_fragment_processing;
+				}
+
+				if (!has_backup)
+					continue;
+
+				err = ssdfs_maptbl_check_request(fdesc, req2);
+				if (unlikely(err)) {
+					SSDFS_ERR("flush request failed: "
+						  "err %d\n", err);
+					goto finish_fragment_processing;
+				}
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+finish_fragment_processing:
+		up_write(&fdesc->lock);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_maptbl_commit_logs() - issue commit log requests
+ * @tbl: mapping table object
+ * @fdesc: pointer on fragment descriptor
+ * @fragment_index: index of fragment in the array
+ *
+ * This method tries to issue the commit log requests.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_maptbl_commit_logs(struct ssdfs_peb_mapping_table *tbl,
+				struct ssdfs_maptbl_fragment_desc *fdesc,
+				u32 fragment_index)
+{
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	struct ssdfs_segment_info *si;
+	u64 ino = SSDFS_MAPTBL_INO;
+	int state;
+	bool has_backup;
+	pgoff_t area_start;
+	pgoff_t area_size, processed_pages;
+	u64 offset;
+	u16 seg_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("maptbl %p, fragment_index %u\n",
+		  tbl, fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	state = atomic_read(&fdesc->state);
+	if (state != SSDFS_MAPTBL_FRAG_TOWRITE) {
+		SSDFS_ERR("fragment isn't under flush: state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	area_start = 0;
+	area_size = min_t(pgoff_t,
+			  (pgoff_t)PAGEVEC_SIZE,
+			  (pgoff_t)tbl->fragment_pages);
+	processed_pages = 0;
+
+	fdesc->flush_req_count = 0;
+
+	do {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(area_size == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_realloc_flush_reqs_array(fdesc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc the reqs array\n");
+			goto finish_issue_commit_request;
+		}
+
+		req1 = &fdesc->flush_req1[fdesc->flush_req_count];
+		req2 = &fdesc->flush_req2[fdesc->flush_req_count];
+		fdesc->flush_req_count++;
+
+		ssdfs_request_init(req1);
+		ssdfs_get_request(req1);
+		if (has_backup) {
+			ssdfs_request_init(req2);
+			ssdfs_get_request(req2);
+		}
+
+		offset = area_start * PAGE_SIZE;
+		offset += fragment_index * tbl->fragment_bytes;
+
+		ssdfs_request_prepare_logical_extent(ino, offset,
+						     0, 0, 0, req1);
+		if (has_backup) {
+			ssdfs_request_prepare_logical_extent(ino,
+							     offset,
+							     0, 0, 0,
+							     req2);
+		}
+
+		page = ssdfs_page_array_get_page_locked(&fdesc->array,
+							area_start);
+		if (IS_ERR_OR_NULL(page)) {
+			err = page == NULL ? -ERANGE : PTR_ERR(page);
+			SSDFS_ERR("fail to get page: "
+				  "index %lu, err %d\n",
+				  area_start, err);
+			goto finish_issue_commit_request;
+		}
+
+		kaddr = kmap_local_page(page);
+		err = ssdfs_maptbl_define_volume_extent(tbl, req1, kaddr,
+							area_start, area_size,
+							&seg_index);
+		kunmap_local(kaddr);
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define volume extent: "
+				  "err %d\n",
+				  err);
+			goto finish_issue_commit_request;
+		}
+
+		if (has_backup) {
+			ssdfs_memcpy(&req2->place,
+				     0, sizeof(struct ssdfs_volume_extent),
+				     &req1->place,
+				     0, sizeof(struct ssdfs_volume_extent),
+				     sizeof(struct ssdfs_volume_extent));
+		}
+
+		si = tbl->segs[SSDFS_MAIN_MAPTBL_SEG][seg_index];
+		err = ssdfs_segment_commit_log_async(si,
+						SSDFS_REQ_ASYNC_NO_FREE,
+						req1);
+
+		if (!err && has_backup) {
+			if (!tbl->segs[SSDFS_COPY_MAPTBL_SEG]) {
+				err = -ERANGE;
+				SSDFS_ERR("copy of maptbl doesn't exist\n");
+				goto finish_issue_commit_request;
+			}
+
+			si = tbl->segs[SSDFS_COPY_MAPTBL_SEG][seg_index];
+			err = ssdfs_segment_commit_log_async(si,
+						SSDFS_REQ_ASYNC_NO_FREE,
+						req2);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update extent: "
+				  "seg_index %u, err %d\n",
+				  seg_index, err);
+			goto finish_issue_commit_request;
+		}
+
+		area_start += area_size;
+		processed_pages += area_size;
+		area_size = min_t(pgoff_t,
+				  (pgoff_t)PAGEVEC_SIZE,
+				  (pgoff_t)(tbl->fragment_pages -
+					    processed_pages));
+	} while (processed_pages < tbl->fragment_pages);
+
+finish_issue_commit_request:
+	if (err) {
+		ssdfs_put_request(req1);
+		if (has_backup)
+			ssdfs_put_request(req2);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_commit_logs() - issue commit log requests
+ * @tbl: mapping table object
+ *
+ * This method tries to issue the commit log requests.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_commit_logs(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	u32 fragments_count;
+	bool has_backup;
+	u32 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragments_count = tbl->fragments_count;
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		down_write(&fdesc->lock);
+
+		switch (atomic_read(&fdesc->state)) {
+		case SSDFS_MAPTBL_FRAG_DIRTY:
+			err = -ERANGE;
+			SSDFS_ERR("found unprocessed dirty fragment: "
+				  "index %d\n", i);
+			goto finish_fragment_processing;
+
+		case SSDFS_MAPTBL_FRAG_TOWRITE:
+			err = __ssdfs_maptbl_commit_logs(tbl, fdesc, i);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to commit logs: "
+					  "fragment_index %u, err %d\n",
+					  i, err);
+				goto finish_fragment_processing;
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+finish_fragment_processing:
+		up_write(&fdesc->lock);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_wait_commit_logs_end() - wait commit logs ending
+ * @tbl: mapping table object
+ *
+ * This method is waiting the end of commit logs operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_wait_commit_logs_end(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	bool has_backup;
+	u32 fragments_count;
+	int state;
+	u32 i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragments_count = tbl->fragments_count;
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		down_write(&fdesc->lock);
+
+		switch (atomic_read(&fdesc->state)) {
+		case SSDFS_MAPTBL_FRAG_DIRTY:
+			err = -ERANGE;
+			SSDFS_ERR("found unprocessed dirty fragment: "
+				  "index %d\n", i);
+			goto finish_fragment_processing;
+
+		case SSDFS_MAPTBL_FRAG_TOWRITE:
+			for (j = 0; j < fdesc->flush_req_count; j++) {
+				req1 = &fdesc->flush_req1[j];
+				req2 = &fdesc->flush_req2[j];
+
+				err = ssdfs_maptbl_check_request(fdesc, req1);
+				if (unlikely(err)) {
+					SSDFS_ERR("flush request failed: "
+						  "err %d\n", err);
+					goto finish_fragment_processing;
+				}
+
+				if (!has_backup)
+					continue;
+
+				err = ssdfs_maptbl_check_request(fdesc, req2);
+				if (unlikely(err)) {
+					SSDFS_ERR("flush request failed: "
+						  "err %d\n", err);
+					goto finish_fragment_processing;
+				}
+			}
+
+			state = atomic_cmpxchg(&fdesc->state,
+						SSDFS_MAPTBL_FRAG_TOWRITE,
+						SSDFS_MAPTBL_FRAG_INITIALIZED);
+			if (state != SSDFS_MAPTBL_FRAG_TOWRITE) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid fragment state %#x\n",
+					  state);
+				goto finish_fragment_processing;;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment_index %u, state %#x\n",
+				  i,
+				  atomic_read(&fdesc->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+finish_fragment_processing:
+		up_write(&fdesc->lock);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_maptbl_prepare_migration() - issue prepare migration requests
+ * @tbl: mapping table object
+ * @fdesc: pointer on fragment descriptor
+ * @fragment_index: index of fragment in the array
+ *
+ * This method tries to issue prepare migration requests.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_maptbl_prepare_migration(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u32 fragment_index)
+{
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	struct ssdfs_segment_info *si;
+	u64 ino = SSDFS_MAPTBL_INO;
+	bool has_backup;
+	pgoff_t area_start;
+	pgoff_t area_size, processed_pages;
+	u64 offset;
+	u16 seg_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("maptbl %p, fragment_index %u\n",
+		  tbl, fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	area_start = 0;
+	area_size = min_t(pgoff_t,
+			  (pgoff_t)PAGEVEC_SIZE,
+			  (pgoff_t)tbl->fragment_pages);
+	processed_pages = 0;
+
+	fdesc->flush_req_count = 0;
+
+	do {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(area_size == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_realloc_flush_reqs_array(fdesc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc the reqs array\n");
+			goto finish_issue_prepare_migration_request;
+		}
+
+		req1 = &fdesc->flush_req1[fdesc->flush_req_count];
+		req2 = &fdesc->flush_req2[fdesc->flush_req_count];
+		fdesc->flush_req_count++;
+
+		ssdfs_request_init(req1);
+		ssdfs_get_request(req1);
+		if (has_backup) {
+			ssdfs_request_init(req2);
+			ssdfs_get_request(req2);
+		}
+
+		offset = area_start * PAGE_SIZE;
+		offset += fragment_index * tbl->fragment_bytes;
+
+		ssdfs_request_prepare_logical_extent(ino, offset,
+						     0, 0, 0, req1);
+		if (has_backup) {
+			ssdfs_request_prepare_logical_extent(ino,
+							     offset,
+							     0, 0, 0,
+							     req2);
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("area_start %lu, area_size %lu, "
+			  "processed_pages %lu, tbl->fragment_pages %u\n",
+			  area_start, area_size, processed_pages,
+			  tbl->fragment_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = ssdfs_page_array_get_page_locked(&fdesc->array,
+							area_start);
+		if (IS_ERR_OR_NULL(page)) {
+			err = page == NULL ? -ERANGE : PTR_ERR(page);
+			SSDFS_ERR("fail to get page: "
+				  "index %lu, err %d\n",
+				  area_start, err);
+			goto finish_issue_prepare_migration_request;
+		}
+
+		kaddr = kmap_local_page(page);
+		err = ssdfs_maptbl_define_volume_extent(tbl, req1, kaddr,
+							area_start, area_size,
+							&seg_index);
+		kunmap_local(kaddr);
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define volume extent: "
+				  "err %d\n",
+				  err);
+			goto finish_issue_prepare_migration_request;
+		}
+
+		if (has_backup) {
+			ssdfs_memcpy(&req2->place,
+				     0, sizeof(struct ssdfs_volume_extent),
+				     &req1->place,
+				     0, sizeof(struct ssdfs_volume_extent),
+				     sizeof(struct ssdfs_volume_extent));
+		}
+
+		si = tbl->segs[SSDFS_MAIN_MAPTBL_SEG][seg_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start migration now: seg %llu\n", si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_segment_prepare_migration_async(si,
+						SSDFS_REQ_ASYNC_NO_FREE,
+						req1);
+		if (!err && has_backup) {
+			if (!tbl->segs[SSDFS_COPY_MAPTBL_SEG]) {
+				err = -ERANGE;
+				SSDFS_ERR("copy of maptbl doesn't exist\n");
+				goto finish_issue_prepare_migration_request;
+			}
+
+			si = tbl->segs[SSDFS_COPY_MAPTBL_SEG][seg_index];
+			err = ssdfs_segment_prepare_migration_async(si,
+						SSDFS_REQ_ASYNC_NO_FREE,
+						req2);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update extent: "
+				  "seg_index %u, err %d\n",
+				  seg_index, err);
+			goto finish_issue_prepare_migration_request;
+		}
+
+		area_start += area_size;
+		processed_pages += area_size;
+		area_size = min_t(pgoff_t,
+				  (pgoff_t)PAGEVEC_SIZE,
+				  (pgoff_t)(tbl->fragment_pages -
+					    processed_pages));
+	} while (processed_pages < tbl->fragment_pages);
+
+finish_issue_prepare_migration_request:
+	if (err) {
+		ssdfs_put_request(req1);
+		if (has_backup)
+			ssdfs_put_request(req2);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_prepare_migration() - issue prepare migration requests
+ * @tbl: mapping table object
+ *
+ * This method tries to issue prepare migration requests.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_prepare_migration(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	u32 fragments_count;
+	int state;
+	u32 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragments_count = tbl->fragments_count;
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		state = atomic_read(&fdesc->state);
+		if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+			SSDFS_ERR("fragment is corrupted: index %u\n",
+				  i);
+			return -EFAULT;
+		} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+			struct completion *end = &fdesc->init_end;
+
+			up_read(&tbl->tbl_lock);
+
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl's fragment init failed: "
+					  "index %u\n", i);
+				return -ERANGE;
+			}
+
+			down_read(&tbl->tbl_lock);
+		}
+
+		state = atomic_read(&fdesc->state);
+		switch (state) {
+		case SSDFS_MAPTBL_FRAG_INITIALIZED:
+		case SSDFS_MAPTBL_FRAG_DIRTY:
+			/* expected state */
+			break;
+
+		case SSDFS_MAPTBL_FRAG_CREATED:
+		case SSDFS_MAPTBL_FRAG_INIT_FAILED:
+			SSDFS_WARN("fragment is not initialized: "
+				   "index %u, state %#x\n",
+				   i, state);
+			return -EFAULT;
+
+		default:
+			SSDFS_WARN("unexpected fragment state: "
+				   "index %u, state %#x\n",
+				   i, atomic_read(&fdesc->state));
+			return -ERANGE;
+		}
+
+		down_write(&fdesc->lock);
+		err = __ssdfs_maptbl_prepare_migration(tbl, fdesc, i);
+		up_write(&fdesc->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare migration: "
+				  "fragment_index %u, err %d\n",
+				  i, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_wait_prepare_migration_end() - wait migration preparation ending
+ * @tbl: mapping table object
+ *
+ * This method is waiting the end of migration preparation operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_wait_prepare_migration_end(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	bool has_backup;
+	u32 fragments_count;
+	u32 i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragments_count = tbl->fragments_count;
+	has_backup = atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		down_write(&fdesc->lock);
+
+		for (j = 0; j < fdesc->flush_req_count; j++) {
+			req1 = &fdesc->flush_req1[j];
+			req2 = &fdesc->flush_req2[j];
+
+			err = ssdfs_maptbl_check_request(fdesc, req1);
+			if (unlikely(err)) {
+				SSDFS_ERR("flush request failed: "
+					  "err %d\n", err);
+				goto finish_fragment_processing;
+			}
+
+			if (!has_backup)
+				continue;
+
+			err = ssdfs_maptbl_check_request(fdesc, req2);
+			if (unlikely(err)) {
+				SSDFS_ERR("flush request failed: "
+					  "err %d\n", err);
+				goto finish_fragment_processing;
+			}
+		}
+
+finish_fragment_processing:
+		up_write(&fdesc->lock);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_maptbl_create_checkpoint(struct ssdfs_peb_mapping_table *tbl)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement %s\n", __func__);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_flush() - flush dirty mapping table object
+ * @tbl: mapping table object
+ *
+ * This method tries to flush dirty mapping table object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - mapping table is corrupted.
+ */
+int ssdfs_maptbl_flush(struct ssdfs_peb_mapping_table *tbl)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("maptbl %p\n", tbl);
+#else
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("prepare migration\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&tbl->tbl_lock);
+
+	err = ssdfs_maptbl_prepare_migration(tbl);
+	if (unlikely(err)) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to prepare migration: err %d\n",
+				err);
+		goto finish_prepare_migration;
+	}
+
+	err = ssdfs_maptbl_wait_prepare_migration_end(tbl);
+	if (unlikely(err)) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to prepare migration: err %d\n",
+				err);
+		goto finish_prepare_migration;
+	}
+
+finish_prepare_migration:
+	up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finish prepare migration\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err))
+		return err;
+
+	/*
+	 * This flag should be not included into the header.
+	 * The flag is used only during flush operation.
+	 * The inclusion of the flag in the on-disk layout's
+	 * state means the volume corruption.
+	 */
+	atomic_or(SSDFS_MAPTBL_UNDER_FLUSH, &tbl->flags);
+
+	down_write(&tbl->tbl_lock);
+
+	ssdfs_sb_maptbl_header_correct_state(tbl);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("flush dirty fragments\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_flush_dirty_fragments(tbl);
+	if (err == -ENODATA) {
+		err = 0;
+		up_write(&tbl->tbl_lock);
+		SSDFS_DBG("maptbl hasn't dirty fragments\n");
+		goto finish_maptbl_flush;
+	} else if (unlikely(err)) {
+		up_write(&tbl->tbl_lock);
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush maptbl: err %d\n",
+				err);
+		goto finish_maptbl_flush;
+	}
+
+	err = ssdfs_maptbl_wait_flush_end(tbl);
+	if (unlikely(err)) {
+		up_write(&tbl->tbl_lock);
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush maptbl: err %d\n",
+				err);
+		goto finish_maptbl_flush;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finish flush dirty fragments\n");
+
+	SSDFS_DBG("commit logs\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_commit_logs(tbl);
+	if (unlikely(err)) {
+		up_write(&tbl->tbl_lock);
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush maptbl: err %d\n",
+				err);
+		goto finish_maptbl_flush;
+	}
+
+	err = ssdfs_maptbl_wait_commit_logs_end(tbl);
+	if (unlikely(err)) {
+		up_write(&tbl->tbl_lock);
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush maptbl: err %d\n",
+				err);
+		goto finish_maptbl_flush;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finish commit logs\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	downgrade_write(&tbl->tbl_lock);
+
+	err = ssdfs_maptbl_create_checkpoint(tbl);
+	if (unlikely(err)) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to create maptbl's checkpoint: "
+				"err %d\n",
+				err);
+	}
+
+	up_read(&tbl->tbl_lock);
+
+finish_maptbl_flush:
+	atomic_and(~SSDFS_MAPTBL_UNDER_FLUSH, &tbl->flags);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+int ssdfs_maptbl_resize(struct ssdfs_peb_mapping_table *tbl,
+			u64 new_pebs_count)
+{
+	/* TODO: implement */
+	SSDFS_WARN("TODO: implement %s\n", __func__);
+	return -ENOSYS;
+}
+
+/*
+ * ssdfs_maptbl_get_peb_descriptor() - retrieve PEB descriptor
+ * @fdesc: fragment descriptor
+ * @index: index of PEB descriptor in the PEB table
+ * @peb_id: pointer on PEB ID value [out]
+ * @peb_desc: pointer on PEB descriptor value [out]
+ *
+ * This method tries to extract PEB ID and PEB descriptor
+ * for the index of PEB descriptor in the PEB table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_get_peb_descriptor(struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u16 index, u64 *peb_id,
+				    struct ssdfs_peb_descriptor *peb_desc)
+{
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !peb_id || !peb_desc);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("fdesc %p, index %u, peb_id %p, peb_desc %p\n",
+		  fdesc, index, peb_id, peb_desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*peb_id = U64_MAX;
+	page_index = PEBTBL_PAGE_INDEX(fdesc, index);
+	item_index = index % fdesc->pebs_per_page;
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	*peb_id = GET_PEB_ID(kaddr, item_index);
+	if (*peb_id == U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define peb_id: "
+			  "page_index %lu, item_index %u\n",
+			  page_index, item_index);
+		goto finish_page_processing;
+	}
+
+	ptr = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = IS_ERR(ptr) ? PTR_ERR(ptr) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_page_processing;
+	}
+
+	ssdfs_memcpy(peb_desc,
+		     0, sizeof(struct ssdfs_peb_descriptor),
+		     ptr,
+		     0, sizeof(struct ssdfs_peb_descriptor),
+		     sizeof(struct ssdfs_peb_descriptor));
+
+finish_page_processing:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * GET_LEB_DESCRIPTOR() - retrieve LEB descriptor
+ * @kaddr: pointer on memory page's content
+ * @leb_id: LEB ID number
+ *
+ * This method tries to return the pointer on
+ * LEB descriptor for @leb_id.
+ *
+ * RETURN:
+ * [success] - pointer on LEB descriptor
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+struct ssdfs_leb_descriptor *GET_LEB_DESCRIPTOR(void *kaddr, u64 leb_id)
+{
+	struct ssdfs_leb_table_fragment_header *hdr;
+	u64 start_leb;
+	u16 lebs_count;
+	u64 leb_id_diff;
+	u32 leb_desc_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, leb_id %llu\n",
+		  kaddr, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+
+	if (le16_to_cpu(hdr->magic) != SSDFS_LEB_TABLE_MAGIC) {
+		SSDFS_ERR("corrupted page\n");
+		return ERR_PTR(-ERANGE);
+	}
+
+	start_leb = le64_to_cpu(hdr->start_leb);
+	lebs_count = le16_to_cpu(hdr->lebs_count);
+
+	if (leb_id < start_leb ||
+	    leb_id >= (start_leb + lebs_count)) {
+		SSDFS_ERR("corrupted page: "
+			  "leb_id %llu, start_leb %llu, lebs_count %u\n",
+			  leb_id, start_leb, lebs_count);
+		return ERR_PTR(-ERANGE);
+	}
+
+	leb_id_diff = leb_id - start_leb;
+	leb_desc_off = SSDFS_LEBTBL_FRAGMENT_HDR_SIZE;
+	leb_desc_off += leb_id_diff * sizeof(struct ssdfs_leb_descriptor);
+
+	if (leb_desc_off >= PAGE_SIZE) {
+		SSDFS_ERR("invalid offset %u\n", leb_desc_off);
+		return ERR_PTR(-ERANGE);
+	}
+
+	return (struct ssdfs_leb_descriptor *)((u8 *)kaddr + leb_desc_off);
+}
+
+/*
+ * LEBTBL_PAGE_INDEX() - define LEB table's page index
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB identification number
+ *
+ * RETURN:
+ * [success] - page index.
+ * [failure] - ULONG_MAX.
+ */
+static inline
+pgoff_t LEBTBL_PAGE_INDEX(struct ssdfs_maptbl_fragment_desc *fdesc,
+			  u64 leb_id)
+{
+	u64 leb_id_diff;
+	pgoff_t page_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, leb_id %llu\n",
+		  fdesc, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (leb_id < fdesc->start_leb ||
+	    leb_id >= (fdesc->start_leb + fdesc->lebs_count)) {
+		SSDFS_ERR("invalid leb_id: leb_id %llu, "
+			  "start_leb %llu, lebs_count %u\n",
+			  leb_id, fdesc->start_leb, fdesc->lebs_count);
+		return ULONG_MAX;
+	}
+
+	leb_id_diff = leb_id - fdesc->start_leb;
+	page_index = (pgoff_t)(leb_id_diff / fdesc->lebs_per_page);
+
+	if (page_index >= fdesc->lebtbl_pages) {
+		SSDFS_ERR("page_index %lu >= fdesc->lebtbl_pages %u\n",
+			  page_index, fdesc->lebtbl_pages);
+		return ULONG_MAX;
+	}
+
+	return page_index;
+}
+
+/*
+ * ssdfs_maptbl_get_leb_descriptor() - retrieve LEB descriptor
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @leb_desc: pointer on LEB descriptor value [out]
+ *
+ * This method tries to extract LEB descriptor
+ * for the LEB ID number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_get_leb_descriptor(struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u64 leb_id,
+				    struct ssdfs_leb_descriptor *leb_desc)
+{
+	struct ssdfs_leb_descriptor *ptr;
+	pgoff_t page_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !leb_desc);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("fdesc %p, leb_id %llu, leb_desc %p\n",
+		  fdesc, leb_id, leb_desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = LEBTBL_PAGE_INDEX(fdesc, leb_id);
+	if (page_index == ULONG_MAX) {
+		SSDFS_ERR("fail to define page_index: "
+			  "leb_id %llu\n",
+			  leb_id);
+		return -ERANGE;
+	}
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	ptr = GET_LEB_DESCRIPTOR(kaddr, leb_id);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = IS_ERR(ptr) ? PTR_ERR(ptr) : -ERANGE;
+		SSDFS_ERR("fail to get leb_descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_page_processing;
+	}
+
+	ssdfs_memcpy(leb_desc,
+		     0, sizeof(struct ssdfs_leb_descriptor),
+		     ptr,
+		     0, sizeof(struct ssdfs_leb_descriptor),
+		     sizeof(struct ssdfs_leb_descriptor));
+
+finish_page_processing:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * FRAGMENT_INDEX() - define fragment index
+ * @tbl: pointer on mapping table object
+ * @leb_id: LEB ID number
+ *
+ * RETURN:
+ * [success] - fragment index.
+ * [failure] - U32_MAX.
+ */
+static inline
+u32 FRAGMENT_INDEX(struct ssdfs_peb_mapping_table *tbl, u64 leb_id)
+{
+	u32 fragment_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p, leb_id %llu\n",
+		  tbl, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (leb_id >= tbl->lebs_count) {
+		SSDFS_ERR("leb_id %llu >= tbl->lebs_count %llu\n",
+			  leb_id, tbl->lebs_count);
+		return U32_MAX;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(div_u64(leb_id, tbl->lebs_per_fragment) >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment_index = (u32)div_u64(leb_id, tbl->lebs_per_fragment);
+	if (fragment_index >= tbl->fragments_count) {
+		SSDFS_ERR("fragment_index %u >= tbl->fragments_count %u\n",
+			  fragment_index, tbl->fragments_count);
+		return U32_MAX;
+	}
+
+	return fragment_index;
+}
+
+/*
+ * ssdfs_maptbl_get_fragment_descriptor() - get fragment descriptor
+ * @tbl: pointer on mapping table object
+ * @leb_id: LEB ID number
+ *
+ * RETURN:
+ * [success] - pointer on fragment descriptor.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+struct ssdfs_maptbl_fragment_desc *
+ssdfs_maptbl_get_fragment_descriptor(struct ssdfs_peb_mapping_table *tbl,
+				     u64 leb_id)
+{
+	u32 fragment_index = FRAGMENT_INDEX(tbl, leb_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("leb_id %llu, fragment index %u\n",
+		  leb_id, fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fragment_index == U32_MAX) {
+		SSDFS_ERR("invalid fragment_index: leb_id %llu\n",
+			  leb_id);
+		return ERR_PTR(-ERANGE);
+	}
+
+	return &tbl->desc_array[fragment_index];
+}
+
+/*
+ * ssdfs_maptbl_get_peb_relation() - retrieve PEB relation
+ * @fdesc: fragment descriptor
+ * @leb_desc: LEB descriptor
+ * @pebr: PEB relation [out]
+ *
+ * This method tries to retrieve PEB relation for @leb_desc.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - unitialized LEB descriptor.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_get_peb_relation(struct ssdfs_maptbl_fragment_desc *fdesc,
+				  struct ssdfs_leb_descriptor *leb_desc,
+				  struct ssdfs_maptbl_peb_relation *pebr)
+{
+	u16 physical_index, relation_index;
+	u64 peb_id;
+	struct ssdfs_peb_descriptor peb_desc;
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !leb_desc || !pebr);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("fdesc %p, leb_desc %p, pebr %p\n",
+		  fdesc, leb_desc, pebr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	physical_index = le16_to_cpu(leb_desc->physical_index);
+	relation_index = le16_to_cpu(leb_desc->relation_index);
+
+	if (physical_index == U16_MAX) {
+		SSDFS_DBG("unitialized leb descriptor\n");
+		return -ENODATA;
+	}
+
+	err = ssdfs_maptbl_get_peb_descriptor(fdesc, physical_index,
+					      &peb_id, &peb_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb descriptor: "
+			  "physical_index %u, err %d\n",
+			  physical_index, err);
+		return err;
+	}
+
+	ptr = &pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX];
+
+	if (peb_id == U64_MAX) {
+		SSDFS_ERR("invalid peb_id\n");
+		return -ERANGE;
+	}
+
+	ptr->peb_id = peb_id;
+	ptr->shared_peb_index = peb_desc.shared_peb_index;
+	ptr->erase_cycles = le32_to_cpu(peb_desc.erase_cycles);
+	ptr->type = peb_desc.type;
+	ptr->state = peb_desc.state;
+	ptr->flags = peb_desc.flags;
+
+	if (relation_index == U16_MAX) {
+		SSDFS_DBG("relation peb_id is absent\n");
+		return 0;
+	}
+
+	err = ssdfs_maptbl_get_peb_descriptor(fdesc, relation_index,
+					      &peb_id, &peb_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb descriptor: "
+			  "relation_index %u, err %d\n",
+			  relation_index, err);
+		return err;
+	}
+
+	ptr = &pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX];
+
+	if (peb_id == U64_MAX) {
+		SSDFS_ERR("invalid peb_id\n");
+		return -ERANGE;
+	}
+
+	ptr->peb_id = peb_id;
+	ptr->erase_cycles = le32_to_cpu(peb_desc.erase_cycles);
+	ptr->type = peb_desc.type;
+	ptr->state = peb_desc.state;
+	ptr->flags = le16_to_cpu(peb_desc.flags);
+
+	return 0;
+}
+
+/*
+ * should_cache_peb_info() - check that PEB info is cached
+ * @peb_type: PEB type
+ */
+static inline
+bool should_cache_peb_info(u8 peb_type)
+{
+	return peb_type == SSDFS_MAPTBL_SBSEG_PEB_TYPE ||
+		peb_type == SSDFS_MAPTBL_SEGBMAP_PEB_TYPE ||
+		peb_type == SSDFS_MAPTBL_MAPTBL_PEB_TYPE;
+}
+
+/*
+ * ssdfs_maptbl_define_pebtbl_page() - define PEB table's page index
+ * @tbl: pointer on mapping table object
+ * @desc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @peb_desc_index: PEB descriptor index
+ *
+ * RETURN:
+ * [success] - page index.
+ * [failure] - ULONG_MAX.
+ */
+static
+pgoff_t ssdfs_maptbl_define_pebtbl_page(struct ssdfs_peb_mapping_table *tbl,
+					struct ssdfs_maptbl_fragment_desc *desc,
+					u64 leb_id,
+					u16 peb_desc_index)
+{
+	u64 leb_id_diff;
+	u64 stripe_index;
+	u64 page_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !desc);
+
+	if (leb_id < desc->start_leb ||
+	    leb_id >= (desc->start_leb + desc->lebs_count)) {
+		SSDFS_ERR("invalid leb_id: leb_id %llu, "
+			  "start_leb %llu, lebs_count %u\n",
+			  leb_id, desc->start_leb, desc->lebs_count);
+		return ULONG_MAX;
+	}
+
+	if (peb_desc_index != U16_MAX) {
+		if (peb_desc_index >= tbl->pebs_per_fragment) {
+			SSDFS_ERR("peb_desc_index %u >= pebs_per_fragment %u\n",
+				  peb_desc_index, tbl->pebs_per_fragment);
+			return ULONG_MAX;
+		}
+	}
+
+	SSDFS_DBG("tbl %p, desc %p, leb_id %llu\n", tbl, desc, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_desc_index >= U16_MAX) {
+		leb_id_diff = leb_id - desc->start_leb;
+		stripe_index = div_u64(leb_id_diff, tbl->pebs_per_stripe);
+		page_index = leb_id_diff -
+				(stripe_index * tbl->pebs_per_stripe);
+		page_index = div_u64(page_index, desc->pebs_per_page);
+		page_index += stripe_index * desc->stripe_pages;
+		page_index += desc->lebtbl_pages;
+	} else {
+		page_index = PEBTBL_PAGE_INDEX(desc, peb_desc_index);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index > ULONG_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (pgoff_t)page_index;
+}
+
+/*
+ * is_pebtbl_stripe_recovering() - check that PEB is under recovering
+ * @hdr: PEB table fragment's header
+ */
+static inline
+bool is_pebtbl_stripe_recovering(struct ssdfs_peb_table_fragment_header *hdr)
+{
+	u16 flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+
+	SSDFS_DBG("pebtbl_hdr %p\n", hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	flags = hdr->flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(flags & ~SSDFS_PEBTBL_FLAGS_MASK);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return flags & SSDFS_PEBTBL_UNDER_RECOVERING;
+}
+
+/*
+ * ssdfs_maptbl_solve_inconsistency() - resolve PEB state inconsistency
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @pebr: cached PEB relation
+ *
+ * This method tries to change the PEB state in the mapping table
+ * for the case if cached PEB state is inconsistent.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unitialized leb descriptor.
+ */
+int ssdfs_maptbl_solve_inconsistency(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u64 leb_id,
+				     struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct ssdfs_leb_descriptor leb_desc;
+	pgoff_t page_index;
+	struct page *page;
+	void *kaddr;
+	struct ssdfs_peb_table_fragment_header *hdr;
+	u16 physical_index, relation_index;
+	struct ssdfs_peb_descriptor *peb_desc;
+	struct ssdfs_maptbl_peb_descriptor *cached;
+	u16 item_index;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc || !pebr);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("fdesc %p, leb_id %llu\n",
+		  fdesc, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_get_leb_descriptor(fdesc, leb_id, &leb_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get leb descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		return err;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+
+	if (physical_index == U16_MAX) {
+		SSDFS_ERR("unitialized leb descriptor: "
+			  "leb_id %llu\n", leb_id);
+		return -ENODATA;
+	}
+
+	page_index = ssdfs_maptbl_define_pebtbl_page(tbl, fdesc,
+						     leb_id, physical_index);
+	if (page_index == ULONG_MAX) {
+		SSDFS_ERR("fail to define PEB table's page_index: "
+			  "leb_id %llu, physical_index %u\n",
+			  leb_id, physical_index);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("leb_id %llu, physical_index %u, page_index %lu\n",
+		  leb_id, physical_index, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	if (is_pebtbl_stripe_recovering(hdr)) {
+		err = -EACCES;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to change the PEB state: "
+			  "leb_id %llu: "
+			  "stripe %u is under recovering\n",
+			  leb_id,
+			  le16_to_cpu(hdr->stripe_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_physical_index_processing;
+	}
+
+	item_index = physical_index % fdesc->pebs_per_page;
+
+	peb_id = GET_PEB_ID(kaddr, item_index);
+	if (peb_id == U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define peb_id: "
+			  "page_index %lu, item_index %u\n",
+			  page_index, item_index);
+		goto finish_physical_index_processing;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("physical_index %u, item_index %u, "
+		  "pebs_per_page %u, peb_id %llu\n",
+		  physical_index, item_index,
+		  fdesc->pebs_per_page, peb_id);
+
+	SSDFS_DBG("PAGE DUMP: page_index %lu\n",
+		  page_index);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_desc = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(peb_desc)) {
+		err = IS_ERR(peb_desc) ? PTR_ERR(peb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_physical_index_processing;
+	}
+
+	cached = &pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX];
+
+	if (cached->peb_id != peb_id) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid main index: "
+			  "cached->peb_id %llu, peb_id %llu\n",
+			  cached->peb_id, peb_id);
+		goto finish_physical_index_processing;
+	}
+
+	peb_desc->state = cached->state;
+	peb_desc->flags = cached->flags;
+	peb_desc->shared_peb_index = cached->shared_peb_index;
+
+finish_physical_index_processing:
+	kunmap_local(kaddr);
+
+	if (!err) {
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		err = ssdfs_page_array_set_page_dirty(&fdesc->array,
+						      page_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: err %d\n",
+				  page_index, err);
+		}
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
+	if (err)
+		return err;
+
+	cached = &pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX];
+	relation_index = le16_to_cpu(leb_desc.relation_index);
+
+	if (cached->peb_id >= U64_MAX && relation_index == U16_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("LEB %llu hasn't relation\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if (relation_index == U16_MAX) {
+		SSDFS_ERR("unitialized leb descriptor: "
+			  "leb_id %llu\n", leb_id);
+		return -ENODATA;
+	}
+
+	page_index = ssdfs_maptbl_define_pebtbl_page(tbl, fdesc,
+						     leb_id, relation_index);
+	if (page_index == ULONG_MAX) {
+		SSDFS_ERR("fail to define PEB table's page_index: "
+			  "leb_id %llu, relation_index %u\n",
+			  leb_id, relation_index);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("leb_id %llu, relation_index %u, page_index %lu\n",
+		  leb_id, relation_index, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	if (is_pebtbl_stripe_recovering(hdr)) {
+		err = -EACCES;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to change the PEB state: "
+			  "leb_id %llu: "
+			  "stripe %u is under recovering\n",
+			  leb_id,
+			  le16_to_cpu(hdr->stripe_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_relation_index_processing;
+	}
+
+	item_index = relation_index % fdesc->pebs_per_page;
+
+	peb_id = GET_PEB_ID(kaddr, item_index);
+	if (peb_id == U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define peb_id: "
+			  "page_index %lu, item_index %u\n",
+			  page_index, item_index);
+		goto finish_relation_index_processing;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("relation_index %u, item_index %u, "
+		  "pebs_per_page %u, peb_id %llu\n",
+		  relation_index, item_index,
+		  fdesc->pebs_per_page, peb_id);
+
+	SSDFS_DBG("PAGE DUMP: page_index %lu\n",
+		  page_index);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_desc = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(peb_desc)) {
+		err = IS_ERR(peb_desc) ? PTR_ERR(peb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_relation_index_processing;
+	}
+
+	if (cached->peb_id != peb_id) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid main index: "
+			  "cached->peb_id %llu, peb_id %llu\n",
+			  cached->peb_id, peb_id);
+		goto finish_relation_index_processing;
+	}
+
+	peb_desc->state = cached->state;
+	peb_desc->flags = cached->flags;
+	peb_desc->shared_peb_index = cached->shared_peb_index;
+
+finish_relation_index_processing:
+	kunmap_local(kaddr);
+
+	if (!err) {
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		err = ssdfs_page_array_set_page_dirty(&fdesc->array,
+						      page_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: err %d\n",
+				  page_index, err);
+		}
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
+	return err;
+}
-- 
2.34.1

