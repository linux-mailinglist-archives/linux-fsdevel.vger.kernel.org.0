Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED34242DE36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhJNPgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:36:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57002 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhJNPgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:36:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8ABC1FD3C;
        Thu, 14 Oct 2021 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634225682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSq5ptbvrWE/9u83361E4QAaf4yB/DROBMgoAb6pL8w=;
        b=POWMIGPQ4r7BOmmAbumhlw45VMBqKqkvgGUD6siLJfp+5yYk+xAgZPtTuDivBnusGMrLRL
        +6rdvnXMtr9alOFVTerJ4+paqp9rVrj9jhpjCdHL9bhE8lRPgwF2KmNEqGtUaBcQDZnVeS
        9C7ZS5gtSrAaH4avOpBoyACbbhAVmXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634225682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSq5ptbvrWE/9u83361E4QAaf4yB/DROBMgoAb6pL8w=;
        b=BJwII89kUlyU/1vQJNfVlrdx0HDpTDhd2fjXcjOvj6Sfb5zD84iug0bBXWEoieO2Agfvd7
        3I4mBzKmGkcGweBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70E1E13D9F;
        Thu, 14 Oct 2021 15:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CVXCGhJOaGF/HQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:34:42 +0000
Message-ID: <cd48c298-fef9-cae8-1148-014c70e37417@suse.cz>
Date:   Thu, 14 Oct 2021 17:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/8] mm/writeback: Throttle based on page writeback
 instead of congestion
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
 <20211008135332.19567-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211008135332.19567-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> do_writepages throttles on congestion if the writepages() fails due to a
> lack of memory but congestion_wait() is partially broken as the congestion
> state is not updated for all BDIs.
> 
> This patch stalls waiting for a number of pages to complete writeback
> that located on the local node. The main weakness is that there is no
> correlation between the location of the inode's pages and locality but
> that is still better than congestion_wait.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page-writeback.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 4812a17b288c..f34f54fcd5b4 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2366,8 +2366,15 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  			ret = generic_writepages(mapping, wbc);
>  		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
>  			break;
> -		cond_resched();
> -		congestion_wait(BLK_RW_ASYNC, HZ/50);
> +
> +		/*
> +		 * Lacking an allocation context or the locality or writeback
> +		 * state of any of the inode's pages, throttle based on
> +		 * writeback activity on the local node. It's as good a
> +		 * guess as any.
> +		 */
> +		reclaim_throttle(NODE_DATA(numa_node_id()),
> +			VMSCAN_THROTTLE_WRITEBACK, HZ/50);
>  	}
>  	/*
>  	 * Usually few pages are written by now from those we've just submitted
> 

