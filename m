Return-Path: <linux-fsdevel+bounces-16976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728398A5E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2921A1F216EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B7159202;
	Mon, 15 Apr 2024 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H91za7sf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39315749D;
	Mon, 15 Apr 2024 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224042; cv=none; b=bE+BdjNFixTuTCr3KxX8P9BCPd4j3plKfqKEhjMVdQUE7vTvny4GlYN0sQV5YVNjJg8mP/I2Q/wFklG6phIxIboSCae/kcPQTMQz3/pFKzJSRBsLXINhoDdcI4wQ5uSW0xRT5217aEEhQbMcSdzdBguFbOkai+0bfQGE+tMRFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224042; c=relaxed/simple;
	bh=9wjkw4K2cO9LzwYifdhmRt96sjojvF9SAKcBGEWXJ04=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1pGWbo+oQ/eodBByglQNGvOzWzdcqqOgvnZXuUFbP2kv7//0uDRsHfK1ldiTrHVT6/e3aI9Qmg13qVPufOq+Xy8tF2LGb5NUnrnRf+lFWMcSf/LKwgX2ggRoQw4p1YPW8bV7MpGO7MFhbuJIW2zaVL9TsLiCQPMBPLK7wYKFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H91za7sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6F6C113CC;
	Mon, 15 Apr 2024 23:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224042;
	bh=9wjkw4K2cO9LzwYifdhmRt96sjojvF9SAKcBGEWXJ04=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H91za7sfhn4T6jaPhPnyTVlawuRGHQmPrrLT0snbzRqSsWt+C9A8jhUviLlO19YM9
	 iAKj2MeLu2GreEa+0kitUyfQxpHZN6UfOayMpmRnMCCrFE76W873SAUUGwEQnhPm+0
	 tm9CFgiFneuN1GFqYhR1U4z8CwezRO0a7KkMA8UQWaubghDjhDmCM4PWHBe3XNwQYF
	 xReB/e9AsbW6Nj2pr1s5+Kcp3PmyaGqbZkaoLo9XQJUraeWPLJYfuBHRqtCZ2qIl+n
	 QrY8+bhlQpwgPSFl4v/0RPkbaEYRtI3dhxzvLlW8ElyCySiE9GOAD4TIkZ4AxyCn0h
	 1okrGVu1G93Lw==
Date: Mon, 15 Apr 2024 16:34:01 -0700
Subject: [PATCHSET v30.3 02/16] xfs: refactorings for atomic file content
 exchanges
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
In-Reply-To: <20240415232853.GE11948@frogsfrogsfrogs>
References: <20240415232853.GE11948@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series applies various cleanups and refactorings to file IO
handling code ahead of the main series to implement atomic file content
exchanges.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=file-exchange-refactorings-6.10
---
Commits in this patchset:
 * xfs: move inode lease breaking functions to xfs_inode.c
 * xfs: move xfs_iops.c declarations out of xfs_inode.h
 * xfs: declare xfs_file.c symbols in xfs_file.h
 * xfs: create a new helper to return a file's allocation unit
 * xfs: hoist multi-fsb allocation unit detection to a helper
 * xfs: refactor non-power-of-two alignment checks
 * xfs: constify xfs_bmap_is_written_extent
---
 fs/xfs/libxfs/xfs_bmap.h |    2 +
 fs/xfs/xfs_bmap_util.c   |    4 +-
 fs/xfs/xfs_file.c        |   88 ++++------------------------------------------
 fs/xfs/xfs_file.h        |   15 ++++++++
 fs/xfs/xfs_inode.c       |   75 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h       |   16 +++++---
 fs/xfs/xfs_ioctl.c       |    1 +
 fs/xfs/xfs_iops.c        |    1 +
 fs/xfs/xfs_iops.h        |    7 ++--
 fs/xfs/xfs_linux.h       |    5 +++
 10 files changed, 121 insertions(+), 93 deletions(-)
 create mode 100644 fs/xfs/xfs_file.h


