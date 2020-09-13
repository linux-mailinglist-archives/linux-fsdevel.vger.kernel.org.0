Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C9F2680A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgIMR4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 13:56:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:43163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgIMR4X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600019709;
        bh=37/K9jmay+vWoED09geZGDHT0GBiGgqzABktSn8pAO8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ODcKTz4Afh6HJdZgzJuUnf3INw5pPrKK+VS9kZo3PB2I4vIQ8wUz3c7YZbmEkqMvM
         3qzE7f6yYI7BYfrfvm6xxFe/YnqNEJX7+OPsU3jU/ubzHqEmBbN61Pok8bGUcHdoUp
         H5MGoDvs0+gUKAqdnwXy2VWvTzo1nzkPdcScx78Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGRz-1jsOgK0oVJ-00PdAm; Sun, 13
 Sep 2020 19:55:09 +0200
Date:   Sun, 13 Sep 2020 19:54:51 +0200
From:   John Wood <john.wood@gmx.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
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
Message-ID: <20200913172415.GA2880@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-6-keescook@chromium.org>
 <CAG48ez1gbu+eBA_PthLemcVVR+AU7Xa1zzbJ8tLMLBDCe_a+fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1gbu+eBA_PthLemcVVR+AU7Xa1zzbJ8tLMLBDCe_a+fQ@mail.gmail.com>
X-Provags-ID: V03:K1:rqCReVk5SG3AVcU2RIp3vqC5UKPhITO5SKjMkNjMy5pBF/LfL1Z
 MUWrU+w9/m5uuZXKCY4TSUD7M+aDK7+73N2qYlkGfzrEgFHEDW21lRrbX9BW0O9dVXbpnIj
 0UghsETC4sfdX+e2dYJXlrVX4wNYhKRX08XcuyaN2mwNB7PoKqUBRKRtCGWGB76A8Hp1eIO
 sRdupJBh1R/eAqBaSMbRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LHzyUdNgCa8=:h+NeD4HnUlM+L9S1sUoGQn
 TIbDmNwwVnptY6RreiUctJEjebk/Iy26DJB4jPCzXjdOac+XK5dE4k7z56ZnRyNTkY7ZwTBUs
 lQkLgz4bajSnG5e+PRUXbaLG+ilivuzR+cJMMswrVHK6jbOzLKOBzEyt2Vdpm66VgKmzqNWxp
 EfKKO70GidjNbMdHPdi6QIeCqGhGj7Hmm3Vqsm1yVWR0VCJ++VcPT440934UnWIjfNa4rKatS
 rNC34S0h0SK3iw+GhHwTxHSfucO5xncfYI0DrVeceJjW+1Tw54En+FtZRDj9EjO4TwsuKCxeD
 I86lzOuF8m7dJOUvRn0yK6E2uximOyhSPMmXYYlAaWVuMvPbmruvOWinbNA0rjbl49RfbmJ6B
 KeNm6Q0JdjH1i/EOg5CCcYABrdouD2FtLVmmivbdQXAJe1PL7t3KUSES6O+rKkB6CMnTMNQWd
 TX6xYdqlT7ngZYbZ3g1bk0yExPOF8qnxSJReemmwUzz3xSK4/gWvcXFvKEcOWSd/xjiE4cIQJ
 kmpPtIRoIO7v1mEpu63xKT5En29hZCEfi00pzLkzkpSfRw6biUEklCwLgmDy3CMf5S1oqMOq5
 wf7fjEB0/0vDqejk3wGQKcMpJfmGof8b+V345pQkUlujdCzkirZ8eBeJC4EYRer72kHT6b8j2
 pey5HTbwJsR4Bcjjdz7Otr4/jvtKWeV0m9yl11LB9RBq0jKymT702jtg3WrpZA+62NaT8JX+M
 NeBeHBI36cL5j+ZiNUnEWy+mROrvBCoVhCrXGuu4rrXC/ptN1yf2+cm0L8dEIOEyvkuOiepXq
 0R0rFizOPtLBxGQ3Vko1ldVFGgBh4K4OjoVDEn55gjCINxBivhNuNM+Xpu7waJJ/XZaT0k2Nn
 Btbxa2JjGx5yYRoOQsph78xg0YFs8tHh6lz/uU3U88rht0DNiizXk7VN9/DfZI0Wx6imwqxZm
 Y/X4eo6PvtT7G0skba+UvJBhQV1zHOgAn0Vj7hCKF49cD/ngqsKJO8zcywbDW7QZQ24XJ1AE+
 8nsZEDdRsQ51uSOE/mKE03TmYO9pmTrwxaDf/ZDRRau2vWkoVwx7bMF//hGLKZw/j7IGEtbO+
 z8oNpE4+3RPWwORbh+Oj+2boXskF7KE3/77WHDAsE29xNhtF7zqEo0O50EORQYPHBm10EKRst
 EO8e4FVJUWvwUS36NH4F3y+wcQzsd1OiJkld3xfNyGeC0+kf6V/O2TnFHnr2uuXVjCYvHyHWH
 3PmCdiTigVJG38v+lBAEFzBfuk2yAAaicF/en7A==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Sep 10, 2020 at 11:10:38PM +0200, Jann Horn wrote:
