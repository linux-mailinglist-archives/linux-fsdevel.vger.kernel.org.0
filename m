Return-Path: <linux-fsdevel+bounces-30634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320198CAEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91870B220CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1186DF78;
	Wed,  2 Oct 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KTa9MzKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53D5256
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833227; cv=none; b=J9Ic3YcL+SiUAznBMTUQm4xxcRaI+3OxKbdLeSHANZh0+B/ej3hF5bDXfQY00Sv5UUJ1JxWojT2Qxi3cgWpQrKyjpC662vFE/lb+eCIrqRWu/9gMWdYTZ3MCPfu6ihEWj16dC1X/h6erfdX32I1HTLXXWB4hwAuGHKGRPrYTA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833227; c=relaxed/simple;
	bh=gFgJLi5T4Aq+ZEXMe0aWDzXtKFuAqp2ElfhjlWpGNwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMsZVmwFYhF7htarM1ZX43EWTxNlgM4eFZxI4LZB6Q/ePfLF7t89CziGigdPl+a4Ul+n1/ZlXnxWNMGmIh9pf0LqOZ8ldTJ324sAmXRt+URmqxetx+tpC7oELd78Xz4CFJ2Z7zp5qZ29xRf/0slkuRwXqDgHZ3r6/OowMFfKOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KTa9MzKa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e18aa9f06dso187589a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727833224; x=1728438024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FL/uWM+F1cyS7WiT9KPMhNIEAhs7u8tYn84QmX7EFE4=;
        b=KTa9MzKaMMHdHGeqTNYcmH2KvtgOSomHI7so/BDBmXWuX9tDqIoNR8h+bccD1kxxVl
         E8Us1NG4/9T1S9HtlwxqCfogB+UGkD8At5k0vRkzdb72Tg3PynDIhNPlwjBVOPeS014s
         srq4qclF3hxFYh1fICnSAlAxGBmu39k8aD2+p23AWdjCd45pIwHbQjPr0q90RS9r5ION
         eC7FNwfuRvmH4ii7nPSLTg1VY/q6wFDhQnNh+6J/USRDEaaOuvgu7VZEmpcvJ/S6jjCj
         eKziY/H51kOseaf/ILis0PHvI6KNQ0w4TqUHWNaMBsRkGO4rAvDjcGx4MySCItWrCgk8
         gIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833224; x=1728438024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FL/uWM+F1cyS7WiT9KPMhNIEAhs7u8tYn84QmX7EFE4=;
        b=gPPPOXNXMWKKyYn5LVSlkj/yLxoLKwGbfEVZjsyGnxeBTEAFQUVEjXZ0Uxeun0tEEO
         kNgHMYsX58reaVAeHpjqM1Lt/vejJn45iJoYvtoFKxItyxUndnbUwQJRHwecUz7Ertm3
         C4Wp628zOPI071k/78ZR1jAqGNBamNUZVxokhu+whQV6RKxYaE9aXGK1zF2Vc8DDNO8r
         /ZPyxGzz0TjjADpM3ifhD3rUqIT6kKU5vcwXHX677shI1H/zFP8OvG+8DZEKGqtkB0SK
         KgVmKykmeBixE95aIs2GBSfNs3G2IDbWKd+LZhpT90dq4nFSKClfUaKIifcNA7N+0MOg
         1oSg==
X-Gm-Message-State: AOJu0YzIFiKHKBrF7j/2W9sKXNtBUQSXOpHj6cP5XwLl35D4qOwIajyq
	iOgifOnvFFBQbS4R7qSJA6J7/Bs6MEgezHaXBDKqY3bvatV3rU8sKO84YnVc4gWEvy0vMFJJp6D
	m
X-Google-Smtp-Source: AGHT+IG92mfCf/4JI93m8RltdBvzKp4sj6jD/Lj8LsU1FzMRk+wzCw1/d0x0uCot/MaWEPCSmto9ZQ==
X-Received: by 2002:a17:90b:4d04:b0:2e0:a9e8:bb95 with SMTP id 98e67ed59e1d1-2e15a19ec2dmr7463719a91.3.1727833224007;
        Tue, 01 Oct 2024 18:40:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8cda33sm329075a91.44.2024.10.01.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:40:22 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1svoLj-00Ck8P-01;
	Wed, 02 Oct 2024 11:40:19 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1svoLj-0000000FxG9-1jxt;
	Wed, 02 Oct 2024 11:40:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Date: Wed,  2 Oct 2024 11:33:17 +1000
