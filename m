Return-Path: <linux-fsdevel+bounces-17214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4798A90C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 03:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E5A1C21B89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 01:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE14481A7;
	Thu, 18 Apr 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSoUtPdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2663A267;
	Thu, 18 Apr 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404367; cv=none; b=UeWoV9Kh05Paq9TILbHefLJdH9ss6Xo4EeMFW1Iov3gAnvQjF2IzDPqA+x8bWSAXS6V4egvX3n/h+nUkeasxeVIuI3wVP44mT1BaYImKXB34tCUptMSSUBih3ExqNZgSUT85eHjdKjvUyV5ePmMtt3Eg6/375WJrqILwaTjGKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404367; c=relaxed/simple;
	bh=f2Dq5guPuEqsQiTvFbgl4H4Q2lmEymOK0U/6BUFRhag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkObwh54dT8G3m7jMwtAmDgMh+o+7riMbGK8W00rdQ6gqgRn6SyORYablH4PFSZIaXzUxbZ94KsTtmuK7W+XPcr5r0d74wNM/8vTtkGHfWE/z8T6+/A99q5sfnnmUdRrdvLu1A6i9zmfRbg6laewkX91Z1LM0x2mWI/QUXtutHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XSoUtPdh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nPQW+PhTfzyYpqrNWwtHYFjE/ppW5K9b7LVALH2CUbw=; b=XSoUtPdhF00S40gBsQwATN/3XT
	CnvglDPefCM2L3t0WX4necLIz5bEyMigX6zqeLM0zda4jE9nRkB8K/dtIFwikK+eGnCF0zT8t29kO
	Mw+VgiqxvX+U2gmvFHIAIJr7nFTZcClJ/dgJ5cNLEiQJ3QYPa0D1AgDk51uHA0rS5G1cXCCXe2ywm
	p2x2bhS0+CeddI3Ivo5uE/oWlTFOGyPU9hPZEkPnPkcsLCAv+ZOxPrhKCHZKZb3Sdc7f+/soUvuNx
	CSRRY/+clV4HihWR5oBpOzc3Iq4QGLDxijsyq48FQWIfDCqzVUT1NRA2YPfB7SRMtTuCv6ctsiawl
	le7qMwMw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxGkB-00000004Ejb-3VEf;
	Thu, 18 Apr 2024 01:39:20 +0000
Date: Thu, 18 Apr 2024 02:39:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, kdevops@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, david@redhat.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <ZiB5x-EKrmb1ZPuf@casper.infradead.org>
References: <20240418001356.95857-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418001356.95857-1-mcgrof@kernel.org>

On Wed, Apr 17, 2024 at 05:13:56PM -0700, Luis Chamberlain wrote:
> Running compaction while we run fsstress can crash older kernels as per
> korg#218227 [0], the fix for that [0] has been posted [1] but that patch
> is not yet on v6.9-rc4 and the patch requires changes for v6.9.

It doesn't require changes, it just has prerequisites:

https://lore.kernel.org/all/ZgHhcojXc9QjynUI@casper.infradead.org/

> Today I find that v6.9-rc4 is also hitting an unrecoverable hung task
> between compaction and fsstress while running generic/476 on the
> following kdevops test sections [2]:
> 
>   * xfs_nocrc
>   * xfs_nocrc_2k
>   * xfs_nocrc_4k
> 
> Analyzing the trace I see the guest uses loopback block devices for the
> fstests TEST_DEV, the loopback file uses sparsefiles on a btrfs
> partition. The contention based on traces [3] [4] seems to be that we
> have somehow have fsstress + compaction race on folio_wait_bit_common().

What do you mean by "race"?  Here's what I see:

Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kcompactd0:72 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:kcompactd0      state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00004000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  __schedule+0x3d9/0xaf0
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  schedule+0x26/0xf0
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  io_schedule+0x42/0x70
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  folio_wait_bit_common+0x123/0x370
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  ? __pfx_wake_page_function+0x10/0x10
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  migrate_pages_batch+0x69a/0xd70

