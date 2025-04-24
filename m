Return-Path: <linux-fsdevel+bounces-47210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E39A9A685
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C3D3A161D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2821CC51;
	Thu, 24 Apr 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4vRp6vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21020C02A;
	Thu, 24 Apr 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484081; cv=none; b=mMYzWf6w52FSowTyQQsMXIYm/D+PRxMnj/mc7Y81nl4a93EqN9KPpGfAv570q0YFBOI/LE4c4fZoP/+J31CkOLp69+j8P1xXrpx926MlJqtlrFaR8rKxdG3tYZNOwGPih4vgsfC1dXdRqVD6NoYkHwcuJ3GPC36PkbPt2/MsPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484081; c=relaxed/simple;
	bh=jSnn/s4sYv8vw3efN+JBVKJekwgJ5vx3xBIVhhRudj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKwTf5aFMBnyvbFzVWhvmnCCzTRZzRae0YfXI8ar/p92eVmIqoKTMAamENjyxdlNtji4UW3Wi7E5Bk1h2B7bTi1mMv/q96biilqnkJ7OldgCp7ELmS6EgzU1dTwYFDzsZl/6YrWQtzb1hmj/XONovkgdORuyGWGFmXNQ9q+Ajyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4vRp6vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14740C4CEE3;
	Thu, 24 Apr 2025 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745484081;
	bh=jSnn/s4sYv8vw3efN+JBVKJekwgJ5vx3xBIVhhRudj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4vRp6vhIVJKmwi7BmxKTkn70yuYaU39WvjJnmPuEUabx5YYE7OxaQ6ksIEh425eT
	 jwxW2WGtOR+Gsb1p3o6x1b1jzkntg2GikiZYxdeILf9fXFw/pZ8JCNejgP/7S0ZiPq
	 PjHaroqwxc03GrblWyPDLE61vmIbrr3DvPJpIR51f5eF42n5QsTAZAQF5j8ldwPnYS
	 OfTMpMzOsrSDFDZxjyBaC7oDvhp0hZ26V4umLetd6IW0Vl9jNJbExz2+w4K6JHCjD5
	 CRc+ISF9LQOeEUvLquIaCGNShqER0bojNsxKK0MUcKgZNID4yAK3ZTzQyDUXrvfyD5
	 n60GbvLOWKUMg==
From: Christian Brauner <brauner@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hca@linux.ibm.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Date: Thu, 24 Apr 2025 10:41:12 +0200
Message-ID: <20250424-auszahlen-nanotechnologie-f68d656fa52c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423045941.1667425-1-hch@lst.de>
References: <20250423045941.1667425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=brauner@kernel.org; h=from:subject:message-id; bh=jSnn/s4sYv8vw3efN+JBVKJekwgJ5vx3xBIVhhRudj4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw/tTuyl5hnxgwgzus9+mMI1FTp/xW+nB/dkLSiv+3W Q/X7r6m2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR5hkM/ywr0xIZnS+fFKpq 7D7BeJ1vQvKTBf3H7j2Zodtb/DoqbSIjwyfm3vRjru8TV0x+Gz779a3b39cUXExafEnhoYiNpsi pLRwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 23 Apr 2025 06:59:41 +0200, Christoph Hellwig wrote:
> The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> helper caused it being used by devtmpfs, which leads to deadlocks in
> md teardown due to the block device lookup and put interfering with the
> unusual lifetime rules in md.
> 
> But as handle_remove only works on inodes created and owned by devtmpfs
> itself there is no need to use vfs_getattr_nosec vs simply reading the
> mode from the inode directly.  Switch to that to avoid the bdev lookup
> or any other unintentional side effect.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] devtmpfs: don't use vfs_getattr_nosec to query i_mode
      https://git.kernel.org/vfs/vfs/c/5a876a5097fe

