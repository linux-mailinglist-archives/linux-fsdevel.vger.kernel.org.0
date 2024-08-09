Return-Path: <linux-fsdevel+bounces-25540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F315494D336
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3E0284EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8D198840;
	Fri,  9 Aug 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTVUuXbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAA198A11;
	Fri,  9 Aug 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216566; cv=none; b=S76+wFTDK2YlLk7m2x4SHjnXwO+5zJPyCFmU4mdczJAzXOvIqrxp4BcFj5gc602iU+hbIIdTp4fLXtSf+dJKxsj7ET8NmtnK5wWlQrsLOIxUPZELawnQIVm4z/3p2dcbtFSgN7Ztkigj0crdP7vDxtpr3bLlCW+ogfk8SBla9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216566; c=relaxed/simple;
	bh=QzbMMXohX/nbFUDAv2G2AVoMhu56MDJK2QCsx8awg/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMg7q7foLPH+tHeyfFr1uXDk8B70/cqGBsEgT4vnAt5uVjE7oeeB1NOMyeD1lrwvKExE01DE3o1V5TQvR+eTdoBEI1fJ7sXvb6wKgzl+dgTcSz2Y6HOMv85+QTTmFp7DYaqysHxstJj9fNaAB0uqnki+d2ELnybJW/q5N2HUYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTVUuXbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3575C32782;
	Fri,  9 Aug 2024 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216565;
	bh=QzbMMXohX/nbFUDAv2G2AVoMhu56MDJK2QCsx8awg/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTVUuXbArCav3KJVsl+eSc5AkhIRDvwX3uQS+sX0twaDYoS4G1Bb3AUiSFynlLqcL
	 gEermTVfi66DEOhk3SG1IHPzSHW5i8qj0tXO6o6OcQwoGNiA8JwaUtKpWVXjVc0SBq
	 S9TdtIMrJ6cQyHpPTxqaeYOMXcJ9Iugr5uLLuvio9ohPakgXzuFEaz5kYTNTwLmNXu
	 JJ3CGcCEiY6NpxGgg/RcWkxIv7uAs8PLryiMOQpg/Zv08B1/MIsHylABygWZKa0GPY
	 J5lror6LoFp1Guh0FkH4MAUO5t1xgQBqgoodSuTC2juW+AvUyfGhY4W14iVLFGO5vG
	 J+/M0xWh0CUGg==
From: Christian Brauner <brauner@kernel.org>
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com,
	wangzhaolong1@huawei.com,
	yangerkun@huawei.com,
	mjguzik@gmail.com,
	viro@zeniv.linux.org.uk,
	error27@gmail.com,
	tahsin@google.com,
	rydercoding@hotmail.com,
	jack@suse.cz,
	hch@infradead.org,
	andreas.dilger@intel.com,
	tytso@mit.edu,
	richard@nod.at
Subject: Re: [PATCH v2] vfs: Don't evict inode under the inode lru traversing context
Date: Fri,  9 Aug 2024 17:15:36 +0200
Message-ID: <20240809-neuanfang-recyceln-b3d99596e98f@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809031628.1069873-1-chengzhihao@huaweicloud.com>
References: <20240809031628.1069873-1-chengzhihao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=brauner@kernel.org; h=from:subject:message-id; bh=QzbMMXohX/nbFUDAv2G2AVoMhu56MDJK2QCsx8awg/A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtM1pzas0xLi7eKXOP/jVYMOvYsu3syX8WfDZ7quSVm OqmJR95raOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAipzgZGa46OBQseXPG6PAJ sx6Vtkc/Vv2ZuPfFZf78ZbsKBVbtVU1h+KfJt6xlhYCouNXlpCmZxkdKT298+0Os1m67NcODPtO l0ZwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Aug 2024 11:16:28 +0800, Zhihao Cheng wrote:
> The inode reclaiming process(See function prune_icache_sb) collects all
> reclaimable inodes and mark them with I_FREEING flag at first, at that
> time, other processes will be stuck if they try getting these inodes
> (See function find_inode_fast), then the reclaiming process destroy the
> inodes by function dispose_list(). Some filesystems(eg. ext4 with
> ea_inode feature, ubifs with xattr) may do inode lookup in the inode
> evicting callback function, if the inode lookup is operated under the
> inode lru traversing context, deadlock problems may happen.
> 
> [...]

I've replaced the BUG_ON() with WARN_ON().

---

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

[1/1] vfs: Don't evict inode under the inode lru traversing context
      https://git.kernel.org/vfs/vfs/c/24b0ba4e047d

