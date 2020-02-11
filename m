Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48815960D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBKRSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:18:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36097 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgBKRSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:18:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so12516933ljg.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPyil68yuyJ+m3ARzQUnwCGclYfZi6FHU/hg2eIAr90=;
        b=Oxv8fx0R5ZtCwFqUKGlJaxrqphkrTuLZoOsqtdvMu8qdk9TYoyohIrDIcokMIwSc+x
         +4mXMfpqj+WKTNEyBCY38t0SeBcNRqiA4exz4ySiOVjleujseR3q93UH+bPca5HLhqhf
         4MNnMhr283uyvOpc3E4SisXbYJPGRSipfnkyrkn9EBVPeYN4m7xKSfgbP7bsN8Yxe6m9
         aq8MytcpBdmHf43OuNOz5DOGdmrrgfNhD7jE3QpenYww+dkQlvPwORl+VzTu58B/CBRN
         gb9h56TSmKV/J+CW2Bvp+frcpdKLtzju4yAfdTelj7n5IrkYFuXibs4G9qsD42LC5Z7w
         7yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPyil68yuyJ+m3ARzQUnwCGclYfZi6FHU/hg2eIAr90=;
        b=Ly39A6PMYNlTm7ld3l7spnJV02HerZgN5jCEgWDEfPSeuNunF3910lRmg6IP4XyD2x
         DDy8hpEb6r6MUl01hFVtzGrrhWeLor7pyRd8MoFGuuKaSQjo8CZzi5q12sctstvr2ZDj
         jdBOTEeqTZTZ/0/A20/0URC3SqWUq5BJQwzUYSLeUz6aKIEIicRXRXewiwXQEFzmqs0C
         9itgBueUfAP+dZkMB9lwNUOb6RgWnPaR76YnMPU+0YZa5pJMAs7Kl7+Q7FYWa4Pr2gUV
         Xpc4z07VoCmpdlDbfLR0bf7jF+YQoZsD2tz8blsEV7EAs2aXcCi7SpMhKF09WFIpK/Sp
         pK3A==
X-Gm-Message-State: APjAAAWA456iIzioEEPol/cKCL8/MPZNjRiGsHevgX2lrVooZRoTUHq9
        6vTB9D5Lbwy26JnokX7rM8YjBJhNpvQ735BnXeQ=
X-Google-Smtp-Source: APXvYqxxW78UCMnah1nr/Je9ax//R7eIwIxRHp3zJ998cc+N33NiEZz8ZOezHoOeqQedroEaJQDgUvAZGq4Ebr1X/tc=
X-Received: by 2002:a2e:9705:: with SMTP id r5mr4907379lji.114.1581441529807;
 Tue, 11 Feb 2020 09:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20200206064757.10726-1-ap420073@gmail.com> <20200210214050.GA1579465@kroah.com>
 <CAMArcTXxkyWnXZW8u0v-YtdWrEb2V-j=cCXxE4qzdr3gNRu3ng@mail.gmail.com> <20200211122819.GA1858119@kroah.com>
In-Reply-To: <20200211122819.GA1858119@kroah.com>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Wed, 12 Feb 2020 02:18:38 +0900
Message-ID: <CAMArcTVVWxrNXUzJFEkuD-RjXHDxWZ96i-agvgfQDHhQnLX_TA@mail.gmail.com>
Subject: Re: [PATCH v2] debugfs: Check module state before warning in {full/open}_proxy_open()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Feb 2020 at 21:28, Greg KH <gregkh@linuxfoundation.org> wrote:
>

Hi Greg!

