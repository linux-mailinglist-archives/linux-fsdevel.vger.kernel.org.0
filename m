Return-Path: <linux-fsdevel+bounces-42398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE79BA41B82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633B87A3F84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9F25744C;
	Mon, 24 Feb 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdGY/V6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89F1D90DF;
	Mon, 24 Feb 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393936; cv=none; b=NEnVxLdXFoI3sVzGGDe47L6MoOHZPF68grwCaNsXjQVTX7IYnOj5WSUvJzlZ4oUNfec0Jbu4Wy3W/6OHapLXz8vMjdxWM7cPy3yjHnLcBDPYSZVWXblBmKB//fMzGG9wWjbmBoAn9CD74+wqPMA+RIkda5JByYv/dabs+UEXf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393936; c=relaxed/simple;
	bh=vGaIzPMkHQEEWfhRyvbGfCJxIL93A6HKSBMqc9lpVJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hnp7v00eGqCXhe30CsLHzM9vzEG0x3V1Fih4hGbAizffsVamwaPkJEeTB74KmRUiMs7wSNvj3XXwEcxueiBJQYX0bXMP1FqM7pm22OUdNnHg14Hb14lOBxf4riTljetIn3Wx0XgZP+69DtK0aX9orHdbRM5eQOwIEOCNwraJpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdGY/V6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC544C4CED6;
	Mon, 24 Feb 2025 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740393934;
	bh=vGaIzPMkHQEEWfhRyvbGfCJxIL93A6HKSBMqc9lpVJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdGY/V6mJfr+RWCq7refHM+XLmstl04/DVun4m3qEIG2ZcDbFE6byCXO6uCf3pUS2
	 w1oiPcLrd2x8HQ74MUYjPRL7co5wl4ydq18yJ9TGz3/XmLROt08ZVBfdMavW2ZaO3l
	 GYD6dvofy3RLhgZUEM2wucVGAccX+PdRCNmrWYWYyrzckSIF5aGzyWvz7hOOLppjMU
	 eqaxl0GX1JHZUt8k689WURD+1qB+f+7aE6UH2WUQQv5aFddrNdiyeUL/7D47XztuLs
	 j0qe5W4uwq2cSeycN/z1Kyze9J6A8keIezMhCjHFdLNQ6pf5MLQrHQz5Ky/1mG5dGn
	 UxDCShzFWJRRg==
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	akpm@linux-foundation.org,
	hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Subject: Re: [PATCH v3 0/8] enable bs > ps for block devices
Date: Mon, 24 Feb 2025 11:45:19 +0100
Message-ID: <20250224-sehtest-messbar-784a08cdaf75@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250221223823.1680616-1-mcgrof@kernel.org>
References: <20250221223823.1680616-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=brauner@kernel.org; h=from:subject:message-id; bh=vGaIzPMkHQEEWfhRyvbGfCJxIL93A6HKSBMqc9lpVJE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTv8T2awHa4gCNY5ujH72qyZ4LU1K+I3DbxCy7ibGlgS LYL/67dUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHQe4wMxz7c1tgifeHfC9H/ S4W3fTU73vafva1M+2juifPNZq1FvYwMu2/sOT/9zK279+afL+1fa3rMscvQ7ELmpSZxpm9/jiw 3YAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 14:38:15 -0800, Luis Chamberlain wrote:
> Christian, Andrew,
> 
> This v3 series addresses the feedback from the v2 series [0]. The only
> patch which was mofified was the patch titled "fs/mpage: use blocks_per_folio
> instead of blocks_per_page". The motivation for this series is to mainly
> start supporting block devices with logical block sizes larger than 4k,
> we do this by addressing buffer-head support required for the block
> device cache.
> 
> [...]

Applied to the vfs-6.15.pagesize branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.pagesize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.pagesize

[1/8] fs/buffer: simplify block_read_full_folio() with bh_offset()
      https://git.kernel.org/vfs/vfs/c/753aadebf2e3
[2/8] fs/buffer: remove batching from async read
      https://git.kernel.org/vfs/vfs/c/b72e591f74de
[3/8] fs/mpage: avoid negative shift for large blocksize
      https://git.kernel.org/vfs/vfs/c/86c60efd7c0e
[4/8] fs/mpage: use blocks_per_folio instead of blocks_per_page
      https://git.kernel.org/vfs/vfs/c/8b45a4f4133d
[5/8] fs/buffer fs/mpage: remove large folio restriction
      https://git.kernel.org/vfs/vfs/c/e59e97d42b05
[6/8] block/bdev: enable large folio support for large logical block sizes
      https://git.kernel.org/vfs/vfs/c/3c20917120ce
[7/8] block/bdev: lift block size restrictions to 64k
      https://git.kernel.org/vfs/vfs/c/47dd67532303
[8/8] bdev: use bdev_io_min() for statx block size
      https://git.kernel.org/vfs/vfs/c/425fbcd62d2e

