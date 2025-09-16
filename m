Return-Path: <linux-fsdevel+bounces-61477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83492B5890C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F86D188FBCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387719F43A;
	Tue, 16 Sep 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgnHklYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057719CC28;
	Tue, 16 Sep 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981992; cv=none; b=QB9sJccr8GBREaLQ8jxcf9YdZezD44EnLNlfTW5Lbg8F2SptMPqxxv/y5PzQq/DN/eG4rD9Hb23K7knuT/cnIFn85j/N1+UkjkUFY+3t8taY/SPEfqkrgtp+OD+g1GB2CJbxDaT6PjBa75676n4SFqzuBWgpJbUeJpvTucfJIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981992; c=relaxed/simple;
	bh=C2gjJbXFlsDif6TijZi9btSYFxB0HW4FSubrbuTpmYQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxTiiaKCtzYbjB+82REvkKOCTz0oJjJEtURA0y7gGXvviNdilMd9r6T6fCBDa4fCdZ1CZGcBAJva2DNN8ULcAFX4NDWGhDCL6BlRtpPXwMb5fUeODpb19rzWvwfU872i7+dgxJhldN4GNfnHsdYzvvb5JlU4A8hXkhH4B2dt5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgnHklYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69234C4CEF1;
	Tue, 16 Sep 2025 00:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981992;
	bh=C2gjJbXFlsDif6TijZi9btSYFxB0HW4FSubrbuTpmYQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WgnHklYEwVa83svgXYJl2baN9SlF4fSo8Gia/EEB326esLKLaLOrBbEnJOcKk2dn/
	 T9+KFk1YiHzNZNElgu6TPwj3DYDKFgZlecSTngfATYi4Pf1bq/i9Bf+pXTwm7FQxg8
	 JqR/8gl1eW+rdms5NMP6gs8O0Q1tOS4URGE+dyGHqF/SUWmE6qgK9PM1SIfGC8zfOO
	 QW2Y8aAsVgSuzFAXK+LciD6kk40+f7BNWmtPpQy+8cd5yDw2DwNJbQQw4i7obm8obx
	 lMfNQUwZAVfYHGshHeajtGYGUGsfEddaD143WW3w4F0FLHNRVZUWgjDgabql2wysX5
	 gmfOxIcM2o50g==
Date: Mon, 15 Sep 2025 17:19:52 -0700
Subject: [PATCHSET RFC v5 7/8] fuse: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
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

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * fuse: cache iomaps
 * fuse_trace: cache iomaps
 * fuse: use the iomap cache for iomap_begin
 * fuse_trace: use the iomap cache for iomap_begin
 * fuse: invalidate iomap cache after file updates
 * fuse_trace: invalidate iomap cache after file updates
 * fuse: enable iomap cache management
 * fuse_trace: enable iomap cache management
 * fuse: overlay iomap inode info in struct fuse_inode
 * fuse: enable iomap
---
 fs/fuse/fuse_i.h          |   58 ++
 fs/fuse/fuse_trace.h      |  434 ++++++++++++
 fs/fuse/iomap_priv.h      |  149 ++++
 include/uapi/linux/fuse.h |   33 +
 fs/fuse/Makefile          |    2 
 fs/fuse/dev.c             |   44 +
 fs/fuse/dir.c             |    6 
 fs/fuse/file.c            |   10 
 fs/fuse/file_iomap.c      |  527 ++++++++++++++
 fs/fuse/iomap_cache.c     | 1693 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 2937 insertions(+), 19 deletions(-)
 create mode 100644 fs/fuse/iomap_cache.c


