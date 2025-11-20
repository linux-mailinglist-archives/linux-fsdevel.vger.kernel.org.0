Return-Path: <linux-fsdevel+bounces-69308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C536C76867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930854E5E48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175C33DECA;
	Thu, 20 Nov 2025 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkLkjUkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6492EFD86
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677995; cv=none; b=GAZId81viKsJ+q8CqZgSYgZAHNKra31Fq3p+LYlhKgVpVUB/YstxGxhJBDiXtEijjpQTKuMCCzjiwftnKC2it4Uhgj3XCME8sU89he2+jpRJxA2gQ+fih0Q9VJuD7e9ZDq5OmjUEKpb0wmjscBzq+kuCkeDsZ3nEPXk55bBjE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677995; c=relaxed/simple;
	bh=sWRguhJbeCKfZvkWexedYWkRW7pu2xxudgJcicc7jlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lURFdk9wFzQ6SF2E2+bLbPkiPWr0YGZemksXQ/C4R8eFCdbjFzk+WugaeBB/3Xi+UdTz4oJFVVUyOLBe8zEg/iX/Ibmyw4KNbT/KOHKZ8EQYLFqmfYGPbWwOxRrOVjbOqr4XKcnVYeikD1hpsXHXIxEOuLP+1QbySLgPCWV9Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkLkjUkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A458BC113D0;
	Thu, 20 Nov 2025 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677995;
	bh=sWRguhJbeCKfZvkWexedYWkRW7pu2xxudgJcicc7jlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qkLkjUkGs+YlZELb+t26uxA5RFIoxD45OjcfS3fOHht9gQALWcMkQlOH12xNLqO27
	 92b7ZhSgv1DZlQvw3BkNQS4eSn5oMQsMQPB1HtJ2f+z31bKpfO7y7Ny26SJaE84Vqt
	 4KqcEk9yLIEAYKgEGZJ7wz3+ezQc2Efk35vQOw5v/D8Le8kCCbj8+zPkBnu0pfEuYR
	 GxTWMmitZZ/dAYbZhFvHMH6zZH3ccYpuxlQL50Q+XFnj8Lh7bFpzRJMHX3Q1LBiv7q
	 qG2OiN7y2iioI1nmRZ5wLLKXg0pKXf8vFBeo/YsVpqtLVKY1ZAAhR5C6Qe45ixBMwt
	 26r9oZLfyvVIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:25 +0100
Subject: [PATCH RFC v2 28/48] net/handshake: convert
 handshake_nl_accept_doit() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-28-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sWRguhJbeCKfZvkWexedYWkRW7pu2xxudgJcicc7jlc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vLu7z9oU2L6KSujd1TStR66z9rlkWePHb06pPTf
 94duGfj3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRv4UMf3iiz9cs+95zvPPf
 g/UJ8WFW6QpHXf90PPqn1Tx51uttu84xMlwQV3jII2H+WHENF+vnO8pOARuq10/v5HlUUSub/1N
 jIhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/handshake/netlink.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 7e46d130dce2..1b51952ffbb9 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -93,7 +93,7 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	struct handshake_net *hn = handshake_pernet(net);
 	struct handshake_req *req = NULL;
 	struct socket *sock;
-	int class, fd, err;
+	int class, err;
 
 	err = -EOPNOTSUPP;
 	if (!hn)
@@ -110,22 +110,21 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_status;
 
 	sock = req->hr_sk->sk_socket;
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
-		goto out_complete;
-	}
 
-	err = req->hr_proto->hp_accept(req, info, fd);
-	if (err) {
-		put_unused_fd(fd);
-		goto out_complete;
-	}
+	FD_PREPARE(fdf, O_CLOEXEC, sock->file) {
+		if (fd_prepare_failed(fdf)) {
+			err = fd_prepare_error(fdf);
+			goto out_complete;
+		}
 
-	fd_install(fd, get_file(sock->file));
+		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
+		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
+		if (err)
+			goto out_complete;  /* Automatic cleanup handles fput */
 
-	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
-	return 0;
+		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
+		return fd_publish(fdf);
+	}
 
 out_complete:
 	handshake_complete(req, -EIO, NULL);

-- 
2.47.3


