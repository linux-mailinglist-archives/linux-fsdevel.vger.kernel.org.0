Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E573BE5F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGGJyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 05:54:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52548 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhGGJyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:54:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FA2020041;
        Wed,  7 Jul 2021 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625651499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ot6CAR92JLdLil0GFznAKUtvkMkMuuMo8NYA4KiY+BM=;
        b=jyINxxpG88xsl6q+H7L3kaRyYFJiM1ZY/59Is9Gv38oo5Fcwtat811E+xJbADcmP/HAJ0c
        UAq3nHGaNZftpbWOiV2SGAzJ0sR8tjkULUlWkKgjVbW3kmId0lG7fxhnDEmsaQYIXu1dHI
        0EgK/DwOR9k6ukLF0tqGIKywo2sm6d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625651499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ot6CAR92JLdLil0GFznAKUtvkMkMuuMo8NYA4KiY+BM=;
        b=Jm7j/8ZFGGoGhFUrO/mHe8cXb7XLaOrol+GxY4Sh496/p6Qw9UIGYWL69cToubZWQpccwO
        6hwkWmhb46guN8DA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 2B985A3BA3;
        Wed,  7 Jul 2021 09:51:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 684221F2CD7; Wed,  7 Jul 2021 11:51:38 +0200 (CEST)
Date:   Wed, 7 Jul 2021 11:51:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Michael Stapelberg <stapelberg+linux@google.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/5] writeback: Fix bandwidth estimate for spiky workload
Message-ID: <20210707095138.GC5335@quack2.suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
 <20210707074017.2195-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707074017.2195-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-07-21 15:40:17, Hillf Danton wrote:
> On Mon,  5 Jul 2021 18:23:17 +0200 Jan Kara wrote:
> >
> >Michael Stapelberg has reported that for workload with short big spikes
> >of writes (GCC linker seem to trigger this frequently) the write
> >throughput is heavily underestimated and tends to steadily sink until it
> >reaches zero. This has rather bad impact on writeback throttling
> >(causing stalls). The problem is that writeback throughput estimate gets
> >updated at most once per 200 ms. One update happens early after we
> >submit pages for writeback (at that point writeout of only small
> >fraction of pages is completed and thus observed throughput is tiny).
> >Next update happens only during the next write spike (updates happen
> >only from inode writeback and dirty throttling code) and if that is
> >more than 1s after previous spike, we decide system was idle and just
> >ignore whatever was written until this moment.
> >
> >Fix the problem by making sure writeback throughput estimate is also
> >updated shortly after writeback completes to get reasonable estimate of
> >throughput for spiky workloads.
> >
> >Link: https://lore.kernel.org/lkml/20210617095309.3542373-1-stapelberg+li>nux@google.com
> >Reported-by: Michael Stapelberg <stapelberg+linux@google.com>
> >Signed-off-by: Jan Kara <jack@suse.cz>
...
> >diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> >index 1fecf8ebadb0..6a99ddca95c0 100644
> >--- a/mm/page-writeback.c
> >+++ b/mm/page-writeback.c
> >@@ -1346,14 +1346,7 @@ static void __wb_update_bandwidth(struct dirty_thr>ottle_control *gdtc,
> > 	unsigned long dirtied;
> > 	unsigned long written;
> >
> >-	lockdep_assert_held(&wb->list_lock);
> >-
> >-	/*
> >-	 * rate-limit, only update once every 200ms.
> >-	 */
> >-	if (elapsed < BANDWIDTH_INTERVAL)
> >-		return;
> 
> Please leave it as it is if you are not dumping the 200ms rule.

Well, that could break the delayed updated scheduled after the end of
writeback and for no good reason. The problematic ordering is like:

end writeback on inode1
  queue_delayed_work() - queues delayed work after BANDWIDTH_INTERVAL

__wb_update_bandwidth() called e.g. from balance_dirty_pages()
  wb->bw_time_stamp = now;

end writeback on inode2
  queue_delayed_work() - does nothing since work is already queued

delayed work calls __wb_update_bandwidth() - nothing is done since elapsed
< BANDWIDTH_INTERVAL and we may thus miss reflecting writeback of inode2 in
our estimates.

> >@@ -2742,6 +2737,11 @@ static void wb_inode_writeback_start(struct bdi_wr>iteback *wb)
> > static void wb_inode_writeback_end(struct bdi_writeback *wb)
> > {
> > 	atomic_dec(&wb->writeback_inodes);
> >+	/*
> >+	 * Make sure estimate of writeback throughput gets
> >+	 * updated after writeback completed.
> >+	 */
> >+	queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> > }
> 
> This is a bogus estimate - it does not break the 200ms rule but walks
> around it without specifying why 300ms is not good.

Well, you're right that BANDWIDTH_INTERVAL is somewhat arbitrary here. We
do want some batching of bandwidth updates after writeback completes for
the cases where lots of inodes end their writeback in a quick succession.
I've picked BANDWIDTH_INTERVAL here as that's the batching of other
bandwidth updates as well so it kind of makes sense. I'll add a comment why
BANDWIDTH_INTERVAL is picked here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
