Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFB3D879F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhG1GEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 02:04:34 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:58950 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhG1GEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:04:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04465563|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0258471-0.000521062-0.973632;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.KrxbVWH_1627452269;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KrxbVWH_1627452269)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 28 Jul 2021 14:04:30 +0800
Date:   Wed, 28 Jul 2021 14:04:31 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-Reply-To: <20210728125819.6E52.409509F4@e16-tech.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown> <20210728125819.6E52.409509F4@e16-tech.com>
Message-Id: <20210728140431.D704.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patchset works well in 5.14-rc3.

1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed to
dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)

2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs is
not used.
/dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
/dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
/dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2

This is a visiual feature change for btrfs user.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/07/28

> Hi,
> 
> We no longer need the dummy inode(BTRFS_FIRST_FREE_OBJECTID - 1) in this
> patch serials?
> 
> I tried to backport it to 5.10.x, but it failed to work.
> No big modification in this 5.10.x backporting, and all modified pathes
> are attached.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/07/28
> 
> > There are long-standing problems with btrfs subvols, particularly in
> > relation to whether and how they are exposed in the mount table.
> > 
> >  - /proc/self/mountinfo reports the major:minor device number for each
> >     filesystem and when a btrfs subvol is explicitly mounted, the number
> >     reported is wrong - it does not match what stat() reports for the
> >     mountpoint.
> > 
> >  - when subvol are not explicitly mounted, they don't appear in
> >    mountinfo at all.
> > 
> > Consequences include that a tool which uses stat() to find the dev of the
> > filesystem, then searches mountinfo for that filesystem, will not find
> > it.
> > 
> > Some tools (e.g. findmnt) appear to have been enhanced to cope with this
> > strangeness, but it would be best to make btrfs behave more normally.
> > 
> >   - nfsd cannot currently see the transition to subvol, so reports the
> >     main volume and all subvols to the client as being in the same
> >     filesystem.  As inode numbers are not unique across all subvols,
> >     this can confuse clients.  In particular, 'find' is likely to report a
> >     loop.
> > 
> > subvols can be made to appear in mountinfo using automounts.  However
> > nfsd does not cope well with automounts.  It assumes all filesystems to
> > be exported are already mounted.  So adding automounts to btrfs would
> > break nfsd.
> > 
> > We can enhance nfsd to understand that some automounts can be managed.
> > "internal mounts" where a filesystem provides an automount point and
> > mounts its own directories, can be handled differently by nfsd.
> > 
> > This series addresses all these issues.  After a few enhancements to the
> > VFS to provide needed support, they enhance exportfs and nfsd to cope
> > with the concept of internal mounts, and then enhance btrfs to provide
> > them.
> > 
> > The NFSv3 support is incomplete.  I'm not sure we can make it work
> > "perfectly".  A normal nfsv3 mount seem to work well enough, but if
> > mounted with '-o noac', it loses track of the mounted-on inode number
> > and complains about inode numbers changing.
> > 
> > My basic test for these is to mount a btrfs filesystem which contains
> > subvols, nfs-export it and mount it with nfsv3 and nfsv4, then run
> > 'find' in each of the filesystem and check the contents of
> > /proc/self/mountinfo.
> > 
> > The first patch simply fixes the dev number in mountinfo and could
> > possibly be tagged for -stable.
> > 
> > NeilBrown
> > 
> > ---
> > 
> > NeilBrown (11):
> >       VFS: show correct dev num in mountinfo
> >       VFS: allow d_automount to create in-place bind-mount.
> >       VFS: pass lookup_flags into follow_down()
> >       VFS: export lookup_mnt()
> >       VFS: new function: mount_is_internal()
> >       nfsd: include a vfsmount in struct svc_fh
> >       exportfs: Allow filehandle lookup to cross internal mount points.
> >       nfsd: change get_parent_attributes() to nfsd_get_mounted_on()
> >       nfsd: Allow filehandle lookup to cross internal mount points.
> >       btrfs: introduce mapping function from location to inum
> >       btrfs: use automount to bind-mount all subvol roots.
> > 
> > 
> >  fs/btrfs/btrfs_inode.h   |  12 +++
> >  fs/btrfs/inode.c         | 111 ++++++++++++++++++++++++++-
> >  fs/btrfs/super.c         |   1 +
> >  fs/exportfs/expfs.c      | 100 ++++++++++++++++++++----
> >  fs/fhandle.c             |   2 +-
> >  fs/internal.h            |   1 -
> >  fs/namei.c               |   6 +-
> >  fs/namespace.c           |  32 +++++++-
> >  fs/nfsd/export.c         |   4 +-
> >  fs/nfsd/nfs3xdr.c        |  40 +++++++---
> >  fs/nfsd/nfs4proc.c       |   9 ++-
> >  fs/nfsd/nfs4xdr.c        | 106 ++++++++++++-------------
> >  fs/nfsd/nfsfh.c          |  44 +++++++----
> >  fs/nfsd/nfsfh.h          |   3 +-
> >  fs/nfsd/nfsproc.c        |   5 +-
> >  fs/nfsd/vfs.c            | 162 +++++++++++++++++++++++----------------
> >  fs/nfsd/vfs.h            |  12 +--
> >  fs/nfsd/xdr4.h           |   2 +-
> >  fs/overlayfs/namei.c     |   5 +-
> >  fs/xfs/xfs_ioctl.c       |  12 ++-
> >  include/linux/exportfs.h |   4 +-
> >  include/linux/mount.h    |   4 +
> >  include/linux/namei.h    |   2 +-
> >  23 files changed, 490 insertions(+), 189 deletions(-)
> > 
> > --
> > Signature
> 


