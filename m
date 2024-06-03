Return-Path: <linux-fsdevel+bounces-20838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773608D84F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8192832BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE212EBF2;
	Mon,  3 Jun 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOUaAi1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30F12BF34
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425007; cv=none; b=H+RCtUw4ycP/sPE/0Uha6SZ15u4h4lB4+rx7zh3iVqfoh3p/0KqnmBFtjymd09XDxWoKLL2Td51O9ZZhHbLzA085LkF31ZppvUuNJmRQ85a9COonyIeeteYPMGpDNWOpf2ZBsw0EC6MZ3Xpo6iv+lhWtqtoZTyeEZpOhEUgJZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425007; c=relaxed/simple;
	bh=ilP/mqfminFIlL/9jrVY6neS/CASV0S8jeIG1imK2Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJx7l0A+l7TlgokdtNvpBJBWLa2vXuKwzNCJSFTyTVwQ2BhNfRNNQD+E5A7LTzfmyIOuelVvQqzRhB9mcEul7IjJ+9vSZzxxR6e2ZFcLIHAm8lk99iGlceThJ6lv1X/7xhpAXFEvQoc3xjcVr4U9JW11bCjZMh3dw8aA+a4Qb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOUaAi1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE2CC2BD10;
	Mon,  3 Jun 2024 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717425007;
	bh=ilP/mqfminFIlL/9jrVY6neS/CASV0S8jeIG1imK2Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOUaAi1xXGHSyy/rlD1HUDAyHs9dC0Lx8iSP2YfHHmW42T5/f6kpJWZgv6+Frblt3
	 vT1M6mHyqooUYneH4d2q2PGWBVkleqxNimOZGnBg2ihwKVECFcSWPxMNej1Nyuy4/D
	 NZWY1INWnnzXVAfMM/mlbM6pV7UtP17AjQ2mwc6JGxtBq20Y5rq+T7cf6+S8wsVCHv
	 7H71i9p70n4REHuC55bFd1Wyp9Wf/AqK76FVsmDgA0Tm5wO0BzunobTWqlQl4V2Qyq
	 hg9yDdpAqijewZqMwf6Pa/uhIepp8SixlcRNtrm8WQpMk1iywEP2/p3FAffZGkzIik
	 GIaXMAnorwJ0g==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Subject: Re: [PATCH v2] hostfs: convert hostfs to use the new mount API
Date: Mon,  3 Jun 2024 16:29:52 +0200
Message-ID: <20240603-abklingen-zutreffen-1bc4c642168b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530120111.3794664-1-lihongbo22@huawei.com>
References: <20240530120111.3794664-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=brauner@kernel.org; h=from:subject:message-id; bh=ilP/mqfminFIlL/9jrVY6neS/CASV0S8jeIG1imK2Z4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFXk4PFwi+9HLBfoUs/j9XBXONXbh+2ec1TLm73/3Bu ZXVHJquHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpYmH4Hyi90DLxY4tmUQXD U+kTd6ty2pdP37TT3vpr+Krrs5d/qWdk+Mp5tcb6/Kd/66Vsk/6HN+xncH8ie80ui0/BTeBCz2J eDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 May 2024 20:01:11 +0800, Hongbo Li wrote:
> Convert the hostfs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> [...]

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

[1/1] hostfs: convert hostfs to use the new mount API
      https://git.kernel.org/vfs/vfs/c/cd140ce9f611

