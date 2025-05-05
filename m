Return-Path: <linux-fsdevel+bounces-48095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F307CAA95E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2C77A5CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E15025C817;
	Mon,  5 May 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s76bOPfY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E0189B8B;
	Mon,  5 May 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455386; cv=none; b=R9V5HyGHNeWJmUSP1XaxkjPt1SEWUmrf9z72TYvs7/DkRKjlh3zmqMp98cwshWcQcQoFtepnAbnoYzgQtjdVprkNZfDc9EErCuHexvFRNd/0jIhOUU92uZbtXs8iAJz4BL0OCX6fMPJ1ejaUDCuzsyqkst6HjDFyBBqDllK/6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455386; c=relaxed/simple;
	bh=CD6uIDxK7PuM4/IKezsMaaIGURgMjXMez6lltVRFv3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlAH9+CPQJMErMtedkew8w2AbCatD3wE9/noQnYmi14nX5Z/iG6p59ATAeCToae2k8dCp29UsC7HQi/cHMTpXlukvpvSsjba5uevoZxkxTtHYeEY3tBBQ4v78sJM8PvjVru91CLd8o7IvzEqE3u+x7hz+qFx1LW6BgAift8613s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s76bOPfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C860C4CEE4;
	Mon,  5 May 2025 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746455386;
	bh=CD6uIDxK7PuM4/IKezsMaaIGURgMjXMez6lltVRFv3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s76bOPfYZwOomTqJoQgcpmX1YDtAmHKEJbY0ysNXij1GtqBx97Zl0E87GV9b+0mDg
	 sYN6vd1GOdlgHX0VhkpZVO7v28jxK0PpVZE4nh5XtGBM/8eoyQxhGxxy5Xz/odn5GV
	 jTOu8ibb2qGgpeOecR3N3XdiOpxDSj8ij1BKjGEoelIa0BXuUwzFa6mIKtdtPxwTYN
	 efpa1YwpPqBh2TbSCKYxdEiLvPt7ORW/D558omfTb2TXPMLGy0BcFQWqwH5QzLs/zy
	 sMYcHohbq/anIdvAaYOqIcMkf6/Gau9wApdBWUEOB0NieDwuqI1jM8qYN5bPmI6YwS
	 V0ZFr/y/4Iqfg==
Date: Mon, 5 May 2025 07:29:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250505142945.GJ1035866@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505132208.GA22182@lst.de>

On Mon, May 05, 2025 at 03:22:08PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 21, 2025 at 10:15:05AM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Add a new attribute flag to statx to determine whether a bdev or a file
> > supports the unmap write zeroes command.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ---
> >  block/bdev.c              | 4 ++++
> >  fs/ext4/inode.c           | 9 ++++++---
> >  include/uapi/linux/stat.h | 1 +
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 4844d1e27b6f..29b0e5feb138 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -1304,6 +1304,10 @@ void bdev_statx(struct path *path, struct kstat *stat,
> >  			queue_atomic_write_unit_max_bytes(bd_queue));
> >  	}
> >  
> > +	if (bdev_write_zeroes_unmap(bdev))
> > +		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
> > +	stat->attributes_mask |= STATX_ATTR_WRITE_ZEROES_UNMAP;
> 
> Hmm, shouldn't this always be set by stat?  But I might just be
> really confused what attributes_mask is, and might in fact have
> misapplied it in past patches of my own..

attributes_mask contains attribute flags known to the filesystem,
whereas attributes contains flags actually set on the file.
"known_attributes" would have been a better name, but that's water under
the bridge. :P

> Also shouldn't the patches to report the flag go into the bdev/ext4
> patches that actually implement the feature for the respective files
> to keep bisectability?

/I/ think so...

--D

