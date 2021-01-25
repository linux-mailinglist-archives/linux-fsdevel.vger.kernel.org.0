Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B080730253E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbhAYNBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 08:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbhAYM64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611579421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrrsduXw40spa9C0cPD/Y3KujjjqBKpfWwF9zUNXpbE=;
        b=StpZjeMxx7xC2CGUa30pgzVOFXbICm63Z0O6HaAKdVG/JBY0+4zvljvpfFB/j/H0oSS6P2
        qwm3HDADRjFIG6BD5xvpVB9oRS3edjexRbJcP+rd0j3ywSx4kuUpVfU5AQ0St+JB6rMkzL
        coNFCOTjMA+N1/orBMQpae8zjQhP0LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-OndNxk3gOOqLsuKiAZjAQQ-1; Mon, 25 Jan 2021 06:43:34 -0500
X-MC-Unique: OndNxk3gOOqLsuKiAZjAQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFE6618C8C0E;
        Mon, 25 Jan 2021 11:43:30 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BE4D19C44;
        Mon, 25 Jan 2021 11:43:24 +0000 (UTC)
Subject: Re: [PATCH v13 09/12] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-10-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7550ebba-fdb5-0dc9-a517-dda56bd105d9@redhat.com>
Date:   Mon, 25 Jan 2021 12:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210117151053.24600-10-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.01.21 16:10, Muchun Song wrote:
> Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.

The description completely lacks a description of the changes performed
in arch/x86/mm/init_64.c.

[...]

> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -34,6 +34,7 @@
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/processor.h>
>  #include <asm/bios_ebda.h>
> @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  {
>  	int err;
>  
> -	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> +	if (is_hugetlb_free_vmemmap_enabled() ||
> +	    end - start < PAGES_PER_SECTION * sizeof(struct page))

This looks irresponsible. You ignore any altmap, even though current
altmap users (ZONE_DEVICE) will not actually result in applicable
vmemmaps that huge pages could ever use.

Why do you ignore the altmap completely? This has to be properly
documented, but IMHO it's not even the right approach to mess with
altmap here.

-- 
Thanks,

David / dhildenb

