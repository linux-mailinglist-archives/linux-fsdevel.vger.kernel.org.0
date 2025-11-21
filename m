Return-Path: <linux-fsdevel+bounces-69425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93147C7B343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14A92367822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DE34EEE3;
	Fri, 21 Nov 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKVijqFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7852E8B76
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748109; cv=none; b=pTaBlUx7XAgAEWGDjDd3/YF8puAYC7X7N5msN1oDchxXxQweolP8r8KTMn3lWwBidX4Wr0U781U47YkdW1vVcI+18Z30TLrjXn5iqBZRojMH4JIuOFfhNuKbU5B9pC5k9oNu7cUXpBq3DHLz8z4BZklGCcHCCd9sUqCitdqaWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748109; c=relaxed/simple;
	bh=uBd8b8Nu527J0dDUEut9eUCGvnVpdhNKlpS/10o1ufQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4jDEyvRfkNEL5kGAlDuWoYrs+IxRBWv/pNkT6WoiJQqX2sAUfjUzE3PnilWnodfWvDVB7dNm5ot5XQ0BSdn2+7j9EKbq65AyOfIy8KIeM9XDwoCiVbGXW3Y0ywWGvjU+2NnKyWi9IqWDP9VPo7MAtU8sCaaLU2O+LGYLw+dR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKVijqFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CA7C4CEF1;
	Fri, 21 Nov 2025 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748108;
	bh=uBd8b8Nu527J0dDUEut9eUCGvnVpdhNKlpS/10o1ufQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BKVijqFB9XFVj1J+ARGN95FA4H8GjiGoC91gZLCCjbWaSr0mbiGxk9JnVzG6P0Zzc
	 g9qxJ43/OJjSeYeeFx/6lDOmFY6Ch+BrxPWoI4a33CnBIIO/DTpDD0dON/0y/rhdAQ
	 xVrZHkioVLMon80TlYe3tsufYJCZ5Y7B4o0tQBRt5Uf3g3HghHonK0/UYneFDIHbqv
	 mXew8C9mNgZWuKUoLgH+1TDKHBmgiqlgpZwq8oCQqyimkPg90TB5gMW84x26RiGr4z
	 ak8z/rMVC/zDlmg0bMDSg1RkT4uicaRXJK4yjC96gvD+q3ZuLeSiqV/5yRJqa8fG7+
	 E2zY5uLmKHNBw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:06 +0100
Subject: [PATCH RFC v3 27/47] net/handshake: convert
 handshake_nl_accept_doit() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-27-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uBd8b8Nu527J0dDUEut9eUCGvnVpdhNKlpS/10o1ufQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjglewyeQ9vyUeG47v+L+KTn3iIp+ee4jvnI+U5O
 u9Dl8zd21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCReG9GhgMfphqs4z0hPN/z
 7ImWRp7vq4Mt52/eGRIhwcgk+VU58QHD/9h0y1D2H/Xvfr1rr+0q6EuTsOhd/uHfrdi+e4GdUwp
 7OQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/handshake/netlink.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 7e46d130dce2..db4f35c31bc1 100644
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
@@ -106,26 +106,22 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 
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
+	if (req) {
+		sock = req->hr_sk->sk_socket;
 
-	err = req->hr_proto->hp_accept(req, info, fd);
-	if (err) {
-		put_unused_fd(fd);
-		goto out_complete;
-	}
+		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		err = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (err)
+			goto out_complete;
 
-	fd_install(fd, get_file(sock->file));
+		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
+		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
+		if (err)
+			goto out_complete; /* Automatic cleanup handles fput */
 
-	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
-	return 0;
+		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
+		return fd_publish(fdf);
+	}
 
 out_complete:
 	handshake_complete(req, -EIO, NULL);

-- 
2.47.3


