Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27CD4DCE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 23:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfFTVkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 17:40:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfFTVkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:40:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLYHVn088700;
        Thu, 20 Jun 2019 21:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=D3CnJNHOIgWdUG1TcE81fq/bsWj72ILMBiE1tAPqQwo=;
 b=HKn791tbDcSyV5tTwA4L7n0iz31Dp5T+PYftD80uW1HfTEOKSjNNo8ILTMjO1/Rv8cOI
 hpROCjBB23fPljyiuqdvwYxNy/xpAecXOJ97+qJXUbuQysBIXp6+kq1M1NohTdSt2o5m
 bdEHlQfhcUcK9Q2VlmkUVsRBf7mVWZm2yOm4eXP0y5gikqkZmSL3eKCbJdvsPzjLY50k
 BfxiWb1VEIm42WU1tUp/bKXk3/F6YlHbkAbzrc8pKPgHNgEvkWIV2bY4z7UBJVZQfH8/
 ZSoTLiWzgKluhc0l9SvuD6uztH108WS7lGdHTqumoJ0SNSOf6qr9qij979gZkZoaMzEB qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t7809kdj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:38:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLacer151050;
        Thu, 20 Jun 2019 21:36:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2t77ypkrr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jun 2019 21:36:38 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5KLabeL151041;
        Thu, 20 Jun 2019 21:36:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t77ypkrqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:36:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5KLaWqH007037;
        Thu, 20 Jun 2019 21:36:32 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 14:36:31 -0700
Date:   Thu, 20 Jun 2019 14:36:29 -0700
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
Subject: Re: [PATCH 4/6] vfs: don't allow most setxattr to immutable files
Message-ID: <20190620213629.GB5375@magnolia>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
 <156022840560.3227213.4776913678782966728.stgit@magnolia>
 <20190620140345.GI30243@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620140345.GI30243@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:03:45PM +0200, Jan Kara wrote:
> On Mon 10-06-19 21:46:45, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > The chattr manpage has this to say about immutable files:
> > 
> > "A file with the 'i' attribute cannot be modified: it cannot be deleted
> > or renamed, no link can be created to this file, most of the file's
> > metadata can not be modified, and the file can not be opened in write
> > mode."
> > 
> > However, we don't actually check the immutable flag in the setattr code,
> > which means that we can update inode flags and project ids and extent
> > size hints on supposedly immutable files.  Therefore, reject setflags
> > and fssetxattr calls on an immutable file if the file is immutable and
> > will remain that way.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  fs/inode.c |   31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index a3757051fd55..adfb458bf533 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2184,6 +2184,17 @@ int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags)
> >  	    !capable(CAP_LINUX_IMMUTABLE))
> >  		return -EPERM;
> >  
> > +	/*
> > +	 * We aren't allowed to change any other flags if the immutable flag is
> > +	 * already set and is not being unset.
> > +	 */
> > +	if ((oldflags & FS_IMMUTABLE_FL) &&
> > +	    (flags & FS_IMMUTABLE_FL)) {
> > +		if ((oldflags & ~FS_IMMUTABLE_FL) !=
> > +		    (flags & ~FS_IMMUTABLE_FL))
> 
> This check looks a bit strange when you've just check FS_IMMUTABLE_FL isn't
> changing... Why not just oldflags != flags?
> 
> > +	if ((old_fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
> > +	    (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)) {
> > +		if ((old_fa->fsx_xflags & ~FS_XFLAG_IMMUTABLE) !=
> > +		    (fa->fsx_xflags & ~FS_XFLAG_IMMUTABLE))
> 
> Ditto here...

Good point!  I'll fix it.

--D

> 
> > +			return -EPERM;
> > +		if (old_fa->fsx_projid != fa->fsx_projid)
> > +			return -EPERM;
> > +		if ((fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
> > +				       FS_XFLAG_EXTSZINHERIT)) &&
> > +		    old_fa->fsx_extsize != fa->fsx_extsize)
> > +			return -EPERM;
> > +		if ((old_fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> > +		    old_fa->fsx_cowextsize != fa->fsx_cowextsize)
> > +			return -EPERM;
> > +	}
> > +
> >  	/* Extent size hints of zero turn off the flags. */
> >  	if (fa->fsx_extsize == 0)
> >  		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
