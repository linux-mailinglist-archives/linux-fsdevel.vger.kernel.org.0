Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73E62ED34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 06:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiKRFaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 00:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRFa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:30:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BBF8F3DB;
        Thu, 17 Nov 2022 21:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tnEO6E1grr6Gr3aJvdASXdNYwfa3vFiu4Cif/7kHt0o=; b=hAXwshqplXRMcXB4Z6fOP1HiPs
        BT9RjODtqGH3KfgrOf8sLezL1o2s6p15OuZBZgjTca13ohdU9Kj3I9hPfC1XBXCiYTjzchenK5vHU
        tsLair41qG+krZuXb5RATFOZt0stL42n0ZTVfY++JNWrNtVCYX9OdIfXfXxIbgqUZcdY120BpRJrb
        XOlJrkq5HWbVjpFzoiYNRvejjAM6hrOFMIjmCd52hrkzBarSajLx65XpC899CIqDqWo0uk69Fti9O
        eNJUmL84wwKOX/tepHCWMpEGtADQ7KTYjUVSVHKSiLtAds//QSE5KMPvfabP7kq7z9tvfQN6legdU
        ZSXkXhBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovtxP-001q6a-HB; Fri, 18 Nov 2022 05:30:31 +0000
Date:   Fri, 18 Nov 2022 05:30:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: fix a NULL pointer dereference in
 drop_buffers()
Message-ID: <Y3cYd6u9wT/ZTHbe@casper.infradead.org>
References: <20221109095018.4108726-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109095018.4108726-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:50:18PM +0800, Liu Shixin wrote:
> syzbot found a null-ptr-deref by KASAN:
> 
>  BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>  BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2856 [inline]
>  BUG: KASAN: null-ptr-deref in drop_buffers+0x61/0x2f0 fs/buffer.c:2868
>  Read of size 4 at addr 0000000000000060 by task syz-executor.5/24786
> 
>  CPU: 0 PID: 24786 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
>  Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>   print_report+0xf1/0x220 mm/kasan/report.c:436
>   kasan_report+0xfb/0x130 mm/kasan/report.c:495
>   kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
>   instrument_atomic_read include/linux/instrumented.h:71 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>   buffer_busy fs/buffer.c:2856 [inline]
>   drop_buffers+0x61/0x2f0 fs/buffer.c:2868
>   try_to_free_buffers+0x2b1/0x640 fs/buffer.c:2898
> [...]
> 
> We use folio_has_private() to decide whether call filemap_release_folio(),
> which may call try_to_free_buffers() then. folio_has_private() return true
> for both PG_private and PG_private_2. We should only call try_to_free_buffers()
> for case PG_private. So we should recheck PG_private in try_to_free_buffers().
> 
> Reported-by: syzbot+fbdb4ec578ebdcfb9ed2@syzkaller.appspotmail.com
> Fixes: 266cf658efcf ("FS-Cache: Recruit a page flags for cache management")

but this can only happen for a filesystem which uses both bufferheads
and PG_private_2.  afaik there aren't any of those in the tree.  so
this bug can't actually happen.

if you have your own filesystem that does, you need to submit it.

