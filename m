Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03640DEC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbhIPP6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbhIPP57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:57:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9AC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 08:56:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so7853223pjc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvOiITgt7vwYoMcxAu+V0NwBXXtHyawdPMx1OZX9YgI=;
        b=CkxiKVMCovQGJvZEybqX9WgB6of6RyerHkKNwrvi8sKubQTZafu+M3bcketvDmCHc/
         1bnDC5JXLlkc4pxDfGJ4nTBOvtItYvUMR5R2aM/Qh917B3TSyLQVA4u7F5guEGBWvL+k
         op4ho36CC/rUZPbZLyeQPuRd9u7JwBeyWqYR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WvOiITgt7vwYoMcxAu+V0NwBXXtHyawdPMx1OZX9YgI=;
        b=VyFmfLGNFPW+VVu8t40kbWq0FtyhU41S67WA7sDli8r3W411WV8TQMfr1RpMkMbLtc
         H1H/ScOTT47iV1CvFloQCD3mVw6UdrW997cf5XiuWKC2h0r7Den1RCMwyNkE0HiOHfJH
         9GCNUXVXOcZgW1KbCREHFCP+ofyT5Z0rxXL4BcAaD7UxuY1GhmK8LpdMkgyU+2Pxf2BZ
         q0m0xSvHrKw8/EEo+9fJJl1B1aUvlGsvPURZO1B+zZBCLWKZIeZW6ivX4sfnzCaH0TX3
         vXo8/hgGa6eR9IB9PflvnyaVJxh/9Kh+zBmWmQOyWtVMZA9dN6CPwcollo29MTIpNgZa
         c1Kg==
X-Gm-Message-State: AOAM5314P6klLq/FcUJwBKyDC6NedTdJH/PLnGGUBUHYuFioJIEGN3Lq
        C5isEIbVhP5WX1JyAyXvBIIUh25FO/dY1w==
X-Google-Smtp-Source: ABdhPJxBFNZai7YdYMHu9V7jrdpk4cMS+9Izk9yYJOA50/4HcaYU2LcZ8yq6BjX7fXA+K/5iUCI7ug==
X-Received: by 2002:a17:902:b592:b0:13a:7b0d:f8ba with SMTP id a18-20020a170902b59200b0013a7b0df8bamr5507854pls.43.1631807798348;
        Thu, 16 Sep 2021 08:56:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm3369598pfl.220.2021.09.16.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:56:37 -0700 (PDT)
Date:   Thu, 16 Sep 2021 08:56:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable
 compat ELF loader
Message-ID: <202109160837.B2889037@keescook>
References: <20210916131816.8841-1-will@kernel.org>
 <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
 <20210916151330.GA9000@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916151330.GA9000@willie-the-truck>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:13:37PM +0100, Will Deacon wrote:
> Hi Arnd,
> 
> On Thu, Sep 16, 2021 at 04:46:15PM +0200, Arnd Bergmann wrote:
> > On Thu, Sep 16, 2021 at 3:18 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Distributions such as Android which support a mixture of 32-bit (compat)
> > > and 64-bit (native) tasks necessarily ship with the compat ELF loader
> > > enabled in their kernels. However, as time goes by, an ever-increasing
> > > proportion of userspace consists of native applications and in some cases
> > > 32-bit capabilities are starting to be removed from the CPUs altogether.
> > >
> > > Inevitably, this means that the compat code becomes somewhat of a
> > > maintenance burden, receiving less testing coverage and exposing an
> > > additional kernel attack surface to userspace during the lengthy
> > > transitional period where some shipping devices require support for
> > > 32-bit binaries.
> > >
> > > Introduce a new sysctl 'fs.compat-binfmt-elf-enable' to allow the compat
> > > ELF loader to be disabled dynamically on devices where it is not required.
> > > On arm64, this is sufficient to prevent userspace from executing 32-bit
> > > code at all.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  fs/compat_binfmt_elf.c | 24 +++++++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > >
> > > I started off hacking this into the arch code, but then I realised it was
> > > just as easy doing it in the core for everybody to enjoy. Unfortunately,
> > > after talking to Peter, it sounds like it doesn't really help on x86
> > > where userspace can switch to 32-bit without involving the kernel at all.
> > >
> > > Thoughts?
> > 
> > I'm not sure I understand the logic behind the sysctl. Are you worried
> > about exposing attack surface on devices that don't support 32-bit
> > instructions at all but might be tricked into loading a 32-bit binary that
> > exploits a bug in the elf loader, or do you want to remove compat support
> > on some but not all devices running the same kernel?
> 
> It's the latter case. With the GKI effort in Android, we want to run the
> same kernel binary across multiple devices. However, for some devices
> we may be able to determine that there is no need to support 32-bit
> applications even though the hardware may support them, and we would
> like to ensure that things like the compat syscall wrappers, compat vDSO,
> signal handling etc are not accessible to applications.

I like the idea! I wonder if the binfmts should have an "enabled" flag
instead? This would make it not compat_binfmt_elf-specific, and would
avoid a new "special" sysfs flag:

static bool enabled = 1;
module_param(enabled, bool, 0600);
MODULE_PARM_DESC(enabled, "Whether this binfmt available for loading");

Then:
echo 0 > /sys/module/compat_binfmt_elf/enabled

> 
> > In the first case, having the kernel make the decision based on CPU
> > feature flags would be easier. In the second case, I would expect this
> > to be a per-process setting similar to prctl, capability or seccomp.
> > This would make it possible to do it for separately per container
> > and avoid ambiguity about what happens to already-running 32-bit
> > tasks.
> 
> I'm not sure I follow the per-process aspect of your suggestion -- we want
> to prevent 32-bit tasks from existing at all. If it wasn't for GKI, we'd
> just disable CONFIG_COMPAT altogether, but while there is a need for 32-bit
> support on some devices then we're not able to do that.

It's possible to do process-hierarchy-controlled compat-restriction on
all architectures with an seccomp ARCH test. For example:

	BPF_STMT(BPF_LD+BPF_W+BPF_ABS, arch_nr),
	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, AUDIT_ARCH_X86_64, 1, 0),
	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL_PROCESS)
	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)

This filter will have fixed tiny overhead because of the automatic
seccomp bitmaps.

FWIW, systemd exposes this feature via "SystemCallArchitectures=native".

This doesn't stop the loader attack surface, though, so I think
something to control that makes sense.

-- 
Kees Cook
