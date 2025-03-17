Return-Path: <linux-fsdevel+bounces-44206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632E4A65503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4814189445D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A42459E5;
	Mon, 17 Mar 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpvMzC7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B60241683;
	Mon, 17 Mar 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223970; cv=none; b=qRJbNvT3HIvnHKH9q7NZc+aw9hx18MyBShNtdFTcaBda9EYS32sLTo8NhdJBpy7ZD1YoVEMoDvB2f/Kb4yKG1XQpv+hSbTtabYO1brBVql9ZD7rFzFoLzFqmye6bFOmuyPngPGwz7tch1v16EYHV9QLb8kbsxq8Gy+vhovy5Xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223970; c=relaxed/simple;
	bh=kqoi/KoKQFDCLkm98Yk6bloLGUhLmdSZwvFY4wvjJZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKL/4oea3oN2rUATGwuQJJvOkBZ74aVS8j4G+7jjYNnFNacfK20d0+0In4sNwTvqktq8aIfD3ba9upbeiPAJm3+OmEeOgZhRkZPx3+3hjep++Ys0monQkvo0j8NmJ8NZPI63eXWW5zyCDcno6iczUh+vUT/x2/EKkDyR/iSy5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpvMzC7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FBFC4CEE3;
	Mon, 17 Mar 2025 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742223970;
	bh=kqoi/KoKQFDCLkm98Yk6bloLGUhLmdSZwvFY4wvjJZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpvMzC7qYAGY0gmLAzuMo0AY5Qn/oZrpcKPa1dYcCAGCPt0xdKqrnpphEqerCJG9I
	 DYi5zsJyOmzJko1R2+FJNn5YyMZQ3GP+GYPtDqo49Cjk0nGYYR1FMIInWWKFZ9u5XL
	 xWUrM5BgWbHOLd3Y9PXSrGQVsSfUVEAbJbhOrLwwf+j14PJUihE9Zsu0+0v/ytjexb
	 BJSN4fpnzBuL4yeVBuxNyLc3RbVhr21qHiDD57NAq+U7hs+r4fTcyVcV5ubCPqwDNd
	 x4/B+SPgABspyS9aROUvdBMgLENFBAp1yslTxUnMySt2FDES6vY+uVA6Pd80UKvUMj
	 ipLgNG59Rt/1A==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use wq_has_sleeper() in end_dir_add()
Date: Mon, 17 Mar 2025 16:06:03 +0100
Message-ID: <20250317-begierde-kundgeben-788fcc33156f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250316232421.1642758-1-mjguzik@gmail.com>
References: <20250316232421.1642758-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=brauner@kernel.org; h=from:subject:message-id; bh=kqoi/KoKQFDCLkm98Yk6bloLGUhLmdSZwvFY4wvjJZg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfsIr5L5rYX7C6dGOWWquIpuOqNcU2iov897l9tp6w+ lnUhE0aHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORfcrIcPm6cWshW4Qfl/7D 48vL9af5/Vu1xfTADN/ZfC/f2DzuP8zw399USieh7Iro3qIq4Snx0cfs+UVcGaZ4X1rx02vR8vN bWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Mar 2025 00:24:21 +0100, Mateusz Guzik wrote:
> The routine is used a lot, while the wakeup almost never has anyone to
> deal with.
> 
> wake_up_all() takes an irq-protected spinlock, wq_has_sleeper() "only"
> contains a full fence -- not free by any means, but still cheaper.
> 
> Sample result tracing waiters using a custom probe during -j 20 kernel
> build (0 - no waiters, 1 - waiters):
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: use wq_has_sleeper() in end_dir_add()
      https://git.kernel.org/vfs/vfs/c/f81ad90aa97e

