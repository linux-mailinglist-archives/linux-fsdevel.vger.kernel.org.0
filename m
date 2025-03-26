Return-Path: <linux-fsdevel+bounces-45108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCFA72083
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5E63B4A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA6261362;
	Wed, 26 Mar 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ogzrCv+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E849659
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023453; cv=none; b=W6631BeCix1V10sHgbEqhmcqQKes/ISH6dBh0Zj/1tQctb2PtErPcLvQTh0wC7nRKiFozm/DCwkgDbj6ZOPYb/B0PMRVhIURkihHV277EdIZvqnmWO84DLXGyGW6IXNanvC33yZFWMWLp1Qb4hj8cVDZF4NrJPt01VmSmHKuBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023453; c=relaxed/simple;
	bh=KtFDJQf3LCeM6WKs6szT70ZPm1vK4ET1jMCs1JH8pQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV14EEcJysFG+sSGZ0fXgqs9e5RjL7A8lKvrVNmZmU4O4Q1KlnRaOiGoj/q1sbrsL/U0ZmL8JIP4+62W8qL3TJ5TT7zwfnXbqJdN1c9GR0EELQc0ndzs/b+p5H9ieeFCXULuLWfeT1hRO2qDlE9P/VgWr7d8WrrqxFx5/eDhPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ogzrCv+q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3014678689aso391096a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743023451; x=1743628251; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8r5zblQElbPQO87GHLZRnHgdEdr+1fSpbnjgQJ9+CIo=;
        b=ogzrCv+qfm/PcZgE13fUY5r088fSh+RcKSDWV9KaGM2XFshVVazTy0bPJu8RXfseo6
         qc756fEwntfK1Z/1qAe9XgYBgbkQCzsiVgi1ZrmTBDG5gbCZkumKYGj3FIQPJ/RWxI//
         KAepLxognxE3oszgrf1aRB6gT4T2VFYkEtDa0nKy9ivVIqxB2Ae7LhE3Zsj9EdzVxHyH
         j9evHWiC+jQB5oGqBBYQnSDV1VqRffol5I3dE+Mao2YbEnPq2W8iykrPLKg/F7AbaEF7
         Go4jumkLtt5guKYd5IurQfhUaO9SdxLkPRzQlC262tXO0DY6ic5z2EJrZ74XEZIjnvyv
         Atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023451; x=1743628251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r5zblQElbPQO87GHLZRnHgdEdr+1fSpbnjgQJ9+CIo=;
        b=I65z8tVbkCGuMfzIb6BLgnwNGp4aWs2enJu33ZPAB1Ku0Anci6adKpofzTkM8i86cr
         GSZa/NMnuREzEwni01sVLY8XcyuiEkle0ynnhmkeQVrIlJsznhlQn2qowFCoN5qVsUCM
         DpreKUbCVDzWIAvQNvdinIT/M0MCFA22TaCx2Z4xKiaKHH2HOP9uL4GJjHPiaXtIKYc8
         ICqPlI8qECfitK/jWd2DglNMDVLvDiMkXTx9DYlrYszGhN6SPKBi1OGmboJGprxQZbCE
         rEjBnM/ZFXm9m5CXeE8V1cDa1ygl8q5VL6hGbzQeQPYQzFisVltsv53AM4zZmV8zujyy
         v0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Z27IFD2SwJJKDoJwg1TJx9RWNbed/OimkOL6fGglUskkORKKMGWKYq+mvkL3p2fmXR1eEaVMIWOvPr2N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HssOX+ahSvlIJ0LYMRnQ287tja+9Ld63FQ1JWGK2KYaj9Qdt
	kqjl6suxFrIhjKuG+r7RuV+aL6rQesWbKEYD3Cmpu0XcgUwOwrTu1Q9lPeiRNNA=
