Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA086DE06A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDKQFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjDKQE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE95FEE;
        Tue, 11 Apr 2023 09:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A116860EF6;
        Tue, 11 Apr 2023 16:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E679AC433D2;
        Tue, 11 Apr 2023 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681229079;
        bh=sg3ars22NaLIXIe2ZO1UoTD/MqpXK8flFXvuIOjDZS8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G7U/TKV0Y6Xptjc7ysYQtum28tdrTzvmsUNerw1jXRI/qBh4j/S1lbQerQWPfxmqj
         T1JvRYcu13V8NuHvwwbE7GnXgb65+xIYTMuYdg22lU46Moz4twI+wu8u1eqw4z69D0
         q92AOB3B0p1cOFkwX7izGXCI75JnsMTaARmAPBctGezKr0eEzKk1k5QgxXtz80nPCa
         j/nZhC708VdAqcUt4Y0qZFQdOQQZgqFOWxAYzKRhkxq8yMZaE83gR0O6g3ABdGoUXG
         k+hWSq1cO++EGXQINkHNu5ire/LbNmJFGX9kKRvEHuEBp4RagLJ5PZhGddRH3UURbO
         G8etQIIxCzejA==
Message-ID: <c63c4c811cfa6c6396674e497920ec984cb476d1.camel@kernel.org>
Subject: Re: [RFC PATCH 1/3][RESEND] fs: add infrastructure for
 opportunistic high-res ctime/mtime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 11 Apr 2023 12:04:36 -0400
In-Reply-To: <20230411-unwesen-prunk-cb7de3cc6cc8@brauner>
References: <20230411143702.64495-1-jlayton@kernel.org>
         <20230411143702.64495-2-jlayton@kernel.org>
         <20230411-unwesen-prunk-cb7de3cc6cc8@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-11 at 17:07 +0200, Christian Brauner wrote:
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
>=20
> How would this happen? Seems weird to even bother checking this.
>=20

Agreed. I copied this from current_time. I'm fine with leaving that out.
Maybe we should remove it from current_time as well?

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
> So that means that each stat call would mark an inode for a
> high-resolution update.
>=20

Yep. At least any statx call with STATX_CTIME|STATX_MTIME set (which
includes legacy stat() calls of course).

> There's some performance concerns here. Calling
> stat() is super common and it would potentially make the next iop more
> expensive. Recursively changing ownership in the container use-case come
> to mind which are already expensive.

stat() is common, but not generally as common as write calls are. I
expect that we'll get somewhat similar results tochanged i_version over
to use a similar QUERIED flag.

The i_version field was originally very expensive and required metadata
updates on every write. After making that change, we got the same
performance back in most tests that we got without the i_version field
being enabled at all. Basically, this just means we'll end up logging an
extra journal transaction on some writes that follow a stat() call,
which turns out to be line noise for most workloads.

I do agree that performance is a concern here though. We'll need to
benchmark this somehow.
--=20
Jeff Layton <jlayton@kernel.org>
