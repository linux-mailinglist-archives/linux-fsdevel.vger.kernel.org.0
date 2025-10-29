Return-Path: <linux-fsdevel+bounces-65994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B31C17981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D979E1C6848C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC132D3A7B;
	Wed, 29 Oct 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2ZGRgqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4C2D2388;
	Wed, 29 Oct 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698573; cv=none; b=DcX/iz0G1abK8JDlotJR3NdkQO1ZeCtNRV0M5/YFMLeMSm+jx4/9kfapzftpqYfCBxhz2P5uqWHP9plWSDeAQHskEJg2XCq1dfpGwsndwTkRVCJrFlNyekstBmVwHm0jhtehIwJEjMkwIgimZ4tZIdA+qU2TGPU+bFk93Ye3maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698573; c=relaxed/simple;
	bh=oFGSMoVW826fsmeMwespne/pVw6BQjG/cLavvsHVlsU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gq/VhEt4APUgfJrEE1d0ouYKd+lWkH30mpWOYEYl/qyOuS8S76FkXoXZXuIDm5ZXwVrxR4yjJUj3HcglnRVddqNW9XXcH6B7mLe+JBSYYPikcPYrfW1gFZMEudljwVtYFHA2NIf0Pz2F5bZ+2aGkYKxTXEyVxxL+l6A3QWUKteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2ZGRgqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4BBC4CEE7;
	Wed, 29 Oct 2025 00:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698572;
	bh=oFGSMoVW826fsmeMwespne/pVw6BQjG/cLavvsHVlsU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D2ZGRgqr05WUR4hpoYApGy7s5agQoIirFTFUNJ7IwL/yd/Bs1ezbqoMU4RE196Jag
	 JkhZwynlBjyn/LP9oN8zyQLh79vY9KmsGCW13FiRZbMus+w5paSQC+cHUW2K8Zow24
	 Ev4oEz4iwukVHne4484aORRvA8zruOT2Vp1I5UwdmhdtcALqwlucuuiC8DWZREYjmY
	 nXpTVdgZLO/UO96I/5jNnRejYINKgr9DhyVDWAJ7jKwyAAs3Q7rPAjSA/1TY3506Ct
	 hXECOOvKDOrf/OYDU7pfzYh7nmx1DCYM2JXTq5qfUUOsdQfwKw7J5GxsQYILDsvMnc
	 vaYgiO0IYHNCg==
Date: Tue, 28 Oct 2025 17:42:52 -0700
Subject: [PATCHSET v6] fstests: support ext4 fuse testing
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, neal@gompa.dev, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Various test adjustments to support testing the fuse ext4 server (fuse2fs) as
if it were the kernel ext4 driver.  This supports QAing the fuse-iomap
prototype project.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuse2fs
---
Commits in this patchset:
 * misc: adapt tests to handle the fuse ext[234] drivers
 * generic/740: don't run this test for fuse ext* implementations
 * ext/052: use popdir.pl for much faster directory creation
 * common/rc: skip test if swapon doesn't work
 * common/rc: streamline _scratch_remount
 * ext/039: require metadata journalling
 * populate: don't check for htree directories on fuse.ext4
 * misc: convert _scratch_mount -o remount to _scratch_remount
 * misc: use explicitly $FSTYP'd mount calls
 * common/ext4: explicitly format with $FSTYP
 * tests/ext*: refactor open-coded _scratch_mkfs_sized calls
 * generic/732: disable for fuse.ext4
 * defrag: fix ext4 defrag ioctl test
 * misc: explicitly require online resize support
 * ext4/004: disable for fuse2fs
 * generic/679: disable for fuse2fs
 * ext4/045: don't run the long dirent test on fuse2fs
 * generic/338: skip test if we can't mount with strictatime
 * generic/563: fuse doesn't support cgroup-aware writeback accounting
 * misc: use a larger buffer size for pwrites
 * ext4/046: don't run this test if dioread_nolock not supported
 * generic/631: don't run test if we can't mount overlayfs
 * generic/{409,410,411,589}: check for stacking mount support
 * generic: add _require_hardlinks to tests that require hardlinks
 * ext4/001: check for fiemap support
 * generic/622: check that strictatime/lazytime actually work
 * generic/050: skip test because fuse2fs doesn't have stable output
 * generic/405: don't stall on mkfs asking for input
 * ext4/006: fix this test
 * ext4/009: fix ENOSPC errors
 * ext4/022: enabl
 * generic/730: adapt test for fuse filesystems
 * fuse2fs: hack around weird corruption problems
