Return-Path: <linux-fsdevel+bounces-18262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774AE8B68D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B7B283B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191417731;
	Tue, 30 Apr 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/dwnMo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C710A0D;
	Tue, 30 Apr 2024 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447948; cv=none; b=AV7K1+PYbPxa5nFzch6qa3i/olFqxaXUX7GkCv/N/jbY8WCMU0/SBiJszbh+vKG33BarIkfNFbiKRdcKjB+wQ2JdQeJYeyXUSp40ITKF3azg+M3St2YvSG5GhFpe904kr95vpvoIGDV0n4BFKRCJtg7RMpPMr94kltrfFjSWaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447948; c=relaxed/simple;
	bh=bFFVF59FtuOzAhQ+x2mWVF5N2VzrjOmGE5wEfGjihi0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slphmKhBCXU8jtYU7viOtZN/910C+4G6GlcHFv3smrojQCEsr0IHIi1cQweD5+oeRpzXrXXcsBeYfWNClTyLWDrbIuaz5a70PBBK5gddI/ioNKRYtGJckKmllODCVNAzQQspkI1F1bPUHJlkyxWgsR2HTD/Y6BQ9dpKI9cAz9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/dwnMo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799A0C116B1;
	Tue, 30 Apr 2024 03:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447947;
	bh=bFFVF59FtuOzAhQ+x2mWVF5N2VzrjOmGE5wEfGjihi0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V/dwnMo0KpHLxmA5kO3RtTojkVRxTUiyj51UrErteJ0ZD45qSJxa8poB+2mZqdezc
	 /q/8FZvjgAFNvY128kclHtqbFK+mOtjaaOvzYm8eBIdeJ+XIaPfDAlqbRiYrrO9iRn
	 cULszSk4+4v1zMBZ28r/40S6QGFh+GAPKpcrB/tmKJkn7urtqo0yAVhc1ac9mo0W1e
	 YHX+tU0P4f9jNmv996SoxTbJJjItsHc8FIy7M4ur37mgNevGvXdnSrW+bIgfVan78p
	 YqTFkijoFAdnw708gsC/DpQz0wmdqx4Yt7BBL+aa3b3Tdz1FutQcl+llksR9guouvO
	 IimnNbeuPvTdw==
Date: Mon, 29 Apr 2024 20:32:27 -0700
Subject: [PATCH 06/38] xfs: use an empty transaction to protect xfs_attr_get
 from deadlocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683203.960383.14371751684414769283.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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

Wrap the xfs_attr_get_ilocked call in xfs_attr_get with an empty
transaction so that we cannot livelock the kernel if someone injects a
loop into the attr structure or the attr fork bmbt.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_attr.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index 3058e609c514..0a9fb396885e 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -273,6 +273,8 @@ xfs_attr_get(
 
 	XFS_STATS_INC(args->dp->i_mount, xs_attr_get);
 
+	ASSERT(!args->trans);
+
 	if (xfs_is_shutdown(args->dp->i_mount))
 		return -EIO;
 
@@ -285,8 +287,27 @@ xfs_attr_get(
 	/* Entirely possible to look up a name which doesn't exist */
 	args->op_flags = XFS_DA_OP_OKNOENT;
 
+	error = xfs_trans_alloc_empty(args->dp->i_mount, &args->trans);
+	if (error)
+		return error;
+
 	lock_mode = xfs_ilock_attr_map_shared(args->dp);
+
+        /*
+	 * Make sure the attr fork iext tree is loaded.  Use the empty
+	 * transaction to load the bmbt so that we avoid livelocking on loops.
+	 */
+        if (xfs_inode_hasattr(args->dp)) {
+                error = xfs_iread_extents(args->trans, args->dp, XFS_ATTR_FORK);
+                if (error)
+                        goto out_cancel;
+        }
+
 	error = xfs_attr_get_ilocked(args);
+
+out_cancel:
+	xfs_trans_cancel(args->trans);
+	args->trans = NULL;
 	xfs_iunlock(args->dp, lock_mode);
 
 	return error;


