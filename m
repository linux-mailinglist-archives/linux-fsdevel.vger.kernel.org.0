Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083A0394629
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 19:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhE1RFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 13:05:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13003 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236794AbhE1RE4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 13:04:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622221401; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=68ZmfhGkhVwi8fpXi4ry64nVPiXvOTjsPddpfCAGMtI=; b=pq3B8kpV0MyoeJYQ8rPX4urs0Wr7HtL80zeMRbN6gM56BawvL0llVzlHhjTiySyqU0+AbjOn
 ZNFKAd+3OUtr1aH4E/zZGpYyTCl8kZwPrX3nwofoeDmR9/zjoWhbIC7CZK7iQtiUAlri350y
 8k6tTp9ENnrPOmIFBvdBBzs4I9I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60b1221eea2aacd729f89856 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 May 2021 17:02:22
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71346C4323A; Fri, 28 May 2021 17:02:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.158.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB24C433D3;
        Fri, 28 May 2021 17:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB24C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        nigupta@nvidia.com, bhe@redhat.com, mateusznosek0@gmail.com,
        sh_def@163.com, iamjoonsoo.kim@lge.com, vinmenon@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
References: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
 <a29f0cf6-d007-ea17-25b7-642168b6efdd@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <461d3bb1-abed-e6e5-d924-44b4a9243e60@codeaurora.org>
Date:   Fri, 28 May 2021 22:32:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a29f0cf6-d007-ea17-25b7-642168b6efdd@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Vlastimil for your inputs!!

On 5/28/2021 8:49 PM, Vlastimil Babka wrote:
> On 5/18/21 3:37 PM, Charan Teja Reddy wrote:
>> The proactive compaction[1] gets triggered for every 500msec and run
>> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
>> pages based on the value set to sysctl.compaction_proactiveness.
>> Triggering the compaction for every 500msec in search of
>> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
>> especially on the embedded system usecases which may have few MB's of
>> RAM. Enabling the proactive compaction in its state will endup in
>> running almost always on such systems.
>> This triggering of proactive compaction is done on a write to
>> sysctl.compaction_proactiveness by user.
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> Cancelling all current sleeps immediately when the controlling variable changes
> doesn't sound wrong to me.

Agree that cancelling sleeps is not wrong here.

> A question below:
> 
>> ---
>> changes in V2: 
>>     - remove /proc interface trigger for proactive compaction
>>     - Intention is same that add a way to trigger proactive compaction by user.
>>  			if (proactive_defer) {
>>  				proactive_defer--;
>> -				continue;
>> +				goto loop;
> I don't understand this part. If we kick kcompactd from the sysctl handler
> because we are changing proactiveness, shouldn't we also discard any accumulated
> defer score?

Yes, we should be discarding the accumulated defer score when user
changing the proactiveness, even when writing higher proactiveness value
than for which it was deferred. Will raise V3 for this.

> 

--Charan
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Projec t
