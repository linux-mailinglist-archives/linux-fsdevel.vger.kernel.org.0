Return-Path: <linux-fsdevel+bounces-33536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717C9B9D39
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E841F222BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E21AFB36;
	Sat,  2 Nov 2024 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="huNnOMtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB8156677;
	Sat,  2 Nov 2024 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524119; cv=none; b=OpmKd1IcLI4kOESRPUqxZrTid0Df+t/vEIdK7MhWu5RKwCnzYeghBLk4yOBPEr8w4rmUSb7VUeOOLN0H3hG8dN3Xg3NFNhyfZYWksKlqhl6les1QkboZeTXdP2Xy9+xxlnD4Ym7NzZf0whTLjnSg6rri7oNs0qDWVH58xMvruLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524119; c=relaxed/simple;
	bh=8n+a72F1MMgWJSpNM2jYjMQ0wNtQt8806+CMxamxLxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSsJc/w0JtfVaTH603+tEqpKvVXyui6dT1qRvxc1wvw0GnhR72nrVViTAnAaZoZ0wWZKS97vIEwopM1In+GzZxCp7P6T1/F86WsmZk3k4tvMbqFbZjIipCq17OKuLQFVTeRXNOo7tkuUltTyXMAZPuJ7Kq91d/jZ66xuDOXcVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=huNnOMtH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=88OljO2gswdjRnWBPxwVZr7JdO5DnVjrbylUMSLr6Xg=; b=huNnOMtHmFnF2wy3ZvgntP6Y4k
	tlXioTWB81Or88deIrmGBxVuYQYIglP5EN7zDGMoWaiuOgzxiWvb2zCET92hor5yJaDAAFtMx7K2W
	cJ9K0K/gzEFtHZIP3oqA39Skr9Dg8+JPa4z82nNsEtHpd642L0/BR+Vr6eZj2Q/0cIEu9exjab659
	iCa8KdwdSm6qaqjum0QQ4Amien3kQXjnIujpnoLZGXPKDre5XDlX+LIG++GpWz2DHaYbgu1udiUP/
	jVUeqh093msyHf//iW16V4TtH3qDurWGV2yTyCHsEFeIIM5uNHgu7x0gtZz/p6q1PmMNzYbkJf56X
	qhSaPb0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76N9-0000000AHm4-1Qas;
	Sat, 02 Nov 2024 05:08:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 02/28] regularize emptiness checks in fini_module(2) and vfs_dedupe_file_range()
Date: Sat,  2 Nov 2024 05:08:00 +0000
Message-ID: <20241102050827.2451599-2-viro@zeniv.linux.org.uk>
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

With few exceptions emptiness checks are done as fd_file(...) in boolean
context (usually something like if (!fd_file(f))...); those will be
taken care of later.

However, there's a couple of places where we do those checks as
'store fd_file(...) into a variable, then check if this variable is
NULL' and those are harder to spot.

Get rid of those now.

use fd_empty() instead of extracting file and then checking it for NULL.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/remap_range.c     | 5 ++---
 kernel/module/main.c | 4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 4403d5c68fcb..017d0d1ea6c9 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -537,9 +537,8 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
 		struct fd dst_fd = fdget(info->dest_fd);
-		struct file *dst_file = fd_file(dst_fd);
 
-		if (!dst_file) {
+		if (fd_empty(dst_fd)) {
 			info->status = -EBADF;
 			goto next_loop;
 		}
@@ -549,7 +548,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 			goto next_fdput;
 		}
 
-		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
+		deduped = vfs_dedupe_file_range_one(file, off, fd_file(dst_fd),
 						    info->dest_offset, len,
 						    REMAP_FILE_CAN_SHORTEN);
 		if (deduped == -EBADE)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..d785973d8a51 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3202,7 +3202,7 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 {
 	struct idempotent idem;
 
-	if (!f || !(f->f_mode & FMODE_READ))
+	if (!(f->f_mode & FMODE_READ))
 		return -EBADF;
 
 	/* Are we the winners of the race and get to do this? */
@@ -3234,6 +3234,8 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		return -EINVAL;
 
 	f = fdget(fd);
+	if (fd_empty(f))
+		return -EBADF;
 	err = idempotent_init_module(fd_file(f), uargs, flags);
 	fdput(f);
 	return err;
-- 
2.39.5


