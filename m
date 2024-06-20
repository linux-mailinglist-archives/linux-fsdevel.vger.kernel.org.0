Return-Path: <linux-fsdevel+bounces-21973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FB91076A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F055F2874F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982A1AF693;
	Thu, 20 Jun 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5oZDmcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4B1AED59;
	Thu, 20 Jun 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892208; cv=none; b=GnbEMsgfWruSqXN+lbfZknxas2QkGnIRmNAHS/8Zp9AFX+2B4mHIdc+ZxRTDgcNFSkDGfpZwZxNrGRUMfeWFtaiViZ6ZjOpzCNpHYxPeoTTMBoIoWGtled+aCiyiQbN2zgZMUdcFMZC2OyQ6Yy+FqqtTIMVFlqX6YYIUD8uiea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892208; c=relaxed/simple;
	bh=Bm2ZjNf2b+VNKHoshVbV2rXdyFmyGGFZXFG269zvKN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9DFTxxxn2fnlhpAs415tOibfqxsqjARH4MUvoMMAO0rHKyazulGB2ac5AXiywH6/GG7+5E2aMh/re3CJoeLC57m9W8+8ExGUaA9wzP5zuBNWJ1UTvVLAPtcZLjLu/obiA1ExdLhSYrlS0KLSs62ugWjue2csqBnyEZ742XuWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5oZDmcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0095C32786;
	Thu, 20 Jun 2024 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892208;
	bh=Bm2ZjNf2b+VNKHoshVbV2rXdyFmyGGFZXFG269zvKN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5oZDmcRVKiRXGV/z66rlpXEDT79Ddpy4N7glSKSArC8UTNU8pFoRHfWsC5B9w9NS
	 T5kECR2Pd0qqet8v+1zBALgtxdmy7vGcXB0hr3h+ybzQa57RAbbb7jl2TixR8zmGya
	 KNVrGLpf8h8wys9zex85p0mFsWByPDzJxFo/wlCi9FF2qZcO+DFqmCc+5ofCPO0qEr
	 gDlYIGSqo6ZeY8wwrUqdcgOMfaCBz1T9zWZHzDf1PyCI8QRmms3m8R+xqDvjsh9Xq/
	 95/kxM22g6HOD9FeAGvZJMdqUthc9aCGNPMrB7Y5WfPtbi3+HqC8EA+IZ/68MUso3l
	 pTpfMznOFFZNw==
From: Christian Brauner <brauner@kernel.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 1/3] fs: Export in_group_or_capable()
Date: Thu, 20 Jun 2024 16:03:01 +0200
Message-ID: <20240620-biografie-anlief-f8640333c226@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
References: <20240620032335.147136-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=brauner@kernel.org; h=from:subject:message-id; bh=Bm2ZjNf2b+VNKHoshVbV2rXdyFmyGGFZXFG269zvKN0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSVmC17tVI48m/oNrs10XfDN+mzHTzSq/L+0dZ5Pv92S AR433Wu6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI6VNGhmVCq9btav7Av7Z1 3YZtD5pS5G++tNigPeuz8dWExuNXwuIZGY7czpyYG60r4W354eu/7VvMp7/b/CL3u+Hmy8JXAgw nreQHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 11:23:33 +0800, Youling Tang wrote:
> Export in_group_or_capable() as a VFS helper function.
> 
> 

This makes sense to me.

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

[1/3] fs: Export in_group_or_capable()
      https://git.kernel.org/vfs/vfs/c/daf0f1ce3585
[2/3] f2fs: Use in_group_or_capable() helper
      https://git.kernel.org/vfs/vfs/c/29a76d8b349b
[3/3] fuse: Use in_group_or_capable() helper
      https://git.kernel.org/vfs/vfs/c/d128e6b878ac

