Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9AC6A2640
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBYBRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBYBQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3061689C
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:30 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk32so762907oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fs0wji0RZdfERTWVvz/dU2Rrcm/WhP8G9lXm3559BE=;
        b=k+i9l2IX5yskL4QgdM+6IdVW432ohxSv1xbcT/yaujkf6tV/8OpjV7UtyDAe0SHTmZ
         wNpQ+HQD9cA2qnYkyQxVhQR3kSkUkf9h67VBveSRkV3SqkgxEYTFq7wPcehYd4hLLH54
         v8C0ufaKBXdRI2l7234Jd7usMfnG+Oohs2YRxQc/xWlAdMsDG76DFqdW2PMD4JratUK9
         BIJ++adyjtjv3ce7Cbt4fNEv/N8hagqNwaKQ8wWEjQQn/h4mzPDHAja4LpSIHQQLeuBZ
         H5+RjgU+F/CtLejQ6fFGfS72W/NEGyZM11sUzPTAYspDI+IClkXGfYjoukGQGatjTzOH
         6+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Fs0wji0RZdfERTWVvz/dU2Rrcm/WhP8G9lXm3559BE=;
        b=mLcFW6nZ/RlLar5RLh67OW/yyUq1gFgcJkBPZo9i93y1hcgvPYZ8PDPfHZjMc1XzOr
         BOybFaALW/AWZDGGkG+8laKC8T64EO67D1gyJpcLilqDHHLMDELQWj6jtGWiZFzfXSFZ
         APcoFlF9Mk92JLWqLJN0mkHlTcSCul/OvrEFaCx2Wu7CmWQtCMyez+TRDf2Ch1mRzcV7
         u2sE66FSa/C9M18VXXM+lRf1a6alp02o7zX1N5bRJeoOzYgZ9TnNn7ghOweZPU7nzNT0
         Q+7LWvzKa8T4AxxNg52EaL63pdwk4GqfjpYpW3l38SW43jJW96MKvE/NyBQjL81Gly96
         Nkvw==
X-Gm-Message-State: AO0yUKVRmY7HZ3SBso0u3bgwevRHGqFS0/OPvT30UQr9k1W8BPTx82Rz
        /CH5zdrBUZisuXuYDvREY6nWoPfiz08Fe/IF
X-Google-Smtp-Source: AK7set9qymfqJWpA5EXCYVIu8P3p/NfAQiDn0EMKr6ixAgNZiWuqJm36JtdKYgHpbyWcdPSWBkxbMA==
X-Received: by 2002:aca:1c0a:0:b0:384:232:2a4f with SMTP id c10-20020aca1c0a000000b0038402322a4fmr1289096oic.4.1677287789299;
        Fri, 24 Feb 2023 17:16:29 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:28 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 26/76] ssdfs: offset translation table initialization logic
Date:   Fri, 24 Feb 2023 17:08:37 -0800
Message-Id: <20230225010927.813929-27-slava@dubeyko.com>
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

Offset translation table is a metadata structure that
is stored as metadata in every log. The responsibility of
offset translation table keeps the knowledge which particular
logical blocks are stored into log's payload and which offset
in the payload should be used to access and retrieve the
content of logical block. Offset translation table can be
imagined like a sequence of fragments. Every fragment contains
array of physical offset descriptors that provides the way
to convert logical block ID into the physical offset in the log.
Initialization logic requires to read all fragments from the
volume, decompress it, and initilaize offset translation table
by fragments.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_read_thread.c | 2288 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2288 insertions(+)

