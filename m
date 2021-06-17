Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576D53AAD98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFQHcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 03:32:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62498 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhFQHcs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:32:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623915040; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=/Ke8K41Ww1WXgC0r6DX1WkuK3ujBCCEjuiXUNiIGjTs=; b=U4ydUD+y0WFxuGLzPpNe9YGUwiUDG5/M7v4OyVjlko2N9IFQyioBLwsxWTwzLg/4rEt9FBlq
 XGAeFMDoDgiTlUQSADq/Z/PcPtxxzyad6sk3Yt3GUAgty1Qajpk5WokXCxNd+nmgTq4MLcgy
 rZ6a9MQlOQZLhd2UF/O/ivCh0SA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60cafa11e27c0cc77f19d764 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Jun 2021 07:30:25
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95D30C433D3; Thu, 17 Jun 2021 07:30:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.156.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEB16C433F1;
        Thu, 17 Jun 2021 07:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEB16C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH v3 1/2] mm: compaction: support triggering of proactive
 compaction by user
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        nigupta@nvidia.com, hannes@cmpxchg.org, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        aarcange@redhat.com, cl@linux.com, xi.fengfei@h3c.com,
        mchehab+huawei@kernel.org, andrew.a.klychkov@gmail.com,
        dave.hansen@linux.intel.com, bhe@redhat.com,
        iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com, sh_def@163.com,
        vinmenon@codeaurora.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <cover.1622454385.git.charante@codeaurora.org>
 <7db6a29a64b29d56cde46c713204428a4b95f0ab.1622454385.git.charante@codeaurora.org>
 <88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <0ca491e8-6d3a-6537-dfa0-ece5f3bb6a1e@codeaurora.org>
Date:   Thu, 17 Jun 2021 13:00:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Vlastimil for your inputs!!

On 6/16/2021 5:29 PM, Vlastimil Babka wrote:
>> This triggering of proactive compaction is done on a write to
>> sysctl.compaction_proactiveness by user.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>> changes in V2:
> You forgot to also summarize the changes. Please do in next version.

Sure. Will take care this in the next version.

> 
>>   */
>>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
>>  
>> +int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
>> +		void *buffer, size_t *length, loff_t *ppos)
>> +{
>> +	int rc, nid;
>> +
>> +	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (write && sysctl_compaction_proactiveness) {
>> +		for_each_online_node(nid) {
>> +			pg_data_t *pgdat = NODE_DATA(nid);
>> +
>> +			if (pgdat->proactive_compact_trigger)
>> +				continue;
>> +
>> +			pgdat->proactive_compact_trigger = true;
> I don't like the new variable. I wish we could do without it. I understand this
> is added to ignore proactive_defer.
> We could instead expose proactive_defer in pgdat and reset it to 0 before wakeup
> (instead being a thread variable in kcompactd). But that would be racy with the
> decreases done by kcompactd.
> But I like the patch 2/2 and the idea could be extended to proactive_defer
> handling. If there's no proactive_defer, timeout is
> HPAGE_FRAG_CHECK_INTERVAL_MSEC. If kcompactd decides to defer, timeout would be
> HPAGE_FRAG_CHECK_INTERVAL_MSEC << COMPACT_MAX_DEFER_SHIFT. Thus, no more waking
> up just to decrease proactive_defer, we can then get rid of the counter. On
> writing new proactiveness just wake up and that's it, regardless of which
> timeout there was at the moment.

I think we can get rid off 'proactive_defer' thread variable with the
timeout approach you suggested. But it is still requires to have one
additional variable 'proactive_compact_trigger', which main purpose is
to decide if the kcompactd wakeup is for proactive compaction or not.
Please see below code:
   if (wait_event_freezable_timeout() && !proactive_compact_trigger) {
	// do the non-proactive work
	continue
   }
   // do the proactive work
     .................

Thus I feel that on writing new proactiveness, it is required to do
wakeup_kcomppactd() + set a flag that this wakeup is for proactive work.

Am I failed to get your point here?


> The only change is, if we get woken up to do non-proactive work, by
> wakeup_kcompactd(), the proactive_defer value would be now be effectively lost.
> I think it's OK as wakeup_kcompactd() means the condition of the zone changed
> substantionally anyway and carrying on with previous defer makes not much sense.
> What do you think?

Agree.

> 
>> +			wake_up_interruptible(&pgdat->kcompactd_wait);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * This is the entry point for compacting all nodes via
>>   * /proc/sys/vm/compact_memory
>> @@ -2752,7 +2776,8 @@ void compaction_unregister_node(struct node *node)
>>  
>>  static inline bool kcompactd_work_requested(pg_data_t *pgdat)
>>  {
>> -	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
>> +	return pgdat->kcompactd_max_order > 0 || kthread_should_stop() ||
>> +		pgdat->proactive_compact_trigger;
>>  }
>>  
>>  static bool kcompactd_node_suitable(pg_data_t *pgdat)
>> @@ -2905,7 +2930,8 @@ static int kcompactd(void *p)
>>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>>  		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
>>  			kcompactd_work_requested(pgdat),
>> -			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
>> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC)) &&
>> +			!pgdat->proactive_compact_trigger) {
>>  
>>  			psi_memstall_enter(&pflags);
>>  			kcompactd_do_work(pgdat);
>> @@ -2917,10 +2943,20 @@ static int kcompactd(void *p)
>>  		if (should_proactive_compact_node(pgdat)) {
>>  			unsigned int prev_score, score;
>>  
>> -			if (proactive_defer) {
>> +			/*
>> +			 * On wakeup of proactive compaction by sysctl
>> +			 * write, ignore the accumulated defer score.
>> +			 * Anyway, if the proactive compaction didn't
>> +			 * make any progress for the new value, it will
>> +			 * be further deferred by 2^COMPACT_MAX_DEFER_SHIFT
>> +			 * times.
>> +			 */
>> +			if (proactive_defer &&
>> +				!pgdat->proactive_compact_trigger) {
>>  				proactive_defer--;
>>  				continue;
>>  			}
>> +
>>  			prev_score = fragmentation_score_node(pgdat);
>>  			proactive_compact_node(pgdat);
>>  			score = fragmentation_score_node(pgdat);
>> @@ -2931,6 +2967,8 @@ static int kcompactd(void *p)
>>  			proactive_defer = score < prev_score ?
>>  					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
>>  		}
>> +		if (pgdat->proactive_compact_trigger)
>> +			pgdat->proactive_compact_trigger = false;
>>  	}
>>  
>>  	return 0;

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
