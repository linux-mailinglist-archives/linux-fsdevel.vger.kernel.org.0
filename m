Return-Path: <linux-fsdevel+bounces-28752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6096DCFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7960F1F22B73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9441A256C;
	Thu,  5 Sep 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="RnR9oQcP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37D6E614;
	Thu,  5 Sep 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548297; cv=none; b=cU3EogKP5vWlBoeXAwRYHY8V1x/S5t5xQtiNMGg8zWx1eRZT2vPxaiYPUTUh0e6c/c+j795b/nQD2bfS7Ggezg7Rq3wS6yVH+2hRDA+72EGM29r13WjMvIPOJzSSRa/q/w1P8usB2BWAaTRzZvxpy1T7J22jybjcOrqHLlbrG0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548297; c=relaxed/simple;
	bh=F4+nNIP45rPDTnusEiNx0LRIIo0bh6KraTxorV1cxo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tiw0yssSSOFwjQEGqEYY3freItvxwiak2RcMtX+kUxiBpF94nbqqUZAOlddozjM17jcuGD0MM1Kz3Mz12wTYviw6qqV6HMvbeM8QZyTq9WXkDp+f27Mtywr3VMeSRyCRxRgPURpYTWPvJlNB7UBair/fzUfsMEZ7mx0uypkqwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=RnR9oQcP; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X02Xz5Y52z9t6V;
	Thu,  5 Sep 2024 16:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5CFQmS4dg9kR/Y1AQq6jUMvui07sBICi7CdGXa1jOM=;
	b=RnR9oQcP6flLcUpDRm66sWqD5s4cdBHutixL3k3ZFVJJjwIJY4UkEjLSW6klQzZb97CAdk
	+GgL+avzS43wpGM2DkvKYgBLFnWzo1o5Ip2Gxun1kf1+urTdUZD76FSbKiZL8Y2U1eXpnv
	TGHmdYfjYqXVIgpLoROab+oI3CF+cdQ/sy5AMECdQY8O2Yk5kFpHcYnelyWr9Nu9F4A5aH
	o/SNfCM0dV0kZVKyOrcRG9rVb0qnfhIoV3h2F9OHZitAyUqtwIXNUtaoHUcbsYFPfRyHPz
	740ZWUhT7detwW39RYNbQsiSChduOc/LvxUkWLrZq2tcYFGlTLdYIQu2VE7kKg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:39 +1000
Subject: [PATCH RFC v2 07/10] clone3: add CHECK_FIELDS flag to usize
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-7-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
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
 h=from:subject:message-id; bh=F4+nNIP45rPDTnusEiNx0LRIIo0bh6KraTxorV1cxo4=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLYlqadKg7frn47bipXXp1mKn+YoWX8ukSFqYuuWb
 1tmSO2q7ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQAT+fuOkWHX5bep1yP9w4r/
 Pgt8zLtoosvmvH9n/k5yqPW+yxn82GAzI8MBp+sHzZVelu9qi67i6wqsmnBzls5+i5t3jQ+rJi7
 VSeUDAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4X02Xz5Y52z9t6V

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
2.46.0


