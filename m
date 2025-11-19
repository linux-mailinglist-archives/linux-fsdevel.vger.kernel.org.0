Return-Path: <linux-fsdevel+bounces-69076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB4C6DEE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 68C7C2F06D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB480346E66;
	Wed, 19 Nov 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdL2su6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22E33DEFC
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547155; cv=none; b=a/ylxuPZrLpAJBnlY5HOs9whbYBjJD6abBkrkgJ59/CxNPy+Q6wII0gDfjaNME5h/tOyhEiPhIVXWe2H2UNSCmBIbsUfCiOZLelcsUJ+R4hIpicj8wRNfa+8aHYHjpkrPLuKAIbRaApDZeXi/kUhibsg3A/Er58pguDlxGPJB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547155; c=relaxed/simple;
	bh=s4y3hIjKIKqq2PO03z1odmZRvi1xixNzpQ8u45u0goY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdsQECAeNPLXpwebn+N+8oZUX5WYiHrFMU7b4NNO/uz4F1Pn46UhfmjsWKSN5GMQQ8cpEkbHAIFy1jCvBJWZ4TNutWRTVVK3VmCHUPIJDeCIvqqPsRl0FvzLHEeXW3y3MY2cc0lEQEb7G+JbCGPk51RjnaDEyV9CUXDw2H3cKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdL2su6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED2C116D0;
	Wed, 19 Nov 2025 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763547153;
	bh=s4y3hIjKIKqq2PO03z1odmZRvi1xixNzpQ8u45u0goY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdL2su6aA8Hh98YIkR07lJyx10hDfK4xWXaB5KiCc7J6GOiCcgO4xIXAAw+ugLIo5
	 7phPgdb8dPC7suFVwt7lOPzx1c96lN8lbYChVkajs1Lqn7iGs6bDskrT+Ng3tkZAc9
	 Q7rN937bvlxD03oylfA+8MYARdhbjBHfTbwTwzRgpTyLXaewtkqGdNx8fTSk1LwHgH
	 NmK+fhVMqA//bJyNtuvmXqglqLEOLzOeNzSCgHBA6YN/4wezOEL1j5X8GIY/t+fZ80
	 ivtx4bVDD9VGdQNtv79JpYjl28QIv3jwF7FAZdgW3TiA2DadMYc0TN4X4EY0CC6aa/
	 jvzzkVuUfqeLA==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2 0/1] iomap: fix iomap_read_end() for already uptodate folios
Date: Wed, 19 Nov 2025 11:12:27 +0100
Message-ID: <20251119-artgenossen-fleischfrei-aae8aa265bb6@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118211111.1027272-1-joannelkoong@gmail.com>
References: <20251118211111.1027272-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=brauner@kernel.org; h=from:subject:message-id; bh=s4y3hIjKIKqq2PO03z1odmZRvi1xixNzpQ8u45u0goY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKzuDO87qrNDn3Qczi+JSlfx50PbxasV3+iQFH5ryq1 rDSnNnWHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5aMnwV8phrVJkXPNZu935 n6M2Cz7rer/x7Y4fuvGKZUw7gzlzbBn+WYmu2yhtari0Xkbt2pSijdlXvSy4HZfO7D0z8YaHW6A eBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 13:11:10 -0800, Joanne Koong wrote:
> This is a fix for commit f8eaf79406fe in the 'vfs-6.19.iomap' branch. It
> would be great if this could get folded up into that original commit, if it's
> not too late to do so.
> 
> Thanks,
> Joanne
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: fix iomap_read_end() for already uptodate folios
      https://git.kernel.org/vfs/vfs/c/2e7278a6e951

