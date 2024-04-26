Return-Path: <linux-fsdevel+bounces-17919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117658B3C64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E321C21CB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34A145B01;
	Fri, 26 Apr 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxzTKtsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654114F109
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147587; cv=none; b=p5WXliD9SZUCFyTgPwLwjjyvEpGlAKiOFCwM2F0bCwTcZFRJ9xeCg+i7S+PWMmHNtMpRMeI3ANNwQ6ZKpABi9Si3m5Qz7oR82Er3w+DXkGP8CIJVFvIA6ZCw83duPnfCmoKugWyeG2kxSCbN7/STZPGs03SN4e2H/ZAVH93a/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147587; c=relaxed/simple;
	bh=87WpVx/3Cu+j9Ko+eoVAZDOpNvhVTqKvw94sAFKVepU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/0fLeP/TVD2O70q0IBwbQtiXahdzdtF4GHPn3XvviB+WF6dIJMggMKFC9b5B02bzsL7/LcHv0nPW2crmemMz581tU3ucQlw7H1Fkn0y/w8ApELN7z8Sd35/JKIr6fl7X5ZolOY3mJcHy+SifG1wrg84lsNsqIjw4eSRr62KCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxzTKtsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7A9C113CD;
	Fri, 26 Apr 2024 16:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714147586;
	bh=87WpVx/3Cu+j9Ko+eoVAZDOpNvhVTqKvw94sAFKVepU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxzTKtsbfIaiS/dgIcUIuPTZdAcTzJzSWEMT4/yrNnshLA0bYLSX8+NZG3dg4Ty8j
	 S4fT/XYvcoRrQSMNzlE1GoCeNhRAO23Fxx6s8TxBU9ItHE7jNloAncV6KbbZJzI6TD
	 LjCngv0T+ASS4XCXklxj9Ex+WbXzwz7b3giLHUP7QHBE55rrZSuMBKBCftbgeFJE08
	 DAVDi9LRG9R/kh0RLjhnEpUQpNF1oVDCDhL1SZyvP1CuYyn+F8rpX5dnUN+zWFxzNC
	 isKEXttlXoVsoISHKhf4lE4+cuIvfnBcEQI7FCmjv1Ey3Xn3JGlYA0h52al4b59/O6
	 MmCQFEvwFeDvA==
From: Christian Brauner <brauner@kernel.org>
To: Dawid Osuchowski <linux@osuchow.ski>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: Create anon_inode_getfile_fmode()
Date: Fri, 26 Apr 2024 18:05:15 +0200
Message-ID: <20240426-singt-abgleichen-2c4c879f3808@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426075854.4723-1-linux@osuchow.ski>
References: <20240426075854.4723-1-linux@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=brauner@kernel.org; h=from:subject:message-id; bh=87WpVx/3Cu+j9Ko+eoVAZDOpNvhVTqKvw94sAFKVepU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRpX/hhPVnMykLMd6bY7otPdm6sd/to+XzOiYW7Ujsmz DTZLirU2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRYwKMDJ/qJbSmbnRpkP21 co+Uf77q44Me+0/uqD7yaHeLgByX4EJGhqndky822/OolkxeZfV9zqQlZ1W52Sc/2c3h2Nf7a1f PD14A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 26 Apr 2024 09:58:54 +0200, Dawid Osuchowski wrote:
> Creates an anon_inode_getfile_fmode() function that works similarly to
> anon_inode_getfile() with the addition of being able to set the fmode
> member.
> 
> 

Sorry, forgot that I picked this up.

---

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

[1/1] fs: Create anon_inode_getfile_fmode()
      https://git.kernel.org/vfs/vfs/c/55394d29c9e1

