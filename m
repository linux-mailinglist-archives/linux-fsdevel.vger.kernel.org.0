Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA14592EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhKVQYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 11:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhKVQYU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:24:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710B160D42;
        Mon, 22 Nov 2021 16:21:08 +0000 (UTC)
Date:   Mon, 22 Nov 2021 11:21:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
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
Message-ID: <20211122112106.5fa656bc@gandalf.local.home>
In-Reply-To: <YZjnREFGhEO9pX6O@elver.google.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
        <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
        <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
        <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
        <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
        <20211115110649.4f9cb390@gandalf.local.home>
        <202111151116.933184F716@keescook>
        <YZjnREFGhEO9pX6O@elver.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 20 Nov 2021 13:17:08 +0100
Marco Elver <elver@google.com> wrote:


> I think userspace would want something other than perf tool to handle it
> of course.  There are several options:
> 
> 	1. Open trace pipe to be notified (/sys/kernel/tracing/trace_pipe).
> 	   This already includes the pid.

I would suggest using /sys/kernel/tracing/per_cpu/cpu*/trace_pipe_raw

and use libtracefs[1] to read it.

-- Steve

[1] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