Message-ID: <20241002014017.3801899-1-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The management of the sb->s_inodes list is a scalability limitation;
it is protected by a single lock and every inode that is
instantiated has to be added to the list. Those inodes then need to
be removed from the list when evicted from cache. Hence every inode
that moves through the VFS inode cache must take this global scope
lock twice.

This proves to be a significant limiting factor for concurrent file
access workloads that repeatedly miss the dentry cache on lookup.
Directory search and traversal workloads are particularly prone to
these issues, though on XFS we have enough concurrency capability
in file creation and unlink for the sb->s_inodes list to be a
limitation there as well.

Previous efforts to solve this problem have
largely centered around reworking the sb->s_inodes list into
something more scalable such as this longstanding patchset does:

https://lore.kernel.org/linux-fsdevel/20231206060629.2827226-1-david@fromorbit.com/

However, a recent discussion about inode cache behaviour that arose
from the bcachefs 6.12-rc1 pull request opened a new direction for
us to explore. With both XFS and bcachefs now providing their own
per-superblock inode cache implementations, we should try to make
use of these inode caches as first class citizens.

With that new direction in mind, it became obvious that XFS could
elide the sb->s_inodes list completely - "the best part is no part"
- if iteration was not reliant on open-coded sb->s_inodes list
walks.

We already use the internal inode cache for iteration, and we have
filters for selecting specific inodes to operate on with specific
callback operations. If we had an abstraction for iterating
all VFS inodes, we can easily implement that directly on the XFS
inode cache.

This is what this patchset aims to implement.

There are two superblock iterator functions provided. The first is a
generic iterator that provides safe, reference counted inodes for
the callback to operate on. This is generally what most sb->s_inodes
iterators use, and it allows the iterator to drop locks and perform
blocking operations on the inode before moving to the next inode in
the sb->s_inodes list.

There is one quirk to this interface - INO_ITER_REFERENCE - because
fsnotify iterates the inode cache -after- evict_inodes() has been
called during superblock shutdown to evict all non-referenced
inodes. Hence it should only find referenced inodes, and it has
a check to skip unreferenced inodes. This flag does the same.

