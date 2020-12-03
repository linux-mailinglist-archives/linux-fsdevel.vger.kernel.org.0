Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589992CE2D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 00:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgLCXkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 18:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgLCXkA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:40:00 -0500
Date:   Thu, 3 Dec 2020 15:39:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607038759;
        bh=zDBJmA1njD9c5R9U97XtgqdT27wAv2IVLfk1nPS0FJM=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=mS6E8T6sd+XV4qfkYaIC7AzHKw/6zG99ExlvCv9CM2GiRif+p2YkZqPRApdyQ8W6k
         4GQb78gRhspuJjIgU7TpCoScNXnKT9kg7Cb/IBT70e6ZKsRZ74kZc1jLZ9uATm4O+j
         kPi+AoMzreC1GgZnwmGefOwVW3qrUNdYbrXPS6vE=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
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
Subject: Re: [PATCH v14 09/10] arch, mm: wire up memfd_secret system call
 were relevant
Message-Id: <20201203153916.91f0f80dcb8a0fa81fc341fa@linux-foundation.org>
In-Reply-To: <20201203062949.5484-10-rppt@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
        <20201203062949.5484-10-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  3 Dec 2020 08:29:48 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Wire up memfd_secret system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
> 
> ...
>
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

Why do we add the ifdef?  Can't we simply define the syscall on all
architectures and let sys_ni do its thing?

