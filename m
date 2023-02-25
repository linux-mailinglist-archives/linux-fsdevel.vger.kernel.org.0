Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B756A2653
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBYBTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBYBRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2B166C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:07 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q15so780946oiw.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D2uDTuwixRNZTXnArg1dsYJIUQZ31YJXhBxaUJkagE=;
        b=FAVGwcOhOnrwvhJTytXYcrrd8yip5TSuXb2d4okBnuw278O2kNVEyFU272EvkzII4Q
         e3aziSA7gUIE5Vc2s5c4aB29quV6hIgcqtF4CjudMe6/j6oZull7eDN7PgECL2Ji9to6
         FyQZfT+T/BGwZpICctfwcy+G9i7w+eA29dld4GPz5FJZM1l8iV9smUjWVydHdD//HdZD
         SaQgniaI/ZGw+no8APe/yL4Jd5ZNVY4ADrgNO7lDZuDp/t2gvra11tffVI2LSIavW0JI
         ZPfVV82PAqinIG0/y77b8MyqhcGwjvNcuAkaLaIsibC/0BTrChYzvSAKoQ4ySs7i/oJB
         sHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0D2uDTuwixRNZTXnArg1dsYJIUQZ31YJXhBxaUJkagE=;
        b=qBCAdQwjABgRNMeQl1O1V8w0KUF0DNVF520rvkczoJAxqTov0AZRo/Z6aN2dEGz1eH
         /yWqFIVCaYWi5Lj5kiXkjzQh0zC1u38knmKDH0BZogMuopg9z7CApCEj+ceJChPlPjcZ
         qhy/sz8InmluR2eHxqYQ0C48cIZG1TmvbfUP3cHBFttCh89hfk235mFxQHw0qQ67T597
         rnNuWJtWYMCTA6onn54pBpEFUUPzJwEFapJ9nXIHGB3Nx8btbwvZU1OoMsZGtpZ7n09E
         rgudxoSOnevLtF2NnSy33mtItxLBL5c9OzSucJNCVhgGxCIy+WDjZzXJqQsBmBQekW/t
         xv5g==
X-Gm-Message-State: AO0yUKVPHJV6hvMTUQD7ggpBtQDDvM5fWcaVbU8EADaEYBuXDRN4G/ED
        GmELfJsRPVCkEAzyblmbD8nauJmeEpxmvWC2
X-Google-Smtp-Source: AK7set+taS0nox9IBDv5i55KMrRUlAeXKmHaqMvzgWQ5Vn8Me0GGgjWeebgN50A940iTlNtn8yL0dg==
X-Received: by 2002:a05:6808:6da:b0:37e:acc5:79 with SMTP id m26-20020a05680806da00b0037eacc50079mr4036392oih.4.1677287826053;
        Fri, 24 Feb 2023 17:17:06 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:05 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 43/76] ssdfs: introduce PEB mapping table cache
Date:   Fri, 24 Feb 2023 17:08:54 -0800
Message-Id: <20230225010927.813929-44-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Physical" Erase Block (PEB) mapping table is enhanced by special
cache is stored in the payload of superblock segment’s log.
Generally speaking, the cache stores the copy of records of
PEBs’ state. The goal of PEB mapping table’s cache is to resolve
the case when a PEB’s descriptor is associated with a LEB of
PEB mapping table itself, for example. If unmount operation
triggers the flush of PEB mapping table then there are the cases
when the PEB mapping table could be modified during the flush
operation’s activity. As a result, actual PEB’s state is stored
only into PEB mapping table’s cache. Such record is marked as
inconsistent and the inconsistency has to be resolved during
the next mount operation by means of storing the actual PEB’s state
into the PEB mapping table by specialized thread. Moreover, the cache
plays another very important role. Namely, PEB mapping table’s cache
is used for conversion the LEB ID into PEB ID for the case of
basic metadata structures (PEB mapping table, segment bitmap,
for example) before the finishing of PEB mapping table initialization
during the mount operation.

PEB mapping table’s cache starts from the header that precedes
to: (1) LEB ID / PEB ID pairs, (2) PEB state records. The pairs’ area
associates the LEB IDs with PEB IDs. Additionally, PEB state records’ area
contains information about the last actual state of PEBs for every
record in the pairs’ area. It makes sense to point out that the most
important fields in PEB state area are: (1) consistency, (2) PEB state,
and (3) PEB flags. Generally speaking, the consistency field simply
shows that a record in the cache and mapping table is identical or not.
If some record in the cache has marked as inconsistent then it means
that the PEB mapping table has to be modified with the goal to keep
the actual value of the cache. As a result, finally, the value in the table
and the cache will be consistent.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_mapping_table.c       | 1154 +++++++++++++++++++++
 fs/ssdfs/peb_mapping_table_cache.c | 1497 ++++++++++++++++++++++++++++
 fs/ssdfs/peb_mapping_table_cache.h |  119 +++
 3 files changed, 2770 insertions(+)
 create mode 100644 fs/ssdfs/peb_mapping_table_cache.c
 create mode 100644 fs/ssdfs/peb_mapping_table_cache.h

diff --git a/fs/ssdfs/peb_mapping_table.c b/fs/ssdfs/peb_mapping_table.c
index 738de2d62c9f..aabaa1dc8a5d 100644
--- a/fs/ssdfs/peb_mapping_table.c
+++ b/fs/ssdfs/peb_mapping_table.c
@@ -11550,3 +11550,1157 @@ ssdfs_maptbl_clear_shared_destination_peb(struct ssdfs_peb_mapping_table *tbl,
 
 	return err;
 }
