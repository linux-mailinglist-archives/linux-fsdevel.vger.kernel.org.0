Return-Path: <linux-fsdevel+bounces-76909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFSUHOnAi2l6aQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:36:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E1120134
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D7630E0A10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85531282F;
	Tue, 10 Feb 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5W6J5nn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C053254B9;
	Tue, 10 Feb 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766313; cv=none; b=Qgsayti2xx5niB17LFQhKiObVi4pHpda9zlSeO75Klv/AaxunnIENoTjNtga8Ya046v9vJJuR036cndcGEornaNFEjFvvWsEhcQZ82RNw8vSYllldt7Sjr1KHbvJWNoiZmAThrF2xT8ZMHMX9Fm6w8VZEtyL+1mI57wMQxKbp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766313; c=relaxed/simple;
	bh=c8fdoILi1srUUOcXtooQ1QwCVWLwYDzNdYRF9st0EK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrufydKHoHj0JfRnt+ic6igLC5Ab+6UMt+OGLDcuYm61Umy8/3gwWJY+twjRUEpbPfXlfE1024Y9s9dojHti192EJncnIn1RCeHc3KmGCYZp4gtO++OgYHxl7BpYYHdmCNagrHk4UorPKIhxQ4Hatm4iik95hoNX5CrZ0ubQt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5W6J5nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE67C116C6;
	Tue, 10 Feb 2026 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766313;
	bh=c8fdoILi1srUUOcXtooQ1QwCVWLwYDzNdYRF9st0EK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5W6J5nniFxeWydZjHO1OBNAUJlReVMRSRGjdxf6KZuDCorYYz+ZjW/DXridHzjqx
	 TS0JLkQSj6lodCDov1Ezx4tNWlyfPVRUlIXRUY/OffgkR5Nu9unKihE2IYjVwrQJcu
	 re7iSs8nOXDz6YeetzJ0EtC0aB4zJU7kBRIu5poInikZab7WQWoHIiH2Yq+6SfkyZT
	 7WHKO8826JetKppynPl4U54YiAXwxJ4KgONOm6URkAkNWmd9KiZLSdblWTERqwD1Tu
	 zww/0StcqspKLGty2r8iBFLqomoq+c/WR0nThbe24snAngvYoMIdxLorHccKfvDusP
	 mWEzEn/NDUh+A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.19-5.10] hfsplus: fix volume corruption issue for generic/498
Date: Tue, 10 Feb 2026 18:31:04 -0500
Message-ID: <20260210233123.2905307-19-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210233123.2905307-1-sashal@kernel.org>
References: <20260210233123.2905307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76909-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,dubeyko.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fu-berlin.de:email]
X-Rspamd-Queue-Id: 1D3E1120134
X-Rspamd-Action: no action

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 9a8c4ad44721da4c48e1ff240ac76286c82837fe ]

The xfstests' test-case generic/498 leaves HFS+ volume
in corrupted state:

sudo ./check generic/498
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #18 SMP PREEMPT_DYNAMIC Thu Dec 4 12:24:45 PST 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/498.full for details)

Ran: generic/498
Failures: generic/498
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
Invalid leaf record count
(It should be 16 instead of 2)
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x8000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The generic/498 test executes such steps on final phase:

mkdir $SCRATCH_MNT/A
mkdir $SCRATCH_MNT/B
mkdir $SCRATCH_MNT/A/C
touch $SCRATCH_MNT/B/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/B/foo

ln $SCRATCH_MNT/B/foo $SCRATCH_MNT/A/C/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/A

"Simulate a power failure and mount the filesystem
to check that what we explicitly fsync'ed exists."

_flakey_drop_and_remount

The FSCK tool complains about "Invalid leaf record count".
HFS+ b-tree header contains leaf_count field is updated
by hfs_brec_insert() and hfs_brec_remove(). The hfs_brec_insert()
is involved into hard link creation process. However,
modified in-core leaf_count field is stored into HFS+
b-tree header by hfs_btree_write() method. But,
unfortunately, hfs_btree_write() hasn't been called
by hfsplus_cat_write_inode() and hfsplus_file_fsync()
stores not fully consistent state of the Catalog File's
b-tree.

