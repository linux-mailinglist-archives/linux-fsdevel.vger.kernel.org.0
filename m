Return-Path: <linux-fsdevel+bounces-49604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3BAC00DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C184E5F50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE5EC5;
	Thu, 22 May 2025 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2HQifvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C180367
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872099; cv=none; b=o+66Ot2N893xiEVx3pybjEtUzT+6j5uECBHX/MxCR3lHhc8h/1U9ok6gx+SPozNK5yZvPWkRxePh6zfhsXO0TITD+Ri6aeq9ccdW0CABIH3ln6tro3+128tUURrcY1vPKi3ZDy7bSG/WZkQV9F2oI4Ob58HrdP1t8ZdvdYM59Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872099; c=relaxed/simple;
	bh=Fw0vD3uRLud7Qljy10YgVqNuSSrsb2cd0hMerZRZhqM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNMSQVyftYvWF7LtlwQGsalZR3zZAKMcPy9FAK0gX1X03L6WM9HU0RR7+k76OtfXwBm+mLIhtkqjN2tgm/XPZ5/y1o9lC0LXpYjY03zYZVSzvSGo/ueDiCeiORwy0zj6y1DZpxWBEz8UGLCxd8ASsLqkECigTLWv+5dQfdtk1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2HQifvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E640C4CEE4;
	Thu, 22 May 2025 00:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872098;
	bh=Fw0vD3uRLud7Qljy10YgVqNuSSrsb2cd0hMerZRZhqM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D2HQifviayF9rztQC6Fno6yFCz7KMv1woR7Ll8bYMm+v5rYYgrbUhFd5BhWe2PxYG
	 fgZSJIHMcGIWYvsBq1rcTZAA3w5G/S0yhGreE4O1WCrzVyhCUdF//WmiVFKRrU3QMI
	 xxK66l4YXX2x85uiTX8NNfJyrmN+vdHBC446P0xeWI3eD85jiTt7M8MFWgDCSqO2li
	 YvK1wu2zWyT56aqsJxjLjK22D1X7fWc3yv1r8wqi3YsGADNdlep93JwWDUpJXh3a2z
	 oQFqJo6/IAo1dAjyeu0QlIlvpPWEND9YXKM9lU4HqvvZPheFurMNQh3mEOq3/sr4DW
	 Lx8dV8NfbsaSQ==
Date: Wed, 21 May 2025 17:01:37 -0700
Subject: [PATCHSET RFC[RAP]] libfuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
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

This series connects libfuse to the iomap-enabled fuse driver in Linux to get
fuse servers out of the business of handling file I/O themselves.  By keeping
the IO path mostly within the kernel, we can dramatically improve the speed of
disk-based filesystems.  This enables us to move all the filesystem metadata
parsing code out of the kernel and into userspace, which means that we can
containerize them for security without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap
---
Commits in this patchset:
 * libfuse: add kernel gates for FUSE_IOMAP and bump libfuse api version
 * libfuse: add fuse commands for iomap_begin and end
 * libfuse: add upper level iomap commands
 * libfuse: add a notification to add a new device to iomap
 * libfuse: add iomap ioend low level handler
 * libfuse: add upper level iomap ioend commands
 * libfuse: add FUSE_IOMAP_PAGECACHE
 * libfuse: allow discovery of the kernel's iomap capabilities
---
 include/fuse.h          |   20 ++++++
 include/fuse_common.h   |   80 ++++++++++++++++++++++
 include/fuse_kernel.h   |   89 ++++++++++++++++++++++++-
 include/fuse_lowlevel.h |   95 ++++++++++++++++++++++++++
 lib/fuse.c              |  142 +++++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  170 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 lib/meson.build         |    2 -
 8 files changed, 597 insertions(+), 3 deletions(-)


