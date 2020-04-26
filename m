Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7F1B9491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 00:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDZWsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbgDZWsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 18:48:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C7C061A0F;
        Sun, 26 Apr 2020 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=AkOxz0hYzToBQAdMTy1OFCG6DGIoX6S2ij8wphXo/3c=; b=ezBGeWRzUcAo6P/ZWshB/Psy6a
        oXrNcJlTmb+ZkdaGM6ieKZ8fCWBo7lPew6jFB+sVvrRSWj3oSa5T8wMl7FNEZW/LCGqyeUHxJ8kpO
        9dOXYJcnKnQYch3u0n/81yksJSl7TIJBKQRW1NlsTSSLRK3uCIifsyFQ7/COcx9NH1ApPHUcco3R1
        9mUcwPheC14zKa0th+YBtKFQN6YdmE5nw8r6tB7CnOei0LgF3ST5lM0Fw/zgzLUwagTX3jbH5YkLe
        NdgU2+0MQGPSdsHUggDWWoE+7WeoCNpvK76s0NbKRX8JEsp2Ob5VdC22kCv7faW3LwQtBxlksTy4e
        8zQ/vyAQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSq4i-0007ek-Qq; Sun, 26 Apr 2020 22:48:36 +0000
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Minchan Kim <minchan@kernel.org>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
 <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
Message-ID: <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
Date:   Sun, 26 Apr 2020 15:48:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/20 10:26 AM, Randy Dunlap wrote:
> On 4/26/20 12:16 AM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2020-04-26-00-15 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> http://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
> 
> Hi,
> I'm seeing lots of build failures in mm/madvise.c.
> 
> Is Minchin's patch only partially applied or is it just missing some pieces?
> 
> a.  mm/madvise.c needs to #include <linux/uio.h>
> 
> b.  looks like the sys_process_madvise() prototype in <linux/syscalls.h>
> has not been updated:
> 
> In file included from ../mm/madvise.c:11:0:
> ../include/linux/syscalls.h:239:18: error: conflicting types for ‘sys_process_madvise’
>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                   ^
> ../include/linux/syscalls.h:225:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:219:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>                                     ^~~~~~~~~~~~~~~
> ../mm/madvise.c:1295:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
>  SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
>  ^~~~~~~~~~~~~~~
> In file included from ../mm/madvise.c:11:0:
> ../include/linux/syscalls.h:880:17: note: previous declaration of ‘sys_process_madvise’ was here
>  asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
>                  ^~~~~~~~~~~~~~~~~~~

I had to add 2 small patches to have clean madvise.c builds:


---
 include/linux/syscalls.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- mmotm-2020-0426-0015.orig/include/linux/syscalls.h
+++ mmotm-2020-0426-0015/include/linux/syscalls.h
@@ -876,9 +876,9 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
-
-asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
-			size_t len, int behavior, unsigned long flags);
+asmlinkage long sys_process_madvise(int which, pid_t upid,
+		const struct iovec __user *vec, unsigned long vlen,
+		int behavior, unsigned long flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);

---
and
---
 mm/madvise.c |    2 ++
 1 file changed, 2 insertions(+)

--- mmotm-2020-0426-0015.orig/mm/madvise.c
+++ mmotm-2020-0426-0015/mm/madvise.c
@@ -23,12 +23,14 @@
 #include <linux/file.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/compat.h>
 #include <linux/pagewalk.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched/mm.h>
+#include <linux/uio.h>
 
 #include <asm/tlb.h>
 
