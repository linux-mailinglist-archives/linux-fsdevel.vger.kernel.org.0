Return-Path: <linux-fsdevel+bounces-73212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C176D11BD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2715330C9E70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799928DB76;
	Mon, 12 Jan 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+wCiHPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C0277CBF;
	Mon, 12 Jan 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212414; cv=none; b=SOZwUNcuqPg1hyEWSSKGtsxNMT8vUxFSWL65ywkOUen+EcV8Wtkm3CHXfhDwEBa5mHusHeFI8YxCvCsO6BJ9sP2Euf7nOcCDDLloHYDeCLlzW6ky8s9tMOKEOlNAYnyRgsU3sV69srnU7fZCNkxGyfWtGlj439tjZpFsRvLKTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212414; c=relaxed/simple;
	bh=fMJeF9GicK/Y69rTQDcYD3d+HbsZSCZheTprgQAEWfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nphNNALamYSOG3kmYJ20P5iDxkkA1p14pATwkSfT7aiXnOV18esGuvRV/BmMYJKVvJ9uXWdOGQaSO/pnp7c7QvlAMj5VQG54Da/cLPsob/D9kn8ssKejJQIb8d7p8drFRT272ajjezoAJh+QMYiqHBiViKTQPXrNJpQsOoQWd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+wCiHPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDEFC19424;
	Mon, 12 Jan 2026 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212414;
	bh=fMJeF9GicK/Y69rTQDcYD3d+HbsZSCZheTprgQAEWfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+wCiHPx1EZw5N2SgfF9TxB9B0RcmXlQ3hzKjB2djgZm1WmnJqGq+cDprAhpRVv/v
	 9ktoIud68jffpynX2HOLMfm5Y2R8kzrexJUIDSk6gSXNGueWCFaVAS12bm/7ea/N2+
	 efuhkcvQxjpKKOkgLp2A0/WIXdPh7/t8umbNn2N2e2DC5sXqZiFzg/D6vGgDDUHQ4X
	 +5S7RclS8yV7U5IkeXxdHn6mKKkuygPN1x9sVC1gF6aSjzRajlznNA2mM0i9JQhfQr
	 llN0C7quGivdfxYr2U3IOt2Adi7S3uccOsIKU6hnvKCiKDR7NL3z4xHDrRXhfoyZ13
	 HZWQDfqkIuCgQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Wei Liu <wei.liu@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] acct(2): begin the deprecation of legacy BSD process accounting
Date: Mon, 12 Jan 2026 11:06:43 +0100
Message-ID: <20260112-frost-amtsmissbrauch-04c1d16623af@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106-bsd-acct-v1-1-d15564b52c83@kernel.org>
References: <20260106-bsd-acct-v1-1-d15564b52c83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=brauner@kernel.org; h=from:subject:message-id; bh=fMJeF9GicK/Y69rTQDcYD3d+HbsZSCZheTprgQAEWfc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHN85f/pcv6P7eud+7fkb0LZDO/L/rKS49cpX6pcqL zJg85ts01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR208Y/gp4n5l9+6CVySNv 1eYjUhWy8/MPLGVZcf/4XBNr56/8e14x/LPx/6xx8/t7VUYJnwneWfJOsw7Nfbc9JljlwqvYe4f efOYCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Jan 2026 09:38:22 -0500, Jeff Layton wrote:
> As Christian points out [1], even though it's privileged, this interface
> has a lot of footguns. There are better options these days (e.g. eBPF),
> so it would be good to start discouraging its use and mark it as
> deprecated.
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20250212-giert-spannend-8893f1eaba7d@brauner/
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] acct(2): begin the deprecation of legacy BSD process accounting
      https://git.kernel.org/vfs/vfs/c/24a4f4e1608f