X-Gm-Gg: ASbGnctAqlGxXjFhPFjnbRzc9egUBNdT5QtsiKnNMMwClFYwClGR4Ph6K5yP0i5WDrw
	6y1Ewy7Az758p1NAn2i/j2MCFG+UyFIeTPH9xDS7o9oKGY+iXH0EKiRrtN33FBhjLZSQ35tedfS
	tnkQjxJ/RSLOhST7Ywgxk+n6BQGahZnRY9f3LbesYJZNVSLHqCu19lTuQtGBXXcrHDhUJ76+WH5
	qk6tETOGKcczszmIrleqqMzw1qTtuXRW6EQHduDn9x3dqjxGqt72KrbCAY9qRFo53CP58tLNTMf
	RF6XsvJswVJUN8SeI40+fa74Q96MCzlNoFEm8dYohh7oooss8gUe21c14x5fSX3X5SYX6uy4TAA
	PLS/Fxfo=
X-Google-Smtp-Source: AGHT+IH74ag5XeN4ls7BanUgMSLHcrsUvl+HEw2fiukQfAGjZxR0vReelBylQGQRPmjYWqz5PrQAvw==
X-Received: by 2002:a17:90a:d2cb:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-303a815a72cmr2059828a91.17.1743023450937;
        Wed, 26 Mar 2025 14:10:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2ae1sm114999645ad.114.2025.03.26.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:10:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txY1P-00000000h3J-1N9l;
	Thu, 27 Mar 2025 08:10:47 +1100
Date: Thu, 27 Mar 2025 08:10:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	jack@suse.cz, apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: Re: [PATCH] generic/764: fsstress + migrate_pages() test
Message-ID: <Z-RtV6OO_IhggLvT@dread.disaster.area>
References: <20250326185101.2237319-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326185101.2237319-1-mcgrof@kernel.org>

