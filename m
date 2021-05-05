Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC91373C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhEENkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 09:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233153AbhEENkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 09:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620221953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHQUE4RBuZmI4g/5aOXOPIjM70ZyTC143fCzVAJ8P/8=;
        b=IzfXabDhlFkN2KkOKsWJJIc0gsQUiIVy/r7T9flLxuwbgYWfjdzoPQnQd9J8BgvhA7UV9R
        FluEaCPMO8eUJRAjK/rcsswg2o1Tsd08GsfcIgbHn9VakY9HV6BJ/+6UEKwuf4vfqdos77
        3ObNcxeicmYDQxtkIgXIz0axfDyypSs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-i7Gs8hgANn-piSmGj1Huhw-1; Wed, 05 May 2021 09:39:11 -0400
X-MC-Unique: i7Gs8hgANn-piSmGj1Huhw-1
Received: by mail-ed1-f71.google.com with SMTP id g19-20020a0564021813b029038811907178so856649edy.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 May 2021 06:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IHQUE4RBuZmI4g/5aOXOPIjM70ZyTC143fCzVAJ8P/8=;
        b=PkQxOWam2NO/zlugDYtNcxF/kHlEXj2NBSvgsOetoOZceAEn2VQCthE3n+GrLaULjv
         E/HD2BtbJVbkpuTqYw+pNpAPp86757H6Uv/KPqD8qTdh87IzPMorbHGc1LaeaC4HC7Rz
         9NHTOT5sYX9kNtNCLw3e5hj67KmdouGkB0ZtoDHqaFRSJF7JlyQwIpyAE5rRA6+yIa4l
         I3//ymg6mb4WeMC1aivXC5LqoKAFv43/dLVfukZA0GTZX6ZvyzUeHox04lPuW+Ufi46w
         vI2RmPets0C0Rb2XX7KO05QRX4aw6QAScMTpsKkIkan+vOHx4WZiKHjOc+yXANvSDi4T
         N8jQ==
X-Gm-Message-State: AOAM532lL/R+F1Dk7mwyRNbWlmoMPNqMNMEtCDuofkuvESwUKTJAdDad
        TJP4vE+f+BJggct72tIUeVQMBwEwlTmwQzzQWEo14XgSIGVnmV3nzJUJUsTrZn7+isOv4dPj39w
        uNLAJAzOqo73VJyvFSnk/X0UoLQ==
X-Received: by 2002:a17:906:2406:: with SMTP id z6mr3444001eja.396.1620221950191;
        Wed, 05 May 2021 06:39:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGWyxHBPyyOetZHpx601TcawWH0Fo+idEg5VdUHFvJAR1tTdcZpi84XXPEA0gN5zGGPMwDGA==
X-Received: by 2002:a17:906:2406:: with SMTP id z6mr3443980eja.396.1620221950000;
        Wed, 05 May 2021 06:39:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
        by smtp.gmail.com with ESMTPSA id p21sm16699366edw.18.2021.05.05.06.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:39:09 -0700 (PDT)
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
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
 <20210429122519.15183-4-david@redhat.com> <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
 <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
 <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com>
Date:   Wed, 5 May 2021 15:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Long story short, this should be good enough for the cases we actually can
>> handle? What am I missing?
> 
> I am not sure I follow. My point is that I fail to see any added value
> of the check as it doesn't prevent the race (it fundamentally cannot as
> the page can be poisoned at any time) but the failure path doesn't
> put_page which is incorrect even for hwpoison pages.

Oh, I think you are right. If we have a page and return NULL we would 
leak a reference.

Actually, we discussed in that thread handling this entirely 
differently, which resulted in a v7 [1]; however Andrew moved forward 
with this (outdated?) patch, maybe that was just a mistake?

Yes, I agree we should revert that patch for now.

Regarding the race comment: AFAIU e.g., [2], it's not really a problem 
with a race, but rather some corner case issue that can happen if we 
fail in memory_failure().


[1] https://lkml.kernel.org/r/20210406104123.451ee3c3@alex-virtual-machine
[2] 
https://lkml.kernel.org/r/20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp

-- 
Thanks,

David / dhildenb

