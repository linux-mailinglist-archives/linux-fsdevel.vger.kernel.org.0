Return-Path: <linux-fsdevel+bounces-21052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC468FD18F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EE3B27874
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696E1773D;
	Wed,  5 Jun 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Ixe37V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F491F5F5;
	Wed,  5 Jun 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601056; cv=none; b=YD8zRPltGyVm9n77KOQnDE9h84UWGT/Nva80X/86Z6X872XGkRvK8GeJb9EVv4IKbhWdiVQCQ+Dg9KRlTwfhsMT1zMc0sJzKACviEjYPJ2VmLbnQ8urg11W+PaDxFiYyx+by3iDuLwdJFZHyUZWFOcUYQ2eCjTkdAfjSNdNpzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601056; c=relaxed/simple;
	bh=N5xGuI+r2hzaR93dFtC7+Kt6OZcds1p/OXnWRHZ6/DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taAHpRvJqXEE6zH9+rs6bgEu4OlyZG8Uf/YUoBqDwMIzyzEW+iw3e6LKhrTOBWbZQMUxXfaS0PYH9Yot4tHJUXigpeOuhq+1LLBP7DoDEcGnBgSWuJXpKrl8RhjAjfl59cpBS3bCaoEOPPxKjQPjJoAY9y6WvHOAVOkFUdBOAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Ixe37V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95582C2BD11;
	Wed,  5 Jun 2024 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717601055;
	bh=N5xGuI+r2hzaR93dFtC7+Kt6OZcds1p/OXnWRHZ6/DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6Ixe37VPgqTDM7/Rk6NPBBu/d+eFVqGBOx43e0FeQE3X4yt8Ctc/ZBDZz9DIqDwp
	 gSZd3m6amOvLD+M/mQfrsihmbT2OgD59Wp3p0OexxmHvIUGZJn1C66k7Re5orGoarG
	 2YrXP06ud8DvYvAseJ5pY2kKmo74IjSFxJ8b7VdZclSi0mi9gTxOq42hWGNtG9u3xC
	 huZW+Zegm1u0sCtc2CY5XG3RiynE5KJGVeqiA8m/TDo7sPoS1MUSGeFeDTZluazfTq
	 g+WEw78j9Vzg6skciarFGmHO73o6z2u2d25rBZLsVio2gFFvJtZDy1zjWPsdLLavue
	 jhz/Z8Ea6K8LA==
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: keep on increasing i_size in iomap_write_end()
Date: Wed,  5 Jun 2024 17:24:07 +0200
Message-ID: <20240605-einmal-wissen-de46a2dc185b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
References: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=brauner@kernel.org; h=from:subject:message-id; bh=N5xGuI+r2hzaR93dFtC7+Kt6OZcds1p/OXnWRHZ6/DM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQlNEssX9y4wlXXRnx3a+/S/e8FajZ5fYhO3P6w5vvmk m/zFiq/7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjID21GhnOTWy84nzVJ5lzT ahzLsMZui0FDntiNDRrJ9t9mMYjHrGT4X/sozfNZM/8qbcW9bruPTbTt+2n4WPjK5cU/5qleEvb cwQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 19:22:22 +0800, Zhang Yi wrote:
> Commit '943bc0882ceb ("iomap: don't increase i_size if it's not a write
> operation")' breaks xfs with realtime device on generic/561, the problem
> is when unaligned truncate down a xfs realtime inode with rtextsize > 1
> fs block, xfs only zero out the EOF block but doesn't zero out the tail
> blocks that aligned to rtextsize, so if we don't increase i_size in
> iomap_write_end(), it could expose stale data after we do an append
> write beyond the aligned EOF block.
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

[1/1] iomap: keep on increasing i_size in iomap_write_end()
      https://git.kernel.org/vfs/vfs/c/86e71b5f0366

