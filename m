Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D586E779328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjHKPcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjHKPcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9319A5;
        Fri, 11 Aug 2023 08:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 214DE65E9D;
        Fri, 11 Aug 2023 15:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E1C433C7;
        Fri, 11 Aug 2023 15:32:12 +0000 (UTC)
Date:   Fri, 11 Aug 2023 16:32:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v4 18/36] arm64/gcs: Context switch GCS state for EL0
Message-ID: <ZNZUerbrJmzqZzJw@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-18-68cfa37f9069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-arm64-gcs-v4-18-68cfa37f9069@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:00:23PM +0100, Mark Brown wrote:
> @@ -271,12 +272,31 @@ static void flush_tagged_addr_state(void)
>  		clear_thread_flag(TIF_TAGGED_ADDR);
>  }
>  
> +#ifdef CONFIG_ARM64_GCS
> +
> +static void flush_gcs(void)
> +{
> +	if (system_supports_gcs()) {

Nitpick: use "if (system_supports_gcs()) return" when we have more than
a line in the conditional block (slightly more consistent with other
places).

> +		gcs_free(current);
> +		current->thread.gcs_el0_mode = 0;
> +		write_sysreg_s(0, SYS_GCSCRE0_EL1);
> +		write_sysreg_s(0, SYS_GCSPR_EL0);
> +	}
> +}

Do we need and isb() or there's one on this path? If it's only EL0
making use of this register, we should be fine with the ERET before
returning to user. Not sure whether the kernel uses this, GCSSTTR
doesn't need it.

> +static void gcs_thread_switch(struct task_struct *next)
> +{
> +	if (!system_supports_gcs())
> +		return;
> +
> +	gcs_preserve_current_state();
> +
> +	/*
> +	 * Ensure that GCS changes are observable by/from other PEs in
> +	 * case of migration.
> +	 */
> +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> +		gcsb_dsync();

What's this barrier for? The spec (at least the version I have) only
talks about accesses, nothing to do with the registers that we context
switch here.

-- 
Catalin
