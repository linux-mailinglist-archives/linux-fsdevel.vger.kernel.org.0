Return-Path: <linux-fsdevel+bounces-42224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B89A3F586
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF238629E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73F20F08B;
	Fri, 21 Feb 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufr+i0sV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3320897B;
	Fri, 21 Feb 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143457; cv=none; b=gLljlIQp5AtB7xRmsPWSCZRULtWvVLFLpYrseRMKO+bKIAzI70uAtsswL8MIZYt60yOrS4zQMsEVWwd1DV7RIkplGuGWUPJyKyyRZ4uYnkzFYr8jF4Kp1qzb+4RYUKHxViyQFVqDvdEdAoQJlljZ+GVM8B+RwhqnSckrpmR2O5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143457; c=relaxed/simple;
	bh=kVxpbB7ukPKF0hngaX8sy4bvmn9YwBcQRU6OVUKcEyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLse8JuCWLFM36QeqEwl2ElJNKbeVUyKAesQinPetGJn1Qg4QXxpcfacTLXHIG37e/zxdsNRmLEElJUqcgI0kU8Og2vYrBObFceTV4zVJk+wKCQTuw0jl2InvykYZC7k3noAzoycI+Ot5hdJjvs2TPA9pXm71sODKhCfbl0ogt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufr+i0sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA98C4CED6;
	Fri, 21 Feb 2025 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143456;
	bh=kVxpbB7ukPKF0hngaX8sy4bvmn9YwBcQRU6OVUKcEyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufr+i0sVTtYunwmtaXO6odAh50ln2BOBOWifXKHmWEPM52yYrPhPiU/1+v7m6OvI3
	 SdmSNGSR+LJqWFPmHrf0+ZIIqhXlsco73kc7/cn96Bcj7+b3VH96+T50Atwafvzvz8
	 GPqP7KK3SeRXcX8Uu4TuDbx08VpEgaQPPlbDFrpSL0baiwU/lOkxpVB2D4ptyLT+eP
	 iqDQJLVHOZpi1oM9rD5MfR+GTsBGYR2kZcCAfe4TB3ZeC/Sy30bY87TlcFbwMAIMo1
	 6FQRAEcWDSyFiIh+p2x948nNI4LimIKGzel5JItG6usyu1Xp05onN2Lgz0+5r58b/k
	 8MICMQOzInsbA==
From: Christian Brauner <brauner@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] fixes for uncached IO
Date: Fri, 21 Feb 2025 14:10:38 +0100
Message-ID: <20250221-kleben-ordnen-8138127aafe2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=brauner@kernel.org; h=from:subject:message-id; bh=kVxpbB7ukPKF0hngaX8sy4bvmn9YwBcQRU6OVUKcEyg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqI40TX70RvtH0DK7R2x76lpeemZclFd/W3N58m+3t Y/E/U9d7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiINTMjw1nxX6U9kxlXSv5Q LOIzu/XhbMf0Sc7bNv9jPaL5Jn2nhDvDX4k3LTMTveMe1YYk2Cw9v4V33rcd7ldXLDu985TH2iu XqzgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Feb 2025 20:02:07 +0800, Jingbo Xu wrote:
> Jingbo Xu (2):
>   mm/filemap: fix miscalculated file range for
>     filemap_fdatawrite_range_kick()
>   mm/truncate: don't skip dirty page in folio_unmap_invalidate()
> 
> include/linux/fs.h | 4 ++--
>  mm/filemap.c       | 2 +-
>  mm/truncate.c      | 2 --
>  3 files changed, 3 insertions(+), 5 deletions(-)
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

[1/2] mm/filemap: fix miscalculated file range for filemap_fdatawrite_range_kick()
      https://git.kernel.org/vfs/vfs/c/8510edf191d2
[2/2] mm/truncate: don't skip dirty page in folio_unmap_invalidate()
      https://git.kernel.org/vfs/vfs/c/927289988068

