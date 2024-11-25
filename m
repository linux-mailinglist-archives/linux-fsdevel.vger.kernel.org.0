Return-Path: <linux-fsdevel+bounces-35829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D09D8834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8197FB63176
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89771B2188;
	Mon, 25 Nov 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTUwG2mR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3C1B0F35
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544233; cv=none; b=RsZ3Q8wOVaEU5mQ5IdesmhPdnJTysDxP5qGic29UlnUbFhK9lwVBy5aFT2IwwqAgVOGtUn0BHD8hR/PnrqJALxwjLZJvY0gx7z1Kem5sqXFBwL1MmT/kWssozlM8wh/92R4noRcLwoucIvfaojRG7QY2RNfYZUCtMz7+1YRvZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544233; c=relaxed/simple;
	bh=dmi9N/hrZbRvXno82lrNCyMzm7QDs9ix0+h1M3aJ/s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd7EYd9yyiuzYHZ7JC/fjg7Y4QOzftCERhb0/EdEaWaHqsVxkc0qsFZqZV00QUd6so0+7tbBfsZI/aCqcT7NjCLEiwyafgTDfkwpuQZVVfEDq4hwBvZkFl+7XGZHVKZgPqXGRZWAfMjDM2CcIarZgOV0qZVCsNsvGaSOhNSv1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTUwG2mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E630DC4CECE;
	Mon, 25 Nov 2024 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544232;
	bh=dmi9N/hrZbRvXno82lrNCyMzm7QDs9ix0+h1M3aJ/s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTUwG2mRKt386N8koRM0/7JZ8NLiry32QtQ6TBN3ibje7oyoZNsar0PREI2jOlZeK
	 BWSkVoVBIr99BuPjUMETu6FGIoG7Um0QMi+iICOnqsV+J2ZU7H7xABu6ZTMaY6whFh
	 K+6NMvQhLwHTtZtl/bukDBF8+xrRfOBRHYsqIbw4YlOXnOl5DK/nUJi6nTdkEEVI7D
	 hA7noCqm2ZcHFR7BgRUzYkT1ODWiynwv1QugYW3vpKeyIZUNfg9qkvRylWUqGFwUtD
	 /RFgtf0lvcAkaOGUgbPonmye+Y09gjiuAwZI21GvYaQePcskMwGWncZ7nHKZAzA/qH
	 c3cO/sZ49lGXA==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] fs: require inode_owner_or_capable for F_SET_RW_HINT
Date: Mon, 25 Nov 2024 15:17:03 +0100
Message-ID: <20241125-wildnis-grabung-ca4f69770bca@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122122931.90408-2-hch@lst.de>
References: <20241122122931.90408-1-hch@lst.de> <20241122122931.90408-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=brauner@kernel.org; h=from:subject:message-id; bh=dmi9N/hrZbRvXno82lrNCyMzm7QDs9ix0+h1M3aJ/s0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tD0qZuyJN0/7wiVkX/zFu0n6ntJ/hVv3phzNmXryy vv5s75M7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIs2+MDKcSZhdXX7Jr0f77 6LT+rIUODv7Sb8yjX3jXX7+wm0Ml9wnDf4/dfFrzSpQdZJxWMx/7uCf8wWsHxxVC3PcvZbikOd7 /wQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 22 Nov 2024 13:29:24 +0100, Christoph Hellwig wrote:
> F_SET_RW_HINT controls data placement in the file system and / or
> device and should not be available to everyone who can read a given file.
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

[1/2] fs: require inode_owner_or_capable for F_SET_RW_HINT
      https://git.kernel.org/vfs/vfs/c/b6512519496e

