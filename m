Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F956A264F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBYBR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBYBRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:11 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C946C12864
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:00 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bg11so810782oib.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W9QJr6cnOo6Oc4vSZBQ10mjMf8/dxAMIjj1Xmwsi84=;
        b=CtfLoqRpigszC+3agUjsqiVuJKoTsoSWF59RnSNHdodvqP5L/4N7vp4caznI5G29y4
         eBDJqw+HmC7CPPbvZIzmMxygZeUsZVa6OGmQR01nHK3VnyJYgpisDr+JJ02rnr1HDU1F
         i0Cr2r49AZc50+0PNiMLkPT5tNY0JdHHFx48Gz7QZ/4gkKEiYqp3la4jhcRL5p/xOlw5
         jjHqi2Y5fOf2ybDSQVlBi9P52sjyMUICZEge6rawkEVxT3uVKDEGgF3J6P/2Ibnt2rxl
         KGFpoPvENncZQGKLV8uZcxJNniHJXfounYfPz0AMhDeM0cMkU37hFeLHGl2nU/3ilYKt
         dFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W9QJr6cnOo6Oc4vSZBQ10mjMf8/dxAMIjj1Xmwsi84=;
        b=VMC5YAPHkAJDvXjmhEwl973r1FPFo2NVSQ7kXCFWab2LsfdQ6R2WUr+XUsVWfKb92U
         EC7D8/3EJo/yqvRkbN9TA6Yj6J5nOHUYDyjPVfbVoXlbgQU/xiT7QPtZC5PEFDvF5bAX
         yUuL+HNy/e/TMPIhcJIwECHuxoQZt4Lplnv40vCi2IE31eREZGCnSfbCanVn3obX71tO
         DsgFYoy20KcmJboNrNsFr1G/K4pKfIsIKqVJWTK2cxm70Up7Gv6dGgp3jDkyf9cXk8xl
         Hee5frroXRQ23ePPdFGjUtpanwZmSTlp1iflTZ4Ouv4YZYYJqmLDiOrn17VLvoxijKNd
         T7sg==
X-Gm-Message-State: AO0yUKVyIeN+yt3GYB6FiALV7E+fuucVIqFbScoLFoiW1fhgHwc/fExL
        oVBYrqXLKxHFKNsxGe2UCP1B7L/FigZXoH51
X-Google-Smtp-Source: AK7set/S+PkkbBHsZsCUDF4qmWbLzh3hhPZ9+HRgFKN7SD2MmaLXZjhLkuNh4i+uZISY5Z3/Mn6sjA==
X-Received: by 2002:aca:2309:0:b0:37f:b11c:7525 with SMTP id e9-20020aca2309000000b0037fb11c7525mr5274195oie.29.1677287819457;
        Fri, 24 Feb 2023 17:16:59 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:58 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 40/76] ssdfs: convert/map LEB to PEB functionality
Date:   Fri, 24 Feb 2023 17:08:51 -0800
Message-Id: <20230225010927.813929-41-slava@dubeyko.com>
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

Logical extent represents fundamental concept of SSDFS file
system. Any piece of data or metadata on file system volume
is identified by: (1) segment ID, (2) logical block ID, and
(3) length. As a result, any logical block is always located
at the same segment because segment is logical portion of
file system volume is always located at the same position.
However, logical block's content should be located into some
erase block. "Physical" Erase Block (PEB) mapping table
implements mapping of Logical Erase Block (LEB) into PEB
because any segment is a container for one or several LEBs.
Moreover, mapping table supports migration scheme implementation.
The migration scheme guarantee that logical block will be
always located at the same segment even for the case of update
requests.

PEB mapping table implements two fundamental methods:
(1) convert LEB to PEB; (2) map LEB to PEB. Conversion operation is
required if we need to identify which particular PEB contains
data for a LEB of particular segment. Mapping operation is required
if a clean segment has been allocated because LEB(s) of clean
segment need to be associated with PEB(s) that can store logs with
user data or metadata.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_mapping_table.c | 3289 ++++++++++++++++++++++++++++++++++
 1 file changed, 3289 insertions(+)

diff --git a/fs/ssdfs/peb_mapping_table.c b/fs/ssdfs/peb_mapping_table.c
index bfc11bb73360..44995170fe75 100644
--- a/fs/ssdfs/peb_mapping_table.c
+++ b/fs/ssdfs/peb_mapping_table.c
@@ -4763,3 +4763,3292 @@ int ssdfs_maptbl_solve_inconsistency(struct ssdfs_peb_mapping_table *tbl,
 
 	return err;
 }
