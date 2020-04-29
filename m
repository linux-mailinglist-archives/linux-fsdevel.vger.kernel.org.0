Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18011BD3B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD2EaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 00:30:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:50602 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgD2EaK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:30:10 -0400
IronPort-SDR: jYZu44eXIBWA/fryfc467h1uVuDbLuH3bhwiT52xp6J0v1AYh4DITp9+QJfXdz41VwkD2VZYPb
 cZIGfeUer8NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 21:30:09 -0700
IronPort-SDR: gHgCiSj+Hez8F35uvvT9L8FD60mHGRbRpB8J+xGO4FEygI0TT2sBHolNaIU2dFvZBlsLXX1z9G
 2OEDGXIQkZVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="294066666"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2020 21:30:08 -0700
Date:   Tue, 28 Apr 2020 21:30:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11.1] Documentation/dax: Update Usage section
Message-ID: <20200429043008.GA410031@iweiny-DESK2.sc.intel.com>
References: <20200428002142.404144-5-ira.weiny@intel.com>
 <20200428222145.409961-1-ira.weiny@intel.com>
 <28f97c0b-6c7f-7496-b57d-0342a4dcc0af@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f97c0b-6c7f-7496-b57d-0342a4dcc0af@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 07:21:18PM -0700, Randy Dunlap wrote:
> On 4/28/20 3:21 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Update the Usage section to reflect the new individual dax selection
> > functionality.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V11:
> > 	Minor changes from Darrick
> > 
> > Changes from V10:
> > 	Clarifications from Dave
> > 	Add '-c' to xfs_io examples
> > 
> > Changes from V9:
> > 	Fix missing ')'
> > 	Fix trialing '"'
> 
> trailing

Thanks

> 
> > 
> > Changes from V8:
> > 	Updates from Darrick
> > 
> > Changes from V7:
> > 	Cleanups/clarifications from Darrick and Dan
> > 
> > Changes from V6:
> > 	Update to allow setting FS_XFLAG_DAX any time.
> > 	Update with list of behaviors from Darrick
> > 	https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> > 
> > Changes from V5:
> > 	Update to reflect the agreed upon semantics
> > 	https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > ---
> >  Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++-
> >  1 file changed, 139 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> > index 679729442fd2..dc1c1aa36cc2 100644
> > --- a/Documentation/filesystems/dax.txt
> > +++ b/Documentation/filesystems/dax.txt
> > @@ -17,11 +17,147 @@ For file mappings, the storage device is mapped directly into userspace.
> >  Usage
> >  -----
> >  
> > -If you have a block device which supports DAX, you can make a filesystem
> > +If you have a block device which supports DAX, you can make a file system
> >  on it as usual.  The DAX code currently only supports files with a block
> >  size equal to your kernel's PAGE_SIZE, so you may need to specify a block
> > -size when creating the filesystem.  When mounting it, use the "-o dax"
> > -option on the command line or add 'dax' to the options in /etc/fstab.
> > +size when creating the file system.
> > +
> > +Currently 3 filesystems support DAX: ext2, ext4 and xfs.  Enabling DAX on them
> 
> Why "file system" in the first paragraph when "filesystem" is used here and below?

AFAIK they are interchangeable.  https://en.wikipedia.org/wiki/File_system

But consistency is a reasonable request.

The rest of the doc (save 1 place) uses filesystem so I will adopt that here,
and clean up that 1 place.

> 
> > +is different.
> > +
> > +Enabling DAX on ext4 and ext2
> > +-----------------------------
> > +
> > +When mounting the filesystem, use the "-o dax" option on the command line or
> > +add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
> > +within the filesystem.  It is equivalent to the '-o dax=always' behavior below.
> > +
> > +
> > +Enabling DAX on xfs
> > +-------------------
> > +
> > +Summary
> > +-------
> > +
> > + 1. There exists an in-kernel file access mode flag S_DAX that corresponds to
> > +    the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
> > +    about this access mode.
> > +
> > + 2. There exists a persistent flag FS_XFLAG_DAX that can be applied to regular
> > +    files and directories. This advisory flag can be set or cleared at any
> > +    time, but doing so does not immediately affect the S_DAX state.
> > +
> > + 3. If the persistent FS_XFLAG_DAX flag is set on a directory, this flag will
> > +    be inherited by all regular files and subdirectories that are subsequently
> > +    created in this directory. Files and subdirectories that exist at the time
> > +    this flag is set or cleared on the parent directory are not modified by
> > +    this modification of the parent directory.
> > +
> > + 4. There exists dax mount options which can override FS_XFLAG_DAX in the
> 
>              exist

