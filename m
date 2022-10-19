Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27B605422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJSXnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 19:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJSXnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:43:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DC153E08
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 16:43:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g28so18683404pfk.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6AvbRHK0Q9akH5lnn/8MQzVb2QsJcDVm+f7P/9b+1bI=;
        b=HeTjh+PEpHIR+EcdF9eVBk0Ho6AHP+s+UkLARGxg9FFF7/DbN+jQMfMNcV9DfZjaiU
         Wp3qW7TjojSbGGdomPd1PKLLGcDlh5spM7v7fql2XVc19mUECh61LSUb+GJpH/TkEF+q
         vdjWBe+uQhLV0uSVEg8o1vBbKVqEyyj9SVm1ASPVAdoonAFvCicOqzAFFZ9qp73lWdn/
         dIee/jKL/GbWoZOieK3dl4VYiZTuzKjzw9eFfN/qpuaBqfZe3AHbOseyLI2Y6wJix30s
         1oFhe9TG9RInuI16hhI1as9Fcj792n3/iKZa9n8WVIZ4WdzDg1W/L2/O0PifFeESVBjz
         Qhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AvbRHK0Q9akH5lnn/8MQzVb2QsJcDVm+f7P/9b+1bI=;
        b=HBZ/d/Wvn4MeHGLyQ2w6cbUVUy0GPs9vVaMCsqTtimKUXbffyxHotdqJTSdDbO5lJ/
         OJK14WLFZ1aOZTwwacelWddK+GGB23eIwbLW/iLohY5RKBGhcgXYaEKxfxc73gIJn5zD
         nFidPqyfrBTvppRt5nWUksUoPKpNsZZAT+TC9JxPfCoMwEuW3X6Rfse6OveF2sdA+rj+
         FAnP0+swDY888N6oWtH1J2hVcuWAm0ZuC2mSWcQXIEyi0HWNSrmuejtPIzVLZFWk5Wn9
         aU7EBaZG7+MxQ8O3jv4eX+h8croHR4wE2ocxEp4rkxcO/LuaO+mENfxshbUeumLP0kKx
         9JLg==
X-Gm-Message-State: ACrzQf1LpBSx+Opns4YRmMQ7vTe6igrLww2sE9FOTb5HjXkYL2janio2
        UiFC9TTeiXRKa0pq2aE+lEjPfw==
X-Google-Smtp-Source: AMsMyM4TNSQltnkZBD4k8vmzhQYDAjhbpDFD9cbkfsonnHMYCJvRPtdpmjtoIPJQUioqJfHvmm43kQ==
X-Received: by 2002:a63:1f13:0:b0:455:80ce:6d36 with SMTP id f19-20020a631f13000000b0045580ce6d36mr9519832pgf.111.1666222980722;
        Wed, 19 Oct 2022 16:43:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090341c500b001714c36a6e7sm11612866ple.284.2022.10.19.16.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:42:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1olIi8-0042ej-Pn; Thu, 20 Oct 2022 10:42:56 +1100
Date:   Thu, 20 Oct 2022 10:42:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <20221019234256.GR2703033@dread.disaster.area>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org>
 <20221019220424.GO2703033@dread.disaster.area>
 <20221019224616.GP2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019224616.GP2703033@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:46:16AM +1100, Dave Chinner wrote:
