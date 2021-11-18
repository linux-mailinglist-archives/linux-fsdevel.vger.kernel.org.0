Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7033745626E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhKRSe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhKRSez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:34:55 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF8C061574;
        Thu, 18 Nov 2021 10:31:55 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v23so9260414iom.12;
        Thu, 18 Nov 2021 10:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X5kdlgxyKQjZxWgr8j3kEcDooSHoUxzoEfAhGMLjm4s=;
        b=TZpIsx5RuDkTi7Z9aZKkTIlbrBib39VCtCLo8mua+mZdQZiWDMSKwJfEgL5yyJLP3F
         yb4Hk9tnfVfedpmeXuN1FHDiZyGpNFCsmRK0R2zzKSI73L6KQIhp8Iv7vfmrekECxhiG
         smudR61M67ZzjQKTG/cGG6dQxuUKMCZwWepmzkpcGJxa4awnyyLdCQliUah4/MFCJMq2
         CWk1BEr9dXuA19eZtDOf3zQvrr6tgYyXF3P+vAL1Oh52SNq1ThISlYjxiFyEAwobX3Dp
         013UorujSFVIjq+TD9NGQl1+Oq7zf26KCt1/YpALMsUO+yZ97NPuDWkD4/N8InnMjEWK
         Ul/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X5kdlgxyKQjZxWgr8j3kEcDooSHoUxzoEfAhGMLjm4s=;
        b=jbCsjcEYu7yaNN6/4SX6n17LUMegh40QdZkbCJcy0fclYVimJtc0f8Se7MkGmPiYbT
         r72UgdDrEDnwjxdVxVpcx6w0Ag/73yvX0YJPrGEM5FDmEipLH5ZzdEhn62M+S1ZjW+Y5
         EERjxzXhVB/TeWYo0m4ktRZYp983VdvJ0o91jJECidZn3GCgHB6Cc7c/3Jg9ZcTOls1N
         snVKzp6Fr14q+7Jby9elxeo8JlVtu81UNAl8l2xr3/TZNCfRq6vi89jarOJ9I0KqrH1D
         xm2bytAwXCPxAGEry/kDRqwCfqR+4McanlB8fda/a4Ut3UvQ6sSLTANS9658JPee24f0
         /ILw==
X-Gm-Message-State: AOAM532bGAzZCJ8PyqeQtACqNpQygN8rXEiuLxsLWUuf29oQF84Q5Ib2
        LHuicVYkXhvDUi7zE+5qpYsiip2zNqqUaQddp9o=