Ah yea,
Done.

> 
> > +    setting of the S_DAX flag.  Given underlying storage which supports DAX the
> > +    following hold:
> > +
> > +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> > +
> > +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> > +
> > +    "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
> > +
> > +    "-o dax"        is a legacy option which is an alias for "dax=always".
> > +		    This may be removed in the future so "-o dax=always" is
> > +		    the preferred method for specifying this behavior.
> > +
> > +    NOTE: Modifications to and the inheritance behavior of FS_XFLAG_DAX remain
> > +    the same even when the file system is mounted with a dax option.  However,
> > +    in-core inode state (S_DAX) will be overridden until the file system is
> 
>                                      "file system" (2 times above)

Done.

> 
> > +    remounted with dax=inode and the inode is evicted from kernel memory.
> > +
> > + 5. The S_DAX policy can be changed via:
> > +
> > +    a) Setting the parent directory FS_XFLAG_DAX as needed before files are
> > +       created
> > +
> > +    b) Setting the appropriate dax="foo" mount option
> > +
> > +    c) Changing the FS_XFLAG_DAX on existing regular files and directories.
> 
>                        FS_XFLAGS_DAX flag on

Done.

> 
> > +       This has runtime constraints and limitations that are described in 6)
> > +       below.
> > +
> > + 6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
> > +    the change in behaviour for existing regular files may not occur
> > +    immediately.  If the change must take effect immediately, the administrator
> > +    needs to:
> > +
> > +    a) stop the application so there are no active references to the data set
> > +       the policy change will affect
> > +
> > +    b) evict the data set from kernel caches so it will be re-instantiated when
> > +       the application is restarted. This can be achieved by:
> > +
> > +       i. drop-caches
> > +       ii. a filesystem unmount and mount cycle
> 
> filesystem

Done.

> 
> > +       iii. a system reboot
> > +
> > +
> > +Details
> > +-------
> > +
> > +There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
> > +and the other is a volatile flag indicating the active state of the feature
> > +(S_DAX).
> > +
> > +FS_XFLAG_DAX is preserved within the file system.  This persistent config
> 
> file system

Done.

> 
> > +setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
> > +(see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> > +
> > +New files and directories automatically inherit FS_XFLAG_DAX from
> > +their parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
> > +directory creation time can be used to set a default behavior for an entire
> > +sub-tree.
> > +
> > +To clarify inheritance, here are 3 examples:
> > +
> > +Example A:
> > +
> > +mkdir -p a/b/c
> > +xfs_io -c 'chattr +x' a
> > +mkdir a/b/c/d
> > +mkdir a/e
> > +
> > +	dax: a,e
> > +	no dax: b,c,d
> > +
> > +Example B:
> > +
> > +mkdir a
> > +xfs_io -c 'chattr +x' a
> > +mkdir -p a/b/c/d
> > +
> > +	dax: a,b,c,d
> > +	no dax:
> > +
> > +Example C:
> > +
> > +mkdir -p a/b/c
> > +xfs_io -c 'chattr +x' c
> > +mkdir a/b/c/d
> > +
> > +	dax: c,d
> > +	no dax: a,b
> > +
> > +
> > +The current enabled state (S_DAX) is set when a file inode is instantiated in
> > +memory by the kernel.  It is set based on the underlying media support, the
> > +value of FS_XFLAG_DAX and the file system's dax mount option.
> > +
> > +statx can be used to query S_DAX.  NOTE that only regular files will ever have
> > +S_DAX set and therefore statx will never indicate that S_DAX is set on
> > +directories.
> > +
> > +Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs even if
> 
>            the FS_XFLAG_DAX flag

Done.

> 
> > +the underlying media does not support dax and/or the file system is overridden
> 
> file system
> 
> Just be consistent, please.

Fair enough,
Done.

> 
> > +with a mount option.
> > +
> >  
> >  
> >  Implementation Tips for Block Driver Writers
> > 
> 
> thanks.

NP, Thank you!
Ira

> -- 
> ~Randy
> 
