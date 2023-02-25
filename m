Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D56A2642
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBYBRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBYBQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:47 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B3B1688D
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:32 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bl7so859227oib.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8EUiqDud2aLb0cV5Wd8Zcdo/JT59MaincS+FUe8d20=;
        b=ATEMztRNqUnbNUdqQzVyO1N++3H7XstQ+WZnq3nHQvNtEscibqtaTZZ7Kjyw+MLap/
         xVxxoQYYex9pXgEidSYZZjcMM0VO46xh/amjHzZoG0mPlhFjpTO6lMJlbbS5Ayw7G3NQ
         0VGTc2AjViUm+VMPasM7AP2e7MfvqHsfR5uCp+3V+CYocQ+YEedffwoEu6AyIdAOzVxn
         761BEtRpSh5377xWRGY6lCnICUe6SJNnmGPH054uoKJ4gvlvWcOk3naSjV4oAEsXGsgE
         uagNrcBpQUAfgKEz+goc+Bvc84OW8cCKVKL/G4I/YympzsFX8RqgdfIfgeHy58qTPUBR
         v6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8EUiqDud2aLb0cV5Wd8Zcdo/JT59MaincS+FUe8d20=;
        b=RyPHLcXh6uxjy7vS2i/QIywdZYJsKNhVJMjG+ubWKhEk7+q33D91fmsD0NDCC8YzIg
         LRFO5MCUUV/dD4K4SFkcOk9/A0oZS7GczUtae2GaeqJsYyTJxdSLjxc4WVzCrqTzqgAO
         9NyYtFMqLuJrrcICxXb5mAWNqeTpRkUqAOdJ53nl8CJxKZzF/xkRsZoLeeJb2/qfU7Aw
         M3ZgA5OhlyEWR7gNZiagjD4NXcCegkh9NppLbTwgQbTHgMXbynz/ZTN3BDvQ1tA0LIpZ
         t0B85MiHsbDAo8ObSJj1gU8p4qw4WDuvdjUeqatXcc/G+lWpeQbqeCyej4fuLdMxL1WI
         RP+A==
X-Gm-Message-State: AO0yUKWn1/MibVqLFa6b2jauOhe1jUi4+o4NxBFAS9661LiRd67uz1lt
        /N8dzUnbeZo4JBCc6FiqGj0r7YSyj6Ma9ulB
X-Google-Smtp-Source: AK7set9GhSN6rBvT9J7xJ2k24FpC6iAejaSNV0t2s2J5FsuFNFcScCk0ZvX0ie+tghG5yl/lbpaNLQ==
X-Received: by 2002:a05:6808:23c7:b0:378:7dbd:6da7 with SMTP id bq7-20020a05680823c700b003787dbd6da7mr902741oib.29.1677287791553;
        Fri, 24 Feb 2023 17:16:31 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:30 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 27/76] ssdfs: read/readahead logic of PEB's thread
Date:   Fri, 24 Feb 2023 17:08:38 -0800
Message-Id: <20230225010927.813929-28-slava@dubeyko.com>
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

This patch implements read and readahead logic.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_read_thread.c | 3076 ++++++++++++++++++++++++++++++++++++
 1 file changed, 3076 insertions(+)

