Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD325BDF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgICI4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 04:56:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32099 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgICI4R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:56:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BhvmX2Z1czB09b1;
        Thu,  3 Sep 2020 10:56:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IpxxRaqw7gdu; Thu,  3 Sep 2020 10:56:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BhvmX0njbzB09b0;
        Thu,  3 Sep 2020 10:56:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 38FCA8B7B7;
        Thu,  3 Sep 2020 10:56:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p0dUuYBZyAAj; Thu,  3 Sep 2020 10:56:13 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DFDE8B7B1;
        Thu,  3 Sep 2020 10:56:12 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
 <d78cb4be-48a9-a7c5-d9d1-d04d2a02b4c6@csgroup.eu>
 <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
 <20200903071144.GA19247@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0f042edf-f277-7637-9913-850cbb7bf3a4@csgroup.eu>
Date:   Thu, 3 Sep 2020 10:55:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903071144.GA19247@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 03/09/2020 à 09:11, Christoph Hellwig a écrit :
> 
> Except that we do not actually have such a patch.  For normal user
> writes we only use ->write_iter if ->write is not present.  But what
> shows up in the profile is that /dev/zero only has a read_iter op and
> not a normal read.  I've added a patch below that implements a normal
> read which might help a tad with this workload, but should not be part
> of a regression.
> 

With that patch below, throughput is 113.5MB/s (instead of 99.9MB/s).
So a 14% improvement. That's not bad.

Christophe

> 
> ---
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index abd4ffdc8cdebc..1dc99ab158457a 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -726,6 +726,27 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
>   	return written;
>   }
>   
> +static ssize_t read_zero(struct file *file, char __user *buf,
> +			 size_t count, loff_t *ppos)
> +{
> +	size_t cleared = 0;
> +
> +	while (count) {
> +		size_t chunk = min_t(size_t, count, PAGE_SIZE);
> +
> +		if (clear_user(buf + cleared, chunk))
> +			return cleared ? cleared : -EFAULT;
> +		cleared += chunk;
> +		count -= chunk;
> +
> +		if (signal_pending(current))
> +			return cleared ? cleared : -ERESTARTSYS;
> +		cond_resched();
> +	}
> +
> +	return cleared;
> +}
> +
>   static int mmap_zero(struct file *file, struct vm_area_struct *vma)
>   {
>   #ifndef CONFIG_MMU
> @@ -921,6 +942,7 @@ static const struct file_operations zero_fops = {
>   	.llseek		= zero_lseek,
>   	.write		= write_zero,
>   	.read_iter	= read_iter_zero,
> +	.read		= read_zero,
>   	.write_iter	= write_iter_zero,
>   	.mmap		= mmap_zero,
>   	.get_unmapped_area = get_unmapped_area_zero,
> 
