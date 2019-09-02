Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D2A4D37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 04:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfIBCDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 22:03:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37003 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfIBCDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 22:03:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46MCzN3t6wz9sBF;
        Mon,  2 Sep 2019 12:03:12 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled on littleendian by default.
In-Reply-To: <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de>
References: <cover.1567198491.git.msuchanek@suse.de> <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de>
Date:   Mon, 02 Sep 2019 12:03:12 +1000
Message-ID: <87ftlftpy7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchanek <msuchanek@suse.de> writes:
> On bigendian ppc64 it is common to have 32bit legacy binaries but much
> less so on littleendian.

I think the toolchain people will tell you that there is no 32-bit
little endian ABI defined at all, if anything works it's by accident.

So I think we should not make this selectable, unless someone puts their
hand up to say they want it and are willing to test it and keep it
working.

cheers

> v3: make configurable
> ---
>  arch/powerpc/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5bab0bb6b833..b0339e892329 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -264,8 +264,9 @@ config PANIC_TIMEOUT
>  	default 180
>  
>  config COMPAT
> -	bool
> -	default y if PPC64
> +	bool "Enable support for 32bit binaries"
> +	depends on PPC64
> +	default y if !CPU_LITTLE_ENDIAN
>  	select COMPAT_BINFMT_ELF
>  	select ARCH_WANT_OLD_COMPAT_IPC
>  	select COMPAT_OLD_SIGACTION
> -- 
> 2.22.0
