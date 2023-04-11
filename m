Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5326DDE8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDKOyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjDKOye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:54:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EAC3C3B;
        Tue, 11 Apr 2023 07:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DEA6280F;
        Tue, 11 Apr 2023 14:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF39C433D2;
        Tue, 11 Apr 2023 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681224871;
        bh=yabeQv2YXsln9+A4U/WF7gDOBnNuivtv0ge605jAWvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gKk6NqKlLmnyt+TruttglVTb3e8/mVYyKO91oqeIk9GpnY71WqWBSM5UOlecjQT9b
         ZtJhLFL3oo0iTWpzmnJ9F9kr2+q08aDcTQiXG2kaRtq94Y8qMQ2ASxK4TnuYjMt5+p
         zjQlOIP3DEXbU/ZvK2WYZBF3XLmKr3MX1j6dMJJbR641nNeQ3bYTdLXRhJ0PNaGBFr
         7VtKMzCy2nIz5Ln1cKWMYlb2TrORHrMRsWmVp063ZKdZMF7MpYr5oy6Kky+0AqjYEC
         OYJ236mqEFOcTUHm6lioE1SRs4UbG3hrDeGjO1jO8PkYdaXQrtCphYqXqsXWjnOFK3
         dSo89U3O3SLPw==
Message-ID: <99ed0a98587ab762dd5cdc1e81e4224936aa4808.camel@kernel.org>
Subject: Re: [RFC PATCH 1/3][RESEND] fs: add infrastructure for
 opportunistic high-res ctime/mtime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 11 Apr 2023 10:54:28 -0400
In-Reply-To: <20230411144232.GF360895@frogsfrogsfrogs>
References: <20230411143702.64495-1-jlayton@kernel.org>
         <20230411143702.64495-2-jlayton@kernel.org>
         <20230411144232.GF360895@frogsfrogsfrogs>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-11 at 07:42 -0700, Darrick J. Wong wrote:
