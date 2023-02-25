Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B217F6A2648
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBYBRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBYBQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:51 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB112BE7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:46 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bk32so763225oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJkyFKj+c87Orteyx/xPl4EwjGVyceqGzuVp4SNE7lQ=;
        b=AsllaPkOO5y/L04fMPqr5KwGlCKyIQatKB5WokW6OigwcDWv/c/vLVMg9SmTdhR2VW
         /Tj0W2hp9OERLHrwTUHo40eDuRSDW7cOLIMg0BED8YWuOFQpbb0htIAwy/XRFaLHBdsY
         xbem9mM8/qOIP7Vfk1lTAa5g7HpWAsGZAa66iC6BOAd3nQ6gy4GXD/cdGu7mYyo2RnBZ
         7sgMdUY4SLne8cT73tCDRhqQ7K9eKdshi5ZsCKv8yUWPT8PT/Xbw+8sfcNtZVISyRB/X
         YfTX4MQzzSFeyQF23CRrnKYLYEGlEO6da1Cin+vcS4XpbMFfhvNPMUutjyvUv2qCEBbP
         KltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJkyFKj+c87Orteyx/xPl4EwjGVyceqGzuVp4SNE7lQ=;
        b=Xomjk0YZCIbt0Y/hhpV7zF8ZB51z6pDSSq/ltbQ47JYXapQukK0gVspyLuV98yu2m0
         4/DvfVqgDFpzvQzchnByIQkNKh1UpcXpVoZ7P18GoQmak4/cGpIM1jWay+z6+u6nAjFg
         fVfg6lf5FRlX3McAEGij2P97bnXTQCKyTzbWmWKJ6s9eVUf7d1/5MMyKO1mTotynfcDx
         mHZ1sACu0o5LqiP6HpAG2TNCK4P50KRxpG8PNyXFZ0Kw7Se29F1PB5JNWuGbVbujf+hL
         5a1l5WcS7LnoqL0yM2KU+GKS2sMITi61mSQaQN2sLq/1xU8pKdcKfwrQgwyZGiS/bEI8
         tD9g==
X-Gm-Message-State: AO0yUKV/jk88tYmewX+ezZth2M5x/mr1Qujy+2h/d+47xx6Mplnbvjlq
        lCAEYMukgNkv9MeT0s9Bq5/6lW9+TSmQIQGF
X-Google-Smtp-Source: AK7set8s1u2V5Omf/zqmjQfJZyzGD+4SF47870L6tIZ+6tN3qsgIi5SI+U9rVepLGssWf28uXhPSHg==
X-Received: by 2002:a05:6808:6384:b0:383:c9f8:5613 with SMTP id ec4-20020a056808638400b00383c9f85613mr5822352oib.4.1677287804760;
        Fri, 24 Feb 2023 17:16:44 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:43 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 33/76] ssdfs: create log logic
Date:   Fri, 24 Feb 2023 17:08:44 -0800
Message-Id: <20230225010927.813929-34-slava@dubeyko.com>
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

This patch contains logic of log creation after the log
commit operation or during PEB container object
initialization.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_flush_thread.c | 2710 +++++++++++++++++++++++++++++++++++
 1 file changed, 2710 insertions(+)

