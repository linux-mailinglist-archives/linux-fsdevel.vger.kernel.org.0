Return-Path: <linux-fsdevel+bounces-55305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA49B0972A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21431C45319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6AE2459D5;
	Thu, 17 Jul 2025 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLAkA2Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1FF241676
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794655; cv=none; b=dZQeJuL28Q1mwALHDM2Djry5Ja0mNnYyo4+P/nO6xJh8uG0ePfIhH3B6wQoMAJjTkMbB1ADCu3EGzOUF68iFCbzvpfzgXZ/R50jwSvOgsFb5ZKq81kqcRAt5MlPnXXc6goMMqv+4II7VyZ4TfqwxvqDVuihTnqiCQfn1QNs3xRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794655; c=relaxed/simple;
	bh=2FpaAl/zEDHTuRmYfXUlJPtw82sbKjytFsFfHCgbjws=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSIS0GnP1yRq/arVQur11QP80EGAhDPvAs/cZgJuRkf7ov0hld/h/ydx0cFLnXDZxrwmHdVgwsNSRe44jh4CoYxQFEmemCGJ7Zf2i4YBmzO+8xAkvvr1H1uHzISjkuaSi4DQZfBoqWW8nOMchEkvJnxRFI5lK/VAJ5tiXmI+87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLAkA2Mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11BDC4CEE3;
	Thu, 17 Jul 2025 23:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794655;
	bh=2FpaAl/zEDHTuRmYfXUlJPtw82sbKjytFsFfHCgbjws=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bLAkA2McDdZRl/0yFLK85UAuZ3VqiYaYFztZjX7jV3YY3MPVyNxjT9LND/8Qi1adD
	 WEYP35O7LkFoE6e4qpYMQP0XVsy5qXV1nCwPR6CPekWZfJCwDTNY9x86aQGHxxvx1W
	 2KBfXwMZn/3F8WmX/q0RzidgnBRRbUV82MjNmjcCRYeqyMrgXN5z5CuP5St/YxMxLA
	 dPopehE71CpCKb0jQaSVwv8oyUA/UrFGMGI/91oTalCZzTIPrwGd1LL7xbak7k977l
	 YYmI/qHxH1T9NNze+kHiuqu50HTt7+xSPhfGENEKObNJDZ7rP0jwo79RKDXnQqP8Bz
	 IN8jicMSPBQJw==
Date: Thu, 17 Jul 2025 16:24:14 -0700
Subject: [PATCHSET RFC v3 2/4] fuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
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
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap
---
Commits in this patchset:
 * fuse: implement the basic iomap mechanisms
 * fuse: add an ioctl to add new iomap devices
 * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
 * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse: implement direct IO with iomap
 * fuse: implement buffered IO with iomap
 * fuse: enable caching of timestamps
 * fuse: implement large folios for iomap pagecache files
 * fuse: use an unrestricted backing device with iomap pagecache io
 * fuse: advertise support for iomap
 * fuse: query filesystem geometry when using iomap
 * fuse: implement fadvise for iomap files
 * fuse: implement inline data file IO via iomap
---
 fs/fuse/fuse_i.h          |  164 ++++
 fs/fuse/fuse_trace.h      | 1167 ++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  174 ++++
 fs/fuse/Kconfig           |   24 +
 fs/fuse/Makefile          |    1 
 fs/fuse/dev.c             |   23 +
 fs/fuse/dir.c             |   34 +
 fs/fuse/file.c            |  138 +++
 fs/fuse/file_iomap.c      | 2019 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   53 +
 10 files changed, 3761 insertions(+), 36 deletions(-)
 create mode 100644 fs/fuse/file_iomap.c


