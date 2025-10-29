Return-Path: <linux-fsdevel+bounces-65978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC814C17915
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 774C3351BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F142D0292;
	Wed, 29 Oct 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sucTiKz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671D268C40;
	Wed, 29 Oct 2025 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698323; cv=none; b=Y1MrHhOT6owGtk5rgvzot6AIdeHF9GZ034+NpdwWgVaam9OdtaJAV8Hj9ZR1N+BLdxxbwURmhzmH9ruOtb7otLH72ABrU3lL4Lifo80NhmuFW7Byyk290HDGwAqTvszbJQ3LKH9F8JI3U/niCmPTktm73xy+j7Ac+7KsfKoBrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698323; c=relaxed/simple;
	bh=x1XuHQkfDLD5lH8/ivotoUEmJO30uUfCUwk5lgw5ehA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCfN7erV+Sv/3JvMKXkkYxivJ3XCa1bOfnvmLP80EpT2of4t+SZIOmOVXlQzkMYF19TYK/VoBXQdW3RZY/wQBxCaBdt+e61sYCUWShgsc06nm6qbpX/bprjAjTSEcRzncEWabp8F2gG4ROXQa8c0N0HxvDsptkLB/L/XbrP9OZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sucTiKz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76FC4CEE7;
	Wed, 29 Oct 2025 00:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698322;
	bh=x1XuHQkfDLD5lH8/ivotoUEmJO30uUfCUwk5lgw5ehA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sucTiKz73x76UcJQQ31AXZjlvjzaNaygODdUYvLLCTExuddvbC2TBjW8ktDqE+yxz
	 oIJzXXpPu9JPsZNaa98/gAsvjSD6nRMuSTlcsniomZZaFYWtoYFeZSJ48w+IImBuhO
	 x5Bfgqmzlx1Nn0S7Fh8caKsJETWtSP/+NRuD5U5htdLubQqaTIsn3vexVN4mzXqK1N
	 2bE9ML4Pkrte4WFzBbhcMZ7YKSQHApXB2A6e5wzJEBeZ8/ByDX09FQVNcY877RMLHD
	 WzPtTkyGPAAclaXuK8Dv4A63fAja/MbbWt93+4nGkuhhzx7DyYZOyMGsMnUhgF0FpM
	 NJLgfFsQljTWg==
Date: Tue, 28 Oct 2025 17:38:42 -0700
Subject: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
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
 * fuse_trace: support atomic writes with iomap
 * fuse: disable direct reclaim for any fuse server that uses iomap
 * fuse: enable swapfile activation on iomap
 * fuse: implement freeze and shutdowns for iomap filesystems
---
 fs/fuse/fuse_i.h          |  161 +++
 fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
 fs/fuse/iomap_i.h         |   52 +
 include/uapi/linux/fuse.h |  219 ++++
 fs/fuse/Kconfig           |   48 +
 fs/fuse/Makefile          |    1 
 fs/fuse/backing.c         |   12 
 fs/fuse/dev.c             |   30 +
 fs/fuse/dir.c             |  120 ++
 fs/fuse/file.c            |  133 ++-
 fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |  162 +++
 fs/fuse/iomode.c          |    2 
 fs/fuse/trace.c           |    2 
 14 files changed, 4056 insertions(+), 55 deletions(-)
 create mode 100644 fs/fuse/iomap_i.h
 create mode 100644 fs/fuse/file_iomap.c


