Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8F3103E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 04:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhBEDxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 22:53:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:34512 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhBEDxi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:53:38 -0500
IronPort-SDR: JFZrqZ04xrDGVnp+AHYSzyfj8S9cIceHbj9MhSj/eiEFi+PVKFv5hU1f5czDOP4Oeya7++hlc+
 2lrdKV9Eu0ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="178812605"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="178812605"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:52:38 -0800
IronPort-SDR: ZtkMwGgKqJszXgT2iemnsvXjrWTCfy7JMDYSFhclK6GT7AqatAZDl6OxFwe30M3WXDZfaXgvBl
 US14tnKSnCGQ==
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="393673586"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:52:37 -0800
Date:   Thu, 4 Feb 2021 19:52:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, Miao Xie <miaox@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix raid6 qstripe kmap'ing
Message-ID: <20210205035236.GB5033@iweiny-DESK2.sc.intel.com>
References: <20210128061503.1496847-1-ira.weiny@intel.com>
 <20210203155648.GE1993@suse.cz>
 <20210204152608.GF1993@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204152608.GF1993@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:26:08PM +0100, David Sterba wrote:
> On Wed, Feb 03, 2021 at 04:56:48PM +0100, David Sterba wrote:
> > On Wed, Jan 27, 2021 at 10:15:03PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > When a qstripe is required an extra page is allocated and mapped.  There
> > > were 3 problems.
> > > 
> > > 1) There is no reason to map the qstripe page more than 1 time if the
> > >    number of bits set in rbio->dbitmap is greater than one.
> > > 2) There is no reason to map the parity page and unmap it each time
> > >    through the loop.
> > > 3) There is no corresponding call of kunmap() for the qstripe page.
> > > 
> > > The page memory can continue to be reused with a single mapping on each
> > > iteration by raid6_call.gen_syndrome() without remapping.  So map the
> > > page for the duration of the loop.
> > > 
> > > Similarly, improve the algorithm by mapping the parity page just 1 time.
> > > 
> > > Fixes: 5a6ac9eacb49 ("Btrfs, raid56: support parity scrub on raid56")
> > > To: Chris Mason <clm@fb.com>
> > > To: Josef Bacik <josef@toxicpanda.com>
> > > To: David Sterba <dsterba@suse.com>
> > > Cc: Miao Xie <miaox@cn.fujitsu.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > This was found while replacing kmap() with kmap_local_page().  After
> > > this patch unwinding all the mappings becomes pretty straight forward.
> > > 
> > > I'm not exactly sure I've worded this commit message intelligently.
> > > Please forgive me if there is a better way to word it.
> > 
> > Changelog is good, thanks. I've added stable tags as the missing unmap
> > is a potential problem.
> 
> There are lots of tests faling, stack traces like below. I haven't seen
> anything obvious in the patch so that needs a closer look and for the
> time being I can't add the patch to for-next.

:-(

I think I may have been off by 1 on the raid6 kmap...

Something like this should fix it...

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b8a39dad0f00..dbf52f1a379d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2370,7 +2370,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
                        goto cleanup;
                }
                SetPageUptodate(q_page);
-               pointers[rbio->real_stripes] = kmap(q_page);
+               pointers[rbio->real_stripes - 1] = kmap(q_page);
        }
 
        atomic_set(&rbio->error, 0);

Let me roll a new version.

Sorry,
Ira

> 
>  BUG: kernel NULL pointer dereference, address:0000000000000000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0 P4D 0
>  Oops: 0002 [#1] PREEMPT SMP
>  CPU: 2 PID: 17173 Comm: kworker/u8:5 Not tainted5.11.0-rc6-default+ #1422
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>  Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
>  RIP: 0010:raid6_avx22_gen_syndrome+0x103/0x140 [raid6_pq]
>  RSP: 0018:ffffa090042cfcf8 EFLAGS: 00010246
>  RAX: ffff9e98e1848e80 RBX: ffff9e98d5849000 RCX:0000000000000020
>  RDX: ffff9e98e32be000 RSI: 0000000000000000 RDI:ffff9e98e1848e80
>  RBP: 0000000000000000 R08: 0000000000000000 R09:0000000000000001
>  R10: ffff9e98e1848e90 R11: ffff9e98e1848e98 R12:0000000000001000
>  R13: ffff9e98e1848e88 R14: 0000000000000005 R15:0000000000000002
>  FS:  0000000000000000(0000) GS:ffff9e993da00000(0000)knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 0000000023143003 CR4:0000000000170ea0
>  Call Trace:
>   finish_parity_scrub+0x47b/0x7a0 [btrfs]
>   raid56_parity_scrub_stripe+0x24e/0x260 [btrfs]
>   btrfs_work_helper+0xd5/0x1d0 [btrfs]
>   process_one_work+0x262/0x5f0
>   worker_thread+0x4e/0x300
>   ? process_one_work+0x5f0/0x5f0
>   kthread+0x151/0x170
>   ? __kthread_bind_mask+0x60/0x60
