Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86EB42DE3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJNPi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:38:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhJNPi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:38:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 113832199D;
        Thu, 14 Oct 2021 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634225783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfCwUxPav+5NMXp6E/NQJY5UwNLjQOLziGSbZZ1HUl4=;
        b=zskhCKQR7MLMfGBQG9LY4tClO48hLJyuPFIryiADcJuXnMzpI5PNhcLhEuF5wvLph9Qfbq
        lOG91gsXPBeZp6OkNp8RVvzUJJD2oVWIuASBZZvIXA/zNHibzIfvu+nrZD+euj8d0PfZRp
        M6upmWMdkaY21VS7Bu1HrAWUrprrN40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634225783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfCwUxPav+5NMXp6E/NQJY5UwNLjQOLziGSbZZ1HUl4=;
        b=AtVsJG+JtGYst8VgqzZHtsBbJGyCbw4oMCR1gH0Zsm2CMx8Z89cB+729ieNEwejGkqPcSA
        IbbDBgZHcvTFNACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D242413D9F;
        Thu, 14 Oct 2021 15:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nX2OMnZOaGFRHgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:36:22 +0000
Message-ID: <f464c5de-7f7c-bafd-7f5c-833faa9a690f@suse.cz>
Date:   Thu, 14 Oct 2021 17:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/8] mm/page_alloc: Remove the throttling logic from the
 page allocator
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
 <20211008135332.19567-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211008135332.19567-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> The page allocator stalls based on the number of pages that are
> waiting for writeback to start but this should now be redundant.
> shrink_inactive_list() will wake flusher threads if the LRU tail are
> unqueued dirty pages so the flusher should be active. If it fails to make
> progress due to pages under writeback not being completed quickly then
> it should stall on VMSCAN_THROTTLE_WRITEBACK.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 78e538067651..8fa0109ff417 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4795,30 +4795,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  		trace_reclaim_retry_zone(z, order, reclaimable,
>  				available, min_wmark, *no_progress_loops, wmark);
>  		if (wmark) {
> -			/*
> -			 * If we didn't make any progress and have a lot of
> -			 * dirty + writeback pages then we should wait for
> -			 * an IO to complete to slow down the reclaim and
> -			 * prevent from pre mature OOM
> -			 */
> -			if (!did_some_progress) {
> -				unsigned long write_pending;
> -
> -				write_pending = zone_page_state_snapshot(zone,
> -							NR_ZONE_WRITE_PENDING);
> -
> -				if (2 * write_pending > reclaimable) {
> -					congestion_wait(BLK_RW_ASYNC, HZ/10);
> -					return true;
> -				}
> -			}
> -
>  			ret = true;
> -			goto out;
> +			break;
>  		}
>  	}
>  
> -out:
>  	/*
>  	 * Memory allocation/reclaim might be called from a WQ context and the
>  	 * current implementation of the WQ concurrency control doesn't
> 

