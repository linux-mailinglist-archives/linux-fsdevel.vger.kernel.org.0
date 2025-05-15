Return-Path: <linux-fsdevel+bounces-49184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A1BAB902C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3691BC7EB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1A29B215;
	Thu, 15 May 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HliEL/40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0862980AB;
	Thu, 15 May 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338685; cv=none; b=HxWlUjz3WTwy67M1FAP69Wrn23WtL88u+jbnJ7sfxT8KG+wNqqNqrsW4Wo+jidYvksgq25GfCHZiQv6yNmmbjTeSUzFTk8LuPO2J8Z89iUV1h3sgtO4oBF6q47WOKiGkCZAtY1znSrx00JrxaHxeaL4rZRe52sfgFMY664axz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338685; c=relaxed/simple;
	bh=C0gZeooMIe0fTQD+RjGjw2VAanLF8tzxx2Gwk7UI/bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vac4IPVDd+fJMYYkWMhsDOAa+7avyAF6bfJ+fnQZH3KymLPHn4gFVmfJA1iynqFVvZAjb3SFtrLdPisdzm/IQieTfkWjLGwuZWNz+WQfa+mqMzPQY+4nwgQ7LemCnGR1Flop7TWD2JGa07keWZGs0FHOTOknnpsq7k3gryJm/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HliEL/40; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so1556306a91.3;
        Thu, 15 May 2025 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338682; x=1747943482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nluKVuFHURg2QHY/7qjIOapT7KabuvnMJZD455zw5lM=;
        b=HliEL/40IDqPJfEvUiahcJg+tZtW8rHG9OzHrgWNFM6b8xsLq94xjX25Vj+ebHdf2Z
         d8KgQXspKBNk+HANLLfVRiFRnMmgJZRP4+8iLQXbTWqw7orUEh2WQdJezd7rjwfRFZZD
         yYS8nyAf7gkNcwQ5VxxyBjT6gVW6CwrY3GmhSwd3iqtjyXN8hU7RMNIPW36BJe0NUo4A
         gdpjmXueeaP71MAFR1kbRKHBj9Nzq4FXwofpwQN6EHX9P1bYwhU9PF//JgbV60WIjJAm
         3UdixTSZYHkbmJuZsCWAGM5WQiWHQy2mN32Ew/K3ivXr1tiZA4q2cRN+7mnDrpS8G4Np
         ZLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338682; x=1747943482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nluKVuFHURg2QHY/7qjIOapT7KabuvnMJZD455zw5lM=;
        b=XkIoBhElHN/Jd+11uW7c5vbzq/cynvFxb9gjKzhW703wceSWn5BoO+XY+EEnyPK1mu
         tfjDYFPNbd2KdXtwjoe+okqBf8ZHal7KDk4hb7twAqI7bx1qp1pN9hna+/Pb7rUkUZgY
         Nv6EkuLzTphcss/6uhVLjIF/cQgo6VZIIVdMAhOX5VO77mUwXKI4nKgj8EsVjt42ck3r
         Sdyl8+DGxh1LWUKm/Jx87ejiS96eUIabTnAEn9z7YMcgIQM6TkSjgjQnLxQGAfu9cv78
         i+qWLQpgKfCbLWI8VszDeZOKshGEvbzefL76iIGiNgf9dwbueRcIC0zWbgz9U/kgHDdV
         u+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxyRVHPzAEZCWD9UbKHrnxRiFq1QFP0t9cLnGtFxqdBlWoXW2h2SkUnDmDKHETXiltkGSi5SU547L6pA2o@vger.kernel.org
X-Gm-Message-State: AOJu0YzatOH1X4d1OCFAjHr0u8+TwiUeIYeDU5qI/3nxarQGOZiNenL0
	eU2MIihuatKXi4viqXkly+fRNSqaHRCzkxDIyczTHz7zGC9n202qNk+DmQemcg==
