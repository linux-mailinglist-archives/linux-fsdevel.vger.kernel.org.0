Return-Path: <linux-fsdevel+bounces-58434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B032AB2E9BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6757B492F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0E1F0E56;
	Thu, 21 Aug 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBB6UcUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6C18991E;
	Thu, 21 Aug 2025 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737442; cv=none; b=I/RxXKbnoY4bD92YnWAdL46/+11fFjKTMQ9P9qQxdbRKnSjOdMFDYLJSUkw7n5ilcRrAf6+f3vaYmAYdN3tZewxPkeOnkHLqbD86a03c1VdNhsZ2KaCl5vGAthuiOkBPLtyeQ7ta3K53E3BKtJFdxeWPItF6oM+ztHJhz3/vH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737442; c=relaxed/simple;
	bh=uRTLz5MW0rXEivC2UHhkkaBYnG2xr8sbLWZoKmm0jMA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvH28edbpTpDNwWD5cdLg+wkqF3H4qXhX4kmEE9PY3HiBxHdFkwTIp3Cj2EoRgRPEsn25d10iWlR4dOFqcvVUpOQlnLHHfnUU4B5YJE3roXpE+blKI1ttVJNnZWv6iizBgSRSA8n+VP+vYMpzAfc8xo/IfsrhmgZZ3SDInr+3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBB6UcUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECCBC4CEE7;
	Thu, 21 Aug 2025 00:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737441;
	bh=uRTLz5MW0rXEivC2UHhkkaBYnG2xr8sbLWZoKmm0jMA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gBB6UcUMKeQsdql1YMc/hPnFDTLRvdMjoPJpgghWjeTaVu5wCcMAWYqCdxsyW9kmp
	 z+5xUj36x8UuIjDL+m6ObQfEoo+MI8ols2QntXKGjKTSlKGjH4Bm7CBwepU2SwjUei
	 Q4hWcL4D4XG4DUDlaJrQjRrQplWrByCxNPRyNUnAsnGusjnvFZcCrhEN9quIsw6nif
	 EzPsOtgPU7PXmDH+J9eeniWJ7bjzhXrSzyu/mAJzVvTCXd5ZP7Mu0Rx6fHdSa9R0ro
	 YsBKAttQ/Pr6nv6UFdIhLhdIMvTJJJo3NrVdmGJqmee+mYd1J07VRN9SIP1SL9vUUE
	 HyGjDFm7UP+hQ==
Date: Wed, 20 Aug 2025 17:50:40 -0700
Subject: [PATCHSET RFC v4 6/6] fuse2fs: improve block and inode caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
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

This final series ports the libext2fs inode cache to the new cache.c
hashtable code that was added for fuse4fs unlinked file support and
improves on the UNIX I/O manager's block cache by adding a new I/O
manager that does its own caching.  Now we no longer have statically
sized buffer caching for the two fuse servers.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-caching
---
Commits in this patchset:
 * libsupport: add caching IO manager
 * iocache: add the actual buffer cache
 * iocache: bump buffer mru priority every 50 accesses
 * fuse2fs: enable caching IO manager
 * fuse2fs: increase inode cache size
 * libext2fs: improve caching for inodes
---
 lib/ext2fs/ext2fsP.h    |   13 +
 lib/support/cache.h     |    1 
 lib/support/iocache.h   |   17 +
 debugfs/Makefile.in     |    4 
 e2fsck/Makefile.in      |    4 
 lib/ext2fs/Makefile.in  |    4 
 lib/ext2fs/inode.c      |  215 +++++++++++---
 lib/ext2fs/io_manager.c |    3 
 lib/support/Makefile.in |    6 
 lib/support/cache.c     |   16 +
 lib/support/iocache.c   |  740 +++++++++++++++++++++++++++++++++++++++++++++++
 misc/Makefile.in        |    7 
 misc/fuse2fs.c          |   75 +----
 misc/fuse4fs.c          |   73 -----
 resize/Makefile.in      |    4 
 tests/progs/Makefile.in |    4 
 16 files changed, 990 insertions(+), 196 deletions(-)
 create mode 100644 lib/support/iocache.h
 create mode 100644 lib/support/iocache.c


