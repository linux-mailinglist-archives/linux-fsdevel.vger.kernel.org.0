Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD55EC8F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiI0QEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiI0QEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75801C8893;
        Tue, 27 Sep 2022 09:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D4F61A90;
        Tue, 27 Sep 2022 16:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D400C433D6;
        Tue, 27 Sep 2022 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664294569;
        bh=q2PgX0FVMvjEOsQGJ0Z4Rp2fHN8quFSL88LHc/A4pJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LepGIAypkn5ICKnpSqAhtivRKIpbQawmlkzkmPTkrkDxHuURprVN5KhuGEw+fL7bU
         GTnsGpQvPcdFa5DOps2nSqKruetSljruJsRo5J84Oz4WYTVdkHp1cdWFG14mk0ZNKB
         ONOvno4yA5WYYJmMbtqJLZ+NJk2hx1MPuiTuJAd4TicZrmskpXpJvNFv1PMpJQqnP0
         TqjCc+EzTHREppb+xZf5PY2oVToms4GFYfLiFlFC6msC30PSwVezO1Q7JYjnFLrbN2
         hVOcrQZ/DdYTI4PBlCa6VG/RtCvzkDRLmh6n38Hdn0y6KBOw+BGiIcy5Zi4stjcRhI
         0iLkbMKTXnSbw==
Date:   Tue, 27 Sep 2022 09:02:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: Re: [RFC PATCH] xfs: drop experimental warning for fsdax
Message-ID: <YzMeqNg56v0/t/8x@magnolia>
References: <1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20220919045003.GJ3600936@dread.disaster.area>
 <20220919211533.GK3600936@dread.disaster.area>
 <f10de555-370b-f236-1107-e3089258ebbc@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f10de555-370b-f236-1107-e3089258ebbc@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:53:14PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/9/20 5:15, Dave Chinner 写道:
