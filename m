Return-Path: <linux-fsdevel+bounces-20504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C022A8D45D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C491C215FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417F74D8B8;
	Thu, 30 May 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTaCa7W0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5504D8B2;
	Thu, 30 May 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053181; cv=none; b=PMRu0X7Eb2F2ZNMNkMJpuXp+6np1vnBZXUQBRdYf2kLM4lPBWEFSBW18Ofr3m3yXb8ZkDcG1NWiTKymyd64BcR4Lc4+feMcVCfsXTknMaglEn2xpt7t7OkMjm+8MOfPYeAdFyy8yuGzDV5RF8hwwSru4NNQc/hKRrBcN3FePLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053181; c=relaxed/simple;
	bh=8ULP4kKmkBkB8OhdDy2ZgeEvGKgKKr0EOtx31F1eVaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLWDBIkYekwTSd6tvKkli20jonLqbo1TKS9AnzhJVmhpxQQtKn0VU44lb92nNdKegAwbjeW1u/lwBLztf4Rc8tadysrYS2ZNRkCs0V/Uu0AIO1escpTW9WTCNEJIJIlKMP3rhZNYD3POLMAANP2mu5pJmHcxpF6tjnVrFqMgNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTaCa7W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8915AC2BBFC;
	Thu, 30 May 2024 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717053181;
	bh=8ULP4kKmkBkB8OhdDy2ZgeEvGKgKKr0EOtx31F1eVaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTaCa7W00BtA8JKrCNXNmV8d62duYklrrNYmxTy76yVZaPce7bAeoHXBselgNOUpy
	 Xu0seF4pq4Fy9bPD0FZ1cueLOHsGREEKKxwpMhB+1pfoW7K+u0Z3jLme6JjLkdVY0i
	 g7iTq63PGO/LRmtPUW+U+qFaOSpHmlNqvLXFbZk0E++ldOvaF1FAmFsQrz7fcJP8ZP
	 oOHCqYu+Fz9qBw8BLQJni58bhwM4796Ca5aLHMIhYxaKvTUw9hpChPx9LWSjmm0j9W
	 y39FBcIsnxZxtXtA1eQlwZ028aNJi7vWMVkQ0NbkcHfd/AytDqyGil1oZUjyxuq8c2
	 W1mE0rmZasYZw==
From: Christian Brauner <brauner@kernel.org>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/file: fix the check in find_next_fd()
Date: Thu, 30 May 2024 09:12:52 +0200
Message-ID: <20240530-gewichen-herzhaft-afdc69132239@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529160656.209352-1-yuntao.wang@linux.dev>
References: <20240529160656.209352-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=brauner@kernel.org; h=from:subject:message-id; bh=8ULP4kKmkBkB8OhdDy2ZgeEvGKgKKr0EOtx31F1eVaM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRFqH05ZvP2WSvLzX9tZ0sWBFYcXlBflqvEwWvWfEcwV lRv9YK0jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0CTAyXP2V03+aSeerfpVg /T5r24Lfr3sdUvkt+XYc2fJNynDVWYZ/+qtfxDsqTXv/9vyvp7rbW9d2vl8YmfzgAx+zluGafvP 3DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 May 2024 00:06:56 +0800, Yuntao Wang wrote:
> The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
> maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
> gives the value of bitbit, which can never be greater than maxfd, it can
> only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
> will never be true.
> 
> Moreover, when bitbit equals maxfd, it indicates that there are no unused
> fds, and the function can directly return.
> 
> [...]

Comment added as that's really useful in general.

---

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

[1/1] fs/file: fix the check in find_next_fd()
      https://git.kernel.org/vfs/vfs/c/96998332ac4d

