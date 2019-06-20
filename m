Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364744DD44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFTWLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 18:11:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38802 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTWLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:11:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KM3qBJ117650;
        Thu, 20 Jun 2019 22:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=34yrDpyIlCnapuEelQkMxzELpTn9E3Oq0EEgTNp3pMo=;
 b=wEo3wGjoiDRLmfFiBOSYftkqF9BxyNKUscmBHul8oqMnrOQ2CuuZil1ROkycJEV6VL7i
 K/EZENHDp/fbYpjQeBCVWiy/W0Tz7wb4eQqeU8hP8XSZ126W7yTiTbuSaF2YghMDkyDz
 1JjI5jgZUM6pLkd8QOel+rUwWuFInCdHZHVl+HAdZhL5eL30xXYf07aNzmm5sQfUY3Xi
 u8qnsSTO1Nnw83kcS80Cgv88V0Im23B5q/abGAirRb0yn4qxQanHw+7gT0cIk1IKOss/
 NQ08jOFoC7P0Gxtp1eUAT6k37gmOMLQ6i9bzdXCoNF+Y2BY5IL9mn4FAiou7/jCFeHkN BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t7809kfc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 22:09:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KM9DaG104726;
        Thu, 20 Jun 2019 22:09:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2t77ynv76j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jun 2019 22:09:47 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5KM9lfD106008;
        Thu, 20 Jun 2019 22:09:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t77ynv76b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 22:09:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KM9hLr020247;
        Thu, 20 Jun 2019 22:09:43 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 15:09:43 -0700
Date:   Thu, 20 Jun 2019 15:09:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/6] vfs: flush and wait for io when setting the
 immutable flag via SETFLAGS
Message-ID: <20190620220940.GC5375@magnolia>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
 <156022838496.3227213.3771632042609589318.stgit@magnolia>
 <20190620140028.GH30243@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620140028.GH30243@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=772 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:00:28PM +0200, Jan Kara wrote:
> On Mon 10-06-19 21:46:25, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > When we're using FS_IOC_SETFLAGS to set the immutable flag on a file, we
> > need to ensure that userspace can't continue to write the file after the
> > file becomes immutable.  To make that happen, we have to flush all the
> > dirty pagecache pages to disk to ensure that we can fail a page fault on
> > a mmap'd region, wait for pending directio to complete, and hope the
> > caller locked out any new writes by holding the inode lock.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> ...
> 
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index 6aa1df1918f7..a05341b94d98 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -290,6 +290,9 @@ static int ext4_ioctl_setflags(struct inode *inode,
> >  	jflag = flags & EXT4_JOURNAL_DATA_FL;
> >  
> >  	err = vfs_ioc_setflags_check(inode, oldflags, flags);
> > +	if (err)
> > +		goto flags_out;
> > +	err = vfs_ioc_setflags_flush_data(inode, flags);
> >  	if (err)
> >  		goto flags_out;
> >  
> 
> ...
> 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8dad3c80b611..9c899c63957e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3548,7 +3548,41 @@ static inline struct sock *io_uring_get_socket(struct file *file)
> >  
> >  int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags);
> >  
> > +/*
> > + * Do we need to flush the file data before changing attributes?  When we're
> > + * setting the immutable flag we must stop all directio writes and flush the
> > + * dirty pages so that we can fail the page fault on the next write attempt.
> > + */
> > +static inline bool vfs_ioc_setflags_need_flush(struct inode *inode, int flags)
> > +{
> > +	if (S_ISREG(inode->i_mode) && !IS_IMMUTABLE(inode) &&
> > +	    (flags & FS_IMMUTABLE_FL))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Flush file data before changing attributes.  Caller must hold any locks
> > + * required to prevent further writes to this file until we're done setting
> > + * flags.
> > + */
> > +static inline int inode_flush_data(struct inode *inode)
> > +{
> > +	inode_dio_wait(inode);
> > +	return filemap_write_and_wait(inode->i_mapping);
> > +}
> > +
> > +/* Flush file data before changing attributes, if necessary. */
> > +static inline int vfs_ioc_setflags_flush_data(struct inode *inode, int flags)
> > +{
> > +	if (vfs_ioc_setflags_need_flush(inode, flags))
> > +		return inode_flush_data(inode);
> > +	return 0;
> > +}
> > +
> 
> But this is racy at least for page faults, isn't it? What protects you
> against write faults just after filemap_write_and_wait() has finished?
> So either you need to set FS_IMMUTABLE_FL before flushing data or you need
> to get more protection from the fs than just i_rwsem. In the case of ext4
> that would be i_mmap_rwsem but other filesystems don't have equivalent
> protection...

Yes, I see that now.  I think it'll work to set S_IMMUTABLE before
trying the flush, so long as I am careful to put the call sites right
before we update the inode flags.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