> On Thu, Sep 10, 2020 at 10:22 PM Kees Cook <keescook@chromium.org> wrote=
:
> > To detect a fork brute force attack it is necessary to compute the
> > crashing rate of the application. This calculation is performed in eac=
h
> > fatal fail of a task, or in other words, when a core dump is triggered=
.
> > If this rate shows that the application is crashing quickly, there is =
a
> > clear signal that an attack is happening.
> >
> > Since the crashing rate is computed in milliseconds per fault, if this
> > rate goes under a certain threshold a warning is triggered.
> [...]
> > +/**
> > + * fbfam_handle_attack() - Fork brute force attack detection.
> > + * @signal: Signal number that causes the core dump.
> > + *
> > + * The crashing rate of an application is computed in milliseconds pe=
r fault in
> > + * each crash. So, if this rate goes under a certain threshold there =
is a clear
> > + * signal that the application is crashing quickly. At this moment, a=
 fork brute
> > + * force attack is happening.
> > + *
> > + * Return: -EFAULT if the current task doesn't have statistical data.=
 Zero
> > + *         otherwise.
> > + */
> > +int fbfam_handle_attack(int signal)
> > +{
> > +       struct fbfam_stats *stats =3D current->fbfam_stats;
> > +       u64 delta_jiffies, delta_time;
> > +       u64 crashing_rate;
> > +
> > +       if (!stats)
> > +               return -EFAULT;
> > +
> > +       if (!(signal =3D=3D SIGILL || signal =3D=3D SIGBUS || signal =
=3D=3D SIGKILL ||
> > +             signal =3D=3D SIGSEGV || signal =3D=3D SIGSYS))
> > +               return 0;
>
> As far as I can tell, you can never get here with SIGKILL, since
> SIGKILL doesn't trigger core dumping and also isn't used by seccomp?

Understood.

> > +
> > +       stats->faults +=3D 1;
>
> This is a data race. If you want to be able to increment a variable
> that may be concurrently incremented by other tasks, use either
> locking or the atomic_t helpers.

Ok, I will correct this for the next version. Thanks.

> > +       delta_jiffies =3D get_jiffies_64() - stats->jiffies;
> > +       delta_time =3D jiffies64_to_msecs(delta_jiffies);
> > +       crashing_rate =3D delta_time / (u64)stats->faults;
>
> Do I see this correctly, is this computing the total runtime of this
> process hierarchy divided by the total number of faults seen in this
> process hierarchy? If so, you may want to reconsider whether that's
> really the behavior you want. For example, if I configure the minimum
> period between crashes to be 30s (as is the default in the sysctl
> patch), and I try to attack a server that has been running without any
> crashes for a month, I'd instantly be able to crash around
> 30*24*60*60/30 =3D 86400 times before the detection kicks in. That seems
> suboptimal.

You are right. This is not the behaviour we want. So, for the next
version it would be better to compute the crashing period as the time
between two faults, or the time between the execve call and the first
fault (first fault case).

However, I am afraid of a premature detection if a child process fails
twice in a short period.

So, I think it would be a good idea add a new sysctl to setup a
minimum number of faults before the time between faults starts to be
computed. And so, the attack detection only will be triggered if the
application crashes quickly but after a number of crashes.

What do you think?

>
> (By the way, it kind of annoys me that you call it the "rate" when
> it's actually the inverse of the rate. "Period" might be more
> appropriate?)

Yes, "period" it's more appropiate. Thanks for the clarification.

> > +       if (crashing_rate < (u64)sysctl_crashing_rate_threshold)
> > +               pr_warn("fbfam: Fork brute force attack detected\n");
> > +
> > +       return 0;
> > +}
> > +
> > --
> > 2.25.1
> >

Regards,
John Wood

