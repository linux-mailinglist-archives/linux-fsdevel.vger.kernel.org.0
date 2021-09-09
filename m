Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A715440476D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhIIJAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 05:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231281AbhIIJAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631177933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/XpMR8IW7n50hqBRiVqU8UBvztjlF9h6rtat9Sfp/0=;
        b=Tp7SmIVJCHLXWfyIiiWR9vQW4sIpX8Ibu1hucoXz8ZgqLpcgtNt5myN7vr8LuuZjCrj28M
        Jyr0kD4rrizVGK9C/FhVW5Zhld8Zx8CnRUId7Fmc2q++BPJVwBAsSrq0hvmbzpofHpzegC
        0IUM2RHLKLPApC/Ms0cEIhLiPYlxHUg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-RD4j77tBMz2A4kDHWxNa_w-1; Thu, 09 Sep 2021 04:58:52 -0400
X-MC-Unique: RD4j77tBMz2A4kDHWxNa_w-1
Received: by mail-wr1-f72.google.com with SMTP id u2-20020adfdd42000000b001579f5d6779so286594wrm.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 01:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B/XpMR8IW7n50hqBRiVqU8UBvztjlF9h6rtat9Sfp/0=;
        b=NOv7sddBrBTd3SQ3YraqzoBKO4o+xE9N3uZuNNiu8N1Km7VvIDTJSubqjJen5u63ls
         DRHf21P1fjCjXrGREZ0irNmcuhGM2aONAhdxhf2wvKKJFcw3O+3oT5ALA2cxya++b5FC
         T+KtLKed+XagLNQEiBa9g78B25zICLtRDbeyl3JVCXlb4xW4NL7kEFgl02gF3DH5ZmX4
         wP3K8sFlAk3apWgqxqKVJcOJN0J8kFabrBUEDaMxi1eloWesNny6dMepHlDQHHoDkEwt
         1aMViFXk5sbP4pzsVgsgYzOGAIcH0gijuKjSlDhRVWD2e7fmZ4UlNCLIOgAYM/LoWHO4
         6U5w==
X-Gm-Message-State: AOAM531k6Mfi0cSXTN7+tqiWHNjv/wyPMgzJis00sQaGoIx+cKVnjDsI
        SM37i/4j+jNaNhFG+Lk1FVLnFBOGw/IFittZziBm1PqLw3+jW6mcScN+jc9y244nFXHZf6/CR9+
        e0LPQZH7IVxI7eYPhRfVHZTQFKw==
X-Received: by 2002:adf:e643:: with SMTP id b3mr2263866wrn.67.1631177931565;
        Thu, 09 Sep 2021 01:58:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHd9tbvGHuH/vI+YA9CIrNsSVEbwqy9yOD6TU2JuSw3sjsuiEtnZ1Wqc75iLPK+6kOv9kJ0Q==
X-Received: by 2002:adf:e643:: with SMTP id b3mr2263848wrn.67.1631177931410;
        Thu, 09 Sep 2021 01:58:51 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23fe4.dip0.t-ipconnect.de. [79.242.63.228])
        by smtp.gmail.com with ESMTPSA id y1sm1029619wmq.43.2021.09.09.01.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 01:58:50 -0700 (PDT)
Subject: Re: [RFC PATCH] fs/exec: Add the support for ELF program's NUMA
 replication
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        jlayton@kernel.org, bfields@fieldses.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, patches@amperecomputing.com,
        zwang@amperecomputing.com
References: <20210906161613.4249-1-shijie@os.amperecomputing.com>
 <2cb841ca-2a04-f088-cee2-6c020ecc9508@redhat.com> <YTnX7IyC420MNBLq@hsj>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1c115101-a549-0e88-7bbb-1b0a19621504@redhat.com>
Date:   Thu, 9 Sep 2021 10:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTnX7IyC420MNBLq@hsj>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.09.21 11:46, Huang Shijie wrote:
> On Mon, Sep 06, 2021 at 11:35:01AM +0200, David Hildenbrand wrote:
>> On 06.09.21 18:16, Huang Shijie wrote:
>>> This patch adds AT_NUMA_REPLICATION for execveat().
>>>
>>> If this flag is set, the kernel will trigger COW(copy on write)
>>> on the mmapped ELF binary. So the program will have a copied-page
>>> on its NUMA node, even if the original page in page cache is
>>> on other NUMA nodes.
>>
>> Am I missing something important or is this just absolutely not what we
>> want?
> 
> Please see the thread:
> https://marc.info/?l=linux-kernel&m=163070220429222&w=2
> 
> Linus did not think it is a good choice to implement the "per-numa node page cache"

That doesn't make this approach any better.

I don't think we want this in the kernel. If user space wants to waste 
memory, it can happily mmap() however it wants. The advisory is to not 
do it.

-- 
Thanks,

David / dhildenb

