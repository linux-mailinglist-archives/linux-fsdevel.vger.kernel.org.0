Return-Path: <linux-fsdevel+bounces-4937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0350806751
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972822820BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6A18AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="K2jBDl3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053F9D45
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso2604674a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842795; x=1702447595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ4TkYRaggCJYZK2FV5jJyuJ3CMLuWDtaS8ek+7yiFo=;
        b=K2jBDl3k7t3xOaKy/HutfVbTEK+JLiL5RsbTpm4VOs/SO342BQ/X4ZDFNfVtA05i+H
         GxpxMZKbStn+LW3EzoyEzFgHpQiDYxkeIO6HjMEoBgi6wUQaB8mTK7Owsj9E4H2O7gSC
         IAx19UZE6WgYV9ascTp96lSHZQFc8WV3HW/805eDheFEb2dLVegQCvS8C9Cmr/hzHTB6
         wt2pl1eOexZqzCA8GRvwcT0OWDgQjNqsxDZa8IFroPjroGCI/bzihR6GGtm+AVTqFE3d
         dWVnqvejHsAHh3AG9+AD0LfOCAB2fvcU82hvAcuQBBubSLUgkbHXoEAQQ53ZMZVTkQtp
         WN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842795; x=1702447595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ4TkYRaggCJYZK2FV5jJyuJ3CMLuWDtaS8ek+7yiFo=;
        b=c68pYHNcN6zzG8vBwCDjaCPpMJKZOThYC4peiZNEI9gWFCBjcKj0FTd3u+FTrOMAK2
         iJn1Qu8hs5iW92qcIDP3nvKxNN09zSFG2bP4lkTJDB5TLWyfT+HPaCPYTJpSqK3XNlrq
         eCJjyJeTdc+243BeCG1PxAMKrlrRDOKJ1iNU0rn6p4NaxigjYrAiwaUCtJGUG6LoLUcS
         LICFPJKQWzI+p2QPlSj2vpYepi1NguRv4Poc04MytNXskjZ8A/vy0rbDBtImpwF6eS8T
         iUJ/wiecSFSOaW3IO9QINwSeiUMLhci4leMuHCthKYTBczO4kAAfhY5o7pi4oZxd/uSF
         Z0lw==
X-Gm-Message-State: AOJu0YwdKFp3LAIo1WuSaBKwdWlt7nl8Gy1bLwvpV5eygostQbF+KpLU
	mM5ALPfL+PeOo3sjFILwLguIRA==
X-Google-Smtp-Source: AGHT+IHb/Qtsso0o+wVgpqf1pcApUheNiLjU522o042hStNIoB3lfZqrlikbyIfnnInfyFHBsFTr/w==
X-Received: by 2002:a05:6a20:8f0e:b0:18f:d694:e899 with SMTP id b14-20020a056a208f0e00b0018fd694e899mr202540pzk.7.1701842795313;
        Tue, 05 Dec 2023 22:06:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id ju1-20020a170903428100b001cf7c07be50sm8347099plb.58.2023.12.05.22.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3H-004VOX-2U;
	Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrUz-1Ada;
	Wed, 06 Dec 2023 17:06:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/11] vfs: inode cache scalability improvements
Date: Wed,  6 Dec 2023 17:05:29 +1100
Message-ID: <20231206060629.2827226-1-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We all know that the global inode_hash_lock and the per-fs global 
sb->s_inode_list_lock locks are contention points in filesystem workloads
that stream inodes through memory, so it's about time we addressed these
limitations.

The first part of the patchset address the sb->s_inode_list_lock.
This was done a long time ago by Waiman Long by converting the
global linked list to a per-cpu linked list - those infrastructure
patches are pretty much unchanged from when Waiman first wrote them,
and as such the still carry the RVB that Jan Kara gave for them. I
have no idea if the problem that Waiman was trying to solve still
exists, but that's largely irrelevant because there are other
problems that I can easily reproduce.

That is, once at ~16 threads trying to instantiate or tear down
inodes at the same time in a filesystem, the sb->s_inode_list_lock
becomes a single point of contention. Adding an inode to the inode
cache requires adding it to the sb->s_inodes list, and removing an
inode from the cache requires removing it from the sb->s_inodes
list. That's two exclusive lock operations per inode we cycle
through the inode cache.

