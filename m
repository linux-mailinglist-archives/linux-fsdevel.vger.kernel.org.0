Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F8298D20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775566AbgJZMvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:51:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39337 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772927AbgJZMvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:51:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id y12so12345375wrp.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqgjVB6F8Bx58HXS22hwK8rReuNM67G4EIl7ngKgd/k=;
        b=s9KFKrIJYd0g1tAYwisx2ejW+1aNeRYNnZLjamPMfZYmsf6yyS4rMLDf1nl3kMWXxE
         bs/zGX7RmJkaubGnly3LZojmsOgsj9KVdLF0ckTaXvKbH43VxoVGG7Fs8yiQEeDlHe4X
         O43oKjW8f5aqK1s2cTdCqcgr4T+yhWA+507Z0iax1P1IK02Tg6Q18D1OdorakR7HSCHW
         Er6IRYBHMCvDaNJejkAuJDuFzj3Ig4FjHS7hX0iWyQOFqcdbI7KmxFWvLmEoqfIaKwTx
         25dKCAcwKzfUuuYsLrErMPOGCSZ8jaM+/R6xaVy2EDKjYtR0mH74X4Dh+pPn4+H7ZHYy
         iQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqgjVB6F8Bx58HXS22hwK8rReuNM67G4EIl7ngKgd/k=;
        b=kB5UNzr7DfMfpT1Nxaf+AdocfBZW9OloRAWD3rwEMgWSOX+WnVpwORcEc4Q/TiksTm
         NIAB4n4Apwpc0g7YY1YCgN0f0TpFeK+7UjUrYnZyqSV40PRZC3PVTais4p58hzzOv0k0
         RfWmMQcwQMzkU+oOjtnzC06+5fXTkEW9L0D3yfZZXy8IPddT0NgDFpfzdk2i+R0E2yzu
         8tusrO8aYjwOaJ0hY3KNDXGG6Fd+SkJpHIJ5eON+2nQ3gCEtj34S91AG3k0Ukg/8aiOv
         0HOyXlxlmMJ6Y7VIx5NRuiaY2JRtVExoekOupxKbYtRjkSpBd7SNCW15XC2JyMxbLhia
         K9Rw==
X-Gm-Message-State: AOAM532UgMQdPHQW6nrqa0mzTeO5pCL2bYGQdxR+bacsUKBTrWxgmPiS
        dpkxbAU+8y3WU2ZTtR8HOCom7Q==
X-Google-Smtp-Source: ABdhPJweLCOTqgxRsr6fReb5cE2vSxD13wn4cre57JcmVHOo6GOTFctC232b6MtUXgs7qLylYyUx+w==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr16937592wrt.183.1603716665336;
        Mon, 26 Oct 2020 05:51:05 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id r1sm24423262wro.18.2020.10.26.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:51:04 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 0/5] fuse: Add support for passthrough read/write
Date:   Mon, 26 Oct 2020 12:50:11 +0000
Message-Id: <20201026125016.1905945-1-balsini@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 10th version of the series. Please find the changelog at the
bottom of this cover letter.

Add support for file system passthrough read/write of files when enabled in
userspace through the option FUSE_PASSTHROUGH.

There are file systems based on FUSE that are intended to enforce special
policies or trigger complicated decision makings at the file operations
level. Android, for example, uses FUSE to enforce fine-grained access
policies that also depend on the file contents.
Sometimes it happens that at open or create time a file is identified as
not requiring additional checks for consequent reads/writes, thus FUSE
would simply act as a passive bridge between the process accessing the FUSE
file system and the lower file system. Splicing and caching help reduce the
FUSE overhead, but there are still read/write operations forwarded to the
userspace FUSE daemon that could be avoided.

This series has been inspired by the original patches from Nikhilesh Reddy,
the idea and code of which has been elaborated and improved thanks to the
community support.

