Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3E3CBA7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPQ0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 12:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPQ0g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:26:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C039613BB;
        Fri, 16 Jul 2021 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626452621;
        bh=POGqhedhygshA0XZUU3Op4Fw0hWujqwUgWAR4cjt94Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwkBhWLmwcpbxMaqHrlKgtHbEqpAtFpEbjYJlxCouiiZuKnoWCXpO4lxG3VGy6h9s
         ERGaQGaLHy4Ob9ssKIg0+E3ekeap/Ux2QceKuL81cPqRSEWFVkoYVgB97laQbkMICh
         0XtKW1fcUaUe7KaRzzIelL3vMKMyIshtF+I85edLy02QFM6dAMSq4Ws02IYbCtN7Bz
         HRZMzmBTIr8OJQR/SXSpju7q0kuGnLu/AtRltkc8obkI7CMG3PUJwrLc+/rJZ74hxz
         phlgQyi2uVGULEKgLddAUrLYUGnTWM8y8Ai713UtnkMJNuzfE0j4mMiO6viWvtZwoQ
         yoafQnxtR82jw==
Date:   Fri, 16 Jul 2021 09:23:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Boyang Xue <bxue@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <20210716162340.GY22357@magnolia>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO+e8UrCbzp2pfvj@casper.infradead.org>
 <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
 <20210715171050.GB22357@magnolia>
 <YPCVrwov6R9yaBcG@carbon.dhcp.thefacebook.com>
 <20210715222812.GW22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715222812.GW22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:28:12PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 01:08:15PM -0700, Roman Gushchin wrote:
> > On Thu, Jul 15, 2021 at 10:10:50AM -0700, Darrick J. Wong wrote:
> > > On Thu, Jul 15, 2021 at 11:51:50AM +0800, Boyang Xue wrote:
> > > > On Thu, Jul 15, 2021 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > > > > It's unclear to me that where to find the required address in the
> > > > > > addr2line command line, i.e.
> > > > > >
> > > > > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > > > <what address here?>
> > > > >
> > > > > ./scripts/faddr2line /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux cleanup_offline_cgwbs_workfn+0x320/0x394
> > > > >
> > > > 
> > > > Thanks! The result is the same as the
> > > > 
> > > > addr2line -i -e
> > > > /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > FFFF8000102D6DD0
> > > > 
> > > > But this script is very handy.
> > > > 
> > > > # /usr/src/kernels/5.14.0-0.rc1.15.bx.el9.aarch64/scripts/faddr2line
> > > > /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > cleanup_offlin
> > > > e_cgwbs_workfn+0x320/0x394
> > > > cleanup_offline_cgwbs_workfn+0x320/0x394:
> > > > arch_atomic64_fetch_add_unless at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
> > > > (inlined by) arch_atomic64_add_unless at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2290
> > > > (inlined by) atomic64_add_unless at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-instrumented.h:1149
> > > > (inlined by) atomic_long_add_unless at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-long.h:491
> > > > (inlined by) percpu_ref_tryget_many at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:247
> > > > (inlined by) percpu_ref_tryget at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:266
> > > > (inlined by) wb_tryget at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:227
> > > > (inlined by) wb_tryget at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:224
> > > > (inlined by) cleanup_offline_cgwbs_workfn at
> > > > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c:679
> > > > 
> > > > # vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c
> > > > ```
> > > > static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > > > {
> > > >         struct bdi_writeback *wb;
> > > >         LIST_HEAD(processed);
> > > > 
> > > >         spin_lock_irq(&cgwb_lock);
> > > > 
> > > >         while (!list_empty(&offline_cgwbs)) {
> > > >                 wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> > > >                                       offline_node);
> > > >                 list_move(&wb->offline_node, &processed);
> > > > 
> > > >                 /*
> > > >                  * If wb is dirty, cleaning up the writeback by switching
> > > >                  * attached inodes will result in an effective removal of any
> > > >                  * bandwidth restrictions, which isn't the goal.  Instead,
> > > >                  * it can be postponed until the next time, when all io
> > > >                  * will be likely completed.  If in the meantime some inodes
> > > >                  * will get re-dirtied, they should be eventually switched to
> > > >                  * a new cgwb.
> > > >                  */
> > > >                 if (wb_has_dirty_io(wb))
> > > >                         continue;
> > > > 
> > > >                 if (!wb_tryget(wb))  <=== line#679
> > > >                         continue;
> > > > 
> > > >                 spin_unlock_irq(&cgwb_lock);
> > > >                 while (cleanup_offline_cgwb(wb))
> > > >                         cond_resched();
> > > >                 spin_lock_irq(&cgwb_lock);
> > > > 
> > > >                 wb_put(wb);
> > > >         }
> > > > 
> > > >         if (!list_empty(&processed))
> > > >                 list_splice_tail(&processed, &offline_cgwbs);
> > > > 
> > > >         spin_unlock_irq(&cgwb_lock);
> > > > }
> > > > ```
> > > > 
> > > > BTW, this bug can be only reproduced on a non-debug production built
> > > > kernel (a.k.a kernel rpm package), it's not reproducible on a debug
> > > > build with various debug configuration enabled (a.k.a kernel-debug rpm
> > > > package)
> > > 
> > > FWIW I've also seen this regularly on x86_64 kernels on ext4 with all
> > > default mkfs settings when running generic/256.
> > 
> > Oh, that's a useful information, thank you!
> > 
> > Btw, would you mind to give a patch from an earlier message in the thread
> > a test? I'd highly appreciate it.
> > 
> > Thanks!
> 
> Will do.

fstests passed here, so

Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> --D
