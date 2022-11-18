Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D762EECC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiKRH7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbiKRH6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:58:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90213FB4;
        Thu, 17 Nov 2022 23:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A67AbkwP8KX00tPROSsJtMhFn5xZm18oI+Xo3K1Eqq0=; b=eIJlPU2PyZr0szgoTA8RuS/IGy
        EGTxgMMLgQe4PlP1kYan4s1cl73MClWuUsiK88vNCDo82C4l32pPmyJGpNZj3sQFApzGtkfEOOXed
        vzc28k8SEOpiPLCeDGOBHo7Jso3Egj4ciBSw68nq62O+IGnMTil9nO/4zy6H1J7QdzphAeSDrUqJK
        5puyV/PLfmc6uAyc4dqV9oAlH6UAxPZI3zRdTdoJJqDeeRf4NuxR42JYYY7MVO/UMvh406/HqgU0f
        s6qWB4j1eQ6kZkgYckQo/OjVEf03W/LNURRNPYflbqAoGPDR2tIfZTwkZMV1lsz0I7NVJ2bCmAZPi
        lLCBP2Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovwH0-0024Mo-N6; Fri, 18 Nov 2022 07:58:54 +0000
Date:   Fri, 18 Nov 2022 07:58:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: fix a NULL pointer dereference in
 drop_buffers()
Message-ID: <Y3c7Pko8AC3ZThgX@casper.infradead.org>
References: <20221109095018.4108726-1-liushixin2@huawei.com>
 <Y3cYd6u9wT/ZTHbe@casper.infradead.org>
 <ba12f39a-4b43-7297-f1fa-b4eb0bbd79a8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba12f39a-4b43-7297-f1fa-b4eb0bbd79a8@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 03:54:54PM +0800, Liu Shixin wrote:
> On 2022/11/18 13:30, Matthew Wilcox wrote:
> > On Wed, Nov 09, 2022 at 05:50:18PM +0800, Liu Shixin wrote:
> >> syzbot found a null-ptr-deref by KASAN:
> >>
> >>  BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> >>  BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> >>  BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2856 [inline]
> >>  BUG: KASAN: null-ptr-deref in drop_buffers+0x61/0x2f0 fs/buffer.c:2868
> >>  Read of size 4 at addr 0000000000000060 by task syz-executor.5/24786
> >>
> >>  CPU: 0 PID: 24786 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
> >>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> >>  Call Trace:
> >>   <TASK>
> >>   __dump_stack lib/dump_stack.c:88 [inline]
> >>   dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
> >>   print_report+0xf1/0x220 mm/kasan/report.c:436
> >>   kasan_report+0xfb/0x130 mm/kasan/report.c:495
> >>   kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
> >>   instrument_atomic_read include/linux/instrumented.h:71 [inline]
> >>   atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> >>   buffer_busy fs/buffer.c:2856 [inline]
> >>   drop_buffers+0x61/0x2f0 fs/buffer.c:2868
> >>   try_to_free_buffers+0x2b1/0x640 fs/buffer.c:2898
> >> [...]
> >>
> >> We use folio_has_private() to decide whether call filemap_release_folio(),
> >> which may call try_to_free_buffers() then. folio_has_private() return true
> >> for both PG_private and PG_private_2. We should only call try_to_free_buffers()
> >> for case PG_private. So we should recheck PG_private in try_to_free_buffers().
> >>
> >> Reported-by: syzbot+fbdb4ec578ebdcfb9ed2@syzkaller.appspotmail.com
> >> Fixes: 266cf658efcf ("FS-Cache: Recruit a page flags for cache management")
> > but this can only happen for a filesystem which uses both bufferheads
> > and PG_private_2.  afaik there aren't any of those in the tree.  so
> > this bug can't actually happen.
> >
> > if you have your own filesystem that does, you need to submit it.
> This null-ptr-deref is found by syzbot, not by my own filesystem. I review the related code and
> found no other possible cause. There are lock protection all the place calling try_to_free_buffers().
> So I only thought of this one possibility. I'm also trying to reproduce the problem but haven't
> been successful.
> 
> If this can't actually happen, maybe I'm missing something when review the code. I'll keep trying
> to see if I can reproduce the problem.

perhaps you could include more information, like the rest of the call
stack so we can see what filesystem is involved?
