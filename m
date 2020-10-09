Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3FA288004
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 03:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgJIBaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 21:30:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgJIBaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:30:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15DA58DAC5AD0225ECCE;
        Fri,  9 Oct 2020 09:30:18 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 9 Oct 2020
 09:30:15 +0800
Subject: Re: [PATCH] f2fs: reject CASEFOLD inode flag without casefold feature
To:     Eric Biggers <ebiggers@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>,
        <syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com>
References: <00000000000085be6f05b12a1366@google.com>
 <20201008191522.1948889-1-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cb993e67-b947-81f9-9f0a-10d924710e5c@huawei.com>
Date:   Fri, 9 Oct 2020 09:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201008191522.1948889-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/9 3:15, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> syzbot reported:
> 
>      general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
>      KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>      CPU: 0 PID: 6860 Comm: syz-executor835 Not tainted 5.9.0-rc8-syzkaller #0
>      Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>      RIP: 0010:utf8_casefold+0x43/0x1b0 fs/unicode/utf8-core.c:107
>      [...]
>      Call Trace:
>       f2fs_init_casefolded_name fs/f2fs/dir.c:85 [inline]
>       __f2fs_setup_filename fs/f2fs/dir.c:118 [inline]
>       f2fs_prepare_lookup+0x3bf/0x640 fs/f2fs/dir.c:163
>       f2fs_lookup+0x10d/0x920 fs/f2fs/namei.c:494
>       __lookup_hash+0x115/0x240 fs/namei.c:1445
>       filename_create+0x14b/0x630 fs/namei.c:3467
>       user_path_create fs/namei.c:3524 [inline]
>       do_mkdirat+0x56/0x310 fs/namei.c:3664
>       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>       entry_SYSCALL_64_after_hwframe+0x44/0xa9
>      [...]
> 
> The problem is that an inode has F2FS_CASEFOLD_FL set, but the
> filesystem doesn't have the casefold feature flag set, and therefore
> super_block::s_encoding is NULL.
> 
> Fix this by making sanity_check_inode() reject inodes that have
> F2FS_CASEFOLD_FL when the filesystem doesn't have the casefold feature.
> 
> Reported-by: syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
> Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
