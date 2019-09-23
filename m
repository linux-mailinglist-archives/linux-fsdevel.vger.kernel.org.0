Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E01BACE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405984AbfIWDc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Sep 2019 23:32:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404054AbfIWDc4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Sep 2019 23:32:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A22F2D247086B6908A67;
        Mon, 23 Sep 2019 11:32:54 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 11:32:46 +0800
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, <renxudong1@huawei.com>,
        Hou Tao <houtao1@huawei.com>
References: <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190922212934.GC29065@ZenIV.linux.org.uk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <0848b6c7-386c-21fb-233f-be8d9965fbf7@huawei.com>
Date:   Mon, 23 Sep 2019 11:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190922212934.GC29065@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/23 5:29, Al Viro wrote:

> On Sat, Sep 14, 2019 at 09:49:21AM -0700, Linus Torvalds wrote:
>> On Sat, Sep 14, 2019 at 9:16 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>         OK, folks, could you try the following?  It survives the local beating
>>> so far.
>> This looks like the right solution to me. Keep the locking simple,
>> take the dentry refcount as long as we keep a ref to it in "*res".
> *grumble*
>
> Example of subtleties in the whole mess: this is safe for mainline
> now, but only due to "devpts_pty_kill(): don't bother with d_delete()"
> already merged.  Without that, we are risking the following fun:
>
> scan_positive() on devpts: finds a dentry, sees it positive, decides
> to grab the sucker.  Refcount is currently 1 (will become 2 after
> we grab the reference).
>
> devpts_pty_kill(): d_delete(dentry); on that sucker.  Refcount is
> currently (still) 1, so we simply make it negative.
>
> scan_positive(): grabs an extra reference to now negative dentry.
>
> devpts_pty_kill(): dput() drops refcount to 1 (what if it got there
> before scan_positive() grabbed a reference?  Nothing, really, since
> scan_positive() is holding parent's ->d_lock; dput() wouldn't
> have progressed through dentry_kill() until it managed to get
> that, and it would've rechecked the refcount.  So that's not
> a problem)
>
> scan_positive(): returns a reference to negative dentry to
> dcache_readdir().  Which proceeds to oops on
>                 if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
>                               d_inode(next)->i_ino, dt_type(d_inode(next))))
> since d_inode(next) is NULL.
>
> With the aforementioned commit it *is* safe, since the dentry remains
> positive (and unhashed), so we simply act as if dcache_readdir() has
> won the race and emitted a record for the sucker killed by devpts_pty_kill().
>
> IOW, backports will either need to bring that commit in as well, or
> they'll need to play silly buggers along the lines of
>
> 		if (simple_positive(d) && !--count) {
> 			spin_lock(&d->d_lock);
> 			if (likely(simple_positive(d)))
> 				found = dget_dlock(d);
> 			spin_unlock(&d->d_lock);
> 			if (found)
> 				break;
> 			count = 1;	// it's gone, keep scanning
>                 }
> Probably the latter, since it's less dependent on some other place
> doing what devpts used to do...

Is it possible to trigger ABBA deadlock? In next_positive, the lock order is (parent, dentry),

while in dput, the lock order is (dentry, parent). Cause we use spin_trylock(parent), so the ABBA deadlock will not open.

dput

    fast_dput

       spin_lock(&dentry->d_lock)

   dentry_kill

       spin_trylock(&parent->d_lock))

Is there any other scene like dput, but do not use spin_trylock? I am looking for the code, till now do not find this

> .
>

