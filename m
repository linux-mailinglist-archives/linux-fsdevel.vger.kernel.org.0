Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D996A2650
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBYBR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBYBRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:11 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB801352D
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:03 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1720600a5f0so1485488fac.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzHQ2qJYirzEnxrJlmagZL6r6yJZeLJJpIhqMusMgxM=;
        b=Pv66UtNVVAFLnYXclVJm/NLFe23cs5XB5EviuhImlgGKSO5xasuVBDiZaIN+cfbDeM
         SSj3kRs1m9mAUCOrkGqTSZ0ALOIJa/fTQLCC/Z+0yaKSDA7dQ24BMSyn1adFROomMNQu
         cYxTtR2GDo5/a/pPnlJt3POfYPz8suKWjd0Ryy3JuqsMKoKHK1ZQCkQWTEVh8v2D2uIy
         q7FCsDLelQ9g1AXo2sxRpT6jsHVGU0nTC8jAAvlZY/RSKzabzf4NkpIClTGoZF3Ap35L
         IwayejlgeLfw2g+5Ki2bBoaK4kM1eYtNZODASUht0s+J4397kFuRvDmR4QR2AnBG0Xox
         13Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzHQ2qJYirzEnxrJlmagZL6r6yJZeLJJpIhqMusMgxM=;
        b=w9zOG2tpW/1K/CffRIJh1u0Jn+miFAmnWAnLi7rT3vsBdkj5RcQ0c/8fynUG2BndPF
         iNUQObNQSjm1lawOMs7mWthIqNccrsuxGkoFamam39kJv7KMLrN1yaMmYJvLST38CAqY
         Xr6DcO8n/3WpE6pLd2zo+TLPDIUvjUc5zDVCi80JBcnkTDt6YM3Uo6+ojU1OvNj+Sk8t
         q5OPMlGoDrSronMzoYhO3YceSU7wscetttyv6p6okWq+15+Fl9NcCMYc7pU9eCPFD3iA
         Qgc9aVlY5cMLomPsu1JM9IDqRE06kpJ/Xbb9az7mumK0XThlwdCac/2PTpDXCD+dTWRj
         nqSQ==
X-Gm-Message-State: AO0yUKV+UcVpLkqEJUhLxTM4y+D0Jzh0flM2i3tUmKqoZz9RnkzXF1Zu
        WP9YT2iG4s/sRr5luehwySkpRh8Ci1TXLUHN
X-Google-Smtp-Source: AK7set8+mtaTr9GKSKeb9bQKYY+QQSr/Hj6kZB1l84rJJYA6yQqT8y8s1hlAnl7Sor1b+dQLEoKXcg==
X-Received: by 2002:a05:6870:fba9:b0:172:2d00:9a4c with SMTP id kv41-20020a056870fba900b001722d009a4cmr8214852oab.34.1677287821891;
        Fri, 24 Feb 2023 17:17:01 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:01 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 41/76] ssdfs: support migration scheme by PEB state
Date:   Fri, 24 Feb 2023 17:08:52 -0800
Message-Id: <20230225010927.813929-42-slava@dubeyko.com>
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

Migration scheme is the fundamental technique of GC overhead
management in the SSDFS file system. The key responsibility of
the migration scheme is to guarantee the presence of data at
the same segment for any update operations. Generally speaking,
the migration scheme’s model is implemented on the basis of
association an exhausted PEB with a clean one. The goal of such
association of two PEBs is to implement the gradual migration of
data by means of the update operations in the initial (exhausted)
PEB. As a result, the old, exhausted PEB becomes invalidated after
complete data migration and it will be possible to apply
the erase operation to convert it in the clean state. Moreover,
the destination PEB in the association changes the initial PEB
for some index in the segment and, finally, it becomes the only
PEB for this position. Such technique implements the concept of
logical extent with the goal to decrease the write amplification
issue and to manage the GC overhead. Because the logical extent
concept excludes the necessity to update metadata tracking
the position of user data on the file system’s volume.
Generally speaking, the migration scheme is capable to decrease
the GC activity significantly by means of the excluding the necessity
to update metadata and by means of self-migration of data
between of PEBs is triggered by regular update operations.

Mapping table supports two principal operations:
(1) add migration PEB, (2) exclude migration PEB. Operation of
adding migration PEB is required for the case of starting
migration. Exclude migration PEB operation is executed during
finishing migration. Adding migration PEB operation implies
the association an exhausted PEB with a clean one. Excluding
migration PEB operation implies removing completely invalidated
PEB from the association and request to TRIM/erase this PEB.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_mapping_table.c | 2985 ++++++++++++++++++++++++++++++++++
 1 file changed, 2985 insertions(+)

diff --git a/fs/ssdfs/peb_mapping_table.c b/fs/ssdfs/peb_mapping_table.c
index 44995170fe75..490114d77c67 100644
--- a/fs/ssdfs/peb_mapping_table.c
+++ b/fs/ssdfs/peb_mapping_table.c
@@ -8052,3 +8052,2988 @@ int ssdfs_maptbl_recommend_search_range(struct ssdfs_fs_info *fsi,
 
 	return err;
 }
