Return-Path: <linux-fsdevel+bounces-58427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73239B2E9AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4DB1CC2B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEDF1E32D3;
	Thu, 21 Aug 2025 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqh4oV+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DA1B2186
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737331; cv=none; b=fogiUaCrn6G+qIWGmoDKKDW1k341h/QREHuq9EXeQNQiZU2c2xlAC05qhrqIoJR3RaOc95ZH+gk+KmeVtKOmfLU3hicDcab9KayZ8thgs5vn1tu+BxX3PyB11aWR2BAFSeYzH/GHzFJVYFDjON78VMvO1ZVBfrb/77x0IieZiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737331; c=relaxed/simple;
	bh=tJqCvZgC1MMC7Yv0Dx/V1X2tJUpc3qppKt4A6Q1jxCI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQIBoVfPB2YOkk6tuJwlVeP4YnrRmP/KuqgCsLWABeyiHEX63O/XzGLyTQMHzEpwr0hlD8GBL6vLsuuGvrCMs/guQ5TJSp9QW7HFrqvPy4p6DMdhq+iqAgbTfugnChY1UoNpcTk6/yyDSTJR96r4xn5mPIhqHtxGLY9c74CP+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqh4oV+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E25C4CEEB;
	Thu, 21 Aug 2025 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737331;
	bh=tJqCvZgC1MMC7Yv0Dx/V1X2tJUpc3qppKt4A6Q1jxCI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bqh4oV+nniOaF4gixnld1O3mtLJZDnFefDi6hrUS/fr1LPFEKV13FAjy0lOLFsOfG
	 z7pW3O4ctapulV7t9CWFeUV9X9qQWSnJyYHx/JTBDcGl3D9b/JXjTHfsOZo+bQsBE7
	 eUUl7Xbab5bMXxtUpN6cXE9COdyuUeWgo7imtTd24KzAh7FdWpB0yEUQ3tvN2KMLV8
	 yKmCCbli/1s+kqckRP45jtTqOJXW6/mFOaqSlm3jnRplVh76v74KO2TkmEZhmU60TL
	 TsGyThwAJem7a9XvMqBrTVbL6oJ4Yv7PA4Ew22d2uerK0dXTMEhWTVgLJWkTqsLn1u
	 9FD7F6ZTjOzpg==
Date: Wed, 20 Aug 2025 17:48:48 -0700
Subject: [PATCHSET RFC v4 3/4] libfuse: cache iomap mappings for even better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711864.19984.18094782290166570853.stgit@frogsfrogsfrogs>
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
---
 include/fuse.h          |   31 ++++++++++++++++++++
 include/fuse_common.h   |   12 ++++++++
 include/fuse_kernel.h   |   26 +++++++++++++++++
 include/fuse_lowlevel.h |   41 ++++++++++++++++++++++++++
 lib/fuse.c              |   30 +++++++++++++++++++
 lib/fuse_lowlevel.c     |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    4 +++
 7 files changed, 217 insertions(+)


