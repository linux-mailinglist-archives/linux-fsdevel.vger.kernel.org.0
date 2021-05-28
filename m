Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275613944EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhE1PU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 11:20:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34742 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhE1PUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 11:20:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 297D4218B3;
        Fri, 28 May 2021 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622215157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6chLmJiVPfngVtoOuiXkJhibKoKI1Z0mcSpxFoLAEO0=;
        b=0I2NkE/E2tbZCBqQMU2AaqFOT9qgYDZzA4Rd7KE1e5g6HXPTaxkUumQe6OJ1fYLevSyZVz
        U3dDidhvDu6gJksIlh1OnGFidc9eA7LmdL8T/tEP/zLXEAuBrakksowKsUqAplbK92pIYD
        /MKDpbElkhtubczmsMObQ3+CH5+dq5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622215157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6chLmJiVPfngVtoOuiXkJhibKoKI1Z0mcSpxFoLAEO0=;
        b=RaH83uhsppZPP6az8xJA4xoDDBJ3YX9ZyWC6C+H2OmE25e6WxCeWa3jL9xJwA3g58J1Grj
        vM0rR1JocaBjNVAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8E55E11906;
        Fri, 28 May 2021 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622215156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6chLmJiVPfngVtoOuiXkJhibKoKI1Z0mcSpxFoLAEO0=;
        b=vMi8WxIufMXntdFavFta+efUU1589XCbzj3X/1BQSaIf52uMUiUWk8iwc3gVsTGmntafoo
        TsdtD5Aux6W1iQBnMQR/NwtfPgvVRQZFYRZxEqSbUDaMD6dRZprAPJ6PWJjh3iCjX2U2Lh
        SEpT07aL260zBJlDjhh65+OFOOTXb/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622215156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6chLmJiVPfngVtoOuiXkJhibKoKI1Z0mcSpxFoLAEO0=;
        b=ufdPVlK9iEILtLMAbFsxuReiP3w06diFZ30cQrskibGruW8RbafJjY1jZ4+MYxPPV3/l8m
        yCJ4zKJV9g8CKCDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mb4zIvQJsWBcDQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 15:19:16 +0000
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, nigupta@nvidia.com,
        bhe@redhat.com, mateusznosek0@gmail.com, sh_def@163.com,
        iamjoonsoo.kim@lge.com, vinmenon@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
References: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
Message-ID: <a29f0cf6-d007-ea17-25b7-642168b6efdd@suse.cz>
Date:   Fri, 28 May 2021 17:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[15];
         FREEMAIL_TO(0.00)[codeaurora.org,linux-foundation.org,kernel.org,chromium.org,google.com,nvidia.com,redhat.com,gmail.com,163.com,lge.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC linux-api

On 5/18/21 3:37 PM, Charan Teja Reddy wrote:
> The proactive compaction[1] gets triggered for every 500msec and run
> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
> pages based on the value set to sysctl.compaction_proactiveness.
> Triggering the compaction for every 500msec in search of
> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
> especially on the embedded system usecases which may have few MB's of
> RAM. Enabling the proactive compaction in its state will endup in
> running almost always on such systems.
> 
> Other side, proactive compaction can still be very much useful for
> getting a set of higher order pages in some controllable
> manner(controlled by using the sysctl.compaction_proactiveness). Thus on
> systems where enabling the proactive compaction always may proove not
> required, can trigger the same from user space on write to its sysctl
> interface. As an example, say app launcher decide to launch the memory
> heavy application which can be launched fast if it gets more higher
> order pages thus launcher can prepare the system in advance by
> triggering the proactive compaction from userspace.
> 
> This triggering of proactive compaction is done on a write to
> sysctl.compaction_proactiveness by user.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Cancelling all current sleeps immediately when the controlling variable changes
doesn't sound wrong to me.
A question below:

> ---
> changes in V2: 
>     - remove /proc interface trigger for proactive compaction
>     - Intention is same that add a way to trigger proactive compaction by user.
> 
> changes in V1:
>     -  https://lore.kernel.org/lkml/1619098678-8501-1-git-send-email-charante@codeaurora.org/
> 
>  include/linux/compaction.h |  2 ++
>  include/linux/mmzone.h     |  1 +
>  kernel/sysctl.c            |  2 +-
>  mm/compaction.c            | 35 ++++++++++++++++++++++++++++++++---
>  4 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 4221888..04d5d9f 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -84,6 +84,8 @@ static inline unsigned long compact_gap(unsigned int order)
>  extern unsigned int sysctl_compaction_proactiveness;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
> +extern int compaction_proactiveness_sysctl_handler(struct ctl_table *table,
> +		int write, void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
>  extern int sysctl_compact_unevictable_allowed;
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0d53eba..9455809 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -815,6 +815,7 @@ typedef struct pglist_data {
>  	enum zone_type kcompactd_highest_zoneidx;
>  	wait_queue_head_t kcompactd_wait;
>  	struct task_struct *kcompactd;
> +	bool proactive_compact_trigger;
>  #endif
>  	/*
>  	 * This is a per-node reserve of pages that are not available
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 14edf84..bed2fad 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2840,7 +2840,7 @@ static struct ctl_table vm_table[] = {
>  		.data		= &sysctl_compaction_proactiveness,
>  		.maxlen		= sizeof(sysctl_compaction_proactiveness),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= compaction_proactiveness_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &one_hundred,
>  	},
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 84fde27..9056693 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2708,6 +2708,30 @@ static void compact_nodes(void)
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
>  
> +int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
> +		void *buffer, size_t *length, loff_t *ppos)
> +{
> +	int rc, nid;
> +
> +	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
> +	if (rc)
> +		return rc;
> +
> +	if (write && sysctl_compaction_proactiveness) {
> +		for_each_online_node(nid) {
> +			pg_data_t *pgdat = NODE_DATA(nid);
> +
> +			if (pgdat->proactive_compact_trigger)
> +				continue;
> +
> +			pgdat->proactive_compact_trigger = true;
> +			wake_up_interruptible(&pgdat->kcompactd_wait);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * This is the entry point for compacting all nodes via
>   * /proc/sys/vm/compact_memory
> @@ -2752,7 +2776,8 @@ void compaction_unregister_node(struct node *node)
>  
>  static inline bool kcompactd_work_requested(pg_data_t *pgdat)
>  {
> -	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
> +	return pgdat->kcompactd_max_order > 0 || kthread_should_stop() ||
> +		pgdat->proactive_compact_trigger;
>  }
>  
>  static bool kcompactd_node_suitable(pg_data_t *pgdat)
> @@ -2905,7 +2930,8 @@ static int kcompactd(void *p)
>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>  		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
>  			kcompactd_work_requested(pgdat),
> -			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC)) &&
> +			!pgdat->proactive_compact_trigger) {
>  
>  			psi_memstall_enter(&pflags);
>  			kcompactd_do_work(pgdat);
> @@ -2919,7 +2945,7 @@ static int kcompactd(void *p)
>  
>  			if (proactive_defer) {
>  				proactive_defer--;
> -				continue;
> +				goto loop;

I don't understand this part. If we kick kcompactd from the sysctl handler
because we are changing proactiveness, shouldn't we also discard any accumulated
defer score?

>  			}
>  			prev_score = fragmentation_score_node(pgdat);
>  			proactive_compact_node(pgdat);
> @@ -2931,6 +2957,9 @@ static int kcompactd(void *p)
>  			proactive_defer = score < prev_score ?
>  					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
>  		}
> +loop:
> +		if (pgdat->proactive_compact_trigger)
> +			pgdat->proactive_compact_trigger = false;
>  	}
>  
>  	return 0;
> 

