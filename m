Return-Path: <linux-fsdevel+bounces-51770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE5ADB39F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464117A62B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76C420468D;
	Mon, 16 Jun 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2hVhxOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA11EA7DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083517; cv=none; b=LMQDSMJkwh5qJcqlEtqepW9KzsoTWCxQr6H8TvxW86lVumtLXb6Lb+qvEpS7XmGndncD//Mygk5pOx4k17V3AaB74LaFbV59rhRxKCbPGAg9nuSanQ6s+IveF6TUGSj5/2Fq8ixLV7ImZw5SHsNcAwAMl20yzMuqSDB6PWsct3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083517; c=relaxed/simple;
	bh=Fe9F/+iegVTN/EmEj11GWION/d6TNhRc1zrPVQKqPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+z/BFNWdyKq3dCSoLCsJ4VJjXT8VITjdOClk2Oe9fcBQt9y09YUNXpe/rB29V4VFlS/pFAOj1q/xdcgiPboesnJ1uQrVC34bfVXZ8ourrru+kfzWZoHJxUda13Nq5ib3RChzDYBeXb6FAVKLA3SpQBukB5jg13uJB7kA3qfauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2hVhxOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C73CC4CEEA;
	Mon, 16 Jun 2025 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083517;
	bh=Fe9F/+iegVTN/EmEj11GWION/d6TNhRc1zrPVQKqPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2hVhxOOmCRASMuFWEztC96QzzVdL54/ypetxfVU/eEJRZoy7nNCrbGEs6yQ37UoP
	 yxBXsIhuNT3YCm//hBvm1D2QCY1+Rh4iz+iJyMTTomYbenFF+R7+YZBuuuDVOvcIyd
	 4iPZB/EGVdIuu2JG8QQV2Hw8UMWRYMzDIkCAyrwiJzQeEkRI8XpmP6eqY+2GeZvvIZ
	 B9+Q4ybCBQRvay/bmy4k9S8zTXGOb8BxOHC64H9hMS2cKMlzy5x1autudQaDro3Gay
	 I2K1LqitK/3V0rUOUN9yndbCL8C23Flw1HeGnhRaKa3g62OYsHb1QJ9UQ70BqiC0wq
	 D475FFl6RnnLQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: (subset) [PATCH] don't duplicate vfs_open() in kernel_file_open()
Date: Mon, 16 Jun 2025 16:18:08 +0200
Message-ID: <20250616-akzentfrei-tapir-bf866897b651@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250615003216.GB3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV> <20250615003216.GB3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=brauner@kernel.org; h=from:subject:message-id; bh=Fe9F/+iegVTN/EmEj11GWION/d6TNhRc1zrPVQKqPy4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEqO84ovZ30Q/muN8uJayBj+/9lNnoJBh/9ZzfF8Ubx ybo6bAKdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk0gRGhnk7z0yquVVqsiuX 72XqlKUa8nHXNn7beV88xtakRz0wZTLDf7ejZzYGF3X67Fj8NG3dXE1H558rt86eFrphyfeNaYK VTewA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 15 Jun 2025 01:32:16 +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> 
> 

Putting this into vfs-6.17.misc with the rest. Commit message updated ofc.

---

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] don't duplicate vfs_open() in kernel_file_open()
      https://git.kernel.org/vfs/vfs/c/55392e956e7f

