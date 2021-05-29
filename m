Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F87394A03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 May 2021 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE2C7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 22:59:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44602 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2C7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 22:59:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622257090; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=UQqC9SGA/mI3zwU5m0sSjfH4Zy9TonhCXautmNeV5Uk=; b=MUrBALKW1Ogytx/uM/KVt12/2wOqrQvAl4IwA8aD1fMDSSFKSR80xnGFKwl+j7PtWSO0at2I
 F9NecCnUaHmyJ2yTvN+HRpbdvN8IpdPGlEnFfhY8G4kbJRzo4IEdERwbYvL5Koiun5Qz7QYX
 PsRRKXQycq8aoG/VoCEtPmHHFyg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60b1adaef726fa4188ae01a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 29 May 2021 02:57:50
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86530C43147; Sat, 29 May 2021 02:57:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.157.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50008C433F1;
        Sat, 29 May 2021 02:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50008C433F1
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
 <2733c513-d9ca-9c33-42ee-38df0a057f8a@codeaurora.org>
 <BYAPR12MB34163A80AD9567746F7904CDD8239@BYAPR12MB3416.namprd12.prod.outlook.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <c8e7f2dd-c6ca-6b1d-0a92-52a24771a15f@codeaurora.org>
Date:   Sat, 29 May 2021 08:27:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB34163A80AD9567746F7904CDD8239@BYAPR12MB3416.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Nitin for your inputs.

On 5/28/2021 5:22 AM, Nitin Gupta wrote:
>> First, Does the user doing the above steps are valid?
>> If yes, then we should guarantee to the user that proactive compaction
>> atleast tried to run when the user changed the proactiveness.
>> If not, I feel, we should document that 'once user changed the
>> compaction_proactiveness, he need to wait atleast
>> HPAGE_FRAG_CHECK_INTERVAL_MSEC before considering that the value he
>> tried to set is effective and proactive compaction tried to run on that'.
>> Doesn't this seem okay?
> Proactive compaction does not guarantee if the kernel will be able to achieve
> fragmentation targets implied from the compaction_proactiveness sysctl. It also
> does not guarantee how much time it will take to reach desired fragmentation
> levels (if at all possible). 

Shouldn't we add these lines in the Documentation. Will raise a patch If
it is fine.


> Maybe add a Kconfig parameter for setting
> HPAGE_FRAG_CHECK_INTERVAL_MSEC to say 1msec?

I really don't have an use case to make the
HPAGE_FRAG_CHECK_INTERVAL_MSEC as config option. But should we make it
as Kconfig option and let the user decide how aggressively proactive
compaction should do the job of system defragmentation in his system?
Selection will be limited in the range of 10msec to 500msec, defaults to
500msec.

--Thanks

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
