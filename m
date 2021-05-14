Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECF1380633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhENJ22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 05:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhENJ21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 05:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620984436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yW2asbdUagGat2ijahWn20ew93BwpmErRmbUGUDMNcY=;
        b=PesLttMemUFfXv4leFnnycKMR7EyGaoYpAU0v/r5JNdfxLgHyxhvVKxVgyPgmx44r89nP9
        10WPakKrV9JVSb8BKJGMMsZ+hUub63RAcAXtv+PL123B+nE0AfDbP39bZ241uPW4lmE0XM
        6e/IqPFzISJ2mkN1o9bFvg2F3HLhM5c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-0wTO_cWANWihwxfOINGVXw-1; Fri, 14 May 2021 05:27:14 -0400
X-MC-Unique: 0wTO_cWANWihwxfOINGVXw-1
Received: by mail-ed1-f70.google.com with SMTP id k10-20020a50cb8a0000b0290387e0173bf7so16190142edi.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 02:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yW2asbdUagGat2ijahWn20ew93BwpmErRmbUGUDMNcY=;
        b=E+UqgB/P/8BAUvrdyo4IgfCYlijy0s18CD5lAnjyfVZ2TyEFkEgJI/DhP8o0MfIyu6
         E25EbyEkl4WePk5OUbLrpGNG+kikeI6TOrv34+zcz+Y/Z2YombWIxWHR+N7OROUyhhNd
         4WaK3czimV50dSaOqJ5GxvhZQvwWyzIHR/G+icr47oZbNY80uGoKN7ScAH2as5O4NbCM
         WQkyzlJONXvkbu1Os4TtNZWAO4CEhdwTaMdbFZaMrazNSoZkR1R4Er1vNKXha3UNnnQg
         mp8pnq6FQN2xVFQAB99+qZHSS9CTusVzh504hzjteGhDENKQsJYmGPGYaDeT4kc0uzh0
         ecLg==
X-Gm-Message-State: AOAM5324/okXv5tbl786GZCkvvOu4zaLRIuhxe1L2Zd1etmkmIxNmqYP
        ZiVGT7SNAAJCl0bQrjfbYRMhCK41EK+wb5yStYUivW2PagUlvTnNXWjzWY3aQluyQ/NcAOKlqf6
        vghrRLjCupeXUhbO5vSZpPVzkbg==
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr55735290edu.241.1620984433538;
        Fri, 14 May 2021 02:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEtOCv5Ls17oMjk/nlAqkQoSV5N2CP4kQHSOXjzJBX9acMLtoFBB9xjtabyDhiKP+sEIswPA==
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr55735269edu.241.1620984433367;
        Fri, 14 May 2021 02:27:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id m9sm3510728ejj.53.2021.05.14.02.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:27:13 -0700 (PDT)
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-7-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d243610c-78df-5e25-cb60-320e7a352d82@redhat.com>
Date:   Fri, 14 May 2021 11:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-7-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> It is unsafe to allow saving of secretmem areas to the hibernation
> snapshot as they would be visible after the resume and this essentially
> will defeat the purpose of secret memory mappings.
> 
> Prevent hibernation whenever there are active secret memory users.
> 
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
>   include/linux/secretmem.h |  6 ++++++
>   kernel/power/hibernate.c  |  5 ++++-
>   mm/secretmem.c            | 15 +++++++++++++++
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index e617b4afcc62..21c3771e6a56 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -30,6 +30,7 @@ static inline bool page_is_secretmem(struct page *page)
>   }
>   
>   bool vma_is_secretmem(struct vm_area_struct *vma);
> +bool secretmem_active(void);
>   
>   #else
>   
> @@ -43,6 +44,11 @@ static inline bool page_is_secretmem(struct page *page)
>   	return false;
>   }
>   
> +static inline bool secretmem_active(void)
> +{
> +	return false;
> +}
> +
>   #endif /* CONFIG_SECRETMEM */
>   
>   #endif /* _LINUX_SECRETMEM_H */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index da0b41914177..559acef3fddb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -31,6 +31,7 @@
>   #include <linux/genhd.h>
>   #include <linux/ktime.h>
>   #include <linux/security.h>
> +#include <linux/secretmem.h>
>   #include <trace/events/power.h>
>   
>   #include "power.h"
> @@ -81,7 +82,9 @@ void hibernate_release(void)
>   
>   bool hibernation_available(void)
>   {
> -	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
> +	return nohibernate == 0 &&
> +		!security_locked_down(LOCKDOWN_HIBERNATION) &&
> +		!secretmem_active();
>   }
>   
>   /**
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1ae50089adf1..7c2499e4de22 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -40,6 +40,13 @@ module_param_named(enable, secretmem_enable, bool, 0400);
>   MODULE_PARM_DESC(secretmem_enable,
>   		 "Enable secretmem and memfd_secret(2) system call");
>   
> +static atomic_t secretmem_users;
> +
> +bool secretmem_active(void)
> +{
> +	return !!atomic_read(&secretmem_users);
> +}
> +
>   static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>   {
>   	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> @@ -94,6 +101,12 @@ static const struct vm_operations_struct secretmem_vm_ops = {
>   	.fault = secretmem_fault,
>   };
>   
> +static int secretmem_release(struct inode *inode, struct file *file)
> +{
> +	atomic_dec(&secretmem_users);
> +	return 0;
> +}
> +
>   static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
>   {
>   	unsigned long len = vma->vm_end - vma->vm_start;
> @@ -116,6 +129,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
>   }
>   
>   static const struct file_operations secretmem_fops = {
> +	.release	= secretmem_release,
>   	.mmap		= secretmem_mmap,
>   };
>   
> @@ -202,6 +216,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>   	file->f_flags |= O_LARGEFILE;
>   
>   	fd_install(fd, file);
> +	atomic_inc(&secretmem_users);
>   	return fd;
>   
>   err_put_fd:
> 

It looks a bit racy, but I guess we don't really care about these corner 
cases.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

