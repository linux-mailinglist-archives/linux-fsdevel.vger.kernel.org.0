Return-Path: <linux-fsdevel+bounces-55308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302BB09744
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640054A6FF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D52624633C;
	Thu, 17 Jul 2025 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP8bT6Ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F1242D7C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794702; cv=none; b=Zp7orFM7mQbFwgUtFNlLekLYpSWTQAfl8iF2Y+5AlI3NKS9FpIu460ApKhnFf+2pLm74vznxnS9mIbl/kY4LtP+n6YOeFvJxr+oldWPhtg75VDKtMVRxfBFo/4PvJw4Vxgm5UYbsdAviSB77P/rHMDb+dhEIToYES8xxHXwlRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794702; c=relaxed/simple;
	bh=9cMy7yx+JX850KqlLwnbADM2zKTMP/MjP5qyrFJKLTI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sqg63B0Ht7sEFm5wWvc2phzgL+Qqry59qk6v3RbFHTds/dySvXsBQY44jypAmP0j+/wu86ufo+zX2j/o+5ujEh0ux4nw4v/9OTPujPA0nu+VLuDS6NG13XAKX6W031jxPq7OZRdbGdtypXBZuoqZs7n4wGDoQVVuKJsD6rzrUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP8bT6Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6BFC4CEE3;
	Thu, 17 Jul 2025 23:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794701;
	bh=9cMy7yx+JX850KqlLwnbADM2zKTMP/MjP5qyrFJKLTI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OP8bT6Ja/sATWQ0kAppbsPeF0qtXwONAmIfLpwxex0Sq+VSA3o+hTAaTmNQFbafe4
	 ARFQ36tZsyAaZbwhTMdvMMzrvfPj16/yyoQ5W6qGz/ZpJrrLYq4uPfqN/B5AUB/Ytb
	 LnenA1t0x8Q2StBMwByrgJoZNQAehoDcQvvn3e2gxqMLijcU6f5ZfQDyZ61Wn8zil6
	 WDe1mXEl0QCZpTlEdyM2wd6VQXoyl2rxY9v42g5USN2UR3TiI62Uw+/8MHVZZYgjws
	 nJRf62QFGSu1cXIP3G283oTd/lu1//KBAZZNsDzJr7m2sY6/YrUx5brq800B+ZYRZj
	 nGJy1ntw5er1A==
Date: Thu, 17 Jul 2025 16:25:01 -0700
Subject: [PATCHSET RFC v3 1/3] libfuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
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
 * libfuse: add a reply function to send FUSE_ATTR_* to the kernel
 * libfuse: connect high level fuse library to fuse_reply_attr_iflags
 * libfuse: add FUSE_IOMAP_DIRECTIO
 * libfuse: add FUSE_IOMAP_FILEIO
 * libfuse: allow discovery of the kernel's iomap capabilities
 * libfuse: add lower level iomap_config implementation
 * libfuse: add upper level iomap_config implementation
 * libfuse: add strictatime/lazytime mount options
---
 include/fuse.h          |   41 +++++
 include/fuse_common.h   |  118 ++++++++++++++
 include/fuse_kernel.h   |  118 +++++++++++++-
 include/fuse_lowlevel.h |  207 +++++++++++++++++++++++-
 lib/fuse.c              |  408 ++++++++++++++++++++++++++++++++++++++++++-----
 lib/fuse_lowlevel.c     |  294 ++++++++++++++++++++++++++++++++--
 lib/fuse_versionscript  |    9 +
 lib/meson.build         |    2 
 lib/mount.c             |   18 ++
 9 files changed, 1147 insertions(+), 68 deletions(-)


