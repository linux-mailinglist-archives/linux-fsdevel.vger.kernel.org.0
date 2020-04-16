Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73BB1AD2F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgDPWt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:49:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47436 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgDPWt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:49:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GMnhY3112084;
        Thu, 16 Apr 2020 22:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QlfJLMxks0tyI/rrqcehNcCSZpC0cqzuJ2JiKv9/wiY=;
 b=Rj/g8RKpnk4K2a20FUpS21AE9ugzQzNN6SMTcaOOb0JRQIJwS7d3vBKeogdDaJwFZ/Ix
 ts6i6onGkkSqF1uH+ZGHxNDUiJalkLvFaX50AACx9dII9qySTfXG5eG9njOaPATzLa/D
 eTlFi7v0s5kPBDQ9bXAAPy7YhGCTpk1cXTMe9+V5uNdMHDlvZptEk+Fq/I5oDtrZlBRR
 JvPMfGqi2hVIKGnKfrEPUgQ9qrRuidR1Z+tKqQmwG18nnXJZq6HEMDEXGNxHyH04qLQv
 nBbp7RNnqPt5KakMrVNMdoJ1IR1yV8vSjbcjnLujYIv1vntB+FpWiruFP4vUJLGgePE7 FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30e0aa9spu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 22:49:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GMbCNR164717;
        Thu, 16 Apr 2020 22:49:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30emep8byd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 22:49:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03GMndXj001342;
        Thu, 16 Apr 2020 22:49:39 GMT
