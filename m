Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2136F1589E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 07:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBKGJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 01:09:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38560 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBKGJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:09:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so6107814lfm.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 22:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wfnVr9/HPvNUt/dlWjCBVLFcqwfLHtLuYOB8tmEsQI=;
        b=Y75m+kox59ue+roFIEsfG3XNiAsqymHCIDsvdCMoSREDP2VtOv6+ZTiMn+mioY5yyv
         3cn9D1QDgvnMOi5Dq6tedCGw8Stye2xhlc5eZv8PeWBxpbFGo42+BvxQ7YlbRDFMg6xr
         vnNgw2O/rcdNQ38mFHb14Yrj2MxBgF544vRi0sJBWETdhoLO1YUqZuPoXcM4hBd21FKr
         Gfajq2u8Hpn9jwHK2ptwUCYUWk/E4kDRVo6LNjiK5N0YJmV+O2mW3amsbdL9xo7K4Ooo
         Yh1ZHW+Nv6qg8yQzxmiyOg0kyEatBp4BtQrbOshEYf6UyMlpZhrkS8g8CYQRr7GLjQaa
         YgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wfnVr9/HPvNUt/dlWjCBVLFcqwfLHtLuYOB8tmEsQI=;
        b=ML4nJjHmRYrKkWc2BPrZfsk2c8/e+1Bs9bXuQpMtOiIYH5oVOLTTXfVnNQp62NU/ge
         pMPEjy29kWXeTpXY0Q309krYs45Vpq6VXGcq3o93bhWQpvZGrAR/J0wobs+AKP2LBZsC
         t0ZFVDkA7J0YtnjFtETIkZ1qccz09n8OmTxVFYYVqRn44ort/k5hgRQLvDANki3q7GCv
         O4kZK+Spaosx4Mz2jEm/L9dhHKpe4vslDmYGc2r6Wzc5czqeN1RPSPgwgXrDXZPyhEh6
         G2Ai2gS2L4tg7NzWn++2lbwClxMNT7hhvYslhxL/VLW6IwMKaG97xFUOBZUH/jWxNXkZ
         83aw==
X-Gm-Message-State: APjAAAUml0DCiXwirjKImDixG9vGY24wLEUnPRUIgmCO3YkMz63okC7k
        pRpYrABVY1Coxbqx2huaB2acddWYsqcixBSm4oI=
X-Google-Smtp-Source: APXvYqy5ckybEWsXxSKUWFzfVQmHvSmhd4aPAI4ULRJY9pBGAoKfmJ2It8R3ChR+J6CNeysqna0tgi7yA9s36OdVrDk=
X-Received: by 2002:ac2:5509:: with SMTP id j9mr2645767lfk.135.1581401365406;
 Mon, 10 Feb 2020 22:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20200206064757.10726-1-ap420073@gmail.com> <20200210214050.GA1579465@kroah.com>
In-Reply-To: <20200210214050.GA1579465@kroah.com>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Tue, 11 Feb 2020 15:09:13 +0900
Message-ID: <CAMArcTXxkyWnXZW8u0v-YtdWrEb2V-j=cCXxE4qzdr3gNRu3ng@mail.gmail.com>
Subject: Re: [PATCH v2] debugfs: Check module state before warning in {full/open}_proxy_open()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Feb 2020 at 06:40, Greg KH <gregkh@linuxfoundation.org> wrote:
>

Hi Greg,
Thank you for your review!

