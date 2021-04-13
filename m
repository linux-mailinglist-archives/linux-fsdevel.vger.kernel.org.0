Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB09D35DA08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhDMI1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 04:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDMI1L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:27:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7981161242;
        Tue, 13 Apr 2021 08:26:43 +0000 (UTC)
Date:   Tue, 13 Apr 2021 10:26:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "alban@kinvolk.io" <alban@kinvolk.io>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "geofft@ldpreload.com" <geofft@ldpreload.com>,
        "hch@lst.de" <hch@lst.de>,
        "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lennart@poettering.net" <lennart@poettering.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mpatel@redhat.com" <mpatel@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>,
        "smbarber@chromium.org" <smbarber@chromium.org>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "tkjos@google.com" <tkjos@google.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>, "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Subject: Re: [PATCH v6 24/40] fs: make helpers idmap mount aware
Message-ID: <20210413082640.krcmqac6y2esuz24@wittgenstein>
References: <E901E25F-41FA-444D-B3C7-A7A786DDD5D5@tuxera.com>
 <CAHk-=wiXqbSgqzv53C98sbaHVqpc+c8NZTpXC7bBMQT3OznE4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXqbSgqzv53C98sbaHVqpc+c8NZTpXC7bBMQT3OznE4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 09:23:38AM -0700, Linus Torvalds wrote:
> On Mon, Apr 12, 2021 at 5:05 AM Anton Altaparmakov <anton@tuxera.com> wrote:
> >
> > Shouldn't that be using mnt_userns instead of &init_user_ns both for the setattr_prepare() and setattr_copy() calls?
> 
> It doesn't matter for a filesystem that hasn't marked itself as
> supporting idmaps.
> 
> If the filesystem doesn't set FS_ALLOW_IDMAP, then mnt_userns is
> always going to be &init_user_ns.
> 
> That said, I don't think you are wrong - it would probably be a good
> idea to pass down the 'mnt_userns' argument just to avoid confusion.
> But if you look at the history, you'll see that adding the mount
> namespace argument to the helper functions (like setattr_copy())
> happened before the actual "switch the filesystem setattr() function
> over to get the namespace argument".
> 
> So the current situation is partly an artifact of how the incremental
> filesystem changes were done.

I'm not so sure the complaint in the original mail is obviously valid.
Passing down mnt_userns through all filesystem codepaths at once
would've caused way more churn. There are filesystems that e.g. do stuff
like this:

<fstype>_create()
-> __<fstype>_internal_create()
<fstype>_mknod()
-> __<fstype>_internal_create()
<fstype>_rmdir()
-> __<fstype>_internal_create()

where __<fstype>_internal_create() was additionally called in a few
other places.
So instead of only changing <fstype>_<i_op> we would've now also have to
change __<fstype>_internal_create() which would've caused the fs
specific change to be more invasive than it needed to be. The way we
did it allowed us to keep the change legible.

And that's just a simple example.
There are fses that have more convoluted callpaths:
- an internal helper used additionally as a callback in a custom ops
  struct
- or most i_ops boiling down to a single internal function
So the choice was also deliberate.

We've also tried to be consistent when we actually pass down mnt_userns
further within the filesystem and when we simply use init_user_ns in
general. Just looking at setattr_copy() which was in the example:

                   attr.c:void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
                   attr.c:EXPORT_SYMBOL(setattr_copy);
                   btrfs/inode.c:          setattr_copy(&init_user_ns, inode, attr);
                   cifs/inode.c:   setattr_copy(&init_user_ns, inode, attrs);
                   cifs/inode.c:   setattr_copy(&init_user_ns, inode, attrs);
                   exfat/file.c:   setattr_copy(&init_user_ns, inode, attr);
                   ext2/inode.c:   setattr_copy(&init_user_ns, inode, iattr);
**FS_ALLOW_IDMAP** ext4/inode.c:           setattr_copy(mnt_userns, inode, attr);
                   f2fs/file.c:static void __setattr_copy(struct user_namespace *mnt_userns,
                   f2fs/file.c:#define __setattr_copy setattr_copy
                   f2fs/file.c:    __setattr_copy(&init_user_ns, inode, attr);
                   fat/file.c:      * setattr_copy can't truncate these appropriately, so we'll
**FS_ALLOW_IDMAP** fat/file.c:     setattr_copy(mnt_userns, inode, attr);
                   gfs2/inode.c:   setattr_copy(&init_user_ns, inode, attr);
                   hfs/inode.c:    setattr_copy(&init_user_ns, inode, attr);
                   hfsplus/inode.c:        setattr_copy(&init_user_ns, inode, attr);
                   hostfs/hostfs_kern.c:   setattr_copy(&init_user_ns, inode, attr);
                   hpfs/inode.c:   setattr_copy(&init_user_ns, inode, attr);
                   hugetlbfs/inode.c:      setattr_copy(&init_user_ns, inode, attr);
                   jfs/file.c:     setattr_copy(&init_user_ns, inode, iattr);
                   kernfs/inode.c: setattr_copy(&init_user_ns, inode, iattr);
**helper library** libfs.c:        setattr_copy(mnt_userns, inode, iattr);
                   minix/file.c:   setattr_copy(&init_user_ns, inode, attr);
                   nilfs2/inode.c: setattr_copy(&init_user_ns, inode, iattr);
                   ocfs2/dlmfs/dlmfs.c:    setattr_copy(&init_user_ns, inode, attr);
                   ocfs2/file.c:   setattr_copy(&init_user_ns, inode, attr);
                   omfs/file.c:    setattr_copy(&init_user_ns, inode, attr);
                   orangefs/inode.c:       setattr_copy(&init_user_ns, inode, iattr);
                   proc/base.c:    setattr_copy(&init_user_ns, inode, attr);
                   proc/generic.c: setattr_copy(&init_user_ns, inode, iattr);
                   proc/proc_sysctl.c:     setattr_copy(&init_user_ns, inode, attr);
                   ramfs/file-nommu.c:     setattr_copy(&init_user_ns, inode, ia);
                   reiserfs/inode.c:               setattr_copy(&init_user_ns, inode, attr);
                   sysv/file.c:    setattr_copy(&init_user_ns, inode, attr);
                   udf/file.c:     setattr_copy(&init_user_ns, inode, attr);
                   ufs/inode.c:    setattr_copy(&init_user_ns, inode, attr);
                   zonefs/super.c: setattr_copy(&init_user_ns, inode, iattr);

so we pass mnt_userns further down for all fses that have FS_ALLOW_IDMAP
set or where it's located in a helper library like libfs whose helpers
might be called by an idmapped mount aware fs.

When an fs is made aware of idmapped mounts the mnt_userns will
naturally be passed down further at which point the relevant fs
developer can decide how to restructure their own internal helpers
instead of vfs developers deciding these internals for them.

The xfs port is a good example where the xfs developers had - rightly so
- opinions on how they wanted the calling conventions for their internal
helpers to look like and how they wanted to pass around mnt_userns. I
don't feel in a position to mandate this from a vfs developers
perspective. I will happily provide input and express my opinion but the
authority of the vfs-calling-convention police mostly ends at the i_op
level.

Christian
