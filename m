Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308A242DE53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhJNPlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:41:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNPlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:41:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 762BC2197B;
        Thu, 14 Oct 2021 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634225950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j79xXtrMUi8AABa1kn9QU6pvBky9XIZZKVmd1IQwy20=;
        b=d1AbXgHQpvbbW1RpQOyZ25qrU/AG3uYxYwlF3ustTQmao6u2WhVYBf52PTII8fkNosId37
        8Nel76IHVz/lubHyLhY/BXUAieD3WqODoS3RBZ0ZR//gnjaI7vYsx6LmuG6iHdGzw4ZqBe
        N1R8d/CXNDci2ElK0i/CDd/nyVzH6pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634225950;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j79xXtrMUi8AABa1kn9QU6pvBky9XIZZKVmd1IQwy20=;
        b=WmtmJ76xM1vy2aZBAM/qbzkEZKoSENAiIswo396RSO9AIGi8AT1FwfVnNi1oVvlWdhkyBy
        kZedwg8DFEjzOECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 438D813D9F;
        Thu, 14 Oct 2021 15:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 89x4Dx5PaGGnHwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:39:10 +0000
Message-ID: <d69cce37-e91d-b20b-9f37-4ef1b1c3e46c@suse.cz>
Date:   Thu, 14 Oct 2021 17:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 7/8] mm/vmscan: Increase the timeout if page reclaim is
 not making progress
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
 <20211008135332.19567-8-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211008135332.19567-8-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> Tracing of the stutterp workload showed the following delays
> 
>       1 usect_delayed=124000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=128000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=176000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=536000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=544000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=556000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=624000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=716000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=772000 reason=VMSCAN_THROTTLE_NOPROGRESS
>       2 usect_delayed=512000 reason=VMSCAN_THROTTLE_NOPROGRESS
>      16 usect_delayed=120000 reason=VMSCAN_THROTTLE_NOPROGRESS
>      53 usect_delayed=116000 reason=VMSCAN_THROTTLE_NOPROGRESS
>     116 usect_delayed=112000 reason=VMSCAN_THROTTLE_NOPROGRESS
>    5907 usect_delayed=108000 reason=VMSCAN_THROTTLE_NOPROGRESS
>   71741 usect_delayed=104000 reason=VMSCAN_THROTTLE_NOPROGRESS
> 
> All the throttling hit the full timeout and then there was wakeup delays
> meaning that the wakeups are premature as no other reclaimer such as
> kswapd has made progress. This patch increases the maximum timeout.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e096e81dcbd8..7b54fec4072c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1038,6 +1038,8 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
>  	 */
>  	switch(reason) {
>  	case VMSCAN_THROTTLE_NOPROGRESS:
> +		timeout = HZ/2;
> +		break;
>  	case VMSCAN_THROTTLE_WRITEBACK:
>  		timeout = HZ/10;
>  		break;
> 

