Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77C30F647
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhBDP3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 10:29:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237301AbhBDP2o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:28:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35C54ACBA;
        Thu,  4 Feb 2021 15:28:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1FB3DA849; Thu,  4 Feb 2021 16:26:08 +0100 (CET)
Date:   Thu, 4 Feb 2021 16:26:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, Miao Xie <miaox@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix raid6 qstripe kmap'ing
Message-ID: <20210204152608.GF1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        Miao Xie <miaox@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210128061503.1496847-1-ira.weiny@intel.com>
 <20210203155648.GE1993@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203155648.GE1993@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:56:48PM +0100, David Sterba wrote:
> On Wed, Jan 27, 2021 at 10:15:03PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > When a qstripe is required an extra page is allocated and mapped.  There
> > were 3 problems.
> > 
> > 1) There is no reason to map the qstripe page more than 1 time if the
> >    number of bits set in rbio->dbitmap is greater than one.
> > 2) There is no reason to map the parity page and unmap it each time
> >    through the loop.
> > 3) There is no corresponding call of kunmap() for the qstripe page.
> > 
> > The page memory can continue to be reused with a single mapping on each
> > iteration by raid6_call.gen_syndrome() without remapping.  So map the
> > page for the duration of the loop.
> > 
> > Similarly, improve the algorithm by mapping the parity page just 1 time.
> > 
> > Fixes: 5a6ac9eacb49 ("Btrfs, raid56: support parity scrub on raid56")
> > To: Chris Mason <clm@fb.com>
> > To: Josef Bacik <josef@toxicpanda.com>
> > To: David Sterba <dsterba@suse.com>
> > Cc: Miao Xie <miaox@cn.fujitsu.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > This was found while replacing kmap() with kmap_local_page().  After
> > this patch unwinding all the mappings becomes pretty straight forward.
> > 
> > I'm not exactly sure I've worded this commit message intelligently.
> > Please forgive me if there is a better way to word it.
> 
> Changelog is good, thanks. I've added stable tags as the missing unmap
> is a potential problem.

There are lots of tests faling, stack traces like below. I haven't seen
anything obvious in the patch so that needs a closer look and for the
time being I can't add the patch to for-next.

 BUG: kernel NULL pointer dereference, address:0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT SMP
 CPU: 2 PID: 17173 Comm: kworker/u8:5 Not tainted5.11.0-rc6-default+ #1422
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
 Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
 RIP: 0010:raid6_avx22_gen_syndrome+0x103/0x140 [raid6_pq]
 RSP: 0018:ffffa090042cfcf8 EFLAGS: 00010246
 RAX: ffff9e98e1848e80 RBX: ffff9e98d5849000 RCX:0000000000000020
 RDX: ffff9e98e32be000 RSI: 0000000000000000 RDI:ffff9e98e1848e80
 RBP: 0000000000000000 R08: 0000000000000000 R09:0000000000000001
 R10: ffff9e98e1848e90 R11: ffff9e98e1848e98 R12:0000000000001000
 R13: ffff9e98e1848e88 R14: 0000000000000005 R15:0000000000000002
 FS:  0000000000000000(0000) GS:ffff9e993da00000(0000)knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000023143003 CR4:0000000000170ea0
 Call Trace:
  finish_parity_scrub+0x47b/0x7a0 [btrfs]
  raid56_parity_scrub_stripe+0x24e/0x260 [btrfs]
  btrfs_work_helper+0xd5/0x1d0 [btrfs]
  process_one_work+0x262/0x5f0
  worker_thread+0x4e/0x300
  ? process_one_work+0x5f0/0x5f0
  kthread+0x151/0x170
  ? __kthread_bind_mask+0x60/0x60
