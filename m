Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2868C456427
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 21:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhKRUc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 15:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhKRUcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:32:16 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61465C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 12:29:16 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r132so6463686pgr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 12:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ext/hA9Hqh6Ihnib1lEscDhjZ8UYlTCVA8i531ovqfY=;
        b=DkxRs4QGBaUfZ5NxWhAUlvfgQ+APMPBEvDxf32GiR+ctjCEwclxDrBmpBI5JKbwmkA
         cgeVsSzBs3oMnWsbAcEi6WdQ1dxVJsjLPfAZOSuwU+Dl1qCX9ttV+fmrBLBCUbr0JuYq
         3HhDrirsunWX4JcVtzu7DG9bT9AHSJBG0fGMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ext/hA9Hqh6Ihnib1lEscDhjZ8UYlTCVA8i531ovqfY=;
        b=u+Wj3lXUZmVHlfHHFZw6qiZH+lsb/eZrxtyaJhzPqQTZyBTdfn9deZ18Cx/SQdnQz4
         uUsy70fB4EJVSn0S48+nSEa3ImRi1Yex7E9RKS4lllCJT7Rn/OvfiQezJjFX6RxWlqP5
         qJJQ5yh5ccBqH5OXOloNzUSmMh6m6gLXk70SaoY7Db5FweJJ+QqIGywr39DS09mrvZe9
         OMNOnXquWlz70eRNdACD0trvyaRma3hkVUE4AnGfW1AFds4v5jY2TiaMCjTVBk/ggAdE
         DrZh2ZfWmwztPzyEpQnGf5ptELtrOA0PsHGoHVk6dFojn1S8mBc0dWaEuakTOrw/cdJd
         qvqA==
X-Gm-Message-State: AOAM532LVJgMi3Yi/+he8CyufC4nIhTGPhGDg178F2Skjh7kkSbbwALT
        9KGnpdG2AFlzxHjfrPQpvOgHsQ==
X-Google-Smtp-Source: ABdhPJzQ8MzBCn4pE81cMqWmI37cBiPbYo9AexOSLUps3f8fPtCWbmtEvHLk9gDRGThFQpv0lTd+fg==
X-Received: by 2002:a63:6747:: with SMTP id b68mr12852566pgc.371.1637267355851;
        Thu, 18 Nov 2021 12:29:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm448700pfh.210.2021.11.18.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:29:15 -0800 (PST)
Date:   Thu, 18 Nov 2021 12:29:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <202111181226.D4538E2F@keescook>
References: <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home>
 <202111151116.933184F716@keescook>
 <59534db5-b251-c0c8-791f-58aca5c00a2b@linux.com>
 <202111161037.7456C981@keescook>
 <fd86a05b-feca-c0a9-c6b0-b2e69c650021@schaufler-ca.com>
 <202111180930.5FA3EF0F59@keescook>
 <16baa1f4-972d-c781-2d57-508296a83bfb@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16baa1f4-972d-c781-2d57-508296a83bfb@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:30:32AM -0800, Casey Schaufler wrote:
> On 11/18/2021 9:32 AM, Kees Cook wrote:
> > On Tue, Nov 16, 2021 at 11:00:23AM -0800, Casey Schaufler wrote:
> > > On 11/16/2021 10:41 AM, Kees Cook wrote:
> > > > On Tue, Nov 16, 2021 at 12:12:16PM +0300, Alexander Popov wrote:
> > > > > What if the Linux kernel had a LSM module responsible for error handling policy?
> > > > > That would require adding LSM hooks to BUG*(), WARN*(), KERN_EMERG, etc.
> > > > > In such LSM policy we can decide immediately how to react on the kernel error.
> > > > > We can even decide depending on the subsystem and things like that.
> > > > That would solve the "atomicity" issue the WARN tracepoint solution has,
> > > > and it would allow for very flexible userspace policy.
> > > > 
> > > > I actually wonder if the existing panic_on_* sites should serve as a
> > > > guide for where to put the hooks. The current sysctls could be replaced
> > > > by the hooks and a simple LSM.
> > > Do you really want to make error handling a "security" issue?
> > > If you add security_bug(), security_warn_on() and the like
> > > you're begging that they be included in SELinux (AppArmor) policy.
> > > BPF, too, come to think of it. Is that what you want?
> > Yeah, that is what I was thinking. This would give the LSM a view into
> > kernel state, which seems a reasonable thing to do. If system integrity
> > is compromised, an LSM may want to stop trusting things.
> 
> How are you planning to communicate the security relevance of the
> warning to the LSM? I don't think that __FILE__, __LINE__ or __func__
> is great information to base security policy on. Nor is a backtrace.

I think that would be part of the design proposal. Initially, the known
parts are "warn or bug" and "pid".

> > A dedicated error-handling LSM could be added for those hooks that
> > implemented the existing default panic_on_* sysctls, and could expand on
> > that logic for other actions.
> 
> I can see having an interface like LSM for choosing a bug/warn policy.
> I worry about expanding the LSM hook list for a case where I would
> hope no existing LSM would use them, and the new LSM doesn't use any
> of the existing hooks.

Yeah, I can see that, though we've got a history of the "specialized"
hooks getting used by other LSMs. (e.g. loadpin's stuff got hooked up to
other LSMs, etc.)

-- 
Kees Cook
