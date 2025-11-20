Return-Path: <linux-fsdevel+bounces-69307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43FC7688F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBB993570F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1B32C943;
	Thu, 20 Nov 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8l6xHUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBC2ED873
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677993; cv=none; b=d7cq0bXexcLc2WqvR0s2wPFarPpntEvvYFng2lNHwb6yQtfRIP3qaLaiz0nVwD9LIw/9n7Uv785jLMnKxPMeQOLorx1S1acCV6PrTYZdSGMGhfrpDbiqSwYJ+DQJvrSP7m7vmTsqfW8EBhQUPnJ2sfdkN7iDWiNXwVgSf5J0oKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677993; c=relaxed/simple;
	bh=phgbI3EKLeVNM76JNcN2P5t7PTvV5D37K2EJ4zmt4Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAWJ/t/BYrokRvBQNP9kdYYbSnxInHLM2ncWhnK3nTykpYlgzq1lqIejJgBmaLUmKwQhw82g/vADT+9EfFQvoX7O09Vf61odJ/OLWj6nTPaIMNhKPnkZSC8lbKN9q/WBLVfbZNtm9KvXKNlQ0TMMgm0/Ca2QhSLRLXIdTuUwleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8l6xHUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3E7C4CEF1;
	Thu, 20 Nov 2025 22:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677993;
	bh=phgbI3EKLeVNM76JNcN2P5t7PTvV5D37K2EJ4zmt4Mw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T8l6xHUu0IA6mWeCgC1HapnKvURIlzs9R+IT6mZb0ksoeReCPfLdSIkIc1rOLqNS7
	 vdB0TTnWgzML2AFDNXJlc55phOC5rYngoCOiEHXowm+obM1AVYJKdB9y5tjrVOzBqO
	 fHBFANgtBHcvbmN/hTjEein6nMnCZi0TnFHjxDI8YpaxwiNbORwS33KsN7zsI8yaI7
	 2s1bFNx+Qn0yYTqM1p2kaKc9y8hIVvk10Ki6TfHTNJX+C3266t6yAsfL7F6Op7md7/
	 v1c/B40TJ0bVrk1qVFjD2/RDciXq5I9eQHqDds8m2iwpDMuErjQPoFdi2Cny2eJ+vs
	 iwtgCwZjyXqkg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:24 +0100
Subject: [PATCH RFC v2 27/48] secretmem: convert memfd_secret() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-27-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=phgbI3EKLeVNM76JNcN2P5t7PTvV5D37K2EJ4zmt4Mw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3v7z7SKK7dCtKDQ/cbuaDmD7t06D6oYneeGB6y9f
 uH/69fbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby5SMjw0XLpeWK7myBM4Qe
 5WreE1vqs7wqqiF7tdMzlsYUe/P3/xl+MSsk/C3i5dmTNTeD6+NJmQrW7gMqkfu1PfPETB6feWj
 JDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/secretmem.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..a41e67090868 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -224,9 +224,6 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 {
-	struct file *file;
-	int fd, err;
-
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
@@ -238,22 +235,12 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	if (atomic_read(&secretmem_users) < 0)
 		return -ENFILE;
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdf, flags & O_CLOEXEC, secretmem_file_create(flags)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	file = secretmem_file_create(flags);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_put_fd;
+		return fd_publish(fdf);
 	}
-
-	fd_install(fd, file);
-	return fd;
-
-err_put_fd:
-	put_unused_fd(fd);
-	return err;
 }
 
 static int secretmem_init_fs_context(struct fs_context *fc)

-- 
2.47.3


