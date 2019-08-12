Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E728A3AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHLQsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so14903014wrj.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FKPizWGbGVEz/UndPoqN8/HIvU7KLf2kRrG7aN8su4=;
        b=twTyig0ebwJHb2xkWsfjUXnoHdIzFv6AzPuGcrdsnH8D/Ltt8x93CQ2SsqLI3EFFkV
         pSzOIQgBkndYK4n5U24/C0UUFncACzaiuwEj/N/sgyERb3erKbP55JXgB9fntCcs9Q6O
         z/RhvAaEwF0ZqNPMPl+XmYMnVV9asE6A9a5OaeGSw1RaWP4kQ7V3wg3bBSgvgnHdH3RT
         eY066Sq3flXLRFGLqnl1/QyG9pC8Y/HNeLz7lmRs5QIt9OVzKD+VGLDDEMZnXadOT/+z
         pz6uMNi+8CTiibMoBG21hu4T2zl1WYJbPCTv/EDaimrtlZAfzuOBnTx4E0NfnTaR7m+W
         LxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FKPizWGbGVEz/UndPoqN8/HIvU7KLf2kRrG7aN8su4=;
        b=r1J+xsMfcQyEEnpz92X5KYmQ3lq/ICHYc1OTdajEpjk6XMb4qOJIoStcx+rxNDvSUo
         XMEPNzkFyNSG5gFGBTon/6wuiaOlPhUlZPqLSy6KcAzB6otMG4atzLj2BlTiA7QQ08HO
         L+u7QIPYmULEB852h6Ea9kMjMAeTaEYDScSRn2ozbcQgGpwGtg3pNhyH78zZP+RCq96a
         DTOsg5tvEQZYv+oB1QXuG1FAKAR/ZLwY6He/R+t8RXsCmUheMu5+lXtxH227es5UKVPc
         sxmHaJiPjr4CcjORzcWwo0Ybg3FLnY51SEqRXThRcaVOtxOGevr8W8owtm/XQzVo0G3y
         ijug==
X-Gm-Message-State: APjAAAVO1KBcKUPjEJamNPl7aW1EGdT1iO5zfI/DS/c4oh8dZ5uOxqdP
        5gQ4VSnOo8/YFdg28culf2wKcIGnUIk=
X-Google-Smtp-Source: APXvYqwpDlYrIgARAuUWyjB18HhdATeKjJDrvTn0xc3Pe+SdFi1Wb8PnymtdGUJ1NluWIUz1DqOdQg==
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr26262493wrn.35.1565628489406;
        Mon, 12 Aug 2019 09:48:09 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id q20sm52636412wrc.79.2019.08.12.09.48.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:08 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCHSET 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
Date:   Mon, 12 Aug 2019 19:47:50 +0300
Message-Id: <20190812164806.15852-1-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I would please like to submit the Kernel code part of the ZUFS file system,
for review.

ZUFS is a full implementation of a VFS filesystem. But mainly it is a very
new way to communicate with user-mode servers.
With performance and scalability never seen before. (<4us latency)
Why? the core communication with user-mode is completely lockless,
per-cpu locality, NUMA aware.

The Kernel code presented here can be found at:
	https://github.com/NetApp/zufs-zuf upstream

And the User-mode Server + example FSs here:
	https://github.com/NetApp/zufs-zus

ZUFS - stands for Zero-copy User-mode FS
The Intention of this project was performance and low-latency.
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
And is released to costumers as Maxdata 1.5.
So it is very stable and performant

In the git repository above there is also a backport for rhel 7.6 and 7.7
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

Please help with *reviews*, comments, questions. We believe this is a very
important project that opens new ways for implementing Server-applications,
including but not restricted to FS Server applications.

Thank you
Boaz

~~~~~~~~~~~~~~~~~~
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
      zuf: More file operations
      zuf: ioctl implementation
      zuf: xattr && acl implementation
      zuf: Support for dynamic-debug of zusFSs

 Documentation/filesystems/zufs.txt |  370 +++++++++++++++++++++++++++++
 MAINTAINERS                        |    6 +
 fs/Kconfig                         |    1 +
 fs/Makefile                        |    1 +
 fs/zuf/Kconfig                     |   24 ++
 fs/zuf/Makefile                    |   23 ++
 fs/zuf/_extern.h                   |  180 ++++++++++++++
 fs/zuf/_pr.h                       |   63 +++++
 fs/zuf/acl.c                       |  270 +++++++++++++++++++++
 fs/zuf/directory.c                 |  167 +++++++++++++
 fs/zuf/file.c                      |  840 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/inode.c                     |  693 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/ioctl.c                     |  313 +++++++++++++++++++++++++
 fs/zuf/md.c                        |  752 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/md.h                        |  332 ++++++++++++++++++++++++++
 fs/zuf/md_def.h                    |  145 ++++++++++++
 fs/zuf/mmap.c                      |  300 ++++++++++++++++++++++++
 fs/zuf/module.c                    |   28 +++
 fs/zuf/namei.c                     |  435 ++++++++++++++++++++++++++++++++++
 fs/zuf/relay.h                     |  104 +++++++++
 fs/zuf/rw.c                        |  977 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/super.c                     |  925 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/symlink.c                   |   74 ++++++
 fs/zuf/t1.c                        |  135 +++++++++++
 fs/zuf/t2.c                        |  356 ++++++++++++++++++++++++++++
 fs/zuf/t2.h                        |   68 ++++++
 fs/zuf/xattr.c                     |  314 +++++++++++++++++++++++++
 fs/zuf/zuf-core.c                  | 1716 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf-root.c                  |  520 +++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf.h                       |  437 ++++++++++++++++++++++++++++++++++
 fs/zuf/zus_api.h                   | 1079 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 31 files changed, 11648 insertions(+)
