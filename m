Return-Path: <linux-fsdevel+bounces-16922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E358A4EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5BB21714
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4886BB50;
	Mon, 15 Apr 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPPN0BH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895E5CDD9;
	Mon, 15 Apr 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184001; cv=none; b=fxd8AOpQDKtkn1vmgzY9VloN51479X8etdkk82pbAgPh2/M6BsNBDByzkCs/nSXhYpnIA0T4a1eiWvKkVmA2yWH+8uNhpb87rgvU7i4BVk9UhDcOxAIgMjyK9gDKfJnIqc3ZxfzrYkWe0FNksIcbOZ4cGSsDdC+t7mNeYlmBy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184001; c=relaxed/simple;
	bh=GTOyXnv1oOZTBRIFSx620T2HMkgwaxIpmsqx4y5zakQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzoymAMq2pjyUiqctKv9YkTKM986lQlmHdNBRpMdyRHW+eDtuYzAEhHHN5UZcpu3s22/jjWjud2qYwmbDIkgJtIh3ZlP9S0iNo3HauOT8Uws+oktgfkdCtz5K+0c+SSi5GEUJ2bUoD4scSEVpj1EonE0E/T3NFkxfW1x7KXHaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPPN0BH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E5C113CC;
	Mon, 15 Apr 2024 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713184000;
	bh=GTOyXnv1oOZTBRIFSx620T2HMkgwaxIpmsqx4y5zakQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPPN0BH4PdBKxmMQzq/QTtQ7glIWE5InvdYxFBSpeFfoDG/NauP8QRAzCVCEFgWko
	 SN30l8Gvu6XZn5p3o3FYJmGshvG3oY1rdegdR2U9711mRYpfvw/jPrsX7RmxirgPeu
	 AMTghWQCq8/50QZP7v0z9vhKUeRK0emZC78Kan4WQVVPLc2dPutsOLZWZyXSkLVtYh
	 gaagMaan9JFVT3m40HypWKIvQHaEvo1fNLYMEbgeKVFlFdOfoVifNhAybiJTG6BjmU
	 EvqFIbYazZ/M5GblB9+TUxxe0tMGhQODMgeiomF7JqNEObbQwnzLg/cF1OunOPWdRL
	 WTe2yUJNfCL8w==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: convert iomap_writepages to writeack_iter
Date: Mon, 15 Apr 2024 14:26:23 +0200
Message-ID: <20240415-chorkonzert-zierlich-9fd1e125ac3d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412061614.1511629-1-hch@lst.de>
References: <20240412061614.1511629-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=brauner@kernel.org; h=from:subject:message-id; bh=GTOyXnv1oOZTBRIFSx620T2HMkgwaxIpmsqx4y5zakQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTJynzKbEtVuPtzR9v07P1d8yKOyV5sZeA3n/BrVWOyu 32z0gLBjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsFGVkWOe4rTGu7eYROfO/ z+5LW0n/O6bum/FNi2e68C1hiy8XExj+ikke3KAdkOcZL/l386XO/Qea+u+t2CcQcoj3yqP70j/ eMwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 08:16:14 +0200, Christoph Hellwig wrote:
> This removes one indirect function call per folio, and adds type safety
> by not casting through a void pointer.
> 
> Based on a patch by Matthew Wilcox.
> 
> 

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[1/1] iomap: convert iomap_writepages to writeack_iter
      https://git.kernel.org/vfs/vfs/c/0fac04e4e0ea

