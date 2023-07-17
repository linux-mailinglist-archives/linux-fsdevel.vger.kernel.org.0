Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B399756815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGQPfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGQPfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C1D2;
        Mon, 17 Jul 2023 08:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 024C46112A;
        Mon, 17 Jul 2023 15:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58512C433C7;
        Mon, 17 Jul 2023 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689608148;
        bh=OTE3Yj1rIX4BsOLrGr4YUl2FnlRjBnMZxri0EarD2rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzMYIW0nSgwZGSriZmni1WvSjwfCS5bRI/ukiY46sND/OHg0n/N059QS5oC2sd6lg
         Tf6x20dYPsxqlgt4t9d54sy/0hXNl+wkAZmCUix8VdPh12QmskigYJxCYGQc1Yq8Z0
         z3PNZF4Z2PbuGi7h9QEsD/1+rFaFI7Di34cst40pT2LEIMY44bYRBbCKI8R4DLav5k
         uei2BV5WCSr7kdRLUThcYs/l1/tFFh2fVy1JODJ542+PB9AUsE/iLBJzyMwAlgv3Qv
         TAVfaQEQMv7FUEaAt8UUExHrazDDu9ymP+pyCmLhpgkUAVzXj3kmzhVrwQ/pIq0K2A
         rJF/uRK2Im88g==
Date:   Mon, 17 Jul 2023 08:35:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [fstests PATCH] generic: add a test for multigrain timestamps
Message-ID: <20230717153547.GC11340@frogsfrogsfrogs>
References: <20230713230939.367068-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713230939.367068-1-jlayton@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:09:39PM -0400, Jeff Layton wrote:
> Ensure that the mtime and ctime apparently change, even when there are
> multiple writes in quick succession. Older kernels didn't do this, but
> there are patches in flight that should help ensure it in the future.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  src/Makefile          |   2 +-
>  src/mgctime.c         | 107 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/730     |  25 ++++++++++
>  tests/generic/730.out |   1 +
>  4 files changed, 134 insertions(+), 1 deletion(-)
>  create mode 100644 src/mgctime.c
>  create mode 100755 tests/generic/730
>  create mode 100644 tests/generic/730.out
> 
> This patchset is intended to test the new multigrain timestamp feature:
> 
>     https://lore.kernel.org/linux-fsdevel/20230713-mgctime-v5-0-9eb795d2ae37@kernel.org/T/#t
> 
> I had originally attempted to write this as a shell script, but it was
> too slow, which made it falsely pass on unpatched kernels.
> 
> All current filesystems will fail this, so we may want to wait until
> we are closer to merging the kernel series.

I wonder, /should/ there be a way to declare to userspace that small
writes in rapid succession are supposed to result in separately
observable mtimestamps?

That might be hard to define generally -- what happens if the filesystem
doesn't support nanosecond precision, e.g. fat?  Or if the system
doesn't have any clocks with better precision than jiffies?  The
expected minimum timestamp change granularity could be exported too, but
that's even more complexity... :(

Thoughts?

> diff --git a/src/Makefile b/src/Makefile
> index 24cd47479140..aff7d07466f0 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl
> +	uuid_ioctl mgctime
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py
> diff --git a/src/mgctime.c b/src/mgctime.c
> new file mode 100644
> index 000000000000..38e22a8613ff
> --- /dev/null
> +++ b/src/mgctime.c
> @@ -0,0 +1,107 @@
> +/*

Needs a SPDX header, I think.

The C program itself looks ok though.

--D

> + * Older Linux kernels always use coarse-grained timestamps, with a
> + * resolution of around 1 jiffy. Writes that are done in quick succession
> + * on those kernels apparent change to the ctime or mtime.
> + *
> + * Newer kernels attempt to ensure that fine-grained timestamps are used
> + * when the mtime or ctime are queried from userland.
> + *
> + * Open a file and do a 1 byte write to it and then statx the mtime and ctime.
> + * Do that in a loop 1000 times and ensure that the value is different from
> + * the last.
> + *
> + * Copyright (c) 2023: Jeff Layton <jlayton@kernel.org>
> + */
> +#define _GNU_SOURCE 1
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <getopt.h>
> +#include <stdbool.h>
> +
> +#define NUM_WRITES 1000
> +
> +static int64_t statx_ts_cmp(struct statx_timestamp *ts1, struct statx_timestamp *ts2)
> +{
> +	int64_t ret = ts2->tv_sec - ts1->tv_sec;
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = ts2->tv_nsec;
> +	ret -= ts1->tv_nsec;
> +
> +	return ret;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret, fd, i;
> +	struct statx stx = { };
> +	struct statx_timestamp ctime, mtime;
> +	bool verbose = false;
> +
> +	while ((i = getopt(argc, argv, "v")) != -1) {
> +		switch (i) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		}
> +	}
> +
> +	if (argc < 2) {
> +		errno = -EINVAL;
> +		perror("usage");
> +	}
> +
> +	fd = open(argv[1], O_WRONLY|O_CREAT|O_TRUNC, 0644);
> +	if (fd < 0) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
> +	if (ret < 0) {
> +		perror("stat");
> +		return 1;
> +	}
> +
> +	ctime = stx.stx_ctime;
> +	mtime = stx.stx_mtime;
> +
> +	for (i = 0; i < NUM_WRITES; ++i) {
> +		ssize_t written;
> +
> +		written = write(fd, "a", 1);
> +		if (written < 0) {
> +			perror("write");
> +			return 1;
> +		}
> +
> +		ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
> +		if (ret < 0) {
> +			perror("stat");
> +			return 1;
> +		}
> +
> +		if (verbose)
> +			printf("%d: %llu.%u\n", i, stx.stx_ctime.tv_sec, stx.stx_ctime.tv_nsec);
> +
> +		if (!statx_ts_cmp(&ctime, &stx.stx_ctime)) {
> +			printf("Duplicate ctime after write!\n");
> +			return 1;
> +		}
> +
> +		if (!statx_ts_cmp(&mtime, &stx.stx_mtime)) {
> +			printf("Duplicate mtime after write!\n");
> +			return 1;
> +		}
> +
> +		ctime = stx.stx_ctime;
> +		mtime = stx.stx_mtime;
> +	}
> +	return 0;
> +}
> diff --git a/tests/generic/730 b/tests/generic/730
> new file mode 100755
> index 000000000000..c3f24aeb8534
> --- /dev/null
> +++ b/tests/generic/730
> @@ -0,0 +1,25 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023, Jeff Layton <jlayton@redhat.com>
> +#
> +# FS QA Test No. 730
> +#
> +# Multigrain time test
> +#
> +# Open a file, and do 1 byte writes to it, and statx the file for
> +# the ctime and mtime after each write. Ensure that they have changed
> +# since the previous write.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Override the default cleanup function.
> +_require_test_program mgctime
> +
> +testfile="$TEST_DIR/test_mgtime_file.$$"
> +
> +$here/src/mgctime $testfile
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/730.out b/tests/generic/730.out
> new file mode 100644
> index 000000000000..5dbea532d60f
> --- /dev/null
> +++ b/tests/generic/730.out
> @@ -0,0 +1 @@
> +QA output created by 730
> -- 
> 2.41.0
> 
