Return-Path: <linux-fsdevel+bounces-65981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DDC17930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EECF1C80497
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38622C3774;
	Wed, 29 Oct 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNvcnrb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E3268C40;
	Wed, 29 Oct 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698370; cv=none; b=ZREapQqkNSdKXmCCnvfktKhqxO83zKIaNWwhDVQS2iPKJ1Ays7mgWD/Cuwr1TbeDtnLxlZka902YohTODZ6cKiVr+1suYxFp6y+rWrTTYsSpsmWt5vnX6jlQwuf13K6hug96ZVeLUt3Gya5KM0CTn3sH7ELqBvX0IBCMou4K+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698370; c=relaxed/simple;
	bh=hBNwtcaXGaeYFAiHMckc88agyjurH41Cgo9xj70eR4g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMslJIqsj6vry+GlY8u4CHlXrgcTfxzJW1SjvuiIW1weHuP0KzP7Qluwdiz28mWyINyJ6NmUACou9lzZYOYXwvHbDDBgVbI4tSedaaFyKA3xLNGiLptzQyP3c8WTqugk5k7VaFVA+hT9f8tzRJPoEpj61FbVfOz87mBajgnCBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNvcnrb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB16BC4CEE7;
	Wed, 29 Oct 2025 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698369;
	bh=hBNwtcaXGaeYFAiHMckc88agyjurH41Cgo9xj70eR4g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XNvcnrb1yDqgUBGeT74pc0fSaLsfZno8Zfky+OfWncgu1yx2lTMUK5q/phgAV3kKs
	 E615gJdcfbjfIIOtVH+N2plHTqt5+AM4qEjkNB8XN0zUf22muXt0WLhflcH8GQLV8X
	 NYI3LEpjT6uu2KnQe+/CkshSdDZi1s9lFKWtcYPNpwnzI1jH7UYUAyOYx5ZyhPuj8g
	 +13bHjQ2CBXno3h/4S6JMlv+Z/AJIXgRRszQayL1qXd7sNDBuLs0We9Jl/y2VfxQ66
	 oYia1Ummso2k1gJh776apq2ivpsMhovOTPC2TAhHB8ZtCDtq7q9rP2gHynVcIQRtcn
	 VuILtLDp7wZeg==
Date: Tue, 28 Oct 2025 17:39:29 -0700
Subject: [PATCHSET v6 7/8] fuse: cache iomap mappings for even better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * fuse: cache iomaps
 * fuse_trace: cache iomaps
 * fuse: use the iomap cache for iomap_begin
 * fuse_trace: use the iomap cache for iomap_begin
 * fuse: invalidate iomap cache after file updates
 * fuse_trace: invalidate iomap cache after file updates
 * fuse: enable iomap cache management
 * fuse_trace: enable iomap cache management
 * fuse: overlay iomap inode info in struct fuse_inode
 * fuse: enable iomap
---
 fs/fuse/fuse_i.h          |   60 ++
 fs/fuse/fuse_trace.h      |  440 ++++++++++++
 fs/fuse/iomap_i.h         |  149 ++++
 include/uapi/linux/fuse.h |   33 +
 fs/fuse/Makefile          |    2 
 fs/fuse/dev.c             |   44 +
 fs/fuse/dir.c             |    6 
 fs/fuse/file.c            |   26 -
 fs/fuse/file_iomap.c      |  541 ++++++++++++++
 fs/fuse/iomap_cache.c     | 1693 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 2968 insertions(+), 26 deletions(-)
 create mode 100644 fs/fuse/iomap_cache.c


