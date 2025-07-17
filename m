Return-Path: <linux-fsdevel+bounces-55213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE1B0875A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5001AA4960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D8266B6F;
	Thu, 17 Jul 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLmucTO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF81EF0B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738965; cv=none; b=oMvJ56StUJZoVm0BOFgJBjiij0diYac4jnSg0GRWyIqfY0XUH7PL2DLpAxFWVacFfU2JKfq6tZp2s2OALpal/zvbnYlBjJCNl+ga2T7nobhtbj6VTp5kaG/s6ELiBJizVLhrrDwBP0Jm4+DcSMn6fQR080kn4WqbawSYViRnRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738965; c=relaxed/simple;
	bh=aI1Jwb9E2TJHqR86TCymxEi9rVvHA684GDEY0/H/lDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZpDoa7UniZ4NJIZ4hmIkqdf43qqz3zGVRIx9PK5l/JfjTcMt/a2qucPdr676Wh6uIjZ56urTE2Ec2ESxSMXNLcNAgQCzpg/JlkNaiBpQDmbpsUScqonQ65iBPWwkycanDfeMUPgSlA6XJdpbGUD7L77usuUT+alSpX6vij6xl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLmucTO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDED9C4CEE3;
	Thu, 17 Jul 2025 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738964;
	bh=aI1Jwb9E2TJHqR86TCymxEi9rVvHA684GDEY0/H/lDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLmucTO+I5jcj6hLU1Fx1Mr2kGHQoAATZ0PRk/Fp7mF+C9zYiZ3JGwfMtKaAbqsFi
	 40jk2uZFeRG3+XeKy85S4HqZVwVwOTn752A59ytootk6jtUll61zvNStB+0nxWZU8R
	 4SpdaeGaMExvj8hX+e/nL6c+vBdJAs7h1Ulpz5nmScWgGQsgxNGAqryfQRiZymkvSO
	 XvCcLkFY29zauuKhV0tEETZg1H0Qd37ONTZz61JDjeO203TnckpeW2wUBNfxuv2nvh
	 V8c38OJ+BZ4PlXWtBnl+V4LcIlCHtjqrGnf4n2xZNPcjbW7BiFJK5/zEEgwCnjBnDc
	 ns8Na7HlVcl1w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	miklos@szeredi.hu,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 0/5] fuse: use iomap for buffered writes + writeback
Date: Thu, 17 Jul 2025 09:55:57 +0200
Message-ID: <20250717-wickeln-schematisch-5f78e7e413fe@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715202122.2282532-1-joannelkoong@gmail.com>
References: <20250715202122.2282532-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=brauner@kernel.org; h=from:subject:message-id; bh=aI1Jwb9E2TJHqR86TCymxEi9rVvHA684GDEY0/H/lDc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRUrOk3XCfde+ZO9pktWZXKC7gmpllErm1myZZd/aymP /PQkU9uHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM51MXwz0Kp+2OtYEbs47zA aXpTVD5v9knJ3lDQIC15+73JNvuZ9gz/67penbmdLWw+c3dEe9+a2QdipvNdeK1Y8ECfNUh+jlc gDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 13:21:17 -0700, Joanne Koong wrote:
> This series adds fuse iomap support for buffered writes and dirty folio
> writeback. This is needed so that granular uptodate and dirty tracking can
> be used in fuse when large folios are enabled. This has two big advantages.
> For writes, instead of the entire folio needing to be read into the page
> cache, only the relevant portions need to be. For writeback, only the
> dirty portions need to be written back instead of the entire folio.
> 
> [...]

Applied to the vfs-6.17.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.iomap

[1/5] fuse: use iomap for buffered writes
      https://git.kernel.org/vfs/vfs/c/a4c9ab1d4975
[2/5] fuse: use iomap for writeback
      https://git.kernel.org/vfs/vfs/c/ef7e7cbb323f
[3/5] fuse: use iomap for folio laundering
      https://git.kernel.org/vfs/vfs/c/1097a87dcb74
[4/5] fuse: hook into iomap for invalidating and checking partial uptodateness
      https://git.kernel.org/vfs/vfs/c/707c5d3471e3
[5/5] fuse: refactor writeback to use iomap_writepage_ctx inode
      https://git.kernel.org/vfs/vfs/c/6e2f4d8a6118

