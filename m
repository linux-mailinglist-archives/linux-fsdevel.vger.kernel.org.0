Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A4356EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 16:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352946AbhDGOay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 10:30:54 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:42761 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352939AbhDGOaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:30:52 -0400
Received: by mail-pj1-f46.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1415205pjv.1;
        Wed, 07 Apr 2021 07:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vVuZ4MvRzeF+pr2v0xmBFFQwK6hdMJanVjlk9hErro=;
        b=p1KK1cOkqF4vkjiGQlQyjZrd/3svw7AsHzTRVm3MhKvVkKR6Dwx4Dfm6sdCjc9Sjqs
         e9RPRL7lF7O2aTAFYFcgFp91u55IRZM+NAVgSg3WTaHfN7rlTs3eMe0+euKVBIXgJ3j9
         Dx7tezCIPDcT5myzik9AmqF8mNzgjQnKa2P1oH64IpJA2yYdZcHqX0zanidKaX0AiS4t
         rhmEmvIfDKDx+m7h6PfV0SxFb7d6VhzZI1lt0LOypBaHz7Io+8kmdqx8DA71pNVQj8F4
         jPzUAMGalLGzmQ6k7AK911TjafA0Gc3OqjWJtEV96H8Ty8DiN14TDbhUigG4+ngbU61s
         UaRw==
X-Gm-Message-State: AOAM531J1WRsK/PlO1ajFnlQH3WLMDcsFiNsNR0QtAUYWNmZSZZxz0uS
        WHPuV3DT84I9B+teB69JxaU=
X-Google-Smtp-Source: ABdhPJytaBCeu/N78G2ItU1as7w8fUmjf8wbl8aAQkobTbao0e2hHv5pq8RooRp01fzv5LCBwmpFDg==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr3482681pjs.153.1617805842980;
        Wed, 07 Apr 2021 07:30:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k11sm5779292pjs.1.2021.04.07.07.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:30:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 09D07402D7; Wed,  7 Apr 2021 14:30:41 +0000 (UTC)
Date:   Wed, 7 Apr 2021 14:30:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210407143040.GB4332@42.do-not-panic.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <20210406165108.GA4332@42.do-not-panic.com>
 <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:33:44AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 7, 2021 at 10:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> > > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > > new file mode 100644
> > > index 000000000000..41e32483d7a7
> > > --- /dev/null
> > > +++ b/include/linux/panic_notifier.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_PANIC_NOTIFIERS_H
> > > +#define _LINUX_PANIC_NOTIFIERS_H
> > > +
> > > +#include <linux/notifier.h>
> > > +#include <linux/types.h>
> > > +
> > > +extern struct atomic_notifier_head panic_notifier_list;
> > > +
> > > +extern bool crash_kexec_post_notifiers;
> > > +
> > > +#endif       /* _LINUX_PANIC_NOTIFIERS_H */
> >
> > Why is it worth it to add another file just for this?
> 
> The main point is to break tons of loops that prevent having clean
> headers anymore.
>
> In this case, see bug.h, which is very important in this sense.

OK based on the commit log this was not clear, it seemed more of moving
panic stuff to its own file, so just cleanup.

> >  Seems like a very
> > small file.
> 
> If it is an argument, it's kinda strange. We have much smaller headers.

The motivation for such separate file was just not clear on the commit
log.

  Luis
