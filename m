Return-Path: <linux-fsdevel+bounces-17946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA808B4112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C55283115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA92D638;
	Fri, 26 Apr 2024 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="at+p/p8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41702C859
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166547; cv=none; b=U2I9uQrbPg8aWoGIjhWDzcUnPUSOZQrFJ5YuzVtQZUXOuQ5pYs32HLRRt6EoglhhCsfzqoJIeOQG/XUMYtsJJ6iPdOa+ycPXxVvVAe+yFCPZuylmxjjFbgjncwGVIvRQYgLL+LbKzr65CWHjN7ilQL628EBY8CpgO7/b+inh0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166547; c=relaxed/simple;
	bh=fOysDqErrJ5jjFQQO7y0XrzRGTTn1Sm1Ftw4svl51wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnWcvuiCR0tzxwkx2JT8CI4/tF8j7d2tWY2Vtz23u3bLrEupAQ9aehcz3GXxkc0r1QrXVVT4m/gloOOKwhvYb4gqwbWxvGIdopfiwc6Rzp0eB9eI65hPZk+d2aTxaDONf4uxeWEUR2i6bKdqMaZp0538B4rlXkou3KQp0tyT3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=at+p/p8W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so7536045ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714166545; x=1714771345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCoO2T2YsP7LrwbAT+g4HEuejnEIT/1nDXSmbYAkLWs=;
        b=at+p/p8WQ7moPDzFRCkS0q8kwJlKDj8scksv7PfoJ97biapaiNva4c5q/M8bOyso7M
         D8BnHH0/c3787g/BCY4NeuTpuRAUsjtVRzLPE4p5qb7P3q64B9BP/rJicQrO2CZyybaP
         zCoNIdqOPTcH57d0FIUFUrBe3nOP7CXPX1DCbStndPTc5YnVeeIyHj6NuUKWzM48k8Ac
         vCCYqKKCfxy5x9ogYsrOIzrlB52bEB8NMT/NTNG5gDkPudAkOL1UFKp6hETHtFolXIeK
         PqYNzQRUbftdsSZxhvIRHGnIl5zjDBJXm1DbTqh+fGoH/xomDhypF9+ADmMRUFwtu8yO
         uMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166545; x=1714771345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCoO2T2YsP7LrwbAT+g4HEuejnEIT/1nDXSmbYAkLWs=;
        b=m1odkMLlHoz5WfdetBS7rFVMRbwLFBGfLqWFpE/ds6SXY3mMIsEu8IvQU4Zi/q9HBz
         OLN+VKAkWQdXwzF3g/JcJLDMEgtwY3hg8+9ON5jOjrXwxZxpNYaMzqj767z2HRH0zASP
         74f//9LDNdAfqqF249U2TRyMEwUcgpSZVGgrzNCR1rg0NSWwLLJC/mU7uX4sFL/y/86L
         LEhDY/F63SGd0g6LZE7JTGFOlklxOA+xfPGuX+AVVx/LPA9taQgqnele9Rtim3QpR2Oh
         vH1k2JpNpV3BpgxHAuuNVgIvJ1IEZu+6QfflrF+98ZJSYmfEcflG36u3bnf9FCHb53Em
         dFSg==
X-Forwarded-Encrypted: i=1; AJvYcCV4wVKbPJcN97auBNhqGDNdkq13Cm47nWitB9jkkC4Wwprh3gCOGHeHRqXNnd+YpxqJWPZrPQNtcfUgMVBu3V1UnDacGPzAmNs5Zm2ELg==
X-Gm-Message-State: AOJu0YyeNyABok7kIGlYMjlXkjkZYYX1YeXLLNS5CuIehN9QReg59evH
	H6Pr8wt/liscFoSehotjGUtSKgiCQypWrjsuHdJhBpv6hcO5Y4eiMkbPyuoP4E0=
