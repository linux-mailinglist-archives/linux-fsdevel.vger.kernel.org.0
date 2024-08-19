Return-Path: <linux-fsdevel+bounces-26258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA16956A7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A461F2119B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B916B399;
	Mon, 19 Aug 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFIlOFoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE38166312;
	Mon, 19 Aug 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069392; cv=none; b=LAac5eAT42YqJ03Lz+RSDQgmoc2jAqQncXW0c9Ot+xw/7iFeGsNojzCPod3TyvSSBjoe9RkmRsSlpq0Ty8MO3VNWup1bW7bT9k4ubOqShFcDBIaD9HssDDGHniQBhehuJwz+OgbYjyNJnCwGUB8oCdm9Guh3pOM2bHcDKRfJa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069392; c=relaxed/simple;
	bh=Ko7YrTMFgeEYgz10mfeYHJXmCLi1qQpsE4JsU2y7FTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1WNcn9Iess4FikIa4BhPQ6XRQpEBbrk6BsZKXEvbuMtiHcfIo9HydcAQJtTb4gCWv8e7MCZE0wwNeJ3muFY3tGkQuNKNrf+A/Rv0B0+hibltsiLcKHQH0z2UfFEF7I1QqF4siXsVcP5oxmVDXlMqsM/CxBRAFnAQN5hmXVRN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFIlOFoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6DAC32782;
	Mon, 19 Aug 2024 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724069391;
	bh=Ko7YrTMFgeEYgz10mfeYHJXmCLi1qQpsE4JsU2y7FTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFIlOFocyb8U5EG+OiDTL9h4psZTVfNqbW5ZuCyJZk6y5NwbSnM4EQAngrzBUcmKH
	 w9JTIo47Qqk5t6H/iD6Yzqtgq/ALqU7rTfPLO8MBA0CJkKgnCWO8iPCVNOCFVlYm1e
	 ttBzvFsuucpRbmj4mm38F5wTBlLCWgWsfigBsbUEnZMHgpIO49DxueqAkfmNCzvkeA
	 cfNvcICoR61uLMs0LrxzS6X6YD+QFPFhfZ9HE1kO3P7SN/9MW7kuT87W5vF9CVC0LU
	 I4Ks33B5OdMPZOr429DKwevEnpfbuD6kAuYun948OaIXBo9H0A4Q1VzHD6hlSk11m7
	 d6G1em9iZhg5w==
From: Christian Brauner <brauner@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	lizetao1@huawei.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] Squashfs: Update code to not use page->index
Date: Mon, 19 Aug 2024 14:09:35 +0200
Message-ID: <20240819-serpentinen-thema-e13d7625bbfa@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818235847.170468-1-phillip@squashfs.org.uk>
References: <20240818235847.170468-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=brauner@kernel.org; h=from:subject:message-id; bh=Ko7YrTMFgeEYgz10mfeYHJXmCLi1qQpsE4JsU2y7FTg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQdNuOSv5/Yer3xA8+Rrd0mRqZzDxxafl/px4mGXsvOh OnqE5zudZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEdh0jQ/+jpaw1n88xr7Da GT/dYKFBxb67bs7lLzY938T0189iTSgjw8v3hi4Txf/wrv/CGHBln+9l85TJ08ovChzcwzijfsv NSRwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 19 Aug 2024 00:58:43 +0100, Phillip Lougher wrote:
> In the near future page->index will be removed [1].  Any code which
> still uses page->index needs to be updated.
> 
> This patch-set contains 4 patches which updates most of the code in
> Squashfs.  The exceptions are functions which have been fixed in
> recent patches [2] & [3].
> 
> [...]

Applied to the vfs.folio branch of the vfs/vfs.git tree.
Patches in the vfs.folio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.folio

[1/4] Squashfs: Update page_actor to not use page->index
      https://git.kernel.org/vfs/vfs/c/2258e22f05af
[2/4] Squashfs: Update squashfs_readahead() to not use page->index
      https://git.kernel.org/vfs/vfs/c/6f09ffb1f4fa
[3/4] Squashfs: Update squashfs_readpage_block() to not use page->index
      https://git.kernel.org/vfs/vfs/c/7f73fcde4d93
[4/4] Squashfs: Rewrite and update squashfs_readahead_fragment() to not use page->index
      https://git.kernel.org/vfs/vfs/c/fd54fa6efe0d

