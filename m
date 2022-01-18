Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA984922FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiARJlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 04:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiARJlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:41:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944ACC061574;
        Tue, 18 Jan 2022 01:41:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w26so26294503wmi.0;
        Tue, 18 Jan 2022 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iFgNmHuHt5y/j3H8Tutu8lSHsdboxVy4VCgXSl8Gp+c=;
        b=e4Voc0fMOqW5qm9lcEfLiDnhnQlQ6ZFzbAF5cwxJ5mcDpg1XMC/Vyh+ISO1xjBLFHn
         OZBmu2WBQ32xYA5gY6rZ5u/wY0gIMbMOaCXhmxdWEL/YktAbkUhPn0sBgNnD6WBfO4DZ
         3lgS5FAKp1slZEpEdZdF1kvBqji5sCHgY1Z5VYVRUY5XCBAh4H+zmAMqkWOKBen3pCKS
         2xp25/UlpA2npVVRg0Krh4ljjtJgh7O4WBzK2+ajjOeLfP6kc35kOL5O3XeLGrYVEt5e
         +OOlNWim2KvAfRD1p+w92PjKRBI7tqlc3+o8+GuaLoT3fyKPHPFgTwxzDUtGyu1OKYTj
         y4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iFgNmHuHt5y/j3H8Tutu8lSHsdboxVy4VCgXSl8Gp+c=;
        b=atcAkC9mnci5kNM9gmNnlk0Ni14vVJUA31kP/Ch6m+S0ufatAy3YG8MxtKRIaaK3nH
         XqeBbh10U++lqbYjsKHZ/bOR8YlWpd76edSLYgtgBdStRKDSPRDCCFeVe2j65AFJxxYU
         lcyKNXWFf1bSskToyGeh5v+qlwb2SeLeqtYjoMcREPeImG6oqMn93cD0g6BJlqrjaymc
         85bq8rgS8iZe9EhssBqkyq5LMMaQjC9P+18uecP7KSHqsTEcn4IWntO0r2ZnV/+WxTmP
         z9lS+whu8quyYViFroKWctyKH1HxlcSPeQasFJICQQzAKizjG50643aF5OdfHStThHcH
         HDig==
X-Gm-Message-State: AOAM531nOHqpJVOXwkBnfOIYEmvRF+RkG9yo0LZvcbJw2zZHDNNZ6V9u
        LYCJgftGRqdOuroyMcHFMbc=
X-Google-Smtp-Source: ABdhPJxVIuos7uF9wvC6FVb9WmzGng58cHgSsM5JWVjupB9kHiycluSpCGN3CNa/ueTUPlfFqJJAKA==
X-Received: by 2002:a1c:1f82:: with SMTP id f124mr888011wmf.157.1642498879254;
        Tue, 18 Jan 2022 01:41:19 -0800 (PST)
Received: from [192.168.1.40] (154.red-83-50-83.dynamicip.rima-tde.net. [83.50.83.154])
        by smtp.gmail.com with ESMTPSA id v13sm18556810wro.90.2022.01.18.01.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 01:41:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe.mathieu.daude@gmail.com>
Message-ID: <0ea887e9-1fd4-1962-cbaa-92b648b28b53@amsat.org>
Date:   Tue, 18 Jan 2022 10:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 10/13] softmmu/physmem: Add private memory address
 space
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        david@redhat.com, "J . Bruce Fields" <bfields@fieldses.org>,
        dave.hansen@intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        ak@linux.intel.com, Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, john.ji@intel.com,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
 <20211111141352.26311-11-chao.p.peng@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <20211111141352.26311-11-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 11/11/21 15:13, Chao Peng wrote:
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/exec/address-spaces.h |  2 ++
>  softmmu/physmem.c             | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
> index db8bfa9a92..b3f45001c0 100644
> --- a/include/exec/address-spaces.h
> +++ b/include/exec/address-spaces.h
> @@ -27,6 +27,7 @@
>   * until a proper bus interface is available.
>   */
>  MemoryRegion *get_system_memory(void);
> +MemoryRegion *get_system_private_memory(void);
>  
>  /* Get the root I/O port region.  This interface should only be used
>   * temporarily until a proper bus interface is available.
> @@ -34,6 +35,7 @@ MemoryRegion *get_system_memory(void);
>  MemoryRegion *get_system_io(void);
>  
>  extern AddressSpace address_space_memory;
> +extern AddressSpace address_space_private_memory;
>  extern AddressSpace address_space_io;
>  
>  #endif
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index f4d6eeaa17..a2d339fd88 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -85,10 +85,13 @@
>  RAMList ram_list = { .blocks = QLIST_HEAD_INITIALIZER(ram_list.blocks) };
>  
>  static MemoryRegion *system_memory;
> +static MemoryRegion *system_private_memory;
>  static MemoryRegion *system_io;
>  
>  AddressSpace address_space_io;
>  AddressSpace address_space_memory;
> +AddressSpace address_space_private_memory;
> +
>  
>  static MemoryRegion io_mem_unassigned;
>  
> @@ -2669,6 +2672,11 @@ static void memory_map_init(void)
>      memory_region_init(system_memory, NULL, "system", UINT64_MAX);
>      address_space_init(&address_space_memory, system_memory, "memory");
>  
> +    system_private_memory = g_malloc(sizeof(*system_private_memory));
> +
> +    memory_region_init(system_private_memory, NULL, "system-private", UINT64_MAX);
> +    address_space_init(&address_space_private_memory, system_private_memory, "private-memory");

Since the description is quite scarce, I don't understand why we need to
add this KVM specific "system-private" MR/AS to all machines on all
architectures.

>      system_io = g_malloc(sizeof(*system_io));
>      memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
>                            65536);

(We already want to get ride of the "io" MR/AS which is specific to
x86 or machines).

> @@ -2680,6 +2688,11 @@ MemoryRegion *get_system_memory(void)
>      return system_memory;
>  }
>  
> +MemoryRegion *get_system_private_memory(void)
> +{
> +    return system_private_memory;
> +}
> +
>  MemoryRegion *get_system_io(void)
>  {
>      return system_io;
