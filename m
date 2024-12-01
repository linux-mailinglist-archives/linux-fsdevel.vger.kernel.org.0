Return-Path: <linux-fsdevel+bounces-36200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FA9DF5B4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8C62817FB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C251CB520;
	Sun,  1 Dec 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysaac3sD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7E1CB506;
	Sun,  1 Dec 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058782; cv=none; b=JFbbiaRDW1Szp5TrjRr9jzEjyOtjScBJD96WgAUdQyDuAauHDJB2qJLpdVmkpHT6IYt/n2LqpNpqYPhYX0TNSfsLPVD7EFjaIVDHhulZZv1cRH5wbvdxsjrrSAA3+Gwv4a3PYzGgQwDUG0c6tSuP0h62yskjbPBPO1mrbZaEh5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058782; c=relaxed/simple;
	bh=uMTdN9Tq9QOP5CBej/C0az0/Wbj6Oorc2xZALcGYetI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0EQmrdOdyX0vMGTcafuOjL8eEA64cVJ3f3zXG1v7J4qEzPlqJi0rDTuRbQMAUwayEjvP4FyImzlAmN/IwdbPzVeypbjAhnrttEbXPw0EHMjHId8Uo94fskg10NTlkhUa4sD3NcH/00/TLdJAgss+ev4d0eWPZhHkXRMh2YlOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysaac3sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11037C4CECF;
	Sun,  1 Dec 2024 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058782;
	bh=uMTdN9Tq9QOP5CBej/C0az0/Wbj6Oorc2xZALcGYetI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ysaac3sDDSvYaJtfhoyfN6B9LrvvZUcAZkQsvLi4KTEDgJQmysNRdFrNwXsVCVosL
	 Des04o1KFEJQcJBJX2EIFYghSG3ossIsd2Bn/jNeuY5rs8KIA9PToiVi74l/zSJhB0
	 Dli5aESXq2vwHv2zMliS9jPxtPE+wmvCdm4KQ82XbATouczasHnrogKHwEzJBzd9EH
	 8KN+a1bMseslFIF/jj4QlHNL/KRVkmnxEbta+nkL+j/thZ2Hj6ld200/y29WNglGaw
	 A0ux9xNILRPZ4Udj+QETLSCM0PS73PGkZJTR9Gk+rSvHsYl6eSQy/kkmI3RoAjJ/sj
	 Otf6CGqT9HvGQ==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: [PATCH 1/4] exportfs: add flag to indicate local file handles
Date: Sun,  1 Dec 2024 14:12:25 +0100
Message-ID: <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267; i=brauner@kernel.org; h=from:subject:message-id; bh=uMTdN9Tq9QOP5CBej/C0az0/Wbj6Oorc2xZALcGYetI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7JOyrnOTXtIefcc/ZZcfYGRye33l6pyjr0vY2+3iHq QkGFxTvd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEYCPDH+5pCZtswpPdmtm4 z+a9l/5fEbtYOfjRRsc3z9XFVjAVnmT4p7M2Z8Pyv1y5Ky9MOWdibDhZ/XCUcZDQ8gliz03E5Ar EGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Some filesystems like kernfs and pidfs support file handles as a
convenience to use name_to_handle_at(2) and open_by_handle_at(2) but
don't want to and cannot be reliably exported. Add a flag that allows
them to mark their export operations accordingly.

Fixes: aa8188253474 ("kernfs: add exportfs operations")
Cc: stable <stable@kernel.org> # >= 4.14
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/export.c         | 8 +++++++-
 include/linux/exportfs.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index eacafe46e3b673cb306bd3c7caabd3283a1e54b1..786551595cc1c2043e8c195c00ca72ef93c769d6 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
 static int check_export(struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
+	const struct export_operations *nop;
 
 	/*
 	 * We currently export only dirs, regular files, and (for v4
@@ -449,11 +450,16 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
+	if (!exportfs_can_decode_fh(nop)) {
 		dprintk("exp_export: export of invalid fs type.\n");
 		return -EINVAL;
 	}
 
+	if (nop && nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE) {
+		dprintk("exp_export: filesystem only supports non-exportable file handles.\n");
+		return -EINVAL;
+	}
+
 	if (is_idmapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
 		return -EINVAL;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index a087606ace194ccc9d1250f990ce55627aaf8dc5..40f78c8e4f31b97b2101b66634e8d1807c1bcc14 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -280,6 +280,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
+#define EXPORT_OP_LOCAL_FILE_HANDLE		(0x80) /* fs only supports file handles, no proper export */
 	unsigned long	flags;
 };
 

-- 
2.45.2


