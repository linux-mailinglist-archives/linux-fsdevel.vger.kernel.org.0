Return-Path: <linux-fsdevel+bounces-69417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA6C7B2C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7659A3A14A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91934EEE2;
	Fri, 21 Nov 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOpI1YP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9663385A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748092; cv=none; b=PGf9JalIh0/ftStLuLF4AHL+3v1LUWLolkyYXNXKM6e/dClIrCt/N5NOApvlwHLUY1iWU9HkiabaVi02Fsqk5Eo/PkeUwv0ILcEuIz5je1RMRvbRmqIFnvL8EM7vGWB84yYM4HUTcO12lj1GcAGxztcq/4xOZXnc/eynOZPF3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748092; c=relaxed/simple;
	bh=DhK6tfJKZUcrZ0z9RL7ojFz5ggjhLyUf2NbkVTfalp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feX6KUOHC/v+2XEDP8XhqgGRXoUZqGa7+T2K4PIXhT7gk18JRy4BGU2fXyyQxbPAlQLSgvB8iUSVGWu5ueghK3+M3S58Wu4C0QbfyRpVQXYlM2CoHBuF71lIBab/kroh7bt+4XiHLyTKblTYRcgQWyjXlFhtADo2as/NfR7GMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOpI1YP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27138C116C6;
	Fri, 21 Nov 2025 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748091;
	bh=DhK6tfJKZUcrZ0z9RL7ojFz5ggjhLyUf2NbkVTfalp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cOpI1YP41Bm1QeFpkBF/xQwl2R0x9LEtYY9v7JzIZ98uR/nghngE8Tl+7DIIRXbAA
	 NIbEVkSWh6Tb4Q6pIEqLzUO3pDfsEbGKwQPu8HDgvTbKU/niiOLups0lQI82DhXPHg
	 7jc+aZ3JpMPPA9YsjoIXEWacLkk76YPpGQgIOop4N7zCWTGsbRxLoLU83lJeGnflmW
	 +RJqZQiCHlPWcHe/PRanEMoN/PGYukrD8REzNODp2LU5fzG+D0QWZtMz8m6gvPNQZX
	 ATzPhGMFzHmlxlouyMMn8Su3rPtKjNSHd3HsN1ojTF9oPjMXxn7zK1HoNIFTIDTI/T
	 sQ3JQ72T5F1kg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:58 +0100
Subject: [PATCH RFC v3 19/47] af_unix: convert unix_file_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-19-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DhK6tfJKZUcrZ0z9RL7ojFz5ggjhLyUf2NbkVTfalp4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLiwu50n7vBs1cRWI5XlZtnrni5c2rxil1X7yW3/H
 9yW9Z/H3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRNUcZGeYXc/7tTMqOKe1V
 O7fh+gups//rfq2MfHog989rszThO68YGVZN6K9t+1xgyfjxvv1O78xGRuNjarb3v/hIby1/dcc
 7iBEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 68c94f49f7b5..80dd12b6b441 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3277,8 +3277,7 @@ EXPORT_SYMBOL_GPL(unix_outq_len);
 
 static int unix_open_file(struct sock *sk)
 {
-	struct file *f;
-	int fd;
+	int ret;
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -3289,18 +3288,11 @@ static int unix_open_file(struct sock *sk)
 	if (!unix_sk(sk)->path.dentry)
 		return -ENOENT;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	f = dentry_open(&unix_sk(sk)->path, O_PATH, current_cred());
-	if (IS_ERR(f)) {
-		put_unused_fd(fd);
-		return PTR_ERR(f);
-	}
-
-	fd_install(fd, f);
-	return fd;
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&unix_sk(sk)->path, O_PATH, current_cred()));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
+	return fd_publish(fdf);
 }
 
 static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)

-- 
2.47.3


