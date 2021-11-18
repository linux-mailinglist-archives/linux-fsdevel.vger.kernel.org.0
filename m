Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6825A455636
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 08:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbhKRICf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 03:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbhKRIC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:02:26 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B8C061200
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 23:59:24 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p2so11714995uad.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxQbOxx3ZpwH4aRXAUnKT4xbBtBALtrVRecKHEhBeTI=;
        b=n8NnFalaUhCosKhDfSTZ/BdBwCKkHBF8lMQcbw8Azy+UHOpwIIj3TLSANd9dVE72fq
         4k9LQTN6prVkomvhvuMFmF0ZCtkVdbFDPzTv8kn+vvYcGDISFUAW7aa4byy9iqRfb7ep
         qs3fNPa6x+H8ivDqYGqu3oclCNLzCFl8+2ERlEXdnbmJ4+moVeChx6xsWNEgcNitDbHE
         aDVH7diC1Zf21DReWGsXmfkmVzWPDvUyVCQ2AZoF5X3YWLTJdu4toOZMnmxHmGYRBDnq
         BFxILhpcIG0mGqPmrptLOEP1BHLzeAsLCRpGyyAov4IS2L0osSm72B3g+I1kCmkHJKOi
         DFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxQbOxx3ZpwH4aRXAUnKT4xbBtBALtrVRecKHEhBeTI=;
        b=tlc7y4FquXgG+YvTYqra6FzRKIq4mDfR27VEUItyW8woEymJiB8DX0zVJaFhC1tjkF
         wKFfHDmCjlyBk2KsC+FhPC/6ISKfirpOrahX9zIdsis0ZTafCR0Sx6VcTWT4qvaRJgOF
         08E4YEjHR6Ij7vG5xHsyIEgsXncwzSA22AYkOIzswDsC0S6ARW/Wlj92yF0wwQooVSZk
         gQVfTuaaoNn6DV3Ti+bcgpUTdsr+fddPyP74uvyu/J7sGMjl4tlFAC3O9cEg62JvD5Qz
         /ruVCb6ibWYyYNTLQRhGrE78/jB7jy21XU4ajlNOsqiuZGQg6F+VIuf+u5R/6Y4HIQqq
         DA3w==
X-Gm-Message-State: AOAM530DKHGLtwzYLoqJh9sOcl0xAk2QSOtsbt632eaqlPhtfICO6r+B
        FO8ztwxe+vXb+ti7ZDaqgmWrcwMWpRNXV+7FS2m6WLrFC1GSkQbR
X-Google-Smtp-Source: ABdhPJzMisD9vHQ3BkKJwNs23ZenX0uJVPOB9omsnLpqaIrRAKetxCQiViS00ulhfuM23ZIpUkBYlF7OxmH9y2WfFMI=
X-Received: by 2002:ab0:2041:: with SMTP id g1mr33435500ual.131.1637222363686;
 Wed, 17 Nov 2021 23:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <a64aa4af-67b1-536c-9bd0-7b34e6cc1abe@schaufler-ca.com>
In-Reply-To: <a64aa4af-67b1-536c-9bd0-7b34e6cc1abe@schaufler-ca.com>
From:   David Anderson <dvander@google.com>
Date:   Wed, 17 Nov 2021 23:59:12 -0800
Message-ID: <CA+FmFJCS+CnDmYw3cOCCjNVhMkq6+i6JaSjWAxjgV674_KZtLA@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        selinux@vger.kernel.org, paulmoore@microsoft.com,
        luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 11/16/2021 5:58 PM, David Anderson wrote:
> > Mark Salyzyn (3):
> >
> > By default, all access to the upper, lower and work directories is the
> > recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > checked against the caller's credentials.
>
> This isn't very clear. Are you saying that the security attributes
> of the upper, lower, and work directories are determined by the
> attributes of the process that mounted the filesystem? What is an
> "incoming access"? I'm sure that means something if you're steeped
> in the lore of overlayfs, but it isn't obvious to me.

(Sorry, hitting "Reply All" this time...)

Thanks for taking a look - Yes. An "incoming access" is the user
application security context accessing the filesystem.

> > If the principles of least privilege are applied for sepolicy, the
> > mounter's credentials might not overlap the credentials of the caller's
> > when accessing the overlayfs filesystem.
>
> I'm sorry, but I've tried pretty hard, and can't puzzle that one out.

If your sepolicy is designed to give processes minimal privileges (as ours is),
then "init" might lack privileges even though other processes have them. For
example, init can mount /x but not access /x/y/z. But, process XYZ can access
/x/y/z. In our system processes have no privileges to anything by default,
and permissions are granted as needed, as narrowly as possible.

> DAC privileges are not hierarchical. This doesn't make any sense.

