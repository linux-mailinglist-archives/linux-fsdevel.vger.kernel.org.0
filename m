Return-Path: <linux-fsdevel+bounces-36181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806F39DF043
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 13:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0525B21BC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE5194ACC;
	Sat, 30 Nov 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKaU5JWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27DAD23;
	Sat, 30 Nov 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732968516; cv=none; b=gEfGAPR5ejBntbB973c3/1q4AmL+Qt7aKFrenXY0bKMPabl8ajU/QC6UNxJGuOWttgBvAxxdMtuFxkDGYq/Xj8K8hE+iPezjy/wPsaACmeX32LzPGNdv/+YABpd+FF442KtgWmzCLBzriG2OyrtVI7jH88U8JMA7sR+jgj9Uoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732968516; c=relaxed/simple;
	bh=CezsRKzPhE3iwg1foiuIEu7w92XM5wn9vMFdnQMVbFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGcqLqJQG7MyreVrBLAGpIG6ff4u6uLc68JS/STVjyHbCPJIHEZeLtBLEfuFMKyj8MosR9dPw5WOiOlFsPqU5wvoxDn5S9vK1afUyXjIUn0MbMsZUbl1be1DoxtRr23dhy5APmFxjDad6C3Srn1mMNvEEMgj4aY8cWDd9OQ5ZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKaU5JWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC589C4CECC;
	Sat, 30 Nov 2024 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732968515;
	bh=CezsRKzPhE3iwg1foiuIEu7w92XM5wn9vMFdnQMVbFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKaU5JWPPyie7Tfy5t7xSjZIuc/7v5/dlJ96drAxOgGl2aPZZ67HuYJ0+jJy9u9zT
	 9gkvTDC0zvpg+Xfrd5vg2hyRWtAmcgDrnzIJ8CHT9wGBQuC+etDSQKPQFpapF8/VCp
	 ZH3XAAm9l5DL7CjIxcPkDwDjFd1sRwYhnHQgjsTNsVrxpC80Z+n/75yVlJX1KhpUS6
	 vnY7c9ZMqzLIEaO1KwGQIlEngzmr2dvEB4Ox+zTWK/RMsBAy2NVOdmciXcV5XVB0EC
	 +OyElNN9jWJvTwmmTUZ9TYUQfWzof4Gy3+Pd3/PPe12PLWief6dBYRj1zMnygRSCwx
	 pTJw5HO4r/tYQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use a consume fence in mnt_idmap()
Date: Sat, 30 Nov 2024 13:08:27 +0100
Message-ID: <20241130-sessel-banditen-096d668b1fc6@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241130051712.1036527-1-mjguzik@gmail.com>
References: <20241130051712.1036527-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=brauner@kernel.org; h=from:subject:message-id; bh=CezsRKzPhE3iwg1foiuIEu7w92XM5wn9vMFdnQMVbFo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7M9jcfM3SPnHHyQTfDdLNIVP9Juxr3VQ7SeJ7Y4bz/ IXcHVXFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh3M/wm1Xbc3vPIgsVhoad bD//7/H6zperd/x6x5Zn/to5vxt+ujP8r/18UO+UGTfn/j+rE+cpXqpo43whupXjZFXqtYiwDzF f2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 30 Nov 2024 06:17:11 +0100, Mateusz Guzik wrote:
> The routine is used in link_path_walk() for every path component.
> 
> To my reading the entire point of the fence was to grab a fully
> populated mnt_idmap, but that's already going to happen with mere
> consume fence.
> 
> Eliminates an actual fence on arm64.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs: use a consume fence in mnt_idmap()
      https://git.kernel.org/vfs/vfs/c/e448a60956bc

