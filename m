Return-Path: <linux-fsdevel+bounces-69566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D80C7E411
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930284E3156
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88BB2DBF45;
	Sun, 23 Nov 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6CQZeSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138372D7DE2
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915711; cv=none; b=q8jd/hbG8CT33ko8+z19nMMRwnESVMAYjOM8s1YBwu0FJAAQBtyFbWPjr1LRA5rz6geqBjtdKSpi+R3BYSFKVqUzFhoZJYDYrhRRz/jQBF58Ks3lSJWBkD5mDxvlWKMR3oVIGOfWHO4WExl5KYFuUyRp+tMhpzaowxLR1GsNgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915711; c=relaxed/simple;
	bh=+wPZfd7lmTHIKiTRUWfhojrF+IKhBYg0IQHn74Y6AE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K45PpWNeBVeslRRuNiIi3LK9jRO5p+qxc0XzSL/d+CPYUnthQ/Gm92geuvz737xwEsGt0rPLXlQbUtDiPOeiBeF12CBt6OQcsBzThiSuY2rFdW6BFoGIPJlDeaScOWDwFrqXpcFE/hPFjbSA9xWghRq1f8HXbeTN03KXWNljvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6CQZeSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DFAC116D0;
	Sun, 23 Nov 2025 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915710;
	bh=+wPZfd7lmTHIKiTRUWfhojrF+IKhBYg0IQHn74Y6AE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z6CQZeSSdFmxa9s1bwf/+EsmMUiQBHIIdwTQ36EPobPrLVq0YzXIsVKXJ3H2FuUtX
	 WrzBM87f50doStyjIJ6nFnKJuuXW7oRvmKtsHr6OAla3D1uN/IVdmip762NL6/c94P
	 71rxWWqxNdCIP7FHTcsHN/Oy7OENXFAFyd4uKgsijXYl6ChiUPwPkyCtPoVFRdRcVU
	 4O2YWbgpGdpZvbAxMBu6Xw9NcTW9dW8t0twHYkkoYdeKAfcIoxPC1Galuc/Yx0ysLr
	 P359nTyQL9hj6/d4Yt4GWjCjFIMaGCce5mxphGxQs72mnUDEZdUt4VTAFBBqzIEJKf
	 M+/FyYMtFnK5A==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:34:02 +0100
Subject: [PATCH v4 44/47] file: convert replace_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-44-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+wPZfd7lmTHIKiTRUWfhojrF+IKhBYg0IQHn74Y6AE0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dPd5AVXi+qeLDD78vln9eFDXVLZYI7PSLnuqX0b
 hBju2jbUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBFRZ4Z/ihZ2JzUWLiid3WQw
 Kfqoz6SE40qSmWxPV/kncr2XdIq8wvBX6uGu3LVn709l15ZZ+4p1eWjD59BNnHsuLNNwWZP2wzq
 DDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..7ea33a617896 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1357,28 +1357,25 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  */
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
-	int new_fd;
 	int error;
 
 	error = security_file_receive(file);
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	FD_PREPARE(fdf, o_flags, file);
+	if (fdf.err)
+		return fdf.err;
+	get_file(file);
 
 	if (ufd) {
-		error = put_user(new_fd, ufd);
-		if (error) {
-			put_unused_fd(new_fd);
+		error = put_user(fd_prepare_fd(fdf), ufd);
+		if (error)
 			return error;
-		}
 	}
 
-	fd_install(new_fd, get_file(file));
-	__receive_sock(file);
-	return new_fd;
+	__receive_sock(fd_prepare_file(fdf));
+	return fd_publish(fdf);
 }
 EXPORT_SYMBOL_GPL(receive_fd);
 

-- 
2.47.3


