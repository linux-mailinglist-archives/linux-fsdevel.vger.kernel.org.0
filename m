Return-Path: <linux-fsdevel+bounces-68652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A61C633C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5744F24F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09FC25BEE7;
	Mon, 17 Nov 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM+m+xSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FD328B6F;
	Mon, 17 Nov 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372041; cv=none; b=Pg6hJzmoze91azooM8WQuSRi6r9uAR9riymG/cGBloCt/i+SgP46RTrj4UA9Efpe06ejuTj1PJDP10tCm4+xvuWQuxKcu0RUohEEdCrWoW2F2v05KzJjFLyjVEiQiNRBspN0mtyGGaHy/c2sv1DiZE0gf2iKoL8BjgornjjDTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372041; c=relaxed/simple;
	bh=3594gwA3mJkkf4GzIrd+4mJpgDHreMVCWU6cv7ipCbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=En1iuP01D3pd2RSzv8EcglLxSVevdtjX/p5oJnr22v38FLcRD0CTEuU5w3m72zrCCQYk5btuSmvFVhDrrbW7kHT0NWajxK/zaxBJwzIzFdOstZwreifwfZIUFPS6Y7uethg1M/ji0K+C/osPSX/+hsKlJKk5eXeMgyyBo2lgZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM+m+xSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0537C4CEF5;
	Mon, 17 Nov 2025 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372041;
	bh=3594gwA3mJkkf4GzIrd+4mJpgDHreMVCWU6cv7ipCbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jM+m+xSsMkOD4Wui2twlJVNrs0KY1xjGITAbFRgVB7ivgAaJ0ebYN7o9QhfrrW1o2
	 oZvGCb60b8BZPT7MpoNTNzqDOh9uD7vYzqTUNcm8fVKfNLwM6Gdx9To3xMYnQ3RK+M
	 8dbdPU3oze39sw6BUWB09x70IM++PHH3//uh5B7ZCne3f6bU9kaYqhdXPxxQ7jRWoV
	 Zx4saiWw11yYUHh9uUp/t7ZCrrHHPb9Ghw2S3zVTyM8xnjkqp5IxqZ6u8+5irdhjzO
	 7Il3q+9FIOUQrUwFPtE6Qp5R2H0Cz+RoCkAgKrxmELOaCm8CdBNSdAdmAq0gqDE45i
	 ks1QyA9oMUsOw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:40 +0100
Subject: [PATCH v4 09/42] ovl: port ovl_fsync() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-9-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3594gwA3mJkkf4GzIrd+4mJpgDHreMVCWU6cv7ipCbk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf4a8ubqrFOV/ssSRE9fl+D/cJq5dQNrxMXptQnK7
 TeuaJc4dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExktybD/4gtfW4Jd+pXrWor
 eNrywM+C5UTMjlWOx/x1d04Ki4rvc2VkeHgsOGpnTf3VCT1CGf519o4hr/qyTKM6uGa4nrbr/8r
 DCgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e713f27d70aa..6c5aa74f63ec 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -446,7 +446,6 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	enum ovl_path_type type;
 	struct path upperpath;
 	struct file *upperfile;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -463,11 +462,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (IS_ERR(upperfile))
 		return PTR_ERR(upperfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fsync_range(upperfile, start, end, datasync);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fsync_range(upperfile, start, end, datasync);
 }
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)

-- 
2.47.3