When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may decide
while handling the open/create operations, if the given file can be
accessed in passthrough mode. This means that all the further read and
write operations would be forwarded by the kernel directly to the lower
file system using the VFS layer rather than to the FUSE daemon.
All the requests other than reads or writes are still handled by the
userspace FUSE daemon.
This allows for improved performance on reads and writes, especially in the
case of reads at random offsets, for which no (readahead) caching mechanism
would help.
Benchmarks show improved performance that is close to native file system
access when doing massive manipulations on a single opened file, especially
in the case of random reads, for which the bandwidth increased by almost 2X
or sequential writes for which the improvement is close to 3X.

The creation of this direct connection (passthrough) between FUSE file
objects and file objects in the lower file system happens in a way that
reminds of passing file descriptors via sockets:
- a process requests the opening of a file handled by FUSE, so the kernel
  forwards the request to the FUSE daemon;
- the FUSE daemon opens the target file in the lower file system, getting
  its file descriptor;
- the FUSE daemon also decides according to its internal policies if
  passthrough can be enabled for that file, and, if so, can perform a
  FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() on /dev/fuse, passing the file
  descriptor obtained at the previous step and the fuse_req unique
  identifier;
- the kernel translates the file descriptor to the file pointer navigating
  through the opened files of the "current" process and temporarily stores
  it in the associated open/create fuse_req's passthrough_filp;
- when the FUSE daemon has done with the request and it's time for the
  kernel to close it, it checks if the passthrough_filp is available and in
  case updates the additional field in the fuse_file owned by the process
  accessing the FUSE file system.
From now on, all the read/write operations performed by that process will
be redirected to the corresponding lower file system file by creating new
VFS requests.
Since the read/write operation to the lower file system is executed with
the current process's credentials, it might happen that it does not have
enough privileges to succeed. For this reason, the process temporarily
receives the same credentials as the FUSE daemon, that are reverted as soon
as the read/write operation completes, emulating the behavior of the
request to be performed by the FUSE daemon itself. This solution has been
inspired by the way overlayfs handles read/write operations.
Asynchronous IO is supported as well, handled by creating separate AIO
requests for the lower file system that will be internally tracked by FUSE,
that intercepts and propagates their completion through an internal
ki_completed callback similar to the current implementation of overlayfs.
The ioctl() has been designed taking as a reference and trying to converge
to the fuse2 implementation. For example, the fuse_passthrough_out data
structure has extra fields that will allow for further extensions of the
feature.


    Performance on SSD

What follows has been performed with this change [V6] rebased on top of
vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
enables pass-through for each file that is opened during both "open" and
"create". Tests were run on an Intel Xeon E5-2678V3, 32GiB of RAM, with an
ext4-formatted SSD as the lower file system, with no special tuning, e.g.,
all the involved processes are SCHED_OTHER, ondemand is the frequency
governor with no frequency restrictions, and turbo-boost, as well as
p-state, are active. This is because I noticed that, for such high-level
benchmarks, results consistency was minimally affected by these features.
The source code of the updated libfuse library and passthrough_hp is shared
at the following repository:

    https://github.com/balsini/libfuse/tree/fuse-passthrough-stable-v.3.9.4

Two different kinds of benchmarks were done for this change, the first set
of tests evaluates the bandwidth improvements when manipulating a huge
single file, the second set of tests verify that no performance regressions
were introduced when handling many small files.

The first benchmarks were done by running FIO (fio-3.21) with:
- bs=4Ki;
- file size: 50Gi;
- ioengine: sync;
- fsync_on_close: true.
The target file has been chosen large enough to avoid it to be entirely
loaded into the page cache.
Results are presented in the following table:

+-----------+--------+-------------+--------+
| Bandwidth |  FUSE  |     FUSE    |  Bind  |
|  (KiB/s)  |        | passthrough |  mount |
+-----------+--------+-------------+--------+
| read      | 468897 |      502085 | 516830 |
+-----------+--------+-------------+--------+
| randread  |  15773 |       26632 |  21386 |
+-----------+--------+-------------+--------+
| write     |  58185 |      141272 | 141671 |
+-----------+--------+-------------+--------+
| randwrite |  59892 |       75236 |  76486 |
+-----------+--------+-------------+--------+

