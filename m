Return-Path: <linux-fsdevel+bounces-65896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44402C139DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E422562518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EF2E7653;
	Tue, 28 Oct 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdF9UdGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF12D97A6;
	Tue, 28 Oct 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641234; cv=none; b=YTYAWBC8mT90o4DUnsqtXWeY49PlCcjXJKRybgjx3OTTO6j899Z2nA7trRPjMNatzcB5BHG4BrPcKP4p/4KI71+NnA33gWa9WTA1SML4oxm88t1RLzT8niKGmxIUIswDIbYEhUdUGy9MWZuvBdAUgfkavD3Y0VM2PGr/qcP0p2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641234; c=relaxed/simple;
	bh=WXvJOQc/1nKleY4xLz7bcXslIdmWnEGWuNhG++Sv6j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQR0AeFFHa51nMSqG+Y3kdGJjWLjAQUN9sll5BfRJOkPGmXijZj2koGsgLFll8ywsnt/UymAnQ1Xo49j2LOB1ZQcsQFm8UGWnolQoGnHbBmdazIupJ3rfxJb5YiZp2NCwfEQ5lyUx1p/zaKLLiQCu+fWmTrxwHnEmbJpvef+2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdF9UdGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06795C4CEE7;
	Tue, 28 Oct 2025 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641232;
	bh=WXvJOQc/1nKleY4xLz7bcXslIdmWnEGWuNhG++Sv6j0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YdF9UdGy6hy3lYDHW0ikUGuAZ1p0YpfbJUGM79DTRT7GC2NLqCmTH+0lAEe4qSW++
	 DsXOauAc4WRiT3hYN3H2TLxlkRKuBAaEZukJdo9eVvoaZNeXoy2m0kp+s2Qtc/szEj
	 MNuAmXDi4GG2r7uQn7Y5WZ9IkIw7aBo2o4f/yKMWYZml4SGM2/vth+OS9PLYW46rW1
	 Ppfvp/Q7nqYizsqlbAhZfSIQR3qhj6rVdvGtIO8f1j2C+n0Kpi+TvpJtgvMocgbc+n
	 piUt5su/LAn/EtpBb0vZ7x+OCZc2RXK2Os7UnqLejFf8cdZ47tUTAmz53Eu6Rez1qh
	 7sVyzBRWJsKpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:01 +0100
Subject: [PATCH 16/22] selftests/coredump: handle edge-triggered epoll
 correctly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-16-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WXvJOQc/1nKleY4xLz7bcXslIdmWnEGWuNhG++Sv6j0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB1q+n72562Fa80nsn8JOFxRvFz57r3kE1M1JL4x+
 oqLPc7d21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRh1GMDE83S4g8Onv04WvT
 XWbxng///frYyXP2kqxk6KGZ6X+y4qMZ/gckHfornnWZe0t897OlGtLn5ORkbh07t1Tu1Q2m2sP
 3WzkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

by putting the file descriptor into non-blocking mode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test_helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 7512a8ef73d3..116c797090a1 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -291,6 +291,14 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
 	int epfd = -1;
 	int exit_code = EXIT_FAILURE;
 	struct epoll_event ev;
+	int flags;
+
+	/* Set socket to non-blocking mode for edge-triggered epoll */
+	flags = fcntl(fd_coredump, F_GETFL, 0);
+	if (flags < 0)
+		goto out;
+	if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0)
+		goto out;
 
 	epfd = epoll_create1(0);
 	if (epfd < 0)

-- 
2.47.3


