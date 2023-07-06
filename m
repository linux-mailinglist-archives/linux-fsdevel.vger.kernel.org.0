Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5B749D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGFNL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjGFNLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F59210B;
        Thu,  6 Jul 2023 06:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E317461957;
        Thu,  6 Jul 2023 13:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB72AC433C7;
        Thu,  6 Jul 2023 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688649063;
        bh=oEdEkSOfLSLAwdgsWbEpfVAODRC3ZWJ5lDosNxaphys=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sfHJo6FDxRJyMmTp7qijhr4qQUjAfS0l0aTR+F1tCLzGbXd16fB4NqOke9JNH3ZkH
         elPPa4ln9zwyr30NRqARyI2Jd1mOvqbEUJ0jD5QXH43YJhDZZMl0GMaud9NXDTn98i
         8LwYX7v7eoRmR3U8dF1mRVhgAlzjyrLjHcZIS7ETvAzP9TWlzS42r8qWphCgOSRadr
         ORiuCbKpPQAjbslQNUitg5v9NNYWsE+KQZvhqS0smz4JHkg/JwGSckgO7FetKK/+OX
         uCMEC2W4/1KJr0VwcNKY8IzrKoCSXwY9uB0bJvvD8QnFOiPH9H7wdI2ZISuYQb1Vgq
         hsjFCW+VB1RIw==
Message-ID: <0fc3bb0f804fe08600ffd1381c38837341972476.camel@kernel.org>
Subject: Re: [PATCH v2 51/92] hpfs: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 09:11:01 -0400
In-Reply-To: <20230706124734.ew57trrtzkegqg6y@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-49-jlayton@kernel.org>
         <20230706124734.ew57trrtzkegqg6y@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-07-06 at 14:47 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:16, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> ...
>=20
> > diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
> > index 69fb40b2c99a..36babb78b510 100644
> > --- a/fs/hpfs/namei.c
> > +++ b/fs/hpfs/namei.c
> > @@ -13,10 +13,10 @@ static void hpfs_update_directory_times(struct inod=
e *dir)
> >  {
> >  	time64_t t =3D local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
> >  	if (t =3D=3D dir->i_mtime.tv_sec &&
> > -	    t =3D=3D dir->i_ctime.tv_sec)
> > +	    t =3D=3D inode_get_ctime(dir).tv_sec)
> >  		return;
> > -	dir->i_mtime.tv_sec =3D dir->i_ctime.tv_sec =3D t;
> > -	dir->i_mtime.tv_nsec =3D dir->i_ctime.tv_nsec =3D 0;
> > +	dir->i_mtime.tv_sec =3D inode_set_ctime(dir, t, 0).tv_sec;
> > +	dir->i_mtime.tv_nsec =3D 0;
>=20
> Easier to read:
>=20
> 	dir->i_mtime =3D inode_set_ctime(dir, t, 0);
>=20
> > @@ -59,8 +59,9 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct=
 inode *dir,
> >  	result->i_ino =3D fno;
> >  	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
> >  	hpfs_i(result)->i_dno =3D dno;
> > -	result->i_ctime.tv_sec =3D result->i_mtime.tv_sec =3D result->i_atime=
.tv_sec =3D local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> > -	result->i_ctime.tv_nsec =3D 0;=20
> > +	inode_set_ctime(result,
> > +			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(=
dir->i_sb, le32_to_cpu(dee.creation_date)),
> > +			0);
> >  	result->i_mtime.tv_nsec =3D 0;=20
> >  	result->i_atime.tv_nsec =3D 0;=20
>=20
> Here also:
> 	result->i_mtime =3D result->i_atime =3D inode_set_ctime(result,
> 		local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0)
>=20
> > @@ -167,8 +168,9 @@ static int hpfs_create(struct mnt_idmap *idmap, str=
uct inode *dir,
> >  	result->i_fop =3D &hpfs_file_ops;
> >  	set_nlink(result, 1);
> >  	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
> > -	result->i_ctime.tv_sec =3D result->i_mtime.tv_sec =3D result->i_atime=
.tv_sec =3D local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> > -	result->i_ctime.tv_nsec =3D 0;
> > +	inode_set_ctime(result,
> > +			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(=
dir->i_sb, le32_to_cpu(dee.creation_date)),
> > +			0);
> >  	result->i_mtime.tv_nsec =3D 0;
> >  	result->i_atime.tv_nsec =3D 0;
>=20
> And here exactly the same.
>=20
> > @@ -250,8 +252,9 @@ static int hpfs_mknod(struct mnt_idmap *idmap, stru=
ct inode *dir,
> >  	hpfs_init_inode(result);
> >  	result->i_ino =3D fno;
> >  	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
> > -	result->i_ctime.tv_sec =3D result->i_mtime.tv_sec =3D result->i_atime=
.tv_sec =3D local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> > -	result->i_ctime.tv_nsec =3D 0;
> > +	inode_set_ctime(result,
> > +			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(=
dir->i_sb, le32_to_cpu(dee.creation_date)),
> > +			0);
> >  	result->i_mtime.tv_nsec =3D 0;
> >  	result->i_atime.tv_nsec =3D 0;
> >  	hpfs_i(result)->i_ea_size =3D 0;
> > @@ -326,8 +329,9 @@ static int hpfs_symlink(struct mnt_idmap *idmap, st=
ruct inode *dir,
> >  	result->i_ino =3D fno;
> >  	hpfs_init_inode(result);
> >  	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
> > -	result->i_ctime.tv_sec =3D result->i_mtime.tv_sec =3D result->i_atime=
.tv_sec =3D local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> > -	result->i_ctime.tv_nsec =3D 0;
> > +	inode_set_ctime(result,
> > +			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(=
dir->i_sb, le32_to_cpu(dee.creation_date)),
> > +			0);
> >  	result->i_mtime.tv_nsec =3D 0;
> >  	result->i_atime.tv_nsec =3D 0;
> >  	hpfs_i(result)->i_ea_size =3D 0;
>=20
> And in above two as well.
>=20
> 								Honza

Thanks. I fixed those up in my tree.
--=20
Jeff Layton <jlayton@kernel.org>
