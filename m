Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0A10DD02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfK3HxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 02:53:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfK3HxW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 02:53:22 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BA000E188C4B7D4B184A;
        Sat, 30 Nov 2019 15:53:18 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 15:53:11 +0800
Subject: Re: [PATCH V2 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
To:     Matthew Wilcox <willy@infradead.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>
References: <20191130020225.20239-1-yukuai3@huawei.com>
 <20191130020225.20239-2-yukuai3@huawei.com>
 <20191130034339.GI20752@bombadil.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e2e7c9f1-7152-1d74-c434-c2c4d57d0422@huawei.com>
Date:   Sat, 30 Nov 2019 15:53:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191130034339.GI20752@bombadil.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/11/30 11:43, Matthew Wilcox wrote:
> On Sat, Nov 30, 2019 at 10:02:23AM +0800, yu kuai wrote:
>> However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
>> two dentry are involed. So, add in 'DENTRY_D_LOCK_NESTED_TWICE'.
> 
> No.  These need meaningful names.  Indeed, I think D_LOCK_NESTED is
> a terrible name.
> 
> Looking at the calls:
> 
> $ git grep -n nested.*d_lock fs
> fs/autofs/expire.c:82:          spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> fs/dcache.c:619:                spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> fs/dcache.c:1086:       spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> fs/dcache.c:1303:               spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> fs/dcache.c:2822:               spin_lock_nested(&old_parent->d_lock, DENTRY_D_LOCK_NESTED);
> fs/dcache.c:2827:                       spin_lock_nested(&target->d_parent->d_lock,
> fs/dcache.c:2830:       spin_lock_nested(&dentry->d_lock, 2);
> fs/dcache.c:2831:       spin_lock_nested(&target->d_lock, 3);
> fs/dcache.c:3121:       spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> fs/libfs.c:112:                 spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
> fs/libfs.c:341:         spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> fs/notify/fsnotify.c:129:                       spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> 
> Most of these would be well-expressed by DENTRY_D_LOCK_CHILD.
> 
> The exception is __d_move() where I think we should actually name the
> different lock classes instead of using a bare '2' and '3'.  Something
> like this, perhaps:
> 
Thanks for looking into this, do you mind if I replace your patch with 
the first two patches in the patchset?

Yu Kuai

