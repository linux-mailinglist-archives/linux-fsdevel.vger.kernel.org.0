Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34B93270D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 06:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhB1FwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 00:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhB1FwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 00:52:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABEEC061756
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 21:51:32 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id q20so9019620pfu.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 21:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIHDClkBpaMvFoqSPfjj0EmUE/3x09RJqK+wtPPSg4Y=;
        b=rKUY1oh245LhQvch6JWVGDf6a4r6pxSBfM0feGDNwBeQvC4sHH2+C8P8yMMRa2hRDb
         2Z430wMWNJQsZ/TQbnnJDxA8cG9oKE9/zR+53fRudHo7pYUZRMxXt/jj3TQdUbKFY2/S
         Int/xQmCCvFRLcUk2N5NCIefgHmfwWU+CM+MccAzfAi/q/tsM34pKZrUrctvjunALRsb
         wGb+fEbPb9QcX0ISVMC8Wv6wDWL+WTl0+H7PhJkgApwe/t7FM8WwmrQW6njmo/1wJCV6
         ttUUtGrUXs9bTWLCczPVZ3MzUkec/qnNWVhD9zIGQmdcZlAU+BFTraBeqhNoRrlZ6+D9
         +Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIHDClkBpaMvFoqSPfjj0EmUE/3x09RJqK+wtPPSg4Y=;
        b=R2nrCbmNbBBx6ooBCZVHXVRikorD4p/B5v5r8Vwk1FMqjE53VRnWMG82TY4CJ7jnmp
         S3Uxq/zglSxWY3rExWeuL5BXvT3TNBynGqpv9l4nnr3oTYmQNWj5rvhBl55hdhtdCVRZ
         D0EHmHAMvDeC0lK4qzn8/Cq06LebVDSVSgLGWQOGETep/rpDB/2PzxyO8YT8IzbfUnyI
         ZclC2cGC1aPgUHe3rY4U88g0MBT/9N9gfphZ9SKy0goXCXKv9Dc6Zwwn1BqG8dcyS+h8
         wDPwDDUmiSH3v46BZKi7xiDbqA2USwEGXu63qo4zBvC9qcp31ClhQgSmPZFS5yNSiDRo
         WtPQ==
X-Gm-Message-State: AOAM532Ax+EUyeAR8kExpI3hcyNRz9FQ1BdnGAXBX6xUp+igKr/CXc/0
        s2aIBWEs0J8K0I7TCfDabw2Ezg==
X-Google-Smtp-Source: ABdhPJxu4qnWdcKZTFmnI510cmE3juJdPrITY4fihAAsm2fiWh/KoeqyfS5ON62mq09DISvSV8Ym3Q==
X-Received: by 2002:a63:c601:: with SMTP id w1mr3085474pgg.11.1614491490896;
        Sat, 27 Feb 2021 21:51:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:cd02:8b49:9326:693e])
        by smtp.gmail.com with ESMTPSA id l22sm3715072pjy.51.2021.02.27.21.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 21:51:30 -0800 (PST)
Date:   Sat, 27 Feb 2021 21:51:24 -0800
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jethro Beekman <jethro@fortanix.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC] x86: remove toolchain check for X32 ABI capability
Message-ID: <20210228055124.sj3z5n3o5y4w54au@google.com>
References: <20210227183910.221873-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210227183910.221873-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-02-28, Masahiro Yamada wrote:
>This commit reverts 0bf6276392e9 ("x32: Warn and disable rather than
>error if binutils too old").
>
>The help text in arch/x86/Kconfig says enabling the X32 ABI support
>needs binutils 2.22 or later. This is met because the minimal binutils
>version is 2.23 according to Documentation/process/changes.rst.
>
>I would not say I am not familiar with toolchain configuration, but
>I checked the configure.tgt code in binutils. The elf32_x86_64
>emulation mode seems to be included when it is configured for the
>x86_64-*-linux-* target.
>
>I also tried lld and llvm-objcopy, and succeeded in building x32 VDSO.
>
>I removed the compile-time check in arch/x86/Makefile, in the hope of
>elf32_x86_64 being always supported.
>
>With this, CONFIG_X86_X32 and CONFIG_X86_X32_ABI will be equivalent.
>Rename the former to the latter.

Hi Masahiro, the cleanup looks nice!

As of LLVM toolchain support, I don't know any user using LLVM binary
utilities or LLD.
The support on binary utitlies should be minimum anyway (EM_X86_64,
ELFCLASS32, ELFDATA2LSB are mostly all the tool needs to know for many utilities), so
many of they should just work.

For llvm-objcopy, I know two issues related to `$(OBJCOPY) -O elf32-x86-64`
(actually `objcopy -I elf64-x86-64 -O elf32-x86-64`).  Such an operation tries
to convert an ELFCLASS64 object file to an ELFCLASS32 object file. It is not very clear
what GNU objcopy does. llvm-objcopy is dumb and does not do fancy CLASS conversion.

* {gcc,clang} -gz{,=zlib} produced object files. The Elf{32,64}_Chdr headers are different.
   Seems that GNU objcopy can convert the headers (https://github.com/ClangBuiltLinux/linux/issues/514).
   llvm-objcopy cannot do it.
* Seems that GNU objcopy can convert .note.gnu.property (https://github.com/ClangBuiltLinux/linux/issues/1141#issuecomment-678798228)
   llvm-objcopy cannot do it.


On the linker side, I know TLS relaxations and IBT need special care and I
believe LLD does not handle them correctly. Thankfully the kernel does not use
thread-local storage so this is not an issue. So perhaps for most configurations
it is already working.  Since you've tested it, that is good news to me:)
