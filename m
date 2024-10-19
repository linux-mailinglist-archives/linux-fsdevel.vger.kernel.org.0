Return-Path: <linux-fsdevel+bounces-32428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D49A4FAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1693B1C223E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E718C011;
	Sat, 19 Oct 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcVq9vLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC78BA38
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729354563; cv=none; b=B0rO5W8qnD+jgz4GjijGLNtYPNctKOImO34M2NN/djzsJrw/p1zWXBBXDqyUkxJDpcpDbOTxs19ouJ7/g4NP9VdeidlqD9ipD42DyvR5fwlhkyFy6j6Tf1fKDg6P8vjLwvbMIHcAIYcnjX24aXcA4iJNJwFc38R5Jt2s1/oJ1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729354563; c=relaxed/simple;
	bh=KLnxVt0NrTe8GR/Mc3m0EbEXBXDS3Eh0s2OP87KmyfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWfB/UBsm705zl9uRlHE4BkEwl8tv6M+UbsYDmZFDcyZPQInPvofFU2bTyl+sAxgRyJzmyTH0T1fpA7WddmR7zxG41WrUIN13IuqDpUJAjEEf1wqUiT3fUH7UzbdwwMMR6IYWOBuUX73gHclt9lvCQCjj/TSDnvNejG4/2RodBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcVq9vLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A45C4CEC5;
	Sat, 19 Oct 2024 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729354562;
	bh=KLnxVt0NrTe8GR/Mc3m0EbEXBXDS3Eh0s2OP87KmyfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcVq9vLfv/3Qz7ZZPJcdz5UVug5tU2g/VCS5DboxNBVKBGXpNgvW2hE4/UDU29db6
	 NSMJpjigs1lwhI8X2M3qZWpW3/uiAkMXdPXbk91jjDFDkaPCyZ2ISXmJsUfr0iplZm
	 9Ti+qlBA2okqO/kNaEA/Km8RqfqLKGamIiveEDOlL9pox2fCvGFcKMa52XXNayQCrK
	 1iwe6N+LIiNulVTwuATYUp2VqjDL3eNyBGwQyQ+rSB8E1aPqYwd/2BRBq1v++CwgS4
	 eDHVFFwBlkYVZnzEDs3bwpk02iL84UmcrYrFh2XJjz9bjGqgV9tzCf1Oj1Z3clzCJm
	 q2Wn88ManTmpA==
Date: Sat, 19 Oct 2024 09:16:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, sunjunchao2870@gmail.com
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <christian@brauner.io>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241019161601.GJ21836@frogsfrogsfrogs>
References: <20241018162837.GA3307207@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018162837.GA3307207@mit.edu>

On Fri, Oct 18, 2024 at 12:28:37PM -0400, Theodore Ts'o wrote:
> I've been running a watcher which automatically kicks off xfstests on
> some 20+ file system configurations for btrfs, ext4, f2fs, and
> xfstests every time fs-next gets updated, and I've noticed that
> generic/564 has been failing essentially for all of the configurations
> that I test.  The test succeeds on rc3; it's only failing on fs-next,
> so it's something in Linux next.
> 
> The weird thing is when I attempted to bisect it (and I've tried twice
> in the last two days) the bisection identifies the first bad commit as
> Stephen's merge of vfs-branuer into linux-next:
> 
>    commit b3efa2373eed4e08e62b50898f8c3a4e757e14c3 (linux-next/fs-next)
>    Merge: 233650c5fbb8 2232c1874e5c
>    Author: Stephen Rothwell <sfr@canb.auug.org.au>
>    Date:   Thu Oct 17 12:45:50 2024 +1100
> 
>        next-20241016/vfs-brauner
>        
>        # Conflicts:
>        #       fs/btrfs/file.c
>        #       include/linux/iomap.h
> 
> The merge resolution looks utterly innocuous, it seems unrelated to
> what generic/564 tests, which is the errors returned by copy_file_range(2):
> 
>     # Exercise copy_file_range() syscall error conditions.
>     #
>     # This is a regression test for kernel commit:
>     #   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
>     #
> 
> 
> # diff -u /root/xfstests/tests/generic/564.out /results/ext4/results-4k/generic/564.out.bad
> --- /root/xfstests/tests/generic/564.out        2024-10-15 13:27:36.000000000 
> -0400
> +++ /results/ext4/results-4k/generic/564.out.bad        2024-10-18 12:23:58.62
> 9855983 -0400
> @@ -29,9 +29,10 @@
>  copy_range: Value too large for defined data type
>  
>  source range beyond 8TiB returns 0
> +copy_range: Value too large for defined data type
>  
>  destination range beyond 8TiB returns EFBIG
> -copy_range: File too large
> +copy_range: Value too large for defined data type
>  
>  destination larger than rlimit returns EFBIG
>  File size limit exceeded
> 
> 
> Could someone take a look, and let me know if I've missed something
> obvious?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/read_write.c?h=fs-next&id=0f0f217df68fd72d91d2de6e85a6dd80fa1f5c95
perhaps?

