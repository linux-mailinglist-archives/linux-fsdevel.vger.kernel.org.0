Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE42A356F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353237AbhDGO7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353220AbhDGO7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:59:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAEC061756;
        Wed,  7 Apr 2021 07:59:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t22so6111827pgu.0;
        Wed, 07 Apr 2021 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/d1grSpme2mQqHlJWH4I0IMbDUguqI3gCUkY5Nr1Q4=;
        b=fYy1lWNPXiQ+yb67ebJZu+8zEC+h0pBnsXArakBNChEkh6CjoRMYl72lknBCAuRuX2
         jxuH9EpzzGDSCJWIUX2Ng7q0y9vsIP4Zr+Ek6u4yFt20hudhezjO5DOYAIxN+UZB5hMM
         FswWwQr3PpOF1lHlMFl2SjtB1/0Fx4MrlsWZAZT4dZpOxE8in8RosRGUfdrKX/M6x4Fq
         inZiwEl3DvszVRA5j32WLhIZYUUNpVuXdnve6hiU7XgFQUrk2IG/GFnBcXcqK58X9Wrd
         bbLLNR2m9dcbokFkoo+uH9b1jOTr6jOD6OdvmDZN/EImsXC0vxwvNHIMR6Dr2vU22cdq
         YTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/d1grSpme2mQqHlJWH4I0IMbDUguqI3gCUkY5Nr1Q4=;
        b=CwV4SfJ5T9ynaA7+mggevnUvClo01FL40NS8lBx81l2cq+igOxHk0kGZlbIVC9/ISG
         EyWuAbQ8gpCwbEEb52k8OYYKhn4x4xEV3rqw3MLC7bOyB6ZHKA9OqxJMDHz60j1dTRQj
         PLYAv/JR5AX65zn2RuOcIkVMjwMyOGbuw0/2uix88YLWnjYxZDznWZESQgjGzxim4wa8
         z7uOMl86wolFhhsVdGsI5z+nmySamZz8reo2EIhgkPTr1IxNaU8KRSkmGrhOINSdtcKs
         0xAOa+wQQ8mCnglgWzdYomOgsQVJfSrMKbUHkKNeRY2qSnQzVFj7XfOiHg/kXzJVekci
         cwRA==
X-Gm-Message-State: AOAM531nqK+plWXtEn2WEGC5MC3uR3QH+Nh57umQItbVUkKDUiMsQii/
        +Rcz1fprVFt1WvT1xiQjbd8sxNDajVcDgrUBUpA=
X-Google-Smtp-Source: ABdhPJyU4xbKR/hTcJT3i+4AmcxOkV7rwYOr2kWTFFANFENce/N3tHTgLI14O9XHpuyAeqcD9v6uZo0Kn/Dprv2XBvs=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr3114076pfb.7.1617807575856; Wed, 07
 Apr 2021 07:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <20210406165108.GA4332@42.do-not-panic.com> <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
 <20210407143040.GB4332@42.do-not-panic.com>
In-Reply-To: <20210407143040.GB4332@42.do-not-panic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 17:59:19 +0300
Message-ID: <CAHp75VeXiLa0b49eoZKVR1DSqTc9hKxpSgy294hMiaUzt0ugOA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 7, 2021 at 5:30 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Wed, Apr 07, 2021 at 10:33:44AM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 7, 2021 at 10:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:

...

> > > Why is it worth it to add another file just for this?
> >
> > The main point is to break tons of loops that prevent having clean
> > headers anymore.
> >
> > In this case, see bug.h, which is very important in this sense.
>
> OK based on the commit log this was not clear, it seemed more of moving
> panic stuff to its own file, so just cleanup.

Sorry for that. it should have mentioned the kernel folder instead of
lib. But I think it won't clarify the above.

In any case there are several purposes in this case
 - dropping dependency in bug.h
 - dropping a loop by moving out panic_notifier.h
 - unload kernel.h from something which has its own domain

I think that you are referring to the commit message describing 3rd
one, but not 1st and 2nd.

I will amend this for the future splits, thanks!

> > >  Seems like a very
> > > small file.
> >
> > If it is an argument, it's kinda strange. We have much smaller headers.
>
> The motivation for such separate file was just not clear on the commit
> log.

-- 
With Best Regards,
Andy Shevchenko
