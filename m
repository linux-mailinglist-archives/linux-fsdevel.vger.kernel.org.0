Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5443D791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 01:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhJ0XfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 19:35:15 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54932 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhJ0XfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:35:08 -0400
Received: by mail-wm1-f52.google.com with SMTP id 71so1796040wma.4;
        Wed, 27 Oct 2021 16:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ib38M5z2yfeOkrCNkLh3vFSIdBa5a6B4vOPMB+9N9es=;
        b=pkjomh6HhKnnnq2DB/DVUedMdZxsOtoD6TAcTcq74Z3PqKgOaq1H/X+gwi7V/rA8gW
         GzbMnV6MLW7CLTEXFPukauCAoZw2dRJvjQZ7tRn/FZqvcrANeYJXh0qd3xG1qvoAVpgc
         v5RJrYqwfvNbiK+5ETk4W1lq9JDVqnSkyAwkAiBnDQW/EY4OAapziPZj3TQvQ2LXjpyr
         Me4O9gK3cHGhMhh5uNFH+ymQm3jHeQFmR4+7bKOrpgM2pWu/g2+ef2cEFXpnwBWw1B65
         2HddDZkR6Pp+ESFzPZP78H3S6gthEwcwJaf53qEzQKlKCSi/M2FLbS84BfqKNwzuGO5w
         NJyQ==
X-Gm-Message-State: AOAM531mPSdobFRyvkHyHE6puhkylQmEgKRwoXh8Uo9B/ojVGiFGcyAM
        1tXVKh6W9a767TLQ/Nx9RkY=
X-Google-Smtp-Source: ABdhPJyUf+Ot/EZyrSg0rZPaYaCHBRmp8Bn13Q7dndxvdrCiCv3cDlxtjuYqmrFqHAONJS0UACnBFQ==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr756787wmb.141.1635377561277;
        Wed, 27 Oct 2021 16:32:41 -0700 (PDT)
Received: from hackbase.. ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id m3sm1199032wrx.52.2021.10.27.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:32:40 -0700 (PDT)
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
Subject: [PATCH v2 2/2] sysctl: introduce kernel.pkill_on_warn
Date:   Thu, 28 Oct 2021 02:32:15 +0300
Message-Id: <20211027233215.306111-3-alex.popov@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027233215.306111-1-alex.popov@linux.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
 include/asm-generic/bug.h                   | 12 ++++++++---
 include/linux/panic.h                       |  3 +++
 kernel/panic.c                              | 22 ++++++++++++++++++++-
 kernel/sysctl.c                             |  9 +++++++++
 lib/bug.c                                   |  3 +++
 6 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 426162009ce9..5faf395fdf8f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -921,6 +921,20 @@ lives in) pid namespace. When selecting a pid for a next task on fork
 kernel tries to allocate a number starting from this one.
 
 
+pkill_on_warn
+=============
+
+Kills all threads in a process that provoked a kernel warning.
+That allows the kernel to stop the process when the first signs
+of wrong behavior are detected.
+
+= =====================================================================
+0 Allows a process to proceed execution after hitting a kernel warning,
+  this is the default behavior.
+1 Kills all threads in a process that provoked a kernel warning.
+= =====================================================================
+
+
 powersave-nap (PPC only)
 ========================
 
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 881aeaf5a2d5..959000b5856a 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -94,8 +94,10 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 #ifndef WARN_ON_ONCE
 #define WARN_ON_ONCE(condition) ({					\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on)) {					\
 		DO_ONCE_LITE(__WARN_printf, TAINT_WARN, NULL);		\
+		do_pkill_on_warn();					\
+	}								\
 	unlikely(__ret_warn_on);					\
 })
 #endif
@@ -151,15 +153,19 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 #define WARN_ONCE(condition, format...) ({				\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on)) {					\
 		DO_ONCE_LITE(__WARN_printf, TAINT_WARN, format);	\
+		do_pkill_on_warn();					\
+	}								\
 	unlikely(__ret_warn_on);					\
 })
 
 #define WARN_TAINT_ONCE(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on)) {					\
 		DO_ONCE_LITE(__WARN_printf, taint, format);		\
+		do_pkill_on_warn();					\
+	}								\
 	unlikely(__ret_warn_on);					\
 })
 
diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..f79c69279859 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -27,6 +27,9 @@ extern int panic_on_oops;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
+extern int pkill_on_warn;
+
+extern void do_pkill_on_warn(void);
 
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..1323c9e2630f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -53,6 +53,7 @@ static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
+int pkill_on_warn __read_mostly;
 unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
 
@@ -625,13 +626,16 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	if (!fmt) {
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
-		return;
+		goto out;
 	}
 
 	args.fmt = fmt;
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
+
+out:
+	do_pkill_on_warn();
 }
 EXPORT_SYMBOL(warn_slowpath_fmt);
 #else
@@ -732,3 +736,19 @@ static int __init panic_on_taint_setup(char *s)
 	return 0;
 }
 early_param("panic_on_taint", panic_on_taint_setup);
+
+void do_pkill_on_warn(void)
+{
+	if (!pkill_on_warn)
+		return;
+
+	if (is_global_init(current))
+		return;
+
+	if (current->flags & PF_KTHREAD)
+		return;
+
+	if (system_state >= SYSTEM_RUNNING)
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, current, PIDTYPE_TGID);
+}
+EXPORT_SYMBOL(do_pkill_on_warn);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..7fe6f0aaad2b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2656,6 +2656,15 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+		{
+		.procname	= "pkill_on_warn",
+		.data		= &pkill_on_warn,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
 		.procname	= "timer_migration",
diff --git a/lib/bug.c b/lib/bug.c
index 1a91f01412b8..28cc8a5b2ee0 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -214,6 +214,9 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	bug_type = BUG_TRAP_TYPE_BUG;
 
 out:
+	if (bug_type == BUG_TRAP_TYPE_WARN)
+		do_pkill_on_warn();
+
 	return bug_type;
 }
 
-- 
2.31.1

