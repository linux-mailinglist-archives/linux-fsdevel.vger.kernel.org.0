Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20737137D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhECKOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhECKOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620036830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfH/Rim8ttUy4kF1walnlnjFDNfkSM8H2CqszcJCsT8=;
        b=BevCE+COvDOK3u4GHQHdjBYuqAK8ilirf44Aztim5XQN3tcBHlVdXkc215Jgj/0RflPCnV
        SKfhT2w2SIIyZuvcjJ+UeN0tQr8oAEWh6lgjEmOlurXHo3xT/Mza0oegDUmtYR8OUGvQ7K
        U7kY1hwNJsr24irOxV418wMyPtfVHDs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-iiK1edMwO82HA6j1UA-Dvg-1; Mon, 03 May 2021 06:13:48 -0400
X-MC-Unique: iiK1edMwO82HA6j1UA-Dvg-1
Received: by mail-wm1-f72.google.com with SMTP id r10-20020a05600c2c4ab029014b601975e1so123761wmg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 03:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TfH/Rim8ttUy4kF1walnlnjFDNfkSM8H2CqszcJCsT8=;
        b=HA8Y4d2d1fRPKa5+8XLD3UkI66MwvAGW4zC09IQtbNrGupmOtmqm9eocl2khuoy0sK
         oKrGF3QZtG6U4mvEaRd+KmCXY0VT8jG5+XGvy8JO4HMoZ36sIIALNR4ArWux/q/SeZyD
         EUtkV6KkBCbqh1e6KfaBWm2yA/0ekcm8y83DYsCz3O2d4ME7vsT7Prlqlk6HT/egwAdl
         xqZMSUZPz5XpZVRWV7AHw1lNhC95bkaT55xbONnXyXp9oPLGYG+8mbID+AAlEuFXwQMk
         D4hS+c49cXzL/Y5TrO0Hxz3aQTHARAVyRtCDuUtTR9Q5r/ceLteogOZDagpbOMLOtQkE
         7wmw==
X-Gm-Message-State: AOAM532w50qw0DUfH71b6KPMqTX34xKzxNmLKHcnkIy+SNqOOMJgbTEz
        4YURANrz5BNR5EHW9XsUZ0PkzVTLz/LkWg3nwTtcnG8XWRKK41ygm4J5jWrUod0FQdZEecDi80Y
        yZWjMTe5D4At5lUCl/PDvYklb+A==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr23980435wrm.392.1620036827539;
        Mon, 03 May 2021 03:13:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzitx86hh7/AAfqMzT0jIWlPfTNKdYBUPj79ED4tgUYCy6GM6viNYbB0BIqh1/tiBOZIdssSA==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr23980386wrm.392.1620036827214;
        Mon, 03 May 2021 03:13:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id d2sm11770212wrs.10.2021.05.03.03.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 03:13:46 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-8-david@redhat.com> <YI5H4yV/c6ReuIDt@kernel.org>
 <5a5a7552-4f0a-75bc-582f-73d24afcf57b@redhat.com>
 <YI/CWg6PrMxcCT2D@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Message-ID: <2f66cbfc-aa29-b3ef-4c6a-0da8b29b56f6@redhat.com>
Date:   Mon, 3 May 2021 12:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI/CWg6PrMxcCT2D@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.05.21 11:28, Mike Rapoport wrote:
> On Mon, May 03, 2021 at 10:28:36AM +0200, David Hildenbrand wrote:
>> On 02.05.21 08:34, Mike Rapoport wrote:
>>> On Thu, Apr 29, 2021 at 02:25:19PM +0200, David Hildenbrand wrote:
>>>> Let's properly synchronize with drivers that set PageOffline(). Unfreeze
>>>> every now and then, so drivers that want to set PageOffline() can make
>>>> progress.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    fs/proc/kcore.c | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>>>> index 92ff1e4436cb..3d7531f47389 100644
>>>> --- a/fs/proc/kcore.c
>>>> +++ b/fs/proc/kcore.c
>>>> @@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>>>>    static ssize_t
>>>>    read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>>>    {
>>>> +	size_t page_offline_frozen = 0;
>>>>    	char *buf = file->private_data;
>>>>    	size_t phdrs_offset, notes_offset, data_offset;
>>>>    	size_t phdrs_len, notes_len;
>>>> @@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>>>    			pfn = __pa(start) >> PAGE_SHIFT;
>>>>    			page = pfn_to_online_page(pfn);
>>>
>>> Can't this race with page offlining for the first time we get here?
>>
>>
>> To clarify, we have three types of offline pages in the kernel ...
>>
>> a) Pages part of an offline memory section; the memap is stale and not
>> trustworthy. pfn_to_online_page() checks that. We *can* protect against
>> memory offlining using get_online_mems()/put_online_mems(), but usually
>> avoid doing so as the race window is very small (and a problem all over the
>> kernel we basically never hit) and locking is rather expensive. In the
>> future, we might switch to rcu to handle that more efficiently and avoiding
>> these possible races.
>>
>> b) PageOffline(): logically offline pages contained in an online memory
>> section with a sane memmap. virtio-mem calls these pages "fake offline";
>> something like a "temporary" memory hole. The new mechanism I propose will
>> be used to handle synchronization as races can be more severe, e.g., when
>> reading actual page content here.
>>
>> c) Soft offline pages: hwpoisoned pages that are not actually harmful yet,
>> but could become harmful in the future. So we better try to remove the page
>> from the page allcoator and try to migrate away existing users.
>>
>>
>> So page_offline_* handle "b) PageOffline()" only. There is a tiny race
>> between pfn_to_online_page(pfn) and looking at the memmap as we have in many
>> cases already throughout the kernel, to be tackled in the future.
> 
> Right, but here you anyway add locking, so why exclude the first iteration?

What we're protecting is PageOffline() below. If I didn't mess up, we 
should always be calling page_offline_freeze() before calling 
PageOffline(). Or am I missing something?

> 
> BTW, did you consider something like

Yes, I played with something like that. We'd have to handle the first 
page_offline_freeze() freeze differently, though, and that's where 
things got a bit ugly in my attempts.

> 
> 	if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
> 		page_offline_unfreeze();
> 		cond_resched();
> 		page_offline_freeze();
> 	}
> 
> We don't seem to care about page_offline_frozen overflows here, do we?

No, the buffer size is also size_t and gets incremented on a per-byte 
basis. The variant I have right now looked the cleanest to me. Happy to 
hear simpler alternatives.


-- 
Thanks,

David / dhildenb

