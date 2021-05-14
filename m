Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F71380805
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhENLFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 07:05:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhENLFJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 07:05:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1F01AF4F;
        Fri, 14 May 2021 11:03:56 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 255d9ad2;
        Fri, 14 May 2021 11:05:31 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [vfs]  94a4dd06a6: xfstests.generic.263.fail
References: <20210513135644.GE20142@xsang-OptiPlex-9020>
Date:   Fri, 14 May 2021 12:05:31 +0100
In-Reply-To: <20210513135644.GE20142@xsang-OptiPlex-9020> (kernel test robot's
        message of "Thu, 13 May 2021 21:56:44 +0800")
Message-ID: <877dk1zibo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 94a4dd06a6bbf3978b0bb1dddc2d8ec4e5bcad26 ("[PATCH v9] vfs: fix copy_file_range regression in cross-fs copies")
> url: https://github.com/0day-ci/linux/commits/Luis-Henriques/vfs-fix-copy_file_range-regression-in-cross-fs-copies/20210510-170804
> base: https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git for-next
>
> in testcase: xfstests
> version: xfstests-x86_64-73c0871-1_20210401
> with following parameters:
>
> 	disk: 4HDD
> 	fs: xfs
> 	test: generic-group-13
> 	ucode: 0x21
>
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
> 2021-05-11 11:28:23 export TEST_DIR=/fs/sda1
> 2021-05-11 11:28:23 export TEST_DEV=/dev/sda1
> 2021-05-11 11:28:23 export FSTYP=xfs
> 2021-05-11 11:28:23 export SCRATCH_MNT=/fs/scratch
> 2021-05-11 11:28:23 mkdir /fs/scratch -p
> 2021-05-11 11:28:23 export SCRATCH_DEV=/dev/sda4
> 2021-05-11 11:28:23 export SCRATCH_LOGDEV=/dev/sda2
> 2021-05-11 11:28:23 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-13
> 2021-05-11 11:28:23 ./check generic/260 generic/261 generic/262 generic/263 generic/264 generic/265 generic/266 generic/267 generic/268 generic/269 generic/270 generic/271 generic/272 generic/273 generic/274 generic/275 generic/276 generic/277 generic/278 generic/279
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 lkp-ivb-d02 5.12.0-rc6-00061-g94a4dd06a6bb #1 SMP Tue May 11 00:58:17 CST 2021
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda4
> MOUNT_OPTIONS -- /dev/sda4 /fs/scratch
>
> generic/260	[not run] FITRIM not supported on /fs/scratch
> generic/261	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/262	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/263	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/263.out.bad)
>     --- tests/generic/263.out	2021-04-01 03:07:08.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/263.out.bad	2021-05-11 11:28:29.773460096 +0000
>     @@ -1,3 +1,32 @@
>      QA output created by 263
>      fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
>     -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
>     +Seed set to 1
>     +main: filesystem does not support clone range, disabling!
>     +main: filesystem does not support dedupe range, disabling!
>     +skipping zero size read
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/263.out /lkp/benchmarks/xfstests/results//generic/263.out.bad'  to see the entire diff)
> generic/264	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/265	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/266	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/267	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/268	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/269	 48s
> generic/270	 61s
> generic/271	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/272	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/273	 17s
> generic/274	 14s
> generic/275	 11s
> generic/276	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/277	 3s
> generic/278	[not run] Reflink not supported by scratch filesystem type: xfs
> generic/279	[not run] Reflink not supported by scratch filesystem type: xfs
> Ran: generic/260 generic/261 generic/262 generic/263 generic/264 generic/265 generic/266 generic/267 generic/268 generic/269 generic/270 generic/271 generic/272 generic/273 generic/274 generic/275 generic/276 generic/277 generic/278 generic/279
> Not run: generic/260 generic/261 generic/262 generic/264 generic/265 generic/266 generic/267 generic/268 generic/271 generic/272 generic/276 generic/278 generic/279
> Failures: generic/263
> Failed 1 of 20 tests

OK, I see what's going on.  There are 2 issues: one with patch and another
one with the test itself.

The CFR syscall should have been disabled in this test but it isn't
because the test tries to copy 1 byte from a zero-sized file:

int
test_copy_range(void)
{
	loff_t o1 = 0, o2 = 1;

	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) == -1 &&
	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
		if (!quiet)
			fprintf(stderr,
				"main: filesystem does not support "
				"copy range, disabling!\n");
		return 0;
	}

	return 1;
}

The syscall is doing an early '0' return because the file size is < len.

Fixing the kernel should probably be as easy as removing the
short-circuiting check in vfs_copy_file_range():

	if (len == 0)
		return 0;

This will force the filesystems code to handle '0' size copies but will
also make sure -EOPNOTSUPP is returned in this case.

Alternatively, we could have something like:

	if (len == 0) {
		if (file_out->f_op->copy_file_range)
			return 0;
		else
			return -EOPNOTSUPP;
	}

What do you guys think is the right thing to do?

Additionally, the test should also be fixed with something as the patch
bellow.  By making sure we have 1 byte to copy we also ensure the syscall
will return -EOPNOTSUPP, even with the current version of the patch.

Cheers,
-- 
Luis

diff --git a/ltp/fsx.c b/ltp/fsx.c
index cd0bae55aeb8..97db594ae142 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1596,6 +1596,10 @@ int
 test_copy_range(void)
 {
 	loff_t o1 = 0, o2 = 1;
+	int ret = 1;
+
+	/* Make sure we have 1 byte to copy */
+	ftruncate(fd, 1);
 
 	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) == -1 &&
 	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
@@ -1603,10 +1607,13 @@ test_copy_range(void)
 			fprintf(stderr,
 				"main: filesystem does not support "
 				"copy range, disabling!\n");
-		return 0;
+		ret = 0;
 	}
 
-	return 1;
+	/* Restore file size */
+	ftruncate(fd, 0);
+
+	return ret;
 }
 
 void
