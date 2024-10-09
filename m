Return-Path: <linux-fsdevel+bounces-31482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD159976BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B101C2282D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39871E25E9;
	Wed,  9 Oct 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="YHdhUXRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CE1E1C3A;
	Wed,  9 Oct 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506534; cv=none; b=lox6pB9piFcE3PnsV4Z7hy2WNlNM0VlQtoqdTyLmjLyEB6h+aWb1HE12Cj3wMepY16v4Cjji6ut9HEBKMAm+1hhWrePS702BdPNAwmrUArx/OnwgrqIOYNH6vErydd9H9WdiHcm+O9+Kre268uGWochW9R57bQyvkRBEJD6bQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506534; c=relaxed/simple;
	bh=o94o6Toa1Pf4WLXPtt6pgYs8bPe/h3R8eYg1DJcRyfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVbwDj/t/AKokRAWofaKHQmCxj+KciNzm3Xl8KqZQ7jqG0lyJlFRnLCkwkoN4aynoeDeu1e5p3+7296mxlA++lUKmhw/aRihXg+I5qQsYfiMUs74t+IbnJnS+qiRfJlCvuDFqIDP2gJIq/X3fX+YPtBNxvzP0Ml08C28Q7lf2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=YHdhUXRB; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XP4Z83lbZz9tWL;
	Wed,  9 Oct 2024 22:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvFZhzQibMAuUvYkTNP2DH0255R8R25uInAVXxNHfKg=;
	b=YHdhUXRBKlxTgq4+K/HlwfGxQBDTI71pIUfYv584e8mB89gfH9rI/6vEcB6c53DJO7+iIP
	KkFAT4YwWVBW7EDf9WhVmCG9FIIhYJV4bBsovbzxKDjunp6m6xzWPVXT3Vt5lwQDFZQJTD
	vBVlEZhhRXvv7bzJIIn2XRD0Bq/bkZFwoupWWfJ+qUYO+VMur0YzDszJoGdwTv7YieL41L
	I8evJBQzvv7oUrHP4+RgPV3QsgbxEvLamvfo6IHlsJNOhwbfV/VxtMzGl/Zuj5Rc9IlvQZ
	LNHXmTNRzMAfCbDOoDBsa+FGbpC/rrUUiQdCJXRZhuWkdpstPMdbSKlRhJstKg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:40 +1100
Subject: [PATCH RFC v3 07/10] clone3: add CHECK_FIELDS flag to usize
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-7-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3623; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=o94o6Toa1Pf4WLXPtt6pgYs8bPe/h3R8eYg1DJcRyfA=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQpi/nFmTv/HWQZ/e9iOrts0+5HWpvx/mrO//3+Zq
 xnXNi+htaOUhUGMi0FWTJFlm59n6Kb5i68kf1rJBjOHlQlkCAMXpwBMpCaIkeHJlqsuiUyc07jr
 1kZXfOsz7tDIu7xi45pKHeWZvc5CE9wZ/gpmfeUW+7bTzl9xftEHkb8qAVdqVJh31nrN6fPb8ex
 HDisA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

As with openat2(2), this allows userspace to easily figure out what
flags and fields are supported by clone3(2). For fields which are not
flag-based, we simply set every bit in the field so that a naive
bitwise-and would show that any value of the field is valid.

For args->exit_signal, since we have an explicit bitmask for the field
defined already (CSIGNAL) we can indicate that only those bits are
supported by current kernels. If we add some extra bits to exit_signal
in the future, being able to detect them as new features would be quite
useful.

The intended way of using this interface to get feature information
looks something like the following:

  static bool clone3_clear_sighand_supported;
  static bool clone3_cgroup_supported;

  int check_clone3_support(void)
  {
      int err;
      struct clone_args args = {};

      err = clone3(&args, CHECK_FIELDS | sizeof(args));
      assert(err < 0);
      switch (errno) {
      case EFAULT: case E2BIG:
          /* Old kernel... */
          check_support_the_old_way();
          break;
      case EEXTSYS_NOOP:
          clone3_clear_sighand_supported = (how.flags & CLONE_CLEAR_SIGHAND);
          clone3_cgroup_supported = (how.flags & CLONE_INTO_CGROUP) &&
                                    (how.cgroup != 0);
          break;
      }
  }

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 kernel/fork.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..bded93f4f5f4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2925,11 +2925,15 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 }
 #endif
 
+
+#define CLONE3_VALID_FLAGS (CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP)
+
 noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t usize)
 {
 	int err;
+	bool check_fields;
 	struct clone_args args;
 	pid_t *kset_tid = kargs->set_tid;
 
@@ -2941,11 +2945,34 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER2);
 	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
 
+	check_fields = usize & CHECK_FIELDS;
+	usize &= ~CHECK_FIELDS;
+
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
 	if (unlikely(usize < CLONE_ARGS_SIZE_VER0))
 		return -EINVAL;
 
+	if (unlikely(check_fields)) {
+		memset(&args, 0, sizeof(args));
+		args = (struct clone_args) {
+			.flags = CLONE3_VALID_FLAGS,
+			.pidfd = 0xFFFFFFFFFFFFFFFF,
+			.child_tid = 0xFFFFFFFFFFFFFFFF,
+			.parent_tid = 0xFFFFFFFFFFFFFFFF,
+			.exit_signal = (u64) CSIGNAL,
+			.stack = 0xFFFFFFFFFFFFFFFF,
+			.stack_size = 0xFFFFFFFFFFFFFFFF,
+			.tls = 0xFFFFFFFFFFFFFFFF,
+			.set_tid = 0xFFFFFFFFFFFFFFFF,
+			.set_tid_size = 0xFFFFFFFFFFFFFFFF,
+			.cgroup = 0xFFFFFFFFFFFFFFFF,
+		};
+
+		err = copy_struct_to_user(uargs, usize, &args, sizeof(args), NULL);
+		return err ?: -EEXTSYS_NOOP;
+	}
+
 	err = copy_struct_from_user(&args, sizeof(args), uargs, usize);
 	if (err)
 		return err;
@@ -3025,8 +3052,7 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
-	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	if (kargs->flags & ~CLONE3_VALID_FLAGS)
 		return false;
 
 	/*

-- 
2.46.1


