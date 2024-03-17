Return-Path: <linux-fsdevel+bounces-14615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7770C87DEB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32658281152
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69B1B949;
	Sun, 17 Mar 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDUOv03a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889B7F6;
	Sun, 17 Mar 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693199; cv=none; b=ZDlZiz/g8IKDaFpftomtTf2p6CJFJeIvHsZovUX7IQqr6h+/ahy6j4C8BoyJ6tuzhO9gImFu2TCn2pblgUykv2ywJ0JPoD3RC54QG/FmTtU9X5XbUwxtgtcpFPg4DeJOnlAynwxJviJTp0TjB/QwxUQKkzFzTArtWigXf6dn3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693199; c=relaxed/simple;
	bh=p+HzgupUX7ciAFwLxTWigNm12S2HS0MQcNcqVZ1LajE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1HXH1kxKpTVZVKIGLkE3kpM1m6qZk0VsCEFgJgsfryl9uHZH22iDHWDi8lRp0Tq6qisFrCtxaa9T1xfCDs6k9s10XYljNufa2XTQAansrTiGOpNMeCA+M16/HJEyEHbEPcOe8SHPmyzEHgQv651eAaCafqLCSppvyLQKqH4Rss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDUOv03a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E46C433F1;
	Sun, 17 Mar 2024 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693199;
	bh=p+HzgupUX7ciAFwLxTWigNm12S2HS0MQcNcqVZ1LajE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eDUOv03adATUnnw94KntnGe+pA+Jhqg8nbfx5x1SayKNJ4XQgDnCfyq41LPyIQEFx
	 R6W3RndXxQYtUUCYyGM18bDE+BbCABgMA3mVT3tsUZWCfMwauINerTJ2dizV2beA8I
	 2yvhkrPHX5MBnaTypJ9O17NMLT5slxpFwWlQHCFtf4Eu5nm4zMTvnv6YbA7L6FPn//
	 8gbuHem/ifG8nlfA8oz4JLkPLNYt+oZdX6tR5kj9p2H+RW8wTfWBKDK6UM5jFVl2/E
	 2mNpVeExtHGcdKKgEDksELNY80YJEvCyRZUhLRLB8B1I3VuoOrwyTCgcbeGRtPh1Ih
	 ZE8N/BIZoRvFQ==
Date: Sun, 17 Mar 2024 09:33:18 -0700
Subject: [PATCH 38/40] xfs: use merkle tree offset as attr hash
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246517.2684506.8560170754721057486.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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
 fs/xfs/libxfs/xfs_attr.c      |    7 +++++++
 fs/xfs/libxfs/xfs_da_format.h |    2 ++
 2 files changed, 9 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index b1fa45197eac..7c0f006f972a 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -245,6 +245,13 @@ xfs_attr_hashname(
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
 
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index e4aa7c9a0ccb..58887a1c65fe 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -946,4 +946,6 @@ xfs_verity_merkle_key_from_disk(
 #define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
 #define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
 
+#define XFS_VERITY_MIN_MERKLE_BLOCKLOG	(10)
+
 #endif /* __XFS_DA_FORMAT_H__ */


