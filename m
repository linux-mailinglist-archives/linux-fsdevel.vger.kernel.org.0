Return-Path: <linux-fsdevel+bounces-69297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06535C76843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F23DE34EA79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4E3587CB;
	Thu, 20 Nov 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzdzyOZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99302E62A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677972; cv=none; b=HCMkYuNEUnOEzLQVS8Rm4cq+kpedb//RTKHiIOiGi/QSq1aMfDLTDyKh8Cy1egv8QqUoiRckk+7wb3i6e/DH7IEh3Gxp2jQ+bR1DXBfxq4F/f9UcBTw+W6l0gKe6U4ciXwDN8trvI74DB1tHNdA9kOuWAgj8dd175xSi7KEaDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677972; c=relaxed/simple;
	bh=YNzMp5YWK8/vKAuUjQbtZ1NbTUe8BJEgTUOcJCd5oqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCuN6EYGJECIRot3jx1dpUnKYHKnWrDIr4GVuNuZe6xG+IOWcydug45oVoYXyaEMuicu0AQZ5bVy0GSIXzPI8cnH89NQJDdeJJG/URaEn5UC60uQGm2wq0PUDeQPEmJQGG+QiRKkUDE2KCRhB3/trIs/OOT0fJ6aO0pV6CGSv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzdzyOZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E088AC19421;
	Thu, 20 Nov 2025 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677972;
	bh=YNzMp5YWK8/vKAuUjQbtZ1NbTUe8BJEgTUOcJCd5oqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kzdzyOZiRKkhi8BPwVEOBY/arRjgR+UfsopPWegAJfVfFcqD0CzfJtRqv3LLM6jan
	 sFjsRFA6XEtTmsO3mx1mXLctQ3f0n97twBm0RSzc5WbRyCrzM2qZIJ0Xy+Ht05UETm
	 WLwLKU7iU5+U5tl3+wzZfltU3YKkfuOJFFWPiiyGqm13z/znz3DJzsomyh8sWxeyOD
	 NNssLnP8DlyEv341bfPfdAI6jEiEdBI8F9UzdLmINpPIaBA5opwtqW2GcRMjEpx1UB
	 uYiatdD+vFt5GO/8QB/RSJ03E6SV7Xs01JvvaC6IhfvzII//w99eTrNIwVjyQtHKMb
	 WWqy4UcdHlISw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:14 +0100
Subject: [PATCH RFC v2 17/48] xfs: convert xfs_open_by_handle() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-17-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YNzMp5YWK8/vKAuUjQbtZ1NbTUe8BJEgTUOcJCd5oqI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3u7StiY78Yerc27GT2LPn+cx3xmR+a7lAuTTvbMX
 3Olc1OlVUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEarUZGc4Llt4QmZZXxVMW
 rN7idyEw3KX/w/dn/xO91NSd9i68ycPIMGWH3dH4777hlppJPbl7nnfF8Dxi1rp9xls0SPmZ9aH
 PDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_handle.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..7a2e53560fe2 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -234,9 +234,7 @@ xfs_open_by_handle(
 {
 	const struct cred	*cred = current_cred();
 	int			error;
-	int			fd;
 	int			permflag;
-	struct file		*filp;
 	struct inode		*inode;
 	struct dentry		*dentry;
 	fmode_t			fmode;
@@ -279,28 +277,23 @@ xfs_open_by_handle(
 		goto out_dput;
 	}
 
-	fd = get_unused_fd_flags(0);
-	if (fd < 0) {
-		error = fd;
-		goto out_dput;
-	}
-
 	path.mnt = parfilp->f_path.mnt;
 	path.dentry = dentry;
-	filp = dentry_open(&path, hreq->oflags, cred);
-	dput(dentry);
-	if (IS_ERR(filp)) {
-		put_unused_fd(fd);
-		return PTR_ERR(filp);
-	}
 
-	if (S_ISREG(inode->i_mode)) {
-		filp->f_flags |= O_NOATIME;
-		filp->f_mode |= FMODE_NOCMTIME;
-	}
+	FD_PREPARE(fdf, 0, dentry_open(&path, hreq->oflags, cred)) {
+		dput(dentry);
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
+
+		if (S_ISREG(inode->i_mode)) {
+			struct file *filp = fd_prepare_file(fdf);
 
-	fd_install(fd, filp);
-	return fd;
+			filp->f_flags |= O_NOATIME;
+			filp->f_mode |= FMODE_NOCMTIME;
+		}
+
+		return fd_publish(fdf);
+	}
 
  out_dput:
 	dput(dentry);

-- 
2.47.3


