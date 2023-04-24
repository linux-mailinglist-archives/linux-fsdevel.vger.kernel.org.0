Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF336ED7F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjDXWbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDXWbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1757FA5FE;
        Mon, 24 Apr 2023 15:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 833F5629CE;
        Mon, 24 Apr 2023 22:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80191C4339C;
        Mon, 24 Apr 2023 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682375447;
        bh=jyjAcsUWhF9GTfszSQ5VAERblFAMH4Dhy92yeDWnrB8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RXADhHaCRTJkF4fsHrm6WPnDy4HcyOhFcFO/RxVo3qY1/eePfXe/zZVqjErNPQkwC
         XkVUkqN5oPb8o703+E8OqyIzphemgDffXwPVppgjTRTUHNUiRoBF/K/ccF2nfwzDZ6
         ILCQJsyVXjC1JYIW5Yv68UYIXeLfFtjn6q3GL6inf/+tXE1BELeexycnDdnKUuN7B8
         Z1/vFLOytZCRJ2SHw/Xb/DnfBh0xMsW9NVLrg4GGxdkljtE+YlrbcQDScoOdgeX94U
         7J3pNcZ8bhXupPgerJGtuX6g2pmcWctMVcVO0XMqXHVrkpmrTUMaSXePkgGS7P4PAn
         iJ76Do70OyCjQ==
Message-ID: <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Mon, 24 Apr 2023 18:30:45 -0400
In-Reply-To: <168237287734.24821.11016713590413362200@noble.neil.brown.name>
References: <20230424151104.175456-1-jlayton@kernel.org>
        , <20230424151104.175456-2-jlayton@kernel.org>
         <168237287734.24821.11016713590413362200@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-25 at 07:47 +1000, NeilBrown wrote:
