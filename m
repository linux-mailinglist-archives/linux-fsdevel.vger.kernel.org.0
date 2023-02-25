Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0270A6A2632
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBYBQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBYBQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09813516
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:13 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o12so802569oik.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzKZF+MN7J4TeG2OpcacBeN5i9f5Sx3rJPlWEIJAXfw=;
        b=LHbSScYIOlXYb0eBz4YKvqDC2bUHpJQ+tiEBl4Esjc8+YZsXve4/sDFp0TVBvySKV/
         KR+eUB4Z5DtpkbYOqrpsZtrC4RILMwfIivorFsXsNKAeqkWRZksKsVfAtW/fOg93TqDb
         eYfkT8fWeaUzPotU/3gyq/dYJbbHn32HkVNcrbZ8vpn/zs/hHh81fOB4dz8m70ecqdJW
         ZuOz5pNVu/RdMS0JZ0gQR2MGUcT5UVOoH52ISmvgZ6Xe0dqlMJsiyj0ZOVXsK+tVovS2
         wN/VaRYthyCvy0DjokociXq11wJSGtFMlOokZnjoKko5c2mdYAN6kdDN3dC6hyC4Ti34
         9eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzKZF+MN7J4TeG2OpcacBeN5i9f5Sx3rJPlWEIJAXfw=;
        b=sZseK0MPt8hK7oMnYcvA41k082dnvAkaH6YRR87A2c21GDugFJbRem66DK8oOcPny5
         9RLRo9bkozOVbk8t6JYBJ8ccQJ+lFjIjSOWMFqaKyTXzsO47ClF1wEPfyzrkFKiCQzMT
         jl6HtXFFRjo/uMxEtOaC+POR/c4RqJQOcOW4z/yN34hbFtaGOSXM3mn2v3XB823AU6Pj
         RJj4KVrEbwjhVmKdyqO5UgrIMLnnNBo8gjsJ2xdv69XMeiZZnYfIwolGbitVIPboaEGx
         8EqJ1OZo6qOfEUC+gzY+PxdLFWpqJQEgrpmvcLm32rXCnc0n62XhM75gGuLAf1IAfpCs
         e5WA==
X-Gm-Message-State: AO0yUKW5wyzno4eAyJyVzM3YMuOXhjWytE7uNbPJ2vaXbQEexCgQshBO
        VVvlgPUmaMQY9vYfnNziMouL8PvXJlTG8+zT
X-Google-Smtp-Source: AK7set+ZGCU2vKE6aL4BBoIVqgjt5169zkJ/MjsybP4edO4csHld1R58OAVWbOTZS8jSHn5UCjxW8Q==
X-Received: by 2002:a05:6808:2896:b0:378:53b:f56d with SMTP id eu22-20020a056808289600b00378053bf56dmr4364765oib.37.1677287772594;
        Fri, 24 Feb 2023 17:16:12 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:11 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 18/76] ssdfs: flush offset translation table
Date:   Fri, 24 Feb 2023 17:08:29 -0800
Message-Id: <20230225010927.813929-19-slava@dubeyko.com>
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

Offset translation table can be imagined like a sequence of
fragments. Every fragment contains array of physical
offset descriptors that provides the way to convert logical
block ID into the physical offset in the log. Flush logic
identifies dirty fragments and stores these fragments as
part of log's metadata during log commit operation.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/offset_translation_table.c | 2250 +++++++++++++++++++++++++++
 1 file changed, 2250 insertions(+)

diff --git a/fs/ssdfs/offset_translation_table.c b/fs/ssdfs/offset_translation_table.c
index 169f8106c5be..ccdabc3b7f72 100644
--- a/fs/ssdfs/offset_translation_table.c
+++ b/fs/ssdfs/offset_translation_table.c
@@ -2912,3 +2912,2253 @@ int ssdfs_blk2off_table_partial_init(struct ssdfs_blk2off_table *table,
 
 	return err;
 }
