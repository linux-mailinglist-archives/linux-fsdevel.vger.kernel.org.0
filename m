Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11E3BF7CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGHJzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 05:55:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhGHJzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:55:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLBMP60LjzZpW0;
        Thu,  8 Jul 2021 17:49:05 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 17:52:18 +0800
Received: from [10.174.148.223] (10.174.148.223) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 17:52:17 +0800
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arch@vger.kernel.org>
CC:     <mhocko@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <arnd@arndb.de>, <ebiederm@xmission.com>, <keescook@chromium.org>,
        <gerg@linux-m68k.org>, <ktkhai@virtuozzo.com>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <esyr@redhat.com>, <jgg@ziepe.ca>, <christian@kellner.me>,
        <areber@redhat.com>, <cyphar@cyphar.com>,
        <steven.sistare@oracle.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
Date:   Thu, 8 Jul 2021 17:52:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anthony and Steven,

ÔÚ 2020/7/28 1:11, Anthony Yznaga Ð´µÀ:
> This patchset adds support for preserving an anonymous memory range across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> sharing memory in this manner, as opposed to re-attaching to a named shared
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address,
> vfio mappings and their associated kernel data structures can remain valid.
> In addition, for the qemu use case, qemu instances that back guest RAM with
> anonymous memory can be updated.
> 

We have a requirement like yours, but ours seems more complex. We want to
isolate some memory regions from the VM's memory space and the start a child
process who will using these memory regions.

I've wrote a draft to support this feature, but I just find that my draft is
pretty like yours.

It seems that you've already abandoned this patchset, why ?

> Patches 1 and 2 ensure that loading of ELF load segments does not silently
> clobber existing VMAS, and remove assumptions that the stack is the only
> VMA in the mm when the stack is set up.  Patch 1 re-introduces the use of
> MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous issues
> and could be considered on its own.
> 
> Patches 3, 4, and 5 introduce the feature and an opt-in method for its use
> using an ELF note.
> 
> Anthony Yznaga (5):
>   elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
>   mm: do not assume only the stack vma exists in setup_arg_pages()
>   mm: introduce VM_EXEC_KEEP
>   exec, elf: require opt-in for accepting preserved mem
>   mm: introduce MADV_DOEXEC
> 
>  arch/x86/Kconfig                       |   1 +
>  fs/binfmt_elf.c                        | 196 +++++++++++++++++++++++++--------
>  fs/exec.c                              |  33 +++++-
>  include/linux/binfmts.h                |   7 +-
>  include/linux/mm.h                     |   5 +
>  include/uapi/asm-generic/mman-common.h |   3 +
>  kernel/fork.c                          |   2 +-
>  mm/madvise.c                           |  25 +++++
>  mm/mmap.c                              |  47 ++++++++
>  9 files changed, 266 insertions(+), 53 deletions(-)
> 

-- 
Sincerely yours,
Longpeng(Mike)
