Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582EBBEA63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfIZCIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:08:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38174 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfIZCIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:08:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so90310wro.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UL7xbe0U1dTqNyI24zzzXMfj1sU5aoXmBfPpWRtIBEc=;
        b=mXod3OEt2iDvU4rw+x/HnqireXm4LPCcYJhWX2vG0fPidGOK8PW2DRljCOz+mKSQEq
         kPukTl37vUXczZOA7EVlWqnnhpgQBMftxbX6N6I1H1g4L18k88S8diTFngOmrjM1Ma+B
         9FF9Z5Ys6RLDCoVphr5AFQMJN0Gr0Hwa1kRpunADCmx/xsNyYwgXraK3YZGMOySlaO9w
         YSZSzO8tl5kKjYkU5UdQB0h4VtrbHejJKMQv86+V2sZUgioL2sxdZsW+BT15NLM7CT1G
         DLl/Bzzx/NE3/8DrXIGzUS186Gt/k2WnI084GFQlSO1bOo2X06X1z3/M4jt4xtubKYIg
         DgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UL7xbe0U1dTqNyI24zzzXMfj1sU5aoXmBfPpWRtIBEc=;
        b=Rj+IyU/CFHHQiLBMogE8F6jG7sIhJ9t4IK5O5XkVCl561OL/1gKWhFM9pVwN7HQzLJ
         q+YVMBdrBoUGn8ThfKCN2ebzOaDOyGoEpxzUF4wCiJiaDKHL3rgcJkTyIvEwlqH7CuLu
         gwrkUwsJSCXNzNGv7hFYhFHdRSz0dlWu4QQwK03r/nw28drt3WKC8Mfk0GYtZd+MACUX
         ROoDEHz0Qf2uSaJhzjI4tDRGoYPBhe+qMDeA8Y5NFUT/hkviAQhqzhIAl6iGENfMF/K6
         A7HDomdEMgEiG/gLSxWxHG8BmfCrDYO1BbXh7N1X4kZJqhNJhFW6CjaU6dQHbdavVZ72
         cQIg==
X-Gm-Message-State: APjAAAXZGrQeEpK/KLk3Gb3RAfpg9mPyU9Wu7qabOBqGb7KelQ/nnj6M
        b08x8qhUfDoj3BhWpJPKu70MjsEryvg=
X-Google-Smtp-Source: APXvYqyLuiT81W3xWgJ31qnO6ba5jH/lpx9zUOL77Xy95JJTtW3F7O3hcUBhkkSxn6jRJ/9XfK5sXA==
X-Received: by 2002:a5d:4ac9:: with SMTP id y9mr873287wrs.371.1569463698764;
        Wed, 25 Sep 2019 19:08:18 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:08:17 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
Date:   Thu, 26 Sep 2019 05:07:09 +0300
Message-Id: <20190926020725.19601-1-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I would please like to submit the Kernel code part of the ZUFS file system,
for review. V02

[v02]
   The git of the changes over v01 can be found at: (Note based on v5.2)
	git https://github.com/NetApp/zufs-zuf upstream-5.2-v02-fixes

   The patches submitted are at:
	git https://github.com/NetApp/zufs-zuf upstream-v02

   list of changes since v01
   * Based on Linux v5.3. Previous was based on v5.2 and experienced
     build breakage with v5.3-rcX
   * Address *all* comments by the Intel Robot. The code should be
     completely free of any warnings.
   * Some bugs found since the time of the first submission.
   * More I(s) doted and T(s) crossed. Please see above
     upstream-5.2-v02-fixes for all the patches on top of v01 before
     they were re-squashed into this set.

[v01]
   find v01 submission here:
   https://lore.kernel.org/linux-fsdevel/20190812164806.15852-1-boazh@netapp.com/
   On github:
	git https://github.com/NetApp/zufs-zuf upstream-v01

---
ZUFS is a full implementation of a VFS filesystem. But mainly it is a very
new way to communicate with user-mode servers.
With performance and scalability never seen before. (<4us latency)
Why? the core communication with user-mode is completely lockless,
per-cpu locality, NUMA aware.

The Kernel code presented here can be found at:
	https://github.com/NetApp/zufs-zuf upstream

And the User-mode Server + example FSs here:
	https://github.com/NetApp/zufs-zus upstream

ZUFS - stands for Zero-copy User-mode FS
The Intention of this project is performance and low-latency.
* True zero copy end to end of both data and meta data.
* Very *low latency*, very high CPU locality, lock-less parallelism.
* Synchronous operations (for low latency)
* Numa awareness

