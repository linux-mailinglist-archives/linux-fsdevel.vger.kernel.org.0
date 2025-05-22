Return-Path: <linux-fsdevel+bounces-49603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD0AC00DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43741BC023F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE92FB6;
	Thu, 22 May 2025 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtr5zPE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48883A50;
	Thu, 22 May 2025 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872083; cv=none; b=royFH7AWyObN3ccFZkWHg6m9JL/2gQ/W3J9j8TRMFMGN6r8Zdz5aBOtLITtMEYE4R1zjq17L5PR6advnS8NE3MT3eb8SZsVhg//uZoipVKfTDuTdpRLjdjHDhTxhmTzFqW+uNevO6vVr4LGiwK5j4sINryBQ0auX5Iu9wR+YOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872083; c=relaxed/simple;
	bh=BC1RwMbo3i81GtugrWB3Rg6/+U8RMVvGtiGqNYTu7jE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ov9mFkqw7WXGB375tLh7u3x+MMPs8KaNxia75WtqoseOOwy7Vy41KgWjBoddk3OtI4X7v6/AncUW5CbavFGrlfH+kvL2tSM2KLE8dUo7gFQEMoybYbFCwlc+d7j6VRc4JK7G4M3tF/fAQrX6X52YA8sz4RlghlUynycWZwF3JDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtr5zPE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCECBC4CEE4;
	Thu, 22 May 2025 00:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872082;
	bh=BC1RwMbo3i81GtugrWB3Rg6/+U8RMVvGtiGqNYTu7jE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Xtr5zPE5otjKrwvCG79wYzjEdtpcybZnY7aIhjSjCPHd0nNMe28hfGjPSHdX65jm9
	 Yme9yGL3na9VZTekwX/JxZY1rPzSWe1P+0FZVqYz/UkwejpMlSIKJYnrq2iFSpPdXU
	 JoWHWSiYFIXSdoxs1X6Y+kyzyNYUPrU1efM6TFDBGRWfIyA4oRqa0/eM3TiNhzaYBJ
	 7AaE7Y6V2niy0YnCARlVEDtQiJDmGBPFgfR7yzK6bQzx+Dxj/ZKYNDecDjtFpceeBC
	 OCm+FPaQmPJ3lJdmy+tqIYg9OKwrGTiLlqBVdu3TbmtYAM349wqnA9wipDUFPcAq+2
	 aMJrGovteY0aA==
Date: Wed, 21 May 2025 17:01:22 -0700
Subject: [PATCHSET RFC[RAP]] fuse: allow servers to use iomap for better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
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

This series connects fuse (the userspace filesystem layer) to fs-iomap to get
fuse servers out of the business of handling file I/O themselves.  By keeping
the IO path mostly within the kernel, we can dramatically improve the speed of
disk-based filesystems.  This enables us to move all the filesystem metadata
parsing code out of the kernel and into userspace, which means that we can
containerize them for security without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap
---
Commits in this patchset:
 * fuse: fix livelock in synchronous file put from fuseblk workers
 * iomap: exit early when iomap_iter is called with zero length
 * fuse: implement the basic iomap mechanisms
 * fuse: add a notification to add new iomap devices
 * fuse: send FUSE_DESTROY to userspace when tearing down an iomap connection
 * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse: implement direct IO with iomap
 * fuse: implement buffered IO with iomap
 * fuse: implement large folios for iomap pagecache files
 * fuse: use an unrestricted backing device with iomap pagecache io
 * fuse: advertise support for iomap
---
 fs/fuse/fuse_i.h          |  135 ++++
 fs/fuse/fuse_trace.h      |  845 ++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  138 ++++
 fs/fuse/Kconfig           |   23 +
 fs/fuse/Makefile          |    1 
 fs/fuse/dev.c             |   26 +
 fs/fuse/dir.c             |   14 
 fs/fuse/file.c            |   85 ++-
 fs/fuse/file_iomap.c      | 1445 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   23 +
 fs/iomap/iter.c           |    5 
 11 files changed, 2730 insertions(+), 10 deletions(-)
 create mode 100644 fs/fuse/file_iomap.c


