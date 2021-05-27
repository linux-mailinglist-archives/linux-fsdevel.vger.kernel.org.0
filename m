Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C4392AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 11:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhE0J3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 05:29:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52131 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhE0J3y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 05:29:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622107701; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=WkY2YTOgRI4Ys9jejhJv/SZd6Pl6W+z9jTGwMepK7Jc=; b=NjoJkB6hiSSpLZwqLNqtWkos6RMie6N2YYHgz7bxNdTejdQAwfA5sQ+5ZMzyma2olOqYRxPL
 1ALFO2MRTrRnR7ATprHbHuZwHG8EKwV4dtEEJqY3Cm62BxuBsBa+pYmnMmgYSqhAf2utNRaP
 yUbURwkL8V65za/BhaoNGTIHDHg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60af662c5f788b52a508b26e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 May 2021 09:28:12
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E385C43143; Thu, 27 May 2021 09:28:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.159.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC715C433F1;
        Thu, 27 May 2021 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC715C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
To:     Nitin Gupta <nigupta@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
 <BYAPR12MB3416727DB2BE2198C324124CD8259@BYAPR12MB3416.namprd12.prod.outlook.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <2733c513-d9ca-9c33-42ee-38df0a057f8a@codeaurora.org>
Date:   Thu, 27 May 2021 14:58:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3416727DB2BE2198C324124CD8259@BYAPR12MB3416.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Nitin for your inputs!!

On 5/26/2021 2:05 AM, Nitin Gupta wrote:
> The proactive compaction[1] gets triggered for every 500msec and run
> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
> pages based on the value set to sysctl.compaction_proactiveness.
> Triggering the compaction for every 500msec in search of
> 
> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
>> especially on the embedded system usecases which may have few MB's of
>> RAM. Enabling the proactive compaction in its state will endup in running
>> almost always on such systems.
>>
> You can disable proactive compaction by setting sysctl.compaction_proactiveness to 0.

Agree. But proactive compaction got its own uses too like it knows when
to stop the compaction, instead of simply doing the full node
compaction, thus we don't want to disable it always.

> 
> 
>> As an example, say app
>> launcher decide to launch the memory heavy application which can be
>> launched fast if it gets more higher order pages thus launcher can prepare
>> the system in advance by triggering the proactive compaction from
>> userspace.
>>
> You can always do: echo 1 > /proc/sys/vm/compact_memory
> On a small system, this should not take much time.

Hmm... With 3GB Snapdragon system, we have observed that write to
compact_memory is taking peak time of 400+msec, could be that
MIGRATE_SYNC on a full node is causing this peak, which is much time.


> 
> Hijacking proactive compaction for one-off compaction (say, before a large app launch)
> does not sound right to me.

Actually we are using the proactive compaction to 'just prepare the
system before asking for huge memory' as compact_memory can take longer
and is not controllable like proactive compaction.

In the V1 of this patch, we actually created a /proc interface(similar
to compact_memory), providing a way to trigger the proactive compaction
from user space. https://lore.kernel.org/patchwork/patch/1417064/. But
since this involved a new /proc interface addition, in V2 we just
implemented an alternative way to it.

Another problem, I think, this patch tried to address is that, in the
existing implementation it is not guaranteed the user set value of
compaction_proactiveness is effective unless atleast
HPAGE_FRAG_CHECK_INTERVAL_MSEC(500msec) is elapsed, Right? Does this
seems correct provided we had given this user interface and can't
specified any where when this value will be effective(where it comes
into effect in the next compact thread wake up for proactive compaction).

Consider the below testcase where a user thinks that the application he
is going to run is performance critical thus decides to do the below steps:
1) Save the present the compaction_proactiveness (Say it is zero thus
disabled)
2) Set the compaction_proactiveness to 100.
3) Allocate memory for the application.
4) Restore the compaction_proactiveness.(set to disabled again)
5) Then proactive compaction is tried to run.

First, Does the user doing the above steps are valid?
If yes, then we should guarantee to the user that proactive compaction
atleast tried to run when the user changed the proactiveness.
If not, I feel, we should document that 'once user changed the
compaction_proactiveness, he need to wait atleast
HPAGE_FRAG_CHECK_INTERVAL_MSEC before considering that the value he
tried to set is effective and proactive compaction tried to run on
that'. Doesn't this seem okay?

--Charan
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
