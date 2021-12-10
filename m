Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422D0470691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbhLJRCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 12:02:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34994 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbhLJRCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:02:44 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 141D5CE2C1E;
        Fri, 10 Dec 2021 16:59:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0827A60C4B;
        Fri, 10 Dec 2021 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1639155545;
        bh=kRdyzfTbRlA8Q6o9ozYIflNqTTqb1/yyQ+Zhl1bc2hI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qehFagygXXv8bbpl27U/7B/DcP1tIA/U/cWnuj39slg4mxEcbhuXFsss1NddlzBIE
         6PkBZYce8BgviUP9YWNtqY/WCPQTLOyw84eVboaBBjEOQla5+S27wj9ObPzqFGeOTI
         VhCCu+m1sjz5CsY/rSDNoqZ/fnHwKR72obNaOkn8=
Date:   Fri, 10 Dec 2021 08:59:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kdump: vmcore: move copy_to() from vmcore.c to
 uaccess.h
Message-Id: <20211210085903.e7820815e738d7dc6da06050@linux-foundation.org>
In-Reply-To: <1639143361-17773-2-git-send-email-yangtiezhu@loongson.cn>
References: <1639143361-17773-1-git-send-email-yangtiezhu@loongson.cn>
        <1639143361-17773-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Dec 2021 21:36:00 +0800 Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> In arch/*/kernel/crash_dump*.c, there exist similar code about
> copy_oldmem_page(), move copy_to() from vmcore.c to uaccess.h,
> and then we can use copy_to() to simplify the related code.
> 
> ...
>
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -238,20 +238,6 @@ copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
>  	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
>  }
>  
> -/*
> - * Copy to either kernel or user space
> - */
> -static int copy_to(void *target, void *src, size_t size, int userbuf)
> -{
> -	if (userbuf) {
> -		if (copy_to_user((char __user *) target, src, size))
> -			return -EFAULT;
> -	} else {
> -		memcpy(target, src, size);
> -	}
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
>  static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
>  {
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac03940..4a6c3e4 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -201,6 +201,20 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
>  	return n;
>  }
>  
> +/*
> + * Copy to either kernel or user space
> + */
> +static inline int copy_to(void *target, void *src, size_t size, int userbuf)
> +{
> +	if (userbuf) {
> +		if (copy_to_user((char __user *) target, src, size))
> +			return -EFAULT;
> +	} else {
> +		memcpy(target, src, size);
> +	}
> +	return 0;
> +}
> +

Ordinarily I'd say "this is too large to be inlined".  But the function
has only a single callsite per architecture so inlining it won't cause
bloat at present.

But hopefully copy_to() will get additional callers in the future, in
which case it shouldn't be inlined.  So I'm thinking it would be best
to start out with this as a regular non-inlined function, in
lib/usercopy.c.

Also, copy_to() is a very poor name for a globally-visible helper
function.  Better would be copy_to_user_or_kernel(), although that's
perhaps a bit long.

And the `userbuf' arg should have type bool, yes?

