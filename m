Return-Path: <linux-fsdevel+bounces-33523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561B9B9D00
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8F91C21F3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB5E188907;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JatZtsMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1414AD38;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524114; cv=none; b=hf9Jlh9FgQZnWTqnV/bauxckMEsHAxo1OpivGylmr6L6LEafVkxa7tlVU/c9CK2M8SwXj94qeQ5QWmOI5buU/m6A8zK49Fmtk1n1vukuwwxt3z84rzqTXwTeuOiIMNv65p6xviTEAgouSCsxtDgkIIqYZun2BHl/9bAmbzDKhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524114; c=relaxed/simple;
	bh=dm+OiAozS+p8UmpZe+U/PsxH/SYbVmjiUE+walBTZ3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiBZjrsCVMkZMW3+BqTGs1RYw5XGEbTdihoVyYa60v0iUuVOglBjzwqXiOBdDTvJwZPQPTfPiophM1wQRNSm/fQ0oigJH6HCwdI8SdPGr43jFz0ANPJmD6aAGT9IYjdrc515rXUT3AioHDVJ6HW9iTu0U2DrPfS6rtRvOsMfxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JatZtsMv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/K0BhcmjV+4n73u3iSBYsRpOEGKMqyoFmjj95TPWqvk=; b=JatZtsMvjHWvPoHucMRy1eqPM4
	5pfZOU8AFr3Glh+EeQeKpwjMRInKOUemRq2iEZR5Jr+K3RyG8EfVpXTwLjrNWvE7R8EZUSpa1uabQ
	uFXSCUvxjUsYPTzVB26dp0F5cLPQSGphuUlbDq6QyjvOeOAStvcKE93mmo+Ojx2ip9at5J6dxiFZN
	2iPmCQjmH+MHjIN49b9NCw9ih/TokBlBlFkdD9EklFcYQjLx9d3dAy7D4CInYPRqOv+qPGASn3s60
	TT+l/ArC5d3AkjE5CgNfVofTTkhSyi5MpDFB5KYQ08vAC9N6kRiZxvuvNadcw57+3Obr6l+ZYn6LQ
	bO+cTIvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHnp-0XHv;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 21/28] convert cifs_ioctl_copychunk()
Date: Sat,  2 Nov 2024 05:08:19 +0000
Message-ID: <20241102050827.2451599-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdput() moved past mnt_drop_file_write(); harmless, if somewhat cringeworthy.
Reordering could be avoided either by adding an explicit scope or by making
mnt_drop_file_write() called via __cleanup.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/client/ioctl.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index 2ce193609d8b..56439da4f119 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -72,7 +72,6 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 			unsigned long srcfd)
 {
 	int rc;
-	struct fd src_file;
 	struct inode *src_inode;
 
 	cifs_dbg(FYI, "ioctl copychunk range\n");
@@ -89,8 +88,8 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 		return rc;
 	}
 
-	src_file = fdget(srcfd);
-	if (!fd_file(src_file)) {
+	CLASS(fd, src_file)(srcfd);
+	if (fd_empty(src_file)) {
 		rc = -EBADF;
 		goto out_drop_write;
 	}
@@ -98,20 +97,18 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 	if (fd_file(src_file)->f_op->unlocked_ioctl != cifs_ioctl) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "src file seems to be from a different filesystem type\n");
-		goto out_fput;
+		goto out_drop_write;
 	}
 
 	src_inode = file_inode(fd_file(src_file));
 	rc = -EINVAL;
 	if (S_ISDIR(src_inode->i_mode))
-		goto out_fput;
+		goto out_drop_write;
 
 	rc = cifs_file_copychunk_range(xid, fd_file(src_file), 0, dst_file, 0,
 					src_inode->i_size, 0);
 	if (rc > 0)
 		rc = 0;
-out_fput:
-	fdput(src_file);
 out_drop_write:
 	mnt_drop_write_file(dst_file);
 	return rc;
-- 
2.39.5


