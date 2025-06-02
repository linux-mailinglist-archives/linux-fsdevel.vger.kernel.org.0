Return-Path: <linux-fsdevel+bounces-50360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248EACB2D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8210B16F1C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACFB2343AE;
	Mon,  2 Jun 2025 14:19:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA623372E;
	Mon,  2 Jun 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873953; cv=none; b=Gfi5ZJ5qIzB75awc4lNBYcHfBnh52mZpFLwH0wr18FlOe0OM3OMzRUUjc7y8zIYJxy4aKm5Jy66tkD+4Rpx+C+gZBBR8EsyQqXif1OQMz81a/SAkwVTbkRtD8673tP/DOmg7F8EZTQQngDjbKB8K6tQBX7h5LmXib5pNSoxY918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873953; c=relaxed/simple;
	bh=4E11vaf+KaP/92AGKGJWyssk3PUKD8Kp2pFck3kO4yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJl4SmETbQK5pHteRh7fZJqpKH/J2y0pksyN5sKkXusWr2Wcf/HdMFBvLohIjTCDdPbtgOOk+bamFChNRZLQzfwM3a/O+keTksA6pJDB8ySM10pXBFFOthcjZZ0VaCtME5849b8u6TZs2CDmh5mTJywldAgMmMYtZVI4v6Tn4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D587968C7B; Mon,  2 Jun 2025 16:19:04 +0200 (CEST)
Date: Mon, 2 Jun 2025 16:19:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250602141904.GA21996@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 04:44:51PM +0530, Kundan Kumar wrote:
> Number of writeback contexts
> ===========================
> The plan is to keep the nr_wb_ctx as 1, ensuring default single threaded
> behavior. However, we set the number of writeback contexts equal to
> number of CPUs in the current version. Later we will make it configurable
> using a mount option, allowing filesystems to choose the optimal number
> of writeback contexts.

Well, the proper thing would be to figure out a good default and not
just keep things as-is, no?

> IOPS and throughput
> ===================
> We see significant improvement in IOPS across several filesystem on both
> PMEM and NVMe devices.
> 
> Performance gains:
>   - On PMEM:
> 	Base XFS		: 544 MiB/s
> 	Parallel Writeback XFS	: 1015 MiB/s  (+86%)
> 	Base EXT4		: 536 MiB/s
> 	Parallel Writeback EXT4	: 1047 MiB/s  (+95%)
> 
>   - On NVMe:
> 	Base XFS		: 651 MiB/s
> 	Parallel Writeback XFS	: 808 MiB/s  (+24%)
> 	Base EXT4		: 494 MiB/s
> 	Parallel Writeback EXT4	: 797 MiB/s  (+61%)

What worksload was this?

How many CPU cores did the system have, how many AGs/BGs did the file
systems have?   What SSD/Pmem was this?  Did this change the write
amp as measure by the media writes on the NVMe SSD?

Also I'd be really curious to see numbers on hard drives.

> We also see that there is no increase in filesystem fragmentation
> # of extents:
>   - On XFS (on PMEM):
> 	Base XFS		: 1964
> 	Parallel Writeback XFS	: 1384
> 
>   - On EXT4 (on PMEM):
> 	Base EXT4		: 21
> 	Parallel Writeback EXT4	: 11

How were the number of extents counts given that they look so wildly
different?


