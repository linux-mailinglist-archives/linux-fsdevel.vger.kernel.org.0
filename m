Return-Path: <linux-fsdevel+bounces-17752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C552B8B2198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFAE287600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A812C468;
	Thu, 25 Apr 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQYJLaIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7912AAEC;
	Thu, 25 Apr 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048119; cv=none; b=bLKM52LrJ6M2jfkGtOOAaYvt844AKMWhXyeWZKeI/UyeHCtgoeWpsLKSk6uWxOG9Cx9IRPzw42E9XTT9prL4F414gLCraFRYDW2kCyuDSQgJRr37qbYf1Ay0Jj86ifO+GsX66v+kZZl5ZH1vgSUb4wGtUQdRzNALwqjw/sv8NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048119; c=relaxed/simple;
	bh=saQubiJ8B8IiQWQ1nNmf3R9q/utKA2r6d7Pfe/giCGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExtzoxgXL79GsTZgrk6lTDoKjMVuL/tFUBwekMGnxWm/7/Z4OqsEeJz/vLRoFHkVpcJuFmQ0/KswXiUi9XN3Xs2TY1y1JKl3KQ52R8VPnH3tWIuWCFMaitFkpl2o4Bbc8RB05eyrE711Tfb90tkoIKlRvmqf0Nj7GvNopfR0yPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQYJLaIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113B5C113CC;
	Thu, 25 Apr 2024 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714048118;
	bh=saQubiJ8B8IiQWQ1nNmf3R9q/utKA2r6d7Pfe/giCGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQYJLaIHV4IcTJrE3/86wGqEexF4wZbsZ+syPCclBnWKmf8VEzLmXnxPjS6LaWRwW
	 d6UVHNoe4rF4Gk57mxEKW8EvR2ORcwhopq9QMQ2cUyDwMZ8Ho9BHg10TuMkeK2oA2T
	 WN5cyvdhCoH+IRBPXLy/iR+bCjNzM2ouAnCMA+Lyp67dEP8uqegyRaDl0xjR8yEVsZ
	 bKLMN3dMajYdSoxMHOG9FakFW8yYMJNUCQB86XdFEStYfnBCBI4lWA9kmL5TcmLzXk
	 EGj/89lt0Asiy7WbZ5Svw2Bn/iMknVatObou4ecXqQ+V+ama1CcbQ9hAn/Qi+OiIN0
	 SpgroX1Z0/IFA==
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/9] xfs/iomap: fix non-atomic clone operation and don't update size when zeroing range post eof
Date: Thu, 25 Apr 2024 14:25:47 +0200
Message-ID: <20240425-modeerscheinung-ortstarif-bf25f0e3e6f3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=brauner@kernel.org; h=from:subject:message-id; bh=saQubiJ8B8IiQWQ1nNmf3R9q/utKA2r6d7Pfe/giCGw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRp+bh+uvB+6mTTyLUH3LY735QI5729o+5o1iGLhU3pf rXb63obO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyfh3D/+gkxrvNMewCOlpf LytlXpldw1rwUXw1j82975HeF7arrmb4p61/MD4w5YVPY5Bzq/9Btvs6Fxqu/n+W9MA/4/Ebh6V TWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 19:05:39 +0800, Zhang Yi wrote:
> Changes since v3:
>  - Improve some git message comments and do some minor code cleanup, no
>    logic changes.
> 
> Changes since v2:
>  - Merge the patch for dropping of xfs_convert_blocks() and the patch
>    for modifying xfs_bmapi_convert_delalloc().
>  - Reword the commit message of the second patch.
> 
> [...]

@Chandan, since the bug has been determined to be in the xfs specific changes
for this I've picked up the cleanup patches into vfs.iomap. If you need to rely
on that branch I can keep it stable.

---

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[5/9] iomap: drop the write failure handles when unsharing and zeroing
      https://git.kernel.org/vfs/vfs/c/89c6c1d91ab2
[6/9] iomap: don't increase i_size if it's not a write operation
      https://git.kernel.org/vfs/vfs/c/943bc0882ceb
[7/9] iomap: use a new variable to handle the written bytes in iomap_write_iter()
      https://git.kernel.org/vfs/vfs/c/1a61d74932d4
[8/9] iomap: make iomap_write_end() return a boolean
      https://git.kernel.org/vfs/vfs/c/815f4b633ba1
[9/9] iomap: do some small logical cleanup in buffered write
      https://git.kernel.org/vfs/vfs/c/e1f453d4336d