This patch adds calling hfs_btree_write() method in
the hfsplus_cat_write_inode() with the goal of
storing consistent state of Catalog File's b-tree.
Finally, it makes FSCK tool happy.

sudo ./check generic/498
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #22 SMP PREEMPT_DYNAMIC Sat Dec  6 17:01:31 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 33s ...  31s
Ran: generic/498
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251207035821.3863657-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Here is my detailed analysis:

---

## Commit Analysis: hfsplus: fix volume corruption issue for generic/498

### 1. The Bug: Filesystem Corruption After Power Failure

This commit fixes a **real volume corruption bug** in the HFS+
filesystem. The corruption occurs in a specific but realistic scenario:
creating a hard link, performing an fsync, then experiencing a power
failure. After recovery, `fsck.hfsplus` reports "Invalid leaf record
count" in the catalog b-tree header.

### 2. Root Cause Analysis

The bug involves a disconnect between in-memory btree metadata updates
and their persistence to disk:

**Step 1: `hfs_brec_insert()` updates `leaf_count` in memory only.**

```105:108:fs/hfsplus/brec.c
        if (node->type == HFS_NODE_LEAF) {
                tree->leaf_count++;
                mark_inode_dirty(tree->inode);
        }
```

When a hard link is created (e.g., `ln $SCRATCH_MNT/B/foo
$SCRATCH_MNT/A/C/foo`), `hfs_brec_insert()` is called on the catalog
b-tree. It increments `tree->leaf_count` in the in-memory `struct
hfs_btree` and calls `mark_inode_dirty(tree->inode)` to dirty the tree
inode — but it does NOT write the b-tree header record to disk.

**Step 2: `hfs_btree_write()` is what persists the header to disk.**

```283:311:fs/hfsplus/btree.c
int hfs_btree_write(struct hfs_btree *tree)
{
        // ... finds node 0 (header node), maps page ...
        head->leaf_count = cpu_to_be32(tree->leaf_count);
        // ... other header fields ...
        set_page_dirty(page);
        hfs_bnode_put(node);
        return 0;
}
```

This function serializes the in-memory btree metadata (including
`leaf_count`) to the header node's page and marks it dirty. This is the
**only** way the btree header gets updated on disk.

**Step 3: `hfsplus_cat_write_inode()` was NOT calling
`hfs_btree_write()`.**

Before this fix, `hfsplus_cat_write_inode()` (lines 612-691 in
`inode.c`) writes the catalog entry for a regular inode (folder/file
data, permissions, timestamps, etc.) but never flushes the btree header.
It sets `HFSPLUS_I_CAT_DIRTY`, which tells `hfsplus_file_fsync()` to
call `filemap_write_and_wait()` on the catalog tree's page cache — but
the header page was never dirtied in the first place.

**Step 4: The fsync path misses the btree header.**

In `hfsplus_file_fsync()`:

```339:345:fs/hfsplus/inode.c
        sync_inode_metadata(inode, 1);
        // ↑ This triggers hfsplus_write_inode() →
hfsplus_cat_write_inode()
        //   which writes the catalog ENTRY but NOT the btree HEADER

        if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags))
                error =
filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
        // ↑ This flushes dirty pages, but the header page isn't dirty!
```

**Step 5: Where it DID work — system inodes.**

For "system" inodes (the btree inodes themselves),
`hfsplus_system_write_inode()` in `super.c` DOES call
`hfs_btree_write()`:

```114:159:fs/hfsplus/super.c
// hfsplus_system_write_inode:
        if (tree) {
                int err = hfs_btree_write(tree);
                // ...
        }
```

But this path is only triggered during `hfsplus_sync_fs()` (full
filesystem sync), not during an individual file's fsync. So the btree
header only gets written on full sync, not on per-file fsync — creating
the corruption window.

