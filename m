Return-Path: <linux-fsdevel+bounces-69427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E271BC7B2DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB473A4227
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B23351FAE;
	Fri, 21 Nov 2025 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvlmVMe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186133A012
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748113; cv=none; b=TsEvNwSCUNypSYQuW2vFhmPPvdthTtk0X5iYmkBrgDN8rTEVc+IWE2gfYFoXHqYcs0srx36LxCeHcYkIShbU5ETCE6IKSVnFp8i59HG6+qIjgB2xv0dr/o9qxDJCe7ZCFJEiy/dJdV6tpzpitO2P5H4n9DaSdvkeVansZtVQyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748113; c=relaxed/simple;
	bh=hTzhddcOMjOacd7aH8ZX2Nr1xcneroEo/Qv4pBgaD4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBkLH1a8xRSj+/5E4D71LSb1ndkPN/MPrGB+vzwadCpgNGknVz4C+qgpARPPq/964mQYnBhuqeccGtzJqKTiomK48k+c37IfElEOz1dtjhma2pkqZX0Rvv/2cJujwx6RzzcvP8x2xpY4a8PUjn56Xdi3hsza1ItWU/ZOnQshQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvlmVMe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267D9C4CEF1;
	Fri, 21 Nov 2025 18:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748112;
	bh=hTzhddcOMjOacd7aH8ZX2Nr1xcneroEo/Qv4pBgaD4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EvlmVMe9LQ73tnRwMUZmNiZglUI0ba1SMFAZzfXgGUlpKpj55NDstXQcigt0dSixd
	 hrLvjdPHcgHqTOkXTzG8573iEG8GWUo8xjTmDZ4nfGcNyH3EnhVHER4/n0eXrIj7SC
	 4M8QQIF+vkA+pXAoTchtZJzq0CJvGa9b3aD8oWD+cDAcQ5CXztJm/ResDE4yIfsD4Q
	 HUxksf6MzJBmJxTnmXKN1oMjcwH2pgFRdVH9B+zLVDmCC7siPyAoBpL28L8ORTKsT2
	 SkQuxA3y2rkJehHxIPBiE5KZsWIk7CRWOLbgo6n+wFlG15/gdhYAupHPZ2lwbPyCu1
	 xubZrTiNhis+w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:08 +0100
Subject: [PATCH RFC v3 29/47] net/sctp: convert
 sctp_getsockopt_peeloff_common() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-29-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hTzhddcOMjOacd7aH8ZX2Nr1xcneroEo/Qv4pBgaD4o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLgg2ScsPfGaQvcPn/BYnu6JHeIXJicc1tlae+X8w
 9XF9vtyOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy7RbDb3aXwzVdi0qrFnhO
 NzrQX9OR9XH9jEVbvvreqPjUlnP7oAgjw7pilfrK/pBqn0kTP04xNt9rzisWcfuI1VmF6gVbcs6
 rMgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/sctp/socket.c | 89 ++++++++++++++++---------------------------------------
 1 file changed, 25 insertions(+), 64 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ed8293a34240..03f0317c5c38 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5664,47 +5664,46 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
 	return err;
 }
 
-static int sctp_getsockopt_peeloff_common(struct sock *sk, sctp_peeloff_arg_t *peeloff,
-					  struct file **newfile, unsigned flags)
+static int sctp_getsockopt_peeloff_common(struct sock *sk,
+					  sctp_peeloff_arg_t *peeloff, int len,
+					  char __user *optval,
+					  int __user *optlen, unsigned flags)
 {
 	struct socket *newsock;
 	int retval;
 
 	retval = sctp_do_peeloff(sk, peeloff->associd, &newsock);
 	if (retval < 0)
-		goto out;
+		return retval;
 
-	/* Map the socket to an unused fd that can be returned to the user.  */
-	retval = get_unused_fd_flags(flags & SOCK_CLOEXEC);
-	if (retval < 0) {
+	FD_PREPARE(fdf, flags & SOCK_CLOEXEC, sock_alloc_file(newsock, 0, NULL));
+	retval = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (retval) {
 		sock_release(newsock);
-		goto out;
-	}
-
-	*newfile = sock_alloc_file(newsock, 0, NULL);
-	if (IS_ERR(*newfile)) {
-		put_unused_fd(retval);
-		retval = PTR_ERR(*newfile);
-		*newfile = NULL;
 		return retval;
 	}
 
 	pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
-		 retval);
-
-	peeloff->sd = retval;
+		 fd_prepare_fd(fdf));
 
 	if (flags & SOCK_NONBLOCK)
-		(*newfile)->f_flags |= O_NONBLOCK;
-out:
-	return retval;
+		fd_prepare_file(fdf)->f_flags |= O_NONBLOCK;
+
+	/* Return the fd mapped to the new socket.  */
+	if (put_user(len, optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &peeloff, len))
+		return -EFAULT;
+
+	peeloff->sd = fd_prepare_fd(fdf);
+	return fd_publish(fdf);
 }
 
-static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval, int __user *optlen)
+static int sctp_getsockopt_peeloff(struct sock *sk, int len,
+				   char __user *optval, int __user *optlen)
 {
 	sctp_peeloff_arg_t peeloff;
-	struct file *newfile = NULL;
-	int retval = 0;
 
 	if (len < sizeof(sctp_peeloff_arg_t))
 		return -EINVAL;
@@ -5712,33 +5711,13 @@ static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval
 	if (copy_from_user(&peeloff, optval, len))
 		return -EFAULT;
 
-	retval = sctp_getsockopt_peeloff_common(sk, &peeloff, &newfile, 0);
-	if (retval < 0)
-		goto out;
-
-	/* Return the fd mapped to the new socket.  */
-	if (put_user(len, optlen)) {
-		fput(newfile);
-		put_unused_fd(retval);
-		return -EFAULT;
-	}
-
-	if (copy_to_user(optval, &peeloff, len)) {
-		fput(newfile);
-		put_unused_fd(retval);
-		return -EFAULT;
-	}
-	fd_install(retval, newfile);
-out:
-	return retval;
+	return sctp_getsockopt_peeloff_common(sk, &peeloff, len, optval, optlen, 0);
 }
 
 static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
 					 char __user *optval, int __user *optlen)
 {
 	sctp_peeloff_flags_arg_t peeloff;
-	struct file *newfile = NULL;
-	int retval = 0;
 
 	if (len < sizeof(sctp_peeloff_flags_arg_t))
 		return -EINVAL;
@@ -5746,26 +5725,8 @@ static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
 	if (copy_from_user(&peeloff, optval, len))
 		return -EFAULT;
 
-	retval = sctp_getsockopt_peeloff_common(sk, &peeloff.p_arg,
-						&newfile, peeloff.flags);
-	if (retval < 0)
-		goto out;
-
-	/* Return the fd mapped to the new socket.  */
-	if (put_user(len, optlen)) {
-		fput(newfile);
-		put_unused_fd(retval);
-		return -EFAULT;
-	}
-
-	if (copy_to_user(optval, &peeloff, len)) {
-		fput(newfile);
-		put_unused_fd(retval);
-		return -EFAULT;
-	}
-	fd_install(retval, newfile);
-out:
-	return retval;
+	return sctp_getsockopt_peeloff_common(sk, &peeloff.p_arg, len, optval,
+					      optlen, peeloff.flags);
 }
 
 /* 7.1.13 Peer Address Parameters (SCTP_PEER_ADDR_PARAMS)

-- 
2.47.3


