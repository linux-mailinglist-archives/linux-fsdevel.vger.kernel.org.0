Return-Path: <linux-fsdevel+bounces-6430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48422817D22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 23:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADC41F2335E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379474E0B;
	Mon, 18 Dec 2023 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO75PUWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B5740B2;
	Mon, 18 Dec 2023 22:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA062C433C7;
	Mon, 18 Dec 2023 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702937521;
	bh=pcXohQ2WHqiutE3mnNDtOMvnN7Gan1n+mY6MXRRhR3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nO75PUWHNvXjEV6MdLDJyQfdXWofcFRsxP5uPWVvHsLng+icjbcLu0X1QdU6JOwcw
	 2mjuYc44hmr2xcFTpuilarWxa7Cu1FeMquWe1vEuhwVGOgc3zjP44oTjY7CxgqI/5i
	 pPJggJ4Cl69gT6FkCiXpfTr+4op5teuFba4J9acqyN+MNf7RD1HckQcUNRBikQMhOX
	 7HR97/rPOUBYA99oTz19hkKsVslCZ2wdK7Fee9Un0LolDGxWTdEedb/H+SrczPW5Sa
	 5obZNeaNbmbHWQUJVzpWMm/FdyZVZzQVNCUPpXfMqna7xoCt2/VMHV7Btc4mK82JK0
	 FJoApQFIepAWQ==
Date: Mon, 18 Dec 2023 14:12:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Brian Foster <bfoster@redhat.com>, Long Li <leo.lilong@huawei.com>,
	brauner@kernel.org, linux-xfs@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] iomap: fix warning in iomap_write_delalloc_release()
Message-ID: <20231218221200.GU361584@frogsfrogsfrogs>
References: <20231216115559.3823359-1-leo.lilong@huawei.com>
 <20231216173951.GP361584@frogsfrogsfrogs>
 <ZYA7LjdIJ3sxsyCm@bfoster>
 <ZYCp0cAVUKssxjsu@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYCp0cAVUKssxjsu@dread.disaster.area>

[cc willy and fsdevel]

