Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1323452BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 00:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVXET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 19:04:19 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58552 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhCVXD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:03:56 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id F3D6D828CF4;
        Tue, 23 Mar 2021 10:03:52 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lOTaS-005cGK-1s; Tue, 23 Mar 2021 10:03:52 +1100
Date:   Tue, 23 Mar 2021 10:03:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
Message-ID: <20210322230352.GW63242@dread.disaster.area>
References: <20210322171118.446536-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322171118.446536-1-amir73il@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=UK19zw5Rb5foiGhwELMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:11:18PM +0200, Amir Goldstein wrote:
> Some filesystems on persistent storage backend use a digest of the
> filesystem's persistent uuid as the value for f_fsid returned by
> statfs(2).
> 
> xfs, as many other filesystem provide the non-persistent block device
> number as the value of f_fsid.
> 
> Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> for identifying objects using file_handle and f_fsid in events.

The filesystem id is encoded into the VFS filehandle - it does not
need some special external identifier to identify the filesystem it
belongs to....

> The xfs specific ioctl XFS_IOC_PATH_TO_FSHANDLE similarly attaches an
> fsid to exported file handles, but it is not the same fsid exported
> via statfs(2) - it is a persistent fsid based on the filesystem's uuid.

To actually use that {fshandle,fhandle} tuple for anything
requires CAP_SYS_ADMIN. A user can read the fshandle, but it can't
use it for anything useful. i.e. it's use is entirely isolated to
the file handle interface for identifying the filesystem the handle
belongs to. This is messy, but XFS inherited this "fixed fsid"
interface from Irix filehandles and was needed to port
xfsdump/xfsrestore to Linux.  Realistically, it is not functionality
that should be duplicated/exposed more widely on Linux...

IMO, if fanotify needs a persistent filesystem ID on Linux, it
should be using something common across all filesystems from the
linux superblock, not deep dark internal filesystem magic. The
export interfaces that generate VFS (and NFS) filehandles already
have a persistent fsid associated with them, which may in fact be
the filesystem UUID in it's entirety.

The export-derived "filesystem ID" is what should be exported to
userspace in combination with the file handle to identify the fs the
handle belongs to because then you have consistent behaviour and a
change that invalidates the filehandle will also invalidate the
fshandle....

> Use the same persistent value for f_fsid, so object identifiers in
> fanotify events will describe the objects more uniquely.

It's not persistent as in "will never change". The moment a user
changes the XFS filesystem uuid, the f_fsid changes.

However, changing the uuid on XFS is an offline (unmounted)
operation, so there will be no fanotify marks present when it is
changed. Hence when it is remounted, there will be a new f_fsid
returned in statvfs(), just like what happens now, and all
applications dependent on "persistent" fsids (and persistent
filehandles for that matter) will now get ESTALE errors...

And, worse, mp->m_fixed_fsid (and XFS superblock UUIDs in general)
are not unique if you've got snapshots and they've been mounted via
"-o nouuid" to avoid XFS's duplicate uuid checking. This is one of
the reasons that the duplicate checking exists - so that fshandles
are unique and resolve to a single filesystem....

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Guys,
> 
> This change would be useful for fanotify users.
> Do you see any problems with that minor change of uapi?

Yes.

IMO, we shouldn't be making a syscall interface rely on the
undefined, filesystem specific behaviour a value some other syscall
exposes to userspace. This means the fsid has no defined or
standardised behaviour applications can rely on and can't be
guaranteed unique and unchanging by fanotify. This seems like a
lose-lose situation for everyone...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
