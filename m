Return-Path: <linux-fsdevel+bounces-70990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D8CAE891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 01:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4544C30FF023
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 00:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFC285061;
	Tue,  9 Dec 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smGA6bCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41C283683;
	Tue,  9 Dec 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239469; cv=none; b=mswMfssVo4Jw9Go7o8sjLUmcVfPeczD5SEguaPluuQyVxKaWKQdPytFMEu8hpdeyHU8IneSrmOgotOliBP0tFaBHeR/eOk7qwxc1jIuuu+30PqQhwJERlbgZDKJMh4SCH547hkDMSLgyl9EIc4hBIgmfkrhqmzl4jrwFhQcvGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239469; c=relaxed/simple;
	bh=gud9IkW3b4vImZq0AZvIY1/XYW3RXkcue78EKo1eToc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMLL9ig9yma7W7jUGPGUtUjUtRBtrQXiaNGwEdqyYm+tW92caJU/3bma8/wYH18q9hekFEqq/W1RdeTMnZ5G+XYhH0O4Ylopk+RQdqDmvNB/C6FwhBcXRvPo71fkXEZ4Eq3uqHXbNPvtO6GFbRPc7R/blYHlsD8f0L91xxNpLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smGA6bCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D41C113D0;
	Tue,  9 Dec 2025 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239469;
	bh=gud9IkW3b4vImZq0AZvIY1/XYW3RXkcue78EKo1eToc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smGA6bCqf0jLGtpHGnl8cvQUiJCVfAi3vUqN6XAeMcQcKZm0Cr5LLEXRkP43IfG1g
	 jh/6PGdhsOJwLoW5qwLi8DB9T+Hd1dXUlaUfvlw1Ba8eLCxGMRVtP8wihCgm+c5hU7
	 1Dl9oPgGua8JZ1QPaynfXGq36aZOaxLYimBXm0tc1WYTm7pb8SYu2KirNJJIWqxE+P
	 FvVqe2L+6sbg21JSTCeox9X1W2UidQki5jv/1zqam9n1ZPqrowM7CA9uWtIX6hag2d
	 kVgPvxRnewHcOp/5ZakGc76g+5Q2tRcG33M+8PB+T/2dzeTZQm5hUE0QUHuqoGjE1j
	 7/XrsJ0Dd8cHg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.18-5.10] hfsplus: fix volume corruption issue for generic/070
Date: Mon,  8 Dec 2025 19:15:22 -0500
Message-ID: <20251209001610.611575-30-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit ed490f36f439b877393c12a2113601e4145a5a56 ]

The xfstests' test-case generic/070 leaves HFS+ volume
in corrupted state:

sudo ./check generic/070
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC Wed Oct 1 15:02:44 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/070 _check_generic_filesystem: filesystem on /dev/loop50 is inconsistent
(see xfstests-dev/results//generic/070.full for details)

Ran: generic/070
Failures: generic/070
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop50
** /dev/loop50
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is test
** Checking extents overflow file.
Unused node is not erased (node = 1)
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0004
CBTStat = 0x0000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is test
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume test was repaired successfully.

It is possible to see that fsck.hfsplus detected not
erased and unused node for the case of extents overflow file.
The HFS+ logic has special method that defines if the node
should be erased:

bool hfs_bnode_need_zeroout(struct hfs_btree *tree)
{
	struct super_block *sb = tree->inode->i_sb;
	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
	const u32 volume_attr = be32_to_cpu(sbi->s_vhdr->attributes);

	return tree->cnid == HFSPLUS_CAT_CNID &&
		volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
}

However, it is possible to see that this method works
only for the case of catalog file. But debugging of the issue
has shown that HFSPLUS_VOL_UNUSED_NODE_FIX attribute has been
requested for the extents overflow file too:

catalog file
kernel: hfsplus: node 4, num_recs 0, flags 0x10
kernel: hfsplus: tree->cnid 4, volume_attr 0x80000800

extents overflow file
kernel: hfsplus: node 1, num_recs 0, flags 0x10
kernel: hfsplus: tree->cnid 3, volume_attr 0x80000800

This patch modifies the hfs_bnode_need_zeroout() by checking
only volume_attr but not the b-tree ID because node zeroing
can be requested for all HFS+ b-tree types.

sudo ./check generic/070
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #79 SMP PREEMPT_DYNAMIC Fri Oct 31 16:07:42 PDT 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/070 33s ...  34s
Ran: generic/070
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251101001229.247432-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Final Assessment

### Summary of Findings

**Bug Type**: Filesystem corruption (data integrity issue)

**Technical Root Cause**: The `hfs_bnode_need_zeroout()` function
incorrectly restricts unused node zeroing to only the catalog B-tree
(HFSPLUS_CAT_CNID). However, when the volume attribute
`HFSPLUS_VOL_UNUSED_NODE_FIX` is set, it applies to ALL HFS+ B-tree
types including the extents overflow file. This causes fsck.hfsplus to
detect corruption: "Unused node is not erased (node = 1)".

**The Fix**: Removes the catalog-only check, allowing node zeroing for
all B-tree types when the volume attribute is set.

### Stable Kernel Criteria Evaluation

| Criterion | Status |
|-----------|--------|
| Fixes real bug | ✅ Filesystem corruption verified by fsck |
| Obviously correct | ✅ Simple condition removal, matches Apple spec |
| Small and contained | ✅ 1 line change, single file |
| No new features | ✅ No new functionality added |
| Tested | ✅ xfstests generic/070 passes |
| Exists in stable | ✅ Function introduced in kernel 3.16 (2014) |

### Risk vs Benefit

**Risk**: Very LOW
- The change makes code more conservative (zeros more nodes, not fewer)
- Only two call sites, both appropriately handle the result
- No new code paths, just relaxing an incorrect restriction

**Benefit**: HIGH
- Fixes filesystem corruption that users can actually hit
- Reproducible with standard xfstests suite
- Prevents data integrity issues on HFS+ volumes

### Concerns

1. **No explicit stable tags**: Missing "Cc: stable" and "Fixes:" tags.
   However, filesystem corruption fixes are exactly what stable is for.

2. **Stale comment**: The comment still says "if this is the catalog
   tree" but this is documentation debt, not a functional issue.

3. **Limited user base**: HFS+ is less commonly used on Linux than other
   filesystems, but users who do use it deserve working support.

### Conclusion

This commit fixes a real, reproducible filesystem corruption issue with
an extremely small, safe change. The fix is obviously correct - it
aligns behavior with the HFS+ specification where
`HFSPLUS_VOL_UNUSED_NODE_FIX` applies to all B-trees, not just the
catalog. The change is conservative (does more work, not less)
minimizing regression risk. The affected code has existed since kernel
3.16, making it applicable to all active stable trees.

Despite the missing explicit stable tags, this is clearly appropriate
stable material - a surgical fix for data corruption that meets all the
technical criteria.

**YES**

 fs/hfsplus/bnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 63768cf0cb1ba..482a6c5faa197 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -705,6 +705,5 @@ bool hfs_bnode_need_zeroout(struct hfs_btree *tree)
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	const u32 volume_attr = be32_to_cpu(sbi->s_vhdr->attributes);
 
-	return tree->cnid == HFSPLUS_CAT_CNID &&
-		volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
+	return volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
 }
-- 
2.51.0


