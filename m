Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534BE5F4BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJDW1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 18:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJDW1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:27:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193C24F16;
        Tue,  4 Oct 2022 15:27:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0845321905;
        Tue,  4 Oct 2022 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664922448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vzITPki9DergJeVn+XOP8XeqEJQp0G0OTrwXmCSGUY=;
        b=GBmgeralmG280qmuwML4DqNserODcQNyzIAWsmjbLUFRPA2y9Rj6dP3hxFYsttwcjhDljL
        GUyKwcox5P78LOMWWFfpeM1qj+Ew1gAkmcnn4S9dVbeX8+itMrHtWqSYbXMVvN0APxf8Ju
        YqSC2wNUrd6iOOQYHu8S33WPfd4N1Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664922448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vzITPki9DergJeVn+XOP8XeqEJQp0G0OTrwXmCSGUY=;
        b=vkUAcjh89hN6EXp3oxhoNf7BpGR04jBmI0o8jkLw5yNE9jcJ20XekNbJPiLQHNh6iwi2/H
        RbAwfnqrkCjYZgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68B9D139D2;
        Tue,  4 Oct 2022 22:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jQedCEmzPGNgKwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Oct 2022 22:27:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 4/9] nfs: report the inode version in getattr if requested
In-reply-to: <822ce678d47be0767464fc580d04981c24ccd28e.camel@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-5-jlayton@kernel.org>,
 <166483977325.14457.7085950126736913468@noble.neil.brown.name>,
 <822ce678d47be0767464fc580d04981c24ccd28e.camel@kernel.org>
Date:   Wed, 05 Oct 2022 09:27:15 +1100
Message-id: <166492243554.14457.1530520033894290024@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 04 Oct 2022, Jeff Layton wrote:
> On Tue, 2022-10-04 at 10:29 +1100, NeilBrown wrote:
> > On Fri, 30 Sep 2022, Jeff Layton wrote:
> > > Allow NFS to report the i_version in getattr requests. Since the cost to
> > > fetch it is relatively cheap, do it unconditionally and just set the
> > > flag if it looks like it's valid. Also, conditionally enable the
> > > MONOTONIC flag when the server reports its change attr type as such.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfs/inode.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > index bea7c005119c..5cb7017e5089 100644
> > > --- a/fs/nfs/inode.c
> > > +++ b/fs/nfs/inode.c
> > > @@ -830,6 +830,8 @@ static u32 nfs_get_valid_attrmask(struct inode *ino=
de)
> > >  		reply_mask |=3D STATX_UID | STATX_GID;
> > >  	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
> > >  		reply_mask |=3D STATX_BLOCKS;
> > > +	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
> > > +		reply_mask |=3D STATX_VERSION;
> > >  	return reply_mask;
> > >  }
> > > =20
> > > @@ -848,7 +850,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, =
const struct path *path,
> > > =20
> > >  	request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
> > >  			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
> > > -			STATX_INO | STATX_SIZE | STATX_BLOCKS;
> > > +			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_VERSION;
> > > =20
> > >  	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
> > >  		if (readdirplus_enabled)
> > > @@ -877,7 +879,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, =
const struct path *path,
> > >  	/* Is the user requesting attributes that might need revalidation? */
> > >  	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
> > >  					STATX_MTIME|STATX_UID|STATX_GID|
> > > -					STATX_SIZE|STATX_BLOCKS)))
> > > +					STATX_SIZE|STATX_BLOCKS|STATX_VERSION)))
> > >  		goto out_no_revalidate;
> > > =20
> > >  	/* Check whether the cached attributes are stale */
> > > @@ -915,6 +917,10 @@ int nfs_getattr(struct user_namespace *mnt_userns,=
 const struct path *path,
> > > =20
> > >  	generic_fillattr(&init_user_ns, inode, stat);
> > >  	stat->ino =3D nfs_compat_user_ino64(NFS_FILEID(inode));
> > > +	stat->version =3D inode_peek_iversion_raw(inode);
> >=20
> > This looks wrong.
> > 1/ it includes the I_VERSION_QUERIED bit, which should be hidden.
> > 2/ it doesn't set that bit.
> >=20
> > I understand that the bit was already set when the generic code called
> > inode_query_iversion(), but it might have changed if we needed to
> > refresh the attrs.
> >=20
> > I'm beginning to think I shouldn't have approved the 3/9 patch.  The
> > stat->version shouldn't be set in vfs_getattr_nosec() - maybe in
> > generic_fillattr(), but not a lot of point.
> >=20
>=20
> NFS (and Ceph),=C2=A0do not set the SB_I_VERSION flag and they don't use the
> QUERIED bit. These are "server managed" implementations of i_version.
> The server is responsible for incrementing the value, and we just store
> the result in the i_version field and present it when needed. That's why
> the patch for NFS is using the "raw" API.

Ahh - of course.  I got confused because the "raw" api is used by code
(in iversion.h) that wants to access the QUERIED bit.  Maybe having
different names would help.  Or maybe me re-familiarising myself with
the interfaces would help...

Reviewed-by: NeilBrown <neilb@suse.de>


>=20
> > > +	stat->attributes_mask |=3D STATX_ATTR_VERSION_MONOTONIC;
> > > +	if (server->change_attr_type !=3D NFS4_CHANGE_TYPE_IS_UNDEFINED)
> > > +		stat->attributes |=3D STATX_ATTR_VERSION_MONOTONIC;
> >=20
> > So if the server tells us that the change attrs is based on time
> > metadata, we accept that it will be monotonic (and RFC7862 encourages
> > this), even though we seem to worry about timestamps going backwards
> > (which we know that can)...  Interesting.
> >=20
> >=20
>=20
> I followed suit from nfs_inode_attrs_cmp(). It seems to treat any value
> that isn't UNDEFINED as MONOTONIC, though it does use a less strict
> comparator for NFS4_CHANGE_TYPE_IS_TIME_METADATA. It may make sense to
> carve that out as an exception.
>=20
> This is probably an indicator that we need a more strict definition for
> STATX_ATTR_VERSION_MONOTONIC.

Maybe.  Or maybe we decide that if the system time goes backwards and
things break, then you get to keep both halves.
The pedant in me want to handle that properly.  The pragmatist doesn't
think it is worth it.

Thanks,
NeilBrown


>=20
>=20
> >=20
> > >  	if (S_ISDIR(inode->i_mode))
> > >  		stat->blksize =3D NFS_SERVER(inode)->dtsize;
> > >  out:
> > > --=20
> > > 2.37.3
> > >=20
> > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
