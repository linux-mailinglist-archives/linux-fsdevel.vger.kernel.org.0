Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF91FA6DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFPD0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 23:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFPDZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 23:25:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4AAC008638
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so898951pjd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rE3Y2iFwUUd87kC4LPkJ/n5Ro7lODcTLpnlUXVeVqP4=;
        b=V3XA0nHMmtCHiAAjYJ+ZyCD0LYHJYFVci/dawxxSgdePAiA4xV8RysbhxpPr+L3zVP
         34KqKhpQ2oyvvwl6p1Hw7IgxnST9JWeyZLSe5rxdOOI4bbcYAgkCRIRj4tk0JM60C9JZ
         M+G42YS35Vm30gy42rDJy0fo0E5XO0KuRrgn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rE3Y2iFwUUd87kC4LPkJ/n5Ro7lODcTLpnlUXVeVqP4=;
        b=B8YX0aVajjfUN2K1bc2ChQ6Ye1SUKL51Bn+0yOl2vYBmY7WqJP+RM0foiP4GlTtFrH
         2gof4LWSNe0OEcpGolUAgSAcApK99Yeg6thGr5vLaMjvWxNK9sh8zlnaMbxfKRkpA+fe
         0RBCI0kZPaNTg1Up3KUGP2fN758+e+dxs3A59fPJKnC9bQPwLUHEPQ4hupyR0vr46yJq
         dmD4Azn/al2rXwBVQJLFuNmcF5FbtKb9OeP4U68ao+Y0/j+MB2ZfWyRmVmAAHuWf37LB
         L9yh2jEWAhRm0ma7Woawg06Km9xqB5DAcg4Y0Be3zBEtemlDXfSMM3iRPeKcXmX8KD0N
         ToHQ==
X-Gm-Message-State: AOAM533Th6sPmsuHh7E7UElSn8we0sX6D3cAzb66POrQIfeFF5AZ8Hrb
        h+UACPMz8rEl3wEKGy5zs/x9rQ==
X-Google-Smtp-Source: ABdhPJxCZqVuV3kzeXed/HFT/JXAbaWaHZ3nnHfrJBQ1uX2cvtIopqK121014OWTVMCuzhtnGpPz3A==
X-Received: by 2002:a17:90b:234c:: with SMTP id ms12mr836787pjb.164.1592277935719;
        Mon, 15 Jun 2020 20:25:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ds11sm785227pjb.0.2020.06.15.20.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 20:25:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 09/11] selftests/seccomp: Rename user_trap_syscall() to user_notif_syscall()
Date:   Mon, 15 Jun 2020 20:25:22 -0700
Message-Id: <20200616032524.460144-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032524.460144-1-keescook@chromium.org>
References: <20200616032524.460144-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The user_trap_syscall() helper creates a filter with
SECCOMP_RET_USER_NOTIF. To avoid confusion with SECCOMP_RET_TRAP, rename
the helper to user_notif_syscall().

Additionally fix a redundant "return" after XFAIL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 40ed846744e4..95b134933831 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3110,10 +3110,8 @@ TEST(get_metadata)
 	long ret;
 
 	/* Only real root can get metadata. */
-	if (geteuid()) {
-		XFAIL(return, "get_metadata requires real root");
-		return;
-	}
+	if (geteuid())
+		XFAIL(return, "get_metadata test requires real root");
 
 	ASSERT_EQ(0, pipe(pipefd));
 
@@ -3170,7 +3168,7 @@ TEST(get_metadata)
 	ASSERT_EQ(0, kill(pid, SIGKILL));
 }
 
-static int user_trap_syscall(int nr, unsigned int flags)
+static int user_notif_syscall(int nr, unsigned int flags)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
@@ -3216,7 +3214,7 @@ TEST(user_notification_basic)
 
 	/* Check that we get -ENOSYS with no listener attached */
 	if (pid == 0) {
-		if (user_trap_syscall(__NR_getppid, 0) < 0)
+		if (user_notif_syscall(__NR_getppid, 0) < 0)
 			exit(1);
 		ret = syscall(__NR_getppid);
 		exit(ret >= 0 || errno != ENOSYS);
@@ -3233,13 +3231,13 @@ TEST(user_notification_basic)
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 
 	/* Check that the basic notification machinery works */
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	/* Installing a second listener in the chain should EBUSY */
-	EXPECT_EQ(user_trap_syscall(__NR_getppid,
-				    SECCOMP_FILTER_FLAG_NEW_LISTENER),
+	EXPECT_EQ(user_notif_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER),
 		  -1);
 	EXPECT_EQ(errno, EBUSY);
 
@@ -3303,12 +3301,12 @@ TEST(user_notification_with_tsync)
 	/* these were exclusive */
 	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
 		SECCOMP_FILTER_FLAG_TSYNC;
-	ASSERT_EQ(-1, user_trap_syscall(__NR_getppid, flags));
+	ASSERT_EQ(-1, user_notif_syscall(__NR_getppid, flags));
 	ASSERT_EQ(EINVAL, errno);
 
 	/* but now they're not */
 	flags |= SECCOMP_FILTER_FLAG_TSYNC_ESRCH;
-	ret = user_trap_syscall(__NR_getppid, flags);
+	ret = user_notif_syscall(__NR_getppid, flags);
 	close(ret);
 	ASSERT_LE(0, ret);
 }
@@ -3326,8 +3324,8 @@ TEST(user_notification_kill_in_middle)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	/*
@@ -3380,8 +3378,8 @@ TEST(user_notification_signal)
 
 	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
 
-	listener = user_trap_syscall(__NR_gettid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_gettid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3450,8 +3448,8 @@ TEST(user_notification_closed_listener)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	/*
@@ -3484,8 +3482,8 @@ TEST(user_notification_child_pid_ns)
 
 	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
 
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3524,8 +3522,8 @@ TEST(user_notification_sibling_pid_ns)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3589,8 +3587,8 @@ TEST(user_notification_fault_recv)
 
 	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
 
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3641,7 +3639,7 @@ TEST(user_notification_continue)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3736,7 +3734,7 @@ TEST(user_notification_filter_empty)
 	if (pid == 0) {
 		int listener;
 
-		listener = user_trap_syscall(__NR_mknod, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		listener = user_notif_syscall(__NR_mknod, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 		if (listener < 0)
 			_exit(EXIT_FAILURE);
 
@@ -3792,7 +3790,7 @@ TEST(user_notification_filter_empty_threaded)
 		int listener, status;
 		pthread_t thread;
 
-		listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		listener = user_notif_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 		if (listener < 0)
 			_exit(EXIT_FAILURE);
 
@@ -3869,8 +3867,8 @@ TEST(user_notification_sendfd)
 	}
 
 	/* Check that the basic notification machinery works */
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3993,8 +3991,8 @@ TEST(user_notification_sendfd_rlimit)
 	}
 
 	/* Check that the basic notification machinery works */
-	listener = user_trap_syscall(__NR_getppid,
-				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
-- 
2.25.1

