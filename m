Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825F756062
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGQK16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 06:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjGQK1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8848E54
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcjXX5GWlegc91aegHozDG5ys9NXk4J7QfyGnNAR82g=;
        b=XrpZPjAsl8mA7ZAChOz1BPW2utDsrTt6W0f0wLIkGDy7RKO8FekuySZ6xmU+/0l2b/WrdZ
        UbDp1rDD2Ylm2q5KuxrTEwqeHD3q0mvKAOj3Vqf2Aqfhw9UT8z5BAoZAEHiY2fMGnK29HR
        ZktIiR5/LJDY0BS79YUN8cln1t31U0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-QaGGU2-GNOO1LIdN5INBpQ-1; Mon, 17 Jul 2023 06:27:02 -0400
X-MC-Unique: QaGGU2-GNOO1LIdN5INBpQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbcae05906so25246815e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 03:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589621; x=1692181621;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcjXX5GWlegc91aegHozDG5ys9NXk4J7QfyGnNAR82g=;
        b=jjmUaVmEQDBYQKjPUHZdPr5gEJgst1VPlzdV4E368iwavSLD6bAEagFNt+TQJZwllV
         kU6nxTuu7pIzZXnQYZYbhUGMRcf0/+PtllyUt7M+Zh11przeNtcmihn0/NJNMVSnv3m7
         5LKh7p6B27hcVGNk441DYkG9z9pplEQWF+k1U8tgdYyOeXbvzuzKpgqhU6OxGGNSRyXB
         jxq0QLpoiVF+q4XxdybGfFsCKT6BBw/eUH13uNWCPBQYfCgIBKwN2wnYjv6o8xvVDIwq
         uEAZYF5dZ2eOmiAm7p5s/KKtGXIBkHDZF12ld/u8rt04hBGpo/115vedRZd+6+i1peq5
         LXIQ==
X-Gm-Message-State: ABy/qLZ5cdnGTb9KfhQqFhzsngEOSJgKkGtqZcsaPin8i/gkhbHhRvRY
        ug7od5PGvEd+hiCpp4NQMxcvF9Gnt/JmmwmAIKAK4Gzihip4cGkQtygFfOHLG0uFLN08eRDEa0E
        7965SMYXYJ3OEVaWCUm13tkZRFQ==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id t9-20020a5d6a49000000b003142c17d921mr10297824wrw.38.1689589621623;
        Mon, 17 Jul 2023 03:27:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHg4QSrt7ASwOV1fEBcNK4Q/NKk0aYoKscyfvU06BxfjAob7ZBV5ewkV0pAvLD46ImkfH0r8w==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id t9-20020a5d6a49000000b003142c17d921mr10297812wrw.38.1689589621295;
        Mon, 17 Jul 2023 03:27:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b003143be36d99sm18839549wrq.58.2023.07.17.03.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:27:00 -0700 (PDT)
Message-ID: <4a7feeb3-0c9e-0dba-1023-4f0ae1bfe471@redhat.com>
Date:   Mon, 17 Jul 2023 12:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5] mm: introduce vma_is_stack() and vma_is_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-2-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712143831.120701-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.07.23 16:38, Kefeng Wang wrote:
> Introduce the two helpers for general use.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/mm.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1462cf15badf..0bbeb31ac750 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -926,6 +926,18 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
>   	return !vma->vm_ops;
>   }
>   
> +static inline bool vma_is_heap(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->brk &&
> +		vma->vm_end >= vma->vm_mm->start_brk;
> +}
> +
> +static inline bool vma_is_stack(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->start_stack &&
> +	       vma->vm_end >= vma->vm_mm->start_stack;
> +}
> +
>   static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>   {
>   	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);

Looking at the comments in patch #3, should these functions be called

vma_is_initial_heap / vma_is_initial_stack ?

-- 
Cheers,

David / dhildenb

