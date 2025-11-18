Return-Path: <linux-fsdevel+bounces-68976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BDDC6A67F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A15DB2B9D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A536A025;
	Tue, 18 Nov 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U07A7D/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1E368271
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481012; cv=none; b=I0S6muj4+a/KpmR8KLqYPMoGBcZR+Tx2kiihRYMNOw5DnO7keO/WVHfANIsOoKccSAoHodiufiaVzd5u2VbEgz8vR/ylnT0AhUniqnPCeXOxJISbGdLBVu6rDbUSNQ8+J1Z4PqAIQw1CqpT7xIpDAyRd8euYtA63MAHKKoFtmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481012; c=relaxed/simple;
	bh=5L7EF+PBndPRwvSrg2aki2R1hOGPcP/wnwweXpJ+K20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYaYrT9dk8aSm7GNJW9OoNKq+bD11EFJ51AKtG/xYn75yXZwZ7zokHAOqNJzmEBIR0KkITsrHiK1NwXMumBpD64G23txK/28Z13SRUOZvjXQkWjEp2SMVsb2+eSHzkr8+67YFJOBFX/8C9jZjOHlety6uANAF0pQCiqLE8GqPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U07A7D/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931BEC4CEF5;
	Tue, 18 Nov 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481012;
	bh=5L7EF+PBndPRwvSrg2aki2R1hOGPcP/wnwweXpJ+K20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U07A7D/ifpxkFg8UECJu0Yzpcc20ZFxkZgrqTGCerT1q0bZ9trpC5J6DpCF5OYqj1
	 H+q9PFDLmv5zfS+daJyOXUyGRrN+cdW8IEI71F77/ELIvHs124xM3zGmMaui0Agfrq
	 URUCcSiHofh9IVvtfHoYjJGR2Ztdj2sdV/LBC8FontAezBfZFdLjiBmwmKyzOroNxW
	 2pkEwvs/oPv5RXnwjrr05YcDwoh3Dp6Qk4pkUDpQMwbARbY2A270Xb2u+ALBJbA7QI
	 KcerLpMhR6Pa9kz5i0FW3EkKozsOPwNltz5tb2mqPzA1WAZwyf0Ki6sOl5HiIOVvLt
	 kihczsFF9zwag==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:57 +0100
Subject: [PATCH DRAFT RFC UNTESTED 17/18] fs: xfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-17-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5L7EF+PBndPRwvSrg2aki2R1hOGPcP/wnwweXpJ+K20=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO338a2MyD6+6dYBpysGkq8jrxZ1FuuX93tW7Mn46
 nIg4D93RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ6pjD8D1wn7iH4LONCKdPX
 pYdn+Szz///5UvRvrSO//teueM34tpORYe4vc/OzJUk9wdpl2759Kvc8vHuH5TNFU/5J/yN8Zwf
 MYgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_handle.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..a507944fe022 100644
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
@@ -279,28 +277,22 @@ xfs_open_by_handle(
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
+
+	FD_PREPARE(fdprep, 0, dentry_open(&path, hreq->oflags, cred));
 	dput(dentry);
-	if (IS_ERR(filp)) {
-		put_unused_fd(fd);
-		return PTR_ERR(filp);
-	}
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
 	if (S_ISREG(inode->i_mode)) {
+		struct file *filp = fd_prepare_file(fdprep);
+
 		filp->f_flags |= O_NOATIME;
 		filp->f_mode |= FMODE_NOCMTIME;
 	}
 
-	fd_install(fd, filp);
-	return fd;
+	return fd_publish(fdprep);
 
  out_dput:
 	dput(dentry);

-- 
2.47.3


