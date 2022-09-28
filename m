Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04A95EDED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiI1OcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI1OcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:32:06 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988447757D;
        Wed, 28 Sep 2022 07:32:05 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id r6so2810950wru.8;
        Wed, 28 Sep 2022 07:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=E7cXoL+OAINuYKkrN/dHEiq/+/562x8zxzlLQXZ+zL4=;
        b=wESsnUC6lFN0dvhuLb/XjKh4Rb+BQD92nfHvHhoEyhXkXeqY6CJAT8/QrVqrR80F6h
         Z2LlvoszS5cI2Z6UUr26u98B/4uha41/RJYY2M+yorwnjojb5OdkSZMdP63IInNdqKy8
         OU9UKKON3H/MAQzLZ1J8cce6ketaQxHfLutdgEGx26IhoF9WnjFBxC00cTtPkeZNBPUn
         3WPZtFCw4Ix0GTIjjUrW+YgwxJk9zVseWZIS2P+Vn+SgMYTyJ3/TPO/Hupf0kC9ND6bh
         MGVJpY1q2zb6ASN5GbEksLGz/wE5spBYL9A3S17baTFcvLrpkcPS7MkadiTg/yVrz3zy
         mg8A==
X-Gm-Message-State: ACrzQf3HE+cbPBhfHm+uJt2J79vV+7Nri9RLCz3Q1CtN1rSSQpSYVW53
        fBJbSHk67+DH2t3SWifKcaQ=
X-Google-Smtp-Source: AMsMyM7SDIXEylyKoG9yE7AyA0r4afRknvFCOI0I0KfbpxFoJSX4zbK2LEhmLIh8dYTYfqEFEtDlNQ==
X-Received: by 2002:a05:6000:681:b0:22a:3007:df45 with SMTP id bo1-20020a056000068100b0022a3007df45mr20145418wrb.149.1664375524035;
        Wed, 28 Sep 2022 07:32:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r7-20020adfda47000000b0021e51c039c5sm4337350wrl.80.2022.09.28.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:32:03 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:32:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
Message-ID: <YzRa4U9iFMm0FAVf@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-26-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:56PM +0200, Miguel Ojeda wrote:
> Note that only x86_64 is covered and not all features nor mitigations
> are handled, but it is enough as a starting point and showcases
> the basics needed to add Rust support for a new architecture.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/rust/arch-support.rst |  1 +
>  arch/x86/Kconfig                    |  1 +
>  arch/x86/Makefile                   | 10 ++++++++++
>  scripts/generate_rust_target.rs     | 15 +++++++++++++--
>  4 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> index 1152e0fbdad0..6982b63775da 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -15,4 +15,5 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
>  ============  ================  ==============================================
>  Architecture  Level of support  Constraints
>  ============  ================  ==============================================
> +``x86``       Maintained        ``x86_64`` only.
>  ============  ================  ==============================================
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..3ca198742b10 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -257,6 +257,7 @@ config X86
>  	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
>  	select HAVE_PREEMPT_DYNAMIC_CALL
>  	select HAVE_RSEQ
> +	select HAVE_RUST			if X86_64
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
>  	select HAVE_UNSTABLE_SCHED_CLOCK
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index bafbd905e6e7..2d7e640674c6 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -68,6 +68,7 @@ export BITS
>  #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
>  #
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> +KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2

I do wonder how many more things you will need to list here. As far as
I can tell there is also other avx512* flags for the x86_64 target.

That said, if this works today ...

Reviewed-by: Wei Liu <wei.liu@kernel.org>
