Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6A36DBB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhD1PeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 11:34:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37875 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhD1PeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:34:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619624004; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+uEHZQCoId6Z6PN43bKUgIGsM7RbOOikbjeOmDhDNZw=; b=j/Jd2LPBF5MjFK9LqrzuzPo3ONy1SIqnadK1QSsfTtILeJxkA9/cUf34asnRm7L6K5vmPLDq
 jUbMAaHth3tkIOGNYdj7pYnO5DiM6x05HfORWT6pZvwRebzqQ+cUWedShdJrxvDOdFRxU7Tt
 6WBmA+nGGyjd9CjDdiTw4BN+9k8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60898026853c0a2c468b6010 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Apr 2021 15:32:54
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0F6DC4338A; Wed, 28 Apr 2021 15:32:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.159.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0902EC433D3;
        Wed, 28 Apr 2021 15:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0902EC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm: compaction: improve /proc trigger for full node
 memory compaction
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, bhe@redhat.com,
        nigupta@nvidia.com, khalid.aziz@oracle.com,
        mateusznosek0@gmail.com, sh_def@163.com, iamjoonsoo.kim@lge.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        vinmenon@codeaurora.org
References: <1619098678-8501-1-git-send-email-charante@codeaurora.org>
 <20210427080921.GG4239@techsingularity.net>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <9afd1ae1-bee8-a4cc-1cd6-df92090abeb4@codeaurora.org>
Date:   Wed, 28 Apr 2021 21:02:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427080921.GG4239@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Mel for your comments!!

On 4/27/2021 1:39 PM, Mel Gorman wrote:
>> The existing /proc/sys/vm/compact_memory interface do the full node
>> compaction when user writes an arbitrary value to it and is targeted for
>> the usecases like an app launcher prepares the system before the target
>> application runs.
> The intent behind compact_memory was a debugging interface to tell
> the difference between an application failing to allocate a huge page
> prematurely and the inability of compaction to find a free page.
> 

Thanks for clarifying this.

>> This patch adds a new /proc interface,
>> /proc/sys/vm/proactive_compact_memory, and on write of an arbitrary
>> value triggers the full node compaction but can be stopped in the middle
>> if sufficient higher order(COMPACTION_HPAGE_ORDER) pages available in
>> the system. The availability of pages that a user looking for can be
>> given as input through /proc/sys/vm/compaction_proactiveness.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> Hence, while I do not object to the patch as-such, I'm wary of the trend
> towards improving explicit out-of-band compaction via proc interfaces. I

I think people relying on this /proc/../compact_memory for reasons of on
demand compaction effects the performance and the kcompactd returns when
 even a single page of the order we are looking for is available. Say
that If an app launching completion is relied on the memory
fragmentation, meaning that lesser the system fragmented, lesser it
needs to spend time on allocation as it gets more higher order pages.
With the current compaction methods we may get just one higher order
page at a time (as compaction stops run after that) thus can effect its
launch completion time. The compact_memory node can help in these
situation where the system administrator can defragment system whenever
is required by writing to the compact_node. This is just a theoretical
example.

Although it is intended for debugging interface, it got a lot of other
applications too.

This patch aims to improve this interface by taking help from tunables
provided by the proactive compaction.

> would have preferred if the focus was on reducing the cost of compaction
> so that direct allocation requests succeed quickly or improving background
> compaction via kcompactd when there has been recent failures.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
