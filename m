Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6366EA893
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDUKsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 06:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDUKsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D283D1;
        Fri, 21 Apr 2023 03:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1726460B6F;
        Fri, 21 Apr 2023 10:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A37C433EF;
        Fri, 21 Apr 2023 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682074078;
        bh=YMiCd2tn+Kwhq5vt740oxHkL6CrclEtNSKXXgkMDZzc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hjutz1fvbTbSug9eVUquviL4tAoNlkEh+D8UwRz2EmqxPmD/qIE/1sOTRzmn5mwqx
         mKM95MWbE5ujOBQHDUryrtj3aqFhc0Q0SATadEGGrZRLjIxBV8nq0lrqpmhmgCTUKh
         lndHzOw7gLoe3S5beyCwDRSRjL1vX/WylSDNOcfAjn6RKpLfuCoNsC6AMTVf+ZImBs
         M3cix5G9qaqYVwm89y3tY5ZNdrS3+cNddU1PF9z56nFky4dcJSc1cQmV7aUBD+FE+2
         Vp7JlPZBRoPkjedQHc7virsAH4OI+StJ+5EdISxvirGszqGIL3Gz4r8XpZo0rZk+Jg
         biHjSlsBXy5yw==
Message-ID: <fb17a0931ae29b89d661b7b2295726689c350ae3.camel@kernel.org>
Subject: Re: [RFC PATCH 1/3] fs: add infrastructure for opportunistic
 high-res ctime/mtime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>
Date:   Fri, 21 Apr 2023 06:47:55 -0400
In-Reply-To: <20230421101331.dlxom6b5e7yds5tn@quack3>
References: <20230411142708.62475-1-jlayton@kernel.org>
         <20230411142708.62475-2-jlayton@kernel.org>
         <20230421101331.dlxom6b5e7yds5tn@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-21 at 12:13 +0200, Jan Kara wrote:
> On Tue 11-04-23 10:27:06, Jeff Layton wrote:
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
>=20
> I don't think we can have inodes without a superblock. Did you ever hit
> this?
>=20

No, I copied this from current_time. I've already removed this in my
working branch. We can probably remove it from current_time too.

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
>=20
> Isn't this a bit fragile? If someone does:
>=20
> 	inode->i_mtime =3D current_cmtime(inode);
> 	inode->i_ctime =3D current_cmtime(inode);
>=20
> the ctime update will be coarse although it should be fine-grained.
>=20

It is a bit. We'll need for users to do something like:

    inode->i_mtime =3D inode->i_ctime =3D current_ctime(inode);

Fortunately, most do this already.

> > +		spin_unlock(&inode->i_lock);
> > +	} else {
> > +		ktime_get_coarse_real_ts64(&now);
> > +	}
> > +
> > +	return timestamp_truncate(now, inode);
>=20
> I'm a bit confused here. Isn't the point of this series also to give NFS
> finer grained granularity time stamps than what the filesystem is possibl=
y
> able to store on disk?
>=20

No. We actually don't want to hand out timestamps more granular than the
underlying filesystem can support, as we'd end up having to invalidate
caches for all of those inodes once the server rebooted and the
unrecordable bits get zeroed out.

The main idea here is to just ensure that we use fine-grained timestamps
when someone has queried the mtime or ctime since the last time it was
updated.

> Hmm, checking XFS it sets 1 ns granularity (as well as tmpfs) so for thes=
e
> using the coarser timers indeed gives a performance benefit. And probably
> you've decided not implement the "better NFS support with coarse grained
> timestamps" yet.
>=20

Yep. The coarse grained timestamps are a _good_ thing for most
filesystems as they allow you to skip a lot of metadata updates. My hope
is that this will end up being like the i_version changes such that the
extra fine-grained updates should be relatively rare and should
(hopefully!) not cause noticeable performance blips. We'll see!

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
>=20
> The name could be better here :). Maybe stat_fill_cmtime_and_mark()?
>=20
> 							=09

I have a quite different set that I've been working on that I'll
(hopefully!) post soon. That one uses the least significant bit of the
tv_nsec field as the QUERIED flag instead of the spinlock.

Still cleaning up the set and need to test it some more though, so it's
not quite ready to post. Stay tuned!

Thanks for the review!=20
--=20
Jeff Layton <jlayton@kernel.org>
