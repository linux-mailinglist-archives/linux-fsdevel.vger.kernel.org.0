Return-Path: <linux-fsdevel+bounces-69310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F4C76858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 76BAF28D58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B9308F23;
	Thu, 20 Nov 2025 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaIr+0n3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A434FF7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678000; cv=none; b=Vk6GlJOiBOAPrJt3IGk+bbF+Mn24ctg+bhpbOhIxjOcaMWlOuCZSsG8ttshQvA871cMypI4QpiOBQ1l6EfrhIc3sLL1TLTN2bV25I7eTo/c39riJOXvNvSrWOm9nukuCZG5Jrf5XZbsBKLzpWLQijklxovvpjVTs0jejQ7IpjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678000; c=relaxed/simple;
	bh=htBzC1Rxlf3A588f6wOuOL+qvE3sPwtfKvXBboSoyd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8ISg/o1A6JQEjX6OWjbXfVwaH+DQj9KbIrQdXjTuVdWFEy80EOXchXHIoE5psca2m3iyp00xUVlwLKNH4Jl5S6S9ryFwKFcC7vdOPQSvNejVM1hCrBYFfn6SdWuLV7xv9FVH4Lpj7PSsWyk12yTaXQV7lkpvsWMnFr5WRN/Ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaIr+0n3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD7C113D0;
	Thu, 20 Nov 2025 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677999;
	bh=htBzC1Rxlf3A588f6wOuOL+qvE3sPwtfKvXBboSoyd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YaIr+0n3RIFKS+UzhIpEWvL6ndCM/m2zdkjw9p0vxtQappuJ6rA/lb++X7OomarSR
	 GK5gW4tiQdHlTN3jhV/7g51DTy/oDH2/kd9zWdmlzVJO0KvVUW4/PyPabr2roeHmLS
	 DvPPD0qcVylI1iMzVJ0ufyE8pMvn3i6xh4s4ZLgw1RAJ7C1aBNn/uWN+avCL984rR9
	 Ui7XObBSsG1tta/11JT7TcnXHXINciH0mVodAnjZkUqV84OCGrERnBOEVk83d76ff4
	 eekAGqiEqJV9HX+l43qMalgSlGdD0ebty1fnBa2pCWlCHEC3rRo3tAwbO3QeJBdSAq
	 rNISFPdU2EBfg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:27 +0100
Subject: [PATCH RFC v2 30/48] net/sctp: convert
 sctp_getsockopt_peeloff_common() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-30-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=brauner@kernel.org;
 h=from:subject:message-id; bh=htBzC1Rxlf3A588f6wOuOL+qvE3sPwtfKvXBboSoyd4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vnePPDn/8Xb7VaSCWdcfWv/9YTUNz5gjPgec28i
 1N+qH+e3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRzSaMDM+mPjkV+unzgmnW
 TzX+3P6QNIV53fetu3iFjQTWKRbO+mXB8D8hLc3m8OtrWlV2Zno5V7TqI25P1j77/o6DQ3rq1YR
 D19kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/sctp/socket.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ed8293a34240..68008514501e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5672,32 +5672,24 @@ static int sctp_getsockopt_peeloff_common(struct sock *sk, sctp_peeloff_arg_t *p
 
 	retval = sctp_do_peeloff(sk, peeloff->associd, &newsock);
 	if (retval < 0)
-		goto out;
-
-	/* Map the socket to an unused fd that can be returned to the user.  */
-	retval = get_unused_fd_flags(flags & SOCK_CLOEXEC);
-	if (retval < 0) {
-		sock_release(newsock);
-		goto out;
-	}
-
-	*newfile = sock_alloc_file(newsock, 0, NULL);
-	if (IS_ERR(*newfile)) {
-		put_unused_fd(retval);
-		retval = PTR_ERR(*newfile);
-		*newfile = NULL;
 		return retval;
-	}
 
-	pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
-		 retval);
+	FD_PREPARE(fdf, flags & SOCK_CLOEXEC, sock_alloc_file(newsock, 0, NULL)) {
+		if (fd_prepare_failed(fdf)) {
+			sock_release(newsock);
+			return fd_prepare_error(fdf);
+		}
 
-	peeloff->sd = retval;
+		pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
+			 fd_prepare_fd(fdf));
 
-	if (flags & SOCK_NONBLOCK)
-		(*newfile)->f_flags |= O_NONBLOCK;
-out:
-	return retval;
+		if (flags & SOCK_NONBLOCK)
+			fd_prepare_file(fdf)->f_flags |= O_NONBLOCK;
+
+		peeloff->sd = fd_prepare_fd(fdf);
+		*newfile = fd_prepare_file(fdf);
+		return fd_publish(fdf);
+	}
 }
 
 static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval, int __user *optlen)

-- 
2.47.3


