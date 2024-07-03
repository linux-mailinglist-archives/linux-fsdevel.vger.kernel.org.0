Return-Path: <linux-fsdevel+bounces-23045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4328926422
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080CB1C24A61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F59181309;
	Wed,  3 Jul 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpeFWcyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3C180A8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018703; cv=none; b=PoYO3zi+iIRa3dyn+r7+5pvIuSLI7/BZWF4zLOzZqGoYddKxTvVEoSoZskAP9meRF0wumaPWsRW3VfMaz4v9QKuk2fDqC6xuJMbGFKgQ8WRIYsGPOYgUz43zTNLUIUdWBJk6D4mvVaXJxacYpYrWwMY6zC2mp06JTvm3rH8fuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018703; c=relaxed/simple;
	bh=weShJow+P1MD1wPU+yOKBgKl46WuzKU63TTHcvgMvbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M49S3R5kg9kQc64ozhqmkSyncEI4jdkfKYhAB5ITJCvqDYIrcGv6Oxi73vrY0NK4UlluwTGA0qfrLzN8znEMrLucWaKxtcXaLm2QkdVXPPvMAFnuIkykPMmR3M0k2JOKutrbwX+LyCgugw02rQX5K46X4tern7p5hSfV/AF4xIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpeFWcyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFBCC2BD10;
	Wed,  3 Jul 2024 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720018703;
	bh=weShJow+P1MD1wPU+yOKBgKl46WuzKU63TTHcvgMvbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpeFWcypO37oAcpphcUIxMH1is5d1fE2wUkQkNcyUEhzgiwCcxVgqIdpTOvPxugJp
	 9y+xXg7/USPPdc6cBLFfSlNCy+cqlB9WOM+pTViQMp0GlFga4tGYpXrAqadXQ+QfRC
	 XGC1Tx4aHerC4RvwNE/RMZKcov+AprKc9ThvkUQtQP0tW6AHCca3sp8n+vjNdTZKXu
	 u0ifwMkggayX5NiBo787u0HblTtwEXNfvpXHqvaDc+85WruSCX5UwYtWJZkkO0EqxC
	 jemzKkdp/GbO//jPXelVkyxL7QUO2pEjhJYDOwOV2OKsvz/NcXUGB0U+kvBse6Vgk/
	 zLHjurmpELHCg==
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fuse: fix up uid/gid mount option handling
Date: Wed,  3 Jul 2024 16:58:16 +0200
Message-ID: <20240703-rudel-weltumsegelung-81f899715679@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
References: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=brauner@kernel.org; h=from:subject:message-id; bh=weShJow+P1MD1wPU+yOKBgKl46WuzKU63TTHcvgMvbc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1pnNGTz+zfrHFsvtvOX+w9kXsfM/Rs9RG6umZYzPZ8 iYbiTFd6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIrEyG/9FH64Om6gl+auf0 EpdZfas04klwUJLG6X1PXDP+n/BpvcHIsF98+rUez0NHLDo2pHTtTumWXHZR7F2a5TqzVY8mVTI 3MwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 17:12:18 -0500, Eric Sandeen wrote:
> This short series fixes up fuse uid/gid mount option handling.
> 
> First, as was done for tmpfs in
> 0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
> it validates that the requested uid and/or gid is representable in
> the filesystem's idmapping. I've shamelessly copied commit description
> and code from that commit.
> 
> [...]

Miklos, I've taken this because I have the required helper in vfs.mount.api.
But if you want to take it just tell me then I can give you a stable branch so
that you can pull the helper.

---

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/2] fuse: verify {g,u}id mount options correctly
      https://git.kernel.org/vfs/vfs/c/525bd65aa759
[2/2] fuse: Convert to new uid/gid option parsing helpers
      https://git.kernel.org/vfs/vfs/c/eea6a8322efd