This creates a hard limit on the number of inodes we can cycle
through memory in a single filesystem. It tops out at around
600-700,000 inodes per second on XFS, and at that point we see
catastrophic cacheline contention breakdown and nothing goes any
faster. We can easily burn hundreds of CPUs on the sb->s_inodes list
operations, yet we still can only get 600-700k inodes/s through the
cache.

Converting the sb->s_inodes list to a dlist gets rid of this single
contention point and makes the sb->s_inodes list operations
disappear from the profiles completely. Prior to this change, at 32
threads XFS could pull 12.8 million inodes into cache in ~20s
(that's ~600k inodes/s - sound familiar?). With this change, those
12.8 million inodes are pulled into cache in ~10s. That's double the
rate at which XFS can pull inodes into memory from the
filesystem....

I'm talking about XFS here, because none of the other filesystem
actually stress the sb->s_inode_list_lock at all. They all hit
catastrophic cacheline contention on the inode_hash_lock long before
they get anywhere near the sb->s_inodes limits. For ext4 and
bcachefs, the inode_hash_lock becomes a limiting factor at 8
threads. btrfs hits internal namespace tree contention limits at 2
threads, so it's not even stressing the inode_hash_lock unless
highly threaded workloads are manually sharded across subvolumes.

So to bring the rest of the filesystems up, we need to fix the
inode_hash_lock contention problems.  This patchset replaces the
global inode_hash_lock with the same lock-per-chain implementation
that the dentry cache uses. i.e. hash-bl lists. This is more complex
than the dentry cache implementation, however, because we nest spin
locks inside the inode_hash_lock. This conversion means we nest spin
locks inside bit spin locks in the inode cache.

Whilst this doesn't sound particularly problematic, the issue arises
on CONFIG_PREEMPT_RT kernels, where spinlocks are converted to
sleeping locks. We can't place sleeping locks inside spinning bit
locks, and that's exactly what happens if we use hash-bl lists in
the inode cache and then turn on CONFIG_PREEMPT_RT.

The other downside to converting to hash-bl is that we lose lockdep
coverage of the inode hash table - lockdep does not track bit locks
at all.

Both of these issues can be solved the same way: whenever either of
these two config options are turned on, we change the hash-bl
implementation from using a bit spin lock on th elowest bit of the
chain head pointer to using as dedicated spinlock per chain. This
trades off performance and memory footprint for configurations where
correctness is more important than performance, but allows optimal
implementations of hash-bl lists when performance is the primary
concern.

In making this conversion, we make all hash-bl implementations safe
for PREEMPT_RT usage and gain lockdep coverage of all hash-bl lists.
It also pointed out that several hash-bl list users did not actually
initialise the hash list heads correctly - they elided the
initialisation and only got away with it because they allocated
zeroed memory and the hash list head would still work from empty.
This needed fixing for lockdep....

The result of this conversion is that inode cache lookup heavy
workloads such as filesystem traversals and inode creation/removal
no longer contend on the inode_hash_lock to stream inodes through
the inode cache. This results in big performance improvements at
thread counts of >= 8.

I've run this through fstests with lockdep enabled on ext4 and XFS
without discovering any issues except for dm-snapshot needing
lockdep nesting annotations for list-bl locks. I've run a bunch of
"will-it-scale" like tests across XFS, ext4, bcachefs and btrfs, and
the raw table results for 6.7-rc4 are below.

The tests runs a fixed number of files per thread, so as the thread
count increases we should see runtimes stay constant if scalability
is perfect. I'm not caring about operation rates, I'm not caring
about which filesystems are faster, all I'm looking at is whether
the scalability of individual filesytsems improves with the changes.

base:  vanilla 6.7-rc4 kernel
scale: 6.7-rc4 plus this patchset

Filesystem      Files  Threads      Create             Walk             chmod            Unlink
				base    scale	  base    scale     base    scale    base    scale
       xfs     400000     1     11.217 10.477     11.621 11.570     14.980 14.797    18.314 18.248
       xfs     800000     2     12.313 11.470     11.673 11.158     15.271 14.782    19.413 18.533
       xfs    1600000     4     14.130 13.246      9.665  9.444     14.794 13.710    19.582 17.015
       xfs    3200000     8     16.654 16.108     10.622  9.275     15.854 14.575    20.679 19.237
       xfs    6400000    16     17.587 18.151     12.148  9.508     16.655 17.691    26.044 21.865
       xfs   12800000    32     20.833 21.491     20.518 10.308     23.614 19.334    42.572 27.404

All of the operations that require directory traversal show
significant improvements at 16 or more threads on XFS. This is
entirely from the sb->s_inodes modifications.

Filesystem      Files  Threads      Create             Walk             chmod            Unlink
				base    scale	  base    scale     base    scale    base     scale
      ext4     400000     1      9.344  9.394      7.691  7.847      9.188  9.212    11.340  12.517
      ext4     800000     2     10.445 10.375      7.923  7.358     10.158 10.114    14.366  14.093
      ext4    1600000     4     11.008 10.948      8.152  7.530     11.140 11.150    18.093  17.153
      ext4    3200000     8     23.348 12.134     13.090  7.871     15.437 12.824    30.806  31.968
      ext4    6400000    16     17.343 29.112     24.602  9.540     31.034 22.057    60.538  57.636
      ext4   12800000    32     40.125 44.638     49.536 19.314     63.183 38.905   138.688 138.632

Walk on ext4 shows major improvements at 8 threads and above, as
does the recursive chmod. This largely comes from the inode hash
lock removal, but the full scalability improvements are not realised
until the sb->s_inodes changes are added as well. 

Note that unlink doesn't scale or improve because the mkfs.ext4
binary in debian unstable does not support the orphan file option
and so it is completely bottlenecked on orphan list scalability
issues.

Filesystem      Files  Threads      Create             Walk             chmod            Unlink
				base    scale	  base    scale     base    scale    base     scale
  bcachefs     400000     1     16.999 17.193      6.546  6.355    13.973  13.024    28.890  19.014
  bcachefs     800000     2     20.133 19.597      8.003  7.276    22.042  20.070    28.959  29.141
  bcachefs    1600000     4     22.836 23.764      9.097  8.506    58.827  56.108    38.955  37.435
  bcachefs    3200000     8     27.932 27.545     11.752 10.015   192.802 185.834    64.402  77.188
  bcachefs    6400000    16     32.389 32.021     24.614 13.989   409.873 408.098   243.757 249.220
  bcachefs   12800000    32     39.809 40.221     49.179 25.982   879.721 821.497   501.357 485.781

bcachefs walk shows major improvements at 16 threads and above, but
chmod and unlink are drowned by internal contention problems.

Filesystem      Files  Threads      Create             Walk             chmod            Unlink
				base    scale	  base     scale    base     scale    base      scale
     btrfs     400000     1     10.307  10.228    12.597  12.104    14.744  14.030    24.171   24.273
     btrfs     800000     2     15.956  14.018    19.693  17.180    24.859  20.872    59.338   48.725
     btrfs    1600000     4     22.441  20.951    32.855  29.013    37.975  33.575   140.601  125.305
     btrfs    3200000     8     34.157  32.693    55.066  56.726    66.676  64.661   343.379  325.816
     btrfs    6400000    16     60.847  59.123    90.097  89.340   116.994 114.280   683.244  681.953
     btrfs   12800000    32    122.525 118.510   118.036 125.761   206.122 212.102  1612.940 1629.689

There's little point in doing scalability testing on plain btrfs -
it is entirely bottlenecked on internal algorithms long before
anything in the VFS becomes a scalability limitation.

Filesystem      Files  Threads      Create             Walk             chmod            Unlink
				base    scale	  base    scale     base    scale    base     scale
btrfs-svol     400000     1     10.417  9.830     12.011 12.154     14.894 14.913    24.157  23.447
btrfs-svol     800000     2     12.079 11.681     12.596 12.208     16.535 15.310    28.031  26.412
btrfs-svol    1600000     4     15.219 15.074     12.711 10.735     18.079 16.948    34.330  31.949
btrfs-svol    3200000     8     23.140 21.307     14.706 10.934     22.580 21.907    53.183  52.129
btrfs-svol    6400000    16     40.657 40.226     26.062 11.471     34.058 33.333   101.133  99.504
btrfs-svol   12800000    32     81.516 79.412     50.320 12.406     65.691 58.229   193.847 200.050

Once btrfs is running with a sharded namespace (i.e. subvol per
thread) we results very similar in nature to bcachefs - walk
improves dramatically at high thread counts, but nothing else
changes as all the scalability limitations are internal to the
filesystem.

I have tested to 64 threads, but there's not a lot extra to add. The
XFs walk was done in 14.1s, so scalability is falling off but I
haven't spent any time looking at it in detail because there's just
so much other internal stuff to fix up before the rest of this
benchmark scales to 64 threads on XFS....

Git tree containing this series can be pulled from:

https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale

-Dave.



