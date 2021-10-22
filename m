Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B012E436F3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJVBIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:08:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50004 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVBIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:08:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEDEB21952;
        Fri, 22 Oct 2021 01:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634864782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEkY/UVa2bQvpyJ7fJC0atYq0k6Jm/d6B0yH0qCw/6w=;
        b=wEMhCZsNZQcuQ0kJAkTqdYpUMCl3TZ115nWU0YWDJNAKL0M2Kf3lrq4xqTJcis4d7qbugd
        b7WXUXqYk22haP88iBM3VkSvQnrlHxUllvFm4Rd7wT/UsoDgMUySiIQfpjfBFmMGJWoKrh
        Sott6UU3PRKwnVH6vBwe1StBLg3ljYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634864782;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEkY/UVa2bQvpyJ7fJC0atYq0k6Jm/d6B0yH0qCw/6w=;
        b=9416TnH5UAKToIOWSeCHdtAf4h2FJtlehDYuTOrX3tByP8YKaOQEYwLIkAEJAzOCwybWwE
        dZKZ77Hz2VNG2wCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73FA91346B;
        Fri, 22 Oct 2021 01:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jFVECIkOcmFwJQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 22 Oct 2021 01:06:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux-MM" <linux-mm@kvack.org>,
        "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH 6/8] mm/vmscan: Centralise timeout values for reclaim_throttle
In-reply-to: <20211019090108.25501-7-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>,
 <20211019090108.25501-7-mgorman@techsingularity.net>
Date:   Fri, 22 Oct 2021 12:06:13 +1100
Message-id: <163486477387.17149.7808824931340167601@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021, Mel Gorman wrote:
...
> +	switch(reason) {
> +	case VMSCAN_THROTTLE_NOPROGRESS:
> +	case VMSCAN_THROTTLE_WRITEBACK:
> +		timeout = HZ/10;
> +
> +		if (atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
> +			WRITE_ONCE(pgdat->nr_reclaim_start,
> +				node_page_state(pgdat, NR_THROTTLED_WRITTEN));

You have introduced a behaviour change that wasn't flagged in the commit
message.
Previously nr_writeback_throttled was only incremented for
VMSCAN_THROTTLE_WRITEBACK, now it is incremented for
VMSCAN_THROTTLE_NOPROGRESS as well.  

Some justification would be good.

> +		}
> +
> +		break;
> +	case VMSCAN_THROTTLE_ISOLATED:
> +		timeout = HZ/50;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		timeout = HZ;
> +		break;
>  	}
>  
>  	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
>  	ret = schedule_timeout(timeout);
>  	finish_wait(wqh, &wait);
>  
> -	if (acct_writeback)
> +	if (reason == VMSCAN_THROTTLE_ISOLATED)

(defect) I think you want "!=" there.

While the numbers a still magic, they are now well documented and all in
one place - a definite improvement!

Thanks,
NeilBrown
