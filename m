Return-Path: <linux-fsdevel+bounces-56381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83DFB16F79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286C67B4F8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1059A2BE04F;
	Thu, 31 Jul 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxFU2i/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3BC238C25;
	Thu, 31 Jul 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957626; cv=none; b=OiYlnp8h0NNTDxrBNg83GIgC/itZtMEbWOVSMweT598RA5ZYVlioKZhcWrCzaWB34b58EYAqFSZAZDHGw6UH2xrMsvEvysn3U6zUjn/tP/GD2LjepTBoRec1VcuIGAgknLUy4DUs5cdmgxrS7hRINHPrO+Z+quqloMLdQcGizWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957626; c=relaxed/simple;
	bh=mZpnZcvWp8SSKYuAUSLT1e/jJIWMm3Zlnit/hTH4MhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww7d8koaIHuKDtTt3icFfLgMUGpgatTyfypSD+WQ4rv8J2F7FTqX3UuNGYEjbKzwTr9AbK/zNQFIOpeUmjm+dt699rINaz6ysMoZ9/hq1A9EMyymaad9MCKO8PBEAJ+y4yErcvPpTGDPd4LOBbHz58UEuq+wBgC1mg7cE+IF6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxFU2i/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16273C4CEEF;
	Thu, 31 Jul 2025 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753957625;
	bh=mZpnZcvWp8SSKYuAUSLT1e/jJIWMm3Zlnit/hTH4MhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxFU2i/hESB/rnLltqh5qnswEaKDj9s43s8dhKgTQsqlatGy6dMTJaGIehAuYk+tr
	 z1/Wd0XYlFmDEnm2ToXyliF6rwWQ+QXwo9NwHDRCuhbflWdNyiBrrBaE4wtPaJBzbk
	 OyHLYu1JN0QQNyTJ1SL0opbd01PnINgZTO4TTvx9CnqNSz1rsaGmWQTJZQ78Vv7rRi
	 diNOh4/LbUE5i/hXALXY5rrd5UR2GXQVCwV20fU1m2h9AVO8bbEhtJTaGF/Uhji8ah
	 Evk8tcTy0mjR9m2huLfkQiTyrKtwXs81NkYuKEYUrNDMLC+qUaCaxKX/KdAuhWKKDA
	 5WjUhKgE7Xn8w==
From: Christian Brauner <brauner@kernel.org>
To: tj@kernel.org,
	jack@suse.cz,
	Jiufei Xue <jiufei.xue@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: writeback: fix use-after-free in __mark_inode_dirty()
Date: Thu, 31 Jul 2025 12:26:55 +0200
Message-ID: <20250731-manisch-zuerst-0aee81784858@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728100715.3863241-1-jiufei.xue@samsung.com>
References: <20250728100715.3863241-1-jiufei.xue@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=brauner@kernel.org; h=from:subject:message-id; bh=mZpnZcvWp8SSKYuAUSLT1e/jJIWMm3Zlnit/hTH4MhM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR0u3wRmHBHTPAPuw+LBYuOYPu+BQwqp/ff3eM6e5/Wp oX94UFyHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxfsrI8PKOlG5If1/F0dly hf9PPvHRXSv34vaytVkhbZUlgUXixxgZtgoJlfHuN/WVPrpPKeHO161hV6beUXWojl5op7ayY+p pRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 28 Jul 2025 18:07:15 +0800, Jiufei Xue wrote:
> An use-after-free issue occurred when __mark_inode_dirty() get the
> bdi_writeback that was in the progress of switching.
> 
> CPU: 1 PID: 562 Comm: systemd-random- Not tainted 6.6.56-gb4403bd46a8e #1
> ......
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __mark_inode_dirty+0x124/0x418
> lr : __mark_inode_dirty+0x118/0x418
> sp : ffffffc08c9dbbc0
> ........
> Call trace:
>  __mark_inode_dirty+0x124/0x418
>  generic_update_time+0x4c/0x60
>  file_modified+0xcc/0xd0
>  ext4_buffered_write_iter+0x58/0x124
>  ext4_file_write_iter+0x54/0x704
>  vfs_write+0x1c0/0x308
>  ksys_write+0x74/0x10c
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x48/0x114
>  el0_svc_common.constprop.0+0xc0/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x40/0xe4
>  el0t_64_sync_handler+0x120/0x12c
>  el0t_64_sync+0x194/0x198
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: writeback: fix use-after-free in __mark_inode_dirty()
      https://git.kernel.org/vfs/vfs/c/f8371b50ceaa

