Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47FB6A263E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBYBRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBYBQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86A14E8D
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:24 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so791863oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ksZ0t2YKR8B6C7nF1sfXOGTZ6hq9F6b8Rj3jN9XECU=;
        b=A47uAJ8RGbZTFkaTnQGFUBjeu6xaaQXDaEUaoy/ph3I/C2HvrhyKLkft0+iQsjXkRi
         5ds4QuxNa6ZJoPm+dZv9cB/rNXiGxbAal+y1j/vB6bFra02LmaoMv5XQhTVVZSzKU/cr
         J1S12czGfBJa/Y9g5nZM3knystCjaJjnvcIbe6eOy34xmZmerZ+eGOAuCjeyF1kooiwk
         vFJPrlVLSBITWpM1gH37X5p31ca5PruqTIRhrW4jZSb2EEHjvGbx4fBL8I5SIPqGVnw9
         I9TtbK4iM5OJbTbKahkXRMdpQl15vWmNm4HKCqEzALR/dqNyEVUrBZmKEVdw7mSYTB4h
         wqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ksZ0t2YKR8B6C7nF1sfXOGTZ6hq9F6b8Rj3jN9XECU=;
        b=MVPG2usWRR6rNXYOsn4sT+Ax8k0gyA/zSKkDQ2CE5geKO9DDFUb4L9XFxxd69Gxi2A
         WcborZliL6LZJLmA9uTtCMs+/XUR25Vw+91pGTyKcRL9gw0rcacOLSEJhVE+r9CJdaWp
         E6zJju8xkuG/A6nmt/yDBpefZt0vZ/T3ckDUigEL58R5CKb8wzpcRNhlqb6EPejdQj03
         EnQvpe4NRDgM/szX9f8yTMa0PSAPllps2SO+c6QsFP1vFx+3bPI0w3IsUssXdHaUWd7Y
         ulFXLNJgfvof65CWG8p9Uli6YLS7ZvXp+irdn/eb2/j+OUY4243iNSwQ+jL8x9wGTxYJ
         kEpA==
X-Gm-Message-State: AO0yUKWxKJhKWqXL3wOoft7StVOGxn3XIEVXF/Uuu1+9epmYWmgplhhJ
        8peNDYe4hidWi/HtKDewkoijRNiT8Q1110l7
X-Google-Smtp-Source: AK7set/nw55YWCFUZdgQl0DEqUhg0sekd9jfU38pI1B8gD5qse0EFKPZ1V5epmYZkZjBoK9lfRNOnw==
X-Received: by 2002:a05:6808:2981:b0:37f:8776:7fb with SMTP id ex1-20020a056808298100b0037f877607fbmr6804654oib.24.1677287783465;
        Fri, 24 Feb 2023 17:16:23 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:22 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 23/76] ssdfs: PEB container API implementation
Date:   Fri, 24 Feb 2023 17:08:34 -0800
Message-Id: <20230225010927.813929-24-slava@dubeyko.com>
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

This patch implements PEB container's API logic.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_container.c | 2980 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 2980 insertions(+)

diff --git a/fs/ssdfs/peb_container.c b/fs/ssdfs/peb_container.c
index 668ded673719..92798bcbe8b7 100644
--- a/fs/ssdfs/peb_container.c
+++ b/fs/ssdfs/peb_container.c
@@ -2667,3 +2667,2983 @@ void ssdfs_peb_container_destroy(struct ssdfs_peb_container *ptr)
 	SSDFS_DBG("finished\n");
 #endif /* CONFIG_SSDFS_TRACK_API_CALL */
 }
