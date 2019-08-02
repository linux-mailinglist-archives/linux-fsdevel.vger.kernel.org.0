Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8937FD45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392083AbfHBPPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:15:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55692 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbfHBPPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72F97kL039609;
        Fri, 2 Aug 2019 15:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BUGUEjFdD3uD7gCNGE7vm9X5m+SBwO7IbYbXo4eLGnw=;
 b=UysPyl55m6IfPiLryv1O79ErGCz8Zd/i2HZaAOeK7HBD4t4trxOG9sMiXwC+MhwH4k6A
 QtiWa1tGKA8E/g1ez7fBjK9KTsP4ciXnjptAmxS3kIr5l9NyBMZxrlzOjyEhtUdOVWad
 LJ/0DZe9OVsVZtjDsVFCrrUitL9gxav09INKWeLVWvrsiXBh76ZPOPnq6xo21GSkhGVK
 EoXYAFJUzPoJ7yYfrR3J5e2eCDp9bOP8KvLQMNfzdLLGrtfEEKxaSXYZzzyR9hnW6zR+
 L8RRVRMU2T+7MEufxhpPNK96C7alFi1nz5naPGD3RnPjzVRrTXmXiNeSoxsSfdBYVefe AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejq2tr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 15:15:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72F7Vnv188409;
        Fri, 2 Aug 2019 15:15:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u3mbvq3hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 15:15:21 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x72FFKHJ010223;
        Fri, 2 Aug 2019 15:15:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 08:15:20 -0700
Date:   Fri, 2 Aug 2019 08:15:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] fs: Move start and length fiemap fields into
 fiemap_extent_info
Message-ID: <20190802151519.GH7138@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-6-cmaiolino@redhat.com>
 <20190731232837.GZ1561054@magnolia>
 <20190802095115.bjz6ejbouif3wkbt@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802095115.bjz6ejbouif3wkbt@pegasus.maiolino.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:51:16AM +0200, Carlos Maiolino wrote:
> > >  
> > >  STATIC int
> > >  xfs_vn_fiemap(
> > > -	struct inode		*inode,
> > > -	struct fiemap_extent_info *fieinfo,
> > > -	u64			start,
> > > -	u64			length)
> > > +	struct inode		  *inode,
> > > +	struct fiemap_extent_info *fieinfo)
> > >  {
> > > -	int			error;
> > > +	u64	start = fieinfo->fi_start;
> > > +	u64	length = fieinfo->fi_len;
> > > +	int	error;
> > 
> > Would be nice if the variable name indentation was consistent here, but
> > otherwise the xfs part looks ok.
> 
> These fields are removed on the next patch, updating it is really required?

Yes, please.

> > 
> > >  
> > >  	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
> > >  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index d5e7c744aea6..7b744b7de24e 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1705,11 +1705,14 @@ extern bool may_open_dev(const struct path *path);
> > >   * VFS FS_IOC_FIEMAP helper definitions.
> > >   */
> > >  struct fiemap_extent_info {
> > > -	unsigned int fi_flags;		/* Flags as passed from user */
> > > -	unsigned int fi_extents_mapped;	/* Number of mapped extents */
> > > -	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
> > > -	struct fiemap_extent __user *fi_extents_start; /* Start of
> > > -							fiemap_extent array */
> > > +	unsigned int	fi_flags;		/* Flags as passed from user */
> > > +	u64		fi_start;
> > > +	u64		fi_len;
> > 
> > Comments for these two new fields?
> 
> Sure, how about this:
> 
>        u64           fi_start;            /* Logical offset at which
>                                              start mapping */
>        u64           fi_len;              /* Logical length of mapping
>                                              the caller cares about */
> 
> 
> btw, Above indentation won't match final result

Looks good to me.

--D

> 
> Christoph, may I keep your reviewed tag by updating the comments as above?
> Otherwise I'll just remove your tag
> 
> > 
> > --D
> > 
> > > +	unsigned int	fi_extents_mapped;	/* Number of mapped extents */
> > > +	unsigned int	fi_extents_max;		/* Size of fiemap_extent array */
> > > +	struct		fiemap_extent __user *fi_extents_start;	/* Start of
> > > +								   fiemap_extent
> > > +								   array */
> > >  };
> > >  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
> > >  			    u64 phys, u64 len, u32 flags);
> > > @@ -1841,8 +1844,7 @@ struct inode_operations {
> > >  	int (*setattr) (struct dentry *, struct iattr *);
> > >  	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
> > >  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
> > > -	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
> > > -		      u64 len);
> > > +	int (*fiemap)(struct inode *, struct fiemap_extent_info *);
> > >  	int (*update_time)(struct inode *, struct timespec64 *, int);
> > >  	int (*atomic_open)(struct inode *, struct dentry *,
> > >  			   struct file *, unsigned open_flag,
> > > @@ -3199,11 +3201,10 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
> > >  
> > >  extern int __generic_block_fiemap(struct inode *inode,
> > >  				  struct fiemap_extent_info *fieinfo,
> > > -				  loff_t start, loff_t len,
> > >  				  get_block_t *get_block);
> > >  extern int generic_block_fiemap(struct inode *inode,
> > > -				struct fiemap_extent_info *fieinfo, u64 start,
> > > -				u64 len, get_block_t *get_block);
> > > +				struct fiemap_extent_info *fieinfo,
> > > +				get_block_t *get_block);
> > >  
> > >  extern struct file_system_type *get_filesystem(struct file_system_type *fs);
> > >  extern void put_filesystem(struct file_system_type *fs);
> > > -- 
> > > 2.20.1
> > > 
> 
> -- 
> Carlos
