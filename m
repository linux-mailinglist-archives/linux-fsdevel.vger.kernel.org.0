Return-Path: <linux-fsdevel+bounces-43903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9FA5F928
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1E3B4455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CA2686B4;
	Thu, 13 Mar 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mtIUYoTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133B267F7D;
	Thu, 13 Mar 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877962; cv=none; b=B8N9KTIgZQVbBdv3ePRIbt2NZwCBGkc7KkbmnyWb/2TmlNYAUdnaW//SQD5ZSEZHC/jlX0bWo6de2gLulN+/2zpEWpp0yML6KC42+wOD2v/rYAJ9cimN9+o132hb5/bCGSVKZjGqlZw6/03cw5jCRFmQxdG+0rPOIhYnfCPd/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877962; c=relaxed/simple;
	bh=5liuPlBqcaflDWW/TPdi7YXsdgu4Qktt64p67vZjWFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhlvOgMYqi/rF0FCatUdLWTGxaFpnjZufWQvdEWMoN9C6bQnCFqV/lhrIsDwRiwYRdKWXFpfbrJXdOfVWZ6ZARZ6q3JC6Aei5khD0Abp2X9PVKLsBGw7/x3hwa9W12Z1TRcN7wZJiBhWU2VXRmPIzDSB/1fBMqZesj4BvQ0n+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mtIUYoTt; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZD9cr1zkCzC2d;
	Thu, 13 Mar 2025 15:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741877948;
	bh=0Gf1DhgQRyBiPnPBQsXXR7n45nbxbcPvMlsb2hmwO+s=;
	h=From:To:Cc:Subject:Date:From;
	b=mtIUYoTtQ0tdNQjqeBvqnicNw6dpqGUbj8D4veT61dES8X6IhDRLYCShmU6ku9M4v
	 IBmZw2jJOwXSbpA9FPw1LwoBgq7nGkAhUer8/aTj5n/NzUoq7WPzj/I6bqdulSAAir
	 cNXi7s/oYO7ToWmSzvA/LReu/2VlyZztzjCTriRE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZD9cq3ZlSzD7B;
	Thu, 13 Mar 2025 15:59:07 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC PATCH v1] landlock: Allow signals between threads of the same process
Date: Thu, 13 Mar 2025 15:59:04 +0100
Message-ID: <20250313145904.3238184-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Because Linux credentials are managed per thread, user space relies on
some hack to synchronize credential update across threads from the same
process.  This is required by the Native POSIX Threads Library and
implemented by set*id(2) wrappers and libcap(3) to use tgkill(2) to
synchronize threads.  See nptl(7) and libpsx(3).  Furthermore, some
runtimes like Go do not enable developers to have control over threads
[1].

To avoid potential issues, and because threads are not security
boundaries, let's relax the Landlock signal scoping to always allow
signals sent between threads of the same process.  This exception is
similar to the __ptrace_may_access() one.

hook_file_set_fowner() now checks if the target task is part of the same
process as the caller.  If this is the case, then the related signal
triggered by the socket will always be allowed.

Scoping of abstract UNIX sockets is not changed because kernel objects
(e.g. sockets) should be tied to their creator's domain at creation
time.

Note that creating one Landlock domain per thread puts each of these
threads (and their future children) in their own scope, which is
probably not what users expect, especially in Go where we do not control
threads.  However, being able to drop permissions on all threads should
not be restricted by signal scoping.  We are working on a way to make it
possible to atomically restrict all threads of a process with the same
domain [2].

Closes: https://github.com/landlock-lsm/go-landlock/issues/36
Fixes: 54a6e6bbf3be ("landlock: Add signal scoping")
Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
Depends-on: 26f204380a3c ("fs: Fix file_set_fowner LSM hook inconsistencies")
Link: https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/psx [1]
Link: https://github.com/landlock-lsm/linux/issues/2 [2]
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250313145904.3238184-1-mic@digikod.net
---

I'm still not sure how we could reliably detect if the running kernel
has this fix or not, especially in Go.
---
 security/landlock/fs.c                        | 22 +++++++++++++++----
 security/landlock/task.c                      | 12 ++++++++++
 .../selftests/landlock/scoped_signal_test.c   |  2 +-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 71b9dc331aae..47c862fe14e4 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -27,7 +27,9 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/signal.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
 #include <linux/types.h>
@@ -1630,15 +1632,27 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 
 static void hook_file_set_fowner(struct file *file)
 {
-	struct landlock_ruleset *new_dom, *prev_dom;
+	struct fown_struct *fown = file_f_owner(file);
+	struct landlock_ruleset *new_dom = NULL;
+	struct landlock_ruleset *prev_dom;
+	struct task_struct *p;
 
 	/*
 	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
 	 * file_set_fowner LSM hook inconsistencies").
 	 */
-	lockdep_assert_held(&file_f_owner(file)->lock);
-	new_dom = landlock_get_current_domain();
-	landlock_get_ruleset(new_dom);
+	lockdep_assert_held(&fown->lock);
+
+	/*
+	 * Always allow sending signals between threads of the same process.  This
+	 * ensures consistency with hook_task_kill().
+	 */
+	p = pid_task(fown->pid, fown->pid_type);
+	if (!same_thread_group(p, current)) {
+		new_dom = landlock_get_current_domain();
+		landlock_get_ruleset(new_dom);
+	}
+
 	prev_dom = landlock_file(file)->fown_domain;
 	landlock_file(file)->fown_domain = new_dom;
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index dc7dab78392e..4578ce6e319d 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -13,6 +13,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <net/af_unix.h>
 #include <net/sock.h>
 
@@ -264,6 +265,17 @@ static int hook_task_kill(struct task_struct *const p,
 		/* Dealing with USB IO. */
 		dom = landlock_cred(cred)->domain;
 	} else {
+		/*
+		 * Always allow sending signals between threads of the same process.
+		 * This is required for process credential changes by the Native POSIX
+		 * Threads Library and implemented by the set*id(2) wrappers and
+		 * libcap(3) with tgkill(2).  See nptl(7) and libpsx(3).
+		 *
+		 * This exception is similar to the __ptrace_may_access() one.
+		 */
+		if (same_thread_group(p, current))
+			return 0;
+
 		dom = landlock_get_current_domain();
 	}
 	dom = landlock_get_applicable_domain(dom, signal_scope);
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 475ee62a832d..767f117703b7 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -281,7 +281,7 @@ TEST(signal_scoping_threads)
 	/* Restricts the domain after creating the first thread. */
 	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
 
-	ASSERT_EQ(EPERM, pthread_kill(no_sandbox_thread, 0));
+	ASSERT_EQ(0, pthread_kill(no_sandbox_thread, 0));
 	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
 
 	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.48.1