+
+/*
+ * __is_mapped_leb2peb() - check that LEB is mapped
+ * @leb_desc: LEB descriptor
+ */
+static inline
+bool __is_mapped_leb2peb(struct ssdfs_leb_descriptor *leb_desc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!leb_desc);
+
+	SSDFS_DBG("physical_index %u, relation_index %u\n",
+		  le16_to_cpu(leb_desc->physical_index),
+		  le16_to_cpu(leb_desc->relation_index));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return le16_to_cpu(leb_desc->physical_index) != U16_MAX;
+}
+
+/*
+ * is_leb_migrating() - check that LEB is migrating
+ * @leb_desc: LEB descriptor
+ */
+static inline
+bool is_leb_migrating(struct ssdfs_leb_descriptor *leb_desc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!leb_desc);
+
+	SSDFS_DBG("physical_index %u, relation_index %u\n",
+		  le16_to_cpu(leb_desc->physical_index),
+		  le16_to_cpu(leb_desc->relation_index));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return le16_to_cpu(leb_desc->relation_index) != U16_MAX;
+}
+
+/*
+ * ssdfs_maptbl_set_under_erase_state() - set source PEB as under erase
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_under_erase_state(struct ssdfs_maptbl_fragment_desc *fdesc,
+					u16 index)
+{
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, index %u\n",
+		  fdesc, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
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
+	ptr = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = IS_ERR(ptr) ? PTR_ERR(ptr) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_page_processing;
+	}
+
+	ptr->state = SSDFS_MAPTBL_UNDER_ERASE_STATE;
+
+finish_page_processing:
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
+
+/*
+ * ssdfs_maptbl_set_pre_erase_state() - set source PEB as pre-erased
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_pre_erase_state(struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u16 index)
+{
+	struct ssdfs_peb_table_fragment_header *hdr;
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	unsigned long *bmap;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, index %u\n",
+		  fdesc, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
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
+	ptr = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = IS_ERR(ptr) ? PTR_ERR(ptr) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_page_processing;
+	}
+
+	ptr->state = SSDFS_MAPTBL_PRE_ERASE_STATE;
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_DIRTY_BMAP][0];
+	bitmap_set(bmap, item_index, 1);
+
+finish_page_processing:
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
+
+/*
+ * ssdfs_maptbl_set_snapshot_state() - set PEB in snapshot state
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_snapshot_state(struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u16 index)
+{
+	struct ssdfs_peb_table_fragment_header *hdr;
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	unsigned long *bmap;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, index %u\n",
+		  fdesc, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
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
+	ptr = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = IS_ERR(ptr) ? PTR_ERR(ptr) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_page_processing;
+	}
+
+	ptr->state = SSDFS_MAPTBL_SNAPSHOT_STATE;
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_DIRTY_BMAP][0];
+	bitmap_set(bmap, item_index, 1);
+
+finish_page_processing:
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
+
+/*
+ * ssdfs_maptbl_set_source_state() - set destination PEB as source
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ * @peb_state: PEB's state
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_source_state(struct ssdfs_maptbl_fragment_desc *fdesc,
+				  u16 index, u8 peb_state)
+{
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, index %u\n",
+		  fdesc, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
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
+	ptr = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = IS_ERR(ptr) ? PTR_ERR(ptr) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_page_processing;
+	}
+
+	if (peb_state == SSDFS_MAPTBL_UNKNOWN_PEB_STATE) {
+		switch (ptr->state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			ptr->state = SSDFS_MAPTBL_CLEAN_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			ptr->state = SSDFS_MAPTBL_USING_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			ptr->state = SSDFS_MAPTBL_USED_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			ptr->state = SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			ptr->state = SSDFS_MAPTBL_DIRTY_PEB_STATE;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid PEB state: "
+				  "state %#x\n",
+				  ptr->state);
+			goto finish_page_processing;
+		}
+	} else {
+		switch (ptr->state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			ptr->state = peb_state;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid PEB state: "
+				  "state %#x\n",
+				  ptr->state);
+			goto finish_page_processing;
+			break;
+		}
+	}
+
+finish_page_processing:
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
+
+/*
+ * __ssdfs_maptbl_exclude_migration_peb() - correct LEB table state
+ * @ptr: fragment descriptor
+ * @leb_id: LEB ID number
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_maptbl_exclude_migration_peb(struct ssdfs_maptbl_fragment_desc *ptr,
+					 u64 leb_id)
+{
+	struct ssdfs_leb_table_fragment_header *hdr;
+	struct ssdfs_leb_descriptor *leb_desc;
+	pgoff_t page_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+
+	SSDFS_DBG("fdesc %p, leb_id %llu\n",
+		  ptr, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = LEBTBL_PAGE_INDEX(ptr, leb_id);
+	if (page_index == ULONG_MAX) {
+		SSDFS_ERR("fail to define page_index: "
+			  "leb_id %llu\n",
+			  leb_id);
+		return -ERANGE;
+	}
+
+	page = ssdfs_page_array_get_page_locked(&ptr->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	leb_desc = GET_LEB_DESCRIPTOR(kaddr, leb_id);
+	if (IS_ERR_OR_NULL(leb_desc)) {
+		err = IS_ERR(leb_desc) ? PTR_ERR(leb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get leb_descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_page_processing;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("INITIAL: page_index %lu, "
+		  "physical_index %u, relation_index %u\n",
+		  page_index,
+		  le16_to_cpu(leb_desc->physical_index),
+		  le16_to_cpu(leb_desc->relation_index));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	leb_desc->physical_index = leb_desc->relation_index;
+	leb_desc->relation_index = cpu_to_le16(U16_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MODIFIED: page_index %lu, "
+		  "physical_index %u, relation_index %u\n",
+		  page_index,
+		  le16_to_cpu(leb_desc->physical_index),
+		  le16_to_cpu(leb_desc->relation_index));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(le16_to_cpu(hdr->migrating_lebs) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	le16_add_cpu(&hdr->migrating_lebs, -1);
+
+finish_page_processing:
+	kunmap_local(kaddr);
+
+	if (!err) {
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		err = ssdfs_page_array_set_page_dirty(&ptr->array,
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
+
+/*
+ * ssdfs_maptbl_solve_pre_deleted_state() - exclude pre-deleted migration PEB
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @pebr: cached PEB relation
+ *
+ * This method tries to exclude the pre-deleted migration PEB
+ * from the relation by means of mapping table modification if
+ * the migration PEB is marked as pre-deleted in the mapping
+ * table cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int
+ssdfs_maptbl_solve_pre_deleted_state(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u64 leb_id,
+				     struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 physical_index, relation_index;
+	int peb_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc);
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
+	if (!__is_mapped_leb2peb(&leb_desc)) {
+		SSDFS_ERR("leb %llu doesn't be mapped yet\n",
+			  leb_id);
+		return -ERANGE;
+	}
+
+	if (!is_leb_migrating(&leb_desc)) {
+		SSDFS_ERR("leb %llu isn't under migration\n",
+			  leb_id);
+		return -ERANGE;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+	relation_index = le16_to_cpu(leb_desc.relation_index);
+
+	peb_state = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state;
+
+	switch (peb_state) {
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid state %#x of source PEB\n",
+			  peb_state);
+		return -ERANGE;
+	}
+
+	err = ssdfs_maptbl_set_pre_erase_state(fdesc, physical_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move PEB into pre-erase state: "
+			  "index %u, err %d\n",
+			  physical_index, err);
+		return err;
+	}
+
+	peb_state = pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state;
+
+	err = ssdfs_maptbl_set_source_state(fdesc, relation_index,
+					    (u8)peb_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move PEB into source state: "
+			  "index %u, peb_state %#x, err %d\n",
+			  relation_index, peb_state, err);
+		return err;
+	}
+
+	err = __ssdfs_maptbl_exclude_migration_peb(fdesc, leb_id);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change leb descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(fdesc->migrating_lebs == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fdesc->migrating_lebs--;
+	fdesc->pre_erase_pebs++;
+	atomic_inc(&tbl->pre_erase_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u\n",
+		  fdesc->mapped_lebs, fdesc->migrating_lebs);
+	SSDFS_DBG("fdesc->pre_erase_pebs %u, tbl->pre_erase_pebs %d\n",
+		  fdesc->pre_erase_pebs,
+		  atomic_read(&tbl->pre_erase_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wake_up(&tbl->wait_queue);
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_set_fragment_dirty() - set fragment as dirty
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ */
+void ssdfs_maptbl_set_fragment_dirty(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u64 leb_id)
+{
+	u32 fragment_index;
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t bytes_count;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment_index = FRAGMENT_INDEX(tbl, leb_id);
+
+	if (is_ssdfs_maptbl_going_to_be_destroyed(tbl)) {
+		SSDFS_WARN("maptbl %p, leb_id %llu, "
+			  "fdesc %p, fragment_index %u, "
+			  "start_leb %llu, lebs_count %u\n",
+			  tbl, leb_id,
+			  fdesc, fragment_index,
+			  fdesc->start_leb, fdesc->lebs_count);
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("maptbl %p, leb_id %llu, "
+			  "fdesc %p, fragment_index %u, "
+			  "start_leb %llu, lebs_count %u\n",
+			  tbl, leb_id,
+			  fdesc, fragment_index,
+			  fdesc->start_leb, fdesc->lebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(fragment_index == U32_MAX);
+	BUG_ON(fragment_index >= tbl->fragments_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_lock(&tbl->bmap_lock);
+#ifdef CONFIG_SSDFS_DEBUG
+	bytes_count = tbl->fragments_count + BITS_PER_LONG - 1;
+	bytes_count /= BITS_PER_BYTE;
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			tbl->dirty_bmap, bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	atomic_set(&fdesc->state, SSDFS_MAPTBL_FRAG_DIRTY);
+	bitmap_set(tbl->dirty_bmap, fragment_index, 1);
+	mutex_unlock(&tbl->bmap_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fragment_index %u, state %#x\n",
+		  fragment_index,
+		  atomic_read(&fdesc->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_maptbl_convert_leb2peb() - get description of PEBs
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @pebr: description of PEBs relation [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to get description of PEBs for the
+ * LEB ID number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-ENODATA    - LEB doesn't mapped to PEB yet.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_convert_leb2peb(struct ssdfs_fs_info *fsi,
+				 u64 leb_id,
+				 u8 peb_type,
+				 struct ssdfs_maptbl_peb_relation *pebr,
+				 struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_cache *cache;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_leb_descriptor leb_desc;
+	struct ssdfs_maptbl_peb_relation cached_pebr;
+	size_t peb_relation_size = sizeof(struct ssdfs_maptbl_peb_relation);
+	u8 consistency = SSDFS_PEB_STATE_CONSISTENT;
+	int state;
+	u64 peb_id;
+	u8 peb_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebr || !end);
+
+	SSDFS_DBG("fsi %p, leb_id %llu, peb_type %#x, "
+		  "pebr %p, init_end %p\n",
+		  fsi, leb_id, peb_type, pebr, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*end = NULL;
+	memset(pebr, 0xFF, peb_relation_size);
+
+	tbl = fsi->maptbl;
+	cache = &tbl->fsi->maptbl_cache;
+
+	if (!tbl) {
+		err = 0;
+
+		if (should_cache_peb_info(peb_type)) {
+			err = ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id,
+								 pebr);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to convert LEB to PEB: "
+					  "leb_id %llu, err %d\n",
+					  leb_id, err);
+			}
+		} else {
+			err = -ERANGE;
+			SSDFS_CRIT("mapping table is absent\n");
+		}
+
+		return err;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	if (rwsem_is_locked(&tbl->tbl_lock) &&
+	    atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		if (should_cache_peb_info(peb_type)) {
+			err = ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id,
+								 pebr);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to convert LEB to PEB: "
+					  "leb_id %llu, err %d\n",
+					  leb_id, err);
+			}
+
+			return err;
+		}
+	}
+
+	down_read(&tbl->tbl_lock);
+
+	if (peb_type == SSDFS_MAPTBL_UNKNOWN_PEB_TYPE) {
+		/*
+		 * GC thread requested the conversion
+		 * without the knowledge of PEB's type.
+		 */
+		goto start_convert_leb2peb;
+	}
+
+	if (should_cache_peb_info(peb_type)) {
+		struct ssdfs_maptbl_peb_descriptor *peb_desc;
+
+		err = __ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id,
+							   &cached_pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to convert LEB to PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_conversion;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_conversion;
+		}
+
+		peb_desc = &cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX];
+		consistency = peb_desc->consistency;
+
+		switch (consistency) {
+		case SSDFS_PEB_STATE_CONSISTENT:
+			peb_desc =
+				&cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX];
+			switch (peb_desc->consistency) {
+			case SSDFS_PEB_STATE_INCONSISTENT:
+				consistency = peb_desc->consistency;
+				break;
+
+			default:
+				/* do nothing */
+				break;
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+			  "state %#x, consistency %#x; "
+			  "RELATION_INDEX: peb_id %llu, type %#x, "
+			  "state %#x, consistency %#x\n",
+		    cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		    cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		    cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		    cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		    cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		    cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		    cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		    cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+start_convert_leb2peb:
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_conversion;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n",
+			  leb_id);
+		goto finish_conversion;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: "
+			  "leb_id %llu\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = -EAGAIN;
+		goto finish_conversion;
+	}
+
+	switch (consistency) {
+	case SSDFS_PEB_STATE_CONSISTENT:
+		down_read(&fdesc->lock);
+
+		err = ssdfs_maptbl_get_leb_descriptor(fdesc, leb_id, &leb_desc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get leb descriptor: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_consistent_case;
+		}
+
+		err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_consistent_case;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_consistent_case;
+		}
+
+finish_consistent_case:
+		up_read(&fdesc->lock);
+		break;
+
+	case SSDFS_PEB_STATE_INCONSISTENT:
+		down_write(&cache->lock);
+		down_write(&fdesc->lock);
+
+		err = ssdfs_maptbl_cache_convert_leb2peb_nolock(cache,
+								leb_id,
+								&cached_pebr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_inconsistent_case;
+		}
+
+		err = ssdfs_maptbl_solve_inconsistency(tbl, fdesc, leb_id,
+							&cached_pebr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to resolve inconsistency: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_inconsistent_case;
+		}
+
+		err = ssdfs_maptbl_get_leb_descriptor(fdesc, leb_id, &leb_desc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get leb descriptor: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_inconsistent_case;
+		}
+
+		err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_inconsistent_case;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_inconsistent_case;
+		}
+
+		peb_id = cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+		peb_state = cached_pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].state;
+		if (peb_id != U64_MAX) {
+			consistency = SSDFS_PEB_STATE_CONSISTENT;
+			err = ssdfs_maptbl_cache_change_peb_state_nolock(cache,
+								  leb_id,
+								  peb_state,
+								  consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change PEB state: "
+					  "leb_id %llu, peb_state %#x, "
+					  "err %d\n",
+					  leb_id, peb_state, err);
+				goto finish_inconsistent_case;
+			}
+		}
+
+		peb_id = cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id;
+		peb_state = cached_pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].state;
+		if (peb_id != U64_MAX) {
+			consistency = SSDFS_PEB_STATE_CONSISTENT;
+			err = ssdfs_maptbl_cache_change_peb_state_nolock(cache,
+								  leb_id,
+								  peb_state,
+								  consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change PEB state: "
+					  "leb_id %llu, peb_state %#x, "
+					  "err %d\n",
+					  leb_id, peb_state, err);
+				goto finish_inconsistent_case;
+			}
+		}
+
+finish_inconsistent_case:
+		up_write(&fdesc->lock);
+		up_write(&cache->lock);
+
+		if (!err) {
+			ssdfs_maptbl_set_fragment_dirty(tbl, fdesc,
+							leb_id);
+		}
+		break;
+
+	case SSDFS_PEB_STATE_PRE_DELETED:
+		down_write(&cache->lock);
+		down_write(&fdesc->lock);
+
+		err = ssdfs_maptbl_cache_convert_leb2peb_nolock(cache,
+								leb_id,
+								&cached_pebr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_pre_deleted_case;
+		}
+
+		err = ssdfs_maptbl_solve_pre_deleted_state(tbl, fdesc, leb_id,
+							   &cached_pebr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to resolve pre-deleted state: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_pre_deleted_case;
+		}
+
+		err = ssdfs_maptbl_get_leb_descriptor(fdesc, leb_id, &leb_desc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get leb descriptor: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_pre_deleted_case;
+		}
+
+		err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_pre_deleted_case;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_pre_deleted_case;
+		}
+
+		consistency = SSDFS_PEB_STATE_CONSISTENT;
+		err = ssdfs_maptbl_cache_forget_leb2peb_nolock(cache,
+								leb_id,
+								consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to exclude migration PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_pre_deleted_case;
+		}
+
+finish_pre_deleted_case:
+		up_write(&fdesc->lock);
+		up_write(&cache->lock);
+
+		if (!err) {
+			ssdfs_maptbl_set_fragment_dirty(tbl, fdesc,
+							leb_id);
+		}
+		break;
+
+	default:
+		err = -EFAULT;
+		SSDFS_ERR("invalid consistency %#x\n",
+			  consistency);
+		goto finish_conversion;
+	}
+
+finish_conversion:
+	up_read(&tbl->tbl_lock);
+
+	if (!err && peb_type == SSDFS_MAPTBL_UNKNOWN_PEB_TYPE) {
+		peb_type = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].type;
+
+		if (should_cache_peb_info(peb_type)) {
+			err = ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id,
+								 &cached_pebr);
+			if (err == -ENODATA) {
+				err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("cache has nothing for leb_id %llu\n",
+					  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to convert LEB to PEB: "
+					  "leb_id %llu, err %d\n",
+					  leb_id, err);
+				return err;
+			} else {
+				/* use the cached value */
+				ssdfs_memcpy(pebr, 0, peb_relation_size,
+					     &cached_pebr, 0, peb_relation_size,
+					     peb_relation_size);
+			}
+		}
+	} else if (err == -EAGAIN && should_cache_peb_info(peb_type)) {
+		err = ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id,
+							 pebr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * is_mapped_leb2peb() - check that LEB is mapped
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ */
+static inline
+bool is_mapped_leb2peb(struct ssdfs_maptbl_fragment_desc *fdesc,
+			u64 leb_id)
+{
+	struct ssdfs_leb_descriptor leb_desc;
+	bool is_mapped;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("leb_id %llu, fdesc %p\n",
+		  leb_id, fdesc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_get_leb_descriptor(fdesc, leb_id, &leb_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get leb descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		return false;
+	}
+
+	is_mapped = __is_mapped_leb2peb(&leb_desc);
+
+	if (!is_mapped) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unitialized leb descriptor: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return is_mapped;
+}
+
+static inline
+bool need_try2reserve_peb(struct ssdfs_fs_info *fsi)
+{
+#define SSDFS_PEB_RESERVATION_THRESHOLD		1
+	return fsi->pebs_per_seg == SSDFS_PEB_RESERVATION_THRESHOLD;
+}
+
+/*
+ * can_be_mapped_leb2peb() - check that LEB can be mapped
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ */
+static inline
+bool can_be_mapped_leb2peb(struct ssdfs_peb_mapping_table *tbl,
+			   struct ssdfs_maptbl_fragment_desc *fdesc,
+			   u64 leb_id)
+{
+	u32 unused_lebs;
+	u32 expected2migrate = 0;
+	u32 reserved_pool = 0;
+	u32 migration_NOT_guaranted = 0;
+	u32 threshold;
+	bool is_mapping_possible = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc);
+	BUG_ON(!tbl->fsi);
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, fdesc %p\n",
+		  tbl, leb_id, fdesc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	expected2migrate = fdesc->mapped_lebs - fdesc->migrating_lebs;
+	reserved_pool = fdesc->reserved_pebs + fdesc->pre_erase_pebs;
+
+	if (expected2migrate > reserved_pool)
+		migration_NOT_guaranted = expected2migrate - reserved_pool;
+	else
+		migration_NOT_guaranted = 0;
+
+	unused_lebs = ssdfs_unused_lebs_in_fragment(fdesc);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lebs_count %u, mapped_lebs %u, "
+		  "migrating_lebs %u, reserved_pebs %u, "
+		  "pre_erase_pebs %u, expected2migrate %u, "
+		  "reserved_pool %u, migration_NOT_guaranted %u, "
+		  "unused_lebs %u\n",
+		  fdesc->lebs_count, fdesc->mapped_lebs,
+		  fdesc->migrating_lebs, fdesc->reserved_pebs,
+		  fdesc->pre_erase_pebs, expected2migrate,
+		  reserved_pool, migration_NOT_guaranted,
+		  unused_lebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	threshold = ssdfs_lebs_reservation_threshold(fdesc);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("unused_lebs %u, migration_NOT_guaranted %u, "
+		  "threshold %u, stripe_pages %u\n",
+		  unused_lebs,
+		  migration_NOT_guaranted,
+		  threshold,
+		  fdesc->stripe_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((reserved_pool + 1) >= unused_lebs) {
+		is_mapping_possible = false;
+		goto finish_check;
+	}
+
+	if (need_try2reserve_peb(tbl->fsi)) {
+		threshold = max_t(u32, threshold,
+				  (u32)tbl->stripes_per_fragment);
+
+		if (unused_lebs > threshold) {
+			is_mapping_possible = true;
+			goto finish_check;
+		}
+
+		if (migration_NOT_guaranted == 0 &&
+		    unused_lebs > tbl->stripes_per_fragment) {
+			is_mapping_possible = true;
+			goto finish_check;
+		}
+	} else {
+		if (unused_lebs > threshold) {
+			is_mapping_possible = true;
+			goto finish_check;
+		}
+
+		if (migration_NOT_guaranted == 0 && unused_lebs > 0) {
+			is_mapping_possible = true;
+			goto finish_check;
+		}
+	}
+
+finish_check:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("is_mapping_possible %#x\n",
+		  is_mapping_possible);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_mapping_possible;
+}
+
+/*
+ * has_fragment_unused_pebs() - check that fragment has unused PEBs
+ * @hdr: PEB table fragment's header
+ */
+static inline
+bool has_fragment_unused_pebs(struct ssdfs_peb_table_fragment_header *hdr)
+{
+	unsigned long *bmap;
+	u16 pebs_count;
+	int used_pebs, unused_pebs;
+	u16 reserved_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	used_pebs = bitmap_weight(bmap, pebs_count);
+	unused_pebs = pebs_count - used_pebs;
+
+	WARN_ON(unused_pebs < 0);
+
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+
+	if (reserved_pebs > unused_pebs) {
+		SSDFS_ERR("reserved_pebs %u > unused_pebs %u\n",
+			  reserved_pebs, unused_pebs);
+		return false;
+	}
+
+	unused_pebs -= reserved_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hdr %p, unused_pebs %d, reserved_pebs %u\n",
+		  hdr, unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return unused_pebs > 0;
+}
+
+/*
+ * ssdfs_maptbl_decrease_reserved_pebs() - decrease amount of reserved PEBs
+ * @fsi: file system info object
+ * @desc: fragment descriptor
+ * @hdr: PEB table fragment's header
+ *
+ * This method tries to move some amount of reserved PEBs into
+ * unused state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - unable to decrease amount of reserved PEBs.
+ */
+static
+int ssdfs_maptbl_decrease_reserved_pebs(struct ssdfs_fs_info *fsi,
+				    struct ssdfs_maptbl_fragment_desc *desc,
+				    struct ssdfs_peb_table_fragment_header *hdr)
+{
+	unsigned long *bmap;
+	u32 expected2migrate;
+	u16 pebs_count;
+	u16 reserved_pebs;
+	u16 used_pebs;
+	u16 unused_pebs;
+	u16 new_reservation;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("desc %p, hdr %p\n", desc, hdr);
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u, "
+		  "pebs_count %u, reserved_pebs %u\n",
+		  desc->mapped_lebs, desc->migrating_lebs,
+		  pebs_count, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	expected2migrate = (desc->mapped_lebs - desc->migrating_lebs);
+	expected2migrate /= desc->stripe_pages;
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	used_pebs = bitmap_weight(bmap, pebs_count);
+	unused_pebs = pebs_count - used_pebs;
+
+	if (reserved_pebs > unused_pebs) {
+		SSDFS_ERR("reserved_pebs %u > unused_pebs %u\n",
+			  reserved_pebs, unused_pebs);
+		return -ERANGE;
+	}
+
+	unused_pebs -= reserved_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebs_count %u, used_pebs %u, unused_pebs %u, "
+		  "expected2migrate %u\n",
+		  pebs_count, used_pebs,
+		  unused_pebs, expected2migrate);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unused_pebs > reserved_pebs) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("no necessity to decrease: "
+			  "unused_pebs %u, reserved_pebs %u\n",
+			  unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	new_reservation = max_t(u16, expected2migrate,
+				(unused_pebs * 20) / 100);
+
+	if (reserved_pebs > new_reservation) {
+		u64 free_pages;
+		u64 new_free_pages;
+		u16 new_unused_pebs = reserved_pebs - new_reservation;
+
+		hdr->reserved_pebs = cpu_to_le16(new_reservation);
+		desc->reserved_pebs -= new_unused_pebs;
+
+		spin_lock(&fsi->volume_state_lock);
+		new_free_pages = (u64)new_unused_pebs * fsi->pages_per_peb;
+		fsi->free_pages += new_free_pages;
+		free_pages = fsi->free_pages;
+		spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free_pages %llu, new_free_pages %llu\n",
+			  free_pages, new_free_pages);
+		SSDFS_DBG("reserved_pebs %u, new_reservation %u, "
+			  "desc->reserved_pebs %u\n",
+			  reserved_pebs, new_reservation,
+			  desc->reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return 0;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("unable to decrease reserved PEBs\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENOSPC;
+}
+
+static inline
+u32 ssdfs_mandatory_reserved_pebs_pct(struct ssdfs_fs_info *fsi)
+{
+	u32 percentage = 50;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	percentage /= fsi->pebs_per_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebs_per_seg %u, percentage %u\n",
+		  fsi->pebs_per_seg, percentage);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return percentage;
+}
+
+/*
+ * ssdfs_maptbl_increase_reserved_pebs() - increase amount of reserved PEBs
+ * @fsi: file system info object
+ * @desc: fragment descriptor
+ * @hdr: PEB table fragment's header
+ *
+ * This method tries to move some amount of unused PEBs into
+ * reserved state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - unable to increase amount of reserved PEBs.
+ */
+static
+int ssdfs_maptbl_increase_reserved_pebs(struct ssdfs_fs_info *fsi,
+				    struct ssdfs_maptbl_fragment_desc *desc,
+				    struct ssdfs_peb_table_fragment_header *hdr)
+{
+	unsigned long *bmap;
+	u32 expected2migrate;
+	u16 pebs_count;
+	u16 reserved_pebs;
+	u16 used_pebs;
+	u16 unused_pebs;
+	u64 free_pages = 0;
+	u64 free_pebs = 0;
+	u64 reserved_pages = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !hdr);
+
+	if (desc->migrating_lebs > desc->mapped_lebs) {
+		SSDFS_ERR("fragment is corrupted: "
+			  "migrating_lebs %u, mapped_lebs %u\n",
+			  desc->migrating_lebs,
+			  desc->mapped_lebs);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, hdr %p\n", desc, hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u, "
+		  "pebs_count %u, reserved_pebs %u\n",
+		  desc->mapped_lebs, desc->migrating_lebs,
+		  pebs_count, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	expected2migrate = desc->mapped_lebs - desc->migrating_lebs;
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	used_pebs = bitmap_weight(bmap, pebs_count);
+	unused_pebs = pebs_count - used_pebs;
+
+	if (reserved_pebs > unused_pebs) {
+		SSDFS_ERR("reserved_pebs %u > unused_pebs %u\n",
+			  reserved_pebs, unused_pebs);
+		return -ERANGE;
+	}
+
+	unused_pebs -= reserved_pebs;
+
+	if (need_try2reserve_peb(fsi)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("used_pebs %u, unused_pebs %u, "
+			  "reserved_pebs %u\n",
+			  used_pebs, unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (reserved_pebs < used_pebs && unused_pebs >= used_pebs) {
+			reserved_pebs = used_pebs;
+
+			spin_lock(&fsi->volume_state_lock);
+			free_pages = fsi->free_pages;
+			free_pebs = div64_u64(free_pages, fsi->pages_per_peb);
+			if (reserved_pebs <= free_pebs) {
+				reserved_pages = (u64)reserved_pebs *
+							fsi->pages_per_peb;
+				fsi->free_pages -= reserved_pages;
+				free_pages = fsi->free_pages;
+				hdr->reserved_pebs = cpu_to_le16(reserved_pebs);
+				desc->reserved_pebs += reserved_pebs;
+			} else
+				err = -ENOSPC;
+			spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("free_pages %llu, reserved_pages %llu, "
+				  "reserved_pebs %u, err %d\n",
+				  free_pages, reserved_pages,
+				  reserved_pebs, err);
+			SSDFS_DBG("hdr->reserved_pebs %u\n",
+				  le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return err;
+		}
+	}
+
+	if (reserved_pebs > 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("no need to increase reserved pebs: "
+			  "reserved_pebs %u\n",
+			  reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	reserved_pebs = min_t(u16, unused_pebs / 2, expected2migrate);
+
+	if (reserved_pebs == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("reserved_pebs %u, unused_pebs %u, "
+			  "expected2migrate %u\n",
+			  reserved_pebs, unused_pebs,
+			  expected2migrate);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	spin_lock(&fsi->volume_state_lock);
+	free_pages = fsi->free_pages;
+	free_pebs = div64_u64(free_pages, fsi->pages_per_peb);
+	if (reserved_pebs <= free_pebs) {
+		reserved_pages = (u64)reserved_pebs * fsi->pages_per_peb;
+		fsi->free_pages -= reserved_pages;
+		free_pages = fsi->free_pages;
+		le16_add_cpu(&hdr->reserved_pebs, reserved_pebs);
+		desc->reserved_pebs += reserved_pebs;
+	} else
+		err = -ENOSPC;
+	spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_pages %llu, reserved_pages %llu, "
+		  "reserved_pebs %u, err %d\n",
+		  free_pages, reserved_pages,
+		  reserved_pebs, err);
+	SSDFS_DBG("hdr->reserved_pebs %u\n",
+		  le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_get_erase_threshold() - detect erase threshold for fragment
+ * @hdr: PEB table fragment's header
+ * @start: start item for search
+ * @max: upper bound for the search
+ * @used_pebs: number of used PEBs
+ * @found: found item index [out]
+ * @erase_cycles: erase cycles for found item [out]
+ *
+ * This method tries to detect the erase threshold of
+ * PEB table's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENODATA    - unable to detect the erase threshold.
+ */
+static int
+ssdfs_maptbl_get_erase_threshold(struct ssdfs_peb_table_fragment_header *hdr,
+				 unsigned long start, unsigned long max,
+				 unsigned long used_pebs,
+				 unsigned long *found, u32 *threshold)
+{
+	struct ssdfs_peb_descriptor *desc;
+	unsigned long *bmap;
+	unsigned long index, index1;
+	u32 found_cycles;
+	int step = 1;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !found || !threshold);
+
+	SSDFS_DBG("hdr %p, start_peb %llu, pebs_count %u, "
+		  "start %lu, max %lu, used_pebs %lu\n",
+		  hdr,
+		  le64_to_cpu(hdr->start_peb),
+		  le16_to_cpu(hdr->pebs_count),
+		  start, max, used_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+
+	*found = ULONG_MAX;
+	*threshold = U32_MAX;
+
+	index = max - 1;
+	while (index > 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index %lu, used_pebs %lu\n",
+			  index, used_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		index1 = bitmap_find_next_zero_area(bmap,
+						    max, index,
+						    1, 0);
+		if (index1 >= max) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try next: index1 %lu >= max %lu\n",
+				  index1, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			desc = GET_PEB_DESCRIPTOR(hdr, (u16)index);
+			if (IS_ERR_OR_NULL(desc)) {
+				err = IS_ERR(desc) ? PTR_ERR(desc) : -ERANGE;
+				SSDFS_ERR("fail to get peb_descriptor: "
+					  "index %lu, err %d\n",
+					  index, err);
+				return err;
+			}
+
+			if (desc->state != SSDFS_MAPTBL_BAD_PEB_STATE) {
+				found_cycles = le32_to_cpu(desc->erase_cycles);
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("index %lu, found_cycles %u, "
+					  "threshold %u\n",
+					  index, found_cycles, *threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				if (*threshold > found_cycles)
+					*threshold = found_cycles;
+			}
+
+			goto try_next_index;
+		} else
+			index = index1;
+
+		if (index == *found)
+			goto finish_search;
+
+		desc = GET_PEB_DESCRIPTOR(hdr, (u16)index);
+		if (IS_ERR_OR_NULL(desc)) {
+			err = IS_ERR(desc) ? PTR_ERR(desc) : -ERANGE;
+			SSDFS_ERR("fail to get peb_descriptor: "
+				  "index %lu, err %d\n",
+				  index, err);
+			return err;
+		}
+
+		if (desc->state != SSDFS_MAPTBL_BAD_PEB_STATE) {
+			found_cycles = le32_to_cpu(desc->erase_cycles);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index %lu, found_cycles %u, threshold %u\n",
+				  index, found_cycles, *threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (*found >= ULONG_MAX) {
+				*threshold = found_cycles;
+				*found = index;
+			} else if (*threshold > found_cycles) {
+				*threshold = found_cycles;
+				*found = index;
+			} else if (*threshold == found_cycles) {
+				/* continue search */
+				*found = index;
+			} else if ((*threshold + 1) <= found_cycles) {
+				*found = index;
+				goto finish_search;
+			}
+		}
+
+try_next_index:
+		if (index <= step)
+			break;
+
+		index -= step;
+		step *= 2;
+
+		while ((index - start) < step && step >= 2)
+			step /= 2;
+	}
+
+	if (*found >= ULONG_MAX) {
+		index = bitmap_find_next_zero_area(bmap,
+						   max, 0,
+						   1, 0);
+		if (index < max) {
+			desc = GET_PEB_DESCRIPTOR(hdr, (u16)index);
+			if (IS_ERR_OR_NULL(desc)) {
+				err = IS_ERR(desc) ? PTR_ERR(desc) : -ERANGE;
+				SSDFS_ERR("fail to get peb_descriptor: "
+					  "index %lu, err %d\n",
+					  index, err);
+				return err;
+			}
+
+			if (desc->state != SSDFS_MAPTBL_BAD_PEB_STATE) {
+				found_cycles = le32_to_cpu(desc->erase_cycles);
+				*threshold = found_cycles;
+				*found = index;
+			}
+		}
+	}
+
+finish_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found %lu, threshold %u\n",
+		  *found, *threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * __ssdfs_maptbl_find_unused_peb() - find unused PEB
+ * @hdr: PEB table fragment's header
+ * @start: start item for search
+ * @max: upper bound for the search
+ * @threshold: erase threshold for fragment
+ * @found: found item index [out]
+ *
+ * This method tries to find unused PEB in the bitmap of
+ * PEB table's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENODATA    - unable to find unused PEB.
+ */
+static
+int __ssdfs_maptbl_find_unused_peb(struct ssdfs_peb_table_fragment_header *hdr,
+				   unsigned long start, unsigned long max,
+				   u32 threshold, unsigned long *found)
+{
+	struct ssdfs_peb_descriptor *desc;
+	unsigned long *bmap;
+	unsigned long index;
+	int err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !found);
+
+	SSDFS_DBG("hdr %p, start %lu, max %lu, threshold %u\n",
+		  hdr, start, max, threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+
+	*found = ULONG_MAX;
+
+	if (start >= max) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %lu >= max %lu\n",
+			  start, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	do {
+		index = bitmap_find_next_zero_area(bmap, max, start, 1, 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %lu, max %lu, index %lu\n",
+			  start, max, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (index >= max) {
+			SSDFS_DBG("unable to find the unused peb\n");
+			return -ENODATA;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		desc = GET_PEB_DESCRIPTOR(hdr, (u16)index);
+		if (IS_ERR_OR_NULL(desc)) {
+			err = IS_ERR(desc) ? PTR_ERR(desc) : -ERANGE;
+			SSDFS_ERR("fail to get peb_descriptor: "
+				  "index %lu, err %d\n",
+				  index, err);
+			return err;
+		}
+
+		if (desc->state != SSDFS_MAPTBL_BAD_PEB_STATE) {
+			u32 found_cycles = le32_to_cpu(desc->erase_cycles);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index %lu, found_cycles %u, threshold %u\n",
+				  index, found_cycles, threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (found_cycles <= threshold) {
+				*found = index;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("found: index %lu, "
+					  "found_cycles %u, threshold %u\n",
+					  *found, found_cycles, threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return 0;
+			} else {
+				/* continue to search */
+				*found = ULONG_MAX;
+			}
+		}
+
+		start = index + 1;
+	} while (start < max);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_find_unused_peb() - find unused PEB
+ * @hdr: PEB table fragment's header
+ * @start: start item for search
+ * @max: upper bound for the search
+ * @used_pebs: number of used PEBs
+ * @found: found item index [out]
+ * @erase_cycles: erase cycles for found item [out]
+ *
+ * This method tries to find unused PEB in the bitmap of
+ * PEB table's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENODATA    - unable to find unused PEB.
+ */
+static
+int ssdfs_maptbl_find_unused_peb(struct ssdfs_peb_table_fragment_header *hdr,
+				 unsigned long start, unsigned long max,
+				 unsigned long used_pebs,
+				 unsigned long *found, u32 *erase_cycles)
+{
+	u32 threshold = U32_MAX;
+	unsigned long found_for_threshold;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !found || !erase_cycles);
+
+	SSDFS_DBG("hdr %p, start %lu, max %lu\n",
+		  hdr, start, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start >= max) {
+		SSDFS_ERR("start %lu >= max %lu\n",
+			  start, max);
+		return -EINVAL;
+	}
+
+	err = ssdfs_maptbl_get_erase_threshold(hdr, 0, max, used_pebs,
+						found, &threshold);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to detect erase threshold: err %d\n", err);
+		return err;
+	} else if (threshold >= U32_MAX) {
+		SSDFS_ERR("invalid erase threshold %u\n", threshold);
+		return -ERANGE;
+	}
+
+	*erase_cycles = threshold;
+	found_for_threshold = *found;
+
+	err = __ssdfs_maptbl_find_unused_peb(hdr, start, max,
+					     threshold, found);
+	if (err == -ENODATA) {
+		err = __ssdfs_maptbl_find_unused_peb(hdr,
+						     0, start,
+						     threshold, found);
+	}
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		struct ssdfs_peb_descriptor *desc;
+		unsigned long *bmap;
+		u64 start_peb;
+		u16 pebs_count;
+		u16 reserved_pebs;
+		u16 last_selected_peb;
+		unsigned long used_pebs;
+		u32 found_cycles;
+		int i;
+
+		SSDFS_DBG("unable to find unused PEB: "
+			  "found_for_threshold %lu, threshold %u\n",
+			  found_for_threshold, threshold);
+
+		bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+		start_peb = le64_to_cpu(hdr->start_peb);
+		pebs_count = le16_to_cpu(hdr->pebs_count);
+		reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+		last_selected_peb = le16_to_cpu(hdr->last_selected_peb);
+		used_pebs = bitmap_weight(bmap, pebs_count);
+
+		SSDFS_DBG("hdr %p, start_peb %llu, pebs_count %u, "
+			  "last_selected_peb %u, "
+			  "reserved_pebs %u, used_pebs %lu\n",
+			  hdr, start_peb, pebs_count, last_selected_peb,
+			  reserved_pebs, used_pebs);
+
+		for (i = 0; i < max; i++) {
+			desc = GET_PEB_DESCRIPTOR(hdr, (u16)i);
+			if (IS_ERR_OR_NULL(desc))
+				continue;
+
+			found_cycles = le32_to_cpu(desc->erase_cycles);
+
+			SSDFS_DBG("index %d, found_cycles %u\n",
+				  i, found_cycles);
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find unused PEB: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+enum {
+	SSDFS_MAPTBL_MAPPING_PEB,
+	SSDFS_MAPTBL_MIGRATING_PEB,
+	SSDFS_MAPTBL_PEB_PURPOSE_MAX
+};
+
+/*
+ * ssdfs_maptbl_select_unused_peb() - select unused PEB
+ * @fdesc: fragment descriptor
+ * @hdr: PEB table fragment's header
+ * @pebs_per_volume: number of PEBs per whole volume
+ * @peb_goal: PEB purpose
+ *
+ * This method tries to find unused PEB and to set this
+ * PEB as used.
+ *
+ * RETURN:
+ * [success] - item index.
+ * [failure] - U16_MAX.
+ */
+static
+u16 ssdfs_maptbl_select_unused_peb(struct ssdfs_maptbl_fragment_desc *fdesc,
+				   struct ssdfs_peb_table_fragment_header *hdr,
+				   u64 pebs_per_volume,
+				   int peb_goal)
+{
+	unsigned long *bmap;
+	u64 start_peb;
+	u16 pebs_count;
+	u16 unused_pebs;
+	u16 reserved_pebs;
+	u16 last_selected_peb;
+	unsigned long used_pebs;
+	unsigned long start = 0;
+	unsigned long found = ULONG_MAX;
+	u32 erase_cycles = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !fdesc);
+	BUG_ON(peb_goal >= SSDFS_MAPTBL_PEB_PURPOSE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	start_peb = le64_to_cpu(hdr->start_peb);
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+	last_selected_peb = le16_to_cpu(hdr->last_selected_peb);
+	used_pebs = bitmap_weight(bmap, pebs_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hdr %p, start_peb %llu, pebs_count %u, "
+		  "last_selected_peb %u, "
+		  "reserved_pebs %u, used_pebs %lu\n",
+		  hdr, start_peb, pebs_count, last_selected_peb,
+		  reserved_pebs, used_pebs);
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u, "
+		  "pre_erase_pebs %u, recovering_pebs %u\n",
+		  fdesc->mapped_lebs, fdesc->migrating_lebs,
+		  fdesc->pre_erase_pebs, fdesc->recovering_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((start_peb + pebs_count) > pebs_per_volume) {
+		/* correct value */
+		pebs_count = (u16)(pebs_per_volume - start_peb);
+	}
+
+	if (used_pebs > pebs_count) {
+		SSDFS_ERR("used_pebs %lu > pebs_count %u\n",
+			  used_pebs, pebs_count);
+		return -ERANGE;
+	}
+
+	unused_pebs = pebs_count - used_pebs;
+
+	switch (peb_goal) {
+	case SSDFS_MAPTBL_MAPPING_PEB:
+		if (unused_pebs <= reserved_pebs) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unused_pebs %u, reserved_pebs %u\n",
+				  unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return U16_MAX;
+		}
+		break;
+
+	case SSDFS_MAPTBL_MIGRATING_PEB:
+		if (reserved_pebs == 0 && unused_pebs == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("reserved_pebs %u, unused_pebs %u\n",
+				  reserved_pebs, unused_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return U16_MAX;
+		}
+		break;
+
+	default:
+		BUG();
+	};
+
+	if ((last_selected_peb + 1) >= pebs_count)
+		last_selected_peb = 0;
+
+	err = ssdfs_maptbl_find_unused_peb(hdr, last_selected_peb,
+					   pebs_count, used_pebs,
+					   &found, &erase_cycles);
+	if (err == -ENODATA) {
+		SSDFS_DBG("unable to find the unused peb\n");
+		return U16_MAX;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find unused peb: "
+			  "start %lu, pebs_count %u, err %d\n",
+			  start, pebs_count, err);
+		return U16_MAX;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(found >= U16_MAX);
+	BUG_ON(erase_cycles >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bitmap_set(bmap, found, 1);
+	hdr->last_selected_peb = cpu_to_le16((u16)found);
+
+	switch (peb_goal) {
+	case SSDFS_MAPTBL_MAPPING_PEB:
+		/* do nothing */
+		break;
+
+	case SSDFS_MAPTBL_MIGRATING_PEB:
+		if (reserved_pebs > 0) {
+			le16_add_cpu(&hdr->reserved_pebs, -1);
+			fdesc->reserved_pebs--;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("hdr->reserved_pebs %u\n",
+				  le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	default:
+		BUG();
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found %lu, erase_cycles %u\n",
+		  found, erase_cycles);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)found;
+}
+
+/*
+ * __ssdfs_maptbl_map_leb2peb() - map LEB into PEB
+ * @fdesc: fragment descriptor
+ * @hdr: PEB table fragment's header
+ * @leb_id: LEB ID number
+ * @page_index: page index in the fragment
+ * @peb_type: type of the PEB
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method sets mapping association between LEB and PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - unable to select unused PEB.
+ */
+static
+int __ssdfs_maptbl_map_leb2peb(struct ssdfs_peb_mapping_table *tbl,
+				struct ssdfs_maptbl_fragment_desc *fdesc,
+				struct ssdfs_peb_table_fragment_header *hdr,
+				u64 leb_id, pgoff_t page_index, u8 peb_type,
+				struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct ssdfs_peb_descriptor *peb_desc;
+	struct ssdfs_leb_table_fragment_header *lebtbl_hdr;
+	struct ssdfs_leb_descriptor *leb_desc;
+	struct ssdfs_maptbl_peb_descriptor *ptr = NULL;
+	u16 item_index;
+	u16 peb_index = 0;
+	pgoff_t lebtbl_page;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !hdr || !pebr);
+
+	if (peb_type >= SSDFS_MAPTBL_PEB_TYPE_MAX) {
+		SSDFS_ERR("invalid peb_type %#x\n",
+			  peb_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("fdesc %p, hdr %p, leb_id %llu, peb_type %#x, pebr %p\n",
+		  fdesc, hdr, leb_id, peb_type, pebr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = ssdfs_maptbl_select_unused_peb(fdesc, hdr,
+						    tbl->pebs_count,
+						    SSDFS_MAPTBL_MAPPING_PEB);
+	if (item_index == U16_MAX) {
+		SSDFS_DBG("unable to select unused peb\n");
+		return -ENOENT;
+	}
+
+	memset(pebr, 0xFF, sizeof(struct ssdfs_maptbl_peb_relation));
+
+	peb_desc = GET_PEB_DESCRIPTOR(hdr, item_index);
+	if (IS_ERR_OR_NULL(peb_desc)) {
+		err = IS_ERR(peb_desc) ? PTR_ERR(peb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "index %u, err %d\n",
+			  item_index, err);
+		return err;
+	}
+
+	peb_desc->type = peb_type;
+	peb_desc->state = SSDFS_MAPTBL_CLEAN_PEB_STATE;
+
+	lebtbl_page = LEBTBL_PAGE_INDEX(fdesc, leb_id);
+	if (lebtbl_page == ULONG_MAX) {
+		SSDFS_ERR("fail to define page_index: "
+			  "leb_id %llu\n",
+			  leb_id);
+		return -ERANGE;
+	}
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, lebtbl_page);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  lebtbl_page);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	leb_desc = GET_LEB_DESCRIPTOR(kaddr, leb_id);
+	if (IS_ERR_OR_NULL(leb_desc)) {
+		err = IS_ERR(leb_desc) ? PTR_ERR(leb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get leb_descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_page_processing;
+	}
+
+	peb_index = DEFINE_PEB_INDEX_IN_FRAGMENT(fdesc, page_index, item_index);
+	if (peb_index == U16_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define peb index\n");
+		goto finish_page_processing;
+	}
+
+	leb_desc->physical_index = cpu_to_le16(peb_index);
+	leb_desc->relation_index = U16_MAX;
+
+	lebtbl_hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+	le16_add_cpu(&lebtbl_hdr->mapped_lebs, 1);
+
+	ptr = &pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX];
+	ptr->peb_id = le64_to_cpu(hdr->start_peb) + item_index;
+	ptr->shared_peb_index = peb_desc->shared_peb_index;
+	ptr->erase_cycles = le32_to_cpu(peb_desc->erase_cycles);
+	ptr->type = peb_desc->type;
+	ptr->state = peb_desc->state;
+	ptr->flags = peb_desc->flags;
+
+finish_page_processing:
+	kunmap_local(kaddr);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("leb_id %llu, item_index %u, peb_index %u, "
+			  "start_peb %llu, peb_id %llu\n",
+			  leb_id, item_index, peb_index,
+			  le64_to_cpu(hdr->start_peb),
+			  ptr->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		err = ssdfs_page_array_set_page_dirty(&fdesc->array,
+						      lebtbl_page);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu dirty: err %d\n",
+				  lebtbl_page, err);
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
+
+static
+int ssdfs_maptbl_reserve_free_pages(struct ssdfs_fs_info *fsi)
+{
+	u64 free_pebs = 0;
+	u64 free_pages = 0;
+	u64 reserved_pages = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&fsi->volume_state_lock);
+	free_pages = fsi->free_pages;
+	free_pebs = div64_u64(free_pages, fsi->pages_per_peb);
+	if (free_pebs >= 1) {
+		reserved_pages = fsi->pages_per_peb;
+		if (fsi->free_pages >= reserved_pages) {
+			fsi->free_pages -= reserved_pages;
+			free_pages = fsi->free_pages;
+		} else
+			err = -ERANGE;
+	} else
+		err = -ENOSPC;
+	spin_unlock(&fsi->volume_state_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve PEB: "
+			  "free_pages %llu, err %d\n",
+			  free_pages, err);
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free_pages %llu, reserved_pages %llu\n",
+			  free_pages, reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+static
+void ssdfs_maptbl_free_reserved_pages(struct ssdfs_fs_info *fsi)
+{
+	u64 free_pages = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&fsi->volume_state_lock);
+	fsi->free_pages += fsi->pages_per_peb;
+	free_pages = fsi->free_pages;
+	spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_pages %llu\n",
+		  free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return;
+}
+
+static inline
+bool can_peb_be_reserved(struct ssdfs_fs_info *fsi,
+			 struct ssdfs_peb_table_fragment_header *hdr)
+{
+	unsigned long *bmap;
+	u16 pebs_count;
+	u16 used_pebs;
+	u16 unused_pebs;
+	u16 reserved_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	used_pebs = bitmap_weight(bmap, pebs_count);
+	unused_pebs = pebs_count - used_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebs_count %u, used_pebs %u, "
+		  "unused_pebs %u, reserved_pebs %u\n",
+		  pebs_count, used_pebs,
+		  unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unused_pebs == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to reserve PEB: "
+			  "pebs_count %u, used_pebs %u, "
+			  "unused_pebs %u, reserved_pebs %u\n",
+			  pebs_count, used_pebs,
+			  unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	} else if ((reserved_pebs + 1) >= unused_pebs) {
+		/*
+		 * Mapping operation takes one PEB +
+		 * reservation needs another one.
+		 */
+		if (reserved_pebs > unused_pebs) {
+			SSDFS_WARN("fail to reserve PEB: "
+				  "pebs_count %u, used_pebs %u, "
+				  "unused_pebs %u, reserved_pebs %u\n",
+				  pebs_count, used_pebs,
+				  unused_pebs, reserved_pebs);
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to reserve PEB: "
+				  "pebs_count %u, used_pebs %u, "
+				  "unused_pebs %u, reserved_pebs %u\n",
+				  pebs_count, used_pebs,
+				  unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		return false;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PEB can be reserved\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return true;
+}
+
+/*
+ * __ssdfs_maptbl_try_map_leb2peb() - try to map LEB into PEB
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @peb_type: type of the PEB
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method tries to set association between LEB identification
+ * number and PEB identification number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EACCES     - PEB stripe is under recovering.
+ * %-ENOENT     - provided @leb_id cannot be mapped.
+ */
+static
+int __ssdfs_maptbl_try_map_leb2peb(struct ssdfs_peb_mapping_table *tbl,
+				   struct ssdfs_maptbl_fragment_desc *fdesc,
+				   u64 leb_id, u64 start_peb_id, u8 peb_type,
+				   struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct ssdfs_fs_info *fsi;
+	pgoff_t page_index;
+	struct page *page;
+	void *kaddr;
+	struct ssdfs_peb_table_fragment_header *hdr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc || !pebr);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	if (peb_type >= SSDFS_MAPTBL_PEB_TYPE_MAX) {
+		SSDFS_ERR("invalid peb_type %#x\n",
+			  peb_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("tbl %p, fdesc %p, leb_id %llu, "
+		  "start_peb_id %llu, peb_type %#x\n",
+		  tbl, fdesc, leb_id, start_peb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tbl->fsi;
+
+	page_index = ssdfs_maptbl_define_pebtbl_page(tbl, fdesc,
+						     start_peb_id,
+						     U16_MAX);
+	if (page_index == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define PEB table's page_index: "
+			  "start_peb_id %llu\n", start_peb_id);
+		goto finish_fragment_change;
+	}
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		goto finish_fragment_change;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	if (is_pebtbl_stripe_recovering(hdr)) {
+		err = -EACCES;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to map leb_id %llu: "
+			  "stripe %u is under recovering\n",
+			  leb_id,
+			  le16_to_cpu(hdr->stripe_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_page_processing;
+	}
+
+	if (!can_be_mapped_leb2peb(tbl, fdesc, leb_id)) {
+		err = ssdfs_maptbl_decrease_reserved_pebs(fsi, fdesc, hdr);
+		if (err == -ENOSPC) {
+			err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to decrease reserved_pebs %u\n",
+				  le16_to_cpu(hdr->reserved_pebs));
+			SSDFS_DBG("unable to map leb_id %llu: "
+				  "value is out of threshold\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_page_processing;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to decrease reserved_pebs: err %d\n",
+				  err);
+			goto finish_page_processing;
+		}
+	}
+
+	if (!has_fragment_unused_pebs(hdr)) {
+		err = ssdfs_maptbl_decrease_reserved_pebs(fsi, fdesc, hdr);
+		if (err == -ENOSPC) {
+			err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to decrease reserved_pebs %u\n",
+				  le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_page_processing;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to decrease reserved_pebs: err %d\n",
+				  err);
+			goto finish_page_processing;
+		}
+	}
+
+	if (!has_fragment_unused_pebs(hdr)) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to map leb_id %llu\n", leb_id);
+		goto finish_page_processing;
+	}
+
+	if (need_try2reserve_peb(fsi)) {
+		/*
+		 * Reservation could be not aligned with
+		 * already mapped PEBs. Simply, try to align
+		 * the number of reserved PEBs.
+		 */
+		err = ssdfs_maptbl_increase_reserved_pebs(fsi, fdesc, hdr);
+		if (err == -ENOSPC) {
+			err = 0;
+			SSDFS_DBG("no space to reserve PEBs\n");
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to increase reserved PEBs: "
+				  "err %d\n", err);
+			goto finish_page_processing;
+		}
+
+		if (can_peb_be_reserved(fsi, hdr)) {
+			err = ssdfs_maptbl_reserve_free_pages(fsi);
+			if (err == -ENOSPC) {
+				err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to reserve PEB: "
+					  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_page_processing;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to reserve PEB: "
+					  "err %d\n", err);
+				goto finish_page_processing;
+			}
+		} else {
+			err = -ENOENT;
+			SSDFS_DBG("unable to reserve PEB\n");
+			goto finish_page_processing;
+		}
+	}
+
+	err = __ssdfs_maptbl_map_leb2peb(tbl, fdesc, hdr, leb_id,
+					 page_index, peb_type, pebr);
+	if (err == -ENOENT) {
+		if (need_try2reserve_peb(fsi)) {
+			ssdfs_maptbl_free_reserved_pages(fsi);
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to map: leb_id %llu, page_index %lu\n",
+			  leb_id, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		goto finish_page_processing;
+	} else if (unlikely(err)) {
+		if (need_try2reserve_peb(fsi)) {
+			ssdfs_maptbl_free_reserved_pages(fsi);
+		}
+
+		SSDFS_ERR("fail to map leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_page_processing;
+	}
+
+	fdesc->mapped_lebs++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u\n",
+		  fdesc->mapped_lebs, fdesc->migrating_lebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_try2reserve_peb(fsi)) {
+		le16_add_cpu(&hdr->reserved_pebs, 1);
+		fdesc->reserved_pebs++;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_pebs %u\n",
+		  le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_page_processing:
+	flush_dcache_page(page);
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
+finish_fragment_change:
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_try_map_leb2peb() - try to map LEB into PEB
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @peb_type: type of the PEB
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method tries to set association between LEB identification
+ * number and PEB identification number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EACCES     - PEB stripe is under recovering.
+ * %-ENOENT     - provided @leb_id cannot be mapped.
+ */
+static
+int ssdfs_maptbl_try_map_leb2peb(struct ssdfs_peb_mapping_table *tbl,
+				 struct ssdfs_maptbl_fragment_desc *fdesc,
+				 u64 leb_id, u8 peb_type,
+				 struct ssdfs_maptbl_peb_relation *pebr)
+{
+	u64 start_peb;
+	u64 end_peb;
+	int err = -ENOENT;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc || !pebr);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	if (peb_type >= SSDFS_MAPTBL_PEB_TYPE_MAX) {
+		SSDFS_ERR("invalid peb_type %#x\n",
+			  peb_type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("tbl %p, fdesc %p, leb_id %llu, peb_type %#x\n",
+		  tbl, fdesc, leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_peb = fdesc->start_leb;
+	end_peb = fdesc->start_leb + fdesc->lebs_count;
+
+	while (start_peb < end_peb) {
+		err = __ssdfs_maptbl_try_map_leb2peb(tbl, fdesc,
+						     leb_id, start_peb,
+						     peb_type, pebr);
+		if (err == -ENOENT) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to map: "
+				  "leb_id %llu, start_peb %llu\n",
+				  leb_id, start_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+			start_peb += fdesc->pebs_per_page;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to map: leb_id %llu, err %d\n",
+				  leb_id, err);
+			return err;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("leb_id %llu has been mapped\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("unable to map: leb_id %llu\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENOENT;
+}
+
+/*
+ * ssdfs_maptbl_map_leb2peb() - map LEB into PEB
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: type of the PEB
+ * @pebr: description of PEBs relation [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to set association between LEB identification
+ * number and PEB identification number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EACCES     - PEB stripe is under recovering.
+ * %-ENOENT     - provided @leb_id cannot be mapped.
+ * %-EEXIST     - LEB is mapped yet.
+ */
+int ssdfs_maptbl_map_leb2peb(struct ssdfs_fs_info *fsi,
+			     u64 leb_id, u8 peb_type,
+			     struct ssdfs_maptbl_peb_relation *pebr,
+			     struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_cache *cache;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebr || !end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, leb_id %llu, pebr %p, init_end %p\n",
+		  fsi, leb_id, pebr, end);
+#else
+	SSDFS_DBG("fsi %p, leb_id %llu, pebr %p, init_end %p\n",
+		  fsi, leb_id, pebr, end);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	*end = NULL;
+	memset(pebr, 0xFF, sizeof(struct ssdfs_maptbl_peb_relation));
+
+	tbl = fsi->maptbl;
+	cache = &tbl->fsi->maptbl_cache;
+
+	if (!tbl) {
+		SSDFS_CRIT("mapping table is absent\n");
+		return -ERANGE;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	down_read(&tbl->tbl_lock);
+
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_mapping;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n", leb_id);
+		goto finish_mapping;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_mapping;
+	}
+
+	down_write(&fdesc->lock);
+
+	err = ssdfs_maptbl_get_leb_descriptor(fdesc, leb_id, &leb_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get leb descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, pebr);
+	if (err != -ENODATA) {
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_fragment_change;
+		} else {
+			err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("leb_id %llu is mapped yet\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_fragment_change;
+		}
+	} else
+		err = 0;
+
+	err = ssdfs_maptbl_try_map_leb2peb(tbl, fdesc, leb_id, peb_type, pebr);
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to map: leb_id %llu, peb_type %#x\n",
+			  leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_fragment_change;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to map: leb_id %llu, peb_type %#x, err %d\n",
+			  leb_id, peb_type, err);
+		goto finish_fragment_change;
+	}
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+finish_mapping:
+	up_read(&tbl->tbl_lock);
+
+	if (err == -EAGAIN && should_cache_peb_info(peb_type)) {
+		err = ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id,
+							 pebr);
+		if (err == -ENODATA) {
+			err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to convert LEB to PEB: "
+				  "leb_id %llu\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+		} else {
+			err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("leb_id %llu is mapped yet\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	} else if (!err && should_cache_peb_info(peb_type)) {
+		err = ssdfs_maptbl_cache_map_leb2peb(cache, leb_id, pebr,
+						SSDFS_PEB_STATE_CONSISTENT);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to cache LEB/PEB mapping: "
+				  "leb_id %llu, peb_id %llu, err %d\n",
+				  leb_id,
+				  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+				  err);
+			err = -EFAULT;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("leb_id %llu, pebs_count %llu\n",
+		  leb_id, tbl->pebs_count);
+	SSDFS_ERR("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("leb_id %llu, pebs_count %llu\n",
+		  leb_id, tbl->pebs_count);
+	SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!err) {
+		u64 peb_id = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+		loff_t offset = peb_id * fsi->erasesize;
+
+		err = fsi->devops->open_zone(fsi->sb, offset);
+		if (err == -EOPNOTSUPP && !fsi->is_zns_device) {
+			/* ignore error */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to open zone: "
+				  "offset %llu, err %d\n",
+				  offset, err);
+			return err;
+		}
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_find_pebtbl_page() - find next page of PEB table
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @cur_index: current page index
+ * @start_index: page index in the start of searching
+ *
+ * This method tries to find a next page of PEB table.
+ */
+static
+pgoff_t ssdfs_maptbl_find_pebtbl_page(struct ssdfs_peb_mapping_table *tbl,
+				      struct ssdfs_maptbl_fragment_desc *fdesc,
+				      pgoff_t cur_index,
+				      pgoff_t start_index)
+{
+	pgoff_t index;
+	u32 pebtbl_pages, fragment_pages;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("maptbl %p, fdesc %p, cur_index %lu, start_index %lu\n",
+		  tbl, fdesc, cur_index, start_index);
+
+	BUG_ON(!tbl || !fdesc);
+	BUG_ON((tbl->stripes_per_fragment * fdesc->stripe_pages) < cur_index);
+	BUG_ON((tbl->stripes_per_fragment * fdesc->stripe_pages) < start_index);
+	BUG_ON(cur_index < fdesc->lebtbl_pages);
+	BUG_ON(start_index < fdesc->lebtbl_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebtbl_pages = tbl->stripes_per_fragment * fdesc->stripe_pages;
+	fragment_pages = (u32)fdesc->lebtbl_pages + pebtbl_pages;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(cur_index >= fragment_pages);
+	BUG_ON(start_index >= fragment_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	index = cur_index + fdesc->stripe_pages;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebtbl_pages %u, fragment_pages %u, "
+		  "fdesc->stripe_pages %u, cur_index %lu, "
+		  "index %lu\n",
+		  pebtbl_pages, fragment_pages,
+		  fdesc->stripe_pages, cur_index,
+		  index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (index >= fragment_pages)
+		index = ULONG_MAX;
+
+	return index;
+}
+
+/*
+ * ssdfs_maptbl_try_decrease_reserved_pebs() - try decrease reserved PEBs
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ *
+ * This method tries to decrease number of reserved PEBs.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EACCES     - fragment is recovering.
+ * %-ENOENT     - unable to decrease the number of reserved PEBs.
+ * %-ERANGE     - internal error.
+ */
+static int
+ssdfs_maptbl_try_decrease_reserved_pebs(struct ssdfs_peb_mapping_table *tbl,
+				    struct ssdfs_maptbl_fragment_desc *fdesc)
+{
+	struct ssdfs_fs_info *fsi;
+	pgoff_t start_page;
+	pgoff_t page_index;
+	struct page *page;
+	void *kaddr;
+	struct ssdfs_peb_table_fragment_header *hdr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !fdesc);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("start_leb %llu, end_leb %llu\n",
+		  fdesc->start_leb,
+		  fdesc->start_leb + fdesc->lebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tbl->fsi;
+
+	start_page = ssdfs_maptbl_define_pebtbl_page(tbl, fdesc,
+						     fdesc->start_leb,
+						     U16_MAX);
+	if (start_page == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define PEB table's page_index: "
+			  "start_peb_id %llu\n", fdesc->start_leb);
+		goto finish_fragment_change;
+	}
+
+	page_index = start_page;
+
+try_next_page:
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: page_index %lu\n",
+			  page_index);
+		goto finish_fragment_change;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	if (is_pebtbl_stripe_recovering(hdr)) {
+		err = -EACCES;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to decrease reserved_pebs: "
+			  "stripe %u is under recovering\n",
+			  le16_to_cpu(hdr->stripe_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_page_processing;
+	}
+
+	err = ssdfs_maptbl_decrease_reserved_pebs(fsi, fdesc, hdr);
+	if (err == -ENOSPC) {
+		err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to decrease reserved_pebs %u\n",
+			  le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_page_processing;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to decrease reserved_pebs: err %d\n",
+			  err);
+		goto finish_page_processing;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u, "
+		  "reserved_pebs %u, pre_erase_pebs %u, "
+		  "recovering_pebs %u\n",
+		  fdesc->mapped_lebs, fdesc->migrating_lebs,
+		  fdesc->reserved_pebs, fdesc->pre_erase_pebs,
+		  fdesc->recovering_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_page_processing:
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+	if (err == -EACCES || err == -ENOENT) {
+		page_index = ssdfs_maptbl_find_pebtbl_page(tbl, fdesc,
+							   page_index,
+							   start_page);
+		if (page_index == ULONG_MAX)
+			goto finish_fragment_change;
+		else
+			goto try_next_page;
+	}
+
+finish_fragment_change:
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_recommend_search_range() - recommend search range
+ * @fsi: file system info object
+ * @start_leb: recommended start LEB ID [in|out]
+ * @end_leb: recommended end LEB ID [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to find not exhausted fragment and
+ * to share the starting/ending LEB ID of this fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - all fragments have been exhausted.
+ */
+int ssdfs_maptbl_recommend_search_range(struct ssdfs_fs_info *fsi,
+					u64 *start_leb,
+					u64 *end_leb,
+					struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	u64 start_search_leb;
+	u64 found_start_leb = 0;
+	u64 found_end_leb = 0;
+	int start_index;
+	bool is_found = false;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !start_leb || !end_leb || !end);
+
+	SSDFS_DBG("fsi %p, start_leb %llu, end_leb %p, init_end %p\n",
+		  fsi, *start_leb, end_leb, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*start_leb >= fsi->nsegs) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_leb %llu >= nsegs %llu",
+			  *start_leb, fsi->nsegs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		*start_leb = U64_MAX;
+		*end_leb = U64_MAX;
+		return -ENOENT;
+	}
+
+	start_search_leb = *start_leb;
+
+	*start_leb = U64_MAX;
+	*end_leb = U64_MAX;
+	*end = NULL;
+
+	tbl = fsi->maptbl;
+	if (!tbl) {
+		SSDFS_CRIT("mapping table is absent\n");
+		return -ERANGE;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	err = -ENOENT;
+
+	down_read(&tbl->tbl_lock);
+
+	start_index = FRAGMENT_INDEX(tbl, start_search_leb);
+
+	for (i = start_index; i < tbl->fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		*end = &fdesc->init_end;
+
+		state = atomic_read(&fdesc->state);
+		if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+			err = -EFAULT;
+			SSDFS_ERR("fragment is corrupted: index %d\n", i);
+			goto finish_check;
+		} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+			err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment is under initialization: "
+				  "index %d\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_check;
+		}
+
+		down_read(&fdesc->lock);
+
+		found_start_leb = fdesc->start_leb;
+		found_end_leb = fdesc->start_leb + fdesc->lebs_count;
+		is_found = can_be_mapped_leb2peb(tbl, fdesc, found_start_leb);
+
+		if (!is_found) {
+			err = ssdfs_maptbl_try_decrease_reserved_pebs(tbl,
+								      fdesc);
+			if (err == -ENOENT) {
+				err = 0;
+				SSDFS_DBG("unable to decrease reserved pebs\n");
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to decrease reserved pebs: "
+					  "err %d\n", err);
+				goto finish_fragment_processing;
+			}
+
+			is_found = can_be_mapped_leb2peb(tbl, fdesc,
+							 found_start_leb);
+		}
+
+finish_fragment_processing:
+		up_read(&fdesc->lock);
+
+		*start_leb = max_t(u64, start_search_leb, found_start_leb);
+		*end_leb = found_end_leb;
+
+		if (is_found) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("recommend: start_leb %llu, end_leb %llu\n",
+				  *start_leb, *end_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		} else {
+			err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment %d (leb_id %llu) is exhausted\n",
+				  i, found_start_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+finish_check:
+	up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished: start_leb %llu, end_leb %llu, err %d\n",
+		  *start_leb, *end_leb, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
-- 
2.34.1

