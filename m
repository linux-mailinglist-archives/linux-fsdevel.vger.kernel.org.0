Return-Path: <linux-fsdevel+bounces-63004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0093BA8A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591DD188C098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA02D24A0;
	Mon, 29 Sep 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhqAqq8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449472857DE;
	Mon, 29 Sep 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138227; cv=none; b=srEbxrArybjW32WmAG+eCXbYe38+v8IhwJK2Q9o/oc/LhUhmeloE9FP4d7l0e/iIh2QQHqBPzC6OXb7ULhBhZ/nkDmI5/XIsqpdRfFN1+dgsmNkNj5IpZQptrYit/+ZcE84TYz74eiUdURq2GktuXGmO7kt1Su0gxwANTSn4/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138227; c=relaxed/simple;
	bh=Xt+H00FTwMgNX3FYouX/B0DyHS064YKeIo3w5xZa1CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLuL33Ye07+Fn7HGCEgWu9t8OgKQF8rZAo3pQASJQYQnTVD+6Xht5PxHikAr37u2hZu87c5g25WD49wXzL+2cBaywCW0hGFtD3nzq6WZymFROUMQEJQkjJOnb/MaMnc9uC0HCelRs/CIh5ygCkJ1TIqozrk4g1YufYv6F8cG2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhqAqq8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4277C4CEF4;
	Mon, 29 Sep 2025 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138226;
	bh=Xt+H00FTwMgNX3FYouX/B0DyHS064YKeIo3w5xZa1CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhqAqq8zY56VNaNn7XJMxLgA0BQhSL4pZ+0ry3mEDg3zt5W0rO/j78IQzJo5c+ZWM
	 /vInMRN1VI6KhEnBPdyshEe7Cga1YyQ4YQZbRN8fCG5Pm3gJl6tn+YxECxu8G6FJR9
	 lBz+v1bjpkWv3Omy4DirbyRGKviSXKAnJDXDHvW+SLHwyXi7aOlI6m1r8vXU3lca+V
	 lnSx6VrVKnaFVJCT0GEi9/mVt0O19yBRXlxQtIUYRext/rX2zTExmuMG+j+pqyWqhs
	 M2hjPTlbLXq/3xSEINOvx4lbYJnU8zhm+Co/dka6V9xZpxXoP/Zp74DZqGt1Xyh1SS
	 HO4J0eV0iHkDA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Date: Mon, 29 Sep 2025 11:30:17 +0200
Message-ID: <20250929-samstag-unkenntlich-623abeff6085@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=brauner@kernel.org; h=from:subject:message-id; bh=Xt+H00FTwMgNX3FYouX/B0DyHS064YKeIo3w5xZa1CM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTcClyT3LTLJ3nizG/bpjn01Su9D9eJyliz15U3esO6R uFEjtjLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpADdZmuG/+/fNU37Ep5o4VrTn Xs8QNxL9qu7C+SMiasej7JjOMxrTGP77d/tIL30g93KOe8uORyZP/t3aIPije1VW8qfW9nmxKWf 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Sep 2025 12:47:06 +0200, Mateusz Guzik wrote:
> First commit message quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> [...]

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/4] fs: provide accessors for ->i_state
      https://git.kernel.org/vfs/vfs/c/e9d1a9abd054
[2/4] Convert the kernel to use ->i_state accessors
      https://git.kernel.org/vfs/vfs/c/67d2f3e3d033
[3/4] Manual conversion of ->i_state uses
      https://git.kernel.org/vfs/vfs/c/b8173a2f1a0a
[4/4] fs: make plain ->i_state access fail to compile
      https://git.kernel.org/vfs/vfs/c/3c2b8d921da8

