Return-Path: <linux-fsdevel+bounces-44340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A7A678E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9B3BFF3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A191212FB1;
	Tue, 18 Mar 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HWN0BOVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38F211A06
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314513; cv=none; b=eXS7BI3x/Y1NA0MXM3bOeJ2BNZD4KM3GR1wPm5w4nUA+NfEKR2JtehSYjbsmk/QKJ1JCo7ZSemdljua5wfNJmDHdFaYcT+VPjjg+QDX3KjNUiJGoPGq3nU/05rxyLt0UCHwPDd9giTuoT6Wd5FzcjHE+xEhI7y/i2IDbeeelWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314513; c=relaxed/simple;
	bh=0qP5GqU6hxuBeipAIyWwTfxwmBhEYf4pOhwFrWR3+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqSMTfOT3Dzo7lGDuM+CjuonkbWUlVsZ/LP8dQTENhlmlYQX8zkAwbepy+Dt/O3isesKKR1swyhm/J6mXdbq0L7nqPO+bAygq4gLB4GGpWggA+QBGtOHYbbH7FloyRVH/HQdcFMDiJKJV3b5in8Vayf6R0RVjqkin2ay1vAcDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HWN0BOVA; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH4421P9zLJx;
	Tue, 18 Mar 2025 17:15:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314500;
	bh=c7lbP1EQsl0DIIQZtCoH5DqcB56sY5n99Bx2F2IcBNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWN0BOVAcXwF63j7W5D86BoY5uwFDnbZUuid85Sfcj3FLLI0sMmGbEEF0aLui1QQd
	 85Es3LH1fczTdZF0U5srAyiKMxC5/zo9VmvrfhTYYywWKU04SwqEYFNmEagpIjsMvE
	 RyYqITeV2AYVSjrOidM3wj9K5lwAAsGxVpezuZek=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH434bfBzVqL;
	Tue, 18 Mar 2025 17:14:59 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 7/8] selftests/landlock: Add a new test for setuid()
Date: Tue, 18 Mar 2025 17:14:42 +0100
Message-ID: <20250318161443.279194-8-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The new signal_scoping_thread_setuid tests check that the libc's
setuid() function works as expected even when a thread is sandboxed with
scoped signal restrictions.

Before the signal scoping fix, this test would have failed with the
setuid() call:

  [pid    65] getpid()                    = 65
  [pid    65] tgkill(65, 66, SIGRT_1)     = -1 EPERM (Operation not permitted)
  [pid    65] futex(0x40a66cdc, FUTEX_WAKE_PRIVATE, 1) = 0
  [pid    65] setuid(1001)                = 0

After the fix, tgkill(2) is successfully leveraged to synchronize
credentials update across threads:

  [pid    65] getpid()                    = 65
  [pid    65] tgkill(65, 66, SIGRT_1)     = 0
  [pid    66] <... read resumed>0x40a65eb7, 1) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  [pid    66] --- SIGRT_1 {si_signo=SIGRT_1, si_code=SI_TKILL, si_pid=65, si_uid=1000} ---
  [pid    66] getpid()                    = 65
  [pid    66] setuid(1001)                = 0
  [pid    66] futex(0x40a66cdc, FUTEX_WAKE_PRIVATE, 1) = 0
  [pid    66] rt_sigreturn({mask=[]})     = 0
  [pid    66] read(3,  <unfinished ...>
  [pid    65] setuid(1001)                = 0

Test coverage for security/landlock is 92.9% of 1053 lines according to
gcc/gcov-14.

Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
Cc: Günther Noack <gnoack@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-8-mic@digikod.net
---

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/common.h     |  1 +
 .../selftests/landlock/scoped_signal_test.c   | 59 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 6064c9ac0532..076a9a625c98 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -41,6 +41,7 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		CAP_MKNOD,
 		CAP_NET_ADMIN,
 		CAP_NET_BIND_SERVICE,
+		CAP_SETUID,
 		CAP_SYS_ADMIN,
 		CAP_SYS_CHROOT,
 		/* clang-format on */
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index d313cb626225..d8bf33417619 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -253,6 +253,7 @@ enum thread_return {
 	THREAD_INVALID = 0,
 	THREAD_SUCCESS = 1,
 	THREAD_ERROR = 2,
+	THREAD_TEST_FAILED = 3,
 };
 
 static void *thread_sync(void *arg)
@@ -316,6 +317,64 @@ TEST(signal_scoping_thread_after)
 	EXPECT_EQ(0, close(thread_pipe[1]));
 }
 
+struct thread_setuid_args {
+	int pipe_read, new_uid;
+};
+
+void *thread_setuid(void *ptr)
+{
+	const struct thread_setuid_args *arg = ptr;
+	char buf;
+
+	if (read(arg->pipe_read, &buf, 1) != 1)
+		return (void *)THREAD_ERROR;
+
+	/* libc's setuid() should update all thread's credentials. */
+	if (getuid() != arg->new_uid)
+		return (void *)THREAD_TEST_FAILED;
+
+	return (void *)THREAD_SUCCESS;
+}
+
+TEST(signal_scoping_thread_setuid)
+{
+	struct thread_setuid_args arg;
+	pthread_t no_sandbox_thread;
+	enum thread_return ret = THREAD_INVALID;
+	int pipe_parent[2];
+	int prev_uid;
+
+	disable_caps(_metadata);
+
+	/* This test does not need to be run as root. */
+	prev_uid = getuid();
+	arg.new_uid = prev_uid + 1;
+	EXPECT_LT(0, arg.new_uid);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	arg.pipe_read = pipe_parent[0];
+
+	/* Capabilities must be set before creating a new thread. */
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, pthread_create(&no_sandbox_thread, NULL, thread_setuid,
+				    &arg));
+
+	/* Enforces restriction after creating the thread. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+	EXPECT_NE(arg.new_uid, getuid());
+	EXPECT_EQ(0, setuid(arg.new_uid));
+	EXPECT_EQ(arg.new_uid, getuid());
+	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
+	EXPECT_EQ(THREAD_SUCCESS, ret);
+
+	clear_cap(_metadata, CAP_SETUID);
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+}
+
 const short backlog = 10;
 
 static volatile sig_atomic_t signal_received;
-- 
2.48.1


