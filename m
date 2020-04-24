Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC61B6D99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 07:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgDXFzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 01:55:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:40659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgDXFzR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:55:17 -0400
IronPort-SDR: OTsL7GHDmk4IOlFPJ83MIa4CqvJUssd29nxNnaLHN5pwCaz41pHukT3NYNIvfQr0iLnnQfstY4
 zBT+w+zgJHtw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 22:55:17 -0700
IronPort-SDR: Wu2Yjz+iBs/lqXxpfWg5oqiMgwsxTdBMbyVV3M3en0Zx/O1+ymKy3bS2I+DKabJzGQWxyckY3f
 R9LOgGSUyKjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="280698972"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2020 22:55:17 -0700
Date:   Thu, 23 Apr 2020 22:55:16 -0700
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
Message-ID: <20200424055516.GD4088835@iweiny-DESK2.sc.intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-5-ira.weiny@intel.com>
 <20200423222720.GS27860@dread.disaster.area>
 <20200423232548.GA4088835@iweiny-DESK2.sc.intel.com>
 <20200424021516.GB2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424021516.GB2040@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:15:16PM +1000, Dave Chinner wrote:
> On Thu, Apr 23, 2020 at 04:25:48PM -0700, Ira Weiny wrote:

[snap]

> > > > +        ii> If the file still does not have the desired S_DAX access
> > > > +            mode, either unmount and remount the filesystem, or close
> > > > +            the file and use drop_caches.
> > > 
> > > .... don't have permissions to do either of these things...
> > > 
> > > Essentially, you may as well say "reboot the machine" at this point,
> > > because it's effectively the same thing from a production workload
> > > point of view...
> > > 
> > > Realistically, I'm not sure we should even say "programs must cause
> > > eviction", because that's something they cannot do directly without
> > > admin privileges nor is it something we want to occur randomly on
> > > production machines during production. i.e. this is something that
> > > should only be done in scheduled downtime by an administrator, not
> > > attempted by applications because DAX isn't immediately available.
> > > The admin is in charge here, not the "program".
> > 
> > I agree with everything you say.
> > 
> > But I feel a bit stuck here.  Without some type of documentation we are not
> > allowing FS_XFLAG_DAX to be changed on a file by the user.  Which is what we
> > were proposing before and we all disliked.
> 
> For production systems, the admin is the "user" we are taking about.
> The program itself shouldn't be choosing the method of file data
> access; that's up to the administrator in charge of the system to
> set the policy how they want it to be set.
> 
> i.e. there's a difference between the user/admin taking action to
> change a data access policy, and the application taking actions to
> override the policy that the admin has set.
> 
> What I'm trying to say is that setting/clearing the DAX flags is an
> -admin operation-, and part of the consideration of that admin
> operation is when the change should take effect.
> 
> i.e. refering to "programs" as if they control the access mode is
> entirely the wrong way to be looking at persistent inode flags. They
> are an administration policy mechanism that belongs to the data set,
> not the application (or "program"). Managing data set storage and
> access policy is something administrators do, not the application...

Ok.

