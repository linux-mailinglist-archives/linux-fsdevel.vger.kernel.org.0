Return-Path: <linux-fsdevel+bounces-69549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B1DC7E3DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E2CB4E33EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030C2D8DA9;
	Sun, 23 Nov 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utf/TEYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D02248B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915674; cv=none; b=fgWZ5et+Ec6MWlIPpTC4nuMO5aiv/8YcJ1WHiskOjfuTYlwQJcZsZlXSwx6H4rBfDn50oPPHW8tlzc9CQbBgCcdXJI0GMcN9SjfT5lagN/Au5CqZTLW4dqlqwDFbKTiB4jjndOL1rhcVFl10C5A7TIHzJQxgDcTrIKnFiOoLSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915674; c=relaxed/simple;
	bh=LawczJOdAKfdWb0mxaTG0lRooxig+gE0RhEh6iQc22Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUOeIDTERC3bAa7lwZ2M0BD1aU9SBuC7FDXQcn3HrIJajnXixrm6BZ7AyD/L4DqG02k0vJLmG3QJIg+jiNKUuSaA/DhoK2ETFyOVyMsiKDuYLDyMk+HDnt0t+/wEfG0bb5U8qpa/0kQYN3txpRJRrfvgWFm/hkuNQxYWK82dbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utf/TEYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3398C16AAE;
	Sun, 23 Nov 2025 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915673;
	bh=LawczJOdAKfdWb0mxaTG0lRooxig+gE0RhEh6iQc22Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Utf/TEYajkAu2mVvyjNG0KLSA3JioGITcRu9bNOdPT6XW3qmFhSn79pBV6b21Vz9F
	 oU8OKFyBuBF4GeAGHcQzK2lrApUu5LLNbGW5KcznQ6YY9SyvlCVwCZ3wTUp84ViYeB
	 roHojZ9B1AGS1swD0+tD+djZUVPa4pNfpHwKt8ec21oGWnHngv4LhbazAX2u7Klf8z
	 0MQpkddoCYq/c/J+2xZXGpJu5JG9z+ucZbJMOQUDs3borbDlHDoVumFZdkXmF9GKH7
	 Sn5Ts5FSNDiQs8H500JhNeznAhq/xuNIX7/JDFkIC65iHOCKp4i5IL64eGWomagJY7
	 YaDMlvvcdL8sw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:45 +0100
Subject: [PATCH v4 27/47] net/handshake: convert handshake_nl_accept_doit()
 to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-27-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LawczJOdAKfdWb0mxaTG0lRooxig+gE0RhEh6iQc22Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0ct417W+vXuxVP2G5yedTK1X7s25atj3ZIvpZPl+
 p5PO/7jR0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBElhYwMmxzZs7dF9j330Kb
 7cKzMM4Qw5kMW+PWPLnccWg6U1FgmjQjwzFu3jjmA+J75HoVL91eXRUWWidh6KXn2/jj5O4dXZ+
 tuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/handshake/netlink.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 7e46d130dce2..7a26f9010277 100644
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
@@ -106,27 +106,24 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
-	if (!req)
-		goto out_status;
-
-	sock = req->hr_sk->sk_socket;
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
-		goto out_complete;
-	}
-
-	err = req->hr_proto->hp_accept(req, info, fd);
-	if (err) {
-		put_unused_fd(fd);
-		goto out_complete;
+	if (req) {
+		sock = req->hr_sk->sk_socket;
+
+		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		if (fdf.err) {
+			err = fdf.err;
+			goto out_complete;
+		}
+
+		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
+		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
+		if (err)
+			goto out_complete; /* Automatic cleanup handles fput */
+
+		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
+		return fd_publish(fdf);
 	}
 
-	fd_install(fd, get_file(sock->file));
-
-	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
-	return 0;
-
 out_complete:
 	handshake_complete(req, -EIO, NULL);
 out_status:

-- 
2.47.3


