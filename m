Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD2453982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 19:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbhKPSou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 13:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbhKPSor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:44:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091AC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 10:41:50 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b68so190882pfg.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rpZo5Ukhloxpo3t6te7xJnWQRrow3d4oIhzJ9wNY//s=;
        b=VSNC43P14WmPSZmUrPilJ+DgGj5eVm+rYneRkINAieo4BCqCLBy5QiE+yxx4dMJHrP
         ofgb/NWCMtHijcLBbRJZt2srQLA+UEZ3FYMnXTi4zhVU59bazntvLi1ZB9x1FOAMm3MU
         zC1NqI7P7FvTEoA0kb6E30B9MNDZ7w/u4TNWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rpZo5Ukhloxpo3t6te7xJnWQRrow3d4oIhzJ9wNY//s=;
        b=oWTKF6CBNImk+P+yr+1Hrq5OoMpx4gYLxtb3ER9kijN4hIv2CPfHwhSngBV2d4g7Y+
         1LIsbGWsb+FM6sbUtIz/qNh/eqnQwYfdk0HroTJrboQQ94SfwYFJssphe9kfoEMHw6mo
         4k7elmRS/5OcE/pun6U5+TRfgONCmexnDBbNZm2XDZ6dyXtS2/m1DdaqgFKmKJHpWvWT
         Rkjbfh9aQ/O1ZvM/S/4tFywfVEX42jg61GYKOuTeKfEz3xdofShvyIQRevG6fzyQNLJu
         TtbLOtCDvsQtI2Qe52/x5YMs/hCtECyoBhelsoFgzCXbUIPUHErvhWr7IHGAwOT3OX2l
         AiLA==
X-Gm-Message-State: AOAM530NzGk49n//2gZzRIv2116B8RR2kyUU3IMybIbx6vap8Mhaswz6
        l+QKhYUCifNq2UPC1mY+9RwdXg==
X-Google-Smtp-Source: ABdhPJwwvQRQ7H1L7erOMj0WCwxaWTV8d2CBQFnkm/BoZWo9AQPZdRvAdBwwSZAEqBBMD7kMUEk6Tw==
X-Received: by 2002:a63:b502:: with SMTP id y2mr798068pge.214.1637088110275;
        Tue, 16 Nov 2021 10:41:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm14550926pgc.17.2021.11.16.10.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:41:49 -0800 (PST)
Date:   Tue, 16 Nov 2021 10:41:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
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
Message-ID: <202111161037.7456C981@keescook>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home>
 <202111151116.933184F716@keescook>
 <59534db5-b251-c0c8-791f-58aca5c00a2b@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59534db5-b251-c0c8-791f-58aca5c00a2b@linux.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:12:16PM +0300, Alexander Popov wrote:
> What if the Linux kernel had a LSM module responsible for error handling policy?
> That would require adding LSM hooks to BUG*(), WARN*(), KERN_EMERG, etc.
> In such LSM policy we can decide immediately how to react on the kernel error.
> We can even decide depending on the subsystem and things like that.

That would solve the "atomicity" issue the WARN tracepoint solution has,
and it would allow for very flexible userspace policy.

I actually wonder if the existing panic_on_* sites should serve as a
guide for where to put the hooks. The current sysctls could be replaced
by the hooks and a simple LSM.

-- 
Kees Cook
