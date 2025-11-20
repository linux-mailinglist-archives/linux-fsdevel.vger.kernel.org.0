Return-Path: <linux-fsdevel+bounces-69287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BDEC76816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F21134DDB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02030AAB7;
	Thu, 20 Nov 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNaJKAIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AED28B7D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677954; cv=none; b=Q9njr6Qw7Lpz9hTtFh0+E4lhRtAG7KXWyjTXhdtEn6tlI1eZuVl1BX6q/PdRb61Zie9/ey3w9c3D78xf/F2Q+YhTXgb8ftXu3/jXUjNWKTzG9CyIXO9gxkvH2wL6TYbIYk278c9bSQNQckWyTnGYBPEbjnmGP40jxyhjxPXOqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677954; c=relaxed/simple;
	bh=TGSVYHdNdJGAWWG7xqL6SSs97oQUM89nVu4eCxJTGnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbNa2+8iSyZqmths3RdFHFh6Q97SC0vdagxWmcaryHxHzDRj8faL2gdyOUtncgbcpEHvXT/R0BJKAQUeYuSP/XHlVDWo4BjmpOPlx85k0Y1c61Wn3dGcMP6HDXaWu7Gin+L9WPyfA70w2MPOzdz9ze1A58aDNi6+2nIM/PINjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNaJKAIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43212C4CEF1;
	Thu, 20 Nov 2025 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677953;
	bh=TGSVYHdNdJGAWWG7xqL6SSs97oQUM89nVu4eCxJTGnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HNaJKAIAAy5CfolDIkklqwcLChx87gZNh7syAAKJEFeTd5pyivPu5SbgnEtttjlKj
	 BFykvuvP6vLLogC1Qt8m8eCsw+fgY0DTH4p438EyKZDqsdZhkkcvwVkR9ZERDpGexb
	 tjLuCZWhm4S+aX+nTTg+pkRcRX6YhN1uhRiGLZEOiKyCYveTcA54eoXHJPEXe0FCPC
	 TMZZmk7JRQ7p3HQgOVxuEGK4o9ITgEfP/qYSTPPwn31hPOidy8OPyoZ5BHBrYClX7X
	 bUcOcV69FNYtgQTiVBeEDdDdqvgaJrMEOrf2PTo/CHqPU9Iajv8AUXs+vuLju7Tcp2
	 yUMWCybBz8r3A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:05 +0100
Subject: [PATCH RFC v2 08/48] fanotify: convert fanotify_init() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-8-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TGSVYHdNdJGAWWG7xqL6SSs97oQUM89nVu4eCxJTGnc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3tz2kBO+UjE1cC6Tk5nHi32vy/ZGs7tXHrMpPj44
 Q/TmyvOdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEg4OR4WjN1X0Pve8f/m7/
 oy903q+kqNDFUdc+TQ3YO+tU2Z3ZFmyMDD12v9Q+MicYz2V9w8TV8ZvLsOeRZrdBV3Hiy6w9lQd
 auAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1dadda82cae5..f1541970c2f3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1606,7 +1606,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
-	struct file *file;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1755,19 +1754,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			goto out_destroy_group;
 	}
 
-	fd = get_unused_fd_flags(f_flags);
-	if (fd < 0)
-		goto out_destroy_group;
+	FD_PREPARE(fdf, f_flags,
+		   anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
+					    f_flags, FMODE_NONOTIFY)) {
+		if (!fd_prepare_failed(fdf))
+			return fd_publish(fdf);
 
-	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
-					f_flags, FMODE_NONOTIFY);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto out_destroy_group;
+		fd = fd_prepare_error(fdf);
 	}
-	fd_install(fd, file);
-	return fd;
 
 out_destroy_group:
 	fsnotify_destroy_group(group);

-- 
2.47.3


