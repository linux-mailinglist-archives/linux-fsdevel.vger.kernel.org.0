Return-Path: <linux-fsdevel+bounces-32474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7B9A6888
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE781C20924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F641F12EF;
	Mon, 21 Oct 2024 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMRb3CJb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF01EABB2;
	Mon, 21 Oct 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513957; cv=none; b=ge8TZWmV2oU+TunjwKfguSK4AecMWB9/Hu0a+SoHl2ic9JicnjLtpfttC/6nRddt7bFiB7imKMW5iRcE7TeYDSk3eEWhj9Cy7ClYeYH/ajqj+pxt+GXHKaJYkxNfEzxF7LYFI/Kl8mIKWpalcdA6S0ANhuYXwM2qGfRODHDTzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513957; c=relaxed/simple;
	bh=DVCh3iNw6uYypy5M+ZmLHYym9XosXi9ik8C+JBoUxs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkPh3++UgoLG3B3z5vBCpU+MOfheLhj5G6sC6umguxGq3q+7AZyyg1xZ1d7w8iHWV56wS6NzbK8+g/Ajg1upkelvj904VcBZw0KEYOCyH8WrEtKEnibqV8w9oi5OfGEgZj21hTMSKQoBdiVvehkiRg6xYk8vI7MhH3OScdMBXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMRb3CJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A68C4CEC3;
	Mon, 21 Oct 2024 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513956;
	bh=DVCh3iNw6uYypy5M+ZmLHYym9XosXi9ik8C+JBoUxs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMRb3CJbsVB5FZhUyX7AOdeCDOUsx0HODnJp64JvMdx85P3rcjiQZHgS+3/Z2K+TW
	 dfpC/QpPYmeHHfTPWeY/FKuduAkEk5svXCyTNbNLyDEOgwjdDcMYDILilS+SWdu/FE
	 /vnVtlAKb7VixXBJAPxXTprJ8AyoShCTiDfRxjX8Xv5rIi4Q+efm6qT28m5kTQqJXb
	 9z6is7DjXHCEJDUVsxQxLQYbnR4tUo+V4T1gJreuwN787sKfgykvotf7LrM7PTHLN7
	 VOAmekzhIMsvjhMgdCF/IqTYgOBmdzBPGyJTy9ANQ4jNDFjg/Qx32SRzLaSYpXQOn1
	 DxnOXjFOCZTCQ==
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Date: Mon, 21 Oct 2024 14:32:29 +0200
Message-ID: <20241021-gesagt-abverlangen-b9ad11ca0e9e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=brauner@kernel.org; h=from:subject:message-id; bh=DVCh3iNw6uYypy5M+ZmLHYym9XosXi9ik8C+JBoUxs0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLed7d5DRNM+1o6qydGjovDrYvVzpXe9h47kKO1MkLy wVCdCY0dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkfzfDP41Lm94vbNkdYff2 qxrL6Ut/6pqEdzDFqacq/pDTDdixV5CR4YCBMUuuH3dE33mrEsPTHI5xUbufe/3f+lVlZwz/3dO hXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
> As Allison reported [1], currently get_tree_bdev() will store
> "Can't lookup blockdev" error message.  Although it makes sense for
> pure bdev-based fses, this message may mislead users who try to use
> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> then.
> 
> Add get_tree_bdev_flags() to specify extensible flags [2] and
> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
> since it's misleading to EROFS file-backed mounts now.
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

[1/2] fs/super.c: introduce get_tree_bdev_flags()
      https://git.kernel.org/vfs/vfs/c/4021e685139d
[2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
      https://git.kernel.org/vfs/vfs/c/14c2d97265ea