> On Thu, Feb 06, 2020 at 06:47:56AM +0000, Taehee Yoo wrote:
> > When the module is being removed, the module state is set to
> > MODULE_STATE_GOING. At this point, try_module_get() fails.
> > And when {full/open}_proxy_open() is being called,
> > it calls try_module_get() to try to hold module reference count.
> > If it fails, it warns about the possibility of debugfs file leak.
> >
> > If {full/open}_proxy_open() is called while the module is being removed,
> > it fails to hold the module.
> > So, It warns about debugfs file leak. But it is not the debugfs file
> > leak case. So, this patch just adds module state checking routine
> > in the {full/open}_proxy_open().
> >
> > Test commands:
> >     #SHELL1
> >     while :
> >     do
> >         modprobe netdevsim
> >         echo 1 > /sys/bus/netdevsim/new_device
> >         modprobe -rv netdevsim
> >     done
> >
> >     #SHELL2
> >     while :
> >     do
> >         cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/ipsec
> >     done
> >
> > Splat looks like:
> > [  298.766738][T14664] debugfs file owner did not clean up at exit: ipsec
> > [  298.766766][T14664] WARNING: CPU: 2 PID: 14664 at fs/debugfs/file.c:312 full_proxy_open+0x10f/0x650
> > [  298.768595][T14664] Modules linked in: netdevsim(-) openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 n][  298.771343][T14664] CPU: 2 PID: 14664 Comm: cat Tainted: G        W         5.5.0+ #1
> > [  298.772373][T14664] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> > [  298.773545][T14664] RIP: 0010:full_proxy_open+0x10f/0x650
> > [  298.774247][T14664] Code: 48 c1 ea 03 80 3c 02 00 0f 85 c1 04 00 00 49 8b 3c 24 e8 e4 b5 78 ff 84 c0 75 2d 4c 89 ee 48
> > [  298.776782][T14664] RSP: 0018:ffff88805b7df9b8 EFLAGS: 00010282[  298.777583][T14664] RAX: dffffc0000000008 RBX: ffff8880511725c0 RCX: 0000000000000000
> > [  298.778610][T14664] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8880540c5c14
> > [  298.779637][T14664] RBP: 0000000000000000 R08: fffffbfff15235ad R09: 0000000000000000
> > [  298.780664][T14664] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffc06b5000
> > [  298.781702][T14664] R13: ffff88804c234a88 R14: ffff88804c22dd00 R15: ffffffff8a1b5660
> > [  298.782722][T14664] FS:  00007fafa13a8540(0000) GS:ffff88806c800000(0000) knlGS:0000000000000000
> > [  298.783845][T14664] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  298.784672][T14664] CR2: 00007fafa0e9cd10 CR3: 000000004b286005 CR4: 00000000000606e0
> > [  298.785739][T14664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  298.786769][T14664] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  298.787785][T14664] Call Trace:
> > [  298.788237][T14664]  do_dentry_open+0x63c/0xf50
> > [  298.788872][T14664]  ? open_proxy_open+0x270/0x270
> > [  298.789524][T14664]  ? __x64_sys_fchdir+0x180/0x180
> > [  298.790169][T14664]  ? inode_permission+0x65/0x390
> > [  298.790832][T14664]  path_openat+0xc45/0x2680
> > [  298.791425][T14664]  ? save_stack+0x69/0x80
> > [  298.791988][T14664]  ? save_stack+0x19/0x80
> > [  298.792544][T14664]  ? path_mountpoint+0x2e0/0x2e0
> > [  298.793233][T14664]  ? check_chain_key+0x236/0x5d0
> > [  298.793910][T14664]  ? sched_clock_cpu+0x18/0x170
> > [  298.794527][T14664]  ? find_held_lock+0x39/0x1d0
> > [  298.795153][T14664]  do_filp_open+0x16a/0x260
> > [ ... ]
> >
> > Fixes: 9fd4dcece43a ("debugfs: prevent access to possibly dead file_operations at file open")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v1 -> v2:
> >  - Fix compile error
> >
> >  fs/debugfs/file.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > index 634b09d18b77..e3075389fba0 100644
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -175,8 +175,13 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
> >       if (r)
> >               goto out;
> >
> > -     real_fops = fops_get(real_fops);
> > -     if (!real_fops) {
> > +     if (!fops_get(real_fops)) {
> > +#ifdef MODULE
> > +             if (real_fops->owner &&
> > +                 real_fops->owner->state == MODULE_STATE_GOING)
> > +                     goto out;
> > +#endif
>
> Why is this in a #ifdef?
>
> The real_fops->owner field will be present if MODULE is not enabled,
> right?  Shouldn't this just work the same for that case?
>

The reason for the #ifdef is to avoid compile error
MODULE_STATE_GOING is defined if CONFIG_MODULES is enabled.
So, If the #ifdef doesn't exist, compile will errors.
But honestly, I'm not sure whether CONFIG_MODULES should be used
here instead of MODULE or not.

> thanks,
>
> greg k-h

Thank you!
Taehee Yoo
