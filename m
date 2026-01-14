Return-Path: <linux-fsdevel+bounces-73774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3035D2014B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7043018F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164D34F24F;
	Wed, 14 Jan 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW2wSB5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00B184;
	Wed, 14 Jan 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406777; cv=none; b=CJPyZZJcXvp0vVJdlPBNlCwOtse+Lnwwgl/GAUB99fH+ifBaQ3KsTWzXukDXnHs6u4m08ATGnfutd04gViYFMbcHXE1wAGp7hXjNfND9admBiEV4fz7XppLyqBfA5oUnjCwNNB2vt+PX2dGPb2y9+Mo08rbpHJnRsmwP5HoznsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406777; c=relaxed/simple;
	bh=GyDq+6eaoZkVZqBLxT6jqTugU3KCXYVJYLg9IeFm+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcHxfW/8iQbtMD/ks+ylC9FQo17+aBWROqzKOxb0VytIQ/DKM/oieb0qJw8mezClFKvv0zwrwQzGpnWyiXWcD+H01ZgqPg/2II0VI0CElvK195aKoeMFdBFSDmZ++glkyY/bnPmPLwLTJjLEu2n42V4GUnrzNGxR+Qj+MO9Q3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW2wSB5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCA8C4CEF7;
	Wed, 14 Jan 2026 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406777;
	bh=GyDq+6eaoZkVZqBLxT6jqTugU3KCXYVJYLg9IeFm+ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PW2wSB5h/YUGeuN8mZBP0EIeN1h0JdZEWtHrU4S6iRqcMv9jTmOeKhP4M95MhqEch
	 S/sBK3qq+pV/2Lx/gPWJpQgIqHsp+wj/mvb4FKYBZBMRw2gx1KCGSLkPvU1oi+B3kB
	 gst/5hg1EL0KkFQRgHG3Y3xZOzl/7G6eWANn848TdJd8gPZbNXEZrSSOvPZjb7nIdI
	 JH/rNfE/kskLg7r1Sy50KoP5HQZm/J0bwyCmUJmollx3DsgK5MlGR+eefUqiGlZJR5
	 Ro3FqBDbmSgaV1bqpJ3iWb24zX2IH5fnYVf5hhLjyWl3iV1cCnV5Gw77RP/zGTP5Mz
	 gXQ+TMZuPsH1w==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	bfoster@redhat.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: wait for batched folios to be stable in __iomap_get_folio
Date: Wed, 14 Jan 2026 17:06:12 +0100
Message-ID: <20260114-abmessungen-pyjama-0d0b08449efc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113153943.3323869-1-hch@lst.de>
References: <20260113153943.3323869-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org; h=from:subject:message-id; bh=GyDq+6eaoZkVZqBLxT6jqTugU3KCXYVJYLg9IeFm+ek=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSm7/sqP3FFgUQ3e/xigUORU3qeHHgUfe/iyZhb5azz9 npuPR7D2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCReXyMDJt4JQ369DemFm2P OLJtVc31hIcbZ7J1hW1l3LZo4kQjJm6gig2MM9PdNjxxbIqKUu5boLV6LkPwzFfyS2Yu5t/k/y2 RCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 Jan 2026 16:39:17 +0100, Christoph Hellwig wrote:
> __iomap_get_folio needs to wait for writeback to finish if the file
> requires folios to be stable for writes.  For the regular path this is
> taken care of by __filemap_get_folio, but for the newly added batch
> lookup it has to be done manually.
> 
> This fixes xfs/131 failures when running on PI-capable hardware.
> 
> [...]

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

[1/1] iomap: wait for batched folios to be stable in __iomap_get_folio
      https://git.kernel.org/vfs/vfs/c/561940a7ee81

