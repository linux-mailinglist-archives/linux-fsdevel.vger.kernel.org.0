Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4C1B69BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 01:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgDWX0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 19:26:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:28307 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgDWXZu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:25:50 -0400
IronPort-SDR: NY/DaHHx6kcAIjtH8BlH7FZRG2Zibt5NDxnE40wFPTxQqMTsKkVh3t/m/9cKmVyRFvgXkloqdZ
 /biMQZiGcLuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 16:25:49 -0700
IronPort-SDR: 1EcgloIQgpPWcznAFYVWwSsXC/s9d38eUqmnaIoqqxq+bOP5zW3if5UCZVVHHd5AZsfdYAwbJx
 s38Pw5Ssa34A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; 
   d="scan'208";a="430537672"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2020 16:25:49 -0700
Date:   Thu, 23 Apr 2020 16:25:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 04/11] Documentation/dax: Update Usage section
Message-ID: <20200423232548.GA4088835@iweiny-DESK2.sc.intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-5-ira.weiny@intel.com>
 <20200423222720.GS27860@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423222720.GS27860@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:27:20AM +1000, Dave Chinner wrote:
> On Wed, Apr 22, 2020 at 02:20:55PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Update the Usage section to reflect the new individual dax selection
> > functionality.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V9:
> > 	Fix missing ')'
> > 	Fix trialing '"'
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
> >  Documentation/filesystems/dax.txt | 164 +++++++++++++++++++++++++++++-
> >  1 file changed, 161 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> > index 679729442fd2..553712c5054e 100644
> > --- a/Documentation/filesystems/dax.txt
> > +++ b/Documentation/filesystems/dax.txt
> > @@ -17,11 +17,169 @@ For file mappings, the storage device is mapped directly into userspace.
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
> > + 2. There exists an advisory file inode flag FS_XFLAG_DAX that is
> > +    inherited from the parent directory FS_XFLAG_DAX inode flag at file
> > +    creation time.  This advisory flag can be set or cleared at any
> > +    time, but doing so does not immediately affect the S_DAX state.
> 
> This needs to make it clear that the inheritance behaviour of this
> flag affects both newly created regular files and sub-directories,
> but no other types of directory entries.

Done.

> 
> > +
> > +    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
> > +    and the fs is on pmem then it will enable S_DAX at inode load time;
> > +    if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> 
> This is item 3), and needs to state that it is specific to regular
> files as DAX is not a method that can be used to access the
> directory structure.

In 1) S_DAX was defined as being a "file" access mode flag.  I could add
explicit verbiage in 1 to clarify that?

> 
> Also "at inode load time" doesn't really mean anything useful to
> users. "when the inode is instantiated in memory by the kernel" is
> what you really mean, and given that 5(c) talks about "the kernel
> evicts the inode from memory", we really need to use consistent
> terminology here so that it's clear to users that the behaviours are
> related.


> 
> > +
> > + 3. There exists a dax= mount option.
> > +
> > +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> > +
> > +    "-o dax=always" means "always set S_DAX (at least on pmem),
> > +                    and ignore FS_XFLAG_DAX."
> > +
> > +    "-o dax"        is an alias for "dax=always".
> 
> "Legacy option that is an alias for "dax=always". This may be
> deprecated and removed in future, so "dax=always" is the preferred
> method for specifying this behaviour."

Done.

> 
> > +
> > +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> > +
> > + 4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
> > +    be set or cleared at any time.  The flag state is inherited by any files or
> > +    subdirectories when they are created within that directory.
> 
> This should be item 2, so that it is defined before it is referenced
> by the current item 2 in the list.

Done.

> 
> > +
> > + 5. Programs that require a specific file access mode (DAX or not DAX)
> > +    can do one of the following:
> > +
> > +    (a) Create files in directories that the FS_XFLAG_DAX flag set as
> > +        needed; or
> 
> 	(a) Set the parent directory FS_XFLAG_DAX as needed before
> 	files are created; or

Done.

> 
> > +    (b) Have the administrator set an override via mount option; or
> 
> 	(b) Have the administrator set the desired behaviour via
> 	mount option; or

Done.

