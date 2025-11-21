Return-Path: <linux-fsdevel+bounces-69424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DEBC7B2D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282503A34CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB4351FA5;
	Fri, 21 Nov 2025 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRA32frt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6652F0C66
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748106; cv=none; b=lm70evX6zT6TFYLGVbofFUa5P+Dzi6Z/8owcEDNlZhZIYkSXeRv9GB0B+KSrcuNpcnkrj1f4aRhtelOp290ZgOfP+x859NI+3nL9/9hY0e4MP4e1/0O9zI6qIXpCqY1YTx0ZsYIko1TJETbe8/Jf0aaPOQKr3fILgkF6bG5qGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748106; c=relaxed/simple;
	bh=T4FWzTQOitQ4DVvCbgYoLbrz1Ul4RTbnFmU3Hoq69V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIu3UY3pjM8teu4dtM/7f7/qXL4n5KnARi7hPWDodBpbAx2JSNNgEhP0yYkUhvVc/A8hrwLGs2R1ACrCDahw2dAuPNu3e2Mp0RfZN5nr2piYo5ockUWNBgWzclyPEC9VVrLGfhT+r7mntkqXDtJxHA30nmF2R2DDfEVtFLvqpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRA32frt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34FEC116C6;
	Fri, 21 Nov 2025 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748106;
	bh=T4FWzTQOitQ4DVvCbgYoLbrz1Ul4RTbnFmU3Hoq69V0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jRA32frt4zLzeDHjxMCcKZ00RHZ4NGx5+RwcCO8ooaKvORCbVwTtRZ5xl0XsjD+IV
	 kd1bE6LoE4LylPYmffH9bNLt/7LmLFAYx6xAy0yZ8JvN3T9ATihoQm9do+ssrywxiN
	 asgX6ADzoxKVYR8ln45XYwlJ+pfXhSq/nJOnhjbIKgl2GM/olHUr5Zx4wD1OfH1/9Y
	 hafKM6HGCRKFOzZhNXGeMKXM5bb/6CtpvM3U8krtWTjOjEWXx/vrAmp6nssBahAD92
	 b++1BSQChy8L95SHry29pcvsxR0V8fkAofSPJR0l36E3YBET3zRry+9N9XMUbl5VMo
	 PWl7yW6XdoNpw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:05 +0100
Subject: [PATCH RFC v3 26/47] secretmem: convert memfd_secret() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-26-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T4FWzTQOitQ4DVvCbgYoLbrz1Ul4RTbnFmU3Hoq69V0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLiQuUzktOZU0e/L0zzOX3qbFzJNwrOdVcPlj9nzJ
 3461+TsO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi/ZPhv5uM54N58zpmv13M
 /H3vXk2Bcy1FrfP2V1cufbO7R5O/8Bkjw5I35+zvz50nv3P/bG+PfNWY22tSV3UsXl+htmHHJme
 7s5wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/secretmem.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..b3cd9a33f68e 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -224,8 +224,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 {
-	struct file *file;
-	int fd, err;
+	int err;
 
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
@@ -238,22 +237,12 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	if (atomic_read(&secretmem_users) < 0)
 		return -ENFILE;
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = secretmem_file_create(flags);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_put_fd;
-	}
-
-	fd_install(fd, file);
-	return fd;
+	FD_PREPARE(fdf, flags & O_CLOEXEC, secretmem_file_create(flags));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
 
-err_put_fd:
-	put_unused_fd(fd);
-	return err;
+	return fd_publish(fdf);
 }
 
 static int secretmem_init_fs_context(struct fs_context *fc)

-- 
2.47.3


