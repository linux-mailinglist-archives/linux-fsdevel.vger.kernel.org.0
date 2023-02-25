Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C206A2624
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBYBQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBYBPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:15:53 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18B1125AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:46 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bm20so798235oib.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnSYdXj+DgGw+DePm+dEPQh+XPhA+sEd1HQBMfLlT00=;
        b=AcIwASjZC9CP4s/TKr+w4Z1LtEWsoPD2//AYOsXAsmdB2s+bel9odUxtOw4+y68/Kr
         Un6WtJb4tRwDVk30GsjSO4aUMiPEG+DH0Lsg6IE8XgA+SYWMvdRuLYkgtZeg13ir9Dzx
         Xjf3TJZdctp0VU74Ad6MoPMRP0MpJ828kOVSvLveUykK2A0mzfzV2qBRci2n9TH2jZ9E
         fqdwvi/wbW/RFSC5nTwmwiA4zhFIAiEb3JylGAZ6DC30/nZbgsgBI2eMbm0vFzYEO9bz
         FgqAfkVXRgwyOwHrQFmrGH9YlA4/sQWWAfBlw2fxlQ+XsbPr1h4P34Skm8axcKXz22+M
         HMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnSYdXj+DgGw+DePm+dEPQh+XPhA+sEd1HQBMfLlT00=;
        b=5iAR7vVyLIRT0oU3cO+WjfC9WKflYjvUEO+b5yQjhT+oPyFG3BhdGrT8MmATyRo+2u
         vg2ho84dmePKShCJgY9UTbs+7cb3+hWabrHiwlXscufpI72wstf3j3K8BXO9ZRETJLov
         su4t5NHPPI6McGu3/7+QVWdo4u4MMvBuo7tn9XL5p3o1eXUrg8m8NNcUjr98VnwTN0Gc
         ZSK3CxCV5LztbPrAJmyYHhFsgKAp3IGFontLlimGuHSV+3BgpHfDnoL/4ZdjGr5m9g+K
         WTMG5MvDx6jHrL79g7ygw3cR5V0u4T2ZB11YFYCOd4L05mwhP1aKZUxM5eU4q/HNNAcv
         SG8w==
X-Gm-Message-State: AO0yUKW5vzrqoYYleV1LAjImia6maSsO03cdBkqC75ixkAUltMZOCz4B
        FwFGbjsYwllpltCzYJ+++BDGhipypaPK3Vzl
X-Google-Smtp-Source: AK7set99w8qWDX/2lenyGf0caAcICfCdrtApuonzd69HHWApF1EO5Tmi8/M2wRhDpPPbU/NgzRKtww==
X-Received: by 2002:a05:6808:6082:b0:383:e7c8:4000 with SMTP id de2-20020a056808608200b00383e7c84000mr3248774oib.13.1677287744610;
        Fri, 24 Feb 2023 17:15:44 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:43 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 05/76] ssdfs: implement commit superblock operation
Date:   Fri, 24 Feb 2023 17:08:16 -0800
Message-Id: <20230225010927.813929-6-slava@dubeyko.com>
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

SSDFS has specialized superblock segment (erase block) that
has goal to keep the sequence of committed superblocks.
Superblock instance is stored on successful mount operation
and during unmount operation. At first, logic tries to detect
the state of current superblock segment. If segment (erase block)
is completely full, then a new superblock segment is reserved.
As a result, new superblock instance is stored into the sequence.
Actually, SSDFS has main and backup copy of current superblock
segments. Additionally, SSDFS keeps information about previous,
current, next, and reserved superblock segments. SSDFS can use
two policy of segment superblock allocation: (1) reserve a new
segment for every new allocation, (2) use only set of superblock
segments that have been reserved by mkfs tool.

Every commit operation stores log into superblock segment.
This log contains:
(1) segment header,
(2) payload (mapping table cache, for example),
(3) log footer.

Segment header can be considered like static superblock info.
It contains metadata that not changed at all after volume
creation (logical block size, for example) or changed rarely
(number of segments in the volume, for example). Log footer
can be considered like dynamic part of superblock because
it contains frequently updated metadata (for example, root
node of inodes b-tree).

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/super.c | 2200 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2200 insertions(+)

diff --git a/fs/ssdfs/super.c b/fs/ssdfs/super.c
index a3b144e6eafb..39df1e4d9152 100644
--- a/fs/ssdfs/super.c
+++ b/fs/ssdfs/super.c
@@ -121,6 +121,27 @@ void ssdfs_super_check_memory_leaks(void)
 #endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
 }
 
