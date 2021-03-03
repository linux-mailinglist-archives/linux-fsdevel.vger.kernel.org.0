Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F0E32C56A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378893AbhCDAUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:37 -0500
Received: from z11.mailgun.us ([104.130.96.11]:50843 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577515AbhCCRsr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:48:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614793709; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Fcd2CI16BjPfDlrMPeOLMsbcVTQCVnoyX8FWXapXUqY=;
 b=O1JoxqTOaN4V3FMn/0pWVqAUs0Cgx3FFloemVyU8uDwLDHRzF74BUqv0NWDaUrSQO2GBrrAV
 0Jc737zAkaxYacY5L/Vs4ioPrusFWAaRo1iBn1JzmJOzn7BHmwVSaWS2Luv4vDVP7ocdgtiE
 ov6jl3Bn86WGSVmE4YalpcTTwfg=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 603fcbc6c862e1b9fdb26fda (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 17:47:50
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4B74C433CA; Wed,  3 Mar 2021 17:47:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 708BEC433ED;
        Wed,  3 Mar 2021 17:47:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 23:17:49 +0530
From:   pintu@codeaurora.org
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        iamjoonsoo.kim@lge.com, sh_def@163.com, mateusznosek0@gmail.com,
        bhe@redhat.com, nigupta@nvidia.com, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org,
        mgorman@techsingularity.net, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
In-Reply-To: <486d7af3-95a3-9701-f0f9-706ff49b99d1@suse.cz>
References: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
 <486d7af3-95a3-9701-f0f9-706ff49b99d1@suse.cz>
Message-ID: <c99eb67f67e4e24b4df1a78a583837b1@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-03 22:39, Vlastimil Babka wrote:
> On 3/2/21 6:56 PM, Pintu Kumar wrote:
>> The sysctl_compact_memory is mostly unsed in mm/compaction.c
>> It just acts as a place holder for sysctl.
>> 
>> Thus we can remove it from here and move the declaration directly
>> in kernel/sysctl.c itself.
>> This will also eliminate the extern declaration from header file.
>> No functionality is broken or changed this way.
>> 
>> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
>> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> 
> You should be able to remove the variable completely and set .data to 
> NULL in
> the corresponding entry. The sysctl_compaction_handler doesn't access 
> it at all.
> 
> Then you could do the same with drop_caches. Currently
> drop_caches_sysctl_handler currently writes to it, but that can be 
> avoided using
> a local variable - see how sysrq_sysctl_handler avoids the global 
> variable and
> its corresponding .data field is NULL.
> 

Oh yes, thank you so much for the reference.
Yes I was looking to do something similar but didn't realize that is 
possible.
I will re-submit the new patch.

And yes, I will try to explore more on drop_caches part as well.

Thanks,
Pintu
