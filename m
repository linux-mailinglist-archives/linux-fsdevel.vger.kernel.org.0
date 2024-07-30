Return-Path: <linux-fsdevel+bounces-24566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9F940772
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD71F2382A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B619FA68;
	Tue, 30 Jul 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ5CxqeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AD19F472;
	Tue, 30 Jul 2024 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316519; cv=none; b=BcsRuokfii6+DdDAz+Ffd8DqC2ZxIS6C7rNoEH7MtgFa06f33V5HnFkA6TrOIqdFok62AXVGTn17SqhqXUTUXFHlcjBdk/qgoJhoyf/pA34LI7KN2B0xb5wc/MEO/JYFKf+n199yXykjl4YjUl+2JSCt4AUPnOoPwVspwE3HIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316519; c=relaxed/simple;
	bh=Jq4jKFKUxEvckJcHkKFVMo0u+y+F+g+qtMwitqPcOTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3+5fdq5bcW30ja9rx2mydzwiK0ccchjKTjqUOR3PFPXiB3PRnDa6UHTBl1gDyAgor7ZaFW3q+69S55jHxecEsrL+Y5PZVx0+AIGAzxxhBX/RqEeJwmNdl1fen5XDXaSQsBBqeue91UYaaQabkL2D3jDAkZwpvdQpWJZddxnM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ5CxqeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125B1C4AF0C;
	Tue, 30 Jul 2024 05:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316518;
	bh=Jq4jKFKUxEvckJcHkKFVMo0u+y+F+g+qtMwitqPcOTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZ5CxqeVMp8yK24ro4mbLlJnpvbQJBUTlSm5/VX9Dm6piAApyiKYJ1Cgi7FgNV3rN
	 ech/4CpjUWWnPJjool2GCrwSqEZSANyRPYt8kxAewEnxpyOn0BYHuSO5P1DbYB6+xx
	 9ZTM9E18l+GZpGHqorqj9da5mj0ziIPfxyEcwd3Vx6gSUYxPbD8wfZgc9HWiamPNZN
	 3a1jHvip75unm2FwTYgxoowXFcM9BBSh9eEOMRNT7exedZdaRDGeQ6mX/uurW9LQXf
	 iKGibVrGvsaDolOybJLSacaBd9PxITKgPcoJIx6ojjlWOc+3v4wnVWOXqWloCc/XEz
	 7cXo5qu5beF9g==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 34/39] do_pollfd(): convert to CLASS(fd)
Date: Tue, 30 Jul 2024 01:16:20 -0400
Message-Id: <20240730051625.14349-34-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

lift setting ->revents into the caller, so that failure exits (including
the early one) would be plain returns.

We need the scope of our struct fd to end before the store to ->revents,
since that's shared with the failure exits prior to the point where we
can do fdget().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/select.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 039f81c6f817..995b4d9491d3 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -856,15 +856,14 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 				     __poll_t busy_flag)
 {
 	int fd = pollfd->fd;
-	__poll_t mask = 0, filter;
-	struct fd f;
+	__poll_t mask, filter;
 
 	if (fd < 0)
-		goto out;
-	mask = EPOLLNVAL;
-	f = fdget(fd);
-	if (!fd_file(f))
-		goto out;
+		return 0;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return EPOLLNVAL;
 
 	/* userland u16 ->events contains POLL... bitmap */
 	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
@@ -872,13 +871,7 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 	mask = vfs_poll(fd_file(f), pwait);
 	if (mask & busy_flag)
 		*can_busy_poll = true;
-	mask &= filter;		/* Mask out unneeded events. */
-	fdput(f);
-
-out:
-	/* ... and so does ->revents */
-	pollfd->revents = mangle_poll(mask);
-	return mask;
+	return mask & filter;		/* Mask out unneeded events. */
 }
 
 static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
@@ -910,6 +903,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			pfd = walk->entries;
 			pfd_end = pfd + walk->len;
 			for (; pfd != pfd_end; pfd++) {
+				__poll_t mask;
 				/*
 				 * Fish for events. If we found one, record it
 				 * and kill poll_table->_qproc, so we don't
@@ -917,8 +911,9 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 				 * this. They'll get immediately deregistered
 				 * when we break out and return.
 				 */
-				if (do_pollfd(pfd, pt, &can_busy_loop,
-					      busy_flag)) {
+				mask = do_pollfd(pfd, pt, &can_busy_loop, busy_flag);
+				pfd->revents = mangle_poll(mask);
+				if (mask) {
 					count++;
 					pt->_qproc = NULL;
 					/* found something, stop busy polling */
-- 
2.39.2