However, I suspect this is now somewhat sub-optimal because LSMs can
hold references to inodes beyond evict_inodes(), and they don't get
torn down until after fsnotify evicts the referenced inodes it
holds. However, the landlock LSM doesn't have checks for
unreferenced inodes (i.e. doesn't use INO_ITER_REFERENCE), so this
guard is not consistently applied.

I'm undecided on how best to handle this, but it does not need to be
solved for this patchset to work. fsnotify and
landlock don't need to run -after- evict_inodes(), but moving them
to before evict_inodes() mean we now do three full inode cache
iterations to evict all the inodes from the cache. That doesn't seem
like a good idea when there might be hundreds of millions of cached
inodes at unmount.

Similarly, needing the iterator to be aware that there should be no
unreferenced inodes left when they run doesn't seem like a good
idea, either. So perhaps the answer is that the iterator checks for
SB_ACTIVE (or some other similar flag) that indicates the superblock
is being torn down and so will skip zero-referenced inodes
automatically in this case. Like I said - this doesn't need to be
solved right now, it's just something to be aware of.

The second iterator is the "unsafe" iterator variant that only
provides the callback with an existence guarantee. It does this by
holding the rcu_read_lock() to guarantee that the inode is not freed
from under the callback. There are no validity checks performed on
the inode - it is entirely up to the callback to validate the inode
can be operated on safely.

Hence the "unsafe" variant is only for very specific internal uses
only. Nobody should be adding new uses of this function without
as there are very few good reasons for external access to inodes
without holding a valid reference. I have not decided whether the
unsafe callbacks should require a lockdep_assert_in_rcu_read_lock()
check in them to clearly document the context under which they are
running.

The patchset converts all the open coded iterators to use these
new iterator functions, which means the only use of sb->s_inodes
is now confined to fs/super.c (iterator API) and fs/inode.c
(add/remove API). A new superblock operation is then added to
call out from the iterators into the filesystem to allow them to run
the iteration instead of walking the sb->s_inodes list.

XFS is then converted to use this new superblock operation. I didn't
use the existing iterator function for this functionality right now
as it is currently based on radix tree tag lookups. It also uses a
batched 'lookup and lock' mechanism that complicated matters as I
developed this code. Hence I open coded a new, simpler cache walk
for testing purposes.

Now that I have stuff working and I think I have the callback API
semantics settled, batched radix tree lookups should still work to
minimise the iteration overhead. Also, we might want to tag VFS
inodes in the radix tree so that we can filter them efficiently for
traversals. This would allow us to use the existing generic inode
cache walker rather than a separate variant as this patch set
implements. This can be done as future work, though.

In terms of scalability improvements, a quick 'will it scale' test
demonstrates where the sb->s_inodes list hurts. Running a sharded,
share-nothing cold cache workload with 100,000 files per thread in
per-thread directories gives the following results on a 4-node 64p
machine with 128GB RAM.

The workloads "walk", "chmod" and "unlink" are all directory
traversal workloads that stream cold cache inodes into the cache.
There is enough memory on this test machine that these indoes are
not being reclaimed during the workload, and are being freed between
steps via drop_caches (which iterates the inode cache and so
explicitly tests the new iteration APIs!). Hence the sb->s_inodes
scalability issues aren't as bad in these tests as when memory is
tight and inodes are being reclaimed (i.e. the issues are worse in
real workloads).

The "bulkstat" workload uses the XFS bulkstat ioctl to iterate
inodes via walking the internal inode btrees. It uses
d_mark_dontcache() so it is actually tearing down each inode as soon
as it has been sampled by the bulkstat code. Hence it is doing two
sb->s_inodes list manipulations per inode and so shows scalability
issues much earlier than the other workloads.

Before:

Filesystem      Files  Threads  Create       Walk      Chmod      Unlink     Bulkstat
       xfs     400000     4      4.269      3.225      4.557      7.316      1.306
       xfs     800000     8      4.844      3.227      4.702      7.905      1.908
       xfs    1600000    16      6.286      3.296      5.592      8.838      4.392
       xfs    3200000    32      8.912      5.681      8.505     11.724      7.085
       xfs    6400000    64     15.344     11.144     14.162     18.604     15.494

Bulkstat starts to show issues at 8 threads, walk and chmod between
16 and 32 threads, and unlink is limited by internal XFS stuff.
Bulkstat is bottlenecked at about 400-450 thousand inodes/s by the
sb->s_inodes list management.

After:

Filesystem      Files  Threads  Create       Walk      Chmod      Unlink     Bulkstat
       xfs     400000     4      4.140      3.502      4.154      7.242      1.164
       xfs     800000     8      4.637      2.836      4.444      7.896      1.093
       xfs    1600000    16      5.549      3.054      5.213      8.696      1.107
       xfs    3200000    32      8.387      3.218      6.867     10.668      1.125
       xfs    6400000    64     14.112      3.953     10.365     18.620      1.270

When patched, walk shows little in way of scalability degradation
out to 64 threads, chmod is significantly improved at 32-64 threads,
and bulkstat shows perfect scalability out to 64 threads now.

I did a couple of other longer running, higher inode count tests
with bulkstat to get an idea of inode cache streaming rates - 32
million inodes scanned in 4.4 seconds at 64 threads. That's about
7.2 million inodes/s being streamed through the inode cache with the
IO rates are peaking well above 5.5GB/s (near IO bound).

Hence raw VFS inode cache throughput sees a ~17x scalability
improvement on XFS at 64 threads (and probably a -lot- more on
higher CPU count machines).  That's far better performance than I
ever got from the dlist conversion of the sb->s_inodes list in
previous patchsets, so this seems like a much better direction to be
heading for optimising the way we cache inodes.

I haven't done a lot of testing on this patchset yet - it boots and
appears to work OK for block devices, ext4 and XFS, but checking
stuff like quota on/off is still working properly on ext4 hasn't
been done yet.

What do people think of moving towards per-sb inode caching and
traversal mechanisms like this?

-Dave.

