Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9057F3192E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 20:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBKTQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 14:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBKTP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:15:59 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB3C061574;
        Thu, 11 Feb 2021 11:15:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l12so8150802edt.3;
        Thu, 11 Feb 2021 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aiFefqoimb6TFhPhRuNGjxw3R3UdnJbDOdGhYcf71E=;
        b=u4NieD2DpZipPoDbNyb/O29FcpWoDFTEF5fVeUcQTfXHWoLGXlQid9V+apL8Ac0OTx
         vLPeGmb2H7cO+Zo6GzVfk/aqVX5vNPx0jIYVkSe2EJEB+Cukt7sAd5oVQYnue4RQdxl3
         mm0FLTPcAEHNVRdGmF3iVdf0Zt/JbGAjrgO2sinnSWRlbmLxKIUFsvngM6FluQ3YpAhg
         oNU0SPvRzOPDeY0prhkg3nCXCy6Mfs3smJ6EBXOZ8EIcDKMpNuR9cAnVYAvOcPQ+HheF
         TiuKKmMbylyQHrRIveNrELq3Nq/oAFkmEAWu4G5VoYHqDXKPymxkbJ1pNEoWlFH04aQM
         qXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aiFefqoimb6TFhPhRuNGjxw3R3UdnJbDOdGhYcf71E=;
        b=qerUfV40V6DQ1oz1hPkYGGP8hCY3VlPhB1qk2y5Ed1FIqVBdoPyF51ZaPQSu7J8yXT
         JMDqgifssf8cC4mbNl/20KJWiOkH7eEBHY+/fof/ybyRbL7FDkC8W6saxJX7/QLgdotm
         gN69LQHj1zunOafV7K4BfoLEdYR9WKvGq4M+FvCM1dlF4liOu8jXqEG+WzbeKS2gfUcj
         sy++Gv5+N/bWFvm5qyzFaX0iwoj8kmYADP/SW6PgNB5I2MEinfTdvriGcGIDqH+2N8y0
         LkfoK/yx6JQ+dUH382h5VMXtuffpA1pTRsuWm/PqZHM9cUW7rWINgxvh/2MH4BiboyVF
         oJ1A==
X-Gm-Message-State: AOAM533VRYIx8O8HBbYyEasneO0Xl6D6/6gzEZvIqsOpyYK1PrUn7e9X
        i6UZkhXjgOA8BZMrkUa6Ujnpunfct1RNP3RCCvM=
X-Google-Smtp-Source: ABdhPJzNIhQdqijCqLZpM87eKqzcbgw66UVqZknP5r/7I6cuRetDOJRWQczlIO90h30Zd653oNIsnZ+LZgL36LjUpcQ=
X-Received: by 2002:aa7:de82:: with SMTP id j2mr9740116edv.313.1613070916975;
 Thu, 11 Feb 2021 11:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-13-shy828301@gmail.com>
 <acd1915c-306b-08a8-9e0f-b06c1e09fb4c@suse.cz> <CAHbLzkpF9+NUp2yUf_yKHHngKXGDya4Mj3ZTc-2rm3yFNw_==A@mail.gmail.com>
 <a56fa0f1-3ac6-49f1-31c1-8bfec961d04e@suse.cz>
In-Reply-To: <a56fa0f1-3ac6-49f1-31c1-8bfec961d04e@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 11 Feb 2021 11:15:04 -0800
Message-ID: <CAHbLzkpqTGWKQuK7HB0o5PPVoebdM83gsPo_Uo7NTD-e_foGWQ@mail.gmail.com>
Subject: Re: [v7 PATCH 12/12] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:52 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/11/21 6:29 PM, Yang Shi wrote:
> > On Thu, Feb 11, 2021 at 5:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >> >       trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> >> >                                  freeable, delta, total_scan, priority);
> >> > @@ -737,10 +708,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >> >               cond_resched();
> >> >       }
> >> >
> >> > -     if (next_deferred >= scanned)
> >> > -             next_deferred -= scanned;
> >> > -     else
> >> > -             next_deferred = 0;
> >> > +     next_deferred = max_t(long, (nr - scanned), 0) + total_scan;
> >>
> >> And here's the bias I think. Suppose we scanned 0 due to e.g. GFP_NOFS. We count
> >> as newly deferred both the "delta" part of total_scan, which is fine, but also
> >> the "nr >> priority" part, where we failed to our share of the "reduce
> >> nr_deferred" work, but I don't think it means we should also increase
> >> nr_deferred by that amount of failed work.
> >
> > Here "nr" is the saved deferred work since the last scan, "scanned" is
> > the scanned work in this round, total_scan is the *unscanned" work
> > which is actually "total_scan - scanned" (total_scan is decreased by
> > scanned in each loop). So, the logic is "decrease any scanned work
> > from deferred then add newly unscanned work to deferred". IIUC this is
> > what "deferred" means even before this patch.
>
> Hm I thought the logic was "increase by any new work (delta) that wasn't done,
> decrease by old deferred work that was done now". My examples with scanned = 0
> and scanned = total_work (total_work before subtracting scanned from it) should
> demonstrate that the logic is different with your patch.

I think we are on the same page about the logic. But I agree the
formula implemented in the code is wrong.

>
> >> OTOH if we succeed and scan exactly the whole goal, we are subtracting from
> >> nr_deferred both the "nr >> priority" part, which is correct, but also delta,
> >> which was new work, not deferred one, so that's incorrect IMHO as well.
> >
> > I don't think so. The deferred comes from new work, why not dec new
> > work from deferred?
> >
> > And, the old code did:
> >
> > if (next_deferred >= scanned)
> >                 next_deferred -= scanned;
> >         else
> >                 next_deferred = 0;
> >
> > IIUC, it also decreases the new work (the scanned includes both last
> > deferred and new delata).
>
> Yes, but in the old code, next_deferred starts as
>
> nr = count_nr_deferred()...
> total_scan = nr;
> delta = ... // something based on freeable
> total_scan += delta;
> next_deferred = total_scan; // in the common case total_scan >= 0
>
> ... and that's "total_scan" before "scanned" is subtracted from it, so it
> includes the new_work ("delta"), so then it's OK to do "next_deferred -= scanned";
>
> I still think your formula is (unintentionally) changing the logic. You can also
> look at it from different angle, it's effectively (without the max_t() part) "nr
> - scanned + total_scan" where total_scan is actually "total_scan - scanned" as
> you point your yourself. So "scanned" is subtracted twice? That can't be correct...

Yes, I think you are right, it can not be correct. Actually I wanted
plus the unscanned delta part to the next_deferred. But my formula
actually not only decs scanned twice but also adds unscanned deferred
back again. So it seems the formula suggested by you is correct. Will
correct this in v8. Thanks a lot for helping get out of the maze. Will
add some notes right before the formula as well.

>
> >> So the calculation should probably be something like this?
> >>
> >>         next_deferred = max_t(long, nr + delta - scanned, 0);
> >>
> >> Thanks,
> >> Vlastimil
> >>
> >> > +     next_deferred = min(next_deferred, (2 * freeable));
> >> > +
> >> >       /*
> >> >        * move the unused scan count back into the shrinker in a
> >> >        * manner that handles concurrent updates.
> >> >
> >>
> >
>
