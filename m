Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4797259C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgIARNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 13:13:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61806 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbgIARN1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:13:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bgtv04xyTz9v1q9;
        Tue,  1 Sep 2020 19:13:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KHA6UIMLnSZl; Tue,  1 Sep 2020 19:13:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bgtv01r8Xz9v1q8;
        Tue,  1 Sep 2020 19:13:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF1578B7E7;
        Tue,  1 Sep 2020 19:13:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dXOiKVa1V5uo; Tue,  1 Sep 2020 19:13:17 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6B3F8B7E6;
        Tue,  1 Sep 2020 19:13:16 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v2
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200827150030.282762-1-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a8bb0319-0928-4687-9e9c-777c5860dbdd@csgroup.eu>
Date:   Tue, 1 Sep 2020 19:13:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200827150030.282762-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

Le 27/08/2020 à 17:00, Christoph Hellwig a écrit :
> Hi all,
> 
> this series removes the last set_fs() used to force a kernel address
> space for the uaccess code in the kernel read/write/splice code, and then
> stops implementing the address space overrides entirely for x86 and
> powerpc.
> 
> The file system part has been posted a few times, and the read/write side
> has been pretty much unchanced.  For splice this series drops the
> conversion of the seq_file and sysctl code to the iter ops, and thus loses
> the splice support for them.  The reasons for that is that it caused a lot
> of churn for not much use - splice for these small files really isn't much
> of a win, even if existing userspace uses it.  All callers I found do the
> proper fallback, but if this turns out to be an issue the conversion can
> be resurrected.
> 
> Besides x86 and powerpc I plan to eventually convert all other
> architectures, although this will be a slow process, starting with the
> easier ones once the infrastructure is merged.  The process to convert
> architectures is roughtly:
> 
>   (1) ensure there is no set_fs(KERNEL_DS) left in arch specific code
>   (2) implement __get_kernel_nofault and __put_kernel_nofault
>   (3) remove the arch specific address limitation functionality
> 
> Changes since v1:
>   - drop the patch to remove the non-iter ops for /dev/zero and
>     /dev/null as they caused a performance regression
>   - don't enable user access in __get_kernel on powerpc
>   - xfail the set_fs() based lkdtm tests
> 
> Diffstat:
> 


I'm still sceptic with the results I get.

With 5.9-rc2:

root@vgoippro:~# time dd if=/dev/zero of=/dev/null count=1M
1048576+0 records in
1048576+0 records out
536870912 bytes (512.0MB) copied, 5.585880 seconds, 91.7MB/s
real    0m 5.59s
user    0m 1.40s
sys     0m 4.19s


With your series:

root@vgoippro:/tmp# time dd if=/dev/zero of=/dev/null count=1M
1048576+0 records in
1048576+0 records out
536870912 bytes (512.0MB) copied, 7.780540 seconds, 65.8MB/s
real    0m 7.79s
user    0m 2.12s
sys     0m 5.66s




Top of perf report of a standard perf record:

With 5.9-rc2:

     20.31%  dd       [kernel.kallsyms]  [k] __arch_clear_user
      8.37%  dd       [kernel.kallsyms]  [k] transfer_to_syscall
      7.37%  dd       [kernel.kallsyms]  [k] __fsnotify_parent
      6.95%  dd       [kernel.kallsyms]  [k] iov_iter_zero
      5.72%  dd       [kernel.kallsyms]  [k] new_sync_read
      4.87%  dd       [kernel.kallsyms]  [k] vfs_write
      4.47%  dd       [kernel.kallsyms]  [k] vfs_read
      3.07%  dd       [kernel.kallsyms]  [k] ksys_write
      2.77%  dd       [kernel.kallsyms]  [k] ksys_read
      2.65%  dd       [kernel.kallsyms]  [k] __fget_light
      2.37%  dd       [kernel.kallsyms]  [k] __fdget_pos
      2.35%  dd       [kernel.kallsyms]  [k] memset
      1.53%  dd       [kernel.kallsyms]  [k] rw_verify_area
      1.52%  dd       [kernel.kallsyms]  [k] read_iter_zero

With your series:
     19.60%  dd       [kernel.kallsyms]  [k] __arch_clear_user
     10.92%  dd       [kernel.kallsyms]  [k] iov_iter_zero
      9.50%  dd       [kernel.kallsyms]  [k] vfs_write
      8.97%  dd       [kernel.kallsyms]  [k] __fsnotify_parent
      5.46%  dd       [kernel.kallsyms]  [k] transfer_to_syscall
      5.42%  dd       [kernel.kallsyms]  [k] vfs_read
      3.58%  dd       [kernel.kallsyms]  [k] ksys_read
      2.84%  dd       [kernel.kallsyms]  [k] read_iter_zero
      2.24%  dd       [kernel.kallsyms]  [k] ksys_write
      1.80%  dd       [kernel.kallsyms]  [k] __fget_light
      1.34%  dd       [kernel.kallsyms]  [k] __fdget_pos
      0.91%  dd       [kernel.kallsyms]  [k] memset
      0.91%  dd       [kernel.kallsyms]  [k] rw_verify_area

Christophe
