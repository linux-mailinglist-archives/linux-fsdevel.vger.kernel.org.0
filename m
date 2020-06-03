Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA81ED4AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCREM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 13:04:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49246 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCREK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:04:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053GuURH084285;
        Wed, 3 Jun 2020 17:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JE+WMAzYhB9I63Z7mLN3ij+Wo6tJjTmohhHE6mf0Dik=;
 b=UvDUuojTTQy9ZVgoum0ooM+DA1vodbZ1rLxZ8kLb0V/FDnz9VFoopV2r+ZgrC9aArifB
 EcnzCqD/N44bU2SOUGxeSlYeBdkl9LCSlmfqyLPrsb3Cmmypn2nMZOXt4kjWEZsdiDLH
 k9XHgRSQPBjFIlqBvHP8YhaS/XTw1tdDt5iRM+AaLzk3le1uIFPOUGEKeFs09OCEaTmc
 TZNDjpfhqdAZHhoT9i1zzP+iZ78irasfD4fy2khX49ETuwfmfUjOsf9gDn6mw+6t4fSA
 j3TtQ9UIR4Fs65FzN5ddA2Y62radlWBGQ3npodurSC/8+EIKltiJOuP2B++6UhutLWVn NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfemacc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:03:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053GvXW5135784;
        Wed, 3 Jun 2020 17:03:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31c12r602b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:03:48 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053H3kbd018195;
        Wed, 3 Jun 2020 17:03:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:03:45 -0700
Date:   Wed, 3 Jun 2020 10:03:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 11/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200603170344.GO2162697@magnolia>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-12-ira.weiny@intel.com>
 <20200428201138.GD6742@magnolia>
 <20200602172353.GC8230@magnolia>
 <20200603101024.GG19165@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603101024.GG19165@quack2.suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=1 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:10:24PM +0200, Jan Kara wrote:
> On Tue 02-06-20 10:23:53, Darrick J. Wong wrote:
> > On Tue, Apr 28, 2020 at 01:11:38PM -0700, Darrick J. Wong wrote:
> > > > -out_unlock:
> > > > -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > > > -	return error;
> > > > +	if ((mp->m_flags & XFS_MOUNT_DAX_ALWAYS) ||
> > > > +	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
> > > > +		return;
> > > >  
> > > > +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > > +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> > > > +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > > +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> > > > +		d_mark_dontcache(inode);
> > 
> > Now that I think about this further, are we /really/ sure that we want
> > to let unprivileged userspace cause inode evictions?
> 
> You have to have an equivalent of write access to the file to be able to
> trigger d_mark_dontcache(). So you can e.g. delete it.  Or you could
> fadvise / madvise regarding its page cache. I don't see the ability to push
> inode out of cache as stronger than the abilities you already have...

<nod> Ok.  I just had one last bout of paranoia, but I think it'll be
fine. :)

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
