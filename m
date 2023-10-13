Return-Path: <linux-fsdevel+bounces-265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858697C88FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8232BB20AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBF1BDE0;
	Fri, 13 Oct 2023 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah9ZcLKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166AC1BDD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 15:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4950CC433C8;
	Fri, 13 Oct 2023 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697211885;
	bh=gNiufPYZ0hqW339nlkZ0KShCby3GmH/4QjkDOxAMhRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ah9ZcLKa5+3a5lw/2RUpzEBlv25I7NYXUvEM4cIdlEAA/57SWHHmYXgZEhi+corK2
	 sanaGiSfMiwMzlMD/ChiTUodBJ13U5rMtECK0R5fJivcc0o/VAo2QzbhyfJ2j+hblG
	 3i3lO7CmuteU+0Cd5rJ6nVMbbTJztOZnFXy7nS/8H1WkxGeZAumrGnvOLwIvL44wZI
	 42siTjyIoIzvBxCDvL3SRA71bmYwRWvKcnevi3x67vZIMt+nMm2SEcaIL7BMfnb1st
	 6CQx1DQcrgJZkU9x8xaLwfPAEC1jkpEyyPjveVJNkazRClwPtM6q7sdg719PlEpXmq
	 IQkqy1seFCYpA==
From: Christian Brauner <brauner@kernel.org>
To: Dan Clash <daclash@linux.microsoft.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	dan.clash@microsoft.com,
	audit@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference count underflow
Date: Fri, 13 Oct 2023 17:44:36 +0200
Message-Id: <20231013-karierte-mehrzahl-6a938035609e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References:  <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=brauner@kernel.org; h=from:subject:message-id; bh=d37zo00rWfqEWvqv9CBNgrxFEsB2MVrLwwB/cAPjv9o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRqph5iehkbnpXoJ8qwaq/PM76TkusybaW+xVyfkfFFWKne 02ljRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEReNjMy9Nbt395ZrxhXcHbWoXc9Xa /1TP4cMM+48/GFREPiuqusvxj+iulVvZu9q4D57deIjKcvNYPL70caLdq4e33AfJvYr14L2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
> An io_uring openat operation can update an audit reference count
> from multiple threads resulting in the call trace below.
> 
> A call to io_uring_submit() with a single openat op with a flag of
> IOSQE_ASYNC results in the following reference count updates.
> 
> These first part of the system call performs two increments that do not race.
> 
> [...]

Picking this up as is. Let me know if this needs another tree.

---

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

[1/1] audit,io_uring: io_uring openat triggers audit reference count underflow
      https://git.kernel.org/vfs/vfs/c/c6f4350ced79

