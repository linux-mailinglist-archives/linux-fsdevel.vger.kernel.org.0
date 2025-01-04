Return-Path: <linux-fsdevel+bounces-38384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C619CA01377
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352BD7A1F78
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF1315ECDF;
	Sat,  4 Jan 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q09MUULQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F91494DC
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735981119; cv=none; b=OEALp+8RDO5/kc20Zs2LrQbgvW7WiSxQ3kXdnkpc9hL7RfOIYmjDEl6H+igbB2rCCV+xO/iUGlva1itpSKEUETolNWJenGv0hxm7W143ZUHDRTQx03cjMQSWNSakz88pAZvmL3DS04Uwd9XNZGx8gXGHYt7nrKEfqzFOTo0BmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735981119; c=relaxed/simple;
	bh=KOZx20LR4rZPEZCX4BToRqR/iDVYpV+4YBVxrE/fWRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jywZ4pon5BO6tjp05GWAy8fdQTWUGR5lfAXolpMKfPDzEV37+ADv0uUzQ4ZS+4JmU7u7vlifJzBCKFoSjPCpjYfFeUO6TSeWVI/VTWZKxpLqo7mNKLI5UHPw4U1iIXTnbeMlhkM70zwpRpjNDkjOw7h4Y3QptjGEhpMcdguEnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q09MUULQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0019FC4CED1;
	Sat,  4 Jan 2025 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735981119;
	bh=KOZx20LR4rZPEZCX4BToRqR/iDVYpV+4YBVxrE/fWRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q09MUULQ10q6k7dxBlZCPr6ZB/xNUkl7yacHSjrQhd+ob/IbmHz+13DVwSFmKZ/D8
	 E+83nhcOixKmSUq+YOeOAQtab/+Qglg2xgbWOdHx/1Rq53pK5p6tSF8RE5Qgv9O6Pr
	 lLbMGS5wh454APJJYwo8a5CFyz6Zb3wo4Hobo+7DTps8wWBanddHAV/DKQ6czuDMBQ
	 uPE06qL/733REcHbxowlZFDa4I+4zAwIhjljmLAey7MltMbbDMYSydIeQ/jBjYiGRG
	 bT0vrGUpVqwSJxxy+ZYXv6syxu2VIWnSRAq1FXom80hFOWptlDPpa0Nf2MxY+H3NPv
	 Xf2zMm5MJl3og==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Prince Kumar <princer@google.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fuse: respect FOPEN_KEEP_CACHE on opendir
Date: Sat,  4 Jan 2025 09:58:26 +0100
Message-ID: <20250104-abkassieren-entkernen-107c439c917f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250101130037.96680-1-amir73il@gmail.com>
References: <20250101130037.96680-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=brauner@kernel.org; h=from:subject:message-id; bh=KOZx20LR4rZPEZCX4BToRqR/iDVYpV+4YBVxrE/fWRU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRX/LCs2GWXUZ3TO+3OQU/n+QVGx562FdkdaJ72IqJ/2 wnD8JxlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRqmP4H7/yFLcl/4IzgWcv PHou/HfX0wmae+UyuQ+K2D5gkli+7AnDP22X6yXLXvxSOvbygWRdY03g17Ns3Ros/fpGtpPkVqr EMQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 01 Jan 2025 14:00:37 +0100, Amir Goldstein wrote:
> The re-factoring of fuse_dir_open() missed the need to invalidate
> directory inode page cache with open flag FOPEN_KEEP_CACHE.
> 
> 

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

[1/1] fuse: respect FOPEN_KEEP_CACHE on opendir
      https://git.kernel.org/vfs/vfs/c/03f275adb8fb

