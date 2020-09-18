Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4072701A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIRQJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:09:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:51409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRQJp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:09:45 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 12:09:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600445371;
        bh=vBPwxcUdsi4o0aVug2jOVM/F/yFtmhBYDt7JUWcG0A0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QYYCOA96Hb8dmKyW0MnlJhl1ng2ubV5U7gKVtqQU9jwpOIvLm0AvMj/RpuBjy9CE7
         RvYm2gOMOha2eDkunwYCYxIY7kJ2MGfTNOhEWGLa5jVA34bLpFXLs62b2EyZTCfhig
         NZgMFNTnq9+CCcRKejGU5RN+RKEPqooV3y5mZV8M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mBa-1kT1jV0BRs-0133RJ; Fri, 18
 Sep 2020 18:02:21 +0200
Date:   Fri, 18 Sep 2020 18:02:16 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, Jann Horn <jannh@google.com>,
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] security/fbfam: Mitigate a fork brute force
 attack
Message-ID: <20200918152116.GB3229@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-7-keescook@chromium.org>
 <202009101649.2A0BF95@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009101649.2A0BF95@keescook>
X-Provags-ID: V03:K1:2SvK/7q6kc93vKtX72+ajY6DtC4s5Tf67gk8f8WTvUKUt0yy6yS
 bWPSrhLmQB7npp3vXdL/TyLUT9kQbwwrrZfRfnDRwSp+8qRRcA+fXHTMVkdm4AmR03DhlcT
 QqX38Q1njL5cy0I9fCNox//miQdNddfYUM3rnCM2NyzFLf1BfPTFPt56NIeVLPusWXCyQcR
 7R9iAboHfzD7xqTK+F1eQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TRqadyr8Bl0=:4GUSPI1Efe+8VovoQvq+Wd
 OP2aUleEEzyxVcVICaY34EPS7gs70rOpuUS5EJrdgG6Y01uSkw9c8ATNQgCst2sSXFMv7zEGv
 GRDUV/o0aAUxKQqfrZ/pUvQW7LKhlXZSlErW2BF5FYWfgODaXvBgtb6VAzOQHlFxyBCGQL07/
 nBHX9Jv65GaLb8BQtiR8tuVsxIdvceVpneMzeeMkGwU1FamG3udzpvfJBxijPYi2ri/t3yqfY
 ZyzOP8mDd0nCjqZL51+Q1Rbz3GRKXtchGtby/Lsvdb/Xx4AVWUz+dQnOpFXf5mqucgZXcgQn6
 uIM2KotJzLcX5xur8lz2MjPzEK6FcHT96kEyj97K91qf84/GkflVcEc1kmpUjzlqyP4vHND8b
 THEyLMRfn/zv2wC++0kG2V0t/a0dLVaOBYpM1pxGBWIvOu09fETeFMGh+iDkex1LFa1kewb/b
 0sU3hollA7bNidhvaxGrglqED9on9TZhCcxdlLNMUYGLtQDBiRExqXHutId+bTBXiZJ7dh+xE
 R3QVc2zO10D4uqeCuFO9a0R8F+3sGUCK91Te/IRNh9XwCV4dqTrhV5NcTeV5g/v7p/Sxva8tB
 mh638Q842sN+UYXdJtcKq1N/74rRJxui7jTTy33oLkH4C3c3Srv0K0Kn8inPwYPfxfUClQhCX
 F/8LUdByAONHna7UU1P3c3YkUvGtaKUz+HC3KS4qTSImGgLRmwTO5k7deJc4+jfyC4wq7JVQ9
 be1r5B+TS+ErQyOczpg7UMGr7YZYGPuKUb8KzsUAvQMQHTdkr5zgQGwWYQ053I82R/e0i6uSW
 Z/6h7AVrjfKe1uuuc4w7eFEVUvgRZnpOdTX54MhtTuEpsoMjjiacTUeFmCwX7rHOhu3ylkBHx
 xCJ8laDqlkt1ZoTkzGyQbV5LE3ipeYH9or3C46h9QR+cdar19jXfysYeVhg7WKEFBu0exGHFa
 tNxWdnkqaMT1q53XPvEaV4j4NaUTz98VNGp6ZS+om1pfZr21gdS6n1faDm1J2ICW2WPIns5+f
 w6tJOUQKBRfH2mFSsysJF/1c8pYEugMS4ZHA+gqrkOkm+Nv4ac6c3SsJp4sc7oigH5krHbbQQ
 mCbg9LG1uJN2kjsP69GEnDeuo7B/EDI8uU4ekfva8IUMmq1pPMqPUasqMYJJKktGPkFPYslKJ
 2HhriJTaYx5FiXIPSvkLS88g95ZLpP6eVMvUbshMhNGFSFLYbjitcUsUXq3rn0IzhM57znXse
 70oQjtLbmjqnQ+4rG3ByYSnWc6mP9KSgENGc9CA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:56:19PM -0700, Kees Cook wrote:
> On Thu, Sep 10, 2020 at 01:21:07PM -0700, Kees Cook wrote:
> >  /**
> > + * fbfam_kill_tasks() - Kill the offending tasks
> > + *
> > + * When a fork brute force attack is detected it is necessary to kill=
 all the
> > + * offending tasks. Since this function is called from fbfam_handle_a=
ttack(),
> > + * and so, every time a core dump is triggered, only is needed to kil=
l the
> > + * others tasks that share the same statistical data, not the current=
 one as
> > + * this is in the path to be killed.
> > + *
> > + * When the SIGKILL signal is sent to the offending tasks, this funct=
ion will be
> > + * called again during the core dump due to the shared statistical da=
ta shows a
> > + * quickly crashing rate. So, to avoid kill again the same tasks due =
to a
> > + * recursive call of this function, it is necessary to disable the at=
tack
> > + * detection setting the jiffies to zero.
> > + *
> > + * To improve the for_each_process loop it is possible to end it when=
 all the
> > + * tasks that shared the same statistics are found.
> > + *
> > + * Return: -EFAULT if the current task doesn't have statistical data.=
 Zero
> > + *         otherwise.
> > + */
> > +static int fbfam_kill_tasks(void)
> > +{
> > +	struct fbfam_stats *stats =3D current->fbfam_stats;
> > +	struct task_struct *p;
> > +	unsigned int to_kill, killed =3D 0;
> > +
> > +	if (!stats)
> > +		return -EFAULT;
> > +
> > +	to_kill =3D refcount_read(&stats->refc) - 1;
> > +	if (!to_kill)
> > +		return 0;
> > +
> > +	/* Disable the attack detection */
> > +	stats->jiffies =3D 0;
> > +	rcu_read_lock();
> > +
> > +	for_each_process(p) {
> > +		if (p =3D=3D current || p->fbfam_stats !=3D stats)
> > +			continue;
> > +
> > +		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
> > +		pr_warn("fbfam: Offending process with PID %d killed\n",
> > +			p->pid);
>
> I'd make this ratelimited (along with Jann's suggestions).

Sorry, but I don't understand what you mean with "make this ratelimited".
A clarification would be greatly appreciated.

> Also, instead of the explicit "fbfam:" prefix, use the regular
> prefixing method:
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Understood.

> > +
> > +		killed +=3D 1;
> > +		if (killed >=3D to_kill)
> > +			break;
> > +	}
> > +
> > +	rcu_read_unlock();
>
> Can't newly created processes escape this RCU read lock? I think this
> need alternate locking, or something in the task_alloc hook that will
> block any new process from being created within the stats group.

I will work on this for the next version. Thanks.

> > +	return 0;
> > +}
>
> --
> Kees Cook

Thanks
John Wood
