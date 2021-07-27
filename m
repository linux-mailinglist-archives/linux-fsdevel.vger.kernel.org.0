Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692373D832D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhG0Wmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:42:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56918 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhG0Wme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:42:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBEE21E78;
        Tue, 27 Jul 2021 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vihpmn2uoW6kZkMJWdfOx9gWR0FQiyNFeIX6RH/tPsE=;
        b=cnEQe2j4Cfk4z+cT0/DTSCoA8HsDK23LYcZHSIFtsZsj4Gqkbyv44hDWtBnQaq7dBqjwi/
        XOkzuOrESpt8dPeEFYWNZ0j9noavvwMqKtpFtfFeRCZaK362EdTK4iXe5rwrIWn2bD7L5d
        ijiP8vUysS8ikbuwH9sPSEPA7elwD0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425753;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vihpmn2uoW6kZkMJWdfOx9gWR0FQiyNFeIX6RH/tPsE=;
        b=WVW8TUzL8L/T4o072uy0bIR/zei2PvXlKzV4Gh/qB8JGOBRXiFVuJHdGkNrvAX/kPp5YRQ
        uFwhOXaIKOMqGUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FEEE13A5D;
        Tue, 27 Jul 2021 22:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zXUnN9WLAGGCVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:42:29 +0000
Subject: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are long-standing problems with btrfs subvols, particularly in
relation to whether and how they are exposed in the mount table.

 - /proc/self/mountinfo reports the major:minor device number for each
    filesystem and when a btrfs subvol is explicitly mounted, the number
    reported is wrong - it does not match what stat() reports for the
    mountpoint.

 - when subvol are not explicitly mounted, they don't appear in
   mountinfo at all.

Consequences include that a tool which uses stat() to find the dev of the
filesystem, then searches mountinfo for that filesystem, will not find
it.

Some tools (e.g. findmnt) appear to have been enhanced to cope with this
strangeness, but it would be best to make btrfs behave more normally.

  - nfsd cannot currently see the transition to subvol, so reports the
    main volume and all subvols to the client as being in the same
    filesystem.  As inode numbers are not unique across all subvols,
    this can confuse clients.  In particular, 'find' is likely to report a
    loop.

subvols can be made to appear in mountinfo using automounts.  However
nfsd does not cope well with automounts.  It assumes all filesystems to
be exported are already mounted.  So adding automounts to btrfs would
break nfsd.

We can enhance nfsd to understand that some automounts can be managed.
"internal mounts" where a filesystem provides an automount point and
mounts its own directories, can be handled differently by nfsd.

This series addresses all these issues.  After a few enhancements to the
VFS to provide needed support, they enhance exportfs and nfsd to cope
with the concept of internal mounts, and then enhance btrfs to provide
them.

The NFSv3 support is incomplete.  I'm not sure we can make it work
"perfectly".  A normal nfsv3 mount seem to work well enough, but if
mounted with '-o noac', it loses track of the mounted-on inode number
and complains about inode numbers changing.

My basic test for these is to mount a btrfs filesystem which contains
subvols, nfs-export it and mount it with nfsv3 and nfsv4, then run
'find' in each of the filesystem and check the contents of
/proc/self/mountinfo.

The first patch simply fixes the dev number in mountinfo and could
possibly be tagged for -stable.

NeilBrown

---

NeilBrown (11):
      VFS: show correct dev num in mountinfo
      VFS: allow d_automount to create in-place bind-mount.
      VFS: pass lookup_flags into follow_down()
      VFS: export lookup_mnt()
      VFS: new function: mount_is_internal()
      nfsd: include a vfsmount in struct svc_fh
      exportfs: Allow filehandle lookup to cross internal mount points.
      nfsd: change get_parent_attributes() to nfsd_get_mounted_on()
      nfsd: Allow filehandle lookup to cross internal mount points.
      btrfs: introduce mapping function from location to inum
      btrfs: use automount to bind-mount all subvol roots.


 fs/btrfs/btrfs_inode.h   |  12 +++
 fs/btrfs/inode.c         | 111 ++++++++++++++++++++++++++-
 fs/btrfs/super.c         |   1 +
 fs/exportfs/expfs.c      | 100 ++++++++++++++++++++----
 fs/fhandle.c             |   2 +-
 fs/internal.h            |   1 -
 fs/namei.c               |   6 +-
 fs/namespace.c           |  32 +++++++-
 fs/nfsd/export.c         |   4 +-
 fs/nfsd/nfs3xdr.c        |  40 +++++++---
 fs/nfsd/nfs4proc.c       |   9 ++-
 fs/nfsd/nfs4xdr.c        | 106 ++++++++++++-------------
 fs/nfsd/nfsfh.c          |  44 +++++++----
 fs/nfsd/nfsfh.h          |   3 +-
 fs/nfsd/nfsproc.c        |   5 +-
 fs/nfsd/vfs.c            | 162 +++++++++++++++++++++++----------------
 fs/nfsd/vfs.h            |  12 +--
 fs/nfsd/xdr4.h           |   2 +-
 fs/overlayfs/namei.c     |   5 +-
 fs/xfs/xfs_ioctl.c       |  12 ++-
 include/linux/exportfs.h |   4 +-
 include/linux/mount.h    |   4 +
 include/linux/namei.h    |   2 +-
 23 files changed, 490 insertions(+), 189 deletions(-)

--
Signature

