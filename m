Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868A944F875
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhKNOY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 09:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhKNOY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 09:24:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3FEC061202
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Nov 2021 06:21:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r8so25101627wra.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Nov 2021 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p8lk+q4Y2CquVO9sqmu4dSc1gvfHGQ8MpCynAwi+U0M=;
        b=tmyGi86bjZW/7vtxIzqiUXXSul5Ye8VTLY6C1i8poScsrQmwey4pUrTupOUd2E5T/O
         U6eX0di3bcDtRIs3BuWvdCD++Z4pOHXG2V7/QjHQvO431WlrLRjiIwM9WemrClq0gXC7
         +Xwgxx1lTobE+ZE2jpjTNbPkawHwTRWgGn7pR4xCufUfAXa+44eXTTKOtS99KaHF6/+R
         X8NSkvmce0zWcaFSbInWCw47Cpi/bqA/D2uBq+Lg4zTA1l4KCZa5rfTWtLhA0NbTHWly
         iswWc8J+xnA9MCX3kJHw267Gkq+v0ts2CP9PZtr0/CC3u0DB5j2rE/ahsAFpiporeeH8
         D3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8lk+q4Y2CquVO9sqmu4dSc1gvfHGQ8MpCynAwi+U0M=;
        b=B0RnLiSgEUvhzhkQbE7KbQiT+xicb1/+QAOAbKEVbu/fjooPzE4lcoscKiDd36JRbz
         mvXarAnIvDIMpO651yQmEkRi/stqQeo8Gr6NKorxjnKpHDlsNuNxOsKRYMXemeLrggLm
         GHyuk8JHx+JhfVjTTnFzyUCQtru+E/O7Eu77LHnt6ifu2BUfEyZaYx+HGxaxyydIhdMM
         JDHitMLc+9+wVuX302eQtjEPxYZOlsp2Uxr2aMeVmB+iVOKgS9oLZlpLPK+vmP9V+l4+
         URmJ8MuOLvIWZY6zah92Y4hsOCGSRo9MyjboyZKjNOI3oI+w46gXcccekIGmQfBYssMT
         pVVA==
X-Gm-Message-State: AOAM532/8/coXkiUcpiuH9CDvbO4zhWbOTs0rsouf+mq8dgtr3ZKealW
        QjtR0X2P9RB8T0xU1H0gblIXUw==
X-Google-Smtp-Source: ABdhPJz1rGJhN4paD+q9e5k6x6AlTsEg1AdYORqZcrmrG1v2dBBnBwDrylK3vuq8tZdXbfsQe80dtQ==
X-Received: by 2002:adf:f042:: with SMTP id t2mr38984084wro.180.1636899689743;
        Sun, 14 Nov 2021 06:21:29 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:48e0:47e8:1868:a12e])
        by smtp.gmail.com with ESMTPSA id 9sm14717028wry.0.2021.11.14.06.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 06:21:29 -0800 (PST)
Date:   Sun, 14 Nov 2021 15:21:22 +0100
From:   Marco Elver <elver@google.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, glider@google.com
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Message-ID: <YZEbYmzy64uai7Af@elver.google.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAHk-=wg+UMNYrR59Z31MhxMzdUEiZMQ1RF9jQvAb6HGBO5EyEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+UMNYrR59Z31MhxMzdUEiZMQ1RF9jQvAb6HGBO5EyEA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 13, 2021 at 11:58AM -0800, Linus Torvalds wrote:
> On Sat, Nov 13, 2021 at 10:14 AM Alexander Popov <alex.popov@linux.com> wrote:
[...]
> Honestly, if the intent is to not have to parse the dmesg output, then
> I think it would be much better to introduce a new /proc file to read
> the kernel tainting state, and then some test manager process could be
> able to poll() that file or something. Not sending a signal to random
> targets, but have a much more explicit model.
> 
> That said, I'm not convinced that "just read the kernel message log"
> is in any way wrong either.

We had this problem of "need to get errors/warnings that appear in the
kernel log" without actually polling the kernel log all the time. Since
5.12 there's the 'error_report' tracepoint for exactly this purpose [1].

Right now it only generates events on KASAN and KFENCE reports, but we
imagined it's easy enough to extend with more types. Like WARN, should
the need arise (you'd have to add it if you decide to go down that
route).

So you could implement a close-enough variant of the whole thing in
userspace using what tracepoints give you by just monitoring the trace
pipe. It'd be much easier to experiment with different policies as well.

[1] https://git.kernel.org/torvalds/c/9c0dee54eb91d48cca048bd7bd2c1f4a166e0252 
