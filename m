Return-Path: <linux-fsdevel+bounces-72200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991FCE7587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E099F3018308
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A48272801;
	Mon, 29 Dec 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1F7y4gfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1B347C6;
	Mon, 29 Dec 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025010; cv=none; b=Gwvwi4wsSIcF3104pps1qg7woqUKegLe2wgdbpqcpObPaxTtmJcJmjcsT3Wz4RVHnwhQG+2fyrsjh7f5PJo2I5Xl76zR4Q7e0dgyCTb3eI5kT4KYUsxmWOTjU44mWYKu2I5qZPok1MpEUuk9E0N9JBy3fzMVdKVIUorBgCGRd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025010; c=relaxed/simple;
	bh=bU5QnyOi+OgX+HxiYlRPqbdwcJNngANIwgva0PdD9+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jky3n6FGLVg72sjUda2ZONyejdqGMt7FLze2QAegsBE5MycFrRfIB40QBQ3x0PdkuTsxIjasmBEUu3ooMqabSh76lnbayECgiXT2TqXVPaELHgf5isPq7ZEsUWr1CBJ+2GHPpRxH0CSlBAqI3eczYnXksIg/y2QBqQ6m2F7dEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1F7y4gfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDCEC4CEF7;
	Mon, 29 Dec 2025 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025010;
	bh=bU5QnyOi+OgX+HxiYlRPqbdwcJNngANIwgva0PdD9+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1F7y4gfCAh4V7CeR4ba0vvw0YW1mPV3ci/UVDqUxCUR/MwJ823zq0a0jwC+Kenogu
	 /+atKkbuQAAfK5tK77mF4biKX/AWKb/RvGmtiwcSbGU/Fz/imeyg3YBujZHDG8fdE7
	 CMf/lwHeXMA/UfK+753I9XO6IxDRRbZowRwgBFKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 029/430] hfsplus: fix volume corruption issue for generic/070
Date: Mon, 29 Dec 2025 17:07:11 +0100
Message-ID: <20251229160725.232300460@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 fs/hfsplus/bnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 63e652ad1e0de..edf7e27e1e375 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -704,6 +704,5 @@ bool hfs_bnode_need_zeroout(struct hfs_btree *tree)
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	const u32 volume_attr = be32_to_cpu(sbi->s_vhdr->attributes);
 
-	return tree->cnid == HFSPLUS_CAT_CNID &&
-		volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
+	return volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
 }
-- 
2.51.0




