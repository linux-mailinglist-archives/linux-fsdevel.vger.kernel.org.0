Return-Path: <linux-fsdevel+bounces-46863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3073A95A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB2418948B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2BC1531E9;
	Tue, 22 Apr 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9R3reoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7533F6;
	Tue, 22 Apr 2025 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284709; cv=none; b=quBifqzidohHnveqsNDx2SRoawZX2MNGZ+INEfo1L6rZ6vgrxmQQYasqeRlwtq1L5DDTaASzcDwJp8hufSjNnFjkqj/ajZLXif99WccjyTd7Eqxi1Hhq36b3cl92xQ52j4X62VF9MJDOYH7M24L0LStBW0H1OplqwCttkiBaq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284709; c=relaxed/simple;
	bh=rHr3OHaH2YIOh9tMd8szZwedcsoXHKBwcUaU/e2K5K8=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=YCg4cNdTIRRuIcY2ZVjSHSuRo2v3jvAravlPcMpkmAEmtmL0xsDj29j1QaGdHUwSlYCAXHcVfuxNBxg1dY2hOh09sT9b0YaHA9PCahieD9f351vtIfgZk1OZQUYwIOFoP/r32h8zPsMygjPoRvvAr+Nn3jqpgqEFHpvYZtfaRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9R3reoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE150C4CEE4;
	Tue, 22 Apr 2025 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284708;
	bh=rHr3OHaH2YIOh9tMd8szZwedcsoXHKBwcUaU/e2K5K8=;
	h=Date:Subject:From:To:Cc:From;
	b=U9R3reoEs6GU+Lmemt3mTV3z6oNYWJvBctJUdGTzp1dKf2T8Nss0cCZRXF55daJb0
	 vjOsrCc4TnTQtkJRmHuh8D7HzxNQZHTJ+nuh1gAu4lwkt1jpHLDvrTANmcbehbBTOa
	 4q5evHHu4ydsbyqpSCD+LGdCwoK59OYpQ9he9iKF17VAKenTgUY2K9El0RSaAr1msE
	 bk+PD+N2l5IRpXFvrSq4jYet+BBd5w/PhUYWB/+5bautGhAqijDN+EVlF04Rb7y9gH
	 29bSL0ND7mRY/dmGMN6p3dfL+vKmAVbz17JxCpf/Ps2Trp4Us80bsvEzNKDXmIUr4U
	 Ns9X3WaLnc36A==
Date: Mon, 21 Apr 2025 18:18:28 -0700
Subject: [PATCHSET V3] block/xfs: bdev page cache bug fixes for 6.15
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, axboe@kernel.dk, djwong@kernel.org
Cc: hch@lst.de, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 linux-xfs@vger.kernel.org, hch@infradead.org, willy@infradead.org
Message-ID: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here are a handful of bugfixes for 6.15.  The first patch fixes a race
between set_blocksize and block device pagecache manipulation; the rest
removes XFS' usage of set_blocksize since it's unnecessary.

v1: clean up into something reviewable
v2: split block and xfs patches, add reviews
v3: rebase to 6.15-rc3, no other dependencies

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=bdev-fixes-6.15
---
Commits in this patchset:
 * block: fix race between set_blocksize and read paths
 * block: hoist block size validation code to a separate function
 * xfs: stop using set_blocksize
---
 include/linux/blkdev.h |    1 +
 block/bdev.c           |   50 ++++++++++++++++++++++++++++++++++++++++++------
 block/blk-zoned.c      |    5 ++++-
 block/fops.c           |   16 +++++++++++++++
 block/ioctl.c          |    6 ++++++
 fs/xfs/xfs_buf.c       |   15 +++++++++++---
 6 files changed, 82 insertions(+), 11 deletions(-)


