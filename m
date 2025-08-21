Return-Path: <linux-fsdevel+bounces-58422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED2BB2E9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F47A5E2936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C91DDA15;
	Thu, 21 Aug 2025 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9KHP2Qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380A2E403
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737252; cv=none; b=U/xkUAaVVW54P+vBveuvf+BXug7xtGDUsl+bBe6ozYG1zUVh/63haF0ESmheakwdy3qQFJ0RVuLjXJ48/UCjJNVtmz/wyBt5gjpHh52IhOsoSmyjCuA2N3KmGZ2QY/8IorOVzTHYZltJuwvVuLwS8kisWMHW8ltH54+ESBlK+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737252; c=relaxed/simple;
	bh=R3FeoIivyyBHgNcxUCGCJjUdKrFjZmXb+24Ey4Mqpos=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8oFjUuiku004Fa9oAHjNGWkdDxmEOyTQ9LU6HDhkSPmOm7ecdBudELqISREaD2nXMN6ZDVOMj8J/YdEAMnszbEDnnsENFW3Z21LdDj/E5vJrInZHystqS93Z8MXR5y3IDxc/h02rjO97LOAUcy8AFlZDZq9s7Eqvx2aaphjNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9KHP2Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A24C4CEE7;
	Thu, 21 Aug 2025 00:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737251;
	bh=R3FeoIivyyBHgNcxUCGCJjUdKrFjZmXb+24Ey4Mqpos=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=r9KHP2QjLgvmyYEqfIhLvWQXNxnvOwnafyUbMxy8/JkkRuPm+1q+Z9z5MWLrP13Ma
	 SAMau7a7+7NU3/pyB+42TIPnfhDmlfD2K+ak7bcScIqOpMrsRAwFkj9+1jorgDD570
	 r8TAWp2yDYFLF76nkgMbXuQJX8MfefAuBXX45WUFEnDGNA+9AzzI1CVU4mqiROreR4
	 f0Ks2Y+jZMpO23E5IcALiP6sLBH1IZwtAaqPcjGwydQrMQOeuyOgZ+E/0roWwrxnOF
	 V+4igP5xP/jSVkLow8Jazlt7HJL8IldQV7S22KxGM6vsKqrXOUl5HvVJfwmWTYoorn
	 CinA7/jkecPRA==
Date: Wed, 20 Aug 2025 17:47:30 -0700
Subject: [PATCHSET RFC v4 2/4] fuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
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
 * fuse: move CREATE_TRACE_POINTS to a separate file
 * fuse: implement the basic iomap mechanisms
 * fuse: make debugging configurable at runtime
 * fuse: move the backing file idr and code into a new source file
 * fuse: move the passthrough-specific code back to passthrough.c
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
 * fuse: make the root nodeid dynamic
 * fuse: allow setting of root nodeid
 * fuse: invalidate ranges of block devices being used for iomap
 * fuse: implement inline data file IO via iomap
 * fuse: allow more statx fields
 * fuse: support atomic writes with iomap
 * fuse: enable iomap
---
 fs/fuse/fuse_i.h          |  249 +++++
 fs/fuse/fuse_trace.h      |  996 +++++++++++++++++++++
 fs/fuse/iomap_priv.h      |   52 +
 include/uapi/linux/fuse.h |  195 ++++
 fs/fuse/Kconfig           |   45 +
 fs/fuse/Makefile          |    5 
 fs/fuse/backing.c         |  237 +++++
 fs/fuse/dev.c             |   35 +
 fs/fuse/dir.c             |  117 ++
 fs/fuse/file.c            |  133 ++-
 fs/fuse/file_iomap.c      | 2183 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   92 +-
 fs/fuse/passthrough.c     |  199 +---
 fs/fuse/readdir.c         |   10 
 fs/fuse/trace.c           |   15 
 15 files changed, 4316 insertions(+), 247 deletions(-)
 create mode 100644 fs/fuse/iomap_priv.h
 create mode 100644 fs/fuse/backing.c
 create mode 100644 fs/fuse/file_iomap.c
 create mode 100644 fs/fuse/trace.c


