Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755843A99B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFPMBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 08:01:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhFPMBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:01:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E6842197A;
        Wed, 16 Jun 2021 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623844780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92Noc+ji9X3hfzxVXbqKDnkao7jlXNF6L8VZO2VgJcs=;
        b=KbCNdOnSSETaRwzOIo5nADriNKb6IhSGZfMka15tkd7Q42eUJRMcPvsjo3LLq2n8K9agL8
        EauOfE9RidbZVQSFP3OlEvZqGxt5wT+ohxAEJ7Na8PJnrK6PrCGDCE1aRfbsAn8rUTfDX6
        ri1P8gBosz+T2xCTAiwHelxp6UFFaFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623844780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92Noc+ji9X3hfzxVXbqKDnkao7jlXNF6L8VZO2VgJcs=;
        b=5/9ZOpOHzACbuRWZlDyfUuiU+SnIjWb2n/tMCBvQBniWFaQbFzaQz3dNlTChqnbt2wxyGg
        NUbaViFIEw5HWoAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5435B118DD;
        Wed, 16 Jun 2021 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623844780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92Noc+ji9X3hfzxVXbqKDnkao7jlXNF6L8VZO2VgJcs=;
        b=KbCNdOnSSETaRwzOIo5nADriNKb6IhSGZfMka15tkd7Q42eUJRMcPvsjo3LLq2n8K9agL8
        EauOfE9RidbZVQSFP3OlEvZqGxt5wT+ohxAEJ7Na8PJnrK6PrCGDCE1aRfbsAn8rUTfDX6
        ri1P8gBosz+T2xCTAiwHelxp6UFFaFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623844780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92Noc+ji9X3hfzxVXbqKDnkao7jlXNF6L8VZO2VgJcs=;
        b=5/9ZOpOHzACbuRWZlDyfUuiU+SnIjWb2n/tMCBvQBniWFaQbFzaQz3dNlTChqnbt2wxyGg
        NUbaViFIEw5HWoAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id m8+iE6znyWDCAgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 16 Jun 2021 11:59:40 +0000
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, nigupta@nvidia.com, hannes@cmpxchg.org,
        corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, aarcange@redhat.com, cl@linux.com,
        xi.fengfei@h3c.com, mchehab+huawei@kernel.org,
        andrew.a.klychkov@gmail.com, dave.hansen@linux.intel.com,
        bhe@redhat.com, iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com,
        sh_def@163.com, vinmenon@codeaurora.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <cover.1622454385.git.charante@codeaurora.org>
 <7db6a29a64b29d56cde46c713204428a4b95f0ab.1622454385.git.charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 1/2] mm: compaction: support triggering of proactive
 compaction by user
Message-ID: <88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz>
Date:   Wed, 16 Jun 2021 13:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7db6a29a64b29d56cde46c713204428a4b95f0ab.1622454385.git.charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/21 12:54 PM, Charan Teja Reddy wrote:
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
> ---
> changes in V2:

You forgot to also summarize the changes. Please do in next version.

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

I don't like the new variable. I wish we could do without it. I understand this
is added to ignore proactive_defer.
We could instead expose proactive_defer in pgdat and reset it to 0 before wakeup
(instead being a thread variable in kcompactd). But that would be racy with the
decreases done by kcompactd.
But I like the patch 2/2 and the idea could be extended to proactive_defer
handling. If there's no proactive_defer, timeout is
HPAGE_FRAG_CHECK_INTERVAL_MSEC. If kcompactd decides to defer, timeout would be
HPAGE_FRAG_CHECK_INTERVAL_MSEC << COMPACT_MAX_DEFER_SHIFT. Thus, no more waking
up just to decrease proactive_defer, we can then get rid of the counter. On
writing new proactiveness just wake up and that's it, regardless of which
timeout there was at the moment.
The only change is, if we get woken up to do non-proactive work, by
wakeup_kcompactd(), the proactive_defer value would be now be effectively lost.
I think it's OK as wakeup_kcompactd() means the condition of the zone changed
substantionally anyway and carrying on with previous defer makes not much sense.
What do you think?

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
> @@ -2917,10 +2943,20 @@ static int kcompactd(void *p)
>  		if (should_proactive_compact_node(pgdat)) {
>  			unsigned int prev_score, score;
>  
> -			if (proactive_defer) {
> +			/*
> +			 * On wakeup of proactive compaction by sysctl
> +			 * write, ignore the accumulated defer score.
> +			 * Anyway, if the proactive compaction didn't
> +			 * make any progress for the new value, it will
> +			 * be further deferred by 2^COMPACT_MAX_DEFER_SHIFT
> +			 * times.
> +			 */
> +			if (proactive_defer &&
> +				!pgdat->proactive_compact_trigger) {
>  				proactive_defer--;
>  				continue;
>  			}
> +
>  			prev_score = fragmentation_score_node(pgdat);
>  			proactive_compact_node(pgdat);
>  			score = fragmentation_score_node(pgdat);
> @@ -2931,6 +2967,8 @@ static int kcompactd(void *p)
>  			proactive_defer = score < prev_score ?
>  					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
>  		}
> +		if (pgdat->proactive_compact_trigger)
> +			pgdat->proactive_compact_trigger = false;
>  	}
>  
>  	return 0;
> 

