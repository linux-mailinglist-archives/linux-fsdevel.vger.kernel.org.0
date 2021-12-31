Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFD4825DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 22:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhLaVEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 16:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhLaVEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 16:04:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00521C061574;
        Fri, 31 Dec 2021 13:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A7A61828;
        Fri, 31 Dec 2021 21:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3D6C36AEA;
        Fri, 31 Dec 2021 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640984669;
        bh=9LdS4YJ2dTX8nxYH2HymplEjjux9p/BXT0uHZJPppE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HPd73zj0+Ds30HpWM2w3T3pzK97Th2xrvft4vEQqFUwCO3LLVx3QsMsQftC6YAJuA
         L76ehC6mRgp6Iy80AniCihq+049S8007yW/lNnye34QV+x86qlCKlmBFrizvHlhRte
         wH3yaNE8SRLLVoQ/5BYJGCQCG9om9f8amj6LPD2Q=
Date:   Fri, 31 Dec 2021 13:04:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure
 to make progress
Message-Id: <20211231130427.2239793015906a1c1ede44a4@linux-foundation.org>
In-Reply-To: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
        <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info>
        <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
        <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info>
        <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
        <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 31 Dec 2021 11:21:14 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 31, 2021 at 11:14 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Dec 31, 2021 at 6:24 AM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> > >
> > > If we get it into rc8 (which is still possible, even if a bit hard due
> > > to the new year festivities), it will get at least one week of testing.
> >
> > I took it with Hugh's ack from his reply to this, so it should be in rc8.
> 
> Pushed out as 1b4e3f26f9f7 ("mm: vmscan: Reduce throttling due to a
> failure to make progress")

Needs this fixup, which I shall tweak a bit then send formally
in a few minutes.


From: Mel Gorman <mgorman@techsingularity.net>
Subject: mm: vmscan: reduce throttling due to a failure to make progress -fix

Hugh Dickins reported the following

	My tmpfs swapping load (tweaked to use huge pages more heavily
	than in real life) is far from being a realistic load: but it was
	notably slowed down by your throttling mods in 5.16-rc, and this
	patch makes it well again - thanks.

	But: it very quickly hit NULL pointer until I changed that last
	line to

        if (first_pgdat)
                consider_reclaim_throttle(first_pgdat, sc);

The likely issue is that huge pages are a major component of the test
workload. When this is the case, first_pgdat may never get set if
compaction is ready to continue due to this check

        if (IS_ENABLED(CONFIG_COMPACTION) &&
            sc->order > PAGE_ALLOC_COSTLY_ORDER &&
            compaction_ready(zone, sc)) {
                sc->compaction_ready = true;
                continue;
        }

If this was true for every zone in the zonelist, first_pgdat would never
get set resulting in a NULL pointer exception.

This is a fix to the mmotm patch
mm-vmscan-reduce-throttling-due-to-a-failure-to-make-progress.patch

Link: https://lkml.kernel.org/r/20211209095453.GM3366@techsingularity.net
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reported-by: Hugh Dickins <hughd@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmscan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/vmscan.c~mm-vmscan-reduce-throttling-due-to-a-failure-to-make-progress-fix
+++ a/mm/vmscan.c
@@ -3530,7 +3530,8 @@ static void shrink_zones(struct zonelist
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
-	consider_reclaim_throttle(first_pgdat, sc);
+	if (first_pgdat)
+		consider_reclaim_throttle(first_pgdat, sc);
 
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
_

