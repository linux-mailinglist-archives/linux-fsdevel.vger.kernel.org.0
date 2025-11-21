Return-Path: <linux-fsdevel+bounces-69402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D859C7B30D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD4351777
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B5A2F6918;
	Fri, 21 Nov 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW2fwWG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D641FF1C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748060; cv=none; b=ASG+AmqMvRbN3Qw7vKsLY8S4iGd/PWs81gXTs7W5rMXUqmCTtERPn2BYCKKThnwYkx8AvFTd4azCbHJpNBYe2KVEdDwZBKa/7R4m9CCx+jdMnD3v6Ks5zgVIMhTTTyUA5jL7ak/a5stTZJDg4LB17F+beGOojNPhqfexohYv4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748060; c=relaxed/simple;
	bh=uX2GwxI2hZsKcDpzLXwsUGK075bwTqFYtcSvS0RkKoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Im3LiI67H9ncdbdcXr2dGBpP1EdEcOrI+wnp5QrdrWVO6KQem/1nZisnHbeYYqH0u7P77yDzqnR39P1hXJ6bLjxMlqsQ2F1ZMPi5EzFNohC13jJkb8wRoT2NQFzA9z3qUY0qkwUtr6KfZi1r68xtM1Q2UfMrguu4MstlsKVCFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW2fwWG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C189C116D0;
	Fri, 21 Nov 2025 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748060;
	bh=uX2GwxI2hZsKcDpzLXwsUGK075bwTqFYtcSvS0RkKoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NW2fwWG+v06g9/SBFXX2KzqL9itGr5VK4YyGC7dZ7Gi4TzNIQl7OxMV3tD4tvafeg
	 mM33pOYuZlKx1jtU2lB+l+PoqWeJ86/0qxTTHiiTh244Q2xWjtQjAFHgso/o4eRh9n
	 +CCFNX87kPpS9GhrrPenDVsnrs9T68LTg29x3KrdQ2SiJcxuJezKrEsNEwrrHZejRn
	 mnxZ0Q+sQMIutqS2KBOMvNqBuD3FsKxwr8J2XJjxEJKNxyCIORDecFK/OgAKPVy+4J
	 ZebIhOMZqcyAmcXiGpiUVzY91qeXTNPuh5j3bt8qU/aYZ8GGu3+35wBcO+fgQTo4gJ
	 LZhzpBkvcfVZg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:43 +0100
Subject: [PATCH RFC v3 04/47] fhandle: convert do_handle_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-4-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uX2GwxI2hZsKcDpzLXwsUGK075bwTqFYtcSvS0RkKoQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDhvf71m4x79/j3Wy83FoytWvE5b6vf915qG7p6I8
 GPd09qedZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkCzcjw4PiF3P+8qYke1xn
 4N/+fAND6RV/scqrU1gS7j2Sfbw7ciEjw5VPLuvPru+uNgphLrXgzW79bf/p57PdG9/r2IZ9yBR
 8yw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 052f9c9368fb..e3d6253b1ebd 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -404,32 +404,33 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	return retval;
 }
 
+static struct file *file_open_handle(struct path *path, int open_flag)
+{
+	const struct export_operations *eops;
+
+	eops = path->mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		return eops->open(path, open_flag);
+
+	return file_open_root(path, "", open_flag, 0);
+}
+
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
 	long retval = 0;
 	struct path path __free(path_put) = {};
-	struct file *file;
-	const struct export_operations *eops;
 
 	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
 		return retval;
 
-	CLASS(get_unused_fd, fd)(open_flag);
-	if (fd < 0)
-		return fd;
-
-	eops = path.mnt->mnt_sb->s_export_op;
-	if (eops->open)
-		file = eops->open(&path, open_flag);
-	else
-		file = file_open_root(&path, "", open_flag, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdf, open_flag, file_open_handle(&path, open_flag));
+	retval = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (retval)
+		return retval;
 
-	fd_install(fd, file);
-	return take_fd(fd);
+	return fd_publish(fdf);
 }
 
 /**

-- 
2.47.3


