Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0043C1738
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGHQpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 12:45:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhGHQpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:45:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0547922171;
        Thu,  8 Jul 2021 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625762582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=no7T263x2p7KR8vDwP0iS2RVpaZtN46cYVsdxB2U64w=;
        b=KMFO8GjgJWHlQ6KKphAP8qHGpiaId1K9k5BtD9WuY9K4592J7WR36qtRlewyPY7O9CKgg/
        7sW+ntdNOySOiG7jZBva15JAfbY8brvgRWfpLziDJwnawbhVV2p+D6ohxP8cQ/3iR1lzka
        orZyvFsVa5fZJtL0V9Ds3A0asaElDwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625762582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=no7T263x2p7KR8vDwP0iS2RVpaZtN46cYVsdxB2U64w=;
        b=68G6CrjSGz2U0JPSDHHMejaBUm598V/Ferref4jJZ4u/yZMcbVo+hLnSbeF2uL/i5GiCVV
        nJHDshYyGMCjLIDQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id B34BCA3B8B;
        Thu,  8 Jul 2021 16:43:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8CE1A1E62E4; Thu,  8 Jul 2021 18:43:01 +0200 (CEST)
Date:   Thu, 8 Jul 2021 18:43:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Michael Stapelberg <stapelberg+linux@google.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/5] writeback: Fix bandwidth estimate for spiky workload
Message-ID: <20210708164301.GA11179@quack2.suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
 <20210707074017.2195-1-hdanton@sina.com>
 <20210708121751.327-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708121751.327-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-07-21 20:17:51, Hillf Danton wrote:
> On Wed, 7 Jul 2021 11:51:38 +0200 Jan Kara wrote:
> >On Wed 07-07-21 15:40:17, Hillf Danton wrote:
> >> On Mon,  5 Jul 2021 18:23:17 +0200 Jan Kara wrote:
> >> >
> >> >Michael Stapelberg has reported that for workload with short big spikes
> >> >of writes (GCC linker seem to trigger this frequently) the write
> >> >throughput is heavily underestimated and tends to steadily sink until it
> >> >reaches zero. This has rather bad impact on writeback throttling
> >> >(causing stalls). The problem is that writeback throughput estimate gets
> >> >updated at most once per 200 ms. One update happens early after we
> >> >submit pages for writeback (at that point writeout of only small
> >> >fraction of pages is completed and thus observed throughput is tiny).
> >> >Next update happens only during the next write spike (updates happen
> >> >only from inode writeback and dirty throttling code) and if that is
> >> >more than 1s after previous spike, we decide system was idle and just
> >> >ignore whatever was written until this moment.
> >> >
> >> >Fix the problem by making sure writeback throughput estimate is also
> >> >updated shortly after writeback completes to get reasonable estimate of
> >> >throughput for spiky workloads.
> >> >
> >> >Link: https://lore.kernel.org/lkml/20210617095309.3542373-1-stapelberg+li>nux@google.com
> >> >Reported-by: Michael Stapelberg <stapelberg+linux@google.com>
> >> >Signed-off-by: Jan Kara <jack@suse.cz>
> >...
> >> >diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> >> >index 1fecf8ebadb0..6a99ddca95c0 100644
> >> >--- a/mm/page-writeback.c
> >> >+++ b/mm/page-writeback.c
> >> >@@ -1346,14 +1346,7 @@ static void __wb_update_bandwidth(struct dirty_thr>ottle_control *gdtc,
> >> > 	unsigned long dirtied;
> >> > 	unsigned long written;
> >> >
> >> >-	lockdep_assert_held(&wb->list_lock);
> >> >-
> >> >-	/*
> >> >-	 * rate-limit, only update once every 200ms.
> >> >-	 */
> >> >-	if (elapsed < BANDWIDTH_INTERVAL)
> >> >-		return;
> >> 
> >> Please leave it as it is if you are not dumping the 200ms rule.
> >
> >Well, that could break the delayed updated scheduled after the end of
> >writeback and for no good reason. The problematic ordering is like:
> 
> After another look at 2/5, you are cutting the rule, which is worth a
> seperate patch.

The only update that can break the 200ms rule are the updates added in this
patch. I don't think separating the removal of 200ms check for that one
case really brings much clarity. It would rather bring "what if questions"
to this patch...

> >end writeback on inode1
> >  queue_delayed_work() - queues delayed work after BANDWIDTH_INTERVAL
> >
> >__wb_update_bandwidth() called e.g. from balance_dirty_pages()
> >  wb->bw_time_stamp = now;
> >
> >end writeback on inode2
> >  queue_delayed_work() - does nothing since work is already queued
> >
> >delayed work calls __wb_update_bandwidth() - nothing is done since elapsed
> >< BANDWIDTH_INTERVAL and we may thus miss reflecting writeback of inode2 in
> >our estimates.
> 
> Your example says the estimate based on inode2 is torpedoed by a random
> update, and you are looking to make that estimate meaningful at the cost
> of breaking the rule - how differet is it to the current one if the
> estimate is derived from 20ms-elapsed interval at inode2? Is it likely to
> see another palpablely different result at inode3 from 50ms-elapsed interval?

I'm not sure I understand your question correctly but updates after shorter
than 200ms interval should not disturb the estimates much.
wb_update_write_bandwidth() effectively uses formula:

	bandwidth = (written + bandwidth * (period - elapsed)) / period

where 'period' is 3 seconds. So we compute average bandwidth over last 3
seconds where amount written in 'elapsed' interval is 'written' pages. If
'elapsed' is small, the influence of current sample on reducing estimated
bandwidth is going to be small as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