diff --git a/fs/ssdfs/peb_flush_thread.c b/fs/ssdfs/peb_flush_thread.c
index 857270e0cbf0..4007cb6ff32d 100644
--- a/fs/ssdfs/peb_flush_thread.c
+++ b/fs/ssdfs/peb_flush_thread.c
@@ -228,6 +228,2716 @@ struct ssdfs_pagevec_descriptor {
  *                         FLUSH THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * __ssdfs_peb_estimate_blk_bmap_bytes() - estimate block bitmap's bytes
+ * @bits_count: bits count in bitmap
+ * @is_migrating: is PEB migrating?
+ */
+static inline
+int __ssdfs_peb_estimate_blk_bmap_bytes(u32 bits_count, bool is_migrating)
+{
+	size_t blk_bmap_hdr_size = sizeof(struct ssdfs_block_bitmap_header);
+	size_t blk_bmap_frag_hdr_size = sizeof(struct ssdfs_block_bitmap_fragment);
+	size_t frag_desc_size = sizeof(struct ssdfs_fragment_desc);
+	size_t blk_bmap_bytes;
+	int reserved_bytes = 0;
+
+	blk_bmap_bytes = BLK_BMAP_BYTES(bits_count);
+
+	reserved_bytes += blk_bmap_hdr_size;
+
+	if (is_migrating) {
+		reserved_bytes += 2 * blk_bmap_frag_hdr_size;
+		reserved_bytes += 2 * frag_desc_size;
+		reserved_bytes += 2 * blk_bmap_bytes;
+	} else {
+		reserved_bytes += blk_bmap_frag_hdr_size;
+		reserved_bytes += frag_desc_size;
+		reserved_bytes += blk_bmap_bytes;
+	}
+
+	return reserved_bytes;
+}
+
+/*
+ * ssdfs_peb_estimate_blk_bmap_bytes() - estimate block bitmap's bytes
+ * @pages_per_peb: number of pages in one PEB
+ * @is_migrating: is PEB migrating?
+ * @prev_log_bmap_bytes: bytes count in block bitmap of previous log
+ */
+static inline
+int ssdfs_peb_estimate_blk_bmap_bytes(u32 pages_per_peb, bool is_migrating,
+				      u32 prev_log_bmap_bytes)
+{
+	int reserved_bytes = 0;
+
+	reserved_bytes = __ssdfs_peb_estimate_blk_bmap_bytes(pages_per_peb,
+							     is_migrating);
+
+	if (prev_log_bmap_bytes < S32_MAX) {
+		reserved_bytes = min_t(int, reserved_bytes,
+					(int)(prev_log_bmap_bytes * 2));
+	}
+
+	return reserved_bytes;
+}
+
+/*
+ * __ssdfs_peb_estimate_blk2off_bytes() - estimate blk2off table's bytes
+ * @items_number: number of allocated logical blocks
+ * @pebs_per_seg: number of PEBs in one segment
+ */
+static inline
+int __ssdfs_peb_estimate_blk2off_bytes(u32 items_number, u32 pebs_per_seg)
+{
+	size_t blk2off_tbl_hdr_size = sizeof(struct ssdfs_blk2off_table_header);
+	size_t pot_tbl_hdr_size = sizeof(struct ssdfs_phys_offset_table_header);
+	size_t phys_off_desc_size = sizeof(struct ssdfs_phys_offset_descriptor);
+	int reserved_bytes = 0;
+
+	reserved_bytes += blk2off_tbl_hdr_size;
+	reserved_bytes += pot_tbl_hdr_size;
+	reserved_bytes += (phys_off_desc_size * items_number) * pebs_per_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_number %u, pebs_per_seg %u, "
+		  "reserved_bytes %d\n",
+		  items_number, pebs_per_seg, reserved_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return reserved_bytes;
+}
+
+/*
+ * ssdfs_peb_estimate_blk2off_bytes() - estimate blk2off table's bytes
+ * @log_pages: number of pages in the full log
+ * @pebs_per_seg: number of PEBs in one segment
+ * @log_start_page: start page of the log
+ * @pages_per_peb: number of pages per PEB
+ */
+static inline
+int ssdfs_peb_estimate_blk2off_bytes(u16 log_pages, u32 pebs_per_seg,
+				     u16 log_start_page, u32 pages_per_peb)
+{
+	u32 items_number;
+
+	items_number = min_t(u32, log_pages - (log_start_page % log_pages),
+				pages_per_peb - log_start_page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_number %u, log_pages %u, "
+		  "pages_per_peb %u, log_start_page %u\n",
+		  items_number, log_pages,
+		  pages_per_peb, log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_peb_estimate_blk2off_bytes(items_number, pebs_per_seg);
+}
+
+/*
+ * __ssdfs_peb_estimate_blk_desc_tbl_bytes() - estimate block desc table's bytes
+ * @items_number: number of allocated logical blocks
+ */
+static inline
+int __ssdfs_peb_estimate_blk_desc_tbl_bytes(u32 items_number)
+{
+	size_t blk_desc_tbl_hdr_size = sizeof(struct ssdfs_area_block_table);
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	int reserved_bytes = 0;
+
+	reserved_bytes += blk_desc_tbl_hdr_size;
+	reserved_bytes += blk_desc_size * items_number;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_number %u, reserved_bytes %d\n",
+		  items_number, reserved_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return reserved_bytes;
+}
+
+/*
+ * ssdfs_peb_estimate_blk_desc_tbl_bytes() - estimate block desc table's bytes
+ * @log_pages: number of pages in the full log
+ * @log_start_page: start page of the log
+ * @pages_per_peb: number of pages per PEB
+ */
+static inline
+int ssdfs_peb_estimate_blk_desc_tbl_bytes(u16 log_pages,
+					  u16 log_start_page,
+					  u32 pages_per_peb)
+{
+	u32 items_number;
+	int reserved_bytes = 0;
+
+	items_number = min_t(u32,
+				log_pages - (log_start_page % log_pages),
+				pages_per_peb - log_start_page);
+
+	reserved_bytes = __ssdfs_peb_estimate_blk_desc_tbl_bytes(items_number);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log_pages %u, log_start_page %u, "
+		  "pages_per_peb %u, items_number %u, "
+		  "reserved_bytes %d\n",
+		  log_pages, log_start_page,
+		  pages_per_peb, items_number,
+		  reserved_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return reserved_bytes;
+}
+
+/*
+ * ssdfs_peb_estimate_reserved_metapages() - estimate reserved metapages in log
+ * @page_size: size of page in bytes
+ * @pages_per_peb: number of pages in one PEB
+ * @log_pages: number of pages in the full log
+ * @pebs_per_seg: number of PEBs in one segment
+ * @is_migrating: is PEB migrating?
+ */
+u16 ssdfs_peb_estimate_reserved_metapages(u32 page_size, u32 pages_per_peb,
+					  u16 log_pages, u32 pebs_per_seg,
+					  bool is_migrating)
+{
+	size_t seg_hdr_size = sizeof(struct ssdfs_segment_header);
+	size_t lf_hdr_size = sizeof(struct ssdfs_log_footer);
+	u32 reserved_bytes = 0;
+	u32 reserved_pages = 0;
+
+	/* segment header */
+	reserved_bytes += seg_hdr_size;
+
+	/* block bitmap */
+	reserved_bytes += ssdfs_peb_estimate_blk_bmap_bytes(pages_per_peb,
+							    is_migrating,
+							    U32_MAX);
+
+	/* blk2off table */
+	reserved_bytes += ssdfs_peb_estimate_blk2off_bytes(log_pages,
+							   pebs_per_seg,
+							   0, pages_per_peb);
+
+	/* block descriptor table */
+	reserved_bytes += ssdfs_peb_estimate_blk_desc_tbl_bytes(log_pages, 0,
+								pages_per_peb);
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+	/* log footer header */
+	reserved_bytes += lf_hdr_size;
+
+	/* block bitmap */
+	reserved_bytes += ssdfs_peb_estimate_blk_bmap_bytes(pages_per_peb,
+							    is_migrating,
+							    U32_MAX);
+
+	/* blk2off table */
+	reserved_bytes += ssdfs_peb_estimate_blk2off_bytes(log_pages,
+							   pebs_per_seg,
+							   0, pages_per_peb);
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+	reserved_pages = reserved_bytes / page_size;
+
+	BUG_ON(reserved_pages >= U16_MAX);
+
+	return reserved_pages;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_reserved_bytes() - calculate block bitmap's reserved bytes
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_peb_blk_bmap_reserved_bytes(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u32 pages_per_peb = fsi->pages_per_peb;
+	bool is_migrating = false;
+	u32 prev_log_bmap_bytes;
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_UNDER_MIGRATION:
+		is_migrating = true;
+		break;
+
+	default:
+		is_migrating = false;
+		break;
+	}
+
+	prev_log_bmap_bytes = pebi->current_log.prev_log_bmap_bytes;
+
+	return ssdfs_peb_estimate_blk_bmap_bytes(pages_per_peb, is_migrating,
+						 prev_log_bmap_bytes);
+}
+
+/*
+ * ssdfs_peb_blk2off_reserved_bytes() - calculate blk2off table's reserved bytes
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_peb_blk2off_reserved_bytes(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u32 pebs_per_seg = fsi->pebs_per_seg;
+	u16 log_pages = pebi->log_pages;
+	u32 pages_per_peb = fsi->pages_per_peb;
+	u16 log_start_page = pebi->current_log.start_page;
+
+	return ssdfs_peb_estimate_blk2off_bytes(log_pages, pebs_per_seg,
+						log_start_page, pages_per_peb);
+}
+
+/*
+ * ssdfs_peb_blk_desc_tbl_reserved_bytes() - calculate block desc reserved bytes
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_peb_blk_desc_tbl_reserved_bytes(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u16 log_pages = pebi->log_pages;
+	u32 pages_per_peb = fsi->pages_per_peb;
+	u16 log_start_page = pebi->current_log.start_page;
+
+	return ssdfs_peb_estimate_blk_desc_tbl_bytes(log_pages,
+						     log_start_page,
+						     pages_per_peb);
+}
+
+/*
+ * ssdfs_peb_log_footer_reserved_bytes() - calculate log footer's reserved bytes
+ * @pebi: pointer on PEB object
+ */
+static inline
+u32 ssdfs_peb_log_footer_reserved_bytes(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	size_t lf_hdr_size = sizeof(struct ssdfs_log_footer);
+	u32 page_size = fsi->pagesize;
+	u32 reserved_bytes = 0;
+
+	/* log footer header */
+	reserved_bytes = lf_hdr_size;
+
+	/* block bitmap */
+	reserved_bytes += atomic_read(&pebi->reserved_bytes.blk_bmap);
+
+	/* blk2off table */
+	reserved_bytes += atomic_read(&pebi->reserved_bytes.blk2off_tbl);
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("block_bitmap %d, blk2off_table %d, "
+		  "reserved_bytes %u\n",
+		  atomic_read(&pebi->reserved_bytes.blk_bmap),
+		  atomic_read(&pebi->reserved_bytes.blk2off_tbl),
+		  reserved_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return reserved_bytes;
+}
+
+/*
+ * ssdfs_peb_log_footer_metapages() - calculate log footer's metadata pages
+ * @pebi: pointer on PEB object
+ */
+static inline
+u32 ssdfs_peb_log_footer_metapages(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u32 page_size = fsi->pagesize;
+	u32 reserved_pages = 0;
+
+	reserved_pages = ssdfs_peb_log_footer_reserved_bytes(pebi) / page_size;
+
+	BUG_ON(reserved_pages >= U16_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_pages %u\n", reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return reserved_pages;
+}
+
+/*
+ * ssdfs_peb_define_reserved_metapages() - calculate reserved metadata pages
+ * @pebi: pointer on PEB object
+ */
+static
+u16 ssdfs_peb_define_reserved_metapages(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u32 reserved_bytes = 0;
+	u32 reserved_pages = 0;
+	size_t seg_hdr_size = sizeof(struct ssdfs_segment_header);
+	u32 page_size = fsi->pagesize;
+	u32 offset;
+	u32 blk_desc_reserved;
+
+	/* segment header */
+	reserved_bytes += seg_hdr_size;
+
+	/* block bitmap */
+	atomic_set(&pebi->reserved_bytes.blk_bmap,
+		   ssdfs_peb_blk_bmap_reserved_bytes(pebi));
+	reserved_bytes += atomic_read(&pebi->reserved_bytes.blk_bmap);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebi->reserved_bytes.blk_bmap %d\n",
+		  atomic_read(&pebi->reserved_bytes.blk_bmap));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/* blk2off table */
+	atomic_set(&pebi->reserved_bytes.blk2off_tbl,
+		   ssdfs_peb_blk2off_reserved_bytes(pebi));
+	reserved_bytes += atomic_read(&pebi->reserved_bytes.blk2off_tbl);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebi->reserved_bytes.blk2off_tbl %d\n",
+		  atomic_read(&pebi->reserved_bytes.blk2off_tbl));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/* block descriptor table */
+	offset = reserved_bytes;
+	blk_desc_reserved = ssdfs_peb_blk_desc_tbl_reserved_bytes(pebi);
+	atomic_set(&pebi->reserved_bytes.blk_desc_tbl, blk_desc_reserved);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebi->reserved_bytes.blk_desc_tbl %d\n",
+		  atomic_read(&pebi->reserved_bytes.blk_desc_tbl));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	reserved_bytes += atomic_read(&pebi->reserved_bytes.blk_desc_tbl);
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_bytes %u, offset %u\n",
+		  reserved_bytes, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	reserved_bytes += ssdfs_peb_log_footer_reserved_bytes(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_bytes %u\n", reserved_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	reserved_pages = reserved_bytes / page_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_pages %u\n", reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(reserved_pages >= U16_MAX);
+
+	return reserved_pages;
+}
+
+/*
+ * ssdfs_peb_reserve_blk_desc_space() - reserve space for block descriptors
+ * @pebi: pointer on PEB object
+ * @metadata: pointer on area's metadata
+ *
+ * This function tries to reserve space for block descriptors.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate the memory.
+ */
+static
+int ssdfs_peb_reserve_blk_desc_space(struct ssdfs_peb_info *pebi,
+				     struct ssdfs_peb_area_metadata *metadata)
+{
+	struct ssdfs_page_array *area_pages;
+	size_t blk_desc_tbl_hdr_size = sizeof(struct ssdfs_area_block_table);
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	size_t count;
+	int buf_size;
+	struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb %llu, current_log.start_page %u\n",
+		  pebi->peb_id, pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	buf_size = atomic_read(&pebi->reserved_bytes.blk_desc_tbl);
+
+	if (buf_size <= blk_desc_tbl_hdr_size) {
+		SSDFS_ERR("invalid reserved_size %d\n",
+			  atomic_read(&pebi->reserved_bytes.blk_desc_tbl));
+		return -ERANGE;
+	}
+
+	buf_size -= blk_desc_tbl_hdr_size;
+
+	if (buf_size < blk_desc_size) {
+		SSDFS_ERR("invalid reserved_size %d\n",
+			  buf_size);
+		return -ERANGE;
+	}
+
+	count = buf_size / blk_desc_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("buf_size %d, blk_desc_size %zu, count %zu\n",
+		  buf_size, blk_desc_size, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area_pages = &pebi->current_log.area[SSDFS_LOG_BLK_DESC_AREA].array;
+
+	page = ssdfs_page_array_grab_page(area_pages, 0);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to add page into area space\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_memzero_page(page, 0, PAGE_SIZE, PAGE_SIZE);
+
+	ssdfs_set_page_private(page, 0);
+	ssdfs_put_page(page);
+	ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	metadata->area.blk_desc.items_count = 0;
+	metadata->area.blk_desc.capacity = count;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_estimate_min_partial_log_pages() - estimate min partial log size
+ * @pebi: pointer on PEB object
+ */
+u16 ssdfs_peb_estimate_min_partial_log_pages(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_container *pebc = pebi->pebc;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u32 reserved_bytes = 0;
+	u32 reserved_pages = 0;
+	size_t pl_hdr_size = sizeof(struct ssdfs_partial_log_header);
+	u32 page_size = fsi->pagesize;
+	size_t lf_hdr_size = sizeof(struct ssdfs_log_footer);
+
+	/* partial log header */
+	reserved_bytes += pl_hdr_size;
+
+	/* block bitmap */
+	reserved_bytes += ssdfs_peb_blk_bmap_reserved_bytes(pebi);
+
+	/* blk2off table */
+	reserved_bytes += ssdfs_peb_blk2off_reserved_bytes(pebi);
+
+	/* block descriptor table */
+	reserved_bytes += ssdfs_peb_blk_desc_tbl_reserved_bytes(pebi);
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+	/* log footer header */
+	reserved_bytes += lf_hdr_size;
+
+	/* block bitmap */
+	reserved_bytes += ssdfs_peb_blk_bmap_reserved_bytes(pebi);
+
+	/* blk2off table */
+	reserved_bytes += ssdfs_peb_blk2off_reserved_bytes(pebi);
+
+	reserved_bytes += page_size - 1;
+	reserved_bytes /= page_size;
+	reserved_bytes *= page_size;
+
+	reserved_pages = reserved_bytes / page_size;
+
+	BUG_ON(reserved_pages >= U16_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_pages %u, reserved_bytes %u, "
+		  "blk_bmap_reserved_bytes %d, "
+		  "blk2off_reserved_bytes %d, "
+		  "blk_desc_tbl_reserved_bytes %d\n",
+		  reserved_pages, reserved_bytes,
+		  ssdfs_peb_blk_bmap_reserved_bytes(pebi),
+		  ssdfs_peb_blk2off_reserved_bytes(pebi),
+		  ssdfs_peb_blk_desc_tbl_reserved_bytes(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return reserved_pages;
+}
+
+enum {
+	SSDFS_START_FULL_LOG,
+	SSDFS_START_PARTIAL_LOG,
+	SSDFS_CONTINUE_PARTIAL_LOG,
+	SSDFS_FINISH_PARTIAL_LOG,
+	SSDFS_FINISH_FULL_LOG
+};
+
+/*
+ * is_log_partial() - should the next log be partial?
+ * @pebi: pointer on PEB object
+ */
+static inline
+int is_log_partial(struct ssdfs_peb_info *pebi)
+{
+	u16 log_pages;
+	u16 free_data_pages;
+	u16 reserved_pages;
+	u16 min_partial_log_pages;
+	int sequence_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_pages = pebi->log_pages;
+	free_data_pages = pebi->current_log.free_data_pages;
+	reserved_pages = pebi->current_log.reserved_pages;
+	sequence_id = atomic_read(&pebi->current_log.sequence_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log_pages %u, free_data_pages %u, "
+		  "reserved_pages %u, sequence_id %d\n",
+		  log_pages, free_data_pages,
+		  reserved_pages, sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (free_data_pages == 0) {
+		if (sequence_id > 0)
+			return SSDFS_FINISH_PARTIAL_LOG;
+		else
+			return SSDFS_FINISH_FULL_LOG;
+	}
+
+	if (free_data_pages >= log_pages)
+		return SSDFS_START_FULL_LOG;
+
+	min_partial_log_pages = ssdfs_peb_estimate_min_partial_log_pages(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("min_partial_log_pages %u, reserved_pages %u\n",
+		  min_partial_log_pages, reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (reserved_pages == 0) {
+		if (free_data_pages <= min_partial_log_pages) {
+			if (sequence_id > 0)
+				return SSDFS_FINISH_PARTIAL_LOG;
+			else
+				return SSDFS_FINISH_FULL_LOG;
+		}
+	} else {
+		u32 available_pages = free_data_pages + reserved_pages;
+
+		if (available_pages <= min_partial_log_pages) {
+			if (sequence_id > 0)
+				return SSDFS_FINISH_PARTIAL_LOG;
+			else
+				return SSDFS_FINISH_FULL_LOG;
+		} else if (free_data_pages < min_partial_log_pages) {
+			/*
+			 * Next partial log cannot be created
+			 */
+			if (sequence_id > 0)
+				return SSDFS_FINISH_PARTIAL_LOG;
+			else
+				return SSDFS_FINISH_FULL_LOG;
+		}
+	}
+
+	if (sequence_id == 0)
+		return SSDFS_START_PARTIAL_LOG;
+
+	return SSDFS_CONTINUE_PARTIAL_LOG;
+}
+
+/*
+ * ssdfs_peb_create_log() - create new log
+ * @pebi: pointer on PEB object
+ *
+ * This function tries to create new log in page cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - PEB is full.
+ * %-EIO        - area contain dirty (not committed) pages.
+ * %-EAGAIN     - current log is not initialized.
+ */
+static
+int ssdfs_peb_create_log(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_log *log;
+	struct ssdfs_metadata_options *options;
+	int log_state;
+	int log_strategy;
+	u32 pages_per_peb;
+	u32 log_footer_pages;
+	int compr_type;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebi->pebc->parent_si;
+	log_state = atomic_read(&pebi->current_log.state);
+
+	switch (log_state) {
+	case SSDFS_LOG_UNKNOWN:
+	case SSDFS_LOG_PREPARED:
+		SSDFS_ERR("peb %llu current log is not initialized\n",
+			  pebi->peb_id);
+		return -ERANGE;
+
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_COMMITTED:
+		/* do function's work */
+		break;
+
+	case SSDFS_LOG_CREATED:
+		SSDFS_WARN("peb %llu current log is not initialized\n",
+			   pebi->peb_id);
+		return -ERANGE;
+
+	default:
+		BUG();
+	};
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb %llu, current_log.start_page %u\n",
+		  si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#else
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u\n",
+		  si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_peb_current_log_lock(pebi);
+
+	log = &pebi->current_log;
+	pages_per_peb = min_t(u32, si->fsi->leb_pages_capacity,
+				   si->fsi->peb_pages_capacity);
+
+	/*
+	 * Start page of the next log should be defined during commit.
+	 * It needs to check this value here only.
+	 */
+
+	if (log->start_page >= pages_per_peb) {
+		SSDFS_ERR("current_log.start_page %u >= pages_per_peb %u\n",
+			  log->start_page, pages_per_peb);
+		err = -ENOSPC;
+		goto finish_log_create;
+	}
+
+	log_strategy = is_log_partial(pebi);
+
+	switch (log_strategy) {
+	case SSDFS_START_FULL_LOG:
+		if ((log->start_page + log->free_data_pages) % pebi->log_pages) {
+			SSDFS_WARN("unexpected state: "
+				   "log->start_page %u, "
+				   "log->free_data_pages %u, "
+				   "pebi->log_pages %u\n",
+				   log->start_page,
+				   log->free_data_pages,
+				   pebi->log_pages);
+		}
+
+		log->reserved_pages = ssdfs_peb_define_reserved_metapages(pebi);
+		break;
+
+	case SSDFS_START_PARTIAL_LOG:
+		log->reserved_pages = ssdfs_peb_define_reserved_metapages(pebi);
+		break;
+
+	case SSDFS_CONTINUE_PARTIAL_LOG:
+		log->reserved_pages = ssdfs_peb_define_reserved_metapages(pebi);
+		log_footer_pages = ssdfs_peb_log_footer_metapages(pebi);
+		log->reserved_pages -= log_footer_pages;
+		break;
+
+	case SSDFS_FINISH_PARTIAL_LOG:
+	case SSDFS_FINISH_FULL_LOG:
+		if (log->free_data_pages == 0) {
+			err = -ENOSPC;
+			SSDFS_ERR("seg %llu, peb %llu, "
+				  "start_page %u, free_data_pages %u\n",
+				  si->seg_id, pebi->peb_id,
+				  log->start_page, log->free_data_pages);
+			goto finish_log_create;
+		} else {
+			log->reserved_pages =
+				ssdfs_peb_define_reserved_metapages(pebi);
+			log_footer_pages =
+				ssdfs_peb_log_footer_metapages(pebi);
+			/*
+			 * The reserved pages imply presence of header
+			 * and footer. However, it needs to add the page
+			 * for data itself. If header's page is able
+			 * to keep the data too then footer will be in
+			 * the log. Otherwise, footer will be absent.
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("log_footer_pages %u, log->reserved_pages %u\n",
+				  log_footer_pages, log->reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			log->free_data_pages += log_footer_pages;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_CRIT("unexpected log strategy %#x\n",
+			   log_strategy);
+		goto finish_log_create;
+	}
+
+	if (log->free_data_pages < log->reserved_pages) {
+		err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log->free_data_pages %u < log->reserved_pages %u\n",
+			  log->free_data_pages, log->reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_log_create;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log_strategy %#x, free_data_pages %u, reserved_pages %u\n",
+		  log_strategy, log->free_data_pages, log->reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_segment_blk_bmap_reserve_metapages(&si->blk_bmap,
+							pebi->pebc,
+							log->reserved_pages);
+	if (err == -ENOSPC) {
+		/*
+		 * The goal of reservation is to decrease the number of
+		 * free logical blocks because some PEB's space is used
+		 * for the metadata. Such decreasing prevents from
+		 * allocation of logical blocks out of physically
+		 * available space in the PEB. However, if no space
+		 * for reservation but there are some physical pages
+		 * for logs creation then the operation of reservation
+		 * can be simply ignored. Because, current log's
+		 * metadata structure manages the real available
+		 * space in the PEB.
+		 */
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve metadata pages: "
+			  "count %u, err %d\n",
+			  log->reserved_pages, err);
+		goto finish_log_create;
+	}
+
+	log->free_data_pages -= log->reserved_pages;
+	pebi->current_log.seg_flags = 0;
+
+	for (i = 0; i < SSDFS_LOG_AREA_MAX; i++) {
+		struct ssdfs_peb_area *area;
+		struct ssdfs_page_array *area_pages;
+		struct ssdfs_peb_area_metadata *metadata;
+		struct ssdfs_fragments_chain_header *chain_hdr;
+		size_t metadata_size = sizeof(struct ssdfs_peb_area_metadata);
+		size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+		size_t desc_size = sizeof(struct ssdfs_fragment_desc);
+
+		area = &pebi->current_log.area[i];
+		area_pages = &area->array;
+
+		if (atomic_read(&area_pages->state) == SSDFS_PAGE_ARRAY_DIRTY) {
+			/*
+			 * It needs to repeat the commit.
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB %llu is dirty on log creation\n",
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			err = ssdfs_page_array_release_all_pages(area_pages);
+			if (unlikely(err)) {
+				ssdfs_fs_error(si->fsi->sb,
+						__FILE__, __func__, __LINE__,
+						"fail to release pages: "
+						"PEB %llu\n",
+						pebi->peb_id);
+				err = -EIO;
+				goto finish_log_create;
+			}
+		}
+
+		metadata = &area->metadata;
+
+		switch (i) {
+		case SSDFS_LOG_BLK_DESC_AREA:
+			memset(&metadata->area.blk_desc.table,
+			       0, sizeof(struct ssdfs_area_block_table));
+			chain_hdr = &metadata->area.blk_desc.table.chain_hdr;
+			chain_hdr->desc_size = cpu_to_le16(desc_size);
+			chain_hdr->magic = SSDFS_CHAIN_HDR_MAGIC;
+
+			options = &si->fsi->metadata_options;
+			compr_type = options->blk2off_tbl.compression;
+
+			switch (compr_type) {
+			case SSDFS_BLK2OFF_TBL_NOCOMPR_TYPE:
+				chain_hdr->type = SSDFS_BLK_DESC_CHAIN_HDR;
+				break;
+			case SSDFS_BLK2OFF_TBL_ZLIB_COMPR_TYPE:
+				chain_hdr->type = SSDFS_BLK_DESC_ZLIB_CHAIN_HDR;
+				break;
+			case SSDFS_BLK2OFF_TBL_LZO_COMPR_TYPE:
+				chain_hdr->type = SSDFS_BLK_DESC_LZO_CHAIN_HDR;
+				break;
+			default:
+				BUG();
+			}
+
+			area->has_metadata = true;
+			area->write_offset = blk_table_size;
+			area->compressed_offset = blk_table_size;
+			metadata->area.blk_desc.capacity = 0;
+			metadata->area.blk_desc.items_count = 0;
+			metadata->reserved_offset = 0;
+			metadata->sequence_id = 0;
+
+			err = ssdfs_peb_reserve_blk_desc_space(pebi, metadata);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to reserve blk desc space: "
+					  "err %d\n", err);
+				goto finish_log_create;
+			}
+			break;
+
+		case SSDFS_LOG_DIFFS_AREA:
+			memset(metadata, 0, metadata_size);
+			chain_hdr = &metadata->area.diffs.table.hdr.chain_hdr;
+			chain_hdr->desc_size = cpu_to_le16(desc_size);
+			chain_hdr->magic = SSDFS_CHAIN_HDR_MAGIC;
+			chain_hdr->type = SSDFS_BLK_STATE_CHAIN_HDR;
+			area->has_metadata = false;
+			area->write_offset = 0;
+			area->metadata.reserved_offset = 0;
+			break;
+
+		case SSDFS_LOG_JOURNAL_AREA:
+			memset(metadata, 0, metadata_size);
+			chain_hdr = &metadata->area.journal.table.hdr.chain_hdr;
+			chain_hdr->desc_size = cpu_to_le16(desc_size);
+			chain_hdr->magic = SSDFS_CHAIN_HDR_MAGIC;
+			chain_hdr->type = SSDFS_BLK_STATE_CHAIN_HDR;
+			area->has_metadata = false;
+			area->write_offset = 0;
+			area->metadata.reserved_offset = 0;
+			break;
+
+		case SSDFS_LOG_MAIN_AREA:
+			memset(metadata, 0, metadata_size);
+			area->has_metadata = false;
+			area->write_offset = 0;
+			area->metadata.reserved_offset = 0;
+			break;
+
+		default:
+			BUG();
+		};
+	}
+
+	ssdfs_peb_set_current_log_state(pebi, SSDFS_LOG_CREATED);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("log created: "
+		  "seg %llu, peb %llu, "
+		  "current_log.start_page %u, free_data_pages %u\n",
+		  si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  log->free_data_pages);
+#else
+	SSDFS_DBG("log created: "
+		  "seg %llu, peb %llu, "
+		  "current_log.start_page %u, free_data_pages %u\n",
+		  si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  log->free_data_pages);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+finish_log_create:
+	ssdfs_peb_current_log_unlock(pebi);
+	return err;
+}
+
+/*
+ * ssdfs_peb_grow_log_area() - grow log's area
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @fragment_size: size of fragment
+ *
+ * This function tries to add memory page into log's area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - log is full.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_grow_log_area(struct ssdfs_peb_info *pebi, int area_type,
+			    u32 fragment_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_page_array *area_pages;
+	u32 write_offset;
+	pgoff_t index_start, index_end;
+	struct page *page;
+	u16 metadata_pages = 0;
+	u16 free_data_pages;
+	u16 reserved_pages;
+	int phys_pages = 0;
+	int log_strategy;
+	u32 min_log_pages;
+	u32 footer_pages;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("peb %llu, current_log.free_data_pages %u, "
+		  "area_type %#x, area.write_offset %u, "
+		  "fragment_size %u\n",
+		  pebi->peb_id,
+		  pebi->current_log.free_data_pages,
+		  area_type,
+		  pebi->current_log.area[area_type].write_offset,
+		  fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	si = pebi->pebc->parent_si;
+	area_pages = &pebi->current_log.area[area_type].array;
+
+	write_offset = pebi->current_log.area[area_type].write_offset;
+
+	BUG_ON(fragment_size > (2 * PAGE_SIZE));
+
+	index_start = (((write_offset >> fsi->log_pagesize) <<
+			fsi->log_pagesize) >> PAGE_SHIFT);
+
+	if (fsi->pagesize > PAGE_SIZE) {
+		index_end = write_offset + fragment_size + fsi->pagesize - 1;
+		index_end >>= fsi->log_pagesize;
+		index_end <<= fsi->log_pagesize;
+		index_end >>= PAGE_SHIFT;
+	} else {
+		index_end = write_offset + fragment_size + PAGE_SIZE - 1;
+		index_end >>= PAGE_SHIFT;
+	}
+
+	do {
+		page = ssdfs_page_array_get_page(area_pages, index_start);
+		if (IS_ERR_OR_NULL(page))
+			break;
+		else {
+			index_start++;
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	} while (index_start < index_end);
+
+	if (index_start >= index_end) {
+		SSDFS_DBG("log doesn't need to grow\n");
+		return 0;
+	}
+
+	phys_pages = index_end - index_start;
+
+	if (fsi->pagesize > PAGE_SIZE) {
+		phys_pages >>= fsi->log_pagesize - PAGE_SHIFT;
+		if (phys_pages == 0)
+			phys_pages = 1;
+	} else if (fsi->pagesize < PAGE_SIZE)
+		phys_pages <<= PAGE_SHIFT - fsi->log_pagesize;
+
+	log_strategy = is_log_partial(pebi);
+	free_data_pages = pebi->current_log.free_data_pages;
+	reserved_pages = pebi->current_log.reserved_pages;
+	min_log_pages = ssdfs_peb_estimate_min_partial_log_pages(pebi);
+	footer_pages = ssdfs_peb_log_footer_metapages(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("min_log_pages %u, footer_pages %u, "
+		  "log_strategy %#x, free_data_pages %u, "
+		  "reserved_pages %u\n",
+		  min_log_pages, footer_pages,
+		  log_strategy, free_data_pages,
+		  reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (phys_pages <= free_data_pages) {
+		/*
+		 * Continue logic.
+		 */
+	} else if (phys_pages <= (free_data_pages + footer_pages) &&
+		   reserved_pages >= min_log_pages) {
+		switch (log_strategy) {
+		case SSDFS_START_FULL_LOG:
+		case SSDFS_FINISH_FULL_LOG:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("new_page_count %u > free_data_pages %u\n",
+				  phys_pages,
+				  pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+
+		case SSDFS_START_PARTIAL_LOG:
+			pebi->current_log.free_data_pages += footer_pages;
+			pebi->current_log.reserved_pages -= footer_pages;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("use footer page for data: "
+				  "free_data_pages %u, reserved_pages %u\n",
+				  pebi->current_log.free_data_pages,
+				  pebi->current_log.reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		case SSDFS_CONTINUE_PARTIAL_LOG:
+		case SSDFS_FINISH_PARTIAL_LOG:
+			/* no free space available */
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("new_page_count %u > free_data_pages %u\n",
+				  phys_pages,
+				  pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("new_page_count %u > free_data_pages %u\n",
+			  phys_pages,
+			  pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	for (; index_start < index_end; index_start++) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %lu, current_log.free_data_pages %u\n",
+			  index_start, pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = ssdfs_page_array_grab_page(area_pages, index_start);
+		if (IS_ERR_OR_NULL(page)) {
+			SSDFS_ERR("fail to add page %lu into area %#x space\n",
+				  index_start, area_type);
+			return -ENOMEM;
+		}
+
+		ssdfs_memzero_page(page, 0, PAGE_SIZE, PAGE_SIZE);
+
+		ssdfs_set_page_private(page, 0);
+		ssdfs_put_page(page);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	pebi->current_log.free_data_pages -= phys_pages;
+
+	if (area_type == SSDFS_LOG_BLK_DESC_AREA)
+		metadata_pages = phys_pages;
+
+	if (metadata_pages > 0) {
+		err = ssdfs_segment_blk_bmap_reserve_metapages(&si->blk_bmap,
+								pebi->pebc,
+								metadata_pages);
+		if (err == -ENOSPC) {
+			/*
+			 * The goal of reservation is to decrease the number of
+			 * free logical blocks because some PEB's space is used
+			 * for the metadata. Such decreasing prevents from
+			 * allocation of logical blocks out of physically
+			 * available space in the PEB. However, if no space
+			 * for reservation but there are some physical pages
+			 * for logs creation then the operation of reservation
+			 * can be simply ignored. Because, current log's
+			 * metadata structure manages the real available
+			 * space in the PEB.
+			 */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to reserve metadata pages: "
+				  "count %u, err %d\n",
+				  metadata_pages, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_fragment() - store fragment into page cache
+ * @from: fragment source descriptor
+ * @to: fragment destination descriptor [in|out]
+ *
+ * This function tries to store fragment into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fail to store fragment into available space.
+ */
+static
+int ssdfs_peb_store_fragment(struct ssdfs_fragment_source *from,
+			     struct ssdfs_fragment_destination *to)
+{
+	int compr_type;
+	unsigned char *src;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!from || !to);
+	BUG_ON(!from->page || !to->store || !to->desc);
+	BUG_ON((from->start_offset + from->data_bytes) > PAGE_SIZE);
+	BUG_ON(from->fragment_type <= SSDFS_UNKNOWN_FRAGMENT_TYPE ||
+		from->fragment_type >= SSDFS_FRAGMENT_DESC_MAX_TYPE);
+	BUG_ON(from->fragment_flags & ~SSDFS_FRAGMENT_DESC_FLAGS_MASK);
+	BUG_ON(to->free_space > PAGE_SIZE);
+
+	SSDFS_DBG("page %p, start_offset %u, data_bytes %zu, "
+		  "sequence_id %u, fragment_type %#x, fragment_flags %#x, "
+		  "write_offset %u, store %p, free_space %zu\n",
+		  from->page, from->start_offset, from->data_bytes,
+		  from->sequence_id, from->fragment_type,
+		  from->fragment_flags,
+		  to->write_offset, to->store, to->free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (from->data_bytes == 0) {
+		SSDFS_WARN("from->data_bytes == 0\n");
+		return 0;
+	}
+
+	if (to->free_space == 0) {
+		SSDFS_WARN("to->free_space is not enough\n");
+		return -EAGAIN;
+	}
+
+	switch (from->fragment_type) {
+	case SSDFS_FRAGMENT_UNCOMPR_BLOB:
+		compr_type = SSDFS_COMPR_NONE;
+		break;
+	case SSDFS_FRAGMENT_ZLIB_BLOB:
+		compr_type = SSDFS_COMPR_ZLIB;
+		break;
+	case SSDFS_FRAGMENT_LZO_BLOB:
+		compr_type = SSDFS_COMPR_LZO;
+		break;
+	default:
+		BUG();
+	};
+
+	if (!ssdfs_can_compress_data(from->page, from->data_bytes)) {
+		compr_type = SSDFS_COMPR_NONE;
+		from->fragment_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+	}
+
+	to->compr_size = to->free_space;
+
+	src = kmap_local_page(from->page);
+	src += from->start_offset;
+	to->desc->checksum = ssdfs_crc32_le(src, from->data_bytes);
+	err = ssdfs_compress(compr_type, src, to->store,
+			     &from->data_bytes, &to->compr_size);
+	kunmap_local(src);
+
+	if (err == -E2BIG || err == -EOPNOTSUPP) {
+		BUG_ON(from->data_bytes > PAGE_SIZE);
+		BUG_ON(from->data_bytes > to->free_space);
+
+		from->fragment_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+
+		src = kmap_local_page(from->page);
+		err = ssdfs_memcpy(to->store, 0, to->free_space,
+				   src, from->start_offset, PAGE_SIZE,
+				   from->data_bytes);
+		kunmap_local(src);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			return err;
+		}
+
+		to->compr_size = from->data_bytes;
+	} else if (err) {
+		SSDFS_ERR("fail to compress fragment: "
+			  "data_bytes %zu, free_space %zu, err %d\n",
+			  from->data_bytes, to->free_space, err);
+		return err;
+	}
+
+	BUG_ON(to->area_offset > to->write_offset);
+	to->desc->offset = cpu_to_le32(to->write_offset - to->area_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(to->compr_size > U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	to->desc->compr_size = cpu_to_le16((u16)to->compr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(from->data_bytes > U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	to->desc->uncompr_size = cpu_to_le16((u16)from->data_bytes);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(from->sequence_id >= U8_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	to->desc->sequence_id = from->sequence_id;
+	to->desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+	to->desc->type = from->fragment_type;
+	to->desc->flags = from->fragment_flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("offset %u, compr_size %u, "
+		  "uncompr_size %u, checksum %#x\n",
+		  to->desc->offset,
+		  to->desc->compr_size,
+		  to->desc->uncompr_size,
+		  le32_to_cpu(to->desc->checksum));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_stream_fragments_count() - calculate fragments count
+ * @start_offset: offset byte stream in bytes
+ * @data_bytes: size of stream in bytes
+ *
+ * This function calculates count of fragments of byte stream.
+ * The byte stream is part of memory page or it can be distributed
+ * between several memory pages. One fragment can't be greater
+ * than memory page (PAGE_SIZE) in bytes. Logic of this
+ * function calculates count of parts are divided between
+ * memory pages.
+ */
+static inline
+u16 ssdfs_define_stream_fragments_count(u32 start_offset,
+					u32 data_bytes)
+{
+	u16 count = 0;
+	u32 partial_offset;
+	u32 front_part;
+
+	if (data_bytes == 0)
+		return 0;
+
+	partial_offset = start_offset % PAGE_SIZE;
+	front_part = PAGE_SIZE - partial_offset;
+	front_part = min_t(u32, front_part, data_bytes);
+
+	if (front_part < data_bytes) {
+		count++;
+		data_bytes -= front_part;
+	}
+
+	count += (data_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	return count;
+}
+
+/*
+ * ssdfs_peb_store_data_block_fragment() - store data block's fragment
+ * @pebi: pointer on PEB object
+ * @from: fragment source descriptor
+ * @write_offset: write offset
+ * @type: area type
+ * @desc: pointer on fragment descriptor
+ *
+ * This function tries to store data block's fragment into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - fail to get memory page.
+ * %-EAGAIN     - unable to store data fragment.
+ */
+static
+int ssdfs_peb_store_data_block_fragment(struct ssdfs_peb_info *pebi,
+					struct ssdfs_fragment_source *from,
+					u32 write_offset,
+					int type,
+					struct ssdfs_fragment_desc *desc)
+{
+	struct ssdfs_fragment_destination to;
+	struct page *page;
+	pgoff_t page_index;
+	u32 offset;
+	u32 written_bytes = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !from);
+	BUG_ON(type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("from->page %p, from->start_offset %u, "
+		  "from->data_bytes %zu, from->sequence_id %u, "
+		  "write_offset %u, type %#x\n",
+		  from->page, from->start_offset, from->data_bytes,
+		  from->sequence_id, write_offset, type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	to.area_offset = 0;
+	to.write_offset = write_offset;
+
+	to.store = ssdfs_flush_kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!to.store) {
+		SSDFS_ERR("fail to allocate buffer for fragment\n");
+		return -ENOMEM;
+	}
+
+	to.free_space = PAGE_SIZE;
+	to.compr_size = 0;
+	to.desc = desc;
+
+	err = ssdfs_peb_store_fragment(from, &to);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to store data fragment: "
+			  "write_offset %u, dst_free_space %zu\n",
+			  write_offset, to.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto free_compr_buffer;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to store fragment: "
+			  "sequence_id %u, write_offset %u, err %d\n",
+			  from->sequence_id, write_offset, err);
+		goto free_compr_buffer;
+	}
+
+	BUG_ON(to.compr_size == 0);
+
+	do {
+		struct ssdfs_page_array *area_pages;
+		u32 size;
+
+		page_index = to.write_offset + written_bytes;
+		page_index >>= PAGE_SHIFT;
+
+		area_pages = &pebi->current_log.area[type].array;
+		page = ssdfs_page_array_get_page_locked(area_pages,
+							page_index);
+		if (IS_ERR_OR_NULL(page)) {
+			err = page == NULL ? -ERANGE : PTR_ERR(page);
+
+			if (err == -ENOENT) {
+				err = ssdfs_peb_grow_log_area(pebi, type,
+							from->data_bytes);
+				if (err == -ENOSPC) {
+					err = -EAGAIN;
+					SSDFS_DBG("log is full\n");
+					goto free_compr_buffer;
+				} else if (unlikely(err)) {
+					SSDFS_ERR("fail to grow log area: "
+						  "type %#x, err %d\n",
+						  type, err);
+					goto free_compr_buffer;
+				}
+			} else {
+				SSDFS_ERR("fail to get page: "
+					  "index %lu for area %#x\n",
+					  page_index, type);
+				goto free_compr_buffer;
+			}
+
+			/* try to get page again */
+			page = ssdfs_page_array_get_page_locked(area_pages,
+								page_index);
+			if (IS_ERR_OR_NULL(page)) {
+				err = page == NULL ? -ERANGE : PTR_ERR(page);
+				SSDFS_ERR("fail to get page: "
+					  "index %lu for area %#x\n",
+					  page_index, type);
+				goto free_compr_buffer;
+			}
+		}
+
+		offset = to.write_offset + written_bytes;
+		offset %= PAGE_SIZE;
+		size = PAGE_SIZE - offset;
+		size = min_t(u32, size, to.compr_size - written_bytes);
+
+		err = ssdfs_memcpy_to_page(page,
+					   offset, PAGE_SIZE,
+					   to.store,
+					   written_bytes, to.free_space,
+					   size);
+		if (unlikely(err)) {
+			SSDFS_ERR("failt to copy: err %d\n", err);
+			goto finish_copy;
+		}
+
+		SetPageUptodate(page);
+		err = ssdfs_page_array_set_page_dirty(area_pages,
+						      page_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: "
+				  "err %d\n",
+				  page_index, err);
+		}
+
+finish_copy:
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err)
+			goto free_compr_buffer;
+
+		written_bytes += size;
+	} while (written_bytes < to.compr_size);
+
+free_compr_buffer:
+	ssdfs_flush_kfree(to.store);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_store_block_state_desc() - store block state descriptor
+ * @pebi: pointer on PEB object
+ * @write_offset: write offset
+ * @type: area type
+ * @desc: pointer on block state descriptor
+ * @array: fragment descriptors array
+ * @array_size: number of items in array
+ *
+ * This function tries to store block state descriptor into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - fail to get memory page.
+ */
+static
+int ssdfs_peb_store_block_state_desc(struct ssdfs_peb_info *pebi,
+				    u32 write_offset,
+				    int type,
+				    struct ssdfs_block_state_descriptor *desc,
+				    struct ssdfs_fragment_desc *array,
+				    u32 array_size)
+{
+	struct ssdfs_page_array *area_pages;
+	struct page *page;
+	pgoff_t page_index;
+	unsigned char *kaddr;
+	u32 page_off;
+	size_t desc_size = sizeof(struct ssdfs_block_state_descriptor);
+	size_t table_size = sizeof(struct ssdfs_fragment_desc) * array_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!desc || !array);
+	BUG_ON(array_size == 0);
+	BUG_ON(type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("write_offset %u, type %#x, desc %p, "
+		  "array %p, array_size %u\n",
+		  write_offset, type, desc, array, array_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = write_offset / PAGE_SIZE;
+	area_pages = &pebi->current_log.area[type].array;
+
+	page = ssdfs_page_array_get_page_locked(area_pages, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to get page %lu for area %#x\n",
+			  page_index, type);
+		return err;
+	}
+
+	page_off = write_offset % PAGE_SIZE;
+
+	kaddr = kmap_local_page(page);
+
+	err = ssdfs_memcpy(kaddr, page_off, PAGE_SIZE,
+			   desc, 0, desc_size,
+			   desc_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto fail_copy;
+	}
+
+	err = ssdfs_memcpy(kaddr, page_off + desc_size, PAGE_SIZE,
+			   array, 0, table_size,
+			   table_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto fail_copy;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u, page_off %u, "
+		  "desc_size %zu, table_size %zu\n",
+		  write_offset, page_off, desc_size, table_size);
+	SSDFS_DBG("BLOCK STATE DESC AREA DUMP:\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr, PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+fail_copy:
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+
+	if (unlikely(err))
+		goto finish_copy;
+
+	SetPageUptodate(page);
+
+	err = ssdfs_page_array_set_page_dirty(area_pages,
+					      page_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu dirty: "
+			  "err %d\n",
+			  page_index, err);
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
+	return err;
+}
+
+/*
+ * ssdfs_peb_store_byte_stream_in_main_area() - store byte stream into main area
+ * @pebi: pointer on PEB object
+ * @stream: byte stream descriptor
+ * @cno: checkpoint
+ * @parent_snapshot: parent snapshot number
+ *
+ * This function tries to store store data block of some size
+ * from pagevec into main area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_byte_stream_in_main_area(struct ssdfs_peb_info *pebi,
+				struct ssdfs_byte_stream_descriptor *stream,
+				u64 cno,
+				u64 parent_snapshot)
+{
+	struct ssdfs_peb_area *area;
+	int area_type = SSDFS_LOG_MAIN_AREA;
+	struct ssdfs_fragment_desc cur_desc = {0};
+	int start_page, page_index;
+	u16 fragments;
+	u32 written_bytes = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !stream);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!stream->pvec);
+	BUG_ON(pagevec_count(stream->pvec) == 0);
+	BUG_ON((pagevec_count(stream->pvec) * PAGE_SIZE) <
+		(stream->start_offset + stream->data_bytes));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "write_offset %u, "
+		  "stream->start_offset %u, stream->data_bytes %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.area[area_type].write_offset,
+		  stream->start_offset, stream->data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area = &pebi->current_log.area[area_type];
+
+	fragments = ssdfs_define_stream_fragments_count(stream->start_offset,
+							stream->data_bytes);
+	if (fragments == 0) {
+		SSDFS_ERR("invalid fragments count %u\n", fragments);
+		return -ERANGE;
+	}
+
+	start_page = stream->start_offset >> PAGE_SHIFT;
+
+	if ((start_page + fragments) > pagevec_count(stream->pvec)) {
+		SSDFS_ERR("start_page %d + fragments %u > pagevec_count %u\n",
+			  start_page, fragments, pagevec_count(stream->pvec));
+		err = -ERANGE;
+		goto finish_store_byte_stream;
+	}
+
+	stream->write_offset = area->write_offset;
+
+	for (page_index = 0; page_index < fragments; page_index++) {
+		int i = start_page + page_index;
+		struct ssdfs_fragment_source from;
+		u32 write_offset;
+
+		if (written_bytes >= stream->data_bytes) {
+			SSDFS_ERR("written_bytes %u >= data_bytes %u\n",
+				  written_bytes, stream->data_bytes);
+			err = -ERANGE;
+			goto finish_store_byte_stream;
+		}
+
+		from.page = stream->pvec->pages[i];
+		from.start_offset = (stream->start_offset + written_bytes) %
+					PAGE_SIZE;
+		from.data_bytes = min_t(u32, PAGE_SIZE,
+					stream->data_bytes - written_bytes);
+		from.sequence_id = page_index;
+
+		from.fragment_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+		from.fragment_flags = 0;
+
+try_get_next_page:
+		write_offset = area->write_offset;
+		err = ssdfs_peb_store_data_block_fragment(pebi, &from,
+							  write_offset,
+							  area_type,
+							  &cur_desc);
+
+		if (err == -EAGAIN) {
+			u32 page_off = write_offset % PAGE_SIZE;
+			u32 rest = PAGE_SIZE - page_off;
+
+			if (page_off == 0)
+				goto finish_store_byte_stream;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try to get next page: "
+				  "write_offset %u, free_space %u\n",
+				  write_offset, rest);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			pebi->current_log.area[area_type].write_offset += rest;
+			goto try_get_next_page;
+		}
+
+		if (err) {
+			SSDFS_ERR("fail to store fragment: "
+				  "sequence_id %u, write_offset %u, err %d\n",
+				  from.sequence_id,
+				  area->write_offset,
+				  err);
+			goto finish_store_byte_stream;
+		}
+
+		written_bytes += from.data_bytes;
+		area->write_offset += le16_to_cpu(cur_desc.compr_size);
+	}
+
+	stream->compr_bytes = area->write_offset;
+
+finish_store_byte_stream:
+	if (err)
+		area->write_offset = 0;
+
+	return err;
+}
+
+static
+int ssdfs_peb_define_metadata_space(struct ssdfs_peb_info *pebi,
+				    int area_type,
+				    u32 start_offset,
+				    u32 data_bytes,
+				    u32 *metadata_offset,
+				    u32 *metadata_space)
+{
+	struct ssdfs_peb_area *area;
+	u16 fragments;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!metadata_offset || !metadata_space);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "area_type %#x, write_offset %u, "
+		  "start_offset %u, data_bytes %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  area_type,
+		  pebi->current_log.area[area_type].write_offset,
+		  start_offset, data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area = &pebi->current_log.area[area_type];
+
+	*metadata_offset = area->write_offset;
+	*metadata_space = sizeof(struct ssdfs_block_state_descriptor);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("metadata_offset %u, metadata_space %u\n",
+		  *metadata_offset, *metadata_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragments = ssdfs_define_stream_fragments_count(start_offset,
+							data_bytes);
+	if (fragments == 0) {
+		SSDFS_ERR("invalid fragments count %u\n", fragments);
+		return -ERANGE;
+	}
+
+	*metadata_space += fragments * sizeof(struct ssdfs_fragment_desc);
+	*metadata_offset = ssdfs_peb_correct_area_write_offset(*metadata_offset,
+							       *metadata_space);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fragments %u, metadata_offset %u, metadata_space %u\n",
+		  fragments, *metadata_offset, *metadata_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_byte_stream() - store byte stream into log
+ * @pebi: pointer on PEB object
+ * @stream: byte stream descriptor
+ * @area_type: area type
+ * @fragment_type: fragment type
+ * @cno: checkpoint
+ * @parent_snapshot: parent snapshot number
+ *
+ * This function tries to store store data block of some size
+ * from pagevec into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_store_byte_stream(struct ssdfs_peb_info *pebi,
+				struct ssdfs_byte_stream_descriptor *stream,
+				int area_type,
+				int fragment_type,
+				u64 cno,
+				u64 parent_snapshot)
+{
+	struct ssdfs_block_state_descriptor state_desc;
+	struct ssdfs_fragment_desc cur_desc = {0};
+	struct ssdfs_peb_area *area;
+	struct ssdfs_fragment_desc *array = NULL;
+	u16 fragments;
+	int start_page, page_index;
+	u32 metadata_offset;
+	u32 metadata_space;
+	u32 written_bytes = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+	void *kaddr;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !stream);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!stream->pvec);
+	BUG_ON(pagevec_count(stream->pvec) == 0);
+	BUG_ON((pagevec_count(stream->pvec) * PAGE_SIZE) <
+		(stream->start_offset + stream->data_bytes));
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(fragment_type <= SSDFS_UNKNOWN_FRAGMENT_TYPE ||
+		fragment_type >= SSDFS_FRAGMENT_DESC_MAX_TYPE);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "area_type %#x, fragment_type %#x, write_offset %u, "
+		  "stream->start_offset %u, stream->data_bytes %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  area_type, fragment_type,
+		  pebi->current_log.area[area_type].write_offset,
+		  stream->start_offset, stream->data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area = &pebi->current_log.area[area_type];
+
+	fragments = ssdfs_define_stream_fragments_count(stream->start_offset,
+							stream->data_bytes);
+	if (fragments == 0) {
+		SSDFS_ERR("invalid fragments count %u\n", fragments);
+		return -ERANGE;
+	} else if (fragments > 1) {
+		array = ssdfs_flush_kcalloc(fragments,
+				      sizeof(struct ssdfs_fragment_desc),
+				      GFP_KERNEL);
+		if (!array) {
+			SSDFS_ERR("fail to allocate fragment desc array: "
+				  "fragments %u\n",
+				  fragments);
+			return -ENOMEM;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fragments %u, start_offset %u, data_bytes %u\n",
+		  fragments, stream->start_offset, stream->data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_page = stream->start_offset >> PAGE_SHIFT;
+
+	if ((start_page + fragments) > pagevec_count(stream->pvec)) {
+		SSDFS_ERR("start_page %d + fragments %u > pagevec_count %u\n",
+			  start_page, fragments, pagevec_count(stream->pvec));
+		err = -ERANGE;
+		goto free_array;
+	}
+
+	err = ssdfs_peb_define_metadata_space(pebi, area_type,
+						stream->start_offset,
+						stream->data_bytes,
+						&metadata_offset,
+						&metadata_space);
+	if (err) {
+		SSDFS_ERR("fail to define metadata space: err %d\n",
+			  err);
+		goto free_array;
+	}
+
+	stream->write_offset = area->write_offset = metadata_offset;
+	area->write_offset += metadata_space;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u\n", area->write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (page_index = 0; page_index < fragments; page_index++) {
+		int i = start_page + page_index;
+		struct ssdfs_fragment_source from;
+		u32 write_offset;
+
+		if (written_bytes >= stream->data_bytes) {
+			SSDFS_ERR("written_bytes %u >= data_bytes %u\n",
+				  written_bytes, stream->data_bytes);
+			err = -ERANGE;
+			goto free_array;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		kaddr = kmap_local_page(stream->pvec->pages[i]);
+		SSDFS_DBG("PAGE DUMP: index %d\n",
+			  i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr,
+				     PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		from.page = stream->pvec->pages[i];
+		from.start_offset = (stream->start_offset + written_bytes) %
+					PAGE_SIZE;
+		from.data_bytes = min_t(u32, PAGE_SIZE,
+					stream->data_bytes - written_bytes);
+		from.sequence_id = page_index;
+		from.fragment_type = fragment_type;
+		from.fragment_flags = SSDFS_FRAGMENT_HAS_CSUM;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("from.start_offset %u, from.data_bytes %zu, "
+			  "page_index %d\n",
+			  from.start_offset, from.data_bytes,
+			  page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+try_get_next_page:
+		write_offset = area->write_offset;
+		err = ssdfs_peb_store_data_block_fragment(pebi, &from,
+							  write_offset,
+							  area_type,
+							  &cur_desc);
+
+		if (err == -EAGAIN) {
+			u32 page_off = write_offset % PAGE_SIZE;
+			u32 rest = PAGE_SIZE - page_off;
+
+			if (page_off == 0)
+				goto free_array;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try to get next page: "
+				  "write_offset %u, free_space %u\n",
+				  write_offset, rest);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			pebi->current_log.area[area_type].write_offset += rest;
+			goto try_get_next_page;
+		}
+
+		if (err) {
+			SSDFS_ERR("fail to store fragment: "
+				  "sequence_id %u, write_offset %u, err %d\n",
+				  from.sequence_id,
+				  area->write_offset,
+				  err);
+			goto free_array;
+		}
+
+		if (array) {
+			ssdfs_memcpy(&array[page_index],
+				     0, sizeof(struct ssdfs_fragment_desc),
+				     &cur_desc,
+				     0, sizeof(struct ssdfs_fragment_desc),
+				     sizeof(struct ssdfs_fragment_desc));
+		} else if (page_index > 0)
+			BUG();
+
+		written_bytes += from.data_bytes;
+		area->write_offset += le16_to_cpu(cur_desc.compr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("written_bytes %u, write_offset %u\n",
+			  written_bytes, area->write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	stream->compr_bytes =
+		area->write_offset - (metadata_offset + metadata_space);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u, metadata_offset %u, metadata_space %u\n",
+		  area->write_offset, metadata_offset, metadata_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state_desc.cno = cpu_to_le64(cno);
+	state_desc.parent_snapshot = cpu_to_le64(parent_snapshot);
+
+	state_desc.chain_hdr.compr_bytes = cpu_to_le32(stream->compr_bytes);
+	state_desc.chain_hdr.uncompr_bytes = cpu_to_le32(written_bytes);
+	state_desc.chain_hdr.fragments_count = cpu_to_le16(fragments);
+	state_desc.chain_hdr.desc_size =
+			cpu_to_le16(sizeof(struct ssdfs_fragment_desc));
+	state_desc.chain_hdr.magic = SSDFS_CHAIN_HDR_MAGIC;
+	state_desc.chain_hdr.type = SSDFS_BLK_STATE_CHAIN_HDR;
+	state_desc.chain_hdr.flags = 0;
+
+	if (array) {
+		err = ssdfs_peb_store_block_state_desc(pebi, metadata_offset,
+							area_type, &state_desc,
+							array, fragments);
+	} else {
+		err = ssdfs_peb_store_block_state_desc(pebi, metadata_offset,
+							area_type, &state_desc,
+							&cur_desc, 1);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block state descriptor: "
+			  "write_offset %u, area_type %#x, err %d\n",
+			  metadata_offset, area_type, err);
+		goto free_array;
+	}
+
+free_array:
+	if (array)
+		ssdfs_flush_kfree(array);
+
+	if (err)
+		area->write_offset = metadata_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "area_type %#x, fragment_type %#x, write_offset %u, "
+		  "stream->start_offset %u, stream->data_bytes %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  area_type, fragment_type,
+		  pebi->current_log.area[area_type].write_offset,
+		  stream->start_offset, stream->data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_area_free_space() - calculate area's free space
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ */
+static
+u32 ssdfs_area_free_space(struct ssdfs_peb_info *pebi, int area_type)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 write_offset;
+	u32 page_index;
+	unsigned long pages_count;
+	u32 free_space = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("area_type %#x\n", area_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	write_offset = pebi->current_log.area[area_type].write_offset;
+	page_index = write_offset / PAGE_SIZE;
+
+	down_read(&pebi->current_log.area[area_type].array.lock);
+	pages_count = pebi->current_log.area[area_type].array.pages_count;
+	up_read(&pebi->current_log.area[area_type].array.lock);
+
+	if (page_index < pages_count)
+		free_space += PAGE_SIZE - (write_offset % PAGE_SIZE);
+
+	free_space += pebi->current_log.free_data_pages * fsi->pagesize;
+
+	/*
+	 * Reserved pages could be used for segment header
+	 * and log footer. However, partial log header is
+	 * the special combination of segment header and
+	 * log footer. Usually, latest log has to be ended
+	 * by the log footer. However, it could be used
+	 * only partial log header if it needs to use
+	 * the reserved space for log footer by user data.
+	 */
+	free_space += (pebi->current_log.reserved_pages - 1) * fsi->pagesize;
+
+	return free_space;
+}
+
+/*
+ * can_area_add_fragment() - do we can store fragment into area?
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @fragment_size: size of fragment
+ *
+ * This function checks that we can add fragment into
+ * free space of requested area.
+ */
+static
+bool can_area_add_fragment(struct ssdfs_peb_info *pebi, int area_type,
+			   u32 fragment_size)
+{
+	u32 write_offset;
+	u32 free_space;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(fragment_size == 0);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("area_type %#x, fragment_size %u\n",
+		  area_type, fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	write_offset = pebi->current_log.area[area_type].write_offset;
+	free_space = ssdfs_area_free_space(pebi, area_type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u, free_space %u\n",
+		  write_offset, free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return fragment_size <= free_space;
+}
+
+/*
+ * has_current_page_free_space() - check current area's memory page
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @fragment_size: size of fragment
+ *
+ * This function checks that we can add fragment into
+ * free space of current memory page.
+ */
+static
+bool has_current_page_free_space(struct ssdfs_peb_info *pebi,
+				 int area_type,
+				 u32 fragment_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_page_array *area_pages;
+	bool is_space_enough, is_page_available;
+	u32 write_offset;
+	pgoff_t page_index;
+	unsigned long pages_count;
+	struct page *page;
+	u32 free_space = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(fragment_size == 0);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("area_type %#x, fragment_size %u\n",
+		  area_type, fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	write_offset = pebi->current_log.area[area_type].write_offset;
+	page_index = write_offset / PAGE_SIZE;
+
+	down_read(&pebi->current_log.area[area_type].array.lock);
+	pages_count = pebi->current_log.area[area_type].array.pages_count;
+	up_read(&pebi->current_log.area[area_type].array.lock);
+
+	if (page_index < pages_count)
+		free_space += PAGE_SIZE - (write_offset % PAGE_SIZE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u, free_space %u\n",
+		  write_offset, free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	is_space_enough = fragment_size <= free_space;
+
+	page_index = write_offset >> PAGE_SHIFT;
+	area_pages = &pebi->current_log.area[area_type].array;
+	page = ssdfs_page_array_get_page(area_pages, page_index);
+	if (IS_ERR_OR_NULL(page))
+		is_page_available = false;
+	else {
+		is_page_available = true;
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return is_space_enough && is_page_available;
+}
+
+/*
+ * ssdfs_peb_get_area_free_frag_desc() - get free fragment descriptor
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ *
+ * This function tries to get next vacant fragment descriptor
+ * from block table.
+ *
+ * RETURN:
+ * [success] - pointer on vacant fragment descriptor.
+ * [failure] - NULL (block table is full).
+ */
+static
+struct ssdfs_fragment_desc *
+ssdfs_peb_get_area_free_frag_desc(struct ssdfs_peb_info *pebi, int area_type)
+{
+	struct ssdfs_area_block_table *table;
+	u16 vacant_item;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (area_type) {
+	case SSDFS_LOG_MAIN_AREA:
+	case SSDFS_LOG_DIFFS_AREA:
+	case SSDFS_LOG_JOURNAL_AREA:
+		/* these areas haven't area block table */
+		SSDFS_DBG("area block table doesn't be created\n");
+		return ERR_PTR(-ERANGE);
+
+	case SSDFS_LOG_BLK_DESC_AREA:
+		/* store area block table */
+		break;
+
+	default:
+		BUG();
+	};
+
+	table = &pebi->current_log.area[area_type].metadata.area.blk_desc.table;
+	vacant_item = le16_to_cpu(table->chain_hdr.fragments_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_type %#x, vacant_item %u\n",
+		  area_type, vacant_item);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(vacant_item > SSDFS_NEXT_BLK_TABLE_INDEX);
+	if (vacant_item == SSDFS_NEXT_BLK_TABLE_INDEX) {
+		SSDFS_DBG("block table is full\n");
+		return NULL;
+	}
+
+	le16_add_cpu(&table->chain_hdr.fragments_count, 1);
+	return &table->blk[vacant_item];
+}
+
+/*
+ * ssdfs_peb_get_area_cur_frag_desc() - get current fragment descriptor
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ *
+ * This function tries to get current fragment descriptor
+ * from block table.
+ *
+ * RETURN:
+ * [success] - pointer on current fragment descriptor.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+struct ssdfs_fragment_desc *
+ssdfs_peb_get_area_cur_frag_desc(struct ssdfs_peb_info *pebi, int area_type)
+{
+	struct ssdfs_area_block_table *table;
+	u16 fragments_count;
+	u16 cur_item = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (area_type) {
+	case SSDFS_LOG_MAIN_AREA:
+	case SSDFS_LOG_DIFFS_AREA:
+	case SSDFS_LOG_JOURNAL_AREA:
+		/* these areas haven't area block table */
+		SSDFS_DBG("area block table doesn't be created\n");
+		return ERR_PTR(-ERANGE);
+
+	case SSDFS_LOG_BLK_DESC_AREA:
+		/* store area block table */
+		break;
+
+	default:
+		BUG();
+	};
+
+	table = &pebi->current_log.area[area_type].metadata.area.blk_desc.table;
+	fragments_count = le16_to_cpu(table->chain_hdr.fragments_count);
+
+	if (fragments_count > 0)
+		cur_item = fragments_count - 1;
+	else
+		cur_item = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_type %#x, cur_item %u\n",
+		  area_type, cur_item);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(cur_item >= SSDFS_NEXT_BLK_TABLE_INDEX);
+
+	return &table->blk[cur_item];
+}
+
+/*
+ * ssdfs_peb_store_area_block_table() - store block table
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @flags: area block table header's flags
+ *
+ * This function tries to store block table into area's address
+ * space by reserved offset.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_store_area_block_table(struct ssdfs_peb_info *pebi,
+				     int area_type, u16 flags)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_area_block_table *table;
+	struct ssdfs_fragment_desc *last_desc;
+	u16 fragments;
+	u32 reserved_offset, new_offset;
+	size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+	u16 hdr_flags;
+	struct page *page;
+	pgoff_t page_index;
+	u32 page_off;
+	bool is_compressed = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (area_type) {
+	case SSDFS_LOG_MAIN_AREA:
+	case SSDFS_LOG_DIFFS_AREA:
+	case SSDFS_LOG_JOURNAL_AREA:
+		/* these areas haven't area block table */
+		SSDFS_DBG("area block table doesn't be created\n");
+		return 0;
+
+	case SSDFS_LOG_BLK_DESC_AREA:
+		/* store area block table */
+		break;
+
+	default:
+		BUG();
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_offset %u, area_type %#x\n",
+		  pebi->current_log.area[area_type].metadata.reserved_offset,
+		  area_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	is_compressed = fsi->metadata_options.blk2off_tbl.flags &
+				SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION;
+
+	area = &pebi->current_log.area[area_type];
+	table = &area->metadata.area.blk_desc.table;
+
+	fragments = le16_to_cpu(table->chain_hdr.fragments_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("table->chain_hdr.fragments_count %u\n",
+		  fragments);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fragments < SSDFS_NEXT_BLK_TABLE_INDEX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(flags & SSDFS_MULTIPLE_HDR_CHAIN);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (fragments > 0)
+			last_desc = &table->blk[fragments - 1];
+		else
+			last_desc = &table->blk[0];
+
+		last_desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+
+		switch (fsi->metadata_options.blk2off_tbl.compression) {
+		case SSDFS_BLK2OFF_TBL_NOCOMPR_TYPE:
+			last_desc->type = SSDFS_DATA_BLK_DESC;
+			break;
+		case SSDFS_BLK2OFF_TBL_ZLIB_COMPR_TYPE:
+			last_desc->type = SSDFS_DATA_BLK_DESC_ZLIB;
+			break;
+		case SSDFS_BLK2OFF_TBL_LZO_COMPR_TYPE:
+			last_desc->type = SSDFS_DATA_BLK_DESC_LZO;
+			break;
+		default:
+			BUG();
+		}
+
+		last_desc->flags = 0;
+	} else if (flags & SSDFS_MULTIPLE_HDR_CHAIN) {
+		u32 write_offset = 0;
+
+		BUG_ON(fragments > SSDFS_NEXT_BLK_TABLE_INDEX);
+
+		last_desc = &table->blk[SSDFS_NEXT_BLK_TABLE_INDEX];
+
+		if (is_compressed) {
+			write_offset = area->compressed_offset;
+			new_offset =
+			    ssdfs_peb_correct_area_write_offset(write_offset,
+								blk_table_size);
+			area->compressed_offset = new_offset;
+		} else {
+			write_offset = area->write_offset;
+			new_offset =
+			    ssdfs_peb_correct_area_write_offset(write_offset,
+								blk_table_size);
+			area->write_offset = new_offset;
+		}
+
+		last_desc->offset = cpu_to_le32(new_offset);
+
+		last_desc->compr_size = cpu_to_le16(blk_table_size);
+		last_desc->uncompr_size = cpu_to_le16(blk_table_size);
+		last_desc->checksum = 0;
+
+		if (area->metadata.sequence_id == U8_MAX)
+			area->metadata.sequence_id = 0;
+
+		last_desc->sequence_id = area->metadata.sequence_id++;
+
+		last_desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+		last_desc->type = SSDFS_NEXT_TABLE_DESC;
+		last_desc->flags = 0;
+	}
+
+	hdr_flags = le16_to_cpu(table->chain_hdr.flags);
+	hdr_flags |= flags;
+	table->chain_hdr.flags = cpu_to_le16(hdr_flags);
+
+	reserved_offset = area->metadata.reserved_offset;
+	page_index = reserved_offset / PAGE_SIZE;
+	page = ssdfs_page_array_get_page_locked(&area->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get page %lu for area %#x\n",
+			  page_index, area_type);
+		return -ERANGE;
+	}
+
+	page_off = reserved_offset % PAGE_SIZE;
+
+	err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+				   table, 0, blk_table_size,
+				   blk_table_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto finish_copy;
+	}
+
+	SetPageUptodate(page);
+
+	err = ssdfs_page_array_set_page_dirty(&area->array, page_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu dirty: "
+			  "err %d\n",
+			  page_index, err);
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
+	return err;
+}
+
+/*
+ * ssdfs_peb_allocate_area_block_table() - reserve block table
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ *
+ * This function tries to prepare new in-core block table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - log is full.
+ */
+static
+int ssdfs_peb_allocate_area_block_table(struct ssdfs_peb_info *pebi,
+					int area_type)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_area *area;
+	u16 fragments;
+	struct ssdfs_area_block_table *table;
+	struct ssdfs_fragment_desc *last_desc;
+	size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+	u32 write_offset = 0;
+	bool is_compressed = false;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (area_type) {
+	case SSDFS_LOG_MAIN_AREA:
+	case SSDFS_LOG_DIFFS_AREA:
+	case SSDFS_LOG_JOURNAL_AREA:
+		/* these areas haven't area block table */
+		SSDFS_DBG("area block table doesn't be created\n");
+		return 0;
+
+	case SSDFS_LOG_BLK_DESC_AREA:
+		/* store area block table */
+		break;
+
+	default:
+		BUG();
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u, area_type %#x\n",
+		  pebi->current_log.area[area_type].write_offset,
+		  area_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	is_compressed = fsi->metadata_options.blk2off_tbl.flags &
+				SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION;
+
+	area = &pebi->current_log.area[area_type];
+	table = &area->metadata.area.blk_desc.table;
+	fragments = le16_to_cpu(table->chain_hdr.fragments_count);
+
+	BUG_ON(fragments > SSDFS_NEXT_BLK_TABLE_INDEX);
+
+	if (fragments < SSDFS_NEXT_BLK_TABLE_INDEX) {
+		SSDFS_ERR("invalid fragments count %u\n", fragments);
+		return -ERANGE;
+	}
+
+	last_desc = &table->blk[SSDFS_NEXT_BLK_TABLE_INDEX];
+
+	if (is_compressed)
+		write_offset = area->compressed_offset;
+	else
+		write_offset = area->write_offset;
+
+	if (le32_to_cpu(last_desc->offset) != write_offset) {
+		SSDFS_ERR("last_desc->offset %u != write_offset %u\n",
+			  le32_to_cpu(last_desc->offset), write_offset);
+		return -ERANGE;
+	}
+
+	if (!has_current_page_free_space(pebi, area_type, blk_table_size)) {
+		err = ssdfs_peb_grow_log_area(pebi, area_type, blk_table_size);
+		if (err == -ENOSPC) {
+			SSDFS_DBG("log is full\n");
+			return -EAGAIN;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to grow log area: "
+				  "type %#x, err %d\n",
+				  area_type, err);
+			return err;
+		}
+	}
+
+	table->chain_hdr.compr_bytes = 0;
+	table->chain_hdr.uncompr_bytes = 0;
+	table->chain_hdr.fragments_count = 0;
+	table->chain_hdr.desc_size =
+			cpu_to_le16(sizeof(struct ssdfs_fragment_desc));
+	table->chain_hdr.magic = SSDFS_CHAIN_HDR_MAGIC;
+	table->chain_hdr.flags = 0;
+
+	memset(table->blk, 0,
+		sizeof(struct ssdfs_fragment_desc) * SSDFS_BLK_TABLE_MAX);
+
+	area->metadata.reserved_offset = write_offset;
+
+	if (is_compressed)
+		area->compressed_offset += blk_table_size;
+	else
+		area->write_offset += blk_table_size;
+
+	return 0;
+}
+
+/* try to estimate fragment size in the log */
+static inline
+u32 ssdfs_peb_estimate_data_fragment_size(u32 uncompr_bytes)
+{
+	u32 estimated_compr_size;
+
+	/*
+	 * There are several alternatives:
+	 * (1) overestimate size;
+	 * (2) underestimate size;
+	 * (3) try to predict possible size by means of some formula.
+	 *
+	 * Currently, try to estimate size as 65% from uncompressed state
+	 * for compression case.
+	 */
+
+	estimated_compr_size = (uncompr_bytes * 65) / 100;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("uncompr_bytes %u, estimated_compr_size %u\n",
+		  uncompr_bytes, estimated_compr_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return estimated_compr_size;
+}
+
 /*
  * ssdfs_request_rest_bytes() - define rest bytes in request
  * @pebi: pointer on PEB object
-- 
2.34.1