> On Thu, Oct 20, 2022 at 09:04:24AM +1100, Dave Chinner wrote:
> > On Wed, Oct 19, 2022 at 04:23:10PM +0100, Matthew Wilcox wrote:
> > > On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> > > > This is reading and writing the same amount of file data at the
> > > > application level, but once the data has been written and kicked out
> > > > of the page cache it seems to require an awful lot more read IO to
> > > > get it back to the application. i.e. this looks like mmap() is
> > > > readahead thrashing severely, and eventually it livelocks with this
> > > > sort of report:
> > > > 
> > > > [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> > > > [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> > > > [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> > > > [175901.995614] Call Trace:
> > > > [175901.996090]  <TASK>
> > > > [175901.996594]  ? __schedule+0x301/0xa30
> > > > [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > > [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > > [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > [175902.000714]  ? xas_start+0x53/0xc0
> > > > [175902.001484]  ? xas_load+0x24/0xa0
> > > > [175902.002208]  ? xas_load+0x5/0xa0
> > > > [175902.002878]  ? __filemap_get_folio+0x87/0x340
> > > > [175902.003823]  ? filemap_fault+0x139/0x8d0
> > > > [175902.004693]  ? __do_fault+0x31/0x1d0
> > > > [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> > > > [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> > > > [175902.006998]  ? exc_page_fault+0x1d9/0x810
> > > > [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> > > > [175902.008613]  </TASK>
> > > > 
> > > > Given that filemap_fault on XFS is probably trying to map large
> > > > folios, I do wonder if this is a result of some kind of race with
> > > > teardown of a large folio...
> > > 
> > > It doesn't matter whether we're trying to map a large folio; it
> > > matters whether a large folio was previously created in the cache.
> > > Through the magic of readahead, it may well have been.  I suspect
> > > it's not teardown of a large folio, but splitting.  Removing a
> > > page from the page cache stores to the pointer in the XArray
> > > first (either NULL or a shadow entry), then decrements the refcount.
> > > 
> > > We must be observing a frozen folio.  There are a number of places
> > > in the MM which freeze a folio, but the obvious one is splitting.
> > > That looks like this:
> > > 
> > >         local_irq_disable();
> > >         if (mapping) {
> > >                 xas_lock(&xas);
> > > (...)
> > >         if (folio_ref_freeze(folio, 1 + extra_pins)) {
> > 
> > But the lookup is not doing anything to prevent the split on the
> > frozen page from making progress, right? It's not holding any folio
> > references, and it's not holding the mapping tree lock, either. So
> > how does the lookup in progress prevent the page split from making
> > progress?
> > 
> > 
> > > So one way to solve this might be to try to take the xa_lock on
> > > failure to get the refcount.  Otherwise a high-priority task
> > > might spin forever without a low-priority task getting the chance
> > > to finish the work being done while the folio is frozen.
> > 
> > IIUC, then you are saying that there is a scheduling priority
> > inversion because the lookup failure looping path doesn't yeild the
> > CPU?
> > 
> > If so, how does taking the mapping tree spin lock on failure cause
> > the looping task to yield the CPU and hence allow the folio split to
> > make progress?
> > 
> > Also, AFAICT, the page split has disabled local interrupts, so it
> > should effectively be running with preemption disabled as it has
> > turned off the mechanism the scheduler can use to preempt it. The
> > page split can't sleep, either, because it holds the mapping tree
> > lock. Hence I can't see how a split-in-progress can be preempted in
> > teh first place to cause a priority inversion livelock like this...
> > 
> > > ie this:
> > > 
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 08341616ae7a..ca0eed80580f 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -1860,8 +1860,13 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
> > >  	if (!folio || xa_is_value(folio))
> > >  		goto out;
> > >  
> > > -	if (!folio_try_get_rcu(folio))
> > > +	if (!folio_try_get_rcu(folio)) {
> > > +		unsigned long flags;
> > > +
> > > +		xas_lock_irqsave(&xas, flags);
> > > +		xas_unlock_irqrestore(&xas, flags);
> > >  		goto repeat;
> > > +	}
> 
> As I suspected, this change did not prevent the livelock. It
> reproduced after just 650 test iterations (a few minutes) with this
> change in place.
> 
> > I would have thought:
> > 
> > 	if (!folio_try_get_rcu(folio)) {
> > 		rcu_read_unlock();
> > 		cond_resched();
> > 		rcu_read_lock();
> > 		goto repeat;
> > 	}
> > 
> > Would be the right way to yeild the CPU to avoid priority
> > inversion related livelocks here...
> 
> I'm now trying this just to provide a data point that actually
> yeilding the CPU avoids the downstream effects of the livelock (i.e.

This causes a different problems to occur. First, a task hangs
evicting the page cache on unlink like so:

[ 1352.990246] INFO: task test_write:3572 blocked for more than 122 seconds.
[ 1352.991418]       Not tainted 6.1.0-rc1-dgc+ #1618
[ 1352.992378] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1352.994702] task:test_write      state:D stack:13088 pid:3572  ppid:3567   flags:0x00004002
[ 1352.996257] Call Trace:
[ 1352.996905]  <TASK>
[ 1352.997452]  __schedule+0x2f9/0xa20
[ 1352.998380]  schedule+0x5a/0xc0
[ 1352.999011]  io_schedule+0x42/0x70
[ 1352.999565]  folio_wait_bit_common+0x137/0x370
[ 1353.000553]  ? dio_warn_stale_pagecache.part.0+0x50/0x50
[ 1353.001425]  truncate_inode_pages_range+0x41a/0x470
[ 1353.002443]  evict+0x1ad/0x1c0
[ 1353.003199]  do_unlinkat+0x1db/0x2e0
[ 1353.003907]  __x64_sys_unlinkat+0x33/0x60
[ 1353.004569]  do_syscall_64+0x35/0x80
[ 1353.005354]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1353.006315] RIP: 0033:0x7f03d6a42157
[ 1353.007088] RSP: 002b:00007ffde8d98388 EFLAGS: 00000206 ORIG_RAX: 0000000000000107
[ 1353.008367] RAX: ffffffffffffffda RBX: 0000000000000df4 RCX: 00007f03d6a42157
[ 1353.009748] RDX: 0000000000000000 RSI: 000055f8660415a0 RDI: 0000000000000007
[ 1353.011115] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffde8d96105
[ 1353.012422] R10: 0000000000000158 R11: 0000000000000206 R12: 0000000000000158
[ 1353.013556] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1353.014958]  </TASK>

And soon after:

[ 1607.746983] ------------[ cut here ]------------
[ 1607.748141] WARNING: CPU: 27 PID: 51385 at fs/iomap/buffered-io.c:80 iomap_page_release+0xaf/0xc0
[ 1607.751098] Modules linked in:
[ 1607.751619] CPU: 27 PID: 51385 Comm: test_write Not tainted 6.1.0-rc1-dgc+ #1618
[ 1607.753307] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 1607.755443] RIP: 0010:iomap_page_release+0xaf/0xc0
[ 1607.756496] Code: 48 c1 e8 02 83 e0 01 75 10 38 d0 75 21 5b 4c 89 e7 5d 41 5c e9 d2 be ee ff eb ee e8 bb e0 ec ff eb 88 48 8b 07 5b 5d 41 5c c3 <0f> 0b eb b1 0f 0b eb db 0f 0b eb b2 0f 1f 44 00 00 0f 1f 44 00 00
[ 1607.759643] RSP: 0018:ffffc900087cb5b0 EFLAGS: 00010206
[ 1607.760775] RAX: 0000000000200000 RBX: ffffea0004378000 RCX: 000000000000000c
[ 1607.762181] RDX: 0017ffffc0050081 RSI: ffff888145cb0178 RDI: ffffea0004378000
[ 1607.764408] RBP: 0000000000000200 R08: 0000000000200000 R09: ffffea0004378008
[ 1607.765560] R10: ffff888141988800 R11: 0000000000033900 R12: ffff88810200ee40
[ 1607.766988] R13: 0000000000000200 R14: ffffc900087cb8c0 R15: ffffea0004378008
[ 1607.768347] FS:  00007f03d5c00640(0000) GS:ffff88833bdc0000(0000) knlGS:0000000000000000
[ 1607.769756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1607.771421] CR2: 00007f03cae00000 CR3: 0000000246226006 CR4: 0000000000770ee0
[ 1607.773298] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1607.775026] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1607.777341] PKRU: 55555554
[ 1607.777995] Call Trace:
[ 1607.778637]  <TASK>
[ 1607.779372]  iomap_release_folio+0x4d/0xa0
[ 1607.780510]  shrink_folio_list+0x9dd/0xb10
[ 1607.781931]  shrink_lruvec+0x558/0xb80
[ 1607.782922]  shrink_node+0x2ce/0x6f0
[ 1607.783993]  do_try_to_free_pages+0xd5/0x570
[ 1607.785031]  try_to_free_mem_cgroup_pages+0x105/0x220
[ 1607.786728]  reclaim_high+0xa6/0xf0
[ 1607.787672]  mem_cgroup_handle_over_high+0x97/0x290
[ 1607.789179]  try_charge_memcg+0x697/0x7f0
[ 1607.790100]  charge_memcg+0x35/0xd0
[ 1607.790930]  __mem_cgroup_charge+0x29/0x80
[ 1607.792884]  __filemap_add_folio+0x21a/0x460
[ 1607.794342]  ? scan_shadow_nodes+0x30/0x30
[ 1607.796052]  filemap_add_folio+0x37/0xa0
[ 1607.797036]  __filemap_get_folio+0x221/0x360
[ 1607.798468]  ? xas_load+0x5/0xa0
[ 1607.799417]  iomap_write_begin+0x103/0x580
[ 1607.800908]  ? filemap_dirty_folio+0x5c/0x80
[ 1607.801940]  ? iomap_write_end+0x101/0x250
[ 1607.803305]  iomap_file_buffered_write+0x17f/0x330
[ 1607.804700]  xfs_file_buffered_write+0xb1/0x2e0
[ 1607.806240]  ? xfs_file_buffered_write+0x2b2/0x2e0
[ 1607.807743]  vfs_write+0x2ca/0x3d0
[ 1607.808622]  __x64_sys_pwrite64+0x8c/0xc0
[ 1607.810502]  do_syscall_64+0x35/0x80
[ 1607.811511]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1607.813116] RIP: 0033:0x7f03d6b40a87
....
[ 1607.925434] kernel BUG at mm/vmscan.c:1306!
[ 1607.926977] invalid opcode: 0000 [#1] PREEMPT SMP
[ 1607.928427] CPU: 8 PID: 51385 Comm: test_write Tainted: G        W          6.1.0-rc1-dgc+ #1618
[ 1607.930742] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 1607.932716] RIP: 0010:__remove_mapping+0x229/0x240
[ 1607.933648] Code: a9 00 00 08 00 75 27 48 8b 3b 48 81 c7 88 00 00 00 e8 db 64 c1 00 31 c0 e9 d6 fe ff ff 48 8b 3b e8 7c 29 0d 00 e9 27 ff ff ff <0f> 0b 0f 0b 48 8b 45 00 f6 c4 04 74 d0 31 c0 e9 b5 fe ff ff 0f 1f
[ 1607.937079] RSP: 0018:ffffc900087cb5d8 EFLAGS: 00010246
[ 1607.938050] RAX: 0017ffffc0010004 RBX: ffffc900087cb6e8 RCX: ffff888244bc5000
[ 1607.939443] RDX: 0000000000000001 RSI: ffffea0004378000 RDI: ffff888145cb0318
[ 1607.940980] RBP: ffffc900087cb648 R08: ffff888145cb0318 R09: ffffffff813be400
[ 1607.942300] R10: ffff88810200ee40 R11: 0000000000033900 R12: ffffea0004378000
[ 1607.943666] R13: 0000000000000200 R14: ffffc900087cb8c0 R15: ffffea0004378008
[ 1607.945004] FS:  00007f03d5c00640(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
[ 1607.946492] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1607.947552] CR2: 00007efd1ae33da8 CR3: 0000000246226001 CR4: 0000000000770ee0
[ 1607.948866] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1607.950250] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1607.951738] PKRU: 55555554
[ 1607.952289] Call Trace:
[ 1607.952775]  <TASK>
[ 1607.953190]  shrink_folio_list+0x5cd/0xb10
[ 1607.954140]  shrink_lruvec+0x558/0xb80
[ 1607.954850]  shrink_node+0x2ce/0x6f0
[ 1607.955536]  do_try_to_free_pages+0xd5/0x570
[ 1607.956397]  try_to_free_mem_cgroup_pages+0x105/0x220
[ 1607.957503]  reclaim_high+0xa6/0xf0
[ 1607.958205]  mem_cgroup_handle_over_high+0x97/0x290
[ 1607.959149]  try_charge_memcg+0x697/0x7f0
[ 1607.959932]  charge_memcg+0x35/0xd0
[ 1607.960549]  __mem_cgroup_charge+0x29/0x80
[ 1607.961257]  __filemap_add_folio+0x21a/0x460
[ 1607.961912]  ? scan_shadow_nodes+0x30/0x30
[ 1607.962705]  filemap_add_folio+0x37/0xa0
[ 1607.963354]  __filemap_get_folio+0x221/0x360
[ 1607.964076]  ? xas_load+0x5/0xa0
[ 1607.964761]  iomap_write_begin+0x103/0x580
[ 1607.965510]  ? filemap_dirty_folio+0x5c/0x80
[ 1607.966349]  ? iomap_write_end+0x101/0x250
[ 1607.967185]  iomap_file_buffered_write+0x17f/0x330
[ 1607.968133]  xfs_file_buffered_write+0xb1/0x2e0
[ 1607.968948]  ? xfs_file_buffered_write+0x2b2/0x2e0
[ 1607.969783]  vfs_write+0x2ca/0x3d0
[ 1607.970326]  __x64_sys_pwrite64+0x8c/0xc0
[ 1607.971073]  do_syscall_64+0x35/0x80
[ 1607.971732]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

which is:

1297  * Same as remove_mapping, but if the folio is removed from the mapping, it      
1298  * gets returned with a refcount of 0.                                           
1299  */                                                                              
1300 static int __remove_mapping(struct address_space *mapping, struct folio *folio,  
1301                             bool reclaimed, struct mem_cgroup *target_memcg)     
1302 {                                                                                
1303         int refcount;                                                            
1304         void *shadow = NULL;                                                     
1305                                                                                  
1306         BUG_ON(!folio_test_locked(folio));                                       
1307         BUG_ON(mapping != folio_mapping(folio));                                 
1308                                                                                  

tripping over an unlocked folio in shrink_folio_list()....

And, finally, there's also a process spinning on a cpu in
truncate_inode_pages_range():

[ 3468.057406] CPU: 1 PID: 3579 Comm: test_write Tainted: G      D W          6.1.0-rc1-dgc+ #1618
[ 3468.057407] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 3468.057408] RIP: 0010:truncate_inode_pages_range+0x3c0/0x470
[ 3468.057411] Code: 8b 7c e5 00 41 f6 c6 01 0f 85 62 ff ff ff be a9 03 00 00 48 c7 c7 b8 62 7b 82 e8 0b 46 e9 ff 2e 2e 2e 31 c0 f0 49 0f ba 7
[ 3468.057412] RSP: 0018:ffffc90002cffd40 EFLAGS: 00000246
[ 3468.057414] RAX: 0000000000000000 RBX: ffffc90002cffdd8 RCX: ffff8882461b8000
[ 3468.057415] RDX: 0000000000000000 RSI: 00000000000003a9 RDI: ffffffff827b62b8
[ 3468.057415] RBP: ffff888246eee718 R08: ffffffffffffffc0 R09: fffffffffffffffe
[ 3468.057416] R10: 0000000000002838 R11: 0000000000002834 R12: 0000000000000004
[ 3468.057417] R13: ffffc90002cffd60 R14: ffffea0004378000 R15: 0000000000002810
[ 3468.057418] FS:  00007f03d6953740(0000) GS:ffff88813bc40000(0000) knlGS:0000000000000000
[ 3468.057420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3468.057421] CR2: 00007f03d0100000 CR3: 0000000245e2c006 CR4: 0000000000770ee0
root@test4:~# [ 3468.057422] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3468.057422] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3468.057423] PKRU: 55555554
[ 3468.057424] Call Trace:
[ 3468.057424]  <TASK>
[ 3468.057426]  evict+0x1ad/0x1c0
[ 3468.057429]  do_unlinkat+0x1db/0x2e0
[ 3468.057432]  __x64_sys_unlinkat+0x33/0x60
[ 3468.057434]  do_syscall_64+0x35/0x80
[ 3468.057437]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

So that's not the problem, either...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
