Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB91B371246
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhECIM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 04:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232895AbhECIM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 04:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620029494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwlHSyZzbGf/1hjjeGeNUgRrxHpiQEqHNLs9/p1ggRw=;
        b=SIrus6e16RobVdtfdpixSPT0rb/Vh1dFZejCDC85Ehuk8mKlXzfTjin25enMM8iDunoRzW
        9+z5Bx0ank8Mjc70PRPv4Nvh8Qy88/cEn8daQOnndug65kG3pM2y/2bLlPWxS8LOSj2ztH
        jokPt5A50mW2oipVOTKvTZ01xiujB44=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-TE6pSlq7N-W9w24X_vuaPQ-1; Mon, 03 May 2021 04:11:32 -0400
X-MC-Unique: TE6pSlq7N-W9w24X_vuaPQ-1
Received: by mail-ed1-f71.google.com with SMTP id d6-20020a0564020786b0290387927a37e2so4066007edy.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 01:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vwlHSyZzbGf/1hjjeGeNUgRrxHpiQEqHNLs9/p1ggRw=;
        b=Vn8bQz4W63TwAJEe5ow11JJuYwG/iN41jxGgjsbDzse7kBQiaknyRkOLgdEEgtmZuB
         3fDy543yR12Dta19ssVOzlhMGzox4Q1mf3abTdAa6lyshpqz8lQXQjlGo/AXEmZE0iBA
         63Qa0Tw/RVm9wzBxxaQ0kXB6mXe8HFQpXLYAHIuZBwJuxvIH++rZoB5nTzCwTWg+w1eH
         qA2mtQbSF0yaI9FJ98H4VGJDuY1LCt9wACxPv6YV/vxdzrw/X5sAioBC3rnlZve6+Hk1
         9/DGXJ7fIJT9LqWKCyYacgFciDTiURDDeyOma64Do8WW9y+05Z6Kfl5iq1D2DkL9satq
         gCWA==
X-Gm-Message-State: AOAM5336oVVZEPbBx8LpqKXMUUCZVM6/3gCUErmIhlHA5XdVfoIXeEas
        3GNNUB6PPJmIy074XjgrAF7u3i7e3qyzrs+j34/55sLDM4l6ySEVF4ZbHUFuDUCo+CXv1vIMZTs
        ELQUZhzWP0nKkvZIg6i6alxCwCA==
X-Received: by 2002:a50:eb47:: with SMTP id z7mr16986477edp.68.1620029491001;
        Mon, 03 May 2021 01:11:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgC+bCNFZ6IjQ+hZxVb6PiUEspf4Kwd7KdWnjG2fBIRF7s94xAa5mK0csiH8ddS3w5cQDqaA==
X-Received: by 2002:a50:eb47:: with SMTP id z7mr16986454edp.68.1620029490784;
        Mon, 03 May 2021 01:11:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id d15sm12268494edu.86.2021.05.03.01.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 01:11:30 -0700 (PDT)
Subject: Re: [PATCH v1 5/7] mm: introduce
 page_offline_(begin|end|freeze|unfreeze) to synchronize setting PageOffline()
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
 <20210429122519.15183-6-david@redhat.com> <YI5Hp49AmWgfTzNy@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4aa55978-c224-7ead-f00d-df1a6c3dfda4@redhat.com>
Date:   Mon, 3 May 2021 10:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5Hp49AmWgfTzNy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.05.21 08:33, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:17PM +0200, David Hildenbrand wrote:
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
> 
> Bikeshed: freeze|thaw?
>

Sure :)


-- 
Thanks,

David / dhildenb

