Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F173F12C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 05:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjF0DK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 23:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0DK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:10:26 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B5BB
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 20:10:23 -0700 (PDT)
Date:   Mon, 26 Jun 2023 23:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687835422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmhUBX2ZB02c55g8bPJJRmeg86fh2l+wtqC8zBugzrE=;
        b=QK0+2kTQHocajlf/RthIsGxma3rgM28r8KUUo1kPstKGHYeKX6ExSJ4iqYg4auuCq71g71
        derzIg/bc/Lw6y1rucZSGUvx487a/eBvu7rXXSAjSCBV5K/iijPqmLW/7IYLplpGtbLb/f
        r62DnMdF2h3Agxa9pN39vI5AG9k+nOM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627031017.en6rkwih7ygbfibc@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:59:13PM -0600, Jens Axboe wrote:
> On 6/26/23 8:05?PM, Kent Overstreet wrote:
> > On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> >> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
> >> either:
> > 
> > It just popped for me on xfs, but it took half an hour or so of looping
> > vs. 30 seconds on bcachefs.
> 
> OK, I'll try and leave it running overnight and see if I can get it to
> trigger.
> 
> >> ~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest/generic/388
> >> realpath: /home/axboe/git/ktest/tests/bcachefs/xfstests.ktest/generic/388: Not a directory
> >> Error 1 at /home/axboe/git/ktest/build-test-kernel 262 from: ktest_test=$(realpath "$1"), exiting
> >>
> >> and I suspect that should've been a space, but:
> >>
> >> ~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest generic/388
> >> Running test xfstests.ktest on m1max at /home/axboe/git/linux-block
> >> No tests found
> >> TEST FAILED
> > 
> > doh, this is because we just changed it to pick up the list of tests
> > from the test lists that fstests generated.
> > 
> > Go into ktest/tests/xfstests and run make and it'll work. (Doesn't
> > matter if make fails due to missing libraries, it'll re-run make inside
> > the VM where the dependencies will all be available).
> 
> OK, I'll try that as well.
> 
> BTW, ran into these too. Didn't do anything, it was just a mount and
> umount trying to get the test going:
> 
> axboe@m1max-kvm ~/g/k/t/xfstests> sudo cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff000201a5e000 (size 1024):
>   comm "bch-copygc/nvme", pid 11362, jiffies 4295015821 (age 6863.776s)
>   hex dump (first 32 bytes):
>     40 00 00 00 00 00 00 00 62 aa e8 ee 00 00 00 00  @.......b.......
>     10 e0 a5 01 02 00 ff ff 10 e0 a5 01 02 00 ff ff  ................
>   backtrace:
>     [<000000002668da56>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<000000006b0b510c>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000041cfdde>] __kmalloc_node+0xac/0xd4
>     [<00000000e1556d66>] kvmalloc_node+0x54/0xe4
>     [<00000000df620afb>] bucket_table_alloc.isra.0+0x44/0x120
>     [<000000005d44ce16>] rhashtable_init+0x148/0x1ac
>     [<00000000fdca7475>] bch2_copygc_thread+0x50/0x2e4
>     [<00000000ea76e08f>] kthread+0xc4/0xd4
>     [<0000000068107ad6>] ret_from_fork+0x10/0x20
> unreferenced object 0xffff000200eed800 (size 1024):
>   comm "bch-copygc/nvme", pid 13934, jiffies 4295086192 (age 6582.296s)
>   hex dump (first 32 bytes):
>     40 00 00 00 00 00 00 00 e8 a5 2a bb 00 00 00 00  @.........*.....
>     10 d8 ee 00 02 00 ff ff 10 d8 ee 00 02 00 ff ff  ................
>   backtrace:
>     [<000000002668da56>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<000000006b0b510c>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000041cfdde>] __kmalloc_node+0xac/0xd4
>     [<00000000e1556d66>] kvmalloc_node+0x54/0xe4
>     [<00000000df620afb>] bucket_table_alloc.isra.0+0x44/0x120
>     [<000000005d44ce16>] rhashtable_init+0x148/0x1ac
>     [<00000000fdca7475>] bch2_copygc_thread+0x50/0x2e4
>     [<00000000ea76e08f>] kthread+0xc4/0xd4
>     [<0000000068107ad6>] ret_from_fork+0x10/0x20

yup, missing a rhashtable_destroy() call, I'll do some kmemleak testing
