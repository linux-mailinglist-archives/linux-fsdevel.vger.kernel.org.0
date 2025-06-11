Return-Path: <linux-fsdevel+bounces-51265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B8AD4F80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B89316AF82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A2253F08;
	Wed, 11 Jun 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtJ8jYuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBA226888
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633239; cv=none; b=bUsiy/klKWK15sc9m+rdU0voF7jHFPd5nsJ++mDl/meaQOPypi8S8mgZ3Wh2Oq0+3YQ+yFX+8jleMAJ+8olWGpn1RY0iETUbCkJ/hTzYRZdQZ3P8/baI1iVWRtpWmGaMNiJwRELMbzSZAb4EX67U1iY0ZN9EC2gsoVDMZP43TNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633239; c=relaxed/simple;
	bh=nrEaIoqxMU6sacIJhkX3I8SB9I1dCy3nhHGJ8nkcHZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+6kp9r2ePtgFSYvEIE/fZvIfxF8C1XKC0xVvhtRf7b6Hv2YLLFVbYxXLy7koacM0QoKE5cRSTbWygji/JdqFXCYnjcT7+dCJH8gG88bEYl28BU+aRtA9eMQdGCIXHDC+pm/zclgMPcsPmqZdDEwHnnzwldRDHHz4LpwRRRBAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtJ8jYuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E43BC4CEEE;
	Wed, 11 Jun 2025 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749633238;
	bh=nrEaIoqxMU6sacIJhkX3I8SB9I1dCy3nhHGJ8nkcHZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtJ8jYuv9yjjHV+t14Jz5tKsA23x3BgOO72i1HCcl3+9axniDDu0XavYk3uwLhZYf
	 3QEchsmekSbHuQzqnU2IM6gP5BLnSn6HU2pxH8BwVL//k5OJD8L2TCv4Vo+IQekrP7
	 N6CYdxXDI+aApMXwfnNJV4cB/d5AzBO1B/c/2PGtRfqwZF/UvU7YrmxYpeU43oK912
	 R7j+FzQCQl1ddQHOL1VtzTcnOKpptuI32k5R4kF3+6oSkyBySwnDmE8pL2e3XqZDY1
	 s4FPGHRTp5awq9O1sTFyXPbzeK1ZUAYprJdeXmRw5hZrgfcT11xn6z134bsjxZH7ds
	 8FdEjqGGajYKg==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] backing_file accessors cleanup
Date: Wed, 11 Jun 2025 11:13:51 +0200
Message-ID: <20250611-entfachen-suppen-d0f790b4064a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250607115304.2521155-1-amir73il@gmail.com>
References: <20250607115304.2521155-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=brauner@kernel.org; h=from:subject:message-id; bh=nrEaIoqxMU6sacIJhkX3I8SB9I1dCy3nhHGJ8nkcHZU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4elxoeBhwYNlnpgn1u67u0Jr/cOlrgfQyLb4VeQyCq kdFjUS2dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk+QdGhlk6AlssQ0K2uZx0 2fh9x9MXazq3TON9uZvzzftrgo+nMa1lZFg661tRuNEjt5fGDn8Kjm9wj322bPLaeyxfzh9QMza Oe8QAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 07 Jun 2025 13:53:02 +0200, Amir Goldstein wrote:
> Christian,
> 
> As promissed, here is the backing_file accessors cleanup that
> was dicussed on the overlayfs pr [1].
> 
> I have kept the ovl patch separate from the vfs patch, so that
> the vfs patch could be backported to stable kernels, because
> the ovl patch depends on master of today.
> 
> [...]

Applied to the vfs-6.17.file branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.file

[1/2] fs: constify file ptr in backing_file accessor helpers
      https://git.kernel.org/vfs/vfs/c/52e50bf764e0
[2/2] ovl: remove unneeded non-const conversion
      https://git.kernel.org/vfs/vfs/c/9445dc8817b5

