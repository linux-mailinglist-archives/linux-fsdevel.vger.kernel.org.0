Return-Path: <linux-fsdevel+bounces-47124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2ADA998F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5DF920E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320AD268685;
	Wed, 23 Apr 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb38UWg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E932701AB;
	Wed, 23 Apr 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438017; cv=none; b=oSXo2wP6rHe6SYJa2iyppAo05rAb1FU1XzUowrcDqpYUmQ1Wf90bx8M1P6fOPTlelHDucmBryZgG+GULGV1zykXjEn32N6J2w/Oc6A3mdxl50GkcFaVb4T5buygVvrMaJtgXhU7hd3MPiLsLJJBojs0wBey7f/vrchdK0OCRQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438017; c=relaxed/simple;
	bh=YncPqb7aIQZETQRJ3H6xA4SvYFka8O6TeRG7Wk0025E=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=dfBDwOLp/oVO9MKvG66SKCVnBThL3GIn/TDWIfXKcn2Oee5i32R55hyvs5k1KNSiwVge1eFBX3CCLv2BpU+o/JmCIROfm9jTBLbk777WckbC/WlYKvcHj4WGAlqoOU6BYMRfcSk35Wse44Oa8oWiqlw8uK+XzLSCRLtxdDiV0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb38UWg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2138C4CEE8;
	Wed, 23 Apr 2025 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745438017;
	bh=YncPqb7aIQZETQRJ3H6xA4SvYFka8O6TeRG7Wk0025E=;
	h=Date:Subject:From:To:Cc:From;
	b=Vb38UWg+UyXbKCVjAfBVbNjxi60sVKSE1XmkOZPi3iOCtrQv6g8vD5fKNR1dNA2Hh
	 NJrjLO/zsXeqhgTboekQpih1q1Rv+ioNAWS2aTBm6TaNLlhjp7ddEZnuMplQdxl3h1
	 CkOy9fSlu8ewFAWsGDrB8CK75ohahInlkQrisvKDT3N8VfrjkAP1lW19wviEzpLLOz
	 QjxjqBsl1TF8zYhhFBvWX3P2awDSsyHABXD94FZlng9PBzogCrrFT/f8C4P9syWXgp
	 p6gF2MEUvHE2APGrkPzIkAVT/+a4wgGoGU+fLpJENnUCyUC9F23S2cOcKGfrtVhvaR
	 tJjhm8iCe4IAg==
Date: Wed, 23 Apr 2025 12:53:36 -0700
Subject: [PATCHSET V4] block/xfs: bdev page cache bug fixes for 6.15
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, mcgrof@kernel.org, shinichiro.kawasaki@wdc.com,
 hch@infradead.org, willy@infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 linux-block@vger.kernel.org, mcgrof@kernel.org
Message-ID: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
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
removes XFS' usage of set_blocksize since it's unnecessary.  I think this
is ready for merging now.

v1: clean up into something reviewable
v2: split block and xfs patches, add reviews
v3: rebase to 6.15-rc3, no other dependencies
v4: add more tags

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


