Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA816A2633
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBYBQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBYBQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296D12BD6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bm20so798875oib.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S3GmeUOr0XGrkUiTYyCIRpgvmzKnmZ0HUQNcR+/F9A=;
        b=21H03ghy8s97v/JauWwYEc2psHz2jbQaLyM3C6+8rhIyQnQSoI6eq8kxf074Mr09n6
         Uohgk+d99QYDctjgYuXK7GzEaIxG59BFvgoLyHO82QEBARFdoh8uU/PGW8WH4rMbef3r
         GG7JkJnvb8w8g2a4gk1R6hgXEEncYxjn11l7DwstnwIRNMibS0Z0Yzu9ycGbgmqJ33PM
         z61SOR8GEAPf7d9kG64WLN2ZSWKHXZtQhTZQOtQN5I/rj6WmdD4luBilXSi8MR3aFHm7
         qK/oySaA/D0WNUEXTmrGcuWP+uSrDR0uahcQEVrNY+H5HRlB6Z/13yswrlUtWa2ev4cI
         /AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S3GmeUOr0XGrkUiTYyCIRpgvmzKnmZ0HUQNcR+/F9A=;
        b=3wKaCok0iiGavJU6biKSzxeHv0O9W0yDoWGY+xJqP++VoJXOE0n0wKLm0nrSWNRZQf
         UQH/TASWTk9fPBjW6TxL1ACwIeWpmNWuEqpn26gccjMRWUcKLcXbVVIByeHnWP0PJHi8
         F5O4G4xegVrC7QI0oTjWmBksbMa9RH3rARCNpSgNZj1OdwxTrazRZGjx+/ZSyltbUkeA
         sshpb46uLFl0XyKdbkNUOpr7+rEcab2gC4naQG12Z0vExfsVBBOmETXfxCQqdowHeHtG
         I90npawtzTPSzCGDFy3bHXxkutDbwPYJtYoDzvn07tyRF/wIQePj4bS4M8lCw7VWSXKv
         XaAQ==
X-Gm-Message-State: AO0yUKVfFZLMRrppN2XOkp9N8JCKTdiXR5eULX84fg/j4wBRwPYKY6CD
        XkknGFGRxWeoXkW1w8S7N1N5U4eYmzEngVHA
X-Google-Smtp-Source: AK7set9wMyG/nBz8TgyewGhCOz819RtVWgjVXTgXN1CdHxmisooVfVSC5fRomXR9+fKARJyXifzd+w==
X-Received: by 2002:aca:90b:0:b0:383:f036:cefa with SMTP id 11-20020aca090b000000b00383f036cefamr1288325oij.43.1677287774979;
        Fri, 24 Feb 2023 17:16:14 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:14 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 19/76] ssdfs: offset translation table API implementation
Date:   Fri, 24 Feb 2023 17:08:30 -0800
Message-Id: <20230225010927.813929-20-slava@dubeyko.com>
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

The responsibility of offset translation table is to implement
the mechanism of converting logical block ID into the physical
offset in the log. As a result, offset translation table
implements API:
(1) create - create empty offset translation table
(2) destroy - destroy offset translation table
(3) partial_init - initialize offset translation table by one fragment
(4) store_offsets_table - flush dirty fragments
(5) convert - convert logical block ID into offset descriptor
(6) allocate_block - allocate logical block
(7) allocate_extent - allocate logical extent
(8) change_offset - initialize offset of allocated logical block
(9) free_block - free logical block
(10) free_extent - free logical extent

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/offset_translation_table.c | 2996 +++++++++++++++++++++++++++
 1 file changed, 2996 insertions(+)

diff --git a/fs/ssdfs/offset_translation_table.c b/fs/ssdfs/offset_translation_table.c
index ccdabc3b7f72..bde595f69d9f 100644
--- a/fs/ssdfs/offset_translation_table.c
+++ b/fs/ssdfs/offset_translation_table.c
@@ -5162,3 +5162,2999 @@ int ssdfs_peb_store_offsets_table(struct ssdfs_peb_info *pebi,
 
 	return err;
 }
