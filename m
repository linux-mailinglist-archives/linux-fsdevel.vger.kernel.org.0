Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A96A2645
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBYBRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBYBQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:48 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2312F04
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:37 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t22so777553oiw.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8KT/xsZ3aapY7TlRqxS9n+nCYXhYZVje65G7qYVAHY=;
        b=F63SyBD7tuXd7IY3FPi3gQaVqfseTEFrv3e7pZEAw/vHfcp/owwiWIrGa1YoDLmKUH
         Mz6BmDN7MYCg5mzGxKXJ45gEHp+dN3grYW7gjSJfUdyA0AA5MvqHLUYAg3euLzO78SG3
         iMYTLFbW2FPbJNcv7c8ZQ1QER7H+MAUxM3E7FqX88pQm0V8NL3lQyl3UN+hwSE8eFfT8
         edzqjTEfrKYKXVcZ06bFMC6x4VPtES/8O1elnUWe6aKLTt4/ENUueNboOiomtlgHF4Ai
         MjxJN8zXsfUPU5BASlC2tXbag12l05IAdkDs6S/ppST8GLopgNCZsBQ2y16AsyDpfc2K
         k4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8KT/xsZ3aapY7TlRqxS9n+nCYXhYZVje65G7qYVAHY=;
        b=xUKlCFQNKthuC3DtDWc471t6bunhFfDqCOVNF/MKWgxlspXLrRufFInlz9GYreTrrX
         b4GLM0+O4J+ybraQYvyU6A3lx4LaEEAqJ/OIqSrRj99HmhetRx/tCIEkK9gg8NrMZOxR
         bwJRG6fToSgNmZlnlOj64xM34gZkKMHUhH1vt/w681NP/5jaWJPvr0fXSGwQU5LwaemS
         eaFyygsQ1aXdtN2po+pGwAv6TD57h8jA8L8OO8zjd7h0JU63lm+Z9s3wj2xDUABlguZN
         oUYiM4Lft4t79poEUMS3f5yLErDBaaSzEFZTOhR7gU1M0MMX7hKnA704SEsyzgSMp0HQ
         iDpQ==
X-Gm-Message-State: AO0yUKVuLYFuGwn1y7b0xO/AN6X41xr0Gb/DQHnMmWaXXmCFru8ioaVX
        8EXh3UPbWgmwf+DDha9DioPx9LL9jAv24Grg
X-Google-Smtp-Source: AK7set82SNyvQG21EdniJg1i/56hilXAroD1yGWztcyFh9MzeX+kxSegFMWODKf6p0Gkcno/VyI9aQ==
X-Received: by 2002:a05:6808:901:b0:37f:ae54:155a with SMTP id w1-20020a056808090100b0037fae54155amr7495982oih.32.1677287795837;
        Fri, 24 Feb 2023 17:16:35 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:34 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 29/76] ssdfs: commit log logic
Date:   Fri, 24 Feb 2023 17:08:40 -0800
Message-Id: <20230225010927.813929-30-slava@dubeyko.com>
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

SSDFS stores any data or metadata in the form of logs in
append-only manner. The mkfs tool defines the size of full
log (for example, 32 logical block or NAND flash pages) for
user data and various metadata. If flush thread has enough
requests to prepare full log, then log starts from segment
header, continues by payload, and finishes by footer.
Otherwise, flush thread logic needs to commit a partial log.
Partial log starts from partial log's header, continues by
payaload, and has no footer. Potentially, area of full log
can contain a sequence of partial logs. It is expected that
the latest log in the sequence of partial logs finishes by
footer. Header contains metadata that desribes location of
block bitmap and offset translation table in the payload
of log. Block bitmap tracks the state (free, pre-allocated,
allocated, invalidated) of logical blocks in the erase block.
Offset translation table converts logical block ID into
the offset of piece of data in the log's payload.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_flush_thread.c | 1745 +++++++++++++++++++++++++++++++++++
 1 file changed, 1745 insertions(+)

diff --git a/fs/ssdfs/peb_flush_thread.c b/fs/ssdfs/peb_flush_thread.c
index 6a9032762ea6..d9352804f6b9 100644
--- a/fs/ssdfs/peb_flush_thread.c
+++ b/fs/ssdfs/peb_flush_thread.c
@@ -113,6 +113,1751 @@ void ssdfs_flush_check_memory_leaks(void)
  *                         FLUSH THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * ssdfs_peb_define_next_log_start() - define start of the next log
