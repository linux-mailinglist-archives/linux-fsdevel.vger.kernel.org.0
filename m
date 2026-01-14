Return-Path: <linux-fsdevel+bounces-73767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A05AED1FDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA2C30B6038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61D39E6C3;
	Wed, 14 Jan 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfB+WzQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31139E16C;
	Wed, 14 Jan 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404941; cv=none; b=nRaAr9vjobZrZGGVS4MaQZ3yIN8z6S7gLoBohz2rm2JVugcGadx0sj0WiISuddNcey3fsXigALA5xKIwIJS78eDVMU/Sxq80+gx7IaYb2Kya0IIBbNRL5J2jV/MYZUYqNTBBThE6ryMd5s8rZ48FPlji/bE7BNsReLVy4JdQA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404941; c=relaxed/simple;
	bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DArH+dfJg2McpJvOm6SMYbtkKod3EvDmPx3+vUBe8BxcXocu9szkbmVrh7TY8QOZtrkw7yDX9jGageMY1m7qRVIpqIU6ZGcNKDVDr/5UBVNQMJXaT59be+ufo4gpJESIarrLFbNVguvTF1n1jHyYK1J+FHa97aBrnjXgffZM3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfB+WzQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AECC4CEF7;
	Wed, 14 Jan 2026 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404940;
	bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfB+WzQlxfM1YRtgmk7/o/Q6os+viuowRQlTste7/tCCa3GR+lWoDezERZ+WI7zez
	 GWPP7xW90MipQ6se7+e0hAm/E+QLp50/B9KboptAIx42aUN3Jf8sbSYa163EpLcVEJ
	 WVYZgfdTuNJGhuxXrTWPMoBP2QzeiAnhiOZItqr3SGQXRRu+OG+U1wL3TPGvgLXBce
	 HiJePu2AJhYeZPdGgRsHMU84wGHgx2doZgcUfVgRYRo30YziFZTkVVYUnX3/8T7gmZ
	 XTUKwaidc10bxdf3Gp/pgp/5LU/cxGiweVKvAOzEDDyhIBq8gXrXKcGhhuhK5Y4YcX
	 VVxwvhgDpBYGw==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	amir73il@gmail.com,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	chao@kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: Re: (subset) [PATCH v14 00/10] erofs: Introduce page cache sharing feature
Date: Wed, 14 Jan 2026 16:35:27 +0100
Message-ID: <20260114-wirkung-planwagen-2f45216c3645@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109102856.598531-1-lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org; h=from:subject:message-id; bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmbz/OG3Dk8Y7pHUqOT94o1G3c9Jtzp3yfSvtUkfjT0 fJJ/6/s6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIuh0jw8ILSxV9b9ebvOz/ fOK3fUFEb5uTbILO8cTZ2l7H55xxXcDI8OfmG8NUL0PPnbEK0SnrTuzkffHica3NQ9uVmptMJml 94QQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Jan 2026 10:28:46 +0000, Hongbo Li wrote:
> Enabling page cahe sharing in container scenarios has become increasingly
> crucial, as it can significantly reduce memory usage. In previous efforts,
> Hongzhen has done substantial work to push this feature into the EROFS
> mainline. Due to other commitments, he hasn't been able to continue his
> work recently, and I'm very pleased to build upon his work and continue
> to refine this implementation.
> 
> [...]

Applied to the vfs-7.0.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.iomap

[01/10] iomap: stash iomap read ctx in the private field of iomap_iter
        https://git.kernel.org/vfs/vfs/c/8806f279244b
[02/10] erofs: hold read context in iomap_iter if needed
        https://git.kernel.org/vfs/vfs/c/8d407bb32186