> > On Mon, Sep 19, 2022 at 02:50:03PM +1000, Dave Chinner wrote:
> > > On Thu, Sep 15, 2022 at 09:26:42AM +0000, Shiyang Ruan wrote:
> > > > Since reflink&fsdax can work together now, the last obstacle has been
> > > > resolved.  It's time to remove restrictions and drop this warning.
> > > > 
> > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > 
> > > I haven't looked at reflink+DAX for some time, and I haven't tested
> > > it for even longer. So I'm currently running a v6.0-rc6 kernel with
> > > "-o dax=always" fstests run with reflink enabled and it's not
> > > looking very promising.
> > > 
> > > All of the fsx tests are failing with data corruption, several
> > > reflink/clone tests are failing with -EINVAL (e.g. g/16[45]) and
> > > *lots* of tests are leaving stack traces from WARN() conditions in
> > > DAx operations such as dax_insert_entry(), dax_disassociate_entry(),
> > > dax_writeback_mapping_range(), iomap_iter() (called from
> > > dax_dedupe_file_range_compare()), and so on.
> > > 
> > > At thsi point - the tests are still running - I'd guess that there's
> > > going to be at least 50 test failures by the time it completes -
> > > in comparison using "-o dax=never" results in just a single test
> > > failure and a lot more tests actually being run.
> > 
> > The end results with dax+reflink were:
> > 
> > SECTION       -- xfs_dax
> > =========================
> > 
> > Failures: generic/051 generic/068 generic/074 generic/075
> > generic/083 generic/091 generic/112 generic/127 generic/164
> > generic/165 generic/175 generic/231 generic/232 generic/247
> > generic/269 generic/270 generic/327 generic/340 generic/388
> > generic/390 generic/413 generic/447 generic/461 generic/471
> > generic/476 generic/517 generic/519 generic/560 generic/561
> > generic/605 generic/617 generic/619 generic/630 generic/649
> > generic/650 generic/656 generic/670 generic/672 xfs/011 xfs/013
> > xfs/017 xfs/068 xfs/073 xfs/104 xfs/127 xfs/137 xfs/141 xfs/158
> > xfs/168 xfs/179 xfs/243 xfs/297 xfs/305 xfs/328 xfs/440 xfs/442
> > xfs/517 xfs/535 xfs/538 xfs/551 xfs/552
> > Failed 61 of 1071 tests
> > 
> > Ok, so I did a new no-reflink run as a baseline, because it is a
> > while since I've tested DAX at all:
> > 
> > SECTION       -- xfs_dax_noreflink
> > =========================
> > Failures: generic/051 generic/068 generic/074 generic/075
> > generic/083 generic/112 generic/231 generic/232 generic/269
> > generic/270 generic/340 generic/388 generic/461 generic/471
> > generic/476 generic/519 generic/560 generic/561 generic/617
> > generic/650 generic/656 xfs/011 xfs/013 xfs/017 xfs/073 xfs/297
> > xfs/305 xfs/517 xfs/538
> > Failed 29 of 1071 tests
> > 
> > Yeah, there's still lots of warnings from dax_insert_entry() and
> > friends like:
> > 
> > [43262.025815] WARNING: CPU: 9 PID: 1309428 at fs/dax.c:380 dax_insert_entry+0x2ab/0x320
> > [43262.028355] Modules linked in:
> > [43262.029386] CPU: 9 PID: 1309428 Comm: fsstress Tainted: G W          6.0.0-rc6-dgc+ #1543
> > [43262.032168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > [43262.034840] RIP: 0010:dax_insert_entry+0x2ab/0x320
> > [43262.036358] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 84 b1 5a 00 eb a4 48 81 e6
> > [43262.042255] RSP: 0018:ffffc9000a0cbb78 EFLAGS: 00010002
> > [43262.043946] RAX: ffffea0018cd1fc0 RBX: 0000000000000001 RCX: 0000000000000001
> > [43262.046233] RDX: ffffea0000000000 RSI: 0000000000000221 RDI: ffffea0018cd2000
> > [43262.048518] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
> > [43262.050762] R10: ffff888241a6d318 R11: 0000000000000001 R12: ffffc9000a0cbc58
> > [43262.053020] R13: ffff888241a6d318 R14: ffffc9000a0cbe20 R15: 0000000000000000
> > [43262.055309] FS:  00007f8ce25e2b80(0000) GS:ffff8885fec80000(0000) knlGS:0000000000000000
> > [43262.057859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [43262.059713] CR2: 00007f8ce25e1000 CR3: 0000000152141001 CR4: 0000000000060ee0
> > [43262.061993] Call Trace:
> > [43262.062836]  <TASK>
> > [43262.063557]  dax_fault_iter+0x243/0x600
> > [43262.064802]  dax_iomap_pte_fault+0x199/0x360
> > [43262.066197]  __xfs_filemap_fault+0x1e3/0x2c0
> > [43262.067602]  __do_fault+0x31/0x1d0
> > [43262.068719]  __handle_mm_fault+0xd6d/0x1650
> > [43262.070083]  ? do_mmap+0x348/0x540
> > [43262.071200]  handle_mm_fault+0x7a/0x1d0
> > [43262.072449]  ? __kvm_handle_async_pf+0x12/0xb0
> > [43262.073908]  exc_page_fault+0x1d9/0x810
> > [43262.075123]  asm_exc_page_fault+0x22/0x30
> > [43262.076413] RIP: 0033:0x7f8ce268bc23
> > 
> > So it looks to me like DAX is well and truly broken in 6.0-rc6. And,
> > yes, I'm running the fixes in mm-hotifxes-stable branch that allow
> > xfs/550 to pass.
> 
> I have tested these two mode for many times:
> 
> xfs_dax mode did failed so many cases.  (If you tested with this "drop"
> patch, some warning around "dax_dedupe_file_range_compare()" won't occur any
> more.)  I think warning around "dax_disassociate_entry()" is a problem with
> concurrency.  Still looking into it.
> 
> But xfs_dax_noreflink didn't have so many failure, just 3 in my environment:
> Failures: generic/471 generic/519 xfs/148.  I am thinking that did you
> forget to reformat the TEST_DEV to be non-reflink before run the test?  If
> so it will make sense.

FWIW I saw dmesg failures in xfs/517 and xfs/013 starting with 6.0-rc5,
and I haven't even turned on reflink yet:

run fstests xfs/517 at 2022-09-26 19:53:34
XFS (pmem1): EXPERIMENTAL Large extent counts feature in use. Use at your own risk!
XFS (pmem1): Mounting V5 Filesystem
XFS (pmem1): Ending clean mount
XFS (pmem1): Quotacheck needed: Please wait.
XFS (pmem1): Quotacheck: Done.
XFS (pmem1): Unmounting Filesystem
XFS (pmem0): EXPERIMENTAL online scrub feature in use. Use at your own risk!
XFS (pmem1): EXPERIMENTAL Large extent counts feature in use. Use at your own risk!
XFS (pmem1): Mounting V5 Filesystem
XFS (pmem1): Ending clean mount
XFS (pmem1): Quotacheck needed: Please wait.
XFS (pmem1): Quotacheck: Done.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 415317 at fs/dax.c:380 dax_insert_entry+0x22d/0x320
Modules linked in: xfs nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables libcrc32c bfq nfnetlink pvpanic_mmio pvpanic nd_pmem dax_pmem nd_btt sch_fq_codel fuse configfs ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_d

CPU: 1 PID: 415317 Comm: fsstress Tainted: G        W          6.0.0-rc7-xfsx #rc7 727341edbd0773a36b78b09dab448fa1896eb3a5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
RIP: 0010:dax_insert_entry+0x22d/0x320
Code: e0 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 62 ff ff ff 48 8b 58 20 48 8d 53 01 e9 4d ff ff ff <0f> 0b e9 6d ff ff ff 31 f6 48 89 ef e8 72 74 12 00 eb a1 83 e0 02
RSP: 0000:ffffc90004693b28 EFLAGS: 00010002
RAX: ffffea0010a20480 RBX: 0000000000000001 RCX: 0000000000000001
RDX: ffffea0000000000 RSI: 0000000000000033 RDI: ffffea0010a204c0
RBP: ffffc90004693c08 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88800c226228 R11: 0000000000000001 R12: 0000000000000011
R13: ffff88800c226228 R14: ffffc90004693e08 R15: 0000000000000000
FS:  00007f3aad8db740(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3aad8d1000 CR3: 0000000043104003 CR4: 00000000001706e0
Call Trace:
 <TASK>
 dax_fault_iter+0x26e/0x670
 dax_iomap_pte_fault+0x1ab/0x3e0
 __xfs_filemap_fault+0x32f/0x5a0 [xfs c617487f99e14abfa5deb24e923415b927df3d4b]
 __do_fault+0x30/0x1e0
 do_fault+0x316/0x6d0
 ? mmap_region+0x2a5/0x620
 __handle_mm_fault+0x649/0x1250
 handle_mm_fault+0xc1/0x220
 do_user_addr_fault+0x1ac/0x610
 ? _copy_to_user+0x63/0x80
 exc_page_fault+0x63/0x130
 asm_exc_page_fault+0x22/0x30
RIP: 0033:0x7f3aada7f1ca
Code: c5 fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 47 60 c5 f8 77 c3 66 0f 1f 84 00 00 00 00 00 40 0f b6 c6 48 89 d1 48 89 fa <f3> aa 48 89 d0 c5 f8 77 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
RSP: 002b:00007ffe47afa688 EFLAGS: 00010206
RAX: 000000000000002e RBX: 0000000000033000 RCX: 000000000000999c
RDX: 00007f3aad8d1000 RSI: 000000000000002e RDI: 00007f3aad8d1000
RBP: 0000558851e13240 R08: 0000000000000000 R09: 0000000000033000
R10: 0000000000000008 R11: 0000000000000246 R12: 028f5c28f5c28f5c
R13: 8f5c28f5c28f5c29 R14: 000000000000999c R15: 0000000000001c81
 </TASK>
---[ end trace 0000000000000000 ]---
XFS (pmem0): Unmounting Filesystem
XFS (pmem1): EXPERIMENTAL online scrub feature in use. Use at your own risk!
XFS (pmem1): *** REPAIR SUCCESS ino 0x80 type probe agno 0x0 inum 0x0 gen 0x0 flags 0x80000001 error 0
XFS (pmem1): Unmounting Filesystem
XFS (pmem1): EXPERIMENTAL Large extent counts feature in use. Use at your own risk!
XFS (pmem1): Mounting V5 Filesystem
XFS (pmem1): Ending clean mount
XFS (pmem1): Unmounting Filesystem

--D

> 
> 
> --
> Thanks,
> Ruan.
> 
> > 
> > Who is actually testing this DAX code, and what are they actually
> > testing on? These are not random failures - I haven't run DAX
> > testing since ~5.18, and none of these failures were present on the
> > same DAX test VM running the same configuration back then....
> > 
> > -Dave.
