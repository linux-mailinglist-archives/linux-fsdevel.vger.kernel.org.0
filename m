Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A933C6A3FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 12:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjB0LGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 06:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjB0LGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:06:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814B7199DC;
        Mon, 27 Feb 2023 03:06:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 349B21F8D9;
        Mon, 27 Feb 2023 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677495975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJzD7rCRYOb2Z0uIwvnb34swkGK5jvovR5ZJ2SZO6Y0=;
        b=KCnXYsH5QjC7rGbRRh8h/5q7K00WTA6gGrcRzwVflQbYExGi3PMjBoXHwkBruEzd28hJTK
        p1Po3Rm2FIHo3XiJdehfJ9D3KEWkhIrsyTOZxAQiBlIcIhRpgmQ+kp6r4+1XRaEaELcT1g
        HclGfiZyEhwnJZsU4JzcW6pwQqD+Hko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677495975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJzD7rCRYOb2Z0uIwvnb34swkGK5jvovR5ZJ2SZO6Y0=;
        b=eqGX4JB5WuOHwQ8m0+O9pe4jSRt5P/3RCEfrf8UWDFidkPdI+IYO3bDF5CHaGDWvMqVPAZ
        3lhHEdCqiKOqmLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20D0E13912;
        Mon, 27 Feb 2023 11:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /5P6B6eO/GN8DQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 11:06:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AD0FDA06F2; Mon, 27 Feb 2023 12:06:14 +0100 (CET)
Date:   Mon, 27 Feb 2023 12:06:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
Message-ID: <20230227110614.dngdub2j3exr6dfp@quack3>
References: <20230213123444.155149-1-ying.huang@intel.com>
 <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-02-23 13:47:48, Hugh Dickins wrote:
> On Mon, 13 Feb 2023, Huang Ying wrote:
> 
> > From: "Huang, Ying" <ying.huang@intel.com>
> > 
> > Now, migrate_pages() migrate folios one by one, like the fake code as
> > follows,
> > 
> >   for each folio
> >     unmap
> >     flush TLB
> >     copy
> >     restore map
> > 
> > If multiple folios are passed to migrate_pages(), there are
> > opportunities to batch the TLB flushing and copying.  That is, we can
> > change the code to something as follows,
> > 
> >   for each folio
> >     unmap
> >   for each folio
> >     flush TLB
> >   for each folio
> >     copy
> >   for each folio
> >     restore map
> > 
> > The total number of TLB flushing IPI can be reduced considerably.  And
> > we may use some hardware accelerator such as DSA to accelerate the
> > folio copying.
> > 
> > So in this patch, we refactor the migrate_pages() implementation and
> > implement the TLB flushing batching.  Base on this, hardware
> > accelerated folio copying can be implemented.
> > 
> > If too many folios are passed to migrate_pages(), in the naive batched
> > implementation, we may unmap too many folios at the same time.  The
> > possibility for a task to wait for the migrated folios to be mapped
> > again increases.  So the latency may be hurt.  To deal with this
> > issue, the max number of folios be unmapped in batch is restricted to
> > no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
> > is at the same level of THP migration.
> > 
> > We use the following test to measure the performance impact of the
> > patchset,
> > 
> > On a 2-socket Intel server,
> > 
> >  - Run pmbench memory accessing benchmark
> > 
> >  - Run `migratepages` to migrate pages of pmbench between node 0 and
> >    node 1 back and forth.
> > 
> > With the patch, the TLB flushing IPI reduces 99.1% during the test and
> > the number of pages migrated successfully per second increases 291.7%.
> > 
> > Xin Hao helped to test the patchset on an ARM64 server with 128 cores,
> > 2 NUMA nodes.  Test results show that the page migration performance
> > increases up to 78%.
> > 
> > This patchset is based on mm-unstable 2023-02-10.
> 
> And back in linux-next this week: I tried next-20230217 overnight.
> 
> There is a deadlock in this patchset (and in previous versions: sorry
> it's taken me so long to report), but I think one that's easily solved.
> 
> I've not bisected to precisely which patch (load can take several hours
> to hit the deadlock), but it doesn't really matter, and I expect that
> you can guess.
> 
> My root and home filesystems are ext4 (4kB blocks with 4kB PAGE_SIZE),
> and so is the filesystem I'm testing, ext4 on /dev/loop0 on tmpfs.
> So, plenty of ext4 page cache and buffer_heads.
> 
> Again and again, the deadlock is seen with buffer_migrate_folio_norefs(),
> either in kcompactd0 or in khugepaged trying to compact, or in both:
> it ends up calling __lock_buffer(), and that schedules away, waiting
> forever to get BH_lock.  I have not identified who is holding BH_lock,
> but I imagine a jbd2 journalling thread, and presume that it wants one
> of the folio locks which migrate_pages_batch() is already holding; or
> maybe it's all more convoluted than that.  Other tasks then back up
> waiting on those folio locks held in the batch.
> 
> Never a problem with buffer_migrate_folio(), always with the "more
> careful" buffer_migrate_folio_norefs().  And the patch below fixes
> it for me: I've had enough hours with it now, on enough occasions,
> to be confident of that.
> 
> Cc'ing Jan Kara, who knows buffer_migrate_folio_norefs() and jbd2
> very well, and I hope can assure us that there is an understandable
> deadlock here, from holding several random folio locks, then trying
> to lock buffers.  Cc'ing fsdevel, because there's a risk that mm
> folk think something is safe, when it's not sufficient to cope with
> the diversity of filesystems.  I hope nothing more than the below is
> needed (and I've had no other problems with the patchset: good job),
> but cannot be sure.

I suspect it can indeed be caused by the presence of the loop device as
Huang Ying has suggested. What filesystems using buffer_heads do is a
pattern like:

bh = page_buffers(loop device page cache page);
lock_buffer(bh);
submit_bh(bh);
- now on loop dev this ends up doing:
  lo_write_bvec()
    vfs_iter_write()
      ...
      folio_lock(backing file folio);

So if migration code holds "backing file folio" lock and at the same time
waits for 'bh' lock (while trying to migrate loop device page cache page), it
is a deadlock.

Proposed solution of never waiting for locks in batched mode looks like a
sensible one to me...

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
