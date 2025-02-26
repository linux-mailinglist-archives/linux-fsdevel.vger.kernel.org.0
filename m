Return-Path: <linux-fsdevel+bounces-42670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE38A458A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7BC16BA1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4E1E1DE9;
	Wed, 26 Feb 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT7cCFxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA3258CC0;
	Wed, 26 Feb 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559416; cv=none; b=Vnf8hr44ljUHiRGuQ+/Ci1ttIoeeNWHwOuU3yhZoN9+F67PGZu2d/jMiLr/udrbbjhvmhB+JCjOxxAts9j78yscsPH9/2q9CQYGfnG1755PYwIuo7EtBAXfH7aqyu1KepLTlfs8Mozz5Wuoys4EjI47STd2SsjASar/Oftk2viE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559416; c=relaxed/simple;
	bh=nQ12+ZuT+RWVfR1SR3GsRnZcsv4vwF6ZxCcziG28oDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KL4yJ5GarOvpgdrsDB7h52kPUN2tj+gKwzDBnc7nQ+C1X9tpYdZzpROsCp6OrclGtC8zQULtHy5DSgMLS0n5e5z8h3vCDqrjqSPDr2OHZ0Plgc6M2I0kj+WxFE+8Fu87RN/+QQZ29PJu9VSgUhJ2JltSasboak68uKXKx7NCmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT7cCFxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B20C4CED6;
	Wed, 26 Feb 2025 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559416;
	bh=nQ12+ZuT+RWVfR1SR3GsRnZcsv4vwF6ZxCcziG28oDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TT7cCFxTl258g78hqWyNldXDNGBuHUF9ieLFzvdPYBY071FSNjuE6tH3mmR6K7Xio
	 QPe+U6PnWvWa9EYPTbvR7OZQ52UnorUIdgyzIDx7t/tA46oF7CBGHi/sXI7rUfW6at
	 5BTQ+Yk0VK5IeMjNycSdRawcu3LZT72x2blnJqKnLdgxmWxVAnPRFdJn6JbkZjxudv
	 ajDFHvy8So1swq8ETqRS4P8g+L3ECYip1gsezjyKovbYLGKf3qSVVGYOd2B1rJ8hsR
	 wv8uUSkfcaq5iQYKLfqPVhrBEVJn2+WwyDZML4UQgpOas+Wm9X/C5kHDVDS/HSfs3m
	 Qnu7pOU2JcHlw==
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] iomap: incremental advance conversion -- phase 2
Date: Wed, 26 Feb 2025 09:43:05 +0100
Message-ID: <20250226-sessel-sichel-42271d7b0d11@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224144757.237706-1-bfoster@redhat.com>
References: <20250224144757.237706-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=brauner@kernel.org; h=from:subject:message-id; bh=UeifwJvUfCO2NHtZtzmPP0byxd7wxoBJXhf2A6//LbM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvuyJv+mHzo5VHZ+0/djvy8ck5ihGhU7bkLtGXCTbNr DD4f2R6fUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEPGUYGQ74Om57fXa9/EcV 6/s65TzcYoJ80U8dan/NFOfboGy80o+RYX6M1Ibj/1/4fWSzUXySV7OjV85L78L5A/YvuvZazRE 9wAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 09:47:45 -0500, Brian Foster wrote:
> Here's phase 2 of the incremental iter advance conversions. This updates
> all remaining iomap operations to advance the iter within the operation
> and thus removes the need to advance from the core iomap iterator. Once
> all operations are switched over, the core advance code is removed and
> the processed field is renamed to reflect that it is now a pure status
> code.
> 
> [...]

I think review has concluded so let's get this into -next.

---

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[01/12] iomap: advance the iter directly on buffered read
        https://git.kernel.org/vfs/vfs/c/d9dc477ff6a2
[02/12] iomap: advance the iter on direct I/O
        https://git.kernel.org/vfs/vfs/c/8fecec46d10b
[03/12] iomap: convert misc simple ops to incremental advance
        https://git.kernel.org/vfs/vfs/c/f145377da150
[04/12] dax: advance the iomap_iter in the read/write path
        https://git.kernel.org/vfs/vfs/c/e1e6bae60732
[05/12] dax: push advance down into dax_iomap_iter() for read and write
        https://git.kernel.org/vfs/vfs/c/e1dae77b50e3
[06/12] dax: advance the iomap_iter on zero range
        https://git.kernel.org/vfs/vfs/c/80fce3058407
[07/12] dax: advance the iomap_iter on unshare range
        https://git.kernel.org/vfs/vfs/c/9ba439cbdcf2
[08/12] dax: advance the iomap_iter on dedupe range
        https://git.kernel.org/vfs/vfs/c/39eb05112987
[09/12] dax: advance the iomap_iter on pte and pmd faults
        https://git.kernel.org/vfs/vfs/c/6fe32fe1bbc1
[10/12] iomap: remove unnecessary advance from iomap_iter()
        https://git.kernel.org/vfs/vfs/c/469739f1d8c5
[11/12] iomap: rename iomap_iter processed field to status
        https://git.kernel.org/vfs/vfs/c/edd3e3b7d210
[12/12] iomap: introduce a full map advance helper
        https://git.kernel.org/vfs/vfs/c/d79c9cc51297

