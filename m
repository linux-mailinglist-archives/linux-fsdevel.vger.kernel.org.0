Return-Path: <linux-fsdevel+bounces-73393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0DAD176C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ABE0303F741
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAA3806C3;
	Tue, 13 Jan 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrnTrxD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BE1F3B87;
	Tue, 13 Jan 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294651; cv=none; b=s/mVwCgrKH5LNpU/MmowLAG7YYqO2gni8TAihFzBe5gciaMvtCw3Z4+uNMrZgQ9EcJMHnw/H3izdIwb2mYWUJl43XifV5znsZAo0mQOpsMtBQcirA8PjUBJ2Xrc9yjNm6TJwIHm09y0hAZrgtC4hP2RyY1cTnxlcmkIVxfXNoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294651; c=relaxed/simple;
	bh=QBk9+V2SxJ4A4LG0A/um8XxD/QOaGgBVRWzxaYODJto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB7hwAllXGpzqSIbFjVHc0aeoftfNZMqJo+pKak1s2ZZBQif42nAIoe+Sn4Oaa9butQuXloz0rFMtxmlbrJnP5Ow+iruDi4N0/FLSj5FZnM3yDkOPVg+CoGr0bofZ7IMkO+31OabRVLf4pSB+0MlDZARrt6x9BkfXfuwDC7ICuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrnTrxD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8614C19422;
	Tue, 13 Jan 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294650;
	bh=QBk9+V2SxJ4A4LG0A/um8XxD/QOaGgBVRWzxaYODJto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrnTrxD2gExaNIbJH9PBzkswZXIdZX8gQyfvC+Ug9NyPBSFdPFEfimIWQeVBERZYl
	 hw9yp45G8sXcPYDInNrsjlGOfCNnXZBVqWQbAM/HQiw2f0e+vzLMC4pmvYGP4Z8HZH
	 f2ujGcR2xSklnirZGlbwFPsjZRXOz5zR6FbEIbOKNbwKnXhi5WTMj6dvCCtsZFHPQX
	 07GJqWzFJoIblKZQfulbq8UiOSg/kh1JHRp6M0dSqE7TzyggLRgPsQUMPngA/X+92j
	 Qqb+Lb9pObgb4lTrvyl2uKgYEWIanp4MWdJI5BozbEqFRBNMn4WF8UX7ciYFR8tfSO
	 7T7m8td2PS7iA==
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	mjguzik@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+9c4e33e12283d9437c25@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] romfs: check sb_set_blocksize() return value
Date: Tue, 13 Jan 2026 09:57:17 +0100
Message-ID: <20260113-wetten-rachsucht-b852bf113d6b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113084037.1167887-1-kartikey406@gmail.com>
References: <20260113084037.1167887-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=brauner@kernel.org; h=from:subject:message-id; bh=QBk9+V2SxJ4A4LG0A/um8XxD/QOaGgBVRWzxaYODJto=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmcXzVXOeY8kL68bdXz/dq8Gnp7FUN3KP9dor/zkzd0 LD+f6anO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSz8XwV/ban2d+TQYtK270 TY/9/2D63IAlb4rOnk/l9eXKSvqypp7hn7Vig3nY5BtelxJsmpbOWrJ0Zf3jrKrEGO45KhaL084 3cwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 Jan 2026 14:10:37 +0530, Deepanshu Kartikey wrote:
> romfs_fill_super() ignores the return value of sb_set_blocksize(), which
> can fail if the requested block size is incompatible with the block
> device's configuration.
> 
> This can be triggered by setting a loop device's block size larger than
> PAGE_SIZE using ioctl(LOOP_SET_BLOCK_SIZE, 32768), then mounting a romfs
> filesystem on that device.
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

[1/1] romfs: check sb_set_blocksize() return value
      https://git.kernel.org/vfs/vfs/c/ab7ad7abb366

