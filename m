Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC270784557
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjHVPWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjHVPWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFE7CD9
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692717675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+4dLM+qjKpedR3SxcMNZWwteZnGWMqZ2x4IrF9xwmE=;
        b=XhksWGvOujynlzvS4ImTi8AXCHbF/+RC2HFdzjfdePZw4G+w5BHMtkFUwC2tLgFIqeYnT/
        raiaJsyAhEk3yuzXHlvDIMAQM7rZLKhzvyK+VaQ7zym6ealaHlpmGSX0kxVrYW5tJp7w90
        Gb8MlHHpW9UMP8VW5d2D/KVOBmvQmPM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-hdeIGybxNZaVc0ijD0FLWg-1; Tue, 22 Aug 2023 11:21:13 -0400
X-MC-Unique: hdeIGybxNZaVc0ijD0FLWg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso2738825f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692717672; x=1693322472;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+4dLM+qjKpedR3SxcMNZWwteZnGWMqZ2x4IrF9xwmE=;
        b=HVZX3OixJjTCNTii1Dy6j2sVPkB/88cHjmc6kLjvBFdmwX7S7ba0EKlHqUEKc4Drnk
         7+33UDfShw1CRqLsAYSbF6RAK0f5Dcms3NZwuBxom0RvRhfLGh4OMTB/CNqfJxvJM/j3
         Fh54AmQ3jIzUEHS3Ipk7P/E1Pil6hpzFPGMOH+tZJCh2fwt7/paKkgjfEQa04VmRWSUs
         4BGPGsaGZH3fHRHGZAHQFiUTkhivcjoLspW/IOJ5o1KJDBzoYQ9P8ToPnLQTtmJQJdYe
         QPvA6WO1AODpxpwfyKbns1ZZLO59otVKHXpza02wVasDDY/nJKwun5b/zUxHtD/qM0vO
         wZsw==
X-Gm-Message-State: AOJu0YwUwQLL0LylGty5wLZS1K5XJmg76qwWM9v/extmLwy66auQxIpu
        wcNexfVgNBCKX6fThFI7LbGNYF7sFkcLd3KQwdHQdikfjoGeGc72RbwgW/28XyZ8RuAWdTU8V75
        yhmPPfWFzRmvP3fHa/48sVDI18Q==
X-Received: by 2002:a5d:4ccc:0:b0:314:1230:29b0 with SMTP id c12-20020a5d4ccc000000b00314123029b0mr6891022wrt.52.1692717672417;
        Tue, 22 Aug 2023 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvvahb1vrGoYIb2vzRiaZnzgGGGa/+gqBYlj1b7B5EZtm9phlubqZT0TsAOsELNEsT5eF4fQ==
X-Received: by 2002:a5d:4ccc:0:b0:314:1230:29b0 with SMTP id c12-20020a5d4ccc000000b00314123029b0mr6890972wrt.52.1692717671988;
        Tue, 22 Aug 2023 08:21:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c? (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de. [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm3811087wrq.95.2023.08.22.08.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:21:11 -0700 (PDT)
Message-ID: <8f2cf5af-cad7-a69c-e8ec-39f48deae1cb@redhat.com>
Date:   Tue, 22 Aug 2023 17:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 11/37] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
 <20230822-arm64-gcs-v5-11-9ef181dd6324@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230822-arm64-gcs-v5-11-9ef181dd6324@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.08.23 15:56, Mark Brown wrote:
> Use VM_HIGH_ARCH_5 for guarded control stack pages.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   Documentation/filesystems/proc.rst |  2 +-
>   fs/proc/task_mmu.c                 |  3 +++
>   include/linux/mm.h                 | 12 +++++++++++-
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 6ccb57089a06..086a0408a4d7 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -566,7 +566,7 @@ encoded manner. The codes are the following:
>       mt    arm64 MTE allocation tags are enabled
>       um    userfaultfd missing tracking
>       uw    userfaultfd wr-protect tracking
> -    ss    shadow stack page
> +    ss    shadow/guarded control stack page
>       ==    =======================================
>   
>   Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index cfab855fe7e9..e8c50848bb16 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>   #ifdef CONFIG_X86_USER_SHADOW_STACK
>   		[ilog2(VM_SHADOW_STACK)] = "ss",
> +#endif
> +#ifdef CONFIG_ARM64_GCS
> +		[ilog2(VM_SHADOW_STACK)] = "ss",
>   #endif

See my comment below.

>   	};
>   	size_t i;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 43fe625b85aa..3f939ae212e5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -372,7 +372,17 @@ extern unsigned int kobjsize(const void *objp);
>    * having a PAGE_SIZE guard gap.
>    */
>   # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> -#else
> +#endif
> +
> +#if defined(CONFIG_ARM64_GCS)
> +/*
> + * arm64's Guarded Control Stack implements similar functionality and
> + * has similar constraints to shadow stacks.
> + */
> +# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> +#endif


Shouldn't that all just merged with the previous define(s)?

Also, I wonder if we now want to have CONFIG_HAVE_ARCH_SHADOW_STACK or 
similar.

-- 
Cheers,

David / dhildenb