The higher FUSE passthrough performance compared to bind mount in the case
of randread has been identified as the result or SSD performance
fluctuations when dealing with random offsets. Updated results are reported
below, with the measurements performed on a lower file system created on
top of a RAM block device.

As long as this patch has the primary objective of improving bandwidth,
another set of tests has been performed to see how this behaves on a
totally different scenario that involves accessing many small files. For
this purpose, measuring the build time of the Linux kernel has been chosen
as a well-known workload. The kernel has been built with as many processes
as the number of logical CPUs (-j $(nproc)), that besides being a
reasonable number, is also enough to saturate the processor’s utilization
thanks to the additional FUSE daemon’s threads, making it even harder to
get closer to the native file system performance.
The following table shows the total build times in the different
configurations:

+------------------+--------------+-----------+
|                  | AVG duration |  Standard |
|                  |     (sec)    | deviation |
+------------------+--------------+-----------+
| FUSE             |      144.566 |     0.697 |
+------------------+--------------+-----------+
| FUSE passthrough |      133.820 |     0.341 |
+------------------+--------------+-----------+
| Raw              |      109.423 |     0.724 |
+------------------+--------------+-----------+

Similar performance measurements were performed with the current version of
the patch, the results of which are comparable with what is shown above.


    Performance on RAM block device

Getting rid of the discrete storage device removes a huge component of
slowness, highlighting the performance difference of the software parts
(and probably goodness of CPU cache and its coherence/invalidation
mechanisms).
What follows has been performed with this change [V10] rebased on top of
vanilla v5.8 Linux kernel.

More specifically, out of my system's 32 GiB of RAM, I reserved 24 for
/dev/ram0, which has been formatted as ext4. That file system has been
completely filled and then cleaned up before running the benchmarks to make
sure all the memory addresses were marked as used and removed from the page
cache.

The following tests were ran using fio-3.23 with the following
configuration:
- bs=4Ki
- size=20Gi
- ioengine=sync
- fsync_on_close=1
- randseed=0
- create_only=0 (set to 1 during a first dry run to create the test
  file)

As for the tool configuration, the following benchmarks would perform a
single open operation each, focusing on just the read/write performance.

The file size of 20 GiB has been chosen to not completely fit the page
cache.

As mentioned in my previous email, all the caches were dropped before
running every benchmark with

  echo 3 > /proc/sys/vm/drop_caches

All the benchmarks were run 10 times, with 1 minute cool down between each
run.

Here the updated results for this patch set:

+-----------+-------------+-------------+-------------+
|           |             | FUSE        |             |
| MiB/s     | FUSE        | passthrough | native      |
+-----------+-------------+-------------+-------------+
| read      | 1341(±4.2%) | 1485(±1.1%) |  1634(±.5%) |
+-----------+-------------+-------------+-------------+
| write     |   49(±2.1%) | 1304(±2.6%) | 1363(±3.0%) |
+-----------+-------------+-------------+-------------+
| randread  |   43(±1.3%) | 643(±11.1%) |  715(±1.1%) |
+-----------+-------------+-------------+-------------+
| randwrite |  27(±39.9%) |  763(±1.1%) |  790(±1.0%) |
+-----------+-------------+-------------+-------------+

This table shows that FUSE, except for the sequential reads, is left behind
FUSE passthrough and native performance. The extremely good FUSE
performance for sequential reads is the result of a great read-ahead
mechanism, that has been easy to prove by showing that performance dropped
after setting read_ahead_kb to 0.
Except for FUSE randwrite and passthrough randread with respectively ~40%
and ~11% standard deviations, all the other results are relatively stable.
Nevertheless, these two standard deviation exceptions are not sufficient to
invalidate the results, which are still showing clear performance benefits.
I'm also kind of happy to see that passthrough, that for each read/write
operation traverses the VFS layer twice, now maintains consistent slightly
lower performance than native.