Received: from localhost (/10.159.254.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 15:49:38 -0700
Date:   Thu, 16 Apr 2020 15:49:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200416224937.GY6749@magnolia>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
 <20200416162504.GB6733@magnolia>
 <20200416223327.GO2309605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416223327.GO2309605@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:33:27PM -0700, Ira Weiny wrote:
> On Thu, Apr 16, 2020 at 09:25:04AM -0700, Darrick J. Wong wrote:
> > On Mon, Apr 13, 2020 at 09:00:26PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > > 
> > > Set the flag to be user visible and changeable.  Set the flag to be
> > > inherited.  Allow applications to change the flag at any time.
> > > 
> > > Finally, on regular files, flag the inode to not be cached to facilitate
> > > changing S_DAX on the next creation of the inode.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  fs/ext4/ext4.h  | 13 +++++++++----
> > >  fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
> > >  2 files changed, 29 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 61b37a052052..434021fcec88 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -415,13 +415,16 @@ struct flex_groups {
> > >  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> > >  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> > >  #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> > > +
> > > +#define EXT4_DAX_FL			0x00800000 /* Inode is DAX */
> > 
> > Sooo, fun fact about ext4 vs. the world--
> > 
> > The GETFLAGS/SETFLAGS ioctl, since it came from ext2, shares the same
> > flag values as the ondisk inode flags in ext*.  Therefore, each of these
> > EXT4_[whatever]_FL values are supposed to have a FS_[whatever]_FL
> > equivalent in include/uapi/linux/fs.h.
> 
> Interesting...
> 
> > 
> > (Note that the "[whatever]" is a straight translation since the same
> > uapi header also defines the FS_XFLAG_[xfswhatever] flag values; ignore
> > those.)
> > 
> > Evidently, FS_NOCOW_FL already took 0x800000, but ext4.h was never
> > updated to note that the value was taken.  I think Ted might be inclined
> > to reserve the ondisk inode bit just in case ext4 ever does support copy
> > on write, though that's his call. :)
> 
> Seems like I should change this...  And I did not realize I was inherently
> changing a bit definition which was exposed to other FS's...

<nod> This whole thing is a mess, particularly now that we have two vfs
ioctls to set per-fs inode attributes, both of which were inherited from
other filesystems... :(

> > 
> > Long story short - can you use 0x1000000 for this instead, and add the
> > corresponding value to the uapi fs.h?  I guess that also means that we
> > can change FS_XFLAG_DAX (in the form of FS_DAX_FL in FSSETFLAGS) after
> > that.
> 
> :-/
> 
> Are there any potential users of FS_XFLAG_DAX now?

Yes, it's in the userspace ABI so we can't get rid of it.

(FWIW there are several flags that exist in both FS_XFLAG_* and FS_*_FL
form.)

> From what it looks like, changing FS_XFLAG_DAX to FS_DAX_FL would be pretty
> straight forward.  Just to be sure, looks like XFS converts the FS_[xxx]_FL to
> FS_XFLAGS_[xxx] in xfs_merge_ioc_xflags()?  But it does not look like all the
> FS_[xxx]_FL flags are converted.  Is is that XFS does not support those
> options?  Or is it depending on the VFS layer for some of them?

XFS doesn't support most of the FS_*_FL flags.

--D

> Ira
> 
> > 
> > --D
> > 
> > > +
> > >  #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> > >  #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > >  #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
> > >  #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
> > >  
> > > -#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
> > > -#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User modifiable flags */
> > > +#define EXT4_FL_USER_VISIBLE		0x70DBDFFF /* User visible flags */
> > > +#define EXT4_FL_USER_MODIFIABLE		0x60CBC0FF /* User modifiable flags */
> > >  
> > >  /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
> > >  #define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
> > > @@ -429,14 +432,16 @@ struct flex_groups {
> > >  					 EXT4_APPEND_FL | \
> > >  					 EXT4_NODUMP_FL | \
> > >  					 EXT4_NOATIME_FL | \
> > > -					 EXT4_PROJINHERIT_FL)
> > > +					 EXT4_PROJINHERIT_FL | \
> > > +					 EXT4_DAX_FL)
> > >  
> > >  /* Flags that should be inherited by new inodes from their parent. */
> > >  #define EXT4_FL_INHERITED (EXT4_SECRM_FL | EXT4_UNRM_FL | EXT4_COMPR_FL |\
> > >  			   EXT4_SYNC_FL | EXT4_NODUMP_FL | EXT4_NOATIME_FL |\
> > >  			   EXT4_NOCOMPR_FL | EXT4_JOURNAL_DATA_FL |\
> > >  			   EXT4_NOTAIL_FL | EXT4_DIRSYNC_FL |\
> > > -			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
> > > +			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL |\
> > > +			   EXT4_DAX_FL)
> > >  
> > >  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> > >  #define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
> > > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > > index ee3401a32e79..ca07d5086f03 100644
> > > --- a/fs/ext4/ioctl.c
> > > +++ b/fs/ext4/ioctl.c
> > > @@ -539,12 +539,15 @@ static inline __u32 ext4_iflags_to_xflags(unsigned long iflags)
> > >  		xflags |= FS_XFLAG_NOATIME;
> > >  	if (iflags & EXT4_PROJINHERIT_FL)
> > >  		xflags |= FS_XFLAG_PROJINHERIT;
> > > +	if (iflags & EXT4_DAX_FL)
> > > +		xflags |= FS_XFLAG_DAX;
> > >  	return xflags;
> > >  }
> > >  
> > >  #define EXT4_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
> > >  				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
> > > -				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
> > > +				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT | \
> > > +				  FS_XFLAG_DAX)
> > >  
> > >  /* Transfer xflags flags to internal */
> > >  static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
> > > @@ -563,6 +566,8 @@ static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
> > >  		iflags |= EXT4_NOATIME_FL;
> > >  	if (xflags & FS_XFLAG_PROJINHERIT)
> > >  		iflags |= EXT4_PROJINHERIT_FL;
> > > +	if (xflags & FS_XFLAG_DAX)
> > > +		iflags |= EXT4_DAX_FL;
> > >  
> > >  	return iflags;
> > >  }
> > > @@ -813,6 +818,17 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
> > >  	return error;
> > >  }
> > >  
> > > +static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
> > > +{
> > > +	struct ext4_inode_info *ei = EXT4_I(inode);
> > > +
> > > +	if (S_ISDIR(inode->i_mode))
> > > +		return;
> > > +
> > > +	if ((ei->i_flags ^ flags) == EXT4_DAX_FL)
> > > +		inode->i_state |= I_DONTCACHE;
> > > +}
> > > +
> > >  long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > >  {
> > >  	struct inode *inode = file_inode(filp);
> > > @@ -1273,6 +1289,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > >  			return err;
> > >  
> > >  		inode_lock(inode);
> > > +
> > > +		ext4_dax_dontcache(inode, flags);
> > > +
> > >  		ext4_fill_fsxattr(inode, &old_fa);
> > >  		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
> > >  		if (err)
> > > -- 
> > > 2.25.1
> > > 
