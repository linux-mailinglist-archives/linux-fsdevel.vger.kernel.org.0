Return-Path: <linux-fsdevel+bounces-22486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A0918077
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68571C23F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65880180A76;
	Wed, 26 Jun 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmwHbF78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5E15A856
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403408; cv=none; b=k/u4uLVrR+WWeZDhH7xbW7IhrWvHRDD8/cMIJC0mZRl8PqXt+yFSJ1n8GbUz8YCeuto9htksieicXXGb6rp/XRPK1pBD/W+fByvCSKxwfI6m6wWSdzzjsIFKQfePkOlhlUQr3+sXan9RBaU3j057f2pE2oOfQL1kiOc7vAhDs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403408; c=relaxed/simple;
	bh=MenChi4xWY9BwIcSq8UBGUeucwU//POkeYn0TanNEkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGXvhoXMURbJfgxxA8Nw6j8MODkKWeb1p+DnxY/9Yu18JmwGoKiyMSPl1Jb7tH72AjwkQdWkZ0UIUkONG5fUWxLG9he0Qj9pVqo6ls8JiqRZ4lgpes+w13Tl/T8KnC3cD/OaYFLaebROPmxAGiqRWrejgMjVUZcd8un3Dudnlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmwHbF78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1868CC4AF0A;
	Wed, 26 Jun 2024 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719403408;
	bh=MenChi4xWY9BwIcSq8UBGUeucwU//POkeYn0TanNEkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmwHbF78TpdP8H7+wAQyxCSNkGbSz1LTf+q1HZEm/VIWIkhkRu73MjZGsO++BdPmn
	 dTkGYvN0mF29oxp+Lm9D0N/TqrhRWpqjOaXnh7zAat2xZfkITe6ic4WhnaoEJJcL2t
	 YpC9ytvc/l0D5YP7/LNoxcP/ifrU1LsVspFOPUjdHLK9QEIbpK2zxDdTkoW9V3xLy/
	 0Ocj22u/apssMMBi4fW+X+PagF6IQooFyN/HIrm31esDDYcax18PKLn7TcIPxx5E5C
	 8NjAZmKNUGPHbDyuaB13rHoxmtLLOMEv8rEePlAf6oMC55WGybydhVG6aCfoLg0dIY
	 nJuuD5aM9aTrg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/8] Support foreign mount namespace with statmount/listmount
Date: Wed, 26 Jun 2024 14:03:21 +0200
Message-ID: <20240626-tunlichst-instruieren-2d823e2eb754@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=brauner@kernel.org; h=from:subject:message-id; bh=MenChi4xWY9BwIcSq8UBGUeucwU//POkeYn0TanNEkg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVMHdeFBDYtHm2VUdgeTanwQyeOUXHfV+l2f0LWx5wj kX2yx7vjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcWc3wV7iNeZvguifnS/Lr p8s0aAe9ltSU7Ej8XRK82Xz62ukdlowM05K7uXa3JAtfYljsbX4lM6TBerexxo2w/fUTfCa4HGf lBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 11:49:43 -0400, Josef Bacik wrote:
> Currently the only way to iterate over mount entries in mount namespaces that
> aren't your own is to trawl through /proc in order to find /proc/$PID/mountinfo
> for the mount namespace that you want.  This is hugely inefficient, so extend
> both statmount() and listmount() to allow specifying a mount namespace id in
> order to get to mounts in other mount namespaces.
> 
> There are a few components to this
> 
> [...]

Applied to the vfs.mount branch of the vfs/vfs.git tree.
Patches in the vfs.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount

[1/8] fs: relax permissions for listmount()
      https://git.kernel.org/vfs/vfs/c/ebfdd03a9748
[2/8] fs: relax permissions for statmount()
      https://git.kernel.org/vfs/vfs/c/a2f1759d19d1
[3/8] fs: keep an index of current mount namespaces
      https://git.kernel.org/vfs/vfs/c/0e79b98f19f8
[4/8] fs: export the mount ns id via statmount
      https://git.kernel.org/vfs/vfs/c/c64449b0b4ae
[5/8] fs: Allow listmount() in foreign mount namespace
      https://git.kernel.org/vfs/vfs/c/047afedd2e22
[6/8] fs: Allow statmount() in foreign mount namespace
      https://git.kernel.org/vfs/vfs/c/1661e867c946
[7/8] fs: add an ioctl to get the mnt ns id from nsfs
      https://git.kernel.org/vfs/vfs/c/00c8d859151b
[8/8] selftests: add a test for the foreign mnt ns extensions
      https://git.kernel.org/vfs/vfs/c/f0f1033dd078

