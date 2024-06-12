Return-Path: <linux-fsdevel+bounces-21564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCF905C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 21:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DC21F22A23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16D83A19;
	Wed, 12 Jun 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld1DIZUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7B433D8;
	Wed, 12 Jun 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221297; cv=none; b=Vdjo1VHrkavLWYCouwWC//OaMgZMCScprYk65xAsA5U0VXwQnvBVlA/qihzxZJeJ2xAqkshYivzdAaaNEbhLI7JN++cRdDYUKOK3t8l7QjzSX8XUO4dz0CVaP7mBN97eTdDr5g6shvWVL4bPCS9xnc9ICjW5BtAPn+xWI9DPxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221297; c=relaxed/simple;
	bh=eYAfv2IaeIPk7YgUpGrCp904JmVahjLKMWGGq1Z2nPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmrN+Wb6PcwEo7ucuEoCgIs7I5eaE86vU6uCQeJ3oUO3X5JHgkGGO0Pkw5tjJ17fF2kECG0NsJkdas1jjvP7SE8o7vx7yX3t1iJZ6xRR19cvQSlJZ6sJmA0q0wm6sWCf7nyhMC+RuuFsdvoPbmWihg7olIR4F6k/7mjajfNa9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld1DIZUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34579C116B1;
	Wed, 12 Jun 2024 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718221297;
	bh=eYAfv2IaeIPk7YgUpGrCp904JmVahjLKMWGGq1Z2nPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ld1DIZUHmUQWoJdWOJRcMipafbO1TzvzzpOFkKcDxwGXTkFb3g1/9q88+FN5kr6o1
	 1GjJnMG/0ao13otOpez8evQhmmP2FZU3wXdhrlfys0RW+vb72ckXo9y1SmBMfaJ4mh
	 PsIvBN72o+riOUHjpwCjafLji2zFMs3M6CNr3SU5EltImyRuTtQ1uIm3jpuL4Whiyy
	 lAv5RPrY82ZVg52rbVs9fMME7QUL2kDkkS7O/FlWdYVMFkBHTBN1Efv4uqkAp00Aqr
	 qnRIIxymHIdVbk733S2PQwAYXSPjv1d4LvDHg9OS3o5J0aDpitZalpVmzc7l+qqq2B
	 RWeeUS8e+0TKA==
Date: Wed, 12 Jun 2024 12:41:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	fstests@vger.kernel.org
Subject: Re: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240612194136.GA2764780@frogsfrogsfrogs>
References: <20240612162948.GA2093190@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612162948.GA2093190@mit.edu>

On Wed, Jun 12, 2024 at 05:29:48PM +0100, Theodore Ts'o wrote:
> I've been trying to clear various failing or flaky tests, and in that
> context I've been finding that generic/269 is failing with a
> probability of ~5% on a wide variety of test scenarios on ext4, xfs,
> btrfs, and f2fs on 6.10-rc2 and on fs-next.  (See below for the
> details; the failure probability ranges from 1% to 10% depending on
> the test config.)
> 
> What generic/269 does is to run fsstress and ENOSPC hitters in
> parallel, and checks to make sure the file system is consistent at the
> end of the tests.  Failure is caused by the umount of the file system
> failing with EBUSY.  I've tried adding a sync and a "sync -f
> $SCRATCH_MNT" before the attempted _scratch_umount, and that doesn't
> seem to change the failure.
> 
> However, on a failure, if you sleep for 10 seconds, and then retry the
> unmount, this seems to make the proble go away.  This is despite the
> fact that we do wait for the fstress process to exit --- I vaguely
> recall that there is some kind of RCU failure which means that the
> umount will not reliably succeed under some circumstances.  Do we
> think this is the right fix?
> 
> (Note: when I tried shortening the sleep 10 to sleep 1, the problem
> came back; so this seems like a real hack.   Thoughts?)

I don't see this problem; if you apply this to fstests to turn off
io_uring:
https://lore.kernel.org/fstests/169335095953.3534600.16325849760213190849.stgit@frogsfrogsfrogs/#r

do the problems go away?

--D

> Thanks,
> 
>      	      	   	      	     - Ted
> 
> diff --git a/tests/generic/269 b/tests/generic/269
> index 29f453735..dad02abf3
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -51,9 +51,12 @@ if ! _workout; then
>  fi
>  
>  if ! _scratch_unmount; then
> +    sleep 10
> +    if ! _scratch_unmount ; then
>  	echo "failed to umount"
>  	status=1
>  	exit
> +    fi
>  fi
>  status=0
>  exit
> 
> 
> ext4/4k: 50 tests, 2 failures, 1339 seconds
>   Flaky: generic/269:  4% (2/50)
> ext4/1k: 50 tests, 5 failures, 1224 seconds
>   Flaky: generic/269: 10% (5/50)
> ext4/ext3: 50 tests, 1477 seconds
> ext4/encrypt: 50 tests, 2 failures, 1253 seconds
>   Flaky: generic/269:  4% (2/50)
> ext4/nojournal: 50 tests, 1 failures, 1503 seconds
>   Flaky: generic/269:  2% (1/50)
> ext4/ext3conv: 50 tests, 4 failures, 1294 seconds
>   Flaky: generic/269:  8% (4/50)
> ext4/adv: 50 tests, 2 failures, 1263 seconds
>   Flaky: generic/269:  4% (2/50)
> ext4/dioread_nolock: 50 tests, 3 failures, 1327 seconds
>   Flaky: generic/269:  6% (3/50)
> ext4/data_journal: 50 tests, 1 failures, 1317 seconds
>   Flaky: generic/269:  2% (1/50)
> ext4/bigalloc_4k: 50 tests, 2 failures, 1193 seconds
>   Flaky: generic/269:  4% (2/50)
> ext4/bigalloc_1k: 50 tests, 1259 seconds
> ext4/dax: 50 tests, 5 failures, 1136 seconds
>   Flaky: generic/269: 10% (5/50)
> xfs/4k: 50 tests, 3 failures, 1211 seconds
>   Flaky: generic/269:  6% (3/50)
> xfs/1k: 50 tests, 1219 seconds
> xfs/v4: 50 tests, 4 failures, 1206 seconds
>   Flaky: generic/269:  8% (4/50)
> xfs/adv: 50 tests, 1 failures, 1206 seconds
>   Flaky: generic/269:  2% (1/50)
> xfs/quota: 50 tests, 2 failures, 1460 seconds
>   Flaky: generic/269:  4% (2/50)
> xfs/quota_1k: 50 tests, 1449 seconds
> xfs/dirblock_8k: 50 tests, 1 failures, 1351 seconds
>   Flaky: generic/269:  2% (1/50)
> xfs/realtime: 50 tests, 1286 seconds
> xfs/realtime_28k_logdev: 50 tests, 1234 seconds
> xfs/realtime_logdev: 50 tests, 1259 seconds
> xfs/logdev: 50 tests, 3 failures, 1390 seconds
>   Flaky: generic/269:  6% (3/50)
> xfs/dax: 50 tests, 1125 seconds
> btrfs/default: 50 tests, 1573 seconds
> f2fs/default: 50 tests, 1471 seconds
> f2fs/encrypt: 50 tests, 1 failures, 1424 seconds
>   Flaky: generic/269:  2% (1/50)
> Totals: 1350 tests, 0 skipped, 42 failures, 0 errors, 35449s
> 
> 