+
+/*
+ * ssdfs_peb_container_prepare_relation() - prepare relation with destination
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to create the relation between source of @ptr
+ * and existing destination in another PEB container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_container_prepare_relation(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_mapping_table *maptbl;
+	struct ssdfs_migration_destination *destination;
+	struct ssdfs_peb_container *relation;
+	int shared_index;
+	int destination_state;
+	u16 peb_index, dst_peb_index;
+	u64 leb_id, dst_leb_id;
+	struct completion *end;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!mutex_is_locked(&ptr->migration_lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	maptbl = fsi->maptbl;
+	si = ptr->parent_si;
+	peb_index = ptr->peb_index;
+
+try_define_relation:
+	destination = &si->migration.array[SSDFS_LAST_DESTINATION];
+
+	spin_lock(&si->migration.lock);
+	destination_state = destination->state;
+	shared_index = destination->shared_peb_index;
+	spin_unlock(&si->migration.lock);
+
+	switch (destination_state) {
+	case SSDFS_VALID_DESTINATION:
+		/* do nothing here */
+		break;
+
+	case SSDFS_DESTINATION_UNDER_CREATION:
+		/* FALLTHRU */
+		fallthrough;
+	case SSDFS_OBSOLETE_DESTINATION: {
+			DEFINE_WAIT(wait);
+
+			mutex_unlock(&ptr->migration_lock);
+			prepare_to_wait(&ptr->migration_wq, &wait,
+					TASK_UNINTERRUPTIBLE);
+			schedule();
+			finish_wait(&ptr->migration_wq, &wait);
+			mutex_lock(&ptr->migration_lock);
+			goto try_define_relation;
+		}
+		break;
+
+	case SSDFS_EMPTY_DESTINATION:
+		SSDFS_ERR("destination is empty\n");
+		return -ERANGE;
+
+	default:
+		BUG();
+	}
+
+	if (shared_index < 0 || shared_index >= si->pebs_count) {
+		SSDFS_ERR("invalid shared_index %d\n",
+			  shared_index);
+		return -ERANGE;
+	}
+
+	relation = &si->peb_array[shared_index];
+
+	destination_state = atomic_read(&relation->migration_state);
+	switch (destination_state) {
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+		SSDFS_ERR("destination PEB is under preparation: "
+			  "shared_index %d\n",
+			  shared_index);
+		return -ERANGE;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		switch (atomic_read(&relation->items_state)) {
+		case SSDFS_PEB1_DST_CONTAINER:
+		case SSDFS_PEB2_DST_CONTAINER:
+		case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+			/* do nothing */
+			break;
+
+		default:
+			SSDFS_WARN("invalid relation state: "
+				   "shared_index %d\n",
+				   shared_index);
+			return -ERANGE;
+		}
+
+		down_read(&relation->lock);
+
+		if (!relation->dst_peb) {
+			err = -ERANGE;
+			SSDFS_ERR("dst_peb is NULL\n");
+			goto finish_define_relation;
+		}
+
+		ptr->dst_peb = relation->dst_peb;
+		atomic_inc(&relation->dst_peb_refs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_id %llu, dst_peb_refs %d\n",
+			  relation->dst_peb->peb_id,
+			  atomic_read(&relation->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_define_relation:
+		up_read(&relation->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define relation: "
+				  "shared_index %d\n",
+				  shared_index);
+			return err;
+		}
+
+		leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+							si->seg_id,
+							peb_index);
+		if (leb_id >= U64_MAX) {
+			SSDFS_ERR("fail to convert PEB index into LEB ID: "
+				  "seg %llu, peb_index %u\n",
+				  si->seg_id, peb_index);
+			return -ERANGE;
+		}
+
+		dst_peb_index = ptr->dst_peb->peb_index;
+
+		dst_leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+							    si->seg_id,
+							    dst_peb_index);
+		if (dst_leb_id >= U64_MAX) {
+			SSDFS_ERR("fail to convert PEB index into LEB ID: "
+				  "seg %llu, peb_index %u\n",
+				  si->seg_id, peb_index);
+			return -ERANGE;
+		}
+
+		err = ssdfs_maptbl_set_indirect_relation(maptbl,
+							 leb_id,
+							 ptr->peb_type,
+							 dst_leb_id,
+							 dst_peb_index,
+							 &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				ptr->dst_peb = NULL;
+				atomic_dec(&relation->dst_peb_refs);
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("dst_peb_refs %d\n",
+					  atomic_read(&relation->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+				return err;
+			}
+
+			err = ssdfs_maptbl_set_indirect_relation(maptbl,
+								 leb_id,
+								 ptr->peb_type,
+								 dst_leb_id,
+								 dst_peb_index,
+								 &end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set relation LEB to PEB: "
+				  "leb_id %llu, dst_peb_index %u"
+				  "err %d\n",
+				  leb_id, dst_peb_index, err);
+			ptr->dst_peb = NULL;
+			atomic_dec(&relation->dst_peb_refs);
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("dst_peb_refs %d\n",
+				  atomic_read(&relation->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		}
+
+		switch (atomic_read(&ptr->items_state)) {
+		case SSDFS_PEB1_SRC_CONTAINER:
+			atomic_set(&ptr->items_state,
+				SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER);
+			break;
+
+		case SSDFS_PEB2_SRC_CONTAINER:
+			atomic_set(&ptr->items_state,
+				SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER);
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	case SSDFS_PEB_RELATION_PREPARATION:
+		SSDFS_WARN("peb not migrating: "
+			   "shared_index %d\n",
+			   shared_index);
+		return -ERANGE;
+
+	case SSDFS_PEB_NOT_MIGRATING:
+		SSDFS_WARN("peb not migrating: "
+			   "shared_index %d\n",
+			   shared_index);
+		return -ERANGE;
+
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_peb_container_prepare_destination() - prepare destination
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to create the destination PEB in requested
+ * container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - try to create a relation.
+ */
+static
+int __ssdfs_peb_container_prepare_destination(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_migration_destination *destination;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int shared_index;
+	int destination_state;
+	int items_state;
+	u16 peb_index;
+	u64 leb_id;
+	u64 peb_id;
+	u64 seg;
+	u32 log_pages;
+	u8 peb_migration_id;
+	struct completion *end;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+	seg = si->seg_id;
+	peb_index = ptr->peb_index;
+	log_pages = ptr->log_pages;
+
+	spin_lock(&si->migration.lock);
+	destination = &si->migration.array[SSDFS_CREATING_DESTINATION];
+	destination_state = destination->state;
+	shared_index = destination->shared_peb_index;
+	spin_unlock(&si->migration.lock);
+
+	if (destination_state != SSDFS_DESTINATION_UNDER_CREATION &&
+	    shared_index != ptr->peb_index) {
+		SSDFS_ERR("destination_state %#x, "
+			  "shared_index %d, "
+			  "peb_index %u\n",
+			  destination_state,
+			  shared_index,
+			  ptr->peb_index);
+		return -ERANGE;
+	}
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi, si->seg_id, peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, peb_index);
+		return -ERANGE;
+	}
+
+	err = ssdfs_maptbl_add_migration_peb(fsi, leb_id, ptr->peb_type,
+					     &pebr, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			goto fail_prepare_destination;
+		}
+
+		err = ssdfs_maptbl_add_migration_peb(fsi, leb_id,
+						     ptr->peb_type,
+						     &pebr, &end);
+	}
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find PEB for migration: "
+			  "leb_id %llu, peb_type %#x\n",
+			  leb_id, ptr->peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto fail_prepare_destination;
+	} else if (err == -EBUSY) {
+		DEFINE_WAIT(wait);
+
+wait_erase_operation_end:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("wait_erase_operation_end: "
+			  "leb_id %llu, peb_type %#x\n",
+			  leb_id, ptr->peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		wake_up_all(&fsi->maptbl->wait_queue);
+
+		mutex_unlock(&ptr->migration_lock);
+		prepare_to_wait(&fsi->maptbl->erase_ops_end_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&fsi->maptbl->erase_ops_end_wq, &wait);
+		mutex_lock(&ptr->migration_lock);
+
+		err = ssdfs_maptbl_add_migration_peb(fsi, leb_id, ptr->peb_type,
+						     &pebr, &end);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find PEB for migration: "
+				  "leb_id %llu, peb_type %#x\n",
+				  leb_id, ptr->peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto fail_prepare_destination;
+		} else if (err == -EBUSY) {
+			/*
+			 * We still have pre-erased PEBs.
+			 * Let's wait more.
+			 */
+			goto wait_erase_operation_end;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to add migration PEB: "
+				  "leb_id %llu, peb_type %#x, "
+				  "err %d\n",
+				  leb_id, ptr->peb_type, err);
+			goto fail_prepare_destination;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to add migration PEB: "
+			  "leb_id %llu, peb_type %#x, "
+			  "err %d\n",
+			  leb_id, ptr->peb_type, err);
+		goto fail_prepare_destination;
+	}
+
+	down_write(&ptr->lock);
+
+	items_state = atomic_read(&ptr->items_state);
+
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+		pebi = &ptr->items[SSDFS_SEG_PEB2];
+		break;
+
+	case SSDFS_PEB_CONTAINER_EMPTY:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		pebi = &ptr->items[SSDFS_SEG_PEB1];
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid container state: %#x\n",
+			  atomic_read(&ptr->items_state));
+		goto finish_prepare_destination;
+		break;
+	};
+
+	peb_id = pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id;
+	peb_migration_id = ssdfs_define_next_peb_migration_id(ptr->src_peb);
+	if (!is_peb_migration_id_valid(peb_migration_id)) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define peb_migration_id\n");
+		goto finish_prepare_destination;
+	}
+
+	err = ssdfs_peb_object_create(pebi, ptr, peb_id,
+				      SSDFS_MAPTBL_CLEAN_PEB_STATE,
+				      peb_migration_id);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create PEB object: "
+			  "seg %llu, peb_index %u, "
+			  "peb_id %llu\n",
+			  seg, peb_index,
+			  peb_id);
+		goto finish_prepare_destination;
+	}
+
+	ptr->dst_peb = pebi;
+	atomic_inc(&ptr->dst_peb_refs);
+
+	atomic_set(&pebi->state,
+		   SSDFS_PEB_OBJECT_INITIALIZED);
+	complete_all(&pebi->init_end);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_id %llu, dst_peb_refs %d\n",
+		  pebi->peb_id,
+		  atomic_read(&ptr->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (items_state) {
+	case SSDFS_PEB_CONTAINER_EMPTY:
+		atomic_set(&ptr->items_state,
+			   SSDFS_PEB1_DST_CONTAINER);
+		break;
+
+	case SSDFS_PEB1_SRC_CONTAINER:
+		atomic_set(&ptr->items_state,
+			   SSDFS_PEB1_SRC_PEB2_DST_CONTAINER);
+		break;
+
+	case SSDFS_PEB2_SRC_CONTAINER:
+		atomic_set(&ptr->items_state,
+			   SSDFS_PEB2_SRC_PEB1_DST_CONTAINER);
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (atomic_read(&ptr->items_state) == SSDFS_PEB1_DST_CONTAINER) {
+		int free_blks;
+
+		free_blks = ssdfs_peb_get_free_pages(ptr);
+		if (unlikely(free_blks < 0)) {
+			err = free_blks;
+			SSDFS_ERR("fail to get free_blks: "
+				  "peb_index %u, err %d\n",
+				  ptr->peb_index, err);
+			goto finish_prepare_destination;
+		} else if (free_blks == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("PEB hasn't free blocks\n");
+			goto finish_prepare_destination;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(free_blks >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		atomic_set(&ptr->shared_free_dst_blks, (u16)free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("shared_free_dst_blks %d\n",
+			  atomic_read(&ptr->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		if (ptr->peb_index >= si->blk_bmap.pebs_count) {
+			err = -ERANGE;
+			SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+				  ptr->peb_index,
+				  si->blk_bmap.pebs_count);
+			goto finish_prepare_destination;
+		}
+
+		peb_blkbmap = &si->blk_bmap.peb[ptr->peb_index];
+		err = ssdfs_peb_blk_bmap_start_migration(peb_blkbmap);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to start PEB's block bitmap migration: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  si->seg_id, ptr->peb_index, err);
+			goto finish_prepare_destination;
+		}
+	}
+
+finish_prepare_destination:
+	up_write(&ptr->lock);
+
+	if (unlikely(err))
+		goto fail_prepare_destination;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_container_prepare_destination: "
+		  "seg_id %llu, leb_id %llu, peb_id %llu, "
+		  "free_blks %d, used_blks %d, invalid_blks %d\n",
+		  si->seg_id, leb_id, peb_id,
+		  ssdfs_peb_get_free_pages(ptr),
+		  ssdfs_peb_get_used_data_pages(ptr),
+		  ssdfs_peb_get_invalid_pages(ptr));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&si->migration.lock);
+	ssdfs_memcpy(&si->migration.array[SSDFS_LAST_DESTINATION],
+		     0, sizeof(struct ssdfs_migration_destination),
+		     &si->migration.array[SSDFS_CREATING_DESTINATION],
+		     0, sizeof(struct ssdfs_migration_destination),
+		     sizeof(struct ssdfs_migration_destination));
+	destination = &si->migration.array[SSDFS_LAST_DESTINATION];
+	destination->state = SSDFS_VALID_DESTINATION;
+	memset(&si->migration.array[SSDFS_CREATING_DESTINATION],
+		0xFF, sizeof(struct ssdfs_migration_destination));
+	destination = &si->migration.array[SSDFS_CREATING_DESTINATION];
+	destination->state = SSDFS_EMPTY_DESTINATION;
+	spin_unlock(&si->migration.lock);
+
+	return 0;
+
+fail_prepare_destination:
+	spin_lock(&si->migration.lock);
+
+	destination = &si->migration.array[SSDFS_CREATING_DESTINATION];
+	destination->state = SSDFS_EMPTY_DESTINATION;
+	destination->shared_peb_index = -1;
+
+	destination = &si->migration.array[SSDFS_LAST_DESTINATION];
+	switch (destination->state) {
+	case SSDFS_OBSOLETE_DESTINATION:
+		destination->state = SSDFS_VALID_DESTINATION;
+		break;
+
+	case SSDFS_EMPTY_DESTINATION:
+		/* do nothing */
+		break;
+
+	case SSDFS_VALID_DESTINATION:
+		SSDFS_DBG("old destination is valid\n");
+		break;
+
+	default:
+		BUG();
+	};
+
+	spin_unlock(&si->migration.lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_container_prepare_zns_destination() - prepare ZNS destination
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to create relation with shared segment for
+ * user data updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - try to create a relation.
+ */
+static
+int ssdfs_peb_container_prepare_zns_destination(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_current_segment *cur_seg;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_info *dest_si = NULL;
+	struct ssdfs_peb_mapping_table *maptbl;
+	u64 start = U64_MAX;
+	int seg_type = SSDFS_USER_DATA_SEG_TYPE;
+	u16 peb_index, dst_peb_index;
+	u64 leb_id, dst_leb_id;
+	struct completion *end;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!mutex_is_locked(&ptr->migration_lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	maptbl = fsi->maptbl;
+	si = ptr->parent_si;
+	peb_index = ptr->peb_index;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi, si->seg_id, peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, peb_index);
+		return -ERANGE;
+	}
+
+	down_read(&fsi->cur_segs->lock);
+
+	cur_seg = fsi->cur_segs->objects[SSDFS_CUR_DATA_UPDATE_SEG];
+
+	ssdfs_current_segment_lock(cur_seg);
+
+	if (is_ssdfs_current_segment_empty(cur_seg)) {
+		start = cur_seg->seg_id;
+		dest_si = ssdfs_grab_segment(fsi, seg_type, U64_MAX, start);
+		if (IS_ERR_OR_NULL(dest_si)) {
+			err = (dest_si == NULL ? -ENOMEM : PTR_ERR(dest_si));
+			if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to create segment object: "
+					  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				SSDFS_ERR("fail to create segment object: "
+					  "err %d\n", err);
+			}
+
+			goto finish_get_current_segment;
+		}
+
+		err = ssdfs_current_segment_add(cur_seg, dest_si);
+		/*
+		 * ssdfs_grab_segment() has got object already.
+		 */
+		ssdfs_segment_put_object(dest_si);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add segment %llu as current: "
+				  "err %d\n",
+				  dest_si->seg_id, err);
+			goto finish_get_current_segment;
+		}
+	}
+
+	dst_peb_index = 0;
+	dst_leb_id = ssdfs_get_leb_id_for_peb_index(fsi, dest_si->seg_id, dst_peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  dest_si->seg_id, dst_peb_index);
+		return -ERANGE;
+	}
+
+finish_get_current_segment:
+	ssdfs_current_segment_unlock(cur_seg);
+	up_read(&fsi->cur_segs->lock);
+
+	if (unlikely(err))
+		return err;
+
+	err = ssdfs_maptbl_set_zns_indirect_relation(maptbl,
+						     leb_id,
+						     ptr->peb_type,
+						     &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			ptr->dst_peb = NULL;
+			return err;
+		}
+
+		err = ssdfs_maptbl_set_zns_indirect_relation(maptbl,
+							     leb_id,
+							     ptr->peb_type,
+							     &end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set relation LEB to PEB: "
+			  "leb_id %llu, dst leb_id %llu"
+			  "err %d\n",
+			  leb_id, dst_leb_id, err);
+		ptr->dst_peb = NULL;
+		return err;
+	}
+
+	switch (atomic_read(&ptr->items_state)) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+		atomic_set(&ptr->items_state,
+			SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER);
+		break;
+
+	case SSDFS_PEB2_SRC_CONTAINER:
+		atomic_set(&ptr->items_state,
+			SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER);
+		break;
+
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_container_prepare_destination() - prepare destination
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to create the destination PEB in requested
+ * container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - try to create a relation.
+ */
+static
+int ssdfs_peb_container_prepare_destination(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+
+	if (fsi->is_zns_device && is_ssdfs_peb_containing_user_data(ptr))
+		err = ssdfs_peb_container_prepare_zns_destination(ptr);
+	else
+		err = __ssdfs_peb_container_prepare_destination(ptr);
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to prepare destination: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  si->seg_id, ptr->peb_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare destination: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  si->seg_id, ptr->peb_index, err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_container_create_destination() - create destination
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to create the destination or relation
+ * with another PEB container.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_container_create_destination(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *relation;
+	struct ssdfs_migration_destination *destination;
+	bool need_create_relation = false;
+	u16 migration_threshold;
+	u16 pebs_per_destination;
+	u16 destination_index;
+	int migration_state;
+	int items_state;
+	int destination_pebs;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!mutex_is_locked(&ptr->migration_lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+
+	spin_lock(&fsi->volume_state_lock);
+	migration_threshold = fsi->migration_threshold;
+	spin_unlock(&fsi->volume_state_lock);
+
+	migration_state = atomic_read(&ptr->migration_state);
+
+	if (migration_state != SSDFS_PEB_NOT_MIGRATING) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid migration_state %#x\n",
+			  migration_state);
+		goto finish_create_destination;
+	}
+
+	items_state = atomic_read(&ptr->items_state);
+
+	if (items_state != SSDFS_PEB1_SRC_CONTAINER &&
+	    items_state != SSDFS_PEB2_SRC_CONTAINER) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_state %#x\n",
+			  items_state);
+		goto finish_create_destination;
+	}
+
+	pebs_per_destination = fsi->pebs_per_seg / migration_threshold;
+	destination_index =
+		atomic_inc_return(&si->migration.migrating_pebs) - 1;
+	destination_index /= pebs_per_destination;
+
+try_start_preparation_again:
+	spin_lock(&si->migration.lock);
+
+	destination = &si->migration.array[SSDFS_LAST_DESTINATION];
+
+	switch (destination->state) {
+	case SSDFS_EMPTY_DESTINATION:
+		need_create_relation = false;
+		destination = &si->migration.array[SSDFS_CREATING_DESTINATION];
+		destination->state = SSDFS_DESTINATION_UNDER_CREATION;
+		destination->destination_pebs++;
+		destination->shared_peb_index = ptr->peb_index;
+		break;
+
+	case SSDFS_VALID_DESTINATION:
+		destination_pebs = destination->destination_pebs;
+		need_create_relation = destination_index < destination_pebs;
+
+		if (need_create_relation) {
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(destination_index >= si->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			relation = &si->peb_array[destination_index];
+			if (atomic_read(&relation->shared_free_dst_blks) <= 0) {
+				/* destination hasn't free room */
+				need_create_relation = false;
+			}
+		}
+
+		if (!need_create_relation) {
+			destination =
+			    &si->migration.array[SSDFS_CREATING_DESTINATION];
+			destination->state = SSDFS_DESTINATION_UNDER_CREATION;
+			destination->destination_pebs++;
+			destination->shared_peb_index = ptr->peb_index;
+		}
+		break;
+
+	case SSDFS_OBSOLETE_DESTINATION:
+		destination = &si->migration.array[SSDFS_CREATING_DESTINATION];
+
+		if (destination->state != SSDFS_DESTINATION_UNDER_CREATION) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid destination state %#x\n",
+				   destination->state);
+			goto finish_check_destination;
+		}
+
+		destination_pebs = destination->destination_pebs;
+		need_create_relation = destination_index < destination_pebs;
+
+		if (!need_create_relation)
+			err = -EAGAIN;
+		break;
+
+	default:
+		BUG();
+	};
+
+finish_check_destination:
+	spin_unlock(&si->migration.lock);
+
+	if (err == -EAGAIN) {
+		DEFINE_WAIT(wait);
+
+		mutex_unlock(&ptr->migration_lock);
+		prepare_to_wait(&ptr->migration_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&ptr->migration_wq, &wait);
+		mutex_lock(&ptr->migration_lock);
+		err = 0;
+		goto try_start_preparation_again;
+	} else if (unlikely(err))
+		goto finish_create_destination;
+
+	if (need_create_relation) {
+create_relation:
+		atomic_set(&ptr->migration_state,
+			    SSDFS_PEB_RELATION_PREPARATION);
+
+		err = ssdfs_peb_container_prepare_relation(ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare relation: "
+				  "err %d\n",
+				  err);
+			goto finish_create_destination;
+		}
+
+		atomic_set(&ptr->migration_state,
+			    SSDFS_PEB_UNDER_MIGRATION);
+	} else {
+		atomic_set(&ptr->migration_state,
+			    SSDFS_PEB_MIGRATION_PREPARATION);
+
+		err = ssdfs_peb_container_prepare_destination(ptr);
+		if (err == -ENODATA) {
+			err = 0;
+			goto create_relation;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare destination: "
+				  "err %d\n",
+				  err);
+			goto finish_create_destination;
+		}
+
+		atomic_set(&ptr->migration_state,
+			    SSDFS_PEB_UNDER_MIGRATION);
+	}
+
+finish_create_destination:
+	if (unlikely(err)) {
+		atomic_set(&ptr->migration_state, migration_state);
+		atomic_dec(&si->migration.migrating_pebs);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("migration_state %d\n",
+		  atomic_read(&ptr->migration_state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_container_move_dest2source() - convert destination into source
+ * @ptr: pointer on PEB container
+ * @state: current state of items
+ *
+ * This method tries to transform destination PEB
+ * into source PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - destination PEB has references.
+ */
+static
+int ssdfs_peb_container_move_dest2source(struct ssdfs_peb_container *ptr,
+					 int state)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_migration_info *mi;
+	struct ssdfs_migration_destination *mdest;
+	int new_state;
+	u64 leb_id;
+	u64 peb_create_time = U64_MAX;
+	u64 last_log_time = U64_MAX;
+	struct completion *end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!rwsem_is_locked(&ptr->lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u, "
+		  "state %#x\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages,
+		  state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+						si->seg_id,
+						ptr->peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, ptr->peb_index);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_id %llu, dst_peb_refs %d\n",
+		  ptr->dst_peb->peb_id,
+		  atomic_read(&ptr->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->dst_peb_refs) > 1) {
+		/* wait of absence of references */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("leb_id %llu, peb_index %u, "
+			  "refs_count %u\n",
+			  leb_id, ptr->peb_index,
+			  atomic_read(&ptr->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	switch (state) {
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		new_state = SSDFS_PEB1_SRC_CONTAINER;
+		break;
+
+	case SSDFS_PEB2_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+		new_state = SSDFS_PEB2_SRC_CONTAINER;
+		break;
+
+	default:
+		SSDFS_WARN("invalid state: %#x\n",
+			   state);
+		return -ERANGE;
+	}
+
+	if (ptr->src_peb) {
+		peb_create_time = ptr->src_peb->peb_create_time;
+
+		ssdfs_peb_current_log_lock(ptr->src_peb);
+		last_log_time = ptr->src_peb->current_log.last_log_time;
+		ssdfs_peb_current_log_unlock(ptr->src_peb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg %llu, peb %llu, "
+			  "peb_create_time %llx, last_log_time %llx\n",
+			  si->seg_id,
+			  ptr->src_peb->peb_id,
+			  peb_create_time,
+			  last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		peb_create_time = ptr->dst_peb->peb_create_time;
+
+		ssdfs_peb_current_log_lock(ptr->dst_peb);
+		last_log_time = ptr->dst_peb->current_log.last_log_time;
+		ssdfs_peb_current_log_unlock(ptr->dst_peb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg %llu, peb %llu, "
+			  "peb_create_time %llx, last_log_time %llx\n",
+			  si->seg_id,
+			  ptr->dst_peb->peb_id,
+			  peb_create_time,
+			  last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	err = ssdfs_maptbl_exclude_migration_peb(fsi, leb_id,
+						 ptr->peb_type,
+						 peb_create_time,
+						 last_log_time,
+						 &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_exclude_migration_peb(fsi, leb_id,
+							 ptr->peb_type,
+							 peb_create_time,
+							 last_log_time,
+							 &end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to exclude migration PEB: "
+			  "leb_id %llu, peb_type %#x, err %d\n",
+			  leb_id, ptr->peb_type, err);
+		return err;
+	}
+
+	atomic_dec(&si->peb_array[ptr->dst_peb->peb_index].dst_peb_refs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, leb_id %llu, "
+		  "peb_id %llu, dst_peb_refs %d\n",
+	    si->seg_id, leb_id,
+	    ptr->dst_peb->peb_id,
+	    atomic_read(&si->peb_array[ptr->dst_peb->peb_index].dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ptr->src_peb) {
+		err = ssdfs_peb_object_destroy(ptr->src_peb);
+		WARN_ON(err);
+		err = 0;
+	}
+
+	memset(ptr->src_peb, 0, sizeof(struct ssdfs_peb_info));
+	ptr->src_peb = ptr->dst_peb;
+	ptr->dst_peb = NULL;
+
+	atomic_set(&ptr->items_state, new_state);
+	atomic_set(&ptr->migration_state, SSDFS_PEB_NOT_MIGRATING);
+
+	mi = &ptr->parent_si->migration;
+	spin_lock(&mi->lock);
+	atomic_dec(&mi->migrating_pebs);
+	mdest = &mi->array[SSDFS_LAST_DESTINATION];
+	switch (mdest->state) {
+	case SSDFS_VALID_DESTINATION:
+	case SSDFS_OBSOLETE_DESTINATION:
+		mdest->destination_pebs--;
+		break;
+	};
+	mdest = &mi->array[SSDFS_CREATING_DESTINATION];
+	switch (mdest->state) {
+	case SSDFS_DESTINATION_UNDER_CREATION:
+		mdest->destination_pebs--;
+		break;
+	};
+	spin_unlock(&mi->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_container_break_relation() - break relation with PEB
+ * @ptr: pointer on PEB container
+ * @state: current state of items
+ * @new_state: new state of items
+ *
+ * This method tries to break relation with destination PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_container_break_relation(struct ssdfs_peb_container *ptr,
+					int state, int new_state)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_mapping_table *maptbl;
+	u64 leb_id, dst_leb_id;
+	u16 dst_peb_index;
+	int dst_peb_refs;
+	struct completion *end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb || !ptr->dst_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!rwsem_is_locked(&ptr->lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u, "
+		  "state %#x, new_state %#x\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages,
+		  state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+	maptbl = fsi->maptbl;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+						si->seg_id,
+						ptr->peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, ptr->peb_index);
+		return -ERANGE;
+	}
+
+	dst_peb_index = ptr->dst_peb->peb_index;
+
+	dst_leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+						    si->seg_id,
+						    dst_peb_index);
+	if (dst_leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, dst_peb_index);
+		return -ERANGE;
+	}
+
+	dst_peb_refs = atomic_read(&si->peb_array[dst_peb_index].dst_peb_refs);
+
+	err = ssdfs_maptbl_break_indirect_relation(maptbl,
+						   leb_id,
+						   ptr->peb_type,
+						   dst_leb_id,
+						   dst_peb_refs,
+						   &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_break_indirect_relation(maptbl,
+							   leb_id,
+							   ptr->peb_type,
+							   dst_leb_id,
+							   dst_peb_refs,
+							   &end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to break relation: "
+			  "leb_id %llu, peb_index %u, err %d\n",
+			  leb_id, ptr->peb_index, err);
+		return err;
+	}
+
+	atomic_dec(&si->peb_array[ptr->dst_peb->peb_index].dst_peb_refs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_id %llu, dst_peb_refs %d\n",
+	    ptr->dst_peb->peb_id,
+	    atomic_read(&si->peb_array[ptr->dst_peb->peb_index].dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (new_state == SSDFS_PEB_CONTAINER_EMPTY) {
+		err = ssdfs_peb_object_destroy(ptr->src_peb);
+		WARN_ON(err);
+		err = 0;
+
+		memset(ptr->src_peb, 0, sizeof(struct ssdfs_peb_info));
+	} else
+		ptr->dst_peb = NULL;
+
+	atomic_set(&ptr->items_state, new_state);
+	atomic_set(&ptr->migration_state, SSDFS_PEB_NOT_MIGRATING);
+	atomic_dec(&ptr->parent_si->migration.migrating_pebs);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_container_break_zns_relation() - break relation with PEB
+ * @ptr: pointer on PEB container
+ * @state: current state of items
+ * @new_state: new state of items
+ *
+ * This method tries to break relation with shared zone.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_container_break_zns_relation(struct ssdfs_peb_container *ptr,
+					   int state, int new_state)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_mapping_table *maptbl;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_invextree_info *invextree;
+	struct ssdfs_btree_search *search;
+	struct ssdfs_raw_extent extent;
+	u64 leb_id;
+	int invalid_blks;
+	struct completion *end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb || !ptr->dst_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!rwsem_is_locked(&ptr->lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u, "
+		  "state %#x, new_state %#x\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages,
+		  state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+	maptbl = fsi->maptbl;
+	seg_blkbmap = &si->blk_bmap;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+						si->seg_id,
+						ptr->peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, ptr->peb_index);
+		return -ERANGE;
+	}
+
+	err = ssdfs_maptbl_break_zns_indirect_relation(maptbl,
+						       leb_id,
+						       ptr->peb_type,
+						       &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_break_zns_indirect_relation(maptbl,
+								leb_id,
+								ptr->peb_type,
+								&end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to break relation: "
+			  "leb_id %llu, peb_index %u, err %d\n",
+			  leb_id, ptr->peb_index, err);
+		return err;
+	}
+
+	invextree = fsi->invextree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!invextree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	invalid_blks = ssdfs_segment_blk_bmap_get_invalid_pages(seg_blkbmap);
+	if (invalid_blks <= 0) {
+		SSDFS_ERR("invalid state: "
+			  "leb_id %llu, invalid_blks %d\n",
+			  leb_id, invalid_blks);
+		return -ERANGE;
+	}
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	extent.seg_id = cpu_to_le64(si->seg_id);
+	extent.logical_blk = cpu_to_le32(0);
+	extent.len = cpu_to_le32(invalid_blks);
+
+	ssdfs_btree_search_init(search);
+	err = ssdfs_invextree_delete(invextree, &extent, search);
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete invalidated extent: "
+			  "leb_id %llu, len %d, err %d\n",
+			  leb_id, invalid_blks, err);
+		return err;
+	}
+
+	if (new_state == SSDFS_PEB_CONTAINER_EMPTY) {
+		err = ssdfs_peb_object_destroy(ptr->src_peb);
+		WARN_ON(err);
+		err = 0;
+
+		memset(ptr->src_peb, 0, sizeof(struct ssdfs_peb_info));
+	} else
+		ptr->dst_peb = NULL;
+
+	atomic_set(&ptr->items_state, new_state);
+	atomic_set(&ptr->migration_state, SSDFS_PEB_NOT_MIGRATING);
+	atomic_dec(&ptr->parent_si->migration.migrating_pebs);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_container_forget_source() - forget about dirty source PEB
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to forget about dirty source PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_container_forget_source(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_migration_info *mi;
+	struct ssdfs_migration_destination *mdest;
+	struct ssdfs_peb_mapping_table *maptbl;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int migration_state;
+	int items_state;
+	u64 leb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!mutex_is_locked(&ptr->migration_lock));
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+	maptbl = fsi->maptbl;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+						si->seg_id,
+						ptr->peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, ptr->peb_index);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (rwsem_is_locked(&ptr->lock)) {
+		SSDFS_DBG("PEB is locked: "
+			  "leb_id %llu\n", leb_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&ptr->lock);
+
+	migration_state = atomic_read(&ptr->migration_state);
+	if (migration_state != SSDFS_PEB_FINISHING_MIGRATION) {
+		err = -ERANGE;
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   migration_state);
+		goto finish_forget_source;
+	}
+
+	items_state = atomic_read(&ptr->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		/* valid state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		goto finish_forget_source;
+	};
+
+/*
+ *       You cannot move destination into source PEB and
+ *       try to create another one destination for existing
+ *       relations. Otherwise, you will have two full PEBs
+ *       for the same peb_index. So, in the case of full
+ *       destination PEB and presence of relation with another
+ *       source PEB it needs to wake up all threads and to wait
+ *       decreasing the dst_peb_refs counter.
+ */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_state %#x\n", items_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (items_state) {
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(ptr->src_peb);
+		BUG_ON(!ptr->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_peb_container_move_dest2source(ptr,
+							   items_state);
+		if (err == -ENODATA)
+			goto finish_forget_source;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to transform destination: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_forget_source;
+		}
+
+		WARN_ON(atomic_read(&ptr->shared_free_dst_blks) > 0);
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ptr->src_peb);
+		BUG_ON(!ptr->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_peb_container_move_dest2source(ptr,
+							   items_state);
+		if (err == -ENODATA)
+			goto finish_forget_source;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to transform destination: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			goto finish_forget_source;
+		}
+
+		if (ptr->peb_index >= si->blk_bmap.pebs_count) {
+			err = -ERANGE;
+			SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+				  ptr->peb_index,
+				  si->blk_bmap.pebs_count);
+			goto finish_forget_source;
+		}
+
+		peb_blkbmap = &si->blk_bmap.peb[ptr->peb_index];
+		err = ssdfs_peb_blk_bmap_finish_migration(peb_blkbmap);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to finish bmap migration: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  ptr->parent_si->seg_id,
+				  ptr->peb_index, err);
+			goto finish_forget_source;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER: {
+		int new_state = SSDFS_PEB_CONTAINER_STATE_MAX;
+		int used_blks;
+		bool has_valid_blks = true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ptr->src_peb);
+		BUG_ON(!ptr->dst_peb);
+		BUG_ON(atomic_read(&ptr->dst_peb_refs) != 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		used_blks = ssdfs_peb_get_used_data_pages(ptr);
+		if (used_blks < 0) {
+			err = used_blks;
+			SSDFS_ERR("fail to get used_blks: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  ptr->parent_si->seg_id,
+				  ptr->peb_index, err);
+			goto finish_forget_source;
+		}
+
+		has_valid_blks = used_blks > 0;
+
+		switch (items_state) {
+		case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+			if (has_valid_blks)
+				new_state = SSDFS_PEB1_SRC_CONTAINER;
+			else
+				new_state = SSDFS_PEB_CONTAINER_EMPTY;
+			break;
+
+		case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+			if (has_valid_blks)
+				new_state = SSDFS_PEB2_SRC_CONTAINER;
+			else
+				new_state = SSDFS_PEB_CONTAINER_EMPTY;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_WARN("invalid state: %#x\n",
+				   new_state);
+			goto finish_forget_source;
+		}
+
+		if (fsi->is_zns_device) {
+			err = ssdfs_peb_container_break_zns_relation(ptr,
+								 items_state,
+								 new_state);
+		} else {
+			err = ssdfs_peb_container_break_relation(ptr,
+								 items_state,
+								 new_state);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to break relation: "
+				  "leb_id %llu, items_state %#x"
+				  "new_state %#x\n",
+				  leb_id, items_state, new_state);
+			goto finish_forget_source;
+		}
+
+		if (new_state != SSDFS_PEB_CONTAINER_EMPTY) {
+			/* try create new destination */
+			err = -ENOENT;
+			goto finish_forget_source;
+		}
+		break;
+	}
+
+	default:
+		BUG();
+	};
+
+finish_forget_source:
+	up_write(&ptr->lock);
+
+	if (err == -ENOENT) { /* create new destination or relation */
+		err = ssdfs_peb_container_create_destination(ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create destination: "
+				  "leb_id %llu, err %d\n",
+				  leb_id, err);
+			return err;
+		}
+	} else if (err == -ENODATA) {
+		wake_up_all(&si->wait_queue[SSDFS_PEB_FLUSH_THREAD]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("dst_peb_refs %d\n",
+			  atomic_read(&ptr->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		while (atomic_read(&ptr->dst_peb_refs) > 1) {
+			DEFINE_WAIT(wait);
+
+			mutex_unlock(&ptr->migration_lock);
+			prepare_to_wait(&ptr->migration_wq, &wait,
+					TASK_UNINTERRUPTIBLE);
+			schedule();
+			finish_wait(&ptr->migration_wq, &wait);
+			mutex_lock(&ptr->migration_lock);
+		};
+
+		down_write(&ptr->lock);
+
+		ptr->src_peb = ptr->dst_peb;
+		ptr->dst_peb = NULL;
+
+		switch (items_state) {
+		case SSDFS_PEB1_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+			atomic_set(&ptr->items_state, SSDFS_PEB1_SRC_CONTAINER);
+			break;
+
+		case SSDFS_PEB2_DST_CONTAINER:
+		case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+			atomic_set(&ptr->items_state, SSDFS_PEB2_SRC_CONTAINER);
+			break;
+
+		default:
+			BUG();
+		};
+
+		atomic_set(&ptr->migration_state, SSDFS_PEB_NOT_MIGRATING);
+
+		up_write(&ptr->lock);
+
+		mi = &ptr->parent_si->migration;
+		spin_lock(&mi->lock);
+		atomic_dec(&mi->migrating_pebs);
+		mdest = &mi->array[SSDFS_LAST_DESTINATION];
+		switch (mdest->state) {
+		case SSDFS_VALID_DESTINATION:
+		case SSDFS_OBSOLETE_DESTINATION:
+			mdest->destination_pebs--;
+			break;
+		};
+		mdest = &mi->array[SSDFS_CREATING_DESTINATION];
+		switch (mdest->state) {
+		case SSDFS_DESTINATION_UNDER_CREATION:
+			mdest->destination_pebs--;
+			break;
+		};
+		spin_unlock(&mi->lock);
+	} else if (unlikely(err))
+		return err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_container_forget_relation() - forget about relation
+ * @ptr: pointer on PEB container
+ *
+ * This method tries to forget about relation with
+ * destination PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_container_forget_relation(struct ssdfs_peb_container *ptr)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_mapping_table *maptbl;
+	int migration_state;
+	int items_state;
+	u64 leb_id;
+	int new_state = SSDFS_PEB_CONTAINER_STATE_MAX;
+	int used_blks;
+	bool has_valid_blks = true;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->src_peb);
+	BUG_ON(!ptr->parent_si || !ptr->parent_si->fsi);
+	BUG_ON(!ptr->dst_peb);
+	BUG_ON(atomic_read(&ptr->dst_peb_refs) != 0);
+
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  ptr,
+		  ptr->peb_index,
+		  ptr->peb_type,
+		  ptr->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = ptr->parent_si->fsi;
+	si = ptr->parent_si;
+	maptbl = fsi->maptbl;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+						si->seg_id,
+						ptr->peb_index);
+	if (leb_id >= U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, ptr->peb_index);
+		return -ERANGE;
+	}
+
+	down_write(&ptr->lock);
+
+	migration_state = atomic_read(&ptr->migration_state);
+	if (migration_state != SSDFS_PEB_FINISHING_MIGRATION) {
+		err = -ERANGE;
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   migration_state);
+		goto finish_forget_relation;
+	}
+
+	used_blks = ssdfs_peb_get_used_data_pages(ptr);
+	if (used_blks < 0) {
+		err = used_blks;
+		SSDFS_ERR("fail to get used_blks: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  ptr->parent_si->seg_id,
+			  ptr->peb_index, err);
+		goto finish_forget_relation;
+	}
+
+	has_valid_blks = used_blks > 0;
+
+	items_state = atomic_read(&ptr->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+		if (has_valid_blks)
+			new_state = SSDFS_PEB1_SRC_CONTAINER;
+		else
+			new_state = SSDFS_PEB_CONTAINER_EMPTY;
+		break;
+
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		if (has_valid_blks)
+			new_state = SSDFS_PEB2_SRC_CONTAINER;
+		else
+			new_state = SSDFS_PEB_CONTAINER_EMPTY;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+		goto finish_forget_relation;
+	};
+
+	err = ssdfs_peb_container_break_relation(ptr,
+						 items_state,
+						 new_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to break relation: "
+			  "leb_id %llu, items_state %#x"
+			  "new_state %#x\n",
+			  leb_id, items_state, new_state);
+	}
+
+finish_forget_relation:
+	up_write(&ptr->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_get_current_peb_locked() - lock PEB container and get PEB object
+ * @pebc: pointer on PEB container
+ */
+struct ssdfs_peb_info *
+ssdfs_get_current_peb_locked(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi = NULL;
+	bool is_peb_exhausted;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+
+try_get_current_peb:
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		down_read(&pebc->lock);
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			err = -ERANGE;
+			SSDFS_WARN("source PEB is NULL\n");
+			goto fail_to_get_current_peb;
+		}
+
+		atomic_set(&pebc->migration_phase,
+				SSDFS_PEB_MIGRATION_STATUS_UNKNOWN);
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		down_read(&pebc->lock);
+
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			err = -ERANGE;
+			SSDFS_WARN("source PEB is NULL\n");
+			goto fail_to_get_current_peb;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+		if (is_peb_exhausted) {
+			if (fsi->is_zns_device &&
+			    is_ssdfs_peb_containing_user_data(pebc)) {
+				atomic_set(&pebc->migration_phase,
+					    SSDFS_SHARED_ZONE_RECEIVES_DATA);
+			} else {
+				pebi = pebc->dst_peb;
+				if (!pebi) {
+					err = -ERANGE;
+					SSDFS_WARN("destination PEB is NULL\n");
+					goto fail_to_get_current_peb;
+				}
+
+				atomic_set(&pebc->migration_phase,
+						SSDFS_DST_PEB_RECEIVES_DATA);
+			}
+		} else {
+			atomic_set(&pebc->migration_phase,
+					SSDFS_SRC_PEB_NOT_EXHAUSTED);
+		}
+		break;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION: {
+			DEFINE_WAIT(wait);
+
+			prepare_to_wait(&pebc->migration_wq, &wait,
+					TASK_UNINTERRUPTIBLE);
+			schedule();
+			finish_wait(&pebc->migration_wq, &wait);
+			goto try_get_current_peb;
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid state: %#x\n",
+			   atomic_read(&pebc->migration_state));
+		return ERR_PTR(-ERANGE);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "migration_state %#x, migration_phase %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->migration_phase));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return pebi;
+
+fail_to_get_current_peb:
+	up_read(&pebc->lock);
+	return ERR_PTR(err);
+}
+
+/*
+ * ssdfs_unlock_current_peb() - unlock source and destination PEB objects
+ * @pebc: pointer on PEB container
+ */
+void ssdfs_unlock_current_peb(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!rwsem_is_locked(&pebc->lock)) {
+		SSDFS_WARN("PEB container hasn't been locked: "
+			   "seg %llu, peb_index %u\n",
+			   pebc->parent_si->seg_id,
+			   pebc->peb_index);
+	} else
+		up_read(&pebc->lock);
+}
+
+/*
+ * ssdfs_get_peb_for_migration_id() - get PEB object for migration ID
+ * @pebc: pointer on PEB container
+ */
+struct ssdfs_peb_info *
+ssdfs_get_peb_for_migration_id(struct ssdfs_peb_container *pebc,
+			       u8 migration_id)
+{
+	struct ssdfs_peb_info *pebi = NULL;
+	int known_migration_id;
+	u64 src_peb_id, dst_peb_id;
+	int src_migration_id, dst_migration_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			err = -ERANGE;
+			SSDFS_WARN("source PEB is NULL\n");
+			goto fail_to_get_peb;
+		}
+
+		known_migration_id = ssdfs_get_peb_migration_id_checked(pebi);
+
+		if (migration_id != known_migration_id) {
+			err = -ERANGE;
+			SSDFS_WARN("peb %llu, "
+				   "migration_id %u != known_migration_id %d\n",
+				   pebi->peb_id, migration_id,
+				   known_migration_id);
+			goto fail_to_get_peb;
+		}
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			err = -ERANGE;
+			SSDFS_WARN("source PEB is NULL\n");
+			goto fail_to_get_peb;
+		}
+
+		known_migration_id = ssdfs_get_peb_migration_id_checked(pebi);
+
+		if (migration_id != known_migration_id) {
+			src_peb_id = pebi->peb_id;
+			src_migration_id = known_migration_id;
+
+			pebi = pebc->dst_peb;
+			if (!pebi) {
+				err = -ERANGE;
+				SSDFS_WARN("destination PEB is NULL\n");
+				goto fail_to_get_peb;
+			}
+
+			known_migration_id =
+				ssdfs_get_peb_migration_id_checked(pebi);
+
+			if (migration_id != known_migration_id) {
+				dst_peb_id = pebi->peb_id;
+				dst_migration_id = known_migration_id;
+
+				err = -ERANGE;
+				SSDFS_WARN("fail to find PEB: "
+					   "src_peb_id %llu, "
+					   "src_migration_id %d, "
+					   "dst_peb_id %llu, "
+					   "dst_migration_id %d, "
+					   "migration_id %u\n",
+					   src_peb_id, src_migration_id,
+					   dst_peb_id, dst_migration_id,
+					   migration_id);
+				goto fail_to_get_peb;
+			}
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid state: %#x\n",
+			   atomic_read(&pebc->migration_state));
+		return ERR_PTR(-ERANGE);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, migration_state %#x, "
+		  "migration_phase %#x, migration_id %u\n",
+		  pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->migration_phase),
+		  migration_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return pebi;
+
+fail_to_get_peb:
+	return ERR_PTR(err);
+}
+
+/*
+ * ssdfs_peb_get_free_pages() - get PEB's free pages count
+ * @ptr: pointer on PEB container
+ */
+int ssdfs_peb_get_free_pages(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+
+	SSDFS_DBG("pebc %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  pebc, pebc->peb_index,
+		  pebc->peb_type, pebc->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+
+	if (pebc->peb_index >= seg_blkbmap->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  pebc->peb_index,
+			  seg_blkbmap->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	return ssdfs_peb_blk_bmap_get_free_pages(peb_blkbmap);
+}
+
+/*
+ * ssdfs_peb_get_used_pages() - get PEB's valid pages count
+ * @ptr: pointer on PEB container
+ */
+int ssdfs_peb_get_used_data_pages(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+
+	SSDFS_DBG("pebc %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  pebc, pebc->peb_index,
+		  pebc->peb_type, pebc->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+
+	if (pebc->peb_index >= seg_blkbmap->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  pebc->peb_index,
+			  seg_blkbmap->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	return ssdfs_peb_blk_bmap_get_used_pages(peb_blkbmap);
+}
+
+/*
+ * ssdfs_peb_get_invalid_pages() - get PEB's invalid pages count
+ * @ptr: pointer on PEB container
+ */
+int ssdfs_peb_get_invalid_pages(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+
+	SSDFS_DBG("pebc %p, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  pebc, pebc->peb_index,
+		  pebc->peb_type, pebc->log_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+
+	if (pebc->peb_index >= seg_blkbmap->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  pebc->peb_index,
+			  seg_blkbmap->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	return ssdfs_peb_blk_bmap_get_invalid_pages(peb_blkbmap);
+}
+
+/*
+ * ssdfs_peb_container_invalidate_block() - invalidate PEB's block
+ * @pebc: pointer on PEB container
+ * @desc: physical offset descriptor
+ *
+ * This method tries to invalidate PEB's block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_container_invalidate_block(struct ssdfs_peb_container *pebc,
+				    struct ssdfs_phys_offset_descriptor *desc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_block_bmap_range range;
+	u16 peb_index;
+	u32 peb_page;
+	u8 peb_migration_id;
+	int id;
+	int items_state;
+	int bmap_index = SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !desc);
+	BUG_ON(!pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_migration_id %u, "
+		  "logical_offset %u, logical_blk %u, peb_page %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  desc->blk_state.peb_migration_id,
+		  le32_to_cpu(desc->page_desc.logical_offset),
+		  le16_to_cpu(desc->page_desc.logical_blk),
+		  le16_to_cpu(desc->page_desc.peb_page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_index = pebc->peb_index;
+	peb_page = le16_to_cpu(desc->page_desc.peb_page);
+	peb_migration_id = desc->blk_state.peb_migration_id;
+
+	down_read(&pebc->lock);
+
+	items_state = atomic_read(&pebc->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: items_state %#x\n",
+				  items_state);
+			err = -ERANGE;
+			goto finish_invalidate_block;
+		}
+		bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		pebi = pebc->dst_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: items_state %#x\n",
+				  items_state);
+			err = -ERANGE;
+			goto finish_invalidate_block;
+		}
+		bmap_index = SSDFS_PEB_BLK_BMAP_DESTINATION;
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: items_state %#x\n",
+				  items_state);
+			err = -ERANGE;
+			goto finish_invalidate_block;
+		}
+
+		bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+		id = ssdfs_get_peb_migration_id_checked(pebi);
+
+		if (peb_migration_id != id) {
+			pebi = pebc->dst_peb;
+			if (!pebi) {
+				SSDFS_ERR("PEB pointer is NULL: "
+					  "items_state %#x\n",
+					  items_state);
+				err = -ERANGE;
+				goto finish_invalidate_block;
+			}
+			bmap_index = SSDFS_PEB_BLK_BMAP_DESTINATION;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid PEB container's items_state: "
+			  "%#x\n",
+			  items_state);
+		err = -ERANGE;
+		goto finish_invalidate_block;
+	};
+
+	id = ssdfs_get_peb_migration_id_checked(pebi);
+
+	if (peb_migration_id != id) {
+		SSDFS_ERR("peb_migration_id %u != pebi->peb_migration_id %u\n",
+			  peb_migration_id,
+			  ssdfs_get_peb_migration_id(pebi));
+		err = -ERANGE;
+		goto finish_invalidate_block;
+	}
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+
+	if (pebc->peb_index >= seg_blkbmap->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  pebc->peb_index,
+			  seg_blkbmap->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	range.start = peb_page;
+	range.len = 1;
+
+	err = ssdfs_peb_blk_bmap_invalidate(peb_blkbmap,
+					    bmap_index,
+					    &range);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate range: "
+			  "peb %llu, "
+			  "range (start %u, len %u), err %d\n",
+			  pebi->peb_id,
+			  range.start, range.len, err);
+		goto finish_invalidate_block;
+	}
+
+finish_invalidate_block:
+	up_read(&pebc->lock);
+
+	return err;
+}
+
+/*
+ * is_peb_joined_into_create_requests_queue() - is PEB joined into create queue?
+ * @pebc: pointer on PEB container
+ */
+bool is_peb_joined_into_create_requests_queue(struct ssdfs_peb_container *pebc)
+{
+	bool is_joined;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pebc->crq_ptr_lock);
+	is_joined = pebc->create_rq != NULL;
+	spin_unlock(&pebc->crq_ptr_lock);
+
+	return is_joined;
+}
+
+/*
+ * ssdfs_peb_join_create_requests_queue() - join to process new page requests
+ * @pebc: pointer on PEB container
+ * @create_rq: pointer on shared new page requests queue
+ * @wait: wait queue of threads that process new pages
+ *
+ * This function select PEB's flush thread for processing new page
+ * requests. Namely, selected PEB object keeps pointer on shared
+ * new page requests queue and to join into wait queue of another
+ * flush threads.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ */
+int ssdfs_peb_join_create_requests_queue(struct ssdfs_peb_container *pebc,
+					 struct ssdfs_requests_queue *create_rq)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+	BUG_ON(!create_rq);
+
+	SSDFS_DBG("seg %llu, peb_index %u, create_rq %p\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, create_rq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_peb_joined_into_create_requests_queue(pebc)) {
+		SSDFS_ERR("PEB is joined into create requests queue yet: "
+			  "seg %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id, pebc->peb_index);
+		return -EINVAL;
+	}
+
+	if (pebc->thread[SSDFS_PEB_FLUSH_THREAD].task == NULL) {
+		SSDFS_ERR("PEB hasn't flush thread: "
+			  "seg %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id, pebc->peb_index);
+		return -EINVAL;
+	}
+
+	spin_lock(&pebc->crq_ptr_lock);
+	pebc->create_rq = create_rq;
+	spin_unlock(&pebc->crq_ptr_lock);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_forget_create_requests_queue() - forget create requests queue
+ * @pebc: pointer on PEB container
+ */
+void ssdfs_peb_forget_create_requests_queue(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+	WARN_ON(!is_peb_joined_into_create_requests_queue(pebc));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pebc->crq_ptr_lock);
+	pebc->create_rq = NULL;
+	spin_unlock(&pebc->crq_ptr_lock);
+}
+
+/*
+ * ssdfs_peb_container_change_state() - change PEB's state in mapping table
+ * @pebc: pointer on PEB container
+ *
+ * This method tries to change PEB's state in the mapping table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_container_change_state(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_peb_mapping_table *maptbl;
+	struct completion *end;
+	int items_state;
+	int used_pages, free_pages, invalid_pages;
+	int new_peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
+	u64 leb_id;
+	bool is_peb_exhausted = false;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	fsi = pebc->parent_si->fsi;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("pebc %p, seg %llu, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  pebc, si->seg_id, pebc->peb_index,
+		  pebc->peb_type, pebc->log_pages);
+#else
+	SSDFS_DBG("pebc %p, seg %llu, peb_index %u, "
+		  "peb_type %#x, log_pages %u\n",
+		  pebc, si->seg_id, pebc->peb_index,
+		  pebc->peb_type, pebc->log_pages);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	seg_blkbmap = &si->blk_bmap;
+	maptbl = fsi->maptbl;
+
+	if (pebc->peb_index >= seg_blkbmap->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  pebc->peb_index,
+			  seg_blkbmap->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi, si->seg_id,
+						pebc->peb_index);
+	if (leb_id == U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  si->seg_id, pebc->peb_index);
+		return -EINVAL;
+	}
+
+	items_state = atomic_read(&pebc->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: items_state %#x\n",
+				  items_state);
+			return -ERANGE;
+		}
+
+		free_pages = ssdfs_peb_blk_bmap_get_free_pages(peb_blkbmap);
+		if (free_pages < 0) {
+			err = free_pages;
+			SSDFS_ERR("fail to get free pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		used_pages = ssdfs_peb_blk_bmap_get_used_pages(peb_blkbmap);
+		if (used_pages < 0) {
+			err = used_pages;
+			SSDFS_ERR("fail to get used pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		invalid_pages =
+			ssdfs_peb_blk_bmap_get_invalid_pages(peb_blkbmap);
+		if (invalid_pages < 0) {
+			err = invalid_pages;
+			SSDFS_ERR("fail to get invalid pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free_pages %d, used_pages %d, "
+			  "invalid_pages %d, is_peb_exhausted %#x\n",
+			  free_pages, used_pages,
+			  invalid_pages, is_peb_exhausted);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (free_pages == 0) {
+			if (!is_peb_exhausted) {
+				new_peb_state =
+					SSDFS_MAPTBL_USING_PEB_STATE;
+			} else if (invalid_pages == 0) {
+				if (used_pages == 0) {
+					SSDFS_ERR("invalid state: "
+						  "free_pages %d, "
+						  "used_pages %d, "
+						  "invalid_pages %d\n",
+						  free_pages,
+						  used_pages,
+						  invalid_pages);
+					return -ERANGE;
+				}
+
+				new_peb_state =
+					SSDFS_MAPTBL_USED_PEB_STATE;
+			} else if (used_pages == 0) {
+				if (invalid_pages == 0) {
+					SSDFS_ERR("invalid state: "
+						  "free_pages %d, "
+						  "used_pages %d, "
+						  "invalid_pages %d\n",
+						  free_pages,
+						  used_pages,
+						  invalid_pages);
+					return -ERANGE;
+				}
+
+				new_peb_state =
+					SSDFS_MAPTBL_DIRTY_PEB_STATE;
+			} else {
+				new_peb_state =
+					SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+			}
+		} else if (used_pages == 0) {
+			if (invalid_pages == 0) {
+				new_peb_state =
+					SSDFS_MAPTBL_CLEAN_PEB_STATE;
+			} else {
+				new_peb_state =
+					SSDFS_MAPTBL_USING_PEB_STATE;
+			}
+		} else {
+			new_peb_state =
+				SSDFS_MAPTBL_USING_PEB_STATE;
+		}
+
+		err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+						    pebc->peb_type,
+						    new_peb_state, &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_maptbl_change_peb_state(fsi,
+							    leb_id,
+							    pebc->peb_type,
+							    new_peb_state,
+							    &end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change the PEB state: "
+				  "peb_id %llu, new_state %#x, err %d\n",
+				  pebi->peb_id, new_peb_state, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		pebi = pebc->dst_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: items_state %#x\n",
+				  items_state);
+			return -ERANGE;
+		}
+
+		free_pages = ssdfs_peb_blk_bmap_get_free_pages(peb_blkbmap);
+		if (free_pages < 0) {
+			err = free_pages;
+			SSDFS_ERR("fail to get free pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		used_pages = ssdfs_peb_blk_bmap_get_used_pages(peb_blkbmap);
+		if (used_pages < 0) {
+			err = used_pages;
+			SSDFS_ERR("fail to get used pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		invalid_pages =
+			ssdfs_peb_blk_bmap_get_invalid_pages(peb_blkbmap);
+		if (invalid_pages < 0) {
+			err = invalid_pages;
+			SSDFS_ERR("fail to get invalid pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("free_pages %d, used_pages %d, "
+			  "invalid_pages %d, is_peb_exhausted %#x\n",
+			  free_pages, used_pages,
+			  invalid_pages, is_peb_exhausted);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (free_pages == 0) {
+			if (!is_peb_exhausted) {
+				new_peb_state =
+					SSDFS_MAPTBL_USING_PEB_STATE;
+			} else if (invalid_pages == 0) {
+				if (used_pages == 0) {
+					SSDFS_ERR("invalid state: "
+						  "free_pages %d, "
+						  "used_pages %d, "
+						  "invalid_pages %d\n",
+						  free_pages,
+						  used_pages,
+						  invalid_pages);
+					return -ERANGE;
+				}
+
+				new_peb_state =
+					SSDFS_MAPTBL_USED_PEB_STATE;
+			} else if (used_pages == 0) {
+				if (invalid_pages == 0) {
+					SSDFS_ERR("invalid state: "
+						  "free_pages %d, "
+						  "used_pages %d, "
+						  "invalid_pages %d\n",
+						  free_pages,
+						  used_pages,
+						  invalid_pages);
+					return -ERANGE;
+				}
+
+				new_peb_state =
+					SSDFS_MAPTBL_DIRTY_PEB_STATE;
+			} else {
+				new_peb_state =
+					SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE;
+			}
+		} else if (used_pages == 0) {
+			if (invalid_pages == 0) {
+				new_peb_state =
+					SSDFS_MAPTBL_CLEAN_PEB_STATE;
+			} else {
+				new_peb_state =
+					SSDFS_MAPTBL_USING_PEB_STATE;
+			}
+		} else {
+			new_peb_state =
+				SSDFS_MAPTBL_USING_PEB_STATE;
+		}
+
+		err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+						    pebc->peb_type,
+						    new_peb_state, &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+							    pebc->peb_type,
+							    new_peb_state,
+							    &end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change the PEB state: "
+				  "peb_id %llu, new_state %#x, err %d\n",
+				  pebi->peb_id, new_peb_state, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: items_state %#x\n",
+				  items_state);
+			return -ERANGE;
+		}
+
+		free_pages = ssdfs_src_blk_bmap_get_free_pages(peb_blkbmap);
+		if (free_pages < 0) {
+			err = free_pages;
+			SSDFS_ERR("fail to get free pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		used_pages = ssdfs_src_blk_bmap_get_used_pages(peb_blkbmap);
+		if (used_pages < 0) {
+			err = used_pages;
+			SSDFS_ERR("fail to get used pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		invalid_pages =
+			ssdfs_src_blk_bmap_get_invalid_pages(peb_blkbmap);
+		if (invalid_pages < 0) {
+			err = invalid_pages;
+			SSDFS_ERR("fail to get invalid pages: err %d\n",
+				  err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("source PEB: free_pages %d, used_pages %d, "
+			  "invalid_pages %d\n",
+			  free_pages, used_pages, invalid_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (invalid_pages == 0) {
+			if (used_pages == 0) {
+				SSDFS_ERR("invalid state: "
+					  "used_pages %d, "
+					  "invalid_pages %d\n",
+					  used_pages,
+					  invalid_pages);
+				return -ERANGE;
+			}
+
+			new_peb_state =
+				SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE;
+		} else if (used_pages == 0) {
+			new_peb_state =
+				SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE;
+		} else {
+			new_peb_state =
+				SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE;
+		}
+
+		err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+						    pebc->peb_type,
+						    new_peb_state, &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+							    pebc->peb_type,
+							    new_peb_state,
+							    &end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change the PEB state: "
+				  "peb_id %llu, new_state %#x, err %d\n",
+				  pebi->peb_id, new_peb_state, err);
+			return err;
+		}
+
+		pebi = pebc->dst_peb;
+		if (!pebi) {
+			SSDFS_ERR("PEB pointer is NULL: "
+				  "items_state %#x\n",
+				  items_state);
+			return -ERANGE;
+		}
+
+		free_pages = ssdfs_dst_blk_bmap_get_free_pages(peb_blkbmap);
+		if (free_pages < 0) {
+			err = free_pages;
+			SSDFS_ERR("fail to get free pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		used_pages = ssdfs_dst_blk_bmap_get_used_pages(peb_blkbmap);
+		if (used_pages < 0) {
+			err = used_pages;
+			SSDFS_ERR("fail to get used pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		invalid_pages =
+			ssdfs_dst_blk_bmap_get_invalid_pages(peb_blkbmap);
+		if (invalid_pages < 0) {
+			err = invalid_pages;
+			SSDFS_ERR("fail to get invalid pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("destination PEB: free_pages %d, used_pages %d, "
+			  "invalid_pages %d, is_peb_exhausted %#x\n",
+			  free_pages, used_pages,
+			  invalid_pages, is_peb_exhausted);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (free_pages == 0) {
+			if (!is_peb_exhausted) {
+				new_peb_state =
+					SSDFS_MAPTBL_MIGRATION_DST_USING_STATE;
+			} else if (invalid_pages == 0) {
+				if (used_pages == 0) {
+					SSDFS_ERR("invalid state: "
+						  "free_pages %d, "
+						  "used_pages %d, "
+						  "invalid_pages %d\n",
+						  free_pages,
+						  used_pages,
+						  invalid_pages);
+					return -ERANGE;
+				}
+
+				new_peb_state =
+					SSDFS_MAPTBL_MIGRATION_DST_USED_STATE;
+			} else if (used_pages == 0) {
+				if (invalid_pages == 0) {
+					SSDFS_ERR("invalid state: "
+						  "free_pages %d, "
+						  "used_pages %d, "
+						  "invalid_pages %d\n",
+						  free_pages,
+						  used_pages,
+						  invalid_pages);
+					return -ERANGE;
+				}
+
+				new_peb_state =
+					SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE;
+			} else {
+				new_peb_state =
+				    SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE;
+			}
+		} else if (used_pages == 0) {
+			if (invalid_pages == 0) {
+				new_peb_state =
+					SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE;
+			} else {
+				new_peb_state =
+					SSDFS_MAPTBL_MIGRATION_DST_USING_STATE;
+			}
+		} else {
+			new_peb_state =
+				SSDFS_MAPTBL_MIGRATION_DST_USING_STATE;
+		}
+
+		err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+						    pebc->peb_type,
+						    new_peb_state, &end);
+		if (err == -EAGAIN) {
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_maptbl_change_peb_state(fsi, leb_id,
+							    pebc->peb_type,
+							    new_peb_state,
+							    &end);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change the PEB state: "
+				  "peb_id %llu, new_state %#x, err %d\n",
+				  pebi->peb_id, new_peb_state, err);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid PEB container's items_state: "
+			  "%#x\n",
+			  items_state);
+		return -ERANGE;
+	};
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
-- 
2.34.1

