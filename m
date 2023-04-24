Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48806ED6EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjDXVsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjDXVsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:48:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54145589;
        Mon, 24 Apr 2023 14:48:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27AC81F8C4;
        Mon, 24 Apr 2023 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682372886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izNLqTt0+ai6rKUeam74EtFs20ltWq+WbOtisYgXzag=;
        b=Wuxksq/gWOB/8UZ97K/DWvDRtA1BJhp92y0fkK1if3keB0fwIjBMdByuWaTp6TfQmL9lRD
        VBIpitJiXUJwvAO1FCzAPnZ5/vlZIYkRJdnDfD4GYEiPlrBglXccmRsU0iFQ2iVVBugdLc
        MoXSmFZW5A+nSJ7i8Zh5njqOyFHuqHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682372886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izNLqTt0+ai6rKUeam74EtFs20ltWq+WbOtisYgXzag=;
        b=26F2BwuYbRoqII3Ad37NegS5xDpN2zX/pNn4IMDfA3jNDeI+p6Lufi7Wps1ML3jZZxNMQ3
        CemttHQ19Dyc/2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 468DF1390E;
        Mon, 24 Apr 2023 21:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rVzyORD5RmTQMwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Apr 2023 21:48:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Jan Kara" <jack@suse.cz>,
        "Amir Goldstein" <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode i_m/ctime
In-reply-to: <20230424151104.175456-2-jlayton@kernel.org>
References: <20230424151104.175456-1-jlayton@kernel.org>,
 <20230424151104.175456-2-jlayton@kernel.org>
Date:   Tue, 25 Apr 2023 07:47:57 +1000
Message-id: <168237287734.24821.11016713590413362200@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Apr 2023, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamp updates for filling out the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metaupdates, to around once per
> jiffy, even when a file is under heavy writes.
>=20
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> lot of exported filesystems don't properly support a change attribute
> and are subject to the same problems with timestamp granularity. Other
> applications have similar issues (e.g backup applications).
>=20
> Switching to always using fine-grained timestamps would improve the
> situation for NFS, but that becomes rather expensive, as the underlying
> filesystem will have to log a lot more metadata updates.
>=20
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried:
>=20
> Whenever the mtime changes, the ctime must also change since we're
> changing the metadata. When a superblock has a s_time_gran >1, we can
> use the lowest-order bit of the inode->i_ctime as a flag to indicate
> that the value has been queried. Then on the next write, we'll fetch a
> fine-grained timestamp instead of the usual coarse-grained one.

This assumes that any s_time_gran value greater then 1, is even.  This is
currently true in practice (it is always a power of 10 I think).
But should we have a WARN_ON_ONCE() somewhere just in case?

