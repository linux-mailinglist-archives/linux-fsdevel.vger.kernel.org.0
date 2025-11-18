Return-Path: <linux-fsdevel+bounces-68966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA9C6A6D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8371A359499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1D36828F;
	Tue, 18 Nov 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCPaAmUI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C8361DB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480992; cv=none; b=fT0+6KXRxzZAK73BTNtv4snjXHukviYf+ViSfTSwjEeQH0iPUcWqRoEgYde1UlkDSAjDAuwAR0VUMbnnWpsKgNtfGS18cgsuAfNPSarwoS3Q79w39hI40WDWn9N12PIE4SLKlzjIsg9RvKzAFOaUhtuQT3C7MItygZ2cw6qagvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480992; c=relaxed/simple;
	bh=MJgpVrhk5OZOlT1RvyqNVhPMCojJiZie5JGv17yyEK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pniYTBTplMGICrNH+k9ECMZal5IyHmF3YNwv+sGD70x3nfEAhyA8a3/FFRDmyHvOFr4bMe8XW1qMMEjLW9L16zfHLpBIeJMqEJSxsN1wS4ArZsm3qyh6hb0eHnB9AcDCRqvEc/xG3WxBMxQhq4qgfpKCqySq8KBxvr21QNNdBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCPaAmUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D01C4CEF5;
	Tue, 18 Nov 2025 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480991;
	bh=MJgpVrhk5OZOlT1RvyqNVhPMCojJiZie5JGv17yyEK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rCPaAmUIpFlVfSeLIVjIBLpEanpjIJzSzsikkjobjLEdD0VRv8x+sg6/vvA/POUx3
	 5Vjfu+fuz+YvXeiSx6655CutuDtiSSYPzGnww93y3qioPJKHmAIWKNl163S77hhaLf
	 svnNBgAA7ONkmRPvfRKt5+RPa6CBp0fYQOdR/nz7Jj8czAzpRXd8WI5DDOQ/yjC3Xu
	 SrzI9auqpj/e4e5o5Np3wg1cFDv72zTrNum2QOl9wZ30QFrORhlQEEPZQ0J9DefCa5
	 OSE8QHJy1MwDi3Q4apZMmP5gQ29NHEkWVovtefunBxlL0SkR1sEHEdL5hmy3OkJTts
	 vAlX6zWccMjrw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:47 +0100
Subject: [PATCH DRAFT RFC UNTESTED 07/18] fs: fanotify
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-7-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MJgpVrhk5OZOlT1RvyqNVhPMCojJiZie5JGv17yyEK0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO1X1N/DLyi9/maw2PJj828xTJz1ecfcU5t52hQ2C
 deEPQ3e0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARXx6G/7GPD/dN75q8PYxn
 yc+lIW+ib1g083R4WS/61iud4nVx3glGht1sa884tP5d1fXAj0/tNOvH2DSFoD9VElvrz353n7t
 vAgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1dadda82cae5..4f818b0ce3be 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1606,7 +1606,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
-	struct file *file;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1755,19 +1754,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			goto out_destroy_group;
 	}
 
-	fd = get_unused_fd_flags(f_flags);
-	if (fd < 0)
-		goto out_destroy_group;
+	FD_PREPARE(fdprep, f_flags,
+		   anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
+					    f_flags, FMODE_NONOTIFY));
+	if (!fd_prepare_failed(fdprep))
+		return fd_publish(fdprep);
 
-	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
-					f_flags, FMODE_NONOTIFY);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto out_destroy_group;
-	}
-	fd_install(fd, file);
-	return fd;
+	fd = fd_prepare_error(fdprep);
 
 out_destroy_group:
 	fsnotify_destroy_group(group);

-- 
2.47.3


