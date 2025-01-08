Return-Path: <linux-fsdevel+bounces-38665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985AA0634D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 18:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE45167CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC4200116;
	Wed,  8 Jan 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3Bm7yv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5C1FCFE7;
	Wed,  8 Jan 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357137; cv=none; b=FvDxaoEddCvyZ3sooK7li5uuda7uvo7MvZAhYKJxqF6el41qjgonA6najJ8r4453BxwA95REGTpATrRVQ3iuidiaS++fNv/5ylklnPSV19VaIo/lsThq8exDmlsMOymGxcoSJVG5tkeenKe5tuh8DXoV5C5eUlFFLRVHoEebj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357137; c=relaxed/simple;
	bh=iU0vRWg45xIZ9U8b9iQJRAK8MWydgw5cleeIbYjRAUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as+V+1Qg/3DWQ4OPGuflI92WnRqkH/WzOhRrXcs5UiAhgLAZNiPqoEhaQu1n+Vsht+AgBhz+pTyGFz75kqCigGONzyO8UpPO/Bud0Jh9HtN4NGRhi/ME22yBeydkKXM8YMH+O+ckU2Y8/w3u8RZZLrPHbc4CiPq/hNSRJ5I6634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3Bm7yv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCDC4CED3;
	Wed,  8 Jan 2025 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736357137;
	bh=iU0vRWg45xIZ9U8b9iQJRAK8MWydgw5cleeIbYjRAUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3Bm7yv41a3s3i3vYn8DV7ocWXE1/NPae+aUdux0nMxlsjLaIH/uSIJGsYS8gFcyd
	 xRE6Bcj9tgwnAoVStQG4qsp537wJ8ELMMz54LCaiIZ1NVkhhbPtbODSQUKDIyKEFxF
	 hTzTvo7s7anxFYhwu/8V1lyEtaoJqXTKZfFw1uqG8o22KYlwb+RFcRBkQ2tPD9/CBp
	 Gixun+X0xysKmUYLigsAQucjIusHPJpWblx6TCbFOyS71LY4B9j0Y7mdDuDMDaXaQw
	 REwoTu1spIMa5Xh7sXJqogYxqABBUp/DKloyG4fGLD8SSMtrh1E43aoxd3w296iXgs
	 HqxiJhp5r62Jg==
Date: Wed, 8 Jan 2025 09:25:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/5] xfs: report larger dio alignment for COW inodes
Message-ID: <20250108172536.GG1306365@frogsfrogsfrogs>
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-6-hch@lst.de>
 <32a8102c-2243-4cc0-b35f-5be2d36ffd98@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a8102c-2243-4cc0-b35f-5be2d36ffd98@oracle.com>

On Wed, Jan 08, 2025 at 10:11:27AM +0000, John Garry wrote:
> On 08/01/2025 08:55, Christoph Hellwig wrote:
> > For I/O to reflinked blocks we always need to write an entire new file
> > system block, and the code enforces the file system block alignment for
> > the entire file if it has any reflinked blocks.  Mirror the larger
> > value reported in the statx in the dio_offset_align in the xfs-specific
> > XFS_IOC_DIOINFO ioctl for the same reason.
> > 
> > Don't bother adding a new field for the read alignment to this legacy
> > ioctl as all new users should use statx instead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   fs/xfs/xfs_ioctl.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index 0789c18aaa18..20f3cf5391c6 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1204,7 +1204,16 @@ xfs_file_ioctl(
> >   		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> >   		struct dioattr		da;
> > -		da.d_mem =  da.d_miniosz = target->bt_logical_sectorsize;
> > +		da.d_mem = target->bt_logical_sectorsize;
> > +
> > +		/*
> > +		 * See xfs_report_dioalign() why report a potential larger than
> > +		 * sector sizevalue here for COW inodes.
> 
> nit: sizevalue

The sentence reads oddly to me; how about:

"See xfs_report_dioalign() for an explanation about why we report a
value larger than the sector size for COW inodes."?

The code change looks ok though.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> > +		 */
> > +		if (xfs_is_cow_inode(ip))
> > +			da.d_miniosz = xfs_inode_alloc_unitsize(ip);
> > +		else
> > +			da.d_miniosz = target->bt_logical_sectorsize;
> >   		da.d_maxiosz = INT_MAX & ~(da.d_miniosz - 1);
> >   		if (copy_to_user(arg, &da, sizeof(da)))
> 
> 

