Return-Path: <linux-fsdevel+bounces-14628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A552287DED4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762A7B21363
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDA1C695;
	Sun, 17 Mar 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLs7MtCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D41CD18;
	Sun, 17 Mar 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693402; cv=none; b=MpaXTMdGufpW6JoZvVMmFHyBvHYRBBcUBF5Ho1JzEFxC1DCzfQBfC/lnQA5U6AHlgTEEsqb8qBIH3yWUdmjRIbWu4WfKgiL8eupQQB2YWkxioWJyHVmrz973LRbbZptHHS4orEma/iGsDyBOt38Ew4wZHC6tNG9IjNf29xuuETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693402; c=relaxed/simple;
	bh=EvjQ4lGa9VZVj1YA3XmFyTfuuixSVMz1etdtyeM3Juk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RISKYVT+w6NioxpnSfqBZQUMBY9CkgqMSb6xRCYE5DHab2f6rnMxIzUHCSA0WoX2vurMDPlUeXRakJ5/TV2H+TZHDUptixJ8+HKPE9cSiL+kzALKGzKQy2Ybat/ip8SQOqGlsiH+nG+miJn99o2EutUIUZiTj3UdqLnqN7/Rdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLs7MtCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE6DC433F1;
	Sun, 17 Mar 2024 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693402;
	bh=EvjQ4lGa9VZVj1YA3XmFyTfuuixSVMz1etdtyeM3Juk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KLs7MtCb89ucG8iXhYjxXELEiXirT//STH6zzZFUpLozzUpzC1oVBtHKTFnEBhXhT
	 Z96qAmQF2CQl7IXW7v26x11a0EjIVgZZVkBZkh53QQM214Y4Xh824yNBYFOxhXWRd3
	 hncGmsv2B+TVHesOvkGr1nDaxu9lX35NhsueRrwhzZE9WXIaxNUoJc6A1QwDD/1wLI
	 V3JZc8I6N6D2LZNYvbne+oDbdesc4Uo6J/ByseDV2xvnhvT4/0PEG/+jFd1ZXme5IR
	 FvuS6mddW4URqGfSYdgoB0ZXkuXEZltG/5CvkbHebgVhO7OClapks826ifEV422UMW
	 iyQnk8eNRGdyg==
Date: Sun, 17 Mar 2024 09:36:41 -0700
Subject: [PATCH 11/20] xfs: use merkle tree offset as attr hash
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247827.2685643.9491628674924172369.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
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

I was exploring the fsverity metadata with xfs_db after creating a 220MB
verity file, and I noticed the following in the debugger output:

entries[0-75] = [hashval,nameidx,incomplete,root,secure,local,parent,verity]
0:[0,4076,0,0,0,0,0,1]
1:[0,1472,0,0,0,1,0,1]
2:[0x800,4056,0,0,0,0,0,1]
3:[0x800,4036,0,0,0,0,0,1]
...
72:[0x12000,2716,0,0,0,0,0,1]
73:[0x12000,2696,0,0,0,0,0,1]
74:[0x12800,2676,0,0,0,0,0,1]
75:[0x12800,2656,0,0,0,0,0,1]
...
nvlist[0].merkle_off = 0x18000
nvlist[1].merkle_off = 0
nvlist[2].merkle_off = 0x19000
nvlist[3].merkle_off = 0x1000
...
nvlist[71].merkle_off = 0x5b000
nvlist[72].merkle_off = 0x44000
nvlist[73].merkle_off = 0x5c000
nvlist[74].merkle_off = 0x45000
nvlist[75].merkle_off = 0x5d000

Within just this attr leaf block, there are 76 attr entries, but only 38
distinct hash values.  There are 415 merkle tree blocks for this file,
but we already have hash collisions.  This isn't good performance from
the standard da hash function because we're mostly shifting and rolling
zeroes around.

However, we don't even have to do that much work -- the merkle tree
block keys are themslves u64 values.  Truncate that value to 32 bits
(the size of xfs_dahash_t) and use that for the hash.  We won't have any
collisions between merkle tree blocks until that tree grows to 2^32nd
blocks.  On a 4k block filesystem, we won't hit that unless the file
contains more than 2^49 bytes, assuming sha256.

As a side effect, the keys for merkle tree blocks get written out in
roughly sequential order, though I didn't observe any change in
performance.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_attr.c      |    7 +++++++
 libxfs/xfs_da_format.h |    2 ++
 2 files changed, 9 insertions(+)


diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index aca65971..971d185b 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -241,6 +241,13 @@ xfs_attr_hashname(
 	const uint8_t		*name,
 	unsigned int		namelen)
 {
+	if ((attr_flags & XFS_ATTR_VERITY) &&
+	    namelen == sizeof(struct xfs_verity_merkle_key)) {
+		uint64_t	off = xfs_verity_merkle_key_from_disk(name);
+
+		return off >> XFS_VERITY_MIN_MERKLE_BLOCKLOG;
+	}
+
 	return xfs_da_hashname(name, namelen);
 }
 
diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index 2d2314a5..1d061cc0 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -951,4 +951,6 @@ xfs_verity_merkle_key_from_disk(
 #define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
 #define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
 
+#define XFS_VERITY_MIN_MERKLE_BLOCKLOG	(10)
+
 #endif /* __XFS_DA_FORMAT_H__ */


