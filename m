Return-Path: <linux-fsdevel+bounces-52777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC4AE67A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C97189A678
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE32D29DD;
	Tue, 24 Jun 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IktSCs9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF812D1905
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773251; cv=none; b=kLZ12Lkicxw4ezKrDAdxaVRdM1Oz9RBvb52/+0Xxmp86a1BMjpEkv/86X/bPq3a03mdor+eGE6lR+TlTGSEBnr2d92n21ydWvFWi5/5rjJs3vw1vEamsCMhusVihOQpq6FQkPqMvnArRqsigaTiAwhyE352pRFrmPmVaECmTgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773251; c=relaxed/simple;
	bh=oaog2z5r4x9BdWv5IPsVvm0QTzwefJCapufAO6ZmLH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1FfRd4sBqEkLfgd/xlzP0bHU8tsbYEOLyzrBITsOpzsJ2ZygBQTp5cVRfpsHI38frtbannFgXM9nH+coaZTf8aL9uZnmSgK0lwdmmJ52GTaZneRkKFXqKRaW4cObq37GsdSfDSdE3/EQRFVRoPy6WNzg+TYpTQcQMbSICNoA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IktSCs9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F143DC4CEE3;
	Tue, 24 Jun 2025 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773251;
	bh=oaog2z5r4x9BdWv5IPsVvm0QTzwefJCapufAO6ZmLH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IktSCs9WOZvfJSyhxhByvkATajtbMVmnp05nNz/D2qz310jyQqSOiNCC6keQRJMUr
	 jwue3Nf+AjkxLNabSHF9vtqIgkjP3hSjNNFVIaq/6BqVLegYEVNhmn7/DnAB/jPX8f
	 zYvmdaiQ3sXyP98yXYiavleYvYHw0ZetgPUpUx3ybV1k8IJgNfZEu7BRdJoC5kw3zU
	 +dtn+OdiC3FzaNiAeiR2BvW1xl+YI8yWowgL5M/6uGw3QtjDS+LDBripbtBpkdFT02
	 /yU8yBPW9Hrjc2erCsXIu86cQLXVlUxBpRH50bc4YJ2vN0aNFwimeCn810Z/qcmmoe
	 rX/TNk+0MnRsw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?=E9=99=88=E6=B6=9B=E6=B6=9B=20Taotao=20Chen?= <chentaotao@didiglobal.com>
Subject: Re: [PATCH] fs: Remove three arguments from block_write_end()
Date: Tue, 24 Jun 2025 15:54:01 +0200
Message-ID: <20250624-wahlrecht-frieden-5030ba41bbe7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250624132130.1590285-1-willy@infradead.org>
References: <20250624132130.1590285-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=brauner@kernel.org; h=from:subject:message-id; bh=oaog2z5r4x9BdWv5IPsVvm0QTzwefJCapufAO6ZmLH0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRErf13VLb02/UA/Re/ouO1n827FrWnUKa6KynCLXP9x u12Po0LOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbybRMjwwyun+tsZMx8fluZ n/cpivPTUZp4TL7yeZefxZ6ok432Pgx/pezmZ8y/eOXkVR+HW5mR2yfy3+O5NvOrx4Mc5jMruSM fswIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 24 Jun 2025 14:21:27 +0100, Matthew Wilcox (Oracle) wrote:
> block_write_end() looks like it can be used as a ->write_end()
> implementation.  However, it can't as it does not unlock nor put
> the folio.  Since it does not use the 'file', 'mapping' nor 'fsdata'
> arguments, remove them.
> 
> 

Nice!

---

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

[1/1] fs: Remove three arguments from block_write_end()
      https://git.kernel.org/vfs/vfs/c/b39f7d75dc41

