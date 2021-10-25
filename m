Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B743935B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhJYKKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 06:10:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37002 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJYKKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:10:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 665F621921;
        Mon, 25 Oct 2021 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635156458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvcTBX6oFUiC/1bvh2fK775aNJCv8thWhu+QlD3HECg=;
        b=br7qWuIIRODx29onOJW6NpA6ttSJ2eYKlbaHgTq3+Hb+Db1ecrMGkrGd51+PRW6KZRARa7
        lzrcGBgwb9uYZLesJSCynPuXtqgJz1V2OrPHXEgqi1K7I768RGmv7MO60y1k8edp8pNULi
        A9oL4HFac6TMw5zIKdXpGaq0b7a+0v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635156458;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvcTBX6oFUiC/1bvh2fK775aNJCv8thWhu+QlD3HECg=;
        b=jZiz7y5C/2nCLsiV05LsGbbLZ+WvJo6IptQOTbBZ+UsIXLRKD3MLy0CDVi7Ti5nQbAdBvS
        4gafu7l01FFdLdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3471013B95;
        Mon, 25 Oct 2021 10:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W1wKDOqBdmE4ZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Oct 2021 10:07:38 +0000
Message-ID: <869ffc61-db52-fa00-b796-6780ab16780d@suse.cz>
Date:   Mon, 25 Oct 2021 12:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/8] mm/page_alloc: Remove the throttling logic from the
 page allocator
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
 <20211022144651.19914-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211022144651.19914-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/21 16:46, Mel Gorman wrote:
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

