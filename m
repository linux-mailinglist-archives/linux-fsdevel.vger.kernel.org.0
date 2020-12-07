Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9402D13FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgLGOru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 09:47:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgLGOrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607352381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWg1t6sTeUgW79K7ShAQcqT7Q1eiw+skkSRDGT0t/ys=;
        b=ccBIpFLGkdJQ/yD7AphOVf6aQNhAXJTp/ZqGLRtIO9gFqBmm5sAKCb77A0LjjMmLVaJPxQ
        9Hre6tMGVythCDCR0WignQOyOiyx+tm+/5/8Sm4OMekcfkRbLDlJT6u4NK9HSsNl6XZqHf
        bC/M2oqdhDvgyTJ1LNZTpKbFAVOwK+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-0dVUfL9vOh2HHBPLYoOQ1w-1; Mon, 07 Dec 2020 09:46:13 -0500
X-MC-Unique: 0dVUfL9vOh2HHBPLYoOQ1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77E8F1005504;
        Mon,  7 Dec 2020 14:46:08 +0000 (UTC)
Received: from ovpn-66-220.rdu2.redhat.com (ovpn-66-220.rdu2.redhat.com [10.10.66.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE5F60BE2;
        Mon,  7 Dec 2020 14:45:59 +0000 (UTC)
Message-ID: <81631d3391abca3f41f2e19092b97a61d49f4e44.camel@redhat.com>
Subject: Re: [PATCH v14 09/10] arch, mm: wire up memfd_secret system call
 were relevant
From:   Qian Cai <qcai@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
Date:   Mon, 07 Dec 2020 09:45:59 -0500
In-Reply-To: <20201203062949.5484-10-rppt@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
         <20201203062949.5484-10-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-12-03 at 08:29 +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Wire up memfd_secret system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/uapi/asm/unistd.h   | 1 +
>  arch/riscv/include/asm/unistd.h        | 1 +
>  arch/x86/entry/syscalls/syscall_32.tbl | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 1 +
>  include/uapi/asm-generic/unistd.h      | 6 +++++-
>  mm/secretmem.c                         | 3 +++
>  scripts/checksyscalls.sh               | 4 ++++
>  8 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> index f83a70e07df8..ce2ee8f1e361 100644
> --- a/arch/arm64/include/uapi/asm/unistd.h
> +++ b/arch/arm64/include/uapi/asm/unistd.h
> @@ -20,5 +20,6 @@
>  #define __ARCH_WANT_SET_GET_RLIMIT
>  #define __ARCH_WANT_TIME32_SYSCALLS
>  #define __ARCH_WANT_SYS_CLONE3
> +#define __ARCH_WANT_MEMFD_SECRET
>  
>  #include <asm-generic/unistd.h>
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 977ee6181dab..6c316093a1e5 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -9,6 +9,7 @@
>   */
>  
>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_MEMFD_SECRET
>  
>  #include <uapi/asm/unistd.h>
>  
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index c52ab1c4a755..109e6681b8fa 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -446,3 +446,4 @@
>  439	i386	faccessat2		sys_faccessat2
>  440	i386	process_madvise		sys_process_madvise
>  441	i386	watch_mount		sys_watch_mount
> +442	i386	memfd_secret		sys_memfd_secret
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f3270a9ef467..742cf17d7725 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -363,6 +363,7 @@
>  439	common	faccessat2		sys_faccessat2
>  440	common	process_madvise		sys_process_madvise
>  441	common	watch_mount		sys_watch_mount
> +442	common	memfd_secret		sys_memfd_secret
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 6d55324363ab..f9d93fbf9b69 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1010,6 +1010,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
>  asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
>  asmlinkage long sys_watch_mount(int dfd, const char __user *path,
>  				unsigned int at_flags, int watch_fd, int watch_id);
> +asmlinkage long sys_memfd_secret(unsigned long flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 5df46517260e..51151888f330 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -861,9 +861,13 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>  __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_watch_mount 441
>  __SYSCALL(__NR_watch_mount, sys_watch_mount)
> +#ifdef __ARCH_WANT_MEMFD_SECRET
> +#define __NR_memfd_secret 442
> +__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
> +#endif

I can't see where was it defined for arm64 after it looks like Andrew has
deleted the  above chunk. Thus, we have a warning using this .config:

https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config

<stdin>:1539:2: warning: #warning syscall memfd_secret not implemented [-Wcpp]

>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 442
> +#define __NR_syscalls 443
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 7236f4d9458a..b8a32954ac68 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -415,6 +415,9 @@ static int __init secretmem_setup(char *str)
>  	unsigned long reserved_size;
>  	int err;
>  
> +	if (!can_set_direct_map())
> +		return 0;
> +
>  	reserved_size = memparse(str, NULL);
>  	if (!reserved_size)
>  		return 0;
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index a18b47695f55..b7609958ee36 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -40,6 +40,10 @@ cat << EOF
>  #define __IGNORE_setrlimit	/* setrlimit */
>  #endif
>  
> +#ifndef __ARCH_WANT_MEMFD_SECRET
> +#define __IGNORE_memfd_secret
> +#endif
> +
>  /* Missing flags argument */
>  #define __IGNORE_renameat	/* renameat2 */
>  

