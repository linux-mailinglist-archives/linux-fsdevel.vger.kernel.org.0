Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AB268060
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgIMQ5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 12:57:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:43001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgIMQ5v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600016191;
        bh=2UfjObndGtW0Xq6W1Y2m5K5jmrf7PALFEYSIFTj3SRk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Zc6U28KaEBYWrmUQ6T5i0/2G23L9udYWFnuge/OPiC8b9IfDTCU017y3rmUXYVxq0
         kajCBw4nHacTh623DsBzar7JounEuziC0XpshmEWy8tQ1iRCEChC2G7oJueREwAIff
         T9MBF+wDx6bYCnRsHxYmSSIbhLAoWxAjlFSktvPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9kM-1kIdsZ0fZU-00Gaaf; Sun, 13
 Sep 2020 18:56:31 +0200
Date:   Sun, 13 Sep 2020 18:56:12 +0200
From:   John Wood <john.wood@gmx.com>
To:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
Message-ID: <20200913152724.GB2873@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-6-keescook@chromium.org>
 <202009101634.52ED6751AD@keescook>
 <CAG48ez2fP7yupg6Th+Hg0tL3o06p2PR1HtQcvy4Ro+Q5T2Nfkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2fP7yupg6Th+Hg0tL3o06p2PR1HtQcvy4Ro+Q5T2Nfkw@mail.gmail.com>
X-Provags-ID: V03:K1:fFhuJz0gvsAKhyXIL51o/azcshQRL7L+66gcb+DURq+rQrGIfh5
 yGkKJ/8c9JYhC2pJjV5T/ERRgDmRmiBJ63C8lyiY2/w7LiCL/JkSkacipHQhE85+cpPDTRO
 eOmkxxwjRIo00I747W9FNP+lUDa+J7oVW4wVTRoysdyrtRTZaVEE9FcLtrcEYR3PHTyXTF2
 Z8jrzms0p4mPTKb94KV3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9JDcq2+UbDI=:GRnECanaZF7QfeOPwoBV1a
 nO6OdYi+PZexCJ2o7AARPY2a6ebH5Ihvx642+JprXJAnuYC/BRiMMxIqEWoscM2svFEfjNmov
 +VXn1ahL3Z5KOa5+fnVBALBFGjftZPL4E5AG2s1vp6sLd9yuypx0hR6eyhMCwAh+xUACGpvpw
 BS8akPEcoTSIAUi01eHLWIcRClbXUssPu8bjkcFxGrrfbA6NX5JOgYDAZGWuTTBT8i36dLPqa
 a4wTP0EOwFSO8BkipUGkEg1OoyvbTpDUh4ScF/Z1+z738ELqAhWAuZdtT89frCqiB7hYwJH9z
 kRxGZuLz8ZhqS6bqpR+HgXFAPoR71DS+soH8btkwcbanjrDB5YA+OI/WWnzD5aXEOn08b2qY7
 BTd7mZyPuhgSmoFQbIQJj3J61nIk7NIgjbRJQBUnuhHSlC6h46hf1KHeZPBedm3XMT77LWXVs
 i+sZpr1g60OLNAe/6qUmcd4Ck9fryu6kKAR3RjULSmG9OH6ODtRURThaYGsDP0AdDl1NI2Hlk
 clXGmkEWOjYOJyU9vQsBJNK7XjHwAX/Y2ZFoOueKnk4BknlrNg95gvW3n1/dfHwEMMAVbIBoC
 s4oERFDoi+yza5XwP4obNOPuXVpkVW5ESDL91QMDAes59k4e6jSsdN8vQbg/KOl42IrVlKxPz
 PNSBO0dW/HGzHjTpX/uVrNFjinwANOA6TEVMV/jAqoKuK6/KuQjFX/NYHHbXkEjigeIYuKCoQ
 7OXQBV8tIwgRuZYhaKcqTMTc7JkWZK8d3SLxv3UO/JsXz2mW6HO/3aZAfQPitSsl7fSo/+X0+
 bKP8nJsqEZnUcHF3CXy1KK6brIYYTkYX9fLLkFYjP/RWuUg+hvynGlrQnrwMsXY7YhT006b27
 3MB3GzxedAdO2eNPyCis8xiOYWP57FbZVChO5YFzv92ShUC95pDdK/Ek0cH+N4TepcIkv/sRR
 2kxCqmBpKNUrzmrHiZEAt2hy7yJ6XudokJmOOyBnllDWZE8cw0uVi9V3eHnVR6w5Y2HzLFMLv
 KeAJFLHhfdAS0HyhaXO2Jh7mP/0ZG2VuvV2AdlYRwsO2u6vfImM1GEmFcTag/snw5vWAZC4ws
 nu5NXkY07Urkr6RSY4YXryNnkV1Yb12jo4s0qx9LwNeBKqg/gbIdWYDJMinutQSRSLBbAscSb
 PM2hDJn62xykg+85Qt91p2TXsgTTACadg8BgzUVBPx4XbPiAHtEFSngCyuwIHDf+EZffSbzZ2
 Ox4mBFjRtTEQhJN8P7RoFK4ho+VRVaYeEHPQYAw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Sep 11, 2020 at 02:01:56AM +0200, Jann Horn wrote:
> On Fri, Sep 11, 2020 at 1:49 AM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 10, 2020 at 01:21:06PM -0700, Kees Cook wrote:
> > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > index 76e7c10edfc0..d4ba4e1828d5 100644
> > > --- a/fs/coredump.c
> > > +++ b/fs/coredump.c
> > > @@ -51,6 +51,7 @@
> > >  #include "internal.h"
> > >
> > >  #include <trace/events/sched.h>
> > > +#include <fbfam/fbfam.h>
> > >
> > >  int core_uses_pid;
> > >  unsigned int core_pipe_limit;
> > > @@ -825,6 +826,7 @@ void do_coredump(const kernel_siginfo_t *siginfo=
)
> > >  fail_creds:
> > >       put_cred(cred);
> > >  fail:
> > > +     fbfam_handle_attack(siginfo->si_signo);
> >
> > I don't think this is the right place for detecting a crash -- isn't
> > this only for the "dumping core" condition? In other words, don't you
> > want to do this in get_signal()'s "fatal" block? (i.e. very close to t=
he
> > do_coredump, but without the "should I dump?" check?)
> >
> > Hmm, but maybe I'm wrong? It looks like you're looking at noticing the
> > process taking a signal from SIG_KERNEL_COREDUMP_MASK ?
> >
> > (Better yet: what are fatal conditions that do NOT match
> > SIG_KERNEL_COREDUMP_MASK, and should those be covered?)
> >
> > Regardless, *this* looks like the only place without an LSM hook. And =
it
> > doesn't seem unreasonable to add one here. I assume it would probably
> > just take the siginfo pointer, which is also what you're checking.
>
> Good point, making this an LSM might be a good idea.
>
> > e.g. for include/linux/lsm_hook_defs.h:
> >
> > LSM_HOOK(int, 0, task_coredump, const kernel_siginfo_t *siginfo);
>
> I guess it should probably be an LSM_RET_VOID hook? And since, as you
> said, it's not really semantically about core dumping, maybe it should
> be named task_fatal_signal or something like that.

If I understand correctly you propose to add a new LSM hook without return
value and place it here:

diff --git a/kernel/signal.c b/kernel/signal.c
index a38b3edc6851..074492d23e98 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2751,6 +2751,8 @@ bool get_signal(struct ksignal *ksig)
                        do_coredump(&ksig->info);
                }

+               // Add the new LSM hook here
+
                /*
                 * Death signals, no core dump.
                 */

Thanks,
John Wood

