Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71716A265D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBYBTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBYBRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:40 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED49814225
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:25 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o12so804130oik.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+9ckWGyOYjVhi0ls0UKK6KqggQpUQFUMZwvw7LkdYE=;
        b=jJdpjOMwH6hcPO6hDt9f6bRSEValfStxuTEm7zB/iQWlJIbXpRoeKi6CFnbo76WLh5
         YG7KOW608coJbtxaAkmL7hCeGiS7CbPOxRjxg5d30T8LF4uqoY9k6xbT/x3477NrhAFP
         4K5WpHAknTFuYLgmjZ8DaIADffeumFT/tZlx29gp44NkV2UsCMFL12kAm6373Efeln3o
         DqJr/0tUQjYZAF+mLIpPMPy72pIIsX1xDrKGQh20VxBhSYzS1VP8rVt4F+qAqdlbwbU5
         aI415fFd7mMLBj5jpTT9HSKgG6ydGDmhDj7xIA2BPiK7ofy3eTWXP3NPmEH7M4TB5EKK
         rrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+9ckWGyOYjVhi0ls0UKK6KqggQpUQFUMZwvw7LkdYE=;
        b=V6TNdCpZXGsf5rT55HUOddRPjcNor4HyO4Bb6Xj+pQmp70Lq2XTnKfi6S9U3o1+O78
         V6PCTQPlT/sLAudB34BCDXtaHuWafEmJOsX+JnTSEmVBQPpoXsYiu69w0SHR5mN5jQ8U
         yTybJB8OsT2Mdq5ploUHpB2kNlYUbJ2hXj/WjzkSukpohTPt5CskiHzrmENdMct38SeR
         gcjQWNEwi7iD/UBgVfcjzGaGkhABI4mPRaOkQahyv3iWp66fjzFzD4j9VFXhDSOz2LQX
         YzfABMgWAmOPdD6GhHXIExrUU+B7WMc+inMh3d6Wexn4xMw3FhHqU6kou5bp8hhUEjYB
         v8Jw==
X-Gm-Message-State: AO0yUKVfX3rDVxMiGrkiVOpnVt30C9vRIG7JNcztzdHaw7ZyYj5AdV8c
        xCfzmcj8xu46DFx6s7mh6wcerkERVHcQlOiH
X-Google-Smtp-Source: AK7set/chlsM5OQitag5fTru1bDfh4Wk8Fan6vmhvjbdBjW/LAupEIJNFsZthpBWygZX0kHzRqfIJA==
X-Received: by 2002:aca:1c0a:0:b0:384:20c:88f2 with SMTP id c10-20020aca1c0a000000b00384020c88f2mr1423128oic.44.1677287844682;
        Fri, 24 Feb 2023 17:17:24 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:23 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 52/76] ssdfs: b-tree node index operations
Date:   Fri, 24 Feb 2023 17:09:03 -0800
Message-Id: <20230225010927.813929-53-slava@dubeyko.com>
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

Every b-tree node is described by index record (or key) that
includes: (1) node ID, (2) node type, (3) node height,
(4) starting hash value, (5) raw extent. The raw extent
describes the segment ID, logical block ID, and length.
Index records are stored into index and hybrid b-tree
nodes. These records implement mechanism of lookup and
traverse operations in b-tree.

Index operations include:
(1) resize_index_area - operation of increasing size of index
                        area in hybrid b-tree node by means of
                        redistribution of free space between
                        index and item area and shift of item
                        area
(2) find_index - find index in hybrid or index b-tree node
(3) add_index - add index in hybrid of index b-tree node
(4) change_index - change index record in hybrid of index b-tree node
(5) delete_index - delete index record from hybrid of index b-tree node

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_node.c | 2985 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2985 insertions(+)

diff --git a/fs/ssdfs/btree_node.c b/fs/ssdfs/btree_node.c
index a826b1c9699d..f4402cb8df64 100644
--- a/fs/ssdfs/btree_node.c
+++ b/fs/ssdfs/btree_node.c
@@ -5222,3 +5222,2988 @@ bool is_ssdfs_node_shared(struct ssdfs_btree_node *node)
 
 	return atomic_read(&node->refs_count) > 1;
 }
