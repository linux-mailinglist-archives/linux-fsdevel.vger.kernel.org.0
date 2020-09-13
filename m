Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B1267FC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIMOeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 10:34:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:49329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgIMOek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 10:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600007610;
        bh=dHflCuyQDEYDcMpnPKECIFyNSbsiT8CytXlxu2bp71o=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bDSoCpaW9dBsL2Re69QW0Ivh+uMs3Lhd+7aN2ghPtpPeOxQGgPuTPD9VBMY7PScxZ
         fqWvgD7YnoSPLFPa4dtja62tZuLzBqO6doYWbwW/XlIt2WSkJE4jg7CFoTE71eBj6X
         F3XnJTHec0KYINrIJadRACkr3dJPNUGbySNy2NZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1k2Nyl2VKr-00XMi7; Sun, 13
 Sep 2020 16:33:30 +0200
Date:   Sun, 13 Sep 2020 16:33:09 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, kernel-hardening@lists.openwall.com,
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
Subject: Re: [RFC PATCH 4/6] security/fbfam: Add a new sysctl to control the
 crashing rate threshold
Message-ID: <20200913143309.GA2873@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-5-keescook@chromium.org>
 <202009101612.18BAD0241D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009101612.18BAD0241D@keescook>
X-Provags-ID: V03:K1:g34bOsvNGvcdIL3vhD+B4Loro4lpz3d33Rzd1nJZQCi64UltDtY
 KxXkFlAvpWBqoGc9UEunLZ+B/OmAtjL1rp4M3xrRUyHVKn12OGhCe2skngRwsODg8cbLsHO
 OHdWHHQb5TJ5/xDAvrL28XWApVU8+vl92dQGrc+yL91F4QwOnGwgm5j3yViHD8UrqUh3mNd
 V/g/bnSsOi/9Xa3OzjkhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0eHgbzh5VJg=:ZD7BwxwgOEUm0hOd/i4YrI
 Fy51LzGO2bzJr1jUdSDKUlZRJnVkZSwj1v8pheewD47iAw4hWoVTDV84BSunzJQF/BzMeDGBQ
 BQQycBZFdkD/yVLCuM4C9qE/aWPHMnO1cXT+uLP/rFM8gj4cJY6YlKWG+0dSEyGHUD+UiIe1n
 c9jjxKj+n2ZoKGLKOm+MTwA8eUY2AIDNXoG4xl72KUjSFxT9H3QSWMxuSfZsM7yhpFPw0mkSZ
 G9T+e13NT0Vs0ifMAg2UU+5062nwXlbFPKSjKYy+VscFYG9Xi+xT7KbN7BkUDSUxFM1O3G4/C
 ar+h0qHAFvl/0wMUsbsUsoPiz1zqdySLoFdDA8dJ1rRbGtQa901oUMH2QJUZFZBzY/xnAvax0
 XudxWOSXMX0fhJ7g1HTMfAj406uzGLblplZMDti7X1im/8nsH6wtIlnAzkKUEtbwk/r/k9WfI
 MrTkTLeBtC9++q37GzWAcE0zxzx9c9x5KCof28AabcNOhMzXOtQgboC2u+2XP31G2MkYzK9L7
 XCCs3f+n59WX0f1RZ030F7u6KJvoKRSH762jAqngmtuPXF3c8lMVGWNlWbd60lkK+gTvIGpRp
 SI0aS6YB9d6D+PqylBmjQLrlIK8l/pQK84QE2gMV++kDVmYKixwafFKSECZpsrTtr4SbVinkG
 E1F1h5shl6WEAei7/Kc4SQVRIYJSOs7pc2zqqyIgZxqNEWMkao/83buIqnkRsNQXBhC0MQx1M
 k+npfS97YzRpmC7xSOh2hB3slromS9JXDETWrjtbrADuJA/7ea/kiXUOyhum+Hzz94WBFJglR
 LqlaMDDqz5fiBCmDrK12azcDC7TBXAN+I9NrIWTkpsW49tEnLDHyuRlIbgFQxA34uMDYjwWhD
 OlRJXDyxv+0cMmwsxL+8DzkoOrcWonYaKTsbw9MlHSExjHzpHiya0bhXysKqq1sY6c7xG/ST7
 zOMcy2Q+dCvqwxWAKv6P15p9OLD5I6rbTYW30fbyYWDYvxdbtQOGBXFg2/3SEED89zKsXNCWs
 0n5KAUx9hnHyLRzNy0ify1BAt4vyTwu4bGefwpcYcWhaBmBl6jTw08Kzvtlqoe+V+hOnBN34f
 OpMI06rO35Rp3i4cbm1CdOI1H4vT8UjQ72N3OtLt5Jn/U/L46G7FRuTHr6XAdhqLE3lSPwlL7
 q+gMYrHOdM419N0m7Hod+1AZixmf9zmx3sOv8f//MMVKRFtG11SaNrita8N5A1O/Tv+czH0wC
 c+PSGq3fJJhrf6H/p4UMFzzS6pt3K58QJnF0iaA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, more inline.