X-Gm-Gg: ASbGnctXIqvlg3lUS2SrI0Tl52uK/o4Tc5o8iMBS8wEJVL5Mh7eEtKFFS3uExAbbIIx
	soUFJWwp77PIF79UfZkQnDZo+dwh44SwNDWCw9NqaC+rbCZ0B+q4wR7AxzlnQc+sdXmKTY27Jrk
	BTxvdWaPazw8aOChMhBQ34k/DKKuqwHR9mqNaehBkMTTKSu9pubOSX9CPTAxCgljQ9+9xj1xP0e
	MrEl/BmP1V9ENDlrgQgvf0RXj68+Px3ATsV/yWZovGDViMf5VTBIL2MRGXy0UcFjqwxr5whVUD8
	4JyzW0W46hoJjxQiDlOnloNwfTKwQqLqHbtzlClXUZeP4lA=
X-Google-Smtp-Source: AGHT+IECJDw+ClAyJT1OfRFjn8PFclTN0PyGd+JciYAdis80AH2j3K2Lv2AWRZLPMrWgvBwqxtNqnQ==
X-Received: by 2002:a17:90a:c88e:b0:30e:823f:ef27 with SMTP id 98e67ed59e1d1-30e823ff07cmr44591a91.33.1747338682073;
        Thu, 15 May 2025 12:51:22 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:21 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 4/7] ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
Date: Fri, 16 May 2025 01:20:52 +0530
Message-ID: <6bb563e661f5fbd80e266a9e6ce6e29178f555f6.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There can be a case where there are contiguous extents on the adjacent
leaf nodes of on-disk extent trees. So when someone tries to write to
this contiguous range, ext4_map_blocks() call will split by returning
1 extent at a time if this is not already cached in extent_status tree
cache (where if these extents when cached can get merged since they are
contiguous).

This is fine for a normal write however in case of atomic writes, it
can't afford to break the write into two. Now this is also something
that will only happen in the slow write case where we call
ext4_map_blocks() for each of these extents spread across different leaf
nodes. However, there is no guarantee that these extent status cache
cannot be reclaimed before the last call to ext4_map_blocks() in
ext4_map_blocks_atomic_write_slow().

Hence this patch adds support of EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.
This flag checks if the requested range can be fully found in extent
status cache and return. If not, it looks up in on-disk extent
tree via ext4_map_query_blocks(). If the found extent is the last entry
in the leaf node, then it goes and queries the next lblk to see if there
is an adjacent contiguous extent in the adjacent leaf node of the
on-disk extent tree.

