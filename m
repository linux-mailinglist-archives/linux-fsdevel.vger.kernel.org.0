Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F532B4B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354153AbhCCF0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839219AbhCBQGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:06:09 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F76C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 07:56:08 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so15096862qtw.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tNdOP429TQBqbFjtRfcboNnC/yDVMr5sai/pD5T/IRg=;
        b=IlpWwYdHCRDOk3kWpi+d9K5sL2BkH9JZ1CEz1ZKimdPVIRwTuGRq3u8IVkuopTydJj
         arkp2Jdxkb6AEwpjHEzEBCdWsa3q3RVDDAD6bSnR4o1EyuK4taQfQjgDPmaAJ9E1rc7M
         d4jHzAyynuq2BzJCokhaQdMM8AN7WuMyNhHQlCWn80oKplc03XM+gFnGwD3Z51x4lbml
         2TCJwmgtS2OfBFJdEHlD5w8ufPSSU3VTgvHICNQAxeKAsegXHKO2hfv/m04PEbTEcSNF
         E3mw5ycnDw+JDvecUfy1I1YGGLn5VeegekbNe2l96F37r1kFSVfRi5rflI3VL2KtZugd
         9xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNdOP429TQBqbFjtRfcboNnC/yDVMr5sai/pD5T/IRg=;
        b=enAg8Qbbvr22vnQv3ltU261HHFQImmli1nF8RP0rfvHy33+/78+r4pKThc27Ijxq18
         Y8QZxMQW5rEXBm9ST7OE6Iz6zbs5DnbQSqNUMjYbekzIZN8tKMod4ipKbCw/WiqHcMDY
         WL85mxSAbcLjCirskDQsIh845/gm2XO1CkKSZ9aD3EtH51fCTu52Ki1GNhl/lvqdx0Bl
         UCzpVCQQc9V4K04AxKrOQdaeBxXDtL0TiKw0seUjJoHaAchWg9IM0TJUFEnWoN76PCG1
         5FzZypmIol/nqeP5mJfBapA5lL+2lDf1w9edB566b1evnESDTPwRAQbF4Mo1p1gXCZ+K
         jCdA==
X-Gm-Message-State: AOAM533WulIFFPA2ogOm+g+miZtyof/f3yC/nSB7gJM/i1sEIjA9DZ6q
        oEtMIYO72cZMMt9HkvACD1KBAw==
X-Google-Smtp-Source: ABdhPJyOfWYuIhZl4tG2VoD6q45/j1mxf/N5hHiy8YupUY6yiNz/e3N1wA6PcoAeeK96MehQQtO/QA==
X-Received: by 2002:ac8:7392:: with SMTP id t18mr17887295qtp.104.1614700567462;
        Tue, 02 Mar 2021 07:56:07 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id o7sm1251394qkb.104.2021.03.02.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 07:56:06 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:56:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     pintu@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        lokeshgidra@google.com, nigupta@nvidia.com, famzheng@amazon.com,
        andrew.a.klychkov@gmail.com, bigeasy@linutronix.de,
        ping.ping@gmail.com, vbabka@suse.cz, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org, corbet@lwn.net,
        pintu.ping@gmail.com
Subject: Re: [PATCH] mm: introduce clear all vm events counters
Message-ID: <YD5gFYalXJh0dMLn@cmpxchg.org>
References: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
 <YD0EOyW3pZXDnuuJ@cmpxchg.org>
 <419bb403c33b7e48291972df938d0cae@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419bb403c33b7e48291972df938d0cae@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 02, 2021 at 04:00:34PM +0530, pintu@codeaurora.org wrote:
> On 2021-03-01 20:41, Johannes Weiner wrote:
> > On Mon, Mar 01, 2021 at 04:19:26PM +0530, Pintu Kumar wrote:
> > > At times there is a need to regularly monitor vm counters while we
> > > reproduce some issue, or it could be as simple as gathering some
> > > system
> > > statistics when we run some scenario and every time we like to start
> > > from
> > > beginning.
> > > The current steps are:
> > > Dump /proc/vmstat
> > > Run some scenario
> > > Dump /proc/vmstat again
> > > Generate some data or graph
> > > reboot and repeat again
> > 
> > You can subtract the first vmstat dump from the second to get the
> > event delta for the scenario run. That's what I do, and I'd assume
> > most people are doing. Am I missing something?
> 
> Thanks so much for your comments.
> Yes in most cases it works.
> 
> But I guess there are sometimes where we need to compare with fresh data
> (just like reboot) at least for some of the counters.
> Suppose we wanted to monitor pgalloc_normal and pgfree.

Hopefully these would already be balanced out pretty well before you
run a test, or there is a risk that whatever outstanding allocations
there are can cause a large number of frees during your test that
don't match up to your recorded allocation events. Resetting to zero
doesn't eliminate the risk of such background noise.

> Or, suppose we want to monitor until the field becomes non-zero..
> Or, how certain values are changing compared to fresh reboot.
> Or, suppose we want to reset all counters after boot and start capturing
> fresh stats.

Again, there simply is no mathematical difference between

	reset events to 0
	run test
	look at events - 0

and

	read events baseline
	run test
	look at events - baseline

> Some of the counters could be growing too large and too fast. Will there be
> chances of overflow ?
> Then resetting using this could help without rebooting.

Overflows are just a fact of life on 32 bit systems. However, they can
also be trivially handled - you can always subtract a ulong start
state from a ulong end state and get a reliable delta of up to 2^32
events, whether the end state has overflowed or not.

The bottom line is that the benefit of this patch adds a minor
convenience for something that can already be done in userspace. But
the downside is that there would be one more possible source of noise
for kernel developers to consider when looking at a bug report. Plus
the extra code and user interface that need to be maintained.

I don't think we should merge this patch.
