Return-Path: <linux-fsdevel+bounces-65977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0DC17912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4354E83C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF72D0292;
	Wed, 29 Oct 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKGkdXEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D093A1CD;
	Wed, 29 Oct 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698307; cv=none; b=LpghTzPKeEMzC7IRAovc1yakxQyoMat0IFnJ13PFjtvHlZGFaHiE+qtZrFgc/pUBqja9OqdSQGMJPL2Svn/AJgtqtdJtXlXj3zIyiqXKm4r/yxqzJbyUsZA61KORdbaFlLer+PZLD0Af9uxR3cKinEvoQwasI6Nt7DE8T3d9TGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698307; c=relaxed/simple;
	bh=UWZSOSR4jEVwP1WgjMcM1AHdD2OdSfR51BWV8oKjp6g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyjBU/MK4rB/bTcWTzbigT2TwFOgSweiJJah80UEc/1q1AsMiGt2e6Npex2CC9y/4TAMRqtkpTDZk6FUj0AWli9tFaGeqDxXr1fvxdBk0Y0U8FovPv60iS2kyy6wXHr7hqHhQIMr5yBm6hHfA4Zp2TYNNieHRxt62F3oO3XLk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKGkdXEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2657DC4CEE7;
	Wed, 29 Oct 2025 00:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698307;
	bh=UWZSOSR4jEVwP1WgjMcM1AHdD2OdSfR51BWV8oKjp6g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UKGkdXEtg/5vbSjyl5shN+r/vxum9A9G/2WONKFq1hlR0F+r7fAuFwoA4RYcZZv2N
	 VoDlyXfEncJ7HgY83r493z0JV4G88I8dcV55vV2JdZKHbQDF7urgDYZBn2BJawUHmi
	 065O2Vpf3JAYXOrlhXWSGBCQ31iiXSWaTnggyXa21cycRxxh7o6Ly1mGqn1q9EbT6k
	 Din/wb/FAWeaRA7keLZPv/IELAam6WTks9hv//tUjmhqeNdvEIGQrGXE/ttIhCRs5g
	 3zA2ikl0ko7TAZW1oR/QbJHpZL0u5bRNU1io92R/cFDtYsweQhRsn3OZUgMjnoTe3U
	 +d8VPzBMl5JyA==
Date: Tue, 28 Oct 2025 17:38:26 -0700
Subject: [PATCHSET v6 3/8] fuse: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
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

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-prep
---
Commits in this patchset:
 * fuse: move the passthrough-specific code back to passthrough.c
 * fuse_trace: move the passthrough-specific code back to passthrough.c
---
 fs/fuse/fuse_i.h          |   25 ++++++++++-
 fs/fuse/fuse_trace.h      |   35 ++++++++++++++++
 include/uapi/linux/fuse.h |    8 +++-
 fs/fuse/Kconfig           |    4 ++
 fs/fuse/Makefile          |    3 +
 fs/fuse/backing.c         |  101 ++++++++++++++++++++++++++++++++++-----------
 fs/fuse/dev.c             |    4 +-
 fs/fuse/inode.c           |    4 +-
 fs/fuse/passthrough.c     |   38 ++++++++++++++++-
 9 files changed, 188 insertions(+), 34 deletions(-)


