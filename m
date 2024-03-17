Return-Path: <linux-fsdevel+bounces-14580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017E87DE55
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95EC1F21A5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD91CD16;
	Sun, 17 Mar 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKuqLw8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50161CA96;
	Sun, 17 Mar 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692651; cv=none; b=mSXASVZNpoK7c6BLkt48wT5dyIv4M3t+fEAhVNhVMQJA3PVIRV7egE0YmeR9QmXXpgcnW+d9tHojaSHSrAj+0InAy35c0HbK0cEBrOOlzj8/ASmsLIgtZT++Cp/v18oFWDKi/UYd8/ljY43cgsF1EDhWWDkje1P/a27Nrdez/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692651; c=relaxed/simple;
	bh=3PiQWLCvQqjS7LPBm90t4SOaaoJMbpAwofTbsuxbe28=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWtk4oTJDDxX+7oDALSuW7A9TUMDxo0ove844yo8sVJ44S1cb5ToRPQmxQylyx2bwu6Ml2ikYLmNf1Bb/2Vjt5xRaP/nrMR4dnIvtn//55O3z09rXwSr29TsvTVUGA0U5cm0dq9j5Re93Hz9dEK8qQ5Gf/9kIeV8HipfMJSg01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKuqLw8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E89C433F1;
	Sun, 17 Mar 2024 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692651;
	bh=3PiQWLCvQqjS7LPBm90t4SOaaoJMbpAwofTbsuxbe28=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hKuqLw8D1H067+gENLLH+BHtGWUS//ttnXOvOvCLgmPIOhoSuKuTOfaBNTrKrvSs/
	 onFmwpS2uvzFzV1pv4mWb7JK0xLHveO0VfZgFh1y6otAkpM9BiE0HAbjJDMcCcBPvT
	 IMSAxADAh9XVSVQjRGyEvjy/2GoKVE00QNib/ssa5pvGSvpMgKjbWMkFY67G5tPg6b
	 DTDpSsN/4JrcZF8W7JrSP0kj2dGkgSR81IEDgjA8ee/2umC/cByGkd5aP3VTWWrA1O
	 vd8LjVhLos718KaSgnwtPDnijrY507RR4m2psmg4O2XxWbwMcEwPb2vBhREG6iym4e
	 3ZLnhOHUNSo7A==
Date: Sun, 17 Mar 2024 09:24:10 -0700
Subject: [PATCH 03/40] xfs: define parent pointer ondisk extended attribute
 format
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: Dave Chinner <dchinner@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069245962.2684506.1502973262362352509.stgit@frogsfrogsfrogs>
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

From: Allison Henderson <allison.henderson@oracle.com>

We need to define the parent pointer attribute format before we start
adding support for it into all the code that needs to use it. The EA
format we will use encodes the following information:

        name={parent inode #, parent inode generation, dirent namehash}
        value={dirent name}

The inode/gen gives all the information we need to reliably identify the
parent without requiring child->parent lock ordering, and allows
userspace to do pathname component level reconstruction without the
kernel ever needing to verify the parent itself as part of ioctl calls.
Storing the dirent name hash in the key reduces hash collisions if a
file is hardlinked multiple times in the same directory.

By using the NVLOOKUP mode in the extended attribute code to match
parent pointers using both the xattr name and value, we can identify the
exact parent pointer EA we need to modify/remove in rename/unlink
operations without searching the entire EA space.

By storing the dirent name, we have enough information to be able to
validate and reconstruct damaged directory trees.  Earlier iterations of
this patchset encoded the directory offset in the parent pointer key,
but this format required repair to keep that in sync across directory
rebuilds, which is unnecessary complexity.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: replace diroffset with the namehash in the pptr key]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_da_format.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 5434d4d5b551..67e8c33c4e82 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -878,4 +878,24 @@ static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
 xfs_failaddr_t xfs_da3_blkinfo_verify(struct xfs_buf *bp,
 				      struct xfs_da3_blkinfo *hdr3);
 
+/*
+ * Parent pointer attribute format definition
+ *
+ * The xattr name encodes the parent inode number, generation and the crc32c
+ * hash of the dirent name.
+ *
+ * The xattr value contains the dirent name.
+ */
+struct xfs_parent_name_rec {
+	__be64	p_ino;
+	__be32	p_gen;
+	__be32	p_namehash;
+};
+
+/*
+ * Maximum size of the dirent name that can be stored in a parent pointer.
+ * This matches the maximum dirent name length.
+ */
+#define XFS_PARENT_DIRENT_NAME_MAX_SIZE		(MAXNAMELEN - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */


