Return-Path: <linux-fsdevel+bounces-18011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03478B4ACE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6FA1C20D3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570B54BE9;
	Sun, 28 Apr 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bKahZhAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659654911
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294993; cv=none; b=IRd+52fqp/SXfnjruHulhk+Ap8ldgfkOUyRUXrBUttOg9HbdiDm9Lo/z/QAb1WC/3gfmCOpCqwxRfzgpuFdrIiDNpob7w7Qsm1OOBQwaCLyKzdxbxNPkhJj8M+SJubvu87/j7qhxQlFnIFWqMR7UPoDfTm4pzY6qToVj6hIvUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294993; c=relaxed/simple;
	bh=HE6YEx6iyY9zD9AH18rT5nCOEkYRCz6W95mci+l+20M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcP7X8gr6F+4boAQgoSqdfaLdCKFlflNq3mx46QhqZsRdk4qUfLrI4vOLR13wcVMlaGdPLd5+TFMs+o4Vf1x0r7wgEtX4QfUvJFxd8pdqf+6H7hf1f8xSK2cYEXWXLlTa42s3zPDz4mwtvhtkHNUI3eSuxrjQ63wgOR/do+d/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bKahZhAL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso3223181b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714294991; x=1714899791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/EjhKNRSg3o3EX3Rny1HlxHzhrYC7Z5aVDzwR+1mQo=;
        b=bKahZhAL3vsRxo47bUmpshOWMXc7quDPWw2sgcvgrZ7N1TaU54bwE1cHUN2aKHnfr5
         UdeIWYs9p5KQqUED50V4ntmLKsV+P6cvxB/5az7kZ6Qwe2Enh6/yt6yTCHRYkI1kt8iw
         B2icC+zfb3Ov0pbsyzAgHzNqD77NnQeuPsCH0yy6MLXtpSK+1z+aFQcZeNOcmqbKsyhO
         v3SnOyQa8TRiW43Y8evQMJaBppNcYsAk07Uz3s873s6xnagj6kySBI9Y8b4eSSsl7KMr
         +/Z0SvfbnuqTJku0W+BgIEljUkL7jnVxvUyBLws7i0ON31/Ya6NxAAkuRuxic4o+JMAM
         pM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714294991; x=1714899791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/EjhKNRSg3o3EX3Rny1HlxHzhrYC7Z5aVDzwR+1mQo=;
        b=czh5aOdOa2nSKLjGyDtj20gKHtHP9rIsDPRG2vfY2+YMMz6dWKeS9TvQPE3HnlIWJJ
         yRUKR0zdMzMxyPesWP0WuseFh0UsF1a4/zgbyxOCSdG0ZfgdvSZKPc7ieq7NDVzMOA51
         +NCttfsa3k0Wubsn7hp4u89z0Zib9ywykDaxmUxix+YnajOULUQn2xbwlIzIwUIUmqvL
         dMiLYex1sfBrYKPwOzI3wDQlQlQLgelXYFWoZbHz1exSc8Gh0XF8rSQs/bGtkDuA4TkJ
         uYxXm9Wp69WWNWhzTXrdMCpPVQv6qN/b1R39sbiOsz/gw7yqGIAW5Hn85jOrnqdkTz74
         iy1w==
X-Forwarded-Encrypted: i=1; AJvYcCXbSp8OliitqK/7UzCsLNOuYaopfv9D079YAgpTuU3ncx6TVEC3/UdRhJqZQFs16aILaUJY7JveLlrFFnLtS0q1f1ZxjIp7ExWJ3hEngw==
X-Gm-Message-State: AOJu0YyojLuBeyeTobVKQZXyGYgRp7gvEtU1pZ6VA83ih4YVcb0vjDzr
	HXMFU1G5eL4dy6m7WbgjhAyCzYKZHT7VTNET3ya/STZ+3TrTIWApcKpffE2FQxw=
X-Google-Smtp-Source: AGHT+IFnJtLkCEfPqJBYHiCH/Dx2zJGLzVHRjBOJOZtR72BjihLV893HcPLnlVvIQLk29Gi+lAw/Ng==
X-Received: by 2002:a17:902:f805:b0:1e2:b137:4f88 with SMTP id ix5-20020a170902f80500b001e2b1374f88mr7678593plb.30.1714294991082;
        Sun, 28 Apr 2024 02:03:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-29-7.pa.nsw.optusnet.com.au. [49.181.29.7])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902b41200b001e446fe6843sm18086990plr.79.2024.04.28.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 02:03:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s10R9-00DiJg-2h;
	Sun, 28 Apr 2024 19:03:07 +1000
Date: Sun, 28 Apr 2024 19:03:07 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
Message-ID: <Zi4Qy2UeWj/R9QcE@dread.disaster.area>
References: <000000000000fee02e0616f8fdff@google.com>
 <20240426163008.GO360919@frogsfrogsfrogs>
 <ZiwbDbYUJgH7t+G6@dread.disaster.area>
 <20240426232052.GT360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426232052.GT360919@frogsfrogsfrogs>