---
 check                      |   24 ++
 common/casefold            |    4 
 common/config              |   11 +
 common/defrag              |    4 
 common/encrypt             |   16 +-
 common/ext4                |   20 ++
 common/log                 |   10 +
 common/populate            |   15 +-
 common/quota               |    9 +
 common/rc                  |  109 ++++++++---
 common/report              |    2 
 common/verity              |    8 -
 src/popdir.pl              |    9 +
 tests/btrfs/015            |    2 
 tests/btrfs/032            |    2 
 tests/btrfs/082            |    2 
 tests/btrfs/139            |    2 
 tests/btrfs/193            |    2 
 tests/btrfs/199            |    2 
 tests/btrfs/219            |   12 +
 tests/btrfs/259            |    2 
 tests/ext4/001             |    1 
 tests/ext4/003             |    3 
 tests/ext4/004             |    2 
 tests/ext4/006             |    4 
 tests/ext4/009             |   11 +
 tests/ext4/022             |    9 +
 tests/ext4/022.cfg         |    1 
 tests/ext4/022.out.default |    0 
 tests/ext4/022.out.fuse2fs |  432 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/032             |    6 -
 tests/ext4/033             |    7 +
 tests/ext4/035             |    4 
 tests/ext4/039             |    1 
 tests/ext4/045             |   12 +
 tests/ext4/046             |    8 -
 tests/ext4/052             |    9 +
 tests/ext4/053             |    2 
 tests/ext4/059             |    2 
 tests/ext4/060             |    2 
 tests/ext4/306             |    7 -
 tests/f2fs/005             |    2 
 tests/generic/020          |    2 
 tests/generic/027          |    4 
 tests/generic/042          |    4 
 tests/generic/050          |    4 
 tests/generic/067          |    6 -
 tests/generic/079          |    1 
 tests/generic/081          |    2 
 tests/generic/082          |    4 
 tests/generic/085          |    2 
 tests/generic/108          |    2 
 tests/generic/223          |    4 
 tests/generic/235          |    4 
 tests/generic/286          |    8 -
 tests/generic/294          |    2 
 tests/generic/323          |    2 
 tests/generic/338          |    2 
 tests/generic/361          |    4 
 tests/generic/405          |    2 
 tests/generic/409          |    1 
 tests/generic/410          |    1 
 tests/generic/411          |    1 
 tests/generic/423          |    1 
 tests/generic/441          |    2 
 tests/generic/449          |    2 
 tests/generic/459          |    2 
 tests/generic/496          |    2 
 tests/generic/511          |    2 
 tests/generic/536          |    2 
 tests/generic/563          |    8 +
 tests/generic/589          |    1 
 tests/generic/597          |    1 
 tests/generic/620          |    2 
 tests/generic/621          |    2 
 tests/generic/622          |    4 
 tests/generic/631          |   22 ++
 tests/generic/648          |    4 
 tests/generic/679          |    2 
 tests/generic/704          |    2 
 tests/generic/730          |   15 +-
 tests/generic/732          |    1 
 tests/generic/740          |    3 
 tests/generic/741          |    8 +
 tests/generic/744          |    6 -
 tests/generic/746          |    8 -
 tests/generic/765          |    4 
 tests/xfs/014              |    4 
 tests/xfs/017              |    4 
 tests/xfs/049              |    2 
 tests/xfs/073              |    8 -
 tests/xfs/074              |    4 
 tests/xfs/075              |    2 
 tests/xfs/078              |    2 
 tests/xfs/148              |    4 
 tests/xfs/149              |    4 
 tests/xfs/189              |    4 
 tests/xfs/196              |    2 
 tests/xfs/199              |    2 
 tests/xfs/206              |    2 
 tests/xfs/216              |    2 
 tests/xfs/217              |    2 
 tests/xfs/250              |    2 
 tests/xfs/289              |    2 
 tests/xfs/291              |    2 
 tests/xfs/423              |    4 
 tests/xfs/507              |    2 
 tests/xfs/513              |    2 
 tests/xfs/606              |    4 
 tests/xfs/609              |    2 
 tests/xfs/610              |    2 
 tests/xfs/613              |    2 
 tests/xfs/806              |    2 
 113 files changed, 828 insertions(+), 206 deletions(-)
 create mode 100644 tests/ext4/022.cfg
 rename tests/ext4/{022.out => 022.out.default} (100%)
 create mode 100644 tests/ext4/022.out.fuse2fs


