Return-Path: <linux-fsdevel+bounces-58426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A5B2E9AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71F31CC2B3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1471E32D3;
	Thu, 21 Aug 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/zji7WD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A801B2186
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737315; cv=none; b=pVuTmV2BJCF6UZYt4qcavaZoPehYLI4COJwFufc6FcoLD3NssrePw6vMLdSK/Di6pgOmk7YyT0/1QiAJQKmWp6Rmxts6eydvMSDauPP8bzgbYqMnBPqz0quETuvVUF+hvu9REhlGu8tgJEXLbZzAPcdgQKK+EMP/+zjc7q1gz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737315; c=relaxed/simple;
	bh=i0WPIpGW72UFexWL1PYVbw+AJaOVvchN6cLZMidNtPU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOTS10pxErPMqy1Qhc2BlAcvwZr84gAZFggfY/BnN4sZHXtNN9OeApz/P3aQ6LiOqiut9hKNhwrFjjZz8ual6a2OqW8JHt5xcIa57mOxQc479mdMOEIlb3NEQmhqrkt9fuTmrAKyegN95S/rq9Wq3o/ABdCnwS6bnBQQSJyZpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/zji7WD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D274C4CEE7;
	Thu, 21 Aug 2025 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737313;
	bh=i0WPIpGW72UFexWL1PYVbw+AJaOVvchN6cLZMidNtPU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S/zji7WD8Byr1V1UaDpNPSvmwQuHIMU481kNLiZNkJjwAAe75S69b5amEYbyk1AnQ
	 Uc54AAHs9WHt7DryLkcN2cC/gDEbrPVwAAaoAQOlVgNUbUwXycZo0RTzRvjGexErUU
	 fQaU7j05Mrip0aQodgvBaDpQYsZ7q9p/tSiJfmTDFDwFmgWxOGrEo4D0pWDSNIzejA
	 +4xcNqV9kTE9so4V99pHkkrX822NDmFdT2d8qimAo2Lma+pqClsKhxSraNkFf2cQSQ
	 WOp1ZQjqU+ddjINazn5TI//2cncSzQ8gHxUvxx0QoPe6KdHpWSkGcgeIfaCiBB5/49
	 hb9NXpH7ja8Tg==
Date: Wed, 20 Aug 2025 17:48:33 -0700
Subject: [PATCHSET RFC v4 2/4] libfuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
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
 * libfuse: bump kernel and library ABI versions
 * libfuse: add kernel gates for FUSE_IOMAP
 * libfuse: add fuse commands for iomap_begin and end
 * libfuse: add upper level iomap commands
 * libfuse: add a lowlevel notification to add a new device to iomap
 * libfuse: add upper-level iomap add device function
 * libfuse: add iomap ioend low level handler
 * libfuse: add upper level iomap ioend commands
 * libfuse: add a reply function to send FUSE_ATTR_* to the kernel
 * libfuse: connect high level fuse library to fuse_reply_attr_iflags
 * libfuse: support direct I/O through iomap
 * libfuse: support buffered I/O through iomap
 * libfuse: don't allow hardlinking of iomap files in the upper level fuse library
 * libfuse: allow discovery of the kernel's iomap capabilities
 * libfuse: add lower level iomap_config implementation
 * libfuse: add upper level iomap_config implementation
 * libfuse: allow root_nodeid mount option
 * libfuse: add low level code to invalidate iomap block device ranges
 * libfuse: add upper-level API to invalidate parts of an iomap block device
 * libfuse: add strictatime/lazytime mount options
 * libfuse: add atomic write support
---
 include/fuse.h          |   86 ++++++++
 include/fuse_common.h   |  131 +++++++++++++
 include/fuse_kernel.h   |  113 +++++++++++
 include/fuse_lowlevel.h |  238 +++++++++++++++++++++++
 ChangeLog.rst           |   12 +
 lib/fuse.c              |  484 ++++++++++++++++++++++++++++++++++++++++++-----
 lib/fuse_lowlevel.c     |  370 ++++++++++++++++++++++++++++++++++--
 lib/fuse_versionscript  |   20 ++
 lib/meson.build         |    2 
 lib/mount.c             |   19 ++
 meson.build             |    2 
 11 files changed, 1400 insertions(+), 77 deletions(-)


