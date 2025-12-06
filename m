Return-Path: <linux-fsdevel+bounces-70942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC404CAA810
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75D4325A9A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61B2FE078;
	Sat,  6 Dec 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9wHiaWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444242288E3;
	Sat,  6 Dec 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029813; cv=none; b=GUHYsb0aC1eikcS2XH/DWIspSFSdkOh9d/ynbZsVX27VuZo5kmGZYUOIrbHMr0XLfRJp/xepCOFHMATv658bVBcPLC1WK6f/j4ba2kNAUQgRxT+dt/CGqyqFseizBTt89ZkLjkswUeXwfmiLUKW2MwpC/i3I5vqwmWpCn0/SS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029813; c=relaxed/simple;
	bh=BU48aj47LaVT2GtfEXAR7/fgZxBcYSX6omRpeqUQsq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlpq21y+LwK+cmcTldgYb1wmLi0JwOGv+DKMro6qSqgckbPvjrVCBpSqnCGIKkekCuLEGjNGw7d8gVdYyOUyLcTlYm5EXjTEFmtBFG4IkbE32fHDDAWF3QkGGnGXLxtddope5IqN1XjV+NEUHe9IOUrpHGWR24k7w7vQrr4Qp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9wHiaWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF9C113D0;
	Sat,  6 Dec 2025 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029812;
	bh=BU48aj47LaVT2GtfEXAR7/fgZxBcYSX6omRpeqUQsq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9wHiaWAvOkVVYxr6u77Kd9lDTf2+UOIBf7qVHYPG1wXkt4lF6/H92tPqQKKsX4UR
	 V0Lxdl3yy0XGa2dPeiOEEQ4m3HzAiL6KP7YCK46iHeI/tT7HXioGAQmA64637t33sf
	 huHSRKHCOZiVoKzYWQy4/W0F+dxf2FSXlOvjFtd81biG7ItuLjWRAlRkXe47Uuhq3k
	 7L8u/4WRDJZ7rXSLfjr2zToKRGOosbBVn4qdDZT80U5tIue+PRdBy9fm9tFhwNREVU
	 3X4c9MST0UXjrSkEcSDoFwEYfuitLtaJGEct2W7BEMdCT0tHBTqc5M8V0WcdhuC9fx
	 rEU1lHsuHxAqw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yang Chenzhi <yang.chenzhi@vivo.com>,
	syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create
Date: Sat,  6 Dec 2025 09:02:23 -0500
Message-ID: <20251206140252.645973-18-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206140252.645973-1-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Transfer-Encoding: 8bit

From: Yang Chenzhi <yang.chenzhi@vivo.com>

[ Upstream commit 152af114287851583cf7e0abc10129941f19466a ]

When sync() and link() are called concurrently, both threads may
enter hfs_bnode_find() without finding the node in the hash table
and proceed to create it.

Thread A:
  hfsplus_write_inode()
    -> hfsplus_write_system_inode()
      -> hfs_btree_write()
        -> hfs_bnode_find(tree, 0)
          -> __hfs_bnode_create(tree, 0)

Thread B:
  hfsplus_create_cat()
    -> hfs_brec_insert()
      -> hfs_bnode_split()
        -> hfs_bmap_alloc()
          -> hfs_bnode_find(tree, 0)
            -> __hfs_bnode_create(tree, 0)

In this case, thread A creates the bnode, sets refcnt=1, and hashes it.
Thread B also tries to create the same bnode, notices it has already
been inserted, drops its own instance, and uses the hashed one without
getting the node.

```

	node2 = hfs_bnode_findhash(tree, cnid);
	if (!node2) {                                 <- Thread A
		hash = hfs_bnode_hash(cnid);
		node->next_hash = tree->node_hash[hash];
		tree->node_hash[hash] = node;
		tree->node_hash_cnt++;
	} else {                                      <- Thread B
		spin_unlock(&tree->hash_lock);
		kfree(node);
		wait_event(node2->lock_wq,
			!test_bit(HFS_BNODE_NEW, &node2->flags));
		return node2;
	}
```

However, hfs_bnode_find() requires each call to take a reference.
Here both threads end up setting refcnt=1. When they later put the node,
this triggers:

BUG_ON(!atomic_read(&node->refcnt))

In this scenario, Thread B in fact finds the node in the hash table
rather than creating a new one, and thus must take a reference.

