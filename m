Return-Path: <linux-fsdevel+bounces-17360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9618ABBE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62B01F21352
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972B20DC5;
	Sat, 20 Apr 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT8ruQ4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87B1CD25
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621774; cv=none; b=bLKLoGCfZdkk9KnG/BckWVhVu65e3hRIrLzZWBKTUUAhEUEDyTr0H4QGXpOHWN7ZfHLlp5c93458Ybk03VkcX7e9mY4iJmT3+FsfLSRBN1j7WX3/8usEk2qGqHznmym0NotfC0BEo+kqB1npPxMS3niAtv6B0xOvNNwYrWEROpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621774; c=relaxed/simple;
	bh=0napQ7pi0k55WEnQiDhsd00EYcSZufBSSb/xqU60oe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3gPEnRbxvH86j4Iz7kx6ehqw9DDdlgumaaKgofsW0aq9HRmc2lo/0Q+y4/+Z8G1rDdMnZUytssdXJRiKkHvXQmrk1CfYsnV4rs4M2PNEKzhRXMBhgz79PRa/cbgUXe9G1skFCKqZYF5b+ZhDNy+twVvaZSNEajL/sGCG2ujnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fT8ruQ4G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713621770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lfgJeEkDXQcf1eXq96/sWgcK53JbCs/dnLvPig9JJw=;
	b=fT8ruQ4Gj9NVw4KNiMsOBY6N1q8QOsqi+gTF6EUn+xskYhchVraDZZXZehzFG/TDAnz+Rh
	CJ2JtSlaNfT0JUwMNTXIVvCnU9pBvDYyuCd6rJO2h3qMyruoU//cha/nHB6Ex1qdPHF3J2
	QoZMJGIWHfmrphY87Oa9hE9cWV8gk50=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-0L6t2vXROuyYtMxoWf0qfA-1; Sat, 20 Apr 2024 10:02:49 -0400
X-MC-Unique: 0L6t2vXROuyYtMxoWf0qfA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e2bbb6049eso38121685ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 07:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713621768; x=1714226568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lfgJeEkDXQcf1eXq96/sWgcK53JbCs/dnLvPig9JJw=;
        b=VY/mDOEdA2CZ4ER67ME8qsyaM5hS76h1IxmlghIe4QMXnbZsqBmwOqMusthsHZstUH
         pfz56h3+fmXjGNllcRtxhrdx8Sq/VGY5aTpP0OKiCCr3suJvfoGyxZmOsuBOvnRggVqa
         uZdo360OxAL2Cpx7c70sFGvkniPAU9vZQeUkZpR7wf7T627XrXvMD87/3XrX5KUFUEIi
         zZTqWUkIuHdvYSoHn5G38nfxJkrUKdPV5T5T1X1nxXeiV9XzacbWX3gsvCfvP0k1pTm2
         BYaMrDHLi0lzy8Yb8O9LKjIcy0VSKMhBOk8F/h30au/fCmcJepfTHbaZdSyfP16sVFv/
         5sYg==
X-Forwarded-Encrypted: i=1; AJvYcCVsTh0hNuLofRFzLa7q65LYoBv5uRnP+S9N/KtEKivJdxQryftL818z980elZTR9sUjFMimpLE0YwUUnmUMClS9hYNRTHVSF2Bj0/nfxA==
X-Gm-Message-State: AOJu0Yy05qMWrgNVZEfK5HCK6Y4canqB4J3iTOVBcfO30q2z1oPwgWtf
	xeTTwL7ik3Q/GxcTBFd7S7JKRo+kC9LvPGSLWV1UkZQfwpWoFc/HuYd1ryd2a5YKfGUBKxJjzOC
	G4EXnfCIl8DkwrBJOJv9cv/54yRmpEAWqs/dQOT9l47J1CxEhMlZDiPmIfivmHXo=
X-Received: by 2002:a17:903:22c5:b0:1dc:de65:623b with SMTP id y5-20020a17090322c500b001dcde65623bmr6365704plg.60.1713621767731;
        Sat, 20 Apr 2024 07:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+B4ecgGbiEbteqjqIcALgwRnV6lNA+X+RJ7IVvcGmdcjPMSR3Dzt2AzFx0d+Gyiael9DH1Q==
X-Received: by 2002:a17:903:22c5:b0:1dc:de65:623b with SMTP id y5-20020a17090322c500b001dcde65623bmr6365648plg.60.1713621767054;
        Sat, 20 Apr 2024 07:02:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd59b54f9fsm5095275plh.136.2024.04.20.07.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 07:02:46 -0700 (PDT)
Date: Sat, 20 Apr 2024 22:02:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, kdevops@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, willy@infradead.org,
	david@redhat.com, linmiaohe@huawei.com, muchun.song@linux.dev,
	osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <20240420140241.wez2x3zoirzlmat6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
> 
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
> 
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

I'm not sure if we should name it as "_require_vm_compaction", does linux
have other "compaction" or only memory compaction?

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

fsstress + memory compaction ?

Looks like this case is copied from g/476, just add memory_compaction
test. That makes sense to me from the test side.

I'm a bit confused on your discussion about an old bug and a new bug(?)
you just found. Looks like you're reporting a bug, and provide a test
case to fstests@ by the way. Anyway, I think there's not objection on
this test itself, right? And is this test for someone known bug or not?

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

Useless comment~

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

I didn't see any other place use this "getfattr_pid". Better to deal with
it in _cleanup().

> +
> +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> +
> +$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +
> +rm -f $runfile
> +wait > /dev/null 2>&1

Better to do these things in _cleanup() function, make sure all background
processes can be done in _cleanup.

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
> 


