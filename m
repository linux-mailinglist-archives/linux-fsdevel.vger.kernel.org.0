Return-Path: <linux-fsdevel+bounces-18269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DA8B68E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD99B23CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB8710A1E;
	Tue, 30 Apr 2024 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpfYn0K+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62411185;
	Tue, 30 Apr 2024 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448057; cv=none; b=k+DxbnyGGUgTp8mtjpNWJyAD+YFw/Mq0HuKR65PfObRNs4uFBTG4Oj1kwBF9uci98jnhiPbinjQMHlxVYBInre0PHbt5wY8mjXh7rWGtH5BWCENNWzljm7ZV26zcN97jNRFGK+J2no7IAYt5UejfhoJzUNnbiBbFj7jZYZzYGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448057; c=relaxed/simple;
	bh=CB4njwGCAc16wwPoRbM7Nf4jAH9eFhcoH+qT539GnFU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaFL9RCXQoitj5NsGPTdITlbaF6ViGvABLlG+r0R1iL7KXnBeVDrvjkolEW+09ZkRprxFb6pYngVx4bpmprBF8ERbCMd/3slNIqXBNIjoB0ldHBQUx4/qwKp8M2bQ/iYuNI3bW5qLsM+Rs4c7HcJz1T0oGdXT95Kun24o8C6//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpfYn0K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1202AC116B1;
	Tue, 30 Apr 2024 03:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448057;
	bh=CB4njwGCAc16wwPoRbM7Nf4jAH9eFhcoH+qT539GnFU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fpfYn0K+4MxXLsDWqBqvawkIZtyAOeAyhQyiBLqMLDtxiFbCLhz7I1xilnDpI7xFc
	 XkZekuyssA+CBkVqdOD7oMsFnOU1FW+8Nq59XP3gAQUezi5DtbCdVY58UGTfjreqSg
	 q0p3DegxrNh2pIGCfBy9YL2il0ies3JTyEEpMvd/kNcQW67k3iC/0OBF4ep50MiM8Y
	 WUpyV8WFTU4MFV800fgJvSkeGz4LHTx/2IRL3PopReoApLTXdrW2llF5TW5GKJUpqr
	 vljD8bGPxNwCuHVB5iJH77qCPwxfxyylAxifn0/5nqNYMcxc29yvgnD2FMT6Jq6S6R
	 5LnephsFs/n7w==
Date: Mon, 29 Apr 2024 20:34:16 -0700
Subject: [PATCH 13/38] xfs: advertise fs-verity being available on filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683311.960383.13826848854466408647.stgit@frogsfrogsfrogs>
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

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libxfs/xfs_fs.h |    1 +
 libxfs/xfs_sb.c |    2 ++
 2 files changed, 3 insertions(+)


diff --git a/libxfs/xfs_fs.h b/libxfs/xfs_fs.h
index f9a6a678f1b4..edc019d89702 100644
--- a/libxfs/xfs_fs.h
+++ b/libxfs/xfs_fs.h
@@ -246,6 +246,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE (1 << 24) /* exchange range */
 #define XFS_FSOP_GEOM_FLAGS_PARENT	(1 << 25) /* linux parent pointers */
 
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1U << 29) /* fs-verity */
 #define XFS_FSOP_GEOM_FLAGS_METADIR	(1U << 30) /* metadata directories */
 
 /*
diff --git a/libxfs/xfs_sb.c b/libxfs/xfs_sb.c
index f8902c4778da..936071abb207 100644
--- a/libxfs/xfs_sb.c
+++ b/libxfs/xfs_sb.c
@@ -1434,6 +1434,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE;
 	if (xfs_has_metadir(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 


