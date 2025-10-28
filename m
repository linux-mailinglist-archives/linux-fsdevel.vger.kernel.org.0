Return-Path: <linux-fsdevel+bounces-65895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D5C139D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263995604EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3532E6CBF;
	Tue, 28 Oct 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG93Awvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901A2D94BD;
	Tue, 28 Oct 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641228; cv=none; b=WoAlq09VIPd0c0hF+aLcVV4ggRG63+X8YzP1BR0iwqBxf7M2ICcyEnnlvjIoI58o9KPR26VzunxsdyhSu5ghkCy7BzlJ7YwGAsR/WAfHzBjumh1faMfLwBl1EyEwFScSeXwYl0086RB9DzbtMai+8zocDLdPE+2Yb+6lYUlH4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641228; c=relaxed/simple;
	bh=9WZyYJSqgqC9uOqgpENuG5GJD+MVhIhJ0ranzrExoPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leMgL2qRoTkrdT6A4RorDcYWEW5nhSFq95eRmcQJswZUe9bUsBQsEZ/FAG1BDpW0dTI/tPZBCshLE1ugAOOH1+IM64Oj+ckh1cdKifexku7iPzqvhuMU28ELeYR4ToSk9twG1r5j2ZevAh0N6qhIT3gzBTcBrsB5oeT6LUZl60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG93Awvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65BBC4CEE7;
	Tue, 28 Oct 2025 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641228;
	bh=9WZyYJSqgqC9uOqgpENuG5GJD+MVhIhJ0ranzrExoPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jG93AwvxpRGB4DRVhc9JjxsSHjsy+FAcq7a2INdrPU64v2FA4vub1w7zmtiVFZCro
	 xskVU0aMqdLj9TQgenEvKFgZqSHq2ugEqrX1fgqDexkgLjhlGCi5NUsxjZaDnhJ10L
	 LNnvFxUbal6Khfmr4qXZdPuOvYpNgZxhmclziooZxBO4OxtrtawThAUjpfdNhS7uv0
	 qVZ5yEqZWmveeaRjCzMKbrhGpNrHfr4o7CGs1YG39PQyv+Fo/eUhGwczfyPPLuONiH
	 1xQrFiIS57baOAVF8M+/E/GgVEC6YozRSHbDsu+3ocR5wvCUR9YgjGvt9EJ6l+tq/I
	 wUadZTlITi8EQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:00 +0100
Subject: [PATCH 15/22] selftests/coredump: fix userspace coredump client
 detection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-15-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9WZyYJSqgqC9uOqgpENuG5GJD+MVhIhJ0ranzrExoPs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2KVwztWbFrdnz/99b0JSwzrHY7zHq6PfVZPd+VT
 Xu8L/rN7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5SaG/5GZz9P5ZzBeb3/B
 17nLSnYO56pr89lUF96r4dsgkblpvR4jw3fbZ/xrXrIkeTJKrRbXfeMi7Xl08nUZ/Utf+uR3zzn
 9nwkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

PIDFD_INFO_COREDUMP is only retrievable until the task has exited. After
it has exited task->mm is NULL. So if the task didn't actually coredump
we can't retrieve it's dumpability settings anymore. Only if the task
did coredump will we have stashed the coredump information in the
respective struct pid.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_socket_test.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 658f3966064f..5103d9f13003 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -271,22 +271,26 @@ TEST_F(coredump, socket_detect_userspace_client)
 			_exit(EXIT_FAILURE);
 
 		close(fd_socket);
+		pause();
 		_exit(EXIT_SUCCESS);
 	}
 
 	pidfd = sys_pidfd_open(pid, 0);
 	ASSERT_GE(pidfd, 0);
 
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(WEXITSTATUS(status), 0);
-
 	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
 	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
 	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 
+	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0), 0);
+	ASSERT_EQ(close(pidfd), 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+
 	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
 	ASSERT_EQ(errno, ENOENT);
 }

-- 
2.47.3


