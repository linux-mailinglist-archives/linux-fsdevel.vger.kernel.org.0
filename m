Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2B45E43B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 02:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357467AbhKZCAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 21:00:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15871 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357469AbhKZB6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:58:11 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J0d8j5JRXz91CD;
        Fri, 26 Nov 2021 09:54:29 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 09:54:57 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 09:54:56 +0800
Subject: Re: [ramfs] 0858d7da8a: canonical_address#:#[##]
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        <almaz.alexandrovich@paragon-software.com>,
        <kari.argillander@gmail.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>, <ntfs3@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>
References: <20211125140816.GC3109@xsang-OptiPlex-9020>
 <CAHk-=widXZyzRiEzmYuG-bLVtNsptxt4TqAhy75Tbio-V_9oNQ@mail.gmail.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <68587446-fb74-b411-ba19-dd52395567c9@huawei.com>
Date:   Fri, 26 Nov 2021 09:54:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=widXZyzRiEzmYuG-bLVtNsptxt4TqAhy75Tbio-V_9oNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc ntfs3:

Maybe it's a problem like this:

do_new_mount
   fs_context_for_mount
     alloc_fs_context
       ntfs_init_fs_context
         sbi = kzalloc(sizeof(struct ntfs_sb_info), GFP_NOFS);
         fc->s_fs_info = sbi;
   vfs_get_tree
     ntfs_fs_get_tree
       get_tree_bdev
         blkdev_get_by_path  // return error and sbi->sb will be NULL
   put_fs_context
     ntfs_fs_free
       put_ntfs
         ntfs_update_mftmirr
           struct super_block *sb = sbi->sb; // NULL
           u32 blocksize = sb->s_blocksize; // BOOM

It's actually a ntfs3 bug which may be introduced by:

610f8f5a7baf fs/ntfs3: Use new api for mounting


On 2021/11/26 2:03, Linus Torvalds wrote:
> On Thu, Nov 25, 2021 at 6:08 AM kernel test robot <oliver.sang@intel.com> wrote:
>> FYI, we noticed the following commit (built with clang-14):
>>
>> commit: 0858d7da8a09e440fb192a0239d20249a2d16af8 ("ramfs: fix mount source show for ramfs")
> 
> Funky. That commit seems to have nothing to do with the oops:
> 
>> [  806.257788][  T204] /dev/root: Can't open blockdev
>> [  806.259101][  T204] general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN
>> [  806.263082][  T204] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> 
> Not a very helpful error message,a nd the KASAN comment makes little sense, but
> 
>> [ 806.267540][ T204] RIP: 0010:ntfs_update_mftmirr (kbuild/src/consumer/fs/ntfs3/fsntfs.c:834)
> 
> That's
> 
>          u32 blocksize = sb->s_blocksize;
> 
> and presumably with KASAN you end up getting hat odd 0xdffffc0000000003 thing.
> 
> Anyway, looks like sb is NULL, and the code is
> 
>    int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
>    {
>          int err;
>          struct super_block *sb = sbi->sb;
>          u32 blocksize = sb->s_blocksize;
>          sector_t block1, block2;
> 
> although I have no idea how sbi->sb could be NULL.
> 
> Konstantin? See
> 
>      https://lore.kernel.org/lkml/20211125140816.GC3109@xsang-OptiPlex-9020/
> 
> for the full thing.
> 
>               Linus
> .
> 
