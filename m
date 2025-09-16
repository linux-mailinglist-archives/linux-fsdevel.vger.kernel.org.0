Return-Path: <linux-fsdevel+bounces-61474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C8B58905
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466C3520A09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1519F43A;
	Tue, 16 Sep 2025 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M80JViEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18D19CC28;
	Tue, 16 Sep 2025 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981946; cv=none; b=scxOTs3LjX9DYqZqvDiPF8WGokmC0H/sWuz4QwQfTS+u3Y/jN9Tg9/l+dPRUfqTSJRmCN0PLAVjv9ZInhLtw+dSZxoVMJNXWWCGxb4d93PF8s2I7xWGHg0fJcmgADqwgp/RBBpIpldwVEY8CZXruv0aK8tROIPwB1TEFjNNtKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981946; c=relaxed/simple;
	bh=kJ7es16wIZjWlflLniEdtgot4aDo6nguFd5atULtJXw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXKvn06q+LdX4qj44aDT2SkIZ7ePkqGsgwjj1RMvFZkAjxdO/mJt9TO0OxR+VmwIgM5HGQMVyLH2kGXg387FO4rtxaZdIU2aIpzQ02Ct9q21jyJmg4HbmHyva4c5QvzinE6XegZFu10vNG59acoB8gIzWuzxOMQn4KQbcNoHtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M80JViEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9960FC4CEF1;
	Tue, 16 Sep 2025 00:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981945;
	bh=kJ7es16wIZjWlflLniEdtgot4aDo6nguFd5atULtJXw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=M80JViElh0rJ30St0epmaAyH0ougJlXVhsLc1UwQ4pYgBuB50wJfLpoxtWU2gGMZB
	 EeZarUu9XeC51OWVqJdrRwOYbwOPVIYrUxF47nTYrSKmpU3oBwMONS7K705of1QBM+
	 wIYdr+441+WFShv4Quwb85YvRxe/PorViZg6zQkYgUfkuZTRQ6l3lQHXTdf+zrXIby
	 26vgxtZ4gkrX5lu00cjDQMSvTj0BjdI+1FDvTTJYrRTD76/rBRFkLxGCmRfb1hkVzW
	 iEBhXgji96vhkdLRuyQNsj++UXll3YwcjO55IzE/Xkw7aFWUNz223SD9cmch48ziCV
	 nq5MXiUIC5HXw==
Date: Mon, 15 Sep 2025 17:19:05 -0700
Subject: [PATCHSET RFC v5 4/8] fuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series connects fuse (the userspace filesystem layer) to fs-iomap
to get fuse servers out of the business of handling file I/O themselves.
By keeping the IO path mostly within the kernel, we can dramatically
improve the speed of disk-based filesystems.  This enables us to move
all the filesystem metadata parsing code out of the kernel and into
userspace, which means that we can containerize them for security
without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
---
Commits in this patchset:
 * fuse: implement the basic iomap mechanisms
 * fuse_trace: implement the basic iomap mechanisms
 * fuse: make debugging configurable at runtime
 * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
 * fuse: create a per-inode flag for toggling iomap
 * fuse_trace: create a per-inode flag for toggling iomap
 * fuse: isolate the other regular file IO paths from iomap
 * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse: implement direct IO with iomap
 * fuse_trace: implement direct IO with iomap
 * fuse: implement buffered IO with iomap
 * fuse_trace: implement buffered IO with iomap
 * fuse: implement large folios for iomap pagecache files
 * fuse: use an unrestricted backing device with iomap pagecache io
 * fuse: advertise support for iomap
 * fuse: query filesystem geometry when using iomap
 * fuse_trace: query filesystem geometry when using iomap
 * fuse: implement fadvise for iomap files
 * fuse: invalidate ranges of block devices being used for iomap
 * fuse_trace: invalidate ranges of block devices being used for iomap
 * fuse: implement inline data file IO via iomap
 * fuse_trace: implement inline data file IO via iomap
 * fuse: allow more statx fields
 * fuse: support atomic writes with iomap
 * fuse: disable direct reclaim for any fuse server that uses iomap
---
 fs/fuse/fuse_i.h          |  172 ++++
 fs/fuse/fuse_trace.h      |  936 +++++++++++++++++++
 fs/fuse/iomap_priv.h      |   52 +
 include/uapi/linux/fuse.h |  201 ++++
 fs/fuse/Kconfig           |   48 +
 fs/fuse/Makefile          |    1 
 fs/fuse/backing.c         |   12 
 fs/fuse/dev.c             |   30 +
 fs/fuse/dir.c             |  120 ++
 fs/fuse/file.c            |  133 ++-
 fs/fuse/file_iomap.c      | 2165 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   66 +
 fs/fuse/iomode.c          |    2 
 fs/fuse/trace.c           |    2 
 14 files changed, 3892 insertions(+), 48 deletions(-)
 create mode 100644 fs/fuse/iomap_priv.h
 create mode 100644 fs/fuse/file_iomap.c


