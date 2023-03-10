Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6955D6B35B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 05:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCJEk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 23:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCJEkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:40:24 -0500
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 20:40:21 PST
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B268102841
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 20:40:19 -0800 (PST)
Date:   Fri, 10 Mar 2023 13:31:37 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678422707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2zysOwE/XmHnnQEWgReghgqR+PBhnvLsAHfZMM+Qa4=;
        b=tXFG+Jg9Cc+ASjSJb5f85Sn4QAmHr6OdtNasQoTS54YtoTxYQ1Z22ditujRLuWd2l4u5lZ
        hhEIISbpKiqFnvfInaEB3IpkHkOukm7qn3P/hUDGs6JVWgnuT6Qmhh+Ns7l2owcwEv1bx9
        NJYxympOP5WD50/Duuq+OnQ5JhmDAsw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, naoya.horiguchi@nec.com
Subject: Re: [PATCH 7/7] mm: return an ERR_PTR from __filemap_get_folio
Message-ID: <20230310043137.GA1624890@u2004>
References: <20230121065755.1140136-1-hch@lst.de>
 <20230121065755.1140136-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230121065755.1140136-8-hch@lst.de>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 07:57:55AM +0100, Christoph Hellwig wrote:
> Instead of returning NULL for all errors, distinguish between:
> 
>  - no entry found and not asked to allocated (-ENOENT)
>  - failed to allocate memory (-ENOMEM)
>  - would block (-EAGAIN)
> 
> so that callers don't have to guess the error based on the passed
> in flags.
> 
> Also pass through the error through the direct callers:
> filemap_get_folio, filemap_lock_folio filemap_grab_folio
> and filemap_get_incore_folio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hello,

I found a NULL pointer dereference issue related to this patch,
so let me share it.

Here is the bug message (I used akpm/mm-unstable on Mar 9):

[ 2871.648659] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2871.651286] #PF: supervisor read access in kernel mode
[ 2871.653231] #PF: error_code(0x0000) - not-present page
[ 2871.655170] PGD 80000001517dd067 P4D 80000001517dd067 PUD 1491d1067 PMD 0
[ 2871.657739] Oops: 0000 [#1] PREEMPT SMP PTI
[ 2871.659329] CPU: 4 PID: 1599 Comm: page-types Tainted: G            E    N 6.3.0-rc1-v6.3-rc1-230309-1629-189-ga71a7+ #36
[ 2871.663362] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
[ 2871.666507] RIP: 0010:mincore_page+0x19/0x90
[ 2871.668086] Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 53 e8 92 2b 03 00 48 3d 00 f0 ff ff 77 54 48 89 c3 <48> 8b 00 48 c1 e8 02 89 c5 83 e5 01 75 21 8b 43 34 85 c0 74 47 f0
[ 2871.678313] RSP: 0018:ffffbe57c203fd00 EFLAGS: 00010207
[ 2871.681422] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 2871.685609] RDX: 0000000000000000 RSI: ffff9f59ca1506d8 RDI: ffff9f59ce7c2880
[ 2871.689599] RBP: 0000000000000000 R08: 00007f9f14200000 R09: ffff9f59c9078508
[ 2871.693295] R10: 00007f9ed4400000 R11: 0000000000000000 R12: 0000000000000200
[ 2871.695969] R13: 0000000000000001 R14: ffff9f59c9ef4450 R15: ffff9f59c4ac9000
[ 2871.699927] FS:  00007f9ed47ee740(0000) GS:ffff9f5abbc00000(0000) knlGS:0000000000000000
[ 2871.703969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2871.706689] CR2: 0000000000000000 CR3: 0000000149ffe006 CR4: 0000000000170ee0
[ 2871.709923] DR0: ffffffff91531760 DR1: ffffffff91531761 DR2: ffffffff91531762
[ 2871.713424] DR3: ffffffff91531763 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[ 2871.716758] Call Trace:
[ 2871.717998]  <TASK>
[ 2871.719008]  __mincore_unmapped_range+0x6e/0xd0
[ 2871.721220]  mincore_unmapped_range+0x16/0x30
[ 2871.723288]  walk_pgd_range+0x485/0x9e0
[ 2871.725128]  __walk_page_range+0x195/0x1b0
[ 2871.727224]  walk_page_range+0x151/0x180
[ 2871.728883]  __do_sys_mincore+0xec/0x2b0
[ 2871.730707]  do_syscall_64+0x3a/0x90
[ 2871.732179]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 2871.734148] RIP: 0033:0x7f9ed443f4ab
[ 2871.735548] Code: 73 01 c3 48 8b 0d 75 99 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 1b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 99 1b 00 f7 d8 64 89 01 48
[ 2871.742194] RSP: 002b:00007ffe924d72b8 EFLAGS: 00000206 ORIG_RAX: 000000000000001b
[ 2871.744787] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ed443f4ab
[ 2871.747186] RDX: 00007ffe92557300 RSI: 0000000000200000 RDI: 00007f9ed4200000
[ 2871.749404] RBP: 00007ffe92567330 R08: 0000000000000005 R09: 0000000000000000
[ 2871.751683] R10: 00007f9ed4405d68 R11: 0000000000000206 R12: 00007ffe925674b8
[ 2871.753925] R13: 0000000000404af1 R14: 000000000040ad78 R15: 00007f9ed4833000
[ 2871.756493]  </TASK>

The precedure to reproduce this is (1) punch hole some page in a shmem
file, then (2) call mincore() over the punch-holed address range. 

I confirmed that filemap_get_incore_folio() (actually filemap_get_entry()
inside it) returns NULL in that case, so we unexpectedly enter the following
if-block for the "not found" case.

> diff --git a/mm/mincore.c b/mm/mincore.c
> index cd69b9db008126..5437e584b208bf 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -61,7 +61,7 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t index)
>  	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
>  	 */
>  	folio = filemap_get_incore_folio(mapping, index);
> -	if (folio) {
> +	if (!IS_ERR(folio)) {
>  		present = folio_test_uptodate(folio);
>  		folio_put(folio);
>  	}

I guess that this patch intends to make filemap_get_incore_folio() return
non-NULL error code, so replacing the check with "if (!IS_ERR_OR_NULL(folio))"
cannot be a solution. But I have no idea about the fix, so could you help me?

Thanks,
Naoya Horiguchi
