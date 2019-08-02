Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC247FD83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfHBP3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:29:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46512 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbfHBP3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:29:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72FOOFh169849;
        Fri, 2 Aug 2019 15:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=aBqKDXVBqbttVMNLVzI3sGrtMwVjVSx5UOLob6/U1K4=;
 b=cCtEtFLisd39GbItYO8isIkKcMlebyG6yE2phf+N8Hxfb1gtwj5mfn/3rHDYKkKDugOU
 PBWYaxdmkborqHm7DdcSGu9/a3d0D5CRyAi/VCQLpknf4FKV56gqKfIRa+44dnz90H6G
 qoLaD+iZtecg/Q8z63bfQ3sdVL3Pb1RtW6VUYdUlkcAMH4L8bUlqsGpIBOI9qbh5hsaQ
 Uyfvz+og5RcNYqKj2qijF5KtoOgLaR07I+3eq/bkG86oND9idbUBgdyp9LsmSWoqEcfT
 B4jdJS4eKcuOOgZvk7zeKZhVr9erpGYNt0TV6kxQCvWKQEoJzWNu5RTfiGGBeh1py2sP zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u0e1ub4am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 15:29:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72FSFQP112605;
        Fri, 2 Aug 2019 15:29:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2u38fcbhqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 15:29:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x72FT4kS018176;
        Fri, 2 Aug 2019 15:29:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 08:29:03 -0700
Date:   Fri, 2 Aug 2019 08:29:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190802152902.GI7138@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-9-cmaiolino@redhat.com>
 <20190731232254.GW1561054@magnolia>
 <20190802134816.usmauocewduggrjt@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802134816.usmauocewduggrjt@pegasus.maiolino.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:48:17PM +0200, Carlos Maiolino wrote:
> > > -#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR)
> > > +#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC | \
> > > +				 FIEMAP_FLAG_XATTR| \
> > > +				 FIEMAP_KERNEL_FIBMAP)
> > >  
> > >  static int ext4_xattr_fiemap(struct inode *inode,
> > >  				struct fiemap_extent_info *fieinfo)
> > > @@ -5048,6 +5050,9 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
> > >  	if (ext4_has_inline_data(inode)) {
> > >  		int has_inline = 1;
> > >  
> > > +		if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
> > > +			return -EINVAL;
> > 
> > Wouldn't the inline data case be caught by fiemap_bmap and turned into
> > -EINVAL?
> 
> Yes, it does, but until ext4_fiemap() returns the extent with the INLINE flag,
> it does need to go through the whole fiemap mapping mechanism when we already
> know the result... So, instead of letting the ext4_fiemap() map the extent, just
> take the shortcut and return -EINVAL directly.
> 
> The check in fiemap_bmap() is a 'safe measure' (if it does have other name I
> don't know :), but if the filesystem already knows it's gonna fall into an
> inline inode, taking the shortcut is better, isn't it?

I suppose so.  Just wondering, that was all... :)

> 
> > > +		return 1;
> > > +	return 0;
> > > +}
> > > +
> > > +static int bmap_fiemap(struct inode *inode, sector_t *block)
> > > +{
> > > +	struct fiemap_extent_info fieinfo = { 0, };
> > > +	struct fiemap_extent fextent;
> > > +	u64 start = *block << inode->i_blkbits;
> > > +	int error = -EINVAL;
> > > +
> > > +	fextent.fe_logical = 0;
> > > +	fextent.fe_physical = 0;
> > > +	fieinfo.fi_extents_max = 1;
> > > +	fieinfo.fi_extents_mapped = 0;
> > > +	fieinfo.fi_cb_data = &fextent;
> > > +	fieinfo.fi_start = start;
> > > +	fieinfo.fi_len = 1 << inode->i_blkbits;
> > > +	fieinfo.fi_cb = fiemap_fill_kernel_extent;
> > > +	fieinfo.fi_flags = (FIEMAP_KERNEL_FIBMAP | FIEMAP_FLAG_SYNC);
> > > +
> > > +	error = inode->i_op->fiemap(inode, &fieinfo);
> > > +
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	if (fieinfo.fi_flags & (FIEMAP_EXTENT_UNKNOWN |
> > > +				FIEMAP_EXTENT_ENCODED |
> > > +				FIEMAP_EXTENT_DATA_INLINE |
> > > +				FIEMAP_EXTENT_UNWRITTEN |
> > > +				FIEMAP_EXTENT_SHARED))
> > > +		return -EINVAL;
> > > +
> > > +	*block = (fextent.fe_physical +
> > > +		  (start - fextent.fe_logical)) >> inode->i_blkbits;
> > > +
> > > +	return error;
> > > +}
> > > +
> > >  /**
> > >   *	bmap	- find a block number in a file
> > >   *	@inode:  inode owning the block number being requested
> > > @@ -1591,10 +1663,15 @@ EXPORT_SYMBOL(iput);
> > >   */
> > >  int bmap(struct inode *inode, sector_t *block)
> > >  {
> > > -	if (!inode->i_mapping->a_ops->bmap)
> > > +	if (inode->i_op->fiemap)
> > > +		return bmap_fiemap(inode, block);
> > > +
> > > +	if (inode->i_mapping->a_ops->bmap)
> > > +		*block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
> > > +						       *block);
> > > +	else
> > >  		return -EINVAL;
> > >  
> > > -	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL(bmap);
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index d72696c222de..0759ac6e4c7e 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -77,11 +77,8 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
> > >  	return error;
> > >  }
> > >  
> > > -#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
> > > -#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
> > > -#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
> > > -int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
> > > -			    u64 phys, u64 len, u32 flags)
> > > +static int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo,
> > > +			u64 logical, u64 phys, u64 len, u32 flags)
> > >  {
> > >  	struct fiemap_extent extent;
> > >  	struct fiemap_extent __user *dest = fieinfo->fi_cb_data;
> > > @@ -89,17 +86,17 @@ int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
> > >  	/* only count the extents */
> > >  	if (fieinfo->fi_extents_max == 0) {
> > >  		fieinfo->fi_extents_mapped++;
> > > -		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
> > > +		goto out;
> > >  	}
> > >  
> > >  	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
> > >  		return 1;
> > >  
> > > -	if (flags & SET_UNKNOWN_FLAGS)
> > > +	if (flags & FIEMAP_EXTENT_DELALLOC)
> > >  		flags |= FIEMAP_EXTENT_UNKNOWN;
> > > -	if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
> > > +	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
> > >  		flags |= FIEMAP_EXTENT_ENCODED;
> > > -	if (flags & SET_NOT_ALIGNED_FLAGS)
> > 
> > It's too bad that we lose the "not aligned" semantic meaning here.
> 
> May you explain a bit better what you mean? We don't lose it, just the define
> goes away, the reason I dropped these defines is because the same flags are used
> in both functions, fiemap_fill_{user,kernel}_extent(), and I didn't think
> defining them on both places (or in fs.h) has any benefit here, so I opted to
> remove them.

Eh, I changed my mind.  It's easy enough to tell which flags map to "No
umounted IO" from the code even if the #defines go away.

> > 
> > > +	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
> > >  		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
> > 
> > Why doesn't this function just call fiemap_fill_kernel_extent to fill
> > out the onstack @extent structure?  We've now implemented "fill out out
> > a struct fiemap_extent" twice.
> 
> fiemap_fill_{user, kernel}_extent() have different purposes, and the big
> difference is one handles a userspace pointer memory and the other don't. IIRC
> the original proposal was some sort of sharing a single function, but then
> Christoph suggested a new design, using different functions as callbacks.

It's harder for me to tell when I don't have a branch containing the
final product to look at, but I'd have thought that _fill_kernel fills
out an in-kernel fiemap extent; and then _fill_user would declare one on
the stack, call _fill_kernel to set the fields, and then copy_to_user?

(But maybe the code already does this and I can't tell...)

> 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index b485190b7ecd..18a798e9076b 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -1113,6 +1113,11 @@ xfs_vn_fiemap(
> > >  	struct fiemap_extent_info *fieinfo)
> > >  {
> > >  	int	error;
> > > +	struct	xfs_inode	*ip = XFS_I(inode);
> > 
> > Would you mind fixing the indentation to match usual xfs style?
> 
> Sure, will fix it
> 
> 
> > 
> > > +
> > > +	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
> > > +		if (xfs_is_reflink_inode(ip) || XFS_IS_REALTIME_INODE(ip))
> > > +			return -EINVAL;
> > 
> > The xfs part looks ok to me.
> > 
> > --D
> > 
> 
> -- 
> Carlos
