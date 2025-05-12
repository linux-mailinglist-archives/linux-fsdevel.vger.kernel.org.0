Return-Path: <linux-fsdevel+bounces-48731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA4AB33E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C728D7A3C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A225D202;
	Mon, 12 May 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh60fEgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6C7DA93
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042846; cv=none; b=UzlRW8EuS8lDPEdVSXiMokvGjk2vG+zxgUxuT+OK0CN79DZOrN1+aTh+zsI/AG/D7aP/JlHpCK6Jw1ZMnSxyVf0OYFPuBmFLQ2YOKoPvxkYKronK7Y2c/ucyKbdVJ3HZL9iAmGHLTqZrueBrQ9uGjnLkX8BkBg53RckI26KaQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042846; c=relaxed/simple;
	bh=uEZk42HavY5HMzp1gmUz34H8tl6+mJDXmPTFflhVBTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ValKO2I+8Ai2oVu1H5X/FnwENPMtmUYwf2brwAlkjPZEpFwbN3lWD7cYMc33/qnxY6TiGBy2XWfr+4oe1K90vsXL4dqYx4MlWw6uKoXpldJbed6aOljDjJpxI77m90CG/gqrFtA0FvcfKuDTC4IcLBPZ8VUk1Jzv+2FdrCm5688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh60fEgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A257C4CEE7;
	Mon, 12 May 2025 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042846;
	bh=uEZk42HavY5HMzp1gmUz34H8tl6+mJDXmPTFflhVBTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fh60fEgNXkBPWKe6gJF3vKKjIuVdkAwHkufz60oV7QHC3GlEhNfjsdKOryNt8lw3r
	 Zuhw6kZTI9/FykwFU4FmFQqznunc9fTlxgxuSbjN3QlOGSgLi7saVooB7271U5qFNd
	 nimRcv+ftjy3OB+aI+N57CZUA2EqRf6iidQsCcvLUlLu+anWg9BFu7UPtr93FYXiLO
	 c17yuBcfrP/raihs66jQwRu/FIOQ4dkHP8Q3uWxyN3GeB7Sd+Chw+PkAQVqQJ5KhqW
	 ahSGpPfCl7rSAofF5whICnPzRtt/8oOllFp/Ox2X03VCtkT9JP+rqKOC6nQlm0u2LJ
	 TMwX+7Wx4u13g==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] filesystems selftests cleanups and fanotify test
Date: Mon, 12 May 2025 11:40:39 +0200
Message-ID: <20250512-absaugen-stengel-a301f3dfc91c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=brauner@kernel.org; h=from:subject:message-id; bh=uEZk42HavY5HMzp1gmUz34H8tl6+mJDXmPTFflhVBTw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQoHpK8P11D+M3R7lO9D1/NK5Sa1ZTeb/ZaukeqKFviq 1hV1ouZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJL2Fk+Mr9TFbk9ZKTAe6J OnX3kzgPiO695Sxs+2mDt9mDLsseN4b/jv5cqsczD0hwchU3Kx30nsynNatVwLk+rTVZKVE7WJs XAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 May 2025 15:32:32 +0200, Amir Goldstein wrote:
> Christian,
> 
> This adds a test for fanotify mount ns notifications inside userns [1].
> 
> While working on the test I ended up making lots of cleanups to reduce
> build dependency on make headers_install.
> 
> [...]

Applied to the vfs-6.16.selftests branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.selftests branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.selftests

[1/8] selftests/filesystems: move wrapper.h out of overlayfs subdir
      https://git.kernel.org/vfs/vfs/c/0bd92b9fe538
[2/8] selftests/fs/statmount: build with tools include dir
      https://git.kernel.org/vfs/vfs/c/b13fb4ee4647
[3/8] selftests/pidfd: move syscall definitions into wrappers.h
      https://git.kernel.org/vfs/vfs/c/ef058fc1e5e9
[4/8] selftests/mount_settattr: remove duplicate syscall definitions
      https://git.kernel.org/vfs/vfs/c/ec050f2adf37
[5/8] selftests/fs/mount-notify: build with tools include dir
      https://git.kernel.org/vfs/vfs/c/c6d9775c2066
[6/8] selftests/filesystems: create get_unique_mnt_id() helper
      https://git.kernel.org/vfs/vfs/c/e897b9b1334b
[7/8] selftests/filesystems: create setup_userns() helper
      https://git.kernel.org/vfs/vfs/c/8199e6f7402c
[8/8] selftests/fs/mount-notify: add a test variant running inside userns
      https://git.kernel.org/vfs/vfs/c/781091f3f594

