Return-Path: <linux-fsdevel+bounces-69312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E19C7686D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8982D4E40B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1534368DEB;
	Thu, 20 Nov 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOyZea7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99D2FF660
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678004; cv=none; b=Rvmk+mFSipgVZmglZf0gCNAualERvHea2nAX7ZA99TQ8isZM6UWryBOqgxV5fI/rwx4kfNfAmkZFCzqAC433zl/YtX3cop6vFdRl5B49FG9m8L8sLMig+RT3ROKfL4/UShnqN6TLazMzNv+q9UxHGLTtuA0pHAiZ+CkEXTu7aK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678004; c=relaxed/simple;
	bh=67wb8+BnyhWbLo3e0HaZj7Dge4GsgglCkykfBli0Ddc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSq7zi0iEM31Bkz2FzHoijHrubQp6iiOwkDtWmfOOY9HMmxVkYMFkR3B+kV2T+fB0T9WrHBXjstUAFJuKylyFDyIDTugjGBhPIBM7VSdtt3jhhT4uS9MSEtFnnF4P4cbnJeq8pDGWbP0Q+aCh3/sFunhztbF3jij23GiOi2zJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOyZea7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455D0C116B1;
	Thu, 20 Nov 2025 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678003;
	bh=67wb8+BnyhWbLo3e0HaZj7Dge4GsgglCkykfBli0Ddc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tOyZea7tDfpa4+Rqxlk0oc7Vx6bb08+DMDsxNFaYENdvbCdFt//awknMAlAv8TuU8
	 Vpn92qMPO3eN5Pkp8fvW2tcFxnjbo59G7rclw3casDpoZjLNOY/T8EuUcZYnkKEhNF
	 z5KZMSwtJogqfWOh/PQZHJGuxlbp9J95S4XOfqxTJerKSoM33RZyo43zsnNi/E4gFl
	 ufx4erFbbvwZwU65V9IB7R+KvqMEIXmcdkmv7i7y4DhHwfaJlP/QVliJprBTMVCZt5
	 mlizXBQHIYMW5ia408A2oc87WvOMxJBA8DN7cSy70io5rsmTvMbbwK/aw7Weagbyu5
	 LCMjOb6jsJoeg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:29 +0100
Subject: [PATCH RFC v2 32/48] net/socket: convert __sys_accept4_file() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-32-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=brauner@kernel.org;
 h=from:subject:message-id; bh=67wb8+BnyhWbLo3e0HaZj7Dge4GsgglCkykfBli0Ddc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vHo2WiNekhb7yvlMaWDMHITZnyhcvWqrjK/DqcU
 vtt/w7BjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlwczIyTFrQoDvX/Os+KweZ
 COstDi9mP1/+vmHj+zlHMtY5KZX0/GJkOJ/RKrZ2gUtMnGKhk/j31FvttXudLdr3fbKKOc8Qvyy
 HEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 669fecc79851..04ae71111235 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2005,8 +2005,6 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 			      int __user *upeer_addrlen, int flags)
 {
 	struct proto_accept_arg arg = { };
-	struct file *newfile;
-	int newfd;
 
 	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
 		return -EINVAL;
@@ -2014,18 +2012,12 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
 		flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
 
-	newfd = get_unused_fd_flags(flags);
-	if (unlikely(newfd < 0))
-		return newfd;
+	FD_PREPARE(fdf, flags, do_accept(file, &arg, upeer_sockaddr, upeer_addrlen, flags)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	newfile = do_accept(file, &arg, upeer_sockaddr, upeer_addrlen,
-			    flags);
-	if (IS_ERR(newfile)) {
-		put_unused_fd(newfd);
-		return PTR_ERR(newfile);
+		return fd_publish(fdf);
 	}
-	fd_install(newfd, newfile);
-	return newfd;
 }
 
 /*

-- 
2.47.3


