Return-Path: <linux-fsdevel+bounces-73778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCB6D20330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0508C309FA71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA93A35AE;
	Wed, 14 Jan 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGNg14+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44163396D06;
	Wed, 14 Jan 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407576; cv=none; b=PoxH/J0P2jljcl/eAS1UnuVKupkpTxB4qQJ2cDRNOF3RMxNbt7DCWFo0GuPbqExGIVgJwmuS2rka5aHfCR0Hvb3opaUMS9vlJi4UdI7szQyNKdzr1YmLLNxwIZ7TdK5s4VpbbwXAUiDCm9YKqyVkmKxUg8DWkMnKTleK47fIwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407576; c=relaxed/simple;
	bh=SmImQF86IKtX1OdHY1e2OsOrS6wpUoN3wvvnIh2lE9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ckb27JQuY+1dkGy5UGS/ei/BgVXDrIX0xxlwtFInOgy0IukL82dAT7g6gETG67ziJKbP5TuBW6TxchfMC3Jr8eiOomGcB4xlRc8rowTGzxL8aAQ4PB9G4xjXMhJfda/ISI3QhWpKDTv+/PYzsECWRuOlObFEcJPlXu25nZfNUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGNg14+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E81C4CEF7;
	Wed, 14 Jan 2026 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407576;
	bh=SmImQF86IKtX1OdHY1e2OsOrS6wpUoN3wvvnIh2lE9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGNg14+IUoLjNNlQxAG3eOUNKP/DxcVDnGlkuUjUuGoxVp6oJCr0ILsLL1yAv9tMg
	 byF8laYnuc1QMY9274qGIJ43KFxXZcut+cucHyvAjPtnNPjlJ+FDeG6AjNh1JTkyoG
	 Kon+pDUlJGnWx4Ie/gVSLdeECWb0yWjEw80lTCv1Xv3OTzyQ1tEZtlVXaFzqPehxJu
	 CA4Jr7pfrvdUKbwAP3kwXuf2+EyqvUTxsGqnzp0sBD/ev5747ye352XsiKi8uQuKeB
	 /MobT8Tj3y2uomeeEPGy+Ma5iP+YuqySnf7RFulXwfK/lc1Qz/RRbR+Cl2pPgOdSH1
	 Ii8vCmDZKt/sA==
From: Christian Brauner <brauner@kernel.org>
To: linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/4] btrfs: stop duplicating VFS code for subvolume/snapshot dentry
Date: Wed, 14 Jan 2026 17:18:57 +0100
Message-ID: <20260114-holprig-flaggen-f8c095e1a439@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768307858.git.fdmanana@suse.com>
References: <cover.1768307858.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=brauner@kernel.org; h=from:subject:message-id; bh=hatMQr9kUalUIKt2eiq0edk4r5N5XyE2FAERtymbezs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmH/z+Sn5Lvuoc1SCftxONFrsKyPcGrXCtUNafuvun/ s2y7Kx1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhi2BkOO848WCjXMNxnyO9 c0JM5W/H/Vw8KZ5hw96fDStrM+PStjMyzFTrsL7mP/un/+acvQrpR0/y7bN6LZ23ctUZ7hlbflq ocQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 Jan 2026 12:39:49 +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently btrfs has copies of two unexported functions from fs/namei.c
> used in the snapshot/subvolume creation and deletion. This patchset
> exports those functions and makes btrfs use them, to avoid duplication
> and the burden of keeping the copies up to date.
> 
> [...]

This is on a separate branch. I'm not going to touch it again.
So if you end up having to rely on it this can easily be arranged.

---

Applied to the vfs-7.0.btrfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.btrfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.btrfs

[1/4] fs: export may_delete() as may_delete_dentry()
      https://git.kernel.org/vfs/vfs/c/173e93755243
[2/4] fs: export may_create() as may_create_dentry()
      https://git.kernel.org/vfs/vfs/c/26aab3a485d5
[3/4] btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
      https://git.kernel.org/vfs/vfs/c/5f84a1092dee
[4/4] btrfs: use may_create_dentry() in btrfs_mksubvol()
      https://git.kernel.org/vfs/vfs/c/6c91c776a923