+ * @pebi: pointer on PEB object
+ * @log_strategy: strategy in log creation
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ */
+static
+void ssdfs_peb_define_next_log_start(struct ssdfs_peb_info *pebi,
+				     int log_strategy,
+				     pgoff_t *cur_page, u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 pages_diff;
+	u16 rest_phys_free_pages = 0;
+	u32 pages_per_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!cur_page || !write_offset);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, log_strategy %#x, "
+		  "current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u, "
+		  "current_log.free_data_pages %u, "
+		  "sequence_id %d\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  log_strategy,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset,
+		  pebi->current_log.free_data_pages,
+		  atomic_read(&pebi->current_log.sequence_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	pages_per_peb = min_t(u32, fsi->leb_pages_capacity,
+				   fsi->peb_pages_capacity);
+
+	switch (log_strategy) {
+	case SSDFS_START_PARTIAL_LOG:
+	case SSDFS_CONTINUE_PARTIAL_LOG:
+		pebi->current_log.start_page = *cur_page;
+		rest_phys_free_pages = pebi->log_pages -
+					(*cur_page % pebi->log_pages);
+		pebi->current_log.free_data_pages = rest_phys_free_pages;
+		atomic_inc(&pebi->current_log.sequence_id);
+		WARN_ON(pebi->current_log.free_data_pages == 0);
+		break;
+
+	case SSDFS_FINISH_PARTIAL_LOG:
+	case SSDFS_FINISH_FULL_LOG:
+		if (*cur_page % pebi->log_pages) {
+			*cur_page += pebi->log_pages - 1;
+			*cur_page =
+			    (*cur_page / pebi->log_pages) * pebi->log_pages;
+		}
+
+		pebi->current_log.start_page = *cur_page;
+
+		if (pebi->current_log.start_page >= pages_per_peb) {
+			pebi->current_log.free_data_pages = 0;
+		} else {
+			pages_diff = pages_per_peb;
+			pages_diff -= pebi->current_log.start_page;
+
+			pebi->current_log.free_data_pages =
+				min_t(u16, pebi->log_pages, pages_diff);
+		}
+
+		atomic_set(&pebi->current_log.sequence_id, 0);
+		break;
+
+	default:
+		BUG();
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebi->current_log.start_page %u, "
+		  "current_log.free_data_pages %u, "
+		  "sequence_id %d\n",
+		  pebi->current_log.start_page,
+		  pebi->current_log.free_data_pages,
+		  atomic_read(&pebi->current_log.sequence_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_peb_store_pl_header_like_footer() - store partial log's header
+ * @pebi: pointer on PEB object
+ * @flags: partial log header's flags
+ * @hdr_desc: partial log header's metadata descriptor in segment header
+ * @plh_desc: partial log header's metadata descriptors array
+ * @array_size: count of items in array
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store the partial log's header
+ * in the end of the log (instead of footer).
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_pl_header_like_footer(struct ssdfs_peb_info *pebi,
+				    u32 flags,
+				    struct ssdfs_metadata_descriptor *hdr_desc,
+				    struct ssdfs_metadata_descriptor *plh_desc,
+				    size_t array_size,
+				    pgoff_t *cur_page,
+				    u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_partial_log_header *pl_hdr;
+	u32 log_pages;
+	struct page *page;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t array_bytes = desc_size * array_size;
+	u32 area_offset, area_size;
+	u16 seg_type;
+	int sequence_id;
+	u64 last_log_time;
+	u64 last_log_cno;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!hdr_desc || !plh_desc);
+	BUG_ON(!cur_page || !write_offset);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
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
+	seg_type = pebi->pebc->parent_si->seg_type;
+
+	sequence_id = atomic_read(&pebi->current_log.sequence_id);
+	if (sequence_id < 0 || sequence_id >= INT_MAX) {
+		SSDFS_ERR("invalid sequence_id %d\n", sequence_id);
+		return -ERANGE;
+	}
+
+	area_offset = *write_offset;
+	area_size = sizeof(struct ssdfs_partial_log_header);
+
+	*write_offset += max_t(u32, PAGE_SIZE, area_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(((*write_offset + PAGE_SIZE - 1) >> fsi->log_pagesize) >
+		pebi->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_pages = (*write_offset + fsi->pagesize - 1) / fsi->pagesize;
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, *cur_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %lu\n",
+			  *cur_page);
+		return -ENOMEM;
+	}
+
+	pl_hdr = kmap_local_page(page);
+	memset(pl_hdr, 0xFF, PAGE_SIZE);
+	ssdfs_memcpy(pl_hdr->desc_array, 0, array_bytes,
+		     plh_desc, 0, array_bytes,
+		     array_bytes);
+
+	pl_hdr->peb_create_time = cpu_to_le64(pebi->peb_create_time);
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
+	err = ssdfs_prepare_partial_log_header_for_commit(fsi,
+							  sequence_id,
+							  log_pages,
+							  seg_type, flags,
+							  last_log_time,
+							  last_log_cno,
+							  pl_hdr);
+
+	if (!err) {
+		hdr_desc->offset = cpu_to_le32(area_offset +
+				(pebi->current_log.start_page * fsi->pagesize));
+		hdr_desc->size = cpu_to_le32(area_size);
+
+		ssdfs_memcpy(&hdr_desc->check,
+			     0, sizeof(struct ssdfs_metadata_check),
+			     &pl_hdr->check,
+			     0, sizeof(struct ssdfs_metadata_check),
+			     sizeof(struct ssdfs_metadata_check));
+	}
+
+	flush_dcache_page(page);
+	kunmap_local(pl_hdr);
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
+		SSDFS_CRIT("fail to store partial log header: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		return err;
+	}
+
+	pebi->current_log.seg_flags |=
+		SSDFS_LOG_IS_PARTIAL |
+		SSDFS_LOG_HAS_PARTIAL_HEADER |
+		SSDFS_PARTIAL_HEADER_INSTEAD_FOOTER;
+
+	(*cur_page)++;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_pl_header_like_header() - store partial log's header
+ * @pebi: pointer on PEB object
+ * @flags: partial log header's flags
+ * @plh_desc: partial log header's metadata descriptors array
+ * @array_size: count of items in array
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store the partial log's header
+ * in the beginning of the log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_pl_header_like_header(struct ssdfs_peb_info *pebi,
+				    u32 flags,
+				    struct ssdfs_metadata_descriptor *plh_desc,
+				    size_t array_size,
+				    pgoff_t *cur_page,
+				    u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_partial_log_header *pl_hdr;
+	struct page *page;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t array_bytes = desc_size * array_size;
+	u32 seg_flags;
+	u32 log_pages;
+	u16 seg_type;
+	int sequence_id;
+	u64 last_log_time;
+	u64 last_log_cno;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!plh_desc);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(pebi->pebc->parent_si->seg_type > SSDFS_LAST_KNOWN_SEG_TYPE);
+	BUG_ON(*write_offset % fsi->pagesize);
+	BUG_ON((*write_offset >> fsi->log_pagesize) > pebi->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sequence_id = atomic_read(&pebi->current_log.sequence_id);
+	if (sequence_id < 0 || sequence_id >= INT_MAX) {
+		SSDFS_ERR("invalid sequence_id %d\n", sequence_id);
+		return -ERANGE;
+	}
+
+	seg_type = pebi->pebc->parent_si->seg_type;
+	seg_flags = pebi->current_log.seg_flags;
+
+	log_pages = (*write_offset + fsi->pagesize - 1) / fsi->pagesize;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache,
+						pebi->current_log.start_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %u\n",
+			  pebi->current_log.start_page);
+		return -ERANGE;
+	}
+
+	pl_hdr = kmap_local_page(page);
+
+	ssdfs_memcpy(pl_hdr->desc_array, 0, array_bytes,
+		     plh_desc, 0, array_bytes,
+		     array_bytes);
+
+	pl_hdr->peb_create_time = cpu_to_le64(pebi->peb_create_time);
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
+	err = ssdfs_prepare_partial_log_header_for_commit(fsi,
+							  sequence_id,
+							  log_pages,
+							  seg_type,
+							  flags | seg_flags,
+							  last_log_time,
+							  last_log_cno,
+							  pl_hdr);
+	if (unlikely(err))
+		goto finish_pl_header_preparation;
+
+finish_pl_header_preparation:
+	flush_dcache_page(page);
+	kunmap_local(pl_hdr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store partial log header: "
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
+ * ssdfs_peb_store_partial_log_header() - store partial log's header
+ * @pebi: pointer on PEB object
+ * @flags: partial log header's flags
+ * @hdr_desc: partial log header's metadata descriptor in segment header
+ * @plh_desc: partial log header's metadata descriptors array
+ * @array_size: count of items in array
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store the partial log's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_partial_log_header(struct ssdfs_peb_info *pebi, u32 flags,
+				    struct ssdfs_metadata_descriptor *hdr_desc,
+				    struct ssdfs_metadata_descriptor *plh_desc,
+				    size_t array_size,
+				    pgoff_t *cur_page,
+				    u32 *write_offset)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!plh_desc);
+	BUG_ON(!cur_page || !write_offset);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (hdr_desc) {
+		return ssdfs_peb_store_pl_header_like_footer(pebi, flags,
+							     hdr_desc,
+							     plh_desc,
+							     array_size,
+							     cur_page,
+							     write_offset);
+	} else {
+		return ssdfs_peb_store_pl_header_like_header(pebi, flags,
+							     plh_desc,
+							     array_size,
+							     cur_page,
+							     write_offset);
+	}
+}
+
+/*
+ * ssdfs_peb_commit_first_partial_log() - commit first partial log
+ * @pebi: pointer on PEB object
+ *
+ * This function tries to commit the first partial log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_commit_first_partial_log(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor hdr_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor plh_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor *cur_hdr_desc;
+	u32 flags;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	pgoff_t cur_page = pebi->current_log.start_page;
+	u32 write_offset = 0;
+	bool log_has_data = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	memset(hdr_desc, 0, desc_size * SSDFS_SEG_HDR_DESC_MAX);
+	memset(plh_desc, 0, desc_size * SSDFS_SEG_HDR_DESC_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0001: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_reserve_segment_header(pebi, &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to reserve segment header: "
+			   "seg %llu, peb %llu, err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0002: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_commit_log_payload(pebi, hdr_desc, &log_has_data,
+					   &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to commit payload: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+	if (!log_has_data) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("current log hasn't data: start_page %u\n",
+			  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0003: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_hdr_desc = &hdr_desc[SSDFS_LOG_FOOTER_INDEX];
+	flags = SSDFS_LOG_IS_PARTIAL |
+		SSDFS_LOG_HAS_PARTIAL_HEADER |
+		SSDFS_PARTIAL_HEADER_INSTEAD_FOOTER;
+	err = ssdfs_peb_store_partial_log_header(pebi, flags, cur_hdr_desc,
+						 plh_desc,
+						 SSDFS_SEG_HDR_DESC_MAX,
+						 &cur_page,
+						 &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store log's partial header: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0004: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_store_log_header(pebi, hdr_desc,
+					 SSDFS_SEG_HDR_DESC_MAX,
+					 write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store log's header: "
+			   "seg %llu, peb %llu, write_offset %u,"
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   write_offset, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0005: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_flush_current_log_dirty_pages(pebi, write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to flush current log: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0006: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_define_next_log_start(pebi, SSDFS_START_PARTIAL_LOG,
+					&cur_page, &write_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0007: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->current_log.reserved_pages = 0;
+	pebi->current_log.seg_flags = 0;
+
+	ssdfs_peb_set_current_log_state(pebi, SSDFS_LOG_COMMITTED);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log commited: seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_commit_log:
+	return err;
+}
+
+/*
+ * ssdfs_peb_commit_next_partial_log() - commit next partial log
+ * @pebi: pointer on PEB object
+ *
+ * This function tries to commit the next partial log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_commit_next_partial_log(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor plh_desc[SSDFS_SEG_HDR_DESC_MAX];
+	u32 flags;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	pgoff_t cur_page = pebi->current_log.start_page;
+	u32 write_offset = 0;
+	bool log_has_data = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	memset(plh_desc, 0, desc_size * SSDFS_SEG_HDR_DESC_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0001: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_reserve_partial_log_header(pebi, &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to reserve partial log's header: "
+			   "seg %llu, peb %llu, err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0002: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_commit_log_payload(pebi, plh_desc, &log_has_data,
+					   &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to commit payload: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+	if (!log_has_data) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("current log hasn't data: start_page %u\n",
+			  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	flags = SSDFS_LOG_IS_PARTIAL |
+		SSDFS_LOG_HAS_PARTIAL_HEADER;
+	err = ssdfs_peb_store_partial_log_header(pebi, flags, NULL,
+						 plh_desc,
+						 SSDFS_SEG_HDR_DESC_MAX,
+						 &cur_page,
+						 &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store log's partial header: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0003: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_flush_current_log_dirty_pages(pebi, write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to flush current log: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0004: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_define_next_log_start(pebi, SSDFS_CONTINUE_PARTIAL_LOG,
+					&cur_page, &write_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0005: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->current_log.reserved_pages = 0;
+	pebi->current_log.seg_flags = 0;
+
+	ssdfs_peb_set_current_log_state(pebi, SSDFS_LOG_COMMITTED);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log commited: seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_commit_log:
+	return err;
+}
+
+/*
+ * ssdfs_peb_commit_last_partial_log() - commit last partial log
+ * @pebi: pointer on PEB object
+ * @cur_segs: current segment IDs array
+ * @cur_segs_size: size of segment IDs array size in bytes
+ *
+ * This function tries to commit the last partial log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_commit_last_partial_log(struct ssdfs_peb_info *pebi,
+					__le64 *cur_segs,
+					size_t cur_segs_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor plh_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor lf_desc[SSDFS_LOG_FOOTER_DESC_MAX];
+	struct ssdfs_metadata_descriptor *cur_hdr_desc;
+	u32 flags;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	pgoff_t cur_page = pebi->current_log.start_page;
+	pgoff_t cur_page_offset;
+	u32 write_offset = 0;
+	bool log_has_data = false;
+	int log_strategy = SSDFS_FINISH_PARTIAL_LOG;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	memset(plh_desc, 0, desc_size * SSDFS_SEG_HDR_DESC_MAX);
+	memset(lf_desc, 0, desc_size * SSDFS_LOG_FOOTER_DESC_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0001: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_reserve_partial_log_header(pebi, &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to reserve partial log's header: "
+			   "seg %llu, peb %llu, err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0002: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_commit_log_payload(pebi, plh_desc, &log_has_data,
+					   &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to commit payload: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+	if (!log_has_data) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("current log hasn't data: start_page %u\n",
+			  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0003: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_page_offset = cur_page % pebi->log_pages;
+
+	if (cur_page_offset == 0) {
+		/*
+		 * There is no space for log footer.
+		 * So, full log will be without footer.
+		 */
+		SSDFS_DBG("There is no space for log footer.\n");
+
+		flags = SSDFS_LOG_IS_PARTIAL |
+			SSDFS_LOG_HAS_PARTIAL_HEADER;
+		log_strategy = SSDFS_FINISH_PARTIAL_LOG;
+	} else if ((pebi->log_pages - cur_page_offset) == 1) {
+		cur_hdr_desc = &plh_desc[SSDFS_LOG_FOOTER_INDEX];
+		flags = SSDFS_PARTIAL_LOG_FOOTER | SSDFS_ENDING_LOG_FOOTER;
+		err = ssdfs_peb_store_log_footer(pebi, flags, cur_hdr_desc,
+						 lf_desc,
+						 SSDFS_LOG_FOOTER_DESC_MAX,
+						 cur_segs, cur_segs_size,
+						 &cur_page,
+						 &write_offset);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to store log's footer: "
+				   "seg %llu, peb %llu, cur_page %lu, "
+				   "write_offset %u, err %d\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_id,
+				   cur_page, write_offset, err);
+			goto finish_commit_log;
+		}
+
+		flags = SSDFS_LOG_IS_PARTIAL |
+			SSDFS_LOG_HAS_PARTIAL_HEADER |
+			SSDFS_LOG_HAS_FOOTER;
+		log_strategy = SSDFS_FINISH_PARTIAL_LOG;
+	} else {
+		/*
+		 * It is possible to add another log.
+		 */
+		flags = SSDFS_LOG_IS_PARTIAL |
+			SSDFS_LOG_HAS_PARTIAL_HEADER;
+		log_strategy = SSDFS_CONTINUE_PARTIAL_LOG;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0004: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_store_partial_log_header(pebi, flags, NULL,
+						 plh_desc,
+						 SSDFS_SEG_HDR_DESC_MAX,
+						 &cur_page,
+						 &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store log's partial header: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0005: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_flush_current_log_dirty_pages(pebi, write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to flush current log: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0006: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_define_next_log_start(pebi, log_strategy,
+					&cur_page, &write_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0007: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->current_log.reserved_pages = 0;
+	pebi->current_log.seg_flags = 0;
+
+	ssdfs_peb_set_current_log_state(pebi, SSDFS_LOG_COMMITTED);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log commited: seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_commit_log:
+	return err;
+}
+
+/*
+ * ssdfs_peb_commit_full_log() - commit full current log
+ * @pebi: pointer on PEB object
+ * @cur_segs: current segment IDs array
+ * @cur_segs_size: size of segment IDs array size in bytes
+ *
+ * This function tries to commit the current log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_commit_full_log(struct ssdfs_peb_info *pebi,
+				__le64 *cur_segs,
+				size_t cur_segs_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor hdr_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor plh_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor lf_desc[SSDFS_LOG_FOOTER_DESC_MAX];
+	struct ssdfs_metadata_descriptor *cur_hdr_desc;
+	int log_strategy = SSDFS_FINISH_FULL_LOG;
+	u32 flags;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	pgoff_t cur_page = pebi->current_log.start_page;
+	pgoff_t cur_page_offset;
+	u32 write_offset = 0;
+	bool log_has_data = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	memset(hdr_desc, 0, desc_size * SSDFS_SEG_HDR_DESC_MAX);
+	memset(lf_desc, 0, desc_size * SSDFS_LOG_FOOTER_DESC_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0001: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_reserve_segment_header(pebi, &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to reserve segment header: "
+			   "seg %llu, peb %llu, err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0002: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_commit_log_payload(pebi, hdr_desc, &log_has_data,
+					   &cur_page, &write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to commit payload: "
+			   "seg %llu, peb %llu, cur_page %lu, write_offset %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   cur_page, write_offset, err);
+		goto finish_commit_log;
+	}
+
+	if (!log_has_data) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("current log hasn't data: start_page %u\n",
+			  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto define_next_log_start;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0003: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_page_offset = cur_page % pebi->log_pages;
+	if (cur_page_offset == 0) {
+		SSDFS_WARN("There is no space for log footer.\n");
+	}
+
+	if ((pebi->log_pages - cur_page_offset) > 1) {
+		log_strategy = SSDFS_START_PARTIAL_LOG;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start partial log: "
+			  "cur_page_offset %lu, pebi->log_pages %u\n",
+			  cur_page_offset, pebi->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		cur_hdr_desc = &hdr_desc[SSDFS_LOG_FOOTER_INDEX];
+		flags = SSDFS_LOG_IS_PARTIAL |
+			SSDFS_LOG_HAS_PARTIAL_HEADER |
+			SSDFS_PARTIAL_HEADER_INSTEAD_FOOTER;
+		err = ssdfs_peb_store_partial_log_header(pebi, flags,
+							 cur_hdr_desc,
+							 plh_desc,
+							 SSDFS_SEG_HDR_DESC_MAX,
+							 &cur_page,
+							 &write_offset);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to store log's partial header: "
+				   "seg %llu, peb %llu, cur_page %lu, "
+				   "write_offset %u, err %d\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_id, cur_page,
+				   write_offset, err);
+			goto finish_commit_log;
+		}
+	} else {
+		log_strategy = SSDFS_FINISH_FULL_LOG;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("finish full log: "
+			  "cur_page_offset %lu, pebi->log_pages %u\n",
+			  cur_page_offset, pebi->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		cur_hdr_desc = &hdr_desc[SSDFS_LOG_FOOTER_INDEX];
+		flags = 0;
+		err = ssdfs_peb_store_log_footer(pebi, flags, cur_hdr_desc,
+						 lf_desc,
+						 SSDFS_LOG_FOOTER_DESC_MAX,
+						 cur_segs, cur_segs_size,
+						 &cur_page,
+						 &write_offset);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to store log's footer: "
+				   "seg %llu, peb %llu, cur_page %lu, "
+				   "write_offset %u, err %d\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_id, cur_page,
+				   write_offset, err);
+			goto finish_commit_log;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0004: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_store_log_header(pebi, hdr_desc,
+					 SSDFS_SEG_HDR_DESC_MAX,
+					 write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to store log's header: "
+			   "seg %llu, peb %llu, write_offset %u,"
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   write_offset, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0005: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_flush_current_log_dirty_pages(pebi, write_offset);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to flush current log: "
+			   "seg %llu, peb %llu, current_log.start_page %u, "
+			   "err %d\n",
+			   pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			   pebi->current_log.start_page, err);
+		goto finish_commit_log;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0006: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+define_next_log_start:
+	ssdfs_peb_define_next_log_start(pebi, log_strategy,
+					&cur_page, &write_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("0007: cur_page %lu, write_offset %u\n",
+		  cur_page, write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->current_log.reserved_pages = 0;
+	pebi->current_log.seg_flags = 0;
+
+	ssdfs_peb_set_current_log_state(pebi, SSDFS_LOG_COMMITTED);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log commited: seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_commit_log:
+	return err;
+}
+
+/*
+ * ssdfs_peb_calculate_reserved_metapages() - calculate reserved metapages
+ * @page_size: size of page in bytes
+ * @data_pages: number of allocated data pages
+ * @pebs_per_seg: number of PEBs in one segment
+ * @log_strategy: stategy of log commiting
+ */
+u16 ssdfs_peb_calculate_reserved_metapages(u32 page_size,
+					   u32 data_pages,
+					   u32 pebs_per_seg,
+					   int log_strategy)
+{
+	size_t seg_hdr_size = sizeof(struct ssdfs_segment_header);
+	size_t lf_hdr_size = sizeof(struct ssdfs_log_footer);
+	u32 blk_bmap_bytes = 0;
+	u32 blk2off_tbl_bytes = 0;
+	u32 blk_desc_tbl_bytes = 0;
+	u32 reserved_bytes = 0;
+	u32 reserved_pages = 0;
+
+	/* segment header */
+	reserved_bytes += seg_hdr_size;
+
+	/* block bitmap */
+	blk_bmap_bytes = __ssdfs_peb_estimate_blk_bmap_bytes(data_pages, true);
+	reserved_bytes += blk_bmap_bytes;
+
+	/* blk2off table */
+	blk2off_tbl_bytes = __ssdfs_peb_estimate_blk2off_bytes(data_pages,
+								pebs_per_seg);
+	reserved_bytes += blk2off_tbl_bytes;
+
+	/* block descriptor table */
+	blk_desc_tbl_bytes =
+		__ssdfs_peb_estimate_blk_desc_tbl_bytes(data_pages);
+	reserved_bytes += blk_desc_tbl_bytes;
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+	switch (log_strategy) {
+	case SSDFS_START_FULL_LOG:
+	case SSDFS_FINISH_PARTIAL_LOG:
+	case SSDFS_FINISH_FULL_LOG:
+		/* log footer header */
+		reserved_bytes += lf_hdr_size;
+
+		/* block bitmap */
+		reserved_bytes += blk_bmap_bytes;
+
+		/* blk2off table */
+		reserved_bytes += blk2off_tbl_bytes;
+
+		reserved_bytes += page_size - 1;
+		reserved_bytes /= page_size;
+		reserved_bytes *= page_size;
+
+		reserved_pages = reserved_bytes / page_size;
+		break;
+
+	case SSDFS_START_PARTIAL_LOG:
+	case SSDFS_CONTINUE_PARTIAL_LOG:
+		/* do nothing */
+		break;
+
+	default:
+		SSDFS_CRIT("unexpected log strategy %#x\n",
+			   log_strategy);
+		return U16_MAX;
+	}
+
+	reserved_pages = reserved_bytes / page_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("data_pages %u, log_strategy %#x, "
+		  "blk_bmap_bytes %u, blk2off_tbl_bytes %u, "
+		  "blk_desc_tbl_bytes %u, reserved_bytes %u, "
+		  "reserved_pages %u\n",
+		  data_pages, log_strategy,
+		  blk_bmap_bytes, blk2off_tbl_bytes,
+		  blk_desc_tbl_bytes, reserved_bytes,
+		  reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(reserved_pages >= U16_MAX);
+
+	return (u16)reserved_pages;
+}
+
+/*
+ * ssdfs_peb_commit_log() - commit current log
+ * @pebi: pointer on PEB object
+ * @cur_segs: current segment IDs array
+ * @cur_segs_size: size of segment IDs array size in bytes
+ *
+ * This function tries to commit the current log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_commit_log(struct ssdfs_peb_info *pebi,
+			 __le64 *cur_segs, size_t cur_segs_size)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_blk2off_table *table;
+	int log_state;
+	int log_strategy;
+	u32 page_size;
+	u32 pebs_per_seg;
+	u32 pages_per_peb;
+	int used_pages;
+	int invalid_pages;
+	u32 data_pages;
+	u16 reserved_pages;
+	u16 diff;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_state = atomic_read(&pebi->current_log.state);
+
+	switch (log_state) {
+	case SSDFS_LOG_UNKNOWN:
+	case SSDFS_LOG_PREPARED:
+	case SSDFS_LOG_INITIALIZED:
+		SSDFS_WARN("peb %llu current log can't be commited\n",
+			   pebi->peb_id);
+		return -EINVAL;
+
+	case SSDFS_LOG_CREATED:
+		/* do function's work */
+		break;
+
+	case SSDFS_LOG_COMMITTED:
+		SSDFS_WARN("peb %llu current log has been commited\n",
+			   pebi->peb_id);
+		return 0;
+
+	default:
+		BUG();
+	};
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb %llu, current_log.start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#else
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	si = pebi->pebc->parent_si;
+	log_strategy = is_log_partial(pebi);
+	page_size = pebi->pebc->parent_si->fsi->pagesize;
+	pebs_per_seg = pebi->pebc->parent_si->fsi->pebs_per_seg;
+	pages_per_peb = pebi->pebc->parent_si->fsi->pages_per_peb;
+
+	used_pages = ssdfs_peb_get_used_data_pages(pebi->pebc);
+	if (used_pages < 0) {
+		err = used_pages;
+		SSDFS_ERR("fail to get used data pages count: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	invalid_pages = ssdfs_peb_get_invalid_pages(pebi->pebc);
+	if (invalid_pages < 0) {
+		err = invalid_pages;
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	data_pages = used_pages + invalid_pages;
+
+	if (data_pages == 0) {
+		SSDFS_ERR("invalid data pages count: "
+			  "used_pages %d, invalid_pages %d, "
+			  "data_pages %u\n",
+			  used_pages, invalid_pages, data_pages);
+		return -ERANGE;
+	}
+
+	reserved_pages = ssdfs_peb_calculate_reserved_metapages(page_size,
+								data_pages,
+								pebs_per_seg,
+								log_strategy);
+	if (reserved_pages > pages_per_peb) {
+		SSDFS_ERR("reserved_pages %u > pages_per_peb %u\n",
+			  reserved_pages, pages_per_peb);
+		return -ERANGE;
+	}
+
+	if (reserved_pages > pebi->current_log.reserved_pages) {
+		diff = reserved_pages - pebi->current_log.reserved_pages;
+
+		err = ssdfs_segment_blk_bmap_reserve_metapages(&si->blk_bmap,
+								pebi->pebc,
+								diff);
+		if (err == -ENOSPC) {
+			/* ignore error */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to reserve metadata pages: "
+				  "count %u, err %d\n",
+				  diff, err);
+			return err;
+		}
+
+		pebi->current_log.reserved_pages += diff;
+		if (diff > pebi->current_log.free_data_pages)
+			pebi->current_log.free_data_pages = 0;
+		else
+			pebi->current_log.free_data_pages -= diff;
+	} else if (reserved_pages < pebi->current_log.reserved_pages) {
+		diff = pebi->current_log.reserved_pages - reserved_pages;
+
+		err = ssdfs_segment_blk_bmap_free_metapages(&si->blk_bmap,
+							    pebi->pebc,
+							    diff);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to free metadata pages: "
+				  "count %u, err %d\n",
+				  diff, err);
+			return err;
+		}
+
+		pebi->current_log.reserved_pages -= diff;
+		pebi->current_log.free_data_pages += diff;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("data_pages %u, "
+		  "current_log (reserved_pages %u, free_data_pages %u)\n",
+		  data_pages,
+		  pebi->current_log.reserved_pages,
+		  pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebi->current_log.last_log_time = ssdfs_current_timestamp();
+	pebi->current_log.last_log_cno = ssdfs_current_cno(si->fsi->sb);
+
+	log_strategy = is_log_partial(pebi);
+
+	switch (log_strategy) {
+	case SSDFS_START_FULL_LOG:
+		SSDFS_CRIT("log contains nothing: "
+			   "seg %llu, peb %llu, "
+			   "free_data_pages %u\n",
+			   pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id,
+			   pebi->current_log.free_data_pages);
+		return -ERANGE;
+
+	case SSDFS_START_PARTIAL_LOG:
+		err = ssdfs_peb_commit_first_partial_log(pebi);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to commit first partial log: "
+				   "err %d\n", err);
+			return err;
+		}
+		break;
+
+	case SSDFS_CONTINUE_PARTIAL_LOG:
+		err = ssdfs_peb_commit_next_partial_log(pebi);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to commit next partial log: "
+				   "err %d\n", err);
+			return err;
+		}
+		break;
+
+	case SSDFS_FINISH_PARTIAL_LOG:
+		err = ssdfs_peb_commit_last_partial_log(pebi, cur_segs,
+							cur_segs_size);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to commit last partial log: "
+				   "err %d\n", err);
+			return err;
+		}
+		break;
+
+	case SSDFS_FINISH_FULL_LOG:
+		err = ssdfs_peb_commit_full_log(pebi, cur_segs,
+						cur_segs_size);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to commit full log: "
+				   "err %d\n", err);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_CRIT("unexpected log strategy %#x\n",
+			   log_strategy);
+		return -ERANGE;
+	}
+
+	table = pebi->pebc->parent_si->blk2off_table;
+
+	err = ssdfs_blk2off_table_revert_migration_state(table,
+							 pebi->peb_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to revert migration state: "
+			  "seg %llu, peb %llu, peb_index %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  pebi->peb_index,
+			  err);
+	}
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
+/*
+ * ssdfs_peb_remain_log_creation_thread() - remain as log creation thread
+ * @pebc: pointer on PEB container
+ *
+ * This function check that PEB's flush thread can work
+ * as thread that creates logs.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - PEB hasn't free space.
+ */
+static
+int ssdfs_peb_remain_log_creation_thread(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	int peb_free_pages;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+
+	SSDFS_DBG("seg %llu, peb_index %d\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+
+	peb_free_pages = ssdfs_peb_get_free_pages(pebc);
+	if (unlikely(peb_free_pages < 0)) {
+		err = peb_free_pages;
+		SSDFS_ERR("fail to calculate PEB's free pages: "
+			  "seg %llu, peb index %d, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_free_pages %d\n", peb_free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_free_pages == 0) {
+		SSDFS_DBG("PEB hasn't free space\n");
+		return -ENOSPC;
+	}
+
+	if (!is_peb_joined_into_create_requests_queue(pebc)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_WARN("peb_index %u hasn't creation role\n",
+			    pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_peb_join_create_requests_queue(pebc,
+							   &si->create_rq);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to join create requests queue: "
+				  "seg %llu, peb_index %d, err %d\n",
+				  si->seg_id, pebc->peb_index, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_delegate_log_creation_role() - try to delegate log creation role
+ * @pebc: pointer on PEB container
+ * @found_peb_index: index of PEB candidate
+ *
+ * This function tries to delegate the role of logs creation to
+ * PEB with @found_peb_index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - it needs to search another candidate.
+ */
+static
+int ssdfs_peb_delegate_log_creation_role(struct ssdfs_peb_container *pebc,
+					 int found_peb_index)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *found_pebc;
+	int peb_free_pages;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(found_peb_index >= pebc->parent_si->pebs_count);
+
+	SSDFS_DBG("seg %llu, peb_index %d, found_peb_index %d\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  found_peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+
+	if (found_peb_index == pebc->peb_index) {
+		err = ssdfs_peb_remain_log_creation_thread(pebc);
+		if (err == -ENOSPC) {
+			SSDFS_WARN("PEB hasn't free space\n");
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to remain log creation thread: "
+				  "seg %llu, peb_index %d, "
+				  "err %d\n",
+				  si->seg_id, pebc->peb_index, err);
+			return err;
+		}
+
+		return 0;
+	}
+
+	found_pebc = &si->peb_array[found_peb_index];
+
+	peb_free_pages = ssdfs_peb_get_free_pages(found_pebc);
+	if (unlikely(peb_free_pages < 0)) {
+		err = peb_free_pages;
+		SSDFS_ERR("fail to calculate PEB's free pages: "
+			  "seg %llu, peb index %d, err %d\n",
+			  found_pebc->parent_si->seg_id,
+			  found_pebc->peb_index, err);
+		return err;
+	}
+
+	if (peb_free_pages == 0)
+		return -EAGAIN;
+
+	if (is_peb_joined_into_create_requests_queue(found_pebc)) {
+		SSDFS_WARN("PEB is creating log: "
+			   "seg %llu, peb_index %d\n",
+			   found_pebc->parent_si->seg_id,
+			   found_pebc->peb_index);
+		return -EAGAIN;
+	}
+
+	ssdfs_peb_forget_create_requests_queue(pebc);
+
+	err = ssdfs_peb_join_create_requests_queue(found_pebc,
+						   &si->create_rq);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to join create requests queue: "
+			  "seg %llu, peb_index %d, err %d\n",
+			  si->seg_id, found_pebc->peb_index, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_find_next_log_creation_thread() - search PEB for logs creation
+ * @pebc: pointer on PEB container
+ *
+ * This function tries to find and to delegate the role of logs creation
+ * to another PEB's flush thread.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - fail to find another PEB.
+ */
+static
+int ssdfs_peb_find_next_log_creation_thread(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	int start_pos;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+
+	SSDFS_DBG("seg %llu, peb_index %d\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+
+	if (!is_peb_joined_into_create_requests_queue(pebc)) {
+		SSDFS_WARN("peb_index %u hasn't creation role\n",
+			    pebc->peb_index);
+		return -EINVAL;
+	}
+
+	start_pos = pebc->peb_index + si->create_threads;
+
+	if (start_pos >= si->pebs_count)
+		start_pos = pebc->peb_index % si->create_threads;
+
+	if (start_pos == pebc->peb_index) {
+		err = ssdfs_peb_remain_log_creation_thread(pebc);
+		if (err == -ENOSPC) {
+			SSDFS_DBG("PEB hasn't free space\n");
+			return 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to remain log creation thread: "
+				  "seg %llu, peb_index %d, "
+				  "err %d\n",
+				  si->seg_id, pebc->peb_index, err);
+			return err;
+		} else
+			return 0;
+	}
+
+	if (start_pos < pebc->peb_index)
+		goto search_from_begin;
+
+	for (i = start_pos; i < si->pebs_count; i += si->create_threads) {
+		err = ssdfs_peb_delegate_log_creation_role(pebc, i);
+		if (err == -EAGAIN)
+			continue;
+		else if (err == -ENOSPC) {
+			SSDFS_WARN("PEB hasn't free space\n");
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to delegate log creation role: "
+				  "seg %llu, peb_index %d, "
+				  "found_peb_index %d, err %d\n",
+				  si->seg_id, pebc->peb_index,
+				  i, err);
+			return err;
+		} else
+			return 0;
+	}
+
+	start_pos = pebc->peb_index % si->create_threads;
+
+search_from_begin:
+	for (i = start_pos; i <= pebc->peb_index; i += si->create_threads) {
+		err = ssdfs_peb_delegate_log_creation_role(pebc, i);
+		if (err == -EAGAIN)
+			continue;
+		if (err == -ENOSPC) {
+			SSDFS_WARN("PEB hasn't free space\n");
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to delegate log creation role: "
+				  "seg %llu, peb_index %d, "
+				  "found_peb_index %d, err %d\n",
+				  si->seg_id, pebc->peb_index,
+				  i, err);
+			return err;
+		} else
+			return 0;
+	}
+
+	SSDFS_ERR("fail to delegate log creation role: "
+		  "seg %llu, peb_index %d\n",
+		  si->seg_id, pebc->peb_index);
+	return -ERANGE;
+}
+
 /*
  * __ssdfs_finish_request() - common logic of request's finishing
  * @pebc: pointer on PEB container
-- 
2.34.1

