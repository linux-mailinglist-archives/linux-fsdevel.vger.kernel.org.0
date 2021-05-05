Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC7373E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhEEPLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233321AbhEEPLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620227439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/L/odP+hNbqQUDDWOlbej9giUfvPDpuerxl0425+TBc=;
        b=eFK8hWqljmUg8TbqRQN2nuiiNGqfYTiONdbhYgrHfQzlYNzHw7cSc8+trK8cwqSh4iL5Vq
        EZHyrAWJA1483zTFbnfybUPB6Wsg9TGHU4Sj6n3g+SrmiQUB4NZS2FCZ/m7dfF4DyTNtc3
        RVF5IfBgt6eF3kbbxNJG3cVa/4NZhuM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-99x7POcVPm2UtJLlX3tiEQ-1; Wed, 05 May 2021 11:10:36 -0400
X-MC-Unique: 99x7POcVPm2UtJLlX3tiEQ-1
Received: by mail-wm1-f70.google.com with SMTP id g17-20020a05600c0011b029014399f816a3so432371wmc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 May 2021 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/L/odP+hNbqQUDDWOlbej9giUfvPDpuerxl0425+TBc=;
        b=NE0FNZJnfVxY3hWQEh9sFE12cBvF+7bXjsZbuzS+jg6D5s9WSgZdI0RGupRJKGRAwE
         HON+sJN0RUxy0VtHFA08jAxP+uxMuy15YTtyyPfFAMx8le+T8dl7tUNc1n2QjHejIY3P
         VNnRAsQm1J6W7SU/9izp4E5pzR+TFE28tCpC0/1BdsTlMlwr3hX6ceCRWHZOMLtPFpNA
         QRpPmEQVsYe+9UoH5bx8CmNM4te133FOzTT0HHUQh33B9EDjwiDiV6OC8s3F8EWxwb96
         aj+YHjy/4ukp7KxvhNKqWHs2zOp1K3KHiPyTIxuep3+qBhVsRhkOEkckBES46A+h5WWY
         6IWA==
X-Gm-Message-State: AOAM531rGboxb6qUkouVKhgKRWaK3M6ekNOEFc7TT4bdYSsueBGgfRdO
        Yujt+napWkX402oLyAYrWwNZWJVacdLuZwaLuqtTUKBhMiUcs4v57Z6EsbW2oH7jVhXZPpaFPqt
        LOGJGOgBqutM8dLEXsx6YbbbsBg==
X-Received: by 2002:adf:e686:: with SMTP id r6mr38035619wrm.187.1620227435728;
        Wed, 05 May 2021 08:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzj10ka75uUq1iMVB73dSK1NoxnunzZR7BfPe0BRAG27lacrjzLCxVkjF8du5Ejfe2oe3wnw==
X-Received: by 2002:adf:e686:: with SMTP id r6mr38035569wrm.187.1620227435461;
        Wed, 05 May 2021 08:10:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
        by smtp.gmail.com with ESMTPSA id m184sm6099684wme.40.2021.05.05.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 08:10:35 -0700 (PDT)
Subject: Re: [PATCH v1 5/7] mm: introduce
 page_offline_(begin|end|freeze|unfreeze) to synchronize setting PageOffline()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Roman Gushchin <guro@fb.com>,
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
 <20210429122519.15183-6-david@redhat.com> <YJKcg06C3xE8fCfu@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8650f764-8652-a82c-c54f-f67401c800e8@redhat.com>
Date:   Wed, 5 May 2021 17:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKcg06C3xE8fCfu@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.05.21 15:24, Michal Hocko wrote:
> On Thu 29-04-21 14:25:17, David Hildenbrand wrote:
>> A driver might set a page logically offline -- PageOffline() -- and
>> turn the page inaccessible in the hypervisor; after that, access to page
>> content can be fatal. One example is virtio-mem; while unplugged memory
>> -- marked as PageOffline() can currently be read in the hypervisor, this
>> will no longer be the case in the future; for example, when having
>> a virtio-mem device backed by huge pages in the hypervisor.
>>
>> Some special PFN walkers -- i.e., /proc/kcore -- read content of random
>> pages after checking PageOffline(); however, these PFN walkers can race
>> with drivers that set PageOffline().
>>
>> Let's introduce page_offline_(begin|end|freeze|unfreeze) for
>> synchronizing.
>>
>> page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
>> synchronize with such drivers, achieving that a page cannot be set
>> PageOffline() while frozen.
>>
>> page_offline_begin()/page_offline_end() is used by drivers that care about
>> such races when setting a page PageOffline().
>>
>> For simplicity, use a rwsem for now; neither drivers nor users are
>> performance sensitive.
> 
> Please add a note to the PageOffline documentation as well. While are
> adding the api close enough an explicit note there wouldn't hurt.

Will do.

> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> As to the patch itself, I am slightly worried that other pfn walkers
> might be less tolerant to the locking than the proc ones. On the other
> hand most users shouldn't really care as they do not tend to touch the
> memory content and PageOffline check without any synchronization should
> be sufficient for those. Let's try this out and see where we get...

My thinking. Users that actually read random page content (as discussed 
in the cover letter) are

1. Hibernation
2. Dumping (/proc/kcore, /proc/vmcore)
3. Physical memory access bypassing the kernel via /dev/mem
4. Live debug tools (kgdb)

Other PFN walkers really shouldn't (and don't) access random page content.

Thanks!

-- 
Thanks,

David / dhildenb

