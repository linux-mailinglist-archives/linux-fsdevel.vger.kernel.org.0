Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4597433A2C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 06:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCNFLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 00:11:04 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:12223 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhCNFKl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 00:10:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615698641; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0NoYkl/FuNu+r0+wsVoEHAF2YmV2p15GFH0+t+rZiNg=;
 b=TUezDuju6+H1kX8KWIDfG0ngsHrqIWOPaqndPq2vjj7OxTyGXeB8NKd2zUSZH0OtdNyixqae
 32WY+bX6LWuY57wMbsWoWYQtSIF6kVk7An3XAnkLs+OmGPsfj0nNuz1+0LEUAMlYqG+8JVD2
 c8VwaZ4i1Fshs07EKF3kUelqj94=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 604d9ac85d70193f88dfb2a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 14 Mar 2021 05:10:32
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA79AC43464; Sun, 14 Mar 2021 05:10:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8987C433C6;
        Sun, 14 Mar 2021 05:10:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 13 Mar 2021 21:10:31 -0800
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, willy@infradead.org, mhocko@suse.com,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH v3 2/3] mm: disable LRU pagevec during the migration
 temporarily
In-Reply-To: <623d54ccbd5324bff22ad1389eae38f4@codeaurora.org>
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-2-minchan@kernel.org>
 <623d54ccbd5324bff22ad1389eae38f4@codeaurora.org>
Message-ID: <a0f4abd8540cddc744061e1210ac6e77@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-11 14:41, Chris Goldsworthy wrote:
> On 2021-03-10 08:14, Minchan Kim wrote:
>> LRU pagevec holds refcount of pages until the pagevec are drained.
>> It could prevent migration since the refcount of the page is greater
>> than the expection in migration logic. To mitigate the issue,
>> callers of migrate_pages drains LRU pagevec via migrate_prep or
>> lru_add_drain_all before migrate_pages call.
>> 
>> However, it's not enough because pages coming into pagevec after the
>> draining call still could stay at the pagevec so it could keep
>> preventing page migration. Since some callers of migrate_pages have
>> retrial logic with LRU draining, the page would migrate at next trail
>> but it is still fragile in that it doesn't close the fundamental race
>> between upcoming LRU pages into pagvec and migration so the migration
>> failure could cause contiguous memory allocation failure in the end.
>> 
>> To close the race, this patch disables lru caches(i.e, pagevec)
>> during ongoing migration until migrate is done.
>> 
>> Since it's really hard to reproduce, I measured how many times
>> migrate_pages retried with force mode(it is about a fallback to a
>> sync migration) with below debug code.
>> 
>> int migrate_pages(struct list_head *from, new_page_t get_new_page,
>> 			..
>> 			..
>> 
>> if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
>>        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), 
>> rc);
>>        dump_page(page, "fail to migrate");
>> }
>> 
>> The test was repeating android apps launching with cma allocation
>> in background every five seconds. Total cma allocation count was
>> about 500 during the testing. With this patch, the dump_page count
>> was reduced from 400 to 30.
>> 
>> The new interface is also useful for memory hotplug which currently
>> drains lru pcp caches after each migration failure. This is rather
>> suboptimal as it has to disrupt others running during the operation.
>> With the new interface the operation happens only once. This is also 
>> in
>> line with pcp allocator cache which are disabled for the offlining as
>> well.
>> 
>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>> ---
> 
> Hi Minchan,
> 
> This all looks good to me - feel free to add a Reviewed-by from me.
> 
> Thanks,
> 
> Chris.
Should have added:

Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
