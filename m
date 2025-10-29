Return-Path: <linux-fsdevel+bounces-65983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9432C1793C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1A2F4E8311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7E2D0292;
	Wed, 29 Oct 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Leeu7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D314268C40;
	Wed, 29 Oct 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698401; cv=none; b=ZNVzLJCG5h690FayjFmh1QDNl0h0ZcvyUemtvCVKRgQdgKzgCYOsgqoWyrgbSCHJkmFpQDUXzcl+SCBdqajWCB2+9pe2urKVdpVYjRNYuW8LZLk7/RdsgV+76tNC11pdWzKkTfOMRJccEORI1bbRdPJsrG5BZcDetnd+oQ3pMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698401; c=relaxed/simple;
	bh=kwRF23NGdQBGblTa+PkkvO8QIaFr1Wa4S9jqSoNaybA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdOwvii2NJjH34KQU3Nl+h3MCkQ9fvqlndIAg0JtYojl8aT+vXNZqz5z6IVgbD06iHb/P/0p1M7piXh9S2R1QNTG3fFQZkgTv0ZuUnjm6zBWRm9nM6k6nPgodbvKg5Bn+sWCP1ek/Gxx4Fo7ip+licUvNmW5In4utHIYFDTOoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Leeu7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBE0C4CEE7;
	Wed, 29 Oct 2025 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698401;
	bh=kwRF23NGdQBGblTa+PkkvO8QIaFr1Wa4S9jqSoNaybA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g6Leeu7klDOohjYOgp8C1o1LDjSVBxTvUm+grU1MqE6X84rgfne8Zp0ihf4jPRk5g
	 ZidPn0urMu9zs8CGYbcA5ksxcv7mYTrTlnOUTnwC2ST5f+SewAPuKPS6VBFdIw+HR3
	 i5ucIKqahMRjnzePvDm80UMClbRT7E1gjftGTRx+0LBa10ZU3FGc8GTroLfhiIWVVK
	 AfHY6OhgHDPx2L2pcITOOXkTUrVloZW0IUum+fjfmTmuKphChjbeu7dZ5mQCM7M8up
	 fimDTyTvgbzl9H39aVDLyws5O+3O29yVo1Uh/Jv49iOSG2YICiKua43xVT0dPKqXwK
	 hsrp8ofsTKc7A==
Date: Tue, 28 Oct 2025 17:40:00 -0700
Subject: [PATCHSET v6 1/5] libfuse: allow servers to use iomap for better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
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
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
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
 * libfuse: don't allow hardlinking of iomap files in the upper level fuse library
 * libfuse: allow discovery of the kernel's iomap capabilities
 * libfuse: add lower level iomap_config implementation
 * libfuse: add upper level iomap_config implementation
 * libfuse: add low level code to invalidate iomap block device ranges
 * libfuse: add upper-level API to invalidate parts of an iomap block device
 * libfuse: add atomic write support
 * libfuse: create a helper to transform an open regular file into an open loopdev
 * libfuse: add swapfile support for iomap files
 * libfuse: add lower-level filesystem freeze, thaw, and shutdown requests
 * libfuse: add upper-level filesystem freeze, thaw, and shutdown events
---
 include/fuse.h          |  101 ++++++++
 include/fuse_common.h   |  141 +++++++++++
 include/fuse_kernel.h   |  130 ++++++++++
 include/fuse_loopdev.h  |   27 ++
 include/fuse_lowlevel.h |  278 ++++++++++++++++++++++
 ChangeLog.rst           |   12 +
 include/meson.build     |    4 
 lib/fuse.c              |  584 +++++++++++++++++++++++++++++++++++++++++++----
 lib/fuse_loopdev.c      |  403 ++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  437 ++++++++++++++++++++++++++++++++++-
 lib/fuse_versionscript  |   21 ++
 lib/meson.build         |    5 
 meson.build             |   13 +
 13 files changed, 2080 insertions(+), 76 deletions(-)
 create mode 100644 include/fuse_loopdev.h
 create mode 100644 lib/fuse_loopdev.c


