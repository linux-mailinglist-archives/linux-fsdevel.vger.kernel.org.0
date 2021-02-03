Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EE30D763
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 11:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhBCKY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 05:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhBCKYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:24:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78980C0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 02:23:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u14so4636122wmq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 02:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YVcGpKd8+eC2YQ5xYyo7fYllHOO2iPEn0qmRLD8c4tk=;
        b=XcTmJyWd74nvKmKqGb0lHYbm4BberuwObLIrEVZVDU5MFPGSgRvwBVl691DtsVL32v
         PoxSztsiW9kqnY7fWODTxJQ24Xut19EQmALlq/oOlmCC/lE28uXGaC0MT/lTB3vpqnHz
         OO6YtZ53iIHcnPn/3H7K8/Ji389pkKLCfJXYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YVcGpKd8+eC2YQ5xYyo7fYllHOO2iPEn0qmRLD8c4tk=;
        b=DKOpE+4eJfb1mdeqIoqQlG2VSskwTx8rsk0u61sUpgNDJC73kME04aQQFuZNxNjBmz
         Q9FD4H4qMuFiSFJQC+hp95EnvEbGQsvOL1L1aiAeSUfJz28McxkzHmbJYieiKLs4sZyM
         we0Ko4dfiC+rbkxETIRiyxn+6Gf0hncVWsDtlcEYxitoWY3gekWSC1CY2fUGGSDR+oGH
         uR2GJiQfVnbcF4X70mLQllQNF4S4krfV/yEVgCCwgqujybhZcX25ctH3SeqUDNOTufC8
         TCE7B44yeCRyOH+4cTbcG2wuLRgXUv9WLbPg6dLFzxhXhwYPZ/TS1dAX6mdSvfBA+fJ9
         wZ1Q==
X-Gm-Message-State: AOAM533ouwzsPnaMFgLgL2mb4igaY7jZ6W0p2dUaT8il6dZVMB00G4ah
        5lOSrI5/VfQJIp5561i2KLDq6g==
X-Google-Smtp-Source: ABdhPJwiI5aD5dqY1ckorWBWkPtWhv80Z2HTWzG7jeWjpVya/U1sTYHLj7xvi3ENjtXKYY1O+EVTCA==
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr1325153wmj.138.1612347823070;
        Wed, 03 Feb 2021 02:23:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b3sm2351907wme.32.2021.02.03.02.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:23:42 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:23:39 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        dri-devel@lists.freedesktop.org, Andrei Vagin <avagin@gmail.com>,
        Kalesh Singh <kaleshsingh@google.com>, Hui Su <sh_def@163.com>,
        Michel Lespinasse <walken@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        kernel-team <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
Message-ID: <YBp5qzLBBMJE0Yhn@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        dri-devel@lists.freedesktop.org, Andrei Vagin <avagin@gmail.com>,
        Kalesh Singh <kaleshsingh@google.com>, Hui Su <sh_def@163.com>,
        Michel Lespinasse <walken@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        kernel-team <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20210126225138.1823266-1-kaleshsingh@google.com>
 <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
 <YBFG/zBxgnapqLAK@dhcp22.suse.cz>
 <ea04b552-7345-b7d5-60fe-7a22515ea63a@amd.com>
 <20210128120130.50aa9a74@eldfell>
 <c95af15d-8ff4-aea0-fa1b-3157845deae1@amd.com>
 <20210129161334.788b8fd0@eldfell>
 <wgUb8smQArgjbRFYMPYVDmukBT-_BrqG2M6XIOkWdBcW_x-m4ORnl3VOvH3J4wrsNGMoOXqMAro0UmkdVXFNso9PEiNCFGEeruibhWsmU34=@emersion.fr>
 <f680ced7-3402-4a1e-4565-35ad7cd0c46d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f680ced7-3402-4a1e-4565-35ad7cd0c46d@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 03:22:06PM +0100, Christian König wrote:
> Am 29.01.21 um 15:17 schrieb Simon Ser:
> > On Friday, January 29th, 2021 at 3:13 PM, Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > 
> > > > Re-importing it adds quite a huge CPU overhead to both userspace as well
> > > > as the kernel.
> > > Perhaps, but so far it seems no-one has noticed the overhead, with Mesa
> > > at least.
> > > 
> > > I happily stand corrected.
> > Note, all of this doesn't mean that compositors will stop keeping
> > DMA-BUF FDs around. They may want to keep them open for other purposes
> > like importing them into KMS or other EGL displays as needed.
> 
> Correct and that's a perfectly valid use case. Just re-importing it on every
> frame is something we should really try to avoid.
> 
> At least with debugging enabled it's massive overhead and maybe even
> performance penalty when we have to re-create device page tables all the
> time.
> 
> But thinking more about that it is possible that we short-cut this step as
> long as the original import was still referenced. Otherwise we probably
> would have noticed this much earlier.

Yeah kernel keeps lots of caches around and just gives you back the
previous buffer if it's still around. Still probably not the smartest
idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
