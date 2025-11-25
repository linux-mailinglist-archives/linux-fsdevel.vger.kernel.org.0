Return-Path: <linux-fsdevel+bounces-69730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273CAC83F66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324B73AF0BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7C2D8375;
	Tue, 25 Nov 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQL0pQmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916B2D8390;
	Tue, 25 Nov 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059049; cv=none; b=kGA6qlxxbfiMzDwjz40S3Mr9rLAqz0PGU+sKBBJ5pR4ei/Lg5oygaVCCKwowwuB2le2SReOsc+KABeeZdL/zSjstL8awEYc2hlgnIPQak5JkWcipHRUyBdfZjy4HQEK8EpS33HVAI1Y+RXr0O19P3oL1szKCCp4svbBg0Rddy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059049; c=relaxed/simple;
	bh=fyCzOdyDgRE3MLw8Olg81SNfYvuO47J9DGOOqw9zWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKW8CLGQE6XVAhJvIzom7VehRDzBMVD1pK7C2+abJ7OqYUN6nw8jgR1UGzCjGzNtkxtcRett5VVVtZUH6OJq9hYvnd7kemLRhGcFkdrPJPHEXeqyiDuTN6HYjULrrJy/mMEgbeKigfD4HVhh9KH33/+GKInYWTygVWycZBpwrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQL0pQmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3055C4CEF1;
	Tue, 25 Nov 2025 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764059046;
	bh=fyCzOdyDgRE3MLw8Olg81SNfYvuO47J9DGOOqw9zWYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQL0pQmNVRQRFxxzPGSDEEX+OxskzMpapiAs2nAFc8ddpNQP+0YsM3NQxj/gq5x0i
	 7DUvBgJGavsmw9rtLdR6QnqX9/h3d6fovy8Yh3b38gTS56dzH30ZRaviwjApJYbrXC
	 AQGx0zqUM/P5NXJvrDtXEY+zDT4nu/QkRz5yovcisjftgoBKnloGDGdaRDGTunFwxk
	 Z+RvVFWFAvG3XQfwRXF7IBxbfOw2X6ugcP/PhTMxmJkG/yj/V6UDX8gb7SvQ5Yc2wm
	 BqR2Tl/SOuoshDKSr69wERaFBqQUer0s3hOiQtsn2iRpRdJDWCoygJ33AGbmkz03o0
	 qysyWW/cxxw1Q==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: allocate s_dio_done_wq for async reads as well
Date: Tue, 25 Nov 2025 09:23:58 +0100
Message-ID: <20251125-hochebene-genau-029f96b5c188@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124140013.902853-1-hch@lst.de>
References: <20251124140013.902853-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=brauner@kernel.org; h=from:subject:message-id; bh=fyCzOdyDgRE3MLw8Olg81SNfYvuO47J9DGOOqw9zWYI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqpi9IbZmmtNV+i62U3mWnS2JnzEqzHyx7afrRa7VGj t6T1anrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy35rhD0dUbbkhv+cc5j1L JDKuS9n/fq1re95u4awSji35DK29ixgZZiko1Z7mVTt+dH+mTfWnp9W+Yq91+FYufje7JsBYVa2 AGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Nov 2025 15:00:13 +0100, Christoph Hellwig wrote:
> Since commit 222f2c7c6d14 ("iomap: always run error completions in user
> context"), read error completions are deferred to s_dio_done_wq.  This
> means the workqueue also needs to be allocated for async reads.
> 
> 

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: allocate s_dio_done_wq for async reads as well
      https://git.kernel.org/vfs/vfs/c/d2560991c66f

