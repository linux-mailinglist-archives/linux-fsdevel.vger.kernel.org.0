Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374872496F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHSHRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 03:17:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38460 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgHSHR3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:17:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWfHT3GNGz9tx31;
        Wed, 19 Aug 2020 09:17:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 00Qb-dSzLs7G; Wed, 19 Aug 2020 09:17:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWfHT2MxBz9tx30;
        Wed, 19 Aug 2020 09:17:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C25B8B7F5;
        Wed, 19 Aug 2020 09:17:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XHszll2otBUV; Wed, 19 Aug 2020 09:17:26 +0200 (CEST)
Received: from [172.25.230.104] (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3D3B8B767;
        Wed, 19 Aug 2020 09:17:25 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200817073212.830069-1-hch@lst.de>
 <319d15b1-cb4a-a7b4-3082-12bb30eb5143@csgroup.eu>
 <20200818180555.GA29185@lst.de>
 <e3781661-2e13-4f46-d892-181907a2e768@csgroup.eu>
Message-ID: <f2e31c89-dd9e-f0f8-ef5c-e930d01a3b65@csgroup.eu>
Date:   Wed, 19 Aug 2020 09:16:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e3781661-2e13-4f46-d892-181907a2e768@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 18/08/2020 à 20:23, Christophe Leroy a écrit :
> 
> 
> Le 18/08/2020 à 20:05, Christoph Hellwig a écrit :
>> On Tue, Aug 18, 2020 at 07:46:22PM +0200, Christophe Leroy wrote:
>>> I gave it a go on my powerpc mpc832x. I tested it on top of my newest
>>> series that reworks the 32 bits signal handlers (see
>>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=196278) with 
>>>
>>> the microbenchmark test used is that series.
>>>
>>> With KUAP activated, on top of signal32 rework, performance is 
>>> boosted as
>>> system time for the microbenchmark goes from 1.73s down to 1.56s, 
>>> that is
>>> 10% quicker
>>>
>>> Surprisingly, with the kernel as is today without my signal's series, 
>>> your
>>> series degrades performance slightly (from 2.55s to 2.64s ie 3.5% 
>>> slower).
>>>
>>>
>>> I also observe, in both cases, a degradation on
>>>
>>>     dd if=/dev/zero of=/dev/null count=1M
>>>
>>> Without your series, it runs in 5.29 seconds.
>>> With your series, it runs in 5.82 seconds, that is 10% more time.
>>
>> That's pretty strage, I wonder if some kernel text cache line
>> effects come into play here?
>>
>> The kernel access side is only used in slow path code, so it should
>> not make a difference, and the uaccess code is simplified and should be
>> (marginally) faster.
>>
>> Btw, was this with the __{get,put}_user_allowed cockup that you noticed
>> fixed?
>>
> 
> Yes it is with the __get_user_size() replaced by __get_user_size_allowed().

I made a test with only the first patch of your series: That's 
definitely the culprit. With only that patch applies, the duration is 
6.64 seconds, that's a 25% degradation.

A perf record provides the following without the patch:
     41.91%  dd       [kernel.kallsyms]  [k] __arch_clear_user
      7.02%  dd       [kernel.kallsyms]  [k] vfs_read
      6.86%  dd       [kernel.kallsyms]  [k] new_sync_read
      6.68%  dd       [kernel.kallsyms]  [k] iov_iter_zero
      6.03%  dd       [kernel.kallsyms]  [k] transfer_to_syscall
      3.39%  dd       [kernel.kallsyms]  [k] memset
      3.07%  dd       [kernel.kallsyms]  [k] __fsnotify_parent
      2.68%  dd       [kernel.kallsyms]  [k] ksys_read
      2.09%  dd       [kernel.kallsyms]  [k] read_iter_zero
      2.01%  dd       [kernel.kallsyms]  [k] __fget_light
      1.84%  dd       [kernel.kallsyms]  [k] __fdget_pos
      1.35%  dd       [kernel.kallsyms]  [k] rw_verify_area
      1.32%  dd       libc-2.23.so       [.] __GI___libc_write
      1.21%  dd       [kernel.kallsyms]  [k] vfs_write
...
      0.03%  dd       [kernel.kallsyms]  [k] write_null

And the following with the patch:

     15.54%  dd       [kernel.kallsyms]  [k] __arch_clear_user
      9.17%  dd       [kernel.kallsyms]  [k] vfs_read
      6.54%  dd       [kernel.kallsyms]  [k] new_sync_write
      6.31%  dd       [kernel.kallsyms]  [k] transfer_to_syscall
      6.29%  dd       [kernel.kallsyms]  [k] __fsnotify_parent
      6.20%  dd       [kernel.kallsyms]  [k] new_sync_read
      5.47%  dd       [kernel.kallsyms]  [k] memset
      5.13%  dd       [kernel.kallsyms]  [k] vfs_write
      4.44%  dd       [kernel.kallsyms]  [k] iov_iter_zero
      2.95%  dd       [kernel.kallsyms]  [k] write_iter_null
      2.82%  dd       [kernel.kallsyms]  [k] ksys_read
      2.46%  dd       [kernel.kallsyms]  [k] __fget_light
      2.34%  dd       libc-2.23.so       [.] __GI___libc_read
      1.89%  dd       [kernel.kallsyms]  [k] iov_iter_advance
      1.76%  dd       [kernel.kallsyms]  [k] __fdget_pos
      1.65%  dd       [kernel.kallsyms]  [k] rw_verify_area
      1.63%  dd       [kernel.kallsyms]  [k] read_iter_zero
      1.60%  dd       [kernel.kallsyms]  [k] iov_iter_init
      1.22%  dd       [kernel.kallsyms]  [k] ksys_write
      1.14%  dd       libc-2.23.so       [.] __GI___libc_write

Christophe

> 
> Christophe
