Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD5619F2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiKDRr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 13:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKDRrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:47:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2943ADA
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 10:47:29 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f4-20020a056830264400b0066c8e56828aso1355418otu.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzwkoj7JXHtMhWN4DfTU8EyhRhWaurFQtea70WyaR28=;
        b=qtt5aqGaqy3QiMpQ1mTCB/HnYZ4F/omMkTgFT0lIRoa4m9PImNOCRSVO8mZ2/m6KhY
         8jy59YD/wONiVgml7HmAu8Lv7BduS90yA3Ad+lRr8MMwggOtTfErPhpnKA89YtR42bwE
         0UXUEbrj5yj2R7ikly+6fQkKYRkZ6VppgM43VIDmnIYQVfHNncbDD4Oens7WT8jxc9xg
         vb+Z+5aWCEcmkdPKMnWmvBgLfvHCdRU1Fm+fuSy5yrGcAreUjliqyhvinWbrDbyH10Yz
         DPQk+fYx+D1lKGn31C1DYVLUUoxLFILLApcvYRweEdSAj4tEiUTznm1TYWzFCilFGs7H
         lxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzwkoj7JXHtMhWN4DfTU8EyhRhWaurFQtea70WyaR28=;
        b=gPbZTqO/+TeYXkj8kqn9Jwwazg+9V58c8oS8m1Vz3uayx9PCVRJtPSLtlM1M2D8aiA
         LtqLQGkqW6BG1IM7tfr96LSCh6G0T7lZ1Wwtt179pRp0W9QQalnZopNCHHAH2d6/O5Tk
         rvjSRpvLO91Bc8wTTUrtb9yjb10i7z6WYwjKpIZVSv5RYbVN6ZB3b8zZkUAJ+RZoFKsi
         wftbgrFTVXF8pC+uB9+E5GSoBESdEuByTzLJ5prAJviBHXQLI7glEU/iOohj+R5tyGIS
         +JNnPVnZwwEHP2dHuBLSxzUvQwM2Dj3F3ZNemtY1+S5TPf5vowzXg/nrMboRKVE+oAUs
         5vFA==
X-Gm-Message-State: ACrzQf3m09oVVPZ+kl8SAPtAF9JlpKfpwU5mf0A+dfGXwXQwXICm0ykN
        G9ZKkzi9m4yB6FeC82wnvPtkxNMVwpRqoYJlPwIWvw==
X-Google-Smtp-Source: AMsMyM7JXoNySD6/C/8Kk+HBoUYqhxXSlv8xwi6EoSDELgUMEhqvCO5BCTSqf0GwMRYVTcnOhozbFZJAxj/uWxd/6S0=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr13851499otk.269.1667584048831; Fri, 04
 Nov 2022 10:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QR0EDvq7p9i1xw@nvidia.com> <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com> <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com>
In-Reply-To: <Y2RbCUdEY2syxRLW@nvidia.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 10:47:17 -0700
Message-ID: <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
Subject: Re: xarray, fault injection and syzkaller
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 iOn Thu, 3 Nov 2022 at 17:21, 'Jason Gunthorpe' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, Nov 03, 2022 at 05:11:04PM -0700, Dmitry Vyukov wrote:
> > On Thu, 3 Nov 2022 at 13:07, 'Jason Gunthorpe' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Thu, Nov 03, 2022 at 08:00:25PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Nov 03, 2022 at 04:09:04PM -0300, Jason Gunthorpe wrote:
> > > > > Hi All,
> > > > >
> > > > > I wonder if anyone has some thoughts on this - I have spent some time
> > > > > setting up syzkaller for a new subsystem and I've noticed that nth
> > > > > fault injection does not reliably cause things like xa_store() to
> > > > > fail.
> >
> > Hi Jason, Matthew,
> >
> > Interesting. Where exactly is that kmalloc sequence? xa_store() itself
> > does not have any allocations:
> > https://elixir.bootlin.com/linux/v6.1-rc3/source/lib/xarray.c#L1577
>
> The first effort is this call chain
>
> __xa_store()
>   xas_store()
>     xas_create()
>      xas_alloc()
>       kmem_cache_alloc_lru(GFP_NOWAIT | __GFP_NOWARN)
>
> If that fails then __xa_store() will do:
>
> __xa_store()
>   __xas_nomem()
>       xas_unlock_type(xas, lock_type);
>       kmem_cache_alloc_lru(GFP_KERNEL);
>       xas_lock_type(xas, lock_type);
>
> They key point being that the retry is structured in a way that allows
> dropping the spinlocks that are forcing the first allocation to be
> atomic.

I see. Yes, as you note below, this cannot be folded into a single
allocation call.

> > Do we know how common/useful such an allocation pattern is?
>
> I have coded something like this a few times, in my cases it is
> usually something like: try to allocate a big chunk of memory hoping
> for a huge page, then fall back to a smaller allocation
>
> Most likely the key consideration is that the callsites are using
> GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
> NOWARN case assuming that another allocation attempt will closely
> follow?

GFP_NOWARN is also extensively used for allocations with
user-controlled size, e.g.:
https://elixir.bootlin.com/linux/v6.1-rc3/source/net/unix/af_unix.c#L3451

That's different and these allocations are usually not repeated.
So looking at GFP_NOWARN does not look like the right thing to do.


> > If it's common/useful, then it can be turned into a single kmalloc()
> > with some special flag that will try both allocation modes at once.
>
> A single call doesn't really suit the use cases..
>
> > Potentially fail-nth interface can be extended to accept a set of
> > sites, e.g. "5,7" or, "5-100".
>
> For my purposes this is possibly Ok, you'd just set N->large and step
> N to naively cover the error paths.

Filed https://bugzilla.kernel.org/show_bug.cgi?id=216661 for this.

> However, this would also have to fix the obnoxious behavior of fail
> nth where it fails its own copy_from_user on its write system call -
> meaning there would be no way to turn it off.

Oh, interesting. We added failing of copy_from/to_user later and did
not consider such interaction.
Filed https://bugzilla.kernel.org/show_bug.cgi?id=216660 for this.

> > > > Hahaha.  I didn't intentionally set out to thwart memory allocation
> > > > fault injection.  Realistically, do we want it to fail though?
> > > > GFP_KERNEL allocations of small sizes are supposed to never fail.
> > > > (for those not aware, node allocations are 576 bytes; typically the slab
> > > > allocator bundles 28 of them into an order-2 allocation).
> >
> > I hear this statement periodically. But I can't understand its
> > status. We discussed it recently here:
>
> I was thinking about this after, and at least for what I am doing it
> doesn't apply. All the allocations here are GFP_KERNEL_ACCOUNT and the
> cgroup can definitely reject any allocation at any time even if it is
> "small"
>
> So I can't ignore allocation failures as something that is unlikely. A
> hostile userspace contained in a cgroup sandbox can reliably trigger
> them at will.
>
> Jason
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/Y2RbCUdEY2syxRLW%40nvidia.com.
