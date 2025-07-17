Return-Path: <linux-fsdevel+bounces-55304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555FB09725
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF704A3449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECD241676;
	Thu, 17 Jul 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsri2hQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6022F850
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794640; cv=none; b=D09mxRCDkyoTtkqYzjjfjbQ81MZGiTKO8xlW1EkYOHvEx7wT8XoKZA515wrT/PYcM6wkZBfB+Kul3CTnlVr7HPMaSYeN2RV1KNGSkyBY6WKbiVK6AouoYjiIjVaDjcIBjUhBaKghK+54Tp6B54Y3Of1rOmDUNtXbnSW1FHjD5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794640; c=relaxed/simple;
	bh=wc9QbZkKtu31ja11pGHetFZkKyK1TvfrEuNJfbvUKkY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBM2EZW3Jmn7+zs44PyWajz2p1ixsUsMcMjBwuxNbmzDNpo6hVxBMO0rEw74Q3zLqXk1uv4yHEU2zV5YPqWRHCyf6GJOjIr78avZ20Uex2DH9ZWP2UBB/VLVpJIBRC+i5XQBvnSj2gGBgWoAj9Lvr6snf/xcZbcZVCCdJlCBAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsri2hQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517CCC4CEE3;
	Thu, 17 Jul 2025 23:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794639;
	bh=wc9QbZkKtu31ja11pGHetFZkKyK1TvfrEuNJfbvUKkY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Rsri2hQ1W/ddDDK8/XeChKEIcM5MugU5Uu7zQGqEXMwUqFsj4ngNu+XofowrLtpYN
	 ck/xCFBnQVW9HFFBCrmtDEarw/bzP+Kyxhv9wsfQN9OMLM8sQi4DeVH6CgxRuxf1/8
	 A6klpus2C4Aa9FHjNuc0o9jX1KIp/d2Ydx8ea3M/rVu50uARi/Etxx15Rk31aZHy/y
	 3GHHo5691T8KSGcMw01qd0x9D1SakfHAW9atKx9aa1EI/7CqpUsLXlmuk7UpHFs1tK
	 jIjZbfQR/k70EjJDWnxjd+y1/twWwLOo0nxtP21gnVCAIlF/BQgHIvY4Cg6FO2bw8v
	 qW8HVNhh2xBNw==
Date: Thu, 17 Jul 2025 16:23:58 -0700
Subject: [PATCHSET RFC v3 1/4] fuse: fixes and cleanups ahead of iomap support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
In-Reply-To: <20250717231038.GQ2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-prep
---
Commits in this patchset:
 * fuse: fix livelock in synchronous file put from fuseblk workers
 * fuse: flush pending fuse events before aborting the connection
 * fuse: capture the unique id of fuse commands being sent
 * fuse: implement file attributes mask for statx
 * iomap: exit early when iomap_iter is called with zero length
 * iomap: trace iomap_zero_iter zeroing activities
 * iomap: error out on file IO when there is no inline_data buffer
---
 fs/fuse/fuse_i.h       |    6 ++++++
 fs/iomap/trace.h       |    1 +
 fs/fuse/dev.c          |   44 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/dev_uring.c    |    8 +++++++-
 fs/fuse/dir.c          |    2 ++
 fs/fuse/file.c         |   10 +++++++++-
 fs/fuse/inode.c        |    1 +
 fs/iomap/buffered-io.c |   18 +++++++++++++-----
 fs/iomap/direct-io.c   |    3 +++
 fs/iomap/iter.c        |    5 ++++-
 10 files changed, 89 insertions(+), 9 deletions(-)


