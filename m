Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138EA3CB63A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhGPKrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:47:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23899 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238337AbhGPKrW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:47:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626432267; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fRfzqitEiF6pl1t4p+k88/o5RHLLygqMeNZ3f4gZTbw=; b=MSVHG7H6mEwwIIPhY28AIAyn3+urd07gCK2vUDEFR6xbU1TQGX48Me9naTVp25q9caQdfZoS
 8uBm0WzW1GG49tiIcblESupjfSOc8+9q6jTIqYkCz94GJsDHpWfXo3cQMl/6sds4Cgz6Kw3m
 OmElvmUIzC8NgQX3WZJlokdpvTE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60f162fc4815712f3ac18cfa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Jul 2021 10:44:12
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CBDEBC4323A; Fri, 16 Jul 2021 10:44:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.159.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D607FC433D3;
        Fri, 16 Jul 2021 10:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D607FC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V4,0/3] mm: compaction: proactive compaction trigger by
 user
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vbabka@suse.cz, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        rientjes@google.com, mchehab+huawei@kernel.org,
        lokeshgidra@google.com, andrew.a.klychkov@gmail.com,
        xi.fengfei@h3c.com, nigupta@nvidia.com,
        dave.hansen@linux.intel.com, famzheng@amazon.com,
        mateusznosek0@gmail.com, oleksandr@redhat.com, sh_def@163.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
 <c0150787-5f85-29ac-9666-05fabedabb1e@codeaurora.org>
 <20210715212744.1a43012c21711bafd25e5b68@linux-foundation.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <f24af677-1005-b14c-4bbe-f41feefe172b@codeaurora.org>
Date:   Fri, 16 Jul 2021 16:14:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715212744.1a43012c21711bafd25e5b68@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Andrew for the reply!!

On 7/16/2021 9:57 AM, Andrew Morton wrote:
> On Sat, 3 Jul 2021 15:52:10 +0530 Charan Teja Kalla <charante@codeaurora.org> wrote:
> 
>> A gentle ping to have your valuable comments.
> 
> Can we please have a resend?
> 
> The series has two fixes against the current code.  Please separate
> that work out from the new feature.  So a 2-patch series to fix the bugs
> followed by a single patch to add your new feature.

https://lore.kernel.org/patchwork/patch/1448789/ -- Can go as a separate
bug fix.

https://lore.kernel.org/patchwork/patch/1448793/ -- is the second bug
fix which is tightly coupled with the feature of explicitly waking of
kcompactd on the event of change in compaction proactiveness, when it is
sleeping with MAX_SCHEDULE_TIMEOUT.

So, will make the changes with 1 patch bug fix and 2nd patch feature
where the second bug fix also clubbed.

I hope this is fine.
> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