I think the problem here is that in the old code:

	pos_in + count < pos_in

@count is unsigned, so I think the compiler uses an unsigned comparison
and thus pos_in + count is a very large positive value, instead of the
negative value that the code author (who could possibly be me :P)
thought they were getting.  Hence this now triggers EOVERFLOW instead of
the "Shorten the copy to EOF" or generic_write_check_limits EFBIG logic.

To Mr. Sun: did you see these regressions when you tested this patch?

--D

> Thanks,
> 
> 					- Ted

> Date: Fri, 18 Oct 2024 06:21:22 +0000 (UTC)
> From: Xfstests Reporter <tytso@thunk.org>
> To: theodore.tso@gmail.com
> Subject: xfstests bisector summary 20241018002402
> Message-ID: <GetBG70iT0y8vnGiS_zP5w@geopod-ismtpd-1>
> X-Spam-Level: 
> X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
>  DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
>  RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_VALIDITY_CERTIFIED_BLOCKED,
>  RCVD_IN_VALIDITY_RPBL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
>  autolearn=no autolearn_force=no version=3.4.6
> 
> ============BISECTOR INFO 20241018002402============
> CMDLINE:	-c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> REPO:	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> BAD COMMIT:	origin/fs-next
> GOOD COMMITS:	v6.12-rc3
> SINCE LAST UPDATE:	0s
> BISECT LOG:
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [b3efa2373eed4e08e62b50898f8c3a4e757e14c3] next-20241016/vfs-brauner
> git bisect bad b3efa2373eed4e08e62b50898f8c3a4e757e14c3
> # status: waiting for good commit(s), bad commit known
> # good: [8e929cb546ee42c9a61d24fae60605e9e3192354] Linux 6.12-rc3
> git bisect good 8e929cb546ee42c9a61d24fae60605e9e3192354
> # good: [c34fba96e591306731d18feb1ec853e4659e16a2] Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6.git
> git bisect good c34fba96e591306731d18feb1ec853e4659e16a2
> # good: [08c323ab021e3a0246554cd7e753e91b3845e3fd] Merge branch 'vfs.ovl' into vfs.all Signed-off-by: Christian Brauner <brauner@kernel.org>
> git bisect good 08c323ab021e3a0246554cd7e753e91b3845e3fd
> # good: [cb0764720682a330425a8354c12ea5343a5691c6] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
> git bisect good cb0764720682a330425a8354c12ea5343a5691c6
> # good: [466247e4e33b7e43589e5fa00bcd721a67463935] nfsd: rename NFS4_SHARE_WANT_* constants to OPEN4_SHARE_ACCESS_WANT_*
> git bisect good 466247e4e33b7e43589e5fa00bcd721a67463935
> # good: [cc261279af9809ddf1f22d12966d4b9033983154] Merge branch '9p-next' of git://github.com/martinetd/linux
> git bisect good cc261279af9809ddf1f22d12966d4b9033983154
> # good: [c29440ff66d6f24be5e9e313c1c0eca7212faf9e] xfs: share more code in xfs_buffered_write_iomap_begin
> git bisect good c29440ff66d6f24be5e9e313c1c0eca7212faf9e
> # good: [b026d364517dc97cd27e0e920a8b5f25f9889059] Merge patch series "API for exporting connectable file handles to userspace"
> git bisect good b026d364517dc97cd27e0e920a8b5f25f9889059
> # good: [f6f91d290c8b9da6e671bd15f306ad2d0e635a04] xfs: punch delalloc extents from the COW fork for COW writes
> git bisect good f6f91d290c8b9da6e671bd15f306ad2d0e635a04
> # good: [2232c1874e5c400d4666ac296258e37828c1bd70] Merge branch 'vfs.exportfs' into vfs.all Signed-off-by: Christian Brauner <brauner@kernel.org>
> git bisect good 2232c1874e5c400d4666ac296258e37828c1bd70
> # good: [233650c5fbb83fb83f8311d660120ba910eff5fa] Merge branch 'for-next' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> git bisect good 233650c5fbb83fb83f8311d660120ba910eff5fa
> # first bad commit: [b3efa2373eed4e08e62b50898f8c3a4e757e14c3] next-20241016/vfs-brauner
> 
> 
> ============TEST 20241018002402-c34fba96============
> TESTRUNID: ltm-20241018002402-c34fba96
> KERNEL:    kernel 6.12.0-rc3-xfstests-00245-gc34fba96e591 #1 SMP PREEMPT_DYNAMIC Fri Oct 18 00:33:27 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 12 seconds
>   generic/564  Pass     9s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 12s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-08c323ab============
> TESTRUNID: ltm-20241018002402-08c323ab
> KERNEL:    kernel 6.12.0-rc3-xfstests-00125-g08c323ab021e #1 SMP PREEMPT_DYNAMIC Fri Oct 18 00:47:07 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 10 failures, 19 seconds
>   generic/564  Failed   12s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   0s
>   generic/564  Failed   0s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
> Totals: 10 tests, 0 skipped, 10 failures, 0 errors, 19s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-cb076472============
> TESTRUNID: ltm-20241018002402-cb076472
> KERNEL:    kernel 6.12.0-rc3-xfstests-00295-gcb0764720682 #1 SMP PREEMPT_DYNAMIC Fri Oct 18 00:56:02 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 10 seconds
>   generic/564  Pass     10s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 10s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-466247e4============
> TESTRUNID: ltm-20241018002402-466247e4
> KERNEL:    kernel 6.12.0-rc3-xfstests-00036-g466247e4e33b #1 SMP PREEMPT_DYNAMIC Fri Oct 18 01:08:37 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 15 seconds
>   generic/564  Pass     9s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
>   generic/564  Pass     0s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 15s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-cc261279============
> TESTRUNID: ltm-20241018002402-cc261279
> KERNEL:    kernel 6.12.0-rc3-xfstests-00350-gcc261279af98 #1 SMP PREEMPT_DYNAMIC Fri Oct 18 01:21:55 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 20 seconds
>   generic/564  Pass     12s
>   generic/564  Pass     0s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 20s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-c29440ff============
> TESTRUNID: ltm-20241018002402-c29440ff
> KERNEL:    kernel 6.12.0-rc2-xfstests-00024-gc29440ff66d6 #1 SMP PREEMPT_DYNAMIC Fri Oct 18 01:34:14 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 15 seconds
>   generic/564  Pass     8s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     0s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     0s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 15s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-b026d364============
> TESTRUNID: ltm-20241018002402-b026d364
> KERNEL:    kernel 6.12.0-rc3-xfstests-00010-gb026d364517d #1 SMP PREEMPT_DYNAMIC Fri Oct 18 01:45:14 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 20 seconds
>   generic/564  Pass     11s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 20s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-f6f91d29============
> TESTRUNID: ltm-20241018002402-f6f91d29
> KERNEL:    kernel 6.12.0-rc2-xfstests-00026-gf6f91d290c8b #1 SMP PREEMPT_DYNAMIC Fri Oct 18 01:53:01 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 18 seconds
>   generic/564  Pass     9s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 18s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-2232c187============
> TESTRUNID: ltm-20241018002402-2232c187
> KERNEL:    kernel 6.12.0-rc3-xfstests-00136-g2232c1874e5c #1 SMP PREEMPT_DYNAMIC Fri Oct 18 02:03:22 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 10 failures, 17 seconds
>   generic/564  Failed   9s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   0s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
> Totals: 10 tests, 0 skipped, 10 failures, 0 errors, 17s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex
> 
> ============TEST 20241018002402-233650c5============
> TESTRUNID: ltm-20241018002402-233650c5
> KERNEL:    kernel 6.12.0-rc3-xfstests-00362-g233650c5fbb8 #1 SMP PREEMPT_DYNAMIC Fri Oct 18 02:12:07 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-good v6.12-rc3 generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 20 seconds
>   generic/564  Pass     12s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     0s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
>   generic/564  Pass     1s
> Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 20s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex

> TESTRUNID: ltm-20241017115737
> KERNEL:    kernel 6.12.0-rc3-xfstests-00490-gb3efa2373eed #1 SMP PREEMPT_DYNAMIC Thu Oct 17 12:14:51 EDT 2024 x86_64
> CMDLINE:   -c ext4/4k -C 10 --repo next.git --commit fs-next generic/564
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 10 tests, 10 failures, 15 seconds
>   generic/564  Failed   9s
>   generic/564  Failed   1s
>   generic/564  Failed   0s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
>   generic/564  Failed   0s
>   generic/564  Failed   1s
>   generic/564  Failed   0s
>   generic/564  Failed   1s
>   generic/564  Failed   1s
> Totals: 10 tests, 0 skipped, 10 failures, 0 errors, 15s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
> FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
> FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
> FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
> FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
> FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
> FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
> FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
> FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
> FSTESTVER: zz_build-distro bookworm
> FSTESTSET: generic/564
> FSTESTOPT: count 10 fail_loop_count 0 aex


