Return-Path: <linux-fsdevel+bounces-61483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B5B58913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA9C1B22378
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446519F40B;
	Tue, 16 Sep 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayKCOytA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B04625
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982086; cv=none; b=LpIVwMmEnmhb/1ve5dKAoyn1Xb+IE4sK1Q1iIdx+uwKfDxeQ+8R75LUF21lOIEkFm2RFAETqkev6QimIQjRd0G7yr3qMJNaD/d+D5rEAjnplXSnf6H+9HBq1+JUxJHDmaqL9cnFgFoOEGHDcQBaYGi9txqN9izmPvpRPVhRyZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982086; c=relaxed/simple;
	bh=DcbTiX2jArPkE4BqazxsEpX9nrZz5AjFTR2lCl/P+k8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anqJ7fBBrZp4w0ZCSuiQhgBIkaHSQrMWE94b9mdnisJuDg/tDhzpMpuZYYulRbfIQoj9p5z1r1+ebgrdNtn3ed4+ckh/ZqcbclPL9OD3UfoBh3Cq4GicMM8uK6VrCNoQISLHVsHSKAchYHXoqIAXRM406/l8xzc3+D6YyH88gVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayKCOytA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF411C4CEF1;
	Tue, 16 Sep 2025 00:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982086;
	bh=DcbTiX2jArPkE4BqazxsEpX9nrZz5AjFTR2lCl/P+k8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ayKCOytA3RDBLyiDJnlOtqMWjENgACUtENLomIZ2SaJ3JGmNIkEuGLmlBKAkmkIXL
	 hjWD7UBQguQeC32/tV0gi1/wkYfvw7Zroq7wf91FoDz2ahvJ2321mVMSadh2WBLIvn
	 fSO2ARLojLZFyzmCU2FmEKfxH1fOXmH/4xIk0qmVDCrkha1aMOBqTk6LW2Of7Gpbzx
	 DjkeXwmjOBG9PFvgetX9MHKYeYRHky+3xXMYB+9XqqPtgwCS6i7FsoCyiKZ18uIm3I
	 v7GJ//Ob5Hox01980Fr1yHjtK/j/WjJZq8BNOajLJIsQ2u7zuE0MWNV5WLVxpsc9Xr
	 bTfYjt+OH5qeA==
Date: Mon, 15 Sep 2025 17:21:25 -0700
Subject: [PATCHSET RFC v5 5/6] libfuse: cache iomap mappings for even better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
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