+struct ssdfs_payload_content {
+	struct pagevec pvec;
+	u32 bytes_count;
+};
+
+struct ssdfs_sb_log_payload {
+	struct ssdfs_payload_content maptbl_cache;
+};
+
+static struct kmem_cache *ssdfs_inode_cachep;
+
+static int ssdfs_prepare_sb_log(struct super_block *sb,
+				struct ssdfs_peb_extent *last_sb_log);
+static int ssdfs_snapshot_sb_log_payload(struct super_block *sb,
+					 struct ssdfs_sb_log_payload *payload);
+static int ssdfs_commit_super(struct super_block *sb, u16 fs_state,
+				struct ssdfs_peb_extent *last_sb_log,
+				struct ssdfs_sb_log_payload *payload);
+static void ssdfs_put_super(struct super_block *sb);
+static void ssdfs_check_memory_leaks(void);
+
 static void init_once(void *foo)
 {
 	struct ssdfs_inode_info *ii = (struct ssdfs_inode_info *)foo;
@@ -528,6 +549,2185 @@ static const struct super_operations ssdfs_super_operations = {
 	.sync_fs	= ssdfs_sync_fs,
 };
 
+static inline
+u32 ssdfs_sb_payload_size(struct pagevec *pvec)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct page *page;
+	void *kaddr;
+	u16 fragment_bytes_count;
+	u32 bytes_count = 0;
+	int i;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		fragment_bytes_count = le16_to_cpu(hdr->bytes_count);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		WARN_ON(fragment_bytes_count > PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		bytes_count += fragment_bytes_count;
+	}
+
+	return bytes_count;
+}
+
+static u32 ssdfs_define_sb_log_size(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi;
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	u32 inline_capacity;
+	u32 log_size = 0;
+	u32 payload_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb);
+
+	SSDFS_DBG("sb %p\n", sb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(sb);
+	payload_size = ssdfs_sb_payload_size(&fsi->maptbl_cache.pvec);
+	inline_capacity = PAGE_SIZE - hdr_size;
+
+	if (payload_size > inline_capacity) {
+		log_size += PAGE_SIZE;
+		log_size += atomic_read(&fsi->maptbl_cache.bytes_count);
+		log_size += PAGE_SIZE;
+	} else {
+		log_size += PAGE_SIZE;
+		log_size += PAGE_SIZE;
+	}
+
+	log_size = (log_size + fsi->pagesize - 1) >> fsi->log_pagesize;
+
+	return log_size;
+}
+
+static int ssdfs_snapshot_sb_log_payload(struct super_block *sb,
+					 struct ssdfs_sb_log_payload *payload)
+{
+	struct ssdfs_fs_info *fsi;
+	unsigned pages_count;
+	unsigned i;
+	struct page *spage, *dpage;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !payload);
+	BUG_ON(pagevec_count(&payload->maptbl_cache.pvec) != 0);
+
+	SSDFS_DBG("sb %p, payload %p\n",
+		  sb, payload);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(sb);
+
+	down_read(&fsi->maptbl_cache.lock);
+
+	pages_count = pagevec_count(&fsi->maptbl_cache.pvec);
+
+	for (i = 0; i < pages_count; i++) {
+		dpage =
+		    ssdfs_super_add_pagevec_page(&payload->maptbl_cache.pvec);
+		if (unlikely(IS_ERR_OR_NULL(dpage))) {
+			err = !dpage ? -ENOMEM : PTR_ERR(dpage);
+			SSDFS_ERR("fail to add pagevec page: "
+				  "index %u, err %d\n",
+				  i, err);
+			goto finish_maptbl_snapshot;
+		}
+
+		spage = fsi->maptbl_cache.pvec.pages[i];
+		if (unlikely(!spage)) {
+			err = -ERANGE;
+			SSDFS_ERR("source page is absent: index %u\n",
+				  i);
+			goto finish_maptbl_snapshot;
+		}
+
+		ssdfs_lock_page(spage);
+		ssdfs_lock_page(dpage);
+		ssdfs_memcpy_page(dpage, 0, PAGE_SIZE,
+				  spage, 0, PAGE_SIZE,
+				  PAGE_SIZE);
+		ssdfs_unlock_page(dpage);
+		ssdfs_unlock_page(spage);
+	}
+
+	payload->maptbl_cache.bytes_count =
+		atomic_read(&fsi->maptbl_cache.bytes_count);
+
+finish_maptbl_snapshot:
+	up_read(&fsi->maptbl_cache.lock);
+
+	if (unlikely(err))
+		ssdfs_super_pagevec_release(&payload->maptbl_cache.pvec);
+
+	return err;
+}
+
+static int ssdfs_define_next_sb_log_place(struct super_block *sb,
+					  struct ssdfs_peb_extent *last_sb_log)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 offset;
+	u32 log_size;
+	u64 cur_peb, prev_peb;
+	u64 cur_leb;
+	int i;
+	int err = 0;
+
+	fsi = SSDFS_FS_I(sb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !last_sb_log);
+
+	SSDFS_DBG("sb %p, last_sb_log %p\n",
+		  sb, last_sb_log);
+	SSDFS_DBG("fsi->sbi.last_log.leb_id %llu, "
+		  "fsi->sbi.last_log.peb_id %llu, "
+		  "fsi->sbi.last_log.page_offset %u, "
+		  "fsi->sbi.last_log.pages_count %u\n",
+		  fsi->sbi.last_log.leb_id,
+		  fsi->sbi.last_log.peb_id,
+		  fsi->sbi.last_log.page_offset,
+		  fsi->sbi.last_log.pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	offset = fsi->sbi.last_log.page_offset;
+
+	log_size = ssdfs_define_sb_log_size(sb);
+	if (log_size > fsi->pages_per_peb) {
+		SSDFS_ERR("log_size %u > fsi->pages_per_peb %u\n",
+			  log_size, fsi->pages_per_peb);
+		return -ERANGE;
+	}
+
+	log_size = max_t(u32, log_size, fsi->sbi.last_log.pages_count);
+
+	if (offset > fsi->pages_per_peb || offset > (UINT_MAX - log_size)) {
+		SSDFS_ERR("inconsistent metadata state: "
+			  "last_sb_log.page_offset %u, "
+			  "pages_per_peb %u, log_size %u\n",
+			  offset, fsi->pages_per_peb, log_size);
+		return -EINVAL;
+	}
+
+	for (err = -EINVAL, i = 0; i < SSDFS_SB_SEG_COPY_MAX; i++) {
+		cur_peb = fsi->sb_pebs[SSDFS_CUR_SB_SEG][i];
+		prev_peb = fsi->sb_pebs[SSDFS_PREV_SB_SEG][i];
+		cur_leb = fsi->sb_lebs[SSDFS_CUR_SB_SEG][i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_peb %llu, prev_peb %llu, "
+			  "last_sb_log.peb_id %llu, err %d\n",
+			  cur_peb, prev_peb, fsi->sbi.last_log.peb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (fsi->sbi.last_log.peb_id == cur_peb) {
+			if ((offset + (2 * log_size)) > fsi->pages_per_peb) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("sb PEB %llu is full: "
+					  "(offset %u + (2 * log_size %u)) > "
+					  "pages_per_peb %u\n",
+					  cur_peb, offset, log_size,
+					  fsi->pages_per_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return -EFBIG;
+			}
+
+			last_sb_log->leb_id = cur_leb;
+			last_sb_log->peb_id = cur_peb;
+			last_sb_log->page_offset = offset + log_size;
+			last_sb_log->pages_count = log_size;
+
+			err = 0;
+			break;
+		} else if (fsi->sbi.last_log.peb_id != cur_peb &&
+			   fsi->sbi.last_log.peb_id == prev_peb) {
+
+			last_sb_log->leb_id = cur_leb;
+			last_sb_log->peb_id = cur_peb;
+			last_sb_log->page_offset = 0;
+			last_sb_log->pages_count = log_size;
+
+			err = 0;
+			break;
+		} else {
+			/* continue to check */
+			err = -ERANGE;
+		}
+	}
+
+	if (err) {
+		SSDFS_ERR("inconsistent metadata state: "
+			  "cur_peb %llu, prev_peb %llu, "
+			  "last_sb_log.peb_id %llu\n",
+			  cur_peb, prev_peb, fsi->sbi.last_log.peb_id);
+		return err;
+	}
+
+	for (i = 0; i < SSDFS_SB_SEG_COPY_MAX; i++) {
+		last_sb_log->leb_id = fsi->sb_lebs[SSDFS_CUR_SB_SEG][i];
+		last_sb_log->peb_id = fsi->sb_pebs[SSDFS_CUR_SB_SEG][i];
+		err = ssdfs_can_write_sb_log(sb, last_sb_log);
+		if (err) {
+			SSDFS_ERR("fail to write sb log into PEB %llu\n",
+				  last_sb_log->peb_id);
+			return err;
+		}
+	}
+
+	last_sb_log->leb_id = cur_leb;
+	last_sb_log->peb_id = cur_peb;
+
+	return 0;
+}
+
+static bool ssdfs_sb_seg_exhausted(struct ssdfs_fs_info *fsi,
+				   u64 cur_leb, u64 next_leb)
+{
+	u64 cur_seg, next_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(cur_leb == U64_MAX || next_leb == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_seg = SSDFS_LEB2SEG(fsi, cur_leb);
+	next_seg = SSDFS_LEB2SEG(fsi, next_leb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_seg %llu, cur_leb %llu, "
+		  "next_seg %llu, next_leb %llu\n",
+		  cur_seg, cur_leb, next_seg, next_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (cur_seg >= U64_MAX || next_seg >= U64_MAX)
+		return true;
+
+	return cur_seg != next_seg;
+}
+
+#ifndef CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET
+static u64 ssdfs_correct_start_leb_id(struct ssdfs_fs_info *fsi,
+				      int seg_type, u64 leb_id)
+{
+	struct completion *init_end;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+	u8 peb_type = SSDFS_MAPTBL_UNKNOWN_PEB_TYPE;
+	u32 pebs_per_seg;
+	u64 seg_id;
+	u64 cur_leb;
+	u64 peb_id1, peb_id2;
+	u64 found_peb_id;
+	u64 peb_id_off;
+	u16 pebs_per_fragment;
+	u16 pebs_per_stripe;
+	u16 stripes_per_fragment;
+	u64 calculated_leb_id = leb_id;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p, seg_type %#x, leb_id %llu\n",
+		  fsi, seg_type, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	found_peb_id = leb_id;
+	peb_type = SEG2PEB_TYPE(seg_type);
+	pebs_per_seg = fsi->pebs_per_seg;
+
+	seg_id = ssdfs_get_seg_id_for_leb_id(fsi, leb_id);
+	if (unlikely(seg_id >= U64_MAX)) {
+		SSDFS_ERR("invalid seg_id: "
+			  "leb_id %llu\n", leb_id);
+		return -ERANGE;
+	}
+
+	err = ssdfs_maptbl_define_fragment_info(fsi, leb_id,
+						&pebs_per_fragment,
+						&pebs_per_stripe,
+						&stripes_per_fragment);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define fragment info: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	for (i = 0; i < pebs_per_seg; i++) {
+		cur_leb = ssdfs_get_leb_id_for_peb_index(fsi, seg_id, i);
+		if (cur_leb >= U64_MAX) {
+			SSDFS_ERR("fail to convert PEB index into LEB ID: "
+				  "seg %llu, peb_index %u\n",
+				  seg_id, i);
+			return -ERANGE;
+		}
+
+		err = ssdfs_maptbl_convert_leb2peb(fsi, cur_leb,
+						   peb_type, &pebr,
+						   &init_end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				goto finish_leb_id_correction;
+			}
+
+			err = ssdfs_maptbl_convert_leb2peb(fsi, cur_leb,
+							   peb_type, &pebr,
+							   &init_end);
+		}
+
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("LEB is not mapped: leb_id %llu\n",
+				  cur_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_leb_id_correction;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  cur_leb, peb_type, err);
+			goto finish_leb_id_correction;
+		}
+
+		ptr = &pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX];
+		peb_id1 = ptr->peb_id;
+		ptr = &pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX];
+		peb_id2 = ptr->peb_id;
+
+		if (peb_id1 < U64_MAX)
+			found_peb_id = max_t(u64, peb_id1, found_peb_id);
+
+		if (peb_id2 < U64_MAX)
+			found_peb_id = max_t(u64, peb_id2, found_peb_id);
+
+		peb_id_off = found_peb_id % pebs_per_stripe;
+		if (peb_id_off >= (pebs_per_stripe / 2)) {
+			calculated_leb_id = found_peb_id / pebs_per_stripe;
+			calculated_leb_id++;
+			calculated_leb_id *= pebs_per_stripe;
+		} else {
+			calculated_leb_id = found_peb_id;
+			calculated_leb_id++;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found_peb_id %llu, pebs_per_stripe %u, "
+			  "calculated_leb_id %llu\n",
+			  found_peb_id, pebs_per_stripe,
+			  calculated_leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+finish_leb_id_correction:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("leb_id %llu, calculated_leb_id %llu\n",
+		  leb_id, calculated_leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return calculated_leb_id;
+}
+#endif /* CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET */
+
+#ifndef CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET
+static int __ssdfs_reserve_clean_segment(struct ssdfs_fs_info *fsi,
+					 int sb_seg_type,
+					 u64 start_search_id,
+					 u64 *reserved_seg)
+{
+	struct ssdfs_segment_bmap *segbmap = fsi->segbmap;
+	u64 start_seg = start_search_id;
+	u64 end_seg = U64_MAX;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct completion *end;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!reserved_seg);
+	BUG_ON(sb_seg_type >= SSDFS_SB_SEG_COPY_MAX);
+
+	SSDFS_DBG("fsi %p, sb_seg_type %#x, start_search_id %llu\n",
+		  fsi, sb_seg_type, start_search_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (sb_seg_type) {
+	case SSDFS_MAIN_SB_SEG:
+	case SSDFS_COPY_SB_SEG:
+		err = ssdfs_segment_detect_search_range(fsi,
+							&start_seg,
+							&end_seg);
+		if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find fragment for search: "
+				  "start_seg %llu, end_seg %llu\n",
+				  start_seg, end_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to define a search range: "
+				  "start_seg %llu, err %d\n",
+				  start_seg, err);
+			return err;
+		}
+		break;
+
+	default:
+		BUG();
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_seg %llu, end_seg %llu\n",
+		  start_seg, end_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_segbmap_reserve_clean_segment(segbmap,
+						  start_seg, end_seg,
+						  reserved_seg, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("segbmap init failed: "
+				  "err %d\n", err);
+			goto finish_search;
+		}
+
+		err = ssdfs_segbmap_reserve_clean_segment(segbmap,
+							  start_seg, end_seg,
+							  reserved_seg,
+							  &end);
+	}
+
+	if (err == -ENODATA) {
+		err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to reserve segment: "
+			  "type %#x, start_seg %llu, end_seg %llu\n",
+			  sb_seg_type, start_seg, end_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve segment: "
+			  "type %#x, start_seg %llu, "
+			   "end_seg %llu, err %d\n",
+			  sb_seg_type, start_seg, end_seg, err);
+		goto finish_search;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_seg %llu\n", *reserved_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < fsi->pebs_per_seg; i++) {
+		u8 peb_type = SSDFS_MAPTBL_SBSEG_PEB_TYPE;
+		u64 leb_id;
+
+		leb_id = ssdfs_get_leb_id_for_peb_index(fsi, *reserved_seg, i);
+		if (leb_id >= U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to convert PEB index into LEB ID: "
+				  "seg %llu, peb_index %u\n",
+				  *reserved_seg, i);
+			goto finish_search;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("leb_id %llu\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_maptbl_map_leb2peb(fsi, leb_id, peb_type,
+						&pebr, &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				goto finish_search;
+			}
+
+			err = ssdfs_maptbl_map_leb2peb(fsi, leb_id,
+							peb_type,
+							&pebr, &end);
+		}
+
+		if (err == -EACCES || err == -ENOENT) {
+			if (i == 0) {
+				SSDFS_ERR("fail to map LEB to PEB: "
+					  "reserved_seg %llu, leb_id %llu, "
+					  "err %d\n",
+					  *reserved_seg, leb_id, err);
+				goto finish_search;
+			} else
+				goto finish_search;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to map LEB to PEB: "
+				  "reserved_seg %llu, leb_id %llu, "
+				  "err %d\n",
+				  *reserved_seg, leb_id, err);
+			goto finish_search;
+		}
+	}
+
+finish_search:
+	if (err == -ENOENT)
+		*reserved_seg = end_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_seg %llu\n", *reserved_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+#endif /* CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET */
+
+#ifndef CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET
+static int ssdfs_reserve_clean_segment(struct super_block *sb,
+					int sb_seg_type, u64 start_leb,
+					u64 *reserved_seg)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u64 start_search_id;
+	u64 cur_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!reserved_seg);
+	BUG_ON(sb_seg_type >= SSDFS_SB_SEG_COPY_MAX);
+
+	SSDFS_DBG("sb %p, sb_seg_type %#x, start_leb %llu\n",
+		  sb, sb_seg_type, start_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*reserved_seg = U64_MAX;
+
+	start_leb = ssdfs_correct_start_leb_id(fsi,
+						SSDFS_SB_SEG_TYPE,
+						start_leb);
+
+	start_search_id = SSDFS_LEB2SEG(fsi, start_leb);
+	if (start_search_id >= fsi->nsegs)
+		start_search_id = 0;
+
+	cur_id = start_search_id;
+
+	while (cur_id < fsi->nsegs) {
+		err = __ssdfs_reserve_clean_segment(fsi, sb_seg_type,
+						    cur_id, reserved_seg);
+		if (err == -ENOENT) {
+			err = 0;
+			cur_id = *reserved_seg;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_id %llu\n", cur_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find a new segment: "
+				  "cur_id %llu, err %d\n",
+				  cur_id, err);
+			return err;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found seg_id %llu\n", *reserved_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+	cur_id = 0;
+
+	while (cur_id < start_search_id) {
+		err = __ssdfs_reserve_clean_segment(fsi, sb_seg_type,
+						    cur_id, reserved_seg);
+		if (err == -ENOENT) {
+			err = 0;
+			cur_id = *reserved_seg;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_id %llu\n", cur_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find a new segment: "
+				  "cur_id %llu, err %d\n",
+				  cur_id, err);
+			return err;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found seg_id %llu\n", *reserved_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("no free space for a new segment\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENOSPC;
+}
+#endif /* CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET */
+
+typedef u64 sb_pebs_array[SSDFS_SB_CHAIN_MAX][SSDFS_SB_SEG_COPY_MAX];
+
+static int ssdfs_erase_dirty_prev_sb_segs(struct ssdfs_fs_info *fsi,
+					  u64 prev_leb)
+{
+	struct completion *init_end;
+	u8 peb_type = SSDFS_MAPTBL_UNKNOWN_PEB_TYPE;
+	u32 pebs_per_seg;
+	u64 seg_id;
+	u64 cur_leb;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p, prev_leb %llu\n",
+		  fsi, prev_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_type = SEG2PEB_TYPE(SSDFS_SB_SEG_TYPE);
+	pebs_per_seg = fsi->pebs_per_seg;
+
+	seg_id = SSDFS_LEB2SEG(fsi, prev_leb);
+	if (seg_id >= U64_MAX) {
+		SSDFS_ERR("invalid seg_id for leb_id %llu\n",
+			  prev_leb);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < pebs_per_seg; i++) {
+		cur_leb = ssdfs_get_leb_id_for_peb_index(fsi, seg_id, i);
+		if (cur_leb >= U64_MAX) {
+			SSDFS_ERR("invalid leb_id for seg_id %llu\n",
+				  seg_id);
+			return -ERANGE;
+		}
+
+		err = ssdfs_maptbl_erase_reserved_peb_now(fsi,
+							  cur_leb,
+							  peb_type,
+							  &init_end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_maptbl_erase_reserved_peb_now(fsi,
+								  cur_leb,
+								  peb_type,
+								  &init_end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to erase reserved dirty PEB: "
+				  "leb_id %llu, err %d\n",
+				  cur_leb, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int ssdfs_move_on_next_peb_in_sb_seg(struct super_block *sb,
+					    int sb_seg_type,
+					    sb_pebs_array *sb_lebs,
+					    sb_pebs_array *sb_pebs)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u64 prev_leb, cur_leb, next_leb, reserved_leb;
+	u64 prev_peb, cur_peb, next_peb, reserved_peb;
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 new_leb = U64_MAX, new_peb = U64_MAX;
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct ssdfs_maptbl_peb_relation pebr;
+	u8 peb_type = SSDFS_MAPTBL_SBSEG_PEB_TYPE;
+	struct completion *end = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !sb_lebs || !sb_pebs);
+
+	if (sb_seg_type >= SSDFS_SB_SEG_COPY_MAX) {
+		SSDFS_ERR("invalid sb_seg_type %#x\n",
+			  sb_seg_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("sb %p, sb_seg_type %#x\n", sb, sb_seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	prev_leb = (*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type];
+	cur_leb = (*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	next_leb = cur_leb + 1;
+	reserved_leb = (*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type];
+
+	prev_peb = (*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type];
+	cur_peb = (*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	next_peb = U64_MAX;
+	reserved_peb = (*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type];
+
+	err = ssdfs_maptbl_convert_leb2peb(fsi, next_leb,
+					   peb_type,
+					   &pebr, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			goto finish_move_sb_seg;
+		}
+
+		err = ssdfs_maptbl_convert_leb2peb(fsi, next_leb,
+						   peb_type,
+						   &pebr, &end);
+	}
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("LEB %llu doesn't mapped\n", next_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_move_sb_seg;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to convert LEB %llu to PEB: err %d\n",
+			  next_leb, err);
+		goto finish_move_sb_seg;
+	}
+
+	next_peb = pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(next_peb == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	(*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_leb;
+	(*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_peb;
+
+	(*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type] = next_leb;
+	(*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type] = next_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_leb %llu, cur_peb %llu, "
+		  "next_leb %llu, next_peb %llu, "
+		  "prev_leb %llu, prev_peb %llu, "
+		  "reserved_leb %llu, reserved_peb %llu, "
+		  "new_leb %llu, new_peb %llu\n",
+		  cur_leb, cur_peb,
+		  next_leb, next_peb,
+		  prev_leb, prev_peb,
+		  reserved_leb, reserved_peb,
+		  new_leb, new_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (prev_leb == U64_MAX)
+		goto finish_move_sb_seg;
+	else {
+		err = ssdfs_erase_dirty_prev_sb_segs(fsi, prev_leb);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail erase dirty PEBs: "
+				  "prev_leb %llu, err %d\n",
+				  prev_leb, err);
+			goto finish_move_sb_seg;
+		}
+	}
+
+finish_move_sb_seg:
+	return err;
+}
+
+#ifdef CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET
+static int ssdfs_move_on_first_peb_next_sb_seg(struct super_block *sb,
+						int sb_seg_type,
+						sb_pebs_array *sb_lebs,
+						sb_pebs_array *sb_pebs)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u64 prev_leb, cur_leb, next_leb, reserved_leb;
+	u64 prev_peb, cur_peb, next_peb, reserved_peb;
+	u64 seg_id;
+	struct ssdfs_maptbl_peb_relation pebr;
+	u8 peb_type = SSDFS_MAPTBL_SBSEG_PEB_TYPE;
+	struct completion *end = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !sb_lebs || !sb_pebs);
+
+	if (sb_seg_type >= SSDFS_SB_SEG_COPY_MAX) {
+		SSDFS_ERR("invalid sb_seg_type %#x\n",
+			  sb_seg_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("sb %p, sb_seg_type %#x\n", sb, sb_seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	prev_leb = (*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type];
+	cur_leb = (*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	next_leb = (*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type];
+	reserved_leb = (*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type];
+
+	prev_peb = (*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type];
+	cur_peb = (*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	next_peb = (*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type];
+	reserved_peb = (*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_peb %llu, next_peb %llu, "
+		  "cur_leb %llu, next_leb %llu\n",
+		  cur_peb, next_peb, cur_leb, next_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	(*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type] = next_leb;
+	(*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type] = next_peb;
+
+	if (prev_leb >= U64_MAX) {
+		(*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_leb;
+		(*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_peb;
+
+		if (fsi->pebs_per_seg == 1) {
+			(*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] =
+								reserved_leb;
+			(*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] =
+								reserved_peb;
+
+			(*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] =
+									U64_MAX;
+			(*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] =
+									U64_MAX;
+		} else {
+			/*
+			 * do nothing
+			 */
+		}
+	} else {
+		err = ssdfs_erase_dirty_prev_sb_segs(fsi, prev_leb);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail erase dirty PEBs: "
+				  "prev_leb %llu, err %d\n",
+				  prev_leb, err);
+			goto finish_move_sb_seg;
+		}
+
+		if (fsi->pebs_per_seg == 1) {
+			(*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] =
+								prev_leb;
+			(*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] =
+								prev_peb;
+
+			(*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] =
+									U64_MAX;
+			(*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] =
+									U64_MAX;
+
+			(*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_leb;
+			(*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_peb;
+		} else {
+			(*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] =
+								reserved_leb;
+			(*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] =
+								reserved_peb;
+
+			seg_id = SSDFS_LEB2SEG(fsi, prev_leb);
+			if (seg_id >= U64_MAX) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid seg_id for leb_id %llu\n",
+					  prev_leb);
+				goto finish_move_sb_seg;
+			}
+
+			prev_leb = ssdfs_get_leb_id_for_peb_index(fsi, seg_id, 0);
+			if (prev_leb >= U64_MAX) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid leb_id for seg_id %llu\n",
+					  seg_id);
+				goto finish_move_sb_seg;
+			}
+
+			err = ssdfs_maptbl_convert_leb2peb(fsi, prev_leb,
+							   peb_type,
+							   &pebr, &end);
+			if (err == -EAGAIN) {
+				err = SSDFS_WAIT_COMPLETION(end);
+				if (unlikely(err)) {
+					SSDFS_ERR("maptbl init failed: "
+						  "err %d\n", err);
+					goto finish_move_sb_seg;
+				}
+
+				err = ssdfs_maptbl_convert_leb2peb(fsi,
+								   prev_leb,
+								   peb_type,
+								   &pebr, &end);
+			}
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to convert LEB %llu to PEB: "
+					  "err %d\n", prev_leb, err);
+				goto finish_move_sb_seg;
+			}
+
+			prev_peb = pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(prev_peb == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			(*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] =
+									prev_leb;
+			(*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] =
+									prev_peb;
+
+			(*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_leb;
+			(*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_peb;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_leb %llu, cur_peb %llu, "
+		  "next_leb %llu, next_peb %llu, "
+		  "reserved_leb %llu, reserved_peb %llu, "
+		  "prev_leb %llu, prev_peb %llu\n",
+		  (*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type],
+		  (*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type],
+		  (*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type],
+		  (*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type],
+		  (*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type],
+		  (*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type],
+		  (*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type],
+		  (*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_move_sb_seg:
+	return err;
+}
+#else
+static int ssdfs_move_on_first_peb_next_sb_seg(struct super_block *sb,
+						int sb_seg_type,
+						sb_pebs_array *sb_lebs,
+						sb_pebs_array *sb_pebs)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct ssdfs_segment_bmap *segbmap = fsi->segbmap;
+	struct ssdfs_maptbl_cache *maptbl_cache = &fsi->maptbl_cache;
+	u64 prev_leb, cur_leb, next_leb, reserved_leb;
+	u64 prev_peb, cur_peb, next_peb, reserved_peb;
+	u64 new_leb = U64_MAX, new_peb = U64_MAX;
+	u64 reserved_seg;
+	u64 prev_seg, cur_seg;
+	struct ssdfs_maptbl_peb_relation pebr;
+	u8 peb_type = SSDFS_MAPTBL_SBSEG_PEB_TYPE;
+	struct completion *end = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !sb_lebs || !sb_pebs);
+
+	if (sb_seg_type >= SSDFS_SB_SEG_COPY_MAX) {
+		SSDFS_ERR("invalid sb_seg_type %#x\n",
+			  sb_seg_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("sb %p, sb_seg_type %#x\n", sb, sb_seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	prev_leb = (*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type];
+	cur_leb = (*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	next_leb = (*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type];
+	reserved_leb = (*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type];
+
+	prev_peb = (*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type];
+	cur_peb = (*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	next_peb = (*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type];
+	reserved_peb = (*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_peb %llu, next_peb %llu, "
+		  "cur_leb %llu, next_leb %llu\n",
+		  cur_peb, next_peb, cur_leb, next_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_reserve_clean_segment(sb, sb_seg_type, cur_leb,
+					  &reserved_seg);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve clean segment: err %d\n", err);
+		goto finish_move_sb_seg;
+	}
+
+	new_leb = ssdfs_get_leb_id_for_peb_index(fsi, reserved_seg, 0);
+	if (new_leb >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu\n", reserved_seg);
+		goto finish_move_sb_seg;
+	}
+
+	err = ssdfs_maptbl_convert_leb2peb(fsi, new_leb,
+					   peb_type,
+					   &pebr, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			goto finish_move_sb_seg;
+		}
+
+		err = ssdfs_maptbl_convert_leb2peb(fsi, new_leb,
+						   peb_type,
+						   &pebr, &end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to convert LEB %llu to PEB: err %d\n",
+			  new_leb, err);
+		goto finish_move_sb_seg;
+	}
+
+	new_peb = pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(new_peb == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	(*sb_lebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_leb;
+	(*sb_pebs)[SSDFS_PREV_SB_SEG][sb_seg_type] = cur_peb;
+
+	(*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type] = next_leb;
+	(*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type] = next_peb;
+
+	(*sb_lebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] = reserved_leb;
+	(*sb_pebs)[SSDFS_NEXT_SB_SEG][sb_seg_type] = reserved_peb;
+
+	(*sb_lebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] = new_leb;
+	(*sb_pebs)[SSDFS_RESERVED_SB_SEG][sb_seg_type] = new_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_leb %llu, cur_peb %llu, "
+		  "next_leb %llu, next_peb %llu, "
+		  "reserved_leb %llu, reserved_peb %llu, "
+		  "new_leb %llu, new_peb %llu\n",
+		  cur_leb, cur_peb,
+		  next_leb, next_peb,
+		  reserved_leb, reserved_peb,
+		  new_leb, new_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (prev_leb == U64_MAX)
+		goto finish_move_sb_seg;
+
+	prev_seg = SSDFS_LEB2SEG(fsi, prev_leb);
+	cur_seg = SSDFS_LEB2SEG(fsi, cur_leb);
+
+	if (prev_seg != cur_seg) {
+		err = ssdfs_segbmap_change_state(segbmap, prev_seg,
+						 SSDFS_SEG_DIRTY, &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("segbmap init failed: "
+					  "err %d\n", err);
+				goto finish_move_sb_seg;
+			}
+
+			err = ssdfs_segbmap_change_state(segbmap, prev_seg,
+							 SSDFS_SEG_DIRTY, &end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change segment state: "
+				  "seg %llu, state %#x, err %d\n",
+				  prev_seg, SSDFS_SEG_DIRTY, err);
+			goto finish_move_sb_seg;
+		}
+	}
+
+	err = ssdfs_maptbl_change_peb_state(fsi, prev_leb, peb_type,
+					    SSDFS_MAPTBL_DIRTY_PEB_STATE,
+					    &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			goto finish_move_sb_seg;
+		}
+
+		err = ssdfs_maptbl_change_peb_state(fsi,
+						prev_leb, peb_type,
+						SSDFS_MAPTBL_DIRTY_PEB_STATE,
+						&end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change the PEB state: "
+			  "leb_id %llu, new_state %#x, err %d\n",
+			  prev_leb, SSDFS_MAPTBL_DIRTY_PEB_STATE, err);
+		goto finish_move_sb_seg;
+	}
+
+	err = ssdfs_maptbl_cache_forget_leb2peb(maptbl_cache, prev_leb,
+						SSDFS_PEB_STATE_CONSISTENT);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to forget prev_leb %llu, err %d\n",
+			  prev_leb, err);
+		goto finish_move_sb_seg;
+	}
+
+finish_move_sb_seg:
+	return err;
+}
+#endif /* CONFIG_SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET */
+
+static int ssdfs_move_on_next_sb_seg(struct super_block *sb,
+				     int sb_seg_type,
+				     sb_pebs_array *sb_lebs,
+				     sb_pebs_array *sb_pebs)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u64 cur_leb, next_leb;
+	u64 cur_peb;
+	u8 peb_type = SSDFS_MAPTBL_SBSEG_PEB_TYPE;
+	struct completion *end = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !sb_lebs || !sb_pebs);
+
+	if (sb_seg_type >= SSDFS_SB_SEG_COPY_MAX) {
+		SSDFS_ERR("invalid sb_seg_type %#x\n",
+			  sb_seg_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("sb %p, sb_seg_type %#x\n", sb, sb_seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_leb = (*sb_lebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+	cur_peb = (*sb_pebs)[SSDFS_CUR_SB_SEG][sb_seg_type];
+
+	next_leb = cur_leb + 1;
+
+	err = ssdfs_maptbl_change_peb_state(fsi, cur_leb, peb_type,
+					    SSDFS_MAPTBL_USED_PEB_STATE,
+					    &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_change_peb_state(fsi,
+					cur_leb, peb_type,
+					SSDFS_MAPTBL_USED_PEB_STATE,
+					&end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change the PEB state: "
+			  "leb_id %llu, new_state %#x, err %d\n",
+			  cur_leb, SSDFS_MAPTBL_USED_PEB_STATE, err);
+		return err;
+	}
+
+	if (!ssdfs_sb_seg_exhausted(fsi, cur_leb, next_leb)) {
+		err = ssdfs_move_on_next_peb_in_sb_seg(sb, sb_seg_type,
+							sb_lebs, sb_pebs);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to move on next PEB of segment: "
+				  "cur_leb %llu, next_leb %llu\n",
+				  cur_leb, next_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto try_move_on_first_peb_next_sb_seg;
+		}
+	} else {
+try_move_on_first_peb_next_sb_seg:
+		err = ssdfs_move_on_first_peb_next_sb_seg(sb, sb_seg_type,
+							sb_lebs, sb_pebs);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move on next sb segment: "
+			  "sb_seg_type %#x, cur_leb %llu, "
+			  "cur_peb %llu, err %d\n",
+			  sb_seg_type, cur_leb,
+			  cur_peb, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int ssdfs_move_on_next_sb_segs_pair(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	sb_pebs_array sb_lebs;
+	sb_pebs_array sb_pebs;
+	size_t array_size;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p", sb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(fsi->fs_feature_compat & SSDFS_HAS_SEGBMAP_COMPAT_FLAG) ||
+	    !(fsi->fs_feature_compat & SSDFS_HAS_MAPTBL_COMPAT_FLAG)) {
+		SSDFS_ERR("volume hasn't segbmap or maptbl\n");
+		return -EIO;
+	}
+
+	array_size = sizeof(u64);
+	array_size *= SSDFS_SB_CHAIN_MAX;
+	array_size *= SSDFS_SB_SEG_COPY_MAX;
+
+	down_read(&fsi->sb_segs_sem);
+	ssdfs_memcpy(sb_lebs, 0, array_size,
+		     fsi->sb_lebs, 0, array_size,
+		     array_size);
+	ssdfs_memcpy(sb_pebs, 0, array_size,
+		     fsi->sb_pebs, 0, array_size,
+		     array_size);
+	up_read(&fsi->sb_segs_sem);
+
+	for (i = 0; i < SSDFS_SB_SEG_COPY_MAX; i++) {
+		err = ssdfs_move_on_next_sb_seg(sb, i, &sb_lebs, &sb_pebs);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move on next sb PEB: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	down_write(&fsi->sb_segs_sem);
+	ssdfs_memcpy(fsi->sb_lebs, 0, array_size,
+		     sb_lebs, 0, array_size,
+		     array_size);
+	ssdfs_memcpy(fsi->sb_pebs, 0, array_size,
+		     sb_pebs, 0, array_size,
+		     array_size);
+	up_write(&fsi->sb_segs_sem);
+
+	return 0;
+}
+
+static
+int ssdfs_prepare_sb_log(struct super_block *sb,
+			 struct ssdfs_peb_extent *last_sb_log)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !last_sb_log);
+
+	SSDFS_DBG("sb %p, last_sb_log %p\n",
+		  sb, last_sb_log);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_define_next_sb_log_place(sb, last_sb_log);
+	switch (err) {
+	case -EFBIG: /* current sb segment is exhausted */
+	case -EIO: /* current sb segment is corrupted */
+		err = ssdfs_move_on_next_sb_segs_pair(sb);
+		if (err) {
+			SSDFS_ERR("fail to move on next sb segs pair: err %d\n",
+				  err);
+			return err;
+		}
+		err = ssdfs_define_next_sb_log_place(sb, last_sb_log);
+		if (unlikely(err)) {
+			SSDFS_ERR("unable to define next sb log place: err %d\n",
+				  err);
+			return err;
+		}
+		break;
+
+	default:
+		if (err) {
+			SSDFS_ERR("unable to define next sb log place: err %d\n",
+				  err);
+			return err;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static void
+ssdfs_prepare_maptbl_cache_descriptor(struct ssdfs_metadata_descriptor *desc,
+				      u32 offset,
+				      struct ssdfs_payload_content *payload,
+				      u32 payload_size)
+{
+	unsigned i;
+	u32 csum = ~0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !payload);
+
+	SSDFS_DBG("desc %p, offset %u, payload %p\n",
+		  desc, offset, payload);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc->offset = cpu_to_le32(offset);
+	desc->size = cpu_to_le32(payload_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(payload_size >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc->check.bytes = cpu_to_le16((u16)payload_size);
+	desc->check.flags = cpu_to_le16(SSDFS_CRC32);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(pagevec_count(&payload->pvec) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < pagevec_count(&payload->pvec); i++) {
+		struct page *page = payload->pvec.pages[i];
+		struct ssdfs_maptbl_cache_header *hdr;
+		u16 bytes_count;
+		void *kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+
+		hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+		bytes_count = le16_to_cpu(hdr->bytes_count);
+
+		csum = crc32(csum, kaddr, bytes_count);
+
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+	}
+
+	desc->check.csum = cpu_to_le32(csum);
+}
+
+static
+int ssdfs_prepare_snapshot_rules_for_commit(struct ssdfs_fs_info *fsi,
+					struct ssdfs_metadata_descriptor *desc,
+					u32 offset)
+{
+	struct ssdfs_snapshot_rules_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_snapshot_rules_header);
+	size_t info_size = sizeof(struct ssdfs_snapshot_rule_info);
+	struct ssdfs_snapshot_rule_item *item = NULL;
+	u32 payload_off;
+	u32 item_off;
+	u32 pagesize = fsi->pagesize;
+	u16 items_count = 0;
+	u16 items_capacity = 0;
+	u32 area_size = 0;
+	struct list_head *this, *next;
+	u32 csum = ~0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !desc);
+
+	SSDFS_DBG("fsi %p, offset %u\n",
+		  fsi, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_ssdfs_snapshot_rules_list_empty(&fsi->snapshots.rules_list)) {
+		SSDFS_DBG("snapshot rules list is empty\n");
+		return -ENODATA;
+	}
+
+	payload_off = offsetof(struct ssdfs_log_footer, payload);
+	hdr = SSDFS_SNRU_HDR((u8 *)fsi->sbi.vs_buf + payload_off);
+	memset(hdr, 0, hdr_size);
+	area_size = pagesize - payload_off;
+	item_off = payload_off + hdr_size;
+
+	items_capacity = (u16)((area_size - hdr_size) / info_size);
+	area_size = min_t(u32, area_size, (u32)items_capacity * info_size);
+
+	spin_lock(&fsi->snapshots.rules_list.lock);
+	list_for_each_safe(this, next, &fsi->snapshots.rules_list.list) {
+		item = list_entry(this, struct ssdfs_snapshot_rule_item, list);
+
+		err = ssdfs_memcpy(fsi->sbi.vs_buf, item_off, pagesize,
+				   &item->rule, 0, info_size,
+				   info_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_copy_items;
+		}
+
+		item_off += info_size;
+		items_count++;
+	}
+finish_copy_items:
+	spin_unlock(&fsi->snapshots.rules_list.lock);
+
+	if (unlikely(err))
+		return err;
+
+	hdr->magic = cpu_to_le32(SSDFS_SNAPSHOT_RULES_MAGIC);
+	hdr->item_size = cpu_to_le16(info_size);
+	hdr->flags = cpu_to_le16(0);
+
+	if (items_count == 0 || items_count > items_capacity) {
+		SSDFS_ERR("invalid items number: "
+			  "items_count %u, items_capacity %u, "
+			  "area_size %u, item_size %zu\n",
+			  items_count, items_capacity,
+			  area_size, info_size);
+		return -ERANGE;
+	}
+
+	hdr->items_count = cpu_to_le16(items_count);
+	hdr->items_capacity = cpu_to_le16(items_capacity);
+	hdr->area_size = cpu_to_le16(area_size);
+
+	desc->offset = cpu_to_le32(offset);
+	desc->size = cpu_to_le32(area_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(area_size >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc->check.bytes = cpu_to_le16(area_size);
+	desc->check.flags = cpu_to_le16(SSDFS_CRC32);
+
+	csum = crc32(csum, hdr, area_size);
+	desc->check.csum = cpu_to_le32(csum);
+
+	return 0;
+}
+
+static int __ssdfs_commit_sb_log(struct super_block *sb,
+				 u64 timestamp, u64 cno,
+				 struct ssdfs_peb_extent *last_sb_log,
+				 struct ssdfs_sb_log_payload *payload)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor hdr_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor footer_desc[SSDFS_LOG_FOOTER_DESC_MAX];
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t hdr_array_bytes = desc_size * SSDFS_SEG_HDR_DESC_MAX;
+	size_t footer_array_bytes = desc_size * SSDFS_LOG_FOOTER_DESC_MAX;
+	struct ssdfs_metadata_descriptor *cur_hdr_desc;
+	struct page *page;
+	struct ssdfs_segment_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	struct ssdfs_log_footer *footer;
+	size_t footer_size = sizeof(struct ssdfs_log_footer);
+	void *kaddr = NULL;
+	loff_t peb_offset, offset;
+	u32 flags = 0;
+	u32 written = 0;
+	unsigned i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !last_sb_log);
+	BUG_ON(!SSDFS_FS_I(sb)->devops);
+	BUG_ON(!SSDFS_FS_I(sb)->devops->writepage);
+	BUG_ON((last_sb_log->page_offset + last_sb_log->pages_count) >
+		(ULLONG_MAX >> SSDFS_FS_I(sb)->log_pagesize));
+	BUG_ON((last_sb_log->leb_id * SSDFS_FS_I(sb)->pebs_per_seg) >=
+		SSDFS_FS_I(sb)->nsegs);
+	BUG_ON(last_sb_log->peb_id >
+		div_u64(ULLONG_MAX, SSDFS_FS_I(sb)->pages_per_peb));
+	BUG_ON((last_sb_log->peb_id * SSDFS_FS_I(sb)->pages_per_peb) >
+		(ULLONG_MAX >> SSDFS_FS_I(sb)->log_pagesize));
+
+	SSDFS_DBG("sb %p, last_sb_log->leb_id %llu, last_sb_log->peb_id %llu, "
+		  "last_sb_log->page_offset %u, last_sb_log->pages_count %u\n",
+		  sb, last_sb_log->leb_id, last_sb_log->peb_id,
+		  last_sb_log->page_offset, last_sb_log->pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(sb);
+	hdr = SSDFS_SEG_HDR(fsi->sbi.vh_buf);
+	footer = SSDFS_LF(fsi->sbi.vs_buf);
+
+	memset(hdr_desc, 0, hdr_array_bytes);
+	memset(footer_desc, 0, footer_array_bytes);
+
+	offset = (loff_t)last_sb_log->page_offset << fsi->log_pagesize;
+	offset += PAGE_SIZE;
+
+	cur_hdr_desc = &hdr_desc[SSDFS_MAPTBL_CACHE_INDEX];
+	ssdfs_prepare_maptbl_cache_descriptor(cur_hdr_desc, (u32)offset,
+					     &payload->maptbl_cache,
+					     payload->maptbl_cache.bytes_count);
+
+	offset += payload->maptbl_cache.bytes_count;
+
+	cur_hdr_desc = &hdr_desc[SSDFS_LOG_FOOTER_INDEX];
+	cur_hdr_desc->offset = cpu_to_le32(offset);
+	cur_hdr_desc->size = cpu_to_le32(footer_size);
+
+	ssdfs_memcpy(hdr->desc_array, 0, hdr_array_bytes,
+		     hdr_desc, 0, hdr_array_bytes,
+		     hdr_array_bytes);
+
+	hdr->peb_migration_id[SSDFS_PREV_MIGRATING_PEB] =
+					SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+	hdr->peb_migration_id[SSDFS_CUR_MIGRATING_PEB] =
+					SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+
+	err = ssdfs_prepare_segment_header_for_commit(fsi,
+						     last_sb_log->pages_count,
+						     SSDFS_SB_SEG_TYPE,
+						     SSDFS_LOG_HAS_FOOTER |
+						     SSDFS_LOG_HAS_MAPTBL_CACHE,
+						     timestamp, cno,
+						     hdr);
+	if (err) {
+		SSDFS_ERR("fail to prepare segment header: err %d\n", err);
+		return err;
+	}
+
+	offset += offsetof(struct ssdfs_log_footer, payload);
+	cur_hdr_desc = &footer_desc[SSDFS_SNAPSHOT_RULES_AREA_INDEX];
+
+	err = ssdfs_prepare_snapshot_rules_for_commit(fsi, cur_hdr_desc,
+						      (u32)offset);
+	if (err == -ENODATA) {
+		err = 0;
+		SSDFS_DBG("snapshot rules list is empty\n");
+	} else if (err) {
+		SSDFS_ERR("fail to prepare snapshot rules: err %d\n", err);
+		return err;
+	} else
+		flags |= SSDFS_LOG_FOOTER_HAS_SNAPSHOT_RULES;
+
+	ssdfs_memcpy(footer->desc_array, 0, footer_array_bytes,
+		     footer_desc, 0, footer_array_bytes,
+		     footer_array_bytes);
+
+	err = ssdfs_prepare_log_footer_for_commit(fsi, last_sb_log->pages_count,
+						  flags, timestamp,
+						  cno, footer);
+	if (err) {
+		SSDFS_ERR("fail to prepare log footer: err %d\n", err);
+		return err;
+	}
+
+	page = ssdfs_super_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return err;
+	}
+
+	/* ->writepage() calls put_page() */
+	ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/* write segment header */
+	ssdfs_lock_page(page);
+	ssdfs_memcpy_to_page(page, 0, PAGE_SIZE,
+			     fsi->sbi.vh_buf, 0, hdr_size,
+			     hdr_size);
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+	SetPageDirty(page);
+	ssdfs_unlock_page(page);
+
+	peb_offset = last_sb_log->peb_id * fsi->pages_per_peb;
+	peb_offset <<= fsi->log_pagesize;
+	offset = (loff_t)last_sb_log->page_offset << fsi->log_pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(peb_offset > (ULLONG_MAX - (offset + fsi->pagesize)));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	offset += peb_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("offset %llu\n", offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = fsi->devops->writepage(sb, offset, page, 0, hdr_size);
+	if (err) {
+		SSDFS_ERR("fail to write segment header: "
+			  "offset %llu, size %zu\n",
+			  (u64)offset, hdr_size);
+		goto cleanup_after_failure;
+	}
+
+	ssdfs_lock_page(page);
+	ClearPageUptodate(page);
+	ssdfs_clear_page_private(page, 0);
+	ssdfs_unlock_page(page);
+
+	offset += fsi->pagesize;
+
+	for (i = 0; i < pagevec_count(&payload->maptbl_cache.pvec); i++) {
+		struct page *payload_page = payload->maptbl_cache.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!payload_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		/* ->writepage() calls put_page() */
+		ssdfs_get_page(payload_page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  payload_page,
+			  page_ref_count(payload_page));
+
+		kaddr = kmap_local_page(payload_page);
+		SSDFS_DBG("PAYLOAD PAGE %d\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(payload_page);
+		ssdfs_set_page_private(payload_page, 0);
+		SetPageUptodate(payload_page);
+		SetPageDirty(payload_page);
+		ssdfs_unlock_page(payload_page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %llu\n", offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = fsi->devops->writepage(sb, offset, payload_page,
+					     0, PAGE_SIZE);
+		if (err) {
+			SSDFS_ERR("fail to write maptbl cache page: "
+				  "offset %llu, page_index %u, size %zu\n",
+				  (u64)offset, i, PAGE_SIZE);
+			goto cleanup_after_failure;
+		}
+
+		ssdfs_lock_page(payload_page);
+		ClearPageUptodate(payload_page);
+		ssdfs_clear_page_private(page, 0);
+		ssdfs_unlock_page(payload_page);
+
+		offset += PAGE_SIZE;
+	}
+
+	/* TODO: write metadata payload */
+
+	/* ->writepage() calls put_page() */
+	ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/* write log footer */
+	written = 0;
+
+	while (written < fsi->sbi.vs_buf_size) {
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		memset(kaddr, 0, PAGE_SIZE);
+		ssdfs_memcpy(kaddr, 0, PAGE_SIZE,
+			     fsi->sbi.vs_buf, written, fsi->sbi.vs_buf_size,
+			     PAGE_SIZE);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		SetPageDirty(page);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %llu\n", offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = fsi->devops->writepage(sb, offset, page, 0, PAGE_SIZE);
+		if (err) {
+			SSDFS_ERR("fail to write log footer: "
+				  "offset %llu, size %zu\n",
+				  (u64)offset, PAGE_SIZE);
+			goto cleanup_after_failure;
+		}
+
+		ssdfs_lock_page(page);
+		ClearPageUptodate(page);
+		ssdfs_clear_page_private(page, 0);
+		ssdfs_unlock_page(page);
+
+		written += PAGE_SIZE;
+		offset += PAGE_SIZE;
+	};
+
+	ssdfs_super_free_page(page);
+	return 0;
+
+cleanup_after_failure:
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_super_free_page(page);
+
+	return err;
+}
+
+static int
+__ssdfs_commit_sb_log_inline(struct super_block *sb,
+			     u64 timestamp, u64 cno,
+			     struct ssdfs_peb_extent *last_sb_log,
+			     struct ssdfs_sb_log_payload *payload,
+			     u32 payload_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_metadata_descriptor hdr_desc[SSDFS_SEG_HDR_DESC_MAX];
+	struct ssdfs_metadata_descriptor footer_desc[SSDFS_LOG_FOOTER_DESC_MAX];
+	size_t desc_size = sizeof(struct ssdfs_metadata_descriptor);
+	size_t hdr_array_bytes = desc_size * SSDFS_SEG_HDR_DESC_MAX;
+	size_t footer_array_bytes = desc_size * SSDFS_LOG_FOOTER_DESC_MAX;
+	struct ssdfs_metadata_descriptor *cur_hdr_desc;
+	struct page *page;
+	struct page *payload_page;
+	struct ssdfs_segment_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	struct ssdfs_log_footer *footer;
+	size_t footer_size = sizeof(struct ssdfs_log_footer);
+	void *kaddr = NULL;
+	loff_t peb_offset, offset;
+	u32 inline_capacity;
+	void *payload_buf;
+	u32 flags = 0;
+	u32 written = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !last_sb_log);
+	BUG_ON(!SSDFS_FS_I(sb)->devops);
+	BUG_ON(!SSDFS_FS_I(sb)->devops->writepage);
+	BUG_ON((last_sb_log->page_offset + last_sb_log->pages_count) >
+		(ULLONG_MAX >> SSDFS_FS_I(sb)->log_pagesize));
+	BUG_ON((last_sb_log->leb_id * SSDFS_FS_I(sb)->pebs_per_seg) >=
+		SSDFS_FS_I(sb)->nsegs);
+	BUG_ON(last_sb_log->peb_id >
+		div_u64(ULLONG_MAX, SSDFS_FS_I(sb)->pages_per_peb));
+	BUG_ON((last_sb_log->peb_id * SSDFS_FS_I(sb)->pages_per_peb) >
+		(ULLONG_MAX >> SSDFS_FS_I(sb)->log_pagesize));
+
+	SSDFS_DBG("sb %p, last_sb_log->leb_id %llu, last_sb_log->peb_id %llu, "
+		  "last_sb_log->page_offset %u, last_sb_log->pages_count %u\n",
+		  sb, last_sb_log->leb_id, last_sb_log->peb_id,
+		  last_sb_log->page_offset, last_sb_log->pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(sb);
+	hdr = SSDFS_SEG_HDR(fsi->sbi.vh_buf);
+	footer = SSDFS_LF(fsi->sbi.vs_buf);
+
+	memset(hdr_desc, 0, hdr_array_bytes);
+	memset(footer_desc, 0, footer_array_bytes);
+
+	offset = (loff_t)last_sb_log->page_offset << fsi->log_pagesize;
+	offset += hdr_size;
+
+	cur_hdr_desc = &hdr_desc[SSDFS_MAPTBL_CACHE_INDEX];
+	ssdfs_prepare_maptbl_cache_descriptor(cur_hdr_desc, (u32)offset,
+					      &payload->maptbl_cache,
+					      payload_size);
+
+	offset += payload_size;
+
+	offset += fsi->pagesize - 1;
+	offset = (offset >> fsi->log_pagesize) << fsi->log_pagesize;
+
+	cur_hdr_desc = &hdr_desc[SSDFS_LOG_FOOTER_INDEX];
+	cur_hdr_desc->offset = cpu_to_le32(offset);
+	cur_hdr_desc->size = cpu_to_le32(footer_size);
+
+	ssdfs_memcpy(hdr->desc_array, 0, hdr_array_bytes,
+		     hdr_desc, 0, hdr_array_bytes,
+		     hdr_array_bytes);
+
+	hdr->peb_migration_id[SSDFS_PREV_MIGRATING_PEB] =
+					SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+	hdr->peb_migration_id[SSDFS_CUR_MIGRATING_PEB] =
+					SSDFS_PEB_UNKNOWN_MIGRATION_ID;
+
+	err = ssdfs_prepare_segment_header_for_commit(fsi,
+						     last_sb_log->pages_count,
+						     SSDFS_SB_SEG_TYPE,
+						     SSDFS_LOG_HAS_FOOTER |
+						     SSDFS_LOG_HAS_MAPTBL_CACHE,
+						     timestamp, cno,
+						     hdr);
+	if (err) {
+		SSDFS_ERR("fail to prepare segment header: err %d\n", err);
+		return err;
+	}
+
+	offset += offsetof(struct ssdfs_log_footer, payload);
+	cur_hdr_desc = &footer_desc[SSDFS_SNAPSHOT_RULES_AREA_INDEX];
+
+	err = ssdfs_prepare_snapshot_rules_for_commit(fsi, cur_hdr_desc,
+						      (u32)offset);
+	if (err == -ENODATA) {
+		err = 0;
+		SSDFS_DBG("snapshot rules list is empty\n");
+	} else if (err) {
+		SSDFS_ERR("fail to prepare snapshot rules: err %d\n", err);
+		return err;
+	} else
+		flags |= SSDFS_LOG_FOOTER_HAS_SNAPSHOT_RULES;
+
+	ssdfs_memcpy(footer->desc_array, 0, footer_array_bytes,
+		     footer_desc, 0, footer_array_bytes,
+		     footer_array_bytes);
+
+	err = ssdfs_prepare_log_footer_for_commit(fsi, last_sb_log->pages_count,
+						  flags, timestamp,
+						  cno, footer);
+	if (err) {
+		SSDFS_ERR("fail to prepare log footer: err %d\n", err);
+		return err;
+	}
+
+	if (pagevec_count(&payload->maptbl_cache.pvec) != 1) {
+		SSDFS_WARN("payload contains several memory pages\n");
+		return -ERANGE;
+	}
+
+	inline_capacity = PAGE_SIZE - hdr_size;
+
+	if (payload_size > inline_capacity) {
+		SSDFS_ERR("payload_size %u > inline_capacity %u\n",
+			  payload_size, inline_capacity);
+		return -ERANGE;
+	}
+
+	payload_buf = ssdfs_super_kmalloc(inline_capacity, GFP_KERNEL);
+	if (!payload_buf) {
+		SSDFS_ERR("fail to allocate payload buffer\n");
+		return -ENOMEM;
+	}
+
+	page = ssdfs_super_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		ssdfs_super_kfree(payload_buf);
+		return err;
+	}
+
+	/* ->writepage() calls put_page() */
+	ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	payload_page = payload->maptbl_cache.pvec.pages[0];
+	if (!payload_page) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid payload page\n");
+		goto free_payload_buffer;
+	}
+
+	ssdfs_lock_page(payload_page);
+	err = ssdfs_memcpy_from_page(payload_buf, 0, inline_capacity,
+				     payload_page, 0, PAGE_SIZE,
+				     payload_size);
+	ssdfs_unlock_page(payload_page);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto free_payload_buffer;
+	}
+
+	/* write segment header + payload */
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+	ssdfs_memcpy(kaddr, 0, PAGE_SIZE,
+		     fsi->sbi.vh_buf, 0, hdr_size,
+		     hdr_size);
+	err = ssdfs_memcpy(kaddr, hdr_size, PAGE_SIZE,
+			   payload_buf, 0, inline_capacity,
+			   payload_size);
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+	if (!err) {
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		SetPageDirty(page);
+	}
+	ssdfs_unlock_page(page);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto free_payload_buffer;
+	}
+
+free_payload_buffer:
+	ssdfs_super_kfree(payload_buf);
+
+	if (unlikely(err))
+		goto cleanup_after_failure;
+
+	peb_offset = last_sb_log->peb_id * fsi->pages_per_peb;
+	peb_offset <<= fsi->log_pagesize;
+	offset = (loff_t)last_sb_log->page_offset << fsi->log_pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(peb_offset > (ULLONG_MAX - (offset + fsi->pagesize)));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	offset += peb_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("offset %llu\n", offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = fsi->devops->writepage(sb, offset, page, 0,
+				     hdr_size + payload_size);
+	if (err) {
+		SSDFS_ERR("fail to write segment header: "
+			  "offset %llu, size %zu\n",
+			  (u64)offset, hdr_size + payload_size);
+		goto cleanup_after_failure;
+	}
+
+	ssdfs_lock_page(page);
+	ClearPageUptodate(page);
+	ssdfs_clear_page_private(page, 0);
+	ssdfs_unlock_page(page);
+
+	offset += fsi->pagesize;
+
+	/* ->writepage() calls put_page() */
+	ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/* write log footer */
+	written = 0;
+
+	while (written < fsi->sbi.vs_buf_size) {
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		memset(kaddr, 0, PAGE_SIZE);
+		ssdfs_memcpy(kaddr, 0, PAGE_SIZE,
+			     fsi->sbi.vs_buf, written, fsi->sbi.vs_buf_size,
+			     PAGE_SIZE);
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		SetPageDirty(page);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset %llu\n", offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = fsi->devops->writepage(sb, offset, page, 0, PAGE_SIZE);
+		if (err) {
+			SSDFS_ERR("fail to write log footer: "
+				  "offset %llu, size %zu\n",
+				  (u64)offset, PAGE_SIZE);
+			goto cleanup_after_failure;
+		}
+
+		ssdfs_lock_page(page);
+		ClearPageUptodate(page);
+		ssdfs_clear_page_private(page, 0);
+		ssdfs_unlock_page(page);
+
+		written += PAGE_SIZE;
+		offset += PAGE_SIZE;
+	};
+
+	ssdfs_super_free_page(page);
+	return 0;
+
+cleanup_after_failure:
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_super_free_page(page);
+
+	return err;
+}
+
+static int ssdfs_commit_sb_log(struct super_block *sb,
+				u64 timestamp, u64 cno,
+				struct ssdfs_peb_extent *last_sb_log,
+				struct ssdfs_sb_log_payload *payload)
+{
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	u32 inline_capacity;
+	u32 payload_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !last_sb_log || !payload);
+
+	SSDFS_DBG("sb %p, last_sb_log->leb_id %llu, last_sb_log->peb_id %llu, "
+		  "last_sb_log->page_offset %u, last_sb_log->pages_count %u\n",
+		  sb, last_sb_log->leb_id, last_sb_log->peb_id,
+		  last_sb_log->page_offset, last_sb_log->pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inline_capacity = PAGE_SIZE - hdr_size;
+	payload_size = ssdfs_sb_payload_size(&payload->maptbl_cache.pvec);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("inline_capacity %u, payload_size %u\n",
+		  inline_capacity, payload_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (payload_size > inline_capacity) {
+		err = __ssdfs_commit_sb_log(sb, timestamp, cno,
+					    last_sb_log, payload);
+	} else {
+		err = __ssdfs_commit_sb_log_inline(sb, timestamp, cno,
+						   last_sb_log,
+						   payload, payload_size);
+	}
+
+	if (unlikely(err))
+		SSDFS_ERR("fail to commit sb log: err %d\n", err);
+
+	return err;
+}
+
+static
+int ssdfs_commit_super(struct super_block *sb, u16 fs_state,
+			struct ssdfs_peb_extent *last_sb_log,
+			struct ssdfs_sb_log_payload *payload)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	__le64 cur_segs[SSDFS_CUR_SEGS_COUNT];
+	size_t size = sizeof(__le64) * SSDFS_CUR_SEGS_COUNT;
+	u64 timestamp = ssdfs_current_timestamp();
+	u64 cno = ssdfs_current_cno(sb);
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !last_sb_log || !payload);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("sb %p, fs_state %u", sb, fs_state);
+#else
+	SSDFS_DBG("sb %p, fs_state %u", sb, fs_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	BUG_ON(fs_state > SSDFS_LAST_KNOWN_FS_STATE);
+
+	if (le16_to_cpu(fsi->vs->state) == SSDFS_ERROR_FS &&
+	    !ssdfs_test_opt(fsi->mount_opts, IGNORE_FS_STATE)) {
+		SSDFS_DBG("refuse commit superblock: fs erroneous state\n");
+		return 0;
+	}
+
+	err = ssdfs_prepare_volume_header_for_commit(fsi, fsi->vh);
+	if (unlikely(err)) {
+		SSDFS_CRIT("volume header is inconsistent: err %d\n", err);
+		goto finish_commit_super;
+	}
+
+	err = ssdfs_prepare_current_segment_ids(fsi, cur_segs, size);
+	if (unlikely(err)) {
+		SSDFS_CRIT("fail to prepare current segments IDs: err %d\n",
+			   err);
+		goto finish_commit_super;
+	}
+
+	err = ssdfs_prepare_volume_state_info_for_commit(fsi, fs_state,
+							 cur_segs, size,
+							 timestamp,
+							 cno,
+							 fsi->vs);
+	if (unlikely(err)) {
+		SSDFS_CRIT("volume state info is inconsistent: err %d\n", err);
+		goto finish_commit_super;
+	}
+
+	for (i = 0; i < SSDFS_SB_SEG_COPY_MAX; i++) {
+		last_sb_log->leb_id = fsi->sb_lebs[SSDFS_CUR_SB_SEG][i];
+		last_sb_log->peb_id = fsi->sb_pebs[SSDFS_CUR_SB_SEG][i];
+		err = ssdfs_commit_sb_log(sb, timestamp, cno,
+					  last_sb_log, payload);
+		if (err) {
+			SSDFS_ERR("fail to commit superblock log: "
+				  "leb_id %llu, peb_id %llu, "
+				  "page_offset %u, pages_count %u, "
+				  "err %d\n",
+				  last_sb_log->leb_id,
+				  last_sb_log->peb_id,
+				  last_sb_log->page_offset,
+				  last_sb_log->pages_count,
+				  err);
+			goto finish_commit_super;
+		}
+	}
+
+	last_sb_log->leb_id = fsi->sb_lebs[SSDFS_CUR_SB_SEG][SSDFS_MAIN_SB_SEG];
+	last_sb_log->peb_id = fsi->sb_pebs[SSDFS_CUR_SB_SEG][SSDFS_MAIN_SB_SEG];
+
+	ssdfs_memcpy(&fsi->sbi.last_log,
+		     0, sizeof(struct ssdfs_peb_extent),
+		     last_sb_log,
+		     0, sizeof(struct ssdfs_peb_extent),
+		     sizeof(struct ssdfs_peb_extent));
+
+finish_commit_super:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
 static void ssdfs_memory_page_locks_checker_init(void)
 {
 #ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
-- 
2.34.1

