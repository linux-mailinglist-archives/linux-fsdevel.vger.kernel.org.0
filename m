Return-Path: <linux-fsdevel+bounces-39276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCEA120F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBAA16A897
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE461E7C02;
	Wed, 15 Jan 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+eVJA1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A6248BBD;
	Wed, 15 Jan 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938275; cv=none; b=lOxxYNj3HvXOspjCF35poGJSDHPJRlU5b1whDaA5L68K5PBptxgUjiSdRz5QLN6t+cEJoVZc94xIt8+90OLPNSXr/LDfp1qfgpM7H58SGNyFWLOA86WUvjh4HJH/qdY1ZkTiQ64JHLelZcqTq3aNjDSEiSr6/85VmvMD/g3Xd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938275; c=relaxed/simple;
	bh=tkNahj98YF5Ew9ZYvQEGcyHo5n4Mx4vVJRfvbbR6VAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTwq3XMDPqccOlBtVOx2/azHBWCqLLLps4KV+szSw6NXG1gnNrLMSART1+ApanpyCrflVZOrRYzkhAPUA7sKjYVOzm3uQC6gQXDEXAp6Jf9x6NRVhJgPdZUzBRE/dUekfBlQs10GKn6KTkluQ9XcMuP7+bYEB03uEAU8dCgWooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+eVJA1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ACAC4CEDF;
	Wed, 15 Jan 2025 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736938275;
	bh=tkNahj98YF5Ew9ZYvQEGcyHo5n4Mx4vVJRfvbbR6VAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+eVJA1Xn4mqvlKFvP3aAWpettlbCeZhVUJ+1W3ZBg1FQ6GZv8GlDyPR+CvimRp+k
	 kFnD0VnvN/EJDx+Kt5RMDFsaN6bcEbTG+GcXFjD2s4zrOw67SdJz3z0YgYfyEbnFgC
	 qoTraY202N3uCwZEc9/bnx6MOxRdOsiKx4c4QeubRZktd3tfEvu/KuTDuIe1pAJwSl
	 zuyCMTlepI8A1Spi6F2p+Df7dEPnd5AKWcjf1+is20UHiQyEhnwOezEuhQfuqQE5ux
	 nwyZMg/Gme+ODf/VOH3q68EfkpHxzxTwSrlROY6eWOzludGZrgrPJHDnsctWsiPVi3
	 i7A6EHHBe7i/w==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: lockref cleanups
Date: Wed, 15 Jan 2025 11:50:52 +0100
Message-ID: <20250115-pelzmantel-backen-53605f1b81d7@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=brauner@kernel.org; h=from:subject:message-id; bh=tkNahj98YF5Ew9ZYvQEGcyHo5n4Mx4vVJRfvbbR6VAw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS3T5beILDixlmx47P6j027NGvJ/jyxN3vuTHbPt3quK JHQKm39qKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi87kZ/pmfutv8qkHN2DUh 7aQx42Lbv1O+rryVyzWf/fEqVmkzfw+Gf8YzQs7/CjY/7Rb7YOFJF3W+F1GyUdPseh4ZfU91qZ0 5lxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 10:46:36 +0100, Christoph Hellwig wrote:
> this series has a bunch of cosmetic cleanups for the lockref code I came up
> with when reading the code in preparation of adding a new user of it.
> 
> Diffstat:
>  fs/dcache.c             |    3 --
>  fs/erofs/zdata.c        |    3 --
>  fs/gfs2/quota.c         |    3 --
>  include/linux/lockref.h |   26 ++++++++++++++------
>  lib/lockref.c           |   60 ++++++++++++------------------------------------
>  5 files changed, 36 insertions(+), 59 deletions(-)
> 
> [...]

Looks good, thanks!

---

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/8] lockref: remove lockref_put_not_zero
      https://git.kernel.org/vfs/vfs/c/74b5da771c89
[2/8] lockref: improve the lockref_get_not_zero description
      https://git.kernel.org/vfs/vfs/c/8c7568356d74
[3/8] lockref: use bool for false/true returns
      https://git.kernel.org/vfs/vfs/c/57bd981b2db7
[4/8] lockref: drop superfluous externs
      https://git.kernel.org/vfs/vfs/c/80e2823cbe59
[5/8] lockref: add a lockref_init helper
      https://git.kernel.org/vfs/vfs/c/5f0c395edf59
[6/8] dcache: use lockref_init for d_lockref
      https://git.kernel.org/vfs/vfs/c/24706068b7b6
[7/8] erofs: use lockref_init for pcl->lockref
      https://git.kernel.org/vfs/vfs/c/160a93170d53
[8/8] gfs2: use lockref_init for qd_lockref
      https://git.kernel.org/vfs/vfs/c/0ef3858b15e3