Even though there can be a case where there are multiple adjacent extent
entries spread across multiple leaf nodes. But we only read an adjacent
leaf block i.e. in total of 2 extent entries spread across 2 leaf nodes.
The reason for this is that we are mostly only going to support atomic
writes with upto 64KB or maybe max upto 1MB of atomic write support.

Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    | 18 ++++++++-
 fs/ext4/extents.c | 12 ++++++
 fs/ext4/inode.c   | 97 +++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 115 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e2b36a3c1b0f..ef6cac6b4b4c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -256,9 +256,19 @@ struct ext4_allocation_request {
 #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
 #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
 #define EXT4_MAP_DELAYED	BIT(BH_Delay)
+/*
+ * This is for use in ext4_map_query_blocks() for a special case where we can
+ * have a physically and logically contiguous blocks split across two leaf
+ * nodes instead of a single extent. This is required in case of atomic writes
+ * to know whether the returned extent is last in leaf. If yes, then lookup for
+ * next in leaf block in ext4_map_query_blocks_next_in_leaf().
+ * - This is never going to be added to any buffer head state.
+ * - We use the next available bit after BH_BITMAP_UPTODATE.
+ */
+#define EXT4_MAP_QUERY_LAST_IN_LEAF	BIT(BH_BITMAP_UPTODATE + 1)
 #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
 				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
-				 EXT4_MAP_DELAYED)
+				 EXT4_MAP_DELAYED | EXT4_MAP_QUERY_LAST_IN_LEAF)
 
 struct ext4_map_blocks {
 	ext4_fsblk_t m_pblk;
@@ -725,6 +735,12 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+/*
+ * Atomic write caller needs this to query in the slow path of mixed mapping
+ * case, when a contiguous extent can be split across two adjacent leaf nodes.
+ * Look EXT4_MAP_QUERY_LAST_IN_LEAF.
+ */
+#define EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF	0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..fa850f188d46 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4433,6 +4433,18 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	allocated = map->m_len;
 	ext4_ext_show_leaf(inode, path);
 out:
+	/*
+	 * We never use EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF with CREATE flag.
+	 * So we know that the depth used here is correct, since there was no
+	 * block allocation done if EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF is set.
+	 * If tomorrow we start using this QUERY flag with CREATE, then we will
+	 * need to re-calculate the depth as it might have changed due to block
+	 * allocation.
+	 */
+	if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
+		if (!err && ex && (ex == EXT_LAST_EXTENT(path[depth].p_hdr)))
+			map->m_flags |= EXT4_MAP_QUERY_LAST_IN_LEAF;
+
 	ext4_free_ext_path(path);
 
 	trace_ext4_ext_map_blocks_exit(inode, flags, map,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2f99b087a5d8..8b86b1a29bdc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -459,14 +459,71 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
+			struct inode *inode, struct ext4_map_blocks *map,
+			unsigned int orig_mlen)
+{
+	struct ext4_map_blocks map2;
+	unsigned int status, status2;
+	int retval;
+
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+		EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+
+	WARN_ON_ONCE(!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF));
+	WARN_ON_ONCE(orig_mlen <= map->m_len);
+
+	/* Prepare map2 for lookup in next leaf block */
+	map2.m_lblk = map->m_lblk + map->m_len;
+	map2.m_len = orig_mlen - map->m_len;
+	map2.m_flags = 0;
+	retval = ext4_ext_map_blocks(handle, inode, &map2, 0);
+
+	if (retval <= 0) {
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status, false);
+		return map->m_len;
+	}
+
+	if (unlikely(retval != map2.m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode "
+			     "%lu: retval %d != map->m_len %d",
+			     inode->i_ino, retval, map2.m_len);
+		WARN_ON(1);
+	}
+
+	status2 = map2.m_flags & EXT4_MAP_UNWRITTEN ?
+		EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+
+	/*
+	 * If map2 is contiguous with map, then let's insert it as a single
+	 * extent in es cache and return the combined length of both the maps.
+	 */
+	if (map->m_pblk + map->m_len == map2.m_pblk &&
+			status == status2) {
+		ext4_es_insert_extent(inode, map->m_lblk,
+				      map->m_len + map2.m_len, map->m_pblk,
+				      status, false);
+		map->m_len += map2.m_len;
+	} else {
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status, false);
+	}
+
+	return map->m_len;
+}
+
 static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map)
+				 struct ext4_map_blocks *map, int flags)
 {
 	unsigned int status;
 	int retval;
+	unsigned int orig_mlen = map->m_len;
+	unsigned int query_flags = flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+		retval = ext4_ext_map_blocks(handle, inode, map, query_flags);
 	else
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
 
@@ -481,11 +538,23 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 		WARN_ON(1);
 	}
 
-	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-			      map->m_pblk, status, false);
-	return retval;
+	/*
+	 * No need to query next in leaf:
+	 * - if returned extent is not last in leaf or
+	 * - if the last in leaf is the full requested range
+	 */
+	if (!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) ||
+			((map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) &&
+			 (map->m_len == orig_mlen))) {
+		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status, false);
+		return retval;
+	}
+
+	return ext4_map_query_blocks_next_in_leaf(handle, inode, map,
+						  orig_mlen);
 }
 
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
@@ -599,6 +668,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	struct extent_status es;
 	int retval;
 	int ret = 0;
+	unsigned int orig_mlen = map->m_len;
 #ifdef ES_AGGRESSIVE_TEST
 	struct ext4_map_blocks orig_map;
 
@@ -650,7 +720,12 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_map_blocks_es_recheck(handle, inode, map,
 					   &orig_map, flags);
 #endif
-		goto found;
+		if (!(flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF) ||
+				orig_mlen == map->m_len)
+			goto found;
+
+		if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
+			map->m_len = orig_mlen;
 	}
 	/*
 	 * In the query cache no-wait mode, nothing we can do more if we
@@ -664,7 +739,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_query_blocks(handle, inode, map);
+	retval = ext4_map_query_blocks(handle, inode, map, flags);
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
@@ -1802,7 +1877,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	if (ext4_has_inline_data(inode))
 		retval = 0;
 	else
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, 0);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval < 0 ? retval : 0;
@@ -1825,7 +1900,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 			goto found;
 		}
 	} else if (!ext4_has_inline_data(inode)) {
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, 0);
 		if (retval) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			return retval < 0 ? retval : 0;
-- 
2.49.0


