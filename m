Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1C230B5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgG1NXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:23:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:37472 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729433AbgG1NXb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:23:31 -0400
Received: from [192.168.15.36]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k0PYr-0004Hm-NN; Tue, 28 Jul 2020 16:22:30 +0300
Subject: Re: [RFC PATCH 5/5] mm: introduce MADV_DOEXEC
To:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1595869887-23307-6-git-send-email-anthony.yznaga@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <743a51db-dc27-c49c-9c65-ac164f5283ba@virtuozzo.com>
Date:   Tue, 28 Jul 2020 16:22:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595869887-23307-6-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.07.2020 20:11, Anthony Yznaga wrote:
> madvise MADV_DOEXEC preserves a memory range across exec.  Initially
> only supported for non-executable, non-stack, anonymous memory.
> MADV_DONTEXEC reverts the effect of a previous MADV_DOXEXEC call and
> undoes the preservation of the range.  After a successful exec call,
> the behavior of all ranges reverts to MADV_DONTEXEC.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/uapi/asm-generic/mman-common.h |  3 +++
>  mm/madvise.c                           | 25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f94f65d429be..7c5f616b28f7 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -72,6 +72,9 @@
>  #define MADV_COLD	20		/* deactivate these pages */
>  #define MADV_PAGEOUT	21		/* reclaim these pages */
>  
> +#define MADV_DOEXEC	22		/* do inherit across exec */
> +#define MADV_DONTEXEC	23		/* don't inherit across exec */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index dd1d43cf026d..b447fa748649 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -103,6 +103,26 @@ static long madvise_behavior(struct vm_area_struct *vma,
>  	case MADV_KEEPONFORK:
>  		new_flags &= ~VM_WIPEONFORK;
>  		break;
> +	case MADV_DOEXEC:

For me MADV_KEEPONEXEC sounds better as it's symmetric to MADV_KEEPONFORK.

> +		/*
> +		 * MADV_DOEXEC is only supported on private, non-executable,
> +		 * non-stack anonymous memory and if the VM_EXEC_KEEP flag
> +		 * is available.
> +		 */
> +		if (!VM_EXEC_KEEP || vma->vm_file || vma->vm_flags & (VM_EXEC|VM_SHARED|VM_STACK)) {
> +			error = -EINVAL;
> +			goto out;
> +		}
> +		new_flags |= (new_flags & ~VM_MAYEXEC) | VM_EXEC_KEEP;
> +		break;
> +	case MADV_DONTEXEC:
> +		if (!VM_EXEC_KEEP) {
> +			error = -EINVAL;
> +			goto out;
> +		}
> +		if (new_flags & VM_EXEC_KEEP)
> +			new_flags |= (new_flags & ~VM_EXEC_KEEP) | VM_MAYEXEC;
> +		break;
>  	case MADV_DONTDUMP:
>  		new_flags |= VM_DONTDUMP;
>  		break;
> @@ -983,6 +1003,8 @@ static int madvise_inject_error(int behavior,
>  	case MADV_SOFT_OFFLINE:
>  	case MADV_HWPOISON:
>  #endif
> +	case MADV_DOEXEC:
> +	case MADV_DONTEXEC:
>  		return true;
>  
>  	default:
> @@ -1037,6 +1059,9 @@ static int madvise_inject_error(int behavior,
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *  MADV_DOEXEC - On exec, preserve and duplicate this area in the new process
> + *		  if the new process allows it.
> + *  MADV_DONTEXEC - Undo the effect of MADV_DOEXEC.
>   *
>   * return values:
>   *  zero    - success
> 

