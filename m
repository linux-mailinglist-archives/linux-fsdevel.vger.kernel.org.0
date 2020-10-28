Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216CE29E224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgJ2CLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 22:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgJ1VhX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:23 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4F9247FA;
        Wed, 28 Oct 2020 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603908114;
        bh=kiVbbIoq2NdlzdJ/a20eGyFOEh2S7Tm7JiSgSH7L1gs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l7oGWJwqBvK8Rg4cu7Y18e3LMzQH14enibKpL4bF5FU9phHHNDzO6IqifKx9gDuyU
         +QOI9cMNrtaIEKc0iVIXsznlb2ho17nUvDhSpciib7ryuCq0uApBJ/tFW2HRlDamgb
         yOlAmE1Dv53mFSCQu/wGHaE8mkik3eSKxCsefF8c=
Received: by mail-qk1-f174.google.com with SMTP id x20so5406931qkn.1;
        Wed, 28 Oct 2020 11:01:54 -0700 (PDT)
X-Gm-Message-State: AOAM532PCEE/M94xfOgBWSINTmaMTcwMQyvtcNxwEPQCri1OGxUe4Lir
        mIX7uQjWkgIKcDaYypOxkxn0kot10uRwbJ7SnNA=
X-Google-Smtp-Source: ABdhPJymgITjNtW7EeX+umApAD4Vf02rqbitm4Ker4JECaOsBTLrlUusKrdjstVTwMYn8ocHZ9ykxsfWXhzFPmaBCLw=
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr35387qkg.3.1603908113213;
 Wed, 28 Oct 2020 11:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
 <20201027085152.GB10053@infradead.org> <CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com>
 <b3a8e2e8-350f-65af-9707-a6d847352f8e@redhat.com>
In-Reply-To: <b3a8e2e8-350f-65af-9707-a6d847352f8e@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 28 Oct 2020 19:01:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0C5qUguxg446iuvaHm0D+E1tSowxht7g9OJp90GDsAAQ@mail.gmail.com>
Message-ID: <CAK8P3a0C5qUguxg446iuvaHm0D+E1tSowxht7g9OJp90GDsAAQ@mail.gmail.com>
Subject: Re: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
To:     William Cohen <wcohen@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 5:34 PM William Cohen <wcohen@redhat.com> wrote:
>
> On 10/27/20 12:54 PM, Linus Torvalds wrote:
> > On Tue, Oct 27, 2020 at 1:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> Is it time to deprecate and eventually remove oprofile while we're at
> >> it?
> >
> > I think it's well past time.
> >
> > I think the user-space "oprofile" program doesn't actually use the
> > legacy kernel code any more, and hasn't for a long time.
> >
> > But I might be wrong. Adding William Cohen to the cc, since he seems
> > to still maintain it to make sure it builds etc.
>
> Yes, current OProfile code uses the existing linux perf infrastructure and
> doesn't use the old oprofile kernel code.  I have thought about removing
> that old oprofile driver code from kernel, but have not submitted patches
> for it. I would be fine with eliminating that code from the kernel.

I notice that arch/ia64/ supports oprofile but not perf. I suppose this just
means that ia64 people no longer care enough about profiling to
add perf support, but it wouldn't stop us from dropping it, right?

There is also a stub implementation of oprofile for microblaze
and no perf code, not sure if it would make any difference for them.

Everything else that has oprofile kernel code also supports perf.

       Arnd
