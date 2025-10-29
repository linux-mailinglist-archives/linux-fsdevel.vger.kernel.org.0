Return-Path: <linux-fsdevel+bounces-66000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDFCC179BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D99402506
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998C2D4807;
	Wed, 29 Oct 2025 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0Q21s7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71A2D3EF8;
	Wed, 29 Oct 2025 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698667; cv=none; b=fi1fCXR3yoxCvazCceLmHsxNLSzmi+vAACONtrOnTf9XA1EpyemAz2XYUs31NAB8TrBoVG/AMDfcqEmVQQA63JOHRKOBQL/qjF9TgFP5wj2JrJyKMDtuR+Kmd82owx1bx9IY1hvSiGQYTGMvSu/frUpPrJSXm6noxWNTTTjpsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698667; c=relaxed/simple;
	bh=mrcYTN1pkerWswX+H+zUJiIxjfXhoFb4dZSrMhE08h4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBogwhEOu27IoVgNSvtJR8mlHBDLdVJqtRNd5hK7XHI0AC/sbbUgDGhuskJmuvllCRjRza5McF+j+EADNqkt6nlYL1gfj5WXZ8FxZQsieZuhuMqaxUIs5GMc0u+4mJNEIvF+a4QsS5CWbcS9KFoIf9zRDNTl79kw0qjyKi/13Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0Q21s7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23CCC4CEE7;
	Wed, 29 Oct 2025 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698666;
	bh=mrcYTN1pkerWswX+H+zUJiIxjfXhoFb4dZSrMhE08h4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=a0Q21s7/T2IngHbuWPFlSKMVJpypX4KGqQvsXmJ5O/uoXSvhe7NhCv2FuM1YM7JnW
	 MoHwlOUL+z2hDfjw5I7cukrtQHi8tuvR1gCDgIXsr5Jqj03aSSG4Y9RLhwIg7MTbfP
	 19xlJEao2Bku7YJzLEm3LFskaqNWLX/8qnIdOrDLbd3i9uDpzuTZuc0MkPaD4ZnzOZ
	 Us812qBABajRCqgg5py4FjHN5g7Udw4SD8h2CgZmNahD+KusxOKeeLsFxRYyhrV/Rc
	 HJKCdFuS2IMiCCXH+bhCGZEW1f0SRH4I7EDT1Co6wY2Swb+p8JFOPIdytc00UjHBgz
	 EvGIQidACklrA==
Date: Tue, 28 Oct 2025 17:44:26 -0700
Subject: [PATCH 1/1] iomap: allow NULL swap info bdev when activating swapfile
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu, brauner@kernel.org
Cc: linux-ext4@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

All current users of the iomap swapfile activation mechanism are block
device filesystems.  This means that claim_swapfile will set
swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.

However, in the future there could be fuse+iomap filesystems that are
block device based but don't set s_bdev.  In this case, sis::bdev will
be set to NULL when we enter iomap_swapfile_activate, and we can pick
up a bdev from the first iomap mapping that the filesystem provides.

To make this work robustly, we must explicitly check that each mapping
provides a bdev and that there's no way we can succeed at collecting
swapfile pages without a block device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/swapfile.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 0db77c449467a7..9d9f4e84437df5 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -112,6 +112,13 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
 	if (iomap->flags & IOMAP_F_SHARED)
 		return iomap_swapfile_fail(isi, "has shared extents");
 
+	/* Swapfiles must be backed by a block device */
+	if (!iomap->bdev)
+		return iomap_swapfile_fail(isi, "is not on a block device");
+
+	if (iter->pos == 0 && !isi->sis->bdev)
+		isi->sis->bdev = iomap->bdev;
+
 	/* Only one bdev per swap file. */
 	if (iomap->bdev != isi->sis->bdev)
 		return iomap_swapfile_fail(isi, "outside the main device");
@@ -184,6 +191,16 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 		return -EINVAL;
 	}
 
+	/*
+	 * If this swapfile doesn't have a block device, reject this useless
+	 * swapfile to prevent confusion later on.
+	 */
+	if (sis->bdev == NULL) {
+		pr_warn(
+ "swapon: No block device for swap file but usage pages?!\n");
+		return -EINVAL;
+	}
+
 	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
 	sis->max = isi.nr_pages;
 	sis->pages = isi.nr_pages - 1;


