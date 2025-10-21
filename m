Return-Path: <linux-fsdevel+bounces-64923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFDFBF6A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7BB7355B22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FEF336EE1;
	Tue, 21 Oct 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9+mukgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81033291F;
	Tue, 21 Oct 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051812; cv=none; b=r5MtyVMC41zd5/1L3bAb0CkgYHh1z5+kbZ+M9TJWrxZa1GLo/V/QO+Y6TiPpkph6J6PeJBmvG6m0lv3aC8TS0UHm7C2NJa3Qcbo7EbNXYxhXN8RlK4VxZPm11Xg5WMoXiFDz6WKEmaMtviouNUb2DeF4bRECM1Tjg6J2dAxZJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051812; c=relaxed/simple;
	bh=t26UTDE6fAOEi9W2Qc7FMVxXQoGtaA09RUpkBMmyPyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jymn+kWDNHGx9VrWbqiX8IExJRNYkHLvUbjlCYjd8p5ouLujTbUZZF6XpEclFAMvJ1XzZZ7xNEzszxfFYd08V9phOgPphzkqDGw0Rq0QPi7/utQvnLEoehiUfHuVQs07JeG2w2pMhuwkFVZJjQKTPbd6WYWnTMtz59ezxdT/dJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9+mukgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E44C4CEF1;
	Tue, 21 Oct 2025 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761051811;
	bh=t26UTDE6fAOEi9W2Qc7FMVxXQoGtaA09RUpkBMmyPyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9+mukgyTBL+w5QBJ5yG/CffLdsdM/e2/sBVxjrQJqwBXoAsvpP5xn9g+9U2ABhB/
	 rLj4fe5z17tL3cVAzYiL2DFBWXN28Ntm+G5bbaRLWpfnMh6xi+mXL3gD3DZmM6hgaD
	 PBWgTpXFSU1fgj5N3qeRACDFRIRlilxIJl41gaNmAz22CNQOQXqxSlpD2ah0taY053
	 KjIPEizXTHzj9upoVl73q7Yi1EjYIps1XtCQ1A0srmlSRlrtTqJsNOYxT2APhvU1w8
	 TWvNazkmMkeU1xYJnBlvoo1XYGtzBHhMKWmCSxX2ujAykU1pW1fibfNus2urVyQvqT
	 syzl8z6An8+jQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Date: Tue, 21 Oct 2025 15:03:08 +0200
Message-ID: <20251021-leber-dienlich-0bee81a049e1@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=brauner@kernel.org; h=from:subject:message-id; bh=t26UTDE6fAOEi9W2Qc7FMVxXQoGtaA09RUpkBMmyPyY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8b5nn9m56ZK3zrylmtflC5nMnPrTMOnf2AfO/zhvaV RZxLeVtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpimf4H/olYP5HxtWnK++s +7X0zoOZZi+VJWY9c1aV4l12c9n9xp+MDJcq1OWUbB51Wiuyz57T2i9sHDbZi9U2wtpNVZ7v0Ol OHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 13 Oct 2025 19:35:16 +1030, Qu Wenruo wrote:
> Btrfs requires all of its bios to be fs block aligned, normally it's
> totally fine but with the incoming block size larger than page size
> (bs > ps) support, the requirement is no longer met for direct IOs.
> 
> Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> requiring alignment to be bdev_logical_block_size().
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
      https://git.kernel.org/vfs/vfs/c/96a9ee1c896f

