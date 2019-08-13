Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787308BFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfHMRq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 13:46:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44228 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfHMRq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:46:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so3003192pfc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mXGH6sfF5Mv8489pO8HNMnvL4N6Kj76jRZqkd1Btows=;
        b=j6j9cc3oeGRVjeb4q1mX5UvZe7oyDjzfb402Fg+7HhPoR8ZZ6I+HCu+AQE3gq0eDDd
         5SBPUQaw2UJReVDDVyXNzMhXDX6rSNUrGZEzebEzR3mC+q1snggT0oxh7Uly5MzYNf5r
         yJLjMHsZJW7MI2LqKKAA1/VIg6caDPkH/ibZtIg4WtRiccYwshL2Lm7PbBhc9gdSlBBi
         BZoO7hz6wHRCK6BnX9Ew8PkGymJjUq48Of9zE+Aq9pDUvh2e/I/OMBDu85QL/WNz3rPv
         lyKbsxEcKoQzkyqDhiw2oQOo/gaNSd8BdY6gFL1sHjdu/3qsLd9O7/r4sNtlcfFs2fOa
         62CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mXGH6sfF5Mv8489pO8HNMnvL4N6Kj76jRZqkd1Btows=;
        b=WIUg3ecOU/jxezAZeOt8Sb911CJ/YFm4gGSc0bbbbvbeg70RmkSOhFp6ZDS061FoeI
         KmyemGULuMFRWufZWC45htnu1HwnMxY2vcm0pILHL1Hj/iY7Dp5tvVeE/o2+FzKoDHsg
         VkGnSj5SMB4vwvp8HvJ2CDZqdDz7tcyX86uNM3RYJdogs0EclrKAiYx0kwbZj72li0UD
         8zwfGlCt9n0hxASglt8utlVqcSdBwXRm7YsryRpyfVQaSiokcbcoKuuUrvhpAibuzV7a
         sWhkzWMGo13uhP2q94VwNdqI85+dIEqu5Xh+dul+0Hz9nHEr7OmwW866u8I7cqcaoqGm
         FqDw==
X-Gm-Message-State: APjAAAWxZG+GyF1qq/+q1GGhLRl3W0NNVSRdP5+LM65AGemHb7gkT/LT
        dtVdlqfnoMW+4keATP5itdvYYw==
X-Google-Smtp-Source: APXvYqyIrpmWgiXBiK3PDYma3AbBRu7FLdOh0ZmeN1sG7QioNu25fJleeVa7zulYpZwXNMNhBdfcVQ==
X-Received: by 2002:a17:90b:d8f:: with SMTP id bg15mr3266929pjb.65.1565718388234;
        Tue, 13 Aug 2019 10:46:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:674])
        by smtp.gmail.com with ESMTPSA id g11sm9780395pfh.121.2019.08.13.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:46:27 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:46:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
Message-ID: <20190813174625.GA21982@cmpxchg.org>
References: <20190808190300.GA9067@cmpxchg.org>
 <20190809221248.GK7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809221248.GK7689@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 10, 2019 at 08:12:48AM +1000, Dave Chinner wrote:
> On Thu, Aug 08, 2019 at 03:03:00PM -0400, Johannes Weiner wrote:
> > psi tracks the time tasks wait for refaulting pages to become
> > uptodate, but it does not track the time spent submitting the IO. The
> > submission part can be significant if backing storage is contended or
> > when cgroup throttling (io.latency) is in effect - a lot of time is
> 
> Or the wbt is throttling.
> 
> > spent in submit_bio(). In that case, we underreport memory pressure.
> > 
> > Annotate submit_bio() to account submission time as memory stall when
> > the bio is reading userspace workingset pages.
> 
> PAtch looks fine to me, but it raises another question w.r.t. IO
> stalls and reclaim pressure feedback to the vm: how do we make use
> of the pressure stall infrastructure to track inode cache pressure
> and stalls?
> 
> With the congestion_wait() and wait_iff_congested() being entire
> non-functional for block devices since 5.0, there is no IO load
> based feedback going into memory reclaim from shrinkers that might
> require IO to free objects before they can be reclaimed. This is
> directly analogous to page reclaim writing back dirty pages from
> the LRU, and as I understand it one of things the PSI is supposed
> to be tracking.
>
> Lots of workloads create inode cache pressure and often it can
> dominate the time spent in memory reclaim, so it would seem to me
> that having PSI only track/calculate pressure and stalls from LRU
> pages misses a fair chunk of the memory pressure and reclaim stalls
> that can be occurring.

psi already tracks the entire reclaim operation. So if reclaim calls
into the shrinker and the shrinker scans inodes, initiates IO, or even
waits on IO, that time is accounted for as memory pressure stalling.

If you can think of asynchronous events that are initiated from
reclaim but cause indirect stalls in other contexts, contexts which
can clearly link the stall back to reclaim activity, we can annotate
them using psi_memstall_enter() / psi_memstall_leave().

In that vein, what would be great to have is be a distinction between
read stalls on dentries/inodes that have never been touched before
versus those that have been recently reclaimed - analogous to cold
page faults vs refaults.

It would help psi, sure, but more importantly it would help us better
balance pressure between filesystem metadata and the data pages. We
would be able to tell the difference between a `find /' and actual
thrashing, where hot inodes are getting kicked out and reloaded
repeatedly - and we could backfeed that pressure to the LRU pages to
allow the metadata caches to grow as needed.

For example, it could make sense to swap out a couple of completely
unused anonymous pages if it means we could hold the metadata
workingset fully in memory. But right now we cannot do that, because
we cannot risk swapping just because somebody runs find /.

I have semi-seriously talked to Josef about this before, but it wasn't
quite obvious where we could track non-residency or eviction
information for inodes, dentries etc. Maybe you have an idea?
