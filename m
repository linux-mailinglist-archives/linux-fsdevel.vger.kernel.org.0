Return-Path: <linux-fsdevel+bounces-35270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77799D3540
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBB6285713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E6170822;
	Wed, 20 Nov 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2GGnhXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD072156F39;
	Wed, 20 Nov 2024 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090758; cv=none; b=dHQP25597oeo9K1Yz23Fde7mz7/uRqd8tKErvMWZDH7oTlR5AOMeYgiXbU4ZYxFbbI6mopa4epEvNYWiYqfvLna+fumuWfLOe2fpQdMAx6EzhNDSNPCWtQwuqf3QwImqOLOV4LpGg5ulblob/mb/ZmAo9YIC7CYzSBSjrldWH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090758; c=relaxed/simple;
	bh=9TI0HM4Dy8p7o0uGW4XXWqn7s6R1nhPDekk9NNPZafI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbmCu4nPjR88Vx1qo4dVAgKSp/nQsi1Epr/pdviPvHytyEITV1KIuh7y2VA4Gs7/zV9bcEVTKTSEwgog+iAFMUWQDcgQpdRilSTggUwTftFmBqPHvkf3oeBQ1dZp9GqIYEGjI5AnFQVoBScp9WYnr8Dp5CVP2oAivt/rBhbtqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2GGnhXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D2C4CECD;
	Wed, 20 Nov 2024 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732090756;
	bh=9TI0HM4Dy8p7o0uGW4XXWqn7s6R1nhPDekk9NNPZafI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2GGnhXCZHnauYXaZWgw/m6Gw4+zTvKgGg+Scx3b08xVvwSKBu0OExkO4Q8tBvnho
	 tRg95NPzUUXud5kmpweVM//uN00Ll6HGDk/uyhKEyHF5wQBZY0U27kN6vr5F/Zep0O
	 xQ4+AaUjcoJy+uVaGMmYX0UoXOWtrHJfE8i9NmdlrjOes8SgJl8ZIM6Ad3SBsEBg7e
	 sHCuKjD/lCX0qlM/TAV8E8ouSHxJ8TYaCqRsEuZP+CMbQcjqvduq8KVL/sUFfdltM7
	 8gFFHAsNE0sjUT3Q8/ZGPFwbtpwRQWxpNkzibqfroUVWIqFiGmdqiA8Fi0w844sK72
	 bkbFkku44e7UA==
From: Christian Brauner <brauner@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Brauner <brauner@kernel.org>,
	sforshee@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels
Date: Wed, 20 Nov 2024 09:19:07 +0100
Message-ID: <20241120-ausnahmen-vermocht-cbee4e244bbd@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115134114.1219555-1-mpe@ellerman.id.au>
References: <20241115134114.1219555-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=brauner@kernel.org; h=from:subject:message-id; bh=9TI0HM4Dy8p7o0uGW4XXWqn7s6R1nhPDekk9NNPZafI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzq7z5f9Wb3uI12Prb82N350iDl38HLv/c4rH4S5HO Tuzb5eZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay+w4jw4/LFacDdnO9b93k POWVjizvtRv/7hnsLZvMFnTi3gJfriZGhm0L/2y+WcXCsMAr4uTH09fv+S9cOPn7m9pq77qoMOs XT5kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 00:41:14 +1100, Michael Ellerman wrote:
> Currently the mount_setattr_test fails on machines with a 64K PAGE_SIZE,
> with errors such as:
> 
>   #  RUN           mount_setattr_idmapped.invalid_fd_negative ...
>   mkfs.ext4: No space left on device while writing out and closing file system
>   # mount_setattr_test.c:1055:invalid_fd_negative:Expected system("mkfs.ext4 -q /mnt/C/ext4.img") (256) == 0 (0)
>   # invalid_fd_negative: Test terminated by assertion
>   #          FAIL  mount_setattr_idmapped.invalid_fd_negative
>   not ok 12 mount_setattr_idmapped.invalid_fd_negative
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

[1/1] selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels
      https://git.kernel.org/vfs/vfs/c/f13242a46438