But you didn't run the backtrace through scripts/decode_stacktrace.sh
so I can't figure out what we're waiting on.

> We have this happening:
> 
>   a) kthread compaction --> migrate_pages_batch()
>                 --> folio_wait_bit_common()
>   b) workqueue on btrfs writeback wb_workfn  --> extent_write_cache_pages()
>                 --> folio_wait_bit_common()
>   c) workqueue on loopback loop_rootcg_workfn() --> filemap_fdatawrite_wbc()
>                 --> folio_wait_bit_common()
>   d) kthread xfsaild --> blk_mq_submit_bio() --> wbt_wait()
> 
> I tried to reproduce but couldn't easily do so, so I wrote this test
> to help, and with this I have 100% failure rate so far out of 2 runs.
> 
> Given we also have korg#218227 and that patch likely needing
> backporting, folks will want a reproducer for this issue. This should
> hopefully help with that case and this new separate issue.
> 
> To reproduce with kdevops just:
> 
> make defconfig-xfs_nocrc_2k  -j $(nproc)
> make -j $(nproc)
> make fstests
> make linux
> make fstests-baseline TESTS=generic/733
> tail -f guestfs/*-xfs-nocrc-2k/console.log
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=218227
> [1] https://lore.kernel.org/all/7ee2bb8c-441a-418b-ba3a-d305f69d31c8@suse.cz/T/#u
> [2] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/xfs/xfs.config
> [3] https://gist.github.com/mcgrof/4dfa3264f513ce6ca398414326cfab84
> [4] https://gist.github.com/mcgrof/f40a9f31a43793dac928ce287cfacfeb
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Note: kdevops uses its own fork of fstests which has this merged
> already, so the above should just work. If it's your first time using
> kdevops be sure to just read the README for the first time users:
> 
> https://github.com/linux-kdevops/kdevops/blob/main/docs/kdevops-first-run.md
> 
>  common/rc             |  7 ++++++
>  tests/generic/744     | 56 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/744.out |  2 ++
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/generic/744
>  create mode 100644 tests/generic/744.out
> 
> diff --git a/common/rc b/common/rc
> index b7b77ac1b46d..d4432f5ce259 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -120,6 +120,13 @@ _require_hugepages()
>  		_notrun "Kernel does not report huge page size"
>  }
>  
> +# Requires CONFIG_COMPACTION
> +_require_compaction()
> +{
> +	if [ ! -f /proc/sys/vm/compact_memory ]; then
> +	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
> +	fi
> +}
>  # Get hugepagesize in bytes
>  _get_hugepagesize()
>  {
> diff --git a/tests/generic/744 b/tests/generic/744
> new file mode 100755
> index 000000000000..2b3c0c7e92fb
> --- /dev/null
> +++ b/tests/generic/744
> @@ -0,0 +1,56 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
> +#
> +# FS QA Test 744
> +#
> +# fsstress + compaction test
> +#
> +. ./common/preamble
> +_begin_fstest auto rw long_rw stress soak smoketest
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +}
> +
> +# Import common functions.
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +
> +_require_scratch
> +_require_compaction
> +_require_command "$KILLALL_PROG" "killall"
> +
> +echo "Silence is golden."
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +nr_cpus=$((LOAD_FACTOR * 4))
> +nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
> +fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
> +
> +# start a background getxattr loop for the existing xattr
> +runfile="$tmp.getfattr"
> +touch $runfile
> +while [ -e $runfile ]; do
> +	echo 1 > /proc/sys/vm/compact_memory
> +	sleep 15
> +done &
> +getfattr_pid=$!
> +
> +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> +
> +$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +
> +rm -f $runfile
> +wait > /dev/null 2>&1
> +
> +status=0
> +exit
> diff --git a/tests/generic/744.out b/tests/generic/744.out
> new file mode 100644
> index 000000000000..205c684fa995
> --- /dev/null
> +++ b/tests/generic/744.out
> @@ -0,0 +1,2 @@
> +QA output created by 744
> +Silence is golden
> -- 
> 2.43.0
> 

