Return-Path: <linux-fsdevel+bounces-18459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05E8B927B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD0B22152
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 23:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7FF16C440;
	Wed,  1 May 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3vbD+96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39016ABEA;
	Wed,  1 May 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714607120; cv=none; b=p4fY7CXHnFWcLuzUsdj0d+WQkL1cfnrC7lwISq7dUtDzU3AkyH6Xd8+PcgELcry/QtygutpXJ6xJh58Hxl/DY0+jRLUniILRahsvtBW66xDiKOCJ2dBvuWv1D/KxiikzoGrYm+JDZYngBK4+KQ1WrV2rYNRXE8nq81dswNO7hxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714607120; c=relaxed/simple;
	bh=JqsnPMx+K0Fb9o3uuuX18tWIg4pXD/BhCsys1itl9Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOFuNSetxE6Sm9AFGw27MyHtqDBWyitB+NXoZjpUFFm4Dch8fjyofNlYSBSm5eIqlud1KKY2KnIOXy/BxYkKhQ6Vp9kVE2gieXLjIK1CQoQWDdj3naOeLFRfKGAZgf8cPjNiwWVcfJGeqffSX1jNlzcrg2JE4GLxT2TnX3PDzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3vbD+96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8313CC072AA;
	Wed,  1 May 2024 23:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714607119;
	bh=JqsnPMx+K0Fb9o3uuuX18tWIg4pXD/BhCsys1itl9Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3vbD+96i3eyTiifGVE6VmejV/oPGXqx532ALF6Xh/weAd4m/qsVPpkdFNKX+9qpt
	 J9ETkVfp3+juMZXflg+QajMTSmFW/C+a2xvn6l6/sXrSprM8vLpFIfT2Tad+rsNHta
	 rnhaGd5+AVJF0WBU7uPoMkTKibHSOdmkQMkMAcOZEqDeifEp41R5L1wt909qIZT/IB
	 yf4HTde0DJKO2aMdDF94lXs61e0LtIPazmBGTs7F4WR1JzOF7/PJHThjF7Ty1HoKeG
	 Zk1x4JqziNdAz5ED1Tvqc4JRgHjgAN3yHvbFxeWFAmRafqrh87/A64KsKYhPm8VJ06
	 7VwR+oQDHLzQA==
Date: Wed, 1 May 2024 16:45:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 10/21] xfs: Update xfs_is_falloc_aligned() mask for
 forcealign
Message-ID: <20240501234518.GO360919@frogsfrogsfrogs>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-11-john.g.garry@oracle.com>
 <ZjGAN8g3yqH01g1w@dread.disaster.area>
 <33700d9d-08d3-4fad-8ca4-e6beb3529bcb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33700d9d-08d3-4fad-8ca4-e6beb3529bcb@oracle.com>

On Wed, May 01, 2024 at 11:48:59AM +0100, John Garry wrote:
> On 01/05/2024 00:35, Dave Chinner wrote:
> > >   	return !((pos | len) & mask);
> > I think this whole function needs to be rewritten so that
> > non-power-of-2 extent sizes are supported on both devices properly.
> > 
> > 	xfs_extlen_t	fsbs = 1;
> > 	u64		bytes;
> > 	u32		mod;
> > 
> > 	if (xfs_inode_has_forcealign(ip))
> > 		fsbs = ip->i_extsize;
> > 	else if (XFS_IS_REALTIME_INODE(ip))
> > 		fsbs = mp->m_sb.sb_rextsize;
> > 
> > 	bytes = XFS_FSB_TO_B(mp, fsbs);
> > 	if (is_power_of_2(fsbs))
> > 		return !((pos | len) & (bytes - 1));
> > 
> > 	div_u64_rem(pos, bytes, &mod);
> > 	if (mod)
> > 		return false;
> > 	div_u64_rem(len, bytes, &mod);
> > 	return mod == 0;
> 
> ok, but I still have a doubt about non-power-of-2 forcealign extsize
> support.

The trouble is, non-power-of-2 extent size hints are supported for
regular and realtime files for funny cases like trying to align
allocations to RAID stripes.  I think it would be hard to drop support
for this, given that means that old filesystems can't ever get upgraded
to forcealign.

--D

> Thanks,
> John
> 

