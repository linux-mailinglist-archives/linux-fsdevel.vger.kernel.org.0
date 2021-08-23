Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAC3F532A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 00:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhHWWHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhHWWHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:07:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3323C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 15:06:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y6so34091986lje.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNzxccHrLNvgtuARmJVk/6D6HUeCLBrBp9BAleU49Ss=;
        b=dwy8paMHkqyjLg1te3lCxkkLE6jDyUtbeifszfiKDvo9BBrM7XLb+10zYHDlIQZ6Gp
         s56jjZ/xv3KJAQ4Nz4+dvXUgTAQZmD21ubLfgu/r5vkDTVl0L1aNZ20sdEQO/9nYBeOg
         2kehgthnitJpNSRy4IWcnjmoAiUzkkD/n4/q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNzxccHrLNvgtuARmJVk/6D6HUeCLBrBp9BAleU49Ss=;
        b=TwA7SqlkTYeG9LsOlUCXT381KMA2jHsFhriZJ0ary79W8O9IVfAuVC2mofsIsV+YeG
         K8XhVAjEhICxFhiXmHGSsm7v4Yk+S0mI1b1ZuzV8kK5CJC5aF49VPb1rAg5DFksGodgU
         Z4gvuZ9A0xDjFRae2YeDsZXpXdPFjFeoOvOLfMoOsSCpfaGvPtoDdPUE69eCCSXg5vqq
         jhjbehttsPlUT0lAohtUk5e1HOrvswv0ogZuIzVWSVIjCrAvkjj5aoIDAkAPwiDr86vN
         j27M5M14sMgx/al6KF9M+GtiLZwxjh0TBeudSZcpiKph5gGP9ugmj17yPmd9nFIFblXk
         Mu4g==
X-Gm-Message-State: AOAM533PS1RvblArmOBYUBmzY0GdqyubYuPzwVw3F2WnsMI+yOh+B/vG
        vbVAooKwRrFU2Pm4B/wmWxL8O2SYV4/mfwRb
X-Google-Smtp-Source: ABdhPJzBczOAdJBca/6XfgVE9HKpF+tWBF6lYZVvOIaDQ1XVRqgDnOKyFwZuNPkFvV/KuXSsSL478w==
X-Received: by 2002:a2e:9185:: with SMTP id f5mr899124ljg.197.1629756385048;
        Mon, 23 Aug 2021 15:06:25 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e19sm1601604ljl.47.2021.08.23.15.06.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 15:06:24 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id s12so8886475ljg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 15:06:24 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr29180236ljc.251.1629756384152;
 Mon, 23 Aug 2021 15:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
In-Reply-To: <YSQSkSOWtJCE4g8p@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Aug 2021 15:06:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
Message-ID: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 2:25 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> One one hand, the ambition appears to substitute folio for everything
> that could be a base page or a compound page even inside core MM
> code. Since there are very few places in the MM code that expressly
> deal with tail pages in the first place, this amounts to a conversion
> of most MM code - including the LRU management, reclaim, rmap,
> migrate, swap, page fault code etc. - away from "the page".

Yeah, honestly, I would have preferred to see this done the exact
reverse way: make the rule be that "struct page" is always a head
page, and anything that isn't a head page would be called something
else.

Because, as you say, head pages are the norm. And "folio" may be a
clever term, but it's not very natural. Certainly not at all as
intuitive or common as "page" as a name in the industry.

That said, I see why Willy did it the way he did - it was easier to do
it incrementally the way he did. But I do think it ends up with an end
result that is kind of topsy turvy where the common "this is the core
allocation" being called that odd "folio" thing, and then the simpler
"page" name is for things that almost nobody should even care about.

I'd have personally preferred to call the head page just a "page", and
other pages "subpage" or something like that. I think that would be
much more intuitive than "folio/page".

                  Linus
