Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0145EB8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 11:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376925AbhKZKcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 05:32:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:35285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377090AbhKZKaB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637922384;
        bh=obeD6+sqgmga7SssO9pkbRmhV6wRnRhhX+/nLsuEoX0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ESyG5jlfZJMIN/iX4X8anthjCUadoQoTAz7Bsg0aIUzc/fBN/nncymtp/Ck5LWznv
         3iylcnyDjfNwnLxgjMevBNQ4zGGF0gR2EjkS5gNolUkfJUFngNa+hhk8VV0U8x6HtR
         Ojsxsvni6r9QPsucjIBoG3UgLtaYNsIxo5hn6juY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1mRQPi3MRR-011A4O; Fri, 26
 Nov 2021 11:26:23 +0100
Message-ID: <cf8040cbd4a83c3e6b1d89f6ea1a3066da11bb11.camel@gmx.de>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Nov 2021 11:26:21 +0100
In-Reply-To: <20211125151853.8540-1-mgorman@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:atLP9Gml7Z7TDmeDtb+384j5teVIu0zYxgKfva1m2rHvt4sNBbk
 zIpbfQbIwZ5CuaUu6v41luPKqQj/w35VDSI8fYqDqTjuzjL3/Ynm0zkR979zbtgkNIWdO6e
 lLPId74dSRUmxvidBm4ok0ek8qafghD4uHhhEmx+f/iuFO6eOsOiqJx5gJeLHGqoKkhkOtS
 9S0RJY03DgD4bOa+yEmVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9qO32pdP3qM=:vw66KE9Mt4y1A8D+y12uQh
 4vW+idEMwugJr8cyLr5DH/igXS90mq8tGTWm77KcyePvrpMIyanOKXUWetmj62GlrjCo3zwb6
 Lq8MO5xbtJ+ErfPuGuiw4eH+Gx6s3cTo2I7PFWvjRYz5wjTsc2EFSBMK52G2Vzl2Q90TkPn2U
 rAQQ81SPdzgn1H6UbOLpPwhME+clYRSpXwCWSr7lgPxBwgtFyZaTPi/tkrYUj+zMrGIoZPL1a
 DTNQLv17NkIfx4mLuqFbCVwy9oyLAWvbMjuyz3GJHz2GuM7PgLmc9aGh2DE2XkaIQdGm+kunB
 hBMLW+FlvzOEbFhwfFRX2usQxGkF2I0/+vGcIN7r3gjVKyv7ii+1/mtHQc3jmOiQey1HRAvuK
 wNNXVfKw8yspIxQv6vgLHarkXm5N0rXjlxdjfS4tyUCGeQIIk5O5Eh90TLv64JktRUQiMuZVD
 a4vyDvhFbuHb/BCzDRZMoCJGuFyfzEC5nDtty81NqH0mOQbWGp1P9gjB2VhQPBWn1HQM55BBK
 cuByUayAcBL74kSrgM0e6J6L76gmyvKUslH62ULE813qg2ensEgIrtaLly0vzPxAs8yeTYPqD
 7McykY7GKBj688jVPHWtoJW6Drlm+naMhujf6Q/JYSVoMupYNnSIXjhjUsFAkTmH0lpZ2NR9E
 pQX720HfHZeYi6QuYxZ5lfou9eB74htq3To9Kj6/CvtmEA/tDP2tKzEpqhCibeNmaDnMZsjgc
 mHLrmRP/k9HP/LOsZcdheB0vnWZTW8RGiUc0fbEngBuegcLCoJEGyvrm5iLF/5eKBl9EqovmZ
 VIJMbv1KRA93gNl1KSsPihBWBdqnenF5KH/kimmd7uPlmqfnQXZatCbTd8K416FMXtlnWDAuc
 /yOysP1MKwuIJI+PvANmM917RBMJZ0TOubuwi/dORveq+sZB1tLgpjAck8j+DGUW8Vji+ipYQ
 nL0k3FtwO+DugS+Wr7A0rgU8gx7T5Fym4HBSXsKpx0Hu50pN5HmrQfU+qxUmX+kbcVpJhvLzy
 Tv2kxRTLIqiOeAgJKsKoRZtPYSd1J8Km0aBzERwSU85Km3NsdltwOduXe1yIFszdgpdMzSxML
 g4mrgU3EHb/Hso=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-11-25 at 15:18 +0000, Mel Gorman wrote:
> Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> problems due to reclaim throttling for excessive lengths of time.
> In Alexey's case, a memory hog that should go OOM quickly stalls for
> several minutes before stalling. In Mike and Darrick's cases, a small
> memcg environment stalled excessively even though the system had enough
> memory overall.
>
> Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is be=
ing
> made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> increase the timeout if page reclaim is not making progress") made it
> worse. Systems at or near an OOM state that cannot be recovered must
> reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
>
> To address this, only stall for the first zone in the zonelist, reduce
> the timeout to 1 tick for VMSCAN_THROTTLE_NOPROGRESS and only stall if
> the scan control nr_reclaimed is 0 and kswapd is still active.=C2=A0 If =
kswapd
> has stopped reclaiming due to excessive failures, do not stall at all so
> that OOM triggers relatively quickly.

This patch helped a ton with LTP testcases, but, the behavior of
test_1() in memcg_regression_test.sh still looks pretty darn bad...

homer:..debug/tracing # tail -1 /trace
    memcg_test_1-4683    [002] .....   282.319617: out_of_memory+0x194/0x4=
40: !!oc->chosen:1
homer:..debug/tracing # grep memcg_test_1-4683 /trace|grep sleepy|wc -l
190 !!!

That one memcg_test_1 instance, of 400 spawned in a memcg with its
limit_in_bytes set to zero, slept 190 times on the way to oom-kill,
leading a regression test that used to complete in a fraction of a
second still taking over 8 minutes to even with the huge improvement
$subject made.

Poking it with the sharp stick below took it down to 20 encounters with
reclaim_throttle(), and a tad under a minute for test_1() to complete.

Reasoning: given try_charge_memcg() will loop as long as there is ANY
progress, and each call to try_to_free_mem_cgroup_pages() therein now
entails multiple encounters with reclaim_throttle(), allowing plenty of
time for some progress enabling events to have occurred and benefit
reaped by the time we return, looping again and again when having been
throttled numerous times did NOT help at all seems now to constitute
pointless thumb twiddling.  Or?

=2D--
 mm/memcontrol.c |    5 -----
 1 file changed, 5 deletions(-)

=2D-- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2584,7 +2584,6 @@ static int try_charge_memcg(struct mem_c
 			unsigned int nr_pages)
 {
 	unsigned int batch =3D max(MEMCG_CHARGE_BATCH, nr_pages);
-	int nr_retries =3D MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
 	enum oom_status oom_status;
@@ -2675,9 +2674,6 @@ static int try_charge_memcg(struct mem_c
 	if (mem_cgroup_wait_acct_move(mem_over_limit))
 		goto retry;

-	if (nr_retries--)
-		goto retry;
-
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;

@@ -2694,7 +2690,6 @@ static int try_charge_memcg(struct mem_c
 		       get_order(nr_pages * PAGE_SIZE));
 	if (oom_status =3D=3D OOM_SUCCESS) {
 		passed_oom =3D true;
-		nr_retries =3D MAX_RECLAIM_RETRIES;
 		goto retry;
 	}
 nomem:

