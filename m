Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC96EF163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbjDZJqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZJqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1389E10EB;
        Wed, 26 Apr 2023 02:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A211F61354;
        Wed, 26 Apr 2023 09:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B839DC433D2;
        Wed, 26 Apr 2023 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682502388;
        bh=rDe2by0ajB34Y2WsvbYRxmpIIZ9tpBbzMPKl/R/dPsc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pbSUKk6J+JCYKTTws6wQA3iwvxBMm1Kcyd7LTfo8JVPI6kOKuBaFj8eFPYkO+lLR/
         8EdhPW7cEEjGZP4u7tIi+Dt/3Hp2cD51viyQkO3TEViZeYvoM6YStCBb/luEl94oHz
         SHMigSdcSpPjHA62s0AKOi6gQ8JKQ1qBgUykW0NhBFbggvxMs1TITesAMvBirRnr2w
         6vq/mcW76riKFgy51nuTHNSjatfTbEvQYmIkBIL3ZtsVBAFniRSAli2UPvRxI5mq6V
         Ky/xAQiPV+Gh3bY/MINAo6ywbwll7eq1Zh6tehLb9T7ZIjVzmVO7xIPaYeJeMSlmQ1
         7XGrZO68OAnSQ==
Message-ID: <07ce85763471a5964c9311792aa7e2f2d1696798.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Wed, 26 Apr 2023 05:46:25 -0400
In-Reply-To: <20230426-meerblick-tortur-c6606f6126fa@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
         <20230424151104.175456-2-jlayton@kernel.org>
         <20230426-meerblick-tortur-c6606f6126fa@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-04-26 at 08:53 +0200, Christian Brauner wrote:
> On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
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
>=20
> Is that trying to mask off I_CTIME_QUERIED?
> If so, can we please use that constant as raw constants tend to be
> confusing in the long run.

Sort of. In principle you could set s_time_gran to 2 without setting
SB_MULTIGRAIN_TS. In that case, would it be correct to use the flag
there?

In any case, I can certainly make it use that constant though if that's
what you'd prefer.
--=20
Jeff Layton <jlayton@kernel.org>
