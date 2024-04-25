Return-Path: <linux-fsdevel+bounces-17712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D58B1A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797D21C21046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCA3BBE2;
	Thu, 25 Apr 2024 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ausYRNjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE942B9C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023425; cv=none; b=aVN2LqVQPWPWUNyqQa3g2hjeEqYNl147rqsmfJsX9j3j3/kUroOa836k3W+5DkWNR4xDMvpxc1xMtnU3RGlcUSFmy19KhRdd3ZtFxPwjOrXDIINuf3WtyrDvr0hS0zc7Pt0d+uAPtxijIxJ1/wDQrgYldezPy1rN6H2ZhYBzyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023425; c=relaxed/simple;
	bh=7zEfJIiF3FivC8A8nCfn1uyLMo6vziSgrYc4tCU5fE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DibX7BALO2w/6Qp8zAOOiBZRiFxYbMm70oIo2nSlSB3GlbJ8F7GQ3rchiTr+tVePUu8au86Da1nz3FBXLctnzvm78Piv5db1DYUtHqoaMVyIsQ2DpFWEyWj07NzlaC+8wZL7fsSvo9p6Ewwu8c8ARPzcUxGUnXYqli35GCpBF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ausYRNjG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714023422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXt+za/0JniFUhxuXePW/X/JHM72efTXKoPa8YCXUF0=;
	b=ausYRNjGGwkbaQnZKWhEy+z1OiX6axl5S3RZxrGyaY25u8VHwcvpVu5a59E+8mBcvEhEUH
	xLpxtMMiwRkHYFXsWZyQlZCphdrmIrz22YlIYbW4OSV/uTdh16StL/Rx+SexB6m2VetKOS
	FBXvhzmMCFQ8xgeS3Ju9i4jDvE31Dss=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-KBNVjjQEOs2aY3DC7xYSkg-1; Thu, 25 Apr 2024 01:37:01 -0400
X-MC-Unique: KBNVjjQEOs2aY3DC7xYSkg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6eb86b1deb1so854242a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 22:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023116; x=1714627916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXt+za/0JniFUhxuXePW/X/JHM72efTXKoPa8YCXUF0=;
        b=P20R75lqOrBH2DLbSMPb2ZZ5u1FVo+Ul7gIHzd9bEzjgvG2UwvG9bmkwqoIwu8CP5K
         FKi/e0tjA0fXIM59Glj3qs5MvRmXax+/CglGX+dYX4ZFIGYsgrkAUtXjh8X6UdQPTci1
         xHXJ5+A7kP0kJJG+Y/SS2BQhDbHVu+pouolZPRaJIpnWkGwnsyIjfDDp58+B/9nvFhPo
         5ii0c9TjMKjy0+oGYup+yzdS1MDxYt/oPl2CS3zB6dwpt7+kw48Jg44aN1ct24BnKyNt
         EGHxBNyiomi+sc4RGalETNDhSpg8iRFRCsuRWf/3+OLVrg80D0xJVPmOR3+cdxieSHtB
         ylLw==
X-Forwarded-Encrypted: i=1; AJvYcCXBJsqpDrtcRDJUYk/CDVaBSEsdvIM87p7cLCsnXXBjrc0wgj5xoJa+yEZcUQnfvbiolu+3oINeaWNLhtlTHbRuMwhUak11Td4FU9sR2g==
X-Gm-Message-State: AOJu0YwXhLsEnfJVrZl5Tqduz5t53XP/33c2pooTk76yPB5BukE3PHeL
	Se86BPyKHzEGMdZn7dqZZxlYBvlCEDjwN9ehIEilRvCMB9eKUiZGmcIw/y0k3XNtt2NtJBixZ/f
	T+nDzvdI11+n90mLkPLPQ7c2rkgbboXMQRkhz8ZxGvHXsGON1yDSOTzppm7yaOWfFZiQ7jE6nDA
	==
X-Received: by 2002:a9d:4e92:0:b0:6ea:2789:8b62 with SMTP id v18-20020a9d4e92000000b006ea27898b62mr5918161otk.19.1714023116345;
        Wed, 24 Apr 2024 22:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExurcrNElXyLE2fPdow34mnWbyvknAw7mkB5c43l+DZ+XlqhkPienYAmSwwKvMbS+xxLYbAw==
