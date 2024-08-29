Return-Path: <linux-fsdevel+bounces-27883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D360964AC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B83284404
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D71B3F01;
	Thu, 29 Aug 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0gfx6+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9151487F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947115; cv=none; b=AraO3748T9ghEi1JmC/R4won0wpOmBQKv0pQYE8WdXoaULGHbqC7FcAsFRuY1959IR6hF3PhgrTgncW9YPKdq/7yjyB7NtQ7rhAl1BqNW2FJIrQOHZ4HnJ2o+uL4o6U4kTp7lyrW+T6yVUDJ/7BW+RNE9WNcjsHoxfpef9ROMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947115; c=relaxed/simple;
	bh=VVokIbso1eod+V2jCOqK7tDccyby/Y9yAysaTNvEBJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhmhlA/TsUmrOPABR1yT/7uEGhFRcwuD/7OwnKJ7EWC1XZ/YALNUWewoswkhKowzR255dDFLYCfjj0gO2uxppCfypIS3W1D/FiWIuqdoU8nCQX/Xt66zLZeLeNwC3YslkX7Rknv695g0pA1kWXTv5mY0zdmFyz0IAovO9hIod30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0gfx6+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CD1C4CEC1;
	Thu, 29 Aug 2024 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947114;
	bh=VVokIbso1eod+V2jCOqK7tDccyby/Y9yAysaTNvEBJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0gfx6+ZPW2GXebkI4SsSSj8j1CQpGmLflFVcYuv9ZVGOi8CPFQaZPHZZd1p8xnuq
	 vvznGLpJpZ2UyVuVOsZqQNJiF7wSKQwbCNIyucdlMygZXr4AuTJbNrWHfs9QFxhcLd
	 QDaAwb0BR5MV/8FiE8oqGOzGFWddL4QsDzVW/As1qsFyjHaVFUTCTM1KoZ9045qdQW
	 vhkNjyWySuo5bHJEaXUzl7ohgQplv7FgPStogTBUE7cOEVBWRIl6Ky6cEvVdMzcEjr
	 ssqHU79Oa5Meqeca4xv505uJFusrVUfND84U5aJ7fsgyCrrCRaYB0x8ms/QSOF/YJD
	 qonwe2j9cLFpw==
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] fs,mm: add kmem_cache_create_rcu()
Date: Thu, 29 Aug 2024 17:58:05 +0200
Message-ID: <20240829-hautklinik-undurchdringlichen-2ce03f6e18da@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
References: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=brauner@kernel.org; h=from:subject:message-id; bh=VVokIbso1eod+V2jCOqK7tDccyby/Y9yAysaTNvEBJo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdmLVQM3lW4l7l+8xC/64v4WXa2OV652Ejz5b5a1Wux Hp8ChHh6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI4AlGhpvc/t5cviazXk5U vKsktEfV1vfmb1nxu2fmnp/2ceqd338YGX7WntrTUnF7/vbi27ErHUQyylKE7i5S+sL4teXFV4c DglwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 12:56:22 +0200, Christian Brauner wrote:
> When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
> must be located outside of the object because we don't know what part of
> the memory can safely be overwritten as it may be needed to prevent
> object recycling.
> 
> That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
> new cacheline. This is the case for .e.g, struct file. After having it
> shrunk down by 40 bytes and having it fit in three cachelines we still
> have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
> accomodate the free pointer and is hardware cacheline aligned.
> 
> [...]

Applied to the vfs.file branch of the vfs/vfs.git tree.
Patches in the vfs.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.file

[1/3] mm: remove unused root_cache argument
      https://git.kernel.org/vfs/vfs/c/a85ba9858175
[2/3] mm: add kmem_cache_create_rcu()
      https://git.kernel.org/vfs/vfs/c/ba8108d69e5b
[3/3] fs: use kmem_cache_create_rcu()
      https://git.kernel.org/vfs/vfs/c/d1e381aa30cb

