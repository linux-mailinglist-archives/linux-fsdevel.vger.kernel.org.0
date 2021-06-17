Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4C3AB88D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhFQQIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:08:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31366 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhFQQIX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623945975; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=S/3+eYb013cEoEfSg59q8XR8ipiEIZP75HRjgZgsG1U=; b=uK5BqNJSto+JW/QeIlceFm5Mbkz0gkTe8/EWcDcqd2GnpmENnI3mLV6La/XvG6e/QWo9FyP4
 hMTgDYOPakcoNUOTepVUhfPwllXUlEZ+6cQAduw2y12nLqQAQjBnW3WyvHUfAJBAcI4Wmlp5
 pnFLuXBV2i63AummPikSG62Pyq8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60cb72ebed59bf69ccf5ba78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Jun 2021 16:06:03
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 507A4C433F1; Thu, 17 Jun 2021 16:06:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.156.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25F4FC433F1;
        Thu, 17 Jun 2021 16:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25F4FC433F1
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
 <0ca491e8-6d3a-6537-dfa0-ece5f3bb6a1e@codeaurora.org>
 <0d516cfa-f41c-5ccc-26aa-67871f23dcd3@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <8d91a81b-09f3-e814-c9ce-16ff246ed359@codeaurora.org>
Date:   Thu, 17 Jun 2021 21:35:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0d516cfa-f41c-5ccc-26aa-67871f23dcd3@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Vlastimil !!

On 6/17/2021 8:07 PM, Vlastimil Babka wrote:
> On 6/17/21 9:30 AM, Charan Teja Kalla wrote:
>> Thanks Vlastimil for your inputs!!
>>
>> On 6/16/2021 5:29 PM, Vlastimil Babka wrote:
>>>> This triggering of proactive compaction is done on a write to
>>>> sysctl.compaction_proactiveness by user.
>>>>
>>>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
>>>>
>>>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>>>> ---
>>>> changes in V2:
>>> You forgot to also summarize the changes. Please do in next version.
>>
>> I think we can get rid off 'proactive_defer' thread variable with the
>> timeout approach you suggested. But it is still requires to have one
>> additional variable 'proactive_compact_trigger', which main purpose is
>> to decide if the kcompactd wakeup is for proactive compaction or not.
>> Please see below code:
>>    if (wait_event_freezable_timeout() && !proactive_compact_trigger) {
>> 	// do the non-proactive work
>> 	continue
>>    }
>>    // do the proactive work
>>      .................
>>
>> Thus I feel that on writing new proactiveness, it is required to do
>> wakeup_kcomppactd() + set a flag that this wakeup is for proactive work.
>>
>> Am I failed to get your point here?
> 
> The check whether to do non-proactive work is already guarded by
> kcompactd_work_requested(), which looks at pgdat->kcompactd_max_order and this
> is set by wakeup_kcompactd().
> 
> So with a plain wakeup where we don't set pgdat->kcompactd_max_order will make
> it consider proactive work instead and we don't need another trigger variable
> AFAICS.

The wait_event/freezable_timeout() documentation says that:
 * Returns:
 * 0 if the @condition evaluated to %false after the @timeout elapsed,
			or
 * 1 if the @condition evaluated to %true after the @timeout elapsed,
 * or the remaining jiffies (at least 1) if the @condition evaluated
 * to %true before the @timeout elapsed.

which means the condition must be evaluated to true or timeout should be
elapsed for the function wait_event_freezable_timeout() to return.

Please check the macro implementation of __wait_event, where it will be
in for(;;) till the condition is evaluated to true or timeout happens.
#define __wait_event_freezable_timeout(wq_head, condition, timeout)

        ___wait_event(wq_head, ___wait_cond_timeout(condition),

                      TASK_INTERRUPTIBLE, 0, timeout,

                      __ret = freezable_schedule_timeout(__ret))

Thus the plain wakeup of kcompactd don't do the proactive compact work.
And so we should identify its wakeup for proactive work with a separate
flag.
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
