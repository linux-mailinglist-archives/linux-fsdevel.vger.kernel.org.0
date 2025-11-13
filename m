Return-Path: <linux-fsdevel+bounces-68264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9693C57D5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9954A4A88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B08352926;
	Thu, 13 Nov 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s31vn1qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C4351FAB;
	Thu, 13 Nov 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040210; cv=none; b=c9YQQHk5ROQVm2aIuM46OghN/0vz4C3P07n6VNIcoPGiMaTOB4/8OkpEhO0ThluJqaC9hKJDVOKUDc7vJlyW//7qzTlxJW1401mjtml/b57jalycPBUYwxYttAqyZ5HhxW9eeMiThNFbBY6BhAc2MgDeaZFE1sKucWZcQrwdX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040210; c=relaxed/simple;
	bh=qiW0pz1GrmI8AZc0MHtKcKY51Pj/YYEFQcx1IzO2BW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnd2zZBYzFwjaEpQTJuUDV3OBPpC3sEYE+8eFFZupVaQ3pVThpMDi+aJ2Srizvi3l2V8yPXnNM3yVmRbKmjbTx+/QVftzlOngILHGobox5QQGkZBiSwvmwLBt/U2xAM6sxE5GuVV9MUTXnFgE9HO5KX2LL1YA55RdZmDRHKQNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s31vn1qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB78FC16AAE;
	Thu, 13 Nov 2025 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040209;
	bh=qiW0pz1GrmI8AZc0MHtKcKY51Pj/YYEFQcx1IzO2BW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s31vn1qaTTW4JISshaWZikRA11uQqdpgnIbaNZKSdp3uCdFM4/Q2xWFw2Ciw51LPr
	 feZY6bswtgGTt9tbHrTr8BampDRQ/c/4hSVNzEQoXeGRScvdRTp393B0sYGLns1SOI
	 NP+p0rm2DowagxDeVW5OYjuGo/+vwR7f9SHFQoDRrs6jGribZdT89JzrIQPorPZnzV
	 VuyzZjFwPcIJ9dZByoydJEmkfSjo6TQ8hI8AgvNmMfdXOnomeWg4q/G8Z+VXpBcofQ
	 SSWB0rMnt4VFNLUuZK299DO+l3TiXCOY5Xa5lyHMID7Ekj3duZ4vnHJLyTGL14I1yX
	 Wl4JXlyOWiBFw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in path lookup
Date: Thu, 13 Nov 2025 14:23:24 +0100
Message-ID: <20251113-schob-gigant-c67723684e5e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105150630.756606-1-mjguzik@gmail.com>
References: <20251105150630.756606-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=brauner@kernel.org; h=from:subject:message-id; bh=qiW0pz1GrmI8AZc0MHtKcKY51Pj/YYEFQcx1IzO2BW4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK3j7jw9LHmP/v5iSV+x3m/H6tJ+KcPk7v2JMz+a6nq 6+wW65GRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQO32Zk2M3bcMP68NOoJz8t 3APEFn1R7JaVXFmn0ji9azHv7CajPEaG/5Hy13altbbM6851Sbyx+kw9y+byg769NwX277GcasT EBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Nov 2025 16:06:30 +0100, Mateusz Guzik wrote:
> Rationale:
> - ND_ROOT_PRESET is only set in a condition already marked unlikely
> - LOOKUP_IS_SCOPED already has unlikely on it, but inconsistently
>   applied
> - set_root() only fails if there is a bug
> - most names are not empty (see !*s)
> - most of the time path_init() does not encounter LOOKUP_CACHED without
>   LOOKUP_RCU
> - LOOKUP_IN_ROOT is a rarely seen flag
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: touch up predicts in path lookup
      https://git.kernel.org/vfs/vfs/c/030e86dfdaa7

