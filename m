Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FDD79C7D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjILHOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjILHN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2276E78
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694502789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTSpSyC5EzR4JqjtmXWa4jhow1lkJCD2XnaN08RB0m8=;
        b=ZV82oyxX6lYliNZKE8gy0UHyXoCc/oB/F3Z0Dby9Xblcz+BRWNa4JhRSOefMlW6KhBVFa8
        9Ll65ZGUyK1kcLa1u5o8bmYlybc8F20fT9XZJfxaa5cZkxC4yPaLhH1xrvA6Cy+WLzkS58
        nR7R4XIXc9Be5uxhUxOlAXCj6dkpfK0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-uS15Sp3SMparmRk3FWgFXg-1; Tue, 12 Sep 2023 03:13:07 -0400
X-MC-Unique: uS15Sp3SMparmRk3FWgFXg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30932d15a30so3742045f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 00:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502786; x=1695107586;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTSpSyC5EzR4JqjtmXWa4jhow1lkJCD2XnaN08RB0m8=;
        b=HHQXFsID507msk4qOJpQLGe1+7LxF2QkLZOu7Qk64b+jE9dkLppmTYICgTS4auGF9O
         BiI+2474W1DvTqaCh3cDTP7Ocrp3KLbS0rBqHi3Y0i8EsojrJfI1/dZQYAg1qVgFJ6Fg
         ++mzlLVRwPseEqCMVuZ/L7/oL9SMiFFLH1RG2T3Xy0vkMGoMIsLT0r3Esoe6ZJ3Tbqzm
         USzzvfD71dTmBdWureep/kFzmYqzB3vIQ+DXoyZtGL1TYJ8jGO/3g//UcEA4O94ujcPD
         gk3ChDDTsJBgr1YJKyd8R6+NMQO93PnL+OuYzseN8xIo8+tWotHNy9imqUdMJZ+3aj2b
         g4Lg==
X-Gm-Message-State: AOJu0YxI/Sp4wtmdA5lXISM3d9H+dhqizkqZpb5lyupe0MdcM5fvvk2z
        tYpKqfOzNDhznP58QsK3jfPP7tKiju71D9FRvTsSzjpBdm0Tj3B4tbGkfSXVlsHf5PXI+Qvf62n
        GOUwRJCt6CTprmlRAQZTZcLEZIg==
X-Received: by 2002:adf:ec10:0:b0:31d:1833:4135 with SMTP id x16-20020adfec10000000b0031d18334135mr9258414wrn.28.1694502786650;
        Tue, 12 Sep 2023 00:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzD/JqAKRst1uRyrpQ1ec8A47CJ05RJvD9vhfbLXgEIWlOOIOrNSivNy+JkLaFrl4za69IRw==
X-Received: by 2002:adf:ec10:0:b0:31d:1833:4135 with SMTP id x16-20020adfec10000000b0031d18334135mr9258385wrn.28.1694502786274;
        Tue, 12 Sep 2023 00:13:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id x18-20020adfdd92000000b0031aeca90e1fsm12117706wrl.70.2023.09.12.00.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:13:05 -0700 (PDT)
Message-ID: <3a37361d-1f3b-c283-3fb0-ab3614e3d38c@redhat.com>
Date:   Tue, 12 Sep 2023 09:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 2/2] proc/kcore: Do not try to access unaccepted memory
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
 <20230911112114.91323-3-adrian.hunter@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.09.23 13:21, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby a virtual
> machine may need to accept memory before it can be used.
> 
> Do not try to access unaccepted memory because it can cause the guest to
> fail.
> 
> For /proc/kcore, which is read-only and does not support mmap, this means a
> read of unaccepted memory will return zeros.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   fs/proc/kcore.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> Changes in V2:
> 
>            Change patch subject and commit message
>            Do not open code pfn_is_unaccepted_memory()
> 
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 23fc24d16b31..6422e569b080 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -546,7 +546,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   			 * and explicitly excluded physical ranges.
>   			 */
>   			if (!page || PageOffline(page) ||
> -			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
> +			    is_page_hwpoison(page) || !pfn_is_ram(pfn) ||
> +			    pfn_is_unaccepted_memory(pfn)) {
>   				if (iov_iter_zero(tsz, iter) != tsz) {
>   					ret = -EFAULT;
>   					goto out;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

