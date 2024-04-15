Return-Path: <linux-fsdevel+bounces-16981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2B8A5E82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B991F21620
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87215921E;
	Mon, 15 Apr 2024 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjYAdNcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370B156974;
	Mon, 15 Apr 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224402; cv=none; b=TQvruipoRbDP0aY+C/Aax9wYfs9RkZJGxpiPynGpWZ9Gj6kw5ya4+xBXdmrTSgAZ+ELrmsVI0zpZSIQmHu9i7iUE7Yj4y88UWXhB4KgfdsLCfFpbelpVq7UXDwqvsFodQ5VhkyDCdwUMez+liydOOcF4kzyiH0xp4fKy4j+5axY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224402; c=relaxed/simple;
	bh=4LAZNsV9CryhHV6r3RxmOqt9wS/YdVLz9e9t+G3PUA4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofx9610wFrpe9LcmCVk19Y3EfMkrF8pMN/sflZRVKKViCbYXU6oGx1BCOFTabwTPjfd/IUMxbkWHkJDw5WuOXEJo3RFs+2/MkYUi7HQ8+CNlkNF1JIqLOdhv9TGoiC5VMNpNC286tz13+c43iQyNu38IW6qh4ZtGAdTiqN1UUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjYAdNcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C1BC113CC;
	Mon, 15 Apr 2024 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224401;
	bh=4LAZNsV9CryhHV6r3RxmOqt9wS/YdVLz9e9t+G3PUA4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JjYAdNcciLMgE5FhjqVVmYRgvGYAQUWO1JlbOUzrTOnKbjyqyl5AoqCBvhijzwEuv
	 yxYKEhKiWvbNpbqJ8l1c6ceLdkIOpE8/MrBtsqjOERgCiItWSUpnlK2B6rRHDDp6+r
	 TSr/bLmdWjWvARnRlnTD+FseaQY/23HYDvJ+ysp8GeCNhVdRn34L8ZvD3xMGeZBej+
	 xJg/VIumuEgAqTqm86xExZHN6zDNcVJqMIfKkWUvwb/Nd1BlcjazoF1DPJdds6Y9DP
	 C3TnxSZK9lUIfIWOyEI+w1l2jEKXzRfVpcx08sBDngU1tmSqPHVN58wIb+Uz5C9xCx
	 WUQ5k3duuZWPg==
Date: Mon, 15 Apr 2024 16:40:01 -0700
Subject: [PATCH 4/7] xfs: create a new helper to return a file's allocation
 unit
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380795.87068.1519661303032649001.stgit@frogsfrogsfrogs>
In-Reply-To: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
References: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new helper function to calculate the fundamental allocation
unit (i.e. the smallest unit of space we can allocate) of a file.
Things are going to get hairy with range-exchange on the realtime
device, so prepare for this now.

Remove the static attribute from xfs_is_falloc_aligned since the next
patch will need it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  |   28 ++++++++++------------------
 fs/xfs/xfs_file.h  |    3 +++
 fs/xfs/xfs_inode.c |   13 +++++++++++++
 fs/xfs/xfs_inode.h |    1 +
 4 files changed, 27 insertions(+), 18 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9961d4b5efbe..64278f8acaee 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -39,33 +39,25 @@ static const struct vm_operations_struct xfs_file_vm_ops;
  * Decide if the given file range is aligned to the size of the fundamental
  * allocation unit for the file.
  */
-static bool
+bool
 xfs_is_falloc_aligned(
 	struct xfs_inode	*ip,
 	loff_t			pos,
 	long long int		len)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	uint64_t		mask;
+	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip);
 
-	if (XFS_IS_REALTIME_INODE(ip)) {
-		if (!is_power_of_2(mp->m_sb.sb_rextsize)) {
-			u64	rextbytes;
-			u32	mod;
+	if (!is_power_of_2(alloc_unit)) {
+		u32	mod;
 
-			rextbytes = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
-			div_u64_rem(pos, rextbytes, &mod);
-			if (mod)
-				return false;
-			div_u64_rem(len, rextbytes, &mod);
-			return mod == 0;
-		}
-		mask = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize) - 1;
-	} else {
-		mask = mp->m_sb.sb_blocksize - 1;
+		div_u64_rem(pos, alloc_unit, &mod);
+		if (mod)
+			return false;
+		div_u64_rem(len, alloc_unit, &mod);
+		return mod == 0;
 	}
 
-	return !((pos | len) & mask);
+	return !((pos | len) & (alloc_unit - 1));
 }
 
 /*
diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
index 7d39e3eca56d..2ad91f755caf 100644
--- a/fs/xfs/xfs_file.h
+++ b/fs/xfs/xfs_file.h
@@ -9,4 +9,7 @@
 extern const struct file_operations xfs_file_operations;
 extern const struct file_operations xfs_dir_file_operations;
 
+bool xfs_is_falloc_aligned(struct xfs_inode *ip, loff_t pos,
+		long long int len);
+
 #endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 39e6f88e9691..492dae0efad2 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -4008,3 +4008,16 @@ xfs_break_layouts(
 
 	return error;
 }
+
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	unsigned int		blocks = 1;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		blocks = ip->i_mount->m_sb.sb_rextsize;
+
+	return XFS_FSB_TO_B(ip->i_mount, blocks);
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index b2dde0e0f265..fa3e605901e2 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -625,6 +625,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
 bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
 void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
+unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 
 struct xfs_dir_update_params {
 	const struct xfs_inode	*dp;


