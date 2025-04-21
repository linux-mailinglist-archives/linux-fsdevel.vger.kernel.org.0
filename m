Return-Path: <linux-fsdevel+bounces-46829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB65A9551A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603251893714
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D41E3774;
	Mon, 21 Apr 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKAtipBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D012F399;
	Mon, 21 Apr 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255926; cv=none; b=IEmYIO+vU5wYfzjYi7wMRYhBftMGq3Pk4lmz1kxW4Zjryb0QjlSvEdyZCE2Vx79H3VqVRAi+wp99gzeynNH2RIAR7gjUwn7mLhEtpszDb5SqUrErnykSG2E4AjQqHWsvbNHFdy7qW3v4ciCujKuojU3vuyMtllHeZ+VY0sZpAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255926; c=relaxed/simple;
	bh=KBpqboJ8Gn+3zVUiSvsVyY5nAHzGZOsNjfQ2V9DsXwo=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Dd+G3LXXkdepTgxZg8AIwTGxyx17tABqAKGiJbRwEJXl1bUmNhE9PoWYwaxmPzM0aRW/JWiNkkM411FdFSsCl9wMLU93ZA3k0f1Ws250loZBDiUnEpGkHGC59DwdpijNIqBURjIOKpovbWU+MtGi7uaetfMy5YV0xBzwkm8ssN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKAtipBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A0FC4CEE4;
	Mon, 21 Apr 2025 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255925;
	bh=KBpqboJ8Gn+3zVUiSvsVyY5nAHzGZOsNjfQ2V9DsXwo=;
	h=Date:Subject:From:To:Cc:From;
	b=FKAtipBQTdNOrpbB/vbqQyPW0DLJjpH/uqXFC591R4ODN9VNm+BWQOKN54t9vbf8C
	 gz7yegAo66p3+MOcOYGEov4qRe57UnoOi0rvUa2wN26h9AAep2CIFSDLlehYXjWpXe
	 3GLLqJXaX0a8ttxH6oPVpm2tsxllkB2ThPhZTkSvMr0wkCjwjKHfUugLaLQoZlNgva
	 9kqba3yPuVGAsM9BUKIv0wp3YA1PU7p2sblSl+MfquOlwz0UPo+Yq3Lluq7nqrKFaT
	 bXNsiBI9YXUgRTdi3A5T7vZsAyJ92QU0Q3z0PkslI8XnI7gFV2yiuSvPygqrTYZP8+
	 1jZZEFytxZr9g==
Date: Mon, 21 Apr 2025 10:18:45 -0700
Subject: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, shinichiro.kawasaki@wdc.com, linux-mm@kvack.org,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
Message-ID: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
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


