Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350861B6B35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 04:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgDXCPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 22:15:25 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44843 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgDXCPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:15:24 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C523B3A2D70;
        Fri, 24 Apr 2020 12:15:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jRns4-0001a5-29; Fri, 24 Apr 2020 12:15:16 +1000
Date:   Fri, 24 Apr 2020 12:15:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 04/11] Documentation/dax: Update Usage section
Message-ID: <20200424021516.GB2040@dread.disaster.area>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-5-ira.weiny@intel.com>
 <20200423222720.GS27860@dread.disaster.area>
 <20200423232548.GA4088835@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423232548.GA4088835@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8
        a=ms1Rwlcf2buM8j6gsPQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 04:25:48PM -0700, Ira Weiny wrote:
> On Fri, Apr 24, 2020 at 08:27:20AM +1000, Dave Chinner wrote:
> > On Wed, Apr 22, 2020 at 02:20:55PM -0700, ira.weiny@intel.com wrote:
> > > +    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
> > > +    and the fs is on pmem then it will enable S_DAX at inode load time;
> > > +    if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> > 
> > This is item 3), and needs to state that it is specific to regular
> > files as DAX is not a method that can be used to access the
> > directory structure.
> 
> In 1) S_DAX was defined as being a "file" access mode flag.  I could add
> explicit verbiage in 1 to clarify that?

A "file" can mean a block device, a symlink, a FIFO, etc. If you are
talking about files containing -user data- then it is a "regular
file" and not just a "file". Making sitinctions like this mean it is
clear that S_DAX will not be set on directories and other types of
files in directories...

> > > +        ii> If the file still does not have the desired S_DAX access
> > > +            mode, either unmount and remount the filesystem, or close
> > > +            the file and use drop_caches.
> > 
> > .... don't have permissions to do either of these things...
> > 
> > Essentially, you may as well say "reboot the machine" at this point,
> > because it's effectively the same thing from a production workload
> > point of view...
> > 
> > Realistically, I'm not sure we should even say "programs must cause
> > eviction", because that's something they cannot do directly without
> > admin privileges nor is it something we want to occur randomly on
> > production machines during production. i.e. this is something that
> > should only be done in scheduled downtime by an administrator, not
> > attempted by applications because DAX isn't immediately available.
> > The admin is in charge here, not the "program".
> 
> I agree with everything you say.
> 
> But I feel a bit stuck here.  Without some type of documentation we are not
> allowing FS_XFLAG_DAX to be changed on a file by the user.  Which is what we
> were proposing before and we all disliked.

For production systems, the admin is the "user" we are taking about.
The program itself shouldn't be choosing the method of file data
access; that's up to the administrator in charge of the system to
set the policy how they want it to be set.

i.e. there's a difference between the user/admin taking action to
change a data access policy, and the application taking actions to
override the policy that the admin has set.

What I'm trying to say is that setting/clearing the DAX flags is an
-admin operation-, and part of the consideration of that admin
operation is when the change should take effect.

i.e. refering to "programs" as if they control the access mode is
entirely the wrong way to be looking at persistent inode flags. They
are an administration policy mechanism that belongs to the data set,
not the application (or "program"). Managing data set storage and
access policy is something administrators do, not the application...

> So I feel like we need to say something about getting the inodes evicted.
> perhaps by a 'drop cache' even requested of the admin???
> 
> Maybe this?
> 
> 
>  4. Programs that require a specific file access mode (DAX or not DAX)
>     can do one of the following:
> 
>     (a) Set the parent directory FS_XFLAG_DAX as needed before file are
>         created; or
> 
>     (b) Have the administrator set the desired behaviour via mount option; or
> 
>     (c) Set or clear the file's FS_XFLAG_DAX flag as needed and wait for the
>         inode to be evicted from memory.
> 
>         i> the only effective way of ensuring this is to request the admin drop
>            the file system caches.

4. The DAX policy can be changed via:

	a) Set the parent directory FS_XFLAG_DAX as needed before
	   files are created

	b) Set the appropriate dax="foo" mount option

	c) Change the FS_XFLAG_DAX on existing regular files and
	   directories. This has runtime constraints and limitations
	   that are described in 5) below.

5. When changing the DAX policy via toggling the persistent
FS_XFLAG_DAX flag, the change in behaviour for existing regular
files may not occur immediately. If the change must take effect
immediately, the administrator needs to:

	1. stop the application so there are no active references to
	   the data set the policy change will affect
	2. evict the data set from kernel caches so it will be
	   re-instantiated when the application is restarted. This can
	   be acheived by:
		a. drop-caches
		b. a filesystem unmount and mount cycle
		c. a system reboot

Hence if DAX access policy changes are required to take immediate
effect, scheduled system-wide downtime will be required to guarantee
the new policy change takes effect when the application is
restarted.


> <quote>
> Enabling DAX on xfs
> -------------------
> 
> Summary
> -------
> 
>  1. There exists an in-kernel file access mode flag S_DAX that corresponds to
>     the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
>     about this access mode.
> 
>  2. There exists a regular file and directory inode flag FS_XFLAG_DAX.  It is
>     inherited from the parent directory FS_XFLAG_DAX inode flag at creation
>     time.  This advisory flag can be set or cleared at any time, but doing so
>     does not immediately affect the S_DAX state.

2. There exists a persistent flag FS_XFLAG_DAX that can be applied to
regular files and directories. This advisory flag can be set or
cleared at any time, but doing so does not immediately affect the
S_DAX state.

3. If the persistent FS_XFLAG_DAX flag is set on a directory, this
flag will be inherited by all regular files and sub directories that
are subsequently created in this directory. Files and subdirectories
that exist at the time this flag is set or cleared on the parent
directory are not modified by this modification of the parent
directory.


> 
>  3. There exists dax mount options which can override FS_XFLAG_DAX in the
>     setting of the S_DAX flag.  Given underlying storage which supports DAX the
>     following hold.
> 
>     "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> 
>     "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> 
>     "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
> 
>     "-o dax"        is a legacy option which is an alias for "dax=always".
>     		    This may be removed in the future so "-o dax=always" is
> 		    the preferred method for specifying this behavior.
> 
>     NOTE: Setting and inheritance affect FS_XFLAG_DAX at all times even when
>     the file system is mounted with a dax option.  However, in-core inode
>     state (S_DAX) will continue to be overridden until the file system is

s/continue to//

>     remounted with dax=inode and the inode is evicted.

evicted from kernel memory.

> 
>  4. Programs that require a specific file access mode (DAX or not DAX)
>     can do one of the following:
> 
>     (a) Set the parent directory FS_XFLAG_DAX as needed before file are
>         created; or
> 
>     (b) Have the administrator set the desired behaviour via mount option; or
> 
>     (c) Set or clear the file's FS_XFLAG_DAX flag as needed and wait for the
>         inode to be evicted from memory.
> 
> 	i> the only effective way of ensuring this is to request the admin drop
> 	   the file system caches.

See my comments above.

> 
> 
> Details
> -------
> 
> There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
> and the other is a volatile flag indicating the active state of the feature
> (S_DAX).
> 
> FS_XFLAG_DAX is preserved within the file system.  This persistent config
> setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
> (see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> 'chattr [-+]x'".

Stray line.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