> On Tue, Apr 11, 2023 at 10:37:00AM -0400, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamp updates for filling out th=
e
> > ctime and mtime after a change. This has the benefit of allowing
> > filesystems to optimize away metadata updates.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, =
a
> > lot of exported filesystems don't properly support a change attribute
> > and are subject to the same problem of timestamp granularity. Other
> > applications have similar issues (e.g backup applications).
> >=20
> > Switching to always using high resolution timestamps would improve the
> > situation for NFS, but that becomes rather expensive, as we'd have to
> > log a lot more metadata updates.
> >=20
> > This patch grabs a new i_state bit to use as a flag that filesystems ca=
n
> > set in their getattr routine to indicate that the mtime or ctime was
> > queried since it was last updated.
> >=20
> > It then adds a new current_cmtime function that acts like the
> > current_time helper, but will conditionally grab high-res timestamps
> > when the i_state flag is set in the inode.
> >=20
> > This allows NFS and other applications to reap the benefits of high-res
> > ctime and mtime timestamps, but at a substantially lower cost than
> > fetching them every time.
> >=20
> > Cc: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/inode.c         | 40 ++++++++++++++++++++++++++++++++++++++--
> >  fs/stat.c          | 10 ++++++++++
> >  include/linux/fs.h |  5 ++++-
> >  3 files changed, 52 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 4558dc2f1355..3630f67fd042 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2062,6 +2062,42 @@ static int __file_update_time(struct file *file,=
 struct timespec64 *now,
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * current_cmtime - Return FS time (possibly high-res)
> > + * @inode: inode.
> > + *
> > + * Return the current time truncated to the time granularity supported=
 by
> > + * the fs, as suitable for a ctime or mtime change. If something recen=
tly
> > + * fetched the ctime or mtime out of the inode via getattr, then get a
> > + * high-resolution timestamp.
> > + *
> > + * Note that inode and inode->sb cannot be NULL.
> > + * Otherwise, the function warns and returns coarse time without trunc=
ation.
> > + */
> > +struct timespec64 current_cmtime(struct inode *inode)
> > +{
> > +	struct timespec64 now;
> > +
> > +	if (unlikely(!inode->i_sb)) {
> > +		WARN(1, "%s() called with uninitialized super_block in the inode", _=
_func__);
> > +		ktime_get_coarse_real_ts64(&now);
> > +		return now;
> > +	}
> > +
> > +	/* Do a lockless check for the flag before taking the spinlock */
> > +	if (READ_ONCE(inode->i_state) & I_CMTIME_QUERIED) {
> > +		ktime_get_real_ts64(&now);
> > +		spin_lock(&inode->i_lock);
> > +		inode->i_state &=3D ~I_CMTIME_QUERIED;
> > +		spin_unlock(&inode->i_lock);
> > +	} else {
> > +		ktime_get_coarse_real_ts64(&now);
> > +	}
> > +
> > +	return timestamp_truncate(now, inode);
>=20
> I wonder, under which conditions (arch+fs) would it be worth the effort
> to check s_time_gran as part of deciding whether or not to sample a high
> res timestamp?
>=20
> I suppose that would only help us for the situation where "ktime
> sampling is not fast" and "fs timestamp granularity is awful"?
>=20
> (Mechanically, the function body looks ok to me...)
>=20

Thanks for looking! Yeah, that is a good point. No reason to fetch a
high res value if we can't store it anyway. That shouldn't be hard to
optimize away. I'll plan to have a look at that.



> > +}
> > +EXPORT_SYMBOL(current_cmtime);
> > +
> >  /**
> >   * file_update_time - update mtime and ctime time
> >   * @file: file accessed
> > @@ -2080,7 +2116,7 @@ int file_update_time(struct file *file)
> >  {
> >  	int ret;
> >  	struct inode *inode =3D file_inode(file);
> > -	struct timespec64 now =3D current_time(inode);
> > +	struct timespec64 now =3D current_cmtime(inode);
> > =20
> >  	ret =3D inode_needs_update_time(inode, &now);
> >  	if (ret <=3D 0)
> > @@ -2109,7 +2145,7 @@ static int file_modified_flags(struct file *file,=
 int flags)
> >  {
> >  	int ret;
> >  	struct inode *inode =3D file_inode(file);
> > -	struct timespec64 now =3D current_time(inode);
> > +	struct timespec64 now =3D current_cmtime(inode);
> > =20
> >  	/*
> >  	 * Clear the security bits if the process is not being run by root.
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 7c238da22ef0..d8b80a2e36b7 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -64,6 +64,16 @@ void generic_fillattr(struct mnt_idmap *idmap, struc=
t inode *inode,
> >  }
> >  EXPORT_SYMBOL(generic_fillattr);
> > =20
> > +void fill_cmtime_and_mark(struct inode *inode, struct kstat *stat)
> > +{
> > +	spin_lock(&inode->i_lock);
> > +	inode->i_state |=3D I_CMTIME_QUERIED;
> > +	stat->ctime =3D inode->i_ctime;
> > +	stat->mtime =3D inode->i_mtime;
> > +	spin_unlock(&inode->i_lock);
> > +}
> > +EXPORT_SYMBOL(fill_cmtime_and_mark);
> > +
> >  /**
> >   * generic_fill_statx_attr - Fill in the statx attributes from the ino=
de flags
> >   * @inode:	Inode to use as the source
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c85916e9f7db..7dece4390979 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1457,7 +1457,8 @@ static inline bool fsuidgid_has_mapping(struct su=
per_block *sb,
> >  	       kgid_has_mapping(fs_userns, kgid);
> >  }
> > =20
> > -extern struct timespec64 current_time(struct inode *inode);
> > +struct timespec64 current_time(struct inode *inode);
> > +struct timespec64 current_cmtime(struct inode *inode);
> > =20
> >  /*
> >   * Snapshotting support.
> > @@ -2116,6 +2117,7 @@ static inline void kiocb_clone(struct kiocb *kioc=
b, struct kiocb *kiocb_src,
> >  #define I_DONTCACHE		(1 << 16)
> >  #define I_SYNC_QUEUED		(1 << 17)
> >  #define I_PINNING_FSCACHE_WB	(1 << 18)
> > +#define I_CMTIME_QUERIED	(1 << 19)
> > =20
> >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> >  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> > @@ -2839,6 +2841,7 @@ extern int page_symlink(struct inode *inode, cons=
t char *symname, int len);
> >  extern const struct inode_operations page_symlink_inode_operations;
> >  extern void kfree_link(void *);
> >  void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat=
 *);
> > +void fill_cmtime_and_mark(struct inode *inode, struct kstat *stat);
> >  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
> >  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32,=
 unsigned int);
> >  extern int vfs_getattr(const struct path *, struct kstat *, u32, unsig=
ned int);
> > --=20
> > 2.39.2
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
