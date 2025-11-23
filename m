Return-Path: <linux-fsdevel+bounces-69551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 911FCC7E3E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 826134E2EE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74D2D9ECF;
	Sun, 23 Nov 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbXIlXNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F82D24BF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915678; cv=none; b=Ro3RhzsHDXzFKqTy1NUBwuYd4lMxFqowi4RaIAJ1JlD04su+T6Lk6N4sllAefmIYo4FiLmclO2ckATzEn84SrOOm3qttew6DVfOCEL9+Ciz02WC1fTk8Lr5MrqKWP1biOCrUPv5uaSnMH3G7kQu59zsU49k6YjDr14KS3gz/ggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915678; c=relaxed/simple;
	bh=h6Vz/6nzyt58FjBv38GshUblHbnZVbWzUnsJkn4ncno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9GUAEJ5T5wIAbDRIAvWLSEnxTeVvzVrJXFB8XH3D/DvXfOUiVoW7R7Ug/WqUrOBg/G5pth4ctRJsBXSIOufplvc8pD8TA1cqb/akoURR5+YFMTq4w8BeOEBjbXYbv/jEc2bqVJ4M03XGNXSsEuxn1bnKU/S5XzwFc3+UfaUqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbXIlXNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC43C19422;
	Sun, 23 Nov 2025 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915677;
	bh=h6Vz/6nzyt58FjBv38GshUblHbnZVbWzUnsJkn4ncno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbXIlXNNWouk5IdkRyxgsH/OBhEC55UKb89X/r/5uMTXBVTu+GqIbHLEYmkhkUMhZ
	 I4nMxZtkuubaCyPNeMcZRGnkt4BDYbVKpsFb0c3uhRMY6ZOHZPYgfMwicsUnOoSWWt
	 s54/sWlZvvUxN5PPuQaGvf6B+44FTLxhxCA43nFOMqLeBbGyT/nR7uMjecgeb7oWi6
	 /9iB5qH9PUsKeulAiz/UCCiMP9QBFrecx0/uqjdlMsfzSDGV4J9vrb29/XqFw9QOzE
	 rXawcMHbDOKPnLJxx10m4EHsx4jLKM0jBpniSIOaCKwbFWL2vg5cihBPYmjJcxSTmK
	 VslbG/T05mdoA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:47 +0100
Subject: [PATCH v4 29/47] net/sctp: convert
 sctp_getsockopt_peeloff_common() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-29-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4121; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h6Vz/6nzyt58FjBv38GshUblHbnZVbWzUnsJkn4ncno=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dd1MtkN81N8NM4qhVQcIx9iuW/4PpvXVdCgwS8t
 zA8FPTqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMiqNkaGPu37in/Sfhk0f0mf
 6fnz5pdjRh/OpO9V/dLPaKIYalh9mJHhR5mgYPicnedbNk+49FrMZ99v/osm9/yy5j36f0jV9nM
 zEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/sctp/socket.c | 90 ++++++++++++++++---------------------------------------
 1 file changed, 25 insertions(+), 65 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ed8293a34240..206f9b7e648e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5664,47 +5664,45 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
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
+	if (fdf.err) {
 		sock_release(newsock);
-		goto out;
-	}
-
-	*newfile = sock_alloc_file(newsock, 0, NULL);
-	if (IS_ERR(*newfile)) {
-		put_unused_fd(retval);
-		retval = PTR_ERR(*newfile);
-		*newfile = NULL;
-		return retval;
+		return fdf.err;
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
@@ -5712,33 +5710,13 @@ static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval
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
@@ -5746,26 +5724,8 @@ static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
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


