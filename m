Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46F541C7D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbhI2PI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 11:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345023AbhI2PI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632928036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gapF6Q7MxbKj+/Jpg0HNCHa+0ngI63VYNLFNHFDInM4=;
        b=KM8YB6ciT9CY51YYfZdK61z7iUAtHYXNHB1ZJ8fpmZyP0UrhOHXBGnTimY0jE0uxLJ+SXR
        yZZNjyqnG+w1t7LH71OrlenCXfMGSpg1RlNDY54gu1a3oo3DN4FaHbcVN0WHEAOaxM5wyJ
        rTLtvokMYRooahm2NYzm6Af+dcD4fxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-9z9FpVOrNx-MUmeL-J_1gg-1; Wed, 29 Sep 2021 11:07:14 -0400
X-MC-Unique: 9z9FpVOrNx-MUmeL-J_1gg-1
Received: by mail-wr1-f70.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso712527wru.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gapF6Q7MxbKj+/Jpg0HNCHa+0ngI63VYNLFNHFDInM4=;
        b=7BS+w1tbSnpLBOKakXMAIlIQiN7GciOxpeGuLmwIIUjx9igHdQ0uvgdbYr2wvhq6yl
         jMg0XmXBWaHFb0NbrqhfEAFy7iKJVnKZ/8gJ9KPs8CmF629K8DQ0sf+5wTGXrzB6awix
         FCW03N6U32pfrwQQDRV2DmiofPNX6wO1nW4rFm0+VjAC4MG3VTg7QUF6HB1JcsOE3Y6u
         e6/+nNIRrglfODmEgdQg5t6WVBeoB64up3Bpmvsco+CTpjhSiWzYatWW5ULpxmjCToD5
         +lqhFpScOUiiyrKKsQihAP1MKwBQLu5T9D0LGIqBktdF4aQNE+UUWr+sLe49Zanuo9Gc
         089g==
X-Gm-Message-State: AOAM532WbYGNSEy5UJP++YDGtChYBnPdwTUjolwq8TZjK1p0azbBoX3v
        cfSjZw8BDsIRoj3zxF6Kz+QfmLNDhF1V6jqYE7GwD1byq+K5ByQWXYNLqbBdJWbtG53L1e+0iYH
        2qZjwP0DP6e1/viZMN0gn9ZZPuw==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr378675wrt.147.1632928032837;
        Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo/OiD1pi8Vj8uvbtvhFWxk5A000qCxnhsR/1CMHH5asTCVBPsn8x+8H3lxRFK4haIMhJq1A==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr378630wrt.147.1632928032598;
        Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id f8sm177044wrx.15.2021.09.29.08.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
 <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e6ace8c8-8a2d-9bf7-e65b-91d0037c4d08@redhat.com>
Date:   Wed, 29 Sep 2021 17:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.09.21 16:22, Boris Ostrovsky wrote:
> 
> On 9/29/21 5:03 AM, David Hildenbrand wrote:
>> On 29.09.21 10:45, David Hildenbrand wrote:
>>>>
>>> Can we go one step further and do
>>>
>>>
>>> @@ -20,24 +20,11 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
>>>            struct xen_hvm_get_mem_type a = {
>>>                    .domid = DOMID_SELF,
>>>                    .pfn = pfn,
>>> +               .mem_type = HVMMEM_ram_rw,
>>>            };
>>> -       int ram;
>>>     -       if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
>>> -               return -ENXIO;
>>> -
>>> -       switch (a.mem_type) {
>>> -       case HVMMEM_mmio_dm:
>>> -               ram = 0;
>>> -               break;
>>> -       case HVMMEM_ram_rw:
>>> -       case HVMMEM_ram_ro:
>>> -       default:
>>> -               ram = 1;
>>> -               break;
>>> -       }
>>> -
>>> -       return ram;
>>> +       HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a);
>>> +       return a.mem_type != HVMMEM_mmio_dm;
> 
> 
> I was actually thinking of asking you to add another patch with pr_warn_once() here (and print error code as well). This call failing is indication of something going quite wrong and it would be good to know about this.

Will include a patch in v2, thanks!


-- 
Thanks,

David / dhildenb