X-Google-Smtp-Source: AGHT+IGXdMkn9l1ezfkyGK+n7n0uMS4D1Tg5ZQjgV0UMy7e+oIR6yZfo+ivuZ6fE7HD6JR0rdlOg3w==
X-Received: by 2002:a17:902:eec1:b0:1e9:1f39:2edb with SMTP id h1-20020a170902eec100b001e91f392edbmr3802429plb.26.1714166544642;
        Fri, 26 Apr 2024 14:22:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001e245c5afbfsm16215959plk.155.2024.04.26.14.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:22:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s0T1R-00Bzn8-1O;
	Sat, 27 Apr 2024 07:22:21 +1000
Date: Sat, 27 Apr 2024 07:22:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
Message-ID: <ZiwbDbYUJgH7t+G6@dread.disaster.area>
References: <000000000000fee02e0616f8fdff@google.com>
 <20240426163008.GO360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426163008.GO360919@frogsfrogsfrogs>

On Fri, Apr 26, 2024 at 09:30:08AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 25, 2024 at 10:15:29PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=158206bb180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1619d847a7b9ba3a9137
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/caa90b55d476/disk-3b680865.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/17940f1c5e8f/vmlinux-3b680865.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b03bd6929a1c/bzImage-3b680865.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0 Not tainted
> > ------------------------------------------------------
> > kswapd0/81 is trying to acquire lock:
> > ffff8881a895a610 (sb_internal#3){.+.+}-{0:0}, at: xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
> > 
> > but task is already holding lock:
> > ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
> > ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #2 (fs_reclaim){+.+.}-{0:0}:
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> >        __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
> >        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
> >        might_alloc include/linux/sched/mm.h:312 [inline]
> >        slab_pre_alloc_hook mm/slub.c:3746 [inline]
> >        slab_alloc_node mm/slub.c:3827 [inline]
> >        kmalloc_trace+0x47/0x360 mm/slub.c:3992
> >        kmalloc include/linux/slab.h:628 [inline]
> >        add_stack_record_to_list mm/page_owner.c:177 [inline]

There's the GFP_KERNEL allocation being warned about again.

> >        inc_stack_record_count mm/page_owner.c:219 [inline]
> >        __set_page_owner+0x561/0x810 mm/page_owner.c:334
> >        set_page_owner include/linux/page_owner.h:32 [inline]
> >        post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
> >        prep_new_page mm/page_alloc.c:1541 [inline]
> >        get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
> >        __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
> >        __alloc_pages_node include/linux/gfp.h:238 [inline]
> >        alloc_pages_node include/linux/gfp.h:261 [inline]
> >        alloc_slab_page+0x5f/0x160 mm/slub.c:2175
> >        allocate_slab mm/slub.c:2338 [inline]
> >        new_slab+0x84/0x2f0 mm/slub.c:2391
> >        ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
> >        __slab_alloc mm/slub.c:3610 [inline]
> >        __slab_alloc_node mm/slub.c:3663 [inline]
> >        slab_alloc_node mm/slub.c:3835 [inline]
> >        kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
> >        kmem_cache_zalloc include/linux/slab.h:739 [inline]
> >        xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:679 [inline]
> >        xfs_refcountbt_init_cursor+0x65/0x2a0 fs/xfs/libxfs/xfs_refcount_btree.c:367
> >        xfs_reflink_find_shared fs/xfs/xfs_reflink.c:147 [inline]
> >        xfs_reflink_trim_around_shared+0x53a/0x9d0 fs/xfs/xfs_reflink.c:194
> >        xfs_buffered_write_iomap_begin+0xebf/0x1b40 fs/xfs/xfs_iomap.c:1062
> 
> Hm.  We've taken an ILOCK in xfs_buffered_write_iomap_begin, and now
> we're allocating a btree cursor but we don't have PF_MEMALLOC_NOFS set,
> nor do we pass GFP_NOFS.
> 
> Ah, because nothing in this code path sets PF_MEMALLOC_NOFS explicitly,
> nor does it create a xfs_trans_alloc_empty, which would set that.  Prior
> to the removal of kmem_alloc, I think we were much more aggressive about
> GFP_NOFS usage.
> 
> Seeing as we're about to walk a btree, we probably want the empty
> transaction to guard against btree cycle livelocks.

Nothing like that is needed or desired, this is a just a bug in the
memory allocation tracking code...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

