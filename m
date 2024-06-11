Return-Path: <linux-fsdevel+bounces-21444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E5903F21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92121F245F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0812B89;
	Tue, 11 Jun 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbegQu1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8368111A1;
	Tue, 11 Jun 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117296; cv=none; b=ZvWDig5og29S+htKNuoDob257SE3MsFI7TxNcpVSHx4tkXUj1SrGexrhL9xUSQb2mwWUcDqetPxfDTjayO7fo1/r6ecr1AxiTeCYqUSYZbhtD/wNivMJygJJiilsYE4f5XGxe9Xnlea3Gjbhkex43qbWdHhRGHeIW81Hte09xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117296; c=relaxed/simple;
	bh=tSXLhE5A82AHcFb1qYX6yXouGrFwwmpKyD2aNdbGHFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjJrnO/2Ym1mkco5wU/inkB/hKsrUJtUOsoo2TXsp5x0INzk13BX9q2TIdZCRabe9QiuL+WGV+EfqZGayPA/nuJztBXm2y0kfAJUH3ac+ecu/NqhbJEGYjyl8QsGbLza0IMntlVxqnUjeX6OIa/Ax7saCioSUO9zPK1Fek125WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbegQu1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3840CC2BD10;
	Tue, 11 Jun 2024 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718117296;
	bh=tSXLhE5A82AHcFb1qYX6yXouGrFwwmpKyD2aNdbGHFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbegQu1IyCSdxxTgJxE8Tvgx00EkdJzoV2KkT7n7a+ibty13ulDI+4grnMt5b5Nyh
	 ujcQL3T9REjvw4gMDqSRSfl1DkDw2ZyVTglUrJPQTnEhpCufdgggwbdUe+h4K447L9
	 z9kCAJT9/ogX4VwumaT2wdYNrWjkpzLlFF81AWdDuM6JyeHF42S9BBh6b1UgQY487V
	 ykT+q4mGatOfl3FmUCY2nlPHxKqOQFe+o26/E1JnT7x0yHPDM67v0SlPfEwWrwFKIF
	 YgBVVsPOUWRCrvYrL7ZThJjmpb9p7vTjUQ2bIglNhPysjc5ooOWPHj/2ZtC6rpCRxd
	 v9ZC4t0Qf6FpA==
Date: Tue, 11 Jun 2024 07:48:15 -0700
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
Subject: Re: [PATCH 3/5] fstests: add fsstress + compaction test
Message-ID: <20240611144815.GJ52977@frogsfrogsfrogs>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-4-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:02:00PM -0700, Luis Chamberlain wrote:
> Running compaction while we run fsstress can crash older kernels as per
> korg#218227 [0], the fix for that [0] has been posted [1] that patch
> was merged on v6.9-rc6 fixed by commit d99e3140a4d3 ("mm: turn
> folio_test_hugetlb into a PageType"). However even on v6.10-rc2 where
> this kernel commit is already merged we can still deadlock when running
> fsstress and at the same time triggering compaction, this is a new
> issue being reported now this through patch, but this patch also
> serves as a reproducer with a high confidence. It always deadlocks.
> If you enable CONFIG_PROVE_LOCKING with the defaults you will end up
> with a complaint about increasing MAX_LOCKDEP_CHAIN_HLOCKS [1], if
> you adjust that you then end up with a few soft lockup complaints and
> some possible deadlock candidates to evaluate [2].
> 
> Provide a simple reproducer and pave the way so we keep on testing this.
> 
> Without lockdep enabled we silently deadlock on the first run of the
> test without the fix applied. With lockdep enabled you get a splat about
> the possible deadlock on the first run of the test.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=218227
> [1] https://gist.github.com/mcgrof/824913b645892214effeb1631df75072
> [2] https://gist.github.com/mcgrof/926e183d21c5c4c55d74ec90197bd77a
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/rc             |  7 +++++
>  tests/generic/750     | 62 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/750.out |  2 ++
>  3 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/750
>  create mode 100644 tests/generic/750.out
> 
> diff --git a/common/rc b/common/rc
> index e812a2f7cc67..18ad25662d5c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -151,6 +151,13 @@ _require_hugepages()
>  		_notrun "Kernel does not report huge page size"
>  }
>  
> +# Requires CONFIG_COMPACTION
> +_require_vm_compaction()
> +{
> +	if [ ! -f /proc/sys/vm/compact_memory ]; then
> +	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
> +	fi
> +}
>  # Get hugepagesize in bytes
>  _get_hugepagesize()
>  {
> diff --git a/tests/generic/750 b/tests/generic/750
> new file mode 100755
> index 000000000000..334ab011dfa0
> --- /dev/null
> +++ b/tests/generic/750
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
> +#
> +# FS QA Test 750
> +#
> +# fsstress + memory compaction test
> +#
> +. ./common/preamble
> +_begin_fstest auto rw long_rw stress soak smoketest
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $runfile
> +	rm -f $tmp.*
> +	kill -9 $trigger_compaction_pid > /dev/null 2>&1
> +	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +
> +	wait > /dev/null 2>&1
> +}
> +
> +# Import common functions.
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +
> +_require_scratch
> +_require_vm_compaction
> +_require_command "$KILLALL_PROG" "killall"
> +
> +# We still deadlock with this test on v6.10-rc2, we need more work.
> +# but the below makes things better.
> +_fixed_by_git_commit kernel d99e3140a4d3 \
> +	"mm: turn folio_test_hugetlb into a PageType"
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +nr_cpus=$((LOAD_FACTOR * 4))
> +nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
> +fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
> +
> +# start a background trigger for memory compaction
> +runfile="$tmp.compaction"
> +touch $runfile
> +while [ -e $runfile ]; do
> +	echo 1 > /proc/sys/vm/compact_memory
> +	sleep 5
> +done &
> +trigger_compaction_pid=$!
> +
> +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")

Maybe put this with the other fsstress_args definition above, but
otherwise this looks reasonable.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
> +$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +wait > /dev/null 2>&1
> +
> +status=0
> +exit
> diff --git a/tests/generic/750.out b/tests/generic/750.out
> new file mode 100644
> index 000000000000..bd79507b632e
> --- /dev/null
> +++ b/tests/generic/750.out
> @@ -0,0 +1,2 @@
> +QA output created by 750
> +Silence is golden
> -- 
> 2.43.0
> 
> 

