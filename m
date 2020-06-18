Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F771FF4A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgFROZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFROZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:25:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48BC0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:25:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b201so2882555pfb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KmDh7WFGo8eDXXNvbv3E2VMAocRFdN201dDRse8FZ+Y=;
        b=gzA2fpTC0SesiwtZyor33GPfMnbM4NWLDMf3on76kw/J2V0qq6i3dU1DlwFqYs7GC0
         l0Dxz+U/ageOuVGpHsC2o9Pf97ZKuZcmGwK9/d5mfrvY5urDYazN1n2T1+FD3a5BGcUh
         spSui7Iz17tRuP0KJkOVyVdDlYsEC0BafwRUhyIIS1KUo4EbkDpvhQPqQD/1y2vXHbzM
         2pLXTibDMTN0VFpmDcqVTwyUEBsd05qfjKn9wemfCTQ+vqFnGbCJBkRU9q7b9pTIu8aC
         OLoZUZwtkXuHxsLQXSRL08hnlzS2wbcXP20P4+yIR5HDjcJo9f1GlpJziKGvMGrecI1I
         g0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KmDh7WFGo8eDXXNvbv3E2VMAocRFdN201dDRse8FZ+Y=;
        b=Y+aGryLql1ijO12OZcewfE28hGZwhJ26qJDVQ//O6ESR6MPqPh5DBK8u8Jy4Eruboh
         Aki3elne6VzGwPDYLQ5mFrbCEasTaS+6aV7xko5CRddstB7+yiuMwn1J2gpJQuIipNj/
         DV158vPRf38E15ZevndujEVBWp9QadIWOk7yJoEinykbY2KrNmo+ipCsWKkfpALZDlz5
         B9F4eOk6fY2bSablYgIOGcxX5PbFR8oylowHPO/8YFQEdnYt3HyGQtSCY9Vc4ANraHz6
         MWO4P9NkvArpFN8PaukuvgFcLzb5zHu63gqoZA0ZvTY0i39wqvBvGbBiEQbGqIi3eZwf
         y2+g==
X-Gm-Message-State: AOAM533Ef41JbKIpU/vrsjvtj1AojbUjzoNFJ1Svv4P5lofJvm2aWNaQ
        4CYmt2H8qLMB3u902TnDN+SBGw==
X-Google-Smtp-Source: ABdhPJzYcdMYYIIDStWXFb9/ybpnI+0+TvK2l0kB7vneujNkEsj61fZGyysLeBP0YtPyBWG7vxc8tQ==
X-Received: by 2002:a65:5c45:: with SMTP id v5mr3587952pgr.281.1592490299680;
        Thu, 18 Jun 2020 07:24:59 -0700 (PDT)
Received: from ngvpn01-160-57.dyn.scz.us.nvidia.com ([2601:646:9302:1050:5536:595e:70b0:cc78])
        by smtp.gmail.com with ESMTPSA id i26sm3046553pfo.0.2020.06.18.07.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 07:24:58 -0700 (PDT)
Subject: Re: [PATCH] mm: Use unsigned types for fragmentation score
To:     Baoquan He <bhe@redhat.com>, Nitin Gupta <nigupta@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20200618010319.13159-1-nigupta@nvidia.com>
 <20200618134142.GD3346@MiWiFi-R3L-srv>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Message-ID: <f2bac2a3-f14a-1156-23e5-eabfcee7141d@nitingupta.dev>
Date:   Thu, 18 Jun 2020 07:24:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618134142.GD3346@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/18/20 6:41 AM, Baoquan He wrote:
> On 06/17/20 at 06:03pm, Nitin Gupta wrote:
>> Proactive compaction uses per-node/zone "fragmentation score" which
>> is always in range [0, 100], so use unsigned type of these scores
>> as well as for related constants.
>>
>> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
>> ---
>>  include/linux/compaction.h |  4 ++--
>>  kernel/sysctl.c            |  2 +-
>>  mm/compaction.c            | 18 +++++++++---------
>>  mm/vmstat.c                |  2 +-
>>  4 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>> index 7a242d46454e..25a521d299c1 100644
>> --- a/include/linux/compaction.h
>> +++ b/include/linux/compaction.h
>> @@ -85,13 +85,13 @@ static inline unsigned long compact_gap(unsigned int order)
>>  
>>  #ifdef CONFIG_COMPACTION
>>  extern int sysctl_compact_memory;
>> -extern int sysctl_compaction_proactiveness;
>> +extern unsigned int sysctl_compaction_proactiveness;
>>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>>  			void *buffer, size_t *length, loff_t *ppos);
>>  extern int sysctl_extfrag_threshold;
>>  extern int sysctl_compact_unevictable_allowed;
>>  
>> -extern int extfrag_for_order(struct zone *zone, unsigned int order);
>> +extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
>>  extern int fragmentation_index(struct zone *zone, unsigned int order);
>>  extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>>  		unsigned int order, unsigned int alloc_flags,
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 58b0a59c9769..40180cdde486 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2833,7 +2833,7 @@ static struct ctl_table vm_table[] = {
>>  	{
>>  		.procname	= "compaction_proactiveness",
>>  		.data		= &sysctl_compaction_proactiveness,
>> -		.maxlen		= sizeof(int),
>> +		.maxlen		= sizeof(sysctl_compaction_proactiveness),
> 
> Patch looks good to me. Wondering why not using 'unsigned int' here,
> just curious.
> 


It's just coding style preference. I see the same style used for many
other sysctls too (min_free_kbytes etc.).

Thanks,
Nitin

