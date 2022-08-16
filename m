Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D981595D96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiHPNn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiHPNnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26B2F39C;
        Tue, 16 Aug 2022 06:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B84B260B82;
        Tue, 16 Aug 2022 13:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8D6C433C1;
        Tue, 16 Aug 2022 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660657398;
        bh=QIPlexrcPxp8haxZEg3yRa1ZyJXIsUHjDdZO4hjWJrc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OeEhbnj1A0851OoNaseJnzt/IVxXEVKgwkqjOOShD7v+62B1LAYvuuKz1jLrHiPyO
         W6BhJSAWCU4ps0oHxB39b0IHiAzlMDho/OrALMzjtF5Lvko+1+Rk3+fuszvj81l12p
         F042CypOlWQY8W3B8cNVBxceVmGTtRABK2qm/1qXRc6lTwR/FYsGfqLpJAZsJLGFOO
         V17Of2ZPCWvmzLLNzG42B0VRX16OYwcA6nWA0w30ID5YgaLW8xYuqHZDrTPnzkcfPD
         PpTMcClrjRhlFr4kZKXoYM2Gm0eZXooMjnHbssH4CpAkaHndH3/IyJbFZoGD0S94aY
         P7pJT7zIjdymg==
Message-ID: <46ecd0f938ecdc508505456f76e767e0ffcc7137.camel@kernel.org>
Subject: Re: [PATCH] ext4: fix i_version handling in ext4
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>
Date:   Tue, 16 Aug 2022 09:43:16 -0400
In-Reply-To: <20220816133340.mtaa7mxmgvhzffoh@wittgenstein>
References: <20220816131522.42467-1-jlayton@kernel.org>
         <20220816133340.mtaa7mxmgvhzffoh@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-08-16 at 15:33 +0200, Christian Brauner wrote:
> On Tue, Aug 16, 2022 at 09:15:22AM -0400, Jeff Layton wrote:
> > ext4 currently updates the i_version counter when the atime is updated
> > during a read. This is less than ideal as it can cause unnecessary cach=
e
> > invalidations with NFSv4. The increment in ext4_mark_iloc_dirty is also
> > problematic since it can also corrupt the i_version counter for
> > ea_inodes.
> >=20
> > We aren't bumping the file times in ext4_mark_iloc_dirty, so changing
> > the i_version there seems wrong, and is the cause of both problems.
> > Remove that callsite and add increments to the setattr and setxattr
> > codepaths (at the same time that we update the ctime). The i_version
> > bump that already happens during timestamp updates should take care of
> > the rest.
> >=20
> > Cc: Lukas Czerner <lczerner@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
>=20
> Seems good to me. But it seems that the xfs patch you sent does have
> inode_inc_version() right after setattr_copy() as well. So I wonder if
> we couldn't just try and move inode_inc_version() into setattr_copy()
> itself.
>=20

We probably could, but setattr_copy has a lot of callers and most
filesystems don't need this.  Also, there are some cases where we don't
want to update the i_version after a setattr.

In particular, if you do a truncate and the size doesn't change, then
you really don't want to update the timestamps (and therefore the
i_version shouldn't change either).


> >  fs/ext4/inode.c | 10 +++++-----
> >  fs/ext4/xattr.c |  2 ++
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >=20
> > I think this patch should probably supersede Lukas' patch entitled:
> >=20
> >     ext4: don't increase iversion counter for ea_inodes
> >=20
> > This will also mean that we'll need to respin the patch to turn on the
> > i_version counter unconditionally in ext4 (though that should be
> > trivial).
> >=20
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 601214453c3a..a70921df89a5 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5342,6 +5342,7 @@ int ext4_setattr(struct user_namespace *mnt_usern=
s, struct dentry *dentry,
> >  	int error, rc =3D 0;
> >  	int orphan =3D 0;
> >  	const unsigned int ia_valid =3D attr->ia_valid;
> > +	bool inc_ivers =3D IS_IVERSION(inode);
> > =20
> >  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> >  		return -EIO;
> > @@ -5425,8 +5426,8 @@ int ext4_setattr(struct user_namespace *mnt_usern=
s, struct dentry *dentry,
> >  			return -EINVAL;
> >  		}
> > =20
> > -		if (IS_I_VERSION(inode) && attr->ia_size !=3D inode->i_size)
> > -			inode_inc_iversion(inode);
> > +		if (attr->ia_size =3D=3D inode->i_size)
> > +			inc_ivers =3D false;
> > =20
> >  		if (shrink) {
> >  			if (ext4_should_order_data(inode)) {
> > @@ -5528,6 +5529,8 @@ int ext4_setattr(struct user_namespace *mnt_usern=
s, struct dentry *dentry,
> >  	}
> > =20
> >  	if (!error) {
> > +		if (inc_ivers)
> > +			inode_inc_iversion(inode);
> >  		setattr_copy(mnt_userns, inode, attr);
> >  		mark_inode_dirty(inode);
> >  	}
> > @@ -5731,9 +5734,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> >  	}
> >  	ext4_fc_track_inode(handle, inode);
> > =20
> > -	if (IS_I_VERSION(inode))
> > -		inode_inc_iversion(inode);
> > -
> >  	/* the do_update_inode consumes one bh->b_count */
> >  	get_bh(iloc->bh);
> > =20
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 533216e80fa2..4d84919d1c9c 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -2412,6 +2412,8 @@ ext4_xattr_set_handle(handle_t *handle, struct in=
ode *inode, int name_index,
> >  	if (!error) {
> >  		ext4_xattr_update_super_block(handle, inode->i_sb);
> >  		inode->i_ctime =3D current_time(inode);
> > +		if (IS_IVERSION(inode))
> > +			inode_inc_iversion(inode);
> >  		if (!value)
> >  			no_expand =3D 0;
> >  		error =3D ext4_mark_iloc_dirty(handle, inode, &is.iloc);
> > --=20
> > 2.37.2
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
