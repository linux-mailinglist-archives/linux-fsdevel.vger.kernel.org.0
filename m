Return-Path: <linux-fsdevel+bounces-13183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC92386C6BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D962B25BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9DC64A98;
	Thu, 29 Feb 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8UPH3zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FE50243;
	Thu, 29 Feb 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202145; cv=none; b=WjsuzylpDYT9DA6j82g/VQbndydkKtBgTH3N8KYR4B1Aw7Um/Htq6gLW38thrEmFwx3ejC1NTGMleA++hQS1yw129UQQ/FIlSO98kjmHrJTVi5Roa0rj9kiHT0uW1MZq/kMr/3a58SPvfDiaiyX4k0sD1PzmWrJ1rRpf/VwycgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202145; c=relaxed/simple;
	bh=xqYoVbQrzxJrVmuFu8YWAVBO11aFSukfR6rHY30u3Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjMrjWqvcwygy5EFjU8lj2JbXffeJJCezR9/PuI97ILO7GSiZieyBXmQvVMQFkgk4gWgEBB+9c0t2SxoXVnZ96JLX0wG4+YPWzrqrwoAvFj5sCFXu4pNf+2j2AFEQ38TyxPWpMW7XyjU5DxUg4qi629eAuNxekXNXoz46Za9zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8UPH3zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F9C433F1;
	Thu, 29 Feb 2024 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709202145;
	bh=xqYoVbQrzxJrVmuFu8YWAVBO11aFSukfR6rHY30u3Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8UPH3zxxxnGbKQ7YoLoRElSx2Xc469vLkUxNDvl0ubOfumLXbHjTH721kp1zxGdF
	 vAaU+P1McRiwO2/xEMG5pJiywbapkYsJRfUg7l5wFPYhxIzV0NEP5tV405y72wli9W
	 cRZlqKLwGLa5SRZN8adsxyify4/pfEW1X1qxjTnyK1Sbto1xBAlngQcPMVh4yDKMKS
	 a3gD+PUdRVbpL3FiZyn0RGAgqKrrfnMJwvSX6i8WL3cBXHWbQcgs39RggpKZu3N+iN
	 bQDxDBJwzDJPaNn0n5m6+q7jZsVOOWgPRQwREOrccT5d+JZB1kdjl2tFPkKddCWyig
	 4h2QBnJ52nbAQ==
From: Christian Brauner <brauner@kernel.org>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: use inode_set_ctime_to_ts to set inode ctime to current time
Date: Thu, 29 Feb 2024 11:22:15 +0100
Message-ID: <20240229-benachbarten-zunutze-5302698c7317@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228173031.3208743-1-phind.uet@gmail.com>
References: <20240228173031.3208743-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=brauner@kernel.org; h=from:subject:message-id; bh=xqYoVbQrzxJrVmuFu8YWAVBO11aFSukfR6rHY30u3Xc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+iLrR9TxTiE15ktBu46fX7uc9q3CINP2sHvX7emz4v TNe/BHPOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSZsHI0MBYekX6XVuS7PJf jOrdy96ezVWUYWwUWrH0ttfUKuujBgy/WVe+al/cvOvlt0l6l6ruJ7pdrv/3pDg0z1BlQ1B7Anc NDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 01:30:31 +0800, Nguyen Dinh Phi wrote:
> The function inode_set_ctime_current simply retrieves the current time
> and assigns it to the field __i_ctime without any alterations. Therefore,
> it is possible to set ctime to now directly using inode_set_ctime_to_ts
> 
> 

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

[1/1] fs: use inode_set_ctime_to_ts to set inode ctime to current time
      https://git.kernel.org/vfs/vfs/c/6adf169c32c2

