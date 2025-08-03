Return-Path: <linux-fsdevel+bounces-56599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C88B19641
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D833B6DAC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A6214814;
	Sun,  3 Aug 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDJISYK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFA2CCC0;
	Sun,  3 Aug 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256148; cv=none; b=E/Z34M2NZuwSjXWl4Z7rNfDpb+8x0a+Zn7BlQZerF/Yb0equpbX+Nb6o8hA1vBbNuwGAc9gPS3d4WtrlBHn2cFZi8f3XK5ZDSLZMWZkpXhh/QTG0hCacJBm/Z5bRNWaZa29sbbo7YM3l36BZ+FwNiG9WQoFrv3utB5tyF9Ni4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256148; c=relaxed/simple;
	bh=Xz0qXBXassRqVnxlrXrAVFGa0XgFnmgYBvILCHLENWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSDAeJqfkRqPfHvQnk/dwpuVJLi0I8JRw4R4dM6XgHUBCgrjmorW9Tdt3LrtDlfou6aDfqysnPDzD6XcTfZw0LCFQhVV76bA0rszjoqe3a0ayhJPcEDjQ/PLXF6KMGhGLIVAalMwIC7CRVDa42RCifsN1dvt3/1GgnAy0muL4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDJISYK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165A5C4CEEB;
	Sun,  3 Aug 2025 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256148;
	bh=Xz0qXBXassRqVnxlrXrAVFGa0XgFnmgYBvILCHLENWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDJISYK4dK6PEzbAyke7B36Zo5dI6OslWYlALfJve6CJqtqlJpVxVazgyCSZAEK1y
	 sxG3Aq1QeBqA7eeRJcemDBin5AX5kVCI6EgX+lwStbTPEB6WBa1Oo9TFGgLsYIiVzh
	 1PsS0IOuNZ1QJp5Ya049b9pD12ZVAlC6NLRNHfe3n17jWzFUlHTv4QG3It3JZC779a
	 ynQuqh85wxEPC1a9mhpchEZSNvk9f6CMxjlAB6C8igwJeleOuq49VJgpCGa6InQAHl
	 SNWcA1SGuyH3ZjUmYwGsmio0fx3vBp6Uo+r36TytTnJvS/Pa2ViRJPOh6V+MMKKB+d
	 awDcM8Igyjzgw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/15] hfs: fix not erasing deleted b-tree node issue
Date: Sun,  3 Aug 2025 17:21:59 -0400
Message-Id: <20250803212206.3548990-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212206.3548990-1-sashal@kernel.org>
References: <20250803212206.3548990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit d3ed6d6981f4756f145766753c872482bc3b28d3 ]

The generic/001 test of xfstests suite fails and corrupts
the HFS volume:

sudo ./check generic/001
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc2+ #3 SMP PREEMPT_DYNAMIC Fri Apr 25 17:13:00 PDT 2>
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/001 32s ... _check_generic_filesystem: filesystem on /dev/loop50 is inconsistent
(see /home/slavad/XFSTESTS-2/xfstests-dev/results//generic/001.full for details)

Ran: generic/001
Failures: generic/001
Failed 1 of 1 tests

fsck.hfs -d -n ./test-image.bin
** ./test-image.bin (NO WRITE)
	Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
   Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
   Unused node is not erased (node = 2)
   Unused node is not erased (node = 4)
<skipped>
   Unused node is not erased (node = 253)
   Unused node is not erased (node = 254)
   Unused node is not erased (node = 255)
   Unused node is not erased (node = 256)
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
   Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
                  CBTStat = 0x0004 CatStat = 0x00000000
** The volume untitled was found corrupt and needs to be repaired.
	volume type is HFS
	primary MDB is at block 2 0x02
	alternate MDB is at block 20971518 0x13ffffe
	primary VHB is at block 0 0x00
	alternate VHB is at block 0 0x00
	sector size = 512 0x200
	VolumeObject flags = 0x19
	total sectors for volume = 20971520 0x1400000
	total sectors for embedded volume = 0 0x00

This patch adds logic of clearing the deleted b-tree node.

sudo ./check generic/001
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc2+ #3 SMP PREEMPT_DYNAMIC Fri Apr 25 17:13:00 PDT 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/001 9s ...  32s
Ran: generic/001
Passed all 1 tests

fsck.hfs -d -n ./test-image.bin
** ./test-image.bin (NO WRITE)
	Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
   Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled appears to be OK.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20250430001211.1912533-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and the surrounding code, I can now
provide a determination on whether this should be backported to stable
kernel trees.

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real bug that causes filesystem corruption**: The commit
   fixes a bug where deleted b-tree nodes in HFS filesystems are not
   properly erased, leading to filesystem corruption that is detected by
   fsck.hfs. The commit message shows clear evidence of filesystem
   corruption with "Unused node is not erased" errors across multiple
   nodes (2, 4, 253-256).

2. **Small and contained fix**: The patch is only 1 line of code
   addition (`hfs_bnode_clear(node, 0, tree->node_size);`), well within
   the 100-line stable tree limit. The fix is localized to the HFS
   b-tree node management code and doesn't affect other subsystems.

3. **Obviously correct**: The fix adds a missing step that already
   exists in the HFS+ implementation. Looking at
   fs/hfsplus/bnode.c:728-729, the HFS+ code already calls
   `hfs_bnode_clear()` when deleting b-tree nodes (conditionally based
   on a volume attribute). The HFS code was missing this critical step
   entirely.

4. **Tested with concrete results**: The commit message includes before
   and after test results using xfstests generic/001, showing that the
   filesystem corruption is resolved after applying the patch. The
   "after" test shows "The volume untitled appears to be OK" from
   fsck.hfs.

5. **Data corruption prevention**: Without this fix, HFS filesystems can
   become corrupted during normal operations that involve b-tree node
   deletion, potentially leading to data loss. This is a serious issue
   that affects filesystem integrity.

6. **No architectural changes**: The commit doesn't introduce any new
   features or architectural changes - it simply adds a missing cleanup
   step that should have been there all along.

7. **Low regression risk**: The `hfs_bnode_clear()` function being
   called already exists and is used elsewhere in the HFS code. The fix
   follows the established pattern from HFS+ and uses existing, tested
   infrastructure.

The commit meets all the stable kernel rules criteria: it fixes a real
bug that causes filesystem corruption, is small and contained, is
obviously correct (matches HFS+ implementation), and has been tested to
resolve the issue.

 fs/hfs/bnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 2039cb6d5f66..219e3b8fd6a8 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -586,6 +586,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		if (test_bit(HFS_BNODE_DELETED, &node->flags)) {
 			hfs_bnode_unhash(node);
 			spin_unlock(&tree->hash_lock);
+			hfs_bnode_clear(node, 0, tree->node_size);
 			hfs_bmap_free(node);
 			hfs_bnode_free(node);
 			return;
-- 
2.39.5


