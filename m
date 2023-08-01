Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E774976BA04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjHAQyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjHAQyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6E2116;
        Tue,  1 Aug 2023 09:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C0016163D;
        Tue,  1 Aug 2023 16:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3C1C433C7;
        Tue,  1 Aug 2023 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908843;
        bh=liMpSScDu0h+PrjpmqiYb+Q+6aHOwyISw4j8BFIcGVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIFlmOCqJS8iQcXvk8oNZxNGz4QNLszdREetAXo8Uo+jxPN2dAxboF2ywOt+r6sF4
         1Ce2+7VJBYSGs32seKXUp9myi6IuJy6hA4JORLtRMmgg1V/NnkE6s5/mCkx/yY5eSx
         hJeilqNSHkRQUd3TgjbR5C3RqdbDv1v8l8q/HRJ5d4R42KAnIGAb5tXRn9g5WJ8qqo
         mDEv5+Zw5cXJgVkudwVKqN6SYARTjqDZCN6holglfEyaqBXFe9dSofXvT6coPEOgpA
         xj+s68tMRVaVcMe1Q2cVhtEHL+1/z/BwX05ZAZfo29BBJ2ZA0XJP5VyrA4HxSuC/Yz
         troFt3trmDEBw==
Date:   Tue, 1 Aug 2023 19:53:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 10/36] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Message-ID: <20230801165312.GB2607694@kernel.org>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-10-cddf9f980d98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-arm64-gcs-v3-10-cddf9f980d98@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:43:19PM +0100, Mark Brown wrote:
> Use VM_HIGH_ARCH_5 for guarded control stack pages.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/filesystems/proc.rst |  2 +-
>  fs/proc/task_mmu.c                 |  3 +++
>  include/linux/mm.h                 | 12 +++++++++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 6ccb57089a06..086a0408a4d7 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -566,7 +566,7 @@ encoded manner. The codes are the following:
>      mt    arm64 MTE allocation tags are enabled
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
> -    ss    shadow stack page
> +    ss    shadow/guarded control stack page

I've missed this in Rick's patches, but it's not a page but area.

>      ==    =======================================
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index cfab855fe7e9..e8c50848bb16 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  #ifdef CONFIG_X86_USER_SHADOW_STACK
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
> +#endif
> +#ifdef CONFIG_ARM64_GCS
> +		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
>  	};
>  	size_t i;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 43fe625b85aa..3f939ae212e5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -372,7 +372,17 @@ extern unsigned int kobjsize(const void *objp);
>   * having a PAGE_SIZE guard gap.
>   */
>  # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
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
> +
> +#ifndef VM_SHADOW_STACK
>  # define VM_SHADOW_STACK	VM_NONE
>  #endif
>  
> 
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
