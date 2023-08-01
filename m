Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B803F76BA6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjHARDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHARD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBF270B;
        Tue,  1 Aug 2023 10:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F116164B;
        Tue,  1 Aug 2023 17:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14158C433C8;
        Tue,  1 Aug 2023 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690909400;
        bh=n2/9ktpmINrFVuBWg1KAR2bAcG2NpG4kfEtaUDByDfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AA0UkNhQxwECDyCEaDtc6JhBhvuvyCYYCaSh4HblOm5/sFOqJy8oy4lzt1PHsqe/d
         TNp/HD+vd9HlKtv5qMTIS+koyMnH6IxwcAdwNwXp4F5+zwZgvrnFbpNoU+QmQ8b5J3
         ddlGURjkJRGzvvXYAv/2/xdGEsvIazcCS7ipemT/wemv7xW5NPdaO+scLqNwkzr3kd
         QYfygusILQtsW8OYGbFyAk8m/i1xYFxg47ufEb41rqQx5La8ZysCvnd1hWLGpVELSo
         6atnVwdyqVnvxRrlqLIxYCR2TAHb6qdezWZ2QfOYTjqX/DgeT6WtV9UpJOx4DAmJz+
         ldxqcY8ezOQig==
Date:   Tue, 1 Aug 2023 20:02:31 +0300
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
Subject: Re: [PATCH v3 11/36] arm64/mm: Map pages for guarded control stack
Message-ID: <20230801170231.GC2607694@kernel.org>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-11-cddf9f980d98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-arm64-gcs-v3-11-cddf9f980d98@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:43:20PM +0100, Mark Brown wrote:
> Map pages flagged as being part of a GCS as such rather than using the
> full set of generic VM flags.
> 
> This is done using a conditional rather than extending the size of
> protection_map since that would make for a very sparse array.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/mm/mmap.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 8f5b7ce857ed..e2ca770920ed 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -79,8 +79,23 @@ arch_initcall(adjust_protection_map);
>  
>  pgprot_t vm_get_page_prot(unsigned long vm_flags)
>  {
> -	pteval_t prot = pgprot_val(protection_map[vm_flags &
> +	pteval_t prot;
> +
> +	/*
> +	 * If this is a GCS then only interpret VM_WRITE.
> +	 *
> +	 * TODO: Just make protection_map[] bigger?  Nothing seems
> +	 * ideal here.
> +	 */

I think extending protection_map and updating adjust_protection_map() is
cleaner and probably faster.

> +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> +		if (vm_flags & VM_WRITE)
> +			prot = _PAGE_GCS;
> +		else
> +			prot = _PAGE_GCS_RO;
> +	} else {
> +		prot = pgprot_val(protection_map[vm_flags &
>  				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> +	}
>  
>  	if (vm_flags & VM_ARM64_BTI)
>  		prot |= PTE_GP;
> 
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
