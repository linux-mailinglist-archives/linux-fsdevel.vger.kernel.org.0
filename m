Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393435F403D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJDJrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJDJqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C158DFD;
        Tue,  4 Oct 2022 02:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2181B61325;
        Tue,  4 Oct 2022 09:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5A5C433D6;
        Tue,  4 Oct 2022 09:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664876633;
        bh=NuOhLmNQi+0z+8SuTgzQVWI6qOlUQYzFgFPJVDcOA2U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P9t1CJU1IOoqBpf2Gub0na4j68dGinNno0bhdmAwo6QX9zaQkEnDQs9hZe2mWGdUy
         JPmF2TwSfK25amHB4SMk+YpCHr9rn7YRhbEPM/J7crfVkRCTGz90CLLCu/xpKJryM0
         SMvDZd24Djwxl7qEVAX51ZW6DOYNnqY/oefQW169aOk56FTVTsfoH/47ilaTkmS8Oc
         9N002yQFgD5A9k59O3X/qtjw8Ya0hDF56PMQ8x3Q//nKdcn0bPRxkPXR7HqSDhoXXr
         YhKAWrhlYrrFNoNewBhzYxlYN/tNiwm6+7SC4IgEty9wvC3vPAkD961Lb2ofh/qluA
         DbZ8TM2bxYVEA==
Message-ID: <822ce678d47be0767464fc580d04981c24ccd28e.camel@kernel.org>
Subject: Re: [PATCH v6 4/9] nfs: report the inode version in getattr if
 requested
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Tue, 04 Oct 2022 05:43:50 -0400
In-Reply-To: <166483977325.14457.7085950126736913468@noble.neil.brown.name>
References: <20220930111840.10695-1-jlayton@kernel.org>
        , <20220930111840.10695-5-jlayton@kernel.org>
         <166483977325.14457.7085950126736913468@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-04 at 10:29 +1100, NeilBrown wrote:
> On Fri, 30 Sep 2022, Jeff Layton wrote:
> > Allow NFS to report the i_version in getattr requests. Since the cost t=
o
> > fetch it is relatively cheap, do it unconditionally and just set the
> > flag if it looks like it's valid. Also, conditionally enable the
> > MONOTONIC flag when the server reports its change attr type as such.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/inode.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index bea7c005119c..5cb7017e5089 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -830,6 +830,8 @@ static u32 nfs_get_valid_attrmask(struct inode *ino=
de)
> >  		reply_mask |=3D STATX_UID | STATX_GID;
> >  	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
> >  		reply_mask |=3D STATX_BLOCKS;
> > +	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
> > +		reply_mask |=3D STATX_VERSION;
> >  	return reply_mask;
> >  }
> > =20
> > @@ -848,7 +850,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, =
const struct path *path,
> > =20
> >  	request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
> >  			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
> > -			STATX_INO | STATX_SIZE | STATX_BLOCKS;
> > +			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_VERSION;
> > =20
> >  	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
> >  		if (readdirplus_enabled)
> > @@ -877,7 +879,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, =
const struct path *path,
> >  	/* Is the user requesting attributes that might need revalidation? */
> >  	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
> >  					STATX_MTIME|STATX_UID|STATX_GID|
> > -					STATX_SIZE|STATX_BLOCKS)))
> > +					STATX_SIZE|STATX_BLOCKS|STATX_VERSION)))
> >  		goto out_no_revalidate;
> > =20
> >  	/* Check whether the cached attributes are stale */
> > @@ -915,6 +917,10 @@ int nfs_getattr(struct user_namespace *mnt_userns,=
 const struct path *path,
> > =20
> >  	generic_fillattr(&init_user_ns, inode, stat);
> >  	stat->ino =3D nfs_compat_user_ino64(NFS_FILEID(inode));
> > +	stat->version =3D inode_peek_iversion_raw(inode);
>=20
> This looks wrong.
> 1/ it includes the I_VERSION_QUERIED bit, which should be hidden.
> 2/ it doesn't set that bit.
>=20
> I understand that the bit was already set when the generic code called
> inode_query_iversion(), but it might have changed if we needed to
> refresh the attrs.
>=20
> I'm beginning to think I shouldn't have approved the 3/9 patch.  The
> stat->version shouldn't be set in vfs_getattr_nosec() - maybe in
> generic_fillattr(), but not a lot of point.
>=20

NFS (and Ceph),=A0do not set the SB_I_VERSION flag and they don't use the
QUERIED bit. These are "server managed" implementations of i_version.
The server is responsible for incrementing the value, and we just store
the result in the i_version field and present it when needed. That's why
the patch for NFS is using the "raw" API.

> > +	stat->attributes_mask |=3D STATX_ATTR_VERSION_MONOTONIC;
> > +	if (server->change_attr_type !=3D NFS4_CHANGE_TYPE_IS_UNDEFINED)
> > +		stat->attributes |=3D STATX_ATTR_VERSION_MONOTONIC;
>=20
> So if the server tells us that the change attrs is based on time
> metadata, we accept that it will be monotonic (and RFC7862 encourages
> this), even though we seem to worry about timestamps going backwards
> (which we know that can)...  Interesting.
>=20
>=20

I followed suit from nfs_inode_attrs_cmp(). It seems to treat any value
that isn't UNDEFINED as MONOTONIC, though it does use a less strict
comparator for NFS4_CHANGE_TYPE_IS_TIME_METADATA. It may make sense to
carve that out as an exception.

This is probably an indicator that we need a more strict definition for
STATX_ATTR_VERSION_MONOTONIC.


>=20
> >  	if (S_ISDIR(inode->i_mode))
> >  		stat->blksize =3D NFS_SERVER(inode)->dtsize;
> >  out:
> > --=20
> > 2.37.3
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
