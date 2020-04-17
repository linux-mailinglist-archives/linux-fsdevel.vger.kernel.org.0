Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7711AD445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgDQB5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 21:57:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgDQB5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:57:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03H1tAHB083213;
        Fri, 17 Apr 2020 01:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=F+76xwT+FKaHjhh1t9ecbLu8da3f4wWJsKR13LIG3E0=;
 b=ZLXrZpbvVeFjL0evQqI4Z/r9dv46Cfl+S7ozpIYFQ5G1QiQyQDyr85OJFRi48wyKMpxv
 +P+xzfeIwFeRqvA+HaaOiuukmeA5sVbxi395re7I8fKY+hO7UZli/5XdvQUZTGoxSQwy
 m7Xim6VzT37/2gTqnJerg9U9Uo4O3t4jWJ472/TL6de05DFIqNE+fseBK/QY7SxBnlWw
 RRd98MJL5W99VT+dcLgXhV424n9704Be71SNda2rmmttnfYP4hjFLdkKIxvTBGf6qmjU
 fhwkLZ1c52I7Gg7rUF5pHfBjdWn64gkW4Fxizp7K4hIK/sjr9cA7+rDu31YV2ZVSdEOv tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30dn95vnt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 01:57:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03H1r9Cs055342;
        Fri, 17 Apr 2020 01:57:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30emephge9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 01:57:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03H1vXQN009641;
        Fri, 17 Apr 2020 01:57:33 GMT
