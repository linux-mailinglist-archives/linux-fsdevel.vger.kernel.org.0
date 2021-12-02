Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CE46694D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376436AbhLBRok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376423AbhLBRok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:44:40 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367C6C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:41:17 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 207so1116087ljf.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sel9QLaZVY4N+mTLlgeCKeQqHTygfT86F1uxh//ubJk=;
        b=HBLmPCV+9oCwHZNYcNxG43IdBP8nmESwXT5WI7ZvozEylY0SxYxbx3yvK8hRsnW9oX
         WCoHepnTCI6wZD6uClG5zlGVdL7PxfteS4avkFUtE47j4XEgz3TYQFKsSSBSVcW+sLe8
         TmPjrny5x9F6q2IbjeZXHzOnzz9jkjPuJkxA82whsbyBV4KhQW8cqDzgXVHqwhzz9iCE
         +/kGoTXMYMk/O/awyc60UzDdOMAeDrs6VEVaJyM7+JFUDco7xMUBt+7c7A51doDv2Irj
         sJQdPmtP7ubIW3L4+bSqS39T+DSuoGJvo3b4ZV4ZdbdScOj+bycogtO4gFABWdDW9rky
         xO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sel9QLaZVY4N+mTLlgeCKeQqHTygfT86F1uxh//ubJk=;
        b=qWXxQo9xHceUECYXxPv31+Zq3FA8IMTf+7Hmu/hmBp5jMofUoLvUhaJ6BkcL2AmB5w
         2CLJdJCdgMW9LGL8ss/bP1fwr1TgwINkfEyRrOhe/Yg722bw7IrZHtKPePzHQxwo+nPt
         tQ1mqKMRc3gzPcZxS0eFADDzNDKhN3NhWLhBeSIaVip6Jb6SDsGvnQM2RRO9x0d5U4fY
         V+k/VyybJs7W+YxajvdD/dv+eY0bDhbBWP56fu8sSMEJVrtwCd6cvc8BTx1qoAVJttW4
         T/yWSf+zR7uLJvBsKry2xTRiCzGY9GA1ydY5qbylWNJYMVeky+bTZ7uzAJBGqUy00Gfm
         koSw==
X-Gm-Message-State: AOAM5300lh9hw4N9l88yLtOQUaEJyg3gChY2dTtvcinzBhSeGlSUguYr
        Ai20jqCmoB/SyIWSIkFa0YSSqkVT1x4soWeUK1mN8g==
X-Google-Smtp-Source: ABdhPJxwsHniTL8HtWjxo0S47SHXwpQxqVedZCKIvQGSboEzg0cQOFPO30fWETeZK9KDiV3DDDoW9A9k9CWWDfdOAVQ=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr12693560ljp.202.1638466875265;
 Thu, 02 Dec 2021 09:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com> <20211202165220.GZ3366@techsingularity.net>
In-Reply-To: <20211202165220.GZ3366@techsingularity.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Dec 2021 09:41:04 -0800
Message-ID: <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 2, 2021 at 8:52 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Dec 02, 2021 at 08:30:51AM -0800, Shakeel Butt wrote:
> > Hi Mel,
> >
> > On Thu, Dec 2, 2021 at 7:07 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > > problems due to reclaim throttling for excessive lengths of time.
> > > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > > several minutes before stalling. In Mike and Darrick's cases, a small
> > > memcg environment stalled excessively even though the system had enough
> > > memory overall.
> > >
> > > Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being
> > > made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> > > increase the timeout if page reclaim is not making progress") made it
> > > worse. Systems at or near an OOM state that cannot be recovered must
> > > reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
> > >
> >
> > Is there a reason we can't simply revert 69392a403f49 instead of adding
> > more code/heuristics? Looking more into 69392a403f49, I don't think the
> > code and commit message are in sync.
> >
> > For the memcg reclaim, instead of just removing congestion_wait or
> > replacing it with schedule_timeout in mem_cgroup_force_empty(), why
> > change the behavior of all memcg reclaim. Also this patch effectively
> > reverts that behavior of 69392a403f49.
> >
>
> It doesn't fully revert it but I did consider reverting it. The reason
> why I preserved it because the intent originally was to throttle somewhat
> when progress is not being made to avoid a premature OOM and I wanted to
> preserve that charactersistic. Right now, this is the least harmful way
> of doing it.

If I understand correctly, the original intent of 69392a403f49 which
you want to preserve is "avoid premature OOMs when reclaim is not
making progress". Were there any complaints or bug reports on these
premature OOMs?

>
> As more memcg, I removed the NOTHROTTLE because the primary reason why a
> memcg might fail to make progress is excessive writeback and that should
> still throttle. Completely failing to make progress in a memcg is most
> likely due to a memcg-OOM.
>
> > For direct reclaimers under global pressure, why is page allocator a bad
> > place for stalling on no progress reclaim? IMHO the callers of the
> > reclaim should decide what to do if reclaim is not making progress.
>
> Because it's a layering violation and the caller has little direct control
> over the reclaim retry logic. The page allocator has no visibility on
> why reclaim failed only that it did fail.
>

Isn't it better that the reclaim returns why it is failing instead of
littering the reclaim code with 'is this global reclaim', 'is this
memcg reclaim', 'am I kswapd' which is also a layering violation. IMO
this is the direction we should be going towards though not asking to
do this now.

Regarding this patch and 69392a403f49, I am still confused on the main
motivation behind 69392a403f49 to change the behavior of 'direct
reclaimers from page allocator'.

thanks,
Shakeel
