Return-Path: <linux-fsdevel+bounces-7781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8E82AAF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20826B26A9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924612E74;
	Thu, 11 Jan 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0BCgLY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E710962;
	Thu, 11 Jan 2024 09:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA2BC433C7;
	Thu, 11 Jan 2024 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704965473;
	bh=Rk9NRpDsadZMSSvC4keuPq0iP2/9RWYyuAwhc7yIrX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0BCgLY1yflXpmcmYV6znA84kTWM7HBx55M1P4GWlSAu59zmFfn5N87JnXf0/mko7
	 u6M9Ip8qEx0hYKGxSBtFywDTIOfy6/IfvHv1nYfxR6UlDKf4dlPO726lKhsjjc57vx
	 qIW38OsFWev/pi8p2uKvZK/x9oL3fhpbzStuF4JEZeLnwODKnm2Of0IASs2IDKKfAl
	 Hg5VAdPgevSZXKAvueHzlYM2Hpb+DTrE+NVFm8YfZanq7dOWMjgf5faXfUTn8fOD33
	 MRQrNDXn1+1wJWeYwcTOHvmOsDPV4YG3IHZY94wHKyTGVVkkMA8m9gSoximOZ9KfMF
	 MvH6jokXogrcA==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] initramfs: remove duplicate built-in __initramfs_start unpacking
Date: Thu, 11 Jan 2024 10:30:58 +0100
Message-ID: <20240111-bratwurst-schrebergarten-1444199c8559@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111062240.9362-1-ddiss@suse.de>
References: <20240111062240.9362-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=brauner@kernel.org; h=from:subject:message-id; bh=Rk9NRpDsadZMSSvC4keuPq0iP2/9RWYyuAwhc7yIrX8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTO3xol2NIdmffcsmTa3VkurfpCdc80e7tdMleuSpD9v TNHfCJ/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERS2BgZZs+s/LLaaYm+v2dz Q+acFVpNop0Nyw5cazz1/2KtaX+dOMM/g98PUi5bb1D6v0Duz+szOzfUdHC2rF3r8rG9WvlRlsM vRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 17:22:40 +1100, David Disseldorp wrote:
> If initrd_start cpio extraction fails, CONFIG_BLK_DEV_RAM triggers
> fallback to initrd.image handling via populate_initrd_image().
> The populate_initrd_image() call follows successful extraction of any
> built-in cpio archive at __initramfs_start, but currently performs
> built-in archive extraction a second time.
> 
> Prior to commit b2a74d5f9d446 ("initramfs: remove clean_rootfs"),
> the second built-in initramfs unpack call was used to repopulate entries
> removed by clean_rootfs(), but it's no longer necessary now the contents
> of the previous extraction are retained.
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

[1/1] initramfs: remove duplicate built-in __initramfs_start unpacking
      https://git.kernel.org/vfs/vfs/c/822b1a28fc5f

