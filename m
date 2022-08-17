Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26025596F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 15:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiHQNL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiHQNKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77E6C125;
        Wed, 17 Aug 2022 06:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F048612FE;
        Wed, 17 Aug 2022 13:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456D4C433D7;
        Wed, 17 Aug 2022 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741801;
        bh=QihSMJKjDch4GL1LywlKzg/ABMaKCsVyPC/+3xtGVJs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HjWdOD2GTsFR8qCj1Rh06D2z7laxaibwRorj9PYREs1gAmMEePcHp9JmUomv8KQcW
         8fIixmRQO0fAoEeLaEXwXh1WdCidCsTnQO4hD0Jg9tXyRG0E0848sEliAnBoCf4nq/
         RyDP08YAWSelZL6kq1a91iL53wsoECRWNInJTuBx+hf9f5pcesLGUDTi7MPHe8vmN1
         WGnzMT178mBsTvK3Id0cva5Zq+sqT5Jy8XxK2gsGTUwkGgAcESBWQYUHIx0LRVAgeC
         h0N1wJdQ/e5fCclD19jRjndgnxxqb0TTZb7Na01FN7PSPYkI90nOUMzrnIpO12hATS
         +BhszTI1xxwgw==
Message-ID: <e822b39e120332f88cbfe5d02d69c217bac74419.camel@kernel.org>
Subject: Re: [PATCH] ext4: fix i_version handling in ext4
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Date:   Wed, 17 Aug 2022 09:09:58 -0400
In-Reply-To: <20220817130441.qigqv62wj6lrvxfc@quack3>
References: <20220816131522.42467-1-jlayton@kernel.org>
         <20220817130441.qigqv62wj6lrvxfc@quack3>
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

On Wed, 2022-08-17 at 15:04 +0200, Jan Kara wrote:
> On Tue 16-08-22 09:15:22, Jeff Layton wrote:
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
>=20
> After some verification (which was not completely trivial e.g. for
> directories) I agree all cases should be covered. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> 								Honza
>=20

Thanks.

I think this covers the typical cases, but there are some places I
missed:

The setacl codepath, for one, and there are a number of places that set
the ctime explicitly for hole punching and the like. I'm planning to
send a v2 once I do a bit more testing. I'll hold off on adding your
Reviewed-by just yet, since the final patch may be quite a bit
different.


> > ---
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