>=20
> We could enable this for any filesystem that has a s_time_gran >1, but
> for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesystems
> to opt-in to this behavior.
>=20
> It then adds a new current_ctime function that acts like the
> current_time helper, but will conditionally grab fine-grained timestamps
> when the flag is set in the current ctime. Also, there is a new
> generic_fill_multigrain_cmtime for grabbing the c/mtime out of the inode
> and atomically marking the ctime as queried.
>=20
> Later patches will convert filesystems over to this new scheme.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c         | 57 +++++++++++++++++++++++++++++++++++++++---
>  fs/stat.c          | 24 ++++++++++++++++++
>  include/linux/fs.h | 62 ++++++++++++++++++++++++++++++++--------------
>  3 files changed, 121 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f1355..4bd11bdb46d4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
>  static int inode_needs_update_time(struct inode *inode, struct timespec64 =
*now)
>  {
>  	int sync_it =3D 0;
> +	struct timespec64 ctime =3D inode->i_ctime;
> =20
>  	/* First try to exhaust all avenues to not sync */
>  	if (IS_NOCMTIME(inode))
> @@ -2038,7 +2039,9 @@ static int inode_needs_update_time(struct inode *inod=
e, struct timespec64 *now)
>  	if (!timespec64_equal(&inode->i_mtime, now))
>  		sync_it =3D S_MTIME;
> =20
> -	if (!timespec64_equal(&inode->i_ctime, now))
> +	if (is_multigrain_ts(inode))
> +		ctime.tv_nsec &=3D ~I_CTIME_QUERIED;
> +	if (!timespec64_equal(&ctime, now))
>  		sync_it |=3D S_CTIME;
> =20
>  	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
> @@ -2062,6 +2065,50 @@ static int __file_update_time(struct file *file, str=
uct timespec64 *now,
>  	return ret;
>  }
> =20
> +/**
> + * current_ctime - Return FS time (possibly high-res)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change.
> + *
> + * For a multigrain timestamp, if the timestamp is flagged as having been
> + * QUERIED, then get a fine-grained timestamp.
> + */
> +struct timespec64 current_ctime(struct inode *inode)
> +{
> +	struct timespec64 now;
> +	long nsec =3D 0;
> +	bool multigrain =3D is_multigrain_ts(inode);
> +
> +	if (multigrain) {
> +		atomic_long_t *pnsec =3D (atomic_long_t *)&inode->i_ctime.tv_nsec;
> +
> +		nsec =3D atomic_long_fetch_and(~I_CTIME_QUERIED, pnsec);

 atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec)  ??

> +	}
> +
> +	if (nsec & I_CTIME_QUERIED) {
> +		ktime_get_real_ts64(&now);
> +	} else {
> +		ktime_get_coarse_real_ts64(&now);
> +
> +		if (multigrain) {
> +			/*
> +			 * If we've recently fetched a fine-grained timestamp
> +			 * then the coarse-grained one may be earlier than the
> +			 * existing one. Just keep the existing ctime if so.
> +			 */
> +			struct timespec64 ctime =3D inode->i_ctime;
> +
> +			if (timespec64_compare(&ctime, &now) > 0)
> +				now =3D ctime;

I think this ctime could have the I_CTIME_QUERIED bit set.  We probably
don't want that ??


> +		}
> +	}
> +
> +	return timestamp_truncate(now, inode);
> +}
> +EXPORT_SYMBOL(current_ctime);
> +
>  /**
>   * file_update_time - update mtime and ctime time
>   * @file: file accessed
> @@ -2080,7 +2127,7 @@ int file_update_time(struct file *file)
>  {
>  	int ret;
>  	struct inode *inode =3D file_inode(file);
> -	struct timespec64 now =3D current_time(inode);
> +	struct timespec64 now =3D current_ctime(inode);
> =20
>  	ret =3D inode_needs_update_time(inode, &now);
>  	if (ret <=3D 0)
> @@ -2109,7 +2156,7 @@ static int file_modified_flags(struct file *file, int=
 flags)
>  {
>  	int ret;
>  	struct inode *inode =3D file_inode(file);
> -	struct timespec64 now =3D current_time(inode);
> +	struct timespec64 now =3D current_ctime(inode);
> =20
>  	/*
>  	 * Clear the security bits if the process is not being run by root.
> @@ -2419,9 +2466,11 @@ struct timespec64 timestamp_truncate(struct timespec=
64 t, struct inode *inode)
>  	if (unlikely(t.tv_sec =3D=3D sb->s_time_max || t.tv_sec =3D=3D sb->s_time=
_min))
>  		t.tv_nsec =3D 0;
> =20
> -	/* Avoid division in the common cases 1 ns and 1 s. */
> +	/* Avoid division in the common cases 1 ns, 2 ns and 1 s. */
>  	if (gran =3D=3D 1)
>  		; /* nothing */
> +	else if (gran =3D=3D 2)
> +		t.tv_nsec &=3D ~1L;
>  	else if (gran =3D=3D NSEC_PER_SEC)
>  		t.tv_nsec =3D 0;
>  	else if (gran > 1 && gran < NSEC_PER_SEC)
> diff --git a/fs/stat.c b/fs/stat.c
> index 7c238da22ef0..67b56daf9663 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,30 @@
>  #include "internal.h"
>  #include "mount.h"
> =20
> +/**
> + * generic_fill_multigrain_cmtime - Fill in the mtime and ctime and flag c=
time as QUERIED
> + * @inode: inode from which to grab the c/mtime
> + * @stat: where to store the resulting values
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will use a fine-grained timestamp.
> + */
> +void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat *sta=
t)
> +{
> +	atomic_long_t *pnsec =3D (atomic_long_t *)&inode->i_ctime.tv_nsec;
> +
> +	stat->mtime =3D inode->i_mtime;
> +	stat->ctime.tv_sec =3D inode->i_ctime.tv_sec;
> +	/*
> +	 * Atomically set the QUERIED flag and fetch the new value with
> +	 * the flag masked off.
> +	 */
> +	stat->ctime.tv_nsec =3D atomic_long_fetch_or(I_CTIME_QUERIED, pnsec)
> +					& ~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(generic_fill_multigrain_cmtime);
> +
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:	idmap of the mount the inode was found from
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..e6dd3ce051ef 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1059,21 +1059,22 @@ extern int send_sigurg(struct fown_struct *fown);
>   * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
>   * represented in both.
>   */
> -#define SB_RDONLY	 1	/* Mount read-only */
> -#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
> -#define SB_NODEV	 4	/* Disallow access to device special files */
> -#define SB_NOEXEC	 8	/* Disallow program execution */
> -#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
> -#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
> -#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
> -#define SB_NOATIME	1024	/* Do not update access times. */
> -#define SB_NODIRATIME	2048	/* Do not update directory access times */
> -#define SB_SILENT	32768
> -#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> -#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
> -#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
> -#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
> -#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
> +#define SB_RDONLY		(1<<0)	/* Mount read-only */

 BIT(0) ???

> +#define SB_NOSUID		(1<<1)	/* Ignore suid and sgid bits */

 BIT(1) ??

> +#define SB_NODEV		(1<<2)	/* Disallow access to device special files */
> +#define SB_NOEXEC		(1<<3)	/* Disallow program execution */
> +#define SB_SYNCHRONOUS		(1<<4)	/* Writes are synced at once */
> +#define SB_MANDLOCK		(1<<6)	/* Allow mandatory locks on an FS */
> +#define SB_DIRSYNC		(1<<7)	/* Directory modifications are synchronous */
> +#define SB_NOATIME		(1<<10)	/* Do not update access times. */
> +#define SB_NODIRATIME		(1<<11)	/* Do not update directory access times */
> +#define SB_SILENT		(1<<15)
> +#define SB_POSIXACL		(1<<16)	/* VFS does not apply the umask */
> +#define SB_INLINECRYPT		(1<<17)	/* Use blk-crypto for encrypted files */
> +#define SB_KERNMOUNT		(1<<22) /* this is a kern_mount call */
> +#define SB_I_VERSION		(1<<23) /* Update inode I_version field */
> +#define SB_MULTIGRAIN_TS	(1<<24) /* Use multigrain c/mtimes */
> +#define SB_LAZYTIME		(1<<25) /* Update the on-disk [acm]times lazily */
> =20
>  /* These sb flags are internal to the kernel */
>  #define SB_SUBMOUNT     (1<<26)

Why not align this one too?

> @@ -1457,7 +1458,8 @@ static inline bool fsuidgid_has_mapping(struct super_=
block *sb,
>  	       kgid_has_mapping(fs_userns, kgid);
>  }
> =20
> -extern struct timespec64 current_time(struct inode *inode);
> +struct timespec64 current_time(struct inode *inode);
> +struct timespec64 current_ctime(struct inode *inode);
> =20
>  /*
>   * Snapshotting support.
> @@ -2171,8 +2173,31 @@ enum file_time_flags {
>  	S_VERSION =3D 8,
>  };
> =20
> -extern bool atime_needs_update(const struct path *, struct inode *);
> -extern void touch_atime(const struct path *);
> +/*
> + * Multigrain timestamps
> + *
> + * Conditionally use fine-grained ctime and mtime timestamps
> + *
> + * When s_time_gran is >1, and SB_MULTIGRAIN_TS is set, use the lowest-ord=
er bit
> + * in the tv_nsec field as a flag to indicate that the value was recently =
queried
> + * and that the next update should use a fine-grained timestamp.
> + */
> +#define I_CTIME_QUERIED 1L
> +
> +static inline bool is_multigrain_ts(struct inode *inode)
> +{
> +	struct super_block *sb =3D inode->i_sb;
> +
> +	/*
> +	 * Warn if someone sets SB_MULTIGRAIN_TS, but doesn't turn down the ts
> +	 * granularity.
> +	 */
> +	return (sb->s_flags & SB_MULTIGRAIN_TS) &&
> +		!WARN_ON_ONCE(sb->s_time_gran =3D=3D 1);

 Maybe=20
		!WARN_ON_ONCE(sb->s_time_gran & SB_MULTIGRAIN_TS);
 ??

> +}
> +
> +bool atime_needs_update(const struct path *, struct inode *);
> +void touch_atime(const struct path *);
>  int inode_update_time(struct inode *inode, struct timespec64 *time, int fl=
ags);
> =20
>  static inline void file_accessed(struct file *file)
> @@ -2838,6 +2863,7 @@ extern void page_put_link(void *);
>  extern int page_symlink(struct inode *inode, const char *symname, int len);
>  extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
> +void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat *sta=
t);
>  void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, uns=
igned int);
> --=20
> 2.40.0
>=20
>=20


Looks generally sensible, thanks!

NeilBrown
