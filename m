Return-Path: <linux-fsdevel+bounces-61478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F27B5890E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5362A1298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B219FA93;
	Tue, 16 Sep 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULda3VZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3319DF62;
	Tue, 16 Sep 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982008; cv=none; b=mM++oweKD+56tGUdUZrTEUIDWypiv+QZRqWdMsOKg1z0ZM45U5m6tjfgun/zvo1hyM1CbKsNSzHdnemTov+dHRLNM/5iGW+K6SonwQlmF7Bw7y2zwnhGJYghMlI5O5SmOAHi18oEyGJq0M1tVT77hBH3QSdoY+aWRQLaNvc/hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982008; c=relaxed/simple;
	bh=cV85r8TI58ghQWVOM9oRzPnpN9ZwFUBp8GADB45qry4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJrAfpKDkw+DNifWPwALaevRnRGY76K+52eyRSxbYvVKx4tCTasLPSHJXnf97j/85QO82JVTmfq+hzGdrvr7CIVSGkbloq/Ai1Ek6bN07Fzicv3dVwkVwTXUJPyvMvibGmt0gzk/VUZRGoe6Xo63THZM0GZPkSIwIW+l9bulOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULda3VZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DE6C4CEF1;
	Tue, 16 Sep 2025 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982008;
	bh=cV85r8TI58ghQWVOM9oRzPnpN9ZwFUBp8GADB45qry4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ULda3VZfFyI3LvH4grMICjMHknAWffd3UP8ydj4pgJ2px0t+RHfRbTBn9jVkbn9/F
	 u8ukpD39ku1RkJcVKZifdIrNqIV/g09VaKUShwOjVON1BdOJ4dEMFw2J47scBeF0Yl
	 t5YfosMOxfm/HwG8NDDPBDI/xGkRabahEATTSh02xtOW13OKqSdQuSWt4WR96ft2eE
	 OMP3Vc3l8V2uBhRora6sKIskZCN+gMrm8zxs4oSOq1zCQHNnJfdYwnNhgcc6+f+WOO
	 Nvaz5cpOr7K8mgW5z9BylQNTgKKfwz9zxs22djYR5YyPKTbZafPnRhcI1ub1foUAqs
	 BcCQRf2Ks434Q==
Date: Mon, 15 Sep 2025 17:20:07 -0700
Subject: [PATCHSET RFC v5 8/8] fuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153353.384981.9881071302133055510.stgit@frogsfrogsfrogs>
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

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * fuse: allow privileged mount helpers to pre-approve iomap usage
 * fuse: set iomap backing device block size
---
 fs/fuse/fuse_dev_i.h      |   32 +++++++++++++++++++--
 fs/fuse/fuse_i.h          |   12 ++++++++
 include/uapi/linux/fuse.h |    8 +++++
 fs/fuse/dev.c             |   13 +++++----
 fs/fuse/file_iomap.c      |   67 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |   18 ++++++++----
 6 files changed, 134 insertions(+), 16 deletions(-)


