Return-Path: <linux-fsdevel+bounces-21443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E33903F13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4212847B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280511717;
	Tue, 11 Jun 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsWzJ9dP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8D1109;
	Tue, 11 Jun 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117104; cv=none; b=i67dRERNqAjW+PCpjBRmy+M+U4194luYmDJpT4PY8ZWw18OVnxj+p0jDAX8HXswDqVFmvIv/nKiCmV2RaaDRueO1gFOR8XrJ0gxG1DPleC7fQKgUNbQyocnxX6yyRUbcXxjlaQEj9fi4nCG/oVUX7MgLE0N+fUXK3R/N+5SOwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117104; c=relaxed/simple;
	bh=/qy27D9TdU90zlrZxsGplfXoqcvHs7I9DYvfbjjLYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGsURPdLkF8u+0RlUzP3u8IauBLDsBEdOQqfL701DMiTGNMb9TI60R4NJ79Fino4+6dFjSbmXagpKB05M+Y8uvVWjvaA1f9ZeBv1pbfI1P16N5mXyHG5srCRILPPejS8LV87JH6vazc7EXQCOL9LiflMQ5bjPiIwsF00lQS+O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsWzJ9dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BE2C2BD10;
	Tue, 11 Jun 2024 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718117103;
	bh=/qy27D9TdU90zlrZxsGplfXoqcvHs7I9DYvfbjjLYMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsWzJ9dPmMw+/B24v3ppf4gZGMLRXx777bAh41V8/1KSDEI89CcpY3rt8hzNPc29m
	 Cwph+hpLhU9IBl+laVqCCm26pQ5R+Ybq9LSmnIesVqtR1Zlsq/ipClRR1LJ/4GmLdx
	 0uHXt0SLE6to5uCBrYVT7dYY+ZtPzbSNMaBjERf8mbqJ2Pqc4z5wtxfFcjcgRmLf6Z
	 XQsIb4DTQUSA5BHQQvfH3s7ygw+cQ2PGourE47hLwTef67A3siBwLDxMbg5GJiGi3U
	 DjbkayV/a8qqtBaatR93bdeQacbtTa0NytzcRnV5BQY/lPnyj0xz7AusdAmgB6yHxy
	 4ikI2aCD3xqDg==
Date: Tue, 11 Jun 2024 07:45:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 5/5] fstests: add stress truncation + writeback test
Message-ID: <20240611144503.GI52977@frogsfrogsfrogs>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-6-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-6-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:02:02PM -0700, Luis Chamberlain wrote:
> Stress test folio splits by using the new debugfs interface to a target
> a new smaller folio order while triggering writeback at the same time.
> 
> This is known to only creates a crash with min order enabled, so for example
> with a 16k block sized XFS test profile, an xarray fix for that is merged
> already. This issue is fixed by kernel commit 2a0774c2886d ("XArray: set the
> marks correctly when splitting an entry").
> 
> If inspecting more closely, you'll want to enable on your kernel boot:
> 
> 	dyndbg='file mm/huge_memory.c +p'
> 
> Since we want to race large folio splits we also augment the full test
> output log $seqres.full with the test specific number of successful
> splits from vmstat thp_split_page and thp_split_page_failed. The larger
> the vmstat thp_split_page the more we stress test this path.
> 
> This test reproduces a really hard to reproduce crash immediately.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/rc             |  14 +++++
>  tests/generic/751     | 127 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/751.out |   2 +
>  3 files changed, 143 insertions(+)
>  create mode 100755 tests/generic/751
>  create mode 100644 tests/generic/751.out
> 
> diff --git a/common/rc b/common/rc
> index 30beef4e5c02..60f572108818 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -158,6 +158,20 @@ _require_vm_compaction()
>  	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
>  	fi
>  }
> +
> +# Requires CONFIG_DEBUGFS and truncation knobs
> +_require_split_debugfs()

Er... I thought "split" referred to debugfs itself.

_require_split_huge_pages_knob?

