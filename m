Return-Path: <linux-fsdevel+bounces-55158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1420B0762A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D0716B45C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819552F3C1D;
	Wed, 16 Jul 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6y/kIIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC85DDAD;
	Wed, 16 Jul 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670221; cv=none; b=KdDUT68vghq/EAOF/G8cuPLMuPNJJspfhJaKQ/Lp0jBXOzkn77lfTDW69vi9ahJM2XCNDRiEgoWkypdjFCMBQtqZYZ/w9GQIarDj30IbJhQpyTS8YrHYQ3gSbIWS50D7+eOfRSRl87XFjnQy5Fjo/EgoTJo6vtIsZNGzcUQ+csM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670221; c=relaxed/simple;
	bh=4HH/7+uv1zqsTl9WSybY+wX55rpatVs4WGpQNqy2vsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBWsDdlH0Z7F8r0cpBWeNkkfbUhPtKPfdBcYIncPIIzvwgbT7V5mTE9rKRF7sqMOzUIZ8FmO6BZDxQEFDCP5pr3MqIpA1moe96bEM1QEU2vZ8v1sELOOjUKoGEJUltREFnnORfNCMAz8RnmnR4cSxOOxS3T6mCGwWsVIc9q6udg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6y/kIIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A5CC4CEF0;
	Wed, 16 Jul 2025 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670219;
	bh=4HH/7+uv1zqsTl9WSybY+wX55rpatVs4WGpQNqy2vsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6y/kIIcjzK27Af//4JSBguOBglPSEovxHsYtB/8Wa8TcuG+tibQdWs4tKJhf9aOP
	 QAhWvPID1sjc5OU2mMQb9ACaCNT5IdeOBz5k0wIeJAO/T9r4uexndr8qUP8MEEbi3c
	 dTe/qm0ra4rVRBYhIHD27AIpyq4/UZP6a6a7eIqXxCbDBJY5X6QD8wu6Fyo0w5jff+
	 N1TvHvPZt9X0nkpkjjZ/MZvJhZ7/uOfEIXdbsbVfM66dJO9/no+J46LR2mtkQUnF1Z
	 5qQHUbsfXPgi0iUgQvHyGRr3hOr2igv2RsgHFDmA6AC+6L/QCLt+6CzcP5oEx0xWVl
	 MwkenhVuOckEw==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?=E9=99=88=E6=B6=9B=E6=B6=9B=20Taotao=20Chen?= <chentaotao@didiglobal.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chentao325@qq.com,
	frank.li@vivo.com,
	kernel test robot <lkp@intel.com>,
	tytso@mit.edu,
	hch@infradead.org,
	adilger.kernel@dilger.ca,
	willy@infradead.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com
Subject: Re: [PATCH v6 0/5] fs: refactor write_begin/write_end and add ext4 IOCB_DONTCACHE support
Date: Wed, 16 Jul 2025 14:50:04 +0200
Message-ID: <20250716-reinigen-kleiden-c6bca9969819@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716093559.217344-1-chentaotao@didiglobal.com>
References: <20250716093559.217344-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=brauner@kernel.org; h=from:subject:message-id; bh=4HH/7+uv1zqsTl9WSybY+wX55rpatVs4WGpQNqy2vsQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUL2DOebyEZcbbPEnRU9cm911muHQr7+ucJ9+yLqz92 xGumRJk2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDycY/hmy+tt+KF+b9IEz adGmKavzZK0ZP8zxW8RVWh8v7Gz5DKjCrHI2G9c7vWotdr9Yn+LdOyvn+O/Pcz7jwmwRuVzK3ZU HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 09:36:01 +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> This patch series refactors the address_space_operations write_begin()
> and write_end() callbacks to take const struct kiocb * as their first
> argument, allowing IOCB flags such as IOCB_DONTCACHE to propagate to the
> filesystem's buffered I/O path.
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

[1/5] drm/i915: Use kernel_write() in shmem object create
      https://git.kernel.org/vfs/vfs/c/e7b840fd4956
[2/5] drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter
      https://git.kernel.org/vfs/vfs/c/048832a3f400
[3/5] fs: change write_begin/write_end interface to take struct kiocb *
      https://git.kernel.org/vfs/vfs/c/e9d8e2bf2320
[4/5] mm/pagemap: add write_begin_get_folio() helper function
      https://git.kernel.org/vfs/vfs/c/b799474b9aeb
[5/5] ext4: support uncached buffered I/O
      https://git.kernel.org/vfs/vfs/c/ae21c0c0ac56

