Return-Path: <linux-fsdevel+bounces-18506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB38B9C49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 16:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF80B282EDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E2146D47;
	Thu,  2 May 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R29od4mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D439146A60;
	Thu,  2 May 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660301; cv=none; b=EfS7ZzVUVIR2XJA9ZQdsDiXJZtyT00ERmJ5QLNK7kVUubUoFDcV5pOXuasR5vkW0D7P2z+KQQkjQXl72EPgk0bEI/08gLbGDCH8TvuG0A7jge3AerW97nEWpembymEwwTWMGF83kczJFh25/+D/4sX3ZprP1ypa0qDWRpWVIrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660301; c=relaxed/simple;
	bh=sttXAQlDkry878GisRDLVSsUBawvXm80C0r/QQMOe5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2FJDSy0YDf7nrxAmwSOLRMtiZO5pB0HqRZgoEB9Smlrot0iNhpr95niWy3ZzcJ9IagFNTJos7DQl6U7aLsQ32LmQ8hw/dyV0Kq509mi9ecdZhmB1ytxPwsl7uNf2l702ARmExTzXqhrQRwLoa0hT1dQ/eiH2SnYDD3DAbYrKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R29od4mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4367DC113CC;
	Thu,  2 May 2024 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660300;
	bh=sttXAQlDkry878GisRDLVSsUBawvXm80C0r/QQMOe5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R29od4mhV3Jn+vhFKx0xzVoCjfx1NebkPQrdnRdr5BxaDUBPpZkrBQ6Wk2diLBFNH
	 PwAViP0KVokkvj0dzujw0spg487c3Zw/yCDGYFAqyQCGR3gxIGgctLFKcL4AJjitEV
	 pWjnVmY1qzX2cxS35wj//3iejaZs1nB7WmOejucPmqdpmdvP1ddNXPd7YAFWU02oqq
	 CGrY8EMnfo/fT89iu4buWxtjWTnHrlonL44Ixtd5PxTrOPaSEjxcbs4/L4eiu4eloH
	 PnIXKKZqQF7vqWPOStHQ+Sz5YLr0H0jw/fubiLr+rvEXsR36JzlSGD8U+I3C4kBpy+
	 VFFiyXeEKlsvg==
From: Christian Brauner <brauner@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David.Laight@ACULAB.COM,
	rasmus.villemoes@prevas.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/2] seq_file: Optimize seq_puts()
Date: Thu,  2 May 2024 16:31:31 +0200
Message-ID: <20240502-hinstellen-standpunkt-1d38980bc0ce@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr>
References:  <a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=brauner@kernel.org; h=from:subject:message-id; bh=sttXAQlDkry878GisRDLVSsUBawvXm80C0r/QQMOe5o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQZLz5S/q87KFrXwjIvaf+ECdUhcvyNM7RFjQP/8T7gX jTv9fZvHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZwMzwP+/e1cwZrO7Pl+bl mE2/9Nru4df2/84zHW4FBi/M3HRz5ipGhlksB2vc129/zzQ3QdYvVlX4lLxs0wnNb1xPJjVcs+n R5AUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 12:24:06 +0200, Christophe JAILLET wrote:
> Most of seq_puts() usages are done with a string literal. In such cases,
> the length of the string car be computed at compile time in order to save
> a strlen() call at run-time. seq_putc() or seq_write() can then be used
> instead.
> 
> This saves a few cycles.
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

[1/2] seq_file: Optimize seq_puts()
      https://git.kernel.org/vfs/vfs/c/45751097aeb3
[2/2] seq_file: Simplify __seq_puts()
      https://git.kernel.org/vfs/vfs/c/e035af9f6eba

