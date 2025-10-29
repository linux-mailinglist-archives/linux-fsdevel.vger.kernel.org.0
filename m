Return-Path: <linux-fsdevel+bounces-65986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7468C17951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02F41C80BED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C852D0637;
	Wed, 29 Oct 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY6b4f+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC54A01;
	Wed, 29 Oct 2025 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698448; cv=none; b=r2p+rKhUjqs7UuCLyEYZXXVh/9ixYrO3aRZDA8x9CnktTxTXLQoUtTNRam5oFJGoKC8KudIEzyMowUmEBRy3RZ1J+uuoceT3h9PGzSdG0WvnGMCnlQKFuBth5Vjt7fm+xWOwQTEkGyUwH4uADilI1RkBD6p7ZuACBVMrqQfao/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698448; c=relaxed/simple;
	bh=DcbTiX2jArPkE4BqazxsEpX9nrZz5AjFTR2lCl/P+k8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laIrhYZFesI0C9LxxiWNEVvKs1NTtU1PeP19mV7OO8Kh7ZxiIZA4+c4uIdI3WnEZwno8vVO1/QQ+AWjuOSBh92xhTekTYQDlTIdVVOoSiOMiJeQ+5YIr3qa8Dt7KRslWDTQoJEVHxZ5yU9FWF1GvTWSez/OzL+wp4qOG32o+y20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY6b4f+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC903C4CEFD;
	Wed, 29 Oct 2025 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698448;
	bh=DcbTiX2jArPkE4BqazxsEpX9nrZz5AjFTR2lCl/P+k8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KY6b4f+Nx1Jx0KFxOKDg+bddy1Jgn+ACuajS/TISmvOuvKjraRYor4aed3YDkKBnh
	 RZL3N6mhGJsOZ5gf0su3zaRI6Pg8XAvhvsfjC/3hiofZFuX/p8Ai2ZH4kYd9afo4LY
	 rM2GlryIg0JFRO/A4XGWnBsN++fMXdaEuV0L1Memi+E+pVvaajuhdg7RsHDikn5ajc
	 l/vYDAxAeFhdnxG/1+DOSZA1ekemASnmvj92khXLycxV9oOgcMiydDYhRua9Qpwhnv
	 8DIVAkH4KTPyQwbOHR01TsPs31EdB/StHlkt5cKcFHnMS3e9Bwxs2gLGLxAosf3FGC
	 Q5KkOZdlCDl1g==
Date: Tue, 28 Oct 2025 17:40:47 -0700
Subject: [PATCHSET v6 4/5] libfuse: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
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

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * libfuse: enable iomap cache management for lowlevel fuse
 * libfuse: add upper-level iomap cache management
 * libfuse: enable iomap
---
 include/fuse.h          |   31 +++++++++++++++++++
 include/fuse_common.h   |   12 ++++++++
 include/fuse_kernel.h   |   26 ++++++++++++++++
 include/fuse_lowlevel.h |   41 ++++++++++++++++++++++++++
 lib/fuse.c              |   30 +++++++++++++++++++
 lib/fuse_lowlevel.c     |   75 ++++++++++++++++++++++++++++++++++++++++++++++-
 lib/fuse_versionscript  |    4 +++
 7 files changed, 217 insertions(+), 2 deletions(-)