X-Google-Smtp-Source: ABdhPJw6nr1Wyo5eWsHZYG1r1ufgD4HhjXQaK50nazGzp9PXq45/+TVF/TCBxfj5NTjSa5oNjxalh8rxF+/APEgZrn0=
X-Received: by 2002:a05:6638:2105:: with SMTP id n5mr22623322jaj.32.1637260314578;
 Thu, 18 Nov 2021 10:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com>
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Nov 2021 20:31:43 +0200
Message-ID: <CAOQ4uxiXgzfLN704TKK4eu2=3b4RuCKBAfp3PAx=tuT31zeEsw@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 0/8] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:31 PM Alessio Balsini <balsini@android.com> wrote=
:
>
> This is the 12th version of the series, rebased on top of v5.11-rc5.
> Please find the changelog at the bottom of this cover letter.
>
> Add support for file system passthrough read/write of files when enabled
> in userspace through the option FUSE_PASSTHROUGH.
>
> There are file systems based on FUSE that are intended to enforce
> special policies or trigger complicated decision makings at the file
> operations level. Android, for example, uses FUSE to enforce
> fine-grained access policies that also depend on the file contents.
> Sometimes it happens that at open or create time a file is identified as
> not requiring additional checks for consequent reads/writes, thus FUSE
> would simply act as a passive bridge between the process accessing the
> FUSE file system and the lower file system. Splicing and caching help
> reduce the FUSE overhead, but there are still read/write operations
> forwarded to the userspace FUSE daemon that could be avoided.
>
> This series has been inspired by the original patches from Nikhilesh
> Reddy, the idea and code of which has been elaborated and improved
> thanks to the community support.
>
> When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may
> decide while handling the open/create operations, if the given file can
> be accessed in passthrough mode. This means that all the further read
> and write operations would be forwarded by the kernel directly to the
> lower file system using the VFS layer rather than to the FUSE daemon.
> All the requests other than reads or writes are still handled by the
> userspace FUSE daemon.
> This allows for improved performance on reads and writes, especially in
> the case of reads at random offsets, for which no (readahead) caching
> mechanism would help.
> Benchmarks show improved performance that is close to native file system
> access when doing massive manipulations on a single opened file,
> especially in the case of random reads, random writes and sequential
> writes. Detailed benchmarking results are presented below.
>
> The creation of this direct connection (passthrough) between FUSE file
> objects and file objects in the lower file system happens in a way that
> reminds of passing file descriptors via sockets:
> - a process requests the opening of a file handled by FUSE, so the
>   kernel forwards the request to the FUSE daemon;
> - the FUSE daemon opens the target file in the lower file system,
>   getting its file descriptor;
> - the FUSE daemon also decides according to its internal policies if
>   passthrough can be enabled for that file, and, if so, can perform a
>   FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl on /dev/fuse, passing the file
>   descriptor obtained at the previous step and the fuse_req unique
>   identifier;
> - the kernel translates the file descriptor to the file pointer
>   navigating through the opened files of the "current" process and
>   temporarily stores it in the associated open/create fuse_req's
>   passthrough_filp;
> - when the FUSE daemon has done with the request and it's time for the
>   kernel to close it, it checks if the passthrough_filp is available and
> in case updates the additional field in the fuse_file owned by the
> process accessing the FUSE file system.
> From now on, all the read/write operations performed by that process
> will be redirected to the corresponding lower file system file by
> creating new VFS requests.
> Since the read/write operation to the lower file system is executed with
> the current process's credentials, it might happen that it does not have
> enough privileges to succeed. For this reason, the process temporarily
> receives the same credentials as the FUSE daemon, that are reverted as
> soon as the read/write operation completes, emulating the behavior of
> the request to be performed by the FUSE daemon itself. This solution has
> been inspired by the way overlayfs handles read/write operations.
> Asynchronous IO is supported as well, handled by creating separate AIO
> requests for the lower file system that will be internally tracked by
> FUSE, that intercepts and propagates their completion through an
> internal ki_completed callback similar to the current implementation of
> overlayfs.
> Finally, also memory-mapped FUSE files are supported in this FUSE
> passthrough series as it has been noticed that when a same file with
> FUSE passthrough enabled is accessed both with standard
> read/write(-iter) operations and memory-mapped read/write operations,
> the file content might result corrupted due to an inconsistency between
> the FUSE and lower file system caches.
>
> The ioctl has been designed taking as a reference and trying to converge
> to the fuse2 implementation. For example, the fuse_passthrough_out data
> structure has extra fields that will allow for further extensions of the
> feature.
>
>
>     Performance on RAM block device
>
> What follows has been performed using a custom passthrough_hp FUSE
> daemon that enables pass-through for each file that is opened during
> both "open" and "create". Benchmarks were run on an Intel Xeon W-2135,
> 64 GiB of RAM workstation, with a RAM block device used as storage
> target. More specifically, out of the system's 64 GiB of RAM, 40 GiB
> were reserved for /dev/ram0, formatted as ext4. For the FUSE and FUSE
> passthrough benchmarks, the FUSE file system was mounted on top of the
> mounted /dev/ram0 device.
> That file system has been completely filled and then cleaned up before
> running the benchmarks: this to ensure that all the /dev/ram0 space was
> reserved and not usable as page cache.
>
> The rationale for using a RAM block device is that SSDs may experience
> performance fluctuations, especially when dealing with accessing data
> random offsets.
> Getting rid of the discrete storage device also removes a huge component
> of slowness, highlighting the performance difference of the software
> parts (and probably the goodness of CPU caching and its coherence
> mechanisms).
>
> No special tuning has been performed, e.g., all the involved processes
> are SCHED_OTHER, ondemand is the frequency governor with no frequency
> restrictions, and turbo-boost, as well as p-state, are active. This is
> because I noticed that, for such high-level benchmarks, results
> consistency was minimally affected by these features.
>
> The source code of the updated libfuse library and passthrough_hp is
> shared at the following repository:
>
>   https://github.com/balsini/libfuse/tree/fuse-passthrough-v12-v5.11-rc5
>
> Two different kinds of benchmarks were done for this change, the first
> set of tests evaluates the bandwidth improvements when manipulating huge
> single files, the second set of tests verify that no performance
> regressions were introduced when handling many small files.
>
> All the caches were dropped before running every benchmark with:
>
>   echo 3 > /proc/sys/vm/drop_caches
>
> All the benchmarks were run 10 times, with 1 minute cool down between
> each run.
>
> The first benchmarks were done by running FIO (fio-3.24) with:
> - bs=3D4Ki;
> - file size: 35Gi;
> - ioengine: sync;
> - fsync_on_close=3D1;
> - randseed=3D0.
> The target file has been chosen large enough to avoid it to be entirely
> loaded into the page cache.
>
> Results are presented in the following table:
>
> +-----------+------------+-------------+-------------+
> |   MiB/s   |    fuse    | passthrough |   native    |
> +-----------+------------+-------------+-------------+
> | read      | 471(=C2=B11.3%) | 1791(=C2=B11.0%) | 1839(=C2=B11.8%) |
> | write     | 95(=C2=B1.6%)   | 1068(=C2=B1.9%)  | 1322(=C2=B1.8%)  |
> | randread  | 25(=C2=B11.7%)  | 860(=C2=B1.8%)   | 1135(=C2=B1.5%)  |
> | randwrite | 76(=C2=B13.0%)  | 813(=C2=B11.0%)  | 1005(=C2=B1.7%)  |
> +-----------+------------+-------------+-------------+
>
> This table shows that FUSE, except for the sequential reads, is far
> behind FUSE passthrough and native in terms of performance. The
> extremely good FUSE performance for sequential reads is the result of a
> great read-ahead mechanism. I was able to verify that setting
> read_ahead_kb to 0 causes a terrible performance drop.
> All the results are stable, as shown by the standard deviations.
> Moreover, these numbers show the reasonable gap between passthrough and
> native, introduced by the extra traversal through the VFS layer.
>
> As long as this patch has the primary objective of improving bandwidth,
> another set of tests has been performed to see how this behaves on a
> totally different scenario that involves accessing many small files. For
> this purpose, measuring the build time of the Linux kernel has been
> chosen as an appropriate, well-known, workload. The kernel has been
> built with as many processes as the number of logical CPUs (-j
> $(nproc)), that besides being a reasonable parallelization value, is
> also enough to saturate the processor's utilization thanks to the
> additional FUSE daemon's threads, making it even harder to get closer to
> the native file system performance.
> The following table shows the total build times in the different
> configurations:
>
> +------------------+--------------+-----------+
> |                  | AVG duration |  Standard |
> |                  |     (sec)    | deviation |
> +------------------+--------------+-----------+
> | FUSE             |      144.566 |     0.697 |
> +------------------+--------------+-----------+
> | FUSE passthrough |      133.820 |     0.341 |
> +------------------+--------------+-----------+
> | Native           |      109.423 |     0.724 |
> +------------------+--------------+-----------+
>
> Further testing and performance evaluations are welcome.
>
>
>     Description of the series
>
> Patch 1 generalizes the function which converts iocb flags to rw flags
> from overlayfs, so that can be used in this patch set.
>
> Patch 2 enables the 32-bit compatibility for the /dev/fuse ioctl.
>
> Patch 3 introduces the data structures, function signatures and ioctl
> required both for the communication with userspace and for the internal
> kernel use.
>
> Patch 4 introduces initialization and release functions for FUSE
> passthrough.
>
> Patch 5 enables the synchronous read and write operations for those FUSE
> files for which the passthrough functionality is enabled.
>
> Patch 6 extends the read and write operations to also support
> asynchronous IO.
>
> Patch 7 allows FUSE passthrough to target files for which the requesting
> process would not have direct access to, by temporarily performing a
> credentials switch to the credentials of the FUSE daemon that issued the
> FUSE passthrough ioctl.
>
> Patch 8 extends FUSE passthrough operations to memory-mapped FUSE files.
>
>
>     Changelog
>
> Changes in v12:
> * Revert FILESYSTEM_MAX_STACK_DEPTH checks as they were in v10
>   [Requested by Amir Goldstein]
> * Introduce passthrough support for memory-mapped FUSE files
>   [Requested by yanwu]
>
> Changes in v11:
> * Fix the FILESYSTEM_MAX_STACK_DEPTH check to allow other file systems
>   to be stacked
> * Moved file system stacking depth check at ioctl time
> * Update cover letter with correct libfuse repository to test the change
>   [Requested by Peng Tao]
> * Fix the file reference counter leak introduced in v10
>   [Requested by yanwu]
>
> Changes in v10:
> * UAPI updated: ioctl now returns an ID that will be used at open/create
>   response time to reference the passthrough file
> * Synchronous read/write_iter functions does not return silly errors
>   (fixed in aio patch)
> * FUSE daemon credentials updated at ioctl time instead of mount time
> * Updated benchmark results
>   [Requested by Miklos Szeredi]
>
> Changes in v9:
> * Switched to using VFS instead of direct lower FS file ops
>   [Attempt to address a request from Jens Axboe, Jann Horn,
>   Amir Goldstein]
> * Removal of useless included aio.h header
>   [Proposed by Jens Axboe]
>
> Changes in v8:
> * aio requests now use kmalloc/kfree, instead of kmem_cache
> * Switched to call_{read,write}_iter in AIO
> * Revisited attributes copy
> * Passthrough can only be enabled via ioctl, fixing the security issue
>   spotted by Jann
> * Use an extensible fuse_passthrough_out data structure
>   [Attempt to address a request from Nikolaus Rath, Amir Goldstein and
> Miklos Szeredi]
>
> Changes in v7:
> * Full handling of aio requests as done in overlayfs (update commit
> * message).
> * s/fget_raw/fget.
> * Open fails in case of passthrough errors, emitting warning messages.
>   [Proposed by Jann Horn]
> * Create new local kiocb, getting rid of the previously proposed ki_filp
>   swapping.
>   [Proposed by Jann Horn and Jens Axboe]
> * Code polishing.
>
> Changes in v6:
> * Port to kernel v5.8:
>   * fuse_file_{read,write}_iter changed since the v5 of this patch was
>     proposed.
> * Simplify fuse_simple_request.
> * Merge fuse_passthrough.h into fuse_i.h
> * Refactor of passthrough.c:
>   * Remove BUG_ONs.
>   * Simplified error checking and request arguments indexing.
>   * Use call_{read,write}_iter utility functions.
>   * Remove get_file and fputs during read/write: handle the extra FUSE
>     references to the lower file object when the fuse_file is
>     created/deleted.
>   [Proposed by Jann Horn]
>
> Changes in v5:
> * Fix the check when setting the passthrough file.
>   [Found when testing by Mike Shal]
>
> Changes in v3 and v4:
> * Use the fs_stack_depth to prevent further stacking and a minor fix.
>   [Proposed by Jann Horn]
>
> Changes in v2:
> * Changed the feature name to passthrough from stacked_io.
>   [Proposed by Linus Torvalds]
>
>
> Alessio Balsini (8):
>   fs: Generic function to convert iocb to rw flags
>   fuse: 32-bit user space ioctl compat for fuse device
>   fuse: Definitions and ioctl for passthrough
>   fuse: Passthrough initialization and release
>   fuse: Introduce synchronous read and write for passthrough
>   fuse: Handle asynchronous read and write in passthrough
>   fuse: Use daemon creds in passthrough mode
>   fuse: Introduce passthrough for mmap
>
>  fs/fuse/Makefile          |   1 +
>  fs/fuse/dev.c             |  41 ++++--
>  fs/fuse/dir.c             |   2 +
>  fs/fuse/file.c            |  15 +-
>  fs/fuse/fuse_i.h          |  33 +++++
>  fs/fuse/inode.c           |  22 ++-
>  fs/fuse/passthrough.c     | 280 ++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/file.c       |  23 +---
>  include/linux/fs.h        |   5 +
>  include/uapi/linux/fuse.h |  14 +-
>  10 files changed, 401 insertions(+), 35 deletions(-)
>  create mode 100644 fs/fuse/passthrough.c
>
> --
> 2.30.0.280.ga3ce27912f-goog
>

Hi Alessio,

I have been testing this patch set for a while and recently
nfstest_posix found one issue:
mtime/ctime are not invalidated on passthrough write.

I have tested a fix on this 5.10.y backport branch:
https://github.com/amir73il/linux/commits/linux-5.10.y-fuse-passthrough

Please feel free to review and/or take the fix for your next posting
if you have plans of posting another version...

Thanks,
Amir.