> On Tue, Feb 11, 2020 at 03:09:13PM +0900, Taehee Yoo wrote:
> > On Tue, 11 Feb 2020 at 06:40, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> >
> > Hi Greg,
> > Thank you for your review!
> >
> > > On Thu, Feb 06, 2020 at 06:47:56AM +0000, Taehee Yoo wrote:
> > > > When the module is being removed, the module state is set to
> > > > MODULE_STATE_GOING. At this point, try_module_get() fails.
> > > > And when {full/open}_proxy_open() is being called,
> > > > it calls try_module_get() to try to hold module reference count.
> > > > If it fails, it warns about the possibility of debugfs file leak.
> > > >
> > > > If {full/open}_proxy_open() is called while the module is being removed,
> > > > it fails to hold the module.
> > > > So, It warns about debugfs file leak. But it is not the debugfs file
> > > > leak case. So, this patch just adds module state checking routine
> > > > in the {full/open}_proxy_open().
> > > >
> > > > Test commands:
> > > >     #SHELL1
> > > >     while :
> > > >     do
> > > >         modprobe netdevsim
> > > >         echo 1 > /sys/bus/netdevsim/new_device
> > > >         modprobe -rv netdevsim
> > > >     done
> > > >
> > > >     #SHELL2
> > > >     while :
> > > >     do
> > > >         cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/ipsec
> > > >     done
> > > >
> > > > Splat looks like:
> > > > [  298.766738][T14664] debugfs file owner did not clean up at exit: ipsec
> > > > [  298.766766][T14664] WARNING: CPU: 2 PID: 14664 at fs/debugfs/file.c:312 full_proxy_open+0x10f/0x650
> > > > [  298.768595][T14664] Modules linked in: netdevsim(-) openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 n][  298.771343][T14664] CPU: 2 PID: 14664 Comm: cat Tainted: G        W         5.5.0+ #1
> > > > [  298.772373][T14664] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> > > > [  298.773545][T14664] RIP: 0010:full_proxy_open+0x10f/0x650
> > > > [  298.774247][T14664] Code: 48 c1 ea 03 80 3c 02 00 0f 85 c1 04 00 00 49 8b 3c 24 e8 e4 b5 78 ff 84 c0 75 2d 4c 89 ee 48
> > > > [  298.776782][T14664] RSP: 0018:ffff88805b7df9b8 EFLAGS: 00010282[  298.777583][T14664] RAX: dffffc0000000008 RBX: ffff8880511725c0 RCX: 0000000000000000
> > > > [  298.778610][T14664] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8880540c5c14
> > > > [  298.779637][T14664] RBP: 0000000000000000 R08: fffffbfff15235ad R09: 0000000000000000
> > > > [  298.780664][T14664] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffc06b5000
> > > > [  298.781702][T14664] R13: ffff88804c234a88 R14: ffff88804c22dd00 R15: ffffffff8a1b5660
> > > > [  298.782722][T14664] FS:  00007fafa13a8540(0000) GS:ffff88806c800000(0000) knlGS:0000000000000000
> > > > [  298.783845][T14664] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  298.784672][T14664] CR2: 00007fafa0e9cd10 CR3: 000000004b286005 CR4: 00000000000606e0
> > > > [  298.785739][T14664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [  298.786769][T14664] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [  298.787785][T14664] Call Trace:
> > > > [  298.788237][T14664]  do_dentry_open+0x63c/0xf50
> > > > [  298.788872][T14664]  ? open_proxy_open+0x270/0x270
> > > > [  298.789524][T14664]  ? __x64_sys_fchdir+0x180/0x180
> > > > [  298.790169][T14664]  ? inode_permission+0x65/0x390
> > > > [  298.790832][T14664]  path_openat+0xc45/0x2680
> > > > [  298.791425][T14664]  ? save_stack+0x69/0x80
> > > > [  298.791988][T14664]  ? save_stack+0x19/0x80
> > > > [  298.792544][T14664]  ? path_mountpoint+0x2e0/0x2e0
> > > > [  298.793233][T14664]  ? check_chain_key+0x236/0x5d0
> > > > [  298.793910][T14664]  ? sched_clock_cpu+0x18/0x170
> > > > [  298.794527][T14664]  ? find_held_lock+0x39/0x1d0
> > > > [  298.795153][T14664]  do_filp_open+0x16a/0x260
> > > > [ ... ]
> > > >
> > > > Fixes: 9fd4dcece43a ("debugfs: prevent access to possibly dead file_operations at file open")
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > > ---
> > > >
> > > > v1 -> v2:
> > > >  - Fix compile error
> > > >
> > > >  fs/debugfs/file.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > > index 634b09d18b77..e3075389fba0 100644
> > > > --- a/fs/debugfs/file.c
> > > > +++ b/fs/debugfs/file.c
> > > > @@ -175,8 +175,13 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
> > > >       if (r)
> > > >               goto out;
> > > >
> > > > -     real_fops = fops_get(real_fops);
> > > > -     if (!real_fops) {
> > > > +     if (!fops_get(real_fops)) {
> > > > +#ifdef MODULE
> > > > +             if (real_fops->owner &&
> > > > +                 real_fops->owner->state == MODULE_STATE_GOING)
> > > > +                     goto out;
> > > > +#endif
> > >
> > > Why is this in a #ifdef?
> > >
> > > The real_fops->owner field will be present if MODULE is not enabled,
> > > right?  Shouldn't this just work the same for that case?
> > >
> >
> > The reason for the #ifdef is to avoid compile error
> > MODULE_STATE_GOING is defined if CONFIG_MODULES is enabled.
>
> We should fix that in the .h file where that is defined so that we don't
> have to mess with stuff like this in a .c file.
>
> > So, If the #ifdef doesn't exist, compile will errors.
> > But honestly, I'm not sure whether CONFIG_MODULES should be used
> > here instead of MODULE or not.
>
> Neither, #ifdefs shouldn't be in .c files :)
>

Thank you for the review.
I would like to move MODULE_STATE_XXX flags to outside of CONFIG_MODULES.
In addition, I think a new inline function, which checks modules state
would be helpful for this case.
The inline function code would like this.

+static inline bool module_is_going(struct module *mod)
+{
+       return mod->state == MODULE_STATE_GOING;
+}

Thank you!
Taehee Yoo
