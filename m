Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB93420C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCSPVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhCSPVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:21:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90120C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 08:21:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so9509526wrd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHMAhBAQOpphLRREZJlNVL6uBoRegoHiEupgJ4ClwKw=;
        b=BeQ/Y7G9PKlLSgTvrVqTbv9UYOwFvwQV2vCiiXKrpFdx48ue4RJWqK2E5Y3hZBX0Zc
         cRVLYAI4PKFcOpaD8KDxYlQVbGKLLSC0XGuySmfIV1xJ7P3J7gkrsggRSyd7n/GhIvwp
         Csf/+kj/SYoazFwU7t7Q+PMp29QGE0HTy8GowqGzTWMGtmcdsgOSiiJK2e1maqB05JUv
         P/68MkGcd14W8EKxbJzg0rkb/bmuYLW/u9JDDRIBwfb1p4BPkcyLEFBQ6UsCobSzKv2y
         jmHkj/KS5zKOJsKRl8B0siydrMFBIJ+hQmh2zfkZYZmMkoJeC/G6cAf2hs96B7ZL8DZu
         zSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHMAhBAQOpphLRREZJlNVL6uBoRegoHiEupgJ4ClwKw=;
        b=I3gbLMLvpQaQdxcMZE+TyuEg3y85VO6STmObYv4T3Bq0gBLdPSf7kWa+omWR2sk55b
         yL9bBm0PHxGc9vpk51G0sQRrVbNtpkmi5K6mwcgc36beIlJI43Yay63veiy0ln6IRF5d
         gB1D35YitjLSDq3N+SfnU9OA+s8zQdsNqHTDwK1T+krVf8vB8oaK5sbtFp0VglNCkB1y
         IPZO+eboJ+ji42goT8z/Es3KIJPaaCqaZoXOOPBihUYBRnGyjoOVXd5Kz7C1Ef5HrQve
         KIcHDLBVv3A4wn8QeVZgMY9NDBmVmOyH7wfmumOMde8ZYDiFG8GYfj3vgAmYrwO0zjBY
         4tgw==
X-Gm-Message-State: AOAM530U15hlW1A+PF05CfRh1Z+bG0vjQkQMaaarI2e88tunabLc1tCp
        As1aWDUBHT0fpfm/vqGlSAaVag==
X-Google-Smtp-Source: ABdhPJzpd//qGkoZOkBXxWlfCTANMCBbP+Zjg7e/uHwpznDUuHjsxQ6xjLoT+rNA0RUU8Bvw9l8prg==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr5097586wrw.351.1616167294369;
        Fri, 19 Mar 2021 08:21:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:d49c:45f3:9d86:b2e9])
        by smtp.gmail.com with ESMTPSA id 13sm6777119wmw.5.2021.03.19.08.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:21:34 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:21:32 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net,
        Android Kernel Team <kernel-team@android.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
Message-ID: <YFTBfKslrZsHYQPi@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-3-balsini@android.com>
 <CAK8P3a2VDH9-reuj8QTkFzbaU9XTUEOWFCmCVg1Snb6RjD6mHw@mail.gmail.com>
 <YFN8IyFTdqhlS9Lf@google.com>
 <CAK8P3a36ToSbvW1F_0w0gCiWGCoZgFwoLHmQ7Tz2jtwV++VrWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a36ToSbvW1F_0w0gCiWGCoZgFwoLHmQ7Tz2jtwV++VrWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:15:43PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 18, 2021 at 5:13 PM Alessio Balsini <balsini@android.com> wrote:
> > On Tue, Mar 16, 2021 at 07:53:06PM +0100, Arnd Bergmann wrote:
> > > On Mon, Jan 25, 2021 at 4:48 PM Alessio Balsini <balsini@android.com> wrote:
> > > >
> >
> > Thanks for spotting this possible criticality.
> >
> > I noticed that 32-bit users pace was unable to use the
> > FUSE_DEV_IOC_CLONE ioctl on 64-bit kernels, so this change avoid this
> > issue by forcing the kernel to interpret 32 and 64 bit
> > FUSE_DEV_IOC_CLONE command as if they were the same.
> 
> As far as I can tell from the kernel headers, the command code should
> be the same for both 32-bit and 64-bit tasks: 0x8004e500.
> Can you find out what exact value you see in the user space that was
> causing problems, and how it ended up with a different value than
> the 64-bit version?
> 
> If there are two possible command codes, I'd suggest you just change
> the driver to handle both variants explicitly, but not any other one.
> 
> > This is the simplest solution I could find as the UAPI is not changed
> > as, as you mentioned, the argument doesn't require any conversion.
> >
> > I understand that this might limit possible future extensions of the
> > FUSE_DEV_IOC_XXX ioctls if their in/out argument changed depending on
> > the architecture, but only at that point we can switch to using the
> > compat layer, right?
> >
> > What I'm worried about is the direction, do you think this would be an
> > issue?
> >
> > I can start working on a compat layer fix meanwhile.
> 
> For a proper well-designed ioctl interface, compat support should not
> need anything beyond the '.compat_ioctl = compat_ptr_ioctl'
> assignment.
> 
>        Arnd

You are right and now I can see what happened here.

When I introduce the PASSTHROUGH ioctl, because of the 'void *', the
command mismatches on _IOC_SIZE(nr). I solved this by only testing
_IOC_NUMBER and _IOC_TYPE, implicitely (mistakenly) removing the
_IOC_SIZE check.  So, the fuse_dev_ioctl was correctly rejecting the
ioctl request from 32-bit userspace because of the wrong size and I was
just forcing it to digest the wrong data regardless.
Ouch!

The commit message for this patch would still be incorrect, but I posted
a fix here to bring the ioctl checking back to the original behavior:

  https://lore.kernel.org/lkml/20210319150514.1315985-1-balsini@android.com/

Thanks for spotting this!
Alessio

