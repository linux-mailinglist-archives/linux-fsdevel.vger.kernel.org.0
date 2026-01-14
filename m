Return-Path: <linux-fsdevel+bounces-73765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44DD1FC61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B359300CCFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160E39C658;
	Wed, 14 Jan 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdUp5Hdq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3C37F74E;
	Wed, 14 Jan 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404824; cv=none; b=Tcnjn/DEPUL/02OZsp5ZVYnW1y2K3bd25fe7INj9uivkTBT7/883ga9+eprejffg5wbP439wXO8SvA+SeT+7MTQ/BxUU8ZOw8c/wCJ6+LkijK1OfUqTb+eBCtDs4WLSA+i1DNV9xAgZ7APgvPNibjXqHZvBjC8eiMwY5a8YJya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404824; c=relaxed/simple;
	bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0dSJ3TviNgSmW2XAKm7JsNkrK6ndCzG0UwOsyFKqA/S7ZRwO9VUsJTPY8jbVY1ITyA+VUY29SrP5rC4YZazYJzEQWU4nrijp8bTIluaMEslrXAFTm98/w+u2TMxO5Px9KdXAh7Ono2hw1zqvwvyFecPfvXJ3ZnL1I6hRF3OT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdUp5Hdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DADC4CEF7;
	Wed, 14 Jan 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404824;
	bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdUp5Hdqng72DgawpASzAQd1tQWNDB00unhfFCktVQAtRnLTVA6k4zY4ckwXGF0mO
	 IIfqIuPqVJ52KKXk+GnyBaae1MFSd6blVN8jDW15BukAc7hmSYwdYz9z8xPp5Q53Ld
	 VrrFo1Fg4WEMr6amjuhJiGeXJZIFbs4lB9CZLFTPy+XyixLJpvnYh8iBBzIg+Zo1Wq
	 t9tITlmpFoU8Tg6XKw5eRnpgni3mhVq8UxZFMiTr/pqCm8VjNcYG7o6IpGAoY9K3to
	 bwBjODpefZFmJZhdqdW1mpBXTP9ISTaXg1fue4SHO8V9Qe5xC/ArD6tjVeXJOdNRhG
	 iLBtccF7U9WRA==
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
Date: Wed, 14 Jan 2026 16:33:33 +0100
Message-ID: <20260114-neufahrzeuge-urfassung-103f4ab953be@brauner>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org; h=from:subject:message-id; bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmbw8Ssa3TnqZh/WXGzxvfuGcsWfhY0vNAy5MDeXzHL Vxts/OKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy8xnDX0HVye+mi16T6n7w TP/Ctp6Nlet05xrkHhF5dENy46W01mJGhoUblmjcNL7989Dum3ECEvLT0/z3VmtkzQlx8Pu9Iv/ NFDYA
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

