Return-Path: <linux-fsdevel+bounces-18239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818FF8B688E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B331C20B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174281078F;
	Tue, 30 Apr 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr2Pj6ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC710A01;
	Tue, 30 Apr 2024 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447603; cv=none; b=OaJVlKrg2gfzQ9lcGrS91ojzEsYm77pqwQ49bpS3Qgg1XEQ+snPNBeTHBCNivgqrmF1WKxFEDkZ3w6p/JfGTaeEqj/dbA7fcdS0s1N1U83rNa4DqJu9dgSEMWFdIPmWJE3GZ7WefOUfMy5uGMg+i0gJXed2yF1oD5uYIKeI55+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447603; c=relaxed/simple;
	bh=F9VE2XMwZP7cJVMy7INw7+3qMZSnsKI2oK80RsCHTbU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDkDHW9xa87k0HYF8rz15i8iGNRBfPkDPkKAmPR+SLYngpADtvwOYI/wkjKXrHeFguwkUKIr8YkIFEvMa+LOgvymK6nVuCtiwpEmvdP2GuOuNyyH4BN42rrnNT7ilmYftPv0ZNx6ALq8UggXmLK0jSWmNc9JiYorTDyL+xDnmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr2Pj6ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC01C116B1;
	Tue, 30 Apr 2024 03:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447603;
	bh=F9VE2XMwZP7cJVMy7INw7+3qMZSnsKI2oK80RsCHTbU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Vr2Pj6evpdlLJ3u4TZdAgxx30uwN2/q5J2P6RVACbcazJ+vVAwr5Gb3amZ3VZyU/Y
	 FRmE6fcLkrxv9vHwNfRzfKPbQA/pkl8HlxUm6PCRxjMZbya595+lYVI4umv6cjXIaC
	 x3ke2AOmFF50IdaKS16G/oH99Ik+bHALHZAB+OT7Th7Cr7UHUYpJHp++EEDZGcnQYG
	 Y6wIt9uKK5gE6bI0yGaXQXlINnEXUwsGwSwhHejnrkdvDLCpA5k1RyFJvM4hSXAdZc
	 MnvEw1qqafyv6FEnDKFxtmzbVBQe2eRydfI/pTNa822YgaJtfTG+pBwUvLTTo4TGLC
	 Rw6nmfqepGCOw==
Date: Mon, 29 Apr 2024 20:26:42 -0700
Subject: [PATCH 10/26] xfs: initialize fs-verity on file open and cleanup on
 inode destruction
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680533.957659.3926647622921839089.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  |    8 ++++++++
 fs/xfs/xfs_super.c |    2 ++
 2 files changed, 10 insertions(+)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 75ec4152ecafc..fe1f108aa6bff 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -33,6 +33,7 @@
 #include <linux/fadvise.h>
 #include <linux/mount.h>
 #include <linux/fsnotify.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1477,10 +1478,17 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8e2f263b444c6..72842d4f16c92 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -52,6 +52,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -667,6 +668,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 