Fix this by calling hfs_bnode_get() when reusing a bnode newly created by
another thread to ensure the refcount is updated correctly.

A similar bug was fixed in HFS long ago in commit
a9dc087fd3c4 ("fix missing hfs_bnode_get() in __hfs_bnode_create")
but the same issue remained in HFS+ until now.

Reported-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com
Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20250829093912.611853-1-yang.chenzhi@vivo.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis Summary

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** "hfsplus: fix missing hfs_bnode_get() in
__hfs_bnode_create"

**Key signals:**
- Clear "fix" keyword indicating bug fix
- Reported-by syzbot - reproducible crash bug
- Detailed race condition explanation with call stacks
- References identical HFS fix from 2022 (commit a9dc087fd3c4)
- No explicit `Cc: stable` tag, but no `Fixes:` tag either since the bug
  exists from the file's creation

### 2. CODE CHANGE ANALYSIS

**The Bug:** When `sync()` and `link()` are called concurrently, both
threads may race into `__hfs_bnode_create()`:
- Thread A creates a bnode with `refcnt=1` and inserts it into the hash
  table
- Thread B finds the hash table entry, but returns the node **without
  incrementing refcnt**
- Both threads believe they own a reference, but only one reference
  exists
- When both call `hfs_bnode_put()`, the second call triggers:
  `BUG_ON(!atomic_read(&node->refcnt))`

**The Fix:** Single line addition at `fs/hfsplus/bnode.c:484`:
```c
} else {
+    hfs_bnode_get(node2);   // <-- Missing refcount increment added
     spin_unlock(&tree->hash_lock);
     kfree(node);
```

**Why it's correct:** `hfs_bnode_get()` simply does
`atomic_inc(&node->refcnt)` (line 658), ensuring correct reference
counting when reusing a shared bnode.

### 3. CLASSIFICATION

- **Bug fix:** YES - fixes a crash (BUG_ON kernel panic)
- **Feature addition:** NO
- **Security consideration:** Crash can be triggered by normal
  operations - potential DoS vector

### 4. SCOPE AND RISK ASSESSMENT

| Metric | Value |
|--------|-------|
| Lines changed | 1 |
| Files touched | 1 |
| Complexity | Very low |
| Subsystem | HFS+ filesystem |
| Regression risk | Very low |

The fix is a **single function call** that mirrors a proven fix from HFS
(commit a9dc087fd3c4) that has been stable since December 2022.

### 5. USER IMPACT

- **Affected users:** Anyone using HFS+ filesystems (common for Mac disk
  compatibility, external drives, dual-boot systems)
- **Trigger condition:** Concurrent sync() and link() operations - can
  occur in normal workloads
- **Severity:** **KERNEL CRASH** (BUG_ON triggers panic)

### 6. STABILITY INDICATORS

- **syzbot reported:** Bug is reproducible
- **Maintainer signed:** Yes (Viacheslav Dubeyko, HFS+ maintainer)
- **LKML link:** Present
- **Precedent:** Identical fix applied to HFS in 2022 with no
  regressions

### 7. DEPENDENCY CHECK

- **Dependencies:** None - completely self-contained
- **Applies to stable:** The affected code pattern has existed unchanged
  for many years in stable trees

## Final Assessment

**This commit should be backported to stable kernels.**

**Rationale:**
1. **Fixes a real crash** - BUG_ON triggers kernel panic in a
   reproducible race condition
2. **Minimal and surgical** - Single line change adding one function
   call
3. **Obviously correct** - Adds missing reference count increment,
   matching HFS pattern
4. **Proven safe** - Identical fix in HFS has been stable for 2+ years
5. **No dependencies** - Will apply cleanly to all stable kernels
6. **Real user impact** - HFS+ is commonly used for Mac disk
   compatibility

The lack of explicit `Cc: stable` tag does not preclude backporting when
all other stable criteria are clearly met. This is a textbook case of a
small, obviously correct fix for a real crash bug.

**YES**

 fs/hfsplus/bnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index edf7e27e1e375..482a6c5faa197 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -481,6 +481,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		tree->node_hash[hash] = node;
 		tree->node_hash_cnt++;
 	} else {
+		hfs_bnode_get(node2);
 		spin_unlock(&tree->hash_lock);
 		kfree(node);
 		wait_event(node2->lock_wq,
-- 
2.51.0


