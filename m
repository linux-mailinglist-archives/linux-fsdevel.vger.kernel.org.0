Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6E66CFCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjAPTwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 14:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjAPTv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:51:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BBC2B2BF;
        Mon, 16 Jan 2023 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVpM1mtW3MN+VZv9WJeM6OcVWT6pY0gr9be30QEiFF4=; b=v6Wbig+JaiPH4eX5Rzg2eO5G0o
        44wcgWigoUXogzv4WZhH7Ix7GQc5ZLLX32DsewWcDQCViwLNcGH2MjnBedpjnb2VyX1pn/6QK7gr8
        2akQdyrK8LwUJDOHBYj/FcyCIp40ED/9LuDsCsMjIrW6g9Y+9oVdO2aI7wY2Xz2ajqM8lYM/xHERJ
        0ES8d3O93yZPCGfimX+tJ+Z6XGnXc/AQytUQRYIvsID8rLIzhqsyx1/B5CPzeW6B7O5G/jAqZ9V6y
        Zuu/9FP9+Rsm+gWVm2KzJNmUFpho9iyAFPeL8UJkwpCDi6YQPqFBTCpR4BYAb6oIujh5W3m4GFx+/
        4GinB/lQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHVWP-0091Si-Ga; Mon, 16 Jan 2023 19:51:57 +0000
Date:   Mon, 16 Jan 2023 19:51:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        bagasdotme@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iamjoonsoo.kim@lge.com, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH linux-next v3] swap_state: update shadow_nodes for
 anonymous page
Message-ID: <Y8Wq3apsJh7keUVA@casper.infradead.org>
References: <202301131736452546903@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301131736452546903@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:36:45PM +0800, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Shadow_nodes is for shadow nodes reclaiming of workingset handling,
> it is updated when page cache add or delete since long time ago
> workingset only supported page cache. But when workingset supports
> anonymous page detection, we missied updating shadow nodes for
> it. This caused that shadow nodes of anonymous page will never be
> reclaimd by scan_shadow_nodes() even they use much memory and
> system memory is tense.
> 
> So update shadow_nodes of anonymous page when swap cache is
> add or delete by calling  xas_set_update(..workingset_update_node).

What testing did you do of this?  I have this crash in today's testing:

04304 BUG: kernel NULL pointer dereference, address: 0000000000000080
04304 #PF: supervisor read access in kernel mode
04304 #PF: error_code(0x0000) - not-present page
04304 PGD 0 P4D 0
04304 Oops: 0000 [#1] PREEMPT SMP NOPTI
04304 CPU: 4 PID: 3219629 Comm: sh Kdump: loaded Not tainted 6.2.0-rc4-next-20230116-00016-gd289d3de8ce5-dirty #69
04304 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
04304 RIP: 0010:_raw_spin_trylock+0x12/0x50
04304 Code: e0 41 5c 5d c3 89 c6 48 89 df e8 89 06 00 00 4c 89 e0 5b 41 5c 5d c3 90 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 be 5b 71 ff <8b> 03 85 c0 75 16 ba 01 00 00 00 f0 0f b1 13 b8 01 00 00 00 75 06
04304 RSP: 0018:ffff888059afbbb8 EFLAGS: 00010093
04304 RAX: 0000000000000003 RBX: 0000000000000080 RCX: 0000000000000000
04304 RDX: 0000000000000000 RSI: ffff8880033e24c8 RDI: 0000000000000001
04304 RBP: ffff888059afbbc0 R08: 0000000000000000 R09: ffff888059afbd68
04304 R10: ffff88807d9db868 R11: 0000000000000000 R12: ffff8880033e24c0
04304 R13: ffff88800a1d8008 R14: ffff8880033e24c8 R15: ffff8880033e24c0
04304 FS:  00007feeeabc6740(0000) GS:ffff88807d900000(0000) knlGS:0000000000000000
04304 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
04304 CR2: 0000000000000080 CR3: 0000000059830003 CR4: 0000000000770ea0
04304 PKRU: 55555554
04304 Call Trace:
04304  <TASK>
04304  shadow_lru_isolate+0x3a/0x120
04304  __list_lru_walk_one+0xa3/0x190
04304  ? memcg_list_lru_alloc+0x330/0x330
04304  ? memcg_list_lru_alloc+0x330/0x330
04304  list_lru_walk_one_irq+0x59/0x80
04304  scan_shadow_nodes+0x27/0x30
04304  do_shrink_slab+0x13b/0x2e0
04304  shrink_slab+0x92/0x250
04304  drop_slab+0x41/0x90
04304  drop_caches_sysctl_handler+0x70/0x80
04304  proc_sys_call_handler+0x162/0x210
04304  proc_sys_write+0xe/0x10
04304  vfs_write+0x1c7/0x3a0
04304  ksys_write+0x57/0xd0
04304  __x64_sys_write+0x14/0x20
04304  do_syscall_64+0x34/0x80
04304  entry_SYSCALL_64_after_hwframe+0x63/0xcd
04304 RIP: 0033:0x7feeeacc1190

Decoding it, shadow_lru_isolate+0x3a/0x120 maps back to this line:

        if (!spin_trylock(&mapping->host->i_lock)) {

i_lock is at offset 128 of struct inode, so that matches the dump.
I believe that swapper_spaces never have ->host set, so I don't
believe you've tested this patch since 51b8c1fe250d went in
back in 2021.
