Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108F345185B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 23:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbhKOW6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbhKOW4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:56:35 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E110C0337C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 14:06:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g18so16213794pfk.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 14:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+75pOgzRSIiee94ABsrf5glhvGlXlViH0+WT5j4L0aw=;
        b=dS8Un6tSdNnk9Z4kmfDP4XsUZOMSVFQw3q3GTGh5sr8XmLWMkM07MuC1+dT12/ptHP
         8r4FauaE6OQMmNCZkBtn866ZhTNqnOWvSfGwr5K3/jo8deQAcP6hs392bnEV+AReAEVH
         V9uj6x0kL07NJEinAldy4HwU/0bSkPFxwZmfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+75pOgzRSIiee94ABsrf5glhvGlXlViH0+WT5j4L0aw=;
        b=NPPOfqoU1LTd0BTDbKcoQ6Jayy0tr3RdBdqu8wO7qVzm6w/YNqa8KRXxSFLn0H77rN
         fsyoBr50F7NwumtBbhbfU7rpWhbNCZuGpW+Jau2qj/F5Su4Vyxtzvlol8bsiU4a2mm6m
         0BBaAYl2+fpzlp+FQ7dkKfMQvcIbnE6IEtysTtLWPU3r9B21FsdsDsjQzJGNck9IkHxE
         SdqIEwaskzCjqWISYf0uR0Klg7QhSIGegsCZVvWnBDtyAaUUlSx/TONIy9gDHN0HnfxM
         v2UrM75GCrAqYDJzR2bnQ7wE+tuB7vYYKAUbFRNogo6sLVG2xTOqx5+D9NWX/4ImqLwj
         X7Sw==
X-Gm-Message-State: AOAM531NifIxTvLtDceaLHyiQqSgiPSpHcieTSEOZgjTf7YlB9HQ9lBQ
        R4BJQTuvkZOtuUCpS5FRowvQOw==
X-Google-Smtp-Source: ABdhPJxbI3NOtgyO8DBjqkXVe/gYAMuaxOIkr7hH2fyzLDr8HfWh0griJts14SzHJ0idri2HBcFqDg==
X-Received: by 2002:aa7:8151:0:b0:480:9d40:8e38 with SMTP id d17-20020aa78151000000b004809d408e38mr35382844pfn.72.1637014002929;
        Mon, 15 Nov 2021 14:06:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id rm10sm277789pjb.29.2021.11.15.14.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:06:42 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:06:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Message-ID: <202111151116.933184F716@keescook>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115110649.4f9cb390@gandalf.local.home>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:06:49AM -0500, Steven Rostedt wrote:
> On Mon, 15 Nov 2021 14:59:57 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > 1. Allow a reasonably configured kernel to boot and run with
> > panic_on_warn set. Warnings should only be raised when something is
> > not configured as the developers expect it or the kernel is put into a
> > state that generally is _unexpected_ and has been exposed little to
> > the critical thought of the developer, to testing efforts and use in
> > other systems in the wild. Warnings should not be used for something
> > informative, which still allows the kernel to continue running in a
> > proper way in a generally expected environment. Up to my knowledge,
> > there are some kernels in production that run with panic_on_warn; so,
> > IMHO, this requirement is generally accepted (we might of course
> 
> To me, WARN*() is the same as BUG*(). If it gets hit, it's a bug in the
> kernel and needs to be fixed. I have several WARN*() calls in my code, and
> it's all because the algorithms used is expected to prevent the condition
> in the warning from happening. If the warning triggers, it means either that
> the algorithm is wrong or my assumption about the algorithm is wrong. In
> either case, the kernel needs to be updated. All my tests fail if a WARN*()
> gets hit (anywhere in the kernel, not just my own).
> 
> After reading all the replies and thinking about this more, I find the
> pkill_on_warning actually worse than not doing anything. If you are
> concerned about exploits from warnings, the only real solution is a
> panic_on_warning. Yes, it brings down the system, but really, it has to be
> brought down anyway, because it is in need of a kernel update.

Hmm, yes. What it originally boiled down to, which is why Linus first
objected to BUG(), was that we don't know what other parts of the system
have been disrupted. The best example is just that of locking: if we
BUG() or do_exit() in the middle of holding a lock, we'll wreck whatever
subsystem that was attached to. Without a deterministic system state
unwinder, there really isn't a "safe" way to just stop a kernel thread.

With this pkill_on_warn, we avoid the BUG problem (since the thread of
execution continues and stops at an 'expected' place: the signal
handler).

However, now we have the newer objection from Linus, which is one of
attribution: the WARN might be hit during an "unrelated" thread of
execution and "current" gets blamed, etc. And beyond that, if we take
down a portion of userspace, what in userspace may be destabilized? In
theory, we get a case where any required daemons would be restarted by
init, but that's not "known".

The safest version of this I can think of is for processes to opt into
this mitigation. That would also cover the "special cases" we've seen
exposed too. i.e. init and kthreads would not opt in.

However, that's a lot to implement when Marco's tracing suggestion might
be sufficient and policy could be entirely implemented in userspace. It
could be as simple as this (totally untested):


diff --git a/include/trace/events/error_report.h b/include/trace/events/error_report.h
index 96f64bf218b2..129d22eb8b6e 100644
--- a/include/trace/events/error_report.h
+++ b/include/trace/events/error_report.h
@@ -16,6 +16,8 @@
 #define __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
 enum error_detector {
+	ERROR_DETECTOR_WARN,
+	ERROR_DETECTOR_BUG,
 	ERROR_DETECTOR_KFENCE,
 	ERROR_DETECTOR_KASAN
 };
@@ -23,6 +25,8 @@ enum error_detector {
 #endif /* __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 #define error_detector_list	\
+	EM(ERROR_DETECTOR_WARN, "warn")	\
+	EM(ERROR_DETECTOR_BUG, "bug")	\
 	EM(ERROR_DETECTOR_KFENCE, "kfence")	\
 	EMe(ERROR_DETECTOR_KASAN, "kasan")
 /* Always end the list with an EMe. */
diff --git a/lib/bug.c b/lib/bug.c
index 45a0584f6541..201b4070bbbc 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -48,6 +48,7 @@
 #include <linux/sched.h>
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
+#include <trace/events/error_report.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -198,6 +199,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
 		       NULL);
+		trace_error_report_end(ERROR_DETECTOR_WARN, bugaddr);
 		return BUG_TRAP_TYPE_WARN;
 	}
 
@@ -206,6 +208,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	else
 		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
+	trace_error_report_end(ERROR_DETECTOR_BUG, bugaddr);
 
 	return BUG_TRAP_TYPE_BUG;
 }


Marco, is this the full version of monitoring this from the userspace
side?

	perf record -e error_report:error_report_end

-- 
Kees Cook
