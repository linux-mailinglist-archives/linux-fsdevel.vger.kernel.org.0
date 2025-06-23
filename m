Return-Path: <linux-fsdevel+bounces-52524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AEAAE3D2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB3A188604E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8B23E226;
	Mon, 23 Jun 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7lCO+rk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF0136988;
	Mon, 23 Jun 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675676; cv=none; b=BhS8BEIO5QjEuBOpUlnJsal8F99bZeDOEsyAQj1gwfK/Vh6bjzwsyWAeIh1xcTKZTNltj9ZA9+Bc9f+fFYeupEGrs35YWF6skuoGLyWtGwtXG4ziPPN4/yRP8f5NHSRNHsUbzoSQpGAB0JJMq9c92VOczlijRXgytU8V9BdxvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675676; c=relaxed/simple;
	bh=vaI9JbaFKhhNbfL3EiT6CpfhfHc/XVt+vnuH5ChGQ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1GywFLVOx9r3kaySZWBhhv8QTTfwgSvKuTRBynfqZKl38AG0Mrdtois8Jg3SuedZjPwrgGJ759inLgGvJJl0WKaFH52O45aQjMTOH+k6sYdvpsN6SBZWwTtiVp342wNE7qydsuWSfsXGibepQLEKo9+GP4mb+bcZYnGzgWqT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7lCO+rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F7C4CEF1;
	Mon, 23 Jun 2025 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750675675;
	bh=vaI9JbaFKhhNbfL3EiT6CpfhfHc/XVt+vnuH5ChGQ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7lCO+rkZfha5OkwQI2AxXKyczCj80cT2NHRXpoSBK/KFuE980LACZ966Ktf6Frhb
	 D6JFf5l3uNV8TKf1Lso9HNIMgZYBTJy0VmCqIo5YzPD0T4E5RzsEraPeo1TERBOiBe
	 uTcVgBIvskm1u0sYg/4+VX4rrzPYKzSRXO7u4sDOl73xVsFORCeTXWIjRa9NZtBON6
	 CzWMgaj53gWBJddS72rFl/tzbBqMWTppxR7smR+HB+TjXjR7CgNZFdKUxw5C/CpMeO
	 wKiwRU22qiMQK8S/pnZp/IuiwheMKF18FwVsFxs7jiYypTApeeVXa4pJCtBC5aKeL+
	 UCx+ilau5wxnA==
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 0/9] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Date: Mon, 23 Jun 2025 12:46:54 +0200
Message-ID: <20250623-woanders-allabendlich-f87ae2d9c704@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4373; i=brauner@kernel.org; h=from:subject:message-id; bh=OinsHwHlIaW6oGbcffOJfdJKYbQ2uEC1ci1r6m7GeH0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREGix/nvp5ld7fB65PPklO87v6O/f5D4/KcwUn71wJ5 7Vb5xff01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRD18YGR4VrfgeVsV69OJK J4uDihukLdR8nao/PFXYPlvhrhG3bQojw4QTkzVm7196Yef0s6x+i0yz3+/Xk/fbUVW0+pff25N fPDgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 19:17:57 +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Rebase codes on 6.16-rc2.
>  - Use max_{hw|user}_wzeroes_unmap_sectors queue limits instead of
>    BLK_FEAT_WRITE_ZEROES_UNMAP feature to represent the status of the
>    unmap write zeroes operation as Christoph and Darrick suggested. This
>    redoes the first 5 patches, so remove all the reviewed-by tags,
>    please review them again.
>  - Simplify the description of FALLOC_FL_WRITE_ZEROES in patch 06 as
>    Darrick suggested.
>  - Revise the check order of FALLOC_FL_WRITE_ZEROES in patch 08 as
>    Christoph suggested.
> Changes since RFC v4:
>  - Rebase codes on 6.16-rc1.
>  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
>    interface to RW mode. User can disable the unmap write zeroes
>    operation by writing '0' to it when the operation is slow.
>  - Modify the documentation of write_zeroes_unmap sysfs interface as
>    Martin suggested.
>  - Remove the statx interface.
>  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
>    if the block device does not enable the unmap write zeroes operation,
>    it should return -EOPNOTSUPP.
> Changes sicne RFC v3:
>  - Rebase codes on 6.15-rc2.
>  - Add a note in patch 1 to indicate that the unmap write zeros command
>    is not always guaranteed as Christoph suggested.
>  - Rename bdev_unmap_write_zeroes() helper and move it to patch 1 as
>    Christoph suggested.
>  - Introduce a new statx attribute flag STATX_ATTR_WRITE_ZEROES_UNMAP as
>    Christoph and Christian suggested.
>  - Exchange the order of the two patches that modified
>    blkdev_fallocate() as Christoph suggested.
> Changes since RFC v2:
>  - Rebase codes on next-20250314.
>  - Add support for nvme multipath.
>  - Add support for NVMeT with block device backing.
>  - Clear FALLOC_FL_WRITE_ZEROES if dm clear
>    limits->max_write_zeroes_sectors.
>  - Complement the counterpart userspace tools(util-linux and xfs_io)
>    and tests(blktests and xfstests), please see below for details.
> Changes since RFC v1:
>  - Switch to add a new write zeroes operation, FALLOC_FL_WRITE_ZEROES,
>    in fallocate, instead of just adding a supported flag to
>    FALLOC_FL_ZERO_RANGE.
>  - Introduce a new flag BLK_FEAT_WRITE_ZEROES_UNMAP to the block
>    device's queue limit features, and implement it on SCSI sd driver,
>    NVMe SSD driver and dm driver.
>  - Implement FALLOC_FL_WRITE_ZEROES on both the ext4 filesystem and
>    block device (bdev).
> 
> [...]

If needed, the branch can be declared stable and thus be used as base
for other work.

---

Applied to the vfs-6.17.fallocate branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.fallocate branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.fallocate

[1/9] block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits
      https://git.kernel.org/vfs/vfs/c/2695a9b086fd
[2/9] nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit
      https://git.kernel.org/vfs/vfs/c/bf07c1180194
[3/9] nvmet: set WZDS and DRB if device enables unmap write zeroes operation
      https://git.kernel.org/vfs/vfs/c/a6c7ab5adcba
[4/9] scsi: sd: set max_hw_wzeroes_unmap_sectors if device supports SD_ZERO_*_UNMAP
      https://git.kernel.org/vfs/vfs/c/92372ed1cc88
[5/9] dm: clear unmap write zeroes limits when disabling write zeroes
      https://git.kernel.org/vfs/vfs/c/e383d550e716
[6/9] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
      https://git.kernel.org/vfs/vfs/c/1ed1b5df86ec
[7/9] block: factor out common part in blkdev_fallocate()
      https://git.kernel.org/vfs/vfs/c/96433508c8c0
[8/9] block: add FALLOC_FL_WRITE_ZEROES support
      https://git.kernel.org/vfs/vfs/c/2b4e5f9b3eb9
[9/9] ext4: add FALLOC_FL_WRITE_ZEROES support
      https://git.kernel.org/vfs/vfs/c/51954e469396

