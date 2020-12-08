Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7E2D202C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 02:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgLHBfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 20:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgLHBfn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:35:43 -0500
Date:   Mon, 7 Dec 2020 17:34:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607391302;
        bh=i3984NOIVWMaE+QFhgCLJtfILbc6/RSkG9XvGukRs7w=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=hca7faBpqEriF6FZPtd0wlbzAlfSR3EKfyTBaBt4dgDAVy9k1yPd7IQFpymwABy3h
         s9qHHlOLbsb4kwF/DfCdj2T4PkbJ+5OVWDB3l03SlUvMWEw9yXHqVH08/s5GvFXorR
         waVdV51wewfkqAeXxoNzsw4CAoe7ms/Mee6ucYrc=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Qian Cai <qcai@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-Id: <20201207173459.a4d4a3404e163314c29f0785@linux-foundation.org>
In-Reply-To: <20201207160006.GG1112728@linux.ibm.com>
References: <20201203062949.5484-1-rppt@kernel.org>
        <20201203062949.5484-10-rppt@kernel.org>
        <81631d3391abca3f41f2e19092b97a61d49f4e44.camel@redhat.com>
        <20201207160006.GG1112728@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 7 Dec 2020 18:00:06 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:

> > 
> > I can't see where was it defined for arm64 after it looks like Andrew has
> > deleted the  above chunk. Thus, we have a warning using this .config:
> > 
> > https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
> > 
> > <stdin>:1539:2: warning: #warning syscall memfd_secret not implemented [-Wcpp]
> 
> I was under the impression that Andrew only removed the #ifdef...
> 
> Andrew, can you please restore syscall definition for memfd_secret() in
> include/uapi/asm-generic/unistd.h?
> 

urgh, OK, that seems to have got lost in the (moderate amount of)
conflict resolution).

--- a/include/uapi/asm-generic/unistd.h~arch-mm-wire-up-memfd_secret-system-call-were-relevant-fix
+++ a/include/uapi/asm-generic/unistd.h
@@ -863,9 +863,13 @@ __SYSCALL(__NR_process_madvise, sys_proc
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
 #define __NR_epoll_pwait2 442
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
+#ifdef __ARCH_WANT_MEMFD_SECRET
+#define __NR_memfd_secret 443
+__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 443
+#define __NR_syscalls 444
 
 /*
  * 32 bit systems traditionally used different
_

