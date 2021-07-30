Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA43DBAFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhG3Oqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 10:46:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50011 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbhG3Oqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:46:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627656400; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=lpsMp8nA04lN8qY1AphLLtY4CXCE1cSpSalnWmM+VjA=; b=H+AtjVYjMnt6cuD7Ok1vBg9K3Q+QfAxXssiuQDxmBZVL5SzohZl38sJV6KrdHGpc/ipcXDmH
 sRIMFSiCZmzPo41XMhcpXpUoVA5LZT5/C1n6qqFdGaDyCb9Cfo7mHC4QJE6/SDWaD+UCARfi
 Zs/rUKwoNYwgW3ZG9yIdTfifLqc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 610410bc17c2b4047d7060be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 14:46:20
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33ED4C43145; Fri, 30 Jul 2021 14:46:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.158.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BD52C433F1;
        Fri, 30 Jul 2021 14:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BD52C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V5] mm: compaction: support triggering of proactive
 compaction by user
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, mgorman@techsingularity.net,
        nigupta@nvidia.com, corbet@lwn.net, rppt@kernel.org,
        khalid.aziz@oracle.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1627653207-12317-1-git-send-email-charante@codeaurora.org>
 <8fe4ba65-28e1-02d8-cf4d-74aaa76fe9df@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <690ffed8-9c2a-1a9e-e592-a103b09e05a7@codeaurora.org>
Date:   Fri, 30 Jul 2021 20:16:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8fe4ba65-28e1-02d8-cf4d-74aaa76fe9df@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Vlastimil!!

On 7/30/2021 7:36 PM, Vlastimil Babka wrote:
>> The proactive compaction[1] gets triggered for every 500msec and run
>> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
>> pages based on the value set to sysctl.compaction_proactiveness.
>> Triggering the compaction for every 500msec in search of
>> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
>> especially on the embedded system usecases which may have few MB's of
>> RAM. Enabling the proactive compaction in its state will endup in
>> running almost always on such systems.
>>
>> Other side, proactive compaction can still be very much useful for
>> getting a set of higher order pages in some controllable
>> manner(controlled by using the sysctl.compaction_proactiveness). So, on
>> systems where enabling the proactive compaction always may proove not
>> required, can trigger the same from user space on write to its sysctl
>> interface. As an example, say app launcher decide to launch the memory
>> heavy application which can be launched fast if it gets more higher
>> order pages thus launcher can prepare the system in advance by
>> triggering the proactive compaction from userspace.
>>
>> This triggering of proactive compaction is done on a write to
>> sysctl.compaction_proactiveness by user.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks for the tag here.

> 
>> @@ -2895,9 +2920,16 @@ static int kcompactd(void *p)
>>  	while (!kthread_should_stop()) {
>>  		unsigned long pflags;
>>  
>> +		/*
>> +		 * Avoid the unnecessary wakeup for proactive compaction
>> +		 * when it is disabled.
>> +		 */
>> +		if (!sysctl_compaction_proactiveness)
>> +			timeout = MAX_SCHEDULE_TIMEOUT;
> Does this part actually logically belong more to your previous patch that
> optimized the deferred timeouts?

IMO, it won't fit there. Reason is that when user writes
sysctl_compaction_proactiveness = 0, it will goes to sleep with
MAX_SCHEDULE_TIMEOUT. Say now user writes non-zero value to
sysctl_compaction_proactiveness then no condition is there to wake it up
for proactive compaction, means, it will still be in sleep with
MAX_SCHEDULE_TIMEOUT.

Thus this logic is put in this patch, where, proactive compaction work
will be scheduled immediately on switch of proactiveness value from zero
to a non-zero.

> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
