Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE49741792
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjF1Ryr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjF1Rya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:54:30 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [IPv6:2001:41d0:203:375::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F24C26B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:54:28 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687974866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRH/yiaIBt1BGCK3wtECdRcCU9jSpluW9EcBNgvsUZU=;
        b=MNqyMbbnZiCc0I0Xram44Jla0y7J5h8Xng6BNCps9hB5HnKKtOt8PaTwzbl02cGEuytao1
        fvIE5RX5Srmla/V6Oji1qfcWNYSvjHLfnM1Ymsl88LaXSIrrh6ixRrXYOj2DhnShnWI8fN
        mImGAj5Z79IRah4+01pAZv1KBAjHnWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628175421.funhhfbx5kdvhclx@moria.home.lan>
References: <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:58:45AM -0600, Jens Axboe wrote:
> On 6/27/23 10:01?PM, Kent Overstreet wrote:
> > On Tue, Jun 27, 2023 at 09:16:31PM -0600, Jens Axboe wrote:
> >> On 6/27/23 2:15?PM, Kent Overstreet wrote:
> >>>> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
> >>>> failing because it assumed it was XFS.
> >>>>
> >>>> I suspected this was just a timing issue, and it looks like that's
> >>>> exactly what it is. Looking at the test case, it'll randomly kill -9
> >>>> fsstress, and if that happens while we have io_uring IO pending, then we
> >>>> process completions inline (for a PF_EXITING current). This means they
> >>>> get pushed to fallback work, which runs out of line. If we hit that case
> >>>> AND the timing is such that it hasn't been processed yet, we'll still be
> >>>> holding a file reference under the mount point and umount will -EBUSY
> >>>> fail.
> >>>>
> >>>> As far as I can tell, this can happen with aio as well, it's just harder
> >>>> to hit. If the fput happens while the task is exiting, then fput will
> >>>> end up being delayed through a workqueue as well. The test case assumes
> >>>> that once it's reaped the exit of the killed task that all files are
> >>>> released, which isn't necessarily true if they are done out-of-line.
> >>>
> >>> Yeah, I traced it through to the delayed fput code as well.
> >>>
> >>> I'm not sure delayed fput is responsible here; what I learned when I was
> >>> tracking this down has mostly fell out of my brain, so take anything I
> >>> say with a large grain of salt. But I believe I tested with delayed_fput
> >>> completely disabled, and found another thing in io_uring with the same
> >>> effect as delayed_fput that wasn't being flushed.
> >>
> >> I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
> >> io_uring can end up doing. But yes, delayed_fput() is another candidate.
> > 
> > Sorry - was just working through my recollections/initial thought
> > process out loud
> 
> No worries, it might actually be a combination and this is why my
> io_uring side patch didn't fully resolve it. Wrote a simple reproducer
> and it seems to reliably trigger it, but is fixed with an flush of the
> delayed fput list on mount -EBUSY return. Still digging...
> 
> >>>> For io_uring specifically, it may make sense to wait on the fallback
> >>>> work. The below patch does this, and should fix the issue. But I'm not
> >>>> fully convinced that this is really needed, as I do think this can
> >>>> happen without io_uring as well. It just doesn't right now as the test
> >>>> does buffered IO, and aio will be fully sync with buffered IO. That
> >>>> means there's either no gap where aio will hit it without O_DIRECT, or
> >>>> it's just small enough that it hasn't been hit.
> >>>
> >>> I just tried your patch and I still have generic/388 failing - it
> >>> might've taken a bit longer to pop this time.
> >>
> >> Yep see the same here. Didn't have time to look into it after sending
> >> that email today, just took a quick stab at writing a reproducer and
> >> ended up crashing bcachefs:
> > 
> > You must have hit an error before we finished initializing the
> > filesystem, the list head never got initialized. Patch for that will be
> > in the testing branch momentarily.
> 
> I'll pull that in. In testing just now, I hit a few more leaks:
> 
> unreferenced object 0xffff0000e55cf200 (size 128):
>   comm "mount", pid 723, jiffies 4294899134 (age 85.868s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000001d69062c>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<00000000c503def2>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cde48528>] __kmalloc+0xac/0xd4
>     [<000000006cb9446a>] kmalloc_array.constprop.0+0x18/0x20
>     [<000000008341b32c>] bch2_fs_alloc+0x73c/0xbcc

Can you faddr2line this? I just did a bunch of kmemleak testing and
didn't see it.

> unreferenced object 0xffff0000e55cf480 (size 128):
>   comm "mount", pid 723, jiffies 4294899134 (age 85.868s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000001d69062c>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<00000000c503def2>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cde48528>] __kmalloc+0xac/0xd4
>     [<0000000097f806f1>] __prealloc_shrinker+0x3c/0x60
>     [<000000008ff20762>] register_shrinker+0x14/0x34
>     [<000000003d050c32>] bch2_fs_btree_key_cache_init+0x88/0x90
>     [<00000000d9f351c0>] bch2_fs_alloc+0x7c0/0xbcc
>     [<000000003b8339fd>] bch2_fs_open+0x19c/0x430
>     [<00000000aef40a23>] bch2_mount+0x194/0x45c
>     [<0000000005e49357>] legacy_get_tree+0x2c/0x54
>     [<00000000f5813622>] vfs_get_tree+0x28/0xd4
>     [<00000000ea6972ec>] path_mount+0x5d0/0x6c8
>     [<00000000468ec307>] do_mount+0x80/0xa4
>     [<00000000ea5d305d>] __arm64_sys_mount+0x150/0x168
>     [<00000000da6d98cb>] invoke_syscall.constprop.0+0x70/0xb8
>     [<000000008f20c487>] do_el0_svc+0xbc/0xf0

This one is actually a bug in unregister_shrinker(), I have a patch I'll
have to send to Andrew.
