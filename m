Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB8660723
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAFTaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 14:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjAFTaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:30:19 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135FB14D02;
        Fri,  6 Jan 2023 11:30:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m18so5677126eji.5;
        Fri, 06 Jan 2023 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmDHBoIoLadMu0Asj1DLZDWnRgLsgqhRy9d3kzCtsbk=;
        b=fBSt+s/kl5kXlV1FTvypk7dxtpv+6oPtbovssMhu4Q25Fp6vyR+EMA4tPOnB12Fc03
         MvvrJGBQcviV5iUqCdonSuf0vrBgfR2qn0fnSaintaFBYBomCV5VcddZQG+nL2J5fpzB
         pveWieFdK4GqaIFCY5wKDedE5QgQatt5hJ/+bUSDJRrLLs/1gCOpU6FKRYQP0/kpYIiI
         64BQvCGYHfRYV6LttaTEra22DNt624VAFh+ddUNsg9P32oQjp8vUo6CJ7QQHNyYt+kvd
         REKIvBr/8AhSUw3DS7XYnnsqMcnJHRawaJUbIgFvqrcLEhUowl69q6SGI1QNvf6Miecs
         8UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmDHBoIoLadMu0Asj1DLZDWnRgLsgqhRy9d3kzCtsbk=;
        b=qmYhwlCjfGlpN1V6vuo8a/ktwcjz7md4craS8vIWm4YQVvG8ckCVLU9CzRW98csJFt
         7KmR7z+LSAwyGOQfMNqgc91aP+apZiWPafUBUAdB7DHxlj7hiKj0NnZAjT1t/VX4nC1J
         oqEnXJYKuVrjfL3nkEuuWJSWcA880wHjDSmia3/RMIuQCNRvbLhqslzLreFWuuO8s/Sj
         H4gIt9ImxODxdILGKIkKUBDrN1+btZgVH5zb5c3jFfukZ1xZSMLp137QvdGf/0bcnzRB
         EJ43Kr3fBZu4uHB+Mfyw4u6ZqtWQKtEGdtccO4OkFaSP5KXEgEbeJ5Jc61YxqZs5e9Zq
         qxsw==
X-Gm-Message-State: AFqh2kq0zw9pcVt05bPtt86QP6s1Ozn6RYGzLv3+u1CI5w8Xnluojctm
        nGbPKCHfBx8GfOrdiDPlVrb1LbUdZQ==
X-Google-Smtp-Source: AMrXdXuoEr49qzXo+JbmRXTlMavUPZCQXqCp1GFjHebdRFtRuCA6gEm1EM7jKSCFx89J5Q6Zxl17yg==
X-Received: by 2002:a17:907:11cf:b0:7c2:3b8a:9f0d with SMTP id va15-20020a17090711cf00b007c23b8a9f0dmr49674013ejb.51.1673033416581;
        Fri, 06 Jan 2023 11:30:16 -0800 (PST)
Received: from p183 ([46.53.252.178])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090646c900b007806c1474e1sm666404ejs.127.2023.01.06.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:30:16 -0800 (PST)
Date:   Fri, 6 Jan 2023 22:30:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH] proc: fix PIE proc-empty-vm, proc-pid-vm tests
Message-ID: <Y7h2xvzKLg36DSq8@p183>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vsyscall detection code uses direct call to the beginning of
the vsyscall page:

	asm ("call %P0" :: "i" (0xffffffffff600000))

It generates "call rel32" instruction but it is not relocated if binary
is PIE, so binary segfaults into random userspace address and vsyscall
page status is detected incorrectly.

Do more direct:

	asm ("call *%rax")

which doesn't do need any relocaltions.

Mark g_vsyscall as volatile for a good measure, I didn't find instruction
setting it to 0. Now the code is obviously correct:

	xor	eax, eax
	mov	rdi, rbp
	mov	rsi, rbp
	mov	DWORD PTR [rip+0x2d15], eax      # g_vsyscall = 0
	mov	rax, 0xffffffffff600000
	call	rax
	mov	DWORD PTR [rip+0x2d02], 1        # g_vsyscall = 1
	mov	eax, DWORD PTR ds:0xffffffffff600000
	mov	DWORD PTR [rip+0x2cf1], 2        # g_vsyscall = 2
	mov	edi, [rip+0x2ceb]                # exit(g_vsyscall)
	call	exit

Note: fixed proc-empty-vm test oopses 5.19.0-28-generic kernel
	but this is separate story.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---

 tools/testing/selftests/proc/proc-empty-vm.c |   12 +++++++-----
 tools/testing/selftests/proc/proc-pid-vm.c   |    9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -25,6 +25,7 @@
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -41,7 +42,7 @@
  * 1: vsyscall VMA is --xp		vsyscall=xonly
  * 2: vsyscall VMA is r-xp		vsyscall=emulate
  */
-static int g_vsyscall;
+static volatile int g_vsyscall;
 static const char *g_proc_pid_maps_vsyscall;
 static const char *g_proc_pid_smaps_vsyscall;
 
@@ -147,11 +148,12 @@ static void vsyscall(void)
 
 		g_vsyscall = 0;
 		/* gettimeofday(NULL, NULL); */
+		uint64_t rax = 0xffffffffff600000;
 		asm volatile (
-			"call %P0"
-			:
-			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
-			: "rax", "rcx", "r11"
+			"call *%[rax]"
+			: [rax] "+a" (rax)
+			: "D" (NULL), "S" (NULL)
+			: "rcx", "r11"
 		);
 
 		g_vsyscall = 1;
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -257,11 +257,12 @@ static void vsyscall(void)
 
 		g_vsyscall = 0;
 		/* gettimeofday(NULL, NULL); */
+		uint64_t rax = 0xffffffffff600000;
 		asm volatile (
-			"call %P0"
-			:
-			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
-			: "rax", "rcx", "r11"
+			"call *%[rax]"
+			: [rax] "+a" (rax)
+			: "D" (NULL), "S" (NULL)
+			: "rcx", "r11"
 		);
 
 		g_vsyscall = 1;
