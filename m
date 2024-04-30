Return-Path: <linux-fsdevel+bounces-18247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E88B68A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93551C21AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648710A1D;
	Tue, 30 Apr 2024 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ7/JTry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CEDDA6;
	Tue, 30 Apr 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447729; cv=none; b=fuHpEOAeY+XbY9/jP+1HNuC8ZbQllqdJwrCQHEG/jFB9AAxlrgeXXyEmOESv2MW9/AZuh3iebuno8XTMhJmw1P4zJbaUNrtBNIlYr+bAFQRZoVZ5gXpQvWCWrRRdtwWQoJxcZHlRZf3iVc5m+Cqr/XQ/w2YNjYaH5kbFMmbJgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447729; c=relaxed/simple;
	bh=iY8RQWkorROZqx0/sWn/fczdek03gXTNwZwuvRnsfyk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2AYH76ecK6o00ptbB8esuLGCdmQxc1OefjlLx0ZwJSkg9khn+f94CZ5moF7u0kE0lpoheFjBY1wuEWrSmSy5eM/Ya6R/B/eDOpIUA0mhdAJLF16L1ZK5/ySBYH93RWUl5rRiSVtDZtOwzLmjmax1tJs1pOCua0I9GjTaCmEDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ7/JTry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89519C116B1;
	Tue, 30 Apr 2024 03:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447728;
	bh=iY8RQWkorROZqx0/sWn/fczdek03gXTNwZwuvRnsfyk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bQ7/JTry1u0cIQxSWYDKPASr2l7PqhJujyMV5Kn4HxdxuesuIAF33XOl3Waw9z/Ph
	 oQtryOFHUV8Bl9uByjcaHtx7X5RR3B0VQ3xYqmAwT8hkPJsTEfBFYL9wZ+SfPDq+s/
	 pzfn1aprxvsRxNT2oMwi3getv5MRhhVSJn6SZoss6iB8WgRokciVaIZVp+uTHLETEv
	 wq8TKtSs+McCaLYQa8VHblxNZsE4PBY7tT7bTwh5QXF/uSGHtrghBvsJo3pA3yxD8A
	 QPtcXkXYycsHKoxeFxbHICPeNTStKC2KgBtp0ywfB97jdHPrvr8qYYpWsdZalzJ3N4
	 fs7nsXkwXB61w==
Date: Mon, 29 Apr 2024 20:28:48 -0700
Subject: [PATCH 18/26] xfs: use merkle tree offset as attr hash
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr.c      |    2 ++
 fs/xfs/libxfs/xfs_da_format.h |    6 ++++++
 fs/xfs/libxfs/xfs_verity.c    |   16 ++++++++++++++++
 fs/xfs/libxfs/xfs_verity.h    |    1 +
 4 files changed, 25 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 953a82d70223e..d21a743f90ea7 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -462,6 +462,8 @@ xfs_attr_hashval(
 
 	if (attr_flags & XFS_ATTR_PARENT)
 		return xfs_parent_hashattr(mp, name, namelen, value, valuelen);
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xfs_verity_hashname(name, namelen);
 
 	return xfs_attr_hashname(name, namelen);
 }
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 43e9d1f00a4ab..c95e8ca22daad 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -943,4 +943,10 @@ struct xfs_merkle_key {
 #define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
 #define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
 
+/*
+ * Merkle tree blocks cannot be smaller than 1k in size, so the hash function
+ * can right-shift the merkle offset by this amount without losing anything.
+ */
+#define XFS_VERITY_HASH_SHIFT		(10)
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/fs/xfs/libxfs/xfs_verity.c b/fs/xfs/libxfs/xfs_verity.c
index ff02c5c840b58..8c470014b915c 100644
--- a/fs/xfs/libxfs/xfs_verity.c
+++ b/fs/xfs/libxfs/xfs_verity.c
@@ -56,3 +56,19 @@ xfs_verity_namecheck(
 
 	return true;
 }
+
+/*
+ * Compute name hash for a verity attribute.  For merkle tree blocks, we want
+ * to use the merkle tree block offset as the hash value to avoid collisions
+ * between blocks unless the merkle tree becomes larger than 2^32 blocks.
+ */
+xfs_dahash_t
+xfs_verity_hashname(
+	const uint8_t		*name,
+	unsigned int		namelen)
+{
+	if (namelen != sizeof(struct xfs_merkle_key))
+		return xfs_attr_hashname(name, namelen);
+
+	return xfs_merkle_key_from_disk(name, namelen) >> XFS_VERITY_HASH_SHIFT;
+}
diff --git a/fs/xfs/libxfs/xfs_verity.h b/fs/xfs/libxfs/xfs_verity.h
index 5813665c5a01e..3d7485c511d58 100644
--- a/fs/xfs/libxfs/xfs_verity.h
+++ b/fs/xfs/libxfs/xfs_verity.h
@@ -9,5 +9,6 @@ void xfs_merkle_key_to_disk(struct xfs_merkle_key *key, uint64_t pos);
 uint64_t xfs_merkle_key_from_disk(const void *attr_name, int namelen);
 bool xfs_verity_namecheck(unsigned int attr_flags, const void *name,
 		int namelen);
+xfs_dahash_t xfs_verity_hashname(const uint8_t *name, unsigned int namelen);
 
 #endif	/* __XFS_VERITY_H__ */


