Return-Path: <linux-fsdevel+bounces-41828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7768A37D29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93D1170AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35841A0BFD;
	Mon, 17 Feb 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyKrXC3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C8192B63;
	Mon, 17 Feb 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780820; cv=none; b=X+hm7RkuycSqsYVK0tbvnEinbZu5CVNeHoW/dv4oaeGzkuB57nUi58veBRAsJyMvFGXPlJ1DULcrCu1zyuc4ihTIbxYvr9qXVqplX9VuWfc/8w2oZFnTLnDERvzv4OkeNcu1GEYrBdkh9HAjDowW0TH7+RkQGLWdxqSgErYbFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780820; c=relaxed/simple;
	bh=sm2EZjnhx6J7VSpn7U999FYUOZrMabD6174jywXnIiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHyJIST7A/JRWUDYNMlRMZjseKK8yKnaFgJ7lSekPEIZ19bo7az7c05GKcsawJth4hhyPabfswGeGhGbvROOBYmnaQHONBAw5KaR0yOC/TOYWOrQ/UuLmUZKb1/eVQRPJXfbI31CotOHT0HwGvof1MNbqSfGHtKDSrRBsphvf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyKrXC3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F8CC4CED1;
	Mon, 17 Feb 2025 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739780819;
	bh=sm2EZjnhx6J7VSpn7U999FYUOZrMabD6174jywXnIiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyKrXC3BlJTtlOqrfoIFRDb+MTcVuuuGbWZAOkpXFhOZC8HewxgZg4MVnn8CpduMw
	 ZKhhIp+j+rtPDGnZSHv7uX2x5T896AW/DG2Et7sr9db+iGApNej2QTCtvX6Xvzeg+X
	 n0yr3BpZX0gFNCAGtP7OjaFP43q3K6uJcCXNakyrG+6hjsuepWhs+1RqFVUPGB4wKj
	 KvOZXVHaNYaYdqxagbj8yLT7J2Evc6Fuup7zXa8+mDrjYyNGWicxzjFjdr+DynbORk
	 /tCdirZyg2IpCoa92eBQ+AudWLDIPP6v1bDkwCkxe7fc8IHQskG0FCKGVmIVwnVOZD
	 u0J3O8ux5Kv3w==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
Date: Mon, 17 Feb 2025 09:26:46 +0100
Message-ID: <20250217-summen-fuhren-b46dddda6d71@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217003020.3170652-2-neilb@suse.de>
References: <20250217003020.3170652-1-neilb@suse.de> <20250217003020.3170652-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=brauner@kernel.org; h=from:subject:message-id; bh=sm2EZjnhx6J7VSpn7U999FYUOZrMabD6174jywXnIiY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv+nTu9Jr/l7+ZWDxfIcYqKMQfZZCWnV60RmFr9j+LR V9Y9yfs7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIShHDXzHL5SxR2+7GS816 53NPNGzmFabsizVeW/3XdN68utH1zntGhp9c+bvPR6j3a7lPm/1Vlckh/MHJ220+crNTFkfP3yD zlBcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 11:27:20 +1100, NeilBrown wrote:
> No callers of kern_path_locked() or user_path_locked_at() want a
> negative dentry.  So change them to return -ENOENT instead.  This
> simplifies callers.
> 
> This results in a subtle change to bcachefs in that an ioctl will now
> return -ENOENT in preference to -EXDEV.  I believe this restores the
> behaviour to what it was prior to
>  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
> 
> [...]

Applied to the vfs-6.15.async.dir branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.async.dir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.async.dir

[1/2] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
      https://git.kernel.org/vfs/vfs/c/a97b8bfbb9f1
[2/2] VFS: add common error checks to lookup_one_qstr_excl()
      https://git.kernel.org/vfs/vfs/c/20c2c1baa9ab

