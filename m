Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAA40DDAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbhIPPPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 11:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238593AbhIPPPD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9ABA60296;
        Thu, 16 Sep 2021 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805222;
        bh=+lq6B1zWF0TxdP6rMUUAWORQ3vfDH10KdhrcUzKH1ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5welG3KaOYvfAHM1r8AmI87dJHTLcWvkqdE0tUnz7sr39kG6QmgCO2vsmulBZYda
         OwhhGO39vYS0KiD/ZyNV0QbakYzcR7QbL0uaBCfLr7e/yrik/LlHETD54b3SuvIV2N
         ccGTE7u1CxOn2EkJF1Xr8SoyH42N6miBKm8R705Ma+AzdDlRA7cLRL/1K64jLXvM35
         Wo4jeExg5xBkGwHSdmh9dzNHt3yazFq8VRVG4xXUU/yfiQ2dv6Agkvo4xi8lf3RugJ
         HNMT/YgqwOdFw3Dw01D7H1nRsyq43NKgOuLn8DStFsMCBpNx0BkqkkhGEKdagVbI6u
         oNXfpYJUClOng==
Date:   Thu, 16 Sep 2021 16:13:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable
 compat ELF loader
Message-ID: <20210916151330.GA9000@willie-the-truck>
References: <20210916131816.8841-1-will@kernel.org>
 <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Arnd,

On Thu, Sep 16, 2021 at 04:46:15PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 16, 2021 at 3:18 PM Will Deacon <will@kernel.org> wrote:
> >
> > Distributions such as Android which support a mixture of 32-bit (compat)
> > and 64-bit (native) tasks necessarily ship with the compat ELF loader
> > enabled in their kernels. However, as time goes by, an ever-increasing
> > proportion of userspace consists of native applications and in some cases
> > 32-bit capabilities are starting to be removed from the CPUs altogether.
> >
> > Inevitably, this means that the compat code becomes somewhat of a
> > maintenance burden, receiving less testing coverage and exposing an
> > additional kernel attack surface to userspace during the lengthy
> > transitional period where some shipping devices require support for
> > 32-bit binaries.
> >
> > Introduce a new sysctl 'fs.compat-binfmt-elf-enable' to allow the compat
> > ELF loader to be disabled dynamically on devices where it is not required.
> > On arm64, this is sufficient to prevent userspace from executing 32-bit
> > code at all.
> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  fs/compat_binfmt_elf.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > I started off hacking this into the arch code, but then I realised it was
> > just as easy doing it in the core for everybody to enjoy. Unfortunately,
> > after talking to Peter, it sounds like it doesn't really help on x86
> > where userspace can switch to 32-bit without involving the kernel at all.
> >
> > Thoughts?
> 
> I'm not sure I understand the logic behind the sysctl. Are you worried
> about exposing attack surface on devices that don't support 32-bit
> instructions at all but might be tricked into loading a 32-bit binary that
> exploits a bug in the elf loader, or do you want to remove compat support
> on some but not all devices running the same kernel?

It's the latter case. With the GKI effort in Android, we want to run the
same kernel binary across multiple devices. However, for some devices
we may be able to determine that there is no need to support 32-bit
applications even though the hardware may support them, and we would
like to ensure that things like the compat syscall wrappers, compat vDSO,
signal handling etc are not accessible to applications.

> In the first case, having the kernel make the decision based on CPU
> feature flags would be easier. In the second case, I would expect this
> to be a per-process setting similar to prctl, capability or seccomp.
> This would make it possible to do it for separately per container
> and avoid ambiguity about what happens to already-running 32-bit
> tasks.

I'm not sure I follow the per-process aspect of your suggestion -- we want
to prevent 32-bit tasks from existing at all. If it wasn't for GKI, we'd
just disable CONFIG_COMPAT altogether, but while there is a need for 32-bit
support on some devices then we're not able to do that.

Does that make more sense now?

Cheers,

Will
