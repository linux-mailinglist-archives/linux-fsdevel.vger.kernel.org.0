Return-Path: <linux-fsdevel+bounces-21888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAE90D5C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1591F2200B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EB176FAC;
	Tue, 18 Jun 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWDej5wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F414884B;
	Tue, 18 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721028; cv=none; b=YpmPSOFu8DUX2FyFIf6nYTOXnXQDjsJvANhB9trC0q7AIVa9WT5WdMM9bg+bPDV3raztThvI6B1CqVL44Z+pOU2me/UMH1P95HlEC7Js+c83QUl9yidi/lSDTJ8cTEumxLde6MhObMVZyvICgrZllx8U2OyILl1DvAoPW8nnQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721028; c=relaxed/simple;
	bh=nBtw6Rnkgjm3r2ZCSML3MQkn1I2c5FD8RpuyHyyvbGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRdPM7cs4mX3uO6DArh51D+LI6l9RE4VEq7tYu3ukeIrzA372mhAO2DdOmZKrVM2BVNzlfJBp+stStiASIiOooi1s5oqc0F/om37LJK8kaCNpO4Zmma+c068jLP4ah5U3Ns9jWSqNb12jIloRVM8LhOvuo4t4jARtMd/4IZtJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWDej5wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD87C3277B;
	Tue, 18 Jun 2024 14:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718721027;
	bh=nBtw6Rnkgjm3r2ZCSML3MQkn1I2c5FD8RpuyHyyvbGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWDej5wbgLwTWdtf/ux0gHFiUz9+4acS3cq0SKhIMD0lv2gfV5/sUvLA+9O4T6t6D
	 v8hLx3ynTh+dcR5q7jbg2OQeTCXQE9FRmU7OhTlFuBBZAgBEAIsIUip0Q8zN0e0cSj
	 fbzqn/pUuk2SW4fIntpU3N0oTi+1a99Z2mmb3SsuJY29q2FWQBSfYYrvuzYd8vLtTw
	 d9flYU8urV1VT4viNquvRtKHusqTF4m99QET01+B2H8PSVcBaPHr9J2xRAlcH4JAjg
	 iwCLJ4HNwtIF/Cl0cxhSbhhq+k1Krx5+VcZe+UcSXeVMV3YNwy7+UN7tRbU3BOWA4x
	 UL5nhOX+2eV+w==
From: Christian Brauner <brauner@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Subject: Re: [PATCH] hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()
Date: Tue, 18 Jun 2024 16:30:14 +0200
Message-ID: <20240618-vehement-ortsnamen-3b54f6c83a53@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616013841.2217-1-chao@kernel.org>
References: <20240616013841.2217-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=brauner@kernel.org; h=from:subject:message-id; bh=nBtw6Rnkgjm3r2ZCSML3MQkn1I2c5FD8RpuyHyyvbGM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQVzvzzR2/l9blsi81/P3gd3srHIFue0Lw9zfurjoSC4 YztMtu6OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaidIzhf9bE06sN+hatvWil vPh6xdzVhdvlecz2TH+mHrjIvnXeVQOG/8WPqyprFvO8aNstvurop4eBua2r3QT+f9+WwZbnX3v oGx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 16 Jun 2024 09:38:41 +0800, Chao Yu wrote:
> Syzbot reports uninitialized value access issue as below:
> 
> loop0: detected capacity change from 0 to 64
> =====================================================
> BUG: KMSAN: uninit-value in hfs_revalidate_dentry+0x307/0x3f0 fs/hfs/sysdep.c:30
>  hfs_revalidate_dentry+0x307/0x3f0 fs/hfs/sysdep.c:30
>  d_revalidate fs/namei.c:862 [inline]
>  lookup_fast+0x89e/0x8e0 fs/namei.c:1649
>  walk_component fs/namei.c:2001 [inline]
>  link_path_walk+0x817/0x1480 fs/namei.c:2332
>  path_lookupat+0xd9/0x6f0 fs/namei.c:2485
>  filename_lookup+0x22e/0x740 fs/namei.c:2515
>  user_path_at_empty+0x8b/0x390 fs/namei.c:2924
>  user_path_at include/linux/namei.h:57 [inline]
>  do_mount fs/namespace.c:3689 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x66b/0x810 fs/namespace.c:3875
>  __x64_sys_mount+0xe4/0x140 fs/namespace.c:3875
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
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

[1/1] hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()
      https://git.kernel.org/vfs/vfs/c/849b386e2876

