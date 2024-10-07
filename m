Return-Path: <linux-fsdevel+bounces-31170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1C992AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638CDB22A91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367BD1D1747;
	Mon,  7 Oct 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6BMZ5NR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FB18A6AD;
	Mon,  7 Oct 2024 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301966; cv=none; b=CtUvdwvsWwHoywiuMhIX0OwEzu+O/YQOqDyqxBAP660FoHjTE0dOAO92pCwE0SQS7GhWCIDCyhMyla5zhz+AXBfUJwO/hOhvlF0Y4enaL5qjWtQLfD9y8ad7uQWYoYHe/ses4yVqeYpESXDVA9lU7SVGPoqxXh0a8afQfwVukPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301966; c=relaxed/simple;
	bh=kkh1KDw439FhZrjuBMAW7t/oHJ7sEBlkTIxdKS3CpjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxtQgWUkxXRj4GJRenWIgljy267ZQwfVSADNvS/bqAkE60NVLnBHgYCIGVnzIBUrwUN1Vzac9Ky9riqDG5Bj0HYN2SZLII2w2U7Po3w6nGzLQ19RqdMn0DpWfhtFW0tT0ypylX04d1uzgp5DI4PFal8rQ2uTcmdNVeguVLbJQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6BMZ5NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE55C4CECC;
	Mon,  7 Oct 2024 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301966;
	bh=kkh1KDw439FhZrjuBMAW7t/oHJ7sEBlkTIxdKS3CpjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6BMZ5NRSJC++5ZtIiYYkiTQtqsnwgb/8NCCdN2Wgi+Bc9wri30t2grThU4eCeWSk
	 I7kDYVZxA45pT4aSRD8/6Qim7l37HpDvLuKv0gE48yzxmgR4gtaqyrfMC7n4RYUh1Z
	 S7NFtBsgodWlyKVybz/umwa1ndLT3OvX0PuBsrG0OtAq2UztOQsOYU5E1iZkfeecMY
	 WJQabbuBgY0UqnHk2GDfX25n9M0JiSl/CGt/jjtoY6ZbEceZ4EvtgZ/p02d5n09Xqb
	 ke84DbO5a9chddxYe3LwNNTyvOZr1gnJal5+9WXhfluT3x89Wy73R/E9yyAPOhACnk
	 uc9NmE3VrIe9A==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	ruansy.fnst@fujitsu.com,
	linux-fsdevel@vger.kernel.org,
	hch@lst.de,
	linux-xfs@vger.kernel.org,
	willy@infradead.org,
	cem@kernel.org
Subject: Re: [PATCHSET] fsdax/xfs: unshare range fixes for 6.12
Date: Mon,  7 Oct 2024 13:52:18 +0200
Message-ID: <20241007-ortstarif-zeugnis-bfffcb7177aa@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=brauner@kernel.org; h=from:subject:message-id; bh=kkh1KDw439FhZrjuBMAW7t/oHJ7sEBlkTIxdKS3CpjE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzn27vtnWyfqUqv2jrrkD/qi0df1TE2+u0Xkw//HJC+ 9e/8T9jOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyrISR4eiNUwGWwpfu/34j ce33o7N1J9q9gxYeu2uy+Tpbg5kY12OG/8nf1VxOH/hqyS7ya+mEO5Oqv8gWRS5T83n92nba7KV nzXkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 03 Oct 2024 08:08:55 -0700, Darrick J. Wong wrote:
> This patchset fixes multiple data corruption bugs in the fallocate unshare
> range implementation for fsdax.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.
> 
> --D
> 
> [...]

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

[1/4] xfs: don't allocate COW extents when unsharing a hole
      https://git.kernel.org/vfs/vfs/c/b8c4076db5fd
[2/4] iomap: share iomap_unshare_iter predicate code with fsdax
      https://git.kernel.org/vfs/vfs/c/6ef6a0e821d3
[3/4] fsdax: remove zeroing code from dax_unshare_iter
      https://git.kernel.org/vfs/vfs/c/95472274b6fe
[4/4] fsdax: dax_unshare_iter needs to copy entire blocks
      https://git.kernel.org/vfs/vfs/c/50793801fc7f

