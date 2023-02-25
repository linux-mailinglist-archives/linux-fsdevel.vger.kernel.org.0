Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6BB6A2646
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBYBRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjBYBQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:48 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078516328
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:43 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk32so763176oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJmoW19vH/ihUE8CclRwinORr6wbIShbLnA29Opvs3o=;
        b=e9eRwQHswQEsvKmSoGov8XUycjrTCFyQs/4pfnp23TX3dVXbxD4sjn4FUPmLgiHhZk
         qAVS0wjiddDxX4BYPvIZFqSuU3733vejFmEgO+4ai99573r9YWQ+iyn3Lp+6Xkzka3JJ
         esiub0GfixJu8EFmshpwt7DdJiPKmkkNfZTLuLFJKyfcwZ049e20naNeGDvJg5m6jNHb
         XAn3+Q1RQGHOzFMukORCY8P66aRPe7BRF8MTHVvqRCsqs/jyMjTOQQYocPjYCXXmCWiB
         xfwqVkAxVIdElWpHTS2hGKNu1kr586a81AhIdrlX60VXCM1nZtg61KKiTtzRqAqL1rYd
         Y2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJmoW19vH/ihUE8CclRwinORr6wbIShbLnA29Opvs3o=;
        b=eqyfTJkPj7PGeFFw5zcMOg5IWyoBmjz8s3zPrI+nC9Pa81bGus0QND8K9Iy6SX5yJh
         LcCYSP/1e7xzn79k0rldlBXxtlj5Xxx5EScsB6PML3ZHRC/jmqcGTW9DKPegjXOOaDdk
         W7BfTyf/sPLtBsSuRWVUhNf3qbGIsQpF4aXt2J/i59u0A6OzKqO4w/1FOj/xTfnvzTKj
         kXwnFC/iLF9zMicW1r3yhqt2PboES02RrO/785ZpDC3LlLRadgs+6f9zhPfZA2yS3PCh
         krnBcwoHNt0X0Ll6sineK08qYZcvja939sjCBkwx23nmoDez3ASvZswJV5sRajlN01NR
         xSSg==
X-Gm-Message-State: AO0yUKUnuV0WqgQ7v5bEsEMoERhH1teNSeIW8rYCyRPLuZwBaWTKJVGQ
        Jbhakb7VXkYaIADCsuVmpQLtteYw83UrvcuY
X-Google-Smtp-Source: AK7set95toy0C8RZyRWlkZHAk+srcyArM3X3blIMNAojQkjj5EET4gVcLnrQwclcpQ58uGJwpvTgKQ==
X-Received: by 2002:a54:4806:0:b0:384:8a1:c14b with SMTP id j6-20020a544806000000b0038408a1c14bmr1282993oij.31.1677287802254;
        Fri, 24 Feb 2023 17:16:42 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:41 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 32/76] ssdfs: process create request
Date:   Fri, 24 Feb 2023 17:08:43 -0800
Message-Id: <20230225010927.813929-33-slava@dubeyko.com>
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

Flush thread of current segment can receive a several types
of create request:
(1) pre-allocate block or extent,
(2) create block or extent,
(3) migrate zone's user block or extent.

