Return-Path: <linux-fsdevel+bounces-65987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56450C17954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA7BC355B2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9BA2D063A;
	Wed, 29 Oct 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="covimT3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4C29CF5;
	Wed, 29 Oct 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698465; cv=none; b=XvOBhad2xJOhrc7pGvRlbRjVEt9XvBc/Jq6XaU87eKz3uV3WmrccDwZErcT7/X3vlgJxWI12hMmN3AJKvMvmNJ4HEVJW7+9xgkmg/JeVEnAsZOtjiylcCjSUk8nn/uO2kJynubXR1dckitG8BqTwLQGq+9GpDBf9wTagO1DhLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698465; c=relaxed/simple;
	bh=NX3k5th5VOINAUQDuyaacmTTFc9udvZHEfEs0Zww9Bk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpnBZ8kcJC7O6Y39CnrxqRXrGRkBRucsh+5Y4+Q7vYDJlCaXcIvlAQMdcYbFYkDoP+hpUdZw30Nzpr8f3ibAOXfq5A+gl2q6A6Ypj9fKz7/z0eUJzqFSwqnexYDz2ks6FYa+O8qlSgtreUGGdytmO8k2R5wtqfcIYDs/0Y4Y6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=covimT3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BE8C4CEE7;
	Wed, 29 Oct 2025 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698463;
	bh=NX3k5th5VOINAUQDuyaacmTTFc9udvZHEfEs0Zww9Bk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=covimT3MjsBdsTV8pTUaLvVUza+YcDxdE3YQBQb6Pd5KZLwvWnNf7xpy85w/HTRrx
	 fcrvK6fOAyv/+LuAi1rgsxNbyBzirDEXI8cT4k+5t59LyL+9xxshUFaFy4J7QEiPga
	 sPK1u9bugjPTia7gFkHVO5bRHQWzH+Q3HWb00o18z91uJ5V1D+Q3UCgvwqjOWBjvCV
	 EIe2QteqIRL3wLU7fkGb1ahkXwZ85OVYZC+c4mAAlJqMPhaKeF84DBHnPLLUnnc2x/
	 weU/QfNddwcXqzhzMXyqJ5HnyWv5IjUIxwxGLgkV1WNRf448LILC9JLFeyDK+mBZjV
	 uzoKvQltjKuqw==
Date: Tue, 28 Oct 2025 17:41:03 -0700
Subject: [PATCHSET v6 5/5] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814833.1428772.4461258885999504499.stgit@frogsfrogsfrogs>
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

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.  As part of the delegation, add a new ioctl allowing any process
with an open fusedev fd to ask for permission for anyone with that
fusedev fd to use iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * libfuse: add systemd/inetd socket service mounting helper
 * libfuse: integrate fuse services into mount.fuse3
 * libfuse: delegate iomap privilege from mount.service to fuse services
 * libfuse: enable setting iomap block device block size
 * fuservicemount: create loop devices for regular files
---
 include/fuse_kernel.h       |    8 
 include/fuse_lowlevel.h     |   23 +
 include/fuse_service.h      |  170 +++++++
 include/fuse_service_priv.h |  112 ++++
 lib/fuse_i.h                |    5 
 util/mount_service.h        |   41 ++
 doc/fuservicemount3.8       |   32 +
 doc/meson.build             |    3 
 include/meson.build         |    4 
 lib/fuse_lowlevel.c         |   16 +
 lib/fuse_service.c          |  828 +++++++++++++++++++++++++++++++++
 lib/fuse_service_stub.c     |   91 ++++
 lib/fuse_versionscript      |   16 +
 lib/helper.c                |   53 ++
 lib/meson.build             |   14 +
 lib/mount.c                 |   57 ++
 meson.build                 |   36 +
 meson_options.txt           |    6 
 util/fuservicemount.c       |   66 +++
 util/meson.build            |   13 -
 util/mount.fuse.c           |   58 +-
 util/mount_service.c        | 1086 +++++++++++++++++++++++++++++++++++++++++++
 22 files changed, 2701 insertions(+), 37 deletions(-)
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c


