Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A223292A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbhCAUta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 15:49:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbhCAUrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:47:25 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lGpQg-000669-3l; Mon, 01 Mar 2021 20:46:10 +0000
Date:   Mon, 1 Mar 2021 21:46:08 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 39/40] xfs: support idmapped mounts
Message-ID: <20210301204608.ip7nowqh6fpztkhr@wittgenstein>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-40-christian.brauner@ubuntu.com>
 <20210301200520.GK7272@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210301200520.GK7272@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 12:05:20PM -0800, Darrick J. Wong wrote:
> On Thu, Jan 21, 2021 at 02:19:58PM +0100, Christian Brauner wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Enable idmapped mounts for xfs. This basically just means passing down
> > the user_namespace argument from the VFS methods down to where it is
> > passed to the relevant helpers.
> > 
> > Note that full-filesystem bulkstat is not supported from inside idmapped
> > mounts as it is an administrative operation that acts on the whole file
> > system. The limitation is not applied to the bulkstat single operation
> > that just operates on a single inode.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > 
> > /* v3 */
> > 
> > /* v4 */
> > 
> > /* v5 */
> > base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> > 
> > /* v6 */
> > unchanged
> > base-commit: 19c329f6808995b142b3966301f217c831e7cf31
> > ---
> >  fs/xfs/xfs_acl.c     |  3 +--
> >  fs/xfs/xfs_file.c    |  4 +++-
> >  fs/xfs/xfs_inode.c   | 26 +++++++++++++++--------
> >  fs/xfs/xfs_inode.h   | 16 +++++++++------
> >  fs/xfs/xfs_ioctl.c   | 35 ++++++++++++++++++-------------
> >  fs/xfs/xfs_ioctl32.c |  6 ++++--
> >  fs/xfs/xfs_iops.c    | 49 +++++++++++++++++++++++++-------------------
> >  fs/xfs/xfs_iops.h    |  3 ++-
> >  fs/xfs/xfs_itable.c  | 17 +++++++++++----
> >  fs/xfs/xfs_itable.h  |  1 +
> >  fs/xfs/xfs_qm.c      |  3 ++-
> >  fs/xfs/xfs_super.c   |  2 +-
> >  fs/xfs/xfs_symlink.c |  5 +++--
> >  fs/xfs/xfs_symlink.h |  5 +++--
> >  14 files changed, 110 insertions(+), 65 deletions(-)
> 
> <snip> Sorry for not noticing until after this went upstream, but...

No problem at all.

> 
> > diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
> > index 16ca97a7ff00..ca310a125d1e 100644
> > --- a/fs/xfs/xfs_itable.c
> > +++ b/fs/xfs/xfs_itable.c
> > @@ -54,10 +54,12 @@ struct xfs_bstat_chunk {
> >  STATIC int
> >  xfs_bulkstat_one_int(
> >  	struct xfs_mount	*mp,
> > +	struct user_namespace	*mnt_userns,
> >  	struct xfs_trans	*tp,
> >  	xfs_ino_t		ino,
> >  	struct xfs_bstat_chunk	*bc)
> >  {
> > +	struct user_namespace	*sb_userns = mp->m_super->s_user_ns;
> >  	struct xfs_icdinode	*dic;		/* dinode core info pointer */
> >  	struct xfs_inode	*ip;		/* incore inode pointer */
> >  	struct inode		*inode;
> > @@ -86,8 +88,8 @@ xfs_bulkstat_one_int(
> >  	 */
> >  	buf->bs_projectid = ip->i_d.di_projid;
> >  	buf->bs_ino = ino;
> > -	buf->bs_uid = i_uid_read(inode);
> > -	buf->bs_gid = i_gid_read(inode);
> > +	buf->bs_uid = from_kuid(sb_userns, i_uid_into_mnt(mnt_userns, inode));
> > +	buf->bs_gid = from_kgid(sb_userns, i_gid_into_mnt(mnt_userns, inode));
> >  	buf->bs_size = dic->di_size;
> >  
> >  	buf->bs_nlink = inode->i_nlink;
> > @@ -173,7 +175,8 @@ xfs_bulkstat_one(
> >  	if (!bc.buf)
> >  		return -ENOMEM;
> >  
> > -	error = xfs_bulkstat_one_int(breq->mp, NULL, breq->startino, &bc);
> > +	error = xfs_bulkstat_one_int(breq->mp, breq->mnt_userns, NULL,
> > +				     breq->startino, &bc);
> >  
> >  	kmem_free(bc.buf);
> >  
> > @@ -194,9 +197,10 @@ xfs_bulkstat_iwalk(
> >  	xfs_ino_t		ino,
> >  	void			*data)
> >  {
> > +	struct xfs_bstat_chunk	*bc = data;
> >  	int			error;
> >  
> > -	error = xfs_bulkstat_one_int(mp, tp, ino, data);
> > +	error = xfs_bulkstat_one_int(mp, bc->breq->mnt_userns, tp, ino, data);
> >  	/* bulkstat just skips over missing inodes */
> >  	if (error == -ENOENT || error == -EINVAL)
> >  		return 0;
> > @@ -239,6 +243,11 @@ xfs_bulkstat(
> >  	};
> >  	int			error;
> >  
> > +	if (breq->mnt_userns != &init_user_ns) {
> > +		xfs_warn_ratelimited(breq->mp,
> > +			"bulkstat not supported inside of idmapped mounts.");
> > +		return -EINVAL;
> 
> Shouldn't this be -EPERM?
> 
> Or -EOPNOTSUPP?

EOPNOTSUPP seems a good choice. Whether or not it's better than EINVAL I
don't know. With my userspace maintainer hat on I would probably say
that EOPNOTSUPP feels a bit more natural and might have the advantage
that it is less overloaded then EINVAL.

> 
> Also, I'm not sure why bulkstat won't work in an idmapped mount but
> bulkstat_single does?  You can use the singleton version to stat inodes
> that aren't inside the submount.

Christoph will very likely have a better informed opinion than I have
but as long as bulkstat is able to discern inodes that need to be
reported idmapped and inodes that don't then I see no reason why this
shouldn't work (at least for privileged users on the host which I think
is the case already).

In any case these changes, if any, aren't vfs changes and so you can
just take them as bugfixes through the xfs tree anyway. So no harm done
in you not spotting it earlier. :)

Thanks for taking another look!
Christian