Pre-allocate operation implies the operation of reservation
one or several logical blocks for empty file or b-tree node.
Also, if a file can be inline (stored into inode's space),
then logical block is in pre-allocated state too. Create block
or extent operation implies the allocation of logical block(s)
and store user data or metadata into it. Migrate zone's block
(or extent) operation is used if user data in closed zone is
received update. Such case requires the storing of new state
of user data into current zone for user data update and store
the invalidated extent of closed zone into invalidated extents
b-tree.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_flush_thread.c | 3270 +++++++++++++++++++++++++++++++++++
 1 file changed, 3270 insertions(+)

diff --git a/fs/ssdfs/peb_flush_thread.c b/fs/ssdfs/peb_flush_thread.c
index 7e6a8a67e142..857270e0cbf0 100644
--- a/fs/ssdfs/peb_flush_thread.c
+++ b/fs/ssdfs/peb_flush_thread.c
@@ -228,6 +228,3276 @@ struct ssdfs_pagevec_descriptor {
  *                         FLUSH THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * ssdfs_request_rest_bytes() - define rest bytes in request
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ */
+static inline
+u32 ssdfs_request_rest_bytes(struct ssdfs_peb_info *pebi,
+			     struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi = pebi->pebc->parent_si->fsi;
+	u32 processed_bytes = req->result.processed_blks * fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("processed_bytes %u, req->extent.data_bytes %u\n",
+		  processed_bytes, req->extent.data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (processed_bytes > req->extent.data_bytes)
+		return 0;
+	else
+		return req->extent.data_bytes - processed_bytes;
+}
+
+/*
+ * ssdfs_peb_increase_area_payload_size() - increase area size
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @p: byte stream object ponter
+ */
+static void
+ssdfs_peb_increase_area_payload_size(struct ssdfs_peb_info *pebi,
+				     int area_type,
+				     struct ssdfs_byte_stream_descriptor *p)
+{
+	struct ssdfs_peb_area *area;
+	struct ssdfs_fragments_chain_header *chain_hdr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !p);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area = &pebi->current_log.area[area_type];
+
+	switch (area_type) {
+	case SSDFS_LOG_BLK_DESC_AREA:
+		chain_hdr = &area->metadata.area.blk_desc.table.chain_hdr;
+		break;
+
+	case SSDFS_LOG_DIFFS_AREA:
+		chain_hdr = &area->metadata.area.diffs.table.hdr.chain_hdr;
+		break;
+
+	case SSDFS_LOG_JOURNAL_AREA:
+		chain_hdr = &area->metadata.area.journal.table.hdr.chain_hdr;
+		break;
+
+	case SSDFS_LOG_MAIN_AREA:
+		chain_hdr = &area->metadata.area.main.desc.chain_hdr;
+		break;
+
+	default:
+		BUG();
+	};
+
+	le32_add_cpu(&chain_hdr->compr_bytes, p->compr_bytes);
+	le32_add_cpu(&chain_hdr->uncompr_bytes, (u32)p->data_bytes);
+}
+
+/*
+ * ssdfs_peb_define_area_offset() - define fragment's offset
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @p: byte stream object ponter
+ * @off: PEB's physical offset to data [out]
+ */
+static
+int ssdfs_peb_define_area_offset(struct ssdfs_peb_info *pebi,
+				  int area_type,
+				  struct ssdfs_byte_stream_descriptor *p,
+				  struct ssdfs_peb_phys_offset *off)
+{
+	int id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !p);
+	BUG_ON(area_type >= SSDFS_LOG_AREA_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	off->peb_index = pebi->peb_index;
+	off->peb_migration_id = (u8)id;
+	off->log_area = area_type;
+	off->byte_offset = p->write_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("off->peb_index %u, off->peb_migration_id %u, "
+		  "off->log_area %#x, off->byte_offset %u\n",
+		  pebi->peb_index, id, area_type, p->write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+static inline
+void ssdfs_prepare_user_data_options(struct ssdfs_fs_info *fsi,
+				     u8 *compression)
+{
+	u16 flags;
+	u8 type;
+
+	flags = fsi->metadata_options.user_data.flags;
+	type = fsi->metadata_options.user_data.compression;
+
+	*compression = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+
+	if (flags & SSDFS_USER_DATA_MAKE_COMPRESSION) {
+		switch (type) {
+		case SSDFS_USER_DATA_NOCOMPR_TYPE:
+			*compression = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+			break;
+
+		case SSDFS_USER_DATA_ZLIB_COMPR_TYPE:
+			*compression = SSDFS_FRAGMENT_ZLIB_BLOB;
+			break;
+
+		case SSDFS_USER_DATA_LZO_COMPR_TYPE:
+			*compression = SSDFS_FRAGMENT_LZO_BLOB;
+			break;
+		}
+	}
+}
+
+/*
+ * ssdfs_peb_store_fragment_in_area() - try to store fragment into area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @area_type: area type
+ * @start_offset: start offset of fragment in bytes
+ * @data_bytes: size of fragment in bytes
+ * @off: PEB's physical offset to data [out]
+ *
+ * This function tries to store fragment into data area (diff updates
+ * or journal) of the log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to store data block in current log.
+ */
+static
+int ssdfs_peb_store_fragment_in_area(struct ssdfs_peb_info *pebi,
+				     struct ssdfs_segment_request *req,
+				     int area_type,
+				     u32 start_offset,
+				     u32 data_bytes,
+				     struct ssdfs_peb_phys_offset *off)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_byte_stream_descriptor byte_stream = {0};
+	u8 compression_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+	u32 metadata_offset;
+	u32 metadata_space;
+	u32 estimated_compr_size = data_bytes;
+	u32 check_bytes;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !off);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "processed_blks %d, area_type %#x, "
+		  "start_offset %u, data_bytes %u\n",
+		  req->place.start.seg_id, pebi->peb_id, req->extent.ino,
+		  req->result.processed_blks, area_type,
+		  start_offset, data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	err = ssdfs_peb_define_metadata_space(pebi, area_type,
+						start_offset,
+						data_bytes,
+						&metadata_offset,
+						&metadata_space);
+	if (err) {
+		SSDFS_ERR("fail to define metadata space: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_prepare_user_data_options(fsi, &compression_type);
+
+	switch (compression_type) {
+	case SSDFS_FRAGMENT_UNCOMPR_BLOB:
+		estimated_compr_size = data_bytes;
+		break;
+
+	case SSDFS_FRAGMENT_ZLIB_BLOB:
+#if defined(CONFIG_SSDFS_ZLIB)
+		estimated_compr_size =
+			ssdfs_peb_estimate_data_fragment_size(data_bytes);
+#else
+		compression_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+		estimated_compr_size = data_bytes;
+		SSDFS_WARN("ZLIB compression is not supported\n");
+#endif
+		break;
+
+	case SSDFS_FRAGMENT_LZO_BLOB:
+#if defined(CONFIG_SSDFS_LZO)
+		estimated_compr_size =
+			ssdfs_peb_estimate_data_fragment_size(data_bytes);
+#else
+		compression_type = SSDFS_FRAGMENT_UNCOMPR_BLOB;
+		estimated_compr_size = data_bytes;
+		SSDFS_WARN("LZO compression is not supported\n");
+#endif
+		break;
+
+	default:
+		BUG();
+	}
+
+	check_bytes = metadata_space + estimated_compr_size;
+
+	if (!can_area_add_fragment(pebi, area_type, check_bytes)) {
+		pebi->current_log.free_data_pages = 0;
+		SSDFS_DBG("log is full\n");
+		return -EAGAIN;
+	}
+
+	if (!has_current_page_free_space(pebi, area_type, check_bytes)) {
+		err = ssdfs_peb_grow_log_area(pebi, area_type, check_bytes);
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
+	byte_stream.pvec = &req->result.pvec;
+	byte_stream.start_offset = start_offset;
+	byte_stream.data_bytes = data_bytes;
+
+	err = ssdfs_peb_store_byte_stream(pebi, &byte_stream, area_type,
+					  compression_type,
+					  req->extent.cno,
+					  req->extent.parent_snapshot);
+
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add byte stream: "
+			  "start_offset %u, data_bytes %u, area_type %#x, "
+			  "cno %llu, parent_snapshot %llu\n",
+			  byte_stream.start_offset, data_bytes, area_type,
+			  req->extent.cno, req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to add byte stream: "
+			  "start_offset %u, data_bytes %u, area_type %#x, "
+			  "cno %llu, parent_snapshot %llu\n",
+			  byte_stream.start_offset, data_bytes, area_type,
+			  req->extent.cno, req->extent.parent_snapshot);
+		return err;
+	}
+
+	ssdfs_peb_increase_area_payload_size(pebi, area_type, &byte_stream);
+
+	err = ssdfs_peb_define_area_offset(pebi, area_type, &byte_stream, off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define area offset: "
+			  "seg %llu, peb_id %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_in_journal_area() - try to store fragment into Journal area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @start_offset: start offset of fragment in bytes
+ * @data_bytes: size of fragment in bytes
+ * @off: PEB's physical offset to data [out]
+ *
+ * This function tries to store fragment into Journal area of the log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to store data block in current log.
+ */
+static inline
+int ssdfs_peb_store_in_journal_area(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_segment_request *req,
+				    u32 start_offset,
+				    u32 data_bytes,
+				    struct ssdfs_peb_phys_offset *off)
+{
+	int area_type = SSDFS_LOG_JOURNAL_AREA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !off);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "processed_blks %d, start_offset %u, data_bytes %u\n",
+		  req->place.start.seg_id, pebi->peb_id, req->extent.ino,
+		  req->result.processed_blks, start_offset, data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_peb_store_fragment_in_area(pebi, req, area_type,
+						start_offset, data_bytes,
+						off);
+}
+
+/*
+ * ssdfs_peb_store_in_diff_area() - try to store fragment into Diff area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @start_offset: start offset of fragment in bytes
+ * @data_bytes: size of fragment in bytes
+ * @off: PEB's physical offset to data [out]
+ *
+ * This function tries to store fragment into Diff Updates area of the log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to store data block in current log.
+ */
+static inline
+int ssdfs_peb_store_in_diff_area(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req,
+				 u32 start_offset,
+				 u32 data_bytes,
+				 struct ssdfs_peb_phys_offset *off)
+{
+	int area_type = SSDFS_LOG_DIFFS_AREA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !off);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "processed_blks %d, start_offset %u, data_bytes %u\n",
+		  req->place.start.seg_id, pebi->peb_id, req->extent.ino,
+		  req->result.processed_blks, start_offset, data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_peb_store_fragment_in_area(pebi, req, area_type,
+						start_offset, data_bytes,
+						off);
+}
+
+/*
+ * ssdfs_peb_store_in_main_area() - try to store fragment into Main area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @start_offset: start offset of fragment in bytes
+ * @data_bytes: size of fragment in bytes
+ * @off: PEB's physical offset to data [out]
+ *
+ * This function tries to store fragment into Main area of the log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to store data block in current log.
+ */
+static
+int ssdfs_peb_store_in_main_area(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req,
+				 u32 start_offset,
+				 u32 data_bytes,
+				 struct ssdfs_peb_phys_offset *off)
+{
+	int area_type = SSDFS_LOG_MAIN_AREA;
+	struct ssdfs_byte_stream_descriptor byte_stream = {0};
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !off);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "processed_blks %d, rest_bytes %u\n",
+		  req->place.start.seg_id, pebi->peb_id, req->extent.ino,
+		  req->result.processed_blks,
+		  data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!can_area_add_fragment(pebi, area_type, data_bytes)) {
+		pebi->current_log.free_data_pages = 0;
+		SSDFS_DBG("log is full\n");
+		return -EAGAIN;
+	}
+
+	if (!has_current_page_free_space(pebi, area_type, data_bytes)) {
+		err = ssdfs_peb_grow_log_area(pebi, area_type, data_bytes);
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
+	byte_stream.pvec = &req->result.pvec;
+	byte_stream.start_offset = start_offset;
+	byte_stream.data_bytes = data_bytes;
+
+	err = ssdfs_peb_store_byte_stream_in_main_area(pebi, &byte_stream,
+						req->extent.cno,
+						req->extent.parent_snapshot);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add byte stream: "
+			  "start_offset %u, data_bytes %u, area_type %#x, "
+			  "cno %llu, parent_snapshot %llu\n",
+			  start_offset, data_bytes, area_type,
+			  req->extent.cno, req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to add byte stream: "
+			  "start_offset %u, data_bytes %u, area_type %#x, "
+			  "cno %llu, parent_snapshot %llu\n",
+			  start_offset, data_bytes, area_type,
+			  req->extent.cno, req->extent.parent_snapshot);
+		return err;
+	}
+
+	ssdfs_peb_increase_area_payload_size(pebi, area_type, &byte_stream);
+
+	err = ssdfs_peb_define_area_offset(pebi, area_type, &byte_stream, off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define area offset: "
+			  "seg %llu, peb_id %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * is_ssdfs_block_full() - check that data size is equal to page size
+ * @pagesize: page size in bytes
+ * @data_size: data size in bytes
+ */
+static inline
+bool is_ssdfs_block_full(u32 pagesize, u32 data_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pagesize %u, data_size %u\n",
+		  pagesize, data_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagesize > PAGE_SIZE)
+		return data_size >= pagesize;
+
+	return data_size >= PAGE_SIZE;
+}
+
+/*
+ * can_ssdfs_pagevec_be_compressed() - check that pagevec can be compressed
+ * @start_page: starting page in pagevec
+ * @page_count: count of pages in the portion
+ * @bytes_count: bytes number in the portion
+ * @req: segment request
+ */
+static
+bool can_ssdfs_pagevec_be_compressed(u32 start_page, u32 page_count,
+				     u32 bytes_count,
+				     struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int page_index;
+	u32 start_offset;
+	u32 portion_size;
+	u32 tested_bytes = 0;
+	u32 can_compress[2] = {0, 0};
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("start_page %u, page_count %u, "
+		  "bytes_count %u\n",
+		  start_page, page_count, bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < page_count; i++) {
+		int state;
+
+		page_index = i + start_page;
+		start_offset = page_index >> PAGE_SHIFT;
+		portion_size = PAGE_SIZE;
+
+		if (page_index >= pagevec_count(&req->result.pvec)) {
+			SSDFS_ERR("fail to check page: "
+				  "index %d, pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&req->result.pvec));
+			return false;
+		}
+
+		page = req->result.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(tested_bytes >= bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		portion_size = min_t(u32, portion_size,
+				     bytes_count - tested_bytes);
+
+		if (ssdfs_can_compress_data(page, portion_size))
+			state = 1;
+		else
+			state = 0;
+
+		can_compress[state]++;
+		tested_bytes += portion_size;
+	}
+
+	return can_compress[true] >= can_compress[false];
+}
+
+/*
+ * ssdfs_peb_define_area_type() - define area type
+ * @pebi: pointer on PEB object
+ * @bytes_count: bytes number in the portion
+ * @start_page: starting page in pagevec
+ * @page_count: count of pages in the portion
+ * @req: I/O request
+ * @desc_off: block descriptor offset
+ * @pos: offset position
+ * @area_type: type of area [out]
+ */
+static
+int ssdfs_peb_define_area_type(struct ssdfs_peb_info *pebi,
+				u32 bytes_count,
+				u32 start_page, u32 page_count,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				int *area_type)
+{
+	struct ssdfs_fs_info *fsi;
+	bool can_be_compressed = false;
+#ifdef CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA
+	int err;
+#endif /* CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !area_type);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "processed_blks %d, bytes_count %u, "
+		  "start_page %u, page_count %u\n",
+		  req->place.start.seg_id, pebi->peb_id, req->extent.ino,
+		  req->result.processed_blks,
+		  bytes_count, start_page, page_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	*area_type = SSDFS_LOG_AREA_MAX;
+
+	if (req->private.class == SSDFS_PEB_DIFF_ON_WRITE_REQ) {
+		*area_type = SSDFS_LOG_DIFFS_AREA;
+	} else if (!is_ssdfs_block_full(fsi->pagesize, bytes_count))
+		*area_type = SSDFS_LOG_JOURNAL_AREA;
+	else {
+#ifdef CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA
+		if (req->private.class == SSDFS_PEB_UPDATE_REQ) {
+			err = ssdfs_user_data_prepare_diff(pebi->pebc,
+							   desc_off,
+							   pos, req);
+		} else
+			err = -ENOENT;
+
+		if (err == -ENOENT) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to prepare user data diff: "
+				  "seg %llu, peb %llu, ino %llu, "
+				  "processed_blks %d, bytes_count %u, "
+				  "start_page %u, page_count %u\n",
+				  req->place.start.seg_id,
+				  pebi->peb_id,
+				  req->extent.ino,
+				  req->result.processed_blks,
+				  bytes_count, start_page,
+				  page_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			can_be_compressed =
+				can_ssdfs_pagevec_be_compressed(start_page,
+								page_count,
+								bytes_count,
+								req);
+			if (can_be_compressed)
+				*area_type = SSDFS_LOG_DIFFS_AREA;
+			else
+				*area_type = SSDFS_LOG_MAIN_AREA;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare user data diff: "
+				  "seg %llu, peb %llu, ino %llu, "
+				  "processed_blks %d, bytes_count %u, "
+				  "start_page %u, page_count %u, err %d\n",
+				  req->place.start.seg_id,
+				  pebi->peb_id,
+				  req->extent.ino,
+				  req->result.processed_blks,
+				  bytes_count, start_page,
+				  page_count, err);
+			return err;
+		} else
+			*area_type = SSDFS_LOG_DIFFS_AREA;
+#else
+		can_be_compressed = can_ssdfs_pagevec_be_compressed(start_page,
+								    page_count,
+								    bytes_count,
+								    req);
+		if (can_be_compressed)
+			*area_type = SSDFS_LOG_DIFFS_AREA;
+		else
+			*area_type = SSDFS_LOG_MAIN_AREA;
+#endif /* CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA */
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_add_block_into_data_area() - try to add data block into log
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @desc_off: block descriptor offset
+ * @pos: offset position
+ * @off: PEB's physical offset to data [out]
+ * @written_bytes: amount of written bytes [out]
+ *
+ * This function tries to add data block into data area (main, diff updates
+ * or journal) of the log. If attempt to add data or block descriptor
+ * has failed with %-EAGAIN error then it needs to return request into
+ * head of the queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to store data block in current log.
+ */
+static
+int ssdfs_peb_add_block_into_data_area(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_peb_phys_offset *off,
+				u32 *written_bytes)
+{
+	struct ssdfs_fs_info *fsi;
+	int area_type = SSDFS_LOG_AREA_MAX;
+	u32 rest_bytes;
+	u32 start_page = 0;
+	u32 page_count = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !off);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*written_bytes = 0;
+	rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "processed_blks %d, rest_bytes %u\n",
+		  req->place.start.seg_id, pebi->peb_id, req->extent.ino,
+		  req->result.processed_blks,
+		  rest_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (req->private.class == SSDFS_PEB_DIFF_ON_WRITE_REQ) {
+		start_page = req->result.processed_blks;
+		rest_bytes = PAGE_SIZE;
+		page_count = 1;
+	} else if (fsi->pagesize < PAGE_SIZE) {
+		start_page = req->result.processed_blks << fsi->log_pagesize;
+		start_page >>= PAGE_SHIFT;
+		rest_bytes = min_t(u32, rest_bytes, PAGE_SIZE);
+		page_count = rest_bytes + PAGE_SIZE - 1;
+		page_count >>= PAGE_SHIFT;
+	} else {
+		start_page = req->result.processed_blks << fsi->log_pagesize;
+		start_page >>= PAGE_SHIFT;
+		rest_bytes = min_t(u32, rest_bytes, fsi->pagesize);
+		page_count = rest_bytes + PAGE_SIZE - 1;
+		page_count >>= PAGE_SHIFT;
+	}
+
+	err = ssdfs_peb_define_area_type(pebi, rest_bytes,
+					 start_page, page_count,
+					 req, desc_off, pos, &area_type);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define area type: "
+			  "rest_bytes %u, start_page %u, "
+			  "page_count %u, err %d\n",
+			  rest_bytes, start_page,
+			  page_count, err);
+		return err;
+	}
+
+	for (i = 0; i < page_count; i++) {
+		int page_index = i + start_page;
+		u32 start_offset = page_index << PAGE_SHIFT;
+		u32 portion_size = PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(*written_bytes >= rest_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		portion_size = min_t(u32, portion_size,
+					  rest_bytes - *written_bytes);
+
+		switch (area_type) {
+		case SSDFS_LOG_JOURNAL_AREA:
+			err = ssdfs_peb_store_in_journal_area(pebi, req,
+							      start_offset,
+							      portion_size,
+							      off);
+			break;
+
+		case SSDFS_LOG_DIFFS_AREA:
+			err = ssdfs_peb_store_in_diff_area(pebi, req,
+							   start_offset,
+							   portion_size,
+							   off);
+			break;
+
+		case SSDFS_LOG_MAIN_AREA:
+			err = ssdfs_peb_store_in_main_area(pebi, req,
+							   start_offset,
+							   portion_size,
+							   off);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add page into current log: "
+				  "index %d, portion_size %u\n",
+				  page_index, portion_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add page into current log: "
+				  "index %d, portion_size %u\n",
+				  page_index, portion_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EAGAIN;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to add page: "
+				  "index %d, portion_size %u, err %d\n",
+				  page_index, portion_size, err);
+			return err;
+		}
+
+		*written_bytes += portion_size;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("written_bytes %u\n", *written_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * need_reserve_free_space() - check necessuty to reserve free space
+ * @pebi: pointer on PEB object
+ * @area_type: area type
+ * @fragment_size: size of fragment
+ *
+ * This function checks that it needs to reserve free space.
+ */
+static
+bool need_reserve_free_space(struct ssdfs_peb_info *pebi,
+			     int area_type,
+			     u32 fragment_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_page_array *area_pages;
+	bool is_space_enough, is_page_available;
+	u32 write_offset;
+	pgoff_t page_index;
+	unsigned long pages_count;
+	struct page *page;
+	struct ssdfs_peb_area_metadata *metadata;
+	u32 free_space = 0;
+	u16 flags;
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
+
+	switch (area_type) {
+	case SSDFS_LOG_BLK_DESC_AREA:
+		flags = fsi->metadata_options.blk2off_tbl.flags;
+		if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+			/*
+			 * continue logic
+			 */
+		} else
+			return has_current_page_free_space(pebi, area_type,
+							   fragment_size);
+		break;
+
+	default:
+		return has_current_page_free_space(pebi, area_type,
+						   fragment_size);
+	}
+
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
+	metadata = &pebi->current_log.area[area_type].metadata;
+	write_offset = metadata->area.blk_desc.flush_buf.write_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("write_offset %u, free_space %u\n",
+		  write_offset, free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	is_space_enough = (write_offset / 2) < free_space;
+
+	write_offset = pebi->current_log.area[area_type].write_offset;
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
+ * ssdfs_peb_reserve_block_descriptor() - reserve block descriptor space
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to reserve space for block descriptor in
+ * block descriptor area. If attempt to add data or block descriptor
+ * has failed with %-EAGAIN error then it needs to return request into
+ * head of the queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to reserve block descriptor in current log.
+ */
+static
+int ssdfs_peb_reserve_block_descriptor(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	int area_type = SSDFS_LOG_BLK_DESC_AREA;
+	struct ssdfs_peb_area_metadata *metadata;
+	struct ssdfs_area_block_table *table;
+	int items_count, capacity;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	u16 flags;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(!req);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, processed_blks %d\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	flags = fsi->metadata_options.blk2off_tbl.flags;
+
+	metadata = &pebi->current_log.area[area_type].metadata;
+	table = &metadata->area.blk_desc.table;
+
+	items_count = metadata->area.blk_desc.items_count;
+	capacity = metadata->area.blk_desc.capacity;
+
+	if (items_count > capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_count %d > capacity %d\n",
+			  items_count, capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_count %d, capacity %d\n",
+			  items_count, capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+		if (need_reserve_free_space(pebi, area_type,
+					    blk_desc_size)) {
+			err = ssdfs_peb_grow_log_area(pebi, area_type,
+						      blk_desc_size);
+			if (err == -ENOSPC) {
+				SSDFS_DBG("log is full\n");
+				return -EAGAIN;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to grow log area: "
+					  "type %#x, err %d\n",
+					  area_type, err);
+				return err;
+			}
+		}
+	} else {
+		if (!has_current_page_free_space(pebi, area_type,
+						 blk_desc_size)) {
+			err = ssdfs_peb_grow_log_area(pebi, area_type,
+						      blk_desc_size);
+			if (err == -ENOSPC) {
+				SSDFS_DBG("log is full\n");
+				return -EAGAIN;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to grow log area: "
+					  "type %#x, err %d\n",
+					  area_type, err);
+				return err;
+			}
+		}
+	}
+
+	metadata->area.blk_desc.items_count++;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_init_block_descriptor_state() - init block descriptor's state
+ * @pebi: pointer on PEB object
+ * @data: data offset inside PEB
+ * @state: block descriptor's state [out]
+ *
+ * This function initializes a state of block descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - corrupted block descriptor.
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_peb_init_block_descriptor_state(struct ssdfs_peb_info *pebi,
+					  struct ssdfs_peb_phys_offset *data,
+					  struct ssdfs_blk_state_offset *state)
+{
+	int id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !data || !state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state->log_start_page = cpu_to_le16(pebi->current_log.start_page);
+	state->log_area = data->log_area;
+	state->byte_offset = cpu_to_le32(data->byte_offset);
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
+	state->peb_migration_id = (u8)id;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_prepare_block_descriptor() - prepare new state of block descriptor
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @data: data offset inside PEB
+ * @desc: block descriptor [out]
+ *
+ * This function prepares new state of block descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - corrupted block descriptor.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_prepare_block_descriptor(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_peb_phys_offset *data,
+				struct ssdfs_block_descriptor *desc)
+{
+	u64 logical_offset;
+	u32 pagesize;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req || !desc || !data);
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, processed_blks %d\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pagesize = pebi->pebc->parent_si->fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(req->result.processed_blks > req->place.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset = req->extent.logical_offset +
+			 (req->result.processed_blks * pagesize);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(logical_offset >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset /= pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	DEBUG_BLOCK_DESCRIPTOR(pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	i = 0;
+
+	do {
+		if (IS_SSDFS_BLK_STATE_OFFSET_INVALID(&desc->state[i]))
+			break;
+		else
+			i++;
+	} while (i < SSDFS_BLK_STATE_OFF_MAX);
+
+	if (i == 0) {
+		/* empty block descriptor */
+		desc->ino = cpu_to_le64(req->extent.ino);
+		desc->logical_offset = cpu_to_le32((u32)logical_offset);
+		desc->peb_index = cpu_to_le16(data->peb_index);
+		desc->peb_page = cpu_to_le16(data->peb_page);
+
+		err = ssdfs_peb_init_block_descriptor_state(pebi, data,
+							    &desc->state[0]);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init block descriptor state: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else if (i >= SSDFS_BLK_STATE_OFF_MAX) {
+		SSDFS_WARN("block descriptor is exhausted: "
+			   "seg_id %llu, peb_id %llu, "
+			   "ino %llu, logical_offset %llu\n",
+			   pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id,
+			   req->extent.ino,
+			   req->extent.logical_offset);
+		return -ERANGE;
+	} else {
+		if (le64_to_cpu(desc->ino) != req->extent.ino) {
+			SSDFS_ERR("corrupted block state: "
+				  "ino1 %llu != ino2 %llu\n",
+				  le64_to_cpu(desc->ino),
+				  req->extent.ino);
+			return -EIO;
+		}
+
+		if (le32_to_cpu(desc->logical_offset) != logical_offset) {
+			SSDFS_ERR("corrupted block state: "
+				  "logical_offset1 %u != logical_offset2 %llu\n",
+				  le32_to_cpu(desc->logical_offset),
+				  logical_offset);
+			return -EIO;
+		}
+
+		if (le16_to_cpu(desc->peb_index) != data->peb_index) {
+			SSDFS_ERR("corrupted block state: "
+				  "peb_index1 %u != peb_index2 %u\n",
+				  le16_to_cpu(desc->peb_index),
+				  data->peb_index);
+			return -EIO;
+		}
+
+		if (le16_to_cpu(desc->peb_page) != data->peb_page) {
+			SSDFS_ERR("corrupted block state: "
+				  "peb_page1 %u != peb_page2 %u\n",
+				  le16_to_cpu(desc->peb_page),
+				  data->peb_page);
+			return -EIO;
+		}
+
+		err = ssdfs_peb_init_block_descriptor_state(pebi, data,
+							    &desc->state[i]);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init block descriptor state: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	DEBUG_BLOCK_DESCRIPTOR(pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_write_block_descriptor() - write block descriptor into area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @desc: block descriptor
+ * @data_off: offset to data in PEB [in]
+ * @off: block descriptor offset in PEB [out]
+ * @write_offset: write offset for written block descriptor [out]
+ *
+ * This function tries to write block descriptor into dedicated area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-E2BIG      - buffer is full.
+ */
+static
+int ssdfs_peb_write_block_descriptor(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req,
+					struct ssdfs_block_descriptor *desc,
+					struct ssdfs_peb_phys_offset *data_off,
+					struct ssdfs_peb_phys_offset *off,
+					u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	int area_type = SSDFS_LOG_BLK_DESC_AREA;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_peb_area_metadata *metadata;
+	struct ssdfs_peb_temp_buffer *buf;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	struct page *page;
+	pgoff_t page_index;
+	u32 page_off;
+	int id;
+	int items_count, capacity;
+	u16 flags;
+	bool is_buffer_full = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req || !desc || !off || !write_offset);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, processed_blks %d\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	flags = fsi->metadata_options.blk2off_tbl.flags;
+
+	area = &pebi->current_log.area[area_type];
+	metadata = &area->metadata;
+	items_count = metadata->area.blk_desc.items_count;
+	capacity = metadata->area.blk_desc.capacity;
+
+	if (items_count < 1) {
+		SSDFS_ERR("block descriptor is not reserved\n");
+		return -ERANGE;
+	}
+
+	*write_offset = ssdfs_peb_correct_area_write_offset(area->write_offset,
+							    blk_desc_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area->write_offset %u, write_offset %u\n",
+		  area->write_offset, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+		buf = &metadata->area.blk_desc.flush_buf;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		if (buf->write_offset % blk_desc_size) {
+			SSDFS_ERR("invalid write_offset %u\n",
+				  buf->write_offset);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if ((buf->write_offset + buf->granularity) > buf->size) {
+			SSDFS_ERR("buffer is full: "
+				  "write_offset %u, granularity %zu, "
+				  "size %zu\n",
+				  buf->write_offset,
+				  buf->granularity,
+				  buf->size);
+
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!buf->ptr);
+
+		if (buf->granularity != blk_desc_size) {
+			SSDFS_ERR("invalid granularity: "
+				  "granularity %zu, item_size %zu\n",
+				  buf->granularity, blk_desc_size);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_memcpy(buf->ptr, buf->write_offset, buf->size,
+				   desc, 0, blk_desc_size,
+				   blk_desc_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: "
+				  "write_offset %u, blk_desc_size %zu, "
+				  "err %d\n",
+				  buf->write_offset, blk_desc_size, err);
+			return err;
+		}
+
+		buf->write_offset += blk_desc_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("buf->write_offset %u, buf->size %zu\n",
+			  buf->write_offset, buf->size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (buf->write_offset == buf->size) {
+			err = ssdfs_peb_realloc_write_buffer(buf);
+			if (err == -E2BIG) {
+				err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("buffer is full: "
+					  "write_offset %u, size %zu\n",
+					  buf->write_offset,
+					  buf->size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				is_buffer_full = true;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to reallocate buffer: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+	} else {
+		page_index = *write_offset / PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("area->write_offset %u, blk_desc_size %zu, "
+			  "write_offset %u, page_index %lu\n",
+			  area->write_offset, blk_desc_size,
+			  *write_offset, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = ssdfs_page_array_grab_page(&area->array, page_index);
+		if (IS_ERR_OR_NULL(page)) {
+			SSDFS_ERR("fail to get page %lu for area %#x\n",
+				  page_index, area_type);
+			return -ERANGE;
+		}
+
+		page_off = *write_offset % PAGE_SIZE;
+
+		err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+					   desc, 0, blk_desc_size,
+					   blk_desc_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: "
+				  "page_off %u, blk_desc_size %zu, err %d\n",
+				  page_off, blk_desc_size, err);
+			goto finish_copy;
+		}
+
+		SetPageUptodate(page);
+
+		err = ssdfs_page_array_set_page_dirty(&area->array,
+							page_index);
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
+		if (unlikely(err))
+			return err;
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
+	/* Prepare block descriptor's offset in PEB */
+	off->peb_index = pebi->peb_index;
+	off->peb_migration_id = (u8)id;
+	off->peb_page = data_off->peb_page;
+	off->log_area = area_type;
+	off->byte_offset = *write_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_id %llu, "
+		  "peb_index %u, peb_page %u, "
+		  "log_area %#x, byte_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  le16_to_cpu(off->peb_index),
+		  le16_to_cpu(off->peb_page),
+		  off->log_area,
+		  le32_to_cpu(off->byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area->write_offset = *write_offset + blk_desc_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area->write_offset %u, write_offset %u\n",
+		  area->write_offset, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_buffer_full)
+		return -E2BIG;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_compress_blk_descs_fragment() - compress block descriptor fragment
+ * @pebi: pointer on PEB object
+ * @uncompr_size: size of uncompressed fragment
+ * @compr_size: size of compressed fragment [out]
+ *
+ * This function tries to compress block descriptor fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to get fragment descriptor.
+ */
+static
+int ssdfs_peb_compress_blk_descs_fragment(struct ssdfs_peb_info *pebi,
+					  size_t uncompr_size,
+					  size_t *compr_size)
+{
+	struct ssdfs_fs_info *fsi;
+	int area_type = SSDFS_LOG_BLK_DESC_AREA;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_peb_temp_buffer *buf;
+	struct page *page;
+	pgoff_t page_index;
+	unsigned char *kaddr;
+	u32 page_off;
+	u8 compr_type;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !compr_size);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	area = &pebi->current_log.area[area_type];
+	buf = &area->metadata.area.blk_desc.flush_buf;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "compressed_offset %u, write_offset %u, "
+		  "uncompr_size %zu\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  area->compressed_offset,
+		  area->write_offset,
+		  uncompr_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (uncompr_size > buf->size) {
+		SSDFS_ERR("uncompr_size %zu > buf->size %zu\n",
+			  uncompr_size, buf->size);
+		return -ERANGE;
+	}
+
+	switch (fsi->metadata_options.blk2off_tbl.compression) {
+	case SSDFS_BLK2OFF_TBL_NOCOMPR_TYPE:
+		compr_type = SSDFS_COMPR_NONE;
+		break;
+	case SSDFS_BLK2OFF_TBL_ZLIB_COMPR_TYPE:
+		compr_type = SSDFS_COMPR_ZLIB;
+		break;
+	case SSDFS_BLK2OFF_TBL_LZO_COMPR_TYPE:
+		compr_type = SSDFS_COMPR_LZO;
+		break;
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!buf->ptr);
+
+	SSDFS_DBG("BUF DUMP: size %zu\n",
+		  buf->size);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     buf->ptr,
+			     buf->size);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = area->compressed_offset / PAGE_SIZE;
+
+	page = ssdfs_page_array_grab_page(&area->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get page %lu for area %#x\n",
+			  page_index, area_type);
+		return -ERANGE;
+	}
+
+	page_off = area->compressed_offset % PAGE_SIZE;
+	*compr_size = PAGE_SIZE - page_off;
+
+	kaddr = kmap_local_page(page);
+	err = ssdfs_compress(compr_type,
+			     buf->ptr, (u8 *)kaddr + page_off,
+			     &uncompr_size, compr_size);
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+
+	if (err == -E2BIG) {
+		void *compr_buf = NULL;
+		u32 copy_len;
+
+		compr_buf = ssdfs_flush_kzalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!compr_buf) {
+			SSDFS_ERR("fail to allocate buffer\n");
+			return -ENOMEM;
+		}
+
+		*compr_size = PAGE_SIZE;
+		err = ssdfs_compress(compr_type,
+				     buf->ptr, compr_buf,
+				     &uncompr_size, compr_size);
+		if (err) {
+			SSDFS_ERR("fail to compress fragment: "
+				  "data_bytes %zu, free_space %zu, "
+				  "err %d\n",
+				  uncompr_size, *compr_size, err);
+			goto free_compr_buf;
+		}
+
+		copy_len = PAGE_SIZE - page_off;
+
+		err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+					   compr_buf, 0, PAGE_SIZE,
+					   copy_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto free_compr_buf;
+		}
+
+		SetPageUptodate(page);
+
+		err = ssdfs_page_array_set_page_dirty(&area->array,
+							page_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: "
+				  "err %d\n",
+				  page_index, err);
+		}
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+		if (unlikely(err))
+			goto free_compr_buf;
+
+		page_index++;
+
+		page = ssdfs_page_array_grab_page(&area->array, page_index);
+		if (IS_ERR_OR_NULL(page)) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to get page %lu for area %#x\n",
+				  page_index, area_type);
+			goto free_compr_buf;
+		}
+
+		err = ssdfs_memcpy_to_page(page, 0, PAGE_SIZE,
+					   compr_buf, copy_len, PAGE_SIZE,
+					   *compr_size - copy_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto free_compr_buf;
+		}
+
+		SetPageUptodate(page);
+
+		err = ssdfs_page_array_set_page_dirty(&area->array,
+							page_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: "
+				  "err %d\n",
+				  page_index, err);
+		}
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+		if (unlikely(err))
+			goto free_compr_buf;
+
+free_compr_buf:
+		ssdfs_flush_kfree(compr_buf);
+
+		if (unlikely(err))
+			return err;
+	} else if (err) {
+		SSDFS_ERR("fail to compress fragment: "
+			  "data_bytes %zu, free_space %zu, err %d\n",
+			  uncompr_size, *compr_size, err);
+		return err;
+	} else {
+		SetPageUptodate(page);
+
+		err = ssdfs_page_array_set_page_dirty(&area->array,
+							page_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: "
+				  "err %d\n",
+				  page_index, err);
+		}
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+		if (unlikely(err))
+			return err;
+	}
+
+	memset(buf->ptr, 0, buf->size);
+	buf->write_offset = 0;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_compressed_block_descriptor() - store block descriptor
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @blk_desc: block descriptor
+ * @data_off: offset to data in PEB [in]
+ * @desc_off: offset to block descriptor in PEB [out]
+ *
+ * This function tries to compress and to store block descriptor
+ * into dedicated area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to get fragment descriptor.
+ */
+static
+int ssdfs_peb_store_compressed_block_descriptor(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req,
+					struct ssdfs_block_descriptor *blk_desc,
+					struct ssdfs_peb_phys_offset *data_off,
+					struct ssdfs_peb_phys_offset *desc_off)
+{
+	struct ssdfs_fs_info *fsi;
+	int area_type = SSDFS_LOG_BLK_DESC_AREA;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_peb_temp_buffer *buf;
+	struct ssdfs_fragments_chain_header *chain_hdr;
+	struct ssdfs_fragment_desc *meta_desc;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	u32 write_offset = 0;
+	u32 old_offset;
+	u16 bytes_count;
+	u16 fragments_count;
+	size_t compr_size = 0;
+	u8 fragment_type = SSDFS_DATA_BLK_DESC;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req || !blk_desc || !data_off || !desc_off);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "logical_offset %llu, processed_blks %d\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	area = &pebi->current_log.area[area_type];
+	buf = &area->metadata.area.blk_desc.flush_buf;
+	chain_hdr = &area->metadata.area.blk_desc.table.chain_hdr;
+	fragments_count = le16_to_cpu(chain_hdr->fragments_count);
+
+	switch (fsi->metadata_options.blk2off_tbl.compression) {
+	case SSDFS_BLK2OFF_TBL_NOCOMPR_TYPE:
+		fragment_type = SSDFS_DATA_BLK_DESC;
+		break;
+	case SSDFS_BLK2OFF_TBL_ZLIB_COMPR_TYPE:
+		fragment_type = SSDFS_DATA_BLK_DESC_ZLIB;
+		break;
+	case SSDFS_BLK2OFF_TBL_LZO_COMPR_TYPE:
+		fragment_type = SSDFS_DATA_BLK_DESC_LZO;
+		break;
+	default:
+		BUG();
+	}
+
+	if (fragments_count == 0) {
+		meta_desc = ssdfs_peb_get_area_free_frag_desc(pebi, area_type);
+		if (IS_ERR(meta_desc)) {
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  (int)PTR_ERR(meta_desc));
+			return PTR_ERR(meta_desc);
+		} else if (!meta_desc) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  err);
+			return err;
+		}
+
+		meta_desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+		meta_desc->type = fragment_type;
+		meta_desc->flags = SSDFS_FRAGMENT_HAS_CSUM;
+		meta_desc->offset = cpu_to_le32(area->compressed_offset);
+		meta_desc->checksum = 0;
+	} else {
+		meta_desc = ssdfs_peb_get_area_cur_frag_desc(pebi, area_type);
+		if (IS_ERR(meta_desc)) {
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  (int)PTR_ERR(meta_desc));
+			return PTR_ERR(meta_desc);
+		} else if (!meta_desc) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	old_offset = le32_to_cpu(meta_desc->offset);
+	bytes_count = le16_to_cpu(meta_desc->uncompr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("old_offset %u, bytes_count %u\n",
+		  old_offset, bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_prepare_block_descriptor(pebi, req, data_off,
+						 blk_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare block descriptor: "
+			  "ino %llu, logical_offset %llu, "
+			  "processed_blks %d, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->result.processed_blks, err);
+		return err;
+	}
+
+	err = ssdfs_peb_write_block_descriptor(pebi, req, blk_desc,
+						data_off, desc_off,
+						&write_offset);
+	if (err == -E2BIG) {
+		/*
+		 * continue logic
+		 */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to write block descriptor: "
+			  "ino %llu, logical_offset %llu, "
+			  "processed_blks %d, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->result.processed_blks, err);
+		return err;
+	}
+
+	bytes_count += blk_desc_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("bytes_count %u\n",
+		  bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!buf->ptr);
+
+		if (buf->write_offset != buf->size) {
+			SSDFS_ERR("invalid request: "
+				  "buf->write_offset %u, buf->size %zu\n",
+				  buf->write_offset, buf->size);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (bytes_count > buf->size) {
+			SSDFS_ERR("invalid size: "
+				  "bytes_count %u > buf->size %zu\n",
+				  bytes_count, buf->size);
+			return -ERANGE;
+		}
+
+		meta_desc->checksum = ssdfs_crc32_le(buf->ptr, bytes_count);
+
+		if (le32_to_cpu(meta_desc->checksum) == 0) {
+			SSDFS_WARN("checksum is invalid: "
+				   "seg %llu, peb %llu, ino %llu, "
+				   "logical_offset %llu, processed_blks %d, "
+				   "bytes_count %u\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_id,
+				   req->extent.ino,
+				   req->extent.logical_offset,
+				   req->result.processed_blks,
+				   bytes_count);
+			return -ERANGE;
+		}
+
+		err = ssdfs_peb_compress_blk_descs_fragment(pebi,
+							    bytes_count,
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
+		WARN_ON(bytes_count > U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+		meta_desc->uncompr_size = cpu_to_le16((u16)bytes_count);
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
+
+		if (fragments_count == SSDFS_NEXT_BLK_TABLE_INDEX) {
+			err = ssdfs_peb_store_area_block_table(pebi, area_type,
+						SSDFS_MULTIPLE_HDR_CHAIN);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to store area's block table: "
+					  "area %#x, err %d\n",
+					  area_type, err);
+				return err;
+			}
+
+			err = ssdfs_peb_allocate_area_block_table(pebi,
+								  area_type);
+			if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("log is full, "
+					  "unable to add next fragments chain: "
+					  "area %#x\n",
+					  area_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return err;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to add next fragments chain: "
+					  "area %#x\n",
+					  area_type);
+				return err;
+			}
+		}
+
+		meta_desc = ssdfs_peb_get_area_free_frag_desc(pebi, area_type);
+		if (IS_ERR(meta_desc)) {
+			SSDFS_ERR("fail to get vacant fragment descriptor: "
+				  "err %d\n",
+				  (int)PTR_ERR(meta_desc));
+			return PTR_ERR(meta_desc);
+		} else if (!meta_desc) {
+			SSDFS_ERR("fail to get fragment descriptor: "
+				  "area_type %#x\n",
+				  area_type);
+			return -ERANGE;
+		}
+
+		meta_desc->offset = cpu_to_le32(area->compressed_offset);
+		meta_desc->compr_size = cpu_to_le16(0);
+		meta_desc->uncompr_size = cpu_to_le16(0);
+		meta_desc->checksum = 0;
+
+		if (area->metadata.sequence_id == U8_MAX)
+			area->metadata.sequence_id = 0;
+
+		meta_desc->sequence_id = area->metadata.sequence_id++;
+
+		meta_desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+		meta_desc->type = fragment_type;
+		meta_desc->flags = SSDFS_FRAGMENT_HAS_CSUM;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_offset %u, write_offset %u, bytes_count %u\n",
+			  old_offset, area->compressed_offset, bytes_count);
+		SSDFS_DBG("fragments_count %u, fragment (offset %u, "
+			  "compr_size %u, sequence_id %u, type %#x)\n",
+			  le16_to_cpu(chain_hdr->fragments_count),
+			  le32_to_cpu(meta_desc->offset),
+			  le16_to_cpu(meta_desc->compr_size),
+			  meta_desc->sequence_id,
+			  meta_desc->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		BUG_ON(bytes_count >= U16_MAX);
+
+		meta_desc->uncompr_size = cpu_to_le16((u16)bytes_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_offset %u, write_offset %u, bytes_count %u\n",
+			  old_offset, write_offset, bytes_count);
+		SSDFS_DBG("fragments_count %u, fragment (offset %u, "
+			  "uncompr_size %u, sequence_id %u, type %#x)\n",
+			  le16_to_cpu(chain_hdr->fragments_count),
+			  le32_to_cpu(meta_desc->offset),
+			  le16_to_cpu(meta_desc->uncompr_size),
+			  meta_desc->sequence_id,
+			  meta_desc->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	le32_add_cpu(&chain_hdr->uncompr_bytes, (u32)blk_desc_size);
+
+	return 0;
+}
+
+/*
+ * __ssdfs_peb_store_block_descriptor() - store block descriptor into area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @blk_desc: block descriptor
+ * @data_off: offset to data in PEB [in]
+ * @desc_off: offset to block descriptor in PEB [out]
+ *
+ * This function tries to store block descriptor into dedicated area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to get fragment descriptor.
+ */
+static
+int __ssdfs_peb_store_block_descriptor(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_block_descriptor *blk_desc,
+				struct ssdfs_peb_phys_offset *data_off,
+				struct ssdfs_peb_phys_offset *desc_off)
+{
+	int area_type = SSDFS_LOG_BLK_DESC_AREA;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_fragments_chain_header *chain_hdr;
+	struct ssdfs_fragment_desc *meta_desc;
+	u32 write_offset, old_offset;
+	u32 old_page_index, new_page_index;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	u16 bytes_count;
+	u16 fragments_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req || !blk_desc || !data_off || !desc_off);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "logical_offset %llu, processed_blks %d\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area = &pebi->current_log.area[area_type];
+	chain_hdr = &area->metadata.area.blk_desc.table.chain_hdr;
+	fragments_count = le16_to_cpu(chain_hdr->fragments_count);
+
+	if (fragments_count == 0) {
+		meta_desc = ssdfs_peb_get_area_free_frag_desc(pebi, area_type);
+		if (IS_ERR(meta_desc)) {
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  (int)PTR_ERR(meta_desc));
+			return PTR_ERR(meta_desc);
+		} else if (!meta_desc) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  err);
+			return err;
+		}
+
+		meta_desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+		meta_desc->type = SSDFS_DATA_BLK_DESC;
+		meta_desc->flags = 0;
+		meta_desc->offset = cpu_to_le32(area->write_offset);
+		meta_desc->checksum = 0;
+	} else {
+		meta_desc = ssdfs_peb_get_area_cur_frag_desc(pebi, area_type);
+		if (IS_ERR(meta_desc)) {
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  (int)PTR_ERR(meta_desc));
+			return PTR_ERR(meta_desc);
+		} else if (!meta_desc) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to get current fragment descriptor: "
+				  "err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	old_offset = le32_to_cpu(meta_desc->offset);
+	old_page_index = old_offset / PAGE_SIZE;
+	new_page_index = area->write_offset / PAGE_SIZE;
+	bytes_count = le16_to_cpu(meta_desc->compr_size);
+
+	if (old_page_index != new_page_index &&
+	    fragments_count == SSDFS_NEXT_BLK_TABLE_INDEX) {
+		err = ssdfs_peb_store_area_block_table(pebi, area_type,
+						SSDFS_MULTIPLE_HDR_CHAIN);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store area's block table: "
+				  "area %#x, err %d\n",
+				  area_type, err);
+			return err;
+		}
+
+		err = ssdfs_peb_allocate_area_block_table(pebi,
+							  area_type);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("log is full, "
+				  "unable to add next fragments chain: "
+				  "area %#x\n",
+				  area_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to add next fragments chain: "
+				  "area %#x\n",
+				  area_type);
+			return err;
+		}
+	}
+
+	err = ssdfs_peb_prepare_block_descriptor(pebi, req, data_off,
+						 blk_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare block descriptor: "
+			  "ino %llu, logical_offset %llu, "
+			  "processed_blks %d, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->result.processed_blks, err);
+		return err;
+	}
+
+	err = ssdfs_peb_write_block_descriptor(pebi, req, blk_desc,
+						data_off, desc_off,
+						&write_offset);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to write block descriptor: "
+			  "ino %llu, logical_offset %llu, "
+			  "processed_blks %d, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->result.processed_blks, err);
+		return err;
+	}
+
+	new_page_index = write_offset / PAGE_SIZE;
+
+	if (old_page_index == new_page_index) {
+		bytes_count += blk_desc_size;
+
+		BUG_ON(bytes_count >= U16_MAX);
+
+		meta_desc->compr_size = cpu_to_le16((u16)bytes_count);
+		meta_desc->uncompr_size = cpu_to_le16((u16)bytes_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_offset %u, write_offset %u, bytes_count %u\n",
+			  old_offset, write_offset, bytes_count);
+		SSDFS_DBG("fragments_count %u, fragment (offset %u, "
+			  "compr_size %u, sequence_id %u, type %#x)\n",
+			  le16_to_cpu(chain_hdr->fragments_count),
+			  le32_to_cpu(meta_desc->offset),
+			  le16_to_cpu(meta_desc->compr_size),
+			  meta_desc->sequence_id,
+			  meta_desc->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		meta_desc = ssdfs_peb_get_area_free_frag_desc(pebi, area_type);
+		if (IS_ERR(meta_desc)) {
+			SSDFS_ERR("fail to get vacant fragment descriptor: "
+				  "err %d\n",
+				  (int)PTR_ERR(meta_desc));
+			return PTR_ERR(meta_desc);
+		} else if (!meta_desc) {
+			SSDFS_ERR("fail to get fragment descriptor: "
+				  "area_type %#x\n",
+				  area_type);
+			return -ERANGE;
+		}
+
+		meta_desc->offset = cpu_to_le32(write_offset);
+		meta_desc->compr_size = cpu_to_le16(blk_desc_size);
+		meta_desc->uncompr_size = cpu_to_le16(blk_desc_size);
+		meta_desc->checksum = 0;
+
+		if (area->metadata.sequence_id == U8_MAX)
+			area->metadata.sequence_id = 0;
+
+		meta_desc->sequence_id = area->metadata.sequence_id++;
+
+		meta_desc->magic = SSDFS_FRAGMENT_DESC_MAGIC;
+		meta_desc->type = SSDFS_DATA_BLK_DESC;
+		meta_desc->flags = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_offset %u, write_offset %u, bytes_count %u\n",
+			  old_offset, write_offset, bytes_count);
+		SSDFS_DBG("fragments_count %u, fragment (offset %u, "
+			  "compr_size %u, sequence_id %u, type %#x)\n",
+			  le16_to_cpu(chain_hdr->fragments_count),
+			  le32_to_cpu(meta_desc->offset),
+			  le16_to_cpu(meta_desc->compr_size),
+			  meta_desc->sequence_id,
+			  meta_desc->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	le32_add_cpu(&chain_hdr->compr_bytes, (u32)blk_desc_size);
+	le32_add_cpu(&chain_hdr->uncompr_bytes, (u32)blk_desc_size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_block_descriptor() - store block descriptor into area
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ * @blk_desc: block descriptor
+ * @data_off: offset to data in PEB [in]
+ * @desc_off: offset to block descriptor in PEB [out]
+ *
+ * This function tries to store block descriptor into dedicated area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to get fragment descriptor.
+ */
+static
+int ssdfs_peb_store_block_descriptor(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_block_descriptor *blk_desc,
+				struct ssdfs_peb_phys_offset *data_off,
+				struct ssdfs_peb_phys_offset *desc_off)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req || !blk_desc || !data_off || !desc_off);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu, ino %llu, "
+		  "logical_offset %llu, processed_blks %d\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	flags = fsi->metadata_options.blk2off_tbl.flags;
+
+	if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+		err = ssdfs_peb_store_compressed_block_descriptor(pebi, req,
+								  blk_desc,
+								  data_off,
+								  desc_off);
+	} else {
+		err = __ssdfs_peb_store_block_descriptor(pebi, req,
+							  blk_desc,
+							  data_off,
+							  desc_off);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block descriptor: "
+			  "seg %llu, peb %llu, ino %llu, "
+			  "logical_offset %llu, processed_blks %d, "
+			  "err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->result.processed_blks,
+			  err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_store_block_descriptor_offset() - store offset in blk2off table
+ * @pebi: pointer on PEB object
+ * @logical_offset: offset in pages from file's begin
+ * @logical_blk: segment's logical block
+ * @blk_desc: block descriptor
+ * @off: pointer on block descriptor offset
+ */
+static
+int ssdfs_peb_store_block_descriptor_offset(struct ssdfs_peb_info *pebi,
+					u32 logical_offset,
+					u16 logical_blk,
+					struct ssdfs_block_descriptor *blk_desc,
+					struct ssdfs_peb_phys_offset *off)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_phys_offset_descriptor blk_desc_off;
+	struct ssdfs_blk2off_table *table;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!off);
+	BUG_ON(logical_blk == U16_MAX);
+
+	SSDFS_DBG("seg %llu, peb %llu, logical_offset %u, "
+		  "logical_blk %u, area_type %#x,"
+		  "peb_index %u, peb_page %u, byte_offset %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, logical_offset, logical_blk,
+		  off->log_area, off->peb_index,
+		  off->peb_page, off->byte_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	blk_desc_off.page_desc.logical_offset = cpu_to_le32(logical_offset);
+	blk_desc_off.page_desc.logical_blk = cpu_to_le16(logical_blk);
+	blk_desc_off.page_desc.peb_page = cpu_to_le16(off->peb_page);
+
+	blk_desc_off.blk_state.log_start_page =
+		cpu_to_le16(pebi->current_log.start_page);
+	blk_desc_off.blk_state.log_area = off->log_area;
+	blk_desc_off.blk_state.peb_migration_id = off->peb_migration_id;
+	blk_desc_off.blk_state.byte_offset = cpu_to_le32(off->byte_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PHYS OFFSET: logical_offset %u, logical_blk %u, "
+		  "peb_page %u, log_start_page %u, "
+		  "log_area %u, peb_migration_id %u, "
+		  "byte_offset %u\n",
+		  logical_offset, logical_blk,
+		  off->peb_page, pebi->current_log.start_page,
+		  off->log_area, off->peb_migration_id,
+		  off->byte_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	table = pebi->pebc->parent_si->blk2off_table;
+
+	err = ssdfs_blk2off_table_change_offset(table, logical_blk,
+						off->peb_index,
+						blk_desc,
+						&blk_desc_off);
+	if (err == -EAGAIN) {
+		struct completion *end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_blk2off_table_change_offset(table, logical_blk,
+							off->peb_index,
+							blk_desc,
+							&blk_desc_off);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change offset: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_peb_create_block() - create data block
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to create data block in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_peb_create_block(struct ssdfs_peb_info *pebi,
+			     struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_phys_offset_descriptor *blk_desc_off = NULL;
+	struct ssdfs_block_descriptor blk_desc = {0};
+	struct ssdfs_peb_phys_offset data_off = {0};
+	struct ssdfs_peb_phys_offset desc_off = {0};
+	struct ssdfs_offset_position pos = {0};
+	u16 logical_block;
+	int processed_blks;
+	u64 logical_offset;
+	struct ssdfs_block_bmap_range range;
+	u32 rest_bytes, written_bytes;
+	u32 len;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.len >= U16_MAX);
+	BUG_ON(req->result.processed_blks > req->place.len);
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
+	processed_blks = req->result.processed_blks;
+	logical_block = req->place.start.blk_index + processed_blks;
+	rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+	logical_offset = req->extent.logical_offset +
+				((u64)processed_blks * fsi->pagesize);
+	logical_offset /= fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, logical_block %u, "
+		  "logical_offset %llu, "
+		  "processed_blks %d, rest_size %u\n",
+		  req->place.start.seg_id, pebi->peb_id,
+		  logical_block, logical_offset,
+		  processed_blks, rest_bytes);
+
+	BUG_ON(logical_offset >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_reserve_block_descriptor(pebi, req);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to add block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id, logical_block,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve block descriptor: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id, logical_block,
+			  pebi->peb_id, err);
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
+			  req->place.start.seg_id, logical_block,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to add block: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id, logical_block,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	len = (written_bytes + fsi->pagesize - 1) >> fsi->log_pagesize;
+
+	if (!is_ssdfs_block_full(fsi->pagesize, written_bytes)) {
+		err = ssdfs_segment_blk_bmap_pre_allocate(&si->blk_bmap,
+							  pebi->pebc,
+							  &len,
+							  &range);
+	} else {
+		err = ssdfs_segment_blk_bmap_allocate(&si->blk_bmap,
+							pebi->pebc,
+							&len,
+							&range);
+	}
+
+	if (err == -ENOSPC) {
+		SSDFS_DBG("block bitmap hasn't free space\n");
+		return err;
+	} else if (unlikely(err || (len != range.len))) {
+		SSDFS_ERR("fail to allocate range: "
+			  "seg %llu, peb %llu, "
+			  "range (start %u, len %u), err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  range.start, range.len, err);
+		return err;
+	}
+
+	data_off.peb_page = (u16)range.start;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, peb_page %u\n",
+		  logical_block, range.start);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	SSDFS_BLK_DESC_INIT(&blk_desc);
+
+	err = ssdfs_peb_store_block_descriptor(pebi, req,
+						&blk_desc, &data_off,
+						&desc_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block descriptor: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id, logical_block,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	err = ssdfs_peb_store_block_descriptor_offset(pebi, (u32)logical_offset,
+						      logical_block,
+						      &blk_desc, &desc_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store block descriptor offset: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	req->result.processed_blks += range.len;
+	return 0;
+}
+
+/*
+ * ssdfs_peb_create_block() - create data block
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to create data block in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_create_block(struct ssdfs_peb_info *pebi,
+			   struct ssdfs_segment_request *req)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+	switch (req->private.class) {
+	case SSDFS_PEB_CREATE_DATA_REQ:
+	case SSDFS_PEB_CREATE_LNODE_REQ:
+	case SSDFS_PEB_CREATE_HNODE_REQ:
+	case SSDFS_PEB_CREATE_IDXNODE_REQ:
+		/* expected state */
+		break;
+	default:
+		BUG();
+	};
+	BUG_ON(req->private.cmd != SSDFS_CREATE_BLOCK);
+	BUG_ON(req->private.type >= SSDFS_REQ_TYPE_MAX);
+	BUG_ON(atomic_read(&req->private.refs_count) == 0);
+	BUG_ON(req->extent.data_bytes > pebi->pebc->parent_si->fsi->pagesize);
+	BUG_ON(req->result.processed_blks > 0);
+
+	SSDFS_DBG("ino %llu, seg %llu, peb %llu, logical_offset %llu, "
+		  "logical_block %u, data_bytes %u, cno %llu, "
+		  "parent_snapshot %llu, cmd %#x, type %#x\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->extent.logical_offset, req->place.start.blk_index,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_peb_create_block(pebi, req);
+	if (err == -ENOSPC) {
+		SSDFS_DBG("block bitmap hasn't free space\n");
+		return err;
+	} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to create block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to create block: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_create_extent() - create extent
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to create extent of data blocks in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_create_extent(struct ssdfs_peb_info *pebi,
+			    struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 rest_bytes;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+	switch (req->private.class) {
+	case SSDFS_PEB_CREATE_DATA_REQ:
+	case SSDFS_PEB_CREATE_LNODE_REQ:
+	case SSDFS_PEB_CREATE_HNODE_REQ:
+	case SSDFS_PEB_CREATE_IDXNODE_REQ:
+		/* expected state */
+		break;
+	default:
+		BUG();
+	};
+	BUG_ON(req->private.cmd != SSDFS_CREATE_EXTENT);
+	BUG_ON(req->private.type >= SSDFS_REQ_TYPE_MAX);
+	BUG_ON(atomic_read(&req->private.refs_count) == 0);
+
+	SSDFS_DBG("peb %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu"
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
+	fsi = pebi->pebc->parent_si->fsi;
+	rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+
+	while (rest_bytes > 0) {
+		u32 logical_block = req->place.start.blk_index +
+					req->result.processed_blks;
+
+		err = __ssdfs_peb_create_block(pebi, req);
+		if (err == -ENOSPC) {
+			SSDFS_DBG("block bitmap hasn't free space\n");
+			return err;
+		} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try again to create block: "
+				  "seg %llu, logical_block %u, peb %llu\n",
+				  req->place.start.seg_id, logical_block,
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create block: "
+				  "seg %llu, logical_block %u, "
+				  "peb %llu, err %d\n",
+				  req->place.start.seg_id, logical_block,
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
+ * __ssdfs_peb_pre_allocate_extent() - pre-allocate extent
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to pre-allocate an extent of blocks in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_peb_pre_allocate_extent(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_phys_offset desc_off = {0};
+	u16 logical_block;
+	int processed_blks;
+	u64 logical_offset;
+	struct ssdfs_block_bmap_range range;
+	u32 rest_bytes;
+	u32 len;
+	u8 id;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
+	BUG_ON(req->extent.data_bytes <
+		(req->result.processed_blks *
+			pebi->pebc->parent_si->fsi->pagesize));
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.len >= U16_MAX);
+	BUG_ON(req->result.processed_blks > req->place.len);
+	WARN_ON(pagevec_count(&req->result.pvec) != 0);
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
+	processed_blks = req->result.processed_blks;
+	logical_block = req->place.start.blk_index + processed_blks;
+	rest_bytes = ssdfs_request_rest_bytes(pebi, req);
+	logical_offset = req->extent.logical_offset +
+				((u64)processed_blks * fsi->pagesize);
+	logical_offset /= fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, logical_block %u, "
+		  "logical_offset %llu, "
+		  "processed_blks %d, rest_size %u\n",
+		  req->place.start.seg_id, pebi->peb_id,
+		  logical_block, logical_offset,
+		  processed_blks, rest_bytes);
+
+	if (req->extent.logical_offset >= U64_MAX) {
+		SSDFS_ERR("seg %llu, peb %llu, logical_block %u, "
+			  "logical_offset %llu, "
+			  "processed_blks %d, rest_size %u\n",
+			  req->place.start.seg_id, pebi->peb_id,
+			  logical_block, logical_offset,
+			  processed_blks, rest_bytes);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	len = req->extent.data_bytes;
+	len -= req->result.processed_blks * si->fsi->pagesize;
+	len >>= fsi->log_pagesize;
+
+	err = ssdfs_segment_blk_bmap_pre_allocate(&si->blk_bmap,
+						  pebi->pebc,
+						  &len,
+						  &range);
+	if (err == -ENOSPC) {
+		SSDFS_DBG("block bitmap hasn't free space\n");
+		return err;
+	} else if (unlikely(err || (len != range.len))) {
+		SSDFS_ERR("fail to allocate range: "
+			  "seg %llu, peb %llu, "
+			  "range (start %u, len %u), err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  range.start, range.len, err);
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
+	for (i = 0; i < range.len; i++) {
+		desc_off.peb_index = pebi->peb_index;
+		desc_off.peb_migration_id = id;
+		desc_off.peb_page = (u16)(range.start + i);
+		desc_off.log_area = SSDFS_LOG_AREA_MAX;
+		desc_off.byte_offset = U32_MAX;
+
+		logical_block += i;
+		logical_offset += i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, peb_page %u\n",
+			  logical_block, range.start + i);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_peb_store_block_descriptor_offset(pebi,
+							(u32)logical_offset,
+							logical_block,
+							NULL,
+							&desc_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store block descriptor offset: "
+				  "logical_block %u, logical_offset %llu, "
+				  "err %d\n",
+				  logical_block, logical_offset, err);
+			return err;
+		}
+	}
+
+	req->result.processed_blks += range.len;
+	return 0;
+}
+
+/*
+ * ssdfs_peb_pre_allocate_block() - pre-allocate block
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to pre-allocate a block in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_pre_allocate_block(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req)
+{
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
+	case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
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
+	case SSDFS_CREATE_BLOCK:
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
+		  "logical_block %u, data_bytes %u, cno %llu, "
+		  "parent_snapshot %llu, cmd %#x, type %#x\n",
+		  req->extent.ino, req->place.start.seg_id, pebi->peb_id,
+		  req->extent.logical_offset, req->place.start.blk_index,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot,
+		  req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_peb_pre_allocate_extent(pebi, req);
+	if (err == -ENOSPC) {
+		SSDFS_DBG("block bitmap hasn't free space\n");
+		return err;
+	} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to pre-allocate block: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-allocate block: "
+			  "seg %llu, logical_block %u, peb %llu, err %d\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_pre_allocate_extent() - pre-allocate extent
+ * @pebi: pointer on PEB object
+ * @req: I/O request
+ *
+ * This function tries to pre-allocate an extent of blocks in PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_pre_allocate_extent(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_segment_request *req)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !req);
+	BUG_ON(!pebi->pebc->parent_si || !pebi->pebc->parent_si->fsi);
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
+	BUG_ON(req->place.start.seg_id != pebi->pebc->parent_si->seg_id);
+	BUG_ON(req->place.start.blk_index >=
+		pebi->pebc->parent_si->fsi->pages_per_seg);
+
+	switch (req->private.class) {
+	case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
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
+	case SSDFS_CREATE_EXTENT:
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
+	BUG_ON((req->extent.data_bytes /
+		pebi->pebc->parent_si->fsi->pagesize) < 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_peb_pre_allocate_extent(pebi, req);
+	if (err == -ENOSPC) {
+		SSDFS_DBG("block bitmap hasn't free space\n");
+		return err;
+	} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try again to pre-allocate extent: "
+			  "seg %llu, logical_block %u, peb %llu\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-allocate extent: "
+			  "seg %llu, logical_block %u, peb %llu, "
+			  "ino %llu, logical_offset %llu, err %d\n",
+			  req->place.start.seg_id,
+			  req->place.start.blk_index,
+			  pebi->peb_id, req->extent.ino,
+			  req->extent.logical_offset, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_process_create_request() - process create request
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
+ */
+static
+int ssdfs_process_create_request(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req)
+{
+	struct ssdfs_segment_info *si;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x\n",
+		  req, req->private.cmd, req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (req->private.cmd <= SSDFS_READ_CMD_MAX ||
+	    req->private.cmd >= SSDFS_CREATE_CMD_MAX) {
+		SSDFS_ERR("unknown create command %d, seg %llu, peb %llu\n",
+			  req->private.cmd,
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id);
+		req->result.err = -EINVAL;
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		return -EINVAL;
+	}
+
+	atomic_set(&req->result.state, SSDFS_REQ_STARTED);
+
+	switch (req->private.cmd) {
+	case SSDFS_CREATE_BLOCK:
+		switch (req->private.class) {
+		case SSDFS_PEB_CREATE_DATA_REQ:
+		case SSDFS_PEB_CREATE_LNODE_REQ:
+		case SSDFS_PEB_CREATE_HNODE_REQ:
+		case SSDFS_PEB_CREATE_IDXNODE_REQ:
+			err = ssdfs_peb_create_block(pebi, req);
+			break;
+
+		case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+		case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+		case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+		case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
+			err = ssdfs_peb_pre_allocate_block(pebi, req);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (err == -ENOSPC) {
+			SSDFS_DBG("block bitmap hasn't free space\n");
+			return err;
+		} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try again to create block: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to create block: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_CREATE_EXTENT:
+		switch (req->private.class) {
+		case SSDFS_PEB_CREATE_DATA_REQ:
+		case SSDFS_PEB_CREATE_LNODE_REQ:
+		case SSDFS_PEB_CREATE_HNODE_REQ:
+		case SSDFS_PEB_CREATE_IDXNODE_REQ:
+			err = ssdfs_peb_create_extent(pebi, req);
+			break;
+
+		case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+		case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+		case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+		case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
+			err = ssdfs_peb_pre_allocate_extent(pebi, req);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (err == -ENOSPC) {
+			SSDFS_DBG("block bitmap hasn't free space\n");
+			return err;
+		} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try again to create extent: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to create extent: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_MIGRATE_ZONE_USER_BLOCK:
+		switch (req->private.class) {
+		case SSDFS_ZONE_USER_DATA_MIGRATE_REQ:
+			err = ssdfs_peb_create_block(pebi, req);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (err == -ENOSPC) {
+			SSDFS_DBG("block bitmap hasn't free space\n");
+			return err;
+		} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try again to migrate block: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to migrate block: "
+				"seg %llu, peb %llu, err %d\n",
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_MIGRATE_ZONE_USER_EXTENT:
+		switch (req->private.class) {
+		case SSDFS_ZONE_USER_DATA_MIGRATE_REQ:
+			err = ssdfs_peb_create_extent(pebi, req);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (err == -ENOSPC) {
+			SSDFS_DBG("block bitmap hasn't free space\n");
+			return err;
+		} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try again to migrate extent: "
+				  "seg %llu, peb %llu\n",
+				  req->place.start.seg_id, pebi->peb_id);
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
+	default:
+		BUG();
+	}
+
+	if (unlikely(err)) {
+		/* request failed */
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+	} else if ((req->private.class == SSDFS_PEB_CREATE_DATA_REQ ||
+		    req->private.class == SSDFS_ZONE_USER_DATA_MIGRATE_REQ) &&
+		   is_ssdfs_peb_containing_user_data(pebi->pebc)) {
+		int processed_blks = req->result.processed_blks;
+		u32 pending = 0;
+
+		si = pebi->pebc->parent_si;
+
+		spin_lock(&si->pending_lock);
+		pending = si->pending_new_user_data_pages;
+		if (si->pending_new_user_data_pages >= processed_blks) {
+			si->pending_new_user_data_pages -= processed_blks;
+			pending = si->pending_new_user_data_pages;
+		} else {
+			/* wrong accounting */
+			err = -ERANGE;
+		}
+		spin_unlock(&si->pending_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("pending %u < processed_blks %d\n",
+				  pending, processed_blks);
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("seg %llu, pending %u, processed_blks %d\n",
+				  si->seg_id, pending, processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+	return err;
+}
+
 /*
  * ssdfs_peb_read_from_offset() - read in buffer from offset
  * @pebi: pointer on PEB object
-- 
2.34.1

