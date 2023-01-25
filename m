Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1C67B956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjAYSaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjAYSaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:30:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AD2EF82;
        Wed, 25 Jan 2023 10:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66B1D614DD;
        Wed, 25 Jan 2023 18:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD575C433EF;
        Wed, 25 Jan 2023 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674671410;
        bh=3hey6nAjOrq1ab1bjrOSm/A7xOGq3F8K7LJwSS7t5Po=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sAB7UgwcmG7X2foV/IQ0XtE/OYTlQ+1hUJpUkN0k1YbSYjv2RT873eHVEQGUW9l1T
         gHKNT5d3xMCGp0pfwsY1sUvw5YnJ+vIvHH4OIXCKuCf1VYJA3tTE5IQJaHe6kZZhbC
         DsBerROt/6HVkZDCP9W6di/zlbwwG1Oa+k00Ir87OP+fjYdt171NELqO+AB6lF4Ymx
         I/hd4cUsz4wKD5RiueEQHUmQvqZM5AhL/bFUerf7yDw25n7bUe5F7w/HhB4PHGS7Jj
         OSelIFkDrINcdDYJEn4XgykCCeXofme/K5cqwMNTZUiKs9dW63KTtSjCp78CZtf2VO
         DagxHTCorSqmA==
Message-ID: <275450f6a909a640a416860b13a35769d253ab1b.camel@kernel.org>
Subject: Re: [PATCH v8 RESEND 3/8] vfs: plumb i_version handling into struct
 kstat
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Wed, 25 Jan 2023 13:30:07 -0500
In-Reply-To: <20230125155059.u22lmktpylymmruo@wittgenstein>
References: <20230124193025.185781-1-jlayton@kernel.org>
         <20230124193025.185781-4-jlayton@kernel.org>
         <20230125155059.u22lmktpylymmruo@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-01-25 at 16:50 +0100, Christian Brauner wrote:
> On Tue, Jan 24, 2023 at 02:30:20PM -0500, Jeff Layton wrote:
> > The NFS server has a lot of special handling for different types of
> > change attribute access, depending on the underlying filesystem. In
> > most cases, it's doing a getattr anyway and then fetching that value
> > after the fact.
> >=20
> > Rather that do that, add a new STATX_CHANGE_COOKIE flag that is a
> > kernel-only symbol (for now). If requested and getattr can implement it=
,
> > it can fill out this field. For IS_I_VERSION inodes, add a generic
> > implementation in vfs_getattr_nosec. Take care to mask
> > STATX_CHANGE_COOKIE off in requests from userland and in the result
> > mask.
> >=20
> > Since not all filesystems can give the same guarantees of monotonicity,
> > claim a STATX_ATTR_CHANGE_MONOTONIC flag that filesystems can set to
> > indicate that they offer an i_version value that can never go backward.
> >=20
> > Eventually if we decide to make the i_version available to userland, we
> > can just designate a field for it in struct statx, and move the
> > STATX_CHANGE_COOKIE definition to the uapi header.
> >=20
> > Reviewed-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/stat.c            | 17 +++++++++++++++--
> >  include/linux/stat.h |  9 +++++++++
> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index d6cc74ca8486..f43afe0081fe 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/compat.h>
> > +#include <linux/iversion.h>
> > =20
> >  #include <linux/uaccess.h>
> >  #include <asm/unistd.h>
> > @@ -122,6 +123,11 @@ int vfs_getattr_nosec(const struct path *path, str=
uct kstat *stat,
> >  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> >  				  STATX_ATTR_DAX);
> > =20
> > +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > +		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> > +		stat->change_cookie =3D inode_query_iversion(inode);
> > +	}
> > +
> >  	mnt_userns =3D mnt_user_ns(path->mnt);
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(mnt_userns, path, stat,
> > @@ -602,9 +608,11 @@ cp_statx(const struct kstat *stat, struct statx __=
user *buffer)
> > =20
> >  	memset(&tmp, 0, sizeof(tmp));
> > =20
> > -	tmp.stx_mask =3D stat->result_mask;
> > +	/* STATX_CHANGE_COOKIE is kernel-only for now */
> > +	tmp.stx_mask =3D stat->result_mask & ~STATX_CHANGE_COOKIE;
> >  	tmp.stx_blksize =3D stat->blksize;
> > -	tmp.stx_attributes =3D stat->attributes;
> > +	/* STATX_ATTR_CHANGE_MONOTONIC is kernel-only for now */
> > +	tmp.stx_attributes =3D stat->attributes & ~STATX_ATTR_CHANGE_MONOTONI=
C;
> >  	tmp.stx_nlink =3D stat->nlink;
> >  	tmp.stx_uid =3D from_kuid_munged(current_user_ns(), stat->uid);
> >  	tmp.stx_gid =3D from_kgid_munged(current_user_ns(), stat->gid);
> > @@ -643,6 +651,11 @@ int do_statx(int dfd, struct filename *filename, u=
nsigned int flags,
> >  	if ((flags & AT_STATX_SYNC_TYPE) =3D=3D AT_STATX_SYNC_TYPE)
> >  		return -EINVAL;
> > =20
> > +	/* STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
> > +	 * from userland.
> > +	 */
> > +	mask &=3D ~STATX_CHANGE_COOKIE;
> > +
> >  	error =3D vfs_statx(dfd, filename, flags, &stat, mask);
> >  	if (error)
> >  		return error;
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index ff277ced50e9..52150570d37a 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
>=20
> Sorry being late to the party once again...
>=20
> > @@ -52,6 +52,15 @@ struct kstat {
> >  	u64		mnt_id;
> >  	u32		dio_mem_align;
> >  	u32		dio_offset_align;
> > +	u64		change_cookie;
> >  };
> > =20
> > +/* These definitions are internal to the kernel for now. Mainly used b=
y nfsd. */
> > +
> > +/* mask values */
> > +#define STATX_CHANGE_COOKIE		0x40000000U	/* Want/got stx_change_attr *=
/
> > +
> > +/* file attribute values */
> > +#define STATX_ATTR_CHANGE_MONOTONIC	0x8000000000000000ULL /* version m=
onotonically increases */
>=20
> maybe it would be better to copy what we do for SB_* vs SB_I_* flags and
> at least rename them to:
>=20
> STATX_I_CHANGE_COOKIE
> STATX_I_ATTR_CHANGE_MONOTONIC
> i_change_cookie

An "i_"/"I_" prefix says "inode" to me. Maybe I've been at this too
long. ;)

>=20
> to visually distinguish internal and external flags.
>=20
> And also if possible it might be useful to move STATX_I_* flags to the
> higher 32 bits and then one can use upper_32_bits to retrieve kernel
> internal flags and lower_32_bits for userspace flags in tiny wrappers.
>=20
> (I did something similar for clone3() a few years ago but there to
> distinguish between flags available both in clone() and clone3() and
> such that are only available in clone3().)
>=20
> But just a thought. I mostly worry about accidently leaking this to
> userspace so ideally we'd even have separate fields in struct kstat for
> internal and external attributes but that might bump kstat size, though
> I don't think struct kstat is actually ever really allocated all that
> much.

I'm not sure that the internal/external distinction matters much for
filesystem providers or consumers of it. The place that it matters is at
the userland interface level, where statx or something similar is
called.

At some point we may want to make STATX_CHANGE_COOKIE queryable via
statx, at which point we'll have to have a big flag day where we do
s/STATX_I_CHANGE_COOKIE/STATX_CHANGE_COOKIE/.

I don't think it's worth it here.
--=20
Jeff Layton <jlayton@kernel.org>
