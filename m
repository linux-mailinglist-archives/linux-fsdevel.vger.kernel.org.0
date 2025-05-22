Return-Path: <linux-fsdevel+bounces-49605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8FAC00E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423367B13DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23428F1;
	Thu, 22 May 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6gONtfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706418D;
	Thu, 22 May 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872130; cv=none; b=c9oDbtE+CBZwyWlLw6t9MkCDbO2XZtnaveO2xUkyOYSfN0CUC6p7Vc9XRyefXOjXZqN//Tmj4y1IqoewwuoSUal5bqlMr3jzh19UXL5NKPx+kWa/+OJ4FpDXE1MsgBP8A5Kf8nqgy6ok7t9BpDAhnMFBTKq1KIwPJcw6rvVWZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872130; c=relaxed/simple;
	bh=AP3+DLbOgJ8hRs2usGzYmT5QQY2qEhyjM3m0dVA57u4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk9uw3BnFo2zYWlvpShEOfmQ5IDlwurqOVQc7anY+ut2uO2W9HxXnDFT/YGDrEuG5qos4YyX6WNiX/DrY1FR+SdtPUW15nHZEiIQmphM2E5V6t6/lNwLOCHVZZBI0oi96GQo6TJ2EQxRccvxkp0cyu+xwv6OJHSnVFlOnn1V2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6gONtfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF8EC4CEE4;
	Thu, 22 May 2025 00:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872129;
	bh=AP3+DLbOgJ8hRs2usGzYmT5QQY2qEhyjM3m0dVA57u4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=U6gONtfwE/iRe9nTWf/jiPWBtlkgzaNff++Vd1YnxUd5IP/fYarcgoMs8HurApjhu
	 fBNDa1gv4Kms6KbgefgcFA6lvQxG8JejiebONkXPo+LiDBW8rjT/S9B79fK1QCap4E
	 UJh936KQXTc/FWGeyCts8AS7k5GaumgjNlc5t32nTUCntZcyIeX8/OA/UslNQjjC9G
	 jiwLEvMv097XGP1dRFqznLrB0cij+d9wVOVSF9RYRN31Z7FGWKvcHWbx4r8o5oynXY
	 1C2rQJ5roB2v8Z9ny6ELenLnDUysg7nVVXXhnpcYQSuLsjPVuOIJeH2QHfQKKfkABe
	 6EVPqQQxYVj6w==
Date: Wed, 21 May 2025 17:02:09 -0700
Subject: [PATCHSET RFC[RAP] 2/3] libext2fs: refactoring for fuse2fs iomap
 support
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
In-Reply-To: <20250521235837.GB9688@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
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
 * libext2fs: always fsync the device when flushing the cache
 * libext2fs: always fsync the device when closing the unix IO manager
 * libext2fs: only fsync the unix fd if we wrote to the device
 * libext2fs: invalidate cached blocks when freeing them
 * libext2fs: add tagged block IO for better caching
 * libext2fs: add tagged block IO caching to the unix IO manager
 * libext2fs: only flush affected blocks in unix_write_byte
 * libext2fs: allow unix_write_byte when the write would be aligned
 * libext2fs: allow clients to ask to write full superblocks
 * libext2fs: allow callers to disallow I/O to file data blocks
---
 lib/ext2fs/ext2_io.h         |   29 ++++
 lib/ext2fs/ext2fs.h          |    4 +
 debian/libext2fs2t64.symbols |    5 +
 lib/ext2fs/alloc_stats.c     |    7 +
 lib/ext2fs/closefs.c         |    7 +
 lib/ext2fs/fileio.c          |   26 +++-
 lib/ext2fs/io_manager.c      |   56 ++++++++
 lib/ext2fs/unix_io.c         |  281 +++++++++++++++++++++++++++++++++++-------
 8 files changed, 362 insertions(+), 53 deletions(-)


