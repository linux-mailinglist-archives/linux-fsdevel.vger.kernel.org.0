Return-Path: <linux-fsdevel+bounces-68382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E97CC5A317
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF784F38A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E8032826C;
	Thu, 13 Nov 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYpd80i6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCA328241;
	Thu, 13 Nov 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069577; cv=none; b=Zytm+dHCujefKMlD9+j2GLhV8GB1Uz0QMVMUi0n+tMTYkn1BG3PFgCSqLG5oET54TasqeARlOHBZpYWwFD1uYcWuO4M8tSNfao4Bl1VsPcTVTQI3YLSsEal9RR96oaTfHqVPDj4pRCpzrr1VCGnH6VBM/gOvXOe5qC032QWjXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069577; c=relaxed/simple;
	bh=kYCUylFAPzr/aYBb9lV6HWt6jl5YiVAS5GSPj55wrTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvn4jU5k3CX92D80rtgBMemMiLrsOiM6odCWjjXrPfd+XOtPkUEzl93OCXw4sHsu183Jl+UQpxD3DZv9/SKKHRBuuiVYb41+iofgd20jKCGdUGJNH2jer3fMFA479WMp/Z4jQXhzpxo75oIQyE9uIa+cP9H4/jx5ZJiS32I9C3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYpd80i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C56DC4CEFB;
	Thu, 13 Nov 2025 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069577;
	bh=kYCUylFAPzr/aYBb9lV6HWt6jl5YiVAS5GSPj55wrTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FYpd80i6zrqLNmdR9F8QbibU02rkEERr/AVrWgHskrr+Qn5lFv1+ZVBMIYle81N6h
	 QXWgDaRD3fN/QPKXj9TDtjbu3bmPZWUmihvHLVyPKCqW/7hyiRMTk/dL+J5a2XaVGG
	 fTDBTITPtSUxFFLZXADm5wDCPyG/zMDE54pfHhdEwEK3JQBu5z/5ruN1URcLtpFvJS
	 KhEJRXrvC5+I2zdyhX/jNdo9mknE0NmOsbM3RagktFUb/s5cGYNlTy6Dq+12pOikhq
	 AfjOPwHPMK1GfenmEuexjmolQFumMzEMuX9k+v4JbKwYU42MJ31F7KqAACHKszJYy0
	 Fmc/zDGPMXO4w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:09 +0100
Subject: [PATCH v3 26/42] ovl: port ovl_dir_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-26-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kYCUylFAPzr/aYBb9lV6HWt6jl5YiVAS5GSPj55wrTE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YV3+7pYMj/rT/ksu6ha+YVQyWPhtAl/yxWCog7vT
 raf5Hi+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIZZxn+Oy9Z91t3TujJ/qMf
 ljxezRiWG3eocE8dS5T4zLwjVwpecDH89/yRnNJjpxLyuXhWTdoHqSsmOWpGntFmjEsjX0xRfGr
 EDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index dd76186ae739..f3bdc080ca85 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -941,14 +941,8 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
-	struct file *res;
-	const struct cred *old_cred;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	ovl_revert_creds(old_cred);
-
-	return res;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*

-- 
2.47.3