> +{
> +       if [ ! -f $DEBUGFS_MNT/split_huge_pages ]; then
> +           _notrun "Needs CONFIG_DEBUGFS and split_huge_pages"
> +       fi
> +}
> +
> +_split_huge_pages_all()
> +{
> +	echo 1 > $DEBUGFS_MNT/split_huge_pages
> +}
> +
>  # Get hugepagesize in bytes
>  _get_hugepagesize()
>  {
> diff --git a/tests/generic/751 b/tests/generic/751
> new file mode 100755
> index 000000000000..7cc96054a5a9
> --- /dev/null
> +++ b/tests/generic/751
> @@ -0,0 +1,127 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Luis Chamberlain. All Rights Reserved.
> +#
> +# FS QA Test No. 751
> +#
> +# stress page cache truncation + writeback
> +#
> +# This aims at trying to reproduce a difficult to reproduce bug found with
> +# min order. The issue was root caused to an xarray bug when we split folios
> +# to another order other than 0. This functionality is used to support min
> +# order. The crash:
> +#
> +# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df

You might want to paste the stacktrace in here directly, in case the
gist ever goes away.

> +#
> +# This may also find future truncation bugs in the future, as truncating any
> +# mapped file through the collateral of using echo 1 > split_huge_pages will
> +# always respect the min order. Truncating to a larger order then is excercised
> +# when this test is run against any filesystem LBS profile or an LBS device.
> +#
> +# If you're enabling this and want to check underneath the hood you may want to
> +# enable:
> +#
> +# dyndbg='file mm/huge_memory.c +p'
> +#
> +# This tests aims at increasing the rate of successful truncations so we want
> +# to increase the value of thp_split_page in $seqres.full. Using echo 1 >
> +# split_huge_pages is extremely aggressive, and even accounts for anonymous
> +# memory on a system, however we accept that tradeoff for the efficiency of
> +# doing the work in-kernel for any mapped file too. Our general goal here is to
> +# race with folio truncation + writeback.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto long_rw stress soak smoketest
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $runfile
> +	kill -9 $split_huge_pages_files_pid > /dev/null 2>&1
> +}
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_scratch
> +_require_debugfs
> +_require_split_debugfs
> +_require_command "$KILLALL_PROG" "killall"
> +_fixed_by_git_commit kernel 2a0774c2886d \
> +	"XArray: set the marks correctly when splitting an entry"
> +
> +# we need buffered IO to force truncation races with writeback in the
> +# page cache
> +cat >$fio_config <<EOF
> +[force_large_large_folio_parallel_writes]
> +nrfiles=10
> +direct=0
> +bs=4M
> +group_reporting=1
> +filesize=1GiB
> +readwrite=write
> +fallocate=none
> +numjobs=$(nproc)
> +directory=$SCRATCH_MNT
> +runtime=100*${TIME_FACTOR}
> +time_based
> +EOF
> +
> +_require_fio $fio_config
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +# used to let our loops know when to stop
> +runfile="$tmp.keep.running.loop"
> +touch $runfile
> +
> +# The background ops are out of bounds, the goal is to race with fsstress.
> +
> +# Force folio split if possible, this seems to be screaming for MADV_NOHUGEPAGE
> +# for large folios.
> +while [ -e $runfile ]; do
> +	_split_huge_pages_all >/dev/null 2>&1
> +done &
> +split_huge_pages_files_pid=$!
> +
> +split_count_before=0
> +split_count_failed_before=0
> +
> +if grep -q thp_split_page /proc/vmstat; then
> +	split_count_before=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
> +	split_count_failed_before=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')
> +else
> +	echo "no thp_split_page in /proc/vmstat" >> $seqres.full
> +fi
> +
> +# we blast away with large writes to force large folio writes when
> +# possible.
> +echo -e "Running fio with config:\n" >> $seqres.full
> +cat $fio_config >> $seqres.full
> +$FIO_PROG $fio_config --alloc-size=$(( $(nproc) * 8192 )) --output=$fio_out
> +
> +rm -f $runfile
> +
> +wait > /dev/null 2>&1
> +
> +if grep -q thp_split_page /proc/vmstat; then
> +	split_count_after=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
> +	split_count_failed_after=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')

I think this ought to be a separate function for cleanliness?

_proc_vmstat()
{
	awk -v name="$1" '{if ($1 ~ name) {print($2)}}' /proc/vmstat
}

	split_count_after=$(_proc_vmstat thp_split_page)

Otherwise this test looks fine to me.

--D

> +	thp_split_page=$((split_count_after - split_count_before))
> +	thp_split_page_failed=$((split_count_failed_after - split_count_failed_before))
> +
> +	echo "vmstat thp_split_page: $thp_split_page" >> $seqres.full
> +	echo "vmstat thp_split_page_failed: $thp_split_page_failed" >> $seqres.full
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/751.out b/tests/generic/751.out
> new file mode 100644
> index 000000000000..6479fa6f1404
> --- /dev/null
> +++ b/tests/generic/751.out
> @@ -0,0 +1,2 @@
> +QA output created by 751
> +Silence is golden
> -- 
> 2.43.0
> 
> 

