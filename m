Return-Path: <linux-fsdevel+bounces-38748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D1A07BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA941885399
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0A21D003;
	Thu,  9 Jan 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Z5425o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CB20469B;
	Thu,  9 Jan 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436284; cv=none; b=rPPkVhBVLmYFT38Vx517fp5JC2E7z34nhOz6ujf1imHOPiYsm4FP3FUd75C+TiTGKjCCSmmM91z/lbA+fnSIVtk73v6hQV/GLQ97qkbuxPLKOeh7+DDrNBaXiX3MbE0nP+iX+aL3dODMeDWh6u/S+fcPYi19Zqzx/Sa163PPgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436284; c=relaxed/simple;
	bh=Cgj4SKDnVIxVoAkg16mjvYmaG/UVaegsKkU2/H3f3zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw6YB8hs7EIXwf/opIv92l++uxnsMKzOT4/F06A58BZQd4DJ1TZaOY0uCmolHgFEUEY6xW9VJjAsUZr7WeXdvwqWjTtwkaXk3QK0CsxWwl4fHaGdkCCCBNAyICsa2o4PtC4Br0pIbDP1PiJHNY8OMz5mqnbCkYgsgWWSE4H2rbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Z5425o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DBBC4CED2;
	Thu,  9 Jan 2025 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436283;
	bh=Cgj4SKDnVIxVoAkg16mjvYmaG/UVaegsKkU2/H3f3zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1Z5425o6M21GALwFnyU7b5Z25TxvsbgYTKJzVNP6ZqNqyhfAVzdhv6n6dH7lFj6E
	 +fe8oHbcApI6WhuQmnyj/cdFwCUoZ9ntYi2hAfomY1rJy1tx27kueIg7IN6FN2XiBS
	 OYtwYvfpSHIkqdERgesQaOJXxETl5Gds9yu0gBA1+z6wcsO/N26iKWgFyORMthzcwL
	 xx1/mRoIHr9T4BlnTYWIOrnAGFy9Q8YjGIIzLUl40U8HcQHx1lJapIxy3vSMXtxDyN
	 uLQ9IzwO4gfv22yIeesKCaHE+17D5djicPqqG8oMlhZW4cT4XuD9wOlScjXUVdkdZo
	 1L+KvRpcP74Rg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: add STATX_DIO_READ_ALIGN v3
Date: Thu,  9 Jan 2025 16:24:28 +0100
Message-ID: <20250109-neigen-eisern-3024e1ffbde0@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109083109.1441561-1-hch@lst.de>
References: <20250109083109.1441561-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=brauner@kernel.org; h=from:subject:message-id; bh=Cgj4SKDnVIxVoAkg16mjvYmaG/UVaegsKkU2/H3f3zI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTXvzK5Unc/l+uq7//nars4kk4qeOcdiE8z2dZk72BW+ Kev8JBARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESYoxj+p6sFppiK5Mnn/zNW 1nNy71vllmL4SPmSnmC+qbJUaVE5I8OJwB38mldYtFsZA+rWvb+pIppf8+VygBp78jMFdf0ZVxg B
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 9 Jan 2025 09:31:00 +0100, Christoph Hellwig wrote:
> [I hope that no one gets too annoyed by the rapid resends, but s we're
>  down to comment an man page tweaks I thought I'd stick to the fast pace]
> 
> file systems that write out of place usually require different alignment
> for direct I/O writes than what they can do for reads.  This series tries
> to address this by adding yet another statx field.
> 
> [...]

Applied to the vfs-6.14.statx.dio branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.statx.dio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.statx.dio

[1/5] fs: reformat the statx definition
      https://git.kernel.org/vfs/vfs/c/8fc7e23a9bd8
[2/5] fs: add STATX_DIO_READ_ALIGN
      https://git.kernel.org/vfs/vfs/c/7ed6cbe0f8ca
[3/5] xfs: cleanup xfs_vn_getattr
      https://git.kernel.org/vfs/vfs/c/7e17483c7b15
[4/5] xfs: report the correct read/write dio alignment for reflinked inodes
      https://git.kernel.org/vfs/vfs/c/7422bbd03021
[5/5] xfs: report larger dio alignment for COW inodes
      https://git.kernel.org/vfs/vfs/c/468210ec76e1

