Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415EF43D787
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 01:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhJ0Xe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 19:34:59 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34743 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Xe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:34:59 -0400
Received: by mail-wm1-f47.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso3679769wmc.1;
        Wed, 27 Oct 2021 16:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGvRlwy1hKPSRe6UF/gEOA6Zs7pqAF2R7y94ByLf0fc=;
        b=V70icanAhmAgsDLoIqa/NExiNCZlvioQ1R74St1gs3N+iUPb/BaB3k2mOFqbUGvZGF
         s0+gFRqjkKidAKEwg8kOvawMCJV7w9GVdDQ8uINFBbq1UnJCgOIKRHRgZv4SSBBUe/19
         O3on3D/vBK1A5tOlNeIfWYlCe6CxVz0ScNfnKSGrASjGUEiOdG9wi1vVrPpY/6qUHvWD
         iXuGifYePMUmVBJs98ZrNcJm0g6fTED6QUPHmS8RX4exYahI6pyXp6X9htzbY3nNM6XA
         QdZbDVdlRtoLTeL2BjLT0q8vEzLCL1QOPLa3U3IU8QjN20HiUBY35aLj3poYJfsnz1AV
         +Amg==
X-Gm-Message-State: AOAM532C22K7rUEszf39deOYPym6Qci5b//cWkn8b/m2RMZCiZXMv7Pn
        q5SnM90zBHtTCfZkfGCaqOw=
X-Google-Smtp-Source: ABdhPJyj9WWwmhPoreFXZQ7aB4YrttTeEGCd1+PRHxnVW+etewoW2O0IcbL3FlSqY563+nnOXCWjlw==
X-Received: by 2002:a1c:9d82:: with SMTP id g124mr775917wme.160.1635377551711;
        Wed, 27 Oct 2021 16:32:31 -0700 (PDT)
Received: from hackbase.. ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id m3sm1199032wrx.52.2021.10.27.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:32:31 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexander Popov <alex.popov@linux.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     notify@kernel.org
Subject: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Date:   Thu, 28 Oct 2021 02:32:13 +0300
Message-Id: <20211027233215.306111-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello! This is the v2 of pkill_on_warn.
Changes from v1 and tricks for testing are described below.

Rationale
=========

Currently, the Linux kernel provides two types of reaction to kernel
warnings:
 1. Do nothing (by default),
 2. Call panic() if panic_on_warn is set. That's a very strong reaction,
    so panic_on_warn is usually disabled on production systems.

From a safety point of view, the Linux kernel misses a middle way of
handling kernel warnings:
 - The kernel should stop the activity that provokes a warning,
 - But the kernel should avoid complete denial of service.

From a security point of view, kernel warning messages provide a lot of
useful information for attackers. Many GNU/Linux distributions allow
unprivileged users to read the kernel log, so attackers use kernel
warning infoleak in vulnerability exploits. See the examples:
https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html
https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
https://googleprojectzero.blogspot.com/2018/09/a-cache-invalidation-bug-in-linux.html

Let's introduce the pkill_on_warn sysctl.
If this parameter is set, the kernel kills all threads in a process that
provoked a kernel warning. This behavior is reasonable from a safety point of
view described above. It is also useful for kernel security hardening because
the system kills an exploit process that hits a kernel warning.

Moreover, bugs usually don't come alone, and a kernel warning may be
followed by memory corruption or other bad effects. So pkill_on_warn allows
the kernel to stop the process when the first signs of wrong behavior
are detected.


Changes from v1
===============

1) Introduce do_pkill_on_warn() and call it in all warning handling paths.

2) Do refactoring without functional changes in a separate patch.

3) Avoid killing init and kthreads.

4) Use do_send_sig_info() instead of do_group_exit().

5) Introduce sysctl instead of using core_param().


Tricks for testing
==================

1) This patch series was tested on x86_64 using CONFIG_LKDTM.
The kernel kills a process that performs this:
  echo WARNING > /sys/kernel/debug/provoke-crash/DIRECT

2) The warn_slowpath_fmt() path was tested using this trick:
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 84b87538a15d..3106c203ebb6 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -73,7 +73,7 @@ do {                                                          \
  * were to trigger, we'd rather wreck the machine in an attempt to get the
  * message out than not know about it.
  */
-#define __WARN_FLAGS(flags)                                    \
+#define ___WARN_FLAGS(flags)                                   \
 do {                                                           \
        instrumentation_begin();                                \
        _BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));           \

3) Testing pkill_on_warn with kthreads was done using this trick:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bce848e50512..13c56f472681 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2133,6 +2133,8 @@ static int __noreturn rcu_gp_kthread(void *unused)
                WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
                rcu_gp_cleanup();
                WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
+
+               WARN_ONCE(1, "hello from kthread\n");
        }
 }

4) Changing drivers/misc/lkdtm/bugs.c:lkdtm_WARNING() allowed me
to test all warning flavours:
 - WARN_ON()
 - WARN()
 - WARN_TAINT()
 - WARN_ON_ONCE()
 - WARN_ONCE()
 - WARN_TAINT_ONCE()

Thanks!

Alexander Popov (2):
  bug: do refactoring allowing to add a warning handling action
  sysctl: introduce kernel.pkill_on_warn

 Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++++
 include/asm-generic/bug.h                   | 37 +++++++++++++++------
 include/linux/panic.h                       |  3 ++
 kernel/panic.c                              | 22 +++++++++++-
 kernel/sysctl.c                             |  9 +++++
 lib/bug.c                                   | 22 ++++++++----
 6 files changed, 90 insertions(+), 17 deletions(-)

-- 
2.31.1

