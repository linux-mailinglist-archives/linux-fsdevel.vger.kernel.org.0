Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F364176C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbhIXO16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbhIXO16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:27:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A7C06161E
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 07:26:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 5so6596260plo.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGzzGbeOeLEORaxwOD7BLDmEH+a0amSJ/nYoDh8OWO0=;
        b=FGOqdb8Wc6HM1sjK/2fbXMNHDvLwKPUuowC529hVtm8I6s3/4QxQ1YBVBPiENwD5cf
         MLK8nggL/D+kCwp/GZZaFYbBbBGuqWUwxJeHpm+2nwMZzck6aP11onhvZEBmpcVEVK8c
         YOS4HwQtsAu3rZGTzfjU2+fJz4DuOZxiWFrE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGzzGbeOeLEORaxwOD7BLDmEH+a0amSJ/nYoDh8OWO0=;
        b=xz0WilNIpLNE5cmr+0UHwfcktwKX2J5aNPBrg9IP/B5YJx/hs0bHRswzyi/iLELldX
         4j29eATwGHADLbBgqG5QzThb7UUPvnchoaAGtwnkbpuyEYjOCUzKGbkhpqrTSiRcWyL8
         KKhRam7SyVtGkEL255Acfpf/Jl8YSdBR3eOEhhlVaopFlBdCcB4AhRwBFAFMuj3wMOzM
         hD6E2Y1Ks0oDU2OaUW9jFp1ewiuS2DMrefDqQy0I1PVzytJCB2rRapufKQvch1F/JMUy
         LgqXr/yeHbytuMCpGHWrNHpP3IdfBScWxXy4NDn072DC2lsZ1BUCWVHA7xNcul1RM8f7
         tivg==
X-Gm-Message-State: AOAM532Fs1DtslZ1z6zpHjuuzdIEqCuBS37/xNEo/KAt61DYGbzXlejH
        ugZbecWteU21+MFgWRgi+yzi+Q==
X-Google-Smtp-Source: ABdhPJz07BWVVjhirIskBAi83rmTvlhUeoG7P547BlYgytzb5ayVQrWhQOHZumT2qg1rFa/0cZwbEw==
X-Received: by 2002:a17:902:c948:b0:13a:345c:917c with SMTP id i8-20020a170902c94800b0013a345c917cmr9245252pla.61.1632493584372;
        Fri, 24 Sep 2021 07:26:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm8893038pfh.213.2021.09.24.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:26:23 -0700 (PDT)
Date:   Fri, 24 Sep 2021 07:26:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Vito Caputo <vcaputo@pengaru.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109240716.A0792BE46@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924135424.GA33573@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > entrypoint address in the current task struct for get_wchan() to
> > > access, whenever userspace enters the kernel?
> > 
> > wchan is supposed to show where the kernel is at the instant the
> > get_wchan() happens. (i.e. recording it at syscall entry would just
> > always show syscall entry.)
> 
> It's supposed to show where a blocked task is blocked; the "wait
> channel".
> 
> I'd wanted to remove get_wchan since it requires cross-task stack
> walking, which is generally painful.

Right -- this is the "fragile" part I'm worried about.

> We could instead have the scheduler entrypoints snapshot their caller
> into a field in task_struct. If there are sufficiently few callers, that
> could be an inline wrapper that passes a __func__ string. Otherwise, we
> still need to symbolize.

Hmm. Does PREEMPT break this?

Can we actually use __builtin_return_address(0) in __schedule?

-- 
Kees Cook