> On Tue, 25 Apr 2023, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamp updates for filling out th=
e
> > ctime and mtime after a change. This has the benefit of allowing
> > filesystems to optimize away a lot metaupdates, to around once per
> > jiffy, even when a file is under heavy writes.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, =
a
> > lot of exported filesystems don't properly support a change attribute
> > and are subject to the same problems with timestamp granularity. Other
> > applications have similar issues (e.g backup applications).
> >=20
> > Switching to always using fine-grained timestamps would improve the
> > situation for NFS, but that becomes rather expensive, as the underlying
> > filesystem will have to log a lot more metadata updates.
> >=20
> > What we need is a way to only use fine-grained timestamps when they are
> > being actively queried:
> >=20
> > Whenever the mtime changes, the ctime must also change since we're
> > changing the metadata. When a superblock has a s_time_gran >1, we can
> > use the lowest-order bit of the inode->i_ctime as a flag to indicate
> > that the value has been queried. Then on the next write, we'll fetch a
> > fine-grained timestamp instead of the usual coarse-grained one.
>=20
> This assumes that any s_time_gran value greater then 1, is even.  This is
> currently true in practice (it is always a power of 10 I think).
> But should we have a WARN_ON_ONCE() somewhere just in case?
>=20
> >=20
> > We could enable this for any filesystem that has a s_time_gran >1, but
> > for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesyste=
ms
> > to opt-in to this behavior.
> >=20
> > It then adds a new current_ctime function that acts like the
> > current_time helper, but will conditionally grab fine-grained timestamp=
s
> > when the flag is set in the current ctime. Also, there is a new
> > generic_fill_multigrain_cmtime for grabbing the c/mtime out of the inod=
e
> > and atomically marking the ctime as queried.
> >=20
> > Later patches will convert filesystems over to this new scheme.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/inode.c         | 57 +++++++++++++++++++++++++++++++++++++++---
> >  fs/stat.c          | 24 ++++++++++++++++++
> >  include/linux/fs.h | 62 ++++++++++++++++++++++++++++++++--------------
> >  3 files changed, 121 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 4558dc2f1355..4bd11bdb46d4 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
> >  static int inode_needs_update_time(struct inode *inode, struct timespe=
c64 *now)
> >  {
> >  	int sync_it =3D 0;
> > +	struct timespec64 ctime =3D inode->i_ctime;
> > =20
> >  	/* First try to exhaust all avenues to not sync */
> >  	if (IS_NOCMTIME(inode))
> > @@ -2038,7 +2039,9 @@ static int inode_needs_update_time(struct inode *=
inode, struct timespec64 *now)
> >  	if (!timespec64_equal(&inode->i_mtime, now))
> >  		sync_it =3D S_MTIME;
> > =20
> > -	if (!timespec64_equal(&inode->i_ctime, now))
> > +	if (is_multigrain_ts(inode))
> > +		ctime.tv_nsec &=3D ~I_CTIME_QUERIED;
> > +	if (!timespec64_equal(&ctime, now))
> >  		sync_it |=3D S_CTIME;
> > =20
> >  	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
> > @@ -2062,6 +2065,50 @@ static int __file_update_time(struct file *file,=
 struct timespec64 *now,
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * current_ctime - Return FS time (possibly high-res)
> > + * @inode: inode.
> > + *
> > + * Return the current time truncated to the time granularity supported=
 by
> > + * the fs, as suitable for a ctime/mtime change.
> > + *
> > + * For a multigrain timestamp, if the timestamp is flagged as having b=
een
> > + * QUERIED, then get a fine-grained timestamp.
> > + */
> > +struct timespec64 current_ctime(struct inode *inode)
> > +{
> > +	struct timespec64 now;
> > +	long nsec =3D 0;
> > +	bool multigrain =3D is_multigrain_ts(inode);
> > +
> > +	if (multigrain) {
> > +		atomic_long_t *pnsec =3D (atomic_long_t *)&inode->i_ctime.tv_nsec;
> > +
> > +		nsec =3D atomic_long_fetch_and(~I_CTIME_QUERIED, pnsec);
>=20
>  atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec)  ??
>=20

I didn't realize that existed! Sure, I can make that change.

> > +	}
> > +
> > +	if (nsec & I_CTIME_QUERIED) {
> > +		ktime_get_real_ts64(&now);
> > +	} else {
> > +		ktime_get_coarse_real_ts64(&now);
> > +
> > +		if (multigrain) {
> > +			/*
> > +			 * If we've recently fetched a fine-grained timestamp
> > +			 * then the coarse-grained one may be earlier than the
> > +			 * existing one. Just keep the existing ctime if so.
> > +			 */
> > +			struct timespec64 ctime =3D inode->i_ctime;
> > +
> > +			if (timespec64_compare(&ctime, &now) > 0)
> > +				now =3D ctime;
>=20
> I think this ctime could have the I_CTIME_QUERIED bit set.  We probably
> don't want that ??
>=20
>=20

The timestamp_truncate below will take care of it.

> > +		}
> > +	}
> > +
> > +	return timestamp_truncate(now, inode);
> > +}
> > +EXPORT_SYMBOL(current_ctime);
> > +
> >  /**
> >   * file_update_time - update mtime and ctime time
> >   * @file: file accessed
> > @@ -2080,7 +2127,7 @@ int file_update_time(struct file *file)
> >  {
> >  	int ret;
> >  	struct inode *inode =3D file_inode(file);
> > -	struct timespec64 now =3D current_time(inode);
> > +	struct timespec64 now =3D current_ctime(inode);
> > =20
> >  	ret =3D inode_needs_update_time(inode, &now);
> >  	if (ret <=3D 0)
> > @@ -2109,7 +2156,7 @@ static int file_modified_flags(struct file *file,=
 int flags)
> >  {
> >  	int ret;
> >  	struct inode *inode =3D file_inode(file);
> > -	struct timespec64 now =3D current_time(inode);
> > +	struct timespec64 now =3D current_ctime(inode);
> > =20
> >  	/*
> >  	 * Clear the security bits if the process is not being run by root.
> > @@ -2419,9 +2466,11 @@ struct timespec64 timestamp_truncate(struct time=
spec64 t, struct inode *inode)
> >  	if (unlikely(t.tv_sec =3D=3D sb->s_time_max || t.tv_sec =3D=3D sb->s_=
time_min))
> >  		t.tv_nsec =3D 0;
> > =20
> > -	/* Avoid division in the common cases 1 ns and 1 s. */
> > +	/* Avoid division in the common cases 1 ns, 2 ns and 1 s. */
> >  	if (gran =3D=3D 1)
> >  		; /* nothing */
> > +	else if (gran =3D=3D 2)
> > +		t.tv_nsec &=3D ~1L;
> >  	else if (gran =3D=3D NSEC_PER_SEC)
> >  		t.tv_nsec =3D 0;
> >  	else if (gran > 1 && gran < NSEC_PER_SEC)
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 7c238da22ef0..67b56daf9663 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -26,6 +26,30 @@
> >  #include "internal.h"
> >  #include "mount.h"
> > =20
> > +/**
> > + * generic_fill_multigrain_cmtime - Fill in the mtime and ctime and fl=
ag ctime as QUERIED
> > + * @inode: inode from which to grab the c/mtime
> > + * @stat: where to store the resulting values
> > + *
> > + * Given @inode, grab the ctime and mtime out if it and store the resu=
lt
> > + * in @stat. When fetching the value, flag it as queried so the next w=
rite
> > + * will use a fine-grained timestamp.
> > + */
> > +void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat =
*stat)
> > +{
> > +	atomic_long_t *pnsec =3D (atomic_long_t *)&inode->i_ctime.tv_nsec;
> > +
> > +	stat->mtime =3D inode->i_mtime;
> > +	stat->ctime.tv_sec =3D inode->i_ctime.tv_sec;
> > +	/*
> > +	 * Atomically set the QUERIED flag and fetch the new value with
> > +	 * the flag masked off.
> > +	 */
> > +	stat->ctime.tv_nsec =3D atomic_long_fetch_or(I_CTIME_QUERIED, pnsec)
> > +					& ~I_CTIME_QUERIED;
> > +}
> > +EXPORT_SYMBOL(generic_fill_multigrain_cmtime);
> > +
> >  /**
> >   * generic_fillattr - Fill in the basic attributes from the inode stru=
ct
> >   * @idmap:	idmap of the mount the inode was found from
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c85916e9f7db..e6dd3ce051ef 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1059,21 +1059,22 @@ extern int send_sigurg(struct fown_struct *fown=
);
> >   * sb->s_flags.  Note that these mirror the equivalent MS_* flags wher=
e
> >   * represented in both.
> >   */
> > -#define SB_RDONLY	 1	/* Mount read-only */
> > -#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
> > -#define SB_NODEV	 4	/* Disallow access to device special files */
> > -#define SB_NOEXEC	 8	/* Disallow program execution */
> > -#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
> > -#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
> > -#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
> > -#define SB_NOATIME	1024	/* Do not update access times. */
> > -#define SB_NODIRATIME	2048	/* Do not update directory access times */
> > -#define SB_SILENT	32768
> > -#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> > -#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files *=
/
> > -#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
> > -#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
> > -#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
> > +#define SB_RDONLY		(1<<0)	/* Mount read-only */
>=20
>  BIT(0) ???
>=20

