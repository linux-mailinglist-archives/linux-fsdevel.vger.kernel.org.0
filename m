Return-Path: <linux-fsdevel+bounces-15734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C606B892862
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B6D1C20F8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF81C3D;
	Sat, 30 Mar 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG5SAtUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B81851;
	Sat, 30 Mar 2024 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759262; cv=none; b=Zbi8FCztdrflaamj4P2FnDn8EXh0aZEueqh5l4A5kJL38gAhXzkD7U1b4MwSq0P63TN/xM+kUOi5PPaxJZjMg3iux/vuCtYvB5yM0JUFAgyGfMOBJyh8CcjqOY1JY0N1+28aKv57REmXQ7PrHn4OSvvAdm7cG5q0AqutPiri5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759262; c=relaxed/simple;
	bh=ziP2eUwk3uDAHxCl5FWWo6T52D2Ctj0EmrTBmUrklbk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFzdNRwVllp/iQKWxq8LFolvK+p922a5fWw0K4wUrF1sM8gPGGPdM/wK2JdtDnBbVQjaP9ujayaIne5tDAOWA3T8tr4fRuXF8oM0nTe+EMzKVnaViUhyrK5qcL3xfBKqG26LocXU+t6xelhQ5zeK20grd7HRM10s6HbD87WoIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG5SAtUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8469C433C7;
	Sat, 30 Mar 2024 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759261;
	bh=ziP2eUwk3uDAHxCl5FWWo6T52D2Ctj0EmrTBmUrklbk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hG5SAtUeXB2bJpfq9lflYobYktjddBMPCUlUiJlAAKTD8t9zmWUqiaHhj2LJ2RFM2
	 Qgymwhh2JgpUYkbUDNpLXkTly3sZu1PPhET9FTLA2U70vo+7Q4L2rkVNU2ylzcyOCx
	 5A71iELiUuRgwx7VBEmchCBtMkTSUHIVHP0UEKn85TwtKvnhFhI7JqRTvrzBbPBl8X
	 ytZzy8IyiR0GgHxW2objQX1iuTbT4+H/dt1Y5coSSNV+N9oeMDIdbgM7/Gw0BhAHeE
	 ieMj1urhgDY0qyor3egh4NVLSVsEbmma4EKWhb5oKadlheiqjFvVKN3ViPzBiTnafE
	 +8ZtzXC2Zx4NA==
Date: Fri, 29 Mar 2024 17:41:01 -0700
Subject: [PATCH 19/29] xfs: use merkle tree offset as attr hash
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868875.1988170.3327132833672531809.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
index c3f686411e378..3d3335148a212 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -431,6 +431,8 @@ xfs_attr_hashval(
 
 	if (attr_flags & XFS_ATTR_PARENT)
 		return xfs_parent_hashattr(mp, name, namelen, value, valuelen);
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xfs_verity_hashname(name, namelen);
 
 	return xfs_attr_hashname(name, namelen);
 }
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 679cf5b4ad4be..4f5fd22ac4f96 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -936,4 +936,10 @@ struct xfs_merkle_key {
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
index bda38b3c19698..d72f04043fe5e 100644
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
index c01cc0678bc04..72e41ecd046f1 100644
--- a/fs/xfs/libxfs/xfs_verity.h
+++ b/fs/xfs/libxfs/xfs_verity.h
@@ -9,5 +9,6 @@ void xfs_merkle_key_to_disk(struct xfs_merkle_key *key, uint64_t offset);
 uint64_t xfs_merkle_key_from_disk(const void *attr_name, int namelen);
 bool xfs_verity_namecheck(unsigned int attr_flags, const void *name,
 		int namelen);
+xfs_dahash_t xfs_verity_hashname(const uint8_t *name, unsigned int namelen);
 
 #endif	/* __XFS_VERITY_H__ */


