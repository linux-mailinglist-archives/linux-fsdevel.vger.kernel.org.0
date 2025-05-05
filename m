Return-Path: <linux-fsdevel+bounces-48063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0215AA91D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B885C7A4AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFF207DF7;
	Mon,  5 May 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAdj8VzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A120297F;
	Mon,  5 May 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443681; cv=none; b=IpPnuZwnPCIDwwLjdrzXmbhjTkiwJAQTxyoDr8NQ03YR5C1Wb9dDV9rYPIjTBX/JDKaYLNlAI4RoPSCEkw976bZPJLodikVfz7siPrOIDOcNw89Dn4A60y5R7f4p+rjDjPBE87j1V0o7ls/l6fGRyjc/EQvwofeL/1/9kKk0adM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443681; c=relaxed/simple;
	bh=PKfxvII8s03tZ/L5i8hb8YTGQUGotETeNiF7b11BExA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg1q+hQ/jfvSedlii2eWRCwHHHYospFgmyhUEXLDg/aQx2MriwZu5iw734PTz1Epmht2z32u1GudMZlyo9aAiNwpYUgJwwZ6mpdR/qqU81C/bNc7v4tHvs2j2lUyHLpD7NHXRFYzUi5ie2FmwlcSMWsg+fePn7pFa5KrFs1q3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAdj8VzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A61C4CEE4;
	Mon,  5 May 2025 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443681;
	bh=PKfxvII8s03tZ/L5i8hb8YTGQUGotETeNiF7b11BExA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TAdj8VzIg52sr2BDfqdA833NR/QLQhAn39r86YgTqdES/ueGk953pkeNUGxaugSIC
	 ntLePb0QnWmL0wzGDe39BlWLtyhmzT42LUbwSyNfzywzbAfGEPbwvSFYtPHW04sDzN
	 OZ2bG/JiG//o5WEr/K88aDqGr2EvCbPup9yqJEtQV8wXTItOm7AEtWaLMK29eNNjbW
	 xpzVmu5MM/fv0YbdHxPdh6Az5qJeJqq8fU/ebZqAY46qGDbJW10ZWQxsHkL7MlqQUw
	 oKb8wthsLTL6+XNuuRqf0lxFBpMjQfW7nCUcRC60axArwOisOYF+WjAHxLmzO9m0Ri
	 R+DmM0pWLnBog==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:48 +0200
Subject: [PATCH RFC v3 10/10] selftests/coredump: add tests for AF_UNIX
 coredumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-10-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3426; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PKfxvII8s03tZ/L5i8hb8YTGQUGotETeNiF7b11BExA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM37G7FjHV+00xIRfQ/O55x8JtJdxRmvdW/e+27+e
 0en+s+ejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMnMLwvzpAxM995xbzPLlT
 uaIJjKqy5xIOzd/T9cNoedy84ua5VxgZmkPeqInFnF19dOnRV5pZRXYh03qP6C6ddil/7rTotfm
 v+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test for generating coredumps via AF_UNIX sockets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 71 ++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index fe3c728cd6be..4d1d444ca3d4 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -5,10 +5,13 @@
 #include <linux/limits.h>
 #include <pthread.h>
 #include <string.h>
+#include <sys/mount.h>
 #include <sys/resource.h>
+#include <sys/stat.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "../pidfd/pidfd.h"
 
 #define STACKDUMP_FILE "stack_values"
 #define STACKDUMP_SCRIPT "stackdump"
@@ -35,6 +38,7 @@ static void crashing_child(void)
 FIXTURE(coredump)
 {
 	char original_core_pattern[256];
+	pid_t pid_socat;
 };
 
 FIXTURE_SETUP(coredump)
@@ -44,6 +48,7 @@ FIXTURE_SETUP(coredump)
 	char *dir;
 	int ret;
 
+	self->pid_socat = -ESRCH;
 	file = fopen("/proc/sys/kernel/core_pattern", "r");
 	ASSERT_NE(NULL, file);
 
@@ -61,10 +66,15 @@ FIXTURE_TEARDOWN(coredump)
 {
 	const char *reason;
 	FILE *file;
-	int ret;
+	int ret, status;
 
 	unlink(STACKDUMP_FILE);
 
+	if (self->pid_socat > 0) {
+		kill(self->pid_socat, SIGTERM);
+		waitpid(self->pid_socat, &status, 0);
+	}
+
 	file = fopen("/proc/sys/kernel/core_pattern", "w");
 	if (!file) {
 		reason = "Unable to open core_pattern";
@@ -154,4 +164,63 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 	fclose(file);
 }
 
+TEST_F(coredump, socket)
+{
+	int fd, pidfd, ret, status;
+	FILE *file;
+	pid_t pid, pid_socat;
+	struct stat st;
+	char core_file[PATH_MAX];
+	struct pidfd_info info = {};
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL), 0);
+	ASSERT_EQ(mount(NULL, "/tmp", "tmpfs", 0, NULL), 0);
+
+	pid_socat = fork();
+	ASSERT_GE(pid_socat, 0);
+	if (pid_socat == 0) {
+		execlp("socat", "socat",
+		       "abstract-listen:linuxafsk/coredump.socket,fork",
+		       "FILE:/tmp/coredump_file,create,append,trunc",
+		       (char *)NULL);
+		_exit(EXIT_FAILURE);
+	}
+	self->pid_socat = pid_socat;
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(NULL, file);
+
+	ret = fprintf(file, "@linuxafsk/coredump.socket");
+	ASSERT_EQ(ret, strlen("@linuxafsk/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	ASSERT_EQ(kill(pid_socat, SIGTERM), 0);
+	waitpid(pid_socat, &status, 0);
+	self->pid_socat = -ESRCH;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 143);
+
+	/* We should somehow validate the produced core file. */
+	ASSERT_EQ(stat("/tmp/coredump_file", &st), 0);
+	ASSERT_GT(st.st_size, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