diff --git a/fs/ssdfs/peb_read_thread.c b/fs/ssdfs/peb_read_thread.c
index 317eef078521..764f4fdf5b0c 100644
--- a/fs/ssdfs/peb_read_thread.c
+++ b/fs/ssdfs/peb_read_thread.c
@@ -245,6 +245,3082 @@ int ssdfs_read_blk2off_table_fragment(struct ssdfs_peb_info *pebi,
  *                          READ THREAD FUNCTIONALITY                         *
  ******************************************************************************/
 
+/*
+ * __ssdfs_peb_release_pages() - release memory pages
+ * @pebi: pointer on PEB object
+ *
+ * This method tries to release the used pages from the page
+ * array upon the init has been finished.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_peb_release_pages(struct ssdfs_peb_info *pebi)
+{
+	u16 last_log_start_page = U16_MAX;
+	u16 log_pages = 0;
+	pgoff_t start, end;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_id %llu\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->pebc->peb_index,
+		  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&pebi->current_log.state)) {
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_CREATED:
+	case SSDFS_LOG_COMMITTED:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid current log's state: "
+			  "%#x\n",
+			  atomic_read(&pebi->current_log.state));
+		return -ERANGE;
+	}
+
+	ssdfs_peb_current_log_lock(pebi);
+	last_log_start_page = pebi->current_log.start_page;
+	log_pages = pebi->log_pages;
+	ssdfs_peb_current_log_unlock(pebi);
+
+	if (last_log_start_page > 0 && last_log_start_page <= log_pages) {
+		start = 0;
+		end = last_log_start_page - 1;
+
+		err = ssdfs_page_array_release_pages(&pebi->cache,
+						     &start, end);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release pages: "
+				  "seg_id %llu, peb_id %llu, "
+				  "start %lu, end %lu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, start, end, err);
+		}
+	}
+
+	if (!err && is_ssdfs_page_array_empty(&pebi->cache)) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cache is empty: "
+			  "seg_id %llu, peb_index %u, peb_id %llu\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->pebc->peb_index,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_release_pages_after_init() - release memory pages
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This method tries to release the used pages from the page
+ * array upon the init has been finished.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_release_pages(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_peb_info *pebi;
+	int err1 = 0, err2 = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&pebc->lock);
+
+	pebi = pebc->src_peb;
+	if (pebi) {
+		err1 = __ssdfs_peb_release_pages(pebi);
+		if (err1 == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache is empty: "
+				  "seg_id %llu, peb_index %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err1)) {
+			SSDFS_ERR("fail to release source PEB pages: "
+				  "seg_id %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err1);
+		}
+	}
+
+	pebi = pebc->dst_peb;
+	if (pebi) {
+		err2 = __ssdfs_peb_release_pages(pebi);
+		if (err2 == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache is empty: "
+				  "seg_id %llu, peb_index %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err2)) {
+			SSDFS_ERR("fail to release dest PEB pages: "
+				  "seg_id %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err2);
+		}
+	}
+
+	up_write(&pebc->lock);
+
+	if (err1 || err2) {
+		if (err1 == -ENODATA && err2 == -ENODATA)
+			return -ENODATA;
+		else if (!err1) {
+			if (err2 != -ENODATA)
+				return err2;
+			else
+				return 0;
+		} else if (!err2) {
+			if (err1 != -ENODATA)
+				return err1;
+			else
+				return 0;
+		} else
+			return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_unaligned_read_cache() - unaligned read from PEB's cache
+ * @pebi: pointer on PEB object
+ * @area_offset: offset from the log's beginning
+ * @area_size: size of the data portion
+ * @buf: buffer for read
+ *
+ * This function tries to read some data portion from
+ * the PEB's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_unaligned_read_cache(struct ssdfs_peb_info *pebi,
+				u32 area_offset, u32 area_size,
+				void *buf)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *page;
+	u32 page_off;
+	u32 bytes_off;
+	size_t read_bytes = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si || !buf);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "area_offset %u, area_size %u, buf %p\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  area_offset, area_size, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	do {
+		size_t iter_read_bytes;
+		size_t offset;
+
+		bytes_off = area_offset + read_bytes;
+		page_off = bytes_off / PAGE_SIZE;
+		offset = bytes_off % PAGE_SIZE;
+
+		iter_read_bytes = min_t(size_t,
+					(size_t)(area_size - read_bytes),
+					(size_t)(PAGE_SIZE - offset));
+
+		page = ssdfs_page_array_get_page_locked(&pebi->cache, page_off);
+		if (IS_ERR_OR_NULL(page)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fail to get page: index %u\n",
+				  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ERANGE;
+		}
+
+		err = ssdfs_memcpy_from_page(buf, read_bytes, area_size,
+					     page, offset, PAGE_SIZE,
+					     iter_read_bytes);
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: "
+				  "read_bytes %zu, offset %zu, "
+				  "iter_read_bytes %zu, err %d\n",
+				  read_bytes, offset,
+				  iter_read_bytes, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		read_bytes += iter_read_bytes;
+	} while (read_bytes < area_size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_log_hdr_desc_array() - read log's header area's descriptors
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @log_start_page: starting page of the log
+ * @array: array of area's descriptors [out]
+ * @array_size: count of items into array
+ *
+ * This function tries to read log's header area's descriptors.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - cache hasn't the requested page.
+ */
+int ssdfs_peb_read_log_hdr_desc_array(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_segment_request *req,
+				      u16 log_start_page,
+				      struct ssdfs_metadata_descriptor *array,
+				      size_t array_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *page;
+	void *kaddr;
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *plh_hdr = NULL;
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t array_bytes = array_size * desc_size;
+	u32 page_off;
+	size_t read_bytes;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!array);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+
+	SSDFS_DBG("seg %llu, peb %llu, log_start_page %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  log_start_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	page_off = log_start_page;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, page_off);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to get page: index %u\n",
+			   page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (req->private.flags & SSDFS_REQ_READ_ONLY_CACHE)
+			return -ENOENT;
+
+		page = ssdfs_page_array_grab_page(&pebi->cache, page_off);
+		if (unlikely(IS_ERR_OR_NULL(page))) {
+			SSDFS_ERR("fail to grab page: index %u\n",
+				  page_off);
+			return -ENOMEM;
+		}
+
+		kaddr = kmap_local_page(page);
+
+		err = ssdfs_aligned_read_buffer(fsi, pebi->peb_id,
+						(page_off * PAGE_SIZE),
+						(u8 *)kaddr,
+						PAGE_SIZE,
+						&read_bytes);
+		if (unlikely(err))
+			goto fail_copy_desc_array;
+		else if (unlikely(read_bytes != (PAGE_SIZE))) {
+			err = -ERANGE;
+			goto fail_copy_desc_array;
+		}
+
+		SetPageUptodate(page);
+		flush_dcache_page(page);
+	} else
+		kaddr = kmap_local_page(page);
+
+	magic = (struct ssdfs_signature *)kaddr;
+
+	if (!is_ssdfs_magic_valid(magic)) {
+		err = -ERANGE;
+		SSDFS_ERR("valid magic is not detected\n");
+		goto fail_copy_desc_array;
+	}
+
+	if (__is_ssdfs_segment_header_magic_valid(magic)) {
+		seg_hdr = SSDFS_SEG_HDR(kaddr);
+		ssdfs_memcpy(array, 0, array_bytes,
+			     seg_hdr->desc_array, 0, array_bytes,
+			     array_bytes);
+	} else if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+		plh_hdr = SSDFS_PLH(kaddr);
+		ssdfs_memcpy(array, 0, array_bytes,
+			     plh_hdr->desc_array, 0, array_bytes,
+			     array_bytes);
+	} else {
+		err = -EIO;
+		SSDFS_ERR("log header is corrupted: "
+			  "seg %llu, peb %llu, log_start_page %u\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  log_start_page);
+		goto fail_copy_desc_array;
+	}
+
+fail_copy_desc_array:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read checked segment header: "
+			  "seg %llu, peb %llu, pages_off %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  page_off, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_page_locked() - read locked page into PEB's cache
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @page_off: page index
+ *
+ * This function tries to read locked page into PEB's cache.
+ */
+static
+struct page *ssdfs_peb_read_page_locked(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req,
+					u32 page_off)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+
+	SSDFS_DBG("seg %llu, peb %llu, page_off %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	page = ssdfs_page_array_get_page_locked(&pebi->cache, page_off);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to get page: index %u\n",
+			   page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (req->private.flags & SSDFS_REQ_READ_ONLY_CACHE)
+			return ERR_PTR(-ENOENT);
+
+		page = ssdfs_page_array_grab_page(&pebi->cache, page_off);
+		if (unlikely(IS_ERR_OR_NULL(page))) {
+			SSDFS_ERR("fail to grab page: index %u\n",
+				  page_off);
+			return NULL;
+		}
+
+		if (PageUptodate(page) || PageDirty(page))
+			goto finish_page_read;
+
+		err = ssdfs_read_page_from_volume(fsi, pebi->peb_id,
+						  page_off << PAGE_SHIFT,
+						  page);
+
+		/*
+		 * ->readpage() unlock the page
+		 * But caller expects that page is locked
+		 */
+		ssdfs_lock_page(page);
+
+		if (unlikely(err))
+			goto fail_read_page;
+
+		SetPageUptodate(page);
+	}
+
+finish_page_read:
+	return page;
+
+fail_read_page:
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	SSDFS_ERR("fail to read locked page: "
+		  "seg %llu, peb %llu, page_off %u, err %d\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  page_off, err);
+
+	return NULL;
+}
+
+/*
+ * __ssdfs_decompress_blk_desc_fragment() - decompress blk desc fragment
+ * @pebi: pointer on PEB object
+ * @frag: fragment descriptor
+ * @area_offset: area offset in bytes
+ * @read_buffer: buffer to read [out]
+ * @buf_size: size of buffer in bytes
+ *
+ * This function tries to decompress block descriptor fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int __ssdfs_decompress_blk_desc_fragment(struct ssdfs_peb_info *pebi,
+					 struct ssdfs_fragment_desc *frag,
+					 u32 area_offset,
+					 void *read_buffer, size_t buf_size)
+{
+	void *cdata_buf = NULL;
+	u32 frag_offset;
+	u16 compr_size;
+	u16 uncompr_size;
+	int compr_type = SSDFS_COMPR_NONE;
+	__le32 checksum = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!frag || !read_buffer);
+
+	SSDFS_DBG("seg %llu, peb %llu, area_offset %u, buf_size %zu\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, area_offset, buf_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	frag_offset = le32_to_cpu(frag->offset);
+	compr_size = le16_to_cpu(frag->compr_size);
+	uncompr_size = le16_to_cpu(frag->uncompr_size);
+
+	if (buf_size < uncompr_size) {
+		SSDFS_ERR("invalid request: buf_size %zu < uncompr_size %u\n",
+			  buf_size, uncompr_size);
+		return -E2BIG;
+	}
+
+	cdata_buf = ssdfs_read_kzalloc(compr_size, GFP_KERNEL);
+	if (!cdata_buf) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate cdata_buf\n");
+		goto free_buf;
+	}
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 area_offset + frag_offset,
+					 compr_size,
+					 cdata_buf);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read blk desc fragment: "
+			  "frag_offset %u, compr_size %u, "
+			  "err %d\n",
+			  frag_offset, compr_size, err);
+		goto free_buf;
+	}
+
+	switch (frag->type) {
+	case SSDFS_DATA_BLK_DESC_ZLIB:
+		compr_type = SSDFS_COMPR_ZLIB;
+		break;
+
+	case SSDFS_DATA_BLK_DESC_LZO:
+		compr_type = SSDFS_COMPR_LZO;
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("compr_type %#x, cdata_buf %px, read_buffer %px, "
+		  "buf_size %zu, compr_size %u, uncompr_size %u\n",
+		  compr_type, cdata_buf, read_buffer,
+		  buf_size, compr_size, uncompr_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_decompress(compr_type,
+				cdata_buf, read_buffer,
+				compr_size, uncompr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to decompress fragment: "
+			  "seg %llu, peb %llu, "
+			  "compr_size %u, uncompr_size %u, "
+			  "err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  compr_size, uncompr_size,
+			  err);
+		goto free_buf;
+	}
+
+	if (frag->flags & SSDFS_FRAGMENT_HAS_CSUM) {
+		checksum = ssdfs_crc32_le(read_buffer, uncompr_size);
+		if (checksum != frag->checksum) {
+			err = -EIO;
+			SSDFS_ERR("invalid checksum: "
+				  "(calculated %#x, csum %#x)\n",
+				  le32_to_cpu(checksum),
+				  le32_to_cpu(frag->checksum));
+			goto free_buf;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BLK DESC FRAGMENT DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     read_buffer, buf_size);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+free_buf:
+	if (cdata_buf)
+		ssdfs_read_kfree(cdata_buf);
+
+	return err;
+}
+
+/*
+ * ssdfs_decompress_blk_desc_fragment() - decompress blk desc fragment
+ * @pebi: pointer on PEB object
+ * @frag: fragment descriptor
+ * @area_offset: area offset in bytes
+ *
+ * This function tries to decompress block descriptor fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_decompress_blk_desc_fragment(struct ssdfs_peb_info *pebi,
+					struct ssdfs_fragment_desc *frag,
+					u32 area_offset)
+{
+	struct ssdfs_peb_read_buffer *buf;
+	u16 uncompr_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!frag);
+	BUG_ON(!rwsem_is_locked(&pebi->read_buffer.lock));
+
+	SSDFS_DBG("seg %llu, peb %llu, area_offset %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  area_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	buf = &pebi->read_buffer.blk_desc;
+	uncompr_size = le16_to_cpu(frag->uncompr_size);
+
+	if (buf->size < uncompr_size) {
+		err = ssdfs_peb_realloc_read_buffer(buf, uncompr_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc read buffer: "
+				  "old_size %zu, new_size %u, err %d\n",
+				  buf->size, uncompr_size, err);
+			return err;
+		}
+	}
+
+	return __ssdfs_decompress_blk_desc_fragment(pebi, frag, area_offset,
+						    buf->ptr, buf->size);
+}
+
+/*
+ * ssdfs_peb_decompress_blk_desc_fragment() - decompress blk desc fragment
+ * @pebi: pointer on PEB object
+ * @meta_desc: area descriptor
+ * @offset: offset in bytes to read block descriptor
+ *
+ * This function tries to decompress block descriptor fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_decompress_blk_desc_fragment(struct ssdfs_peb_info *pebi,
+				struct ssdfs_metadata_descriptor *meta_desc,
+				u32 offset)
+{
+	struct ssdfs_area_block_table table;
+	size_t tbl_size = sizeof(struct ssdfs_area_block_table);
+	u32 area_offset;
+	u32 area_size;
+	u32 tbl_offset = 0;
+	u32 compr_bytes = 0;
+	u32 uncompr_bytes = 0;
+	u16 flags;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!meta_desc);
+	BUG_ON(!rwsem_is_locked(&pebi->read_buffer.lock));
+
+	SSDFS_DBG("seg %llu, peb %llu, offset %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	area_offset = le32_to_cpu(meta_desc->offset);
+	area_size = le32_to_cpu(meta_desc->size);
+
+try_read_area_block_table:
+	if ((tbl_offset + tbl_size) > area_size) {
+		SSDFS_ERR("area block table out of area: "
+			  "tbl_offset %u, tbl_size %zu, area_size %u\n",
+			  tbl_offset, tbl_size, area_size);
+		return -ERANGE;
+	}
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 area_offset + tbl_offset,
+					 tbl_size,
+					 &table);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read area block table: "
+			  "area_offset %u, area_size %u, "
+			  "tbl_offset %u, tbl_size %zu, err %d\n",
+			  area_offset, area_size,
+			  tbl_offset, tbl_size, err);
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
+	compr_bytes = le32_to_cpu(table.chain_hdr.compr_bytes);
+	uncompr_bytes += le32_to_cpu(table.chain_hdr.uncompr_bytes);
+
+	if (offset < uncompr_bytes) {
+		struct ssdfs_fragment_desc *frag;
+		u16 fragments_count;
+		u16 frag_uncompr_size;
+		int i;
+
+		uncompr_bytes -= le32_to_cpu(table.chain_hdr.uncompr_bytes);
+		fragments_count = le16_to_cpu(table.chain_hdr.fragments_count);
+
+		for (i = 0; i < fragments_count; i++) {
+			frag = &table.blk[i];
+
+			if (frag->magic != SSDFS_FRAGMENT_DESC_MAGIC) {
+				SSDFS_ERR("corrupted area block table: "
+					  "magic (expected %#x, found %#x)\n",
+					  SSDFS_FRAGMENT_DESC_MAGIC,
+					  frag->magic);
+				return -EIO;
+			}
+
+			switch (frag->type) {
+			case SSDFS_DATA_BLK_DESC_ZLIB:
+			case SSDFS_DATA_BLK_DESC_LZO:
+				/* expected type */
+				break;
+
+			default:
+				SSDFS_ERR("unexpected fragment's type %#x\n",
+					  frag->type);
+				return -EIO;
+			}
+
+			frag_uncompr_size = le16_to_cpu(frag->uncompr_size);
+			uncompr_bytes += frag_uncompr_size;
+
+			if (offset < uncompr_bytes) {
+				err = ssdfs_decompress_blk_desc_fragment(pebi,
+							    frag, area_offset);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to decompress: "
+						  "err %d\n", err);
+					return err;
+				}
+
+				break;
+			}
+		}
+
+		if (i >= fragments_count) {
+			SSDFS_ERR("corrupted area block table: "
+				  "i %d >= fragments_count %u\n",
+				  i, fragments_count);
+			return -EIO;
+		}
+	} else {
+		flags = le16_to_cpu(table.chain_hdr.flags);
+
+		if (!(flags & SSDFS_MULTIPLE_HDR_CHAIN)) {
+			SSDFS_ERR("corrupted area block table: "
+				  "invalid flags set %#x\n",
+				  flags);
+			return -EIO;
+		}
+
+		tbl_offset += compr_bytes;
+		goto try_read_area_block_table;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_block_descriptor() - read block descriptor
+ * @pebi: pointer on PEB object
+ * @meta_desc: area descriptor
+ * @offset: offset in bytes to read block descriptor
+ * @blk_desc: block descriptor [out]
+ *
+ * This function tries to read block descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_block_descriptor(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_metadata_descriptor *meta_desc,
+				    u32 offset,
+				    struct ssdfs_block_descriptor *blk_desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_temp_read_buffers *buf;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	int compr_type = SSDFS_COMPR_NONE;
+	u32 lower_bound = U32_MAX;
+	u32 upper_bound = U32_MAX;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!meta_desc || !blk_desc);
+
+	SSDFS_DBG("seg %llu, peb %llu, offset %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	flags = le16_to_cpu(meta_desc->check.flags);
+
+	if ((flags & SSDFS_ZLIB_COMPRESSED) && (flags & SSDFS_LZO_COMPRESSED)) {
+		SSDFS_ERR("invalid set of flags: "
+			  "flags %#x\n",
+			  flags);
+		return -ERANGE;
+	}
+
+	if (flags & SSDFS_ZLIB_COMPRESSED)
+		compr_type = SSDFS_COMPR_ZLIB;
+	else if (flags & SSDFS_LZO_COMPRESSED)
+		compr_type = SSDFS_COMPR_LZO;
+
+	if (compr_type != SSDFS_COMPR_NONE) {
+		buf = &pebi->read_buffer;
+
+		down_write(&buf->lock);
+
+		if (!buf->blk_desc.ptr) {
+			err = -ENOMEM;
+			SSDFS_ERR("buffer is not allocated\n");
+			goto finish_decompress;
+		}
+
+		lower_bound = buf->blk_desc.offset;
+		upper_bound = buf->blk_desc.offset + buf->blk_desc.size;
+
+		if (buf->blk_desc.offset >= U32_MAX) {
+			err = ssdfs_peb_decompress_blk_desc_fragment(pebi,
+								     meta_desc,
+								     offset);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to decompress: err %d\n",
+					  err);
+				goto finish_decompress;
+			}
+		} else if (offset < lower_bound || offset >= upper_bound) {
+			err = ssdfs_peb_decompress_blk_desc_fragment(pebi,
+								     meta_desc,
+								     offset);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to decompress: err %d\n",
+					  err);
+				goto finish_decompress;
+			}
+		}
+
+finish_decompress:
+		downgrade_write(&buf->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to decompress portion: "
+				  "err %d\n", err);
+			goto finish_read_compressed_blk_desc;
+		}
+
+		err = ssdfs_memcpy(blk_desc,
+				   0, blk_desc_size,
+				   buf->blk_desc.ptr,
+				   offset - lower_bound, buf->blk_desc.size,
+				   blk_desc_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("invalid buffer state: "
+				  "offset %u, buffer (offset %u, size %zu)\n",
+				  offset,
+				  buf->blk_desc.offset,
+				  buf->blk_desc.size);
+			goto finish_read_compressed_blk_desc;
+		}
+
+finish_read_compressed_blk_desc:
+		up_read(&buf->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read compressed block descriptor: "
+				  "offset %u, err %d\n",
+				  offset, err);
+			return err;
+		}
+	} else {
+		err = ssdfs_unaligned_read_cache(pebi, offset,
+						 blk_desc_size,
+						 blk_desc);
+		if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to read block descriptor: "
+				  "seg %llu, peb %llu, "
+				  "offset %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_find_block_descriptor() - find block descriptor
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ * @desc_off: descriptor of physical offset
+ * @blk_desc: block descriptor [out]
+ *
+ * This function tries to get block descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_find_block_descriptor(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_block_descriptor *blk_desc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_blk_state_offset *blk_state;
+	struct page *page;
+	struct pagevec pvec;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	int area_index;
+	u32 area_offset;
+	u32 area_size;
+	u32 blk_desc_off;
+	u64 calculated;
+	u32 page_off;
+	u32 pages_count;
+	u32 i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !array || !desc_off || !blk_desc);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "log_start_page %u, log_area %#x, "
+		  "peb_migration_id %u, byte_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  le16_to_cpu(desc_off->blk_state.log_start_page),
+		  desc_off->blk_state.log_area,
+		  desc_off->blk_state.peb_migration_id,
+		  le32_to_cpu(desc_off->blk_state.byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	blk_state = &desc_off->blk_state;
+
+	err = ssdfs_peb_read_log_hdr_desc_array(pebi, req,
+					le16_to_cpu(blk_state->log_start_page),
+					array, array_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read log's header desc array: "
+			  "seg %llu, peb %llu, log_start_page %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  le16_to_cpu(blk_state->log_start_page),
+			  err);
+		return err;
+	}
+
+	area_index = SSDFS_AREA_TYPE2INDEX(blk_state->log_area);
+
+	if (area_index >= SSDFS_SEG_HDR_DESC_MAX) {
+		SSDFS_ERR("invalid area index %#x\n", area_index);
+		return -ERANGE;
+	}
+
+	area_offset = le32_to_cpu(array[area_index].offset);
+	area_size = le32_to_cpu(array[area_index].size);
+	blk_desc_off = le32_to_cpu(blk_state->byte_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_offset %u, blk_desc_off %u\n",
+		  area_offset, blk_desc_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_read_block_descriptor(pebi, &array[area_index],
+					      area_offset + blk_desc_off,
+					      blk_desc);
+	if (err) {
+		page_off = (area_offset + blk_desc_off) / PAGE_SIZE;
+		pages_count = (area_size + PAGE_SIZE - 1) / PAGE_SIZE;
+		pages_count = min_t(u32, pages_count, PAGEVEC_SIZE);
+
+		pagevec_init(&pvec);
+
+		for (i = 0; i < pages_count; i++) {
+			page = ssdfs_page_array_grab_page(&pebi->cache,
+							  page_off + i);
+			if (unlikely(IS_ERR_OR_NULL(page))) {
+				SSDFS_ERR("fail to grab page: index %u\n",
+					  page_off);
+				return -ENOMEM;
+			}
+
+			if (PageUptodate(page) || PageDirty(page))
+				break;
+
+			pagevec_add(&pvec, page);
+		}
+
+		err = ssdfs_read_pagevec_from_volume(fsi, pebi->peb_id,
+						     page_off << PAGE_SHIFT,
+						     &pvec);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read pagevec: "
+				  "peb_id %llu, page_off %u, "
+				  "pages_count %u, err %d\n",
+				  pebi->peb_id, page_off,
+				  pages_count, err);
+			return err;
+		}
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			page = pvec.pages[i];
+
+			if (!page) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("page %d is NULL\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+				continue;
+			}
+
+			pvec.pages[i] = NULL;
+		}
+
+		pagevec_reinit(&pvec);
+
+		err = ssdfs_peb_read_block_descriptor(pebi, &array[area_index],
+						     area_offset + blk_desc_off,
+						     blk_desc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read block descriptor: "
+				  "peb %llu, area_offset %u, byte_offset %u, "
+				  "buf_size %zu, err %d\n",
+				  pebi->peb_id, area_offset, blk_desc_off,
+				  blk_desc_size, err);
+			return err;
+		}
+	}
+
+	if (le64_to_cpu(blk_desc->ino) != req->extent.ino) {
+		SSDFS_ERR("seg %llu, peb %llu, "
+			  "blk_desc->ino %llu != req->extent.ino %llu\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  le64_to_cpu(blk_desc->ino), req->extent.ino);
+		return -ERANGE;
+	}
+
+	calculated = (u64)req->result.processed_blks * fsi->pagesize;
+
+	if (calculated >= req->extent.data_bytes) {
+		SSDFS_ERR("calculated %llu >= req->extent.data_bytes %u\n",
+			  calculated, req->extent.data_bytes);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_peb_get_block_state_desc() - get block state descriptor
+ * @pebi: pointer on PEB object
+ * @req: segment request
+ * @area_desc: area descriptor
+ * @desc: block state descriptor [out]
+ * @cno: checkpoint ID [out]
+ * @parent_snapshot: parent snapshot ID [out]
+ *
+ * This function tries to get block state descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+int __ssdfs_peb_get_block_state_desc(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_metadata_descriptor *area_desc,
+				struct ssdfs_block_state_descriptor *desc,
+				u64 *cno, u64 *parent_snapshot)
+{
+	struct ssdfs_fs_info *fsi;
+	size_t state_desc_size = sizeof(struct ssdfs_block_state_descriptor);
+	u32 area_offset;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!area_desc || !desc);
+	BUG_ON(!cno || !parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	area_offset = le32_to_cpu(area_desc->offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, area_offset %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, area_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_unaligned_read_cache(pebi,
+					 area_offset,
+					 state_desc_size,
+					 desc);
+	if (err) {
+		SSDFS_DBG("cache hasn't requested page\n");
+
+		if (req->private.flags & SSDFS_REQ_READ_ONLY_CACHE)
+			return -ENOENT;
+
+		err = ssdfs_unaligned_read_buffer(fsi, pebi->peb_id,
+						  area_offset,
+						  desc, state_desc_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read buffer: "
+				  "peb %llu, area_offset %u, "
+				  "buf_size %zu, err %d\n",
+				  pebi->peb_id, area_offset,
+				  state_desc_size, err);
+			return err;
+		}
+	}
+
+	if (desc->chain_hdr.magic != SSDFS_CHAIN_HDR_MAGIC) {
+		SSDFS_ERR("chain header magic invalid\n");
+		return -EIO;
+	}
+
+	if (desc->chain_hdr.type != SSDFS_BLK_STATE_CHAIN_HDR) {
+		SSDFS_ERR("chain header type invalid\n");
+		return -EIO;
+	}
+
+	if (le16_to_cpu(desc->chain_hdr.desc_size) !=
+	    sizeof(struct ssdfs_fragment_desc)) {
+		SSDFS_ERR("fragment descriptor size is invalid\n");
+		return -EIO;
+	}
+
+	*cno = le64_to_cpu(desc->cno);
+	*parent_snapshot = le64_to_cpu(desc->parent_snapshot);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_get_block_state_desc() - get block state descriptor
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @area_desc: area descriptor
+ * @desc: block state descriptor [out]
+ *
+ * This function tries to get block state descriptor.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_get_block_state_desc(struct ssdfs_peb_info *pebi,
+				   struct ssdfs_segment_request *req,
+				   struct ssdfs_metadata_descriptor *area_desc,
+				   struct ssdfs_block_state_descriptor *desc)
+{
+	u64 cno;
+	u64 parent_snapshot;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !area_desc || !desc);
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_peb_get_block_state_desc(pebi, req, area_desc,
+						desc, &cno, &parent_snapshot);
+	if (err == -ENOENT) {
+		SSDFS_DBG("cache hasn't requested page\n");
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get block state descriptor: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (req->extent.cno != cno) {
+		SSDFS_ERR("req->extent.cno %llu != cno %llu\n",
+			  req->extent.cno, cno);
+		return -EIO;
+	}
+
+	if (req->extent.parent_snapshot != parent_snapshot) {
+		SSDFS_ERR("req->extent.parent_snapshot %llu != "
+			  "parent_snapshot %llu\n",
+			  req->extent.parent_snapshot,
+			  parent_snapshot);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_get_fragment_desc_array() - get fragment descriptors array
+ * @pebi: pointer on PEB object
+ * @req: segment request
+ * @array_offset: offset of array from the log's beginning
+ * @array: array of fragment descriptors [out]
+ * @array_size: count of items into array
+ *
+ * This function tries to get array of fragment descriptors.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_get_fragment_desc_array(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req,
+					u32 array_offset,
+					struct ssdfs_fragment_desc *array,
+					size_t array_size)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 page_index, page_off;
+	struct page *page;
+	size_t frag_desc_size = sizeof(struct ssdfs_fragment_desc);
+	size_t array_bytes = frag_desc_size * array_size;
+	size_t size = array_bytes;
+	size_t read_size = 0;
+	u32 buf_off = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!array);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "array_offset %u, array_size %zu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  array_offset, array_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+read_next_page:
+	page_off = array_offset % PAGE_SIZE;
+	read_size = min_t(size_t, size, PAGE_SIZE - page_off);
+
+	page_index = array_offset >> PAGE_SHIFT;
+	page = ssdfs_peb_read_page_locked(pebi, req, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = IS_ERR(page) ? PTR_ERR(page) : -ERANGE;
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't page: index %u\n",
+				  page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			SSDFS_ERR("fail to read locked page: index %u\n",
+				  page_index);
+		}
+		return err;
+	}
+
+	err = ssdfs_memcpy_from_page(array, buf_off, array_bytes,
+				     page, page_off, PAGE_SIZE,
+				     read_size);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: "
+			  "page_off %u, buf_off %u, "
+			  "read_size %zu, size %zu, err %d\n",
+			  page_off, buf_off,
+			  read_size, array_bytes, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	size -= read_size;
+	buf_off += read_size;
+	array_offset += read_size;
+
+	if (size != 0)
+		goto read_next_page;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_unaligned_read_fragment() - unaligned read fragment
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @byte_off: offset in bytes from PEB's begin
+ * @size: size of fragment in bytes
+ * @buf: buffer pointer
+ *
+ * This function tries to read fragment.
+ *
+ * RETURN:
+ * [success] - fragment has been read successfully.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_unaligned_read_fragment(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_segment_request *req,
+				      u32 byte_off,
+				      size_t size,
+				      void *buf)
+{
+	u32 page_index, page_off;
+	struct page *page;
+	size_t read_size = 0;
+	u32 buf_off = 0;
+	size_t array_bytes = size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(byte_off > pebi->pebc->parent_si->fsi->erasesize);
+	BUG_ON(size > PAGE_SIZE);
+	WARN_ON(size == 0);
+	BUG_ON(!buf);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "offset %u, size %zu, buf %p\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  byte_off, size, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+read_next_page:
+	if (byte_off > pebi->pebc->parent_si->fsi->erasesize) {
+		SSDFS_ERR("offset %u > erasesize %u\n",
+			  byte_off,
+			  pebi->pebc->parent_si->fsi->erasesize);
+		return -ERANGE;
+	}
+
+	page_off = byte_off % PAGE_SIZE;
+	read_size = min_t(size_t, size, PAGE_SIZE - page_off);
+
+	page_index = byte_off >> PAGE_SHIFT;
+	page = ssdfs_peb_read_page_locked(pebi, req, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = IS_ERR(page) ? PTR_ERR(page) : -ERANGE;
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't page: page_off %u\n",
+				  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			SSDFS_ERR("fail to read locked page: index %u\n",
+				  page_off);
+		}
+		return err;
+	}
+
+	err = ssdfs_memcpy_from_page(buf, buf_off, array_bytes,
+				     page, page_off, PAGE_SIZE,
+				     read_size);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: "
+			  "page_off %u, buf_off %u, "
+			  "read_size %zu, size %zu, err %d\n",
+			  page_off, buf_off,
+			  read_size, array_bytes, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	size -= read_size;
+	buf_off += read_size;
+	byte_off += read_size;
+
+	if (size != 0)
+		goto read_next_page;
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_checked_fragment() - read and check data fragment
+ * @pebi: pointer on PEB object
+ * @req: segment request
+ * @area_offset: offset in bytes from log's begin
+ * @sequence_id: fragment identification number
+ * @desc: fragment descriptor
+ * @cdata_buf: compressed data buffer
+ * @page: buffer for uncompressed data
+ *
+ * This function reads data fragment, uncompressed it
+ * (if neccessary) and check fragment's checksum.
+ *
+ * RETURN:
+ * [success] - fragment has been read successfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal calculation error.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_read_checked_fragment(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				u32 area_offset,
+				int sequence_id,
+				struct ssdfs_fragment_desc *desc,
+				void *cdata_buf,
+				struct page *page)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 pebsize;
+	u32 offset;
+	size_t compr_size, uncompr_size;
+	bool is_compressed;
+	void *kaddr;
+	__le32 checksum;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!desc || !cdata_buf || !page);
+
+	SSDFS_DBG("seg %llu, peb %llu, area_offset %u, sequence_id %u, "
+		  "offset %u, compr_size %u, uncompr_size %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  area_offset,
+		  le16_to_cpu(desc->sequence_id),
+		  le32_to_cpu(desc->offset),
+		  le16_to_cpu(desc->compr_size),
+		  le16_to_cpu(desc->uncompr_size));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (sequence_id != le16_to_cpu(desc->sequence_id)) {
+		SSDFS_ERR("sequence_id %d != desc->sequence_id %u\n",
+			  sequence_id, le16_to_cpu(desc->sequence_id));
+		return -EINVAL;
+	}
+
+	pebsize = fsi->pages_per_peb * fsi->pagesize;
+	offset = area_offset + le32_to_cpu(desc->offset);
+	compr_size = le16_to_cpu(desc->compr_size);
+	uncompr_size = le16_to_cpu(desc->uncompr_size);
+
+	if (offset >= pebsize) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"desc->offset %u >= pebsize %u\n",
+				offset, pebsize);
+		return -EIO;
+	}
+
+	if (uncompr_size > PAGE_SIZE) {
+		SSDFS_ERR("uncompr_size %zu > PAGE_SIZE %lu\n",
+			  uncompr_size, PAGE_SIZE);
+		return -ERANGE;
+	}
+
+	is_compressed = (desc->type == SSDFS_FRAGMENT_ZLIB_BLOB ||
+			 desc->type == SSDFS_FRAGMENT_LZO_BLOB);
+
+	if (desc->type == SSDFS_FRAGMENT_UNCOMPR_BLOB) {
+		if (compr_size != uncompr_size) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+					"compr_size %zu != uncompr_size %zu\n",
+					compr_size, uncompr_size);
+			return -EIO;
+		}
+
+		if (uncompr_size > PAGE_SIZE) {
+			ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+					"uncompr_size %zu > PAGE_CACHE %lu\n",
+					uncompr_size, PAGE_SIZE);
+			return -EIO;
+		}
+
+		kaddr = kmap_local_page(page);
+		err = ssdfs_peb_unaligned_read_fragment(pebi, req, offset,
+							uncompr_size,
+							kaddr);
+		if (!err)
+			checksum = ssdfs_crc32_le(kaddr, uncompr_size);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't requested page: "
+				  "seg %llu, peb %llu, offset %u, size %zu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  offset, uncompr_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read fragment: "
+				  "seg %llu, peb %llu, offset %u, size %zu, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  offset, uncompr_size, err);
+			return err;
+		}
+	} else if (is_compressed) {
+		int type;
+
+		err = ssdfs_peb_unaligned_read_fragment(pebi, req, offset,
+							compr_size,
+							cdata_buf);
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't requested page: "
+				  "seg %llu, peb %llu, offset %u, size %zu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  offset, uncompr_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read fragment: "
+				  "seg %llu, peb %llu, offset %u, size %zu, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  offset, compr_size, err);
+			return err;
+		}
+
+		if (desc->type == SSDFS_FRAGMENT_ZLIB_BLOB)
+			type = SSDFS_COMPR_ZLIB;
+		else if (desc->type == SSDFS_FRAGMENT_LZO_BLOB)
+			type = SSDFS_COMPR_LZO;
+		else
+			BUG();
+
+		kaddr = kmap_local_page(page);
+		err = ssdfs_decompress(type, cdata_buf, kaddr,
+					compr_size, uncompr_size);
+		if (!err)
+			checksum = ssdfs_crc32_le(kaddr, uncompr_size);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to decompress fragment: "
+				  "seg %llu, peb %llu, offset %u, "
+				  "compr_size %zu, uncompr_size %zu"
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  offset, compr_size, uncompr_size, err);
+			return err;
+		}
+	} else
+		BUG();
+
+	if (desc->checksum != checksum) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"desc->checksum %#x != checksum %#x\n",
+				le32_to_cpu(desc->checksum),
+				le32_to_cpu(checksum));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_main_area_page() - read main area's page
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ * @blk_state_off: block state offset
+ *
+ * This function tries to read main area's page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_main_area_page(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_segment_request *req,
+				  struct ssdfs_metadata_descriptor *array,
+				  size_t array_size,
+				  struct ssdfs_blk_state_offset *blk_state_off)
+{
+	struct ssdfs_fs_info *fsi;
+	u8 area_index;
+	u32 area_offset;
+	u32 data_bytes;
+	u32 read_bytes;
+	u32 byte_offset;
+	int page_index;
+	struct page *page;
+	void *kaddr;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !array || !blk_state_off);
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	area_index = SSDFS_AREA_TYPE2INDEX(blk_state_off->log_area);
+	if (area_index >= array_size) {
+		SSDFS_ERR("area_index %u >= array_size %zu\n",
+			  area_index, array_size);
+		return -EIO;
+	}
+
+	read_bytes = req->result.processed_blks * fsi->pagesize;
+
+	if (read_bytes > req->extent.data_bytes) {
+		SSDFS_ERR("read_bytes %u > req->extent.data_bytes %u\n",
+			  read_bytes, req->extent.data_bytes);
+		return -ERANGE;
+	} else if (read_bytes == req->extent.data_bytes) {
+		SSDFS_WARN("read_bytes %u == req->extent.data_bytes %u\n",
+			   read_bytes, req->extent.data_bytes);
+		return -ERANGE;
+	}
+
+	data_bytes = req->extent.data_bytes - read_bytes;
+
+	if (fsi->pagesize > PAGE_SIZE)
+		data_bytes = min_t(u32, data_bytes, fsi->pagesize);
+	else
+		data_bytes = min_t(u32, data_bytes, PAGE_SIZE);
+
+	area_offset = le32_to_cpu(array[area_index].offset);
+	byte_offset = le32_to_cpu(blk_state_off->byte_offset);
+
+	page_index = (int)(read_bytes >> PAGE_SHIFT);
+	BUG_ON(page_index >= U16_MAX);
+
+	if (req->private.flags & SSDFS_REQ_PREPARE_DIFF) {
+		if (pagevec_count(&req->result.old_state) <= page_index) {
+			SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+				  page_index,
+				  pagevec_count(&req->result.old_state));
+			return -EIO;
+		}
+
+		page = req->result.old_state.pages[page_index];
+	} else {
+		if (pagevec_count(&req->result.pvec) <= page_index) {
+			SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+				  page_index,
+				  pagevec_count(&req->result.pvec));
+			return -EIO;
+		}
+
+		page = req->result.pvec.pages[page_index];
+	}
+
+	kaddr = kmap_local_page(page);
+	err = ssdfs_peb_unaligned_read_fragment(pebi, req,
+						area_offset + byte_offset,
+						data_bytes,
+						kaddr);
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read page: "
+			  "seg %llu, peb %llu, offset %u, size %u, "
+			  "err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  area_offset + byte_offset, data_bytes, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_area_fragment() - read area's fragment
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ * @blk_state_off: block state offset
+ *
+ * This function tries to read area's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_area_fragment(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req,
+				 struct ssdfs_metadata_descriptor *array,
+				 size_t array_size,
+				 struct ssdfs_blk_state_offset *blk_state_off)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_block_state_descriptor found_blk_state;
+	size_t state_desc_size = sizeof(struct ssdfs_block_state_descriptor);
+	struct ssdfs_fragment_desc *frag_descs = NULL;
+	size_t frag_desc_size = sizeof(struct ssdfs_fragment_desc);
+	void *cdata_buf = NULL;
+	u8 area_index;
+	u32 area_offset;
+	u32 frag_desc_offset;
+	u32 full_offset;
+	u32 data_bytes;
+	u32 read_bytes;
+	int page_index;
+	u16 fragments;
+	u32 uncompr_bytes;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !array || !blk_state_off);
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	area_index = SSDFS_AREA_TYPE2INDEX(blk_state_off->log_area);
+	if (area_index >= array_size) {
+		SSDFS_ERR("area_index %u >= array_size %zu\n",
+			  area_index, array_size);
+		return -EIO;
+	}
+
+	read_bytes = req->result.processed_blks * fsi->pagesize;
+
+	if (read_bytes > req->extent.data_bytes) {
+		SSDFS_ERR("read_bytes %u > req->extent.data_bytes %u\n",
+			  read_bytes, req->extent.data_bytes);
+		return -ERANGE;
+	} else if (read_bytes == req->extent.data_bytes) {
+		SSDFS_WARN("read_bytes %u == req->extent.data_bytes %u\n",
+			   read_bytes, req->extent.data_bytes);
+		return -ERANGE;
+	}
+
+	data_bytes = req->extent.data_bytes - read_bytes;
+
+	if (fsi->pagesize > PAGE_SIZE)
+		data_bytes = min_t(u32, data_bytes, fsi->pagesize);
+	else
+		data_bytes = min_t(u32, data_bytes, PAGE_SIZE);
+
+	err = ssdfs_peb_get_block_state_desc(pebi, req, &array[area_index],
+					     &found_blk_state);
+	if (err == -ENOENT) {
+		SSDFS_DBG("cache hasn't requested page\n");
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get block state descriptor: "
+			  "area_offset %u, err %d\n",
+			  le32_to_cpu(array[area_index].offset),
+			  err);
+		return err;
+	}
+
+	uncompr_bytes = le32_to_cpu(found_blk_state.chain_hdr.uncompr_bytes);
+	if (data_bytes > uncompr_bytes) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("data_bytes %u > uncompr_bytes %u\n",
+			  data_bytes, uncompr_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		req->extent.data_bytes -= data_bytes - uncompr_bytes;
+		data_bytes = uncompr_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("CORRECTED VALUE: data_bytes %u\n",
+			  data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	fragments = le16_to_cpu(found_blk_state.chain_hdr.fragments_count);
+	if (fragments == 0 || fragments > SSDFS_FRAGMENTS_CHAIN_MAX) {
+		SSDFS_ERR("invalid fragments count %u\n", fragments);
+		return -EIO;
+	}
+
+	frag_descs = ssdfs_read_kcalloc(fragments, frag_desc_size, GFP_KERNEL);
+	if (!frag_descs) {
+		SSDFS_ERR("fail to allocate fragment descriptors array\n");
+		return -ENOMEM;
+	}
+
+	area_offset = le32_to_cpu(array[area_index].offset);
+	frag_desc_offset = le32_to_cpu(blk_state_off->byte_offset);
+	frag_desc_offset += state_desc_size;
+	full_offset = area_offset + frag_desc_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_offset %u, blk_state_off->byte_offset %u, "
+		  "state_desc_size %zu, frag_desc_offset %u, "
+		  "full_offset %u\n",
+		  area_offset, le32_to_cpu(blk_state_off->byte_offset),
+		  state_desc_size, frag_desc_offset, full_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_get_fragment_desc_array(pebi, req, full_offset,
+						frag_descs, fragments);
+	if (err == -ENOENT) {
+		SSDFS_DBG("cache hasn't requested page\n");
+		goto free_bufs;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get fragment descriptor array: "
+			  "offset %u, fragments %u, err %d\n",
+			  full_offset, fragments, err);
+		goto free_bufs;
+	}
+
+	cdata_buf = ssdfs_read_kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!cdata_buf) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate cdata_buf\n");
+		goto free_bufs;
+	}
+
+	page_index = (int)(read_bytes >> PAGE_SHIFT);
+	BUG_ON(page_index >= U16_MAX);
+
+	for (i = 0; i < fragments; i++) {
+		struct pagevec *pvec;
+		struct page *page;
+		struct ssdfs_fragment_desc *cur_desc;
+		u32 compr_size;
+
+		if (req->private.flags & SSDFS_REQ_PREPARE_DIFF) {
+			pvec = &req->result.old_state;
+
+			if (pagevec_count(pvec) <= i) {
+				err = -EIO;
+				SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+					  i, pagevec_count(pvec));
+				goto free_bufs;
+			}
+		} else {
+			pvec = &req->result.pvec;
+
+			if (pagevec_count(pvec) <= (page_index + i)) {
+				err = -EIO;
+				SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+					  page_index + i,
+					  pagevec_count(pvec));
+				goto free_bufs;
+			}
+		}
+
+		cur_desc = &frag_descs[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("FRAGMENT DESC DUMP: index %d\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     cur_desc,
+				     sizeof(struct ssdfs_fragment_desc));
+		SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (cur_desc->magic != SSDFS_FRAGMENT_DESC_MAGIC) {
+			err = -EIO;
+			SSDFS_ERR("invalid fragment descriptor magic\n");
+			goto free_bufs;
+		}
+
+		if (cur_desc->type < SSDFS_FRAGMENT_UNCOMPR_BLOB ||
+		    cur_desc->type > SSDFS_FRAGMENT_LZO_BLOB) {
+			err = -EIO;
+			SSDFS_ERR("invalid fragment descriptor type\n");
+			goto free_bufs;
+		}
+
+		if (cur_desc->sequence_id != i) {
+			err = -EIO;
+			SSDFS_ERR("invalid fragment's sequence id\n");
+			goto free_bufs;
+		}
+
+		compr_size = le16_to_cpu(cur_desc->compr_size);
+
+		if (compr_size > PAGE_SIZE) {
+			err = -EIO;
+			SSDFS_ERR("compr_size %u > PAGE_SIZE %lu\n",
+				  compr_size, PAGE_SIZE);
+			goto free_bufs;
+		}
+
+		if (req->private.flags & SSDFS_REQ_PREPARE_DIFF)
+			page = pvec->pages[i];
+		else
+			page = pvec->pages[page_index + i];
+
+		err = ssdfs_read_checked_fragment(pebi, req, area_offset,
+						  i, cur_desc,
+						  cdata_buf,
+						  page);
+		if (err == -ENOENT) {
+			SSDFS_DBG("cache hasn't requested page\n");
+			goto free_bufs;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read fragment: "
+				  "index %d, err %d\n",
+				  i, err);
+			goto free_bufs;
+		}
+	}
+
+free_bufs:
+	ssdfs_read_kfree(frag_descs);
+	ssdfs_read_kfree(cdata_buf);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_read_base_block_state() - read base state of block
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ * @offset: block state offset
+ *
+ * This function tries to extract a base state of block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - cache hasn't requested page.
+ */
+static
+int ssdfs_peb_read_base_block_state(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_segment_request *req,
+				    struct ssdfs_metadata_descriptor *array,
+				    size_t array_size,
+				    struct ssdfs_blk_state_offset *offset)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req || !array || !offset);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_read_log_hdr_desc_array(pebi, req,
+					le16_to_cpu(offset->log_start_page),
+					array, array_size);
+	if (err == -ENOENT) {
+		SSDFS_DBG("cache hasn't requested page\n");
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read log's header desc array: "
+			  "seg %llu, peb %llu, log_start_page %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  le16_to_cpu(offset->log_start_page),
+			  err);
+		return err;
+	}
+
+	if (offset->log_area == SSDFS_LOG_MAIN_AREA) {
+		err = ssdfs_peb_read_main_area_page(pebi, req,
+						    array, array_size,
+						    offset);
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't requested page: "
+				  "seg %llu, peb %llu, "
+				  "ino %llu, logical_offset %llu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  req->extent.ino,
+				  req->extent.logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read main area's page: "
+				  "seg %llu, peb %llu, "
+				  "ino %llu, logical_offset %llu, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  req->extent.ino,
+				  req->extent.logical_offset,
+				  err);
+			return err;
+		}
+	} else {
+		err = ssdfs_peb_read_area_fragment(pebi, req,
+						   array, array_size,
+						   offset);
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't requested page: "
+				  "seg %llu, peb %llu, "
+				  "ino %llu, logical_offset %llu\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  req->extent.ino,
+				  req->extent.logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read area's fragment: "
+				  "seg %llu, peb %llu, "
+				  "ino %llu, logical_offset %llu, "
+				  "err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  req->extent.ino,
+				  req->extent.logical_offset,
+				  err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_area_diff_fragment() - read diff fragment
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ * @blk_state_off: block state offset
+ * @page: page with current diff blob
+ * @sequence_id: sequence ID of the fragment
+ *
+ * This function tries to extract a diff blob into @page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_area_diff_fragment(struct ssdfs_peb_info *pebi,
+				 struct ssdfs_segment_request *req,
+				 struct ssdfs_metadata_descriptor *array,
+				 size_t array_size,
+				 struct ssdfs_blk_state_offset *blk_state_off,
+				 struct page *page,
+				 int sequence_id)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_block_state_descriptor found_blk_state;
+	size_t state_desc_size = sizeof(struct ssdfs_block_state_descriptor);
+	struct ssdfs_fragment_desc frag_desc = {0};
+	void *cdata_buf = NULL;
+	u8 area_index;
+	u32 area_offset;
+	u32 frag_desc_offset;
+	u32 full_offset;
+	u16 fragments;
+	u64 cno;
+	u64 parent_snapshot;
+	u32 compr_size;
+#ifdef CONFIG_SSDFS_DEBUG
+	void *kaddr;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!array || !blk_state_off || !page);
+
+	SSDFS_DBG("seg %llu, peb %llu, sequence_id %d\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	err = ssdfs_peb_read_log_hdr_desc_array(pebi, req,
+				le16_to_cpu(blk_state_off->log_start_page),
+				array, array_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read log's header desc array: "
+			  "seg %llu, peb %llu, log_start_page %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  le16_to_cpu(blk_state_off->log_start_page),
+			  err);
+		return err;
+	}
+
+	area_index = SSDFS_AREA_TYPE2INDEX(blk_state_off->log_area);
+	if (area_index >= array_size) {
+		SSDFS_ERR("area_index %u >= array_size %zu\n",
+			  area_index, array_size);
+		return -EIO;
+	}
+
+	err = __ssdfs_peb_get_block_state_desc(pebi, req, &array[area_index],
+						&found_blk_state,
+						&cno, &parent_snapshot);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get block state descriptor: "
+			  "area_offset %u, err %d\n",
+			  le32_to_cpu(array[area_index].offset),
+			  err);
+		return err;
+	}
+
+	fragments = le16_to_cpu(found_blk_state.chain_hdr.fragments_count);
+	if (fragments == 0 || fragments > 1) {
+		SSDFS_ERR("invalid fragments count %u\n", fragments);
+		return -EIO;
+	}
+
+	area_offset = le32_to_cpu(array[area_index].offset);
+	frag_desc_offset = le32_to_cpu(blk_state_off->byte_offset);
+	frag_desc_offset += state_desc_size;
+	full_offset = area_offset + frag_desc_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area_offset %u, blk_state_off->byte_offset %u, "
+		  "state_desc_size %zu, frag_desc_offset %u, "
+		  "full_offset %u\n",
+		  area_offset, le32_to_cpu(blk_state_off->byte_offset),
+		  state_desc_size, frag_desc_offset, full_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_get_fragment_desc_array(pebi, req, full_offset,
+						&frag_desc, 1);
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cache hasn't requested page: "
+			  "seg %llu, peb %llu\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get fragment descriptor array: "
+			  "offset %u, fragments %u, err %d\n",
+			  full_offset, fragments, err);
+		return err;
+	}
+
+	cdata_buf = ssdfs_read_kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!cdata_buf) {
+		SSDFS_ERR("fail to allocate cdata_buf\n");
+		return -ENOMEM;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("FRAGMENT DESC DUMP: index %d\n", sequence_id);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     &frag_desc,
+			     sizeof(struct ssdfs_fragment_desc));
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (frag_desc.magic != SSDFS_FRAGMENT_DESC_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid fragment descriptor magic\n");
+		goto free_bufs;
+	}
+
+	if (frag_desc.type < SSDFS_FRAGMENT_UNCOMPR_BLOB ||
+	    frag_desc.type > SSDFS_FRAGMENT_LZO_BLOB) {
+		err = -EIO;
+		SSDFS_ERR("invalid fragment descriptor type\n");
+		goto free_bufs;
+	}
+
+	compr_size = le16_to_cpu(frag_desc.compr_size);
+
+	if (compr_size > PAGE_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("compr_size %u > PAGE_SIZE %lu\n",
+			  compr_size, PAGE_SIZE);
+		goto free_bufs;
+	}
+
+	err = ssdfs_read_checked_fragment(pebi, req, area_offset,
+					  0, &frag_desc,
+					  cdata_buf,
+					  page);
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cache hasn't requested page: "
+			  "seg %llu, peb %llu\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto free_bufs;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read fragment: "
+			  "index %d, err %d\n",
+			  sequence_id, err);
+		goto free_bufs;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	kaddr = kmap_local_page(page);
+	SSDFS_DBG("DIFF DUMP: index %d\n",
+		  sequence_id);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+	kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+free_bufs:
+	if (cdata_buf)
+		ssdfs_read_kfree(cdata_buf);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_read_diff_block_state() - read diff blob
+ * @pebi: pointer on PEB object
+ * @req: request
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ * @offset: block state offset
+ *
+ * This function tries to extract a diff blob.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_read_diff_block_state(struct ssdfs_peb_info *pebi,
+				    struct ssdfs_segment_request *req,
+				    struct ssdfs_metadata_descriptor *array,
+				    size_t array_size,
+				    struct ssdfs_blk_state_offset *offset)
+{
+	struct page *page = NULL;
+	int sequence_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!array || !offset);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+
+	SSDFS_DBG("seg %llu, peb %llu, pagevec_size %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pagevec_count(&req->result.diffs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_request_allocate_and_add_diff_page(req);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		err = !page ? -ENOMEM : PTR_ERR(page);
+		SSDFS_ERR("fail to add pagevec page: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_lock_page(page);
+
+	sequence_id = pagevec_count(&req->result.diffs) - 1;
+	err = ssdfs_peb_read_area_diff_fragment(pebi, req, array, array_size,
+						offset, page, sequence_id);
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cache hasn't requested page: "
+			  "seg %llu, peb %llu\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read area's fragment: "
+			  "seg %llu, peb %llu, "
+			  "err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk_desc_buffer_init() - init block descriptor buffer
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @desc_off: block descriptor offset
+ * @pos: offset position
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ *
+ * This function tries to init block descriptor buffer.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+int ssdfs_blk_desc_buffer_init(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size)
+{
+	struct ssdfs_peb_info *pebi = NULL;
+	struct ssdfs_blk2off_table *table;
+	u8 peb_migration_id;
+	u16 logical_blk;
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_blk_state_offset *state_off;
+	int j;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!desc_off || !pos);
+
+	SSDFS_DBG("seg %llu, peb_index %u, blk_desc.status %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  pos->blk_desc.status);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (pos->blk_desc.status) {
+	case SSDFS_BLK_DESC_BUF_UNKNOWN_STATE:
+	case SSDFS_BLK_DESC_BUF_ALLOCATED:
+		peb_migration_id = desc_off->blk_state.peb_migration_id;
+
+		pebi = ssdfs_get_peb_for_migration_id(pebc, peb_migration_id);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			goto finish_blk_desc_buffer_init;
+		}
+
+		err = ssdfs_peb_find_block_descriptor(pebi, req,
+						      array, array_size,
+						      desc_off,
+						      &pos->blk_desc.buf);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find block descriptor: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			goto finish_blk_desc_buffer_init;
+		}
+
+		pos->blk_desc.status = SSDFS_BLK_DESC_BUF_INITIALIZED;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("status %#x, ino %llu, "
+			  "logical_offset %u, peb_index %u, peb_page %u\n",
+			  pos->blk_desc.status,
+			  le64_to_cpu(pos->blk_desc.buf.ino),
+			  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+			  le16_to_cpu(pos->blk_desc.buf.peb_index),
+			  le16_to_cpu(pos->blk_desc.buf.peb_page));
+
+		for (j = 0; j < SSDFS_BLK_STATE_OFF_MAX; j++) {
+			state_off = &pos->blk_desc.buf.state[j];
+
+			SSDFS_DBG("BLK STATE OFFSET %d: "
+				  "log_start_page %u, log_area %#x, "
+				  "byte_offset %u, peb_migration_id %u\n",
+				  j,
+				  le16_to_cpu(state_off->log_start_page),
+				  state_off->log_area,
+				  le32_to_cpu(state_off->byte_offset),
+				  state_off->peb_migration_id);
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		table = pebi->pebc->parent_si->blk2off_table;
+		logical_blk = req->place.start.blk_index +
+					req->result.processed_blks;
+
+		err = ssdfs_blk2off_table_blk_desc_init(table, logical_blk,
+							pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init blk desc: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			goto finish_blk_desc_buffer_init;
+		}
+		break;
+
+	case SSDFS_BLK_DESC_BUF_INITIALIZED:
+		/* do nothing */
+		SSDFS_DBG("descriptor buffer is initialized already\n");
+		break;
+
+	default:
+		SSDFS_ERR("pos->blk_desc.status %#x\n",
+			  pos->blk_desc.status);
+		BUG();
+	}
+
+finish_blk_desc_buffer_init:
+	return err;
+}
+
+/*
+ * ssdfs_peb_read_block_state() - read state of the block
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @desc_off: block descriptor offset
+ * @pos: offset position
+ * @array: array of area's descriptors
+ * @array_size: count of items into array
+ *
+ * This function tries to read block state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - I/O error.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+int ssdfs_peb_read_block_state(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size)
+{
+	struct ssdfs_peb_info *pebi = NULL;
+	struct ssdfs_blk_state_offset *offset = NULL;
+	u64 ino;
+	u32 logical_offset;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req || !array);
+	BUG_ON(array_size != SSDFS_SEG_HDR_DESC_MAX);
+
+	SSDFS_DBG("seg %llu, peb_index %u, processed_blks %d\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_blk_desc_buffer_init(pebc, req, desc_off, pos,
+					 array, array_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init blk desc buffer: err %d\n",
+			  err);
+		goto finish_prepare_pvec;
+	}
+
+	ino = le64_to_cpu(pos->blk_desc.buf.ino);
+	logical_offset = le32_to_cpu(pos->blk_desc.buf.logical_offset);
+
+	offset = &pos->blk_desc.buf.state[0];
+
+	if (IS_SSDFS_BLK_STATE_OFFSET_INVALID(offset)) {
+		err = -ERANGE;
+		SSDFS_ERR("block state offset invalid\n");
+		SSDFS_ERR("log_start_page %u, log_area %u, "
+			  "peb_migration_id %u, byte_offset %u\n",
+			  le16_to_cpu(offset->log_start_page),
+			  offset->log_area,
+			  offset->peb_migration_id,
+			  le32_to_cpu(offset->byte_offset));
+		goto finish_prepare_pvec;
+	}
+
+	pebi = ssdfs_get_peb_for_migration_id(pebc, offset->peb_migration_id);
+	if (IS_ERR_OR_NULL(pebi)) {
+		err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+		SSDFS_ERR("fail to get PEB object: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		goto finish_prepare_pvec;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	DEBUG_BLOCK_DESCRIPTOR(pebi->pebc->parent_si->seg_id,
+				pebi->peb_id, &pos->blk_desc.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_read_base_block_state(pebi, req,
+					      array, array_size,
+					      offset);
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to read block state: "
+			  "seg %llu, peb_index %u, ino %llu, "
+			  "logical_offset %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  ino, logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_prepare_pvec;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read block state: "
+			  "seg %llu, peb_index %u, ino %llu, "
+			  "logical_offset %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  ino, logical_offset,
+			  err);
+		goto finish_prepare_pvec;
+	}
+
+	for (i = 0; i < SSDFS_BLK_STATE_OFF_MAX; i++) {
+		offset = &pos->blk_desc.buf.state[i];
+
+		if (i == 0) {
+			/*
+			 * base block state has been read already
+			 */
+			continue;
+		} else {
+			if (IS_SSDFS_BLK_STATE_OFFSET_INVALID(offset))
+				goto finish_prepare_pvec;
+
+			pebi = ssdfs_get_peb_for_migration_id(pebc,
+						offset->peb_migration_id);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				goto finish_prepare_pvec;
+			}
+
+			err = ssdfs_peb_read_diff_block_state(pebi,
+							      req,
+							      array,
+							      array_size,
+							      offset);
+		}
+
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cache hasn't requested page: "
+				  "seg %llu, peb_index %u, ino %llu, "
+				  "logical_offset %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  ino, logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_prepare_pvec;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read block state: "
+				  "seg %llu, peb_index %u, ino %llu, "
+				  "logical_offset %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  ino, logical_offset, err);
+			goto finish_prepare_pvec;
+		}
+	}
+
+finish_prepare_pvec:
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to read the block state: "
+			  "seg %llu, peb_index %u, ino %llu, "
+			  "logical_offset %u, peb_index %u, "
+			  "peb_page %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  le64_to_cpu(pos->blk_desc.buf.ino),
+			  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+			  le16_to_cpu(pos->blk_desc.buf.peb_index),
+			  le16_to_cpu(pos->blk_desc.buf.peb_page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_read_block_state;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read the block state: "
+			  "seg %llu, peb_index %u, ino %llu, "
+			  "logical_offset %u, peb_index %u, "
+			  "peb_page %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  le64_to_cpu(pos->blk_desc.buf.ino),
+			  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+			  le16_to_cpu(pos->blk_desc.buf.peb_index),
+			  le16_to_cpu(pos->blk_desc.buf.peb_page),
+			  err);
+		goto finish_read_block_state;
+	}
+
+	if (pagevec_count(&req->result.diffs) == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("diffs pagevec is empty: "
+			  "seg %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_read_block_state;
+	}
+
+	switch (pebi->pebc->peb_type) {
+	case SSDFS_MAPTBL_DATA_PEB_TYPE:
+		err = ssdfs_user_data_apply_diffs(pebi, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to apply diffs on base state: "
+				  "seg %llu, peb_index %u, ino %llu, "
+				  "logical_offset %u, peb_index %u, "
+				  "peb_page %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  le64_to_cpu(pos->blk_desc.buf.ino),
+				  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+				  le16_to_cpu(pos->blk_desc.buf.peb_index),
+				  le16_to_cpu(pos->blk_desc.buf.peb_page),
+				  err);
+			goto finish_read_block_state;
+		}
+		break;
+
+	case SSDFS_MAPTBL_LNODE_PEB_TYPE:
+	case SSDFS_MAPTBL_HNODE_PEB_TYPE:
+	case SSDFS_MAPTBL_IDXNODE_PEB_TYPE:
+		err = ssdfs_btree_node_apply_diffs(pebi, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to apply diffs on base state: "
+				  "seg %llu, peb_index %u, ino %llu, "
+				  "logical_offset %u, peb_index %u, "
+				  "peb_page %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  le64_to_cpu(pos->blk_desc.buf.ino),
+				  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+				  le16_to_cpu(pos->blk_desc.buf.peb_index),
+				  le16_to_cpu(pos->blk_desc.buf.peb_page),
+				  err);
+			goto finish_read_block_state;
+		}
+		break;
+
+	default:
+		err = -EOPNOTSUPP;
+		SSDFS_ERR("diff-on-write is not supported: "
+			  "seg %llu, peb_index %u, peb_type %#x, ino %llu, "
+			  "logical_offset %u, peb_index %u, "
+			  "peb_page %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  pebi->pebc->peb_type,
+			  le64_to_cpu(pos->blk_desc.buf.ino),
+			  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+			  le16_to_cpu(pos->blk_desc.buf.peb_index),
+			  le16_to_cpu(pos->blk_desc.buf.peb_page),
+			  err);
+		goto finish_read_block_state;
+	}
+
+finish_read_block_state:
+	if (!err && !(req->private.flags & SSDFS_REQ_PREPARE_DIFF))
+		req->result.processed_blks++;
+
+	if (err)
+		ssdfs_request_unlock_and_remove_old_state(req);
+
+	ssdfs_request_unlock_and_remove_diffs(req);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_read_page() - read page from PEB
+ * @pebc: pointer on PEB container
+ * @req: request [in|out]
+ * @end: pointer on waiting queue [out]
+ *
+ * This function tries to read PEB's page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - PEB object is not initialized yet.
+ */
+int ssdfs_peb_read_page(struct ssdfs_peb_container *pebc,
+			struct ssdfs_segment_request *req,
+			struct completion **end)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_phys_offset_descriptor *desc_off = NULL;
+	struct ssdfs_blk_state_offset *blk_state = NULL;
+	u16 logical_blk;
+	u16 log_start_page;
+	struct ssdfs_metadata_descriptor desc_array[SSDFS_SEG_HDR_DESC_MAX];
+	u8 peb_migration_id;
+	u16 peb_index;
+	int migration_state = SSDFS_LBLOCK_UNKNOWN_STATE;
+	struct ssdfs_offset_position pos = {0};
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x, "
+		  "ino %llu, logical_offset %llu, data_bytes %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd, req->private.type,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+
+	if (req->extent.data_bytes == 0) {
+		SSDFS_WARN("empty read request: ino %llu, logical_offset %llu\n",
+			   req->extent.ino, req->extent.logical_offset);
+		return 0;
+	}
+
+	table = pebc->parent_si->blk2off_table;
+	logical_blk = req->place.start.blk_index + req->result.processed_blks;
+
+	desc_off = ssdfs_blk2off_table_convert(table, logical_blk,
+						&peb_index,
+						&migration_state,
+						&pos);
+	if (IS_ERR(desc_off) && PTR_ERR(desc_off) == -EAGAIN) {
+		struct completion *init_end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		desc_off = ssdfs_blk2off_table_convert(table, logical_blk,
+							&peb_index,
+							&migration_state,
+							&pos);
+	}
+
+	if (IS_ERR_OR_NULL(desc_off)) {
+		err = (desc_off == NULL ? -ERANGE : PTR_ERR(desc_off));
+		SSDFS_ERR("fail to convert: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+	peb_migration_id = desc_off->blk_state.peb_migration_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, peb_index %u, "
+		  "logical_offset %u, logical_blk %u, peb_page %u, "
+		  "log_start_page %u, log_area %u, "
+		  "peb_migration_id %u, byte_offset %u\n",
+		  logical_blk, pebc->peb_index,
+		  le32_to_cpu(desc_off->page_desc.logical_offset),
+		  le16_to_cpu(desc_off->page_desc.logical_blk),
+		  le16_to_cpu(desc_off->page_desc.peb_page),
+		  le16_to_cpu(desc_off->blk_state.log_start_page),
+		  desc_off->blk_state.log_area,
+		  desc_off->blk_state.peb_migration_id,
+		  le32_to_cpu(desc_off->blk_state.byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_ssdfs_logical_block_migrating(migration_state)) {
+		err = ssdfs_blk2off_table_get_block_state(table, req);
+		if (err == -EAGAIN) {
+			desc_off = ssdfs_blk2off_table_convert(table,
+							    logical_blk,
+							    &peb_index,
+							    &migration_state,
+							    &pos);
+			if (IS_ERR_OR_NULL(desc_off)) {
+				err = (desc_off == NULL ?
+						-ERANGE : PTR_ERR(desc_off));
+				SSDFS_ERR("fail to convert: "
+					  "logical_blk %u, err %d\n",
+					  logical_blk, err);
+				return err;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to get migrating block state: "
+				  "logical_blk %u, peb_index %u, err %d\n",
+				  logical_blk, pebc->peb_index, err);
+			return err;
+		} else
+			return 0;
+	}
+
+	down_read(&pebc->lock);
+
+	blk_state = &desc_off->blk_state;
+	log_start_page = le16_to_cpu(blk_state->log_start_page);
+
+	if (log_start_page >= fsi->pages_per_peb) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid log_start_page %u\n", log_start_page);
+		goto finish_read_page;
+	}
+
+	err = ssdfs_peb_read_block_state(pebc, req,
+					 desc_off, &pos,
+					 desc_array,
+					 SSDFS_SEG_HDR_DESC_MAX);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read block state: "
+			  "seg %llu, peb_index %u, "
+			  "class %#x, cmd %#x, type %#x, "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, migration_state %#x, "
+			  "err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  req->private.class, req->private.cmd,
+			  req->private.type,
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->extent.data_bytes,
+			  migration_state,
+			  err);
+
+		SSDFS_ERR("seg_id %llu, peb_index %u, ino %llu, "
+			  "logical_offset %u, peb_index %u, "
+			  "peb_page %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  le64_to_cpu(pos.blk_desc.buf.ino),
+			  le32_to_cpu(pos.blk_desc.buf.logical_offset),
+			  le16_to_cpu(pos.blk_desc.buf.peb_index),
+			  le16_to_cpu(pos.blk_desc.buf.peb_page));
+
+		for (i = 0; i < SSDFS_BLK_STATE_OFF_MAX; i++) {
+			blk_state = &pos.blk_desc.buf.state[i];
+
+			SSDFS_ERR("BLK STATE OFFSET %d: "
+				  "log_start_page %u, log_area %#x, "
+				  "byte_offset %u, peb_migration_id %u\n",
+				  i,
+				  le16_to_cpu(blk_state->log_start_page),
+				  blk_state->log_area,
+				  le32_to_cpu(blk_state->byte_offset),
+				  blk_state->peb_migration_id);
+		}
+
+		goto finish_read_page;
+	}
+
+finish_read_page:
+	up_read(&pebc->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_readahead_pages() - read-ahead pages from PEB
+ * @pebc: pointer on PEB container
+ * @req: request [in|out]
+ * @end: pointer on waiting queue [out]
+ *
+ * This function tries to read-ahead PEB's pages.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_readahead_pages(struct ssdfs_peb_container *pebc,
+			      struct ssdfs_segment_request *req,
+			      struct completion **end)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 pages_count;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x, "
+		  "ino %llu, logical_offset %llu, data_bytes %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd, req->private.type,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+
+	if (req->extent.data_bytes == 0) {
+		SSDFS_WARN("empty read request: ino %llu, logical_offset %llu\n",
+			   req->extent.ino, req->extent.logical_offset);
+		return 0;
+	}
+
+	pages_count = req->extent.data_bytes + fsi->pagesize - 1;
+	pages_count >>= fsi->log_pagesize;
+
+	for (i = req->result.processed_blks; i < pages_count; i++) {
+		int err = ssdfs_peb_read_page(pebc, req, end);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to process page %d\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to process page %d, err %d\n",
+				  i, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * __ssdfs_peb_read_log_footer() - read log's footer
  * @fsi: file system info object
-- 
2.34.1

