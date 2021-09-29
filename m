Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96E41CC93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbhI2T2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbhI2T2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:28:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43CC061765
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 12:26:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g2so2828402pfc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qyIj0uuuYD2n22GzyP1Tp1qkKngJHlSoFNMFwTLRsyo=;
        b=IvkOeEHVGJn8g4QIoGZC5vJvMkA5is7yCkwEyLBjjfmXJVSDFA8w0vX4YiJxFjA7i4
         klUZfu4GPqbcWaHx1Dtb7yBc/ZL6pq2CwDTZmCAslYr4EzPvMFGYDGnNSeU0eGyM5Yv3
         7SXpxQbn3QwzsGeAaJoMYXHsmtw9YlKOLdthA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyIj0uuuYD2n22GzyP1Tp1qkKngJHlSoFNMFwTLRsyo=;
        b=PdRJho8BqlFaBahZpwXvhE0lZbVLf7I0krcBAlFeoCxNlE50hLACeXmOULUQguImJg
         Pwe/O+b4XPlirWrgStxTcDbaAWshDeVTKIOlFYCD3LR+kdUhoRXfjTe1R0xr5TElhwKj
         2ACMgrnAd1AUyIXYyNHZClLIe5Zb22qCsF94dbgnecxBhytzDm73svkQn9o1xbtVdx+r
         AnZro6IlmXA8SlbjK6lgS8rmEliHXvCp+IiT0Ry1YJd5cBIl9WAh7FCBKj6mllT2Bm3h
         ZsfNICzhbmrq9L4u3W7JvFfJQJ5tLpmtandn8voRY8R/IFB/7vtQyeRsFQo2XFiiBts1
         XcZQ==
X-Gm-Message-State: AOAM533ijQAACVlYAV0kJHlTYQ+GNIz2p0HcPLPtyCzOy2RmPU/mySbC
        ZX9uPO5mkrVLYweCQ8+MvP+dCg==
X-Google-Smtp-Source: ABdhPJzpu7EKgHxN8BtF9vP2GWOOxpRr41KUz4wIy1cMVPxpf6sAaY3N3efZp44d3yxahyNaa6T8lA==
X-Received: by 2002:a62:5297:0:b0:3f4:263a:b078 with SMTP id g145-20020a625297000000b003f4263ab078mr397109pfb.20.1632943592305;
        Wed, 29 Sep 2021 12:26:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm415376pju.33.2021.09.29.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:26:31 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:26:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109291224.8C538667@keescook>
References: <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
 <202109291152.681444A135@keescook>
 <20210929190042.GU4199@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929190042.GU4199@sirena.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 08:00:42PM +0100, Mark Brown wrote:
> On Wed, Sep 29, 2021 at 11:54:55AM -0700, Kees Cook wrote:
> > On Mon, Sep 27, 2021 at 01:50:56PM -0700, Josh Poimboeuf wrote:
> 
> > > Even with that patch, it doesn't lock the task's runqueue before reading
> > > the stack, so there's still the possibility of the task running on
> > > another CPU and the unwinder going off the rails a bit, which might be
> > > used by an attacker in creative ways similar to the /proc/<pid>/stack
> > > vulnerability Jann mentioned earlier.
> 
> > Since I think we're considering get_wchan() to be slow-path, can we just
> > lock the runqueue and use arch_stack_walk_reliable()?
> 
> Unfortunately arch_stack_walk_reliable() is only available for powerpc,
> s390 and x86 currently - work is in progress to implement it for arm64
> as well but it's not there yet.

Strictly speaking, we're only trying to fix this for x86+ORC. The other
architectures (or non-ORC x86) already have their own non-ORC unwinders
behind get_wchan(). They may have similar weaknesses (which should
certainly be fixed), I think the first step here is to restore wchan
under x86+ORC.

-- 
Kees Cook
