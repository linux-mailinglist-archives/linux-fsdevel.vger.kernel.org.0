Return-Path: <linux-fsdevel+bounces-61486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD5B58919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781C83B4502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339531A00F0;
	Tue, 16 Sep 2025 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAL834UI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB0625;
	Tue, 16 Sep 2025 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982148; cv=none; b=VCs+LeYjix9jQv9GLqA8NKSXiNM3G9tMefKRbD38lO5Kh4X2pPla4qK0WY8+DjyRx11FZ7pIt6XUr86cw3hXoGK+nSpsI//u3/QJMJLa56bW2r4fkhU8zsekNiK+VZCw926OTofzEXwndL0tEDsPog3wqK1nrBABazFVedd/UBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982148; c=relaxed/simple;
	bh=QCAyoU9buE9MRdsjyBbMY+MZqXyIoegvcxnr2QwPqrw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdPTL/26Qiu1qmoNg7Yy6JaDi/5eNbtQUYw7EOW7ATabIvb5s5pOtNJeBlTc00L8FJHuLZ7vulhasjlv7kfZVsqZ0QoxB5MFODf+p2hgdcMn7PnnJiQfq37b23/NOMrZrlhOMHGgR2obi9Rdn6jmLx9tIWZhk2zcBXIlN5fKsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAL834UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6519EC4CEF1;
	Tue, 16 Sep 2025 00:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982148;
	bh=QCAyoU9buE9MRdsjyBbMY+MZqXyIoegvcxnr2QwPqrw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WAL834UINnG/KQG3ZiK3hcc7wxQ3bj01cik2OkY0mk4nESGSSZUZ2InNsWOHYK76J
	 t4/5LDNt35CJk0IR/wbsNXfnkfpXcZv+GOAGt8QpeI7ZsthV1RzlktDNlsffWzbYrW
	 W9rAEh8Zp+MHc1cbMuYCiHTy+UdnAfYV0UXC6aOVeI7iZ+cade45lb2HOHqBwg6vbe
	 nQTjcV3usOlOMwM2/L5s99mRdDrGQ3rxc00n67Ch+ve3dGg6adJbAYkVuTDH6muDvc
	 40/6UTMNVTN92BN10eXaBMWNdgJZwkjg8OrcXe4zNO+ME76B7QWr52uFofZN/PRZ7c
	 A5JHrAQ/RkGTg==
Date: Mon, 15 Sep 2025 17:22:27 -0700
Subject: [PATCHSET RFC v5 3/9] libext2fs: refactoring for fuse2fs iomap
 support
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
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


