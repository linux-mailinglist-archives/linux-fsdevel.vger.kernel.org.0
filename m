Return-Path: <linux-fsdevel+bounces-50719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65639ACEE40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90281896000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7756213236;
	Thu,  5 Jun 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T13d8qYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2621C4A20
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121254; cv=none; b=qKXkF4d3+6PpxkVS4tBNZdZUd7Nb+BZZEP+u0DHN0mmvICafBsfhPFz1vnJ5l6XjVoh67kZipQY767BtV+LeD8gMjpiZAGsRy06nX+kwATTjeuA5Rvn/Wms8CLHXdXcU0OBnxXrgdq/IO8oMiHoiW1qJKFTVDEPNAPcM3Yl98fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121254; c=relaxed/simple;
	bh=VDJ2RIbOCyvfExSxgqR4BN47agHgkrURgYlDgWmG2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQXM7sIaT5bwzrBTUo3vh9ac+de0eT2Jy8tbawidOePDk4ZKQi0bZOSWl/R2MkaPLrvKI3Leu+7hQReIBEgsyr++eeLW3futfRpIEePM0eB4VrAqNx4g6atBBynxMml4UuKly+Qab8kNbjb4N25qthCj/HMp2BF/6J3ieMTc3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T13d8qYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE696C4CEE7;
	Thu,  5 Jun 2025 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749121253;
	bh=VDJ2RIbOCyvfExSxgqR4BN47agHgkrURgYlDgWmG2yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T13d8qYdzx3KVeQFsat7YaMBr5mEq6ee50E73M1CrHweoRJuKna8p6vA7VFclL2Un
	 MLLZ9IM85L+SqPKI4sdQJjuKVRaFh+ojF2gNCpkDx+Sp323bBF9Ejo3apRcUcc1JWW
	 dBEAYa5x0RGBrx90LLQsnHap05BYP1XY0736leWfHbjF2zb6zYzGHMkEw9C6bbnakF
	 UM7Av9TSOXFPzgnkBjRX31hjwc2SMXFdoHGK/p0hyAsNXfvb2cVBYNmMIOLE9PFM8V
	 GQcQ1ttIDgQddroNUDXGqnqMw+vdw33EnwtWUGbQtKUuZjcXhNDeO4jq6CPS+nVODr
	 CaA7F3OvUotWw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH] ovl: fix regression caused for lookup helpers API changes
Date: Thu,  5 Jun 2025 13:00:47 +0200
Message-ID: <20250605-bogen-ansprachen-08f6b5554ad4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605101530.2336320-1-amir73il@gmail.com>
References: <20250605101530.2336320-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=brauner@kernel.org; h=from:subject:message-id; bh=VDJ2RIbOCyvfExSxgqR4BN47agHgkrURgYlDgWmG2yw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ4Vjxw7+I+VPl3zZmsQ50bU7MPhxdOf7d30ru1Sw9XX JpdKrdiV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEMpYy/E/XepzRf7PnpuHj 2zYXvxTXMix7+7YxKHPqwQs7fh0Lav3F8D9n0d0NN19zC38214474Kt31jp1xeOQ2odax7YHf4y sm8AMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 05 Jun 2025 12:15:30 +0200, Amir Goldstein wrote:
> The lookup helpers API was changed by merge of vfs-6.16-rc1.async.dir to
> pass a non-const qstr pointer argument to lookup_one*() helpers.
> 
> All of the callers of this API were changed to pass a pointer to temp
> copy of qstr, except overlays that was passing a const pointer to
> dentry->d_name that was changed to pass a non-const copy instead
> when doing a lookup in lower layer which is not the fs of said dentry.
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

[1/1] ovl: fix regression caused for lookup helpers API changes
      https://git.kernel.org/vfs/vfs/c/339740d5d1cd