On Thu, Sep 10, 2020 at 04:14:38PM -0700, Kees Cook wrote:
> > diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
> > index b5b7d1127a52..2cfe51d2b0d5 100644
> > --- a/include/fbfam/fbfam.h
> > +++ b/include/fbfam/fbfam.h
> > @@ -3,8 +3,12 @@
> >  #define _FBFAM_H_
> >
> >  #include <linux/sched.h>
> > +#include <linux/sysctl.h>
> >
> >  #ifdef CONFIG_FBFAM
> > +#ifdef CONFIG_SYSCTL
> > +extern struct ctl_table fbfam_sysctls[];
> > +#endif
>
> Instead of doing the extern and adding to sysctl.c, this can all be done
> directly (dynamically) from the fbfam.c file instead.

Like Yama do in the yama_init_sysctl() function? As a reference code.

> >  int fbfam_fork(struct task_struct *child);
> >  int fbfam_execve(void);
> >  int fbfam_exit(void);
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 09e70ee2332e..c3b4d737bef3 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -77,6 +77,8 @@
> >  #include <linux/uaccess.h>
> >  #include <asm/processor.h>
> >
> > +#include <fbfam/fbfam.h>
> > +
> >  #ifdef CONFIG_X86
> >  #include <asm/nmi.h>
> >  #include <asm/stacktrace.h>
> > @@ -2660,6 +2662,13 @@ static struct ctl_table kern_table[] =3D {
> >  		.extra1		=3D SYSCTL_ZERO,
> >  		.extra2		=3D SYSCTL_ONE,
> >  	},
> > +#endif
> > +#ifdef CONFIG_FBFAM
> > +	{
> > +		.procname	=3D "fbfam",
> > +		.mode		=3D 0555,
> > +		.child		=3D fbfam_sysctls,
> > +	},
> >  #endif
> >  	{ }
> >  };
> > diff --git a/security/fbfam/Makefile b/security/fbfam/Makefile
> > index f4b9f0b19c44..b8d5751ecea4 100644
> > --- a/security/fbfam/Makefile
> > +++ b/security/fbfam/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_FBFAM) +=3D fbfam.o
> > +obj-$(CONFIG_SYSCTL) +=3D sysctl.o
> > diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
> > index 0387f95f6408..9be4639b72eb 100644
> > --- a/security/fbfam/fbfam.c
> > +++ b/security/fbfam/fbfam.c
> > @@ -7,6 +7,17 @@
> >  #include <linux/refcount.h>
> >  #include <linux/slab.h>
> >
> > +/**
> > + * sysctl_crashing_rate_threshold - Crashing rate threshold.
> > + *
> > + * The rate's units are in milliseconds per fault.
> > + *
> > + * A fork brute force attack will be detected if the application's cr=
ashing rate
> > + * falls under this threshold. So, the higher this value, the faster =
an attack
> > + * will be detected.
> > + */
> > +unsigned long sysctl_crashing_rate_threshold =3D 30000;
>
> I would move the sysctls here, instead. (Also, the above should be
> const.)

If the above variable is const how the sysctl interface can modify it?
I think it would be better to declare it as __read_mostly instead. What
do you think?

unsigned long sysctl_crashing_rate_threshold __read_mostly =3D 30000;

> > +
> >  /**
> >   * struct fbfam_stats - Fork brute force attack mitigation statistics=
.
> >   * @refc: Reference counter.
> > diff --git a/security/fbfam/sysctl.c b/security/fbfam/sysctl.c
> > new file mode 100644
> > index 000000000000..430323ad8e9f
> > --- /dev/null
> > +++ b/security/fbfam/sysctl.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/sysctl.h>
> > +
> > +extern unsigned long sysctl_crashing_rate_threshold;
> > +static unsigned long ulong_one =3D 1;
> > +static unsigned long ulong_max =3D ULONG_MAX;
> > +
> > +struct ctl_table fbfam_sysctls[] =3D {
> > +	{
> > +		.procname	=3D "crashing_rate_threshold",
> > +		.data		=3D &sysctl_crashing_rate_threshold,
> > +		.maxlen		=3D sizeof(sysctl_crashing_rate_threshold),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_doulongvec_minmax,
> > +		.extra1		=3D &ulong_one,
> > +		.extra2		=3D &ulong_max,
> > +	},
> > +	{ }
> > +};
>
> I wouldn't bother splitting this into a separate file. (Just leave it in
> fbfam.c)
>
> --
> Kees Cook

Thanks,
John Wood