diff --git a/fs/ssdfs/peb_read_thread.c b/fs/ssdfs/peb_read_thread.c
index f6a5b67612af..317eef078521 100644
--- a/fs/ssdfs/peb_read_thread.c
+++ b/fs/ssdfs/peb_read_thread.c
@@ -245,6 +245,2294 @@ int ssdfs_read_blk2off_table_fragment(struct ssdfs_peb_info *pebi,
  *                          READ THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * __ssdfs_peb_read_log_footer() - read log's footer
+ * @fsi: file system info object
+ * @pebi: PEB object
+ * @page_off: log's starting page
+ * @desc: footer's descriptor
+ * @log_bytes: pointer on value of bytes in the log [out]
+ *
+ * This function tries to read log's footer.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - valid footer is not found.
+ */
+static
+int __ssdfs_peb_read_log_footer(struct ssdfs_fs_info *fsi,
+				struct ssdfs_peb_info *pebi,
+				u16 page_off,
+				struct ssdfs_metadata_descriptor *desc,
+				u32 *log_bytes)
+{
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_partial_log_header *plh_hdr = NULL;
+	struct ssdfs_log_footer *footer = NULL;
+	u16 footer_off;
+	u32 bytes_off;
+	struct page *page;
+	void *kaddr;
+	size_t read_bytes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!desc || !log_bytes);
+
+	SSDFS_DBG("seg %llu, peb_id %llu, page_off %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*log_bytes = U32_MAX;
+
+	bytes_off = le32_to_cpu(desc->offset);
+	footer_off = bytes_off / fsi->pagesize;
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, footer_off);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		SSDFS_ERR("fail to grab page: index %u\n",
+			  footer_off);
+		return -ENOMEM;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	if (PageUptodate(page) || PageDirty(page))
+		goto check_footer_magic;
+
+	err = ssdfs_aligned_read_buffer(fsi, pebi->peb_id,
+					bytes_off,
+					(u8 *)kaddr,
+					PAGE_SIZE,
+					&read_bytes);
+	if (unlikely(err))
+		goto fail_read_footer;
+	else if (unlikely(read_bytes != PAGE_SIZE)) {
+		err = -ERANGE;
+		goto fail_read_footer;
+	}
+
+	SetPageUptodate(page);
+
+check_footer_magic:
+	magic = (struct ssdfs_signature *)kaddr;
+
+	if (!is_ssdfs_magic_valid(magic)) {
+		err = -ENODATA;
+		goto fail_read_footer;
+	}
+
+	if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+		plh_hdr = SSDFS_PLH(kaddr);
+		*log_bytes = le32_to_cpu(plh_hdr->log_bytes);
+	} else if (__is_ssdfs_log_footer_magic_valid(magic)) {
+		footer = SSDFS_LF(kaddr);
+		*log_bytes = le32_to_cpu(footer->log_bytes);
+	} else {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log footer is corrupted: "
+			  "peb %llu, page_off %u\n",
+			  pebi->peb_id, page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto fail_read_footer;
+	}
+
+fail_read_footer:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("valid footer is not detected: "
+			  "seg_id %llu, peb_id %llu, "
+			  "page_off %u\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  footer_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read footer: "
+			  "seg %llu, peb %llu, "
+			  "pages_off %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  footer_off,
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_peb_read_log_header() - read log's header
+ * @fsi: file system info object
+ * @pebi: PEB object
+ * @page_off: log's starting page
+ * @log_bytes: pointer on value of bytes in the log [out]
+ *
+ * This function tries to read the log's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - valid footer is not found.
+ */
+static
+int __ssdfs_peb_read_log_header(struct ssdfs_fs_info *fsi,
+				struct ssdfs_peb_info *pebi,
+				u16 page_off,
+				u32 *log_bytes)
+{
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	struct page *page;
+	void *kaddr;
+	size_t read_bytes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!log_bytes);
+
+	SSDFS_DBG("seg %llu, peb_id %llu, page_off %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*log_bytes = U32_MAX;
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, page_off);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		SSDFS_ERR("fail to grab page: index %u\n",
+			  page_off);
+		return -ENOMEM;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	if (PageUptodate(page) || PageDirty(page))
+		goto check_header_magic;
+
+	err = ssdfs_aligned_read_buffer(fsi, pebi->peb_id,
+					page_off * PAGE_SIZE,
+					(u8 *)kaddr,
+					PAGE_SIZE,
+					&read_bytes);
+	if (unlikely(err))
+		goto fail_read_log_header;
+	else if (unlikely(read_bytes != PAGE_SIZE)) {
+		err = -ERANGE;
+		goto fail_read_log_header;
+	}
+
+	SetPageUptodate(page);
+
+check_header_magic:
+	magic = (struct ssdfs_signature *)kaddr;
+
+	if (!is_ssdfs_magic_valid(magic)) {
+		err = -ENODATA;
+		goto fail_read_log_header;
+	}
+
+	if (__is_ssdfs_segment_header_magic_valid(magic)) {
+		seg_hdr = SSDFS_SEG_HDR(kaddr);
+
+		err = ssdfs_check_segment_header(fsi, seg_hdr,
+						 false);
+		if (unlikely(err)) {
+			err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("log header is corrupted: "
+				  "seg %llu, peb %llu, page_off %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto fail_read_log_header;
+		}
+
+		desc = &seg_hdr->desc_array[SSDFS_LOG_FOOTER_INDEX];
+
+		err = __ssdfs_peb_read_log_footer(fsi, pebi, page_off,
+						   desc, log_bytes);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fail to read footer: "
+				  "seg %llu, peb %llu, page_off %u, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  page_off,
+				  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto fail_read_log_header;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read footer: "
+				  "seg %llu, peb %llu, page_off %u, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  page_off,
+				  err);
+			goto fail_read_log_header;
+		}
+	} else if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+		pl_hdr = SSDFS_PLH(kaddr);
+
+		err = ssdfs_check_partial_log_header(fsi, pl_hdr,
+						     false);
+		if (unlikely(err)) {
+			err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("partial log header is corrupted: "
+				  "seg %llu, peb %llu, page_off %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto fail_read_log_header;
+		}
+
+		desc = &pl_hdr->desc_array[SSDFS_LOG_FOOTER_INDEX];
+
+		if (ssdfs_pl_has_footer(pl_hdr)) {
+			err = __ssdfs_peb_read_log_footer(fsi, pebi, page_off,
+							  desc, log_bytes);
+			if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("fail to read footer: "
+					  "seg %llu, peb %llu, page_off %u, "
+					  "err %d\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  page_off,
+					  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto fail_read_log_header;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to read footer: "
+					  "seg %llu, peb %llu, page_off %u, "
+					  "err %d\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  page_off,
+					  err);
+				goto fail_read_log_header;
+			}
+		} else
+			*log_bytes = le32_to_cpu(pl_hdr->log_bytes);
+	} else {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log header is corrupted: "
+			  "seg %llu, peb %llu, page_off %u\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto fail_read_log_header;
+	}
+
+fail_read_log_header:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("valid header is not detected: "
+			  "seg_id %llu, peb_id %llu, page_off %u\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read checked log header: "
+			  "seg %llu, peb %llu, "
+			  "pages_off %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  page_off, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_all_log_headers() - read all PEB's log headers
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to read all headers and footers of
+ * the PEB's logs.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_all_log_headers(struct ssdfs_peb_info *pebi,
+				   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 log_bytes = U32_MAX;
+	u32 page_off;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x, "
+		  "ino %llu, logical_offset %llu, data_bytes %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->pebc->peb_index,
+		  req->private.class, req->private.cmd, req->private.type,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	page_off = 0;
+
+	do {
+		u32 pages_per_log;
+
+		err = __ssdfs_peb_read_log_header(fsi, pebi, page_off,
+						  &log_bytes);
+		if (err == -ENODATA)
+			return 0;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to read log header: "
+				  "seg %llu, peb %llu, page_off %u, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  page_off,
+				  err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(log_bytes >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		pages_per_log = log_bytes + fsi->pagesize - 1;
+		pages_per_log /= fsi->pagesize;
+		page_off += pages_per_log;
+	} while (page_off < fsi->pages_per_peb);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_src_all_log_headers() - read all source PEB's log headers
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to read all headers and footers of
+ * the source PEB's logs.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_src_all_log_headers(struct ssdfs_peb_container *pebc,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_peb_info *pebi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->src_peb;
+	if (!pebi) {
+		SSDFS_WARN("source PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_read_src_all_log_headers;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, peb_id %llu\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  pebi->peb_id);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_id %llu\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  pebi->peb_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_peb_read_all_log_headers(pebi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read the log's headers: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		goto finish_read_src_all_log_headers;
+	}
+
+finish_read_src_all_log_headers:
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
+ * ssdfs_peb_read_dst_all_log_headers() - read all dst PEB's log headers
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to read all headers and footers of
+ * the destination PEB's logs.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_dst_all_log_headers(struct ssdfs_peb_container *pebc,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_peb_info *pebi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->dst_peb;
+	if (!pebi) {
+		SSDFS_WARN("destination PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_read_dst_all_log_headers;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, peb_id %llu\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  pebi->peb_id);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_id %llu\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  pebi->peb_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_peb_read_all_log_headers(pebi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read the log's headers: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		goto finish_read_dst_all_log_headers;
+	}
+
+finish_read_dst_all_log_headers:
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
+ * ssdfs_peb_get_log_pages_count() - determine count of pages in the log
+ * @fsi: file system info object
+ * @pebi: PEB object
+ * @env: init environment [in | out]
+ *
+ * This function reads segment header of the first log in
+ * segment and to retrieve log_pages field. Also it initilizes
+ * current and previous PEB migration IDs.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_get_log_pages_count(struct ssdfs_fs_info *fsi,
+				  struct ssdfs_peb_info *pebi,
+				  struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_signature *magic;
+	struct page *page;
+	size_t hdr_buf_size = sizeof(struct ssdfs_segment_header);
+	u32 log_pages;
+	u32 pages_off = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !env || !env->log_hdr);
+
+	SSDFS_DBG("peb %llu, env %p\n", pebi->peb_id, env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, 0);
+	if (IS_ERR_OR_NULL(page)) {
+		err = ssdfs_read_checked_segment_header(fsi,
+							pebi->peb_id,
+							0,
+							env->log_hdr,
+							false);
+		if (err) {
+			SSDFS_ERR("fail to read checked segment header: "
+				  "peb %llu, err %d\n",
+				  pebi->peb_id, err);
+			return err;
+		}
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
+	magic = (struct ssdfs_signature *)env->log_hdr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!is_ssdfs_magic_valid(magic)) {
+		SSDFS_ERR("valid magic is not detected\n");
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (__is_ssdfs_segment_header_magic_valid(magic)) {
+		struct ssdfs_segment_header *seg_hdr;
+
+		seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+		log_pages = le16_to_cpu(seg_hdr->log_pages);
+		env->log_pages = log_pages;
+		env->cur_migration_id =
+			seg_hdr->peb_migration_id[SSDFS_CUR_MIGRATING_PEB];
+		env->prev_migration_id =
+			seg_hdr->peb_migration_id[SSDFS_PREV_MIGRATING_PEB];
+	} else {
+		SSDFS_ERR("log header is corrupted: "
+			  "peb %llu, pages_off %u\n",
+			  pebi->peb_id, pages_off);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (fsi->pages_per_peb % log_pages) {
+		SSDFS_WARN("fsi->pages_per_peb %u, log_pages %u\n",
+			   fsi->pages_per_peb, log_pages);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (log_pages > fsi->pages_per_peb) {
+		SSDFS_ERR("log_pages %u > fsi->pages_per_peb %u\n",
+			  log_pages, fsi->pages_per_peb);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_find_last_partial_log() - find the last partial log
+ * @fsi: file system info object
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ * @new_log_start_page: pointer on the new log's start page [out]
+ *
+ * This function tries to find the last partial log
+ * in the PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_find_last_partial_log(struct ssdfs_fs_info *fsi,
+				struct ssdfs_peb_info *pebi,
+				struct ssdfs_read_init_env *env,
+				u16 *new_log_start_page)
+{
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	struct ssdfs_log_footer *footer = NULL;
+	struct page *page;
+	void *kaddr;
+	size_t hdr_buf_size = sizeof(struct ssdfs_segment_header);
+	u32 byte_offset, page_offset;
+	unsigned long last_page_idx;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi || !pebi->pebc || !env);
+	BUG_ON(!new_log_start_page);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*new_log_start_page = U16_MAX;
+
+	last_page_idx = ssdfs_page_array_get_last_page_index(&pebi->cache);
+
+	if (last_page_idx >= SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE) {
+		SSDFS_ERR("empty page array: last_page_idx %lu\n",
+			  last_page_idx);
+		return -ERANGE;
+	}
+
+	if (last_page_idx >= fsi->pages_per_peb) {
+		SSDFS_ERR("corrupted page array: "
+			  "last_page_idx %lu, fsi->pages_per_peb %u\n",
+			  last_page_idx, fsi->pages_per_peb);
+		return -ERANGE;
+	}
+
+	for (i = (int)last_page_idx; i >= 0; i--) {
+		page = ssdfs_page_array_get_page_locked(&pebi->cache, i);
+		if (IS_ERR_OR_NULL(page)) {
+			if (page == NULL) {
+				SSDFS_ERR("fail to get page: "
+					  "index %d\n",
+					  i);
+				return -ERANGE;
+			} else {
+				err = PTR_ERR(page);
+
+				if (err == -ENOENT)
+					continue;
+				else {
+					SSDFS_ERR("fail to get page: "
+						  "index %d, err %d\n",
+						  i, err);
+					return err;
+				}
+			}
+		}
+
+		kaddr = kmap_local_page(page);
+		ssdfs_memcpy(env->log_hdr, 0, hdr_buf_size,
+			     kaddr, 0, PAGE_SIZE,
+			     hdr_buf_size);
+		ssdfs_memcpy(env->footer, 0, hdr_buf_size,
+			     kaddr, 0, PAGE_SIZE,
+			     hdr_buf_size);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %d, page %p, count %d\n",
+			  i, page, page_ref_count(page));
+
+		SSDFS_DBG("PAGE DUMP: cur_page %u\n",
+			  i);
+		kaddr = kmap_local_page(page);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+		kunmap_local(kaddr);
+		SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		magic = (struct ssdfs_signature *)env->log_hdr;
+
+		if (!is_ssdfs_magic_valid(magic))
+			continue;
+
+		if (__is_ssdfs_segment_header_magic_valid(magic)) {
+			seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+
+			err = ssdfs_check_segment_header(fsi, seg_hdr,
+							 false);
+			if (unlikely(err)) {
+				SSDFS_ERR("log header is corrupted: "
+					  "seg %llu, peb %llu, index %u\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  i);
+				return -EIO;
+			}
+
+			if (*new_log_start_page >= U16_MAX) {
+				SSDFS_ERR("invalid new_log_start_page\n");
+				return -EIO;
+			}
+
+			byte_offset = i * fsi->pagesize;
+			byte_offset += env->log_bytes;
+			byte_offset += fsi->pagesize - 1;
+			page_offset = byte_offset / fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("byte_offset %u, page_offset %u, "
+				  "new_log_start_page %u\n",
+				  byte_offset, page_offset, *new_log_start_page);
+			SSDFS_DBG("log_bytes %u\n", env->log_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (*new_log_start_page < page_offset) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("correct new log start page: "
+					  "old value %u, new value %u\n",
+					  *new_log_start_page,
+					  page_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+				*new_log_start_page = page_offset;
+			} else if (page_offset != *new_log_start_page) {
+				SSDFS_ERR("invalid new log start: "
+					  "page_offset %u, "
+					  "new_log_start_page %u\n",
+					  page_offset,
+					  *new_log_start_page);
+				return -EIO;
+			}
+
+			env->log_offset = (u16)i;
+			pebi->peb_create_time =
+				le64_to_cpu(seg_hdr->peb_create_time);
+			pebi->current_log.last_log_time =
+				le64_to_cpu(seg_hdr->timestamp);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("seg %llu, peb %llu, "
+				  "peb_create_time %llx, last_log_time %llx\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  pebi->peb_create_time,
+				  pebi->current_log.last_log_time);
+
+			BUG_ON(pebi->peb_create_time >
+				pebi->current_log.last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			goto finish_last_log_search;
+		} else if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+			u32 flags;
+
+			pl_hdr = SSDFS_PLH(env->log_hdr);
+
+			err = ssdfs_check_partial_log_header(fsi, pl_hdr,
+							     false);
+			if (unlikely(err)) {
+				SSDFS_ERR("partial log header is corrupted: "
+					  "seg %llu, peb %llu, index %u\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  i);
+				return -EIO;
+			}
+
+			flags = le32_to_cpu(pl_hdr->pl_flags);
+
+			if (flags & SSDFS_PARTIAL_HEADER_INSTEAD_FOOTER) {
+				/* first partial log */
+#ifdef CONFIG_SSDFS_DEBUG
+				BUG_ON((i + 1) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				byte_offset = (i + 1) * fsi->pagesize;
+				byte_offset += fsi->pagesize - 1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("byte_offset %u, "
+					  "new_log_start_page %u\n",
+					  byte_offset, *new_log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				*new_log_start_page =
+					(u16)(byte_offset / fsi->pagesize);
+				env->log_bytes =
+					le32_to_cpu(pl_hdr->log_bytes);
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("log_bytes %u\n", env->log_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				continue;
+			} else if (flags & SSDFS_LOG_HAS_FOOTER) {
+				/* last partial log */
+
+				env->log_bytes =
+					le32_to_cpu(pl_hdr->log_bytes);
+
+				byte_offset = i * fsi->pagesize;
+				byte_offset += env->log_bytes;
+				byte_offset += fsi->pagesize - 1;
+				page_offset = byte_offset / fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("byte_offset %u, page_offset %u, "
+					  "new_log_start_page %u\n",
+					  byte_offset, page_offset, *new_log_start_page);
+				SSDFS_DBG("log_bytes %u\n", env->log_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				if (*new_log_start_page < page_offset) {
+#ifdef CONFIG_SSDFS_DEBUG
+					SSDFS_DBG("correct new log start page: "
+						  "old value %u, "
+						  "new value %u\n",
+						  *new_log_start_page,
+						  page_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+					*new_log_start_page = page_offset;
+				} else if (page_offset != *new_log_start_page) {
+					SSDFS_ERR("invalid new log start: "
+						  "page_offset %u, "
+						  "new_log_start_page %u\n",
+						  page_offset,
+						  *new_log_start_page);
+					return -EIO;
+				}
+
+				env->log_offset = (u16)i;
+				pebi->peb_create_time =
+					le64_to_cpu(pl_hdr->peb_create_time);
+				pebi->current_log.last_log_time =
+					le64_to_cpu(pl_hdr->timestamp);
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("seg %llu, peb %llu, "
+					  "peb_create_time %llx, last_log_time %llx\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  pebi->peb_create_time,
+					  pebi->current_log.last_log_time);
+
+				BUG_ON(pebi->peb_create_time >
+					pebi->current_log.last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				goto finish_last_log_search;
+			} else {
+				/* intermediate partial log */
+
+				env->log_bytes =
+					le32_to_cpu(pl_hdr->log_bytes);
+
+				byte_offset = i * fsi->pagesize;
+				byte_offset += env->log_bytes;
+				byte_offset += fsi->pagesize - 1;
+				page_offset = byte_offset / fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("byte_offset %u, page_offset %u, "
+					  "new_log_start_page %u\n",
+					  byte_offset, page_offset, *new_log_start_page);
+				SSDFS_DBG("log_bytes %u\n", env->log_bytes);
+
+				BUG_ON(page_offset >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				*new_log_start_page = (u16)page_offset;
+				env->log_offset = (u16)i;
+				pebi->peb_create_time =
+					le64_to_cpu(pl_hdr->peb_create_time);
+				pebi->current_log.last_log_time =
+					le64_to_cpu(pl_hdr->timestamp);
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("seg %llu, peb %llu, "
+					  "peb_create_time %llx, last_log_time %llx\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  pebi->peb_create_time,
+					  pebi->current_log.last_log_time);
+
+				BUG_ON(pebi->peb_create_time >
+					pebi->current_log.last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				goto finish_last_log_search;
+			}
+		} else if (__is_ssdfs_log_footer_magic_valid(magic)) {
+			footer = SSDFS_LF(env->footer);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON((i + 1) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			byte_offset = (i + 1) * fsi->pagesize;
+			byte_offset += fsi->pagesize - 1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("byte_offset %u, new_log_start_page %u\n",
+				  byte_offset, *new_log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			*new_log_start_page =
+				(u16)(byte_offset / fsi->pagesize);
+			env->log_bytes =
+				le32_to_cpu(footer->log_bytes);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("log_bytes %u\n", env->log_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			continue;
+		} else {
+			SSDFS_ERR("log header is corrupted: "
+				  "seg %llu, peb %llu, index %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  i);
+			return -ERANGE;
+		}
+	}
+
+finish_last_log_search:
+	if (env->log_offset >= fsi->pages_per_peb) {
+		SSDFS_ERR("log_offset %u >= pages_per_peb %u\n",
+			  env->log_offset, fsi->pages_per_peb);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (fsi->erasesize < env->log_bytes) {
+		SSDFS_WARN("fsi->erasesize %u, log_bytes %u\n",
+			   fsi->erasesize,
+			   env->log_bytes);
+	}
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u, "
+		  "new_log_start_page %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index,
+		  *new_log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_check_log_header() - check log's header
+ * @fsi: file system info object
+ * @env: init environment [in|out]
+ *
+ * This function checks the log's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ENODATA    - valid magic is not detected.
+ */
+static inline
+int ssdfs_check_log_header(struct ssdfs_fs_info *fsi,
+			   struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->log_hdr || !env->footer);
+
+	SSDFS_DBG("log_offset %u, log_pages %u\n",
+		  env->log_offset, env->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	magic = (struct ssdfs_signature *)env->log_hdr;
+
+	if (!is_ssdfs_magic_valid(magic)) {
+		SSDFS_DBG("valid magic is not detected\n");
+		return -ENODATA;
+	}
+
+	if (__is_ssdfs_segment_header_magic_valid(magic)) {
+		seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+
+		err = ssdfs_check_segment_header(fsi, seg_hdr,
+						 false);
+		if (unlikely(err)) {
+			SSDFS_ERR("log header is corrupted\n");
+			return -EIO;
+		}
+
+		env->has_seg_hdr = true;
+		env->has_footer = ssdfs_log_has_footer(seg_hdr);
+	} else if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+		pl_hdr = SSDFS_PLH(env->log_hdr);
+
+		err = ssdfs_check_partial_log_header(fsi, pl_hdr,
+						     false);
+		if (unlikely(err)) {
+			SSDFS_ERR("partial log header is corrupted\n");
+			return -EIO;
+		}
+
+		env->has_seg_hdr = false;
+		env->has_footer = ssdfs_pl_has_footer(pl_hdr);
+	} else {
+		SSDFS_DBG("log header is corrupted\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_segment_header_blk_bmap_desc() - get block bitmap's descriptor
+ * @pebi: pointer on PEB object
+ * @env: init environment [in]
+ * @desc: block bitmap's descriptor [out]
+ *
+ * This function tries to extract the block bitmap's descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_get_segment_header_blk_bmap_desc(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_metadata_descriptor **desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	size_t footer_size = sizeof(struct ssdfs_log_footer);
+	u32 pages_off;
+	u32 bytes_off;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	*desc = NULL;
+
+	if (!env->has_seg_hdr) {
+		SSDFS_ERR("segment header is absent\n");
+		return -ERANGE;
+	}
+
+	seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+
+	if (!ssdfs_seg_hdr_has_blk_bmap(seg_hdr)) {
+		if (!env->has_footer) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__,
+					__LINE__,
+					"log hasn't footer\n");
+			return -EIO;
+		}
+
+		*desc = &seg_hdr->desc_array[SSDFS_LOG_FOOTER_INDEX];
+
+		bytes_off = le32_to_cpu((*desc)->offset);
+		pages_off = bytes_off / fsi->pagesize;
+
+		page = ssdfs_page_array_get_page_locked(&pebi->cache,
+							pages_off);
+		if (IS_ERR_OR_NULL(page)) {
+			err = ssdfs_read_checked_log_footer(fsi,
+							    env->log_hdr,
+							    pebi->peb_id,
+							    bytes_off,
+							    env->footer,
+							    false);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to read checked log footer: "
+					  "seg %llu, peb %llu, bytes_off %u\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id, bytes_off);
+				return err;
+			}
+		} else {
+			ssdfs_memcpy_from_page(env->footer, 0, footer_size,
+						page, 0, PAGE_SIZE,
+						footer_size);
+
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		if (!ssdfs_log_footer_has_blk_bmap(env->footer)) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__,
+					__LINE__,
+					"log hasn't block bitmap\n");
+			return -EIO;
+		}
+
+		*desc = &env->footer->desc_array[SSDFS_BLK_BMAP_INDEX];
+	} else
+		*desc = &seg_hdr->desc_array[SSDFS_BLK_BMAP_INDEX];
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_partial_header_blk_bmap_desc() - get block bitmap's descriptor
+ * @pebi: pointer on PEB object
+ * @env: init environment [in]
+ * @desc: block bitmap's descriptor [out]
+ *
+ * This function tries to extract the block bitmap's descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_get_partial_header_blk_bmap_desc(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_metadata_descriptor **desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	size_t footer_size = sizeof(struct ssdfs_log_footer);
+	u32 pages_off;
+	u32 bytes_off;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	*desc = NULL;
+
+	if (env->has_seg_hdr) {
+		SSDFS_ERR("partial log header is absent\n");
+		return -ERANGE;
+	}
+
+	pl_hdr = SSDFS_PLH(env->log_hdr);
+
+	if (!ssdfs_pl_hdr_has_blk_bmap(pl_hdr)) {
+		if (!env->has_footer) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__,
+					__LINE__,
+					"log hasn't footer\n");
+			return -EIO;
+		}
+
+		*desc = &pl_hdr->desc_array[SSDFS_LOG_FOOTER_INDEX];
+
+		bytes_off = le32_to_cpu((*desc)->offset);
+		pages_off = bytes_off / fsi->pagesize;
+
+		page = ssdfs_page_array_get_page_locked(&pebi->cache,
+							pages_off);
+		if (IS_ERR_OR_NULL(page)) {
+			err = ssdfs_read_checked_log_footer(fsi,
+							    env->log_hdr,
+							    pebi->peb_id,
+							    bytes_off,
+							    env->footer,
+							    false);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to read checked log footer: "
+					  "seg %llu, peb %llu, bytes_off %u\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id, bytes_off);
+				return err;
+			}
+		} else {
+			ssdfs_memcpy_from_page(env->footer, 0, footer_size,
+						page, 0, PAGE_SIZE,
+						footer_size);
+
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		if (!ssdfs_log_footer_has_blk_bmap(env->footer)) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__,
+					__LINE__,
+					"log hasn't block bitmap\n");
+			return -EIO;
+		}
+
+		*desc = &env->footer->desc_array[SSDFS_BLK_BMAP_INDEX];
+	} else
+		*desc = &pl_hdr->desc_array[SSDFS_BLK_BMAP_INDEX];
+
+	return 0;
+}
+
+/*
+ * ssdfs_pre_fetch_block_bitmap() - pre-fetch block bitmap
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to check the presence of block bitmap
+ * in the PEB's cache. Otherwise, it tries to read the block
+ * bitmap from the volume into the PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_pre_fetch_block_bitmap(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	struct page *page;
+	void *kaddr;
+	u32 pages_off;
+	u32 bytes_off;
+	size_t hdr_buf_size = sizeof(struct ssdfs_segment_header);
+	u32 area_offset, area_size;
+	u32 cur_page, page_start, page_end;
+	size_t read_bytes;
+	size_t bmap_hdr_size = sizeof(struct ssdfs_block_bitmap_header);
+	u32 pebsize;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	pages_off = env->log_offset;
+	pebsize = fsi->pages_per_peb * fsi->pagesize;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, pages_off);
+	if (IS_ERR_OR_NULL(page)) {
+		err = ssdfs_read_checked_segment_header(fsi,
+							pebi->peb_id,
+							pages_off,
+							env->log_hdr,
+							false);
+		if (err) {
+			SSDFS_ERR("fail to read checked segment header: "
+				  "peb %llu, err %d\n",
+				  pebi->peb_id, err);
+			return err;
+		}
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
+	area_offset = le32_to_cpu(desc->offset);
+	area_size = le32_to_cpu(desc->size);
+
+	if (bmap_hdr_size != le16_to_cpu(desc->check.bytes)) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"bmap_hdr_size %zu != desc->check.bytes %u\n",
+				bmap_hdr_size,
+				le16_to_cpu(desc->check.bytes));
+		return -EIO;
+	}
+
+	if (area_offset >= pebsize) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"desc->offset %u >= pebsize %u\n",
+				area_offset, pebsize);
+		return -EIO;
+	}
+
+	bytes_off = area_offset;
+	page_start = bytes_off / fsi->pagesize;
+	bytes_off += area_size - 1;
+	page_end = bytes_off / fsi->pagesize;
+
+	for (cur_page = page_start; cur_page <= page_end; cur_page++) {
+		page = ssdfs_page_array_get_page_locked(&pebi->cache,
+							cur_page);
+		if (IS_ERR_OR_NULL(page)) {
+			page = ssdfs_page_array_grab_page(&pebi->cache,
+							  cur_page);
+			if (unlikely(IS_ERR_OR_NULL(page))) {
+				SSDFS_ERR("fail to grab page: index %u\n",
+					  cur_page);
+				return -ENOMEM;
+			}
+
+			kaddr = kmap_local_page(page);
+			err = ssdfs_aligned_read_buffer(fsi, pebi->peb_id,
+							cur_page * PAGE_SIZE,
+							(u8 *)kaddr,
+							PAGE_SIZE,
+							&read_bytes);
+			kunmap_local(kaddr);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to read memory page: "
+					  "index %u, err %d\n",
+					  cur_page, err);
+				goto finish_read_page;
+			} else if (unlikely(read_bytes != PAGE_SIZE)) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid read_bytes %zu\n",
+					  read_bytes);
+				goto finish_read_page;
+			}
+
+			SetPageUptodate(page);
+
+finish_read_page:
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_get_segment_header_blk2off_tbl_desc() - get blk2off tbl's descriptor
+ * @pebi: pointer on PEB object
+ * @env: init environment [in]
+ * @desc: blk2off tbl's descriptor [out]
+ *
+ * This function tries to extract the blk2off table's descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOENT     - blk2off table's descriptor is absent.
+ */
+static inline
+int ssdfs_get_segment_header_blk2off_tbl_desc(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_metadata_descriptor **desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*desc = NULL;
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (!env->has_seg_hdr) {
+		SSDFS_ERR("segment header is absent\n");
+		return -ERANGE;
+	}
+
+	seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+
+	if (!ssdfs_seg_hdr_has_offset_table(seg_hdr)) {
+		if (!env->has_footer) {
+			ssdfs_fs_error(fsi->sb, __FILE__,
+					__func__, __LINE__,
+					"log hasn't footer\n");
+			return -EIO;
+		}
+
+		if (!ssdfs_log_footer_has_offset_table(env->footer)) {
+			SSDFS_DBG("log hasn't blk2off table\n");
+			return -ENOENT;
+		}
+
+		*desc = &env->footer->desc_array[SSDFS_OFF_TABLE_INDEX];
+	} else
+		*desc = &seg_hdr->desc_array[SSDFS_OFF_TABLE_INDEX];
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_segment_header_blk_desc_tbl_desc() - get blk desc tbl's descriptor
+ * @pebi: pointer on PEB object
+ * @env: init environment [in]
+ * @desc: blk desc tbl's descriptor [out]
+ *
+ * This function tries to extract the block descriptor table's descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOENT     - block descriptor table's descriptor is absent.
+ */
+static inline
+int ssdfs_get_segment_header_blk_desc_tbl_desc(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_metadata_descriptor **desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*desc = NULL;
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (!env->has_seg_hdr) {
+		SSDFS_ERR("segment header is absent\n");
+		return -ERANGE;
+	}
+
+	seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+
+	if (!ssdfs_log_has_blk_desc_chain(seg_hdr)) {
+		SSDFS_DBG("log hasn't block descriptor table\n");
+		return -ENOENT;
+	} else
+		*desc = &seg_hdr->desc_array[SSDFS_BLK_DESC_AREA_INDEX];
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_partial_header_blk2off_tbl_desc() - get blk2off tbl's descriptor
+ * @pebi: pointer on PEB object
+ * @env: init environment [in]
+ * @desc: blk2off tbl's descriptor [out]
+ *
+ * This function tries to extract the blk2off table's descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOENT     - blk2off table's descriptor is absent.
+ */
+static inline
+int ssdfs_get_partial_header_blk2off_tbl_desc(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_metadata_descriptor **desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*desc = NULL;
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (env->has_seg_hdr) {
+		SSDFS_ERR("partial log header is absent\n");
+		return -ERANGE;
+	}
+
+	pl_hdr = SSDFS_PLH(env->log_hdr);
+
+	if (!ssdfs_pl_hdr_has_offset_table(pl_hdr)) {
+		if (!env->has_footer) {
+			SSDFS_DBG("log hasn't blk2off table\n");
+			return -ENOENT;
+		}
+
+		if (!ssdfs_log_footer_has_offset_table(env->footer)) {
+			SSDFS_DBG("log hasn't blk2off table\n");
+			return -ENOENT;
+		}
+
+		*desc = &env->footer->desc_array[SSDFS_OFF_TABLE_INDEX];
+	} else
+		*desc = &pl_hdr->desc_array[SSDFS_OFF_TABLE_INDEX];
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_partial_header_blk_desc_tbl_desc() - get blk desc tbl's descriptor
+ * @pebi: pointer on PEB object
+ * @env: init environment [in]
+ * @desc: blk desc tbl's descriptor [out]
+ *
+ * This function tries to extract the block descriptor table's descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOENT     - block descriptor table's descriptor is absent.
+ */
+static inline
+int ssdfs_get_partial_header_blk_desc_tbl_desc(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env,
+					struct ssdfs_metadata_descriptor **desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env || !desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*desc = NULL;
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (env->has_seg_hdr) {
+		SSDFS_ERR("partial log header is absent\n");
+		return -ERANGE;
+	}
+
+	pl_hdr = SSDFS_PLH(env->log_hdr);
+
+	if (!ssdfs_pl_has_blk_desc_chain(pl_hdr)) {
+		SSDFS_DBG("log hasn't block descriptor table\n");
+		return -ENOENT;
+	} else
+		*desc = &pl_hdr->desc_array[SSDFS_BLK_DESC_AREA_INDEX];
+
+	return 0;
+}
+
+/*
+ * ssdfs_pre_fetch_metadata_area() - pre-fetch metadata area
+ * @pebi: pointer on PEB object
+ * @desc: metadata area's descriptor
+ *
+ * This function tries to check the presence of metadata area
+ * in the PEB's cache. Otherwise, it tries to read the metadata area
+ * from the volume into the PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_pre_fetch_metadata_area(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_metadata_descriptor *desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *page;
+	void *kaddr;
+	u32 bytes_off;
+	u32 area_offset, area_size;
+	u32 cur_page, page_start, page_end;
+	size_t read_bytes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !desc);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	area_offset = le32_to_cpu(desc->offset);
+	area_size = le32_to_cpu(desc->size);
+
+	bytes_off = area_offset;
+	page_start = bytes_off / fsi->pagesize;
+	bytes_off += area_size - 1;
+	page_end = bytes_off / fsi->pagesize;
+
+	for (cur_page = page_start; cur_page <= page_end; cur_page++) {
+		page = ssdfs_page_array_get_page_locked(&pebi->cache,
+							cur_page);
+		if (IS_ERR_OR_NULL(page)) {
+			page = ssdfs_page_array_grab_page(&pebi->cache,
+							  cur_page);
+			if (unlikely(IS_ERR_OR_NULL(page))) {
+				SSDFS_ERR("fail to grab page: index %u\n",
+					  cur_page);
+				return -ENOMEM;
+			}
+
+			kaddr = kmap_local_page(page);
+			err = ssdfs_aligned_read_buffer(fsi, pebi->peb_id,
+							cur_page * PAGE_SIZE,
+							(u8 *)kaddr,
+							PAGE_SIZE,
+							&read_bytes);
+			flush_dcache_page(page);
+			kunmap_local(kaddr);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to read memory page: "
+					  "index %u, err %d\n",
+					  cur_page, err);
+				goto finish_read_page;
+			} else if (unlikely(read_bytes != PAGE_SIZE)) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid read_bytes %zu\n",
+					  read_bytes);
+				goto finish_read_page;
+			}
+
+			SetPageUptodate(page);
+
+finish_read_page:
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_pre_fetch_blk2off_table_area() - pre-fetch blk2off table
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to check the presence of blk2off table
+ * in the PEB's cache. Otherwise, it tries to read the blk2off table
+ * from the volume into the PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - blk2off table is absent.
+ */
+static
+int ssdfs_pre_fetch_blk2off_table_area(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	struct page *page;
+	u32 pages_off;
+	size_t hdr_buf_size = sizeof(struct ssdfs_segment_header);
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	pages_off = env->log_offset;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, pages_off);
+	if (IS_ERR_OR_NULL(page)) {
+		err = ssdfs_read_checked_segment_header(fsi,
+							pebi->peb_id,
+							pages_off,
+							env->log_hdr,
+							false);
+		if (err) {
+			SSDFS_ERR("fail to read checked segment header: "
+				  "peb %llu, err %d\n",
+				  pebi->peb_id, err);
+			return err;
+		}
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
+	if (env->has_seg_hdr) {
+		err = ssdfs_get_segment_header_blk2off_tbl_desc(pebi, env,
+								&desc);
+	} else {
+		err = ssdfs_get_partial_header_blk2off_tbl_desc(pebi, env,
+								&desc);
+	}
+
+	if (err == -ENOENT) {
+		SSDFS_DBG("blk2off table is absent\n");
+		return err;
+	} else if (unlikely(err)) {
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
+	err = ssdfs_pre_fetch_metadata_area(pebi, desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch a metadata area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_blk_desc_byte_stream() - read blk desc's byte stream
+ * @pebi: pointer on PEB object
+ * @read_bytes: amount of bytes for reading
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk desc table's byte stream.
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
+int ssdfs_read_blk_desc_byte_stream(struct ssdfs_peb_info *pebi,
+				    u32 read_bytes,
+				    struct ssdfs_read_init_env *env)
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
+		  read_bytes, env->bdt_init.read_off,
+		  env->bdt_init.write_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	while (read_bytes > 0) {
+		struct page *page = NULL;
+		void *kaddr;
+		pgoff_t page_index = env->bdt_init.write_off >> PAGE_SHIFT;
+		u32 capacity = pagevec_count(&env->bdt_init.pvec) << PAGE_SHIFT;
+		u32 offset, bytes;
+
+		if (env->bdt_init.write_off >= capacity) {
+			if (pagevec_space(&env->bdt_init.pvec) == 0) {
+				/*
+				 * Block descriptor table byte stream could be
+				 * bigger than page vector capacity.
+				 * As a result, not complete byte stream will
+				 * read and initialization will be done only
+				 * partially. The rest byte stream will be
+				 * extracted and be used for initialization
+				 * for request of particular logical block.
+				 */
+				SSDFS_DBG("pagevec is full\n");
+				return 0;
+			}
+
+			page = ssdfs_read_add_pagevec_page(&env->bdt_init.pvec);
+			if (unlikely(IS_ERR_OR_NULL(page))) {
+				err = !page ? -ENOMEM : PTR_ERR(page);
+				SSDFS_ERR("fail to add pagevec page: err %d\n",
+					  err);
+				return err;
+			}
+		} else {
+			page = env->bdt_init.pvec.pages[page_index];
+			if (unlikely(!page)) {
+				err = -ERANGE;
+				SSDFS_ERR("fail to get page: err %d\n",
+					  err);
+				return err;
+			}
+		}
+
+		offset = env->bdt_init.write_off % PAGE_SIZE;
+		bytes = min_t(u32, read_bytes, PAGE_SIZE - offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %u, bytes %u\n",
+			  offset, bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = ssdfs_unaligned_read_cache(pebi,
+						 env->bdt_init.read_off, bytes,
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
+				  pebi->peb_id, env->bdt_init.read_off,
+				  bytes, err);
+			return err;
+		}
+
+		read_bytes -= bytes;
+		env->bdt_init.read_off += bytes;
+		env->bdt_init.write_off += bytes;
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_blk_desc_compressed_byte_stream() - read blk desc's byte stream
+ * @pebi: pointer on PEB object
+ * @read_bytes: amount of bytes for reading
+ * @env: init environment [in|out]
+ *
+ * This function tries to read blk desc table's byte stream.
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
+int ssdfs_read_blk_desc_compressed_byte_stream(struct ssdfs_peb_info *pebi,
+						u32 read_bytes,
+						struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_area_block_table table;
+	struct ssdfs_fragment_desc *frag;
+	struct page *page = NULL;
+	void *kaddr;
+	size_t tbl_size = sizeof(struct ssdfs_area_block_table);
+	u32 area_offset;
+	u16 fragments_count;
+	u16 frag_uncompr_size;
+	int i;
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
+		  read_bytes, env->bdt_init.read_off,
+		  env->bdt_init.write_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	area_offset = env->bdt_init.read_off;
+
+	err = ssdfs_unaligned_read_cache(pebi, area_offset, tbl_size, &table);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read area block table: "
+			  "area_offset %u, tbl_size %zu, err %d\n",
+			  area_offset, tbl_size, err);
+		return err;
+	}
+
+	if (table.chain_hdr.magic != SSDFS_CHAIN_HDR_MAGIC) {
+		SSDFS_ERR("corrupted area block table: "
+			  "magic (expected %#x, found %#x)\n",
+			  SSDFS_CHAIN_HDR_MAGIC,
+			  table.chain_hdr.magic);
+		return -EIO;
+	}
+
+	switch (table.chain_hdr.type) {
+	case SSDFS_BLK_DESC_ZLIB_CHAIN_HDR:
+	case SSDFS_BLK_DESC_LZO_CHAIN_HDR:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected area block table's type %#x\n",
+			  table.chain_hdr.type);
+		return -EIO;
+	}
+
+	fragments_count = le16_to_cpu(table.chain_hdr.fragments_count);
+
+	for (i = 0; i < fragments_count; i++) {
+		frag = &table.blk[i];
+
+		if (frag->magic != SSDFS_FRAGMENT_DESC_MAGIC) {
+			SSDFS_ERR("corrupted area block table: "
+				  "magic (expected %#x, found %#x)\n",
+				  SSDFS_FRAGMENT_DESC_MAGIC,
+				  frag->magic);
+			return -EIO;
+		}
+
+		switch (frag->type) {
+		case SSDFS_DATA_BLK_DESC_ZLIB:
+		case SSDFS_DATA_BLK_DESC_LZO:
+			/* expected type */
+			break;
+
+		default:
+			SSDFS_ERR("unexpected fragment's type %#x\n",
+				  frag->type);
+			return -EIO;
+		}
+
+		frag_uncompr_size = le16_to_cpu(frag->uncompr_size);
+
+		page = ssdfs_read_add_pagevec_page(&env->bdt_init.pvec);
+		if (unlikely(IS_ERR_OR_NULL(page))) {
+			err = !page ? -ENOMEM : PTR_ERR(page);
+			SSDFS_ERR("fail to add pagevec page: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = __ssdfs_decompress_blk_desc_fragment(pebi, frag,
+							   area_offset,
+							   kaddr, PAGE_SIZE);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read page: "
+				  "seg %llu, peb %llu, offset %u, "
+				  "size %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, env->bdt_init.read_off,
+				  frag_uncompr_size, err);
+			return err;
+		}
+
+		env->bdt_init.read_off += frag_uncompr_size;
+		env->bdt_init.write_off += frag_uncompr_size;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_pre_fetch_blk_desc_table_area() - pre-fetch blk desc table
+ * @pebi: pointer on PEB object
+ * @env: init environment [in|out]
+ *
+ * This function tries to check the presence of blk desc table
+ * in the PEB's cache. Otherwise, it tries to read the blk desc table
+ * from the volume into the PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - blk desc table is absent.
+ */
+static
+int ssdfs_pre_fetch_blk_desc_table_area(struct ssdfs_peb_info *pebi,
+					struct ssdfs_read_init_env *env)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor *desc = NULL;
+	struct page *page;
+	u32 pages_off;
+	size_t hdr_buf_size = sizeof(struct ssdfs_segment_header);
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !env);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	pages_off = env->log_offset;
+	env->bdt_init.read_off = 0;
+	env->bdt_init.write_off = 0;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, pages_off);
+	if (IS_ERR_OR_NULL(page)) {
+		err = ssdfs_read_checked_segment_header(fsi,
+							pebi->peb_id,
+							pages_off,
+							env->log_hdr,
+							false);
+		if (err) {
+			SSDFS_ERR("fail to read checked segment header: "
+				  "peb %llu, err %d\n",
+				  pebi->peb_id, err);
+			return err;
+		}
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
+	if (env->has_seg_hdr) {
+		err = ssdfs_get_segment_header_blk_desc_tbl_desc(pebi, env,
+								 &desc);
+	} else {
+		err = ssdfs_get_partial_header_blk_desc_tbl_desc(pebi, env,
+								 &desc);
+	}
+
+	if (err == -ENOENT) {
+		SSDFS_DBG("blk descriptor table is absent\n");
+		return err;
+	} else if (unlikely(err)) {
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
+	env->bdt_init.read_off = le32_to_cpu(desc->offset);
+
+	err = ssdfs_pre_fetch_metadata_area(pebi, desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-fetch a metadata area: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	flags = le16_to_cpu(desc->check.flags);
+
+	if ((flags & SSDFS_ZLIB_COMPRESSED) && (flags & SSDFS_LZO_COMPRESSED)) {
+		SSDFS_ERR("invalid set of flags: "
+			  "flags %#x\n",
+			  flags);
+		return -ERANGE;
+	}
+
+	if ((flags & SSDFS_ZLIB_COMPRESSED) || (flags & SSDFS_LZO_COMPRESSED)) {
+		err = ssdfs_read_blk_desc_compressed_byte_stream(pebi,
+						      le32_to_cpu(desc->size),
+						      env);
+	} else {
+		u32 read_bytes = le32_to_cpu(desc->size);
+		size_t area_tbl_size = sizeof(struct ssdfs_area_block_table);
+
+		env->bdt_init.read_off += area_tbl_size;
+
+		if (read_bytes <= area_tbl_size) {
+			SSDFS_ERR("corrupted area blocks table: "
+				  "read_bytes %u, area_tbl_size %zu\n",
+				  read_bytes, area_tbl_size);
+			return -EIO;
+		}
+
+		read_bytes -= area_tbl_size;
+
+		err = ssdfs_read_blk_desc_byte_stream(pebi, read_bytes, env);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare block descriptor table: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 /*
  * ssdfs_read_checked_block_bitmap_header() - read and check block bitmap header
  * @pebi: pointer on PEB object
-- 
2.34.1

