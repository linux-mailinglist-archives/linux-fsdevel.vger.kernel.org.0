Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCB2FE138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbhAUDwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 22:52:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11113 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436599AbhAUCBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:01:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLltp1vmWz15wZF;
        Thu, 21 Jan 2021 09:59:14 +0800 (CST)
Received: from [10.174.177.6] (10.174.177.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 10:00:19 +0800
Subject: Re: [PATCH] fs: fix a hungtask problem when freeze/unfreeze fs
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20210105134600.24022-1-jack@suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <15fad91c-66a9-8be2-36fa-5fa2bbbcb7f5@huawei.com>
Date:   Thu, 21 Jan 2021 10:00:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210105134600.24022-1-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

friendly ping...

On 2021/1/5 21:46, Jan Kara wrote:
> We found the following deadlock when running xfstests generic/390 with ext4
> filesystem, and simutaneously offlining/onlining the disk we tested. It will
> cause a deadlock whose call trace is like this:
>
> fsstress        D    0 11672  11625 0x00000080
> Call Trace:
>   ? __schedule+0x2fc/0x930
>   ? filename_parentat+0x10b/0x1a0
>   schedule+0x28/0x70
>   rwsem_down_read_failed+0x102/0x1c0
>   ? __percpu_down_read+0x93/0xb0
>   __percpu_down_read+0x93/0xb0
>   __sb_start_write+0x5f/0x70
>   mnt_want_write+0x20/0x50
>   do_renameat2+0x1f3/0x550
>   __x64_sys_rename+0x1c/0x20
>   do_syscall_64+0x5b/0x1b0
>   entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> The root cause is that when ext4 hits IO error due to disk being
> offline, it will switch itself into read-only state. When it is frozen
> at that moment, following thaw_super() call will not unlock percpu
> freeze semaphores (as the fs is read-only) causing the deadlock.
>
>
>   };
