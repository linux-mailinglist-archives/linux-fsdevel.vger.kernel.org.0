Return-Path: <linux-fsdevel+bounces-46899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A82A95FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AAC7AAEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95E1EF092;
	Tue, 22 Apr 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="harMrkoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837F1E3790;
	Tue, 22 Apr 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308276; cv=none; b=TzsWxPhri/tTucYgKsj2aQU2h0fzIXduRk5i7YHD6Rj+Dd8+a7jSnD7Zm2WzvbJETGXJ7S9kIOrvcQsjuUyON4DBBHq8ssuCYxpPsjby/uquj1/gQQsFbglYtdtbQ6mhTJdF0nXrmyt/LSFLB9GFRF3PQ1pndHhFyKDFf7Qq1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308276; c=relaxed/simple;
	bh=piMIjRvQpKrC2CvG47V5eABCBgjupbRMSHg7q3PNm1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCxNZcxgBIeOMkg7RDlCH0llCK7/Jq1f5xAUPaN4ZrSK36F98p/rJkjb4e/TXD7TPCqJKqdTqVVyy0aYPbBOWpti6TExxEgnFSRtvkNnRO+11JE1FARqkrxXPNMTE1J3sk59WamyNv0nlB4VqjQdrU+hpGY1gKdL/tIv2OPNebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=harMrkoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9131EC4CEE9;
	Tue, 22 Apr 2025 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745308276;
	bh=piMIjRvQpKrC2CvG47V5eABCBgjupbRMSHg7q3PNm1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=harMrkoB8y79bG1ilHEsEhn0B3Bt/8XhTYvZsfKmW3xM6Eq+PCnBqC05WD4dKf9NI
	 cjv2EE6CrlNdRC2FPN7L8Oa64O0dFgRF1qQZQt1sNJ52XWM4FlOx5HMc25DDl+JOLH
	 nKVLoNQmSl/iOqsK3CLcK3LP4BlU2yBsWgq5UPlG1UKdF8ZTA8R+16NvMNwQufs+EQ
	 gE7ajCkkkDJWR/9XniGbqGvr0eG4RYxP0LIXD39mL7FwHz/Eba9KG8iXP7pC9xWyH3
	 j2ex4G9T3PP8Tp/rUtJMJ53tcXe5MzrBZy33TIHQaoA/dHROPKxZu+1TqgGGMWi+G+
	 jY1r/YYefyJkQ==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: Christian Brauner <brauner@kernel.org>,
	mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] fs/buffer: split pagecache lookups into atomic or blocking
Date: Tue, 22 Apr 2025 09:51:06 +0200
Message-ID: <20250422-filigran-entsagen-fe5e2882a2f7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250418015921.132400-1-dave@stgolabs.net>
References: <20250418015921.132400-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=brauner@kernel.org; h=from:subject:message-id; bh=piMIjRvQpKrC2CvG47V5eABCBgjupbRMSHg7q3PNm1g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSwe+WumvTKLVWpKtYk/Vrnb+7eufkXF3Ivmree9f8tu yqDuOqWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsn8vwP32769ejbNNYPE3v s3Mcs3Vk9j6w1cL2lHfYHWGWXYpMZgz/nd72T1aJYVGJ6RIXyN14NPfxjYsccxU0hJQWLIsLdP/ CDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 17 Apr 2025 18:59:14 -0700, Davidlohr Bueso wrote:
> Changes from v1: rebased on top of vfs.fixes (Christian).
> 
> This is a respin of the series[0] to address the sleep in atomic scenarios for
> noref migration with large folios, introduced in:
> 
>       3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
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

[1/7] fs/buffer: split locking for pagecache lookups
      https://git.kernel.org/vfs/vfs/c/86e6a02d527d
[2/7] fs/buffer: introduce sleeping flavors for pagecache lookups
      https://git.kernel.org/vfs/vfs/c/b3a1fdf3516f
[3/7] fs/buffer: use sleeping version of __find_get_block()
      https://git.kernel.org/vfs/vfs/c/5852088c19f2
[4/7] fs/ocfs2: use sleeping version of __find_get_block()
      https://git.kernel.org/vfs/vfs/c/2732f3e4752a
[5/7] fs/jbd2: use sleeping version of __find_get_block()
      https://git.kernel.org/vfs/vfs/c/ce1fb0552481
[6/7] fs/ext4: use sleeping version of sb_find_get_block()
      https://git.kernel.org/vfs/vfs/c/9461e25786b0
[7/7] mm/migrate: fix sleep in atomic for large folios and buffer heads
      https://git.kernel.org/vfs/vfs/c/6676209df9cf

