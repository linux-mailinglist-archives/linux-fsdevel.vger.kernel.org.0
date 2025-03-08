Return-Path: <linux-fsdevel+bounces-43516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA028A57A0F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 13:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549AE189388D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EF1B4251;
	Sat,  8 Mar 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmHTEHw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDEC18FDBE
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741435814; cv=none; b=XHHXAsehG0iwOyzpm4WcP+vQAzVeFGbnSt7DtsHDoWRAgr65qol1Xlrp2BLdoijZgcnlx4lMe+Plw3vQSrZZYIvte55bzSboFr9YSxuPAhLcPOFCEla/t4feE6QcWq9y4SF6ryOZQlgBmTp3+ByzzlNfr51drrteLq4KP1WiJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741435814; c=relaxed/simple;
	bh=R9dF4uyM5Pyzy/9NIo0tsfQraPmOnQoqzhblryOSsds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il1WSB0Xs3ZDQtxSPyf91dyDNbqMC8vCJiS65ZqLAu4F4rD1TvUCj2jXt2DbMXnIqZNgEOSHgGNVleUBJr6Nn9VT06gcVwSms1A3USCGTC5O09rwtkUN1fsi6FCI7PEEmzITSZS/SZKZU7izMTFvo3NgOklCo+m7s9ufEvstw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmHTEHw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B603CC4CEE0;
	Sat,  8 Mar 2025 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741435813;
	bh=R9dF4uyM5Pyzy/9NIo0tsfQraPmOnQoqzhblryOSsds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmHTEHw8ceuYZNTb9lyp4dXoVkBYYntlGitS/jXmempoEZuqfdVXDboh6zw3gsZ9M
	 eM/vcWCPUz89lj56D0cBX8rrTImCbQEJxSndMHocd5Sdq98TwYXX+uWw/WOXSEekA3
	 GrDX3hZP14P7q+fHUGANXjGDQ81nDmcNxBESYio61pJ+YP4lIvo5fJxB+JXkwwtvJn
	 mTQgPOyfta5UVQiQmvDYX6MNiZV8Tr+7gOhbHJiNq87kqPBnMqU6+FfJFDiqvU5ZO4
	 YiWcCVuZSTFCnCirMdqVOCXP4nmgFVzRPORl+IxkQul7A4QilLk7eZH4iBOo9DmLIW
	 J11m2aallrs9w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] selftests: add tests for mount notification
Date: Sat,  8 Mar 2025 13:10:03 +0100
Message-ID: <20250308-entmachten-sogenannten-ae2ff47ca76f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307204046.322691-1-mszeredi@redhat.com>
References: <20250307204046.322691-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=brauner@kernel.org; h=from:subject:message-id; bh=R9dF4uyM5Pyzy/9NIo0tsfQraPmOnQoqzhblryOSsds=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfMV5wZueWsO//Mx3ed4cI+F9+c0S781wIu/1BOT6l4 +uKed+3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwz9GhsdZlt61vuv5yjz4 nJYtvvFSXSAwVdE19JieyPcd6Zli3gz/lG2P37q2ilfy1Ptp+RMeKs7X55LeW+zrZMqZn5v44DI LCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 21:40:45 +0100, Miklos Szeredi wrote:
> Provide coverage for all mnt_notify_add() instances.
> 
> 

Applied to the vfs-6.15.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount

[1/1] selftests: add tests for mount notification
      https://git.kernel.org/vfs/vfs/c/a0359e49cb43