X-Received: by 2002:a9d:4e92:0:b0:6ea:2789:8b62 with SMTP id v18-20020a9d4e92000000b006ea27898b62mr5918140otk.19.1714023115768;
        Wed, 24 Apr 2024 22:31:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l185-20020a6391c2000000b005ffd8019f01sm6334919pge.20.2024.04.24.22.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 22:31:55 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:31:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com,
	hare@suse.de, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-xfs@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC] fstests: add fsstress + writeback + debugfs folio split
 test
Message-ID: <20240425053150.tx7pdosbfv5adat6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240424224649.1494092-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224649.1494092-1-mcgrof@kernel.org>

On Wed, Apr 24, 2024 at 03:46:48PM -0700, Luis Chamberlain wrote:
> Stress test folio splits by using the debugfs interface to a target
> a new smaller folio order. This is dangerous at the moment as its using
> a debugfs API which requires two out of tree fixes [0] [1] which will
> be posted shortly. With these patches applied no crash is possible yet.
> However, this test was designed to try to exacerbate races with folio
> splits and writeback, at least running generic/447 twice ends up
> producing a crash only if large folio splits with minimum folio order
> is enabled.
> 
> With the known fixes for the debugfs interface, this test produces no
> crashes even after 3 hour soaking for 4k and LBS. We should enhance
> this test a bit more so to reproduce the issues observed by running
> generic/447 twice.
> 
> This also begs the question if something like MADV_NOHUGEPAGE might be
> desirable from userspace, so to enable userspace to request splits when
> possible.
> 
> If inspecting more closely, you'll want to enable on your kernel boot:
> 
> 	dyndbg='file mm/huge_memory.c +p'
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240424-lbs&id=80f6df5037fd0ad560526af45bd7f4d779fe03f6
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240424-lbs&id=38f6fac5b4283ea48b1876fc56728f062168f8c3
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> For those that want to help stress test folio splits to an order, hopefully
> this will help start to enable this. Perhaps there are better ways to create
> more easy targets to stress test folio splits, and in particular try to
> reproduce the issue which so far is only possible by running generic/447 twice
> on LBS. The issue with generic/447 on LBS is not observed on 4k, and this test
> produces no crashes on LBS...
> 
>  common/rc             | 20 +++++++++
>  tests/generic/745     | 97 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/745.out |  2 +
>  3 files changed, 119 insertions(+)
>  create mode 100755 tests/generic/745
>  create mode 100644 tests/generic/745.out
> 
> diff --git a/common/rc b/common/rc
> index d4432f5ce259..1eefb53aa84b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -127,6 +127,26 @@ _require_compaction()
>  	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
>  	fi
>  }
> +
> +# Requires CONFIG_DEBUGFS and truncation knobs
> +SPLIT_DEBUGFS="/sys/kernel/debug/split_huge_pages"
> +_require_split_debugfs()
> +{
> +       if [ ! -f $SPLIT_DEBUGFS ]; then
> +           _notrun "Needs CONFIG_DEBUGFS and split_huge_pages"
> +       fi
> +}

The global SPLIT_DEBUGFS isn't necessary, you can just use:

  $DEBUGFS_MNT/split_huge_pages