Short description:
  ZUFS is a from scratch implementation of a filesystem-in-user-space, which
  tries to address the above goals. from the get go it is aimed for pmem
  based FSs. But supports any other type of FSs.
  The novelty of this project is that the interface is designed with a modern
  multi-core NUMA machine in mind down to the ABI.
  Also it utilizes the normal mount API of the Kernel.
  Multiple block devices are supported per superblock, Kernel owns those
  devices. FileSystem types are registered/exposed via the regular way

The Kernel is released as a pure GPLv2 License. The user-mode core is
BSD-3 so to be friendly with other OSs.

Current status: There are a couple of trivial open-source filesystem
implementations and a full blown proprietary implementation from Netapp.
 3 more ports to more serious open-source filesystems are on the way.
A usermode CEPH client, a ZFS implementation, and port of the infamous PMFS
to demonstrate the amazing pmem performance under zufs.
(Will be released as Open source when they are ready)

Together with the Kernel module submitted here the User-mode-Server and the
zusFSs User-mode plugins, pass Netapp QA including xfstests + internal QA tests.
And is released to costumers as Maxdata.
So it is very stable and performant

In the git repository above there is also a backport for rhel 7.6 7.7 and 8.0
Including rpm packages for Kernel and Server components.
(Also available evaluation licenses of Maxdata 1.5 for developers.
 Please contact Amit Golander <Amit.Golander@netapp.com> if you need one)

Performance:
A simple fio direct 4k random write test with incrementing number
of threads.

[fuse]
threads wr_iops	wr_bw	wr_lat
1	33606	134424	26.53226
2	57056	228224	30.38476
4	88667	354668	40.12783
7	116561	466245	53.98572
8	129134	516539	55.6134

[fuse-splice]
threads	wr_iops	wr_bw	wr_lat
1	39670	158682	21.8399
2	51100	204400	34.63294
4	75220	300882	47.42344
7	97706	390825	63.04435
8	98034	392137	73.24263

[xfs-dax]
threads	wr_iops	wr_bw		wr_lat   

[Maxdata-1.5-zufs]
threads	wr_iops	wr_bw		wr_lat
1	1041802 260,450		3.623
2	1983997 495,999		3.808
4	3829456 957,364		3.959
7	4501154 1,125,288	5.895330
8	4400698 1,100,174	6.922174

I have used an 8 way KVM-qemu with 2 NUMA nodes.
(on an Intel(R) Xeon(R) CPU E3-1230 v6 @ 3.50GHz)

Running fio with 4k random writes O_DIRECT | O_SYNC to a DRAM
simulated pmem. (memmap=! at grub)
Fuse-fs was a memcpy same 4k null-FS
fio was run with more and more threads (see threads column)
to test for scalability.

We see a bit of a slowdown when pushing to 8 threads. This is
mainly a scheduler and KVM issue. Big metal machines do better
(more flat scalability) but also degrade a bit on full load
I will try to post real metal scores later.

The in Kernel xfs-dax is slower than a zufs-pmem because:
1. It was not built specifically for pmem so there are latency
   issues (async operations) and extra copies in places.
2. In writes because of the Journal there are actually 3 IOPs
   for every write. Where with pmem other means can keep things
   crash-proof.
3. Because in random write + DAX each block is written twice
   It is first ZEROed then copied too.
4. But mainly because we use a single pmem on one of the NUMAs
   with zufs we put a pmem device on each NUMA node. And each core
   writes locally. So the memory bandwith is doubled. (Perhaps there
   is a way to use a dm configuration that makes this better but at
   the base xfs is not NUMA aware)
Is why I chose writes. With reads xfs-dax is much faster. In
zufs reads are actually 10% slower because in reads we do regular
memcpy-from-pmem which is exactly 10% slower than mov_nt operations

[Changes since last RFC submission]

Lots and lots of changes since then. More hardening stability
and more fixtures.

But mainly is the NEW-IO way.
The old way of IO where we mmap application-pages into the Server is
still there because there are modes where this is faster still.
For example direct IO from network type of FSs. We are all about choice.
(The zusFS is the one that decides which mode to use)
But the results above are with the NEW-IO way. The new way is -
we ask the Server what are the blocks to read/write (both pmem or bdev)
and the IO or pmem_memcpy is done in Kernel.
(We do not yet cache these results in Kernel but might in future
 ((when caching will actually make things faster currently xarray does
   not scale for us)))

