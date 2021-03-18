Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5343409CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhCRQNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhCRQN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:13:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA2C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 09:13:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so3728700wmj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BINIGwJxwGmOwEiPbRzuCVVu9BcgGBArfEIZAsM96Eo=;
        b=PJyzt0TQAZ6q+XU89v8X2lZwTXRSjsGBr+roWlDXFOCw/q7BkcPc9KKR9l3+EBKput
         BOBLc/wttyIbmktCUuPGof6wydF/xyMXMFU1emN7DYvAdztIqufIGIwExca8SlLseDtq
         uTEc0LZEE68/QpDM0rEjPP+1WuZxmzceuYPX6tEyVf/2o5Ol1lF3BDb2aRaFFS9rSo0a
         HsC9n9pOeJtnWPS2t50tj1R8uLt4Rn1dDcEb7PubZ4XhvWufHicBFN9eGsAGliQbVPKE
         FNLXqByAUPPT91tPyTpNOzClHDMZJDcn3Th3cyLF/vNEXQ3y2mwtpOCN7uasBirnelYi
         WYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BINIGwJxwGmOwEiPbRzuCVVu9BcgGBArfEIZAsM96Eo=;
        b=nK+MzGKbAHmeG8HGLm3wiNpKQWZOvEAp2yEc9DpfWHuXdEGRAoi0c+hnH6ux4xwiFo
         eyo5n4kocgNU5BpyvW9StkpOYzBawP8napeGD4aHER4MVOdYM4drphpzeteq+0JUg/yi
         ix/w4OnUHTmel1W59Kuoo0RJEXdAk8kQPFPNEGXPA7SZbt4xf92aWCP/hl+Pm55CkXf6
         7bcyBIS8fmR43UwX/bnbQlrwBj52f1RpG6Lk4J0/LDYWQ8GlyY7pgWBayLfmwQdWM+qz
         pTfhR141JY6yki2mcAiPb9WfbZfQOUa9N9IdxxPoqnXylrX5xv4975qFcTU/mA7/51Iy
         6QzQ==
X-Gm-Message-State: AOAM532bm1ktL696iNS06BGS5IVu2he0b9QORYvSXnEjvY6aW3GjN2Lh
        +rqFFdZwJId19xDXt5Z9HOWPQw==
X-Google-Smtp-Source: ABdhPJzOvlozfcDMp/H97oOOn9jII/km2GNy6th7b2R4rgD2EHECWXAk7TZKijGyZkpLQ7XhVdp//A==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr11269wml.103.1616084005261;
        Thu, 18 Mar 2021 09:13:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:d49c:45f3:9d86:b2e9])
        by smtp.gmail.com with ESMTPSA id t188sm3042384wma.25.2021.03.18.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:13:24 -0700 (PDT)
Date:   Thu, 18 Mar 2021 16:13:23 +0000
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
Message-ID: <YFN8IyFTdqhlS9Lf@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-3-balsini@android.com>
 <CAK8P3a2VDH9-reuj8QTkFzbaU9XTUEOWFCmCVg1Snb6RjD6mHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2VDH9-reuj8QTkFzbaU9XTUEOWFCmCVg1Snb6RjD6mHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 07:53:06PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 25, 2021 at 4:48 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > With a 64-bit kernel build the FUSE device cannot handle ioctl requests
> > coming from 32-bit user space.
> > This is due to the ioctl command translation that generates different
> > command identifiers that thus cannot be used for direct comparisons
> > without proper manipulation.
> >
> > Explicitly extract type and number from the ioctl command to enable
> > 32-bit user space compatibility on 64-bit kernel builds.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> 
> I saw this commit go into the mainline kernel, and I'm worried that this
> doesn't do what the description says. Since the argument is a 'uint32_t',
> it is the same on both 32-bit and 64-bit user space, and the patch won't
> make any difference for compat mode, as long as that is using the normal
> uapi headers.
> 
> If there is any user space that has a different definition of
> FUSE_DEV_IOC_CLONE, that may now successfully call
> this ioctl command, but the kernel will now also accept any other
> command code that has the same type and number, but an
> arbitrary direction or size argument.
> 
> I think this should be changed back to specifically allow the
> command code(s) that are actually used and nothing else.
> 
>        Arnd

Hi Arnd,

Thanks for spotting this possible criticality.

I noticed that 32-bit users pace was unable to use the
FUSE_DEV_IOC_CLONE ioctl on 64-bit kernels, so this change avoid this
issue by forcing the kernel to interpret 32 and 64 bit
FUSE_DEV_IOC_CLONE command as if they were the same.
This is the simplest solution I could find as the UAPI is not changed
as, as you mentioned, the argument doesn't require any conversion.

I understand that this might limit possible future extensions of the
FUSE_DEV_IOC_XXX ioctls if their in/out argument changed depending on
the architecture, but only at that point we can switch to using the
compat layer, right?

What I'm worried about is the direction, do you think this would be an
issue?

I can start working on a compat layer fix meanwhile.

Thanks,
Alessio