On Tue, Dec 19, 2023 at 07:21:37AM +1100, Dave Chinner wrote:
> [cc Jan Kara]
> 
> On Mon, Dec 18, 2023 at 07:29:34AM -0500, Brian Foster wrote:
> > On Sat, Dec 16, 2023 at 09:39:51AM -0800, Darrick J. Wong wrote:
> > > On Sat, Dec 16, 2023 at 07:55:59PM +0800, Long Li wrote:
> > > > While fsstress + drop cache test, we get following warning:
> > > > 
> > > >  ------------[ cut here ]------------
> > > >  WARNING: CPU: 2 PID: 1003 at fs/iomap/buffered-io.c:1182 iomap_file_buffered_write_punch_delalloc+0x691/0x730
> > > >  Modules linked in:
> > > >  CPU: 2 PID: 1003 Comm: fsstress Not tainted 6.7.0-rc5-06945-g3ba9b31d6bf3-dirty #256
> > > >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> > > >  RIP: 0010:iomap_file_buffered_write_punch_delalloc+0x691/0x730
> > > >  Code: d1 0b 01 0f 0b 48 83 05 14 a2 d1 0b 01 48 89 05 35 a1 d1 0b 49 39 ec 0f 8c 09 fb ff ff e9 b6 fd ff ff 48 83 05 df a1 d1 0b 01 <0f> 0b 48 83 05 dd a1 d1 0b 01 48 39 6c 24 10 7c c0 48 89 05 07 a1
> > > >  RSP: 0018:ffffc900005b7b08 EFLAGS: 00010202
> > > >  RAX: 0000000000000001 RBX: ffff888102363d40 RCX: 0000000000000001
> > > >  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888108080000
> > > >  RBP: 0000000000050000 R08: ffff888108084eb8 R09: ffff888108084eb8
> > > >  R10: 000000000000005c R11: 0000000000000059 R12: 0000000000050000
> > > >  R13: ffffffff8c978ef0 R14: 0000000000050000 R15: 000000000005a000
> > > >  FS:  00007efc04c63b40(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> > > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >  CR2: 00007efc0375c000 CR3: 0000000105a4d000 CR4: 00000000000006f0
> > > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > >  Call Trace:
> > > >   <TASK>
> > > >   xfs_buffered_write_iomap_end+0x40/0xb0
> > > >   iomap_iter+0x8e/0x5f0
> > > >   iomap_file_buffered_write+0xa4/0x460
> > > >   xfs_file_buffered_write+0x156/0x3d0
> > > >   xfs_file_write_iter+0xb2/0x1c0
> > > >   do_iter_readv_writev+0x19b/0x1f0
> > > >   vfs_writev+0x114/0x4f0
> > > >   do_writev+0x7f/0x1c0
> > > >   __x64_sys_writev+0x24/0x30
> > > >   do_syscall_64+0x3f/0xe0
> > > >   entry_SYSCALL_64_after_hwframe+0x62/0x6a
> > > >  RIP: 0033:0x7efc03b06610
> > > >  Code: 73 01 c3 48 8b 0d 78 88 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d d9 e0 2c 00 00 75 10 b8 14 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e 8e 01 00 48 89 04 24
> > > >  RSP: 002b:00007ffdf8f426d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> > > >  RAX: ffffffffffffffda RBX: 000000000000007a RCX: 00007efc03b06610
> > > >  RDX: 00000000000002c4 RSI: 00000000012f5580 RDI: 0000000000000003
> > > >  RBP: 0000000000000003 R08: 00000000012f53a0 R09: 0000000000000077
> > > >  R10: 000000000000007c R11: 0000000000000246 R12: 00000000000002c4
> > > >  R13: 00000000012dba50 R14: 00000000012f5580 R15: 0000000000000094
> > > > 
> > > > The warning occurred in the following code of iomap_write_delalloc_release().
> > > > After analyzing vmcore, I found that the reason for the warning is that
> > > > data_end was equal to start_byte.
> > > > 
> > > >         WARN_ON_ONCE(data_end <= start_byte);
> > > > 
> > > > If some delay is added between seeking for data and seeking for hole
> > > > in iomap_write_delalloc_release(), the problem can be reproduced quickly.
> > > > The root cause of the problem is that clean data page was dropped between
> > > > two seeking in the page cache. As a result, data_end may be equal to
> > > > start_byte.
> > > > 
> > > > buffered write                        drop cache
> > > > ---------------------------           ---------------------------
> > > > xfs_buffered_write_iomap_end
> > > >   iomap_file_buffered_write_punch_delalloc
> > > >     iomap_write_delalloc_release
> > > >       start_byte = mapping_seek_hole_data(SEEK_DATA)
> > > > 
> > > >                                       drop_pagecache_sb
> > > >                                         invalidate_mapping_pages
> > > >                                           mapping_try_invalidate
> > > >                                             mapping_evict_folio
> > > >                                               remove_mapping
> > > > 
> > > >       data_end = mapping_seek_hole_data(SEEK_HOLE)
> > > >       WARN_ON_ONCE(data_end <= start_byte)
> > > > 
> > > > In my investigation, I found that clean data pages was alloced and added
> > > > to page cache when reading the file's hole. After that, while buffered
> > > > write and goes into delalloc release, we seek for data, it will find
> > > > the start offset of the clean data pages. If the clean data pages was
> > > > dropped, when we seek for hole, it will find the same offset as the
> > > > previous seek.
> > > 
> > > iomap_write_delalloc_release holds the invalidation lock, shouldn't that
> > > be sufficient to prevent folios from being dropped?
> > > 
> > 
> > I believe it's the other way around. The invalidate lock prevents new
> > folios from being added (i.e. to serialize an invalidation sequence).
> > IIRC it won't necessarily prevent folios from going away.
> 
> It also serialises operations doing invalidations against other
> operations doing invalidations (e.g. truncate, hole punch, direct
> IO, etc) that require the invalidation lock to be held exclusively.
> 
> Having looked a little deeper, it appears we have a large number of
> invalidation paths that don't actually hold the invalidation lock at
> all. drop_pagecache_sb() is just one of them.  Is that a bug?

Clearly I think so. ;)

> If not, then this code needs to prevent any mapping tree change from
> occurring whilst it is walking the range of the write that needs to
> be scanned. The write has partially failed at this point, and we're
> trying to clean up the mess the partial write has left behind. We
> really need exclusive access to that range of the mapping whilst
> cleanup is done.
> 
> IOWs, if the invalidation lock is not sufficient to serialise
> against other invalidations being run concurrently, what mapping
> lock can we hold whilst we call into the filesystem, take sleeping
> FS locks and modify the extent tree that will serialise against
> other invalidations?

I don't know of any other locks that would provide that; also, I thought
invalidate_lock (fka MMAPLOCK_EXCL) was what xfs was supposed to take to
serialize against folios getting ripped out of the mapping and page
faults.

Though now that I think about this further -- have dropcaches and xfs
post-write error delalloc punching always lacked coordination?  I think
for most pagecache operations that old "lock and recheck mapping/offset"
strategy works ok; it's just here where we might've been touching
multiple folios that things go awry...?

--D

> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