+
+const u16 last_used_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	U16_MAX, 0, 1, 1,
+/* 01 - 0x04 */	2, 2, 2, 2,
+/* 02 - 0x08 */	3, 3, 3, 3,
+/* 03 - 0x0C */	3, 3, 3, 3,
+/* 04 - 0x10 */	4, 4, 4, 4,
+/* 05 - 0x14 */	4, 4, 4, 4,
+/* 06 - 0x18 */	4, 4, 4, 4,
+/* 07 - 0x1C */	4, 4, 4, 4,
+/* 08 - 0x20 */	5, 5, 5, 5,
+/* 09 - 0x24 */	5, 5, 5, 5,
+/* 10 - 0x28 */	5, 5, 5, 5,
+/* 11 - 0x2C */	5, 5, 5, 5,
+/* 12 - 0x30 */	5, 5, 5, 5,
+/* 13 - 0x34 */	5, 5, 5, 5,
+/* 14 - 0x38 */	5, 5, 5, 5,
+/* 15 - 0x3C */	5, 5, 5, 5,
+/* 16 - 0x40 */	6, 6, 6, 6,
+/* 17 - 0x44 */	6, 6, 6, 6,
+/* 18 - 0x48 */	6, 6, 6, 6,
+/* 19 - 0x4C */	6, 6, 6, 6,
+/* 20 - 0x50 */	6, 6, 6, 6,
+/* 21 - 0x54 */	6, 6, 6, 6,
+/* 22 - 0x58 */	6, 6, 6, 6,
+/* 23 - 0x5C */	6, 6, 6, 6,
+/* 24 - 0x60 */	6, 6, 6, 6,
+/* 25 - 0x64 */	6, 6, 6, 6,
+/* 26 - 0x68 */	6, 6, 6, 6,
+/* 27 - 0x6C */	6, 6, 6, 6,
+/* 28 - 0x70 */	6, 6, 6, 6,
+/* 29 - 0x74 */	6, 6, 6, 6,
+/* 30 - 0x78 */	6, 6, 6, 6,
+/* 31 - 0x7C */	6, 6, 6, 6,
+/* 32 - 0x80 */	7, 7, 7, 7,
+/* 33 - 0x84 */	7, 7, 7, 7,
+/* 34 - 0x88 */	7, 7, 7, 7,
+/* 35 - 0x8C */	7, 7, 7, 7,
+/* 36 - 0x90 */	7, 7, 7, 7,
+/* 37 - 0x94 */	7, 7, 7, 7,
+/* 38 - 0x98 */	7, 7, 7, 7,
+/* 39 - 0x9C */	7, 7, 7, 7,
+/* 40 - 0xA0 */	7, 7, 7, 7,
+/* 41 - 0xA4 */	7, 7, 7, 7,
+/* 42 - 0xA8 */	7, 7, 7, 7,
+/* 43 - 0xAC */	7, 7, 7, 7,
+/* 44 - 0xB0 */	7, 7, 7, 7,
+/* 45 - 0xB4 */	7, 7, 7, 7,
+/* 46 - 0xB8 */	7, 7, 7, 7,
+/* 47 - 0xBC */	7, 7, 7, 7,
+/* 48 - 0xC0 */	7, 7, 7, 7,
+/* 49 - 0xC4 */	7, 7, 7, 7,
+/* 50 - 0xC8 */	7, 7, 7, 7,
+/* 51 - 0xCC */	7, 7, 7, 7,
+/* 52 - 0xD0 */	7, 7, 7, 7,
+/* 53 - 0xD4 */	7, 7, 7, 7,
+/* 54 - 0xD8 */	7, 7, 7, 7,
+/* 55 - 0xDC */	7, 7, 7, 7,
+/* 56 - 0xE0 */	7, 7, 7, 7,
+/* 57 - 0xE4 */	7, 7, 7, 7,
+/* 58 - 0xE8 */	7, 7, 7, 7,
+/* 59 - 0xEC */	7, 7, 7, 7,
+/* 60 - 0xF0 */	7, 7, 7, 7,
+/* 61 - 0xF4 */	7, 7, 7, 7,
+/* 62 - 0xF8 */	7, 7, 7, 7,
+/* 63 - 0xFC */	7, 7, 7, 7
+};
+
+/*
+ * ssdfs_blk2off_table_find_last_valid_block() - find last valid block
+ * @table: pointer on translation table object
+ *
+ * RETURN:
+ * [success] - last valid logical block number.
+ * [failure] - U16_MAX.
+ */
+static
+u16 ssdfs_blk2off_table_find_last_valid_block(struct ssdfs_blk2off_table *table)
+{
+	u16 logical_blk;
+	unsigned long *lbmap;
+	unsigned char *byte;
+	int long_count, byte_count;
+	int i, j;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(!rwsem_is_locked(&table->translation_lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_blk = U16_MAX;
+	long_count = BITS_TO_LONGS(table->lbmap.bits_count);
+	lbmap = table->lbmap.array[SSDFS_LBMAP_STATE_INDEX];
+
+	for (i = long_count - 1; i >= 0; i--) {
+		if (lbmap[i] != 0) {
+			byte_count = sizeof(unsigned long);
+			for (j = byte_count - 1; j >= 0; j--) {
+				byte = (unsigned char *)lbmap[i] + j;
+				logical_blk = last_used_blk[*byte];
+				if (logical_blk != U16_MAX)
+					break;
+			}
+			goto calculate_logical_blk;
+		}
+	}
+
+calculate_logical_blk:
+	if (logical_blk != U16_MAX)
+		logical_blk += i * BITS_PER_LONG;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("table %p, logical_blk %u\n",
+		  table, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return logical_blk;
+}
+
+/*
+ * ssdfs_blk2off_table_resize() - resize table
+ * @table: pointer on translation table object
+ * @new_items_count: new table size
+ *
+ * This method tries to grow or to shrink table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - unable to shrink table.
+ * %-ENOMEM     - unable to realloc table.
+ */
+int ssdfs_blk2off_table_resize(struct ssdfs_blk2off_table *table,
+				u16 new_items_count)
+{
+	u16 last_blk;
+	int diff;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+
+	SSDFS_DBG("table %p, lblk2off_capacity %u, new_items_count %u\n",
+		  table, table->lblk2off_capacity, new_items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&table->translation_lock);
+
+	if (new_items_count == table->lblk2off_capacity) {
+		SSDFS_WARN("new_items_count %u == lblk2off_capacity %u\n",
+			   new_items_count, table->lblk2off_capacity);
+		goto finish_table_resize;
+	} else if (new_items_count < table->lblk2off_capacity) {
+		last_blk = ssdfs_blk2off_table_find_last_valid_block(table);
+
+		if (last_blk != U16_MAX && last_blk >= new_items_count) {
+			err = -ERANGE;
+			SSDFS_ERR("unable to shrink bitmap: "
+				  "last_blk %u >= new_items_count %u\n",
+				  last_blk, new_items_count);
+			goto finish_table_resize;
+		}
+	}
+
+	diff = (int)new_items_count - table->lblk2off_capacity;
+
+	table->lblk2off_capacity = new_items_count;
+	table->free_logical_blks += diff;
+
+finish_table_resize:
+	up_write(&table->translation_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_dirtied() - check that PEB's table is dirty
+ * @table: pointer on translation table object
+ * @peb_index: PEB's index
+ */
+bool ssdfs_blk2off_table_dirtied(struct ssdfs_blk2off_table *table,
+				 u16 peb_index)
+{
+	bool is_dirty = false;
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_sequence_array *sequence;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(!table->peb);
+	BUG_ON(peb_index >= table->pebs_count);
+
+	SSDFS_DBG("table %p, peb_index %u\n",
+		  table, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	phys_off_table = &table->peb[peb_index];
+	sequence = phys_off_table->sequence;
+	is_dirty = has_ssdfs_sequence_array_state(sequence,
+				SSDFS_SEQUENCE_ITEM_DIRTY_TAG);
+
+	switch (atomic_read(&phys_off_table->state)) {
+	case SSDFS_BLK2OFF_TABLE_DIRTY:
+	case SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT:
+		if (!is_dirty) {
+			/* table is dirty without dirty fragments */
+			SSDFS_WARN("table is marked as dirty!\n");
+		}
+		break;
+
+	default:
+		if (is_dirty) {
+			/* there are dirty fragments but table is clean */
+			SSDFS_WARN("table is not dirty\n");
+		}
+		break;
+	}
+
+	return is_dirty;
+}
+
+/*
+ * ssdfs_blk2off_table_initialized() - check that PEB's table is initialized
+ * @table: pointer on translation table object
+ * @peb_index: PEB's index
+ */
+bool ssdfs_blk2off_table_initialized(struct ssdfs_blk2off_table *table,
+				     u16 peb_index)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(peb_index >= table->pebs_count);
+
+	SSDFS_DBG("table %p, peb_index %u\n",
+		  table, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(!table->peb);
+
+	state = atomic_read(&table->peb[peb_index].state);
+
+	return state >= SSDFS_BLK2OFF_TABLE_COMPLETE_INIT &&
+		state < SSDFS_BLK2OFF_TABLE_STATE_MAX;
+}
+
+static
+int ssdfs_change_fragment_state(void *item, int old_state, int new_state)
+{
+	struct ssdfs_phys_offset_table_fragment *fragment =
+		(struct ssdfs_phys_offset_table_fragment *)item;
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("old_state %#x, new_state %#x\n",
+		  old_state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!fragment) {
+		SSDFS_ERR("pointer is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sequence_id %u, state %#x\n",
+		  fragment->sequence_id,
+		  atomic_read(&fragment->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_cmpxchg(&fragment->state, old_state, new_state);
+
+	switch (new_state) {
+	case SSDFS_BLK2OFF_FRAG_DIRTY:
+		switch (state) {
+		case SSDFS_BLK2OFF_FRAG_CREATED:
+		case SSDFS_BLK2OFF_FRAG_INITIALIZED:
+		case SSDFS_BLK2OFF_FRAG_DIRTY:
+			/* expected old state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid old_state %#x\n",
+				  old_state);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		if (state != old_state) {
+			SSDFS_ERR("state %#x != old_state %#x\n",
+				  state, old_state);
+			return -ERANGE;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static inline
+int ssdfs_calculate_start_sequence_id(u16 last_sequence_id,
+				      u16 dirty_fragments,
+				      u16 *start_sequence_id)
+{
+	u16 upper_bound;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!start_sequence_id);
+
+	SSDFS_DBG("last_sequence_id %u, dirty_fragments %u\n",
+		  last_sequence_id, dirty_fragments);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_sequence_id = U16_MAX;
+
+	if (last_sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("invalid last_sequence_id %u\n",
+			  last_sequence_id);
+		return -ERANGE;
+	}
+
+	if (dirty_fragments > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("invalid dirty_fragments %u\n",
+			  dirty_fragments);
+		return -ERANGE;
+	}
+
+	upper_bound = last_sequence_id + 1;
+
+	if (upper_bound >= dirty_fragments)
+		*start_sequence_id = upper_bound - dirty_fragments;
+	else {
+		*start_sequence_id = SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD -
+					(dirty_fragments - upper_bound);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_snapshot() - get table's snapshot
+ * @table: pointer on translation table object
+ * @peb_index: PEB's index
+ * @snapshot: pointer on table's snapshot object
+ *
+ * This method tries to get table's snapshot. The @bmap_copy
+ * and @tbl_copy fields of snapshot object are allocated during
+ * getting snapshot by this method. Freeing of allocated
+ * memory SHOULD BE MADE by caller.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - PEB hasn't dirty fragments.
+ */
+int ssdfs_blk2off_table_snapshot(struct ssdfs_blk2off_table *table,
+				 u16 peb_index,
+				 struct ssdfs_blk2off_table_snapshot *snapshot)
+{
+	struct ssdfs_phys_offset_table_array *pot_table;
+	struct ssdfs_sequence_array *sequence;
+	u32 capacity;
+	size_t bmap_bytes, tbl_bytes;
+	u16 last_sequence_id;
+	unsigned long dirty_fragments;
+	int state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !snapshot);
+	BUG_ON(peb_index >= table->pebs_count);
+
+	SSDFS_DBG("table %p, peb_index %u, snapshot %p\n",
+		  table, peb_index, snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(snapshot, 0, sizeof(struct ssdfs_blk2off_table_snapshot));
+	snapshot->bmap_copy = NULL;
+	snapshot->tbl_copy = NULL;
+
+	down_write(&table->translation_lock);
+
+	if (!ssdfs_blk2off_table_dirtied(table, peb_index)) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("table isn't dirty for peb_index %u\n",
+			  peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_snapshoting;
+	}
+
+	capacity = ssdfs_dynamic_array_items_count(&table->lblk2off);
+	if (capacity == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid capacity %u\n", capacity);
+		goto finish_snapshoting;
+	}
+
+	bmap_bytes = ssdfs_blk2off_table_bmap_bytes(table->lbmap.bits_count);
+	snapshot->bmap_copy = ssdfs_blk2off_kvzalloc(bmap_bytes, GFP_KERNEL);
+	if (!snapshot->bmap_copy) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocated bytes %zu\n",
+			  bmap_bytes);
+		goto finish_snapshoting;
+	}
+
+	tbl_bytes = ssdfs_dynamic_array_allocated_bytes(&table->lblk2off);
+	if (tbl_bytes == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid bytes count %zu\n", tbl_bytes);
+		goto finish_snapshoting;
+	}
+
+	snapshot->tbl_copy = ssdfs_blk2off_kvzalloc(tbl_bytes, GFP_KERNEL);
+	if (!snapshot->tbl_copy) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocated bytes %zu\n",
+			  tbl_bytes);
+		goto finish_snapshoting;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("capacity %u, bits_count %u, "
+		  "bmap_bytes %zu, tbl_bytes %zu, "
+		  "last_allocated_blk %u\n",
+		  capacity, table->lbmap.bits_count,
+		  bmap_bytes, tbl_bytes,
+		  table->last_allocated_blk);
+	SSDFS_DBG("init_bmap %lx, state_bmap %lx, bmap_copy %lx\n",
+		  *table->lbmap.array[SSDFS_LBMAP_INIT_INDEX],
+		  *table->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  *snapshot->bmap_copy);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bitmap_or(snapshot->bmap_copy,
+		   snapshot->bmap_copy,
+		   table->lbmap.array[SSDFS_LBMAP_MODIFICATION_INDEX],
+		   table->lbmap.bits_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("modification_bmap %lx, bmap_copy %lx\n",
+		  *table->lbmap.array[SSDFS_LBMAP_MODIFICATION_INDEX],
+		  *snapshot->bmap_copy);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_dynamic_array_copy_content(&table->lblk2off,
+						snapshot->tbl_copy,
+						tbl_bytes);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy position array: "
+			  "err %d\n", err);
+		goto finish_snapshoting;
+	}
+
+	snapshot->capacity = capacity;
+
+	snapshot->used_logical_blks = table->used_logical_blks;
+	snapshot->free_logical_blks = table->free_logical_blks;
+	snapshot->last_allocated_blk = table->last_allocated_blk;
+
+	snapshot->peb_index = peb_index;
+	snapshot->start_sequence_id = SSDFS_INVALID_FRAG_ID;
+
+	sequence = table->peb[peb_index].sequence;
+	err = ssdfs_sequence_array_change_all_states(sequence,
+					SSDFS_SEQUENCE_ITEM_DIRTY_TAG,
+					SSDFS_SEQUENCE_ITEM_UNDER_COMMIT_TAG,
+					ssdfs_change_fragment_state,
+					SSDFS_BLK2OFF_FRAG_DIRTY,
+					SSDFS_BLK2OFF_FRAG_UNDER_COMMIT,
+					&dirty_fragments);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change from dirty to under_commit: "
+			  "err %d\n", err);
+		goto finish_snapshoting;
+	} else if (dirty_fragments >= U16_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid dirty_fragments %lu\n",
+			  dirty_fragments);
+		goto finish_snapshoting;
+	}
+
+#ifdef CONFIG_SSDFS_SAVE_WHOLE_BLK2OFF_TBL_IN_EVERY_LOG
+	snapshot->start_sequence_id = 0;
+	snapshot->dirty_fragments = dirty_fragments;
+	snapshot->fragments_count =
+			atomic_read(&table->peb[peb_index].fragment_count);
+#else
+	snapshot->dirty_fragments = dirty_fragments;
+
+	last_sequence_id =
+		ssdfs_sequence_array_last_id(table->peb[peb_index].sequence);
+	err = ssdfs_calculate_start_sequence_id(last_sequence_id,
+						snapshot->dirty_fragments,
+						&snapshot->start_sequence_id);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate start sequence ID: "
+			  "err %d\n", err);
+		goto finish_snapshoting;
+	}
+
+	snapshot->fragments_count =
+			atomic_read(&table->peb[peb_index].fragment_count);
+#endif /* CONFIG_SSDFS_SAVE_WHOLE_BLK2OFF_TBL_IN_EVERY_LOG */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_sequence_id %u, dirty_fragments %u\n",
+		  snapshot->start_sequence_id,
+		  snapshot->dirty_fragments);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (snapshot->dirty_fragments == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("PEB hasn't dirty fragments\n");
+		goto finish_snapshoting;
+	}
+
+	snapshot->cno = ssdfs_current_cno(table->fsi->sb);
+
+	pot_table = &table->peb[peb_index];
+	state = atomic_cmpxchg(&pot_table->state,
+				SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT,
+				SSDFS_BLK2OFF_TABLE_PARTIAL_INIT);
+	if (state != SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT) {
+		state = atomic_cmpxchg(&pot_table->state,
+					SSDFS_BLK2OFF_TABLE_DIRTY,
+					SSDFS_BLK2OFF_TABLE_COMPLETE_INIT);
+		if (state != SSDFS_BLK2OFF_TABLE_DIRTY) {
+			err = -ERANGE;
+			SSDFS_ERR("table isn't dirty: "
+				  "state %#x\n",
+				  state);
+			goto finish_snapshoting;
+		}
+	}
+
+finish_snapshoting:
+	up_write(&table->translation_lock);
+
+	if (err) {
+		if (snapshot->bmap_copy) {
+			ssdfs_blk2off_kvfree(snapshot->bmap_copy);
+			snapshot->bmap_copy = NULL;
+		}
+
+		if (snapshot->tbl_copy) {
+			ssdfs_blk2off_kvfree(snapshot->tbl_copy);
+			snapshot->tbl_copy = NULL;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_free_snapshot() - free snapshot's resources
+ * @sp: pointer on tabls's snapshot
+ */
+void ssdfs_blk2off_table_free_snapshot(struct ssdfs_blk2off_table_snapshot *sp)
+{
+	if (!sp)
+		return;
+
+	if (sp->bmap_copy) {
+		ssdfs_blk2off_kvfree(sp->bmap_copy);
+		sp->bmap_copy = NULL;
+	}
+
+	if (sp->tbl_copy) {
+		ssdfs_blk2off_kvfree(sp->tbl_copy);
+		sp->tbl_copy = NULL;
+	}
+
+	memset(sp, 0, sizeof(struct ssdfs_blk2off_table_snapshot));
+}
+
+/*
+ * ssdfs_find_changed_area() - find changed area
+ * @sp: table's snapshot
+ * @start: starting bit for search
+ * @found: found range of set bits
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ * %-ENODATA    - nothing was found.
+ */
+static inline
+int ssdfs_find_changed_area(struct ssdfs_blk2off_table_snapshot *sp,
+			    unsigned long start,
+			    struct ssdfs_blk2off_range *found)
+{
+	unsigned long modified_bits;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sp || !found);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	modified_bits = bitmap_weight(sp->bmap_copy, sp->capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("snapshot %p, peb_index %u, start %lu, found %p\n",
+		  sp, sp->peb_index, start, found);
+	SSDFS_DBG("modified_bits %lu, capacity %u\n",
+		  modified_bits, sp->capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start = find_next_bit(sp->bmap_copy, sp->capacity, start);
+	if (start >= sp->capacity) {
+		SSDFS_DBG("nothing found\n");
+		return -ENODATA;
+	}
+
+	found->start_lblk = (u16)start;
+
+	start = find_next_zero_bit(sp->bmap_copy, sp->capacity, start);
+	start = (unsigned long)min_t(u16, (u16)start, sp->capacity);
+
+	found->len = (u16)(start - found->start_lblk);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_start %lu, found_end %lu, len %lu\n",
+		  (unsigned long)found->start_lblk,
+		  start,
+		  (unsigned long)found->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (found->len == 0) {
+		SSDFS_ERR("found empty extent\n");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * struct ssdfs_blk2off_found_range - found range
+ * @range: range descriptor
+ * @start_id: starting offset ID
+ * @state: state of logical blocks in extent (used, free and so on)
+ */
+struct ssdfs_blk2off_found_range {
+	struct ssdfs_blk2off_range range;
+	u16 start_id;
+	u8 state;
+};
+
+/*
+ * ssdfs_translation_extent_init() - init translation extent
+ * @found: range of changed logical blocks
+ * @sequence_id: sequence ID of extent
+ * @extent: pointer on initialized extent [out]
+ */
+static inline
+void ssdfs_translation_extent_init(struct ssdfs_blk2off_found_range *found,
+				   u8 sequence_id,
+				   struct ssdfs_translation_extent *extent)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!found || !extent);
+	BUG_ON(found->state <= SSDFS_LOGICAL_BLK_UNKNOWN_STATE ||
+		found->state >= SSDFS_LOGICAL_BLK_STATE_MAX);
+
+	SSDFS_DBG("start %u, len %u, id %u, sequence_id %u, state %#x\n",
+		  found->range.start_lblk, found->range.len,
+		  found->start_id, sequence_id, found->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extent->logical_blk = cpu_to_le16(found->range.start_lblk);
+	extent->offset_id = cpu_to_le16(found->start_id);
+	extent->len = cpu_to_le16(found->range.len);
+	extent->sequence_id = sequence_id;
+	extent->state = found->state;
+}
+
+/*
+ * can_translation_extent_be_merged() - check opportunity to merge extents
+ * @extent: extent for checking
+ * @found: range of changed logical blocks
+ */
+static inline
+bool can_translation_extent_be_merged(struct ssdfs_translation_extent *extent,
+				      struct ssdfs_blk2off_found_range *found)
+{
+	u16 logical_blk;
+	u16 offset_id;
+	u16 len;
+	u16 found_blk;
+	u16 found_len;
+	u16 found_id;
+	u8 found_state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !found);
+	BUG_ON(found->start_id == SSDFS_BLK2OFF_TABLE_INVALID_ID);
+	BUG_ON(found->state <= SSDFS_LOGICAL_BLK_UNKNOWN_STATE ||
+		found->state >= SSDFS_LOGICAL_BLK_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_blk = le16_to_cpu(extent->logical_blk);
+	offset_id = le16_to_cpu(extent->offset_id);
+	len = le16_to_cpu(extent->len);
+
+	found_blk = found->range.start_lblk;
+	found_len = found->range.len;
+	found_id = found->start_id;
+	found_state = found->state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("EXTENT: logical_blk %u, offset_id %u, len %u, "
+		  "sequence_id %u, state %#x; "
+		  "FOUND: logical_blk %u, start_id %u, "
+		  "len %u, state %#x\n",
+		  logical_blk, offset_id, len,
+		  extent->sequence_id, extent->state,
+		  found->range.start_lblk, found->start_id,
+		  found->range.len, found->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (extent->state != found->state)
+		return false;
+
+	if (found_id == offset_id) {
+		SSDFS_ERR("start_id %u == offset_id %u\n",
+			  found_id, offset_id);
+		return false;
+	} else if (found_id > offset_id &&
+			(offset_id + len) == found_id) {
+		if ((logical_blk + len) == found_blk)
+			return true;
+		else if ((found_blk + found_len) == logical_blk)
+			return true;
+	} else if (found_id < offset_id &&
+			(found_id + found_len) == offset_id) {
+		if ((logical_blk + len) == found_blk)
+			return true;
+		else if ((found_blk + found_len) == logical_blk)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * ssdfs_merge_translation_extent() - merge translation extents
+ * @extent: extent for checking
+ * @found: range of changed logical blocks
+ */
+static inline
+int ssdfs_merge_translation_extent(struct ssdfs_translation_extent *extent,
+				   struct ssdfs_blk2off_found_range *found)
+{
+	u16 logical_blk;
+	u16 offset_id;
+	u16 len;
+	u16 found_blk;
+	u16 found_len;
+	u16 found_id;
+	u8 found_state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !found);
+	BUG_ON(found->start_id == SSDFS_BLK2OFF_TABLE_INVALID_ID);
+	BUG_ON(found->state <= SSDFS_LOGICAL_BLK_UNKNOWN_STATE ||
+		found->state >= SSDFS_LOGICAL_BLK_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_blk = le16_to_cpu(extent->logical_blk);
+	offset_id = le16_to_cpu(extent->offset_id);
+	len = le16_to_cpu(extent->len);
+
+	found_blk = found->range.start_lblk;
+	found_len = found->range.len;
+	found_id = found->start_id;
+	found_state = found->state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("EXTENT: logical_blk %u, offset_id %u, len %u, "
+		  "sequence_id %u, state %#x; "
+		  "FOUND: logical_blk %u, start_id %u, "
+		  "len %u, state %#x\n",
+		  logical_blk, offset_id, len,
+		  extent->sequence_id, extent->state,
+		  found_blk, found_id, found_len,
+		  found_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (extent->state != found_state) {
+		SSDFS_ERR("extent->state %#x != state %#x\n",
+			  extent->state, found_state);
+		return -EINVAL;
+	}
+
+	if (found_id == offset_id) {
+		SSDFS_ERR("start_id %u == offset_id %u\n",
+			  found_id, offset_id);
+		return -ERANGE;
+	}
+
+	if (found_id > offset_id &&
+			(offset_id + len) == found_id) {
+		if ((logical_blk + len) == found_blk) {
+			extent->len = cpu_to_le16(len + found_len);
+		} else if ((found_blk + found_len) == logical_blk) {
+			extent->logical_blk = cpu_to_le16(found_blk);
+			extent->len = cpu_to_le16(len + found_len);
+		}
+	} else if (found_id < offset_id &&
+			(found_id + found_len) == offset_id) {
+		if ((logical_blk + len) == found_blk) {
+			extent->offset_id = cpu_to_le16(found_id);
+			extent->len = cpu_to_le16(len + found_len);
+		} else if ((found_blk + found_len) == logical_blk) {
+			extent->logical_blk = cpu_to_le16(found_blk);
+			extent->offset_id = cpu_to_le16(found_id);
+			extent->len = cpu_to_le16(len + found_len);
+		}
+	} else {
+		SSDFS_ERR("fail to merge the translation extent\n");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_insert_translation_extent() - insert translation extent into the queue
+ * @found: range of changed logical blocks
+ * @array: extents array [in|out]
+ * @capacity: capacity of extents array
+ * @extent_count: pointer on extents count value [out]
+ */
+static inline
+int ssdfs_insert_translation_extent(struct ssdfs_blk2off_found_range *found,
+				    struct ssdfs_translation_extent *array,
+				    u16 capacity, u16 *extent_count)
+{
+	struct ssdfs_translation_extent *extent;
+	size_t extent_size = sizeof(struct ssdfs_translation_extent);
+	size_t array_bytes = extent_size * capacity;
+	u16 logical_blk;
+	u16 offset_id;
+	u16 len;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!found || !extent_count);
+	BUG_ON(found->state <= SSDFS_LOGICAL_BLK_UNKNOWN_STATE ||
+		found->state >= SSDFS_LOGICAL_BLK_STATE_MAX);
+
+	SSDFS_DBG("start_id %u, state %#x, extent_count %u\n",
+		  found->start_id, found->state, *extent_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(*extent_count >= capacity);
+
+	if (found->start_id == SSDFS_BLK2OFF_TABLE_INVALID_ID) {
+		extent = &array[*extent_count];
+		ssdfs_translation_extent_init(found, *extent_count, extent);
+		(*extent_count)++;
+
+		return 0;
+	}
+
+	for (i = 0; i < *extent_count; i++) {
+		extent = &array[i];
+
+		logical_blk = le16_to_cpu(extent->logical_blk);
+		offset_id = le16_to_cpu(extent->offset_id);
+		len = le16_to_cpu(extent->len);
+
+		if (offset_id >= SSDFS_BLK2OFF_TABLE_INVALID_ID)
+			continue;
+
+		if (found->start_id == offset_id) {
+			SSDFS_ERR("start_id %u == offset_id %u\n",
+				  found->start_id, offset_id);
+			return -ERANGE;
+		} else if (found->start_id > offset_id &&
+			   can_translation_extent_be_merged(extent, found)) {
+			err = ssdfs_merge_translation_extent(extent, found);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to merge extent: "
+					  "err %d\n", err);
+				return err;
+			} else
+				return 0;
+		} else if (found->start_id < offset_id) {
+			if (can_translation_extent_be_merged(extent, found)) {
+				err = ssdfs_merge_translation_extent(extent,
+								     found);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to merge extent: "
+						  "err %d\n", err);
+					return err;
+				} else
+					return 0;
+			} else {
+				i++;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to merge: index %d\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+				break;
+			}
+		}
+	}
+
+	if (i < *extent_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		if (((i + 1) + (*extent_count - i)) > capacity) {
+			SSDFS_WARN("value is out capacity\n");
+			return -ERANGE;
+		}
+
+		SSDFS_DBG("extent_count %u, index %d, extent_size %zu\n",
+			  *extent_count, i, extent_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_memmove(array, (i + 1) * extent_size, array_bytes,
+				    array, i * extent_size, array_bytes,
+				    (*extent_count - i) * extent_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: err %d\n", err);
+			return err;
+		}
+
+		for (j = i + 1; j <= *extent_count; j++) {
+			extent = &array[j];
+			extent->sequence_id = j;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("extent_count %u, index %d, extent_size %zu\n",
+		  *extent_count, i, extent_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extent = &array[i];
+	ssdfs_translation_extent_init(found, i, extent);
+
+	(*extent_count)++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	for (i = 0; i < *extent_count; i++) {
+		extent = &array[i];
+
+		SSDFS_DBG("index %d, logical_blk %u, offset_id %u, "
+			  "len %u, sequence_id %u, state %u\n",
+			  i,
+			  le16_to_cpu(extent->logical_blk),
+			  le16_to_cpu(extent->offset_id),
+			  le16_to_cpu(extent->len),
+			  extent->sequence_id,
+			  extent->state);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+static inline
+bool is_found_logical_block_free(struct ssdfs_blk2off_table_snapshot *sp,
+				 u16 blk)
+{
+	struct ssdfs_offset_position *pos;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sp);
+
+	SSDFS_DBG("blk %u\n", blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pos = &sp->tbl_copy[blk];
+
+	return pos->id == SSDFS_BLK2OFF_TABLE_INVALID_ID &&
+		pos->offset_index >= U16_MAX;
+}
+
+static inline
+bool is_found_extent_ended(struct ssdfs_blk2off_table_snapshot *sp,
+			   u16 blk,
+			   struct ssdfs_blk2off_found_range *found)
+{
+	struct ssdfs_offset_position *pos;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sp || !found);
+
+	SSDFS_DBG("blk %u\n", blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pos = &sp->tbl_copy[blk];
+
+	if (pos->peb_index != sp->peb_index) {
+		/* changes of another PEB */
+		return true;
+	} else if (pos->id != SSDFS_BLK2OFF_TABLE_INVALID_ID) {
+		if (found->start_id == SSDFS_BLK2OFF_TABLE_INVALID_ID)
+			found->start_id = pos->id;
+		else if ((found->start_id + found->range.len) != pos->id)
+			return true;
+	} else if (pos->id == SSDFS_BLK2OFF_TABLE_INVALID_ID &&
+		   found->state != SSDFS_LOGICAL_BLK_FREE) {
+		if (found->range.start_lblk != U16_MAX) {
+			/* state is changed */
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * ssdfs_blk2off_table_extract_extents() - extract changed extents
+ * @sp: table's snapshot
+ * @array: extents array [in|out]
+ * @capacity: capacity of extents array
+ * @extent_count: pointer on extents count value [out]
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ */
+int ssdfs_blk2off_table_extract_extents(struct ssdfs_blk2off_table_snapshot *sp,
+					struct ssdfs_translation_extent *array,
+					u16 capacity, u16 *extent_count)
+{
+	unsigned long start = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sp || !array || !extent_count);
+	BUG_ON(capacity == 0);
+
+	SSDFS_DBG("snapshot %p, peb_index %u, extents %p, "
+		  "capacity %u, extent_count %p\n",
+		  sp, sp->peb_index, array,
+		  capacity, extent_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*extent_count = 0;
+
+	do {
+		struct ssdfs_blk2off_range changed_area = {0};
+		struct ssdfs_blk2off_found_range found = {
+			.range.start_lblk = U16_MAX,
+			.range.len = 0,
+			.start_id = SSDFS_BLK2OFF_TABLE_INVALID_ID,
+			.state = SSDFS_LOGICAL_BLK_UNKNOWN_STATE,
+		};
+		struct ssdfs_offset_position *pos;
+
+		err = ssdfs_find_changed_area(sp, start, &changed_area);
+		if (err == -ENODATA) {
+			err = 0;
+			SSDFS_DBG("nothing found\n");
+			goto finish_extract_extents;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find changed area: err %d\n",
+				  err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("changed area: start %u, len %u\n",
+			  changed_area.start_lblk, changed_area.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		for (i = 0; i < changed_area.len; i++) {
+			u16 blk = changed_area.start_lblk + i;
+			bool is_extent_ended = false;
+
+			pos = &sp->tbl_copy[blk];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cno %llx, id %u, peb_index %u, "
+				  "sequence_id %u, offset_index %u\n",
+				  pos->cno, pos->id, pos->peb_index,
+				  pos->sequence_id, pos->offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (pos->peb_index == U16_MAX) {
+				SSDFS_WARN("invalid peb_index: "
+					   "logical_blk %u\n",
+					   blk);
+				return -ERANGE;
+			}
+
+			if (is_found_logical_block_free(sp, blk)) {
+				/* free block */
+
+				switch (found.state) {
+				case SSDFS_LOGICAL_BLK_UNKNOWN_STATE:
+					found.range.start_lblk = blk;
+					found.range.len = 1;
+					found.state = SSDFS_LOGICAL_BLK_FREE;
+					break;
+
+				case SSDFS_LOGICAL_BLK_FREE:
+					found.range.len++;
+					break;
+
+				case SSDFS_LOGICAL_BLK_USED:
+					is_extent_ended = true;
+					break;
+
+				default:
+					SSDFS_ERR("unexpected blk state %#x\n",
+						  found.state);
+					return -ERANGE;
+				}
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("free block: start_lblk %u, "
+					  "len %u, state %#x, "
+					  "is_extent_ended %#x\n",
+					  found.range.start_lblk,
+					  found.range.len,
+					  found.state,
+					  is_extent_ended);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				/* used block */
+
+				switch (found.state) {
+				case SSDFS_LOGICAL_BLK_UNKNOWN_STATE:
+					found.range.start_lblk = blk;
+					found.range.len = 1;
+					found.start_id = pos->id;
+					found.state = SSDFS_LOGICAL_BLK_USED;
+					break;
+
+				case SSDFS_LOGICAL_BLK_USED:
+					is_extent_ended =
+						is_found_extent_ended(sp, blk,
+									&found);
+					if (!is_extent_ended)
+						found.range.len++;
+					break;
+
+				case SSDFS_LOGICAL_BLK_FREE:
+					is_extent_ended = true;
+					break;
+
+				default:
+					SSDFS_ERR("unexpected blk state %#x\n",
+						  found.state);
+					return -ERANGE;
+				}
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("used block: start_lblk %u, "
+					  "len %u, state %#x, "
+					  "is_extent_ended %#x\n",
+					  found.range.start_lblk,
+					  found.range.len,
+					  found.state,
+					  is_extent_ended);
+#endif /* CONFIG_SSDFS_DEBUG */
+			}
+
+			if (is_extent_ended) {
+				if (found.range.start_lblk == U16_MAX) {
+					SSDFS_ERR("invalid start_lblk %u\n",
+						  found.range.start_lblk);
+					return -ERANGE;
+				}
+
+				err = ssdfs_insert_translation_extent(&found,
+								array,
+								capacity,
+								extent_count);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to insert extent: "
+						  "start_id %u, state %#x, "
+						  "err %d\n",
+						  found.start_id, found.state,
+						  err);
+					return err;
+				}
+
+				pos = &sp->tbl_copy[blk];
+
+				if (pos->id == SSDFS_BLK2OFF_TABLE_INVALID_ID)
+					found.state = SSDFS_LOGICAL_BLK_FREE;
+				else
+					found.state = SSDFS_LOGICAL_BLK_USED;
+
+				found.range.start_lblk = blk;
+				found.range.len = 1;
+				found.start_id = pos->id;
+			}
+		}
+
+		if (found.range.start_lblk != U16_MAX) {
+			err = ssdfs_insert_translation_extent(&found,
+								array,
+								capacity,
+								extent_count);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to insert extent: "
+					  "start_id %u, state %#x, "
+					  "err %d\n",
+					  found.start_id, found.state, err);
+				return err;
+			}
+
+			start = found.range.start_lblk + found.range.len;
+
+			found.range.start_lblk = U16_MAX;
+			found.range.len = 0;
+			found.state = SSDFS_LOGICAL_BLK_UNKNOWN_STATE;
+		} else
+			start = changed_area.start_lblk + changed_area.len;
+	} while (start < sp->capacity);
+
+finish_extract_extents:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("extents_count %u\n", *extent_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*extent_count == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid state of change bitmap\n");
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_prepare_for_commit() - prepare fragment for commit
+ * @table: pointer on table object
+ * @peb_index: PEB's index
+ * @sequence_id: fragment's sequence ID
+ * @offset_table_off: pointer on current offset to offset table header [in|out]
+ * @sp: pointer on snapshot
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal logic error.
+ */
+int
+ssdfs_blk2off_table_prepare_for_commit(struct ssdfs_blk2off_table *table,
+				       u16 peb_index, u16 sequence_id,
+				       u32 *offset_table_off,
+				       struct ssdfs_blk2off_table_snapshot *sp)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_phys_offset_table_array *pot_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	void *ptr;
+	u16 id_count;
+	u32 byte_size;
+	u16 flags = 0;
+	int last_sequence_id;
+	bool has_next_fragment = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !sp || !table->fsi || !offset_table_off);
+	BUG_ON(peb_index >= table->pebs_count);
+	BUG_ON(peb_index != sp->peb_index);
+
+	SSDFS_DBG("table %p, peb_index %u, sequence_id %u, "
+		  "offset_table_off %p, sp %p\n",
+		  table, peb_index, sequence_id,
+		  offset_table_off, sp);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = table->fsi;
+
+	down_read(&table->translation_lock);
+
+	pot_table = &table->peb[peb_index];
+
+	sequence = pot_table->sequence;
+	ptr = ssdfs_sequence_array_get_item(sequence, sequence_id);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = (ptr == NULL ? -ENOENT : PTR_ERR(ptr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		goto finish_prepare_for_commit;
+	}
+	fragment = (struct ssdfs_phys_offset_table_fragment *)ptr;
+
+	if (atomic_read(&fragment->state) != SSDFS_BLK2OFF_FRAG_UNDER_COMMIT) {
+		err = -ERANGE;
+		SSDFS_ERR("fragment isn't under commit: "
+			  "state %#x\n",
+			  atomic_read(&fragment->state));
+		goto finish_prepare_for_commit;
+	}
+
+	down_write(&fragment->lock);
+
+	fragment->hdr->magic = cpu_to_le32(SSDFS_PHYS_OFF_TABLE_MAGIC);
+	fragment->hdr->checksum = 0;
+
+	fragment->hdr->start_id = cpu_to_le16(fragment->start_id);
+	id_count = (u16)atomic_read(&fragment->id_count);
+	fragment->hdr->id_count = cpu_to_le16(id_count);
+	byte_size = sizeof(struct ssdfs_phys_offset_table_header);
+	byte_size += (u32)id_count * sizeof(struct ssdfs_phys_offset_descriptor);
+	fragment->hdr->byte_size = cpu_to_le32(byte_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hdr_size %zu, id_count %u, "
+		  "desc_size %zu, byte_size %u\n",
+		  sizeof(struct ssdfs_phys_offset_table_header),
+		  id_count,
+		  sizeof(struct ssdfs_phys_offset_descriptor),
+		  byte_size);
+	SSDFS_DBG("fragment: start_id %u, id_count %u\n",
+		  le16_to_cpu(fragment->hdr->start_id),
+		  le16_to_cpu(fragment->hdr->id_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment->hdr->peb_index = cpu_to_le16(peb_index);
+	fragment->hdr->sequence_id = cpu_to_le16(fragment->sequence_id);
+	fragment->hdr->type = cpu_to_le16(table->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sequence_id %u, start_sequence_id %u, "
+		  "dirty_fragments %u, fragment->sequence_id %u\n",
+		  sequence_id, sp->start_sequence_id,
+		  sp->dirty_fragments,
+		  fragment->sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	last_sequence_id = ssdfs_sequence_array_last_id(pot_table->sequence);
+	has_next_fragment = sequence_id != last_sequence_id;
+
+	flags |= SSDFS_OFF_TABLE_HAS_CSUM;
+	if (has_next_fragment)
+		flags |= SSDFS_OFF_TABLE_HAS_NEXT_FRAGMENT;
+
+	switch (fsi->metadata_options.blk2off_tbl.compression) {
+	case SSDFS_BLK2OFF_TBL_ZLIB_COMPR_TYPE:
+	case SSDFS_BLK2OFF_TBL_LZO_COMPR_TYPE:
+		flags |= SSDFS_BLK_DESC_TBL_COMPRESSED;
+		break;
+	default:
+		/* do nothing */
+		break;
+	}
+
+	fragment->hdr->flags = cpu_to_le16(flags);
+
+	fragment->hdr->used_logical_blks = cpu_to_le16(sp->used_logical_blks);
+	fragment->hdr->free_logical_blks = cpu_to_le16(sp->free_logical_blks);
+	fragment->hdr->last_allocated_blk = cpu_to_le16(sp->last_allocated_blk);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(byte_size >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*offset_table_off += byte_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("offset_table_off %u\n", *offset_table_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (has_next_fragment) {
+		fragment->hdr->next_fragment_off =
+				cpu_to_le16((u16)byte_size);
+	} else {
+		fragment->hdr->next_fragment_off =
+				cpu_to_le16(U16_MAX);
+	}
+
+	fragment->hdr->checksum = ssdfs_crc32_le(fragment->hdr, byte_size);
+
+	up_write(&fragment->lock);
+
+finish_prepare_for_commit:
+	up_read(&table->translation_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_forget_snapshot() - undirty PEB's table
+ * @table: pointer on table object
+ * @sp: pointer on snapshot
+ * @array: extents array
+ * @extent_count: count of extents in array
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal logic error.
+ */
+int
+ssdfs_blk2off_table_forget_snapshot(struct ssdfs_blk2off_table *table,
+				    struct ssdfs_blk2off_table_snapshot *sp,
+				    struct ssdfs_translation_extent *array,
+				    u16 extent_count)
+{
+	struct ssdfs_phys_offset_table_array *pot_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_offset_position *pos;
+	u16 last_sequence_id;
+	unsigned long commited_fragments = 0;
+	int i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !sp || !array);
+	BUG_ON(sp->peb_index >= table->pebs_count);
+	BUG_ON(extent_count == 0);
+
+	SSDFS_DBG("table %p, peb_index %u, sp %p, "
+		  "extents %p, extents_count %u\n",
+		  table, sp->peb_index, sp,
+		  array, extent_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&table->translation_lock);
+
+	pot_table = &table->peb[sp->peb_index];
+	last_sequence_id = ssdfs_sequence_array_last_id(pot_table->sequence);
+
+	if (sp->dirty_fragments == 0) {
+		err = -EINVAL;
+		SSDFS_ERR("dirty_fragments == 0\n");
+		goto finish_forget_snapshot;
+	}
+
+	sequence = table->peb[sp->peb_index].sequence;
+	err = ssdfs_sequence_array_change_all_states(sequence,
+					SSDFS_SEQUENCE_ITEM_UNDER_COMMIT_TAG,
+					SSDFS_SEQUENCE_ITEM_COMMITED_TAG,
+					ssdfs_change_fragment_state,
+					SSDFS_BLK2OFF_FRAG_UNDER_COMMIT,
+					SSDFS_BLK2OFF_FRAG_COMMITED,
+					&commited_fragments);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set fragments as commited: "
+			  "err %d\n", err);
+		goto finish_forget_snapshot;
+	}
+
+	if (sp->dirty_fragments != commited_fragments) {
+		err = -ERANGE;
+		SSDFS_ERR("dirty_fragments %u != commited_fragments %lu\n",
+			  sp->dirty_fragments, commited_fragments);
+		goto finish_forget_snapshot;
+	}
+
+	for (i = 0; i < extent_count; i++) {
+		u16 start_blk = le16_to_cpu(array[i].logical_blk);
+		u16 len = le16_to_cpu(array[i].len);
+
+		for (j = 0; j < len; j++) {
+			u16 blk = start_blk + j;
+			u64 cno1, cno2;
+			void *kaddr;
+
+			kaddr = ssdfs_dynamic_array_get_locked(&table->lblk2off,
+								blk);
+			if (IS_ERR_OR_NULL(kaddr)) {
+				err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+				SSDFS_ERR("fail to get logical block: "
+					  "blk %u, err %d\n",
+					  blk, err);
+				goto finish_forget_snapshot;
+			}
+
+			pos = SSDFS_OFF_POS(kaddr);
+			cno1 = pos->cno;
+			cno2 = sp->tbl_copy[blk].cno;
+
+			err = ssdfs_dynamic_array_release(&table->lblk2off,
+							  blk, pos);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to release: "
+					  "blk %u, err %d\n",
+					  blk, err);
+				goto finish_forget_snapshot;
+			}
+
+			if (cno1 < cno2) {
+				SSDFS_WARN("cno1 %llu < cno2 %llu\n",
+					   cno1, cno2);
+			} else if (cno1 > cno2)
+				continue;
+
+			/*
+			 * Don't clear information about free blocks
+			 * in the modification bitmap. Otherwise,
+			 * this information will be lost during
+			 * the PEBs migration.
+			 */
+			if (array[i].state != SSDFS_LOGICAL_BLK_FREE) {
+				err =
+				   ssdfs_blk2off_table_bmap_clear(&table->lbmap,
+					   SSDFS_LBMAP_MODIFICATION_INDEX, blk);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to clear bitmap: "
+						  "blk %u, err %d\n",
+						  blk, err);
+					goto finish_forget_snapshot;
+				}
+			}
+
+			err = ssdfs_blk2off_table_bmap_set(&table->lbmap,
+						SSDFS_LBMAP_INIT_INDEX, blk);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to set bitmap: "
+					  "blk %u, err %d\n",
+					  blk, err);
+				goto finish_forget_snapshot;
+			}
+		}
+	}
+
+finish_forget_snapshot:
+	up_write(&table->translation_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_store_offsets_table_header() - store offsets table header
+ * @pebi: pointer on PEB object
+ * @hdr: table header
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store table header into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to find memory page.
+ */
+int ssdfs_peb_store_offsets_table_header(struct ssdfs_peb_info *pebi,
+					 struct ssdfs_blk2off_table_header *hdr,
+					 pgoff_t *cur_page,
+					 u32 *write_offset)
+{
+	size_t hdr_sz = sizeof(struct ssdfs_blk2off_table_header);
+	struct page *page;
+	u32 page_off, cur_offset;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!hdr || !cur_page || !write_offset);
+
+	SSDFS_DBG("peb %llu, current_log.start_page %u, "
+		  "hdr %p, cur_page %lu, write_offset %u\n",
+		  pebi->peb_id,
+		  pebi->current_log.start_page,
+		  hdr, *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_off = *write_offset % PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON((PAGE_SIZE - page_off) < hdr_sz);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, *cur_page);
+	if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get cache page: index %lu\n",
+			  *cur_page);
+		return -ENOMEM;
+	}
+
+	err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+				   hdr, 0, hdr_sz,
+				   hdr_sz);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto finish_copy;
+	}
+
+	ssdfs_set_page_private(page, 0);
+	SetPageUptodate(page);
+
+	err = ssdfs_page_array_set_page_dirty(&pebi->cache, *cur_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set page %lu as dirty: err %d\n",
+			  *cur_page, err);
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
+	if (unlikely(err))
+		return err;
+
+	*write_offset += hdr_sz;
+
+	cur_offset = (*cur_page << PAGE_SHIFT) + page_off + hdr_sz;
+	*cur_page = cur_offset >> PAGE_SHIFT;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_offsets_table_extents() - store translation extents
+ * @pebi: pointer on PEB object
+ * @array: translation extents array
+ * @extent_count: count of extents in the array
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store translation extents into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to find memory page.
+ */
+int
+ssdfs_peb_store_offsets_table_extents(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_translation_extent *array,
+				      u16 extent_count,
+				      pgoff_t *cur_page,
+				      u32 *write_offset)
+{
+	struct page *page;
+	size_t extent_size = sizeof(struct ssdfs_translation_extent);
+	size_t array_size = extent_size * extent_count;
+	u32 rest_bytes, written_bytes = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!array || !cur_page || !write_offset);
+	BUG_ON(extent_count == 0 || extent_count == U16_MAX);
+
+	SSDFS_DBG("peb %llu, current_log.start_page %u, "
+		  "array %p, extent_count %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->peb_id,
+		  pebi->current_log.start_page,
+		  array, extent_count,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	rest_bytes = extent_count * extent_size;
+
+	while (rest_bytes > 0) {
+		u32 bytes;
+		u32 cur_off = *write_offset % PAGE_SIZE;
+		u32 new_off;
+
+		bytes = min_t(u32, rest_bytes, PAGE_SIZE - cur_off);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(bytes < extent_size);
+		BUG_ON(written_bytes > (extent_count * extent_size));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = ssdfs_page_array_grab_page(&pebi->cache,
+						  *cur_page);
+		if (IS_ERR_OR_NULL(page)) {
+			SSDFS_ERR("fail to get cache page: index %lu\n",
+				  *cur_page);
+			return -ENOMEM;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_off %u, written_bytes %u, bytes %u\n",
+			  cur_off, written_bytes, bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_memcpy_to_page(page, cur_off, PAGE_SIZE,
+					   array, written_bytes, array_size,
+					   bytes);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_copy;
+		}
+
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+
+		err = ssdfs_page_array_set_page_dirty(&pebi->cache,
+						      *cur_page);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu as dirty: err %d\n",
+				  *cur_page, err);
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
+
+		*write_offset += bytes;
+
+		new_off = (*cur_page << PAGE_SHIFT) + cur_off + bytes;
+		*cur_page = new_off >> PAGE_SHIFT;
+
+		rest_bytes -= bytes;
+		written_bytes += bytes;
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_store_offsets_table_fragment() - store fragment of offsets table
+ * @pebi: pointer on PEB object
+ * @table: pointer on translation table object
+ * @peb_index: PEB's index
+ * @sequence_id: sequence ID of fragment
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store table's fragment into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to find memory page.
+ */
+int ssdfs_peb_store_offsets_table_fragment(struct ssdfs_peb_info *pebi,
+					   struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id,
+					   pgoff_t *cur_page,
+					   u32 *write_offset)
+{
+	struct ssdfs_phys_offset_table_array *pot_table;
+	struct ssdfs_sequence_array *sequence;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	struct ssdfs_phys_offset_table_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_phys_offset_table_header);
+	struct page *page;
+	void *kaddr;
+	u32 fragment_size;
+	u16 flags;
+	u32 next_fragment_off;
+	u32 rest_bytes, written_bytes = 0;
+	u32 cur_off;
+	u32 new_off;
+	u32 diff;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!table || !cur_page || !write_offset);
+	BUG_ON(peb_index >= table->pebs_count);
+
+	SSDFS_DBG("peb %llu, current_log.start_page %u, "
+		  "peb_index %u, sequence_id %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->peb_id,
+		  pebi->current_log.start_page,
+		  peb_index, sequence_id,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&table->translation_lock);
+
+	pot_table = &table->peb[peb_index];
+
+	sequence = pot_table->sequence;
+	kaddr = ssdfs_sequence_array_get_item(sequence, sequence_id);
+	if (IS_ERR_OR_NULL(kaddr)) {
+		err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		goto finish_store_fragment;
+	}
+	fragment = (struct ssdfs_phys_offset_table_fragment *)kaddr;
+
+	down_write(&fragment->lock);
+
+	if (atomic_read(&fragment->state) != SSDFS_BLK2OFF_FRAG_UNDER_COMMIT) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid fragment state %#x\n",
+			  atomic_read(&fragment->state));
+		goto finish_fragment_copy;
+	}
+
+	hdr = fragment->hdr;
+
+	if (!hdr) {
+		err = -ERANGE;
+		SSDFS_ERR("header pointer is NULL\n");
+		goto finish_fragment_copy;
+	}
+
+	fragment_size = le32_to_cpu(hdr->byte_size);
+	rest_bytes = fragment_size;
+
+	if (fragment_size < hdr_size || fragment_size > fragment->buf_size) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid fragment size %u\n",
+			  fragment_size);
+		goto finish_fragment_copy;
+	}
+
+	next_fragment_off = ssdfs_peb_correct_area_write_offset(*write_offset +
+								fragment_size,
+								hdr_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_page %lu, write_offset %u, fragment_size %u, "
+		  "hdr_size %zu, next_fragment_off %u\n",
+		  *cur_page, *write_offset, fragment_size,
+		  hdr_size, next_fragment_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	flags = le16_to_cpu(hdr->flags);
+	if (flags & SSDFS_OFF_TABLE_HAS_NEXT_FRAGMENT) {
+		diff = next_fragment_off - *write_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(diff >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		hdr->next_fragment_off = cpu_to_le16((u16)diff);
+		hdr->checksum = ssdfs_crc32_le(hdr,
+						le32_to_cpu(hdr->byte_size));
+	}
+
+	while (rest_bytes > 0) {
+		u32 bytes;
+		cur_off = *write_offset % PAGE_SIZE;
+
+		bytes = min_t(u32, rest_bytes, PAGE_SIZE - cur_off);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(written_bytes > fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = ssdfs_page_array_grab_page(&pebi->cache,
+						  *cur_page);
+		if (IS_ERR_OR_NULL(page)) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to get cache page: index %lu\n",
+				  *cur_page);
+			goto finish_fragment_copy;
+		}
+
+		err = ssdfs_memcpy_to_page(page, cur_off, PAGE_SIZE,
+					   hdr, written_bytes, fragment_size,
+					   bytes);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_cur_copy;
+		}
+
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("ssdfs_page_array_set_page_dirty %lu\n",
+			  *cur_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_page_array_set_page_dirty(&pebi->cache,
+						      *cur_page);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set page %lu as dirty: err %d\n",
+				  *cur_page, err);
+		}
+
+finish_cur_copy:
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err))
+			goto finish_fragment_copy;
+
+		*write_offset += bytes;
+
+		new_off = (*cur_page << PAGE_SHIFT) + cur_off + bytes;
+		*cur_page = new_off >> PAGE_SHIFT;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_off %u, bytes %u, new_off %u, cur_page %lu\n",
+			  cur_off, bytes, new_off, *cur_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		rest_bytes -= bytes;
+		written_bytes += bytes;
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(*write_offset > next_fragment_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	diff = next_fragment_off - *write_offset;
+
+	if (diff > 0) {
+		cur_off = *write_offset % PAGE_SIZE;
+		*write_offset = next_fragment_off;
+
+		new_off = (*cur_page << PAGE_SHIFT) + cur_off + diff;
+		*cur_page = new_off >> PAGE_SHIFT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_page %lu, write_offset %u, "
+		  "next_fragment_off %u\n",
+		  *cur_page, *write_offset,
+		  next_fragment_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_fragment_copy:
+	up_write(&fragment->lock);
+
+finish_store_fragment:
+	up_read(&table->translation_lock);
+
+	return err;
+}
+
+static inline
+u16 ssdfs_next_sequence_id(u16 sequence_id)
+{
+	u16 next_sequence_id = U16_MAX;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sequence_id %u\n", sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("invalid sequence_id %u\n",
+			  sequence_id);
+		return U16_MAX;
+	} else if (sequence_id < SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		/* increment value */
+		next_sequence_id = sequence_id + 1;
+	} else
+		next_sequence_id = 0;
+
+	return next_sequence_id;
+}
+
+/*
+ * ssdfs_peb_store_offsets_table() - store offsets table
+ * @pebi: pointer on PEB object
+ * @desc: offsets table descriptor [out]
+ * @cur_page: pointer on current page value [in|out]
+ * @write_offset: pointer on write offset value [in|out]
+ *
+ * This function tries to store the offsets table into log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to find memory page.
+ */
+int ssdfs_peb_store_offsets_table(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_metadata_descriptor *desc,
+				  pgoff_t *cur_page,
+				  u32 *write_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_blk2off_table_snapshot snapshot = {0};
+	struct ssdfs_blk2off_table_header hdr;
+	struct ssdfs_translation_extent *extents = NULL;
+	size_t tbl_hdr_size = sizeof(struct ssdfs_blk2off_table_header);
+	u16 extents_off = offsetof(struct ssdfs_blk2off_table_header, sequence);
+	u16 extent_count = 0;
+	u32 offset_table_off;
+	u16 peb_index;
+	u32 table_start_offset;
+	u16 sequence_id;
+	u32 fragments_count = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!pebi->pebc->parent_si->blk2off_table);
+	BUG_ON(!desc || !cur_page || !write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+#else
+	SSDFS_DBG("seg %llu, peb %llu, current_log.start_page %u, "
+		  "cur_page %lu, write_offset %u\n",
+		  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+		  pebi->current_log.start_page,
+		  *cur_page, *write_offset);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	peb_index = pebi->peb_index;
+	table = pebi->pebc->parent_si->blk2off_table;
+
+	memset(desc, 0, sizeof(struct ssdfs_metadata_descriptor));
+	memset(&hdr, 0, tbl_hdr_size);
+
+	err = ssdfs_blk2off_table_snapshot(table, peb_index, &snapshot);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("table hasn't dirty fragments: peb_index %u\n",
+			  peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to get snapshot: peb_index %u, err %d\n",
+			  peb_index, err);
+		return err;
+	}
+
+	if (unlikely(peb_index != snapshot.peb_index)) {
+		err = -ERANGE;
+		SSDFS_ERR("peb_index %u != snapshot.peb_index %u\n",
+			  peb_index, snapshot.peb_index);
+		goto fail_store_off_table;
+	}
+
+	if (unlikely(!snapshot.bmap_copy || !snapshot.tbl_copy)) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid snapshot: "
+			  "peb_index %u, bmap_copy %p, tbl_copy %p\n",
+			  peb_index,
+			  snapshot.bmap_copy,
+			  snapshot.tbl_copy);
+		goto fail_store_off_table;
+	}
+
+	extents = ssdfs_blk2off_kcalloc(snapshot.capacity,
+				sizeof(struct ssdfs_translation_extent),
+				GFP_KERNEL);
+	if (unlikely(!extents)) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate extent array\n");
+		goto fail_store_off_table;
+	}
+
+	hdr.magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	hdr.magic.key = cpu_to_le16(SSDFS_BLK2OFF_TABLE_HDR_MAGIC);
+	hdr.magic.version.major = SSDFS_MAJOR_REVISION;
+	hdr.magic.version.minor = SSDFS_MINOR_REVISION;
+
+	err = ssdfs_blk2off_table_extract_extents(&snapshot, extents,
+						  snapshot.capacity,
+						  &extent_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the extent array: "
+			  "peb_index %u, err %d\n",
+			  peb_index, err);
+		goto fail_store_off_table;
+	} else if (extent_count == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid extent count\n");
+		goto fail_store_off_table;
+	}
+
+	hdr.extents_off = cpu_to_le16(extents_off);
+	hdr.extents_count = cpu_to_le16(extent_count);
+
+#ifdef CONFIG_SSDFS_SAVE_WHOLE_BLK2OFF_TBL_IN_EVERY_LOG
+	fragments_count = snapshot.fragments_count;
+#else
+	fragments_count = snapshot.dirty_fragments;
+#endif /* CONFIG_SSDFS_SAVE_WHOLE_BLK2OFF_TBL_IN_EVERY_LOG */
+
+	offset_table_off = tbl_hdr_size +
+			   ((extent_count - 1) *
+			    sizeof(struct ssdfs_translation_extent));
+
+	hdr.offset_table_off = cpu_to_le16((u16)offset_table_off);
+
+	sequence_id = snapshot.start_sequence_id;
+	for (i = 0; i < fragments_count; i++) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment_index %d, offset_table_off %u\n",
+			  i, offset_table_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_blk2off_table_prepare_for_commit(table, peb_index,
+							     sequence_id,
+							     &offset_table_off,
+							     &snapshot);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare fragment for commit: "
+				  "peb_index %u, sequence_id %u, err %d\n",
+				  peb_index, sequence_id, err);
+			goto fail_store_off_table;
+		}
+
+		sequence_id = ssdfs_next_sequence_id(sequence_id);
+		if (sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid next sequence_id %u\n",
+				  sequence_id);
+			goto fail_store_off_table;
+		}
+	}
+
+	hdr.fragments_count = cpu_to_le16(snapshot.dirty_fragments);
+
+	ssdfs_memcpy(hdr.sequence, 0, sizeof(struct ssdfs_translation_extent),
+		     extents, 0, sizeof(struct ssdfs_translation_extent),
+		     sizeof(struct ssdfs_translation_extent));
+
+	hdr.check.bytes = cpu_to_le16(tbl_hdr_size);
+	hdr.check.flags = cpu_to_le16(SSDFS_CRC32);
+
+	err = ssdfs_calculate_csum(&hdr.check, &hdr, tbl_hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to calculate checksum: err %d\n", err);
+		goto fail_store_off_table;
+	}
+
+	*write_offset = ssdfs_peb_correct_area_write_offset(*write_offset,
+							    tbl_hdr_size);
+	table_start_offset = *write_offset;
+
+	desc->offset = cpu_to_le32(*write_offset +
+				(pebi->current_log.start_page * fsi->pagesize));
+
+	err = ssdfs_peb_store_offsets_table_header(pebi, &hdr,
+						   cur_page, write_offset);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to store offsets table's header: "
+			  "cur_page %lu, write_offset %u, err %d\n",
+			  *cur_page, *write_offset, err);
+		goto fail_store_off_table;
+	}
+
+	if (extent_count > 1) {
+		err = ssdfs_peb_store_offsets_table_extents(pebi, &extents[1],
+							    extent_count - 1,
+							    cur_page,
+							    write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store offsets table's extents: "
+				  "cur_page %lu, write_offset %u, err %d\n",
+				  *cur_page, *write_offset, err);
+			goto fail_store_off_table;
+		}
+	}
+
+	sequence_id = snapshot.start_sequence_id;
+	for (i = 0; i < fragments_count; i++) {
+		err = ssdfs_peb_store_offsets_table_fragment(pebi, table,
+							     peb_index,
+							     sequence_id,
+							     cur_page,
+							     write_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to store offsets table's fragment: "
+				  "sequence_id %u, cur_page %lu, "
+				  "write_offset %u, err %d\n",
+				  sequence_id, *cur_page,
+				  *write_offset, err);
+			goto fail_store_off_table;
+		}
+
+		sequence_id = ssdfs_next_sequence_id(sequence_id);
+		if (sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid next sequence_id %u\n",
+				  sequence_id);
+			goto fail_store_off_table;
+		}
+	}
+
+	err = ssdfs_blk2off_table_forget_snapshot(table, &snapshot,
+						  extents, extent_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to forget snapshot state: "
+			  "peb_index %u, err %d\n",
+			  peb_index, err);
+		goto fail_store_off_table;
+	}
+
+	BUG_ON(*write_offset <= table_start_offset);
+	desc->size = cpu_to_le32(*write_offset - table_start_offset);
+
+	pebi->current_log.seg_flags |= SSDFS_SEG_HDR_HAS_OFFSET_TABLE;
+
+fail_store_off_table:
+	ssdfs_blk2off_table_free_snapshot(&snapshot);
+
+	ssdfs_blk2off_kfree(extents);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
-- 
2.34.1