> 
> > +    (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
> > +        must then cause the kernel to evict the inode from memory.  This
> > +        can be done by:
> > +
> > +        i>  Closing the file and re-opening the file and using statx to
> > +            see if the fs has changed the S_DAX flag; and
> 
> That will almost never work by itself as the cached dentry will
> still pin the inode. Suggesting it will lead to people implementing
> dumb loops where they open/check/close/sleep because they....

loops which ...  will keep loading the inode into the cache...  yea...  :-(

> 
> > +        ii> If the file still does not have the desired S_DAX access
> > +            mode, either unmount and remount the filesystem, or close
> > +            the file and use drop_caches.
> 
> .... don't have permissions to do either of these things...
> 
> Essentially, you may as well say "reboot the machine" at this point,
> because it's effectively the same thing from a production workload
> point of view...
> 
> Realistically, I'm not sure we should even say "programs must cause
> eviction", because that's something they cannot do directly without
> admin privileges nor is it something we want to occur randomly on
> production machines during production. i.e. this is something that
> should only be done in scheduled downtime by an administrator, not
> attempted by applications because DAX isn't immediately available.
> The admin is in charge here, not the "program".

I agree with everything you say.

But I feel a bit stuck here.  Without some type of documentation we are not
allowing FS_XFLAG_DAX to be changed on a file by the user.  Which is what we
were proposing before and we all disliked.

So I feel like we need to say something about getting the inodes evicted.
perhaps by a 'drop cache' even requested of the admin???

Maybe this?


 4. Programs that require a specific file access mode (DAX or not DAX)
    can do one of the following:

    (a) Set the parent directory FS_XFLAG_DAX as needed before file are
        created; or

    (b) Have the administrator set the desired behaviour via mount option; or

    (c) Set or clear the file's FS_XFLAG_DAX flag as needed and wait for the
        inode to be evicted from memory.

        i> the only effective way of ensuring this is to request the admin drop
           the file system caches.


> 
> > + 6. It is expected that users who want to squeeze every last bit of performance
> > +    out of the particular rough and tumble bits of their storage will also be
> > +    exposed to the difficulties of what happens when the operating system can't
> > +    totally virtualize those hardware capabilities.  DAX is such a feature.
> 
> I don't think this adds any value. You may as well just say "caveat
> empor", but that's kinda implied by the fact a computer is
> involved..

Deleted.

> 
> > +
> > +
> > +Details
> > +-------
> > +
> > +There are 2 per-file dax flags.  One is a physical inode setting (FS_XFLAG_DAX)
> 
> s/physical/persistent/

Done.

> 
> > +and the other a currently enabled state (S_DAX).
> 
> the other is a volatile flag indicating the active state of the
> feature (S_DAX)

Done.

> 
> > +
> > +FS_XFLAG_DAX is maintained, on disk, on individual inodes.
> 
> This is implementation detail, not a requirement. The only
> requirement is that it is stored persistently by the filesystem.

removed.

> 
> > It is preserved
> > +within the file system.  This 'physical' config setting can be set using an
> > +ioctl and/or an application such as "xfs_io -c 'chattr [-+]x'".  Files and
> 
> s/physical/persistent/
> 
> ... can be set, cleared and/or queried use the FS_IOC_FS[GS]ETXATTR
> ioctl (see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> New files and ...

Done.

> 
> > +directories automatically inherit FS_XFLAG_DAX from their parent directory
> > +_when_ _created_.  Therefore, setting FS_XFLAG_DAX at directory creation time
> > +can be used to set a default behavior for an entire sub-tree.  (Doing so on the
> > +root directory acts to set a default for the entire file system.)
> 
> No need for () around the example, but regardless, I don't think
> this is a well thought out example. i.e.  setting it on an existing
> filesystem which already contains data will not affect the default
> behaviour of existing subdirectories or files. IOWs, it only sets the
> default behaviour when set on an -empty- filesystem because of the
> inheritance characteristics of the flag...

I did mention "at directory creation time" which in my mind when extended to
the root directory means when the file system is empty...  But I'll just remove
this example as it provide very little additional information.

> 
> > +The current enabled state (S_DAX) is set when a file inode is _loaded_ based on
> 
> instantiated in memoy by the kernel.

Done.

> 
> > +the underlying media support, the value of FS_XFLAG_DAX, and the file systems
> 
> no comma before "and".

Done.

> 
> > +dax mount option setting.  See below.
> > +
> > +statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
> > +set and therefore statx will never indicate that S_DAX is set on directories.
> > +
> > +NOTE: Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs
> > +even if the underlying media does not support dax and/or the file system is
> > +overridden with a mount option.
> > +
> > +
> > +Overriding FS_XFLAG_DAX (dax= mount option)
> > +-------------------------------------------
> > +
> > +There exists a dax mount option.  Using the mount option does not change the
> > +physical configured state of individual files but overrides the S_DAX operating
> > +state when inodes are loaded.
> > +
> > +Given underlying media support, the dax mount option is a tri-state option
> > +(never, always, inode) with the following meanings:
> > +
> > +   "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
> > +   "-o dax=always" means "always set S_DAX, ignore FS_XFLAG_DAX"
> > +        "-o dax" by itself means "dax=always" to remain compatible with older
> > +	         kernels
> > +   "-o dax=inode" means "follow FS_XFLAG_DAX"
> 
> This is just repeating what is in the definition section.

Removed.

> 
> > +The default state is 'inode'.  Given underlying media support, the following
> > +algorithm is used to determine the effective mode of the file S_DAX on a
> > +capable device.
> > +
> > +	S_DAX = FS_XFLAG_DAX;
> > +
> > +	if (dax_mount == "always")
> > +		S_DAX = true;
> > +	else if (dax_mount == "off")
> > +		S_DAX = false;
> > +
> > +To reiterate: Setting, and inheritance, continues to affect FS_XFLAG_DAX even
> > +while the file system is mounted with a dax override.  However, in-core inode
> > +state (S_DAX) will continue to be overridden until the filesystem is remounted
> > +with dax=inode and the inode is evicted.
> 
> Just put this last paragraph up in the "behavioural definitions" and
> this whole section can go away.

Yep moved above.

To sum up the changes see the entire text below.
Ira


<quote>
Enabling DAX on xfs
-------------------

Summary
-------

 1. There exists an in-kernel file access mode flag S_DAX that corresponds to
    the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
    about this access mode.

 2. There exists a regular file and directory inode flag FS_XFLAG_DAX.  It is
    inherited from the parent directory FS_XFLAG_DAX inode flag at creation
    time.  This advisory flag can be set or cleared at any time, but doing so
    does not immediately affect the S_DAX state.

 3. There exists dax mount options which can override FS_XFLAG_DAX in the
    setting of the S_DAX flag.  Given underlying storage which supports DAX the
    following hold.

    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.

    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."

    "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."

    "-o dax"        is a legacy option which is an alias for "dax=always".
    		    This may be removed in the future so "-o dax=always" is
		    the preferred method for specifying this behavior.

    NOTE: Setting and inheritance affect FS_XFLAG_DAX at all times even when
    the file system is mounted with a dax option.  However, in-core inode
    state (S_DAX) will continue to be overridden until the file system is
    remounted with dax=inode and the inode is evicted.

 4. Programs that require a specific file access mode (DAX or not DAX)
    can do one of the following:

    (a) Set the parent directory FS_XFLAG_DAX as needed before file are
        created; or

    (b) Have the administrator set the desired behaviour via mount option; or

    (c) Set or clear the file's FS_XFLAG_DAX flag as needed and wait for the
        inode to be evicted from memory.

	i> the only effective way of ensuring this is to request the admin drop
	   the file system caches.


Details
-------

There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
and the other is a volatile flag indicating the active state of the feature
(S_DAX).

FS_XFLAG_DAX is preserved within the file system.  This persistent config
setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
(see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
'chattr [-+]x'".

New files and directories automatically inherit FS_XFLAG_DAX from
their parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
directory creation time can be used to set a default behavior for an entire
sub-tree.

To clarify inheritance here are 3 examples:

Example A:

mkdir -p a/b/c
xfs_io -c 'chattr +x' a
mkdir a/b/c/d
mkdir a/e

	dax: a,e
	no dax: b,c,d

Example B:

mkdir a
xfs_io -c 'chattr +x' a
mkdir -p a/b/c/d

	dax: a,b,c,d
	no dax:

Example C:

mkdir -p a/b/c
xfs_io -c 'chattr +x' c
mkdir a/b/c/d

	dax: c,d
	no dax: a,b


The current enabled state (S_DAX) is set when a file inode is instantiated in
memory by the kernel.  It is set based on the underlying media support, the
value of FS_XFLAG_DAX and the file systems dax mount option setting.

statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
set and therefore statx will never indicate that S_DAX is set on directories.

Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs even if
the underlying media does not support dax and/or the file system is overridden
with a mount option.

</quote>

