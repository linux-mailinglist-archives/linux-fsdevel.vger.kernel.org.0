Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9419042DE72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJNPnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:43:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51374 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhJNPnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:43:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BBC22197B;
        Thu, 14 Oct 2021 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634226078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEsEtocmA/7tqkQKeziK3eedh4hAIlcY+2qkVb6Er6M=;
        b=vg18iST+sUHwjVOhDlwp6jEiqeTTr1OBUH1Kv/ORi9IVNBzewLXEIcKyGboshj82p4+XoF
        KkacC/Bsj8pscxTnwLwX/pov5s+dGOjPzw/NkyujkqQXiuAD/icRMrwVhggebRC4IEECD3
        5ldzJw/mgGSfLx9XcXix2HgRIXVGyQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634226078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEsEtocmA/7tqkQKeziK3eedh4hAIlcY+2qkVb6Er6M=;
        b=eT8brfy1cCD8SiYsNBf3zG9lXyuWpUvLPlR2rztiaz2dQo7J/qfW6yhosEDdQfuAKW+fRa
        tZl2x/IFIV0B/BCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AB9E13D9F;
        Thu, 14 Oct 2021 15:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1H6LEZ5PaGHlIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:41:18 +0000
Message-ID: <f28a74c8-69c5-fd65-778f-48e68aed99df@suse.cz>
Date:   Thu, 14 Oct 2021 17:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 8/8] mm/vmscan: Delay waking of tasks throttled on
 NOPROGRESS
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
 <20211008135332.19567-9-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211008135332.19567-9-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> Tracing indicates that tasks throttled on NOPROGRESS are woken
> prematurely resulting in occasional massive spikes in direct
> reclaim activity. This patch wakes tasks throttled on NOPROGRESS
> if reclaim efficiency is at least 12%.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7b54fec4072c..80a9a26f701f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3338,8 +3338,11 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
>  
>  static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
>  {
> -	/* If reclaim is making progress, wake any throttled tasks. */
> -	if (sc->nr_reclaimed) {
> +	/*
> +	 * If reclaim is making progress greater than 12% efficiency then
> +	 * wake all the NOPROGRESS throttled tasks.
> +	 */
> +	if (sc->nr_reclaimed > (sc->nr_scanned >> 3)) {
>  		wait_queue_head_t *wqh;
>  
>  		wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_NOPROGRESS];
> 