Even better. I'll revise it.

> > +#define SB_NOSUID		(1<<1)	/* Ignore suid and sgid bits */
>=20
>  BIT(1) ??
>=20
> > +#define SB_NODEV		(1<<2)	/* Disallow access to device special files */
> > +#define SB_NOEXEC		(1<<3)	/* Disallow program execution */
> > +#define SB_SYNCHRONOUS		(1<<4)	/* Writes are synced at once */
> > +#define SB_MANDLOCK		(1<<6)	/* Allow mandatory locks on an FS */
> > +#define SB_DIRSYNC		(1<<7)	/* Directory modifications are synchronous =
*/
> > +#define SB_NOATIME		(1<<10)	/* Do not update access times. */
> > +#define SB_NODIRATIME		(1<<11)	/* Do not update directory access times=
 */
> > +#define SB_SILENT		(1<<15)
> > +#define SB_POSIXACL		(1<<16)	/* VFS does not apply the umask */
> > +#define SB_INLINECRYPT		(1<<17)	/* Use blk-crypto for encrypted files =
*/
> > +#define SB_KERNMOUNT		(1<<22) /* this is a kern_mount call */
> > +#define SB_I_VERSION		(1<<23) /* Update inode I_version field */
> > +#define SB_MULTIGRAIN_TS	(1<<24) /* Use multigrain c/mtimes */
> > +#define SB_LAZYTIME		(1<<25) /* Update the on-disk [acm]times lazily *=
/
> > =20
> >  /* These sb flags are internal to the kernel */
> >  #define SB_SUBMOUNT     (1<<26)
>=20
> Why not align this one too?
>=20

