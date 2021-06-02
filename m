Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C181398E33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhFBPTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:19:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54202 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhFBPTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:19:48 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4DBC1FDC6;
        Wed,  2 Jun 2021 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gj6dWuCSzujTy3LicA2z1/vTjDnYis4/WLpv1WCDvTg=;
        b=QXTtmjxzMOakAMCjtf72HzgFWfl5MUGpZV5x5SgG/6NBaxavfexdHKiS3Isfb9Nrtj4+op
        RKCGNIqPaRucrVKQzcF5t9f5dDmm0/sqVJMqwcb3I9nLt0QIiOzEJJgbMREKU2f1QwWYWj
        cONk1Qpg+D0ykbogmQ91obMg1YMArLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647083;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gj6dWuCSzujTy3LicA2z1/vTjDnYis4/WLpv1WCDvTg=;
        b=zJNFfJGQS66hVnY+dKjR0nhp/d3m5OfMjZhcX8yhYqzCh5eofzLgLFThRHwzKStws1Sgwe
        f7ufJ0C+8jUAG+Cg==
Received: by relay2.suse.de (Postfix, from userid 51)
        id C054FA3C54; Wed,  2 Jun 2021 15:25:59 +0000 (UTC)
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 53420A8177;
        Wed,  2 Jun 2021 15:15:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 396DD1F2CB3; Wed,  2 Jun 2021 17:15:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, brauner@suse.cz,
        <linux-api@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] quota: Wire up quotactl_fd syscall
Date:   Wed,  2 Jun 2021 17:15:53 +0200
Message-Id: <20210602151553.30090-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602151553.30090-1-jack@suse.cz>
References: <20210602151553.30090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12394; h=from:subject; bh=zzroR4lZXjHnpqNq/An86dpR7vPPuIF+QR0Jr/aeeZ8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgt6Cj4ZF9XdWViy85pf9o1WQpixmSueX4w271Hs/8 hQPhsP+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYLegowAKCRCcnaoHP2RA2ScaB/ 9EVQSgWaOLAYYGlLcSRGxlCEP4ba6stAveGJPE7vRex7xTvrulLi0rj84FvrnD+3zgBkAf6LvnrVr4 Jn/pxl3027/FGnpJJ9mNJrXYaphIPOf+9YbfwJiVvJ29UQyJHSZO2aV97tZfe2W3+WSDf+2WC4ssso jNtVie3B3U4dyeXo1qI6dIjqhLCKzb4K9gPxFDbWSgsn3xNt1gO447ugBdHJj56QTvpvRtTK89FlOm BpeNl9MgqeIsDmRoYu7srakXUYEwfbapsfFCbu8DyOeLEvJ73LqNoDLvlbYiQFVuZSsQInVEkQwBQT KNpwsOjP0s0QyXeerDdHfsk12E2WcI
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up the quotactl_fd syscall.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 2 +-
 arch/arm/tools/syscall.tbl                  | 2 +-
 arch/arm64/include/asm/unistd32.h           | 3 ++-
 arch/ia64/kernel/syscalls/syscall.tbl       | 2 +-
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 2 +-
 arch/sh/kernel/syscalls/syscall.tbl         | 2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      | 2 +-
 arch/x86/entry/syscalls/syscall_32.tbl      | 2 +-
 arch/x86/entry/syscalls/syscall_64.tbl      | 2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 +-
 17 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3000a2e8ee21..a17687ed4b51 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -482,7 +482,7 @@
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
 552	common	mount_setattr			sys_mount_setattr
-# 553 reserved for quotactl_path
+553	common	quotactl_fd			sys_quotactl_fd
 554	common	landlock_create_ruleset		sys_landlock_create_ruleset
 555	common	landlock_add_rule		sys_landlock_add_rule
 556	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 28e03b5fec00..c5df1179fc5d 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -456,7 +456,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 5dab69d2c22b..99ffcafc736c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -893,7 +893,8 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
-/* 443 is reserved for quotactl_path */
+#define __NR_quotactl_fd 443
+__SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
 #define __NR_landlock_create_ruleset 444
 __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
 #define __NR_landlock_add_rule 445
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index bb11fe4c875a..6d07742c57b8 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -363,7 +363,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 79c2d24c89dd..541bc1b3a8f9 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -442,7 +442,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index b11395a20c20..a176faca2927 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -448,7 +448,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 9220909526f9..c2d2e19abea8 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -381,7 +381,7 @@
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
 442	n32	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	n32	quotactl_fd			sys_quotactl_fd
 444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n32	landlock_add_rule		sys_landlock_add_rule
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 9cd1c34f31b5..ac653d08b1ea 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -357,7 +357,7 @@
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
 442	n64	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	n64	quotactl_fd			sys_quotactl_fd
 444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n64	landlock_add_rule		sys_landlock_add_rule
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index d560c467a8c6..253f2cd70b6b 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -430,7 +430,7 @@
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	o32	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	o32	quotactl_fd			sys_quotactl_fd
 444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	o32	landlock_add_rule		sys_landlock_add_rule
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index aabc37f8cae3..e26187b9ab87 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -440,7 +440,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 8f052ff4058c..aef2a290e71a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -522,7 +522,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 0690263df1dd..64d51ab5a8b4 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -445,7 +445,7 @@
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
-# 443 reserved for quotactl_path
+443  common	quotactl_fd		sys_quotactl_fd			sys_quotactl_fd
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 0b91499ebdcf..e0a70be77d84 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -445,7 +445,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e34cc30ef22c..603f5a821502 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -488,7 +488,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4bbc267fb36b..fba2f615119a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -447,7 +447,7 @@
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	i386	mount_setattr		sys_mount_setattr
-# 443 reserved for quotactl_path
+443	i386	quotactl_fd		sys_quotactl_fd
 444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ce18119ea0d0..af973e400053 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,7 +364,7 @@
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	mount_setattr		sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd		sys_quotactl_fd
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index fd2f30227d96..235d67d6ceb4 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -413,7 +413,7 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
-- 
2.26.2