### 3. The Fix

The fix adds `hfs_btree_write(tree)` to `hfsplus_cat_write_inode()`:

```diff
+       struct hfs_btree *tree = HFSPLUS_SB(inode->i_sb)->cat_tree;
        ...
- if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
+       if (hfs_find_init(tree, &fd))
        ...
        hfs_find_exit(&fd);
+
+       if (!res) {
+               res = hfs_btree_write(tree);
+               if (res) {
+                       pr_err("b-tree write err: %d, ino %lu\n",
+                              res, inode->i_ino);
+               }
+       }
+
        return res;
```

Now when `hfsplus_cat_write_inode()` runs (via `sync_inode_metadata`
during fsync), it also dirties the btree header page. When
`hfsplus_file_fsync()` then calls `filemap_write_and_wait()` on the
catalog tree's mapping, the header page (with the correct `leaf_count`)
gets flushed to disk. After power failure, the on-disk btree header
matches reality.

### 4. Scope and Risk Assessment

- **Lines changed**: ~10 lines added, 1 line modified (extracting `tree`
  variable)
- **Files changed**: 1 file (`fs/hfsplus/inode.c`)
- **Function affected**: `hfsplus_cat_write_inode()` only
- **Pattern**: Identical to `hfsplus_system_write_inode()` which already
  calls `hfs_btree_write()` for the same tree
- **Performance impact**: Minimal — `hfs_btree_write()` just writes to a
  cached page and marks it dirty; the actual I/O happens asynchronously
  or during the subsequent `filemap_write_and_wait()`
- **Risk of regression**: Very low — this makes the catalog inode write
  path consistent with the system inode write path

### 5. Dependency Analysis

This commit is **completely standalone**:
- `hfs_btree_write()` has existed since the early HFS+ implementation
- The `HFSPLUS_SB()->cat_tree` structure hasn't changed
- The `hfsplus_cat_write_inode()` function's structure is stable across
  kernel versions
- It does NOT depend on the companion fix `3f04ee216bc14` ("fix volume
  corruption issue for generic/101") which modified
  `hfsplus_file_fsync()` and `hfsplus_sync_fs()` — those are completely
  different functions
- The patch should apply cleanly to any recent stable tree

### 6. User Impact

- **Severity**: HIGH — this is **filesystem/volume corruption** (data
  integrity)
- **Trigger**: Any operation that modifies the catalog btree leaf count
  (hard link creation/deletion) followed by fsync + power failure
- **Users affected**: Anyone using HFS+ filesystem (macOS interop,
  embedded systems, dual-boot scenarios)
- **Reproducibility**: 100% reproducible via xfstests generic/498

### 7. Classification

This is a clear **data corruption fix**:
- Fixes metadata inconsistency after crash recovery
- The bug has been present since the HFS+ driver was written (the btree
  header write was always missing from `hfsplus_cat_write_inode()`)
- Small, surgical fix using an established function
- No new features, APIs, or behavioral changes
- Zero risk to non-HFS+ users

The fix is small, surgical, and meets all stable kernel criteria.

**YES**

 fs/hfsplus/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c762bf909d1aa..6153e5cc6eb65 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -615,6 +615,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 int hfsplus_cat_write_inode(struct inode *inode)
 {
 	struct inode *main_inode = inode;
+	struct hfs_btree *tree = HFSPLUS_SB(inode->i_sb)->cat_tree;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int res = 0;
@@ -627,7 +628,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (!main_inode->i_nlink)
 		return 0;
 
-	if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
+	if (hfs_find_init(tree, &fd))
 		/* panic? */
 		return -EIO;
 
@@ -692,6 +693,15 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
+
+	if (!res) {
+		res = hfs_btree_write(tree);
+		if (res) {
+			pr_err("b-tree write err: %d, ino %lu\n",
+			       res, inode->i_ino);
+		}
+	}
+
 	return res;
 }
 
-- 
2.51.0


