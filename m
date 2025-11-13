Return-Path: <linux-fsdevel+bounces-68328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E86EC58F6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649B0427E58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E6369966;
	Thu, 13 Nov 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC3RJX3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170730BB81;
	Thu, 13 Nov 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051914; cv=none; b=foYasaMRJD6x+tUsa2FLoADeA/v155OrO8uPwkqk3FmWMJFk2FJchkevUeT+bsWY0lYx/3pk8OWRXCtOqViLN8RyhjxdkTIInbmXZT1UuPt2rzknMFhGACC74wlkc9hvH2Er5S4swYRAWgvJbkTyOeeE5t5IlUUA24A6obaGsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051914; c=relaxed/simple;
	bh=cX0ivMUhUZg0Ag9i5XDln1NVjc/AyRza93nUQ77bgAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEOCSUTEn1wnqCkFsJy2wJKyp+LXh87/raFFPkeGLXiXszviRjXEJvlBNjMtYTwvwGwpkfJ7j/iemmSDkMMmhHGEL/J7Zm5EPHsQhA6kkDsy/jNn6vrfk4Tb4LJSmJrBVtJScTvJFKbY4kzTPB88td5KL++oQ0DTdcokqAkUljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC3RJX3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BE9C4CEF1;
	Thu, 13 Nov 2025 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051914;
	bh=cX0ivMUhUZg0Ag9i5XDln1NVjc/AyRza93nUQ77bgAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iC3RJX3mIonpWF6O6QN7ESBysiVKd0CxfMGqG12xq70kC+Pp8qQEbGuwUJyevFkm1
	 XyEdChI14wFY7WwVEtEkg0EKV1DvVmSutKhbSIBM9x4/VzwajNOXBqUW5LF2rZI/3B
	 DCYLjR6SpykUkvQtvhvvpxEwhCxkLrbDKpb0+63NHDLAqkYxN2oN0rBWpQ9Y5XCE9d
	 mqII9AquaQ4dxc7YL18cJu62iHkfUkJcaBGBI87UoSsGt+oPMpxy/A25yAq3GE2Rw9
	 TfdzP5/X4vY9tiG3Zw4LZjDSQme8P8FlY/ixxYfJrINv6Ni8VIV6LusO0xSbz8TQQj
	 316+r1oauX0jg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:40 +0100
Subject: [PATCH v2 35/42] ovl: port ovl_copyfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-35-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cX0ivMUhUZg0Ag9i5XDln1NVjc/AyRza93nUQ77bgAM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqf+ah1yK4mgu2jytRz9Vr7mjn4rOUzXz6Yrbtb6
 NbtyS9mdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE5yDD/+KKmOPPPxxqP3Tv
 1t43Qk7i7We7zZLOL4+2D1KMXbk+I5aRYdPK+NepdopLQ0Oy5CbFtPNNfpddqNj/XGrymqPnmKs
 a2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e375c7306051..42a77876a36d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -531,7 +531,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_out = file_inode(file_out);
 	struct file *realfile_in, *realfile_out;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	inode_lock(inode_out);
@@ -553,25 +552,27 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	if (IS_ERR(realfile_in))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
+	with_ovl_creds(file_inode(file_out)->i_sb) {
 		switch (op) {
 			case OVL_COPY:
 				ret = vfs_copy_file_range(realfile_in, pos_in,
-					  realfile_out, pos_out, len, flags);
+							  realfile_out, pos_out,
+							  len, flags);
 				break;
 
 			case OVL_CLONE:
 				ret = vfs_clone_file_range(realfile_in, pos_in,
-					   realfile_out, pos_out, len, flags);
+							   realfile_out,
+							   pos_out, len, flags);
 				break;
 
 			case OVL_DEDUPE:
 				ret = vfs_dedupe_file_range_one(realfile_in, pos_in,
-						realfile_out, pos_out, len,
-						flags);
+								realfile_out, pos_out,
+								len, flags);
 				break;
 		}
-	ovl_revert_creds(old_cred);
+	}
 
 	/* Update size */
 	ovl_file_modified(file_out);

-- 
2.47.3


