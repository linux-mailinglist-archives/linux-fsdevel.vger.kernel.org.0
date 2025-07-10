Return-Path: <linux-fsdevel+bounces-54435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72237AFFB0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E187A5CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C170289809;
	Thu, 10 Jul 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK1Z9b1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40A19E7D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133090; cv=none; b=X7nkGtvwZg/jxXe5mDNU2r4Lmtl0aWPRv5Op9cQ9P+VP3D4MJ52d4WZoeL5FDU1qgD1GwZw+Vr2pT9xzb+VRgxOWQfoc29V8qjJusMsf9iiDMn0y63lNBz2nafVOM8PK3HvjbDYoNFlHTF64qN9DLD0JFoSs+qg+epb/LRsRx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133090; c=relaxed/simple;
	bh=ZXkEYQSmrea8vlwoTme0ywkxaTaq14YYEUzmB1emUJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INUsuLgVJko6UByOykQEPbIpRQgV+MzQOH37koKeIFV07LSg7bQ314TBFJBQ03lZ9jF2ri5I0qhASmKcW/G20pigNeOwpRfN7LpZTmZ518XnCrZTruBzewC1/S3KnNeLW9EYIdj5Dfsj4LyXokTyX9CXKQ9CflrDHMfGHA6xeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK1Z9b1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50FC4CEE3;
	Thu, 10 Jul 2025 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752133090;
	bh=ZXkEYQSmrea8vlwoTme0ywkxaTaq14YYEUzmB1emUJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK1Z9b1L8HJpKEJAdnMCXc1Zz3GolNXG3x0rpp5iqB1OhNOKiogVfuTAbAohYS5XI
	 TFoucLXORyJvtOe9ZiSarGM5pMscqjfnVQlnWAfDkc3MxzXMpAhF8uJF2VbXdmGTzZ
	 nqRoa+eFhj9hor7VrGpcL7a3gi8ndZ9365hUfjArddy6wH0uPuKcl5ojXjWuUxFHl5
	 caOSGRc/e1I4SVAa93+Y63S0Bm3P1jcOu66b8GfEKM9Cx5NRBXvAtkrsoLLuWYR4NT
	 j+AixYA39KU+dpB407m/GIJ0xu9BBrcSdds5v16Csmn6QRLXCRameLavtIhOqXGG15
	 MaEc/abregyPg==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: Remove unnecessary list_for_each_entry_safe() from evict_inodes()
Date: Thu, 10 Jul 2025 09:38:05 +0200
Message-ID: <20250710-zersetzen-erdgeschichte-c54403fa9602@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709090635.26319-2-jack@suse.cz>
References: <20250709090635.26319-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=brauner@kernel.org; h=from:subject:message-id; bh=ZXkEYQSmrea8vlwoTme0ywkxaTaq14YYEUzmB1emUJA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTk594tWnzmi2DMvUShBhueTcdWu8V5rG248kvC9YPEy 4dt1w3mdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwlOGf8q3jgZXaohGMemd 5uo+xFrAu6TN6k5X0VXtmvkZHhX/fzMyXAgMvDdhl2LXyr+b+dd/fXB3ztQJ68rC/QVFzrZMufm wngkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Jul 2025 11:06:36 +0200, Jan Kara wrote:
> evict_inodes() uses list_for_each_entry_safe() to iterate sb->s_inodes
> list. However, since we use i_lru list entry for our local temporary
> list of inodes to destroy, the inode is guaranteed to stay in
> sb->s_inodes list while we hold sb->s_inode_list_lock. So there is no
> real need for safe iteration variant and we can use
> list_for_each_entry() just fine.
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] vfs: Remove unnecessary list_for_each_entry_safe() from evict_inodes()
      https://git.kernel.org/vfs/vfs/c/3bc4e4410830

