Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CE41DD36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbhI3PUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245398AbhI3PUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:20:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F3AC06176C
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 08:18:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so6565704pgr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/xgE/Y55JRJKfdAPlV0ukAj6bmYdIAVihPBePNuMEA=;
        b=Z2IgmXvUaFEXY7MoioDiKe6ZZXF3Bz9nLqLBxBra5B6yYSfjaV6O3KO7hSmCQCYZwn
         AJym7zohhwCmLwm3Ggn4jIJhrIwFaKsw7T0/Byaoj/Q4zb48yyrzljuLX9WGvrE8k0xl
         YrDcPGeqFNU/vPgzQWAb2nzuj9yniB4QbcaIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/xgE/Y55JRJKfdAPlV0ukAj6bmYdIAVihPBePNuMEA=;
        b=pWWVXgcTPjQaRn8pgtFXy0HPLiMJZPsOo8xuRM91e+BACoDhAn76eKLfyKVlg/kWOX
         ShMSNKfbefhr96/ittW3QbZqLCYprlkaILMDhlOns0sgJaLmygflDqzWIJfQw3hE/VaR
         A4VVVpaO7GGsqfjKNlMGp/+hW6K2ZxLiO/jhVGza/V5odTtXgi9eR9MZ4HvEtuRLL6Tv
         50HU0vwI2kgeJkuhvWl2NoHTnUADmvDJNkWB9GygjVpvEYetK7qNPv4puZlrLCnI4+d1
         8q+Ucytbxf/uk5z5yeIsdUCOdIJqN6ELzST8FW2tWhHjCBkE4CyQkTw6/7qrKDm0L+8v
         hkwA==
X-Gm-Message-State: AOAM533pxd0c05Frdz+AzCq5ZlqogswrmLlL1FCSuiY6u/rxqfQbvkZI
        j9Yq5zENZQi+qD4CKfVfue82/w==
X-Google-Smtp-Source: ABdhPJx9xd/CgJ2K56cg1nMviMwyZqmS6824yDtPEv7b6XWoioc9YvVjIpGU29bL2HCgdp9tPKZPhw==
X-Received: by 2002:a63:1a64:: with SMTP id a36mr5432550pgm.225.1633015116124;
        Thu, 30 Sep 2021 08:18:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c22sm3022703pja.10.2021.09.30.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:18:35 -0700 (PDT)
Date:   Thu, 30 Sep 2021 08:18:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/6] wchan: Fix ORC support and leaky fallback
Message-ID: <202109300817.36A8D1D0A@keescook>
References: <20210929220218.691419-1-keescook@chromium.org>
 <20210930010157.mtn7pjyxkxokzmyh@treble>
 <YVV36z4UZaL/vOBI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVV36z4UZaL/vOBI@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:40:11AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 29, 2021 at 06:01:57PM -0700, Josh Poimboeuf wrote:
> 
> > - Should we use a similar sched wrapper for /proc/$pid/stack to make its
> >   raciness go away?
> 
> Alternatively, can we make /stack go away? AFAICT the semantics of that
> are far worse in that it wants the actual kernel stack of a task,
> blocked or not, which is a total pain in the arse (not to mention a
> giant infoleak and side-channel).
> 
> > - At the risk of triggering a much larger patch set, I suspect
> >   get_wchan() can be made generic ;-)  It's just a glorified wrapper
> >   around stack_trace_save_tsk().
> 
> Done that for you :-)

Thanks! I wasn't sure the renaming was worth the churn, but the other
cleanups make it much nicer. :)

Do you want me to re-collect the resulting series, or do you have a tree
already for -tip for this?

-Kees

-- 
Kees Cook
