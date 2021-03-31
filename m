Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2DE3502CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhCaOyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 10:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236101AbhCaOxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617202422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZEKE6hBaJr4eywpWwM7diien2WEI7hK6/ALRAO0X7o=;
        b=gb7P9Y83Phlll0xSC9w6ag/SPoP0hwnx1ER/1BzH9w8zshFDczdj9W1NXgffEBUerE2XMa
        qjimVeIC71TmEtpz6roI1RETLS9nYs55A9wt10UkFSmD8sIblU1Jnan+49DTRsnZmU+vve
        Es3PIxugSa6amr6KT2/kwrZ18V3ou80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-q9s5QEWiO9Oyky6hKm6VYA-1; Wed, 31 Mar 2021 10:53:37 -0400
X-MC-Unique: q9s5QEWiO9Oyky6hKm6VYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F98A612A3;
        Wed, 31 Mar 2021 14:53:28 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17D9910013D7;
        Wed, 31 Mar 2021 14:53:16 +0000 (UTC)
Subject: Re: [PATCH] memfd_secret: use unsigned int rather than long as
 syscall flags type
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
References: <20210331142345.27532-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <516d5d41-8d4a-7519-e88e-e16747e993c9@redhat.com>
Date:   Wed, 31 Mar 2021 16:53:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331142345.27532-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.03.21 16:23, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Yuri Norov says:
> 
>    If parameter size is the same for native and compat ABIs, we may
>    wire a syscall made by compat client to native handler. This is
>    true for unsigned int, but not true for unsigned long or pointer.
> 
>    That's why I suggest using unsigned int and so avoid creating compat
>    entry point.
> 
> Use unsigned int as the type of the flags parameter in memfd_secret()
> system call.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> @Andrew,
> The patch is vs v5.12-rc5-mmots-2021-03-30-23, I'd appreciate if it would
> be added as a fixup to the memfd_secret series.
> 
>   include/linux/syscalls.h                  | 2 +-
>   mm/secretmem.c                            | 2 +-
>   tools/testing/selftests/vm/memfd_secret.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 49c93c906893..1a1b5d724497 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1050,7 +1050,7 @@ asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr _
>   asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
>   		const void __user *rule_attr, __u32 flags);
>   asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
> -asmlinkage long sys_memfd_secret(unsigned long flags);
> +asmlinkage long sys_memfd_secret(unsigned int flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index f2ae3f32a193..3b1ba3991964 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -199,7 +199,7 @@ static struct file *secretmem_file_create(unsigned long flags)
>   	return file;
>   }
>   
> -SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
> +SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>   {
>   	struct file *file;
>   	int fd, err;
> diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
> index c878c2b841fc..2462f52e9c96 100644
> --- a/tools/testing/selftests/vm/memfd_secret.c
> +++ b/tools/testing/selftests/vm/memfd_secret.c
> @@ -38,7 +38,7 @@ static unsigned long page_size;
>   static unsigned long mlock_limit_cur;
>   static unsigned long mlock_limit_max;
>   
> -static int memfd_secret(unsigned long flags)
> +static int memfd_secret(unsigned int flags)
>   {
>   	return syscall(__NR_memfd_secret, flags);
>   }
> 

LGTM

-- 
Thanks,

David / dhildenb

