Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1968A434124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 00:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhJSWCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 18:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhJSWCl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE0960FDA;
        Tue, 19 Oct 2021 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634680827;
        bh=Rk43kt/rzfIF9w6y1lPOwDQjIprPyWMfV86zk0IuZz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mM0x0H7FCOinXZ4mdFMqWNW7smp4C8w8lQtnMlj9VvCKdIW/SFcPU/RxPsKDbsP1t
         z5A59chQaUCEMvnwBQDimhND52a8u62ysdVmWCy88aEidcmxII8iqtpdqeGNfRkfsx
         waP9eBwf4tcdC+5UkRoYp/O1Jy625nCCmK4DZTDE=
Date:   Tue, 19 Oct 2021 15:00:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     NeilBrown <neilb@suse.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Message-Id: <20211019150025.c62a0c72538d1f9fa20f1e81@linux-foundation.org>
In-Reply-To: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021 10:01:00 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> Changelog since v3
> o Count writeback completions for NR_THROTTLED_WRITTEN only
> o Use IRQ-safe inc_node_page_state
> o Remove redundant throttling
> 
> This series is also available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-reclaimcongest-v4r2
> 
> This series that removes all calls to congestion_wait
> in mm/ and deletes wait_iff_congested. It's not a clever
> implementation but congestion_wait has been broken for a long time
> (https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).

The block layer doesn't call clear_bdi_congested() at all.  I never
knew this until recent discussions :(

So this means that congestion_wait() will always time out, yes?

> Even if congestion throttling worked, it was never a great idea.

Well.  It was a good idea until things like isolation got added!

> While
> excessive dirty/writeback pages at the tail of the LRU is one possibility
> that reclaim may be slow, there is also the problem of too many pages
> being isolated and reclaim failing for other reasons (elevated references,
> too many pages isolated, excessive LRU contention etc).
> 
> This series replaces the "congestion" throttling with 3 different types.
> 
> o If there are too many dirty/writeback pages, sleep until a timeout
>   or enough pages get cleaned
> o If too many pages are isolated, sleep until enough isolated pages
>   are either reclaimed or put back on the LRU
> o If no progress is being made, direct reclaim tasks sleep until
>   another task makes progress with acceptable efficiency.
> 
> This was initially tested with a mix of workloads that used to trigger
> corner cases that no longer work.

Mix of workloads is nice, but a mix of devices is more important here. 
I trust some testing was done on plain old spinning disks?  And USB
storage, please!  And NFS plays with BDI congestion.  Ceph and FUSE also.

We've had complaints about this stuff forever.  Usually of the form of
interactive tasks getting horridly stalled by writeout/swap activity.
