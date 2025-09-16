Return-Path: <linux-fsdevel+bounces-61480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65410B58910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264BE480D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FF19EEC2;
	Tue, 16 Sep 2025 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgdiCknN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51488625
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982039; cv=none; b=VCarAmpVizfCWr6HuLulLb9j2jUWaakSFqnUO5VowKt7v66lVJJxyaHc5DZV2kOshs7X5NobIm6m6tW1UKJYAnLl06SbOJzXazKdUILH5j8FrJUfECmVFh/KzB24CU00TLtUoNZ4ird8l+A7HvUEb5uYDNJfnp1lDw8oIcCU+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982039; c=relaxed/simple;
	bh=VrNCHpnqqIgAV7exM8PGoqYzyHSS6llyZxlRJiu2jNg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCM1U1p6bWujJbuS3E9PfLorgktYSeDQw/dnnPBbSVSQTcA97mOXWkmui6Hak7YsiVlQ3uSRgDXgxhk9aaS6YQnbsBB3gfOY52jSlwlJTRAD6NjOKah26bxanlmWoIjX1VboQ9ZD2Mlq3arP687I7gh1Z4dDFvVld7MSMNBTEsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgdiCknN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29193C4CEF1;
	Tue, 16 Sep 2025 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982039;
	bh=VrNCHpnqqIgAV7exM8PGoqYzyHSS6llyZxlRJiu2jNg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YgdiCknNhT08JGAZ39+xpfb7OIWLQ3jMI6GH1ltd1XlSDQ2hJAm/fcY70qEu/k/us
	 JXP+BVWsLl8dYo89MijZo008iUq/vstWvUnzDze5OkQgdG0e4ji+bD8SHxS+1IJxMc
	 eTZbj2qTq2i6yFW2x0V9wk+ALg9eBk0kw8NlKyCNPwzoqdDEgV/o0vFAojwQhz8DO3
	 hypppV7YOUeL6SailzDFRchiFzVW4swVSTBX5QOhl6zMsysCHw61zAmXbPBnhbFucn
	 nipV0JLpTrsNYx1Dur2jG4a5T/h2crEgfDwijNwx8btMPZIC/4T/xtEMFEPnvKxuQs
	 F6rt4C5NrzN7A==
Date: Mon, 15 Sep 2025 17:20:38 -0700
Subject: [PATCHSET RFC v5 2/6] libfuse: allow servers to use iomap for better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
---
 include/fuse.h          |   86 ++++++++
 include/fuse_common.h   |  136 +++++++++++++
 include/fuse_kernel.h   |  118 +++++++++++
 include/fuse_lowlevel.h |  243 ++++++++++++++++++++++++
 ChangeLog.rst           |   12 +
 lib/fuse.c              |  484 ++++++++++++++++++++++++++++++++++++++++++-----
 lib/fuse_lowlevel.c     |  377 +++++++++++++++++++++++++++++++++++--
 lib/fuse_versionscript  |   20 ++
 lib/meson.build         |    2 
 meson.build             |    2 
 10 files changed, 1405 insertions(+), 75 deletions(-)


