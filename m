Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2D79C802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjILHT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjILHTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D6E9E79
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694503114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OodWnETEUgz5EFst9JGpxDf54xHXqhw04bLaPZH7zA=;
        b=CfJufZ0+jnXUOpY16coEfCS98QFO6LyZiJN9ZQMEe4HxCEEczHeF8QRji3hYNbeDMVubLi
        gHqDdWxKeZudQiHsUd87wPqpjxK1HDtphR7kFywyJrwBO45UzoqF2qdoKhL9doH/MrBHQR
        2veEcmGi/Pw8q2Awo+KXC6QZ231lHVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-FSxPoegbNoaAYzwQOJkTEQ-1; Tue, 12 Sep 2023 03:18:33 -0400
X-MC-Unique: FSxPoegbNoaAYzwQOJkTEQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso42482815e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 00:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503112; x=1695107912;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OodWnETEUgz5EFst9JGpxDf54xHXqhw04bLaPZH7zA=;
        b=Q8WlWZbdmcrDbD6ENyuOC8/x3Imms9em/95YcbZ7R077jS6PF6aD3sTuxMFWd+z6FY
         6IBITpdk8OrV0cPc8N4iQcZbrt14ODQfs5SLEatM4s9YTTt4qwIdJqLNNW+lqPjzvoOU
         jXQ/KPqWLvjlRP8RlPbZ5v9L+AI//UWlrYdJGpTj20f+qhWvx7GwUlxqrmmAdn+caM3q
         BD5Q2t4G7KpPyGazlCzsJ8yBZPD4vPw//2PF82TtjVKEOb3Rfpzyp3l0arAQcW6IdlOu
         npmyFjGBN0HBAobWjcPuRVpE+8c5dYJVgeqZItZvBUJ07F6udKfLA/RdIfPPGLKDIY25
         Uscg==
X-Gm-Message-State: AOJu0YyekSgxIreRKqCGNqS/HNTu+lO4hhvmUVmdVsxZoyWFzMQGphbk
        +CPX8YCX8dUEAlxetzcKUFu1tOf3Bo/84PaicC9JurgSNbkhsGwvvAz5iic/HNSyMNPnZLFaxfj
        OsqlXMTCLjCy2XcEk7LRuzgtw+w==
X-Received: by 2002:a7b:c853:0:b0:401:db82:3edf with SMTP id c19-20020a7bc853000000b00401db823edfmr9908939wml.39.1694503112134;
        Tue, 12 Sep 2023 00:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQr59YxQoahIdt2pGpOn3n/3cyfcIn7qrajZoDiICpNrmoOnS/ynh5Tia67CgdCYHJ/KD0yA==
X-Received: by 2002:a7b:c853:0:b0:401:db82:3edf with SMTP id c19-20020a7bc853000000b00401db823edfmr9908928wml.39.1694503111718;
        Tue, 12 Sep 2023 00:18:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fed630f560sm12028942wmj.36.2023.09.12.00.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:18:31 -0700 (PDT)
Message-ID: <7f4881dc-885a-a8f5-47a5-0dd23886a416@redhat.com>
Date:   Tue, 12 Sep 2023 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.09.23 13:21, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
> need to accept memory before it can be used.
> 
> Do not let /proc/vmcore try to access unaccepted memory because it can
> cause the guest to fail.
> 
> For /proc/vmcore, which is read-only, this means a read or mmap of
> unaccepted memory will return zeros.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

[...]

> +static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
> +{
> +	phys_addr_t paddr = pfn << PAGE_SHIFT;
> +
> +	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
> +}
> +
>   #endif /* _LINUX_MM_H */

As stated, if the relevant table is not already properly populated with 
information about unaccepted memory by the first kernel, this probably 
logically belongs into Kirills series.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

