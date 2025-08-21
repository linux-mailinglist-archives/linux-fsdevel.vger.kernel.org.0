Return-Path: <linux-fsdevel+bounces-58430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15168B2E9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC12D1CC309D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD301F0E56;
	Thu, 21 Aug 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZGlvBcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B911DDA15;
	Thu, 21 Aug 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737379; cv=none; b=SRLkqmR0lT/iUhZrJQYOnCj7RQMCgu9kamlxArlEVgIL6eOagraTIS2n4tgEyhHGRXgMi4t+GitZ/XPSVWv44r7vaFOg8EqrvQ6bTYpg0yy0szbpDsjmx99olNWgmJ2PjCh90Q15qV6f4QYD81uMWVEI4OILrzHWNfVTmRgzaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737379; c=relaxed/simple;
	bh=QCAyoU9buE9MRdsjyBbMY+MZqXyIoegvcxnr2QwPqrw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkd4qKu8smrRjpZecp+uLu6xu9hUjptlmpDVTrmtz3TtnDLQxIc6OqwY2BFzzfv129SnVeL/HKqzw2OUoxP8kv0JwU/e9NgMWhhYq/fiSX8hxiaLaTgc69yoMrqnZzuOuROgpeKgNoMizY2a2RvP+fV/9kFolgIpAG0ylqiTmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZGlvBcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6C5C4CEE7;
	Thu, 21 Aug 2025 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737378;
	bh=QCAyoU9buE9MRdsjyBbMY+MZqXyIoegvcxnr2QwPqrw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PZGlvBcWSD1lFO/9XtLSknnMlKucI0d2VqIo59bhB9RW78ZonE5xjHnUFFuaWGOkA
	 zirYfYLja0N5ehYyc/s0471B3tPMHm2SJQh4uDQOSIXVB2aDed8B6kcIUnuKN2xpd8
	 tf8F5++mq6e5DqYJ2oiMkmeOfH+HHhW+AgXAmCPgj6HrXz2Wi/RRZ5EazdiQ8BJsTY
	 Lc7RGe12hPxRWUp+isFgZbvQll3bhvqAId4CkfduZ+pCaBESrwqASPT9dMnM+kkAKH
	 IiRmL4eW66XlCKK6caJj+KYBVaA0YcsThD0K5vlmr13YmJG5GJkZ444XkZLZKbcraS
	 iLQanJYbMbFeQ==
Date: Wed, 20 Aug 2025 17:49:37 -0700
Subject: [PATCHSET RFC v4 2/6] libext2fs: refactoring for fuse2fs iomap
 support
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
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

In preparation for connecting fuse, iomap, and fuse2fs for a much more
performant file IO path, make some changes to the Unix IO manager in
libext2fs so that we can have better IO.  First we start by making
filesystem flushes a lot more efficient by eliding fsyncs when they're
not necessary, and allowing library clients to turn off the racy code
that writes the superblock byte by byte but exposes stale checksums.

XXX: The second part of this series adds IO tagging so that we could tag
IOs by inode number to distinguish file data blocks in cache from
everything else.  This is temporary scaffolding whilst we're in the
middle adding directio and later buffered writes.  Once we can use the
pagecache for all file IO activity I think we could drop the back half
of this series.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=libext2fs-iomap-prep
---
Commits in this patchset:
 * libext2fs: make it possible to extract the fd from an IO manager
 * libext2fs: always fsync the device when flushing the cache
 * libext2fs: always fsync the device when closing the unix IO manager
 * libext2fs: only fsync the unix fd if we wrote to the device
 * libext2fs: invalidate cached blocks when freeing them
 * libext2fs: only flush affected blocks in unix_write_byte
 * libext2fs: allow unix_write_byte when the write would be aligned
 * libext2fs: allow clients to ask to write full superblocks
 * libext2fs: allow callers to disallow I/O to file data blocks
 * libext2fs: add posix advisory locking to the unix IO manager
---
 lib/ext2fs/ext2_io.h         |   10 ++
 lib/ext2fs/ext2fs.h          |    4 +
 debian/libext2fs2t64.symbols |    2 
 lib/ext2fs/alloc_stats.c     |    6 +
 lib/ext2fs/closefs.c         |    7 ++
 lib/ext2fs/fileio.c          |   12 +++
 lib/ext2fs/io_manager.c      |   17 ++++
 lib/ext2fs/unix_io.c         |  180 ++++++++++++++++++++++++++++++++++++++++--
 8 files changed, 228 insertions(+), 10 deletions(-)


