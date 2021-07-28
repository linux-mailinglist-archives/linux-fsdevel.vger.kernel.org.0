Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66CF3D9614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhG1Tfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 15:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhG1Tfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:35:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC6C061757;
        Wed, 28 Jul 2021 12:35:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BAC546C91; Wed, 28 Jul 2021 15:35:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BAC546C91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627500936;
        bh=+ubDzSENl39MUZIPXJcllRmY3lYjmwUKCDsj0PDkg4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6pK9ojWCkrR98kzMLRySGHNXaOC8domFNiLKDe9C4R+73FjE8De5OBwjGe/7Js61
         WVSJ9a/8YqpcB+C0AYk02CVYsyVuoIUKtMHb93Y/jbgUOO1anbGCpabk2k2brgyjCH
         oxklpoC/f/SUUJUVPoYV1eB8DS1qKaeqJDcwdRIM=
Date:   Wed, 28 Jul 2021 15:35:36 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210728193536.GD3152@fieldses.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm still stuck trying to understand why subvolumes can't get their own
superblocks:

	- Why are the performance issues Josef raises unsurmountable?
	  And why are they unique to btrfs?  (Surely there other cases
	  where people need hundreds or thousands of superblocks?)

	- If filehandle decoding can return a different vfs mount than
	  it's passed, why can't it return a different superblock?

--b.

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> There are long-standing problems with btrfs subvols, particularly in
> relation to whether and how they are exposed in the mount table.
> 
>  - /proc/self/mountinfo reports the major:minor device number for each
>     filesystem and when a btrfs subvol is explicitly mounted, the number
>     reported is wrong - it does not match what stat() reports for the
>     mountpoint.
> 
>  - when subvol are not explicitly mounted, they don't appear in
>    mountinfo at all.
> 
> Consequences include that a tool which uses stat() to find the dev of the
> filesystem, then searches mountinfo for that filesystem, will not find
> it.
> 
> Some tools (e.g. findmnt) appear to have been enhanced to cope with this
> strangeness, but it would be best to make btrfs behave more normally.
> 
>   - nfsd cannot currently see the transition to subvol, so reports the
>     main volume and all subvols to the client as being in the same
>     filesystem.  As inode numbers are not unique across all subvols,
>     this can confuse clients.  In particular, 'find' is likely to report a
>     loop.
> 
> subvols can be made to appear in mountinfo using automounts.  However
> nfsd does not cope well with automounts.  It assumes all filesystems to
> be exported are already mounted.  So adding automounts to btrfs would
> break nfsd.
> 
> We can enhance nfsd to understand that some automounts can be managed.
> "internal mounts" where a filesystem provides an automount point and
> mounts its own directories, can be handled differently by nfsd.
> 
> This series addresses all these issues.  After a few enhancements to the
> VFS to provide needed support, they enhance exportfs and nfsd to cope
> with the concept of internal mounts, and then enhance btrfs to provide
> them.
> 
> The NFSv3 support is incomplete.  I'm not sure we can make it work
> "perfectly".  A normal nfsv3 mount seem to work well enough, but if
> mounted with '-o noac', it loses track of the mounted-on inode number
> and complains about inode numbers changing.
> 
> My basic test for these is to mount a btrfs filesystem which contains
> subvols, nfs-export it and mount it with nfsv3 and nfsv4, then run
> 'find' in each of the filesystem and check the contents of
> /proc/self/mountinfo.
> 
> The first patch simply fixes the dev number in mountinfo and could
> possibly be tagged for -stable.
> 
> NeilBrown
> 
> ---
> 
> NeilBrown (11):
>       VFS: show correct dev num in mountinfo
>       VFS: allow d_automount to create in-place bind-mount.
>       VFS: pass lookup_flags into follow_down()
>       VFS: export lookup_mnt()
>       VFS: new function: mount_is_internal()
>       nfsd: include a vfsmount in struct svc_fh
>       exportfs: Allow filehandle lookup to cross internal mount points.
>       nfsd: change get_parent_attributes() to nfsd_get_mounted_on()
>       nfsd: Allow filehandle lookup to cross internal mount points.
>       btrfs: introduce mapping function from location to inum
>       btrfs: use automount to bind-mount all subvol roots.
> 
> 
>  fs/btrfs/btrfs_inode.h   |  12 +++
>  fs/btrfs/inode.c         | 111 ++++++++++++++++++++++++++-
>  fs/btrfs/super.c         |   1 +
>  fs/exportfs/expfs.c      | 100 ++++++++++++++++++++----
>  fs/fhandle.c             |   2 +-
>  fs/internal.h            |   1 -
>  fs/namei.c               |   6 +-
>  fs/namespace.c           |  32 +++++++-
>  fs/nfsd/export.c         |   4 +-
>  fs/nfsd/nfs3xdr.c        |  40 +++++++---
>  fs/nfsd/nfs4proc.c       |   9 ++-
>  fs/nfsd/nfs4xdr.c        | 106 ++++++++++++-------------
>  fs/nfsd/nfsfh.c          |  44 +++++++----
>  fs/nfsd/nfsfh.h          |   3 +-
>  fs/nfsd/nfsproc.c        |   5 +-
>  fs/nfsd/vfs.c            | 162 +++++++++++++++++++++++----------------
>  fs/nfsd/vfs.h            |  12 +--
>  fs/nfsd/xdr4.h           |   2 +-
>  fs/overlayfs/namei.c     |   5 +-
>  fs/xfs/xfs_ioctl.c       |  12 ++-
>  include/linux/exportfs.h |   4 +-
>  include/linux/mount.h    |   4 +
>  include/linux/namei.h    |   2 +-
>  23 files changed, 490 insertions(+), 189 deletions(-)
> 
> --
> Signature