On Wed, Mar 26, 2025 at 11:50:55AM -0700, Luis Chamberlain wrote:
> 0-day reported a page migration kernel warning with folios which happen
> to be buffer-heads [0]. I'm having a terribly hard time reproducing the bug
> and so I wrote this test to force page migration filesystems.
> 
> It turns out we have have no tests for page migration on fstests or ltp,
> and its no surprise, other than compaction covered by generic/750 there
> is no easy way to trigger page migration right now unless you have a
> numa system.
> 
> We should evaluate if we want to help stress test page migration
> artificially by later implementing a way to do page migration on simple
> systems to an artificial target.
> 
> So far, this doesn't trigger any kernel splats, not even warnings for me.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/config         |  2 +
>  common/rc             |  8 ++++
>  tests/generic/764     | 94 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/764.out |  2 +
>  4 files changed, 106 insertions(+)
>  create mode 100755 tests/generic/764
>  create mode 100644 tests/generic/764.out
> 
> diff --git a/common/config b/common/config
> index 2afbda141746..93b50f113b44 100644
> --- a/common/config
> +++ b/common/config
> @@ -239,6 +239,8 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>  export PARTED_PROG="$(type -P parted)"
>  export XFS_PROPERTY_PROG="$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
> +export NUMACTL_PROG="$(type -P numactl)"
> +export MIGRATEPAGES_PROG="$(type -P migratepages)"
>  
>  # udev wait functions.
>  #
> diff --git a/common/rc b/common/rc
> index e51686389a78..ed9613a9bf28 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -281,6 +281,14 @@ _require_vm_compaction()
>  	fi
>  }
>  
> +_require_numa_nodes()
> +{
> +	readarray -t QUEUE < <($NUMACTL_PROG --show | awk '/^membind:/ {for (i=2; i<=NF; i++) print $i}')

sed makes this easier: remove the membind token, then remove all the
lines that have ":"s left in them. This leaves behind the membind
node string.

$ numactl --show | sed -e 's/membind://' -e '/:/d'
 0 1 2 3
$

Also should have:

	_require_command "$NUMACTL_PROG" "numactl"

built into it, rather than requiring the test to declare it first.

> +	if (( ${#QUEUE[@]} < 2 )); then
> +		_notrun "You need a system with at least two numa nodes to run this test"
> +	fi
> +}



> +
>  # Requires CONFIG_DEBUGFS and truncation knobs
>  _require_split_huge_pages_knob()
>  {
> diff --git a/tests/generic/764 b/tests/generic/764
> new file mode 100755
> index 000000000000..91d9fb7e08da
> --- /dev/null
> +++ b/tests/generic/764
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
> +#
> +# FS QA Test 764
> +#
> +# fsstress + migrate_pages() test
> +#
> +. ./common/preamble
> +_begin_fstest auto rw long_rw stress soak smoketest
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $runfile
> +	rm -f $tmp.*
> +	kill -9 $run_migration_pid > /dev/null 2>&1
> +	kill -9 $stress_pid > /dev/null 2>&1
> +
> +	wait > /dev/null 2>&1
> +}

If you implement this using the fsstress wrappers like I mention
below, and get rid of running the main migration loop in background,
this cleanup function can go away completely.

> +
> +_require_scratch
> +_require_command "$NUMACTL_PROG" "numactl"
> +_require_command "$MIGRATEPAGES_PROG" "migratepages"
> +_require_numa_nodes
> +
> +readarray -t QUEUE < <($NUMACTL_PROG --show | awk '/^membind:/ {for (i=2; i<=NF; i++) print $i}')
> +if (( ${#QUEUE[@]} < 2 )); then
> +	echo "Not enough NUMA nodes to pick two different ones."
> +	exit 1
> +fi

You've implemented this twice.

> +echo "Silence is golden"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +nr_cpus=$((LOAD_FACTOR * 4))
> +nr_ops=$((25000 * nr_cpus * TIME_FACTOR))

Don't scale ops with nr_cpus - you've already scaled processes
with nr_cpus.

> +fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
> +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> +
> +runfile="$tmp.migratepages"
> +pidfile="$tmp.stress.pid"
> +
> +run_stress_fs()
> +{
> +	$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" &
> +	stress_pid=$!
> +	echo $stress_pid > $pidfile
> +	wait $stress_pid
> +	rm -f $runfile
> +	rm -f $pidfile
> +}

Don't reimplement _run_fsstress(), call it instead.

> +
> +run_stress_fs &

Actually, you want _run_fsstress_bg() here, and then
_kill_fsstress() when you want it to die.

> +touch $runfile
> +stress_pid=$(cat $pidfile)

Don't need either of these.

> +
> +while [ -e $runfile ]; do

while [ -n "_FSSTRESS_PID" ]; do


> +	readarray -t QUEUE < <(numactl --show | awk '/^membind:/ {for (i=2; i<=NF; i++) print $i}')

Third time this is implemented.

> +	# Proper Fisher–Yates shuffle
> +	for ((i=${#QUEUE[@]} - 1; i > 0; i--)); do
> +		j=$((RANDOM % (i + 1)))
> +		var=${QUEUE[i]}
> +		QUEUE[i]=${QUEUE[j]}
> +		QUEUE[j]=$var
> +	done
> +
> +	RANDOM_NODE_1=${QUEUE[0]}
> +	RANDOM_NODE_2=${QUEUE[1]}

If all you are doing is picking two random nodes, then you could
just use RANDOM for the array index and drop the whole shuffle
thing, yes?

> +	if [[ -f $pidfile ]]; then

no need for this if we gate the loop on _FSSTRESS_PID

> +		echo "migrating parent fsstress process:" >> $seqres.full
> +		echo -en "\t$MIGRATEPAGES_PROG $pid $RANDOM_NODE_1 $RANDOM_NODE_2 ..." >> $seqres.full
> +		$MIGRATEPAGES_PROG $stress_pid $RANDOM_NODE_1 $RANDOM_NODE_2
> +		echo " $?" >> $seqres.full
> +		echo "migrating child fsstress processes ..." >> $seqres.full
> +		for pid in $(ps --ppid "$stress_pid" -o pid=); do
> +			echo -en "\tmigratepages $pid $RANDOM_NODE_1 $RANDOM_NODE_2 ..." >> $seqres.full
> +			$MIGRATEPAGES_PROG $pid $RANDOM_NODE_1 $RANDOM_NODE_2
> +			echo " $?" >> $seqres.full
> +		done
> +	fi
> +	sleep 2
> +done &
> +run_migration_pid=$!

why is this put in the background, only to then wait on it to
complete? The loop will stop when fsstress finishes, yes?
Which means this doesn't need to be run in the background at all,
and then cleanup doesn't need to handle killing this, either.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

