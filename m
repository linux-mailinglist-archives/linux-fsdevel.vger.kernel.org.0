Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409004129D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhIUAQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 20:16:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48738 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhIUAOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:14:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC5D0220BD;
        Tue, 21 Sep 2021 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632183204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSbgiXkFC+Y4M1oU9xp1rvgmBone8LNnbtaCTWQdN4s=;
        b=R0BIAB5TRdPPkGgJusC8jb2FlK3KIuDq0VxZ+ex6xJq3ilAXKOT1YHyBZML6wwIXTZZvjA
        vgvRt/wVq94mvYlCwIkAVT4S2UHcL3R33GvTYxGwxcyj/6CaU2A/+d0QAS6Y55IvbQX4T4
        TmEZT3QppuSANM+YMUbYoJhC8ahGlzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632183204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSbgiXkFC+Y4M1oU9xp1rvgmBone8LNnbtaCTWQdN4s=;
        b=2PTuCfQamwKo3aHKonMUxT2xxUcEuj8DpXTzxhRjl5q5bmWCrokk/03O79iXNwRh3fGXht
        5b0hSPB4DYuzByDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDF6213A77;
        Tue, 21 Sep 2021 00:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W+9GKqAjSWGieAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 21 Sep 2021 00:13:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Linux-MM" <linux-mm@kvack.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
In-reply-to: <20210920085436.20939-2-mgorman@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-2-mgorman@techsingularity.net>
Date:   Tue, 21 Sep 2021 10:13:17 +1000
Message-id: <163218319798.3992.1165186037496786892@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Sep 2021, Mel Gorman wrote:
> -long wait_iff_congested(int sync, long timeout)
> -{
> -	long ret;
> -	unsigned long start = jiffies;
> -	DEFINE_WAIT(wait);
> -	wait_queue_head_t *wqh = &congestion_wqh[sync];
> -
> -	/*
> -	 * If there is no congestion, yield if necessary instead
> -	 * of sleeping on the congestion queue
> -	 */
> -	if (atomic_read(&nr_wb_congested[sync]) == 0) {
> -		cond_resched();
> -
> -		/* In case we scheduled, work out time remaining */
> -		ret = timeout - (jiffies - start);
> -		if (ret < 0)
> -			ret = 0;
> -
> -		goto out;
> -	}
> -
> -	/* Sleep until uncongested or a write happens */
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);

Uninterruptible wait.

....
> +static void
> +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> +							long timeout)
> +{
> +	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> +	unsigned long start = jiffies;
> +	long ret;
> +	DEFINE_WAIT(wait);
> +
> +	atomic_inc(&pgdat->nr_reclaim_throttled);
> +	WRITE_ONCE(pgdat->nr_reclaim_start,
> +		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> +
> +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);

Interruptible wait.

Why the change?  I think these waits really need to be TASK_UNINTERRUPTIBLE.

Thanks,
NeilBrown