+
+/*
+ * ssdfs_maptbl_break_external_peb_ptr() - forget PEB as external pointer
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ * @peb_type: PEB type
+ * @peb_state: pointer on PEB state value [out]
+ *
+ * This method tries to forget index of destination PEB and to clear
+ * SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static int
+ssdfs_maptbl_break_external_peb_ptr(struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u16 index, u8 peb_type,
+				    u8 *peb_state)
+{
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !peb_state);
+
+	SSDFS_DBG("fdesc %p, index %u\n",
+		  fdesc, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
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
+	if (peb_type != ptr->type) {
+		err = -ERANGE;
+		SSDFS_ERR("peb_type %#x != ptr->type %#x\n",
+			  peb_type, ptr->type);
+		goto finish_page_processing;
+	}
+
+	if (ptr->flags & SSDFS_MAPTBL_SHARED_DESTINATION_PEB) {
+		err = -ERANGE;
+		SSDFS_ERR("corrupted PEB desriptor\n");
+		goto finish_page_processing;
+	}
+
+	if (!(ptr->flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR))
+		SSDFS_WARN("PEB hasn't indirect relation\n");
+
+	switch (ptr->state) {
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+		ptr->state = SSDFS_MAPTBL_USED_PEB_STATE;
+		*peb_state = SSDFS_MAPTBL_USED_PEB_STATE;
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+		ptr->state = SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+		*peb_state = SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		ptr->state = SSDFS_MAPTBL_DIRTY_PEB_STATE;
+		*peb_state = SSDFS_MAPTBL_DIRTY_PEB_STATE;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  ptr->state);
+		goto finish_page_processing;
+	}
+
+	ptr->shared_peb_index = U8_MAX;
+	ptr->flags &= ~SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR;
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
+ * __ssdfs_maptbl_break_indirect_relation() - forget destination PEB as shared
+ * @tbl: pointer on mapping table object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to forget index of destination PEB and to clear
+ * SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_maptbl_break_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					   u64 leb_id, u8 peb_type,
+					   struct completion **end)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 physical_index;
+	u8 peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !end);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, peb_type %#x\n",
+		  tbl, leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		return err;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n", leb_id);
+		return err;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
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
+	if (!__is_mapped_leb2peb(&leb_desc)) {
+		err = -ERANGE;
+		SSDFS_ERR("leb %llu doesn't be mapped yet\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	if (is_leb_migrating(&leb_desc)) {
+		err = -ERANGE;
+		SSDFS_ERR("leb %llu has direct relation\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+
+	if (physical_index == U16_MAX) {
+		err = -ENODATA;
+		SSDFS_DBG("unitialized leb descriptor\n");
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_break_external_peb_ptr(fdesc, physical_index,
+						  peb_type, &peb_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to break external PEB pointer: "
+			  "physical_index %u, err %d\n",
+			  physical_index, err);
+		goto finish_fragment_change;
+	}
+
+	if (peb_state == SSDFS_MAPTBL_DIRTY_PEB_STATE) {
+		err = ssdfs_maptbl_set_pre_erase_state(fdesc, physical_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into pre-erase state: "
+				  "index %u, err %d\n",
+				  physical_index, err);
+			goto finish_fragment_change;
+		}
+
+		fdesc->pre_erase_pebs++;
+		atomic_inc(&tbl->pre_erase_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fdesc->pre_erase_pebs %u, tbl->pre_erase_pebs %d\n",
+			  fdesc->pre_erase_pebs,
+			  atomic_read(&tbl->pre_erase_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		wake_up(&tbl->wait_queue);
+	}
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_break_indirect_relation() - break PEBs indirect relation
+ * @tbl: pointer on mapping table object
+ * @leb_id: source LEB ID number
+ * @peb_type: PEB type
+ * @dst_leb_id: destination LEB ID number
+ * @dst_peb_refs: destination PEB reference counter
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to clear SSDFS_MAPTBL_SHARED_DESTINATION_PEB flag
+ * in destination PEB. Then it tries to forget index of destination PEB
+ * and to clear SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_break_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					  u64 leb_id, u8 peb_type,
+					  u64 dst_leb_id, int dst_peb_refs,
+					  struct completion **end)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !end);
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, "
+		  "peb_type %#x, dst_leb_id %llu, "
+		  "dst_peb_refs %d\n",
+		  tbl, leb_id, peb_type,
+		  dst_leb_id, dst_peb_refs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tbl->fsi;
+	*end = NULL;
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	if (dst_peb_refs <= 0) {
+		SSDFS_ERR("invalid dst_peb_refs\n");
+		return -ERANGE;
+	}
+
+	if (should_cache_peb_info(peb_type)) {
+		struct ssdfs_maptbl_peb_relation prev_pebr;
+
+		/* resolve potential inconsistency */
+		err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id, peb_type,
+						   &prev_pebr, end);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment is under initialization: "
+				  "leb_id %llu\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to resolve inconsistency: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			return err;
+		}
+	}
+
+	down_read(&tbl->tbl_lock);
+
+	if (dst_peb_refs > 1)
+		goto break_indirect_relation;
+
+	err = ssdfs_maptbl_clear_shared_destination_peb(tbl, dst_leb_id,
+							peb_type, end);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  dst_leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_break_indirect_relation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to clear shared destination PEB: "
+			  "dst_leb_id %llu, err %u\n",
+			  dst_leb_id, err);
+		goto finish_break_indirect_relation;
+	}
+
+break_indirect_relation:
+	err = __ssdfs_maptbl_break_indirect_relation(tbl, leb_id,
+						     peb_type, end);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_break_indirect_relation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to break indirect relation: "
+			  "leb_id %llu, err %u\n",
+			  leb_id, err);
+		goto finish_break_indirect_relation;
+	}
+
+finish_break_indirect_relation:
+	up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_break_zns_external_peb_ptr() - forget shared zone
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ * @peb_type: PEB type
+ * @peb_state: pointer on PEB state value [out]
+ *
+ * This method tries to clear SSDFS_MAPTBL_SOURCE_PEB_HAS_ZONE_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static int
+ssdfs_maptbl_break_zns_external_peb_ptr(struct ssdfs_maptbl_fragment_desc *fdesc,
+					u16 index, u8 peb_type,
+					u8 *peb_state)
+{
+	struct ssdfs_peb_descriptor *ptr;
+	pgoff_t page_index;
+	u16 item_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !peb_state);
+
+	SSDFS_DBG("fdesc %p, index %u\n",
+		  fdesc, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
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
+	if (peb_type != ptr->type) {
+		err = -ERANGE;
+		SSDFS_ERR("peb_type %#x != ptr->type %#x\n",
+			  peb_type, ptr->type);
+		goto finish_page_processing;
+	}
+
+	if (ptr->flags & SSDFS_MAPTBL_SHARED_DESTINATION_PEB) {
+		err = -ERANGE;
+		SSDFS_ERR("corrupted PEB desriptor\n");
+		goto finish_page_processing;
+	}
+
+	if (!(ptr->flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_ZONE_PTR))
+		SSDFS_WARN("PEB hasn't indirect relation\n");
+
+	switch (ptr->state) {
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+		ptr->state = SSDFS_MAPTBL_USED_PEB_STATE;
+		*peb_state = SSDFS_MAPTBL_USED_PEB_STATE;
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+		ptr->state = SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+		*peb_state = SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		ptr->state = SSDFS_MAPTBL_DIRTY_PEB_STATE;
+		*peb_state = SSDFS_MAPTBL_DIRTY_PEB_STATE;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  ptr->state);
+		goto finish_page_processing;
+	}
+
+	ptr->shared_peb_index = U8_MAX;
+	ptr->flags &= ~SSDFS_MAPTBL_SOURCE_PEB_HAS_ZONE_PTR;
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
+ * __ssdfs_maptbl_break_zns_indirect_relation() - forget shared zone
+ * @tbl: pointer on mapping table object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to clear SSDFS_MAPTBL_SOURCE_PEB_HAS_ZONE_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-ERANGE     - internal error.
+ */
+static int
+__ssdfs_maptbl_break_zns_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					   u64 leb_id, u8 peb_type,
+					   struct completion **end)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 physical_index;
+	u8 peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !end);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, peb_type %#x\n",
+		  tbl, leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		return err;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n", leb_id);
+		return err;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
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
+	if (!__is_mapped_leb2peb(&leb_desc)) {
+		err = -ERANGE;
+		SSDFS_ERR("leb %llu doesn't be mapped yet\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	if (is_leb_migrating(&leb_desc)) {
+		err = -ERANGE;
+		SSDFS_ERR("leb %llu has direct relation\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+
+	if (physical_index == U16_MAX) {
+		err = -ENODATA;
+		SSDFS_DBG("unitialized leb descriptor\n");
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_break_zns_external_peb_ptr(fdesc, physical_index,
+							peb_type, &peb_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to break external PEB pointer: "
+			  "physical_index %u, err %d\n",
+			  physical_index, err);
+		goto finish_fragment_change;
+	}
+
+	if (peb_state == SSDFS_MAPTBL_DIRTY_PEB_STATE) {
+		err = ssdfs_maptbl_set_pre_erase_state(fdesc, physical_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into pre-erase state: "
+				  "index %u, err %d\n",
+				  physical_index, err);
+			goto finish_fragment_change;
+		}
+
+		fdesc->pre_erase_pebs++;
+		atomic_inc(&tbl->pre_erase_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fdesc->pre_erase_pebs %u, tbl->pre_erase_pebs %d\n",
+			  fdesc->pre_erase_pebs,
+			  atomic_read(&tbl->pre_erase_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		wake_up(&tbl->wait_queue);
+	}
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_break_zns_indirect_relation() - break PEBs indirect relation
+ * @tbl: pointer on mapping table object
+ * @leb_id: source LEB ID number
+ * @peb_type: PEB type
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to clear SSDFS_MAPTBL_SOURCE_PEB_HAS_ZONE_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_break_zns_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					     u64 leb_id, u8 peb_type,
+					     struct completion **end)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !end);
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, "
+		  "peb_type %#x\n",
+		  tbl, leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tbl->fsi;
+	*end = NULL;
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	if (should_cache_peb_info(peb_type)) {
+		struct ssdfs_maptbl_peb_relation prev_pebr;
+
+		/* resolve potential inconsistency */
+		err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id, peb_type,
+						   &prev_pebr, end);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment is under initialization: "
+				  "leb_id %llu\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to resolve inconsistency: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			return err;
+		}
+	}
+
+	down_read(&tbl->tbl_lock);
+
+	err = __ssdfs_maptbl_break_zns_indirect_relation(tbl, leb_id,
+							 peb_type, end);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_break_indirect_relation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to break indirect relation: "
+			  "leb_id %llu, err %u\n",
+			  leb_id, err);
+		goto finish_break_indirect_relation;
+	}
+
+finish_break_indirect_relation:
+	up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+static inline
+int __ssdfs_reserve_free_pages(struct ssdfs_fs_info *fsi, u32 count,
+				int type, u64 *free_pages)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 reserved = 0;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(type <= SSDFS_UNKNOWN_PAGE_TYPE || type >= SSDFS_PAGES_TYPE_MAX);
+
+	SSDFS_DBG("fsi %p, count %u, type %#x\n",
+		  fsi, count, type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*free_pages = 0;
+
+	spin_lock(&fsi->volume_state_lock);
+	*free_pages = fsi->free_pages;
+	if (fsi->free_pages >= count) {
+		err = -EEXIST;
+		fsi->free_pages -= count;
+		switch (type) {
+		case SSDFS_USER_DATA_PAGES:
+			fsi->reserved_new_user_data_pages += count;
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		};
+#ifdef CONFIG_SSDFS_DEBUG
+		reserved = fsi->reserved_new_user_data_pages;
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else
+		err = -ENOSPC;
+	spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved %llu\n", reserved);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+static
+int ssdfs_try2increase_free_pages(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	u32 fragments_count;
+	int state;
+	u32 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+
+	fragments_count = tbl->fragments_count;
+
+	down_read(&tbl->tbl_lock);
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		state = atomic_read(&fdesc->state);
+		if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+			err = -EFAULT;
+			SSDFS_ERR("fragment is corrupted: index %u\n",
+				  i);
+			goto finish_fragment_check;
+		} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+			struct completion *end = &fdesc->init_end;
+
+			up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("wait fragment initialization end: "
+				  "index %u, state %#x\n",
+				  i, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("fragment init failed: "
+					  "index %u\n", i);
+				err = -EFAULT;
+				goto finish_try2increase_free_pages;
+			}
+
+			down_read(&tbl->tbl_lock);
+		}
+
+		down_read(&fdesc->lock);
+		err = ssdfs_maptbl_try_decrease_reserved_pebs(tbl, fdesc);
+		up_read(&fdesc->lock);
+
+		if (err == -ENOENT) {
+			err = -ENOSPC;
+			SSDFS_DBG("unable to decrease reserved pebs\n");
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to decrease reserved pebs: "
+				  "err %d\n", err);
+			goto finish_fragment_check;
+		}
+	}
+
+finish_fragment_check:
+	up_read(&tbl->tbl_lock);
+
+finish_try2increase_free_pages:
+	return err;
+}
+
+static
+int ssdfs_wait_maptbl_init_ending(struct ssdfs_fs_info *fsi, u32 count)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	u32 fragments_count;
+	int state;
+	u64 free_pages;
+	u32 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+
+	fragments_count = tbl->fragments_count;
+
+	down_read(&tbl->tbl_lock);
+
+	for (i = 0; i < fragments_count; i++) {
+		fdesc = &tbl->desc_array[i];
+
+		state = atomic_read(&fdesc->state);
+		if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+			err = -EFAULT;
+			SSDFS_ERR("fragment is corrupted: index %u\n",
+				  i);
+			goto finish_fragment_check;
+		} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+			struct completion *end = &fdesc->init_end;
+
+			up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("wait fragment initialization end: "
+				  "index %u, state %#x\n",
+				  i, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("fragment init failed: "
+					  "index %u\n", i);
+				err = -EFAULT;
+				goto finish_wait_init;
+			}
+
+			spin_lock(&fsi->volume_state_lock);
+			free_pages = fsi->free_pages;
+			spin_unlock(&fsi->volume_state_lock);
+
+			if (free_pages >= count)
+				goto finish_wait_init;
+
+			down_read(&tbl->tbl_lock);
+		}
+	}
+
+finish_fragment_check:
+	up_read(&tbl->tbl_lock);
+
+finish_wait_init:
+	return err;
+}
+
+int ssdfs_reserve_free_pages(struct ssdfs_fs_info *fsi, u32 count, int type)
+{
+	u64 free_pages = 0;
+	int state;
+	u32 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(type <= SSDFS_UNKNOWN_PAGE_TYPE || type >= SSDFS_PAGES_TYPE_MAX);
+
+	SSDFS_DBG("fsi %p, count %u, type %#x\n",
+		  fsi, count, type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&fsi->global_fs_state);
+
+	err = __ssdfs_reserve_free_pages(fsi, count, type, &free_pages);
+	if (err == -EEXIST) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free pages %u have been reserved, free_pages %llu\n",
+			  count, free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (err == -ENOSPC && state == SSDFS_UNKNOWN_GLOBAL_FS_STATE) {
+		err = ssdfs_wait_maptbl_init_ending(fsi, count);
+		if (unlikely(err)) {
+			SSDFS_ERR("initialization has failed: "
+				  "err %d\n", err);
+			goto finish_reserve_free_pages;
+		}
+
+		err = __ssdfs_reserve_free_pages(fsi, count,
+						 type, &free_pages);
+		if (err == -EEXIST) {
+			/* succesful reservation */
+			err = 0;
+			goto finish_reserve_free_pages;
+		} else {
+			/*
+			 * finish logic
+			 */
+			goto finish_reserve_free_pages;
+		}
+	} else if (err == -ENOSPC) {
+		DEFINE_WAIT(wait);
+		err = 0;
+
+		wake_up_all(&fsi->shextree->wait_queue);
+		wake_up_all(&fsi->maptbl->wait_queue);
+
+		for (i = 0; i < SSDFS_GC_THREAD_TYPE_MAX; i++) {
+			wake_up_all(&fsi->gc_wait_queue[i]);
+		}
+
+		prepare_to_wait(&fsi->maptbl->erase_ops_end_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&fsi->maptbl->erase_ops_end_wq, &wait);
+
+		err = ssdfs_try2increase_free_pages(fsi);
+		if (err == -ENOSPC) {
+			/*
+			 * try to collect the dirty segments
+			 */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to increase the free pages: "
+				  "err %d\n", err);
+			goto finish_reserve_free_pages;
+		} else {
+			err = __ssdfs_reserve_free_pages(fsi, count,
+							 type, &free_pages);
+			if (err == -EEXIST) {
+				/* succesful reservation */
+				err = 0;
+				goto finish_reserve_free_pages;
+			} else {
+				/*
+				 * try to collect the dirty segments
+				 */
+				err = 0;
+			}
+		}
+
+		err = ssdfs_collect_dirty_segments_now(fsi);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to collect the dirty segments: "
+				  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_reserve_free_pages;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to collect the dirty segments: "
+				  "err %d\n", err);
+			goto finish_reserve_free_pages;
+		}
+
+		err = ssdfs_try2increase_free_pages(fsi);
+		if (err == -ENOSPC) {
+			/*
+			 * finish logic
+			 */
+			goto finish_reserve_free_pages;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to increase the free pages: "
+				  "err %d\n", err);
+			goto finish_reserve_free_pages;
+		} else {
+			err = __ssdfs_reserve_free_pages(fsi, count,
+							 type, &free_pages);
+			if (err == -EEXIST) {
+				/* succesful reservation */
+				err = 0;
+				goto finish_reserve_free_pages;
+			} else {
+				/*
+				 * finish logic
+				 */
+				goto finish_reserve_free_pages;
+			}
+		}
+	} else
+		BUG();
+
+finish_reserve_free_pages:
+	if (err) {
+		err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to reserve, free_pages %llu\n",
+			  free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free pages %u have been reserved, free_pages %llu\n",
+			  count, free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+void ssdfs_debug_maptbl_object(struct ssdfs_peb_mapping_table *tbl)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i, j;
+	size_t bytes_count;
+
+	BUG_ON(!tbl);
+
+	SSDFS_DBG("fragments_count %u, fragments_per_seg %u, "
+		  "fragments_per_peb %u, fragment_bytes %u, "
+		  "flags %#x, lebs_count %llu, pebs_count %llu, "
+		  "lebs_per_fragment %u, pebs_per_fragment %u, "
+		  "pebs_per_stripe %u, stripes_per_fragment %u\n",
+		  tbl->fragments_count, tbl->fragments_per_seg,
+		  tbl->fragments_per_peb, tbl->fragment_bytes,
+		  atomic_read(&tbl->flags), tbl->lebs_count,
+		  tbl->pebs_count, tbl->lebs_per_fragment,
+		  tbl->pebs_per_fragment, tbl->pebs_per_stripe,
+		  tbl->stripes_per_fragment);
+
+	for (i = 0; i < MAPTBL_LIMIT1; i++) {
+		for (j = 0; j < MAPTBL_LIMIT2; j++) {
+			struct ssdfs_meta_area_extent *extent;
+			extent = &tbl->extents[i][j];
+			SSDFS_DBG("extent[%d][%d]: "
+				  "start_id %llu, len %u, "
+				  "type %#x, flags %#x\n",
+				  i, j,
+				  le64_to_cpu(extent->start_id),
+				  le32_to_cpu(extent->len),
+				  le16_to_cpu(extent->type),
+				  le16_to_cpu(extent->flags));
+		}
+	}
+
+	SSDFS_DBG("segs_count %u\n", tbl->segs_count);
+
+	for (i = 0; i < SSDFS_MAPTBL_SEG_COPY_MAX; i++) {
+		if (!tbl->segs[i])
+			continue;
+
+		for (j = 0; j < tbl->segs_count; j++)
+			SSDFS_DBG("seg[%d][%d] %p\n", i, j, tbl->segs[i][j]);
+	}
+
+	SSDFS_DBG("pre_erase_pebs %u, max_erase_ops %u, "
+		  "last_peb_recover_cno %llu\n",
+		  atomic_read(&tbl->pre_erase_pebs),
+		  atomic_read(&tbl->max_erase_ops),
+		  (u64)atomic64_read(&tbl->last_peb_recover_cno));
+
+	bytes_count = tbl->fragments_count + BITS_PER_LONG - 1;
+	bytes_count /= BITS_PER_BYTE;
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				tbl->dirty_bmap, bytes_count);
+
+	for (i = 0; i < tbl->fragments_count; i++) {
+		struct ssdfs_maptbl_fragment_desc *desc;
+		struct page *page;
+		u32 pages_count;
+		int state;
+
+		desc = &tbl->desc_array[i];
+
+		state = atomic_read(&desc->state);
+		SSDFS_DBG("fragment #%d: "
+			  "state %#x, start_leb %llu, lebs_count %u, "
+			  "lebs_per_page %u, lebtbl_pages %u, "
+			  "pebs_per_page %u, stripe_pages %u, "
+			  "mapped_lebs %u, migrating_lebs %u, "
+			  "pre_erase_pebs %u, recovering_pebs %u\n",
+			  i, state,
+			  desc->start_leb, desc->lebs_count,
+			  desc->lebs_per_page, desc->lebtbl_pages,
+			  desc->pebs_per_page, desc->stripe_pages,
+			  desc->mapped_lebs, desc->migrating_lebs,
+			  desc->pre_erase_pebs, desc->recovering_pebs);
+
+		if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+			SSDFS_DBG("fragment #%d isn't initialized\n", i);
+			continue;
+		} else if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+			SSDFS_DBG("fragment #%d init was failed\n", i);
+			continue;
+		}
+
+		pages_count = desc->lebtbl_pages +
+			(desc->stripe_pages * tbl->stripes_per_fragment);
+
+		for (j = 0; j < pages_count; j++) {
+			void *kaddr;
+
+			page = ssdfs_page_array_get_page_locked(&desc->array,
+								j);
+
+			SSDFS_DBG("page[%d] %p\n", j, page);
+			if (IS_ERR_OR_NULL(page))
+				continue;
+
+			SSDFS_DBG("page_index %llu, flags %#lx\n",
+				  (u64)page_index(page), page->flags);
+
+			kaddr = kmap_local_page(page);
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+						kaddr, PAGE_SIZE);
+			kunmap_local(kaddr);
+
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+		}
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
diff --git a/fs/ssdfs/peb_mapping_table_cache.c b/fs/ssdfs/peb_mapping_table_cache.c
new file mode 100644
index 000000000000..e83e07947743
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_table_cache.c
@@ -0,0 +1,1497 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_table_cache.c - PEB mapping table cache functionality.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/kernel.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_array.h"
+#include "peb_mapping_table.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_map_cache_page_leaks;
+atomic64_t ssdfs_map_cache_memory_leaks;
+atomic64_t ssdfs_map_cache_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_map_cache_cache_leaks_increment(void *kaddr)
+ * void ssdfs_map_cache_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_map_cache_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_map_cache_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_map_cache_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_map_cache_kfree(void *kaddr)
+ * struct page *ssdfs_map_cache_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_map_cache_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_map_cache_free_page(struct page *page)
+ * void ssdfs_map_cache_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(map_cache)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(map_cache)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_map_cache_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_map_cache_page_leaks, 0);
+	atomic64_set(&ssdfs_map_cache_memory_leaks, 0);
+	atomic64_set(&ssdfs_map_cache_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_map_cache_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_map_cache_page_leaks) != 0) {
+		SSDFS_ERR("MAPPING CACHE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_map_cache_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_map_cache_memory_leaks) != 0) {
+		SSDFS_ERR("MAPPING CACHE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_map_cache_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_map_cache_cache_leaks) != 0) {
+		SSDFS_ERR("MAPPING CACHE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_map_cache_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_maptbl_cache_init() - init mapping table cache
+ */
+void ssdfs_maptbl_cache_init(struct ssdfs_maptbl_cache *cache)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+
+	SSDFS_DBG("cache %p\n", cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	init_rwsem(&cache->lock);
+	pagevec_init(&cache->pvec);
+	atomic_set(&cache->bytes_count, 0);
+	ssdfs_peb_mapping_queue_init(&cache->pm_queue);
+}
+
+/*
+ * ssdfs_maptbl_cache_destroy() - destroy mapping table cache
+ */
+void ssdfs_maptbl_cache_destroy(struct ssdfs_maptbl_cache *cache)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache);
+
+	SSDFS_DBG("cache %p\n", cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_map_cache_pagevec_release(&cache->pvec);
+	ssdfs_peb_mapping_queue_remove_all(&cache->pm_queue);
+}
+
+/*
+ * __ssdfs_maptbl_cache_area_size() - calculate areas' size in fragment
+ * @hdr: fragment's header
+ * @leb2peb_area_size: LEB2PEB area size [out]
+ * @peb_state_area_size: PEB state area size [out]
+ *
+ * This method calculates size in bytes of LEB2PEB area and
+ * PEB state area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE    - internal error.
+ * %-ENODATA   - fragment is empty.
+ */
+static inline
+int __ssdfs_maptbl_cache_area_size(struct ssdfs_maptbl_cache_header *hdr,
+				   size_t *leb2peb_area_size,
+				   size_t *peb_state_area_size)
+{
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t magic_size = peb_state_size;
+	u16 bytes_count;
+	u16 items_count;
+	size_t threshold_size;
+	size_t capacity;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !leb2peb_area_size || !peb_state_area_size);
+
+	SSDFS_DBG("hdr %p\n", hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*leb2peb_area_size = 0;
+	*peb_state_area_size = magic_size;
+
+	bytes_count = le16_to_cpu(hdr->bytes_count);
+	items_count = le16_to_cpu(hdr->items_count);
+
+	threshold_size = hdr_size + magic_size;
+
+	if (bytes_count < threshold_size) {
+		SSDFS_ERR("fragment is corrupted: "
+			  "hdr_size %zu, bytes_count %u\n",
+			  hdr_size, bytes_count);
+		return -ERANGE;
+	} else if (bytes_count == threshold_size) {
+		SSDFS_DBG("fragment is empty\n");
+		return -ENODATA;
+	}
+
+	capacity =
+		(bytes_count - threshold_size) / (pair_size + peb_state_size);
+
+	if (items_count > capacity) {
+		SSDFS_ERR("items_count %u > capacity %zu\n",
+			  items_count, capacity);
+		return -ERANGE;
+	}
+
+	*leb2peb_area_size = capacity * pair_size;
+	*peb_state_area_size = magic_size + (capacity * peb_state_size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_leb2peb_pair_area_size() - calculate LEB2PEB area size
+ * @hdr: fragment's header
+ *
+ * This method calculates size in bytes of LEB2PEB area.
+ *
+ * RETURN:
+ * [success] - LEB2PEB area size in bytes.
+ * [failure] - error code:
+ *
+ * %-ERANGE    - internal error.
+ * %-ENODATA   - fragment is empty.
+ */
+static inline
+int ssdfs_leb2peb_pair_area_size(struct ssdfs_maptbl_cache_header *hdr)
+{
+	size_t leb2peb_area_size;
+	size_t peb_state_area_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+
+	SSDFS_DBG("hdr %p\n", hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_maptbl_cache_area_size(hdr,
+					     &leb2peb_area_size,
+					     &peb_state_area_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define leb2peb area size: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	return (int)leb2peb_area_size;
+}
+
+/*
+ * ssdfs_maptbl_cache_fragment_capacity() - calculate fragment capacity
+ *
+ * This method calculates the capacity (maximum number of items)
+ * of fragment.
+ */
+static inline
+size_t ssdfs_maptbl_cache_fragment_capacity(void)
+{
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t magic_size = peb_state_size;
+	size_t size = PAGE_SIZE;
+	size_t count;
+
+	size -= hdr_size + magic_size;
+	count = size / (pair_size + peb_state_size);
+
+	return count;
+}
+
+/*
+ * LEB2PEB_PAIR_AREA() - get pointer on first LEB2PEB pair
+ * @kaddr: pointer on fragment's beginning
+ */
+static inline
+struct ssdfs_leb2peb_pair *LEB2PEB_PAIR_AREA(void *kaddr)
+{
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+
+	return (struct ssdfs_leb2peb_pair *)((u8 *)kaddr + hdr_size);
+}
+
+/*
+ * ssdfs_peb_state_area_size() - calculate PEB state area size
+ * @hdr: fragment's header
+ *
+ * This method calculates size in bytes of PEB state area.
+ *
+ * RETURN:
+ * [success] - PEB state area size in bytes.
+ * [failure] - error code:
+ *
+ * %-ERANGE    - internal error.
+ * %-ENODATA   - fragment is empty.
+ */
+static inline
+int ssdfs_peb_state_area_size(struct ssdfs_maptbl_cache_header *hdr)
+{
+	size_t leb2peb_area_size;
+	size_t peb_state_area_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+
+	SSDFS_DBG("hdr %p\n", hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_maptbl_cache_area_size(hdr,
+					     &leb2peb_area_size,
+					     &peb_state_area_size);
+	if (err == -ENODATA) {
+		/* empty area */
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to define peb state area size: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	return (int)peb_state_area_size;
+}
+
+/*
+ * PEB_STATE_AREA() - get pointer on PEB state area
+ * @kaddr: pointer on fragment's beginning
+ * @area_offset: PEB state area's offset
+ *
+ * This method tries to prepare pointer on the
+ * PEB state area in the fragment.
+ *
+ * RETURN:
+ * [success] - pointer on the PEB state area.
+ * [failure] - error code:
+ *
+ * %-ERANGE    - corrupted PEB state area.
+ */
+static inline
+void *PEB_STATE_AREA(void *kaddr, u32 *area_offset)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_maptbl_cache_header);
+	size_t leb2peb_area_size;
+	size_t peb_state_area_size;
+	void *start = NULL;
+	__le32 *magic = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !area_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	*area_offset = U32_MAX;
+
+	err = __ssdfs_maptbl_cache_area_size(hdr,
+					     &leb2peb_area_size,
+					     &peb_state_area_size);
+	if (err == -ENODATA) {
+		/* empty area */
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get area size: err %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	if ((hdr_size + leb2peb_area_size + peb_state_area_size) > PAGE_SIZE) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid state: "
+			  "hdr_size %zu, leb2peb_area_size %zu, "
+			  "peb_state_area_size %zu\n",
+			  hdr_size, leb2peb_area_size,
+			  peb_state_area_size);
+		return ERR_PTR(err);
+	}
+
+	*area_offset = hdr_size + leb2peb_area_size;
+	start = (u8 *)kaddr + hdr_size + leb2peb_area_size;
+	magic = (__le32 *)start;
+
+	if (le32_to_cpu(*magic) != SSDFS_MAPTBL_CACHE_PEB_STATE_MAGIC) {
+		SSDFS_ERR("invalid magic %#x\n",
+			  le32_to_cpu(*magic));
+		return ERR_PTR(-ERANGE);
+	}
+
+	return start;
+}
+
+/*
+ * FIRST_PEB_STATE() - get pointer on first PEB state
+ * @kaddr: pointer on fragment's beginning
+ * @area_offset: PEB state area's offset
+ *
+ * This method tries to prepare pointer on the first
+ * PEB state in the fragment.
+ *
+ * RETURN:
+ * [success] - pointer on first PEB state.
+ * [failure] - error code:
+ *
+ * %-ERANGE    - corrupted PEB state area.
+ */
+static inline
+struct ssdfs_maptbl_cache_peb_state *FIRST_PEB_STATE(void *kaddr,
+						     u32 *area_offset)
+{
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	size_t magic_size = peb_state_size;
+	void *start = PEB_STATE_AREA(kaddr, area_offset);
+
+	if (IS_ERR_OR_NULL(start))
+		return (struct ssdfs_maptbl_cache_peb_state *)start;
+
+	return (struct ssdfs_maptbl_cache_peb_state *)((u8 *)start +
+							magic_size);
+}
+
+/*
+ * ssdfs_find_range_lower_limit() - find the first item of range
+ * @hdr: mapping table cache's header
+ * @leb_id: LEB ID
+ * @start_index: starting index
+ * @start_pair: pointer on starting LEB2PEB pair
+ * @found_index: pointer on found index [out]
+ *
+ * This method tries to find position of the first item
+ * for the same @leb_id in the range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL    - invalid input.
+ * %-ERANGE    - internal error.
+ */
+static
+int ssdfs_find_range_lower_limit(struct ssdfs_maptbl_cache_header *hdr,
+				 u64 leb_id, int start_index,
+				 struct ssdfs_leb2peb_pair *start_pair,
+				 int *found_index)
+{
+	struct ssdfs_leb2peb_pair *cur_pair = NULL;
+	u16 items_count;
+	u64 cur_leb_id;
+	int i = 0, j = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !start_pair || !found_index);
+
+	SSDFS_DBG("hdr %p, leb_id %llu, start_index %d, "
+		  "start_pair %p, found_index %p\n",
+		  hdr, leb_id, start_index, start_pair, found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache\n");
+		return -ERANGE;
+	}
+
+	if (start_index < 0 || start_index >= items_count) {
+		SSDFS_ERR("invalid index: "
+			  "start_index %d, items_count %u\n",
+			  start_index, items_count);
+		return -EINVAL;
+	}
+
+	if (leb_id != le64_to_cpu(start_pair->leb_id)) {
+		SSDFS_ERR("invalid ID: "
+			  "leb_id1 %llu, leb_id2 %llu\n",
+			  leb_id,
+			  le64_to_cpu(start_pair->leb_id));
+		return -EINVAL;
+	}
+
+	*found_index = start_index;
+
+	for (i = start_index - 1, j = 1; i >= 0; i--, j++) {
+		cur_pair = start_pair - j;
+		cur_leb_id = le64_to_cpu(cur_pair->leb_id);
+
+		if (cur_leb_id == leb_id) {
+			*found_index = i;
+			continue;
+		} else
+			return 0;
+
+		if ((start_index - i) >= 2) {
+			SSDFS_ERR("corrupted cache\n");
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_find_range_upper_limit() - find the last item of range
+ * @hdr: mapping table cache's header
+ * @leb_id: LEB ID
+ * @start_index: starting index
+ * @start_pair: pointer on starting LEB2PEB pair
+ * @found_index: pointer on found index [out]
+ *
+ * This method tries to find position of the last item
+ * for the same @leb_id in the range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL    - invalid input.
+ * %-ERANGE    - internal error.
+ */
+static
+int ssdfs_find_range_upper_limit(struct ssdfs_maptbl_cache_header *hdr,
+				 u64 leb_id, int start_index,
+				 struct ssdfs_leb2peb_pair *start_pair,
+				 int *found_index)
+{
+	struct ssdfs_leb2peb_pair *cur_pair = NULL;
+	u16 items_count;
+	u64 cur_leb_id;
+	int i = 0, j = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !start_pair || !found_index);
+
+	SSDFS_DBG("hdr %p, leb_id %llu, start_index %d, "
+		  "start_pair %p, found_index %p\n",
+		  hdr, leb_id, start_index, start_pair, found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache\n");
+		return -ERANGE;
+	}
+
+	if (start_index < 0 || start_index >= items_count) {
+		SSDFS_ERR("invalid index: "
+			  "start_index %d, items_count %u\n",
+			  start_index, items_count);
+		return -EINVAL;
+	}
+
+	if (leb_id != le64_to_cpu(start_pair->leb_id)) {
+		SSDFS_ERR("invalid ID: "
+			  "leb_id1 %llu, leb_id2 %llu\n",
+			  leb_id,
+			  le64_to_cpu(start_pair->leb_id));
+		return -EINVAL;
+	}
+
+	*found_index = start_index;
+
+	for (i = start_index + 1, j = 1; i < items_count; i++, j++) {
+		cur_pair = start_pair + j;
+		cur_leb_id = le64_to_cpu(cur_pair->leb_id);
+
+		if (cur_leb_id == leb_id) {
+			*found_index = i;
+			continue;
+		} else
+			return 0;
+
+		if ((i - start_index) >= 2) {
+			SSDFS_ERR("corrupted cache\n");
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_find_result_pair() - extract pair of descriptors
+ * @hdr: mapping table cache's header
+ * @sequence_id: fragment ID
+ * @leb_id: LEB ID
+ * @peb_index: main/relation PEB index
+ * @cur_index: current index of item in cache
+ * @start_pair: pointer on starting pair in cache
+ * @cur_pair: pointer on current pair for @current_index
+ * @res: pointer on the extracted pair of descriptors [out]
+ *
+ * This method tries to extract the pair of descriptor for
+ * main and relation LEB2PEB pairs.
+ *
+ * RETURN:
+ * [success] - error code:
+ * %-EAGAIN    - repeat the search for the next memory page
+ * %-EEXIST    - @leb_id is found.
+ *
+ * [failure] - error code:
+ * %-ERANGE    - internal error.
+ */
+static
+int ssdfs_find_result_pair(struct ssdfs_maptbl_cache_header *hdr,
+			   unsigned sequence_id,
+			   u64 leb_id,
+			   int peb_index,
+			   int cur_index,
+			   struct ssdfs_leb2peb_pair *start_pair,
+			   struct ssdfs_leb2peb_pair *cur_pair,
+			   struct ssdfs_maptbl_cache_search_result *res)
+{
+	struct ssdfs_maptbl_cache_item *cur_item;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	int lo_limit = -1;
+	int up_limit = -1;
+	u16 items_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !start_pair || !cur_pair || !res);
+
+	SSDFS_DBG("sequence_id %u, leb_id %llu, "
+		  "peb_index %#x, cur_index %d\n",
+		  sequence_id, leb_id, peb_index, cur_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_item = &res->pebs[peb_index];
+	cur_item->state = SSDFS_MAPTBL_CACHE_SEARCH_ERROR;
+
+	items_count = le16_to_cpu(hdr->items_count);
+	if (items_count == 0) {
+		SSDFS_ERR("empty maptbl cache\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_range_lower_limit(hdr, leb_id, cur_index,
+					   cur_pair, &lo_limit);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find lower_limit: "
+			  "leb_id %llu, cur_index %d, "
+			  "err %d\n",
+			  leb_id, cur_index, err);
+		return err;
+	}
+
+	err = ssdfs_find_range_upper_limit(hdr, leb_id, cur_index,
+					   cur_pair, &up_limit);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find upper_limit: "
+			  "leb_id %llu, cur_index %d, "
+			  "err %d\n",
+			  leb_id, cur_index, err);
+		return err;
+	}
+
+	switch (peb_index) {
+	case SSDFS_MAPTBL_MAIN_INDEX:
+		/* save main item */
+		cur_item->state = SSDFS_MAPTBL_CACHE_ITEM_FOUND;
+		cur_item->page_index = sequence_id;
+		cur_item->item_index = lo_limit;
+		cur_pair = start_pair + lo_limit;
+		ssdfs_memcpy(&cur_item->found, 0, pair_size,
+			     cur_pair, 0, pair_size,
+			     pair_size);
+		peb_index = SSDFS_MAPTBL_RELATION_INDEX;
+		cur_item = &res->pebs[peb_index];
+		cur_item->state = SSDFS_MAPTBL_CACHE_ITEM_ABSENT;
+
+		if (lo_limit == up_limit && (up_limit + 1) == items_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("leb_id %llu, peb_index %d, cur_index %d, "
+				  "lo_limit %d, up_limit %d, items_count %u\n",
+				  leb_id, peb_index, cur_index,
+				  lo_limit, up_limit, items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EAGAIN;
+		} else if (lo_limit == up_limit)
+			return -EEXIST;
+
+		/* save relation item */
+		cur_item->state = SSDFS_MAPTBL_CACHE_ITEM_FOUND;
+		cur_item->page_index = sequence_id;
+		cur_item->item_index = up_limit;
+		cur_pair = start_pair + up_limit;
+		ssdfs_memcpy(&cur_item->found, 0, pair_size,
+			     cur_pair, 0, pair_size,
+			     pair_size);
+		break;
+
+	case SSDFS_MAPTBL_RELATION_INDEX:
+		if (lo_limit != up_limit && lo_limit != 0) {
+			SSDFS_ERR("corrupted cache\n");
+			return -ERANGE;
+		}
+
+		cur_item->state = SSDFS_MAPTBL_CACHE_ITEM_FOUND;
+		cur_item->page_index = sequence_id;
+		cur_item->item_index = lo_limit;
+		cur_pair = start_pair + lo_limit;
+		ssdfs_memcpy(&cur_item->found, 0, pair_size,
+			     cur_pair, 0, pair_size,
+			     pair_size);
+		break;
+
+	default:
+		SSDFS_ERR("invalid index %d\n", peb_index);
+		return -ERANGE;
+	}
+
+	return -EEXIST;
+}
+
+static
+void ssdfs_maptbl_cache_show_items(void *kaddr)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *start_pair, *cur_pair;
+	struct ssdfs_maptbl_cache_peb_state *start_state = NULL;
+	struct ssdfs_maptbl_cache_peb_state *state_ptr;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int i;
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	items_count = le16_to_cpu(hdr->items_count);
+	start_pair = LEB2PEB_PAIR_AREA(kaddr);
+
+	SSDFS_ERR("MAPTBL CACHE:\n");
+
+	SSDFS_ERR("LEB2PEB pairs:\n");
+	for (i = 0; i < items_count; i++) {
+		cur_pair = start_pair + i;
+		SSDFS_ERR("item %d, leb_id %llu, peb_id %llu\n",
+			  i,
+			  le64_to_cpu(cur_pair->leb_id),
+			  le64_to_cpu(cur_pair->peb_id));
+	}
+
+	start_state = FIRST_PEB_STATE(kaddr, &area_offset);
+
+	SSDFS_ERR("PEB states:\n");
+	for (i = 0; i < items_count; i++) {
+		state_ptr =
+		    (struct ssdfs_maptbl_cache_peb_state *)((u8 *)start_state +
+							(peb_state_size * i));
+		SSDFS_ERR("item %d, consistency %#x, "
+			  "state %#x, flags %#x, "
+			  "shared_peb_index %u\n",
+			  i, state_ptr->consistency,
+			  state_ptr->state, state_ptr->flags,
+			  state_ptr->shared_peb_index);
+	}
+}
+
+/*
+ * __ssdfs_maptbl_cache_find_leb() - find position of LEB
+ * @kaddr: pointer on maptbl cache's fragment
+ * @sequence_id: fragment ID
+ * @leb_id: LEB ID
+ * @res: pointer on the extracted pair of descriptors [out]
+ *
+ * This method tries to find position of LEB for extracting
+ * or inserting a LEB/PEB pair.
+ *
+ * RETURN:
+ * [success] - error code:
+ * %-EAGAIN    - repeat the search for the next memory page
+ * %-EFAULT    - @leb_id doesn't found; position can be used for inserting.
+ * %-E2BIG     - page is full; @leb_id is greater than ending LEB number.
+ * %-ENODATA   - @leb_id is greater than ending LEB number.
+ * %-EEXIST    - @leb_id is found.
+ *
+ * [failure] - error code:
+ * %-ERANGE    - internal error.
+ */
+static
+int __ssdfs_maptbl_cache_find_leb(void *kaddr,
+				  unsigned sequence_id,
+				  u64 leb_id,
+				  struct ssdfs_maptbl_cache_search_result *res)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_maptbl_cache_item *cur_item;
+	int cur_item_index = SSDFS_MAPTBL_MAIN_INDEX;
+	struct ssdfs_leb2peb_pair *start_pair, *cur_pair;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	u64 start_leb, end_leb;
+	u64 start_diff, end_diff;
+	u64 cur_leb_id;
+	u16 items_count;
+	int i = 0;
+	int step, cur_index;
+	bool disable_step = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !res);
+
+	SSDFS_DBG("kaddr %p, sequence_id %u, "
+		  "leb_id %llu, res %p\n",
+		  kaddr, sequence_id, leb_id, res);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	if (le16_to_cpu(hdr->sequence_id) != sequence_id) {
+		SSDFS_ERR("invalid sequence_id %u\n", sequence_id);
+		return -ERANGE;
+	}
+
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (items_count == 0) {
+		SSDFS_ERR("maptbl cache fragment %u is empty\n",
+			  sequence_id);
+		return -ERANGE;
+	}
+
+	start_pair = LEB2PEB_PAIR_AREA(kaddr);
+	start_leb = le64_to_cpu(hdr->start_leb);
+	end_leb = le64_to_cpu(hdr->end_leb);
+
+	cur_item = &res->pebs[cur_item_index];
+
+	switch (cur_item->state) {
+	case SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN:
+		/*
+		 * Continue the search for main item
+		 */
+		break;
+
+	case SSDFS_MAPTBL_CACHE_ITEM_FOUND:
+		cur_item_index = SSDFS_MAPTBL_RELATION_INDEX;
+		cur_item = &res->pebs[cur_item_index];
+
+		switch (cur_item->state) {
+		case SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN:
+			/*
+			 * Continue the search for relation item
+			 */
+			break;
+
+		default:
+			SSDFS_ERR("invalid search result's state %#x\n",
+				  cur_item->state);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  cur_item->state);
+		return -ERANGE;
+	}
+
+	if (leb_id < start_leb) {
+		cur_item->state = SSDFS_MAPTBL_CACHE_ITEM_ABSENT;
+		cur_item->page_index = sequence_id;
+		cur_item->item_index = 0;
+		ssdfs_memcpy(&cur_item->found, 0, pair_size,
+			     start_pair, 0, pair_size,
+			     pair_size);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("leb_id %llu, start_leb %llu, end_leb %llu\n",
+			  leb_id, start_leb, end_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EFAULT;
+	}
+
+	if (end_leb < leb_id) {
+		size_t capacity = ssdfs_maptbl_cache_fragment_capacity();
+
+		if ((items_count + 1) > capacity)
+			return -E2BIG;
+		else {
+			cur_item->state = SSDFS_MAPTBL_CACHE_ITEM_ABSENT;
+			cur_item->page_index = sequence_id;
+			cur_item->item_index = items_count;
+			ssdfs_memcpy(&cur_item->found, 0, pair_size,
+				     start_pair + items_count, 0, pair_size,
+				     pair_size);
+			return -ENODATA;
+		}
+	}
+
+	start_diff = leb_id - start_leb;
+	end_diff = end_leb - leb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_diff %llu, end_diff %llu\n",
+		  start_diff, end_diff);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start_diff <= end_diff) {
+		/* straight search */
+		SSDFS_DBG("straight search\n");
+
+		i = 0;
+		cur_index = 0;
+		step = 1;
+		while (i < items_count) {
+			cur_pair = start_pair + cur_index;
+			cur_leb_id = le64_to_cpu(cur_pair->leb_id);
+
+			if (leb_id < cur_leb_id) {
+				disable_step = true;
+				cur_index = i;
+				cur_pair = start_pair + cur_index;
+				cur_leb_id = le64_to_cpu(cur_pair->leb_id);
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_index %d, step %d, "
+				  "cur_leb_id %llu, leb_id %llu\n",
+				  cur_index, step, cur_leb_id, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (leb_id > cur_leb_id)
+				goto continue_straight_search;
+			else if (cur_leb_id == leb_id) {
+				return ssdfs_find_result_pair(hdr, sequence_id,
+							      leb_id,
+							      cur_item_index,
+							      cur_index,
+							      start_pair,
+							      cur_pair,
+							      res);
+			} else {
+				cur_item->state =
+					SSDFS_MAPTBL_CACHE_ITEM_ABSENT;
+				cur_item->page_index = sequence_id;
+				cur_item->item_index = cur_index;
+				ssdfs_memcpy(&cur_item->found, 0, pair_size,
+					     cur_pair, 0, pair_size,
+					     pair_size);
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("leb_id %llu, start_leb %llu, end_leb %llu, "
+					  "cur_leb_id %llu, cur_index %d, step %d\n",
+					  leb_id, start_leb, end_leb,
+					  cur_leb_id, cur_index, step);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return -EFAULT;
+			}
+
+continue_straight_search:
+			if (!disable_step)
+				step *= 2;
+
+			i = cur_index + 1;
+
+			if (disable_step)
+				cur_index = i;
+			else if ((i + step) < items_count) {
+				cur_index = i + step;
+			} else {
+				disable_step = true;
+				cur_index = i;
+			}
+		}
+	} else {
+		/* reverse search */
+		SSDFS_DBG("reverse search\n");
+
+		i = items_count - 1;
+		cur_index = i;
+		step = 1;
+		while (i >= 0) {
+			cur_pair = start_pair + cur_index;
+			cur_leb_id = le64_to_cpu(cur_pair->leb_id);
+
+			if (leb_id > cur_leb_id) {
+				disable_step = true;
+				cur_index = i;
+				cur_pair = start_pair + cur_index;
+				cur_leb_id = le64_to_cpu(cur_pair->leb_id);
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_index %d, step %d, "
+				  "cur_leb_id %llu, leb_id %llu\n",
+				  cur_index, step, cur_leb_id, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (leb_id < cur_leb_id)
+				goto continue_reverse_search;
+			else if (cur_leb_id == leb_id) {
+				return ssdfs_find_result_pair(hdr, sequence_id,
+							      leb_id,
+							      cur_item_index,
+							      cur_index,
+							      start_pair,
+							      cur_pair,
+							      res);
+			} else {
+				cur_item->state =
+					SSDFS_MAPTBL_CACHE_ITEM_ABSENT;
+				cur_item->page_index = sequence_id;
+				cur_index++;
+				cur_pair = start_pair + cur_index;
+				cur_item->item_index = cur_index;
+				ssdfs_memcpy(&cur_item->found, 0, pair_size,
+					     cur_pair, 0, pair_size,
+					     pair_size);
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("leb_id %llu, start_leb %llu, end_leb %llu, "
+					  "cur_leb_id %llu, cur_index %d, step %d\n",
+					  leb_id, start_leb, end_leb,
+					  cur_leb_id, cur_index, step);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return -EFAULT;
+			}
+
+continue_reverse_search:
+			if (!disable_step)
+				step *= 2;
+
+			i = cur_index - 1;
+
+			if (disable_step)
+				cur_index = i;
+			else if (i >= step && ((i - step) >= 0))
+				cur_index = i - step;
+			else {
+				disable_step = true;
+				cur_index = i;
+			}
+		};
+	}
+
+	return -ERANGE;
+}
+
+/*
+ * ssdfs_maptbl_cache_get_leb2peb_pair() - get LEB2PEB pair
+ * @kaddr: pointer on fragment's beginning
+ * @item_index: index of item in the fragment
+ * @pair: pointer on requested LEB2PEB pair [out]
+ *
+ * This method tries to prepare pointer on the requested
+ * LEB2PEB pair in the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL    - invalid input.
+ */
+static
+int ssdfs_maptbl_cache_get_leb2peb_pair(void *kaddr, u16 item_index,
+					struct ssdfs_leb2peb_pair **pair)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_leb2peb_pair *start = NULL;
+	size_t pair_size = sizeof(struct ssdfs_leb2peb_pair);
+	u16 items_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !pair);
+
+	SSDFS_DBG("kaddr %p, item_index %u, pair %p\n",
+		  kaddr, item_index, pair);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	items_count = le16_to_cpu(hdr->items_count);
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u >= items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	start = LEB2PEB_PAIR_AREA(kaddr);
+
+	*pair = (struct ssdfs_leb2peb_pair *)((u8 *)start +
+					(pair_size * item_index));
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_get_peb_state() - get PEB state
+ * @kaddr: pointer on fragment's beginning
+ * @item_index: index of item in the fragment
+ * @ptr: pointer on requested PEB state [out]
+ *
+ * This method tries to prepare pointer on the requested
+ * PEB state in the fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL    - invalid input.
+ * %-ERANGE    - internal error.
+ */
+static
+int ssdfs_maptbl_cache_get_peb_state(void *kaddr, u16 item_index,
+				     struct ssdfs_maptbl_cache_peb_state **ptr)
+{
+	struct ssdfs_maptbl_cache_header *hdr;
+	struct ssdfs_maptbl_cache_peb_state *start = NULL;
+	size_t peb_state_size = sizeof(struct ssdfs_maptbl_cache_peb_state);
+	u16 items_count;
+	u32 area_offset = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !ptr);
+
+	SSDFS_DBG("kaddr %p, item_index %u, ptr %p\n",
+		  kaddr, item_index, ptr);
+
+	SSDFS_DBG("PAGE DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr, PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_maptbl_cache_header *)kaddr;
+	items_count = le16_to_cpu(hdr->items_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("CACHE HEADER\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr, 32);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (item_index >= items_count) {
+		SSDFS_ERR("item_index %u >= items_count %u\n",
+			  item_index, items_count);
+		return -EINVAL;
+	}
+
+	start = FIRST_PEB_STATE(kaddr, &area_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PEB STATE START\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     start, 32);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (IS_ERR_OR_NULL(start)) {
+		err = start == NULL ? -ERANGE : PTR_ERR(start);
+		SSDFS_ERR("fail to get area's start pointer: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	*ptr = (struct ssdfs_maptbl_cache_peb_state *)((u8 *)start +
+					    (peb_state_size * item_index));
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MODIFIED ITEM\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     *ptr, 32);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_cache_find_leb() - find LEB ID inside maptbl cache's fragment
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID
+ * @res: pointer on the extracted pair of descriptors [out]
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method tries to find LEB/PEB pair for requested LEB ID
+ * inside of fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL    - invalid input.
+ * %-ERANGE    - internal error.
+ * %-EFAULT    - cache doesn't contain LEB/PEB pair.
+ * %-ENODATA   - try to search in the next fragment.
+ * %-EAGAIN    - try to search the relation LEB/PEB pair in the next page.
+ */
+static
+int ssdfs_maptbl_cache_find_leb(struct ssdfs_maptbl_cache *cache,
+				u64 leb_id,
+				struct ssdfs_maptbl_cache_search_result *res,
+				struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct ssdfs_maptbl_cache_peb_state *peb_state = NULL;
+	struct page *page;
+	unsigned page_index;
+	u16 item_index;
+	struct ssdfs_leb2peb_pair *found;
+	void *kaddr;
+	u64 peb_id = U64_MAX;
+	unsigned i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !res || !pebr);
+	BUG_ON(!rwsem_is_locked(&cache->lock));
+
+	SSDFS_DBG("cache %p, leb_id %llu, res %p, pebr %p\n",
+		  cache, leb_id, res, pebr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(res, 0xFF, sizeof(struct ssdfs_maptbl_cache_search_result));
+	res->pebs[SSDFS_MAPTBL_MAIN_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+	res->pebs[SSDFS_MAPTBL_RELATION_INDEX].state =
+				SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN;
+
+	memset(pebr, 0xFF, sizeof(struct ssdfs_maptbl_peb_relation));
+
+	for (i = 0; i < pagevec_count(&cache->pvec); i++) {
+		page = cache->pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = __ssdfs_maptbl_cache_find_leb(kaddr, i, leb_id, res);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("leb_id %llu, page_index %u, err %d\n",
+			  leb_id, i, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -ENODATA || err == -E2BIG)
+			continue;
+		else if (err == -EAGAIN)
+			continue;
+		else if (err == -EFAULT) {
+			err = -ENODATA;
+			goto finish_leb_id_search;
+		} else if (err == -EEXIST) {
+			err = 0;
+			break;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find LEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_leb_id_search;
+		}
+	}
+
+	if (err == -ENODATA || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find: leb_id %llu\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = -ENODATA;
+		goto finish_leb_id_search;
+	}
+
+	for (i = SSDFS_MAPTBL_MAIN_INDEX; i < SSDFS_MAPTBL_RELATION_MAX; i++) {
+		switch (res->pebs[i].state) {
+		case SSDFS_MAPTBL_CACHE_ITEM_FOUND:
+			page_index = res->pebs[i].page_index;
+			item_index = res->pebs[i].item_index;
+			found = &res->pebs[i].found;
+
+			if (page_index >= pagevec_count(&cache->pvec)) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid page index %u\n",
+					  page_index);
+				goto finish_leb_id_search;
+			}
+
+			page = cache->pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_lock_page(page);
+			kaddr = kmap_local_page(page);
+			err = ssdfs_maptbl_cache_get_peb_state(kaddr,
+								item_index,
+								&peb_state);
+			kunmap_local(kaddr);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to get peb state: "
+					  "item_index %u, err %d\n",
+					  item_index, err);
+				goto finish_leb_id_search;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!peb_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (le64_to_cpu(found->leb_id) != leb_id) {
+				err = -ERANGE;
+				SSDFS_ERR("leb_id1 %llu != leb_id2 %llu\n",
+					  le64_to_cpu(found->leb_id),
+					  leb_id);
+				goto finish_leb_id_search;
+			}
+
+			peb_id = le64_to_cpu(found->peb_id);
+
+			pebr->pebs[i].peb_id = peb_id;
+			pebr->pebs[i].shared_peb_index =
+					peb_state->shared_peb_index;
+			pebr->pebs[i].type =
+					SSDFS_MAPTBL_UNKNOWN_PEB_TYPE;
+			pebr->pebs[i].state = peb_state->state;
+			pebr->pebs[i].flags = peb_state->flags;
+			pebr->pebs[i].consistency = peb_state->consistency;
+			break;
+
+		case SSDFS_MAPTBL_CACHE_ITEM_ABSENT:
+			continue;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("search failure: "
+				  "leb_id %llu, index %u, state %#x\n",
+				  leb_id, i, res->pebs[i].state);
+			goto finish_leb_id_search;
+		}
+	}
+
+finish_leb_id_search:
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_convert_leb2peb_nolock() - cache-based LEB/PEB conversion
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method tries to convert LEB ID into PEB ID on the basis of
+ * mapping table's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - LEB doesn't mapped to PEB yet.
+ */
+int ssdfs_maptbl_cache_convert_leb2peb_nolock(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct ssdfs_maptbl_cache_search_result res;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pebr);
+	BUG_ON(atomic_read(&cache->bytes_count) == 0);
+	BUG_ON(pagevec_count(&cache->pvec) == 0);
+	BUG_ON(atomic_read(&cache->bytes_count) >
+		(pagevec_count(&cache->pvec) * PAGE_SIZE));
+	BUG_ON(atomic_read(&cache->bytes_count) <=
+		((pagevec_count(&cache->pvec) - 1) * PAGE_SIZE));
+	BUG_ON(!rwsem_is_locked(&cache->lock));
+
+	SSDFS_DBG("cache %p, leb_id %llu, pebr %p\n",
+		  cache, leb_id, pebr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_cache_find_leb(cache, leb_id, &res, pebr);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to convert leb %llu to peb\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to convert leb %llu to peb: "
+			  "err %d\n",
+			  leb_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_maptbl_cache_convert_leb2peb() - cache-based LEB/PEB conversion
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method tries to convert LEB ID into PEB ID on the basis of
+ * mapping table's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - LEB doesn't mapped to PEB yet.
+ */
+int __ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pebr);
+	BUG_ON(atomic_read(&cache->bytes_count) == 0);
+	BUG_ON(pagevec_count(&cache->pvec) == 0);
+	BUG_ON(atomic_read(&cache->bytes_count) >
+		(pagevec_count(&cache->pvec) * PAGE_SIZE));
+	BUG_ON(atomic_read(&cache->bytes_count) <=
+		((pagevec_count(&cache->pvec) - 1) * PAGE_SIZE));
+
+	SSDFS_DBG("cache %p, leb_id %llu, pebr %p\n",
+		  cache, leb_id, pebr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&cache->lock);
+	err = ssdfs_maptbl_cache_convert_leb2peb_nolock(cache, leb_id, pebr);
+	up_read(&cache->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_cache_convert_leb2peb() - maptbl cache-based LEB/PEB conversion
+ * @cache: maptbl cache object
+ * @leb_id: LEB ID number
+ * @pebr: description of PEBs relation [out]
+ *
+ * This method tries to convert LEB ID into PEB ID on the basis of
+ * mapping table's cache.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - LEB doesn't mapped to PEB yet.
+ */
+int ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id,
+					struct ssdfs_maptbl_peb_relation *pebr)
+{
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cache || !pebr);
+	BUG_ON(atomic_read(&cache->bytes_count) == 0);
+	BUG_ON(pagevec_count(&cache->pvec) == 0);
+	BUG_ON(atomic_read(&cache->bytes_count) >
+		(pagevec_count(&cache->pvec) * PAGE_SIZE));
+	BUG_ON(atomic_read(&cache->bytes_count) <=
+		((pagevec_count(&cache->pvec) - 1) * PAGE_SIZE));
+
+	SSDFS_DBG("cache %p, leb_id %llu, pebr %p\n",
+		  cache, leb_id, pebr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_maptbl_cache_convert_leb2peb(cache, leb_id, pebr);
+	if (unlikely(err))
+		goto finish_leb2peb_conversion;
+
+	for (i = SSDFS_MAPTBL_MAIN_INDEX; i < SSDFS_MAPTBL_RELATION_MAX; i++) {
+		struct ssdfs_peb_mapping_info *pmi = NULL;
+		int consistency = pebr->pebs[i].consistency;
+		u64 peb_id = pebr->pebs[i].peb_id;
+
+		switch (consistency) {
+		case SSDFS_PEB_STATE_INCONSISTENT:
+		case SSDFS_PEB_STATE_PRE_DELETED:
+			pmi = ssdfs_peb_mapping_info_alloc();
+			if (IS_ERR_OR_NULL(pmi)) {
+				err = !pmi ? -ENOMEM : PTR_ERR(pmi);
+				SSDFS_ERR("fail to alloc PEB mapping info: "
+					  "leb_id %llu, err %d\n",
+					  leb_id, err);
+				goto finish_leb2peb_conversion;
+			}
+
+			ssdfs_peb_mapping_info_init(leb_id, peb_id,
+						    consistency, pmi);
+			ssdfs_peb_mapping_queue_add_tail(&cache->pm_queue, pmi);
+			break;
+		}
+	}
+
+	switch (pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency) {
+	case SSDFS_PEB_STATE_PRE_DELETED:
+		ssdfs_memcpy(&pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX],
+			     0, sizeof(struct ssdfs_maptbl_peb_descriptor),
+			     &pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX],
+			     0, sizeof(struct ssdfs_maptbl_peb_descriptor),
+			     sizeof(struct ssdfs_maptbl_peb_descriptor));
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id = U64_MAX;
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].shared_peb_index =
+									U8_MAX;
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].type =
+						SSDFS_MAPTBL_UNKNOWN_PEB_TYPE;
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].state = U8_MAX;
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].flags = 0;
+		pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency =
+							SSDFS_PEB_STATE_UNKNOWN;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+finish_leb2peb_conversion:
+	return err;
+}
diff --git a/fs/ssdfs/peb_mapping_table_cache.h b/fs/ssdfs/peb_mapping_table_cache.h
new file mode 100644
index 000000000000..803cfb8447a5
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_table_cache.h
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_table_cache.h - PEB mapping table cache declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_PEB_MAPPING_TABLE_CACHE_H
+#define _SSDFS_PEB_MAPPING_TABLE_CACHE_H
+
+#include <linux/ssdfs_fs.h>
+
+/*
+ * struct ssdfs_maptbl_cache - maptbl cache
+ * @lock: lock of maptbl cache
+ * @pvec: memory pages of maptbl cache
+ * @bytes_count: count of bytes in maptbl cache
+ * @pm_queue: PEB mappings queue
+ */
+struct ssdfs_maptbl_cache {
+	struct rw_semaphore lock;
+	struct pagevec pvec;
+	atomic_t bytes_count;
+
+	struct ssdfs_peb_mapping_queue pm_queue;
+};
+
+/*
+ * struct ssdfs_maptbl_cache_item - cache item descriptor
+ * @page_index: index of the found memory page
+ * @item_index: item of found index
+ * @found: found LEB2PEB pair
+ */
+struct ssdfs_maptbl_cache_item {
+#define SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN		(0)
+#define SSDFS_MAPTBL_CACHE_ITEM_FOUND		(1)
+#define SSDFS_MAPTBL_CACHE_ITEM_ABSENT		(2)
+#define SSDFS_MAPTBL_CACHE_SEARCH_ERROR		(3)
+#define SSDFS_MAPTBL_CACHE_SEARCH_MAX		(4)
+	int state;
+	unsigned page_index;
+	u16 item_index;
+	struct ssdfs_leb2peb_pair found;
+};
+
+#define SSDFS_MAPTBL_MAIN_INDEX		(0)
+#define SSDFS_MAPTBL_RELATION_INDEX	(1)
+#define SSDFS_MAPTBL_RELATION_MAX	(2)
+
+/*
+ * struct ssdfs_maptbl_cache_search_result - PEBs association
+ * @pebs: array of PEB descriptors
+ */
+struct ssdfs_maptbl_cache_search_result {
+	struct ssdfs_maptbl_cache_item pebs[SSDFS_MAPTBL_RELATION_MAX];
+};
+
+struct ssdfs_maptbl_peb_relation;
+
+/*
+ * PEB mapping table cache's API
+ */
+void ssdfs_maptbl_cache_init(struct ssdfs_maptbl_cache *cache);
+void ssdfs_maptbl_cache_destroy(struct ssdfs_maptbl_cache *cache);
+
+int ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id,
+					struct ssdfs_maptbl_peb_relation *pebr);
+int ssdfs_maptbl_cache_map_leb2peb(struct ssdfs_maptbl_cache *cache,
+				   u64 leb_id,
+				   struct ssdfs_maptbl_peb_relation *pebr,
+				   int consistency);
+int ssdfs_maptbl_cache_forget_leb2peb(struct ssdfs_maptbl_cache *cache,
+				      u64 leb_id,
+				      int consistency);
+int ssdfs_maptbl_cache_change_peb_state(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id, int peb_state,
+					int consistency);
+int ssdfs_maptbl_cache_add_migration_peb(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id,
+					struct ssdfs_maptbl_peb_relation *pebr,
+					int consistency);
+int ssdfs_maptbl_cache_exclude_migration_peb(struct ssdfs_maptbl_cache *cache,
+					     u64 leb_id,
+					     int consistency);
+
+/*
+ * PEB mapping table cache's internal API
+ */
+struct page *
+ssdfs_maptbl_cache_add_pagevec_page(struct ssdfs_maptbl_cache *cache);
+int ssdfs_maptbl_cache_convert_leb2peb_nolock(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr);
+int __ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr);
+int ssdfs_maptbl_cache_change_peb_state_nolock(struct ssdfs_maptbl_cache *cache,
+						u64 leb_id, int peb_state,
+						int consistency);
+int ssdfs_maptbl_cache_forget_leb2peb_nolock(struct ssdfs_maptbl_cache *cache,
+					     u64 leb_id,
+					     int consistency);
+
+#endif /* _SSDFS_PEB_MAPPING_TABLE_CACHE_H */
-- 
2.34.1

