Return-Path: <linux-fsdevel+bounces-34783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5D9C8B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188A5B248B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EE81FAC4A;
	Thu, 14 Nov 2024 12:49:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993321F8900;
	Thu, 14 Nov 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588590; cv=none; b=dSoDI/gzQ74sx3ikktAN6zST6m6a7gbv9Yt9sAox1PSImwFzEmM/8yL/PLyqHR00L5sQvX52cyuOvKC6Ow7Es9xrwwqVif/dyEpyVF2gNP1aEAW6MQ3JQu6A4rVh47YW3dbUtSz6b+6V7LOFFL2GNbr0Wulvcny48ZyRvuOP0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588590; c=relaxed/simple;
	bh=k3bq9txkWb0lZ8GyLDb0v5XOIzhc50LCc0dXpD/E+Lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqkCmfmHsMp0VfmOsvUfLa16qqJuh+Q7uXuBo5Ds9+uJqjhZUBRsTg8yA6MPcYwzDa9YGQavb5ZtY+Q0rjgpHhvt+oeqiZb96QnyV/c2OdvUELI4XeC2V4c6IZhnnWlRBj+CdlHkmeRgt04F8ErGLVlS3Ln2yb92X15kBCVgHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xq0Lt4tbQzQt1b;
	Thu, 14 Nov 2024 20:48:22 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 98CD9140393;
	Thu, 14 Nov 2024 20:49:38 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 20:49:38 +0800
Date: Thu, 14 Nov 2024 20:48:21 +0800
From: Long Li <leo.lilong@huawei.com>
To: John Garry <john.g.garry@oracle.com>, Dave Chinner <david@fromorbit.com>
CC: Ritesh Harjani <ritesh.list@gmail.com>, <chandan.babu@oracle.com>,
	<djwong@kernel.org>, <dchinner@redhat.com>, <hch@lst.de>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <catherine.hoang@oracle.com>,
	<martin.petersen@oracle.com>
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZzXxlf6RWeX3e-3x@localhost.localdomain>
References: <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
 <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
 <ZuoCafOAVqSN6AIK@dread.disaster.area>
 <1394ceeb-ce8c-4d0f-aec8-ba93bf1afb90@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1394ceeb-ce8c-4d0f-aec8-ba93bf1afb90@oracle.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Wed, Sep 18, 2024 at 11:12:47AM +0100, John Garry wrote:
> On 17/09/2024 23:27, Dave Chinner wrote:
> > > # xfs_bmap -vvp  mnt/file
> > > mnt/file:
> > > EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> > >    0: [0..15]:         384..399          0 (384..399)          16 010000
> > >    1: [16..31]:        400..415          0 (400..415)          16 000000
> > >    2: [32..127]:       416..511          0 (416..511)          96 010000
> > >    3: [128..255]:      256..383          0 (256..383)         128 000000
> > > FLAG Values:
> > >     0010000 Unwritten preallocated extent
> > > 
> > > Here we have unaligned extents wrt extsize.
> > > 
> > > The sub-alloc unit zeroing would solve that - is that what you would still
> > > advocate (to solve that issue)?
> > Yes, I thought that was already implemented for force-align with the
> > DIO code via the extsize zero-around changes in the iomap code. Why
> > isn't that zero-around code ensuring the correct extent layout here?
> 
> I just have not included the extsize zero-around changes here. They were
> just grouped with the atomic writes support, as they were added specifically
> for the atomic writes support. Indeed - to me at least - it is strange that
> the DIO code changes are required for XFS forcealign implementation. And,
> even if we use extsize zero-around changes for DIO path, what about buffered
> IO?


I've been reviewing and testing the XFS atomic write patch series. Since
there haven't been any new responses to the previous discussions on this
issue, I'd like to inquire about the buffered IO problem with force-aligned
files, which is a scenario we might encounter.

Consider a case where the file supports force-alignment with a 64K extent size,
and the system page size is 4K. Take the following commands as an example:

xfs_io  -c "pwrite 64k 64k" mnt/file
xfs_io  -c "pwrite 8k 8k" mnt/file

If unaligned unwritten extents are not permitted, we need to zero out the
sub-allocation units for ranges [0, 8K] and [16K, 64K] to prevent stale
data. While this can be handled relatively easily in direct I/O scenarios,
it presents significant challenges in buffered I/O operations. The main
difficulty arises because the extent size (64K) is larger than the page
size (4K), and our current code base has substantial limitations in handling
such cases.

Any thoughts on this?

Thanks,
Long Li

> 
> BTW, I still have concern with this extsize zero-around change which I was
> making:
> 
> xfs_iomap_write_unwritten()
> {
> 	unsigned int rounding;
> 
> 	/* when converting anything unwritten, we must be spanning an 	alloc unit,
> so round up/down */
> 	if (rounding > 1) {
> 		offset_fsb = rounddown(rounding);
> 		count_fsb = roundup(rounding);
> 	}
> 
> 	...
> 	do {
> 		xfs_bmapi_write();
> 		...
> 		xfs_trans_commit();
> 	} while ();
> }
> 
> As mentioned elsewhere, it's a bit of a bodge (to do this rounding).
> 
> > 
> > > > FWIW, I also understand things are different if we are doing 128kB
> > > > atomic writes on 16kB force aligned files. However, in this
> > > > situation we are treating the 128kB atomic IO as eight individual
> > > > 16kB atomic IOs that are physically contiguous.
> > > Yes, if 16kB force aligned, userspace can only issue 16KB atomic writes.
> > Right, but the eventual goal (given the statx parameters) is to be
> > able to do 8x16kB sequential atomic writes as a single 128kB IO, yes?
> 
> No, if atomic write unit max is 16KB, then userspace can only issue a single
> 16KB atomic write.
> 
> However, some things to consider:
> a. the block layer may merge those 16KB atomic writes
> b. userspace may also merge 16KB atomic writes and issue a larger atomic
> write (if atomic write unit max is > 16KB)
> 
> I had been wondering if there is any value in a lib for helping with b.
> 
> > 
> > > > > > Again, this is different to the traditional RT file behaviour - it
> > > > > > can use unwritten extents for sub-alloc-unit alignment unmaps
> > > > > > because the RT device can align file offset to any physical offset,
> > > > > > and issue unaligned sector sized IO without any restrictions. Forced
> > > > > > alignment does not have this freedom, and when we extend forced
> > > > > > alignment to RT files, it will not have the freedom to use
> > > > > > unwritten extents for sub-alloc-unit unmapping, either.
> > > > > > 
> > > > > So how do you think that we should actually implement
> > > > > xfs_itruncate_extents_flags() properly for forcealign? Would it simply be
> > > > > like:
> > > > > 
> > > > > --- a/fs/xfs/xfs_inode.c
> > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > @@ -1050,7 +1050,7 @@ xfs_itruncate_extents_flags(
> > > > >                   WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
> > > > >                   return 0;
> > > > >           }
> > > > > +	if (xfs_inode_has_forcealign(ip))
> > > > > +	       first_unmap_block = xfs_inode_roundup_alloc_unit(ip,
> > > > > first_unmap_block);
> > > > >           error = xfs_bunmapi_range(&tp, ip, flags, first_unmap_block,
> > > > Yes, it would be something like that, except it would have to be
> > > > done before first_unmap_block is verified.
> > > > 
> > > ok, and are you still of the opinion that this does not apply to rtvol?
> > The rtvol is*not* force-aligned. It -may- have some aligned
> > allocation requirements that are similar (i.e. sb_rextsize > 1 fsb)
> > but it does*not* force-align extents, written or unwritten.
> > 
> > The moment we add force-align support to RT files (as is the plan),
> > then the force-aligned inodes on the rtvol will need to behave as
> > force aligned inodes, not "rtvol" inodes.
> 
> ok, fine
> 
> Thanks,
> John
> 
> 
> 

