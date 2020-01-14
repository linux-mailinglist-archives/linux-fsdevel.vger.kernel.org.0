Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785AF139EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 02:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgANBEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 20:04:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36218 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgANBEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:04:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E13GnB085465;
        Tue, 14 Jan 2020 01:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=7jBHH4oOQP9IrNSe4g8pOXVxUUR5i6Dekv8HSEosktE=;
 b=q49gJ62uRjgjD6IaNwvxQbHBzO6WlK2GucQc7AR6OZxlLWMotZvd9XOqZ1vGG69Z4EDX
 VdqF5U1wK8g7Pr5lFGBTg171P7DQcUiHDEVHRi6/Ram8BKUz2XY7UwMuqehMf9sXUmn3
 ukFgJeiSNQmrdmFcMjMf2jXrH8xOtd01f6iVSEUEIGnXpJfbs3N836jRs8Vev2s2F7hK
 A+LNbxni8wynofU3YSaldKp1HASUi7JevUc3AtTgVnPuhO+ZvD6dXq34cFrboLoze392
 KhyyQiB62M/bOTmkmAL4cC8B8G02w1g2miOIee+/7joxjYF4ctqXl/qiE6Dy8gUfWPUF wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73tjkcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 01:04:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E14FB5170858;
        Tue, 14 Jan 2020 01:04:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xh2sbjdc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 01:04:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E13OGJ020546;
        Tue, 14 Jan 2020 01:03:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 17:03:24 -0800
Date:   Mon, 13 Jan 2020 17:03:22 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 07/12] fs: Add locking for a dynamic inode 'mode'
Message-ID: <20200114010322.GS8247@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-8-ira.weiny@intel.com>
 <20200113221218.GM8247@magnolia>
 <20200114002005.GA29860@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114002005.GA29860@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140007
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:20:05PM -0800, Ira Weiny wrote:
> On Mon, Jan 13, 2020 at 02:12:18PM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 10, 2020 at 11:29:37AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]
> 
> > >  
> > >  The File Object
> > >  ---------------
> > > @@ -437,6 +459,8 @@ As of kernel 2.6.22, the following members are defined:
> > >  		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
> > >  				   unsigned open_flag, umode_t create_mode);
> > >  		int (*tmpfile) (struct inode *, struct dentry *, umode_t);
> > > +		void (*lock_mode)(struct inode *);
> > > +		void (*unlock_mode)(struct inode *);
> > 
> > Yikes.  "mode" has a specific meaning for inodes, and this lock isn't
> > related to i_mode.  This lock protects aops from changing while an
> > address space operation is in use.
> 
> Ah...  yea ok mode is a bad name.
> 
> > 
> > >  	};
> > >  
> > >  Again, all methods are called without any locks being held, unless
> > > @@ -584,6 +608,12 @@ otherwise noted.
> > >  	atomically creating, opening and unlinking a file in given
> > >  	directory.
> > >  
> > > +``lock_mode``
> > > +	called to prevent operations which depend on the inode's mode from
> > > +        proceeding should a mode change be in progress
> > 
> > "Inodes can't change mode, because files do not suddenly become
> > directories". ;)
> 
> Yea sorry.
> 
> > 
> > Oh, you meant "lock_XXXX is called to prevent a change in the pagecache
> > mode from proceeding while there are address space operations in
> > progress".  So these are really more aops get and put functions...
> 
> At first I actually did have aops get/put functions but this is really
> protecting more than the aops vector because as Christoph said there are file
> operations which need to be protected not just address space operations.
> 
> But I agree "mode" is a bad name...  Sorry...

inode_fops_{get,set}(), then?

inode_start_fileop()
inode_end_fileop() ?

Trying to avoid sounding foppish <COUGH>

> > 
> > > +``unlock_mode``
> > > +	called when critical mode dependent operation is complete
> > >  
> > >  The Address Space Object
> > >  ========================
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 7c9a5df5a597..ed6ab5303a24 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -55,18 +55,29 @@ EXPORT_SYMBOL(vfs_ioctl);
> > >  static int ioctl_fibmap(struct file *filp, int __user *p)
> > >  {
> > >  	struct address_space *mapping = filp->f_mapping;
> > > +	struct inode *inode = filp->f_inode;
> > >  	int res, block;
> > >  
> > > +	lock_inode_mode(inode);
> > > +
> > >  	/* do we support this mess? */
> > > -	if (!mapping->a_ops->bmap)
> > > -		return -EINVAL;
> > > -	if (!capable(CAP_SYS_RAWIO))
> > > -		return -EPERM;
> > > +	if (!mapping->a_ops->bmap) {
> > > +		res = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +	if (!capable(CAP_SYS_RAWIO)) {
> > > +		res = -EPERM;
> > > +		goto out;
> > 
> > Why does the order of these checks change here?
> 
> I don't understand?  The order does not change we just can't return without
> releasing the lock.  And to protect against bmap changing the lock needs to be
> taken first.

Doh.  -ENOCOFFEE, I plead.

--D

> [snip]
> 
> > >  
> > > +static inline void lock_inode_mode(struct inode *inode)
> > 
> > inode_aops_get()?
> 
> Let me think on this.  This is not just getting a reference to the aops vector.
> It is more than that...  and inode_get is not right either!  ;-P
> 
> > 
> > > +{
> > > +	WARN_ON_ONCE(inode->i_op->lock_mode &&
> > > +		     !inode->i_op->unlock_mode);
> > > +	if (inode->i_op->lock_mode)
> > > +		inode->i_op->lock_mode(inode);
> > > +}
> > > +static inline void unlock_inode_mode(struct inode *inode)
> > > +{
> > > +	WARN_ON_ONCE(inode->i_op->unlock_mode &&
> > > +		     !inode->i_op->lock_mode);
> > > +	if (inode->i_op->unlock_mode)
> > > +		inode->i_op->unlock_mode(inode);
> > > +}
> > > +
> > >  static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
> > >  				     struct iov_iter *iter)
> > 
> > inode_aops_put()?
> 
> ...  something like that but not 'aops'...
> 
> Ira
> 
> > 
> > --D
> > 
