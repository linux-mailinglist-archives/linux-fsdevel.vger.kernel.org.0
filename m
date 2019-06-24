Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE151DC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 23:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfFXV7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 17:59:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39540 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfFXV7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OLsca6091939;
        Mon, 24 Jun 2019 21:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JPBEqrnBb8FJilUCQCUmMJhL0pO+qsW2uzegjGEHDYQ=;
 b=vwSceTOFPnndaHyinJXnA0XxpMTF4zGHNj5lEs+w8XWiVL6ly7Z9VEVjJV4gnFgKkKwW
 B8SdZ4krsyR6f1E0FlYW5moxuEmjhgn85HtSg0z2oOp1hhMJdo3XOqpiHvEil1BlZ2KW
 PEGmAIadWWqhl9+AmMr5FDs139rF0no0szY6ZnskKVnUEMSG9PrJ5dCsFbIdJrY2zxiP
 3z4yfqHwUSqvLrreOnH+MDuEMhE8ElZOtQ8shgvbsZ/7FCLrYScc7NOmLBxChFYSaq/u
 gI1Rn+l+GOiLbqZED3Z1Od5UlWcckpvKqSJxtGUwwy+7uAnIrP4j5qb9NqSYBMPprys8 Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pgrf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 21:58:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OLwP9j160075;
        Mon, 24 Jun 2019 21:58:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2tat7bvjfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jun 2019 21:58:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5OLwS3d160108;
        Mon, 24 Jun 2019 21:58:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7bvjf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 21:58:28 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OLwK6v015219;
        Mon, 24 Jun 2019 21:58:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 14:58:20 -0700
Date:   Mon, 24 Jun 2019 14:58:17 -0700
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
Subject: Re: [PATCH 2/7] vfs: flush and wait for io when setting the
 immutable flag via SETFLAGS
Message-ID: <20190624215817.GE1611011@magnolia>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116142734.1664939.5074567130774423066.stgit@magnolia>
 <20190624113737.GG32376@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624113737.GG32376@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=805 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240172
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:37:37PM +0200, Jan Kara wrote:
> On Fri 21-06-19 16:57:07, Darrick J. Wong wrote:
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
> Seeing the way this worked out, is there a reason to have separate
> vfs_ioc_setflags_flush_data() instead of folding the functionality in
> vfs_ioc_setflags_check() (possibly renaming it to
> vfs_ioc_setflags_prepare() to indicate it does already some changes)? I
> don't see any place that would need these two separated...

XFS needs them to be separated.

If we even /think/ that we're going to be setting the immutable flag
then we need to grab the IOLOCK and the MMAPLOCK to prevent further
writes while we drain all the directio writes and dirty data.  IO
completions for the write draining can take the ILOCK, which means that
we can't have grabbed it yet.

Next, we grab the ILOCK so we can check the new flags against the inode
and then update the inode core.

For most filesystems I think it suffices to inode_lock and then do both,
though.

> > +/*
> > + * Flush all pending IO and dirty mappings before setting S_IMMUTABLE on an
> > + * inode via FS_IOC_SETFLAGS.  If the flush fails we'll clear the flag before
> > + * returning error.
> > + *
> > + * Note: the caller should be holding i_mutex, or else be sure that
> > + * they have exclusive access to the inode structure.
> > + */
> > +static inline int vfs_ioc_setflags_flush_data(struct inode *inode, int flags)
> > +{
> > +	int ret;
> > +
> > +	if (!vfs_ioc_setflags_need_flush(inode, flags))
> > +		return 0;
> > +
> > +	inode_set_flags(inode, S_IMMUTABLE, S_IMMUTABLE);
> > +	ret = inode_flush_data(inode);
> > +	if (ret)
> > +		inode_set_flags(inode, 0, S_IMMUTABLE);
> > +	return ret;
> > +}
> 
> Also this sets S_IMMUTABLE whenever vfs_ioc_setflags_need_flush() returns
> true. That is currently the right thing but seems like a landmine waiting
> to trip? So I'd just drop the vfs_ioc_setflags_need_flush() abstraction to
> make it clear what's going on.

Ok.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
