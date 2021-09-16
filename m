Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6389F40DAEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhIPNTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 09:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239938AbhIPNTn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 351026120F;
        Thu, 16 Sep 2021 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631798302;
        bh=5QDco+H6yKaDHQBgOn3z6hTcONmXAHYxpTTjoyccPr4=;
        h=From:To:Cc:Subject:Date:From;
        b=WPjkidT7YXXVCKctwIF6oNsCxPGA3XFpFE+jDMXaP/pjt6LnGlYZs+t0gDpBGQ0jd
         9398xpRXlC/capRZfjGq9OZzBulnRK8JuOIGWN+K4Ozwpleici8iqAvt+dSwrwgWYF
         wNeplkL6/wqW8Haoa7Eio6ZuQEF98S+yLkbuDyOrRsCXPM7SwQcJHhC4q7acXzFc28
         53Bu3kCUL9dLH/T4YBt0lKMLO0uN7bp8Cswte0H/lU2YqDx5aUhqIVoE9izb/O7lJJ
         PA6YXGPaPBreNc4xj/bQ+2a25T+ucWtp35QYz4KJHxP0d2g9zVezDVPJVohdDyPoAb
         NE98J9tRjV83Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable compat ELF loader
Date:   Thu, 16 Sep 2021 14:18:16 +0100
Message-Id: <20210916131816.8841-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Distributions such as Android which support a mixture of 32-bit (compat)
and 64-bit (native) tasks necessarily ship with the compat ELF loader
enabled in their kernels. However, as time goes by, an ever-increasing
proportion of userspace consists of native applications and in some cases
32-bit capabilities are starting to be removed from the CPUs altogether.

Inevitably, this means that the compat code becomes somewhat of a
maintenance burden, receiving less testing coverage and exposing an
additional kernel attack surface to userspace during the lengthy
transitional period where some shipping devices require support for
32-bit binaries.

Introduce a new sysctl 'fs.compat-binfmt-elf-enable' to allow the compat
ELF loader to be disabled dynamically on devices where it is not required.
On arm64, this is sufficient to prevent userspace from executing 32-bit
code at all.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/compat_binfmt_elf.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

I started off hacking this into the arch code, but then I realised it was
just as easy doing it in the core for everybody to enjoy. Unfortunately,
after talking to Peter, it sounds like it doesn't really help on x86
where userspace can switch to 32-bit without involving the kernel at all.

Thoughts?

diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 95e72d271b95..e8ce6c8fff42 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -15,6 +15,8 @@
  */
 
 #include <linux/elfcore-compat.h>
+#include <linux/init.h>
+#include <linux/sysctl.h>
 #include <linux/time.h>
 
 #define ELF_COMPAT	1
@@ -63,7 +65,8 @@
  */
 
 #undef	elf_check_arch
-#define	elf_check_arch	compat_elf_check_arch
+#define	elf_check_arch(ex)	\
+	(compat_binfmt_elf_enable && compat_elf_check_arch(ex))
 
 #ifdef	COMPAT_ELF_PLATFORM
 #undef	ELF_PLATFORM
@@ -136,6 +139,25 @@
 #define init_elf_binfmt		init_compat_elf_binfmt
 #define exit_elf_binfmt		exit_compat_elf_binfmt
 
+static int compat_binfmt_elf_enable = 1;
+
+static struct ctl_table compat_elf_sysctl_table[] = {
+	{
+		.procname	= "compat-binfmt-elf-enable",
+		.data		= &compat_binfmt_elf_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{ },
+};
+
+static int __init compat_elf_init(void)
+{
+	return register_sysctl("fs", compat_elf_sysctl_table) == NULL;
+}
+fs_initcall(compat_elf_init);
+
 /*
  * We share all the actual code with the native (64-bit) version.
  */
-- 
2.33.0.464.g1972c5931b-goog

