Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242051D8827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgERTX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 15:23:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:37755 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgERTX7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 15:23:59 -0400
IronPort-SDR: o6WqnFtRWw648yJnTBVCibxHDp978ah9IfTl/PdjB1Bp0Zway4EalNXQxG4ksLTrV+zWRI43p5
 JA1lDBJyFAMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 12:23:58 -0700
IronPort-SDR: NDhrWaw/AbgHFmGh0MuM+YO/qV5icHEW4Lug05Ae9xABBLnPruju/EyFUoO+cNd90Qjh+Kfqz4
 BGb2wi+tyEVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="282074584"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2020 12:23:57 -0700
Date:   Mon, 18 May 2020 12:23:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200518192357.GE3025231@iweiny-DESK2.sc.intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-4-ira.weiny@intel.com>
 <20200516020253.GG1009@sol.localdomain>
 <20200518050315.GA3025231@iweiny-DESK2.sc.intel.com>
 <20200518162447.GA954@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518162447.GA954@sol.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 09:24:47AM -0700, Eric Biggers wrote:
> On Sun, May 17, 2020 at 10:03:15PM -0700, Ira Weiny wrote:
> > On Fri, May 15, 2020 at 07:02:53PM -0700, Eric Biggers wrote:
> > > On Tue, May 12, 2020 at 10:43:18PM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > Encryption and DAX are incompatible.  Changing the DAX mode due to a
> > > > change in Encryption mode is wrong without a corresponding
> > > > address_space_operations update.
> > > > 
> > > > Make the 2 options mutually exclusive by returning an error if DAX was
> > > > set first.
> > > > 
> > > > Furthermore, clarify the documentation of the exclusivity and how that
> > > > will work.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > ---
> > > > Changes:
> > > > 	remove WARN_ON_ONCE
> > > > 	Add documentation to the encrypt doc WRT DAX
> > > > ---
> > > >  Documentation/filesystems/fscrypt.rst |  4 +++-
> > > >  fs/ext4/super.c                       | 10 +---------
> > > >  2 files changed, 4 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > > > index aa072112cfff..1475b8d52fef 100644
> > > > --- a/Documentation/filesystems/fscrypt.rst
> > > > +++ b/Documentation/filesystems/fscrypt.rst
> > > > @@ -1038,7 +1038,9 @@ astute users may notice some differences in behavior:
> > > >  - The ext4 filesystem does not support data journaling with encrypted
> > > >    regular files.  It will fall back to ordered data mode instead.
> > > >  
> > > > -- DAX (Direct Access) is not supported on encrypted files.
> > > > +- DAX (Direct Access) is not supported on encrypted files.  Attempts to enable
> > > > +  DAX on an encrypted file will fail.  Mount options will _not_ enable DAX on
> > > > +  encrypted files.
> > > >  
> > > >  - The st_size of an encrypted symlink will not necessarily give the
> > > >    length of the symlink target as required by POSIX.  It will actually
> > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > index bf5fcb477f66..9873ab27e3fa 100644
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -1320,7 +1320,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> > > >  	if (inode->i_ino == EXT4_ROOT_INO)
> > > >  		return -EPERM;
> > > >  
> > > > -	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
> > > > +	if (IS_DAX(inode))
> > > >  		return -EINVAL;
> > > >  
> > > >  	res = ext4_convert_inline_data(inode);
> > > > @@ -1344,10 +1344,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> > > >  			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
> > > >  			ext4_clear_inode_state(inode,
> > > >  					EXT4_STATE_MAY_INLINE_DATA);
> > > > -			/*
> > > > -			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
> > > > -			 * S_DAX may be disabled
> > > > -			 */
> > > >  			ext4_set_inode_flags(inode);
> > > >  		}
> > > >  		return res;
> > > > @@ -1371,10 +1367,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> > > >  				    ctx, len, 0);
> > > >  	if (!res) {
> > > >  		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
> > > > -		/*
> > > > -		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
> > > > -		 * S_DAX may be disabled
> > > > -		 */
> > > >  		ext4_set_inode_flags(inode);
> > > >  		res = ext4_mark_inode_dirty(handle, inode);
> > > >  		if (res)
> > > 
> > > I'm confused by the ext4_set_context() change.
> > > 
> > > ext4_set_context() is only called when FS_IOC_SET_ENCRYPTION_POLICY sets an
> > > encryption policy on an empty directory, *or* when a new inode (regular, dir, or
> > > symlink) is created in an encrypted directory (thus inheriting encryption from
> > > its parent).
> > 
> > I don't see the check which prevents FS_IOC_SET_ENCRYPTION_POLICY on a file?
> 
> It's in fscrypt_ioctl_set_policy().

I see...

> 
> > 
> > On inode creation, encryption will always usurp S_DAX...
> > 
> > > 
> > > So when is it reachable when IS_DAX()?  Is the issue that the DAX flag can now
> > > be set on directories?  The commit message doesn't seem to be talking about
> > > directories.  Is the behavior we want is that on an (empty) directory with the
> > > DAX flag set, FS_IOC_SET_ENCRYPTION_POLICY should fail with EINVAL?
> > 
> > We would want that but AFIAK S_DAX is never set on directories.  Perhaps this
> > is another place where S_DAX needs to be changed to the new inode flag?
> > However, this would not be appropriate at this point in the series.  At this
> > point in the series S_DAX is still set based on the mount option and I'm 99%
> > sure that only happens on regular files, not directories.  So I'm confused now.
> 
> S_DAX is only set by ext4_set_inode_flags() which only sets it on regular files.

Exactly...

> 
> > 
> > This is, AFAICS, not going to affect correctness.  It will only be confusing
> > because the user will be able to set both DAX and encryption on the directory
> > but files there will only see encryption being used...  :-(
> > 
> > Assuming you are correct about this call path only being valid on directories.
> > It seems this IS_DAX() needs to be changed to check for EXT4_DAX_FL in
> > "fs/ext4: Introduce DAX inode flag"?  Then at that point we can prevent DAX and
> > encryption on a directory.  ...  and at this point IS_DAX() could be removed at
> > this point in the series???
> 
> I haven't read the whole series, but if you are indeed trying to prevent a
> directory with EXT4_DAX_FL from being encrypted, then it does look like you'd
> need to check EXT4_DAX_FL, not S_DAX.

Yep.

> 
> The other question is what should happen when a file is created in an encrypted
> directory when the filesystem is mounted with -o dax.  Actually, I think I
> missed something there.  Currently (based on reading the code) the DAX flag will
> get set first, and then ext4_set_context()

See this is where I am confused.  Above you said that ext4_set_context() is only
called on a directory.  And I agree with you now having seen the check in
fscrypt_ioctl_set_policy().  So what is the call path you are speaking of here?

> will see IS_DAX() && i_size == 0 and
> clear the DAX flag when setting the encrypt flag.  So, the i_size == 0 check is
> actually needed.  Your patch (AFAICS) just makes creating an encrypted file fail
> when '-o dax'.  Is that intended?

Yes that is what I intended for this patch.  At this point in the series the
file system is either all DAX (-o dax) or not.  I did not comprehend the
directory vs regular file complexity with fscrypt.

It seems this patch should be removing the IS_DAX() check completely but I'm
still not sure if a regular file inode could be passed to ext4_set_context()
and I think we need to protect if it has IS_DAX() set if it does...

An alternate solution would be to drop this patch entirely and change the code
later in the series once EXT4_DAX_FL is defined...

But I'm not even clear where EXT4_ENCRYPT_FL is set...

Ira

> If not, maybe you should change it to check
> S_NEW instead of i_size == 0 to make it clearer?
> 
> - Eric