On Fri, Apr 26, 2024 at 04:20:52PM -0700, Darrick J. Wong wrote:
> On Sat, Apr 27, 2024 at 07:22:21AM +1000, Dave Chinner wrote:
> > On Fri, Apr 26, 2024 at 09:30:08AM -0700, Darrick J. Wong wrote:
> > > On Thu, Apr 25, 2024 at 10:15:29PM -0700, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=158206bb180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=1619d847a7b9ba3a9137
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > 
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > 
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/caa90b55d476/disk-3b680865.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/17940f1c5e8f/vmlinux-3b680865.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/b03bd6929a1c/bzImage-3b680865.xz
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com
> > > > 
> > > > ======================================================
> > > > WARNING: possible circular locking dependency detected
> > > > 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0 Not tainted
> > > > ------------------------------------------------------
> > > > kswapd0/81 is trying to acquire lock:
> > > > ffff8881a895a610 (sb_internal#3){.+.+}-{0:0}, at: xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
> > > > 
> > > > but task is already holding lock:
> > > > ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
> > > > ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
> > > > 
> > > > which lock already depends on the new lock.
> > > > 
> > > > 
> > > > the existing dependency chain (in reverse order) is:
> > > > 
> > > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > > >        __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
> > > >        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
> > > >        might_alloc include/linux/sched/mm.h:312 [inline]
> > > >        slab_pre_alloc_hook mm/slub.c:3746 [inline]
> > > >        slab_alloc_node mm/slub.c:3827 [inline]
> > > >        kmalloc_trace+0x47/0x360 mm/slub.c:3992
> > > >        kmalloc include/linux/slab.h:628 [inline]
> > > >        add_stack_record_to_list mm/page_owner.c:177 [inline]
> > 
> > There's the GFP_KERNEL allocation being warned about again.
> > 
> > > >        inc_stack_record_count mm/page_owner.c:219 [inline]
> > > >        __set_page_owner+0x561/0x810 mm/page_owner.c:334
> > > >        set_page_owner include/linux/page_owner.h:32 [inline]
> > > >        post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
> > > >        prep_new_page mm/page_alloc.c:1541 [inline]
> > > >        get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
> > > >        __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
> > > >        __alloc_pages_node include/linux/gfp.h:238 [inline]
> > > >        alloc_pages_node include/linux/gfp.h:261 [inline]
> > > >        alloc_slab_page+0x5f/0x160 mm/slub.c:2175
> > > >        allocate_slab mm/slub.c:2338 [inline]
> > > >        new_slab+0x84/0x2f0 mm/slub.c:2391
> > > >        ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
> > > >        __slab_alloc mm/slub.c:3610 [inline]
> > > >        __slab_alloc_node mm/slub.c:3663 [inline]
> > > >        slab_alloc_node mm/slub.c:3835 [inline]
> > > >        kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
> > > >        kmem_cache_zalloc include/linux/slab.h:739 [inline]
> > > >        xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:679 [inline]
> > > >        xfs_refcountbt_init_cursor+0x65/0x2a0 fs/xfs/libxfs/xfs_refcount_btree.c:367
> > > >        xfs_reflink_find_shared fs/xfs/xfs_reflink.c:147 [inline]
> > > >        xfs_reflink_trim_around_shared+0x53a/0x9d0 fs/xfs/xfs_reflink.c:194
> > > >        xfs_buffered_write_iomap_begin+0xebf/0x1b40 fs/xfs/xfs_iomap.c:1062
> > > 
> > > Hm.  We've taken an ILOCK in xfs_buffered_write_iomap_begin, and now
> > > we're allocating a btree cursor but we don't have PF_MEMALLOC_NOFS set,
> > > nor do we pass GFP_NOFS.
> > > 
> > > Ah, because nothing in this code path sets PF_MEMALLOC_NOFS explicitly,
> > > nor does it create a xfs_trans_alloc_empty, which would set that.  Prior
> > > to the removal of kmem_alloc, I think we were much more aggressive about
> > > GFP_NOFS usage.
> > > 
> > > Seeing as we're about to walk a btree, we probably want the empty
> > > transaction to guard against btree cycle livelocks.
> > 
> > Nothing like that is needed or desired, this is a just a bug in the
> > memory allocation tracking code...
> 
> Not needed because it doesn't address the root cause of these two syzbot
> reports?

Yes.

> Or did you actually analyze the refcount btree code and
> discover that there's no possibility of livelocking on btree cycles?

I think that's completely irrelevant, because I'm at a loss to
explain why adding a transaction context will prevent a btree cycle
from livelocking a lookup that stumbles into the cycle.

How does adding a transaction context trigger detection of a btree
cycle and enable the code to break out of it before it livelocks?

I know that the transaction context does not track the path taken
through the btree - it simply tracks buffers that are either dirtied
or not released by the btree path traversal. I also know that the
only buffers that aren't released while a traversal is in progress
is the path held by the btree cursor.  i.e. when we
increment/decrement the cursor to the next block, the previous block
the cursor pointed to is released (see xfs_btree_setbuf()). If it
wasn't dirtied, then the transaction context will also release and
unlock it and stop tracking it.

Hence I don't see what adding a transaction context does here w.r.t.
btree cycles, especially as the btree cursor does this buffer
management regardless of whether a transaction context is present or
not.

Yes, I can see that adding a transaction context may change what
happens when we try to lock a buffer we already have locked in the
current operation.  e.g. a ptr points to a node already held by the
cursor. This will turn a deadlock into a livelock, but it does not
add anything that detects the cycle or enables the code to break out
of the cycle.

AFAICS, the btree cursor is the context that should be doing btree
traversal tracking and cycle detection but it does not do this right
now. And AFAICT it doesn't need a transaction context to do this
job, either, because we don't need to hold references to locked
buffers to do visitation history tracking...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

