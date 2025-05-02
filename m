Return-Path: <linux-fsdevel+bounces-47919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBAEAA726C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668943A6E80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22DE256C7A;
	Fri,  2 May 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYqTei7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872F254AF8;
	Fri,  2 May 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189792; cv=none; b=Tw34LRd0T4GB16gQo1tZmsNOvgN838u3pnDS1FwietdQ+e/CxDMA5eDQ/etmu9Z2/jimlB1LaSpN1uAndPebYgdK9Bi9wwjYLsZl3M+hfupTlugCx08nlQ7RlFLvurrBg+b2qeNmrv+C6GsPjCLtLRT8cxKN9MZYnqKq4X7eI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189792; c=relaxed/simple;
	bh=vWvdauE0P4tZXK3aJ6k30xFFFQGEsyt1LCtOQc4zs2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIXIxBGXs4P9KGTFwBeRGck07qJCSfOZwxJ10hNut0Z+fm75q8RzgrtGSWzRXgMmv5OMOCoNKOAFl3z3jYLCtIc9SNpYglW2ZTfvvSs6T2bKxtfK9EO33GEdoAFPSfdmdPdUrK5r9lUT5OJDLURQ+A16CslnKtZBPFj7QHY+WbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYqTei7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88201C4CEE4;
	Fri,  2 May 2025 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746189791;
	bh=vWvdauE0P4tZXK3aJ6k30xFFFQGEsyt1LCtOQc4zs2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XYqTei7Iu717MS6b7ipZKgw+7d6TYnrO/ZshwmXBbtxlMtnnKr4OPPLjqd0vPkAgT
	 n6YHXGQLnlEcyvPAZ0Dwe5y9QCGcHYp/kyb5Kdj1i2iU/sMZIY6rrR5Yr0RlElFezm
	 8OAQ2ZoMohXDDtwTtfPBLehkR4OV8jMs9Nfm7Ve5kFFWIs2Bvh9xY4EWqecGiUbPkx
	 09i1q73tAANoD9XJeieDt+YFOEme7kJwGAdD9C/hNbMb/NrN8Y1BJNDwJUOoNWX4Aq
	 b6CEGrdd7oJk8uAoge6agezK+xLh20eYi8QifSVinXAOyyZo9KjIUHoJ5lHFuSo6d8
	 0TpZCwYd5xADw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 May 2025 14:42:37 +0200
Subject: [PATCH RFC v2 6/6] selftests/coredump: add tests for AF_UNIX
 coredumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-work-coredump-socket-v2-6-43259042ffc7@kernel.org>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
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
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vWvdauE0P4tZXK3aJ6k30xFFFQGEsyt1LCtOQc4zs2U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7D1w0ctzz1Ephx8XKvuajIUbKwye+8azC7CvF/5iU
 aVY9lq7o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLvDRn+pznNU5+QMM/DJ32b
 6xf3vdLLTzE63PG2mmLgHinpyV7szsgw+3XpQ6e0RX/q+DPsL+jJp20/8G3VBNvMKWxsGl/sHd6
 wAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test for generating coredumps via AF_UNIX sockets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index fe3c728cd6be..ccaee98dbee3 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -5,7 +5,9 @@
 #include <linux/limits.h>
 #include <pthread.h>
 #include <string.h>
+#include <sys/mount.h>
 #include <sys/resource.h>
+#include <sys/stat.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
@@ -154,4 +156,52 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 	fclose(file);
 }
 
+TEST_F(coredump, socket)
+{
+	int fd, ret, status;
+	FILE *file;
+	pid_t pid, pid_socat;
+	struct stat st;
+	char core_file[PATH_MAX];
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL), 0);
+	ASSERT_EQ(mount(NULL, "/tmp", "tmpfs", 0, NULL), 0);
+
+	pid_socat = fork();
+	ASSERT_GE(pid_socat, 0);
+	if (pid_socat == 0) {
+		execlp("socat", "socat",
+		       "unix-listen:/tmp/coredump.socket,fork",
+		       "FILE:/tmp/coredump_file,create,append,trunc",
+		       (char *)NULL);
+		_exit(EXIT_FAILURE);
+	}
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(NULL, file);
+
+	ret = fprintf(file, ":/tmp/coredump.socket");
+	ASSERT_EQ(ret, strlen(":/tmp/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_EQ(kill(pid_socat, SIGTERM), 0);
+	waitpid(pid_socat, &status, 0);
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


