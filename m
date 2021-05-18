Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12F387663
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348450AbhERKZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:25:55 -0400
Received: from foss.arm.com ([217.140.110.172]:48128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239674AbhERKZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:25:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F83E1FB;
        Tue, 18 May 2021 03:24:36 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1EB3F719;
        Tue, 18 May 2021 03:24:27 -0700 (PDT)
Date:   Tue, 18 May 2021 11:24:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <20210518102424.GD82842@C02TD0UTHF1T.local>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-7-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513184734.29317-7-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> It is unsafe to allow saving of secretmem areas to the hibernation
> snapshot as they would be visible after the resume and this essentially
> will defeat the purpose of secret memory mappings.
> 
> Prevent hibernation whenever there are active secret memory users.

Have we thought about how this is going to work in practice, e.g. on
mobile systems? It seems to me that there are a variety of common
applications which might want to use this which people don't expect to
inhibit hibernate (e.g. authentication agents, web browsers).

Are we happy to say that any userspace application can incidentally
inhibit hibernate?

Thanks,
Mark.

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Will Deacon <will@kernel.org>
> ---
>  include/linux/secretmem.h |  6 ++++++
>  kernel/power/hibernate.c  |  5 ++++-
>  mm/secretmem.c            | 15 +++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index e617b4afcc62..21c3771e6a56 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -30,6 +30,7 @@ static inline bool page_is_secretmem(struct page *page)
>  }
>  
>  bool vma_is_secretmem(struct vm_area_struct *vma);
> +bool secretmem_active(void);
>  
>  #else
>  
> @@ -43,6 +44,11 @@ static inline bool page_is_secretmem(struct page *page)
>  	return false;
>  }
>  
> +static inline bool secretmem_active(void)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SECRETMEM */
>  
>  #endif /* _LINUX_SECRETMEM_H */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index da0b41914177..559acef3fddb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -31,6 +31,7 @@
>  #include <linux/genhd.h>
>  #include <linux/ktime.h>
>  #include <linux/security.h>
> +#include <linux/secretmem.h>
>  #include <trace/events/power.h>
>  
>  #include "power.h"
> @@ -81,7 +82,9 @@ void hibernate_release(void)
>  
>  bool hibernation_available(void)
>  {
> -	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
> +	return nohibernate == 0 &&
> +		!security_locked_down(LOCKDOWN_HIBERNATION) &&
> +		!secretmem_active();
>  }
>  
>  /**
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1ae50089adf1..7c2499e4de22 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -40,6 +40,13 @@ module_param_named(enable, secretmem_enable, bool, 0400);
>  MODULE_PARM_DESC(secretmem_enable,
>  		 "Enable secretmem and memfd_secret(2) system call");
>  
> +static atomic_t secretmem_users;
> +
> +bool secretmem_active(void)
> +{
> +	return !!atomic_read(&secretmem_users);
> +}
> +
>  static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> @@ -94,6 +101,12 @@ static const struct vm_operations_struct secretmem_vm_ops = {
>  	.fault = secretmem_fault,
>  };
>  
> +static int secretmem_release(struct inode *inode, struct file *file)
> +{
> +	atomic_dec(&secretmem_users);
> +	return 0;
> +}
> +
>  static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	unsigned long len = vma->vm_end - vma->vm_start;
> @@ -116,6 +129,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
>  }
>  
>  static const struct file_operations secretmem_fops = {
> +	.release	= secretmem_release,
>  	.mmap		= secretmem_mmap,
>  };
>  
> @@ -202,6 +216,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  	file->f_flags |= O_LARGEFILE;
>  
>  	fd_install(fd, file);
> +	atomic_inc(&secretmem_users);
>  	return fd;
>  
>  err_put_fd:
> -- 
> 2.28.0
> 