Received: from localhost (/10.159.254.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 18:57:33 -0700
Date:   Thu, 16 Apr 2020 18:57:31 -0700
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
Message-ID: <20200417015731.GU6742@magnolia>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
 <20200416162504.GB6733@magnolia>
 <20200416223327.GO2309605@iweiny-DESK2.sc.intel.com>
 <20200416224937.GY6749@magnolia>
 <20200417003719.GP2309605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417003719.GP2309605@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170013
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:37:19PM -0700, Ira Weiny wrote:
> On Thu, Apr 16, 2020 at 03:49:37PM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 16, 2020 at 03:33:27PM -0700, Ira Weiny wrote:
> > > On Thu, Apr 16, 2020 at 09:25:04AM -0700, Darrick J. Wong wrote:
> > > > On Mon, Apr 13, 2020 at 09:00:26PM -0700, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > > > > 
> > > > > Set the flag to be user visible and changeable.  Set the flag to be
> > > > > inherited.  Allow applications to change the flag at any time.
> > > > > 
> > > > > Finally, on regular files, flag the inode to not be cached to facilitate
> > > > > changing S_DAX on the next creation of the inode.
> > > > > 
> > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > > ---
> > > > >  fs/ext4/ext4.h  | 13 +++++++++----
> > > > >  fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
> > > > >  2 files changed, 29 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > > > index 61b37a052052..434021fcec88 100644
> > > > > --- a/fs/ext4/ext4.h
> > > > > +++ b/fs/ext4/ext4.h
> > > > > @@ -415,13 +415,16 @@ struct flex_groups {
> > > > >  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> > > > >  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> > > > >  #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> > > > > +
> > > > > +#define EXT4_DAX_FL			0x00800000 /* Inode is DAX */
> > > > 
> > > > Sooo, fun fact about ext4 vs. the world--
> > > > 
> > > > The GETFLAGS/SETFLAGS ioctl, since it came from ext2, shares the same
> > > > flag values as the ondisk inode flags in ext*.  Therefore, each of these
> > > > EXT4_[whatever]_FL values are supposed to have a FS_[whatever]_FL
> > > > equivalent in include/uapi/linux/fs.h.
> > > 
> > > Interesting...
> > > 
> > > > 
> > > > (Note that the "[whatever]" is a straight translation since the same
> > > > uapi header also defines the FS_XFLAG_[xfswhatever] flag values; ignore
> > > > those.)
> > > > 
> > > > Evidently, FS_NOCOW_FL already took 0x800000, but ext4.h was never
> > > > updated to note that the value was taken.  I think Ted might be inclined
> > > > to reserve the ondisk inode bit just in case ext4 ever does support copy
> > > > on write, though that's his call. :)
> > > 
> > > Seems like I should change this...  And I did not realize I was inherently
> > > changing a bit definition which was exposed to other FS's...
> > 
> > <nod> This whole thing is a mess, particularly now that we have two vfs
> > ioctls to set per-fs inode attributes, both of which were inherited from
> > other filesystems... :(
> >
> 
> Ok I've changed it.
> 
> > 
> > > > 
> > > > Long story short - can you use 0x1000000 for this instead, and add the
> > > > corresponding value to the uapi fs.h?  I guess that also means that we
> > > > can change FS_XFLAG_DAX (in the form of FS_DAX_FL in FSSETFLAGS) after
> > > > that.
> > > 
> > > :-/
> > > 
> > > Are there any potential users of FS_XFLAG_DAX now?
> > 
> > Yes, it's in the userspace ABI so we can't get rid of it.
> > 
> > (FWIW there are several flags that exist in both FS_XFLAG_* and FS_*_FL
> > form.)
> > 
> > > From what it looks like, changing FS_XFLAG_DAX to FS_DAX_FL would be pretty
> > > straight forward.  Just to be sure, looks like XFS converts the FS_[xxx]_FL to
> > > FS_XFLAGS_[xxx] in xfs_merge_ioc_xflags()?  But it does not look like all the
> > > FS_[xxx]_FL flags are converted.  Is is that XFS does not support those
> > > options?  Or is it depending on the VFS layer for some of them?
> > 
> > XFS doesn't support most of the FS_*_FL flags.
> 
> If FS_XFLAG_DAX needs to continue to be user visible I think we need to keep
> that flag and we should not expose the EXT4_DAX_FL flag...
> 
> I think that works for XFS.
> 
> But for ext4 it looks like EXT4_FL_XFLAG_VISIBLE was intended to be used for
> [GET|SET]XATTR where EXT4_FL_USER_VISIBLE was intended to for [GET|SET]FLAGS...
> But if I don't add EXT4_DAX_FL in EXT4_FL_XFLAG_VISIBLE my test fails.
> 
> I've been playing with the flags and looking at the code and I _thought_ the
> following patch would ensure that FS_XFLAG_DAX is the only one visible but for
> some reason FS_XFLAG_DAX can't be set with this patch.  I still need the
> EXT4_FL_USER_VISIBLE mask altered...  Which I believe would expose EXT4_DAX_FL
> directly as well.
> 
> Jan, Ted?  Any ideas?  Or should we expose EXT4_DAX_FL and FS_XFLAG_DAX in
> ext4?

Both flags should be exposed through their respective ioctl interfaces
in both filesystems.  That way we don't have to add even more verbiage
to the documentation to instruct userspace programmers on how to special
case ext4 and XFS for the same piece of functionality.

--D

> Ira
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index fb7e66089a74..c3823f057755 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -423,7 +423,7 @@ struct flex_groups {
>  #define EXT4_CASEFOLD_FL               0x40000000 /* Casefolded file */
>  #define EXT4_RESERVED_FL               0x80000000 /* reserved for ext4 lib */
>  
> -#define EXT4_FL_USER_VISIBLE           0x715BDFFF /* User visible flags */
> +#define EXT4_FL_USER_VISIBLE           0x705BDFFF /* User visible flags */
>  #define EXT4_FL_USER_MODIFIABLE                0x614BC0FF /* User modifiable flags */
>  
>  /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index b3c6e891185e..8bd0d3f9ca0b 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -744,8 +744,8 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
>  {
>         struct ext4_inode_info *ei = EXT4_I(inode);
>  
> -       simple_fill_fsxattr(fa, ext4_iflags_to_xflags(ei->i_flags &
> -                                                     EXT4_FL_USER_VISIBLE));
> +       simple_fill_fsxattr(fa, (ext4_iflags_to_xflags(ei->i_flags) &
> +                                                     EXT4_FL_XFLAG_VISIBLE));
>  
>         if (ext4_has_feature_project(inode->i_sb))
>                 fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