+
+/*
+ * ssdfs_blk2off_table_get_used_logical_blks() - get used logical blocks count
+ * @tbl: pointer on table object
+ * @used_blks: pointer on used logical blocks count [out]
+ *
+ * This method tries to get used logical blocks count.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - table doesn't initialized yet.
+ */
+int ssdfs_blk2off_table_get_used_logical_blks(struct ssdfs_blk2off_table *tbl,
+						u16 *used_blks)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !used_blks);
+
+	SSDFS_DBG("table %p, used_blks %p\n",
+		  tbl, used_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*used_blks = U16_MAX;
+
+	if (atomic_read(&tbl->state) < SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		SSDFS_DBG("table is not initialized yet\n");
+		return -EAGAIN;
+	}
+
+	down_read(&tbl->translation_lock);
+	*used_blks = tbl->used_logical_blks;
+	up_read(&tbl->translation_lock);
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_blk_desc_init() - init block descriptor for offset
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @pos: pointer of offset's position [in]
+ *
+ * This method tries to init block descriptor for offset.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ * %-ENODATA    - table doesn't contain logical block or corresponding ID.
+ */
+int ssdfs_blk2off_table_blk_desc_init(struct ssdfs_blk2off_table *table,
+					u16 logical_blk,
+					struct ssdfs_offset_position *pos)
+{
+	struct ssdfs_offset_position *old_pos = NULL;
+	struct ssdfs_blk_state_offset *state_off;
+	size_t desc_size = sizeof(struct ssdfs_block_descriptor_state);
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !pos);
+
+	SSDFS_DBG("table %p, logical_blk %u, pos %p\n",
+		  table, logical_blk, pos);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (logical_blk >= table->lblk2off_capacity) {
+		SSDFS_ERR("logical_blk %u >= lblk2off_capacity %u\n",
+			  logical_blk, table->lblk2off_capacity);
+		return -ERANGE;
+	}
+
+	down_write(&table->translation_lock);
+
+	if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+					    SSDFS_LBMAP_STATE_INDEX,
+					    table->lblk2off_capacity,
+					    logical_blk)) {
+		err = -ENODATA;
+		SSDFS_ERR("requested block %u hasn't been allocated\n",
+			  logical_blk);
+		goto finish_init;
+	}
+
+	old_pos = SSDFS_OFF_POS(ssdfs_dynamic_array_get_locked(&table->lblk2off,
+								logical_blk));
+	if (IS_ERR_OR_NULL(old_pos)) {
+		err = (old_pos == NULL ? -ENOENT : PTR_ERR(old_pos));
+		SSDFS_ERR("fail to get logical block: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		goto finish_init;
+	}
+
+	switch (old_pos->blk_desc.status) {
+	case SSDFS_BLK_DESC_BUF_UNKNOWN_STATE:
+	case SSDFS_BLK_DESC_BUF_ALLOCATED:
+		/* continue logic */
+		break;
+
+	case SSDFS_BLK_DESC_BUF_INITIALIZED:
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical block %u has been initialized\n",
+			  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_init;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid state %#x of blk desc buffer\n",
+			  old_pos->blk_desc.status);
+		goto finish_init;
+	}
+
+	state_off = &pos->blk_desc.buf.state[0];
+
+	if (IS_SSDFS_BLK_STATE_OFFSET_INVALID(state_off)) {
+		err = -ERANGE;
+		SSDFS_ERR("block state offset invalid\n");
+		SSDFS_ERR("log_start_page %u, log_area %u, "
+			  "peb_migration_id %u, byte_offset %u\n",
+			  le16_to_cpu(state_off->log_start_page),
+			  state_off->log_area,
+			  state_off->peb_migration_id,
+			  le32_to_cpu(state_off->byte_offset));
+		goto finish_init;
+	}
+
+	ssdfs_memcpy(&old_pos->blk_desc, 0, desc_size,
+		     &pos->blk_desc.buf, 0, desc_size,
+		     desc_size);
+
+finish_init:
+	ssdfs_dynamic_array_release(&table->lblk2off, logical_blk, old_pos);
+	up_write(&table->translation_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_get_checked_position() - get checked offset's position
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @pos: pointer of offset's position [out]
+ *
+ * This method tries to get and to check offset's position for
+ * requested logical block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ * %-ENODATA    - table doesn't contain logical block or corresponding ID.
+ * %-ENOENT     - table's fragment for requested logical block not initialized.
+ * %-EBUSY      - logical block hasn't ID yet.
+ */
+static
+int ssdfs_blk2off_table_get_checked_position(struct ssdfs_blk2off_table *table,
+					     u16 logical_blk,
+					     struct ssdfs_offset_position *pos)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	void *ptr;
+	size_t off_pos_size = sizeof(struct ssdfs_offset_position);
+	int state;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !pos);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p, logical_blk %u, pos %p\n",
+		  table, logical_blk, pos);
+
+	ssdfs_debug_blk2off_table_object(table);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (logical_blk >= table->lblk2off_capacity) {
+		SSDFS_ERR("logical_blk %u >= lblk2off_capacity %u\n",
+			  logical_blk, table->lblk2off_capacity);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("init_bmap %lx, state_bmap %lx, modification_bmap %lx\n",
+		  *table->lbmap.array[SSDFS_LBMAP_INIT_INDEX],
+		  *table->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  *table->lbmap.array[SSDFS_LBMAP_MODIFICATION_INDEX]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+					    SSDFS_LBMAP_STATE_INDEX,
+					    table->lblk2off_capacity,
+					    logical_blk)) {
+		SSDFS_ERR("requested block %u hasn't been allocated\n",
+			  logical_blk);
+		return -ENODATA;
+	}
+
+	ptr = ssdfs_dynamic_array_get_locked(&table->lblk2off, logical_blk);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = (ptr == NULL ? -ENOENT : PTR_ERR(ptr));
+		SSDFS_ERR("fail to get logical block: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+	ssdfs_memcpy(pos, 0, off_pos_size,
+		     ptr, 0, off_pos_size,
+		     off_pos_size);
+
+	err = ssdfs_dynamic_array_release(&table->lblk2off, logical_blk, ptr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to release: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+	if (pos->id == SSDFS_INVALID_OFFSET_ID) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical block %u hasn't ID yet\n",
+			  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EBUSY;
+	}
+
+	if (pos->peb_index >= table->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  pos->peb_index, table->pebs_count);
+		return -ERANGE;
+	}
+
+	if (pos->sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("sequence_id %u is out of order\n",
+			  pos->sequence_id);
+		return -ERANGE;
+	}
+
+	phys_off_table = &table->peb[pos->peb_index];
+
+	sequence = phys_off_table->sequence;
+	ptr = ssdfs_sequence_array_get_item(sequence, pos->sequence_id);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = (ptr == NULL ? -ENOENT : PTR_ERR(ptr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  pos->sequence_id, err);
+		return err;
+	}
+	fragment = (struct ssdfs_phys_offset_table_fragment *)ptr;
+
+	state = atomic_read(&fragment->state);
+	if (state < SSDFS_BLK2OFF_FRAG_INITIALIZED) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u is not initialized yet\n",
+			  pos->sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	} else if (state >= SSDFS_BLK2OFF_FRAG_STATE_MAX) {
+		SSDFS_ERR("unknown fragment's state\n");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_check_fragment_desc() - check fragment's description
+ * @table: pointer on table object
+ * @frag: pointer on fragment
+ * @pos: pointer of offset's position
+ *
+ * This method tries to check fragment's description.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ */
+static
+int ssdfs_blk2off_table_check_fragment_desc(struct ssdfs_blk2off_table *table,
+				struct ssdfs_phys_offset_table_fragment *frag,
+				struct ssdfs_offset_position *pos)
+{
+	u16 start_id;
+	int id_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !frag || !pos);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p, id %u, peb_index %u, "
+		  "sequence_id %u, offset_index %u\n",
+		  table, pos->id, pos->peb_index,
+		  pos->sequence_id, pos->offset_index);
+
+	BUG_ON(!rwsem_is_locked(&frag->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_id = frag->start_id;
+	id_count = atomic_read(&frag->id_count);
+
+	if (pos->id < start_id || pos->id >= (start_id + id_count)) {
+		SSDFS_ERR("id %u out of range (start %u, len %u)\n",
+			  pos->id, start_id, id_count);
+		return -ERANGE;
+	}
+
+	if (pos->offset_index >= id_count) {
+		SSDFS_ERR("offset_index %u >= id_count %u\n",
+			  pos->offset_index, id_count);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!frag->phys_offs) {
+		SSDFS_ERR("offsets table pointer is NULL\n");
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+bool has_logical_block_id_assigned(struct ssdfs_blk2off_table *table,
+				   u16 logical_blk)
+{
+	u16 capacity;
+	bool has_assigned = false;
+
+	down_read(&table->translation_lock);
+	capacity = table->lblk2off_capacity;
+	has_assigned = !ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+						SSDFS_LBMAP_MODIFICATION_INDEX,
+						capacity,
+						logical_blk);
+	up_read(&table->translation_lock);
+
+	return has_assigned;
+}
+
+/*
+ * ssdfs_blk2off_table_convert() - convert logical block into offset
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @peb_index: pointer on PEB index value [out]
+ * @migration_state: migration state of the block [out]
+ * @pos: offset position [out]
+ *
+ * This method tries to convert logical block number into offset.
+ *
+ * RETURN:
+ * [success] - pointer on found offset.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for conversion yet.
+ * %-ENODATA    - table doesn't contain logical block.
+ * %-ENOENT     - table's fragment for requested logical block not initialized
+ */
+struct ssdfs_phys_offset_descriptor *
+ssdfs_blk2off_table_convert(struct ssdfs_blk2off_table *table,
+			    u16 logical_blk,
+			    u16 *peb_index,
+			    int *migration_state,
+			    struct ssdfs_offset_position *pos)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	struct ssdfs_phys_offset_descriptor *ptr = NULL;
+	struct ssdfs_migrating_block *blk = NULL;
+	void *kaddr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !peb_index || !pos);
+
+	SSDFS_DBG("table %p, logical_blk %u\n",
+		  table, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*peb_index = U16_MAX;
+
+	down_read(&table->translation_lock);
+
+	if (logical_blk >= table->lblk2off_capacity) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to convert logical block: "
+			  "block %u >= capacity %u\n",
+			  logical_blk,
+			  table->lblk2off_capacity);
+		goto finish_translation;
+	}
+
+	if (atomic_read(&table->state) <= SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		u16 capacity = table->lblk2off_capacity;
+
+		if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+						    SSDFS_LBMAP_INIT_INDEX,
+						    capacity,
+						    logical_blk)) {
+			err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("table is not initialized yet: "
+				  "logical_blk %u\n",
+				  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_translation;
+		}
+	}
+
+	if (migration_state) {
+		blk = ssdfs_get_migrating_block(table, logical_blk, false);
+		if (IS_ERR_OR_NULL(blk))
+			*migration_state = SSDFS_LBLOCK_UNKNOWN_STATE;
+		else
+			*migration_state = blk->state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, migration_state %#x\n",
+			  logical_blk, *migration_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	err = ssdfs_blk2off_table_get_checked_position(table, logical_blk,
+							pos);
+	if (err == -EBUSY) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to get checked position: logical_blk %u\n",
+		          logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		up_read(&table->translation_lock);
+		wait_event_interruptible_timeout(table->wait_queue,
+				has_logical_block_id_assigned(table,
+							logical_blk),
+				SSDFS_DEFAULT_TIMEOUT);
+		down_read(&table->translation_lock);
+
+		err = ssdfs_blk2off_table_get_checked_position(table,
+								logical_blk,
+								pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get checked offset's position: "
+				  "logical_block %u, err %d\n",
+				  logical_blk, err);
+			goto finish_translation;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get checked offset's position: "
+			  "logical_block %u, err %d\n",
+			  logical_blk, err);
+		goto finish_translation;
+	}
+
+	*peb_index = pos->peb_index;
+	phys_off_table = &table->peb[pos->peb_index];
+
+	sequence = phys_off_table->sequence;
+	kaddr = ssdfs_sequence_array_get_item(sequence, pos->sequence_id);
+	if (IS_ERR_OR_NULL(kaddr)) {
+		err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  pos->sequence_id, err);
+		goto finish_translation;
+	}
+	fragment = (struct ssdfs_phys_offset_table_fragment *)kaddr;
+
+	down_read(&fragment->lock);
+
+	err = ssdfs_blk2off_table_check_fragment_desc(table, fragment, pos);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid fragment description: err %d\n", err);
+		goto finish_fragment_lookup;
+	}
+
+	ptr = &fragment->phys_offs[pos->offset_index];
+
+finish_fragment_lookup:
+	up_read(&fragment->lock);
+
+finish_translation:
+	up_read(&table->translation_lock);
+
+	if (err)
+		return ERR_PTR(err);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, "
+		  "logical_offset %u, peb_index %u, peb_page %u, "
+		  "log_start_page %u, log_area %u, "
+		  "peb_migration_id %u, byte_offset %u\n",
+		  logical_blk,
+		  le32_to_cpu(ptr->page_desc.logical_offset),
+		  pos->peb_index,
+		  le16_to_cpu(ptr->page_desc.peb_page),
+		  le16_to_cpu(ptr->blk_state.log_start_page),
+		  ptr->blk_state.log_area,
+		  ptr->blk_state.peb_migration_id,
+		  le32_to_cpu(ptr->blk_state.byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ptr;
+}
+
+/*
+ * ssdfs_blk2off_table_get_offset_position() - get offset position
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @pos: offset position
+ *
+ * This method tries to get offset position.
+ *
+ * RETURN:
+ * [success] - pointer on found offset.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for conversion yet.
+ * %-ENODATA    - table doesn't contain logical block.
+ */
+int ssdfs_blk2off_table_get_offset_position(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    struct ssdfs_offset_position *pos)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !pos);
+
+	SSDFS_DBG("table %p, logical_blk %u\n",
+		  table, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&table->translation_lock);
+
+	if (logical_blk >= table->lblk2off_capacity) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to convert logical block: "
+			  "block %u >= capacity %u\n",
+			  logical_blk,
+			  table->lblk2off_capacity);
+		goto finish_extract_position;
+	}
+
+	if (atomic_read(&table->state) <= SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		u16 capacity = table->lblk2off_capacity;
+
+		if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+						    SSDFS_LBMAP_INIT_INDEX,
+						    capacity,
+						    logical_blk)) {
+			err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("table is not initialized yet: "
+				  "logical_blk %u\n",
+				  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_extract_position;
+		}
+	}
+
+	err = ssdfs_blk2off_table_get_checked_position(table, logical_blk,
+							pos);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get checked offset's position: "
+			  "logical_block %u, err %d\n",
+			  logical_blk, err);
+		goto finish_extract_position;
+	}
+
+finish_extract_position:
+	up_read(&table->translation_lock);
+
+	if (err)
+		return err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, "
+		  "pos->cno %llu, pos->id %u, pos->peb_index %u, "
+		  "pos->sequence_id %u, pos->offset_index %u\n",
+		  logical_blk, pos->cno, pos->id,
+		  pos->peb_index, pos->sequence_id,
+		  pos->offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * calculate_rest_range_id_count() - get rest range's IDs
+ * @ptr: pointer on fragment object
+ *
+ * This method calculates the rest count of IDs.
+ */
+static inline
+int calculate_rest_range_id_count(struct ssdfs_phys_offset_table_fragment *ptr)
+{
+	int id_count = atomic_read(&ptr->id_count);
+	size_t blk2off_tbl_hdr_size = sizeof(struct ssdfs_blk2off_table_header);
+	size_t hdr_size = sizeof(struct ssdfs_phys_offset_table_header);
+	size_t off_size = sizeof(struct ssdfs_phys_offset_descriptor);
+	size_t metadata_size = blk2off_tbl_hdr_size + hdr_size;
+	int id_capacity;
+	int start_id = ptr->start_id;
+	int rest_range_ids;
+
+	if ((start_id + id_count) > SSDFS_INVALID_OFFSET_ID) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_id %d, id_count %d\n",
+			  start_id, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	id_capacity = (ptr->buf_size - metadata_size) / off_size;
+
+	if (id_count >= id_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("id_count %d, id_capacity %d\n",
+			  id_count, id_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	rest_range_ids = id_capacity - id_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("id_count %d, id_capacity %d, rest_range_ids %d\n",
+		  id_count, id_capacity, rest_range_ids);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return rest_range_ids;
+}
+
+/*
+ * is_id_valid_for_assignment() - check ID validity
+ * @table: pointer on table object
+ * @ptr: pointer on fragment object
+ * @id: ID value
+ */
+static
+bool is_id_valid_for_assignment(struct ssdfs_blk2off_table *table,
+				struct ssdfs_phys_offset_table_fragment *ptr,
+				int id)
+{
+	int id_count = atomic_read(&ptr->id_count);
+	int rest_range_ids;
+
+	if (id < ptr->start_id) {
+		SSDFS_WARN("id %d < start_id %u\n",
+			   id, ptr->start_id);
+		return false;
+	}
+
+	if (id > (ptr->start_id + id_count)) {
+		SSDFS_WARN("id %d > (ptr->start_id %u + id_count %d)",
+			   id, ptr->start_id, id_count);
+		return false;
+	}
+
+	rest_range_ids = calculate_rest_range_id_count(ptr);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("id %d, rest_range_ids %d\n",
+		  id, rest_range_ids);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return rest_range_ids > 0;
+}
+
+/*
+ * ssdfs_blk2off_table_assign_id() - assign ID for logical block
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @peb_index: PEB's index
+ * @blk_desc: block descriptor
+ * @last_sequence_id: pointer on last fragment index [out]
+ *
+ * This method tries to define physical offset's ID value for
+ * requested logical block number in last actual PEB's fragment.
+ * If the last actual fragment hasn't vacant ID then the method
+ * returns error and found last fragment index in
+ * @last_sequence_id.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - internal logic error.
+ * %-ENOENT     - table's fragment for requested logical block not initialized
+ * %-ENOSPC     - fragment hasn't vacant IDs and it needs to initialize next one
+ */
+static
+int ssdfs_blk2off_table_assign_id(struct ssdfs_blk2off_table *table,
+				  u16 logical_blk, u16 peb_index,
+				  struct ssdfs_block_descriptor *blk_desc,
+				  u16 *last_sequence_id)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	struct ssdfs_offset_position *pos;
+	int state;
+	int id = -1;
+	u16 offset_index = U16_MAX;
+	u16 capacity;
+	void *kaddr;
+	unsigned long last_id;
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !last_sequence_id);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p, logical_blk %u, peb_index %u\n",
+		  table, logical_blk, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= table->pebs_count) {
+		SSDFS_ERR("fail to change offset value: "
+			  "peb_index %u >= pebs_count %u\n",
+			  peb_index, table->pebs_count);
+		return -EINVAL;
+	}
+
+	capacity = table->lblk2off_capacity;
+	phys_off_table = &table->peb[peb_index];
+
+	state = atomic_read(&phys_off_table->state);
+	if (state < SSDFS_BLK2OFF_TABLE_PARTIAL_INIT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("table is not initialized for peb %u\n",
+			  peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	} else if (state >= SSDFS_BLK2OFF_TABLE_STATE_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unknown table state %#x\n",
+			  state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	sequence = phys_off_table->sequence;
+
+	if (is_ssdfs_sequence_array_last_id_invalid(sequence)) {
+		/* first creation */
+		return -ENOSPC;
+	}
+
+	last_id = ssdfs_sequence_array_last_id(sequence);
+	if (last_id >= U16_MAX) {
+		SSDFS_ERR("invalid last_id %lu\n", last_id);
+		return -ERANGE;
+	} else
+		*last_sequence_id = (u16)last_id;
+
+	if (*last_sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("invalid last_sequence_id %d\n",
+			  *last_sequence_id);
+		return -ERANGE;
+	}
+
+	kaddr = ssdfs_sequence_array_get_item(sequence, *last_sequence_id);
+	if (IS_ERR_OR_NULL(kaddr)) {
+		err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  *last_sequence_id, err);
+		return err;
+	}
+	fragment = (struct ssdfs_phys_offset_table_fragment *)kaddr;
+
+	state = atomic_read(&fragment->state);
+	if (state < SSDFS_BLK2OFF_FRAG_CREATED) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u isn't created\n",
+			  *last_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	} else if (state == SSDFS_BLK2OFF_FRAG_UNDER_COMMIT ||
+		   state == SSDFS_BLK2OFF_FRAG_COMMITED) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %d is under commit\n",
+			  *last_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	} else if (state >= SSDFS_BLK2OFF_FRAG_STATE_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unknown fragment state %#x\n",
+			  state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	pos = SSDFS_OFF_POS(ssdfs_dynamic_array_get_locked(&table->lblk2off,
+							   logical_blk));
+	if (IS_ERR_OR_NULL(pos)) {
+		err = (pos == NULL ? -ENOENT : PTR_ERR(pos));
+		SSDFS_ERR("fail to get logical block: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("POS BEFORE: cno %llu, id %u, peb_index %u, "
+		  "sequence_id %u, offset_index %u\n",
+		  pos->cno, pos->id, pos->peb_index,
+		  pos->sequence_id, pos->offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+					     SSDFS_LBMAP_MODIFICATION_INDEX,
+					     capacity,
+					     logical_blk)) {
+		if (pos->sequence_id == *last_sequence_id) {
+			pos->cno = ssdfs_current_cno(table->fsi->sb);
+			pos->peb_index = peb_index;
+			id = pos->id;
+			offset_index = pos->offset_index;
+		} else if (pos->sequence_id < *last_sequence_id) {
+			offset_index =
+				atomic_inc_return(&fragment->id_count) - 1;
+			id = fragment->start_id + offset_index;
+
+			if (!is_id_valid_for_assignment(table, fragment, id)) {
+				err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("id %d cannot be assign "
+					  "for fragment %d\n",
+					  id, *last_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				atomic_dec(&fragment->id_count);
+				goto finish_assign_id;
+			}
+
+			pos->cno = ssdfs_current_cno(table->fsi->sb);
+			pos->id = (u16)id;
+			pos->peb_index = peb_index;
+			pos->sequence_id = *last_sequence_id;
+			pos->offset_index = offset_index;
+		} else if (pos->sequence_id >= SSDFS_INVALID_FRAG_ID) {
+			offset_index =
+				atomic_inc_return(&fragment->id_count) - 1;
+			id = fragment->start_id + offset_index;
+
+			if (!is_id_valid_for_assignment(table, fragment, id)) {
+				err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("id %d cannot be assign "
+					  "for fragment %d\n",
+					  id, *last_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				atomic_dec(&fragment->id_count);
+				goto finish_assign_id;
+			}
+
+			pos->cno = ssdfs_current_cno(table->fsi->sb);
+			pos->id = (u16)id;
+			pos->peb_index = peb_index;
+			pos->sequence_id = *last_sequence_id;
+			pos->offset_index = offset_index;
+		} else if (pos->sequence_id > *last_sequence_id) {
+			err = -ERANGE;
+			SSDFS_WARN("sequence_id %u > last_sequence_id %d\n",
+				  pos->sequence_id,
+				  *last_sequence_id);
+			goto finish_assign_id;
+		}
+	} else {
+		offset_index = atomic_inc_return(&fragment->id_count) - 1;
+		id = fragment->start_id + offset_index;
+
+		if (!is_id_valid_for_assignment(table, fragment, id)) {
+			err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("id %d cannot be assign for fragment %d\n",
+				  id, *last_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			atomic_dec(&fragment->id_count);
+			goto finish_assign_id;
+		}
+
+		pos->cno = ssdfs_current_cno(table->fsi->sb);
+		pos->id = (u16)id;
+		pos->peb_index = peb_index;
+		pos->sequence_id = *last_sequence_id;
+		pos->offset_index = offset_index;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("POS AFTER: cno %llu, id %u, peb_index %u, "
+		  "sequence_id %u, offset_index %u\n",
+		  pos->cno, pos->id, pos->peb_index,
+		  pos->sequence_id, pos->offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blk_desc) {
+		ssdfs_memcpy(&pos->blk_desc.buf,
+			     0, sizeof(struct ssdfs_block_descriptor),
+			     blk_desc,
+			     0, sizeof(struct ssdfs_block_descriptor),
+			     sizeof(struct ssdfs_block_descriptor));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, id %d, "
+			  "peb_index %u, sequence_id %u, offset_index %u\n",
+			  logical_blk, id, peb_index,
+			  *last_sequence_id, offset_index);
+
+		for (i = 0; i < SSDFS_BLK_STATE_OFF_MAX; i++) {
+			struct ssdfs_blk_state_offset *offset = NULL;
+
+			offset = &blk_desc->state[i];
+
+			SSDFS_DBG("BLK STATE OFFSET %d: "
+				  "log_start_page %u, log_area %#x, "
+				  "byte_offset %u, "
+				  "peb_migration_id %u\n",
+				  i,
+				  le16_to_cpu(offset->log_start_page),
+				  offset->log_area,
+				  le32_to_cpu(offset->byte_offset),
+				  offset->peb_migration_id);
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("DONE: logical_blk %u, id %d, "
+		  "peb_index %u, sequence_id %u, offset_index %u\n",
+		  logical_blk, id, peb_index,
+		  *last_sequence_id, offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_assign_id:
+	ssdfs_dynamic_array_release(&table->lblk2off, logical_blk, pos);
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_add_fragment() - add fragment into PEB's table
+ * @table: pointer on table object
+ * @peb_index: PEB's index
+ * @old_sequence_id: old last sequence id
+ *
+ * This method tries to initialize additional fragment into
+ * PEB's table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - PEB's fragment count isn't equal to @old_fragment_count
+ * %-ENOSPC     - table hasn't space for new fragments
+ */
+static
+int ssdfs_blk2off_table_add_fragment(struct ssdfs_blk2off_table *table,
+					u16 peb_index,
+					u16 old_sequence_id)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment, *prev_fragment;
+	unsigned long last_sequence_id = ULONG_MAX;
+	u16 start_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p,  peb_index %u, old_sequence_id %d\n",
+		  table, peb_index, old_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= table->pebs_count) {
+		SSDFS_ERR("fail to change offset value: "
+			  "peb_index %u >= pebs_count %u\n",
+			  peb_index, table->pebs_count);
+		return -EINVAL;
+	}
+
+	phys_off_table = &table->peb[peb_index];
+	sequence = phys_off_table->sequence;
+
+	if (is_ssdfs_sequence_array_last_id_invalid(sequence)) {
+		/*
+		 * first creation
+		 */
+	} else {
+		last_sequence_id = ssdfs_sequence_array_last_id(sequence);
+		if (last_sequence_id != old_sequence_id) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("last_id %lu != old_id %u\n",
+				  last_sequence_id, old_sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EAGAIN;
+		}
+	}
+
+	fragment = ssdfs_blk2off_frag_alloc();
+	if (IS_ERR_OR_NULL(fragment)) {
+		err = (fragment == NULL ? -ENOMEM : PTR_ERR(fragment));
+		SSDFS_ERR("fail to allocate fragment: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_sequence_array_add_item(sequence, fragment,
+					    &last_sequence_id);
+	if (unlikely(err)) {
+		ssdfs_blk2off_frag_free(fragment);
+		SSDFS_ERR("fail to add fragment: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (last_sequence_id == 0) {
+		start_id = 0;
+	} else {
+		int prev_id_count;
+		void *kaddr;
+
+		kaddr = ssdfs_sequence_array_get_item(sequence,
+						      last_sequence_id - 1);
+		if (IS_ERR_OR_NULL(kaddr)) {
+			err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+			SSDFS_ERR("fail to get fragment: "
+				  "sequence_id %lu, err %d\n",
+				  last_sequence_id - 1, err);
+			return err;
+		}
+		prev_fragment =
+			(struct ssdfs_phys_offset_table_fragment *)kaddr;
+
+		start_id = prev_fragment->start_id;
+		prev_id_count = atomic_read(&prev_fragment->id_count);
+
+		if ((start_id + prev_id_count + 1) >= SSDFS_INVALID_OFFSET_ID)
+			start_id = 0;
+		else
+			start_id += prev_id_count;
+	}
+
+	err = ssdfs_blk2off_table_init_fragment(fragment, last_sequence_id,
+						start_id, table->pages_per_peb,
+						SSDFS_BLK2OFF_FRAG_INITIALIZED,
+						NULL);
+	if (err) {
+		SSDFS_ERR("fail to init fragment %lu: err %d\n",
+			  last_sequence_id, err);
+		return err;
+	}
+
+	atomic_inc(&phys_off_table->fragment_count);
+
+	return 0;
+}
+
+/*
+ * ssdfs_table_fragment_set_dirty() - set fragment dirty
+ * @table: pointer on table object
+ * @peb_index: PEB's index value
+ * @sequence_id: fragment's sequence_id
+ */
+static inline
+int ssdfs_table_fragment_set_dirty(struct ssdfs_blk2off_table *table,
+				    u16 peb_index, u16 sequence_id)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	int new_state = SSDFS_BLK2OFF_TABLE_UNDEFINED;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p,  peb_index %u, sequence_id %u\n",
+		  table, peb_index, sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	phys_off_table = &table->peb[peb_index];
+
+	err = ssdfs_sequence_array_change_state(phys_off_table->sequence,
+						sequence_id,
+						SSDFS_SEQUENCE_ITEM_NO_TAG,
+						SSDFS_SEQUENCE_ITEM_DIRTY_TAG,
+						ssdfs_change_fragment_state,
+						SSDFS_BLK2OFF_FRAG_INITIALIZED,
+						SSDFS_BLK2OFF_FRAG_DIRTY);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set fragment dirty: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		return err;
+	}
+
+	switch (atomic_read(&phys_off_table->state)) {
+	case SSDFS_BLK2OFF_TABLE_COMPLETE_INIT:
+		new_state = SSDFS_BLK2OFF_TABLE_DIRTY;
+		break;
+
+	case SSDFS_BLK2OFF_TABLE_PARTIAL_INIT:
+		new_state = SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT;
+		break;
+
+	case SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT:
+		SSDFS_DBG("blk2off table is dirty already\n");
+		new_state = SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT;
+		break;
+
+	case SSDFS_BLK2OFF_TABLE_DIRTY:
+		SSDFS_DBG("blk2off table is dirty already\n");
+		new_state = SSDFS_BLK2OFF_TABLE_DIRTY;
+		break;
+
+	default:
+		SSDFS_WARN("unexpected blk2off state %#x\n",
+			   atomic_read(&phys_off_table->state));
+		new_state = SSDFS_BLK2OFF_TABLE_DIRTY;
+		break;
+	}
+
+	atomic_set(&phys_off_table->state,
+		   new_state);
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_fragment_set_clean() - set fragment clean
+ * @table: pointer on table object
+ * @peb_index: PEB's index value
+ * @sequence_id: fragment's sequence_id
+ */
+#ifdef CONFIG_SSDFS_TESTING
+int ssdfs_blk2off_table_fragment_set_clean(struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	int new_state = SSDFS_BLK2OFF_TABLE_COMPLETE_INIT;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p,  peb_index %u, sequence_id %u\n",
+		  table, peb_index, sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	phys_off_table = &table->peb[peb_index];
+
+	err = ssdfs_sequence_array_change_state(phys_off_table->sequence,
+						sequence_id,
+						SSDFS_SEQUENCE_ITEM_DIRTY_TAG,
+						SSDFS_SEQUENCE_ITEM_NO_TAG,
+						ssdfs_change_fragment_state,
+						SSDFS_BLK2OFF_FRAG_DIRTY,
+						SSDFS_BLK2OFF_FRAG_INITIALIZED);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set fragment clean: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		return err;
+	}
+
+	atomic_set(&phys_off_table->state, new_state);
+
+	return 0;
+}
+#endif /* CONFIG_SSDFS_TESTING */
+
+/*
+ * ssdfs_blk2off_table_change_offset() - update logical block's offset
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @peb_index: PEB's index value
+ * @blk_desc: block descriptor
+ * @off: new value of offset [in]
+ *
+ * This method tries to update offset value for logical block.
+ * Firstly, logical blocks' state bitmap is set when allocation
+ * takes place. But table->lblk2off array contains U16_MAX for
+ * this logical block number. It means that logical block was
+ * allocated but it doesn't correspond to any physical offset
+ * ID. Secondly, it needs to provide every call of
+ * ssdfs_blk2off_table_change_offset() with peb_index value.
+ * In such situation the method sets correspondence between
+ * logical block and physical offset ID.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for this change yet.
+ * %-ENODATA    - table doesn't contain logical block.
+ * %-ENOENT     - table's fragment for requested logical block not initialized
+ */
+int ssdfs_blk2off_table_change_offset(struct ssdfs_blk2off_table *table,
+				      u16 logical_blk,
+				      u16 peb_index,
+				      struct ssdfs_block_descriptor *blk_desc,
+				      struct ssdfs_phys_offset_descriptor *off)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	struct ssdfs_offset_position pos = {0};
+	u16 last_sequence_id = SSDFS_INVALID_FRAG_ID;
+	void *kaddr;
+	u16 capacity;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("table %p, logical_blk %u, peb_index %u, "
+		  "off->page_desc.logical_offset %u, "
+		  "off->page_desc.logical_blk %u, "
+		  "off->page_desc.peb_page %u, "
+		  "off->blk_state.log_start_page %u, "
+		  "off->blk_state.log_area %u, "
+		  "off->blk_state.peb_migration_id %u, "
+		  "off->blk_state.byte_offset %u\n",
+		  table, logical_blk, peb_index,
+		  le32_to_cpu(off->page_desc.logical_offset),
+		  le16_to_cpu(off->page_desc.logical_blk),
+		  le16_to_cpu(off->page_desc.peb_page),
+		  le16_to_cpu(off->blk_state.log_start_page),
+		  off->blk_state.log_area,
+		  off->blk_state.peb_migration_id,
+		  le32_to_cpu(off->blk_state.byte_offset));
+#else
+	SSDFS_DBG("table %p, logical_blk %u, peb_index %u, "
+		  "off->page_desc.logical_offset %u, "
+		  "off->page_desc.logical_blk %u, "
+		  "off->page_desc.peb_page %u, "
+		  "off->blk_state.log_start_page %u, "
+		  "off->blk_state.log_area %u, "
+		  "off->blk_state.peb_migration_id %u, "
+		  "off->blk_state.byte_offset %u\n",
+		  table, logical_blk, peb_index,
+		  le32_to_cpu(off->page_desc.logical_offset),
+		  le16_to_cpu(off->page_desc.logical_blk),
+		  le16_to_cpu(off->page_desc.peb_page),
+		  le16_to_cpu(off->blk_state.log_start_page),
+		  off->blk_state.log_area,
+		  off->blk_state.peb_migration_id,
+		  le32_to_cpu(off->blk_state.byte_offset));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (peb_index >= table->pebs_count) {
+		SSDFS_ERR("fail to change offset value: "
+			  "peb_index %u >= pebs_count %u\n",
+			  peb_index, table->pebs_count);
+		return -EINVAL;
+	}
+
+	down_write(&table->translation_lock);
+
+	if (logical_blk >= table->lblk2off_capacity) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to convert logical block: "
+			  "block %u >= capacity %u\n",
+			  logical_blk,
+			  table->lblk2off_capacity);
+		goto finish_table_modification;
+	}
+
+	capacity = table->lblk2off_capacity;
+
+	if (atomic_read(&table->state) <= SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+						    SSDFS_LBMAP_INIT_INDEX,
+						    capacity,
+						    logical_blk)) {
+			err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("table is not initialized yet: "
+				  "logical_blk %u\n",
+				  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_table_modification;
+		}
+	}
+
+	if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+					    SSDFS_LBMAP_STATE_INDEX,
+					    capacity,
+					    logical_blk)) {
+		err = -ENODATA;
+		SSDFS_ERR("logical block is not allocated yet: "
+			  "logical_blk %u\n",
+			  logical_blk);
+		goto finish_table_modification;
+	}
+
+	err = ssdfs_blk2off_table_assign_id(table, logical_blk,
+					    peb_index, blk_desc,
+					    &last_sequence_id);
+	if (err == -ENOSPC) {
+		err = ssdfs_blk2off_table_add_fragment(table, peb_index,
+							last_sequence_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add fragment: "
+				  "peb_index %u, err %d\n",
+				  peb_index, err);
+			goto finish_table_modification;
+		}
+
+		err = ssdfs_blk2off_table_assign_id(table, logical_blk,
+						    peb_index, blk_desc,
+						    &last_sequence_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to assign id: "
+				  "peb_index %u, logical_blk %u, err %d\n",
+				  peb_index, logical_blk, err);
+			goto finish_table_modification;
+		}
+	} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("meet unintialized fragment: "
+			  "peb_index %u, logical_blk %u\n",
+			  peb_index, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_table_modification;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to assign id: "
+			  "peb_index %u, logical_blk %u, err %d\n",
+			  peb_index, logical_blk, err);
+		goto finish_table_modification;
+	}
+
+	err = ssdfs_blk2off_table_get_checked_position(table, logical_blk,
+							&pos);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get checked offset's position: "
+			  "logical_block %u, err %d\n",
+			  logical_blk, err);
+		goto finish_table_modification;
+	}
+
+	phys_off_table = &table->peb[peb_index];
+
+	sequence = phys_off_table->sequence;
+	kaddr = ssdfs_sequence_array_get_item(sequence, pos.sequence_id);
+	if (IS_ERR_OR_NULL(kaddr)) {
+		err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  pos.sequence_id, err);
+		goto finish_table_modification;
+	}
+	fragment = (struct ssdfs_phys_offset_table_fragment *)kaddr;
+
+	down_write(&fragment->lock);
+
+	err = ssdfs_blk2off_table_check_fragment_desc(table, fragment, &pos);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid fragment description: err %d\n", err);
+		goto finish_fragment_modification;
+	}
+
+	err = ssdfs_blk2off_table_bmap_set(&table->lbmap,
+					   SSDFS_LBMAP_MODIFICATION_INDEX,
+					   logical_blk);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set bitmap: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		goto finish_fragment_modification;
+	}
+
+	downgrade_write(&table->translation_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, POS: cno %llu, id %u, "
+		  "peb_index %u, sequence_id %u, offset_index %u\n",
+		  logical_blk, pos.cno, pos.id, pos.peb_index,
+		  pos.sequence_id, pos.offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_memcpy(&fragment->phys_offs[pos.offset_index],
+		     0, sizeof(struct ssdfs_phys_offset_descriptor),
+		     off, 0, sizeof(struct ssdfs_phys_offset_descriptor),
+		     sizeof(struct ssdfs_phys_offset_descriptor));
+
+	ssdfs_table_fragment_set_dirty(table, peb_index, pos.sequence_id);
+
+	up_write(&fragment->lock);
+	up_read(&table->translation_lock);
+
+	wake_up_all(&table->wait_queue);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+finish_fragment_modification:
+	up_write(&fragment->lock);
+
+finish_table_modification:
+	up_write(&table->translation_lock);
+
+	wake_up_all(&table->wait_queue);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_bmap_allocate() - find vacant and set logical block
+ * @lbmap: bitmap array pointer
+ * @bitmap_index: index of bitmap in array
+ * @start_blk: start block for search
+ * @len: requested length
+ * @max_blks: upper bound for search
+ * @extent: pointer on found extent of logical blocks [out]
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - allocated extent hasn't requested length.
+ * %-ENODATA    - unable to allocate.
+ */
+static inline
+int ssdfs_blk2off_table_bmap_allocate(struct ssdfs_bitmap_array *lbmap,
+					int bitmap_index,
+					u16 start_blk, u16 len,
+					u16 max_blks,
+					struct ssdfs_blk2off_range *extent)
+{
+	unsigned long found, end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap || !extent);
+
+	SSDFS_DBG("lbmap %p, bitmap_index %d, "
+		  "start_blk %u, len %u, "
+		  "max_blks %u, extent %p\n",
+		  lbmap, bitmap_index,
+		  start_blk, len, max_blks, extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bitmap_index >= SSDFS_LBMAP_ARRAY_MAX) {
+		SSDFS_ERR("invalid bitmap index %d\n",
+			  bitmap_index);
+		return -EINVAL;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap->array[bitmap_index]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	len = min_t(u16, len, max_blks);
+
+	found = find_next_zero_bit(lbmap->array[bitmap_index],
+				   lbmap->bits_count, start_blk);
+	if (found >= lbmap->bits_count) {
+		if (lbmap->bits_count >= max_blks) {
+			SSDFS_DBG("unable to allocate\n");
+			return -ENODATA;
+		}
+
+		err = ssdfs_blk2off_table_resize_bitmap_array(lbmap,
+							lbmap->bits_count);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc bitmap array: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		found = find_next_zero_bit(lbmap->array[bitmap_index],
+					   lbmap->bits_count, start_blk);
+		if (found >= lbmap->bits_count) {
+			SSDFS_ERR("unable to allocate\n");
+			return -ENODATA;
+		}
+	}
+	BUG_ON(found >= U16_MAX);
+
+	if (found >= max_blks) {
+		SSDFS_DBG("unable to allocate\n");
+		return -ENODATA;
+	}
+
+	end = min_t(unsigned long, found + len, (unsigned long)max_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found %lu, len %u, max_blks %u, end %lu\n",
+		  found, len, max_blks, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	end = find_next_bit(lbmap->array[bitmap_index],
+			    end, found);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found %lu, end %lu\n",
+		  found, end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extent->start_lblk = (u16)found;
+	extent->len = (u16)(end - found);
+
+	if (extent->len < len && lbmap->bits_count < max_blks) {
+		err = ssdfs_blk2off_table_resize_bitmap_array(lbmap, end);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc bitmap array: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		end = find_next_bit(lbmap->array[bitmap_index],
+				    end, found);
+	}
+
+	extent->start_lblk = (u16)found;
+	extent->len = (u16)(end - found);
+
+	bitmap_set(lbmap->array[bitmap_index], extent->start_lblk, extent->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found extent (start %u, len %u)\n",
+		  extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (extent->len < len)
+		return -EAGAIN;
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_allocate_extent() - allocate vacant extent
+ * @table: pointer on table object
+ * @len: requested length
+ * @extent: pointer on found extent [out]
+ *
+ * This method tries to allocate vacant extent.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for this change yet.
+ * %-ENODATA    - bitmap hasn't vacant logical blocks.
+ */
+int ssdfs_blk2off_table_allocate_extent(struct ssdfs_blk2off_table *table,
+					u16 len,
+					struct ssdfs_blk2off_range *extent)
+{
+	void *kaddr;
+	size_t off_pos_size = sizeof(struct ssdfs_offset_position);
+	u16 start_blk = 0;
+	u16 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("table %p, len %u, extent %p, "
+		  "used_logical_blks %u, free_logical_blks %u, "
+		  "last_allocated_blk %u\n",
+		  table, len, extent,
+		  table->used_logical_blks,
+		  table->free_logical_blks,
+		  table->last_allocated_blk);
+#else
+	SSDFS_DBG("table %p, len %u, extent %p, "
+		  "used_logical_blks %u, free_logical_blks %u, "
+		  "last_allocated_blk %u\n",
+		  table, len, extent,
+		  table->used_logical_blks,
+		  table->free_logical_blks,
+		  table->last_allocated_blk);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (atomic_read(&table->state) <= SSDFS_BLK2OFF_OBJECT_CREATED) {
+		SSDFS_DBG("unable to allocate before initialization\n");
+		return -EAGAIN;
+	}
+
+	down_write(&table->translation_lock);
+
+	if (table->free_logical_blks == 0) {
+		if (table->used_logical_blks != table->lblk2off_capacity) {
+			err = -ERANGE;
+			SSDFS_ERR("used_logical_blks %u != capacity %u\n",
+				  table->used_logical_blks,
+				  table->lblk2off_capacity);
+		} else {
+			err = -ENODATA;
+			SSDFS_DBG("bitmap hasn't vacant logical blocks\n");
+		}
+		goto finish_allocation;
+	}
+
+	if (atomic_read(&table->state) == SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		u16 capacity = table->lblk2off_capacity;
+		bool is_vacant;
+
+		start_blk = table->last_allocated_blk;
+		is_vacant = ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+							SSDFS_LBMAP_INIT_INDEX,
+							capacity,
+							start_blk);
+
+		if (is_vacant) {
+			start_blk = table->used_logical_blks;
+			if (start_blk > 0)
+				start_blk--;
+
+			is_vacant =
+			    ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+							SSDFS_LBMAP_INIT_INDEX,
+							capacity,
+							start_blk);
+		}
+
+		if (is_vacant) {
+			err = -EAGAIN;
+			SSDFS_DBG("table is not initialized yet\n");
+			goto finish_allocation;
+		}
+	}
+
+	err = ssdfs_blk2off_table_bmap_allocate(&table->lbmap,
+						SSDFS_LBMAP_STATE_INDEX,
+						start_blk, len,
+						table->lblk2off_capacity,
+						extent);
+	if (err == -EAGAIN) {
+		err = 0;
+		SSDFS_DBG("requested extent doesn't allocated fully\n");
+		goto finish_allocation;
+	} else if (err == -ENODATA)
+		goto try_next_range;
+	else if (unlikely(err)) {
+		SSDFS_ERR("fail to find vacant extent: err %d\n",
+			  err);
+		goto finish_allocation;
+	} else
+		goto save_found_extent;
+
+try_next_range:
+	if (atomic_read(&table->state) < SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT) {
+		err = -EAGAIN;
+		SSDFS_DBG("table is not initialized yet\n");
+		goto finish_allocation;
+	}
+
+	err = ssdfs_blk2off_table_bmap_allocate(&table->lbmap,
+						SSDFS_LBMAP_STATE_INDEX,
+						0, len, start_blk,
+						extent);
+	if (err == -EAGAIN) {
+		err = 0;
+		SSDFS_DBG("requested extent doesn't allocated fully\n");
+		goto finish_allocation;
+	} else if (err == -ENODATA) {
+		SSDFS_DBG("bitmap hasn't vacant logical blocks\n");
+		goto finish_allocation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find vacant extent: err %d\n",
+			  err);
+		goto finish_allocation;
+	}
+
+save_found_extent:
+	for (i = 0; i < extent->len; i++) {
+		u16 blk = extent->start_lblk + i;
+
+		kaddr = ssdfs_dynamic_array_get_locked(&table->lblk2off, blk);
+		if (IS_ERR_OR_NULL(kaddr)) {
+			err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+			SSDFS_ERR("fail to get logical block: "
+				  "blk %u, extent (start %u, len %u), "
+				  "err %d\n",
+				  blk, extent->start_lblk,
+				  extent->len, err);
+			goto finish_allocation;
+		}
+
+		memset(kaddr, 0xFF, off_pos_size);
+
+		err = ssdfs_dynamic_array_release(&table->lblk2off,
+						  blk, kaddr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release: "
+				  "blk %u, extent (start %u, len %u), "
+				  "err %d\n",
+				  blk, extent->start_lblk,
+				  extent->len, err);
+			goto finish_allocation;
+		}
+	}
+
+	BUG_ON(table->used_logical_blks > (U16_MAX - extent->len));
+	BUG_ON((table->used_logical_blks + extent->len) >
+		table->lblk2off_capacity);
+	table->used_logical_blks += extent->len;
+
+	BUG_ON(extent->len > table->free_logical_blks);
+	table->free_logical_blks -= extent->len;
+
+	BUG_ON(extent->len == 0);
+	table->last_allocated_blk = extent->start_lblk + extent->len - 1;
+
+finish_allocation:
+	up_write(&table->translation_lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extent (start %u, len %u) has been allocated\n",
+			  extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_blk2off_table_object(table);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_allocate_block() - allocate vacant logical block
+ * @table: pointer on table object
+ * @logical_blk: pointer on found logical block value [out]
+ *
+ * This method tries to allocate vacant logical block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for this change yet.
+ * %-ENODATA    - bitmap hasn't vacant logical blocks.
+ */
+int ssdfs_blk2off_table_allocate_block(struct ssdfs_blk2off_table *table,
+					u16 *logical_blk)
+{
+	struct ssdfs_blk2off_range extent = {0};
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !logical_blk);
+
+	SSDFS_DBG("table %p, logical_blk %p, "
+		  "used_logical_blks %u, free_logical_blks %u, "
+		  "last_allocated_blk %u\n",
+		  table, logical_blk,
+		  table->used_logical_blks,
+		  table->free_logical_blks,
+		  table->last_allocated_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_blk2off_table_allocate_extent(table, 1, &extent);
+	if (err) {
+		SSDFS_ERR("fail to allocate logical block: err %d\n",
+			  err);
+		SSDFS_ERR("used_logical_blks %u, free_logical_blks %u, "
+			  "last_allocated_blk %u\n",
+			  table->used_logical_blks,
+			  table->free_logical_blks,
+			  table->last_allocated_blk);
+		return err;
+	} else if (extent.start_lblk >= table->lblk2off_capacity ||
+		   extent.len != 1) {
+		SSDFS_ERR("invalid extent (start %u, len %u)\n",
+			  extent.start_lblk, extent.len);
+		return -ERANGE;
+	}
+
+	*logical_blk = extent.start_lblk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical block %u has been allocated\n",
+		  *logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_free_extent() - free extent
+ * @table: pointer on table object
+ * @peb_index: PEB's index
+ * @extent: pointer on extent
+ *
+ * This method tries to free extent of logical blocks.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for this change yet.
+ * %-ENOENT     - logical block isn't allocated yet.
+ */
+int ssdfs_blk2off_table_free_extent(struct ssdfs_blk2off_table *table,
+				    u16 peb_index,
+				    struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	struct ssdfs_phys_offset_descriptor off;
+	u16 last_sequence_id = SSDFS_INVALID_FRAG_ID;
+	struct ssdfs_offset_position pos = {0};
+	void *old_pos;
+	size_t desc_size = sizeof(struct ssdfs_offset_position);
+	struct ssdfs_block_descriptor blk_desc = {0};
+	bool is_vacant;
+	u16 end_lblk;
+	int state;
+	void *kaddr;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("table %p, extent (start %u, len %u)\n",
+		  table, extent->start_lblk, extent->len);
+#else
+	SSDFS_DBG("table %p, extent (start %u, len %u)\n",
+		  table, extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (atomic_read(&table->state) <= SSDFS_BLK2OFF_OBJECT_CREATED) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to free before initialization: "
+			  "extent (start %u, len %u)\n",
+			  extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EAGAIN;
+	}
+
+	memset(&blk_desc, 0xFF, sizeof(struct ssdfs_block_descriptor));
+
+	down_write(&table->translation_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("used_logical_blks %u, free_logical_blks %u, "
+		  "last_allocated_blk %u, lblk2off_capacity %u\n",
+		  table->used_logical_blks,
+		  table->free_logical_blks,
+		  table->last_allocated_blk,
+		  table->lblk2off_capacity);
+
+	BUG_ON(extent->len > table->used_logical_blks);
+	BUG_ON(table->used_logical_blks > table->lblk2off_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((extent->start_lblk + extent->len) > table->lblk2off_capacity) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to free extent (start %u, len %u)\n",
+			  extent->start_lblk, extent->len);
+		goto finish_freeing;
+	}
+
+	state = atomic_read(&table->state);
+	if (state == SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		is_vacant = ssdfs_blk2off_table_extent_vacant(&table->lbmap,
+						      SSDFS_LBMAP_INIT_INDEX,
+						      table->lblk2off_capacity,
+						      extent);
+
+		if (is_vacant) {
+			err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to free before initialization: "
+				  "extent (start %u, len %u)\n",
+				  extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_freeing;
+		}
+	}
+
+	is_vacant = ssdfs_blk2off_table_extent_vacant(&table->lbmap,
+						      SSDFS_LBMAP_STATE_INDEX,
+						      table->lblk2off_capacity,
+						      extent);
+	if (is_vacant) {
+		err = -ENOENT;
+		SSDFS_WARN("extent (start %u, len %u) "
+			   "doesn't allocated yet\n",
+			   extent->start_lblk, extent->len);
+		goto finish_freeing;
+	}
+
+	end_lblk = extent->start_lblk + extent->len;
+	for (i = extent->start_lblk; i < end_lblk; i++) {
+		old_pos = ssdfs_dynamic_array_get_locked(&table->lblk2off, i);
+		if (IS_ERR_OR_NULL(old_pos)) {
+			err = (old_pos == NULL ? -ENOENT : PTR_ERR(old_pos));
+			SSDFS_ERR("fail to get logical block: "
+				  "blk %u, err %d\n",
+				  i, err);
+			goto finish_freeing;
+		}
+
+		if (SSDFS_OFF_POS(old_pos)->id == U16_MAX) {
+			SSDFS_WARN("logical block %d hasn't associated ID\n",
+				   i);
+		}
+
+		err = ssdfs_dynamic_array_release(&table->lblk2off,
+						  i, old_pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release: "
+				  "blk %u, err %d\n",
+				  i, err);
+			goto finish_freeing;
+		}
+
+		err = ssdfs_blk2off_table_assign_id(table, i, peb_index,
+						    &blk_desc,
+						    &last_sequence_id);
+		if (err == -ENOSPC) {
+			err = ssdfs_blk2off_table_add_fragment(table, peb_index,
+							last_sequence_id);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add fragment: "
+					  "peb_index %u, err %d\n",
+					  peb_index, err);
+				goto finish_freeing;
+			}
+
+			err = ssdfs_blk2off_table_assign_id(table, i,
+							    peb_index,
+							    &blk_desc,
+							    &last_sequence_id);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to assign id: "
+					  "peb_index %u, logical_blk %u, "
+					  "err %d\n",
+					  peb_index, i, err);
+				goto finish_freeing;
+			}
+		} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("meet unintialized fragment: "
+				  "peb_index %u, logical_blk %u\n",
+				  peb_index, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_freeing;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to assign id: "
+				  "peb_index %u, logical_blk %u, err %d\n",
+				  peb_index, i, err);
+			goto finish_freeing;
+		}
+
+		err = ssdfs_blk2off_table_get_checked_position(table, (u16)i,
+								&pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get checked offset's position: "
+				  "logical_block %d, err %d\n",
+				  i, err);
+			goto finish_freeing;
+		}
+
+		phys_off_table = &table->peb[peb_index];
+
+		sequence = phys_off_table->sequence;
+		kaddr = ssdfs_sequence_array_get_item(sequence,
+							pos.sequence_id);
+		if (IS_ERR_OR_NULL(kaddr)) {
+			err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+			SSDFS_ERR("fail to get fragment: "
+				  "sequence_id %u, err %d\n",
+				  pos.sequence_id, err);
+			goto finish_freeing;
+		}
+		fragment = (struct ssdfs_phys_offset_table_fragment *)kaddr;
+
+		down_write(&fragment->lock);
+
+		err = ssdfs_blk2off_table_check_fragment_desc(table, fragment,
+								&pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("invalid fragment description: err %d\n",
+				  err);
+			goto finish_fragment_modification;
+		}
+
+		ssdfs_blk2off_table_bmap_clear(&table->lbmap,
+						SSDFS_LBMAP_STATE_INDEX,
+						(u16)i);
+		ssdfs_blk2off_table_bmap_set(&table->lbmap,
+					     SSDFS_LBMAP_MODIFICATION_INDEX,
+					     (u16)i);
+
+		off.page_desc.logical_offset = cpu_to_le32(U32_MAX);
+		off.page_desc.logical_blk = cpu_to_le16((u16)i);
+		off.page_desc.peb_page = cpu_to_le16(U16_MAX);
+		off.blk_state.log_start_page = cpu_to_le16(U16_MAX);
+		off.blk_state.log_area = U8_MAX;
+		off.blk_state.peb_migration_id = U8_MAX;
+		off.blk_state.byte_offset = cpu_to_le32(U32_MAX);
+
+		ssdfs_memcpy(&fragment->phys_offs[pos.offset_index],
+			     0, sizeof(struct ssdfs_phys_offset_descriptor),
+			     &off,
+			     0, sizeof(struct ssdfs_phys_offset_descriptor),
+			     sizeof(struct ssdfs_phys_offset_descriptor));
+
+		ssdfs_table_fragment_set_dirty(table, peb_index,
+						pos.sequence_id);
+
+finish_fragment_modification:
+		up_write(&fragment->lock);
+
+		if (unlikely(err))
+			goto finish_freeing;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("BEFORE: logical_blk %d, pos (cno %llx, id %u, "
+			  "sequence_id %u, offset_index %u)\n",
+			  i, pos.cno, pos.id, pos.sequence_id,
+			  pos.offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		pos.cno = ssdfs_current_cno(table->fsi->sb);
+		pos.id = SSDFS_BLK2OFF_TABLE_INVALID_ID;
+		pos.offset_index = U16_MAX;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("AFTER: logical_blk %d, pos (cno %llx, id %u, "
+			  "sequence_id %u, offset_index %u)\n",
+			  i, pos.cno, pos.id, pos.sequence_id,
+			  pos.offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		old_pos = ssdfs_dynamic_array_get_locked(&table->lblk2off, i);
+		if (IS_ERR_OR_NULL(kaddr)) {
+			err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+			SSDFS_ERR("fail to get logical block: "
+				  "blk %u, err %d\n",
+				  i, err);
+			goto finish_freeing;
+		}
+
+		err = ssdfs_memcpy(old_pos, 0, desc_size,
+				   &pos, 0, desc_size,
+				   desc_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n",
+				  err);
+			goto finish_freeing;
+		}
+
+		err = ssdfs_dynamic_array_release(&table->lblk2off,
+						  i, kaddr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release: "
+				  "blk %u, err %d\n",
+				  i, err);
+			goto finish_freeing;
+		}
+
+		BUG_ON(table->used_logical_blks == 0);
+		table->used_logical_blks--;
+		BUG_ON(table->free_logical_blks == U16_MAX);
+		table->free_logical_blks++;
+	}
+
+finish_freeing:
+	up_write(&table->translation_lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extent (start %u, len %u) has been freed\n",
+			  extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	wake_up_all(&table->wait_queue);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_free_block() - free logical block
+ * @table: pointer on table object
+ * @peb_index: PEB's index
+ * @logical_blk: logical block number
+ *
+ * This method tries to free logical block number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for this change yet.
+ * %-ENOENT     - logical block isn't allocated yet.
+ */
+int ssdfs_blk2off_table_free_block(struct ssdfs_blk2off_table *table,
+				   u16 peb_index,
+				   u16 logical_blk)
+{
+	struct ssdfs_blk2off_range extent = {
+		.start_lblk = logical_blk,
+		.len = 1,
+	};
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+
+	SSDFS_DBG("table %p, logical_blk %u\n",
+		  table, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_blk2off_table_free_extent(table, peb_index, &extent);
+	if (err) {
+		SSDFS_ERR("fail to free logical block %u: err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical block %u has been freed\n",
+		  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_set_block_migration() - set block migration
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @peb_index: PEB index in the segment
+ * @req: request's result with block's content
+ *
+ * This method tries to set migration state for logical block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - table doesn't prepared for this change yet.
+ */
+int ssdfs_blk2off_table_set_block_migration(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    u16 peb_index,
+					    struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_migrating_block *blk = NULL;
+	u32 pages_per_lblk;
+	u32 start_page;
+	u32 count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !req);
+
+	SSDFS_DBG("table %p, logical_blk %u, peb_index %u, req %p\n",
+		  table, logical_blk, peb_index, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = table->fsi;
+	pages_per_lblk = fsi->pagesize >> PAGE_SHIFT;
+
+	if (peb_index >= table->pebs_count) {
+		SSDFS_ERR("fail to set block migration: "
+			  "peb_index %u >= pebs_count %u\n",
+			  peb_index, table->pebs_count);
+		return -EINVAL;
+	}
+
+	if (logical_blk < req->place.start.blk_index ||
+	    logical_blk >= (req->place.start.blk_index + req->place.len)) {
+		SSDFS_ERR("inconsistent request: "
+			  "logical_blk %u, "
+			  "request (start_blk %u, len %u)\n",
+			  logical_blk,
+			  req->place.start.blk_index,
+			  req->place.len);
+		return -EINVAL;
+	}
+
+	count = pagevec_count(&req->result.pvec);
+	if (count % pages_per_lblk) {
+		SSDFS_ERR("inconsistent request: "
+			  "pagevec count %u, "
+			  "pages_per_lblk %u, req->place.len %u\n",
+			  count, pages_per_lblk, req->place.len);
+		return -EINVAL;
+	}
+
+	down_write(&table->translation_lock);
+
+	if (logical_blk > table->last_allocated_blk) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to set block migrating: "
+			  "block %u > last_allocated_block %u\n",
+			  logical_blk,
+			  table->last_allocated_blk);
+		goto finish_set_block_migration;
+	}
+
+	if (atomic_read(&table->state) <= SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+		u16 capacity = table->lblk2off_capacity;
+
+		if (ssdfs_blk2off_table_bmap_vacant(&table->lbmap,
+						    SSDFS_LBMAP_INIT_INDEX,
+						    capacity,
+						    logical_blk)) {
+			err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("table is not initialized yet: "
+				  "logical_blk %u\n",
+				  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_set_block_migration;
+		}
+	}
+
+	blk = ssdfs_get_migrating_block(table, logical_blk, true);
+	if (IS_ERR_OR_NULL(blk)) {
+		err = (blk == NULL ? -ENOENT : PTR_ERR(blk));
+		SSDFS_ERR("fail to get migrating block: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		goto finish_set_block_migration;
+	}
+
+	switch (blk->state) {
+	case SSDFS_LBLOCK_UNKNOWN_STATE:
+		/* expected state */
+		break;
+
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+	case SSDFS_LBLOCK_UNDER_COMMIT:
+		err = -ERANGE;
+		SSDFS_WARN("logical_blk %u is under migration already\n",
+			  logical_blk);
+		goto finish_set_block_migration;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk->state);
+		goto finish_set_block_migration;
+	}
+
+	pagevec_init(&blk->pvec);
+
+	start_page = logical_blk - req->place.start.blk_index;
+	for (i = start_page; i < (start_page + pages_per_lblk); i++) {
+		struct page *page;
+#ifdef CONFIG_SSDFS_DEBUG
+		void *kaddr;
+
+		SSDFS_DBG("start_page %u, logical_blk %u, "
+			  "blk_index %u, i %d, "
+			  "pagevec_count %u\n",
+			  start_page, logical_blk,
+			  req->place.start.blk_index,
+			  i,
+			  pagevec_count(&req->result.pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = ssdfs_blk2off_alloc_page(GFP_KERNEL);
+		if (IS_ERR_OR_NULL(page)) {
+			err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+			SSDFS_ERR("unable to allocate #%d memory page\n", i);
+			ssdfs_blk2off_pagevec_release(&blk->pvec);
+			goto finish_set_block_migration;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+
+		BUG_ON(i >= pagevec_count(&req->result.pvec));
+		BUG_ON(!req->result.pvec.pages[i]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_memcpy_page(page, 0, PAGE_SIZE,
+				  req->result.pvec.pages[i], 0, PAGE_SIZE,
+				  PAGE_SIZE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		kaddr = kmap_local_page(req->result.pvec.pages[i]);
+		SSDFS_DBG("BLOCK STATE DUMP: page_index %d\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		pagevec_add(&blk->pvec, page);
+	}
+
+	blk->state = SSDFS_LBLOCK_UNDER_MIGRATION;
+	blk->peb_index = peb_index;
+
+finish_set_block_migration:
+	up_write(&table->translation_lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u is under migration: "
+			  "(peb_index %u, state %#x)\n",
+			  logical_blk, peb_index, blk->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_get_block_migration() - get block's migration state
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @peb_index: PEB index
+ *
+ * This method tries to get the migration state of logical block.
+ *
+ */
+int ssdfs_blk2off_table_get_block_migration(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    u16 peb_index)
+{
+	struct ssdfs_migrating_block *blk = NULL;
+	int migration_state = SSDFS_LBLOCK_UNKNOWN_STATE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p, logical_blk %u, peb_index %u\n",
+		  table, logical_blk, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	blk = ssdfs_get_migrating_block(table, logical_blk, false);
+	if (IS_ERR_OR_NULL(blk))
+		migration_state = SSDFS_LBLOCK_UNKNOWN_STATE;
+	else
+		migration_state = blk->state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, migration_state %#x\n",
+		  logical_blk, migration_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return migration_state;
+}
+
+/*
+ * ssdfs_blk2off_table_get_block_state() - get state migrating block
+ * @table: pointer on table object
+ * @req: segment request [in|out]
+ *
+ * This method tries to get the state of logical block under migration.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal logic error.
+ * %-EAGAIN     - logical block is not migrating.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+int ssdfs_blk2off_table_get_block_state(struct ssdfs_blk2off_table *table,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 logical_blk;
+	struct ssdfs_migrating_block *blk = NULL;
+	u32 read_bytes;
+	int start_page;
+	u32 data_bytes = 0;
+	int processed_blks;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !req);
+
+	SSDFS_DBG("table %p, req %p\n",
+		  table, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = table->fsi;
+	read_bytes = req->result.processed_blks * fsi->pagesize;
+	start_page = (int)(read_bytes >> PAGE_SHIFT);
+	BUG_ON(start_page >= U16_MAX);
+
+	if (pagevec_count(&req->result.pvec) <= start_page) {
+		SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+			  start_page,
+			  pagevec_count(&req->result.pvec));
+		return -ERANGE;
+	}
+
+	logical_blk = req->place.start.blk_index + req->result.processed_blks;
+
+	down_read(&table->translation_lock);
+
+	if (logical_blk > table->last_allocated_blk) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to get migrating block: "
+			  "block %u > last_allocated_block %u\n",
+			  logical_blk,
+			  table->last_allocated_blk);
+		goto finish_get_block_state;
+	}
+
+	blk = ssdfs_get_migrating_block(table, logical_blk, false);
+	if (IS_ERR_OR_NULL(blk)) {
+		err = -EAGAIN;
+		goto finish_get_block_state;
+	}
+
+	switch (blk->state) {
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+	case SSDFS_LBLOCK_UNDER_COMMIT:
+		/* expected state */
+		break;
+
+	case SSDFS_LBLOCK_UNKNOWN_STATE:
+		err = -EAGAIN;
+		goto finish_get_block_state;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk->state);
+		goto finish_get_block_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, state %#x\n",
+		  logical_blk, blk->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&blk->pvec) == (fsi->pagesize >> PAGE_SHIFT)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, blk pagevec count %u\n",
+			  logical_blk, pagevec_count(&blk->pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		SSDFS_WARN("logical_blk %u, blk pagevec count %u\n",
+			  logical_blk, pagevec_count(&blk->pvec));
+	}
+
+	for (i = 0; i < pagevec_count(&blk->pvec); i++) {
+		int page_index = start_page + i;
+		struct page *page;
+#ifdef CONFIG_SSDFS_DEBUG
+		void *kaddr;
+
+		SSDFS_DBG("index %d, read_bytes %u, "
+			  "start_page %u, page_index %d\n",
+			  i, read_bytes, start_page, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index >= pagevec_count(&req->result.pvec)) {
+			err = -ERANGE;
+			SSDFS_ERR("page_index %d >= count %d\n",
+				  page_index,
+				  pagevec_count(&req->result.pvec));
+			goto finish_get_block_state;
+		}
+
+		page = req->result.pvec.pages[page_index];
+		ssdfs_lock_page(blk->pvec.pages[i]);
+
+		ssdfs_memcpy_page(page, 0, PAGE_SIZE,
+				  blk->pvec.pages[i], 0, PAGE_SIZE,
+				  PAGE_SIZE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		kaddr = kmap_local_page(blk->pvec.pages[i]);
+		SSDFS_DBG("BLOCK STATE DUMP: page_index %d\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_unlock_page(blk->pvec.pages[i]);
+		SetPageUptodate(page);
+
+		data_bytes += PAGE_SIZE;
+	}
+
+finish_get_block_state:
+	up_read(&table->translation_lock);
+
+	if (!err) {
+		processed_blks =
+			(data_bytes + fsi->pagesize - 1) >> fsi->log_pagesize;
+		req->result.processed_blks += processed_blks;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_update_block_state() - update state migrating block
+ * @table: pointer on table object
+ * @req: segment request [in|out]
+ *
+ * This method tries to update the state of logical block under migration.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal logic error.
+ * %-ENOENT     - logical block is not migrating.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+int ssdfs_blk2off_table_update_block_state(struct ssdfs_blk2off_table *table,
+					   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 logical_blk;
+	struct ssdfs_migrating_block *blk = NULL;
+	u32 read_bytes;
+	int start_page;
+	u32 data_bytes = 0;
+	int processed_blks;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !req);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+
+	SSDFS_DBG("table %p, req %p\n",
+		  table, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = table->fsi;
+	read_bytes = req->result.processed_blks * fsi->pagesize;
+	start_page = (int)(read_bytes >> PAGE_SHIFT);
+	BUG_ON(start_page >= U16_MAX);
+
+	if (pagevec_count(&req->result.pvec) <= start_page) {
+		SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+			  start_page,
+			  pagevec_count(&req->result.pvec));
+		return -ERANGE;
+	}
+
+	logical_blk = req->place.start.blk_index + req->result.processed_blks;
+
+	if (logical_blk > table->last_allocated_blk) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to get migrating block: "
+			  "block %u > last_allocated_block %u\n",
+			  logical_blk,
+			  table->last_allocated_blk);
+		goto finish_update_block_state;
+	}
+
+	blk = ssdfs_get_migrating_block(table, logical_blk, false);
+	if (IS_ERR_OR_NULL(blk)) {
+		err = -ENOENT;
+		goto finish_update_block_state;
+	}
+
+	switch (blk->state) {
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk->state);
+		goto finish_update_block_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, state %#x\n",
+		  logical_blk, blk->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&blk->pvec) == (fsi->pagesize >> PAGE_SHIFT)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, blk pagevec count %u\n",
+			  logical_blk, pagevec_count(&blk->pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		SSDFS_WARN("logical_blk %u, blk pagevec count %u\n",
+			  logical_blk, pagevec_count(&blk->pvec));
+	}
+
+	for (i = 0; i < pagevec_count(&blk->pvec); i++) {
+		int page_index = start_page + i;
+		struct page *page;
+#ifdef CONFIG_SSDFS_DEBUG
+		void *kaddr;
+
+		SSDFS_DBG("index %d, read_bytes %u, "
+			  "start_page %u, page_index %d\n",
+			  i, read_bytes, start_page, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index >= pagevec_count(&req->result.pvec)) {
+			err = -ERANGE;
+			SSDFS_ERR("page_index %d >= count %d\n",
+				  page_index,
+				  pagevec_count(&req->result.pvec));
+			goto finish_update_block_state;
+		}
+
+		page = req->result.pvec.pages[page_index];
+		ssdfs_lock_page(blk->pvec.pages[i]);
+
+		ssdfs_memcpy_page(blk->pvec.pages[i], 0, PAGE_SIZE,
+				  page, 0, PAGE_SIZE,
+				  PAGE_SIZE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		kaddr = kmap_local_page(blk->pvec.pages[i]);
+		SSDFS_DBG("BLOCK STATE DUMP: page_index %d\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_unlock_page(blk->pvec.pages[i]);
+
+		data_bytes += PAGE_SIZE;
+	}
+
+finish_update_block_state:
+	if (!err) {
+		processed_blks =
+			(data_bytes + fsi->pagesize - 1) >> fsi->log_pagesize;
+		req->result.processed_blks += processed_blks;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_set_block_commit() - set block commit
+ * @table: pointer on table object
+ * @logical_blk: logical block number
+ * @peb_index: PEB index in the segment
+ *
+ * This method tries to set commit state for logical block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input
+ * %-ERANGE     - internal logic error
+ */
+int ssdfs_blk2off_table_set_block_commit(struct ssdfs_blk2off_table *table,
+					 u16 logical_blk,
+					 u16 peb_index)
+{
+	struct ssdfs_migrating_block *blk = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+
+	SSDFS_DBG("table %p, logical_blk %u, peb_index %u\n",
+		  table, logical_blk, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= table->pebs_count) {
+		SSDFS_ERR("fail to set block commit: "
+			  "peb_index %u >= pebs_count %u\n",
+			  peb_index, table->pebs_count);
+		return -EINVAL;
+	}
+
+	down_write(&table->translation_lock);
+
+	if (logical_blk > table->last_allocated_blk) {
+		err = -EINVAL;
+		SSDFS_ERR("fail to set block commit: "
+			  "block %u > last_allocated_block %u\n",
+			  logical_blk,
+			  table->last_allocated_blk);
+		goto finish_set_block_commit;
+	}
+
+	blk = ssdfs_get_migrating_block(table, logical_blk, false);
+	if (IS_ERR_OR_NULL(blk)) {
+		err = (blk == NULL ? -ENOENT : PTR_ERR(blk));
+		SSDFS_ERR("fail to get migrating block: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		goto finish_set_block_commit;
+	}
+
+	switch (blk->state) {
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+		/* expected state */
+		break;
+
+	case SSDFS_LBLOCK_UNDER_COMMIT:
+		err = -ERANGE;
+		SSDFS_ERR("logical_blk %u is under commit already\n",
+			  logical_blk);
+		goto finish_set_block_commit;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk->state);
+		goto finish_set_block_commit;
+	}
+
+	if (blk->peb_index != peb_index) {
+		err = -ERANGE;
+		SSDFS_ERR("blk->peb_index %u != peb_index %u\n",
+			  blk->peb_index, peb_index);
+		goto finish_set_block_commit;
+	}
+
+	blk->state = SSDFS_LBLOCK_UNDER_COMMIT;
+
+finish_set_block_commit:
+	up_write(&table->translation_lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u is under commit: "
+			  "(peb_index %u, state %#x)\n",
+			  logical_blk, peb_index, blk->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_revert_migration_state() - revert migration state
+ * @table: pointer on table object
+ * @peb_index: PEB index in the segment
+ *
+ * This method tries to revert migration state for logical block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input
+ */
+int ssdfs_blk2off_table_revert_migration_state(struct ssdfs_blk2off_table *tbl,
+						u16 peb_index)
+{
+	struct ssdfs_migrating_block *blk = NULL;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+
+	SSDFS_DBG("table %p, peb_index %u\n",
+		  tbl, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= tbl->pebs_count) {
+		SSDFS_ERR("fail to revert migration state: "
+			  "peb_index %u >= pebs_count %u\n",
+			  peb_index, tbl->pebs_count);
+		return -EINVAL;
+	}
+
+	down_write(&tbl->translation_lock);
+
+	for (i = 0; i <= tbl->last_allocated_blk; i++) {
+		blk = ssdfs_get_migrating_block(tbl, i, false);
+		if (IS_ERR_OR_NULL(blk))
+			continue;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("blk->peb_index %u, peb_index %u\n",
+			  blk->peb_index, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (blk->peb_index != peb_index)
+			continue;
+
+		if (blk->state == SSDFS_LBLOCK_UNDER_COMMIT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("reverting migration state: blk %d\n",
+				  i);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			blk->state = SSDFS_LBLOCK_UNKNOWN_STATE;
+			ssdfs_blk2off_pagevec_release(&blk->pvec);
+
+			ssdfs_blk2off_kfree(blk);
+			blk = NULL;
+
+			err = ssdfs_dynamic_array_set(&tbl->migrating_blks,
+							i, &blk);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to zero pointer: "
+					  "logical_blk %d, err %d\n",
+					  i, err);
+				goto finish_revert_migration_state;
+			}
+		}
+	}
+
+finish_revert_migration_state:
+	up_write(&tbl->translation_lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("migration state was reverted for peb_index %u\n",
+			  peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+static inline
+int ssdfs_show_fragment_details(void *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_phys_offset_table_fragment *fragment;
+
+	fragment = (struct ssdfs_phys_offset_table_fragment *)ptr;
+	if (!fragment) {
+		SSDFS_ERR("empty pointer on fragment\n");
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("fragment: "
+		  "start_id %u, sequence_id %u, "
+		  "id_count %d, state %#x, "
+		  "hdr %p, phys_offs %p, "
+		  "buf_size %zu\n",
+		  fragment->start_id,
+		  fragment->sequence_id,
+		  atomic_read(&fragment->id_count),
+		  atomic_read(&fragment->state),
+		  fragment->hdr,
+		  fragment->phys_offs,
+		  fragment->buf_size);
+
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				fragment->buf,
+				fragment->buf_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+static
+void ssdfs_debug_blk2off_table_object(struct ssdfs_blk2off_table *tbl)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	u32 items_count;
+	int i;
+
+	BUG_ON(!tbl);
+
+	SSDFS_DBG("flags %#x, state %#x, pages_per_peb %u, "
+		  "pages_per_seg %u, type %#x\n",
+		  atomic_read(&tbl->flags),
+		  atomic_read(&tbl->state),
+		  tbl->pages_per_peb,
+		  tbl->pages_per_seg,
+		  tbl->type);
+
+	SSDFS_DBG("init_cno %llu, used_logical_blks %u, "
+		  "free_logical_blks %u, last_allocated_blk %u\n",
+		  tbl->init_cno, tbl->used_logical_blks,
+		  tbl->free_logical_blks, tbl->last_allocated_blk);
+
+	for (i = 0; i < SSDFS_LBMAP_ARRAY_MAX; i++) {
+		unsigned long *bmap = tbl->lbmap.array[i];
+
+		SSDFS_DBG("lbmap: index %d, bmap %p\n", i, bmap);
+		if (bmap) {
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+						bmap,
+						tbl->lbmap.bytes_count);
+		}
+	}
+
+	SSDFS_DBG("lblk2off_capacity %u, capacity %u\n",
+		  tbl->lblk2off_capacity,
+		  ssdfs_dynamic_array_items_count(&tbl->lblk2off));
+
+	items_count = tbl->last_allocated_blk + 1;
+
+	for (i = 0; i < items_count; i++) {
+		void *kaddr;
+
+		kaddr = ssdfs_dynamic_array_get_locked(&tbl->lblk2off, i);
+		if (IS_ERR_OR_NULL(kaddr))
+			continue;
+
+		SSDFS_DBG("lbk2off: index %d, "
+			  "cno %llu, id %u, peb_index %u, "
+			  "sequence_id %u, offset_index %u\n",
+			  i,
+			  SSDFS_OFF_POS(kaddr)->cno,
+			  SSDFS_OFF_POS(kaddr)->id,
+			  SSDFS_OFF_POS(kaddr)->peb_index,
+			  SSDFS_OFF_POS(kaddr)->sequence_id,
+			  SSDFS_OFF_POS(kaddr)->offset_index);
+
+		ssdfs_dynamic_array_release(&tbl->lblk2off, i, kaddr);
+	}
+
+	SSDFS_DBG("pebs_count %u\n", tbl->pebs_count);
+
+	for (i = 0; i < tbl->pebs_count; i++) {
+		struct ssdfs_phys_offset_table_array *peb = &tbl->peb[i];
+		int fragments_count = atomic_read(&peb->fragment_count);
+
+		SSDFS_DBG("peb: index %d, state %#x, "
+			  "fragment_count %d, last_sequence_id %lu\n",
+			  i, atomic_read(&peb->state),
+			  fragments_count,
+			  ssdfs_sequence_array_last_id(peb->sequence));
+
+		ssdfs_sequence_array_apply_for_all(peb->sequence,
+						ssdfs_show_fragment_details);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
-- 
2.34.1

