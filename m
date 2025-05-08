Return-Path: <linux-fsdevel+bounces-48441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C1AAF289
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D359B3B00D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3F235BF4;
	Thu,  8 May 2025 05:01:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041623498F;
	Thu,  8 May 2025 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680516; cv=none; b=s5bCJSvaf8dr9oPPhvA+WuHfEHDJ5WoWefJAErZl/6ldl64Vu35D5VgECEJPy/mq1Wf6pW8uk3lPpC7Xo9boiYYRMe14z6vS7c4AQn9AW0Nuq04t2+Q/4rh6UJqBLUv3wdit0gKB7nWj9bFQ/rtJC1rn+kDa7NTXCOj8S3lbtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680516; c=relaxed/simple;
	bh=AwhhZ2wBTFfk+q7m2bEqg8jP8mcot7mr9qk1rjjHN4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUsJOTlO75FlF4utm5B09QRhU067zUvCUsJuxGHeBAx7xO6k8tbR2QRopwRT/VPaVJLJAwjwwD+eHvEPGJdG+EfrZ/JPJ9amV20oihCmIFSOcqADwwTmPcQ4yiMBeVRihWflV9vWbl5LS3wtADw8tzrA536OO8RfKLi/9Q4Acyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F69868B05; Thu,  8 May 2025 07:01:47 +0200 (CEST)
Date: Thu, 8 May 2025 07:01:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250508050147.GA26916@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com> <20250506043907.GA27061@lst.de> <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com> <20250506121102.GA21905@lst.de> <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 03:33:23PM +0800, Zhang Yi wrote:
> On 2025/5/6 20:11, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
> >> Sorry, but I don't understand your suggestion. The
> >> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
> >> and the block device that under the specified file support unmap write
> >> zeroes commoand. It does not reflect whether the bdev and the
> >> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
> >> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
> >> commoand now, users simply refer to this attribute flag to determine
> >> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
> >> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
> >> have strong relations, why do you suggested to put this into the ext4
> >> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?
> > 
> > So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?
> 
> My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
> only bdev or files where bdev_unmap_write_zeroes() returns true. In
> other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
> are not consistent, they are two independent features. Even if some
> devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
> allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
> devices and drivers currently cannot reliably ascertain whether they
> support the unmap write zero command; however, certain devices, such as
> specific cloud storage devices, do support it. Users of these devices
> may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
> process.

What are those "cloud storage devices" where you set it reliably,
i.e.g what drivers?

> Therefore, I think that the current point of
> STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
> be to just indicate whether a bdev or file supports the unmap write zero
> command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
> use standard SCSI and NVMe storage devices, and the
> STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
> that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
> fallocate(FALLOC_FL_WRITE_ZEROES) immediately.

That's breaking the abstracton again.  An attribute must say something
about the specific file, not about some underlying semi-related feature.

> Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
> FALLOC_FL_WRITE_ZEROES consistent, which means
> fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
> device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?

Not sure where the block device comes from here, both of these operate
on a file.

> If so, I'd suggested we need to:
> 1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
>    existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
>    statx flag seems useless.

Yes, that was my inital thought.

> 2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
>    users to adjust the block device's support state according to the
>    real situation.

No, it's a feature and not a flag.


