Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682AB571CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiGLOjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 10:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiGLOjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:39:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D492495E;
        Tue, 12 Jul 2022 07:39:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf4so13509996ejc.3;
        Tue, 12 Jul 2022 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MkimO/JYfFEWErwwRlGZI0yEI3KTdQ++omf5SZxftc4=;
        b=kBVAhs7SuDDu7URHr0MlshT8v64mj4buHFbV/4Rbh3RrmSkwTHDt/+porNaTfhjeFR
         xQOmNyrpXOnrt8deh+kv+2VUxxwjT+BKXdjUI8+V4u3t+40qiOkj5c/o/twvWDLnuDPL
         mD1BhRtPWDZ4ZqOHWJHDqSLGcdP+R5rjEH0bxu8I4uaAmrxonjwyid8CLhkI3RbjPeF8
         fBke5NR6KZUfvlPwGMJHOUFx9Y7v20jN+kibypMCu8Mt/RMIwavyux3ZxxnsuIQw/XW5
         Augm2qz4Ec/06nsrp5NMYBbRDmHDyzIG+65HY5RehskEXxqmsOPLbLzi2Z0/TFKdocI3
         zrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MkimO/JYfFEWErwwRlGZI0yEI3KTdQ++omf5SZxftc4=;
        b=WYG/PCHS51lHr1DFIMdNVTgZ/YOL7CsTtX9I46/RMBqXxT5R2XYyktMZgIAaIHHX03
         r8DP9JhpU4EWrxrUDylsc5XKYG5+Rrec2z7d/ws7QIUCapOlswxuYJELHUx8mEwEqJqD
         OW87unmtyydtMW2jmPi3OeOYPVWPYwj7WY9+hRrd6t35eyHwGibrsmGkaeBtbYzF4zHc
         rh7ixEFjqVuRk1WXt3z/S0gk0qs7fHq1DOHaWexx5zGsjpFzZapFOMZ/oBFXDtww3hxy
         seqUXA/CP0LBREP2em0SXRhQYun2i2z7vOonHong2DYhGsASD1UH8khx6f3d2KJlOquR
         Z2yg==
X-Gm-Message-State: AJIora/1rKolZ8GEdCfnMtK8jKnhIgcXtNCdEmg7Xvfzlxh9k3PjS2b7
        exeOWHPzr8T6VSkg9SAv7A==
X-Google-Smtp-Source: AGRyM1sFrjxb8Xrs4zv78FZe/7YJyrbgXHAoRlUjqwvCnWRK+PDXIDo+aqby0XL2zc8NS68689prlw==
X-Received: by 2002:a17:906:7b82:b0:6f3:ee8d:b959 with SMTP id s2-20020a1709067b8200b006f3ee8db959mr24608884ejo.458.1657636750966;
        Tue, 12 Jul 2022 07:39:10 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.195])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b006feec47dae9sm3861670ejt.157.2022.07.12.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:39:09 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:39:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dylanbhatch@google.com,
        skhan@linuxfoundation.org
Subject: [PATCH] proc: fix test for "vsyscall=xonly" boot option
Message-ID: <Ys2Hi3Ps933B6IsE@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Booting with vsyscall=xonly results in the "--xp" vsyscall VMA:

	ffffffffff600000-ffffffffff601000 --xp ... [vsyscall]\n

Test does read from fixed vsyscall address to determine if kernel
supports vsyscall page but it doesn't work with vsyscall=xonly
because, well, vsyscall page is execute only.

Fix test by trying to execute from the first byte of the page
(which contains gettimeofday() stub). This should work because vsyscall
entry points themselves have stable addresses by design.

	Alexey, avoiding parsing .config, /proc/config.gz and
	/proc/cmdline at all costs.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	I'm not sure who reported what, so please add tested-by and
	reported-by lines.

 tools/testing/selftests/proc/proc-pid-vm.c |   75 ++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 7 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -211,10 +211,19 @@ static int make_exe(const uint8_t *payload, size_t len)
 }
 #endif
 
-static bool g_vsyscall = false;
+/*
+ * 0: vsyscall VMA doesn't exist	vsyscall=none
+ * 1: vsyscall VMA is r-xp		vsyscall=emulate
+ * 2: vsyscall VMA is --xp		vsyscall=xonly
+ */
+static int g_vsyscall;
+static const char *str_vsyscall;
 
-static const char str_vsyscall[] =
+static const char str_vsyscall_0[] = "";
+static const char str_vsyscall_1[] =
 "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
+static const char str_vsyscall_2[] =
+"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
 
 #ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
@@ -223,13 +232,47 @@ static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 }
 
 /*
- * vsyscall page can't be unmapped, probe it with memory load.
+ * vsyscall page can't be unmapped, probe it directly.
  */
 static void vsyscall(void)
 {
 	pid_t pid;
 	int wstatus;
 
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "fork, errno %d\n", errno);
+		exit(1);
+	}
+	if (pid == 0) {
+		struct rlimit rlim = {0, 0};
+		(void)setrlimit(RLIMIT_CORE, &rlim);
+
+		/* Hide "segfault at ffffffffff600000" messages. */
+		struct sigaction act;
+		memset(&act, 0, sizeof(struct sigaction));
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = sigaction_SIGSEGV;
+		(void)sigaction(SIGSEGV, &act, NULL);
+
+		/* gettimeofday(NULL, NULL); */
+		asm volatile (
+			"call %P0"
+			:
+			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
+			: "rax"
+		);
+		exit(0);
+	}
+	waitpid(pid, &wstatus, 0);
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
+		/* vsyscall page exists and is executable. */
+	} else {
+		/* vsyscall page doesn't exist. */
+		g_vsyscall = 0;
+		return;
+	}
+
 	pid = fork();
 	if (pid < 0) {
 		fprintf(stderr, "fork, errno %d\n", errno);
@@ -251,8 +294,13 @@ static void vsyscall(void)
 	}
 	waitpid(pid, &wstatus, 0);
 	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
-		g_vsyscall = true;
+		/* vsyscall page is readable and executable. */
+		g_vsyscall = 1;
+		return;
 	}
+
+	/* vsyscall page is executable but unreadable. */
+	g_vsyscall = 2;
 }
 
 int main(void)
@@ -261,6 +309,19 @@ int main(void)
 	int exec_fd;
 
 	vsyscall();
+	switch (g_vsyscall) {
+	case 0:
+		str_vsyscall = str_vsyscall_0;
+		break;
+	case 1:
+		str_vsyscall = str_vsyscall_1;
+		break;
+	case 2:
+		str_vsyscall = str_vsyscall_2;
+		break;
+	default:
+		abort();
+	}
 
 	atexit(ate);
 
@@ -314,7 +375,7 @@ int main(void)
 
 	/* Test /proc/$PID/maps */
 	{
-		const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
+		const size_t len = strlen(buf0) + strlen(str_vsyscall);
 		char buf[256];
 		ssize_t rv;
 		int fd;
@@ -327,7 +388,7 @@ int main(void)
 		rv = read(fd, buf, sizeof(buf));
 		assert(rv == len);
 		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
-		if (g_vsyscall) {
+		if (g_vsyscall > 0) {
 			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
 		}
 	}
@@ -374,7 +435,7 @@ int main(void)
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 
-		if (g_vsyscall) {
+		if (g_vsyscall > 0) {
 			assert(memmem(buf, rv, str_vsyscall, strlen(str_vsyscall)));
 		}
 	}