[TODOs]
1. EZUFS_ASYNC is not submitted here. It is implemented but there are
   no current users so it was never fully tested (waiting for a user)
2. Support Page-cache. This one is very easy to do, but again no users
   yet
3. more stuff ....

Please help with *reviews*, comments, questions. We believe this is a very
important project that opens new ways for implementing Server-applications,
including but not restricted to FS Server applications.

Thank you
Boaz

----------------------------------------------------------------
Boaz Harrosh (16):
      fs: Add the ZUF filesystem to the build + License
      MAINTAINERS: Add the ZUFS maintainership
      zuf: Preliminary Documentation
      zuf: zuf-rootfs
      zuf: zuf-core The ZTs
      zuf: Multy Devices
      zuf: mounting
      zuf: Namei and directory operations
      zuf: readdir operation
      zuf: symlink
      zuf: Write/Read implementation
      zuf: mmap & sync
      zuf: More file operation
      zuf: ioctl implementation
      zuf: xattr && acl implementation
      zuf: Support for dynamic-debug of zusFSs

 Documentation/filesystems/zufs.txt |  386 +++++++++++++++++++++++++++++++
 MAINTAINERS                        |    6 +
 fs/Kconfig                         |    1 +
 fs/Makefile                        |    1 +
 fs/zuf/Kconfig                     |   24 ++
 fs/zuf/Makefile                    |   23 ++
 fs/zuf/_extern.h                   |  179 +++++++++++++++
 fs/zuf/_pr.h                       |   68 ++++++
 fs/zuf/acl.c                       |  270 ++++++++++++++++++++++
 fs/zuf/directory.c                 |  171 ++++++++++++++
 fs/zuf/file.c                      |  825 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/inode.c                     |  630 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/ioctl.c                     |  309 +++++++++++++++++++++++++
 fs/zuf/md.c                        |  742 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/md.h                        |  332 +++++++++++++++++++++++++++
 fs/zuf/md_def.h                    |  141 ++++++++++++
 fs/zuf/mmap.c                      |  300 ++++++++++++++++++++++++
 fs/zuf/module.c                    |   28 +++
 fs/zuf/namei.c                     |  435 +++++++++++++++++++++++++++++++++++
 fs/zuf/relay.h                     |  104 +++++++++
 fs/zuf/rw.c                        | 1051 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/super.c                     |  954 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/symlink.c                   |   74 ++++++
 fs/zuf/t1.c                        |  145 ++++++++++++
 fs/zuf/t2.c                        |  356 ++++++++++++++++++++++++++++
 fs/zuf/t2.h                        |   68 ++++++
 fs/zuf/xattr.c                     |  314 +++++++++++++++++++++++++
 fs/zuf/zuf-core.c                  | 1735 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf-root.c                  |  519 +++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf.h                       |  452 ++++++++++++++++++++++++++++++++++++
 fs/zuf/zus_api.h                   | 1075 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 31 files changed, 11718 insertions(+)
 create mode 100644 Documentation/filesystems/zufs.txt
 create mode 100644 fs/zuf/Kconfig
 create mode 100644 fs/zuf/Makefile
 create mode 100644 fs/zuf/_extern.h
 create mode 100644 fs/zuf/_pr.h
 create mode 100644 fs/zuf/acl.c
 create mode 100644 fs/zuf/directory.c
 create mode 100644 fs/zuf/file.c
 create mode 100644 fs/zuf/inode.c
 create mode 100644 fs/zuf/ioctl.c
 create mode 100644 fs/zuf/md.c
 create mode 100644 fs/zuf/md.h
 create mode 100644 fs/zuf/md_def.h
 create mode 100644 fs/zuf/mmap.c
 create mode 100644 fs/zuf/module.c
 create mode 100644 fs/zuf/namei.c
 create mode 100644 fs/zuf/relay.h
 create mode 100644 fs/zuf/rw.c
 create mode 100644 fs/zuf/super.c
 create mode 100644 fs/zuf/symlink.c
 create mode 100644 fs/zuf/t1.c
 create mode 100644 fs/zuf/t2.c
 create mode 100644 fs/zuf/t2.h
 create mode 100644 fs/zuf/xattr.c
 create mode 100644 fs/zuf/zuf-core.c
 create mode 100644 fs/zuf/zuf-root.c
 create mode 100644 fs/zuf/zuf.h
 create mode 100644 fs/zuf/zus_api.h
