Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2563B3ADF43
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jun 2021 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhFTQD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Jun 2021 12:03:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhFTQD6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:03:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624204906; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=tBT+9R016OURPd1+oAsunExiWefitK40L6H5apyub1U=;
 b=J489C/CI6aFNZi9q19ZLKNDlI6lcxjPZqX0EhtkxTc/8uYQ5A5HaG676OFCwAGV5JoXBkBhn
 NBaQUwNGf1+uOkMSVrVVYYCu9gJMtKOpS9HbrydLSYGHcuGXDrtd+ir3CIVPDISekd+dpCsn
 LSKok834UZKKNvEVKWv04I6zaOc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60cf6662e27c0cc77f49bb72 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Jun 2021 16:01:38
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73BABC43217; Sun, 20 Jun 2021 16:01:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.102] (unknown [49.204.183.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75B03C433F1;
        Sun, 20 Jun 2021 16:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75B03C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: Re: [PATCH v1] mm: slub: fix the leak of alloc/free traces debugfs
 interface
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <1624019875-611-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VePzuYwHxA4S8UiUKG1uSqpvnJhfajjJkQi1qS-BhHSdg@mail.gmail.com>
Message-ID: <4ecb4c12-6183-95c5-af59-02fe5da0c17c@codeaurora.org>
Date:   Sun, 20 Jun 2021 21:31:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VePzuYwHxA4S8UiUKG1uSqpvnJhfajjJkQi1qS-BhHSdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/18/2021 6:45 PM, Andy Shevchenko wrote:
> On Fri, Jun 18, 2021 at 3:38 PM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>>
>> fix the leak of alloc/free traces debugfs interface, reported
> 
> Fix
> 
Okay, I will update in next patch version.

>> by kmemleak like below,
>>
>> unreferenced object 0xffff00091ae1b540 (size 64):
>>   comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
>>   hex dump (first 32 bytes):
>>     02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>>   backtrace:
>>     [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
>>     [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
>>     [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
>>     slab_debugfs_start at mm/slub.c:5831
>>     [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
>>     [<ffff8000107b4b84>] seq_read+0x28c/0x418
>>     [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
>>     [<ffff800010738f24>] vfs_read+0x104/0x340
>>     [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
>>     [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
>>     [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
>>     [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
>>     [<ffff800011138528>] el0_svc+0x20/0x30
>>     [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
>>     [<ffff80001001259c>] el0t_64_sync+0x178/0x17c
> 
> Can you shrink this a bit?
>
Okay

>> Fixes: 84a2bdb1b458fc968d6d9e07dab388dc679bd747 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
> 
> We use 12, which is shorter.
> 
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/mm/slub.c?h=next-20210617&id=84a2bdb1b458fc968d6d9e07dab388dc679bd747
> 
>>
> 
> Must be no blank lines in the tag block.
> >> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> 
Okay
> ...
> 
>>  static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>>  {
>> -       loff_t *spos = v;
>>         struct loc_track *t = seq->private;
>>
>> +       v = ppos;
>>         if (*ppos < t->count) {
>> -               *ppos = ++*spos;
>> -               return spos;
>> +               ++*ppos;
>> +               return v;
>>         }
>> -       *ppos = ++*spos;
>> +       ++*ppos;
>>         return NULL;
> 
> Can it be
> 
>        v = ppos;
>        ++*ppos;
>        if (*ppos <= t->count>               return v;
>        return NULL;
> 
> ?  (basically the question is, is the comparison equivalent in this case or not)
> 
>>  }
>Yes, we can update it and slab_debugfs_show has the index check as well.
I will update in next patch version.

Thanks and regards,
Mohammed Faiyaz