> 
> > So I feel like we need to say something about getting the inodes evicted.
> > perhaps by a 'drop cache' even requested of the admin???
> > 
> > Maybe this?
> > 
> > 
> >  4. Programs that require a specific file access mode (DAX or not DAX)
> >     can do one of the following:
> > 
> >     (a) Set the parent directory FS_XFLAG_DAX as needed before file are
> >         created; or
> > 
> >     (b) Have the administrator set the desired behaviour via mount option; or
> > 
> >     (c) Set or clear the file's FS_XFLAG_DAX flag as needed and wait for the
> >         inode to be evicted from memory.
> > 
> >         i> the only effective way of ensuring this is to request the admin drop
> >            the file system caches.
> 
> 4. The DAX policy can be changed via:
> 
> 	a) Set the parent directory FS_XFLAG_DAX as needed before
> 	   files are created
> 
> 	b) Set the appropriate dax="foo" mount option
> 
> 	c) Change the FS_XFLAG_DAX on existing regular files and
> 	   directories. This has runtime constraints and limitations
> 	   that are described in 5) below.
> 
> 5. When changing the DAX policy via toggling the persistent
> FS_XFLAG_DAX flag, the change in behaviour for existing regular
> files may not occur immediately. If the change must take effect
> immediately, the administrator needs to:
> 
> 	1. stop the application so there are no active references to
> 	   the data set the policy change will affect
> 	2. evict the data set from kernel caches so it will be
> 	   re-instantiated when the application is restarted. This can
> 	   be acheived by:
> 		a. drop-caches
> 		b. a filesystem unmount and mount cycle
> 		c. a system reboot
> 
> Hence if DAX access policy changes are required to take immediate
> effect, scheduled system-wide downtime will be required to guarantee
> the new policy change takes effect when the application is
> restarted.
> 
> 
> > <quote>
> > Enabling DAX on xfs
> > -------------------
> > 
> > Summary
> > -------
> > 
> >  1. There exists an in-kernel file access mode flag S_DAX that corresponds to
> >     the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
> >     about this access mode.
> > 
> >  2. There exists a regular file and directory inode flag FS_XFLAG_DAX.  It is
> >     inherited from the parent directory FS_XFLAG_DAX inode flag at creation
> >     time.  This advisory flag can be set or cleared at any time, but doing so
> >     does not immediately affect the S_DAX state.
> 
> 2. There exists a persistent flag FS_XFLAG_DAX that can be applied to
> regular files and directories. This advisory flag can be set or
> cleared at any time, but doing so does not immediately affect the
> S_DAX state.

Done.

> 
> 3. If the persistent FS_XFLAG_DAX flag is set on a directory, this
> flag will be inherited by all regular files and sub directories that
> are subsequently created in this directory. Files and subdirectories
> that exist at the time this flag is set or cleared on the parent
> directory are not modified by this modification of the parent
> directory.
> 

Done.

> 
> > 
> >  3. There exists dax mount options which can override FS_XFLAG_DAX in the
> >     setting of the S_DAX flag.  Given underlying storage which supports DAX the
> >     following hold.
> > 
> >     "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> > 
> >     "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> > 
> >     "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
> > 
> >     "-o dax"        is a legacy option which is an alias for "dax=always".
> >     		    This may be removed in the future so "-o dax=always" is
> > 		    the preferred method for specifying this behavior.
> > 
> >     NOTE: Setting and inheritance affect FS_XFLAG_DAX at all times even when
> >     the file system is mounted with a dax option.  However, in-core inode
> >     state (S_DAX) will continue to be overridden until the file system is
> 
> s/continue to//

Done.

> 
> >     remounted with dax=inode and the inode is evicted.
> 
> evicted from kernel memory.

Done.

> 
> > 
> >  4. Programs that require a specific file access mode (DAX or not DAX)
> >     can do one of the following:
> > 
> >     (a) Set the parent directory FS_XFLAG_DAX as needed before file are
> >         created; or
> > 
> >     (b) Have the administrator set the desired behaviour via mount option; or
> > 
> >     (c) Set or clear the file's FS_XFLAG_DAX flag as needed and wait for the
> >         inode to be evicted from memory.
> > 
> > 	i> the only effective way of ensuring this is to request the admin drop
> > 	   the file system caches.
> 
> See my comments above.

Done. thanks!

> 
> > 
> > 
> > Details
> > -------
> > 
> > There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
> > and the other is a volatile flag indicating the active state of the feature
> > (S_DAX).
> > 
> > FS_XFLAG_DAX is preserved within the file system.  This persistent config
> > setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
> > (see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> > 'chattr [-+]x'".
> 
> Stray line.

Thanks for the review!  V11 should be out soon.

Ira

> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
