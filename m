Return-Path: <linux-fsdevel+bounces-53905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC2AF8E17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9567B1E27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C02868B2;
	Fri,  4 Jul 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLpy79R3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E1328AE4;
	Fri,  4 Jul 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618400; cv=none; b=DO+4XH/igW6zNQMj0MVkKegBUBQ5eHX2kwSpIIBpWYNCR67Na0tpeQqzLdMOyHyp2/Cr3r6v7DDQ+HotVFFZE3hpUxgCrku98eRVEvUZK+O28N7aIXDISxzOUUmPW177vHnnVrY0+lL5+Vwf01+U0pLv9VsHbtzdttH9xpMVTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618400; c=relaxed/simple;
	bh=FHas3OLzhcWmJla/w9SVAWfRsC/N5brO1Le2ihalCNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN2UI3xyCfwRG2Zl3GjjqEP0gUD97Lrde26YuFL2ocVGOzIcKvc4MrsbLy7pOFTOE+SYnfxnbQwcJ/byijjLYkVgyMtM4bvdb/ZaPjiHX6cF53fbz1/XHoGaNUhohKRw6JpXr+sywUrNN/+CZ2gCEdKBEZBuydk+4csAmU3hG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLpy79R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EA7C4CEF0;
	Fri,  4 Jul 2025 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751618400;
	bh=FHas3OLzhcWmJla/w9SVAWfRsC/N5brO1Le2ihalCNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLpy79R3WoowQ0dde0FpFT1YyHsXsurqva+SkoBcww5fjPVnQMcwqe87L2wtjyLYi
	 kRKqWJIQ81p4a1f0xNgpRmdmn+OPlPkQk/4+3lz4NrJRi0wbmnDt4pjvgXFACOvZxO
	 qU9E5LKN5/hna1bw+wpVR2YB99mwlJCTB2beguJ1mHivp02SKA4At/U4wBW5k3iT/Q
	 u3HMCjJxxvd2r71zcnuKhwU/Z06IvtD7wFREJ9CXS/1miJCbu6oYZeK5DrvOvTrTgE
	 IHzvXhhXfrV+PFyTdnHzAjREeo0FCEO0Q5nKDCaILrTwFadudwtNVY/apMjWmKyCd5
	 QDeadiD91wJeA==
Date: Fri, 4 Jul 2025 10:39:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, 
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com, 
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, martin.petersen@oracle.com, 
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 0/9] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Message-ID: <20250704-gemein-addieren-62ad4d210c70@brauner>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <20250623-woanders-allabendlich-f87ae2d9c704@brauner>
 <99010bfd-c968-49c7-b62b-c72b38722c1b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99010bfd-c968-49c7-b62b-c72b38722c1b@huaweicloud.com>

On Thu, Jul 03, 2025 at 11:35:41AM +0800, Zhang Yi wrote:
> On 2025/6/23 18:46, Christian Brauner wrote:
> > On Thu, 19 Jun 2025 19:17:57 +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Changes since v1:
> >>  - Rebase codes on 6.16-rc2.
> >>  - Use max_{hw|user}_wzeroes_unmap_sectors queue limits instead of
> >>    BLK_FEAT_WRITE_ZEROES_UNMAP feature to represent the status of the
> >>    unmap write zeroes operation as Christoph and Darrick suggested. This
> >>    redoes the first 5 patches, so remove all the reviewed-by tags,
> >>    please review them again.
> >>  - Simplify the description of FALLOC_FL_WRITE_ZEROES in patch 06 as
> >>    Darrick suggested.
> >>  - Revise the check order of FALLOC_FL_WRITE_ZEROES in patch 08 as
> >>    Christoph suggested.
> >> Changes since RFC v4:
> >>  - Rebase codes on 6.16-rc1.
> >>  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
> >>    interface to RW mode. User can disable the unmap write zeroes
> >>    operation by writing '0' to it when the operation is slow.
> >>  - Modify the documentation of write_zeroes_unmap sysfs interface as
> >>    Martin suggested.
> >>  - Remove the statx interface.
> >>  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
> >>    if the block device does not enable the unmap write zeroes operation,
> >>    it should return -EOPNOTSUPP.
> >> Changes sicne RFC v3:
> >>  - Rebase codes on 6.15-rc2.
> >>  - Add a note in patch 1 to indicate that the unmap write zeros command
> >>    is not always guaranteed as Christoph suggested.
> >>  - Rename bdev_unmap_write_zeroes() helper and move it to patch 1 as
> >>    Christoph suggested.
> >>  - Introduce a new statx attribute flag STATX_ATTR_WRITE_ZEROES_UNMAP as
> >>    Christoph and Christian suggested.
> >>  - Exchange the order of the two patches that modified
> >>    blkdev_fallocate() as Christoph suggested.
> >> Changes since RFC v2:
> >>  - Rebase codes on next-20250314.
> >>  - Add support for nvme multipath.
> >>  - Add support for NVMeT with block device backing.
> >>  - Clear FALLOC_FL_WRITE_ZEROES if dm clear
> >>    limits->max_write_zeroes_sectors.
> >>  - Complement the counterpart userspace tools(util-linux and xfs_io)
> >>    and tests(blktests and xfstests), please see below for details.
> >> Changes since RFC v1:
> >>  - Switch to add a new write zeroes operation, FALLOC_FL_WRITE_ZEROES,
> >>    in fallocate, instead of just adding a supported flag to
> >>    FALLOC_FL_ZERO_RANGE.
> >>  - Introduce a new flag BLK_FEAT_WRITE_ZEROES_UNMAP to the block
> >>    device's queue limit features, and implement it on SCSI sd driver,
> >>    NVMe SSD driver and dm driver.
> >>  - Implement FALLOC_FL_WRITE_ZEROES on both the ext4 filesystem and
> >>    block device (bdev).
> >>
> >> [...]
> > 
> > If needed, the branch can be declared stable and thus be used as base
> > for other work.
> > 
> > ---
> > 
> > Applied to the vfs-6.17.fallocate branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.17.fallocate branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.17.fallocate
> 
> Hi Christian,
> 
> I noticed that this patch series doesn't appear to be merged into this
> branch. Just wondering if it might have been missed?

Dammit, my script missed to push the branch. Fixed now. Thanks for
checking!

