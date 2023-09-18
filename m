Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF30A7A49C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbjIRMdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbjIRMc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:32:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0173F12F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so966461366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695040357; x=1695645157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X6QtCgWBlGiAp6h0kF11KB6rl566Y3up0YcWsWItks=;
        b=Tj2vtYb6TouL5/hGJnJfRgF1fUCrUMB9K0ph236O723alETthSQocRNC6PdHDca5Kb
         9Ss13k7zOLBqEl6KbNyO6WdJ0svtavKwKgbcXvp5D7zAJvJB3lJ0OfMtATpOV5z36YTJ
         DDju7F+coo+B30W680ZWth7+8Sc1wu36ghxprFL6Zkh3oqsxCB2GUY5QRY9pF8eI+rx3
         Bb6Nb+/DigcQ9zH/li6koN2JpH4l/wcT3wPubReXZACWUjNlf/fzOLfAHm1zEVxWrho0
         u4wFXJi1soAWyKaCgYgYvmsrH+NH7tJTWQJwB5X5lpjVkvLvTeEpRD1C/dSJi4TpCw4m
         +byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040357; x=1695645157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X6QtCgWBlGiAp6h0kF11KB6rl566Y3up0YcWsWItks=;
        b=omSmRZqrbiZAY8hdKx1RTCTRpm2iBpnxkXwYI2cXJ3FTgf4ZS2lyQkAK7yVZ5NB/+P
         NQ6WFRHjJAiopo2djctYIgKQNTAVTRmaA0Z+jGUTlO1RxlHtmUSyRKi3KDRKY7mcjjwk
         2s9al4Rh8Hhv9ORBDLTlrMnAZZfvOIjulZlTb6u/QukWzKeSwjOMigMYOB8i2vMXuAh0
         jKfpu2YW4eDe+s+p/NwqpJXV62Q/brJDGiX/k82vTmhkpMMh5k6kxLBGhaWrRVvwLorU
         zsyy98/WxUgs+i0lhGJYK1djvRnf/76aKZLnF9L8YWcIIyRsroV4o5g+gof3NDnXJ0R/
         rRkQ==
X-Gm-Message-State: AOJu0Yzy/ibg8ut1uUmmtQk9cylqjb8AkkAl9GLMcwjeOWKlRKwem6sp
        TdRlcWwoKAXuO4BOkyaZCPgiNw==
X-Google-Smtp-Source: AGHT+IFDdOBnzHdZyGLyZKVR0v/pADMFz5hsIDpwkS0m3PP6fei3DHqPGd6adGZwnzXHrnOt1zV2Fw==
X-Received: by 2002:a17:906:eec5:b0:9a1:aaae:8207 with SMTP id wu5-20020a170906eec500b009a1aaae8207mr16145626ejb.20.1695040357404;
        Mon, 18 Sep 2023 05:32:37 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b00992a8a54f32sm6328834ejb.139.2023.09.18.05.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:32:35 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amir73il@gmail.com, max.kellermann@ionos.com
Subject: [PATCH 4/4] arch: register inotify_add_watch_at
Date:   Mon, 18 Sep 2023 14:32:17 +0200
Message-Id: <20230918123217.932179-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918123217.932179-1-max.kellermann@ionos.com>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using syscall number 454 (only different on Alpha).  This skips 453 on
most architectures; 453 is used on x86_64 for "map_shadow_stack" and
my idea is to reserve that number for the remaining architectures,
where an implementation may be added eventually.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/linux/syscalls.h                    | 2 ++
 include/uapi/asm-generic/unistd.h           | 5 ++++-
 20 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ad37569d0507..3eaf0c8ffe9c 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,4 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
+563	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c572d6c3dee0..08fc73bf211c 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -466,3 +466,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index bd77253b62e0..63a8a9c4abc1 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		453
+#define __NR_compat_syscalls		455
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 78b68311ec81..384c121dfbdf 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,8 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_inotify_add_watch_at 454
+__SYSCALL(__NR_inotify_add_watch_at, sys_inotify_add_watch_at)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 83d8609aec03..8312606fdcd7 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 259ceb125367..51de66ce3e9b 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a3798c2637fd..991a0ae1c4be 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 152034b8e0a0..98a7c7c45293 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,4 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
+454	n32	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cb5e757f6621..8751f6de6b96 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
+454	n64	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 1a646813afdc..a899807b3b64 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,4 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
+454	o32	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e97c175b56f9..325885297d5d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 20e50586e8a2..132876dc7aa5 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,4 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 0122cc156952..b6d29996190c 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+454  common	inotify_add_watch_at	sys_inotify_add_watch_at	sys_inotify_add_watch_at
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e90d585c4d3e..337875016443 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4ed06c71c43f..9634f81be406 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..de83d6861429 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,4 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+454	i386	inotify_add_watch_at	sys_inotify_add_watch_at
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..fdf0128fffce 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	inotify_add_watch_at	sys_inotify_add_watch_at
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index fc1a4f3c81d9..43cbdd8f369c 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	inotify_add_watch_at		sys_inotify_add_watch_at
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..63349ee93cb3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -379,6 +379,8 @@ asmlinkage long sys_fcntl64(unsigned int fd,
 asmlinkage long sys_inotify_init1(int flags);
 asmlinkage long sys_inotify_add_watch(int fd, const char __user *path,
 					u32 mask);
+asmlinkage long sys_inotify_add_watch_at(int fd, int dfd, const char __user *path,
+					 u32 mask);
 asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..f84bdb800352 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+#define __NR_inotify_add_watch_at 454
+__SYSCALL(__NR_inotify_add_watch_at, sys_inotify_add_watch_at)
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
-- 
2.39.2

