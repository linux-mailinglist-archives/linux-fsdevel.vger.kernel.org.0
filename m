Return-Path: <linux-fsdevel+bounces-3676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38C7F7788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1997C1C20F58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4A82E84C;
	Fri, 24 Nov 2023 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyqkkMlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68C2E82A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 15:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40332C43391;
	Fri, 24 Nov 2023 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839161;
	bh=AxnCrub8TDnlTzblxU/JgLVOnW/iV5OidhqOG/icin8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyqkkMlCeftsYMjf0Vqa9+3fFEH7Yd7j5SJtfDSTGcgjjGmLLywaWqcJm0A4iJbBt
	 fLaz4Un0Zy8VnrXcU9qQmhIbgi69X1z4E/JOJWcT5er5dK4US8pHeJor5Sb4YJVezx
	 lx+pYJwu0e2870JDjgTFk3dlfKe750bY6oMD3l3iFOdWPsl1RPWmtTTTrg+I9QjA/f
	 yWjPmfjhQfKvyEiuDYRVOM2ZxjXh6/QhKJ5/lAnY4EJnxxKAh7aK7o7+KQssdE8+F7
	 3wa4ORDQ8BXEzjs/e0LvmOJHB2ip49l3l3CCqjp/HgrYxoTgJiTh+AV9NwainAvh2U
	 IgI12j2v/SSzA==
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
Date: Fri, 24 Nov 2023 16:19:00 +0100
Message-ID: <20231124-detailgetreu-solidarisch-ae74c731c362@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124150822.2121798-1-jannh@google.com>
References: <20231124150822.2121798-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=brauner@kernel.org; h=from:subject:message-id; bh=AxnCrub8TDnlTzblxU/JgLVOnW/iV5OidhqOG/icin8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQm7HusxnmZrd2q/KC2xjO1VZ/blq7bwnmhK7fyxqam6 80lT8+wdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEToeR4deDnK0M+7dV3649 /of30JbNaQp23OfXLTXmYdt0Ny5RYRbD/7Lu4Oxpx2oesq7Ta8vpT8+PNtRa25BS3CjzxtuJ4cU pZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 Nov 2023 16:08:22 +0100, Jann Horn wrote:
> When you try to splice between a normal pipe and a notification pipe,
> get_pipe_info(..., true) fails, so splice() falls back to treating the
> notification pipe like a normal pipe - so we end up in
> iter_file_splice_write(), which first locks the input pipe, then calls
> vfs_iter_write(), which locks the output pipe.
> 
> Lockdep complains about that, because we're taking a pipe lock while
> already holding another pipe lock.
> 
> [...]

Yeah, that looks to be a improvement in general, since you can't upgrade
a regular pipe to a O_NOTIFICATION pipe. IOW, peforming that check with
pipe_lock() isn't necessary.

(The check for watch queue in pipe_set_size() called from pipe_fcntl()
 also wouldn't need to be done with __pipe_lock() held fwiw.)

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

[1/1] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
      https://git.kernel.org/vfs/vfs/c/efb8f498327c

