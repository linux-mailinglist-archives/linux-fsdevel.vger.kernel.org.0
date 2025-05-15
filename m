Return-Path: <linux-fsdevel+bounces-49118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16777AB8386
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E3E1B67742
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170F297B9D;
	Thu, 15 May 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uin2Rz/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87028540B;
	Thu, 15 May 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303474; cv=none; b=QOe0/mabRIixQIb6J2DYpGoUgGHu/z2aPr7QACkfAqNhwHl39y7d5tZEKYwYhClqcWSvBpSv8U2ORWMLylnvsSPfAIEgnX8BOVryiSYbc93nO/CU6+StPe/JosTk06nnqw9/ibTJAnHjt+LPh/u8V0UGAd+ccWwTs7tCO8wZW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303474; c=relaxed/simple;
	bh=4fv5s1gQ9Teikm9yrf0w4UpJvAG//n1htCUJx+4nq4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCVNQiJ/XY9RLOXTYeVLmp02pbX/Uotzxs5Rorv7H17hyIdtuPpS6SJ0Bg7YrA+MBhni8K70P48OagXpEkUywcfKm7UWP7XcGHqrJ0b0CwLpBFSTqJthZOKqxqsGH25IlTqwwdWhwoQVM1A+gZiRi7HHD8k0UFMIA0fzwkG0dm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uin2Rz/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DF5C4CEE7;
	Thu, 15 May 2025 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747303473;
	bh=4fv5s1gQ9Teikm9yrf0w4UpJvAG//n1htCUJx+4nq4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uin2Rz/qjU+at2D7epdPaUL2iL/qvJqvVs0nND1g6/bF/hfb+bI5E7sokurf10GZ3
	 zSPC6A2BstdjDnGsWx8xu1z313IwWKwhNfuptYz73qVOJ2ankAdOimymnEh8NGwIBW
	 x5+E2oOTfk8uXUBzhjCep7R9Ic59pZztKV5hdg5cEZy55MWFCPCkoLQAuSJ8IKSGhq
	 irm5XJIC1C9AnQQLP0nbEJhBjq027B3RcU0/o/lrCrpWExlJKDPmeXNjmh4tF4yQ02
	 gxtfQwCnW27axXw5yzJ47/RhQxOQjItN8MpXP7ErhlUH2iQSLZ2/0T4Q9V/F0aapCt
	 hZlItVXccSOAA==
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] include/linux/fs.h: add inode_lock_killable()
Date: Thu, 15 May 2025 12:04:20 +0200
Message-ID: <20250515-wettrennen-zweisamkeit-5493081baee2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150327.1373061-1-max.kellermann@ionos.com>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=brauner@kernel.org; h=from:subject:message-id; bh=4fv5s1gQ9Teikm9yrf0w4UpJvAG//n1htCUJx+4nq4A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSo7tGZc/PIkzX5Zn9mMm67V58RnWq3yUCJq1LN8ztH2 +n/oazhHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp5WRkeMH7KE3Xt9j59ySH o3IrHZtvTTNUL2o/zb+CT2K3/bmjZYwMW3adP2L5NmXvo8sFi9Pu+lS+sXN6018f8OF79/xnzL1 zWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 17:03:24 +0200, Max Kellermann wrote:
> Prepare for making inode operations killable while they're waiting for
> the lock.
> 
> 

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/4] include/linux/fs.h: add inode_lock_killable()
      https://git.kernel.org/vfs/vfs/c/d8c5507cd140
[2/4] fs/open: make chmod_common() and chown_common() killable
      https://git.kernel.org/vfs/vfs/c/28a3f6ab2fe0
[3/4] fs/open: make do_truncate() killable
      https://git.kernel.org/vfs/vfs/c/d68687564280
[4/4] fs/read_write: make default_llseek() killable
      https://git.kernel.org/vfs/vfs/c/2e1a8fbff51b