Sorry, that was probably not the right word. The intent was to say that a
process with minimal DAC privileges might be able to access a file, but
a process with expansive DAC privileges might be denied access to the
same file due to MAC restrictions.

> I think I might have figured that one out, but in order to do so
> I have to make way too many assumptions about the earlier paragraph.
> Could you please try to explain what you're doing with more context?

Hopefully the above helps explain: overlayfs uses the mounter's privileges,
which does not work on a system where the mounter does not have a
superset of child processes' privileges. That's the crux of the issue and
I'll keep working on how it's communicated in the patch description.

-David

On Tue, Nov 16, 2021 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 11/16/2021 5:58 PM, David Anderson wrote:
> > Mark Salyzyn (3):
> >    Add flags option to get xattr method paired to __vfs_getxattr
> >    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> >    overlayfs: override_creds=off option bypass creator_cred
> >
> > Mark Salyzyn + John Stultz (1):
> >    overlayfs: inode_owner_or_capable called during execv
> >
> > The first three patches address fundamental security issues that should
> > be solved regardless of the override_creds=off feature.
> >
> > The fourth adds the feature depends on these other fixes.
> >
> > By default, all access to the upper, lower and work directories is the
> > recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > checked against the caller's credentials.
>
> This isn't very clear. Are you saying that the security attributes
> of the upper, lower, and work directories are determined by the
> attributes of the process that mounted the filesystem? What is an
> "incoming access"? I'm sure that means something if you're steeped
> in the lore of overlayfs, but it isn't obvious to me.
>
> > If the principles of least privilege are applied for sepolicy, the
> > mounter's credentials might not overlap the credentials of the caller's
> > when accessing the overlayfs filesystem.
>
> I'm sorry, but I've tried pretty hard, and can't puzzle that one out.
>
> >    For example, a file that a
> > lower DAC privileged caller can execute, is MAC denied to the
> > generally higher DAC privileged mounter, to prevent an attack vector.
>
> DAC privileges are not hierarchical. This doesn't make any sense.
>
> > We add the option to turn off override_creds in the mount options; all
> > subsequent operations after mount on the filesystem will be only the
> > caller's credentials.
>
> I think I might have figured that one out, but in order to do so
> I have to make way too many assumptions about the earlier paragraph.
> Could you please try to explain what you're doing with more context?
>
> >    The module boolean parameter and mount option
> > override_creds is also added as a presence check for this "feature",
> > existence of /sys/module/overlay/parameters/overlay_creds
> >
> > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > Signed-off-by: David Anderson <dvander@google.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: kernel-team@android.com
> > Cc: selinux@vger.kernel.org
> > Cc: paulmoore@microsoft.com
> > Cc: Luca.Boccassi@microsoft.com
> >
> > ---
> >
> > v19
> > - rebase.
> >
> > v18
> > - rebase + fix minor cut and paste error for inode argument in __vfs_getxattr
> >
> > v17
> > - correct some zero-day build failures.
> > - fix up documentation
> >
> > v16
> > - rebase and merge of two patches.
> > - add adjustment to deal with execv when overrides is off.
> >
> > v15
> > - Revert back to v4 with fixes from on the way from v5-v14. The single
> >    structure argument passing to address the complaints about too many
> >    arguments was rejected by the community.
> > - Drop the udner discussion fix for an additional CAP_DAC_READ_SEARCH
> >    check. Can address that independently.
> > - ToDo: upstream test frame for thes security fixes (currently testing
> >    is all in Android).
> >
> > v14:
> > - Rejoin, rebase and a few adjustments.
> >
> > v13:
> > - Pull out first patch and try to get it in alone feedback, some
> >    Acks, and then <crickets> because people forgot why we were doing i.
> >
> > v12:
> > - Restore squished out patch 2 and 3 in the series,
> >    then change algorithm to add flags argument.
> >    Per-thread flag is a large security surface.
> >
> > v11:
> > - Squish out v10 introduced patch 2 and 3 in the series,
> >    then and use per-thread flag instead for nesting.
> > - Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
> > - Add sb argument to ovl_revert_creds to match future work.
> >
> > v10:
> > - Return NULL on CAP_DAC_READ_SEARCH
> > - Add __get xattr method to solve sepolicy logging issue
> > - Drop unnecessary sys_admin sepolicy checking for administrative
> >    driver internal xattr functions.
> >
> > v6:
> > - Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
> > - Do better with the documentation, drop rationalizations.
> > - pr_warn message adjusted to report consequences.
> >
> > v5:
> > - beefed up the caveats in the Documentation
> > - Is dependent on
> >    "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
> >    "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
> > - Added prwarn when override_creds=off
> >
> > v4:
> > - spelling and grammar errors in text
> >
> > v3:
> > - Change name from caller_credentials / creator_credentials to the
> >    boolean override_creds.
> > - Changed from creator to mounter credentials.
> > - Updated and fortified the documentation.
> > - Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS
> >
> > v2:
> > - Forward port changed attr to stat, resulting in a build error.
> > - altered commit message.
> >
> > David Anderson (4):
> >    Add flags option to get xattr method paired to __vfs_getxattr
> >    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> >    overlayfs: override_creds=off option bypass creator_cred
> >    overlayfs: inode_owner_or_capable called during execv
> >
> >   Documentation/filesystems/locking.rst   |  2 +-
> >   Documentation/filesystems/overlayfs.rst | 26 ++++++++++++++-
> >   fs/9p/acl.c                             |  3 +-
> >   fs/9p/xattr.c                           |  3 +-
> >   fs/afs/xattr.c                          | 10 +++---
> >   fs/attr.c                               |  2 +-
> >   fs/btrfs/xattr.c                        |  3 +-
> >   fs/ceph/xattr.c                         |  3 +-
> >   fs/cifs/xattr.c                         |  2 +-
> >   fs/ecryptfs/inode.c                     |  6 ++--
> >   fs/ecryptfs/mmap.c                      |  5 +--
> >   fs/erofs/xattr.c                        |  3 +-
> >   fs/ext2/xattr_security.c                |  2 +-
> >   fs/ext2/xattr_trusted.c                 |  2 +-
> >   fs/ext2/xattr_user.c                    |  2 +-
> >   fs/ext4/xattr_hurd.c                    |  2 +-
> >   fs/ext4/xattr_security.c                |  2 +-
> >   fs/ext4/xattr_trusted.c                 |  2 +-
> >   fs/ext4/xattr_user.c                    |  2 +-
> >   fs/f2fs/xattr.c                         |  4 +--
> >   fs/fuse/xattr.c                         |  4 +--
> >   fs/gfs2/xattr.c                         |  3 +-
> >   fs/hfs/attr.c                           |  2 +-
> >   fs/hfsplus/xattr.c                      |  3 +-
> >   fs/hfsplus/xattr_security.c             |  3 +-
> >   fs/hfsplus/xattr_trusted.c              |  3 +-
> >   fs/hfsplus/xattr_user.c                 |  3 +-
> >   fs/inode.c                              |  7 +++--
> >   fs/internal.h                           |  3 +-
> >   fs/jffs2/security.c                     |  3 +-
> >   fs/jffs2/xattr_trusted.c                |  3 +-
> >   fs/jffs2/xattr_user.c                   |  3 +-
> >   fs/jfs/xattr.c                          |  5 +--
> >   fs/kernfs/inode.c                       |  3 +-
> >   fs/nfs/nfs4proc.c                       |  9 ++++--
> >   fs/ntfs3/xattr.c                        |  2 +-
> >   fs/ocfs2/xattr.c                        |  9 ++++--
> >   fs/open.c                               |  2 +-
> >   fs/orangefs/xattr.c                     |  3 +-
> >   fs/overlayfs/copy_up.c                  |  2 +-
> >   fs/overlayfs/dir.c                      | 17 +++++-----
> >   fs/overlayfs/file.c                     | 25 ++++++++-------
> >   fs/overlayfs/inode.c                    | 29 ++++++++---------
> >   fs/overlayfs/namei.c                    |  6 ++--
> >   fs/overlayfs/overlayfs.h                |  7 +++--
> >   fs/overlayfs/ovl_entry.h                |  1 +
> >   fs/overlayfs/readdir.c                  |  8 ++---
> >   fs/overlayfs/super.c                    | 34 ++++++++++++++++----
> >   fs/overlayfs/util.c                     | 13 ++++++--
> >   fs/posix_acl.c                          |  2 +-
> >   fs/reiserfs/xattr_security.c            |  3 +-
> >   fs/reiserfs/xattr_trusted.c             |  3 +-
> >   fs/reiserfs/xattr_user.c                |  3 +-
> >   fs/squashfs/xattr.c                     |  2 +-
> >   fs/ubifs/xattr.c                        |  3 +-
> >   fs/xattr.c                              | 42 +++++++++++++------------
> >   fs/xfs/xfs_xattr.c                      |  3 +-
> >   include/linux/lsm_hook_defs.h           |  3 +-
> >   include/linux/security.h                |  6 ++--
> >   include/linux/xattr.h                   |  6 ++--
> >   include/uapi/linux/xattr.h              |  7 +++--
> >   mm/shmem.c                              |  3 +-
> >   net/socket.c                            |  3 +-
> >   security/commoncap.c                    | 11 ++++---
> >   security/integrity/evm/evm_main.c       | 13 +++++---
> >   security/security.c                     |  5 +--
> >   security/selinux/hooks.c                | 19 ++++++-----
> >   security/smack/smack_lsm.c              | 18 ++++++-----
> >   68 files changed, 289 insertions(+), 167 deletions(-)
> >