And this remind me we have a _require_debugfs helper in common/rc, but
it's not used by any one test case. And it looks like not correct:

  _require_debugfs()
  {
      #boot_params always present in debugfs
      [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
  }

I can't find "boot_params" in /sys/kernel/debug/. So we might need to
fix this helper, and then call it in debugfs related test cases.

I'll send another patch to talk about that fix. For this case, it needs
_require_debugfs and $DEBUGFS_MNT.

> +
> +_split_huge_pages_file_full()

May we have a comment to explain what this common helper for? Thanks.

> +{
> +	local file=$1
> +	local offset="0x0"
> +	local len=$(printf "%x" $(stat --format='%s' $file))
> +	local order="0"
> +	local split_cmd="$file,$offset,0x${len},$order"
> +	echo $split_cmd > $SPLIT_DEBUGFS
                           ^^^^^^^^^^^^^
$DEBUGFS_MNT/split_huge_pages is good enough.

> +}
> +
>  # Get hugepagesize in bytes
>  _get_hugepagesize()
>  {
> diff --git a/tests/generic/745 b/tests/generic/745
> new file mode 100755
> index 000000000000..0a30dbee35bd
> --- /dev/null
> +++ b/tests/generic/745
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Luis Chamberlain. All Rights Reserved.
> +#
> +# FS QA Test No. 734
> +#
> +# Run fsstress in a loop, and in the background force some writeback and
> +# folio splits for every file. If you're enabling this and want to check
> +# underneath the hood you may want to enable:
> +#
> +# dyndbg='file mm/huge_memory.c +p'
> +. ./common/preamble
> +_begin_fstest long_rw stress soak smoketest dangerous_fuzzers

Just double check, is it a dangerous_fuzzers test, and not good to be in auto group?

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +}
> +
> +# Import common functions.
> +. ./common/filter

I didn't see any filters called in this case, so don't need to
import it.

> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test

I didn't see TEST_DIR or TEST_DEV in this test case, so don't need
_require_test

> +_require_scratch
> +_require_split_debugfs
> +_require_command "$KILLALL_PROG" "killall"
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +nr_cpus=$((LOAD_FACTOR * 4))
> +nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
> +
> +fsstress_args=(-w -d $SCRATCH_MNT/test -n $nr_ops -p $nr_cpus)
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
> +	for i in $(find $SCRATCH_MNT/test \( -type f \) 2>/dev/null); do

May I ask why the "\( .. \)" is needed?

> +		_split_huge_pages_file_full $i >/dev/null 2>&1

Just make sure, don't you want to output to $seqres.full file to get more information
for debug, if something wrong.

> +	done
> +	sleep 2
> +done &
> +split_huge_pages_files_pid=$!

This split_huge_pages_files_pid isn't be used anywhere, you can deal with it in
_cleanup.

> +
> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> +export XFS_DIO_MIN=$((blocksize * 2))

Oh, I even forgot we have this parameter in fsstress.c :)

> +
> +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> +
> +# Our general goal here is to race with ops which can stress folio addition,
> +# removal, edits, and writeback.
> +
> +# zero frequencies for write ops to minimize writeback
> +fsstress_args+=(-R)

But you set "fsstress_args=(-w -d $SCRATCH_MNT/test -n $nr_ops -p $nr_cpus)" above,
so you zeros frequencies of non-write operations (-w) and then zeros frequencies of
write operations (-R). Do you want to use "-z" directly, to zeros frequencies of
all operations ?

> +
> +# XXX: we can improve this, so to increase the chances to allow more
> +# folio splits. Also running generic/447 twice triggers a corner case we can't
> +# capture here on folio splits and write_cache_pages, increasing the chances of
> +# this test to cover that same corner case would be ideal.
> +#
> +# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> +fsstress_args+=(-f creat=1)
> +fsstress_args+=(-f write=1)
> +fsstress_args+=(-f dwrite=1)
> +fsstress_args+=(-f truncate=1)
> +fsstress_args+=(-f zero=1)
> +fsstress_args+=(-f unlink=1)
> +fsstress_args+=(-f fsync=1)
> +fsstress_args+=(-f punch=2)
> +fsstress_args+=(-f copyrange=4)
> +fsstress_args+=(-f clonerange=4)
> +
> +if [[ "$FSTYP" != "xfs" || "$FSTYP" == "ext4" ]]; then
> +	fsstress_args+=(-f collapse=1)

Can you explain why the FALLOC_FL_COLLAPSE_RANGE is special, and not suitable
for xfs?

And I think the range of $FSTYP" != "xfs" contains "$FSTYP" == "ext4", so
this logic makes me confused.

> +fi
> +
> +$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +
> +rm -f $runfile
> +wait > /dev/null 2>&1

Better to move this to _cleanup. e.g.

rm -f $runfile
[ -n "$split_huge_pages_files_pid" ] && kill $split_huge_pages_files_pid
$KILLALL_PROG -9 fsstress
wait


Thanks,
Zorro
> +
> +status=0
> +exit
> diff --git a/tests/generic/745.out b/tests/generic/745.out
> new file mode 100644
> index 000000000000..fce6b7f5489d
> --- /dev/null
> +++ b/tests/generic/745.out
> @@ -0,0 +1,2 @@
> +QA output created by 745
> +Silence is golden
> -- 
> 2.43.0
> 
> 