+
+/*
+ * ssdfs_btree_root_node_find_index() - find index record in root node
+ * @node: node object
+ * search_hash: hash for search in the index area
+ * @found_index: identification number of found index [out]
+ *
+ * This method tries to find the index record for the requested hash.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - unable to find the node's index.
+ * %-EEXIST     - search hash has been found.
+ */
+static
+int ssdfs_btree_root_node_find_index(struct ssdfs_btree_node *node,
+				     u64 search_hash,
+				     u16 *found_index)
+{
+	int i;
+	int err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !found_index);
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, search_hash %llx\n",
+		  node->node_id, atomic_read(&node->type),
+		  search_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_index = U16_MAX;
+
+	for (i = 0; i < SSDFS_BTREE_ROOT_NODE_INDEX_COUNT; i++) {
+		struct ssdfs_btree_index *ptr = &node->raw.root_node.indexes[i];
+		u64 hash = le64_to_cpu(ptr->hash);
+
+		if (hash == U64_MAX)
+			break;
+
+		if (search_hash < hash)
+			break;
+
+		err = 0;
+		*found_index = i;
+
+		if (search_hash == hash) {
+			err = -EEXIST;
+			break;
+		}
+	}
+
+	return err;
+}
+
+#define CUR_INDEX(kaddr, page_off, index) \
+	((struct ssdfs_btree_index_key *)((u8 *)kaddr + \
+	 page_off + (index * sizeof(struct ssdfs_btree_index_key))))
+
+/*
+ * ssdfs_get_index_key_hash() - get hash from a range
+ * @node: node object
+ * @kaddr: pointer on starting address in the page
+ * @page_off: offset from page's beginning in bytes
+ * @index: requested starting index in the range
+ * @upper_index: last index in the available range
+ * @hash_index: available (not locked) index in the range [out]
+ * @hash: hash value of found index [out]
+ *
+ * This method tries to find any unlocked index in suggested
+ * range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - unable to find the node's index.
+ */
+static
+int ssdfs_get_index_key_hash(struct ssdfs_btree_node *node,
+			     void *kaddr, u32 page_off,
+			     u32 index, u32 upper_index,
+			     u32 *hash_index, u64 *hash)
+{
+	struct ssdfs_btree_index_key *ptr;
+	int err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !kaddr || !hash_index || !hash);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("kaddr %p, page_off %u, "
+		  "index %u, upper_index %u\n",
+		  kaddr, page_off, index, upper_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*hash = U64_MAX;
+
+	for (*hash_index = index; *hash_index <= upper_index; ++(*hash_index)) {
+		err = ssdfs_lock_index_range(node, *hash_index, 1);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock index %u, err %d\n",
+				  *hash_index, err);
+			break;
+		}
+
+		err = -EEXIST;
+		ptr = CUR_INDEX(kaddr, page_off, *hash_index);
+		*hash = le64_to_cpu(ptr->index.hash);
+
+		ssdfs_unlock_index_range(node, *hash_index, 1);
+
+		if (err == -EEXIST) {
+			err = 0;
+			break;
+		} else if (err == -ENODATA)
+			continue;
+		else if (unlikely(err))
+			break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash_index %u, hash %llx\n",
+		  *hash_index, *hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_check_last_index() - check last index in the search
+ * @node: node object
+ * @kaddr: pointer on starting address in the page
+ * @page_off: offset from page's beginning in bytes
+ * @index: requested index for the check
+ * @search_hash: hash for search
+ * @range_start: first index in the index area
+ * @range_end: last index in the index area
+ * @prev_found: processed index on previous iteration
+ * @found_index: value of found index [out]
+ *
+ * This method tries to check the index for the case when
+ * range has only one index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - requested hash is located in previous range.
+ * %-ENODATA    - unable to find the node's index.
+ */
+static
+int ssdfs_check_last_index(struct ssdfs_btree_node *node,
+			   void *kaddr, u32 page_off,
+			   u32 index, u64 search_hash,
+			   u32 range_start, u32 range_end,
+			   u32 prev_found, u16 *found_index)
+{
+	u32 hash_index;
+	u64 hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !kaddr || !found_index);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("kaddr %p, page_off %u, "
+		  "index %u, search_hash %llx, "
+		  "range_start %u, range_end %u, "
+		  "prev_found %u\n",
+		  kaddr, page_off, index, search_hash,
+		  range_start, range_end, prev_found);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_get_index_key_hash(node, kaddr, page_off,
+					index, index,
+					&hash_index, &hash);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get hash: "
+			  "index %u, err %d\n",
+			  index, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash_index %u, hash %llx\n",
+		  hash_index, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (hash_index != index) {
+		SSDFS_ERR("hash_index %u != index %u\n",
+			  hash_index, index);
+		return -ERANGE;
+	}
+
+	if (search_hash < hash) {
+		err = -ENOENT;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find index: "
+			  "index %u, search_hash %llx, "
+			  "hash %llx\n",
+			  hash_index, search_hash,
+			  hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (prev_found < U16_MAX)
+			*found_index = prev_found;
+		else
+			*found_index = hash_index;
+	} else if (search_hash == hash) {
+		err = 0;
+		*found_index = hash_index;
+	} else {
+		err = -ENODATA;
+		*found_index = hash_index;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("prev_found %u, found_index %u\n",
+		  prev_found, *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_check_last_index_pair() - check last pair of indexes in the search
+ * @node: node object
+ * @kaddr: pointer on starting address in the page
+ * @page_off: offset from page's beginning in bytes
+ * @lower_index: starting index in the search
+ * @upper_index: ending index in the search
+ * @search_hash: hash for search
+ * @range_start: first index in the index area
+ * @range_end: last index in the index area
+ * @prev_found: processed index on previous iteration
+ * @found_index: value of found index [out]
+ *
+ * This method tries to find an index for the case when
+ * range has only two indexes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - requested hash is located in previous range.
+ * %-ENODATA    - unable to find the node's index.
+ */
+static
+int ssdfs_check_last_index_pair(struct ssdfs_btree_node *node,
+				void *kaddr, u32 page_off,
+				u32 lower_index, u32 upper_index,
+				u64 search_hash,
+				u32 range_start, u32 range_end,
+				u32 prev_found, u16 *found_index)
+{
+	u32 hash_index;
+	u64 hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !kaddr || !found_index);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("kaddr %p, page_off %u, "
+		  "lower_index %u, upper_index %u, "
+		  "search_hash %llx, range_start %u, prev_found %u\n",
+		  kaddr, page_off, lower_index, upper_index,
+		  search_hash, range_start, prev_found);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_get_index_key_hash(node, kaddr, page_off,
+					lower_index, upper_index,
+					&hash_index, &hash);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get hash: "
+			  "lower_index %u, upper_index %u, err %d\n",
+			  lower_index, upper_index, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash_index %u, hash %llx\n",
+		  hash_index, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (hash_index == lower_index) {
+		if (search_hash < hash) {
+			err = -ENOENT;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find index: "
+				  "index %u, search_hash %llx, "
+				  "hash %llx\n",
+				  hash_index, search_hash,
+				  hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (prev_found < U16_MAX)
+				*found_index = prev_found;
+			else
+				*found_index = hash_index;
+		} else if (search_hash == hash) {
+			err = 0;
+			*found_index = hash_index;
+		} else {
+			prev_found = hash_index;
+			err = ssdfs_check_last_index(node, kaddr, page_off,
+						     upper_index, search_hash,
+						     range_start, range_end,
+						     prev_found, found_index);
+			if (err == -ENOENT) {
+				err = 0;
+				*found_index = prev_found;
+			}
+		}
+	} else if (hash_index == upper_index) {
+		if (search_hash > hash) {
+			err = -ENODATA;
+			*found_index = upper_index;
+		} else if (search_hash == hash) {
+			err = 0;
+			*found_index = upper_index;
+		} else {
+			prev_found = hash_index;
+			err = ssdfs_check_last_index(node, kaddr, page_off,
+						     lower_index, search_hash,
+						     range_start, range_end,
+						     prev_found, found_index);
+			if (err == -ENOENT) {
+				err = 0;
+				*found_index = prev_found;
+			}
+		}
+	} else {
+		SSDFS_ERR("invalid index: hash_index %u, "
+			  "lower_index %u, upper_index %u\n",
+			  hash_index, lower_index, upper_index);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("prev_found %u, found_index %u, err %d\n",
+		  prev_found, *found_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_find_index_in_memory_page() - find index record in memory page
+ * @node: node object
+ * @area: description of index area
+ * @start_offset: offset in the index area of the node
+ * search_hash: hash for search in the index area
+ * @found_index: identification number of found index [out]
+ * @processed_bytes: amount of processed bytes into index area [out]
+ *
+ * This method tries to find the index record for the requested hash.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find the node's index.
+ * %-ENOENT     - index record is outside of this memory page.
+ */
+static
+int ssdfs_find_index_in_memory_page(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u32 start_offset,
+				    u64 search_hash,
+				    u16 *found_index,
+				    u32 *processed_bytes)
+{
+	struct page *page;
+	void *kaddr;
+	u32 page_index;
+	u32 page_off;
+	u32 search_bytes;
+	u32 index_count;
+	u32 cur_index, upper_index, lower_index;
+	u32 range_start, range_end;
+	u32 prev_found;
+	u64 hash;
+	u32 processed_indexes = 0;
+	int err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !processed_bytes || !found_index);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, "
+		  "start_offset %u, search_hash %llx\n",
+		  node->node_id, atomic_read(&node->type),
+		  start_offset, search_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_index = U16_MAX;
+	*processed_bytes = 0;
+
+	if (start_offset >= (area->offset + area->area_size)) {
+		SSDFS_ERR("invalid start_offset: "
+			  "offset %u, area_start %u, area_size %u\n",
+			  start_offset, area->offset, area->area_size);
+		return -ERANGE;
+	}
+
+	if (area->index_size != sizeof(struct ssdfs_btree_index_key)) {
+		SSDFS_ERR("invalid index size %u\n",
+			  area->index_size);
+		return -ERANGE;
+	}
+
+	page_index = start_offset >> PAGE_SHIFT;
+	page_off = start_offset % PAGE_SIZE;
+
+	if ((page_off + area->index_size) > PAGE_SIZE) {
+		SSDFS_ERR("invalid offset into the page: "
+			  "offset %u, index_size %u\n",
+			  page_off, area->index_size);
+		return -ERANGE;
+	}
+
+	if (page_index == 0 && page_off < area->offset) {
+		SSDFS_ERR("page_off %u < area->offset %u\n",
+			  page_off, area->offset);
+		return -ERANGE;
+	}
+
+	if (page_off % area->index_size) {
+		SSDFS_ERR("offset is not aligned: "
+			  "page_off %u, index_size %u\n",
+			  page_off, area->index_size);
+		return -ERANGE;
+	}
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("invalid page index: "
+			  "page_index %u, pagevec_count %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	search_bytes = PAGE_SIZE - page_off;
+	search_bytes = min_t(u32, search_bytes,
+			(area->offset + area->area_size) - start_offset);
+
+	index_count = search_bytes / area->index_size;
+	if (index_count == 0) {
+		SSDFS_ERR("invalid index_count %u\n",
+			  index_count);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search_bytes %u, offset %u, area_size %u\n",
+		  search_bytes, area->offset, area->area_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	processed_indexes = (start_offset - area->offset);
+	processed_indexes /= area->index_size;
+
+	if (processed_indexes >= area->index_capacity) {
+		SSDFS_ERR("processed_indexes %u >= area->index_capacity %u\n",
+			  processed_indexes,
+			  area->index_capacity);
+		return -ERANGE;
+	} else if (processed_indexes >= area->index_count) {
+		err = -ENOENT;
+		*processed_bytes = search_bytes;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find an index: "
+			  "processed_indexes %u, area->index_count %u\n",
+			  processed_indexes,
+			  area->index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area->index_count %u, area->index_capacity %u\n",
+		  area->index_count, area->index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	index_count = min_t(u32, index_count,
+				area->index_count - processed_indexes);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("area->index_count %u, processed_indexes %u, "
+		  "index_count %u\n",
+		  area->index_count, processed_indexes, index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_index = 0;
+	range_start = lower_index = 0;
+	range_end = upper_index = index_count - 1;
+
+	page = node->content.pvec.pages[page_index];
+	kaddr = kmap_local_page(page);
+
+	prev_found = *found_index;
+	while (lower_index <= upper_index) {
+		int diff = upper_index - lower_index;
+		u32 hash_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("lower_index %u, upper_index %u, diff %d\n",
+			  lower_index, upper_index, diff);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (diff < 0) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid diff: "
+				  "diff %d, lower_index %u, "
+				  "upper_index %u\n",
+				  diff, lower_index, upper_index);
+			goto finish_search;
+		}
+
+		if (diff == 0) {
+			err = ssdfs_check_last_index(node, kaddr, page_off,
+						     lower_index, search_hash,
+						     range_start, range_end,
+						     prev_found, found_index);
+			if (err == -ENOENT) {
+				if (prev_found < U16_MAX)
+					*found_index = prev_found;
+			} else if (err == -ENODATA) {
+				/*
+				 * Nothing was found
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check the last index: "
+					  "index %u, err %d\n",
+					  lower_index, err);
+			}
+
+			*processed_bytes = search_bytes;
+			goto finish_search;
+		} else if (diff == 1) {
+			err = ssdfs_check_last_index_pair(node, kaddr,
+							  page_off,
+							  lower_index,
+							  upper_index,
+							  search_hash,
+							  range_start,
+							  range_end,
+							  prev_found,
+							  found_index);
+			if (err == -ENOENT) {
+				if (prev_found < U16_MAX)
+					*found_index = prev_found;
+			} else if (err == -ENODATA) {
+				/*
+				 * Nothing was found
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check the last index pair: "
+					  "lower_index %u, upper_index %u, "
+					  "err %d\n",
+					  lower_index, upper_index, err);
+			}
+
+			*processed_bytes = search_bytes;
+			goto finish_search;
+		} else
+			cur_index = lower_index + (diff / 2);
+
+
+		err = ssdfs_get_index_key_hash(node, kaddr, page_off,
+						cur_index, upper_index,
+						&hash_index, &hash);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to get hash: "
+				  "cur_index %u, upper_index %u, err %d\n",
+				  cur_index, upper_index, err);
+			goto finish_search;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("search_hash %llx, hash %llx, "
+			  "hash_index %u, range_start %u, range_end %u\n",
+			  search_hash, hash, hash_index,
+			  range_start, range_end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (search_hash < hash) {
+			if (hash_index == range_start) {
+				err = -ENOENT;
+				*found_index = hash_index;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to find index: "
+					  "index %u, search_hash %llx, "
+					  "hash %llx\n",
+					  hash_index, search_hash,
+					  hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_search;
+			} else {
+				prev_found = lower_index;
+				upper_index = cur_index;
+			}
+		} else if (search_hash == hash) {
+			err = -EEXIST;
+			*found_index = cur_index;
+			*processed_bytes = search_bytes;
+			goto finish_search;
+		} else {
+			if (hash_index == range_end) {
+				err = -ENODATA;
+				*found_index = hash_index;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to find index: "
+					  "index %u, search_hash %llx, "
+					  "hash %llx\n",
+					  hash_index, search_hash,
+					  hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_search;
+			} else {
+				prev_found = lower_index;
+				lower_index = cur_index;
+			}
+		}
+	};
+
+finish_search:
+	kunmap_local(kaddr);
+
+	if (!err || err == -EEXIST) {
+		*found_index += processed_indexes;
+		if (*found_index >= area->index_capacity) {
+			SSDFS_ERR("found_index %u >= capacity %u\n",
+				  *found_index,
+				  area->index_capacity);
+			return -ERANGE;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("prev_found %u, found_index %u\n",
+		  prev_found, *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_common_node_find_index() - find index record
+ * @node: node object
+ * @area: description of index area
+ * search_hash: hash for search in the index area
+ * @found_index: identification number of found index [out]
+ *
+ * This method tries to find the index record for the requested hash.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find the node's index.
+ * %-EEXIST     - search hash has been found.
+ */
+static
+int ssdfs_btree_common_node_find_index(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u64 search_hash,
+				    u16 *found_index)
+{
+	u32 start_offset, end_offset;
+	u32 processed_bytes = 0;
+	u16 prev_found = U16_MAX;
+	int err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !found_index);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, search_hash %llx\n",
+		  node->node_id, atomic_read(&node->type),
+		  search_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_index = U16_MAX;
+
+	if (atomic_read(&area->state) != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  atomic_read(&area->state));
+		return -ERANGE;
+	}
+
+	if (area->index_count == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't any index\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	if (area->index_count > area->index_capacity) {
+		SSDFS_ERR("invalid area: "
+			  "index_count %u, index_capacity %u\n",
+			  area->index_count,
+			  area->index_capacity);
+		return -ERANGE;
+	}
+
+	if ((area->offset + area->area_size) > node->node_size) {
+		SSDFS_ERR("invalid area: "
+			  "offset %u, area_size %u, node_size %u\n",
+			  area->offset,
+			  area->area_size,
+			  node->node_size);
+		return -ERANGE;
+	}
+
+	if (area->index_size != sizeof(struct ssdfs_btree_index_key)) {
+		SSDFS_ERR("invalid index size %u\n",
+			  area->index_size);
+		return -ERANGE;
+	}
+
+	start_offset = area->offset;
+	end_offset = area->offset + area->area_size;
+
+	while (start_offset < end_offset) {
+		prev_found = *found_index;
+		err = ssdfs_find_index_in_memory_page(node, area,
+						      start_offset,
+						      search_hash,
+						      found_index,
+						      &processed_bytes);
+		if (err == -ENODATA) {
+			err = 0;
+
+			if (*found_index >= U16_MAX) {
+				/*
+				 * continue to search
+				 */
+			} else if ((*found_index + 1) >= area->index_count) {
+				/*
+				 * index has been found
+				 */
+				break;
+			}
+		} else if (err == -ENOENT) {
+			err = 0;
+
+			if (prev_found != U16_MAX) {
+				err = 0;
+				*found_index = prev_found;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("node_id %u, search_hash %llx, "
+					  "found_index %u\n",
+					  node->node_id, search_hash,
+					  *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			}
+			break;
+		} else if (err == -EEXIST) {
+			/*
+			 * index has been found
+			 */
+			break;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find index: err %d\n",
+				  err);
+			break;
+		} else
+			break;
+
+		start_offset += processed_bytes;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("prev_found %u, found_index %u, err %d\n",
+		  prev_found, *found_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_root_node_extract_index() - extract index from root node
+ * @node: node object
+ * @found_index: identification number of found index
+ * @search: btree search object [out]
+ *
+ * This method tries to extract index record from the index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int __ssdfs_btree_root_node_extract_index(struct ssdfs_btree_node *node,
+					  u16 found_index,
+					  struct ssdfs_btree_index_key *ptr)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index);
+	__le32 node_id;
+	int node_height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, found_index %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (found_index >= SSDFS_BTREE_ROOT_NODE_INDEX_COUNT) {
+		SSDFS_ERR("invalid found_index %u\n",
+			  found_index);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index 0: node_id %u; index 1: node_id %u\n",
+		  cpu_to_le32(node->raw.root_node.header.node_ids[0]),
+		  cpu_to_le32(node->raw.root_node.header.node_ids[1]));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	node_id = node->raw.root_node.header.node_ids[found_index];
+	ptr->node_id = cpu_to_le32(node_id);
+	ssdfs_memcpy(&ptr->index, 0, index_size,
+		     &node->raw.root_node.indexes[found_index], 0, index_size,
+		     index_size);
+	up_read(&node->header_lock);
+
+	node_height = atomic_read(&node->height);
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(node_height < 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+	ptr->height = node_height - 1;
+
+	switch (node_height) {
+	case SSDFS_BTREE_LEAF_NODE_HEIGHT:
+	case SSDFS_BTREE_PARENT2LEAF_HEIGHT:
+		ptr->node_type = SSDFS_BTREE_LEAF_NODE;
+		break;
+
+	case SSDFS_BTREE_PARENT2HYBRID_HEIGHT:
+		ptr->node_type = SSDFS_BTREE_HYBRID_NODE;
+		break;
+
+	default:
+		ptr->node_type = SSDFS_BTREE_INDEX_NODE;
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_height %u, node_type %#x\n",
+		  node_height, ptr->node_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr->flags = cpu_to_le16(SSDFS_BTREE_INDEX_HAS_VALID_EXTENT);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_root_node_extract_index() - extract index from root node
+ * @node: node object
+ * @found_index: identification number of found index
+ * @search: btree search object [out]
+ *
+ * This method tries to extract index record from the index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_btree_root_node_extract_index(struct ssdfs_btree_node *node,
+					u16 found_index,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_index_key *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, found_index %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = &search->node.found_index;
+	return __ssdfs_btree_root_node_extract_index(node, found_index, ptr);
+}
+
+/*
+ * ssdfs_btree_node_get_index() - extract index from node
+ * @pvec: pagevec object
+ * @area_offset: area offset from the node's beginning
+ * @area_size: size of the area
+ * @node_size: node size in bytes
+ * @position: position of index record in the node
+ * @ptr: pointer on index buffer [out]
+ *
+ * This method tries to extract index record from the index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_get_index(struct pagevec *pvec,
+				u32 area_offset, u32 area_size,
+				u32 node_size, u16 position,
+				struct ssdfs_btree_index_key *ptr)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index_key);
+	struct page *page;
+	u32 page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec || !ptr);
+
+	SSDFS_DBG("area_offset %u, area_size %u, "
+		  "node_size %u, position %u\n",
+		  area_offset, area_size,
+		  node_size, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_define_memory_page(area_offset, area_size,
+					 node_size, index_size, position,
+					 &page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "position %u, err %d\n",
+			  position, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(pvec));
+		return -ERANGE;
+	}
+
+	page = pvec->pages[page_index];
+	err = ssdfs_memcpy_from_page(ptr, 0, index_size,
+				     page, page_off, PAGE_SIZE,
+				     index_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid page_off %u, err %d\n",
+			  page_off, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(ptr->node_id),
+		  ptr->node_type,
+		  le64_to_cpu(ptr->index.hash),
+		  le64_to_cpu(ptr->index.extent.seg_id),
+		  le32_to_cpu(ptr->index.extent.logical_blk),
+		  le32_to_cpu(ptr->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * __ssdfs_btree_common_node_extract_index() - extract index from node
+ * @node: node object
+ * @area: description of index area
+ * @found_index: identification number of found index
+ * @search: btree search object [out]
+ *
+ * This method tries to extract index record from the index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int __ssdfs_btree_common_node_extract_index(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u16 found_index,
+				    struct ssdfs_btree_index_key *ptr)
+{
+	struct page *page;
+	size_t index_key_len = sizeof(struct ssdfs_btree_index_key);
+	u32 page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, found_index %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (found_index == area->index_count) {
+		SSDFS_ERR("found_index %u == index_count %u\n",
+			  found_index, area->index_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_memory_page(node, area, found_index,
+					&page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "node_id %u, found_index %u, err %d\n",
+			  node->node_id, found_index, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+	err = ssdfs_memcpy_from_page(ptr, 0, index_key_len,
+				     page, page_off, PAGE_SIZE,
+				     index_key_len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	if (ptr->node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    ptr->node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_WARN("node_id %u, node_type %#x, found_index %u\n",
+			  node->node_id, atomic_read(&node->type),
+			  found_index);
+		SSDFS_ERR("page_index %u, page_off %u\n",
+			  page_index, page_off);
+		SSDFS_ERR("FOUND_INDEX: node_id %u, node_type %#x, "
+			  "height %u, flags %#x, hash %llx, "
+			  "seg_id %llu, logical_blk %u, len %u\n",
+			  le32_to_cpu(ptr->node_id),
+			  ptr->node_type, ptr->height, ptr->flags,
+			  le64_to_cpu(ptr->index.hash),
+			  le64_to_cpu(ptr->index.extent.seg_id),
+			  le32_to_cpu(ptr->index.extent.logical_blk),
+			  le32_to_cpu(ptr->index.extent.len));
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("FOUND_INDEX: node_id %u, node_type %#x, "
+		  "height %u, flags %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(ptr->node_id),
+		  ptr->node_type, ptr->height, ptr->flags,
+		  le64_to_cpu(ptr->index.hash),
+		  le64_to_cpu(ptr->index.extent.seg_id),
+		  le32_to_cpu(ptr->index.extent.logical_blk),
+		  le32_to_cpu(ptr->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_extract_index() - extract index from node
+ * @node: node object
+ * @area: description of index area
+ * @found_index: identification number of found index
+ * @search: btree search object [out]
+ *
+ * This method tries to extract index record from the index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_btree_common_node_extract_index(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u16 found_index,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_index_key *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, found_index %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = &search->node.found_index;
+	return __ssdfs_btree_common_node_extract_index(node, area,
+							found_index, ptr);
+}
+
+/*
+ * ssdfs_find_index_by_hash() - find index record in the node by hash
+ * @node: node object
+ * @area: description of index area
+ * @hash: hash value for the search
+ * @found_index: found position of index record in the node [out]
+ *
+ * This method tries to find node's index for
+ * the requested hash value.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find the node's index.
+ * %-EEXIST     - search hash has been found.
+ */
+int ssdfs_find_index_by_hash(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_index_area *area,
+			     u64 hash,
+			     u16 *found_index)
+{
+	int node_type;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !found_index);
+
+	SSDFS_DBG("node_id %u, hash %llx, "
+		  "area->start_hash %llx, area->end_hash %llx\n",
+		  node->node_id, hash,
+		  area->start_hash, area->end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_index = U16_MAX;
+
+	node_type = atomic_read(&node->type);
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  node_type);
+		return -ERANGE;
+	}
+
+	if (atomic_read(&area->state) != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("index area hasn't been created: "
+			  "node_id %u, node_type %#x\n",
+			  node->node_id,
+			  atomic_read(&node->type));
+		return -ERANGE;
+	}
+
+	if (area->index_count == 0) {
+		*found_index = 0;
+		SSDFS_DBG("index area is empty\n");
+		return -ENODATA;
+	}
+
+	if (area->index_count > area->index_capacity) {
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  area->index_count,
+			  area->index_capacity);
+		return -ERANGE;
+	}
+
+	if (area->start_hash == U64_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_hash is invalid: node_id %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (hash == U64_MAX) {
+		SSDFS_ERR("invalid requested hash\n");
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (hash < area->start_hash) {
+		err = 0;
+		*found_index = 0;
+		goto finish_hash_search;
+	}
+
+	if (area->end_hash == U64_MAX)
+		*found_index = 0;
+	else if (hash >= area->end_hash) {
+		*found_index = area->index_count - 1;
+	} else {
+		if (node_type == SSDFS_BTREE_ROOT_NODE) {
+			err = ssdfs_btree_root_node_find_index(node, hash,
+								found_index);
+			if (err == -ENODATA) {
+				SSDFS_DBG("unable to find index\n");
+				goto finish_hash_search;
+			} else if (err == -EEXIST) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("index exists already: "
+					  "hash %llx, index %u\n",
+					  hash, *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_hash_search;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to find index in root node: "
+					  "err %d\n",
+					  err);
+				goto finish_hash_search;
+			} else if (*found_index == U16_MAX) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid index was found\n");
+				goto finish_hash_search;
+			}
+		} else {
+			err = ssdfs_btree_common_node_find_index(node, area,
+								 hash,
+								 found_index);
+			if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to find index: "
+					  "node_id %u\n",
+					  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_hash_search;
+			} else if (err == -EEXIST) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("index exists already: "
+					  "hash %llx, index %u\n",
+					  hash, *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_hash_search;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to find index in the node: "
+					  "node_id %u, err %d\n",
+					  node->node_id, err);
+				goto finish_hash_search;
+			} else if (*found_index == U16_MAX) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid index was found\n");
+				goto finish_hash_search;
+			}
+		}
+	}
+
+finish_hash_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash %llx, found_index %u, err %d\n",
+		  hash, *found_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_find_index_position() - find index's position
+ * @node: node object
+ * @hash: hash value
+ * @found_position: pointer on returned value [out]
+ *
+ * This method tries to find node's index for
+ * the requested hash value.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find the node's index.
+ * %-ENOENT     - node hasn't the index area.
+ * %-EACCES     - node is under initialization yet.
+ */
+int ssdfs_btree_node_find_index_position(struct ssdfs_btree_node *node,
+					 u64 hash,
+					 u16 *found_position)
+{
+	struct ssdfs_btree_node_index_area area;
+	size_t desc_size = sizeof(struct ssdfs_btree_node_index_area);
+	int node_type;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !found_position);
+	BUG_ON(!node->tree);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx\n",
+		  node->node_id,
+		  atomic_read(&node->type),
+		  hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	*found_position = U16_MAX;
+
+	down_read(&node->full_lock);
+
+	node_type = atomic_read(&node->type);
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid node type %#x\n",
+			  node_type);
+		goto finish_index_search;
+	}
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&area, 0, desc_size,
+		     &node->index_area, 0, desc_size,
+		     desc_size);
+	err = ssdfs_find_index_by_hash(node, &area, hash,
+					found_position);
+	up_read(&node->header_lock);
+
+	if (err == -EEXIST) {
+		/* hash == found hash */
+		err = 0;
+	} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find an index: "
+			  "node_id %u, hash %llx\n",
+			  node->node_id, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_index_search;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find an index: "
+			  "node_id %u, hash %llx, err %d\n",
+			  node->node_id, hash, err);
+		goto finish_index_search;
+	}
+
+finish_index_search:
+	up_read(&node->full_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(*found_position == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_find_index() - find node's index
+ * @search: btree search object
+ *
+ * This method tries to find node's index for
+ * the requested hash value.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find the node's index.
+ * %-ENOENT     - node hasn't the index area.
+ * %-EACCES     - node is under initialization yet.
+ */
+int ssdfs_btree_node_find_index(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_node_index_area area;
+	size_t desc_size = sizeof(struct ssdfs_btree_node_index_area);
+	int tree_height;
+	int node_type;
+	u16 found_index = U16_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.parent) {
+		node = search->node.parent;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node->tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		tree_height = atomic_read(&node->tree->height);
+		if (tree_height <= (SSDFS_BTREE_LEAF_NODE_HEIGHT + 1)) {
+			/* tree has only root node */
+			return -ENODATA;
+		}
+	}
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		node = search->node.parent;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try parent node %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	down_read(&node->full_lock);
+
+	node_type = atomic_read(&node->type);
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid node type %#x\n",
+			  node_type);
+		goto finish_index_search;
+	}
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&area, 0, desc_size,
+		     &node->index_area, 0, desc_size,
+		     desc_size);
+	err = ssdfs_find_index_by_hash(node, &area,
+					search->request.start.hash,
+					&found_index);
+	up_read(&node->header_lock);
+
+	if (err == -EEXIST) {
+		/* hash == found hash */
+		err = 0;
+	} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find an index: "
+			  "node_id %u, hash %llx\n",
+			  node->node_id, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_index_search;
+	} else if (unlikely(err)) {
+		SSDFS_WARN("fail to find an index: "
+			  "node_id %u, hash %llx, err %d\n",
+			  node->node_id, search->request.start.hash,
+			  err);
+		goto finish_index_search;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(found_index == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node_type == SSDFS_BTREE_ROOT_NODE) {
+		err = ssdfs_btree_root_node_extract_index(node,
+							  found_index,
+							  search);
+	} else {
+		err = ssdfs_btree_common_node_extract_index(node, &area,
+							    found_index,
+							    search);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract index: "
+			  "node_id %u, node_type %#x, "
+			  "found_index %u, err %d\n",
+			  node->node_id, node_type,
+			  found_index, err);
+		goto finish_index_search;
+	}
+
+finish_index_search:
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		ssdfs_debug_show_btree_node_indexes(node->tree, node);
+
+	return err;
+}
+
+/*
+ * can_add_new_index() - check that index area has free space
+ * @node: node object
+ */
+bool can_add_new_index(struct ssdfs_btree_node *node)
+{
+	bool can_add = false;
+	u16 count, capacity;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	count = node->index_area.index_count;
+	capacity = node->index_area.index_capacity;
+	if (count > capacity)
+		err = -ERANGE;
+	else
+		can_add = count < capacity;
+	up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u, can_add %#x, err %d\n",
+		  count, capacity, can_add, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_WARN("count %u > capacity %u\n",
+			   count, capacity);
+		return false;
+	}
+
+	return can_add;
+}
+
+/*
+ * ssdfs_btree_root_node_add_index() - add index record into the root node
+ * @node: node object
+ * @position: position in the node for storing the new index record
+ * @ptr: pointer on storing index record [in]
+ *
+ * This method tries to add index record into the root node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - root node hasn't free space.
+ * %-EEXIST     - root node contains such record already.
+ */
+static
+int ssdfs_btree_root_node_add_index(struct ssdfs_btree_node *node,
+				    u16 position,
+				    struct ssdfs_btree_index_key *ptr)
+{
+	struct ssdfs_btree_index *found = NULL;
+	size_t index_size = sizeof(struct ssdfs_btree_index);
+	u64 hash1, hash2;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u\n",
+		  node->node_id, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (position >= SSDFS_BTREE_ROOT_NODE_INDEX_COUNT) {
+		SSDFS_ERR("invalid position %u\n",
+			  position);
+		return -ERANGE;
+	}
+
+	if (node->index_area.index_count > node->index_area.index_capacity) {
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+		return -ERANGE;
+	}
+
+	if (node->index_area.index_count == node->index_area.index_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add the index: "
+			  "index_count %u, index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	found = &node->raw.root_node.indexes[position];
+
+	hash1 = le64_to_cpu(found->hash);
+	hash2 = le64_to_cpu(ptr->index.hash);
+
+	if (hash1 == hash2) {
+		ssdfs_memcpy(&node->raw.root_node.indexes[position],
+			     0, index_size,
+			     &ptr->index, 0, index_size,
+			     index_size);
+	} else if (hash1 < hash2) {
+		ssdfs_memcpy(&node->raw.root_node.indexes[position + 1],
+			     0, index_size,
+			     &ptr->index, 0, index_size,
+			     index_size);
+		position++;
+		node->index_area.index_count++;
+	} else {
+		void *indexes = node->raw.root_node.indexes;
+		u32 dst_off = (u32)(position + 1) * index_size;
+		u32 src_off = (u32)position * index_size;
+		u32 array_size = index_size * SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+		u32 move_size = (u32)(node->index_area.index_count - position) *
+					index_size;
+
+		err = ssdfs_memmove(indexes, dst_off, array_size,
+				    indexes, src_off, array_size,
+				    move_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: err %d\n", err);
+			return err;
+		}
+
+		ssdfs_memcpy(&node->raw.root_node.indexes[position],
+			     0, index_size,
+			     &ptr->index, 0, index_size,
+			     index_size);
+		node->index_area.index_count++;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(ptr->node_id),
+		  ptr->node_type,
+		  le64_to_cpu(ptr->index.hash),
+		  le64_to_cpu(ptr->index.extent.seg_id),
+		  le32_to_cpu(ptr->index.extent.logical_blk),
+		  le32_to_cpu(ptr->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	found = &node->raw.root_node.indexes[0];
+	node->index_area.start_hash = le64_to_cpu(found->hash);
+
+	found = &node->raw.root_node.indexes[node->index_area.index_count - 1];
+	node->index_area.end_hash = le64_to_cpu(found->hash);
+
+	ssdfs_memcpy(&node->raw.root_node.header.node_ids[position],
+		     0, sizeof(__le32),
+		     &ptr->node_id, 0, sizeof(__le32),
+		     sizeof(__le32));
+
+	return 0;
+}
+
+/*
+ * __ssdfs_btree_common_node_add_index() - add index record into the node
+ * @node: node object
+ * @position: position in the node for storing the new index record
+ * @ptr: pointer on storing index record [in]
+ *
+ * This method tries to add index record into the common node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_btree_common_node_add_index(struct ssdfs_btree_node *node,
+					u16 position,
+					struct ssdfs_btree_index_key *ptr)
+{
+	struct page *page;
+	size_t index_key_len = sizeof(struct ssdfs_btree_index_key);
+	u32 page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u\n",
+		  node->node_id, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (position != node->index_area.index_count) {
+		SSDFS_ERR("cannot add index: "
+			  "position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_memory_page(node, &node->index_area,
+					position,
+					&page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "node_id %u, position %u, err %d\n",
+			  node->node_id, position, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+
+	ssdfs_lock_page(page);
+	err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+				   ptr, 0, index_key_len,
+				   index_key_len);
+	ssdfs_unlock_page(page);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %u, page_off %u\n",
+		  page_index, page_off);
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(ptr->node_id),
+		  ptr->node_type,
+		  le64_to_cpu(ptr->index.hash),
+		  le64_to_cpu(ptr->index.extent.seg_id),
+		  le32_to_cpu(ptr->index.extent.logical_blk),
+		  le32_to_cpu(ptr->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_root_node_change_index() - change index record into root node
+ * @node: node object
+ * @found_index: position in the node of the changing index record
+ * @new_index: pointer on new index record state [in]
+ *
+ * This method tries to change the index record into the root node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_btree_root_node_change_index(struct ssdfs_btree_node *node,
+				       u16 found_index,
+				       struct ssdfs_btree_index_key *new_index)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !new_index);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, found_index %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  found_index);
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(new_index->node_id),
+		  new_index->node_type,
+		  le64_to_cpu(new_index->index.hash),
+		  le64_to_cpu(new_index->index.extent.seg_id),
+		  le32_to_cpu(new_index->index.extent.logical_blk),
+		  le32_to_cpu(new_index->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (found_index >= SSDFS_BTREE_ROOT_NODE_INDEX_COUNT) {
+		SSDFS_ERR("invalid found_index %u\n",
+			  found_index);
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&node->raw.root_node.indexes[found_index],
+		     0, index_size,
+		     &new_index->index, 0, index_size,
+		     index_size);
+
+	switch (found_index) {
+	case SSDFS_ROOT_NODE_LEFT_LEAF_NODE:
+		node->index_area.start_hash =
+			le64_to_cpu(new_index->index.hash);
+		break;
+
+	case SSDFS_ROOT_NODE_RIGHT_LEAF_NODE:
+		node->index_area.end_hash =
+			le64_to_cpu(new_index->index.hash);
+		break;
+
+	default:
+		BUG();
+	}
+
+	ssdfs_memcpy(&node->raw.root_node.header.node_ids[found_index],
+		     0, sizeof(__le32),
+		     &new_index->node_id, 0, sizeof(__le32),
+		     sizeof(__le32));
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_change_index() - change index record into common node
+ * @node: node object
+ * @found_index: position in the node of the changing index record
+ * @new_index: pointer on new index record state [in]
+ *
+ * This method tries to change the index record into the common node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_common_node_change_index(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u16 found_index,
+				    struct ssdfs_btree_index_key *new_index)
+{
+	struct page *page;
+	size_t index_key_len = sizeof(struct ssdfs_btree_index_key);
+	u32 page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, found_index %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  found_index);
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(new_index->node_id),
+		  new_index->node_type,
+		  le64_to_cpu(new_index->index.hash),
+		  le64_to_cpu(new_index->index.extent.seg_id),
+		  le32_to_cpu(new_index->index.extent.logical_blk),
+		  le32_to_cpu(new_index->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (found_index == area->index_count) {
+		SSDFS_ERR("found_index %u == index_count %u\n",
+			  found_index, area->index_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_memory_page(node, area, found_index,
+					&page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "node_id %u, found_index %u, err %d\n",
+			  node->node_id, found_index, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+	err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+				   new_index, 0, index_key_len,
+				   index_key_len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	if (found_index == 0)
+		area->start_hash = le64_to_cpu(new_index->index.hash);
+	else if (found_index == (area->index_count - 1))
+		area->end_hash = le64_to_cpu(new_index->index.hash);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_insert_index() - insert index record into the node
+ * @node: node object
+ * @position: position in the node for storing the new index record
+ * @ptr: pointer on storing index record [in]
+ *
+ * This method tries to insert the index record into the common node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_common_node_insert_index(struct ssdfs_btree_node *node,
+					 u16 position,
+					 struct ssdfs_btree_index_key *ptr)
+{
+	struct ssdfs_btree_index_key buffer[2];
+	struct page *page;
+	void *kaddr;
+	u32 page_index;
+	u32 page_off;
+	u16 cur_pos = position;
+	u8 index_size;
+	bool is_valid_index_in_buffer = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u\n",
+		  node->node_id, position);
+	SSDFS_DBG("node_id %u, node_type %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(ptr->node_id),
+		  ptr->node_type,
+		  le64_to_cpu(ptr->index.hash),
+		  le64_to_cpu(ptr->index.extent.seg_id),
+		  le32_to_cpu(ptr->index.extent.logical_blk),
+		  le32_to_cpu(ptr->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(position < node->index_area.index_count)) {
+		SSDFS_ERR("cannot insert index: "
+			  "position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	index_size = node->index_area.index_size;
+	if (index_size != sizeof(struct ssdfs_btree_index_key)) {
+		SSDFS_ERR("invalid index_size %u\n",
+			  index_size);
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&buffer[0], 0, index_size,
+		     ptr, 0, index_size,
+		     index_size);
+
+	do {
+		u32 rest_capacity;
+		u32 moving_count;
+		u32 moving_bytes;
+
+		if (cur_pos > node->index_area.index_count) {
+			SSDFS_ERR("cur_pos %u, index_area.index_count %u\n",
+				  cur_pos, node->index_area.index_count);
+			return -ERANGE;
+		}
+
+		err = ssdfs_define_memory_page(node, &node->index_area,
+						cur_pos,
+						&page_index, &page_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define memory page: "
+				  "node_id %u, position %u, err %d\n",
+				  node->node_id, cur_pos, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(page_index >= U32_MAX);
+		BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		rest_capacity = PAGE_SIZE - page_off;
+		rest_capacity /= index_size;
+
+		if (rest_capacity == 0) {
+			SSDFS_WARN("rest_capacity == 0\n");
+			return -ERANGE;
+		}
+
+		moving_count = node->index_area.index_count - cur_pos;
+		moving_count = min_t(u32, moving_count, rest_capacity);
+
+		if (moving_count == rest_capacity) {
+			/*
+			 * Latest item will be moved into
+			 * temporary buffer (exclude from count)
+			 */
+			moving_bytes = (moving_count - 1) * index_size;
+		} else
+			moving_bytes = moving_count * index_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %u, page_off %u, cur_pos %u, "
+			  "moving_count %u, rest_capacity %u\n",
+			  page_index, page_off, cur_pos,
+			  moving_count, rest_capacity);
+
+		if ((page_off + index_size) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "page_off %u, index_size %u\n",
+				   page_off, index_size);
+			return -ERANGE;
+		}
+
+		if ((page_off + moving_bytes + index_size) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "page_off %u, moving_bytes %u, "
+				   "index_size %u\n",
+				   page_off, moving_bytes, index_size);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("page_index %u > pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		page = node->content.pvec.pages[page_index];
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+
+		if (moving_count == 0) {
+			err = ssdfs_memcpy(kaddr, page_off, PAGE_SIZE,
+					   &buffer[0], 0, index_size,
+					   index_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				goto finish_copy;
+			}
+
+			is_valid_index_in_buffer = false;
+			cur_pos++;
+		} else {
+			if (moving_count == rest_capacity) {
+				err = ssdfs_memcpy(&buffer[1],
+						   0, index_size,
+						   kaddr,
+						   PAGE_SIZE - index_size,
+						   PAGE_SIZE,
+						   index_size);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to copy: err %d\n",
+						  err);
+					goto finish_copy;
+				}
+
+				is_valid_index_in_buffer = true;
+			} else
+				is_valid_index_in_buffer = false;
+
+			err = ssdfs_memmove(kaddr,
+					    page_off + index_size,
+					    PAGE_SIZE,
+					    kaddr,
+					    page_off,
+					    PAGE_SIZE,
+					    moving_bytes);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n",
+					  err);
+				goto finish_copy;
+			}
+
+			err = ssdfs_memcpy(kaddr, page_off, PAGE_SIZE,
+					   &buffer[0], 0, index_size,
+					   index_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n",
+					  err);
+				goto finish_copy;
+			}
+
+			if (is_valid_index_in_buffer) {
+				ssdfs_memcpy(&buffer[0], 0, index_size,
+					     &buffer[1], 0, index_size,
+					     index_size);
+			}
+
+			cur_pos += moving_count;
+		}
+
+finish_copy:
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_pos %u, index_area.index_count %u, "
+			  "is_valid_index_in_buffer %#x\n",
+			  cur_pos, node->index_area.index_count,
+			  is_valid_index_in_buffer);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err)) {
+			SSDFS_ERR("cur_pos %u, index_area.index_count %u, "
+				  "is_valid_index_in_buffer %#x\n",
+				  cur_pos, node->index_area.index_count,
+				  is_valid_index_in_buffer);
+			return err;
+		}
+	} while (is_valid_index_in_buffer);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_add_index() - add index record into the node
+ * @node: node object
+ * @position: position in the node for storing the new index record
+ * @ptr: pointer on storing index record [in]
+ *
+ * This method tries to add the index record into the common node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free space.
+ */
+static
+int ssdfs_btree_common_node_add_index(struct ssdfs_btree_node *node,
+				      u16 position,
+				      struct ssdfs_btree_index_key *ptr)
+{
+	struct ssdfs_btree_index_key tmp_key;
+	u64 hash1, hash2;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u, index_count %u\n",
+		  node->node_id, position,
+		  node->index_area.index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->index_area.index_count > node->index_area.index_capacity) {
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+		return -ERANGE;
+	}
+
+	if (node->index_area.index_count == node->index_area.index_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add the index: "
+			  "index_count %u, index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	if (position > node->index_area.index_count) {
+		SSDFS_ERR("invalid index place: "
+			  "position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	if (position == node->index_area.index_count) {
+		err = __ssdfs_btree_common_node_add_index(node, position, ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add index: "
+				  "node_id %u, position %u, err %d\n",
+				  node->node_id, position, err);
+			return err;
+		}
+
+		node->index_area.index_count++;
+	} else {
+		err = __ssdfs_btree_common_node_extract_index(node,
+							      &node->index_area,
+							      position,
+							      &tmp_key);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the index: err %d\n", err);
+			return err;
+		}
+
+		hash1 = le64_to_cpu(tmp_key.index.hash);
+		hash2 = le64_to_cpu(ptr->index.hash);
+
+		if (hash1 == hash2) {
+			err = ssdfs_btree_common_node_change_index(node,
+							&node->index_area,
+							position,
+							ptr);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change index: "
+					  "node_id %u, position %u, err %d\n",
+					  node->node_id, position, err);
+				return err;
+			}
+		} else {
+			if (hash2 > hash1)
+				position++;
+
+			if (position == node->index_area.index_count) {
+				err = __ssdfs_btree_common_node_add_index(node,
+								    position,
+								    ptr);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to add index: "
+						  "node_id %u, position %u, "
+						  "err %d\n",
+						  node->node_id, position, err);
+					return err;
+				}
+			} else {
+				err = ssdfs_btree_common_node_insert_index(node,
+								    position,
+								    ptr);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to insert index: "
+						  "node_id %u, position %u, "
+						  "err %d\n",
+						  node->node_id, position, err);
+					return err;
+				}
+			}
+
+			node->index_area.index_count++;
+		}
+	}
+
+	err = __ssdfs_btree_common_node_extract_index(node,
+						      &node->index_area,
+						      0,
+						      &tmp_key);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the index: err %d\n", err);
+		return err;
+	}
+
+	node->index_area.start_hash = le64_to_cpu(tmp_key.index.hash);
+
+	err = __ssdfs_btree_common_node_extract_index(node,
+					&node->index_area,
+					node->index_area.index_count - 1,
+					&tmp_key);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the index: err %d\n", err);
+		return err;
+	}
+
+	node->index_area.end_hash = le64_to_cpu(tmp_key.index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "index_count %u, index_capacity %u\n",
+		  node->index_area.start_hash,
+		  node->index_area.end_hash,
+		  node->index_area.index_count,
+		  node->index_area.index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_add_index() - add index into node's index area
+ * @node: node object
+ * @index: new index
+ *
+ * This method tries to insert the index into node's index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - index area hasn't free space.
+ * %-ENOENT     - node hasn't the index area.
+ * %-EFAULT     - corrupted index or node's index area.
+ * %-EACCES     - node is under initialization yet.
+ */
+int ssdfs_btree_node_add_index(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_index_key *index)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 hash;
+	int node_type;
+	u16 found = U16_MAX;
+	u16 count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi || !index);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hash = le64_to_cpu(index->index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, hash %llx\n",
+		  node->node_id, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (hash == U64_MAX) {
+		SSDFS_ERR("invalid hash %llx\n", hash);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node_type = atomic_read(&node->type);
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  node_type);
+		return -ERANGE;
+	}
+
+	if (!can_add_new_index(node)) {
+		u32 new_size;
+
+		down_read(&node->header_lock);
+		new_size = node->index_area.area_size * 2;
+		up_read(&node->header_lock);
+
+		err = ssdfs_btree_node_resize_index_area(node, new_size);
+		if (err == -EACCES) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node %u is under initialization\n",
+				  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index area cannot be resized: "
+				  "node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to resize index area: "
+				  "node_id %u, new_size %u, err %d\n",
+				  node->node_id, new_size, err);
+			return err;
+		}
+	}
+
+	if (node_type == SSDFS_BTREE_ROOT_NODE) {
+		down_read(&node->full_lock);
+		down_write(&node->header_lock);
+
+		err = ssdfs_find_index_by_hash(node, &node->index_area,
+						hash, &found);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -ENODATA) {
+			/* node hasn't any index */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find an index: "
+				  "node_id %u, hash %llx, err %d\n",
+				  node->node_id, hash, err);
+			goto finish_change_root_node;
+		}
+
+		err = ssdfs_btree_root_node_add_index(node, found,
+							index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change index: "
+				  "node_id %u, node_type %#x, "
+				  "found_index %u, err %d\n",
+				  node->node_id, node_type,
+				  found, err);
+		}
+
+finish_change_root_node:
+		up_write(&node->header_lock);
+		up_read(&node->full_lock);
+
+		if (unlikely(err)) {
+			ssdfs_debug_show_btree_node_indexes(node->tree, node);
+			return err;
+		}
+	} else {
+		down_write(&node->full_lock);
+		down_write(&node->header_lock);
+
+		err = ssdfs_find_index_by_hash(node, &node->index_area,
+						hash, &found);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -EEXIST) {
+			/* index exist already */
+			err = 0;
+		} else if (err == -ENODATA) {
+			/* node hasn't any index */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find an index: "
+				  "node_id %u, hash %llx, err %d\n",
+				  node->node_id, hash, err);
+			up_write(&node->header_lock);
+			up_write(&node->full_lock);
+			return err;
+		}
+
+		count = (node->index_area.index_count + 1) - found;
+		err = ssdfs_lock_index_range(node, found, count);
+		BUG_ON(err == -ENODATA);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock index range: "
+				  "start %u, count %u, err %d\n",
+				  found, count, err);
+			up_write(&node->header_lock);
+			up_write(&node->full_lock);
+			return err;
+		}
+
+		downgrade_write(&node->full_lock);
+
+		err = ssdfs_btree_common_node_add_index(node, found,
+							index);
+		ssdfs_unlock_index_range(node, found, count);
+
+		if (!err)
+			err = ssdfs_set_dirty_index_range(node, found, count);
+
+		up_write(&node->header_lock);
+		up_read(&node->full_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add index: "
+				  "node_id %u, node_type %#x, "
+				  "found_index %u, err %d\n",
+				  node->node_id, node_type,
+				  found, err);
+			ssdfs_debug_show_btree_node_indexes(node->tree, node);
+		}
+	}
+
+	ssdfs_set_node_update_cno(node);
+	set_ssdfs_btree_node_dirty(node);
+
+	return 0;
+}
+
+static inline
+bool is_ssdfs_btree_index_key_identical(struct ssdfs_btree_index_key *index1,
+					struct ssdfs_btree_index_key *index2)
+{
+	u32 node_id1, node_id2;
+	u8 node_type1, node_type2;
+	u64 hash1, hash2;
+	u64 seg_id1, seg_id2;
+	u32 logical_blk1, logical_blk2;
+	u32 len1, len2;
+
+	node_id1 = le32_to_cpu(index1->node_id);
+	node_type1 = index1->node_type;
+	hash1 = le64_to_cpu(index1->index.hash);
+	seg_id1 = le64_to_cpu(index1->index.extent.seg_id);
+	logical_blk1 = le32_to_cpu(index1->index.extent.logical_blk);
+	len1 = le32_to_cpu(index1->index.extent.len);
+
+	node_id2 = le32_to_cpu(index2->node_id);
+	node_type2 = index2->node_type;
+	hash2 = le64_to_cpu(index2->index.hash);
+	seg_id2 = le64_to_cpu(index2->index.extent.seg_id);
+	logical_blk2 = le32_to_cpu(index2->index.extent.logical_blk);
+	len2 = le32_to_cpu(index2->index.extent.len);
+
+	return node_id1 == node_id2 && node_type1 == node_type2 &&
+		hash1 == hash2 && seg_id1 == seg_id2 &&
+		logical_blk1 == logical_blk2 && len1 == len2;
+}
+
+/*
+ * __ssdfs_btree_node_change_index() - change existing index
+ * @node: node object
+ * @old_index: old index
+ * @new_index: new index
+ *
+ * This method tries to change @old_index on @new_index into
+ * node's index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node's index area doesn't contain @old_index.
+ * %-ENOENT     - node hasn't the index area.
+ * %-EFAULT     - corrupted index or node's index area.
+ * %-EACCES     - node is under initialization yet.
+ */
+static
+int __ssdfs_btree_node_change_index(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_index_key *old_index,
+				    struct ssdfs_btree_index_key *new_index)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node_index_area area;
+	size_t desc_size = sizeof(struct ssdfs_btree_node_index_area);
+	int node_type;
+	u64 old_hash, new_hash;
+	u16 found = U16_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+	BUG_ON(!old_index || !new_index);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+	old_hash = le64_to_cpu(old_index->index.hash);
+	new_hash = le64_to_cpu(new_index->index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, old_hash %llx, new_hash %llx\n",
+		  node->node_id, old_hash, new_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (old_hash == U64_MAX || new_hash == U64_MAX) {
+		SSDFS_ERR("invalid old_hash %llx or new_hash %llx\n",
+			  old_hash, new_hash);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node_type = atomic_read(&node->type);
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  node_type);
+		return -ERANGE;
+	}
+
+	if (node_type == SSDFS_BTREE_ROOT_NODE) {
+		down_read(&node->full_lock);
+
+		err = ssdfs_find_index_by_hash(node, &node->index_area,
+						old_hash, &found);
+		if (err == -EEXIST) {
+			err = 0;
+			/*
+			 * Index has been found.
+			 * Continue logic.
+			 */
+		} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find an index: "
+				  "node_id %u, hash %llx\n",
+				  node->node_id, old_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_change_root_node;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find an index: "
+				  "node_id %u, hash %llx, err %d\n",
+				  node->node_id, old_hash, err);
+			goto finish_change_root_node;
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("no index for the hash %llx\n",
+				  old_hash);
+			goto finish_change_root_node;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		down_write(&node->header_lock);
+
+		err = ssdfs_btree_root_node_change_index(node, found,
+							 new_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change index: "
+				  "node_id %u, node_type %#x, "
+				  "found %u, err %d\n",
+				  node->node_id, node_type,
+				  found, err);
+		}
+
+		up_write(&node->header_lock);
+finish_change_root_node:
+		up_read(&node->full_lock);
+
+		if (unlikely(err))
+			return err;
+	} else {
+		down_read(&node->full_lock);
+
+		down_read(&node->header_lock);
+		ssdfs_memcpy(&area, 0, desc_size,
+			     &node->index_area, 0, desc_size,
+			     desc_size);
+		up_read(&node->header_lock);
+
+		err = ssdfs_find_index_by_hash(node, &area,
+						old_hash, &found);
+		if (err == -EEXIST) {
+			err = 0;
+			/*
+			 * Index has been found.
+			 * Continue logic.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find an index: "
+				  "node_id %u, hash %llx, err %d\n",
+				  node->node_id, old_hash, err);
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("no index for the hash %llx\n",
+				  old_hash);
+		}
+
+		up_read(&node->full_lock);
+
+		if (unlikely(err))
+			return err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		down_write(&node->full_lock);
+		down_write(&node->header_lock);
+
+		err = ssdfs_lock_index_range(node, found, 1);
+		BUG_ON(err == -ENODATA);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock index %u, err %d\n",
+				  found, err);
+			up_write(&node->header_lock);
+			up_write(&node->full_lock);
+			return err;
+		}
+
+		downgrade_write(&node->full_lock);
+
+		err = ssdfs_btree_common_node_change_index(node,
+							   &node->index_area,
+							   found, new_index);
+		ssdfs_unlock_index_range(node, found, 1);
+
+		if (!err)
+			err = ssdfs_set_dirty_index_range(node, found, 1);
+
+		up_write(&node->header_lock);
+		up_read(&node->full_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change index: "
+				  "node_id %u, node_type %#x, "
+				  "found %u, err %d\n",
+				  node->node_id, node_type,
+				  found, err);
+			return err;
+		}
+	}
+
+	ssdfs_set_node_update_cno(node);
+	set_ssdfs_btree_node_dirty(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_change_index() - change existing index
+ * @node: node object
+ * @old_index: old index
+ * @new_index: new index
+ *
+ * This method tries to change @old_index on @new_index into
+ * node's index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node's index area doesn't contain @old_index.
+ * %-ENOENT     - node hasn't the index area.
+ * %-EFAULT     - corrupted index or node's index area.
+ * %-EACCES     - node is under initialization yet.
+ */
+int ssdfs_btree_node_change_index(struct ssdfs_btree_node *node,
+				  struct ssdfs_btree_index_key *old_index,
+				  struct ssdfs_btree_index_key *new_index)
+{
+	u64 old_hash, new_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+	BUG_ON(!old_index || !new_index);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	old_hash = le64_to_cpu(old_index->index.hash);
+	new_hash = le64_to_cpu(new_index->index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, old_hash %llx, new_hash %llx\n",
+		  node->node_id, old_hash, new_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (old_hash == U64_MAX || new_hash == U64_MAX) {
+		SSDFS_ERR("invalid old_hash %llx or new_hash %llx\n",
+			  old_hash, new_hash);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_ssdfs_btree_index_key_identical(old_index, new_index)) {
+		SSDFS_DBG("old and new index are identical\n");
+		return 0;
+	}
+
+	if (old_hash == new_hash) {
+		err = __ssdfs_btree_node_change_index(node, old_index,
+							new_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change index: "
+				  "old_hash %llx, err %d\n",
+				  old_hash, err);
+			goto fail_change_index;
+		}
+	} else {
+		err = ssdfs_btree_node_delete_index(node, old_hash);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete index: "
+				  "old_hash %llx, err %d\n",
+				  old_hash, err);
+			goto fail_change_index;
+		}
+
+		err = ssdfs_btree_node_add_index(node, new_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add index: "
+				  "new_hash %llx, err %d\n",
+				  new_hash, err);
+			goto fail_change_index;
+		}
+	}
+
+	return 0;
+
+fail_change_index:
+	SSDFS_ERR("node_id %u, node_type %#x\n",
+		  node->node_id,
+		  atomic_read(&node->type));
+	SSDFS_ERR("node_id %u, node_type %#x, old_hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(old_index->node_id),
+		  old_index->node_type,
+		  le64_to_cpu(old_index->index.hash),
+		  le64_to_cpu(old_index->index.extent.seg_id),
+		  le32_to_cpu(old_index->index.extent.logical_blk),
+		  le32_to_cpu(old_index->index.extent.len));
+	SSDFS_ERR("node_id %u, node_type %#x, new_hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(new_index->node_id),
+		  new_index->node_type,
+		  le64_to_cpu(new_index->index.hash),
+		  le64_to_cpu(new_index->index.extent.seg_id),
+		  le32_to_cpu(new_index->index.extent.logical_blk),
+		  le32_to_cpu(new_index->index.extent.len));
+
+	return err;
+}
-- 
2.34.1

