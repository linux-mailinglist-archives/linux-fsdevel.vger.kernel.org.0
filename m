Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0597541CC23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbhI2S4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbhI2S4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:56:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9693BC061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 11:54:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j15so2181301plh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8+uJcBBc/PF7ems2z5fw4m588jWE79HAklefzm/UZpA=;
        b=jUKnSXoA0hVODkS6t3osdG2XYk+v1gSULRVbnIZ9NcZh4ZpOliivKVPuRpp/UlzKhh
         AbAGzhdYgAFxFcXd7rtQC4jDpvDc26ThZ27hDgqIxJg/E3s6vOblrrvcj45Gi0/6cPpw
         q2WLquH9eoGvFWwMXjEu5YoLIYzPRTV+vvS4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+uJcBBc/PF7ems2z5fw4m588jWE79HAklefzm/UZpA=;
        b=qR3urM6Rz7zwNcOhqX9T4B27DbPCfnL6/HoIEN4jLAl9tuqidCT5HWBD3dnvesiXuo
         ZkuRU+eRcWNkgt9yKBj06gNv5ydWWQV2Wo6edWikRIQKz9CZqr6Baf7FsJPKH8TsrsV2
         zN3Tbvm0wBlE1yDPoFWjlezaShUIlpazuHe3EBHchdXxRSC/8e4ZllfnJ76XkHrGY5/f
         tnxRmaLtca4jCq3HPzzH6LZctwpHbrIEGDtHk2pQGlE4IOA1JXGxRGOlWziYBgHiH3gM
         oYAFeQZEuzBfEZIk695hvnhXlHD56cwt8ZFiU1yHCRtipA+JBLsz5lylxhF24W2Os2QA
         HZGg==
X-Gm-Message-State: AOAM532LEpYFOZiU8H2VfTP2L/dAbE1j3pVBvWCq9Q9P+4IZWTf2yngY
        k6m3ENIaLUfSpUSB4UJ2mzpTyg==
X-Google-Smtp-Source: ABdhPJzMCh/F5SF+Yhv5xgUAe1RpRTKX6R9v+nOxJt1NfhIE0v6dfSR2DW4sq15+zE5QfL0u0Kpdvg==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr8095556pje.124.1632941697076;
        Wed, 29 Sep 2021 11:54:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c206sm480031pfc.220.2021.09.29.11.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:54:56 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:54:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <202109291152.681444A135@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927205056.jjdlkof5w6fs5wzw@treble>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 01:50:56PM -0700, Josh Poimboeuf wrote:
> On Mon, Sep 27, 2021 at 11:07:27AM -0700, Kees Cook wrote:
> > On Mon, Sep 27, 2021 at 10:03:51AM +0100, Mark Rutland wrote:
> > > On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> > > > On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > > > > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > > > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > > > > entrypoint address in the current task struct for get_wchan() to
> > > > > > > access, whenever userspace enters the kernel?
> > > > > > 
> > > > > > wchan is supposed to show where the kernel is at the instant the
> > > > > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > > > > always show syscall entry.)
> > > > > 
> > > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > > channel".
> > > > > 
> > > > > I'd wanted to remove get_wchan since it requires cross-task stack
> > > > > walking, which is generally painful.
> > > > 
> > > > Right -- this is the "fragile" part I'm worried about.
> > 
> > I'd like to clarify this concern first -- is the proposed fix actually
> > fragile? Because I think we'd be better off just restoring behavior than
> > trying to invent new behavior...
> > 
> > i.e. Josh, Jann, do you see any issues with Qi Zheng's fix here:
> > https://lore.kernel.org/all/20210924062006.231699-4-keescook@chromium.org/
> 
> Even with that patch, it doesn't lock the task's runqueue before reading
> the stack, so there's still the possibility of the task running on
> another CPU and the unwinder going off the rails a bit, which might be
> used by an attacker in creative ways similar to the /proc/<pid>/stack
> vulnerability Jann mentioned earlier.

Since I think we're considering get_wchan() to be slow-path, can we just
lock the runqueue and use arch_stack_walk_reliable()?

-- 
Kees Cook
