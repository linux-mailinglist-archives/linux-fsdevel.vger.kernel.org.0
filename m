Return-Path: <linux-fsdevel+bounces-59707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C3B3CA50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 12:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7451BA6DE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F5279329;
	Sat, 30 Aug 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UO0h2o2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B494274FCE;
	Sat, 30 Aug 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756551345; cv=none; b=D0gdqSwkcEdCLnG/qFR3nI7czvSoPxA6uRge691Kzz6Mb17+PtsMSdKjF0ofLuHF5ax6FFZjFMeTNmyfkzbscch1+MGYj80d/Wu9w2sYW5c6M4gU870Irz5bawsOMoVtIFtQ7v5Q1GZ3WjoYU42rPMVQL8Den5/e2VuFENlNbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756551345; c=relaxed/simple;
	bh=i5zY8f2VKVpzPlPoYIug3F1ZCRs+538GRcdBf4WSpxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXx+eJhZpKZX82VULeLdW0yq2+poe7AmoR5Yx9e2+bd2FTkIekucYFwV+NSm1CIL1VWmiyUyLLadz/U4E7Pi4RIzhPSAZs/mYMVXP7GjBtKaaBbEYkR8f6T81B4/SPpDkydIzbj+pdOrF30ZgpNXRfwP9l/WRe2Y2s3ZIgBNt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UO0h2o2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A6FC4CEEB;
	Sat, 30 Aug 2025 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756551344;
	bh=i5zY8f2VKVpzPlPoYIug3F1ZCRs+538GRcdBf4WSpxg=;
	h=From:To:Cc:Subject:Date:From;
	b=UO0h2o2wRX7kdL8iB42EKfZMEzk3R37jTXBerrIdbomtOPUpj8a1bC6ZeY/2PuofI
	 UqoaqvT+6jq1Odda8jvKnnEiaFva/5VoUU6WkTTplVWc/4AyyGeru/1gaH0Ckz2zPl
	 fI9Ao0fK9mTBc1Vq53B/PC9/fhdtQv88a0vBqYH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: remove vfs_ioctl export
Date: Sat, 30 Aug 2025 12:55:39 +0200
Message-ID: <2025083038-carving-amuck-a4ae@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 48
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=i5zY8f2VKVpzPlPoYIug3F1ZCRs+538GRcdBf4WSpxg=; b=owGbwMvMwCRo6H6F97bub03G02pJDBmbbqwK8Jm8JeXzIRNFVtfNR20a5q50cdV8+vbi/+Vz3 waEr9lf3RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT+b+QYcFCgWWvDiwMEmBm ZD1qm11otfDSBEGGeea/FfcU+8Smz86eeUhomcuayzNzygA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

vfs_ioctl() is no longer called by anything outside of fs/ioctl.c, so
remove the global symbol and export as it is not needed.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ioctl.c         | 3 +--
 include/linux/fs.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 0248cb8db2d3..3ee1aaa46947 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -41,7 +41,7 @@
  *
  * Returns 0 on success, -errno on error.
  */
-int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+static int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int error = -ENOTTY;
 
@@ -54,7 +54,6 @@ int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
  out:
 	return error;
 }
-EXPORT_SYMBOL(vfs_ioctl);
 
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..ccf482803525 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2052,8 +2052,6 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group);
 int vfs_fchmod(struct file *file, umode_t mode);
 int vfs_utimes(const struct path *path, struct timespec64 *times);
 
-int vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-
 #ifdef CONFIG_COMPAT
 extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 					unsigned long arg);
-- 
2.51.0