+
+/*
+ * __ssdfs_maptbl_change_peb_state() - change PEB state
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @selected_index: index of item in the whole fragment
+ * @new_peb_state: new state of the PEB
+ * @old_peb_state: old state of the PEB [out]
+ *
+ * This method tries to change the state of the PEB
+ * in the mapping table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EACCES     - PEB stripe is under recovering.
+ * %-EEXIST     - PEB has this state already.
+ */
+static
+int __ssdfs_maptbl_change_peb_state(struct ssdfs_peb_mapping_table *tbl,
+				    struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u64 leb_id,
+				    u16 selected_index,
+				    int new_peb_state,
+				    int *old_peb_state)
+{
+	struct ssdfs_peb_table_fragment_header *hdr;
+	struct ssdfs_peb_descriptor *peb_desc;
+	pgoff_t page_index;
+	struct page *page;
+	void *kaddr;
+	u16 item_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tbl %p, fdesc %p, leb_id %llu, "
+		  "selected_index %u, new_peb_state %#x\n",
+		  tbl, fdesc, leb_id,
+		  selected_index, new_peb_state);
+
+	BUG_ON(!tbl || !fdesc || !old_peb_state);
+	BUG_ON(selected_index >= U16_MAX);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	if (new_peb_state <= SSDFS_MAPTBL_UNKNOWN_PEB_STATE ||
+	    new_peb_state >= SSDFS_MAPTBL_PEB_STATE_MAX) {
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  new_peb_state);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*old_peb_state = SSDFS_MAPTBL_PEB_STATE_MAX;
+
+	page_index = ssdfs_maptbl_define_pebtbl_page(tbl, fdesc,
+						     leb_id, selected_index);
+	if (page_index == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define PEB table's page_index: "
+			  "leb_id %llu\n", leb_id);
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
+		SSDFS_DBG("unable to change the PEB state: "
+			  "leb_id %llu: "
+			  "stripe %u is under recovering\n",
+			  leb_id,
+			  le16_to_cpu(hdr->stripe_id));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_page_processing;
+	}
+
+	item_index = selected_index % fdesc->pebs_per_page;
+
+	peb_desc = GET_PEB_DESCRIPTOR(kaddr, item_index);
+	if (IS_ERR_OR_NULL(peb_desc)) {
+		err = IS_ERR(peb_desc) ? PTR_ERR(peb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "page_index %lu, item_index %u, err %d\n",
+			  page_index, item_index, err);
+		goto finish_page_processing;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("leb_id %llu, item_index %u, "
+		  "old_peb_state %#x, new_peb_state %#x\n",
+		  leb_id, item_index, peb_desc->state, new_peb_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*old_peb_state = peb_desc->state;
+
+	if (peb_desc->state == (u8)new_peb_state) {
+		err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_state1 %#x == peb_state2 %#x\n",
+			  peb_desc->state,
+			  (u8)new_peb_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_page_processing;
+	} else
+		peb_desc->state = (u8)new_peb_state;
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
+ * ssdfs_maptbl_change_peb_state() - change PEB state
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: type of the PEB
+ * @peb_state: new state of the PEB
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to change the state of the PEB
+ * in the mapping table.
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
+ * %-ENODATA    - uninitialized LEB descriptor.
+ */
+int ssdfs_maptbl_change_peb_state(struct ssdfs_fs_info *fsi,
+				  u64 leb_id, u8 peb_type, int peb_state,
+				  struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_cache *cache;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_leb_descriptor leb_desc;
+	struct ssdfs_maptbl_peb_relation pebr;
+	int state;
+	u16 selected_index;
+	int consistency;
+	int old_peb_state = SSDFS_MAPTBL_PEB_STATE_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, leb_id %llu, peb_type %#x, "
+		  "peb_state %#x, init_end %p\n",
+		  fsi, leb_id, peb_type, peb_state, end);
+#else
+	SSDFS_DBG("fsi %p, leb_id %llu, peb_type %#x, "
+		  "peb_state %#x, init_end %p\n",
+		  fsi, leb_id, peb_type, peb_state, end);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+	cache = &tbl->fsi->maptbl_cache;
+	*end = NULL;
+
+	if (peb_state <= SSDFS_MAPTBL_UNKNOWN_PEB_STATE ||
+	    peb_state >= SSDFS_MAPTBL_PEB_STATE_MAX) {
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  peb_state);
+		return -EINVAL;
+	}
+
+	if (!tbl) {
+		err = 0;
+
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_INCONSISTENT;
+			err = ssdfs_maptbl_cache_change_peb_state(cache,
+								  leb_id,
+								  peb_state,
+								  consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change PEB state: "
+					  "leb_id %llu, peb_state %#x, "
+					  "err %d\n",
+					  leb_id, peb_state, err);
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
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_INCONSISTENT;
+			err = ssdfs_maptbl_cache_change_peb_state(cache,
+								  leb_id,
+								  peb_state,
+								  consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change PEB state: "
+					  "leb_id %llu, peb_state %#x, "
+					  "err %d\n",
+					  leb_id, peb_state, err);
+			}
+
+			return err;
+		}
+	}
+
+	if (should_cache_peb_info(peb_type)) {
+		/* resolve potential inconsistency */
+		err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id, peb_type,
+						   &pebr, end);
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
+	if (rwsem_is_locked(&tbl->tbl_lock) &&
+	    atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_INCONSISTENT;
+			err = ssdfs_maptbl_cache_change_peb_state(cache,
+								  leb_id,
+								  peb_state,
+								  consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change PEB state: "
+					  "leb_id %llu, peb_state %#x, "
+					  "err %d\n",
+					  leb_id, peb_state, err);
+			}
+
+			return err;
+		}
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
+		goto finish_change_state;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n",
+			  leb_id);
+		goto finish_change_state;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_change_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (rwsem_is_locked(&fdesc->lock)) {
+		SSDFS_DBG("fragment is locked -> lock fragment: "
+			  "leb_id %llu\n", leb_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, &pebr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb relation: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_fragment_change;
+	}
+
+	switch (peb_state) {
+	case SSDFS_MAPTBL_BAD_PEB_STATE:
+	case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+	case SSDFS_MAPTBL_USING_PEB_STATE:
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_PRE_ERASE_STATE:
+	case SSDFS_MAPTBL_RECOVERING_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		selected_index = le16_to_cpu(leb_desc.physical_index);
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+		selected_index = le16_to_cpu(leb_desc.relation_index);
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (selected_index == U16_MAX) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unitialized leb descriptor: "
+			  "leb_id %llu\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_fragment_change;
+	}
+
+	err = __ssdfs_maptbl_change_peb_state(tbl, fdesc, leb_id,
+					      selected_index,
+					      peb_state,
+					      &old_peb_state);
+	if (err == -EEXIST) {
+		/*
+		 * PEB has this state already.
+		 * Don't set fragment dirty!!!
+		 */
+		goto finish_fragment_change;
+	} else if (err == -EACCES) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to change the PEB state: "
+			  "leb_id %llu: "
+			  "stripe is under recovering\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_fragment_change;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to change the PEB state: "
+			  "leb_id %llu, peb_state %#x, err %d\n",
+			  leb_id, peb_state, err);
+		goto finish_fragment_change;
+	}
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+finish_change_state:
+	up_read(&tbl->tbl_lock);
+
+	if (err == -EAGAIN && should_cache_peb_info(peb_type)) {
+		consistency = SSDFS_PEB_STATE_INCONSISTENT;
+		err = ssdfs_maptbl_cache_change_peb_state(cache,
+							  leb_id,
+							  peb_state,
+							  consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change PEB state: "
+				  "leb_id %llu, peb_state %#x, "
+				  "err %d\n",
+				  leb_id, peb_state, err);
+		}
+	} else if (!err && should_cache_peb_info(peb_type)) {
+		consistency = SSDFS_PEB_STATE_CONSISTENT;
+		err = ssdfs_maptbl_cache_change_peb_state(cache,
+							  leb_id,
+							  peb_state,
+							  consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change PEB state: "
+				  "leb_id %llu, peb_state %#x, "
+				  "err %d\n",
+				  leb_id, peb_state, err);
+		}
+	} else if (err == -EEXIST) {
+		/* PEB has this state already */
+		err = 0;
+
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_CONSISTENT;
+			err = ssdfs_maptbl_cache_change_peb_state(cache,
+								  leb_id,
+								  peb_state,
+								  consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change PEB state: "
+					  "leb_id %llu, peb_state %#x, "
+					  "err %d\n",
+					  leb_id, peb_state, err);
+			}
+		}
+	}
+
+	if (!err && fsi->is_zns_device) {
+		u64 peb_id = U64_MAX;
+
+		err = -ENODATA;
+
+		switch (old_peb_state) {
+		case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+		case SSDFS_MAPTBL_USING_PEB_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_USED_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+			case SSDFS_MAPTBL_PRE_ERASE_STATE:
+			case SSDFS_MAPTBL_RECOVERING_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+				err = 0;
+				selected_index = SSDFS_MAPTBL_MAIN_INDEX;
+				peb_id = pebr.pebs[selected_index].peb_id;
+				break;
+
+			default:
+				/* do nothing */
+				break;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			switch (peb_state) {
+			case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+				err = 0;
+				selected_index = SSDFS_MAPTBL_RELATION_INDEX;
+				peb_id = pebr.pebs[selected_index].peb_id;
+				break;
+
+			default:
+				/* do nothing */
+				break;
+			}
+
+		default:
+			/* do nothing */
+			break;
+		};
+
+		if (!err) {
+			loff_t offset = peb_id * fsi->erasesize;
+
+			err = fsi->devops->close_zone(fsi->sb, offset);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to close zone: "
+					  "offset %llu, err %d\n",
+					  offset, err);
+				return err;
+			}
+		} else
+			err = 0;
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
+ * __ssdfs_maptbl_unmap_dirty_peb() - unmap dirty PEB
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
+int __ssdfs_maptbl_unmap_dirty_peb(struct ssdfs_maptbl_fragment_desc *ptr,
+				   u64 leb_id)
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
+	leb_desc->physical_index = cpu_to_le16(U16_MAX);
+	leb_desc->relation_index = cpu_to_le16(U16_MAX);
+
+	hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(le16_to_cpu(hdr->mapped_lebs) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	le16_add_cpu(&hdr->mapped_lebs, -1);
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
+ * ssdfs_maptbl_prepare_pre_erase_state() - convert dirty PEB into pre-erased
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: type of the PEB
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to convert dirty PEB into pre-erase state
+ * in the mapping table.
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
+ * %-ENODATA    - uninitialized LEB descriptor.
+ * %-EBUSY      - maptbl is under flush operation.
+ */
+int ssdfs_maptbl_prepare_pre_erase_state(struct ssdfs_fs_info *fsi,
+					 u64 leb_id, u8 peb_type,
+					 struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_cache *cache;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_leb_descriptor leb_desc;
+	int state;
+	u16 physical_index, relation_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !end);
+
+	SSDFS_DBG("fsi %p, leb_id %llu, peb_type %#x, "
+		  "init_end %p\n",
+		  fsi, leb_id, peb_type, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+	cache = &tbl->fsi->maptbl_cache;
+	*end = NULL;
+
+	if (!tbl) {
+		SSDFS_WARN("operation is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		SSDFS_DBG("maptbl is under flush\n");
+		return -EBUSY;
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
+		goto finish_change_state;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n",
+			  leb_id);
+		goto finish_change_state;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_change_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (rwsem_is_locked(&fdesc->lock)) {
+		SSDFS_DBG("fragment is locked -> lock fragment: "
+			  "leb_id %llu\n", leb_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
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
+		SSDFS_ERR("leb %llu is under migration\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+	relation_index = le16_to_cpu(leb_desc.relation_index);
+
+	if (relation_index != U16_MAX) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_set_pre_erase_state(fdesc, physical_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move PEB into pre-erase state: "
+			  "index %u, err %d\n",
+			  physical_index, err);
+		goto finish_fragment_change;
+	}
+
+	err = __ssdfs_maptbl_unmap_dirty_peb(fdesc, leb_id);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change leb descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_fragment_change;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(fdesc->mapped_lebs == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fdesc->mapped_lebs--;
+	fdesc->pre_erase_pebs++;
+	atomic_inc(&tbl->pre_erase_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fdesc->pre_erase_pebs %u, tbl->pre_erase_pebs %d\n",
+		  fdesc->pre_erase_pebs,
+		  atomic_read(&tbl->pre_erase_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+	if (should_cache_peb_info(peb_type)) {
+		err = ssdfs_maptbl_cache_forget_leb2peb(cache, leb_id,
+						SSDFS_PEB_STATE_CONSISTENT);
+		if (err == -ENODATA || err == -EFAULT) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("leb_id %llu is not in cache already\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to forget leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_change_state;
+		}
+	}
+
+finish_change_state:
+	wake_up(&tbl->wait_queue);
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
+ * ssdfs_maptbl_set_pre_erased_snapshot_peb() - set snapshot PEB as pre-erased
+ * @fsi: file system info object
+ * @peb_id: PEB ID number
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to convert snapshot PEB into pre-erase state
+ * in the mapping table.
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
+ * %-ENODATA    - uninitialized LEB descriptor.
+ * %-EBUSY      - maptbl is under flush operation.
+ */
+int ssdfs_maptbl_set_pre_erased_snapshot_peb(struct ssdfs_fs_info *fsi,
+					     u64 peb_id,
+					     struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_peb_descriptor peb_desc;
+	int state;
+	u16 physical_index;
+	u64 found_peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !end);
+
+	SSDFS_DBG("fsi %p, peb_id %llu, init_end %p\n",
+		  fsi, peb_id, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+	*end = NULL;
+
+	if (!tbl) {
+		SSDFS_WARN("operation is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		SSDFS_DBG("maptbl is under flush\n");
+		return -EBUSY;
+	}
+
+	down_read(&tbl->tbl_lock);
+
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, peb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "peb_id %llu, err %d\n",
+			  peb_id, err);
+		goto finish_change_state;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: peb_id %llu\n",
+			  peb_id);
+		goto finish_change_state;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: peb_id %llu\n",
+			  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_change_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (rwsem_is_locked(&fdesc->lock)) {
+		SSDFS_DBG("fragment is locked -> lock fragment: "
+			  "peb_id %llu\n", peb_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&fdesc->lock);
+
+	if (peb_id < fdesc->start_leb ||
+	    peb_id > (fdesc->start_leb + fdesc->lebs_count)) {
+		err = -ERANGE;
+		SSDFS_ERR("peb_id %llu is out of range: "
+			  "start_leb %llu, lebs_count %u\n",
+			  peb_id, fdesc->start_leb, fdesc->lebs_count);
+		goto finish_fragment_change;
+	}
+
+	physical_index = peb_id - fdesc->start_leb;
+
+	err = ssdfs_maptbl_get_peb_descriptor(fdesc, physical_index,
+					      &found_peb_id, &peb_desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb descriptor: "
+			  "peb_id %llu, err %d\n",
+			  peb_id, err);
+		goto finish_fragment_change;
+	}
+
+	if (found_peb_id != peb_id) {
+		err = -ERANGE;
+		SSDFS_ERR("corrupted mapping table: "
+			  "found_peb_id %llu != peb_id %llu\n",
+			  found_peb_id, peb_id);
+		goto finish_fragment_change;
+	}
+
+	if (peb_desc.state != SSDFS_MAPTBL_SNAPSHOT_STATE) {
+		err = -ERANGE;
+		SSDFS_ERR("unexpected PEB state: "
+			  "peb_id %llu, state %#x\n",
+			  peb_id, peb_desc.state);
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_set_pre_erase_state(fdesc, physical_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move PEB into pre-erase state: "
+			  "index %u, err %d\n",
+			  physical_index, err);
+		goto finish_fragment_change;
+	}
+
+	fdesc->pre_erase_pebs++;
+	atomic_inc(&tbl->pre_erase_pebs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fdesc->pre_erase_pebs %u, tbl->pre_erase_pebs %d\n",
+		  fdesc->pre_erase_pebs,
+		  atomic_read(&tbl->pre_erase_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, peb_id);
+
+finish_change_state:
+	wake_up(&tbl->wait_queue);
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
+ * has_fragment_reserved_pebs() - check that fragment has reserved PEBs
+ * @hdr: PEB table fragment's header
+ */
+static inline
+bool has_fragment_reserved_pebs(struct ssdfs_peb_table_fragment_header *hdr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+
+	SSDFS_DBG("hdr %p, reserved_pebs %u\n",
+		  hdr, le16_to_cpu(hdr->reserved_pebs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return le16_to_cpu(hdr->reserved_pebs) != 0;
+}
+
+/*
+ * ssdfs_maptbl_select_pebtbl_page() - select page of PEB table
+ * @tbl: pointer on mapping table object
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ *
+ * This method tries to select a page of PEB table.
+ */
+static
+int ssdfs_maptbl_select_pebtbl_page(struct ssdfs_peb_mapping_table *tbl,
+				    struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u64 leb_id, pgoff_t *page_index)
+{
+	pgoff_t start_page;
+	pgoff_t first_valid_page = ULONG_MAX;
+	struct page *page;
+	void *kaddr;
+	struct ssdfs_peb_table_fragment_header *hdr;
+	unsigned long *bmap;
+	u16 pebs_count, used_pebs;
+	u16 unused_pebs, reserved_pebs;
+	bool is_recovering = false;
+	bool has_reserved_pebs = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("maptbl %p, fdesc %p, leb_id %llu\n",
+		  tbl, fdesc, leb_id);
+
+	BUG_ON(!tbl || !fdesc || !page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*page_index = ssdfs_maptbl_define_pebtbl_page(tbl, fdesc,
+						      leb_id, U16_MAX);
+	if (*page_index == ULONG_MAX) {
+		SSDFS_ERR("fail to define PEB table's page_index: "
+			  "leb_id %llu\n", leb_id);
+		return -ERANGE;
+	}
+
+	start_page = *page_index;
+
+try_next_page:
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, *page_index);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: "
+			  "page_index %lu, err %d\n",
+			  *page_index, err);
+		return -ERANGE;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+	used_pebs = bitmap_weight(bmap, pebs_count);
+	unused_pebs = pebs_count - used_pebs;
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+	is_recovering = is_pebtbl_stripe_recovering(hdr);
+
+	has_reserved_pebs = has_fragment_reserved_pebs(hdr);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d, page_index %lu\n",
+		  page, page_ref_count(page), *page_index);
+	SSDFS_DBG("pebs_count %u, used_pebs %u, unused_pebs %u, "
+		  "reserved_pebs %u, is_recovering %#x, "
+		  "has_reserved_pebs %#x\n",
+		  pebs_count, used_pebs, unused_pebs,
+		  reserved_pebs, is_recovering,
+		  has_reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!has_reserved_pebs) {
+		err = ssdfs_maptbl_increase_reserved_pebs(tbl->fsi, fdesc, hdr);
+		if (!err) {
+			reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+			has_reserved_pebs = has_fragment_reserved_pebs(hdr);
+		} else if (err == -ENOSPC && unused_pebs > 0) {
+			/* we can take from the unused pool, anyway */
+			err = 0;
+		}
+	}
+
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find PEB table page: "
+			  "leb_id %llu, page_index %lu\n",
+			  leb_id, *page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		*page_index = ssdfs_maptbl_find_pebtbl_page(tbl, fdesc,
+							    *page_index,
+							    start_page);
+		if (*page_index == ULONG_MAX)
+			goto use_first_valid_page;
+		else {
+			err = 0;
+			goto try_next_page;
+		}
+	} else if (unlikely(err)) {
+		*page_index = ULONG_MAX;
+		SSDFS_ERR("fail to increase reserved pebs: "
+			  "err %d\n", err);
+		goto finish_select_pebtbl_page;
+	}
+
+	if (is_recovering) {
+		*page_index = ssdfs_maptbl_find_pebtbl_page(tbl, fdesc,
+							    *page_index,
+							    start_page);
+		if (*page_index == ULONG_MAX)
+			goto use_first_valid_page;
+		else
+			goto try_next_page;
+	} else if (!has_reserved_pebs) {
+		if (unused_pebs > 0) {
+			first_valid_page = *page_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("take from unused pool: "
+				  "leb_id %llu, unused_pebs %u, "
+				  "reserved_pebs %u\n",
+				  leb_id, unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			*page_index = ULONG_MAX;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find PEB table page: "
+				  "leb_id %llu\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		goto finish_select_pebtbl_page;
+	} else if (unused_pebs > 0) {
+		first_valid_page = *page_index;
+
+		if (unused_pebs < reserved_pebs) {
+			*page_index = ssdfs_maptbl_find_pebtbl_page(tbl, fdesc,
+								    *page_index,
+								    start_page);
+			if (*page_index == ULONG_MAX)
+				goto use_first_valid_page;
+			else
+				goto try_next_page;
+		} else
+			goto finish_select_pebtbl_page;
+	} else
+		goto finish_select_pebtbl_page;
+
+use_first_valid_page:
+	if (first_valid_page >= ULONG_MAX) {
+		if (fdesc->pre_erase_pebs > 0)
+			err = -EBUSY;
+		else
+			err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find PEB table page: "
+			  "leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	*page_index = first_valid_page;
+
+finish_select_pebtbl_page:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %lu\n", *page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_set_peb_descriptor() - change PEB descriptor
+ * @fdesc: fragment descriptor
+ * @pebtbl_page: page index of PEB table
+ * @peb_goal: PEB purpose
+ * @peb_type: type of the PEB
+ * @item_index: item index in the memory page [out]
+ *
+ * This method tries to change PEB descriptor in the PEB table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_peb_descriptor(struct ssdfs_peb_mapping_table *tbl,
+				    struct ssdfs_maptbl_fragment_desc *fdesc,
+				    pgoff_t pebtbl_page,
+				    int peb_goal,
+				    u8 peb_type,
+				    u16 *item_index)
+{
+	struct ssdfs_peb_table_fragment_header *hdr;
+	struct ssdfs_peb_descriptor *peb_desc;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc || !item_index);
+
+	SSDFS_DBG("fdesc %p, pebtbl_page %lu, "
+		  "peb_goal %#x, peb_type %#x\n",
+		  fdesc, pebtbl_page, peb_goal, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*item_index = U16_MAX;
+
+	page = ssdfs_page_array_get_page_locked(&fdesc->array, pebtbl_page);
+	if (IS_ERR_OR_NULL(page)) {
+		err = page == NULL ? -ERANGE : PTR_ERR(page);
+		SSDFS_ERR("fail to find page: "
+			  "page_index %lu, err %d\n",
+			  pebtbl_page, err);
+		return err;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	*item_index = ssdfs_maptbl_select_unused_peb(fdesc, hdr,
+						     tbl->pebs_count,
+						     peb_goal);
+	if (*item_index >= U16_MAX) {
+		err = -ERANGE;
+		SSDFS_DBG("unable to select unused peb\n");
+		goto finish_set_peb_descriptor;
+	}
+
+	peb_desc = GET_PEB_DESCRIPTOR(hdr, *item_index);
+	if (IS_ERR_OR_NULL(peb_desc)) {
+		err = IS_ERR(peb_desc) ? PTR_ERR(peb_desc) : -ERANGE;
+		SSDFS_ERR("fail to get peb_descriptor: "
+			  "index %u, err %d\n",
+			  *item_index, err);
+		goto finish_set_peb_descriptor;
+	}
+
+	peb_desc->type = peb_type;
+	peb_desc->state = SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE;
+
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+	err = ssdfs_page_array_set_page_dirty(&fdesc->array,
+					      pebtbl_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu dirty: err %d\n",
+			  pebtbl_page, err);
+	}
+
+finish_set_peb_descriptor:
+	flush_dcache_page(page);
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
+ * ssdfs_maptbl_set_leb_descriptor() - change LEB descriptor
+ * @fdesc: fragment descriptor
+ * @leb_id: LEB ID number
+ * @pebtbl_page: page index of PEB table
+ * @item_index: item index in the memory page
+ *
+ * This method tries to change LEB descriptor in the LEB table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_leb_descriptor(struct ssdfs_maptbl_fragment_desc *fdesc,
+				    u64 leb_id, pgoff_t pebtbl_page,
+				    u16 item_index)
+{
+	struct ssdfs_leb_descriptor *leb_desc;
+	struct ssdfs_leb_table_fragment_header *lebtbl_hdr;
+	pgoff_t lebtbl_page;
+	u16 peb_index;
+	struct page *page;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, leb_id %llu, pebtbl_page %lu, "
+		  "item_index %u\n",
+		  fdesc, leb_id, pebtbl_page, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	peb_index = DEFINE_PEB_INDEX_IN_FRAGMENT(fdesc,
+						 pebtbl_page,
+						 item_index);
+	if (peb_index == U16_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define peb index\n");
+		goto finish_page_processing;
+	}
+
+	leb_desc->relation_index = cpu_to_le16(peb_index);
+
+	lebtbl_hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+	le16_add_cpu(&lebtbl_hdr->migrating_lebs, 1);
+
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+	err = ssdfs_page_array_set_page_dirty(&fdesc->array,
+					      lebtbl_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu dirty: err %d\n",
+			  lebtbl_page, err);
+	}
+
+finish_page_processing:
+	flush_dcache_page(page);
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
+ * ssdfs_maptbl_add_migration_peb() - associate PEB for migration
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: type of the PEB
+ * @pebr: description of PEBs relation [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to add in the pair destination PEB for
+ * data migration.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find PEB for migration.
+ * %-EEXIST     - LEB is under migration yet.
+ */
+int ssdfs_maptbl_add_migration_peb(struct ssdfs_fs_info *fsi,
+				   u64 leb_id, u8 peb_type,
+				   struct ssdfs_maptbl_peb_relation *pebr,
+				   struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_cache *cache;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	pgoff_t pebtbl_page = ULONG_MAX;
+	u16 item_index;
+	int consistency;
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
+	tbl = fsi->maptbl;
+	cache = &tbl->fsi->maptbl_cache;
+	*end = NULL;
+
+	memset(pebr, 0xFF, sizeof(struct ssdfs_maptbl_peb_relation));
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
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_add_migrating_peb;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n", leb_id);
+		goto finish_add_migrating_peb;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_add_migrating_peb;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (rwsem_is_locked(&fdesc->lock)) {
+		SSDFS_DBG("fragment is locked -> lock fragment: "
+			  "leb_id %llu\n", leb_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
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
+		err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, pebr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+		} else {
+			err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("leb %llu is under migration yet\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_select_pebtbl_page(tbl, fdesc, leb_id, &pebtbl_page);
+	if (unlikely(err)) {
+		SSDFS_DBG("unable to find the peb table's page\n");
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_set_peb_descriptor(tbl, fdesc, pebtbl_page,
+						SSDFS_MAPTBL_MIGRATING_PEB,
+						peb_type, &item_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set PEB descriptor: "
+			  "pebtbl_page %lu, "
+			  "peb_type %#x, err %d\n",
+			  pebtbl_page,
+			  peb_type, err);
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_set_leb_descriptor(fdesc, leb_id,
+					      pebtbl_page,
+					      item_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set LEB descriptor: "
+			  "leb_id %llu, pebtbl_page %lu, "
+			  "item_index %u, err %d\n",
+			  leb_id, pebtbl_page,
+			  item_index, err);
+		goto finish_fragment_change;
+	}
+
+	fdesc->migrating_lebs++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u\n",
+		  fdesc->mapped_lebs, fdesc->migrating_lebs);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb relation: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_fragment_change;
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
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+finish_add_migrating_peb:
+	up_read(&tbl->tbl_lock);
+
+	if (!err && should_cache_peb_info(peb_type)) {
+		consistency = SSDFS_PEB_STATE_CONSISTENT;
+		err = ssdfs_maptbl_cache_add_migration_peb(cache, leb_id,
+							   pebr,
+							   consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add migration PEB: "
+				  "leb_id %llu, peb_id %llu, err %d\n",
+				leb_id,
+				pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+				err);
+			err = -EFAULT;
+		}
+	}
+
+	if (!err) {
+		u64 peb_id = pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id;
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
+ * need_erase_peb_now() - does it need to erase PEB now?
+ * @fdesc: fragment descriptor
+ */
+static inline
+bool need_erase_peb_now(struct ssdfs_maptbl_fragment_desc *fdesc)
+{
+	u32 percentage;
+	u32 unused_lebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	percentage = (fdesc->pre_erase_pebs * 100) / fdesc->lebs_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lebs_count %u, pre_erase_pebs %u, "
+		  "percentage %u\n",
+		  fdesc->lebs_count,
+		  fdesc->pre_erase_pebs,
+		  percentage);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (percentage > SSDFS_PRE_ERASE_PEB_THRESHOLD_PCT)
+		return true;
+
+	unused_lebs = fdesc->lebs_count;
+	unused_lebs -= fdesc->mapped_lebs;
+	unused_lebs -= fdesc->migrating_lebs;
+	unused_lebs -= fdesc->pre_erase_pebs;
+	unused_lebs -= fdesc->recovering_pebs;
+
+	percentage = (unused_lebs * 100) / fdesc->lebs_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lebs_count %u, mapped_lebs %u, "
+		  "migrating_lebs %u, pre_erase_pebs %u, "
+		  "recovering_pebs %u, reserved_pebs %u, "
+		  "percentage %u\n",
+		  fdesc->lebs_count, fdesc->mapped_lebs,
+		  fdesc->migrating_lebs, fdesc->pre_erase_pebs,
+		  fdesc->recovering_pebs, fdesc->reserved_pebs,
+		  percentage);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (percentage <= SSDFS_UNUSED_LEB_THRESHOLD_PCT)
+		return true;
+
+	return false;
+}
+
+/*
+ * ssdfs_maptbl_erase_reserved_peb_now() - erase reserved dirty PEB
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to erase a reserved dirty PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_erase_reserved_peb_now(struct ssdfs_fs_info *fsi,
+					u64 leb_id, u8 peb_type,
+					struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+	struct ssdfs_erase_result res;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 physical_index;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !end);
+
+	SSDFS_DBG("fsi %p, leb_id %llu, init_end %p\n",
+		  fsi, leb_id, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+	*end = NULL;
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH)
+		BUG();
+
+	down_read(&tbl->tbl_lock);
+
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_erase_reserved_peb;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n", leb_id);
+		goto finish_erase_reserved_peb;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_erase_reserved_peb;
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
+		SSDFS_ERR("leb %llu has not been mapped yet\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+
+	err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, &pebr);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to get peb relation: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_fragment_change;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get peb relation: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_set_under_erase_state(fdesc, physical_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set PEB as under erase state: "
+			  "index %u, err %d\n",
+			  physical_index, err);
+		goto finish_fragment_change;
+	}
+
+	ptr = &pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX];
+	peb_id = ptr->peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("erase peb_id %llu now\n",
+		  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	SSDFS_ERASE_RESULT_INIT(fdesc->fragment_id, physical_index,
+				peb_id, SSDFS_ERASE_RESULT_UNKNOWN,
+				&res);
+
+	up_write(&fdesc->lock);
+	err = ssdfs_maptbl_erase_peb(fsi, &res);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to erase: "
+			  "peb_id %llu, err %d\n",
+			  peb_id, err);
+		goto finish_erase_reserved_peb;
+	}
+	down_write(&fdesc->lock);
+
+	switch (res.state) {
+	case SSDFS_ERASE_DONE:
+		res.state = SSDFS_ERASE_SB_PEB_DONE;
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to erase: peb_id %llu\n",
+			  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+	}
+
+	fdesc->pre_erase_pebs++;
+	atomic_inc(&tbl->pre_erase_pebs);
+
+	err = ssdfs_maptbl_correct_dirty_peb(tbl, fdesc, &res);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct dirty PEB's state: "
+			  "err %d\n", err);
+		goto finish_fragment_change;
+	}
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+finish_erase_reserved_peb:
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
+ * is_ssdfs_peb_contains_snapshot() - check that PEB contains snapshot
+ * @fsi: file system info object
+ * @peb_type: PEB type
+ * @peb_create_time: PEB creation time
+ * @last_log_time: last log creation time
+ *
+ * This method tries to check that PEB contains a snapshot.
+ */
+static
+bool is_ssdfs_peb_contains_snapshot(struct ssdfs_fs_info *fsi,
+				    u8 peb_type,
+				    u64 peb_create_time,
+				    u64 last_log_time)
+{
+	struct ssdfs_snapshots_btree_info *tree;
+	struct ssdfs_btree_search *search = NULL;
+	struct ssdfs_timestamp_range range;
+	bool is_contains_snapshot = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("peb_type %#x, peb_create_time %llu, "
+		  "last_log_time %llu\n",
+		  peb_type, peb_create_time,
+		  last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (peb_type) {
+	case SSDFS_MAPTBL_DATA_PEB_TYPE:
+	case SSDFS_MAPTBL_LNODE_PEB_TYPE:
+	case SSDFS_MAPTBL_HNODE_PEB_TYPE:
+	case SSDFS_MAPTBL_IDXNODE_PEB_TYPE:
+		/* continue logic */
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PEB hasn't snapshot: "
+			  "peb_type %#x\n",
+			  peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	tree = fsi->snapshots.tree;
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate btree search object\n");
+		goto finish_search_snapshots_range;
+	}
+
+	range.start = peb_create_time;
+	range.end = last_log_time;
+
+	ssdfs_btree_search_init(search);
+	err = ssdfs_snapshots_btree_check_range(tree, &range, search);
+	if (err == -ENODATA) {
+		err = 0;
+		is_contains_snapshot = false;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find snapshot: "
+			  "start_timestamp %llu, end_timestamp %llu\n",
+			  peb_create_time, last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (err == -EAGAIN) {
+		err = 0;
+		is_contains_snapshot = true;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("snapshots have been found: "
+			  "start_timestamp %llu, end_timestamp %llu\n",
+			  peb_create_time, last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_WARN("fail to find snapshot: "
+			  "start_timestamp %llu, end_timestamp %llu, "
+			  "err %d\n",
+			  peb_create_time, last_log_time, err);
+	} else {
+		is_contains_snapshot = true;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("snapshots have been found: "
+			  "start_timestamp %llu, end_timestamp %llu\n",
+			  peb_create_time, last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+finish_search_snapshots_range:
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err))
+		return false;
+
+	return is_contains_snapshot;
+}
+
+/*
+ * ssdfs_maptbl_exclude_migration_peb() - exclude PEB from migration
+ * @fsi: file system info object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @peb_create_time: PEB creation time
+ * @last_log_time: last log creation time
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to exclude PEB from migration association.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_exclude_migration_peb(struct ssdfs_fs_info *fsi,
+					u64 leb_id, u8 peb_type,
+					u64 peb_create_time,
+					u64 last_log_time,
+					struct completion **end)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_cache *cache;
+	struct ssdfs_snapshots_btree_info *snap_tree;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+	struct ssdfs_erase_result res;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 physical_index, relation_index;
+	int consistency;
+	u64 peb_id;
+	bool need_erase = false;
+	bool peb_contains_snapshot = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, leb_id %llu, init_end %p\n",
+		  fsi, leb_id, end);
+#else
+	SSDFS_DBG("fsi %p, leb_id %llu, init_end %p\n",
+		  fsi, leb_id, end);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tbl = fsi->maptbl;
+	cache = &tbl->fsi->maptbl_cache;
+	snap_tree = fsi->snapshots.tree;
+	*end = NULL;
+
+	if (!tbl) {
+		err = 0;
+
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_PRE_DELETED;
+			err = ssdfs_maptbl_cache_exclude_migration_peb(cache,
+								leb_id,
+								consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to exclude migration PEB: "
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
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_PRE_DELETED;
+			err = ssdfs_maptbl_cache_exclude_migration_peb(cache,
+								leb_id,
+								consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to exclude migration PEB: "
+					  "leb_id %llu, err %d\n",
+					  leb_id, err);
+			}
+
+			return err;
+		}
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
+	if (rwsem_is_locked(&tbl->tbl_lock) &&
+	    atomic_read(&tbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH) {
+		if (should_cache_peb_info(peb_type)) {
+			consistency = SSDFS_PEB_STATE_PRE_DELETED;
+			err = ssdfs_maptbl_cache_exclude_migration_peb(cache,
+								leb_id,
+								consistency);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to exclude migration PEB: "
+					  "leb_id %llu, err %d\n",
+					  leb_id, err);
+			}
+
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_create_time %llx, last_log_time %llx\n",
+		  peb_create_time, last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_contains_snapshot = is_ssdfs_peb_contains_snapshot(fsi, peb_type,
+								peb_create_time,
+								last_log_time);
+
+	down_read(&tbl->tbl_lock);
+
+	fdesc = ssdfs_maptbl_get_fragment_descriptor(tbl, leb_id);
+	if (IS_ERR_OR_NULL(fdesc)) {
+		err = IS_ERR(fdesc) ? PTR_ERR(fdesc) : -ERANGE;
+		SSDFS_ERR("fail to get fragment descriptor: "
+			  "leb_id %llu, err %d\n",
+			  leb_id, err);
+		goto finish_exclude_migrating_peb;
+	}
+
+	*end = &fdesc->init_end;
+
+	state = atomic_read(&fdesc->state);
+	if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		err = -EFAULT;
+		SSDFS_ERR("fragment is corrupted: leb_id %llu\n", leb_id);
+		goto finish_exclude_migrating_peb;
+	} else if (state == SSDFS_MAPTBL_FRAG_CREATED) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_exclude_migrating_peb;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (rwsem_is_locked(&fdesc->lock)) {
+		SSDFS_DBG("fragment is locked -> lock fragment: "
+			  "leb_id %llu\n", leb_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
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
+		SSDFS_ERR("leb %llu has not been mapped yet\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	if (!is_leb_migrating(&leb_desc)) {
+		err = -ERANGE;
+		SSDFS_ERR("leb %llu isn't under migration\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	physical_index = le16_to_cpu(leb_desc.physical_index);
+	relation_index = le16_to_cpu(leb_desc.relation_index);
+
+	need_erase = need_erase_peb_now(fdesc);
+
+	if (peb_contains_snapshot) {
+		struct ssdfs_peb_timestamps peb2time;
+		struct ssdfs_btree_search *search = NULL;
+
+		need_erase = false;
+
+		err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, &pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_fragment_change;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_fragment_change;
+		}
+
+		err = ssdfs_maptbl_set_snapshot_state(fdesc, physical_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into snapshot state: "
+				  "index %u, err %d\n",
+				  physical_index, err);
+			goto finish_fragment_change;
+		}
+
+		peb2time.peb_id = pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+		peb2time.create_time = peb_create_time;
+		peb2time.last_log_time = last_log_time;
+
+		search = ssdfs_btree_search_alloc();
+		if (!search) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate btree search object\n");
+			goto finish_fragment_change;
+		}
+
+		ssdfs_btree_search_init(search);
+		err = ssdfs_snapshots_btree_add_peb2time(snap_tree, &peb2time,
+							 search);
+		ssdfs_btree_search_free(search);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add peb2time: "
+				  "peb_id %llu, peb_create_time %llu, "
+				  "last_log_time %llu, err %d\n",
+				  peb2time.peb_id, peb2time.create_time,
+				  peb2time.last_log_time, err);
+			goto finish_fragment_change;
+		}
+
+		err = ssdfs_maptbl_set_source_state(fdesc, relation_index,
+					    SSDFS_MAPTBL_UNKNOWN_PEB_STATE);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into source state: "
+				  "index %u, err %d\n",
+				  relation_index, err);
+			goto finish_fragment_change;
+		}
+
+		err = __ssdfs_maptbl_exclude_migration_peb(fdesc, leb_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change leb descriptor: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_fragment_change;
+		}
+	} else if (need_erase) {
+		err = ssdfs_maptbl_get_peb_relation(fdesc, &leb_desc, &pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_fragment_change;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to get peb relation: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_fragment_change;
+		}
+
+		err = ssdfs_maptbl_set_under_erase_state(fdesc, physical_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set PEB as under erase state: "
+				  "index %u, err %d\n",
+				  physical_index, err);
+			goto finish_fragment_change;
+		}
+
+		err = ssdfs_maptbl_set_source_state(fdesc, relation_index,
+					    SSDFS_MAPTBL_UNKNOWN_PEB_STATE);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into source state: "
+				  "index %u, err %d\n",
+				  relation_index, err);
+			goto finish_fragment_change;
+		}
+
+		err = __ssdfs_maptbl_exclude_migration_peb(fdesc, leb_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change leb descriptor: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_fragment_change;
+		}
+
+		ptr = &pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX];
+		peb_id = ptr->peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("erase peb_id %llu now\n",
+			  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		SSDFS_ERASE_RESULT_INIT(fdesc->fragment_id, physical_index,
+					peb_id, SSDFS_ERASE_RESULT_UNKNOWN,
+					&res);
+
+		up_write(&fdesc->lock);
+		err = ssdfs_maptbl_erase_peb(fsi, &res);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to erase: "
+				  "peb_id %llu, err %d\n",
+				  peb_id, err);
+			goto finish_exclude_migrating_peb;
+		}
+		down_write(&fdesc->lock);
+
+		switch (res.state) {
+		case SSDFS_ERASE_DONE:
+			/* expected state */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to erase: peb_id %llu\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		}
+	} else {
+		err = ssdfs_maptbl_set_pre_erase_state(fdesc, physical_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into pre-erase state: "
+				  "index %u, err %d\n",
+				  physical_index, err);
+			goto finish_fragment_change;
+		}
+
+		err = ssdfs_maptbl_set_source_state(fdesc, relation_index,
+					    SSDFS_MAPTBL_UNKNOWN_PEB_STATE);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move PEB into source state: "
+				  "index %u, err %d\n",
+				  relation_index, err);
+			goto finish_fragment_change;
+		}
+
+		err = __ssdfs_maptbl_exclude_migration_peb(fdesc, leb_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change leb descriptor: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_fragment_change;
+		}
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
+	if (need_erase) {
+		err = ssdfs_maptbl_correct_dirty_peb(tbl, fdesc, &res);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to correct dirty PEB's state: "
+				  "err %d\n", err);
+			goto finish_fragment_change;
+		}
+	}
+
+	wake_up(&tbl->wait_queue);
+
+finish_fragment_change:
+	up_write(&fdesc->lock);
+
+	if (!err)
+		ssdfs_maptbl_set_fragment_dirty(tbl, fdesc, leb_id);
+
+finish_exclude_migrating_peb:
+	up_read(&tbl->tbl_lock);
+
+	if (err == -EAGAIN && should_cache_peb_info(peb_type)) {
+		consistency = SSDFS_PEB_STATE_PRE_DELETED;
+		err = ssdfs_maptbl_cache_exclude_migration_peb(cache,
+								leb_id,
+								consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to exclude migration PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+		}
+	} else if (!err && should_cache_peb_info(peb_type)) {
+		consistency = SSDFS_PEB_STATE_CONSISTENT;
+		err = ssdfs_maptbl_cache_exclude_migration_peb(cache,
+								leb_id,
+								consistency);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to exclude migration PEB: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+		}
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
+ * ssdfs_maptbl_set_peb_as_shared() - set destination PEB as shared
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ * @peb_type: PEB type
+ *
+ * This method tries to set SSDFS_MAPTBL_SHARED_DESTINATION_PEB flag
+ * in destination PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_peb_as_shared(struct ssdfs_maptbl_fragment_desc *fdesc,
+				   u16 index, u8 peb_type)
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
+	if (peb_type != ptr->type) {
+		err = -ERANGE;
+		SSDFS_ERR("peb_type %#x != ptr->type %#x\n",
+			  peb_type, ptr->type);
+		goto finish_page_processing;
+	}
+
+	switch (ptr->state) {
+	case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+		/* valid state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  ptr->state);
+		goto finish_page_processing;
+	}
+
+	if (ptr->flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR ||
+	    ptr->shared_peb_index != U16_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("corrupted PEB desriptor\n");
+		goto finish_page_processing;
+	}
+
+	ptr->flags |= SSDFS_MAPTBL_SHARED_DESTINATION_PEB;
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
+ * ssdfs_maptbl_set_shared_destination_peb() - set destination PEB as shared
+ * @tbl: pointer on mapping table object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to set SSDFS_MAPTBL_SHARED_DESTINATION_PEB flag
+ * in destination PEB.
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
+int ssdfs_maptbl_set_shared_destination_peb(struct ssdfs_peb_mapping_table *tbl,
+					    u64 leb_id, u8 peb_type,
+					    struct completion **end)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 relation_index;
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
+	if (!is_leb_migrating(&leb_desc)) {
+		err = -ERANGE;
+		SSDFS_ERR("leb %llu isn't under migration\n",
+			  leb_id);
+		goto finish_fragment_change;
+	}
+
+	relation_index = le16_to_cpu(leb_desc.relation_index);
+
+	if (relation_index == U16_MAX) {
+		err = -ENODATA;
+		SSDFS_DBG("unitialized leb descriptor\n");
+		goto finish_fragment_change;
+	}
+
+	err = ssdfs_maptbl_set_peb_as_shared(fdesc, relation_index,
+					     peb_type);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set shared destination PEB: "
+			  "relation_index %u, err %d\n",
+			  relation_index, err);
+		goto finish_fragment_change;
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
+ * ssdfs_maptbl_set_external_peb_ptr() - define PEB as external pointer
+ * @fdesc: fragment descriptor
+ * @index: PEB index in the fragment
+ * @peb_type: PEB type
+ * @dst_peb_index: destination PEB index
+ *
+ * This method tries to define index of destination PEB and to set
+ * SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_set_external_peb_ptr(struct ssdfs_maptbl_fragment_desc *fdesc,
+				      u16 index, u8 peb_type,
+				      u16 dst_peb_index)
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
+	switch (ptr->state) {
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+		ptr->state = SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE;
+		break;
+
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+		ptr->state = SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  ptr->state);
+		goto finish_page_processing;
+	}
+
+	if (dst_peb_index >= U8_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid dst_peb_index %u\n",
+			  dst_peb_index);
+		goto finish_page_processing;
+	}
+
+	ptr->shared_peb_index = (u8)dst_peb_index;
+	ptr->flags |= SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR;
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
+ * __ssdfs_maptbl_set_indirect_relation() - set destination PEB as shared
+ * @tbl: pointer on mapping table object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @dst_peb_index: destination PEB index
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to define index of destination PEB and to set
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
+int __ssdfs_maptbl_set_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					 u64 leb_id, u8 peb_type,
+					 u16 dst_peb_index,
+					 struct completion **end)
+{
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	struct ssdfs_leb_descriptor leb_desc;
+	u16 physical_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !end);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, peb_type %#x, "
+		  "dst_peb_index %u\n",
+		  tbl, leb_id, peb_type, dst_peb_index);
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
+	err = ssdfs_maptbl_set_external_peb_ptr(fdesc, physical_index,
+						peb_type, dst_peb_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set external PEB pointer: "
+			  "physical_index %u, err %d\n",
+			  physical_index, err);
+		goto finish_fragment_change;
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
+ * ssdfs_maptbl_set_indirect_relation() - set PEBs indirect relation
+ * @tbl: pointer on mapping table object
+ * @leb_id: source LEB ID number
+ * @peb_type: PEB type
+ * @dst_leb_id: destination LEB ID number
+ * @dst_peb_index: destination PEB index
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to set SSDFS_MAPTBL_SHARED_DESTINATION_PEB flag
+ * in destination PEB. Then it tries to define index of destination PEB
+ * and to set SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR flag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - maptbl has inconsistent state.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_maptbl_set_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					u64 leb_id, u8 peb_type,
+					u64 dst_leb_id, u16 dst_peb_index,
+					struct completion **end)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !end);
+
+	SSDFS_DBG("maptbl %p, leb_id %llu, "
+		  "peb_type %#x, dst_peb_index %u\n",
+		  tbl, leb_id, peb_type, dst_peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*end = NULL;
+	fsi = tbl->fsi;
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
+	err = ssdfs_maptbl_set_shared_destination_peb(tbl, dst_leb_id,
+						      peb_type, end);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  dst_leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_set_indirect_relation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to set shared destination PEB: "
+			  "dst_leb_id %llu, err %u\n",
+			  dst_leb_id, err);
+		goto finish_set_indirect_relation;
+	}
+
+	err = __ssdfs_maptbl_set_indirect_relation(tbl, leb_id, peb_type,
+						   dst_peb_index, end);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment is under initialization: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_set_indirect_relation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to set indirect relation: "
+			  "leb_id %llu, err %u\n",
+			  leb_id, err);
+		goto finish_set_indirect_relation;
+	}
+
+finish_set_indirect_relation:
+	up_read(&tbl->tbl_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
-- 
2.34.1

