Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EE335E840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbhDMVZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 17:25:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbhDMVZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:25:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618349086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dexUbzd9VcB2sp+U6xmRFJemKXDWhpez0KUYWHf8VNM=;
        b=vHh0lruZVTyh+1jyo+pse63FD2gTlrnQIF6yw6jy4fzM4e1kx0dr29uTBmtNYJaiyAlgsy
        KNWJBXPn1jj6TaE1OZStKdamu8y7sUgBGopFftKTfFejsEDuo2QBV6/zv0VwbyQrMzY2Dg
        cyiOh55/NGon9taEDnEXtk1sD/1PZHSNWWT3zst1TPuwvcjCZE/lKk54ZMW3XOGhbcojmS
        fLsfYjPh7hNproNjU3o1+djTTgDUTJ9Uxkd2JK9Tlo13nhR/Es9IVO10lk+O3Hk1j1bkBI
        8zPTDsxIYE6MRtavVgohuVlTmI1XY+rd2qCaBTAq4uuqEuVKQ4a7YtZHv5APCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618349086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dexUbzd9VcB2sp+U6xmRFJemKXDWhpez0KUYWHf8VNM=;
        b=TYdiYP6g+bxEYTBknyxYg4pg9oIVzLTwRC9laSLa5oNncqQ2PGJzzNZTkb6+XhJjxEKYQq
        EdOtG8zNilr0yfAQ==
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, bigeasy@linutronix.de,
        hch@infradead.org, npiggin@kernel.dk
Subject: Re: bl_list and lockdep
In-Reply-To: <20210413095837.GD63242@dread.disaster.area>
References: <20210406123343.1739669-1-david@fromorbit.com> <20210406123343.1739669-4-david@fromorbit.com> <20210406132834.GP2531743@casper.infradead.org> <20210406212253.GC1990290@dread.disaster.area> <874kgb1qcq.ffs@nanos.tec.linutronix.de> <20210412221536.GQ1990290@dread.disaster.area> <87fszvytv8.ffs@nanos.tec.linutronix.de> <20210413095837.GD63242@dread.disaster.area>
Date:   Tue, 13 Apr 2021 23:24:45 +0200
Message-ID: <87o8ehyj1e.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,

On Tue, Apr 13 2021 at 19:58, Dave Chinner wrote:
> On Tue, Apr 13, 2021 at 01:18:35AM +0200, Thomas Gleixner wrote:
> So for solving the inode cache scalability issue with RT in mind,
> we're left with these choices:
>
> a) increase memory consumption and cacheline misses for everyone by
>    adding a spinlock per hash chain so that RT kernels can do their
>    substitution magic and make the memory footprint and scalability
>    for RT kernels worse
>
> b) convert the inode hash table to something different (rhashtable,
>    radix tree, Xarray, etc) that is more scalable and more "RT
>    friendly".
>
> c) have RT kernel substitute hlist-bl with hlist_head and a spinlock
>    so that it all works correctly on RT kernels and only RT kernels
>    take the memory footprint and cacheline miss penalties...
>
> We rejected a) for the dentry hash table, so it is not an appropriate
> soltion for the inode hash table for the same reasons.
>
> There is a lot of downside to b). Firstly there's the time and
> resources needed for experimentation to find an appropriate
> algorithm for both scalability and RT. Then all the insert, removal
> and search facilities will have to be rewritten, along with all the
> subtlies like "fake hashing" to allow fielsysetms to provide their
> own inode caches.  The changes in behaviour and, potentially, API
> semantics will greatly increase the risk of regressions and adverse
> behaviour on both vanilla and RT kernels compared to option a) or
> c).
>
> It is clear that option c) is of minimal risk to vanilla kernels,
> and low risk to RT kernels. It's pretty straight forward to do for
> both configs, and only the RT kernels take the memory footprint
> penalty.
>
> So a technical analysis points to c) being the most reasonable
> resolution of the problem.

I agree with that analysis for technical reasons and I'm not entirely
unfamiliar how to solve hlist_bl conversions on RT either as you might
have guessed.

Having a technical argument to discuss and agree on is far simpler
than going along with "I don't care".

Thanks for taking the time to put a technical rationale on this!

       tglx
