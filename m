Return-Path: <linux-fsdevel+bounces-28206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D33968011
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B01F213E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0B417E8E2;
	Mon,  2 Sep 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="TktvPOUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543C17B51B;
	Mon,  2 Sep 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260875; cv=none; b=SVX/h3Udm4U0W6mB0Edk1SVgqQrn64Hsb1JZY1+ypv9nBPxU4a1HDivNxBVc9nWeEW9RNdw0EHsVTIUlVaAtoZNUfh4Oj99p3tIxdrSA/jcUL+7w09daPdzOkzCSOCCVYzD7jqKFUaS8U0eEZNsgL0bo0buprtU8mjdPA+G+vvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260875; c=relaxed/simple;
	bh=AvNm6GNn27uxCEZPdXlR1U4pUmIyZHmVqQFO6K4P0Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpJGjhT/T/3BiNpyzPOF/ltrfCrmD5jvnuh/OOPKKA9IvgrSzJ6UHGFO3so2fUPJAddtgHyzrHHCtYcXPxUGtouSmvfShogpzfd7NazLd1QQQ8XHgam2LSBrfSfRIqgdy5BTIX10mxBQ7aOyQYoBWX0kmiDOTXJJFLEWqt/pbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=TktvPOUi; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wy0FX2cRjz9tGD;
	Mon,  2 Sep 2024 09:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYEDlNo9L4pHF0QLPlL4TCKGDXH3Koc/Agi/hXqQ5Us=;
	b=TktvPOUiUDYm42A3LoHT2Jgt46RVFmcyHkixoakr9BnJGGCwoqh6ccTuXHjxy5TdBPg5Qg
	0WTKuyD3dgATjhA0tSMH9xTr4e7C4VTFNg2WVDp0XBeYpgL57lQYUqV+pdJA7yePCmnNgt
	uEfDbaDlyWJYaJH0P3j0XGTshTtJluCOOOtWKq+B46AqZ5Q0nK98N0sLEwJ/OzynEE2DG2
	4fdpEV2SOcbL722uJnOCo4Thfze3utWMfFIUjJnjJMv+yPeaIssmvk/q5Je5gaEskoDp0S
	LQVfKQCG+ls8OaT5HCyC7XR45fTTAqW1zp+Hph2Jh+7+4pdpPzlNPnCQ9IJuKA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:27 +1000
Subject: [PATCH RFC 5/8] clone3: add CHECK_FIELDS flag to usize argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-5-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=AvNm6GNn27uxCEZPdXlR1U4pUmIyZHmVqQFO6K4P0Fs=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWGRfKLbWfTzyWQDZXbJB7trPsvMbMlZePQU0wzGn
 Q9DPlnXdpSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJcPIx/JWZlivFcNxOy6qr
 WdVhyZzPfxaeuJTXp62UIS2hu3RD1EuG/0W+Kqy3H5tsmXh7qfxkB56vTfN0Gvr57r7pcdlrs2W
 WLx8A
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
 kernel/fork.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..1a170098a1c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2925,6 +2925,9 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 }
 #endif
 
+
+#define CLONE3_VALID_FLAGS (CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP)
+
 noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t usize)
@@ -2941,11 +2944,34 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER2);
 	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
 
-	if (unlikely(usize > PAGE_SIZE))
-		return -E2BIG;
 	if (unlikely(usize < CLONE_ARGS_SIZE_VER0))
 		return -EINVAL;
 
+	if (unlikely(usize & CHECK_FIELDS)) {
+		usize &= ~CHECK_FIELDS;
+
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
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
+
 	err = copy_struct_from_user(&args, sizeof(args), uargs, usize);
 	if (err)
 		return err;
@@ -3025,8 +3051,7 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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