Further testing and performance evaluations are welcome.


    Description of the series

Patch 1 introduces the data structures and function signatures required
both for the communication with userspace and for the internal kernel use.

Patch 2 introduces the ioctl() and initialization and release functions for
FUSE passthrough.

Patch 3 enables the synchronous read and write operations for those FUSE
files for which the passthrough functionality is enabled.

Patch 4 extends the read and write operations to also support asynchronous
IO.

Patch 5 allows FUSE passthrough to target files for which the requesting
process would not have direct access to, by temporarily performing a
credentials switch to the credentials of the FUSE daemon that issued the
FUSE passthrough ioctl().


    Changelog

Changes in v10:
* UAPI updated: ioctl() now returns an ID that will be used at
  open/create response time to reference the passthrough file
* Synchronous read/write_iter functions does not return silly errors (fixed
  in aio patch)
* FUSE daemon credentials updated at ioctl() time instead of mount time
* Updated benchmark results with RAM block device
  [Requested by Miklos Szeredi]

Changes in v9:
* Switched to using VFS instead of direct lower FS file ops
  [Attempt to address a request from Jens Axboe, Jann Horn, Amir
Goldstein]
* Removal of useless included aio.h header
  [Proposed by Jens Axboe]

Changes in v8:
* aio requests now use kmalloc/kfree, instead of kmem_cache
* Switched to call_{read,write}_iter in AIO
* Revisited attributes copy
* Passthrough can only be enabled via ioctl(), fixing the security issue
  spotted by Jann
* Use an extensible fuse_passthrough_out data structure
  [Attempt to address a request from Nikolaus Rath, Amir Goldstein and
  Miklos Szeredi]

Changes in v7:
* Full handling of aio requests as done in overlayfs (update commit
* message).
* s/fget_raw/fget.
* Open fails in case of passthrough errors, emitting warning messages.
  [Proposed by Jann Horn]
* Create new local kiocb, getting rid of the previously proposed ki_filp
* swapping.
  [Proposed by Jann Horn and Jens Axboe]
* Code polishing.

Changes in v6:
* Port to kernel v5.8:
  * fuse_file_{read,write}_iter() changed since the v5 of this patch was
  * proposed.
* Simplify fuse_simple_request().
* Merge fuse_passthrough.h into fuse_i.h
* Refactor of passthrough.c:
  * Remove BUG_ON()s.
  * Simplified error checking and request arguments indexing.
  * Use call_{read,write}_iter() utility functions.
  * Remove get_file() and fputs() during read/write: handle the extra
  * FUSE references to the lower file object when the fuse_file is
  * created/deleted.
  [Proposed by Jann Horn]

Changes in v5:
* Fix the check when setting the passthrough file.
  [Found when testing by Mike Shal]

Changes in v3 and v4:
* Use the fs_stack_depth to prevent further stacking and a minor fix.
  [Proposed by Jann Horn]

Changes in v2:
* Changed the feature name to passthrough from stacked_io.
  [Proposed by Linus Torvalds]


Alessio Balsini (5):
  fuse: Definitions and ioctl() for passthrough
  fuse: Passthrough initialization and release
  fuse: Introduce synchronous read and write for passthrough
  fuse: Handle asynchronous read and write in passthrough
  fuse: Use daemon creds in passthrough mode

 fs/fuse/Makefile          |   1 +
 fs/fuse/dev.c             |  40 +++++--
 fs/fuse/dir.c             |   1 +
 fs/fuse/file.c            |  12 +-
 fs/fuse/fuse_i.h          |  31 +++++
 fs/fuse/inode.c           |  23 +++-
 fs/fuse/passthrough.c     | 245 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  13 +-
 8 files changed, 349 insertions(+), 17 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

-- 
2.29.0.rc1.297.gfa9743e501-goog

