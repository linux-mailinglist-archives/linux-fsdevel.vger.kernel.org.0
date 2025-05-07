Return-Path: <linux-fsdevel+bounces-48427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B975CAAED8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 23:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E69501D29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5F28FFE5;
	Wed,  7 May 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou5UvFB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2287202F83;
	Wed,  7 May 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651792; cv=none; b=tSgSR3YHPOkbeE9L15qP7uQEIWMX73s7j/CRnykYic2NibDPGKUDZTkzHfiIcsAQ0+emMv3i8NWmGkiyQSeFejcnnRPZvIjRaWhFxehtTFYDE4Oz9U7E1mtAgXJD8gk2RWnnoFlSJtXFNmBi1kvBhjHuTUL/U7+qUMySzyXro5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651792; c=relaxed/simple;
	bh=cnPOQ8rH8mGEWg2SZAMmFPn+K66GqaSykHvHWUjRJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwQ9scGayCQ05N3YqjBmMMRM0npvbcH7vLMMxiXOJ7F7KX0wknWPeBKkre1f5TqD0vnleB15iBTXTXwtewWa1TmgvlQaCe2r2105qeceG3seMu9CLHROnRwXlY3RWJ4nH5m/UXdjSg9aAVIcbrDfv0nZD4r/Nq2zMciBGCyczH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou5UvFB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59BAC4CEE2;
	Wed,  7 May 2025 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746651792;
	bh=cnPOQ8rH8mGEWg2SZAMmFPn+K66GqaSykHvHWUjRJFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ou5UvFB7TRZFqaxnYiEakdi8Tv4V4TzoEj9Wbs7Q232VF867LOvRSZU+HZuD0Bq29
	 6CsCTPAn0pECDaosSJX8x976KW3ktLd9AEIM0HbZDqa6j9FdJY0JVbrPH5Nv3bO1hF
	 iIRu+OKZ1opelRfc+PFgGG2aRNfJhh4De1IHrOez/LdSHTTOSeQKEui3LTnMMeRTT9
	 W+5W3K5rrPfVhLUgD3gPmbJZPXu0JaLwoj23F/peyg6pNFb6IhrHsA/7+Eet9shIt4
	 Sng0fra5pNs4VfCOHaFQ+hSm5RXYO+syELa8jv0hYssg/oKu0kM6h7bFr8uzfaXdN3
	 ajieBlH8ExtxQ==
Date: Wed, 7 May 2025 14:03:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250507210310.GG25675@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
 <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
 <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
 <20250506121102.GA21905@lst.de>
 <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>

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
> 
> Therefore, I think that the current point of
> STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
> be to just indicate whether a bdev or file supports the unmap write zero
> command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
> use standard SCSI and NVMe storage devices, and the
> STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
> that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
> fallocate(FALLOC_FL_WRITE_ZEROES) immediately.
> 
> Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
> FALLOC_FL_WRITE_ZEROES consistent, which means
> fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
> device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?
> 
> If so, I'd suggested we need to:
> 1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
>    existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
>    statx flag seems useless.
> 2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
>    users to adjust the block device's support state according to the
>    real situation.

Sounds fine to me... ;)

--D

> Thanks,
> Yi.
> 
> 

