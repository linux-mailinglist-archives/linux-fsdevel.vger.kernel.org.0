Return-Path: <linux-fsdevel+bounces-27595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1B962AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481821C22A7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D691A0B15;
	Wed, 28 Aug 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVT0pES8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E117C9AF;
	Wed, 28 Aug 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857150; cv=none; b=HyMqtJqtdrYkf0iXKlphl2yELuv8rN7s8rU3zc5fnPld/DcqW4rPFHx6/7atG/V1Hbn/4FwBM28F7rbTM6dFM8ycMZQU77mcWbQp/NKXYYksYuccPQIs/KWd5hkTkDIXwvG4YZyJd5o/VFPSEQQgvrPuNdsgsWhWUdjhLKHuUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857150; c=relaxed/simple;
	bh=UpzTDQbTDM/duQdOjIrQF0JtfhbJsdmFGxYvGryuTxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIpmsGNBiQo6emj5a688ScF+iQTIsoE0M2lbsogk690/DD5RKWP7IJZKNNb3+jtWHu/DThgfNhcm8ub6DJY9YVW189S806q6TyRy67O16OpX7qSiwBjoipBh7e8kJJCf07Pe5rH1aAdP6XFWtYstsChW4FFKLX4guxupIBxIP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVT0pES8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EABC4CEDF;
	Wed, 28 Aug 2024 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724857149;
	bh=UpzTDQbTDM/duQdOjIrQF0JtfhbJsdmFGxYvGryuTxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVT0pES8N4PTFkiCAwxNpO3Cg29t7OPWu7yjC+pA3SXVg8PJqiXGwGVa+bnL7dJs4
	 DZIQV+K9/5/NPv3UxO1xcCZ4XoDV0gZQYFRwcxdB36iPowOcmtu24JEevYL9yLw8nv
	 mcuhQy/UCzoXHn4eZJWxbDn3ZQSjIiC8BcMHzNbyuBr0pu3BIW4QvGSyWv4BpBvSY/
	 SgtK6QW0dX5i0VGoej1CCMc9Ux4/UrqYgxnlEdP3x/2Rr32LgYzX/r+1koyJA+37up
	 odG8/YtATU6VO7ij/D/6QUuJGrjnXR4jXXR4kP8MwzetNZ97WOzYocUpTctL35PdHz
	 lCMEd+lAg13Mg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Subject: Re: [PATCH 1/6] block: remove checks for FALLOC_FL_NO_HIDE_STALE
Date: Wed, 28 Aug 2024 16:58:47 +0200
Message-ID: <20240828-bauen-leben-c8bb953a9fae@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827065123.1762168-2-hch@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=brauner@kernel.org; h=from:subject:message-id; bh=UpzTDQbTDM/duQdOjIrQF0JtfhbJsdmFGxYvGryuTxk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdtzZZ+fPJvXuvTxXsXqpguebWGw9R9oAtW/l4V36Ks Ll1cOGcvo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJxPIwMky/cuDUxf32EV5h 81f+XvrK+cvRPBM1C+HchQonb5r2qZ5h+J/4+1/Li76oKBEHjlsCV5Z4HZ1aE7f+M4PH3J9/bS8 arOEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 08:50:45 +0200, Christoph Hellwig wrote:
> While the FALLOC_FL_NO_HIDE_STALE value has been registered, it has
> always been rejected by vfs_fallocate before making it into
> blkdev_fallocate because it isn't in the supported mask.
> 
> 

Applied to the vfs.fallocate branch of the vfs/vfs.git tree.
Patches in the vfs.fallocate branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fallocate

[1/6] block: remove checks for FALLOC_FL_NO_HIDE_STALE
      https://git.kernel.org/vfs/vfs/c/a24dfa515642
[2/6] ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
      https://git.kernel.org/vfs/vfs/c/c5a8e5423301
[3/6] fs: sort out the fallocate mode vs flag mess
      https://git.kernel.org/vfs/vfs/c/2f6369068139
[4/6] xfs: call xfs_flush_unmap_range from xfs_free_file_space
      https://git.kernel.org/vfs/vfs/c/2764727be269
[5/6] xfs: move the xfs_is_always_cow_inode check into xfs_alloc_file_space
      https://git.kernel.org/vfs/vfs/c/12206b1c423b
[6/6] xfs: refactor xfs_file_fallocate
      https://git.kernel.org/vfs/vfs/c/a0c3802f87a2

