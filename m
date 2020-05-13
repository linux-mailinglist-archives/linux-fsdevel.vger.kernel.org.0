Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329D61D2146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgEMVl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 17:41:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:7010 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgEMVl4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 17:41:56 -0400
IronPort-SDR: myQYB0V2K15ihPEq0wI4Fb0P7OmkFUFxIx6NF0KkBCns6Ai9ZtL2zsWdpIeoUSfomxiawMXo4s
 tF2f8zw8o0pA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 14:41:55 -0700
IronPort-SDR: G91xqFVTAl1hSUCjiwpQwMkoghQt2IXBwgchoMMwgdQiwBlQRpFohg3BNmQTWp29uqsQEIxCnk
 4cV+pl4zDYeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="253307995"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2020 14:41:55 -0700
Date:   Wed, 13 May 2020 14:41:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs/ext4: Introduce DAX inode flag
Message-ID: <20200513214154.GB2140786@iweiny-DESK2.sc.intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-9-ira.weiny@intel.com>
 <20200513144706.GH27709@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513144706.GH27709@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 04:47:06PM +0200, Jan Kara wrote:
> On Tue 12-05-20 22:43:23, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > 
> > Set the flag to be user visible and changeable.  Set the flag to be
> > inherited.  Allow applications to change the flag at any time.
> > 
> > Finally, on regular files, flag the inode to not be cached to facilitate
> > changing S_DAX on the next creation of the inode.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Change from RFC:
> > 	use new d_mark_dontcache()
> > 	Allow caching if ALWAYS/NEVER is set
> > 	Rebased to latest Linus master
> > 	Change flag to unused 0x01000000
> > 	update ext4_should_enable_dax()
> > ---
> >  fs/ext4/ext4.h  | 13 +++++++++----
> >  fs/ext4/inode.c |  4 +++-
> >  fs/ext4/ioctl.c | 25 ++++++++++++++++++++++++-
> >  3 files changed, 36 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 01d1de838896..715f8f2029b2 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -415,13 +415,16 @@ struct flex_groups {
> >  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> >  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> >  /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
> > +
> > +#define EXT4_DAX_FL			0x01000000 /* Inode is DAX */
> > +
> >  #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> >  #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> >  #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
> >  #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
> >  
> > -#define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
> > -#define EXT4_FL_USER_MODIFIABLE		0x604BC0FF /* User modifiable flags */
> > +#define EXT4_FL_USER_VISIBLE		0x715BDFFF /* User visible flags */
> > +#define EXT4_FL_USER_MODIFIABLE		0x614BC0FF /* User modifiable flags */
> 
> Hum, I think this was already mentioned but there are also definitions in
> include/uapi/linux/fs.h which should be kept in sync... Also if DAX flag
> gets modified through FS_IOC_SETFLAGS, we should call ext4_doncache() as
> well, shouldn't we?

Ah yea it was mentioned.  Sorry.

> 
> > @@ -802,6 +807,21 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
> >  	return error;
> >  }
> >  
> > +static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
> > +{
> > +	struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +	if (S_ISDIR(inode->i_mode))
> > +		return;
> > +
> > +	if (test_opt2(inode->i_sb, DAX_NEVER) ||
> > +	    test_opt(inode->i_sb, DAX_ALWAYS))
> > +		return;
> > +
> > +	if (((ei->i_flags ^ flags) & EXT4_DAX_FL) == EXT4_DAX_FL)
> > +		d_mark_dontcache(inode);
> > +}
> > +
> >  long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  {
> >  	struct inode *inode = file_inode(filp);
> > @@ -1267,6 +1287,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  			return err;
> >  
> >  		inode_lock(inode);
> > +
> > +		ext4_dax_dontcache(inode, flags);
> > +
> 
> I don't think we should set dontcache flag when setting of DAX flag fails -
> it could event be a security issue).

good point.

>
> So I think you'll have to check
> whether DAX flag is being changed,

ext4_dax_dontcache() does check if the flag is being changed.

> call vfs_ioc_fssetxattr_check(), and
> only if it succeeded and DAX flags was changing call ext4_dax_dontcache().

Yes I think it would be better to ensure all of the ioctl succeeds prior to
setting the don't cache.  The logic is easier to follow.

Ira

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