Sure. I'll add that in for the next one.

> > @@ -1457,7 +1458,8 @@ static inline bool fsuidgid_has_mapping(struct su=
per_block *sb,
> >  	       kgid_has_mapping(fs_userns, kgid);
> >  }
> > =20
> > -extern struct timespec64 current_time(struct inode *inode);
> > +struct timespec64 current_time(struct inode *inode);
> > +struct timespec64 current_ctime(struct inode *inode);
> > =20
> >  /*
> >   * Snapshotting support.
> > @@ -2171,8 +2173,31 @@ enum file_time_flags {
> >  	S_VERSION =3D 8,
> >  };
> > =20
> > -extern bool atime_needs_update(const struct path *, struct inode *);
> > -extern void touch_atime(const struct path *);
> > +/*
> > + * Multigrain timestamps
> > + *
> > + * Conditionally use fine-grained ctime and mtime timestamps
> > + *
> > + * When s_time_gran is >1, and SB_MULTIGRAIN_TS is set, use the lowest=
-order bit
> > + * in the tv_nsec field as a flag to indicate that the value was recen=
tly queried
> > + * and that the next update should use a fine-grained timestamp.
> > + */
> > +#define I_CTIME_QUERIED 1L
> > +
> > +static inline bool is_multigrain_ts(struct inode *inode)
> > +{
> > +	struct super_block *sb =3D inode->i_sb;
> > +
> > +	/*
> > +	 * Warn if someone sets SB_MULTIGRAIN_TS, but doesn't turn down the t=
s
> > +	 * granularity.
> > +	 */
> > +	return (sb->s_flags & SB_MULTIGRAIN_TS) &&
> > +		!WARN_ON_ONCE(sb->s_time_gran =3D=3D 1);
>=20
>  Maybe=20
> 		!WARN_ON_ONCE(sb->s_time_gran & SB_MULTIGRAIN_TS);
>  ??
>=20

I'm not sure I understand what you mean here. We want to check whether
SB_MULTIGRAIN_TS is set in the flags, and that s_time_gran > 1. The
latter is required so that we have space for the I_CTIME_QUERIED flag.

If SB_MULTIGRAIN_TS is set, but the s_time_gran is too low, we want to
throw a warning (since something is clearly wrong).


> > +}
> > +
> > +bool atime_needs_update(const struct path *, struct inode *);
> > +void touch_atime(const struct path *);
> >  int inode_update_time(struct inode *inode, struct timespec64 *time, in=
t flags);
> > =20
> >  static inline void file_accessed(struct file *file)
> > @@ -2838,6 +2863,7 @@ extern void page_put_link(void *);
> >  extern int page_symlink(struct inode *inode, const char *symname, int =
len);
> >  extern const struct inode_operations page_symlink_inode_operations;
> >  extern void kfree_link(void *);
> > +void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat =
*stat);
> >  void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat=
 *);
> >  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
> >  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32,=
 unsigned int);
> > --=20
> > 2.40.0
> >=20
> >=20
>=20
>=20
> Looks generally sensible, thanks!
>=20

Thanks for taking a look! I think this has the potential to fix some
very long standing cache coherency issues in all NFS versions (v3 and
up).
--=20
Jeff Layton <jlayton@kernel.org>
