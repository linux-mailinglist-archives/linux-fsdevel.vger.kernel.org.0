Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C662EF70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiKRIah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 03:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiKRIaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:30:00 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD5E4D5E0;
        Fri, 18 Nov 2022 00:29:34 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND91H6P2VzmVk8;
        Fri, 18 Nov 2022 16:29:07 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:29:32 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:29:32 +0800
Subject: Re: [PATCH] fs/buffer: fix a NULL pointer dereference in
 drop_buffers()
To:     Matthew Wilcox <willy@infradead.org>
References: <20221109095018.4108726-1-liushixin2@huawei.com>
 <Y3cYd6u9wT/ZTHbe@casper.infradead.org>
 <ba12f39a-4b43-7297-f1fa-b4eb0bbd79a8@huawei.com>
 <Y3c7Pko8AC3ZThgX@casper.infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <f447866f-ae3b-a1b7-ce9c-31e138b6854a@huawei.com>
Date:   Fri, 18 Nov 2022 16:29:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y3c7Pko8AC3ZThgX@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/18 15:58, Matthew Wilcox wrote:
> On Fri, Nov 18, 2022 at 03:54:54PM +0800, Liu Shixin wrote:
>> On 2022/11/18 13:30, Matthew Wilcox wrote:
>>> On Wed, Nov 09, 2022 at 05:50:18PM +0800, Liu Shixin wrote:
>>>> syzbot found a null-ptr-deref by KASAN:
>>>>
>>>>  BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
>>>>  BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>>>>  BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2856 [inline]
>>>>  BUG: KASAN: null-ptr-deref in drop_buffers+0x61/0x2f0 fs/buffer.c:2868
>>>>  Read of size 4 at addr 0000000000000060 by task syz-executor.5/24786
>>>>
>>>>  CPU: 0 PID: 24786 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
>>>>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
>>>>  Call Trace:
>>>>   <TASK>
>>>>   __dump_stack lib/dump_stack.c:88 [inline]
>>>>   dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>>>>   print_report+0xf1/0x220 mm/kasan/report.c:436
>>>>   kasan_report+0xfb/0x130 mm/kasan/report.c:495
>>>>   kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
>>>>   instrument_atomic_read include/linux/instrumented.h:71 [inline]
>>>>   atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>>>>   buffer_busy fs/buffer.c:2856 [inline]
>>>>   drop_buffers+0x61/0x2f0 fs/buffer.c:2868
>>>>   try_to_free_buffers+0x2b1/0x640 fs/buffer.c:2898
>>>> [...]
>>>>
>>>> We use folio_has_private() to decide whether call filemap_release_folio(),
>>>> which may call try_to_free_buffers() then. folio_has_private() return true
>>>> for both PG_private and PG_private_2. We should only call try_to_free_buffers()
>>>> for case PG_private. So we should recheck PG_private in try_to_free_buffers().
>>>>
>>>> Reported-by: syzbot+fbdb4ec578ebdcfb9ed2@syzkaller.appspotmail.com
>>>> Fixes: 266cf658efcf ("FS-Cache: Recruit a page flags for cache management")
>>> but this can only happen for a filesystem which uses both bufferheads
>>> and PG_private_2.  afaik there aren't any of those in the tree.  so
>>> this bug can't actually happen.
>>>
>>> if you have your own filesystem that does, you need to submit it.
>> This null-ptr-deref is found by syzbot, not by my own filesystem. I review the related code and
>> found no other possible cause. There are lock protection all the place calling try_to_free_buffers().
>> So I only thought of this one possibility. I'm also trying to reproduce the problem but haven't
>> been successful.
>>
>> If this can't actually happen, maybe I'm missing something when review the code. I'll keep trying
>> to see if I can reproduce the problem.
> perhaps you could include more information, like the rest of the call
> stack so we can see what filesystem is involved?
This is the original link about the bug:
https://groups.google.com/g/syzkaller-bugs/c/sqeWJ62OEsc/m/kr6FRxXqBAAJ
>
> .
>

