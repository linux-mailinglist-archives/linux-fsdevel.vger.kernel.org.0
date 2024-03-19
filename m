Return-Path: <linux-fsdevel+bounces-14815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C088006A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911A91F233DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFDC657A8;
	Tue, 19 Mar 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZzgyT2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738B62818;
	Tue, 19 Mar 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861539; cv=none; b=JYzIAPXlN1n0TVcVxyzOPexAeJzK7yVXwJ5OxDqhLwtsA/yksTe4+xAxhcErdlvcsWzZaV/Vd2madbX1h4hOXS1+FponHQoct82YuiOW9Ab9J8Dr5zib7BCI6WSub/4avkHiqm1ImpPqMtl/w0KKv/1yhtpVgnwgLYmdNwS4PN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861539; c=relaxed/simple;
	bh=mXLsvx3NPcyaTxw3wY50t4r5yJKqU68pXzaKruUAPFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXPHPSw6cJ43zaE85eShV5pI/lnbH2dv1MHzmmvN52pKYfTMyTC7Rh5lT9J689v+fFKI8zBS8eMfZj1GCEQ6buSJA+2LryrB7j/9e8k33+lQ5VM6xzaVt2SLrHoGfmyk+eDIlbMGfLrM0zXdx5ws9s2JA6U56XfK4VXBR3+go5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZzgyT2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4C0C433F1;
	Tue, 19 Mar 2024 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710861539;
	bh=mXLsvx3NPcyaTxw3wY50t4r5yJKqU68pXzaKruUAPFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZzgyT2h2JMsfE766edUOchmTKUAn0tOvqkv5xydNY3I8zocA/XpkFKN6VQXlMfG9
	 VjX6HxcuabnZn3mLq66vTY21Bq7TLmBSZn6DotsKs7nIyJbSLy9Vnj3zGCKkYgsVgM
	 oPl4mnF4xa33O32Z02rtrFod5e4yLhksHvwtpI+ht0yIvt2Ex55NF3lafPsMaoZdRZ
	 uMBh6zJdHhJug2dK1KXRixYQRf3NTQgCEmSubkadD6HbBfxCS7XT/AQAPumXgofh6y
	 UOvYgukbi5ws/rSFE8NwkXWy6HiEFvNaKRbRCFCuYPWQ3gQ5diEiKoG/vW1Wc+A1zN
	 UF+4dgiOSEYBw==
From: Christian Brauner <brauner@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2 0/6] Fixes and cleanups to fs-writeback
Date: Tue, 19 Mar 2024 16:18:47 +0100
Message-ID: <20240319-saloon-besehen-01786cbe9431@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228091958.288260-1-shikemeng@huaweicloud.com>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=brauner@kernel.org; h=from:subject:message-id; bh=mXLsvx3NPcyaTxw3wY50t4r5yJKqU68pXzaKruUAPFI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT+XHPD4LVYcv2cXT9+VfK/WXPR7+x7FYlThhk5zhdn6 ZwyvFL1r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi1w8yMrSp/Um9PEU4tLVL RV790bWW4p2lsmXfEp1mcAYp1/h8DGZkuPdm213fjLVaBifU7h0r5mNd7Vj+wli4NJHl1IL4SEd /HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 17:19:52 +0800, Kemeng Shi wrote:
> v1->v2:
> -Filter non-expired in requeue_inode in patch "fs/writeback: avoid to
> writeback non-expired inode in kupdate writeback"
> -Wrap the comment at 80 columns in patch "fs/writeback: only calculate
> dirtied_before when b_io is empty"
> -Abandon patch "fs/writeback: remove unneeded check in
> writeback_single_inode"
> -Collect RVB from Jan and Tim
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/6] fs/writeback: avoid to writeback non-expired inode in kupdate writeback
      https://git.kernel.org/vfs/vfs/c/c66cf7bdd77c
[2/6] fs/writeback: bail out if there is no more inodes for IO and queued once
      https://git.kernel.org/vfs/vfs/c/d82e51471fc3
[3/6] fs/writeback: remove unused parameter wb of finish_writeback_work
      https://git.kernel.org/vfs/vfs/c/7cb6d20fc517
[4/6] fs/writeback: only calculate dirtied_before when b_io is empty
      https://git.kernel.org/vfs/vfs/c/e5cb59d053c2
[5/6] fs/writeback: correct comment of __wakeup_flusher_threads_bdi
      https://git.kernel.org/vfs/vfs/c/78f2b24980d8
[6/6] fs/writeback: remove unnecessary return in writeback_inodes_sb
      https://git.kernel.org/vfs/vfs/c/ed9d128c0c42

