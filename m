Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C21749AF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGFLlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGFLlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699741FEC;
        Thu,  6 Jul 2023 04:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF20761909;
        Thu,  6 Jul 2023 11:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9470EC433CB;
        Thu,  6 Jul 2023 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688643626;
        bh=3DM6oxlTYa5BF9QPOZUriTDTpP9nsRtOe29lS1bWByg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nGUC4QTGsb6t1j/yaHqtyYUmiffzuKBIXJgczIAn3qe5B2DVwNiHS1H9EW0InTWa7
         KBKKNSA8SYxxqz8Dv5PXUwCJaG665fM6mQcHTz1aKev9EFZMvwQNp9W4oQTrcEaCUf
         qKYp1BNMFOFB3DBzLAaCsHhGws6WM2LDDsdY67XGd5ftoSW8IPTjufbCcCFgbl1cte
         p4Ro+cVHLK/HOznubGyS1fdTf432fIidUowEGVA4TN7urfFVSLESLPk38jxs5AzDu9
         gKbdI5V9MMwTnHItZT94M8jQTwEcT8b/F4YmOWUpnbtEYC30MSX4PPc00Tqp2QsaWI
         hKtQH7CVtqPhA==
Message-ID: <bb698e294b0d4dbbbad4b94048693360010b8010.camel@kernel.org>
Subject: Re: [PATCH v2 12/92] exfat: convert to simple_rename_timestamp
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 07:40:24 -0400
In-Reply-To: <20230706103909.jclg3nvltflqgwo2@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-10-jlayton@kernel.org>
         <20230706103909.jclg3nvltflqgwo2@quack3>
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

On Thu, 2023-07-06 at 12:39 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:00:37, Jeff Layton wrote:
> > A rename potentially involves updating 4 different inode timestamps.
> > Convert to the new simple_rename_timestamp helper function.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/exfat/namei.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> > index d9b46fa36bff..e91022ff80ef 100644
> > --- a/fs/exfat/namei.c
> > +++ b/fs/exfat/namei.c
> > @@ -1312,8 +1312,8 @@ static int exfat_rename(struct mnt_idmap *idmap,
> >  		goto unlock;
> > =20
> >  	inode_inc_iversion(new_dir);
> > -	new_dir->i_ctime =3D new_dir->i_mtime =3D new_dir->i_atime =3D
> > -		EXFAT_I(new_dir)->i_crtime =3D current_time(new_dir);
> > +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
> > +	EXFAT_I(new_dir)->i_crtime =3D current_time(new_dir);
>=20
> Hum, you loose atime update with this. Not that it would make sense to ha=
ve
> it but it would probably deserve a comment in the changelog.
>=20
> Also why you use current_time(new_dir) here instead of say inode->i_ctime=
?
>=20

I think the atime update there is a mistake. A rename is not a "read"
operation. I'll note it in the changelog.

The i_crtime in exfat is the creation time (aka btime). I don't think it
matters much which source that ultimately comes from, but now I'm
wondering why it gets set here at all. Does exfat create a new inode
during a rename? If not, then the i_crtime updates here should probably
be removed.


> >  	exfat_truncate_atime(&new_dir->i_atime);
> >  	if (IS_DIRSYNC(new_dir))
> >  		exfat_sync_inode(new_dir);
> > @@ -1336,7 +1336,6 @@ static int exfat_rename(struct mnt_idmap *idmap,
> >  	}
> > =20
> >  	inode_inc_iversion(old_dir);
> > -	old_dir->i_ctime =3D old_dir->i_mtime =3D current_time(old_dir);
> >  	if (IS_DIRSYNC(old_dir))
> >  		exfat_sync_inode(old_dir);
> >  	else
>=20
> Also there is:
>=20
>                 new_inode->i_ctime =3D EXFAT_I(new_inode)->i_crtime =3D
>                         current_time(new_inode);
>=20
> in exfat_rename() from which you can remove the ctime update?
>=20

Yeah, that should be removed too. I'll fix that in my tree. The i_crtime
update here looks pretty suspicious too, fwiw.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
