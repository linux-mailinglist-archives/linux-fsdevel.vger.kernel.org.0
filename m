Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8E46BD2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 15:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhLGOGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhLGOGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:06:43 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A5C061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 06:03:13 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id ay21so26682457uab.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 06:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iv4MZHpg9+XiA+tVT8cP5y6XOJdTeoCNwCFRc76ApJA=;
        b=RvdI66/PlmYiW3OYZ4zWhMExkYLm/bPVKAd5DnJ4M6MujtrN2QDr4Jx/PmbKzgBmXS
         xNDJnQ0igFy8HS1lh+Rqcw+usDz+njpuY2iE6JPb0fLAAfryL9Lx84RFFrmdGtBgvPvM
         xS4BrwCv2sMVFTLf2OvByd5+YQvKUUlzIDOgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iv4MZHpg9+XiA+tVT8cP5y6XOJdTeoCNwCFRc76ApJA=;
        b=E9B1mR5P3EWSr09RaKOyt9PSjr3EULqpoW299rQ8cjmN4GekRPZLGADVqowcyVjFWb
         2/EkDspU1xzTOCGuWda2/EtueI1oQG2HJq/xlyyK5eB4yiz3iHDwY9NjnwKxIgCrKshe
         Ojz9+hHNSKvhSLek/jlnyBCjZeN2OKLwngWvbG//dnqvkA+tYqv4KMauanek073f9jpX
         v+aYeRf5pN6mUwEwWeq0o7vnL7i0+mVwuhVa8xuCWX91++R2dSCmfoCBefHp4KHeLwqS
         q5bPaes4Hkl0g/qDkWK6G93vd8MGu09i0cn2AJXU1UTkxANIVLZIJM/cr2/Mtpn617fL
         kuMg==
X-Gm-Message-State: AOAM530WW90clh03gfhwPAzCMuhBbCMjGCuNAMT4IEfouBrZ3dyixL6D
        drIph7oPpbgD9sXCeB4Puw28x7Em+wGZFIZOPpwRNPEBjGk=
X-Google-Smtp-Source: ABdhPJyPF+G2PUMHKn04AcAEdLaHfZHTeFcCVEZ7VRllfqBvl9kNcGrASgqyIE4cXjsBVALJhAsHoZmB3Bl1SX9iTs4=
X-Received: by 2002:a05:6102:c4e:: with SMTP id y14mr47053652vss.61.1638885792380;
 Tue, 07 Dec 2021 06:03:12 -0800 (PST)
MIME-Version: 1.0
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net> <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net> <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
 <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net> <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 15:03:01 +0100
Message-ID: <CAJfpegt2x1ztuzh0niY7fgx1UKxDGsAkJbS0wVPp5awxwyhRpA@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Dec 2021 at 14:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 07, 2021 at 02:45:49PM +0100, Peter Zijlstra wrote:
>
> > > What would be much nicer, is to look at all the threads on the waitq
> > > and pick one that previously ran on the current CPU if there's one.
> > > Could this be implemented?
> >
> > It would violate the FIFO semantics of _exclusive.
>
> That said, look at
> kernel/locking/percpu-rwsem.c:percpu_rwsem_wake_function() for how to do
> really terrible things with waitqueues, possibly including what you
> suggest.

Okay, so it looks doable, but rather more involved than just sticking
that _sync onto the wake helper.

FIFO is used so that we always wake the most recently used thread, right?

That makes sense if it doesn't involve migration, but if the hot
thread is going to be moved to another CPU then we'd lost most of the
advantages.  Am I missing something?

Thanks,
Miklos
