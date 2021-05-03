Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1F371258
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhECIRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 04:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232906AbhECIRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 04:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620029770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uB/EYYvRDIWzIKd9NUtpds132sJrn5ZaXZy/6UA0sM=;
        b=GNbUAaF2WD3BEvnFoLvpEAjiYa1z/T7fUWnxqp+QIiq3lixTYH/u0Rxu0WqImN87/4LdzK
        iKPSuc5TJZFtJX2iPoKshc22XLVAJcOrAC347MkSXh2F5mirNOQzkGHQ1INNIxvd0xNyJo
        4hvKB3l1peOUONJ0U7iUrbYPEiXp3Uw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-_2N5RP0EPqONX17Mty_AIg-1; Mon, 03 May 2021 04:16:06 -0400
X-MC-Unique: _2N5RP0EPqONX17Mty_AIg-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a0564023591b02903886c26ada4so4103240edc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 01:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3uB/EYYvRDIWzIKd9NUtpds132sJrn5ZaXZy/6UA0sM=;
        b=typgTIHdxt+nAAyZQ/Fa/qKQFx5NhDDGlphALRJQzVZlgTBC39+JFJ3Czdyj0R1P6G
         ou9qjpOP/6siPpNPMg5lO0sT+mYU4Ma5JEEfNN2qtuMO6y41rJKXEklmeAt4sQZxZ/zj
         DA3cIoonNko5WY4NIbjG8uuZ2xCETSGAxY5JYPQKgqyuKE/ZXL/sgMBi63FaJ2J9mkJz
         cH2fzH5/+Jy4RYyXqlaS+AE3L2nvc5uUvHdJgbF/Ys6WnJs6WIz9RYNnHtxOftVOD6te
         Q45+WsZExaKvJWWK4cZFKvwmdv2BKA+ObaltyElpt41jiJh9udI7wDthVkH50MyPAanp
         u2fg==
X-Gm-Message-State: AOAM5335NAitmyESTUQ6HdLGOHxDakqYydlUy13YQ/lrq6KzPZhihIyP
        x4BvRJ/XI0qJe7Q0GQKIztTgNcTUznqp+5juZqdWoKmz46m4MX96HB8gDBAasogp4HMbPr9e5bL
        2syPfD5wpQATcc4GsWkRp5g4vMQ==
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr11677880ejw.496.1620029764846;
        Mon, 03 May 2021 01:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5t6QJnu76x0vRJx5wjyCiN1MvkzdCqG/1DMVBAPOiuRhGpdYa0HWbVhYZGZKhNk34vPvb6A==
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr11677854ejw.496.1620029764611;
        Mon, 03 May 2021 01:16:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id lr15sm4554094ejb.107.2021.05.03.01.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 01:16:04 -0700 (PDT)
Subject: Re: [PATCH v1 6/7] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
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
 <20210429122519.15183-7-david@redhat.com> <YI5HzXN7+ZTNXtcI@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <98f22a46-da8b-2891-fade-09937c0ccf69@redhat.com>
Date:   Mon, 3 May 2021 10:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5HzXN7+ZTNXtcI@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.05.21 08:33, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:18PM +0200, David Hildenbrand wrote:
>> Let's properly use page_offline_(start|end) to synchronize setting
>> PageOffline(), so we won't have valid page access to unplugged memory
>> regions from /proc/kcore.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/virtio/virtio_mem.c | 2 ++
>>   mm/util.c                   | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 10ec60d81e84..dc2a2e2b2ff8 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -1065,6 +1065,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>>   static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   					unsigned long nr_pages, bool onlined)
>>   {
>> +	page_offline_begin();
>>   	for (; nr_pages--; pfn++) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> @@ -1075,6 +1076,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   			ClearPageReserved(page);
>>   		}
>>   	}
>> +	page_offline_end();
> 
> I'm not really familiar with ballooning and memory hotplug, but is it the
> only place that needs page_offline_{begin,end} ?

Existing balloon implementations that I am aware of (Hyper-V, XEN, 
virtio-balloon, vmware-balloon) usually allow reading inflated memory; 
doing so might result in unnecessary overhead in the hypervisor, so we 
really want to avoid it -- but it's strictly not forbidden and has been 
working forever. So we barely care about races: if there would be a rare 
race, we'd still be able to read that memory.

For virtio-mem, it'll be different in the future when using shmem, huge 
pages, !anonymous private mappings, ... as backing storage for a VM; 
there will be a virtio spec extension to document that virtio-mem 
changes that indicate the new behavior won't allow reading unplugged 
memory and doing so will result in undefined behavior.

-- 
Thanks,

David / dhildenb

