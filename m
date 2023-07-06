Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8B749E6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGFOBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGFOBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797331BEA;
        Thu,  6 Jul 2023 07:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 063FC61988;
        Thu,  6 Jul 2023 14:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C98C433C9;
        Thu,  6 Jul 2023 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688652100;
        bh=RA6lri/m2E0gZF1CUPwJ2FYbrnZahd6ULY8ragN/3e0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kesckKw+bfEGdhvNzfB/FTcNyo9kIoIxJAmreJAtPz5hlEge2OepS25Vnfv8LdNtG
         UmAD56IkEDbAtc3KXh8itsLP2qyj4cM3GRFg/N+Pt+FM0dZbj3gxmpkLre4xw7mjdT
         dz/NzVxZdjZk+/ERBLpiG1kWbq2LfAEVRJMKeBQ0SyvvXrhoTKzeS4m2QYtwOvHyhj
         K2iFbPJ+jSP8YS16H5edIBaMbB3EeE3rt/e4TT9XubaSg1aV+5NItRsBppnY56mY9e
         +AjNbAyNtv9lJ/Ltx0eC7I71PQL/GLPAN0VwMi6YSpSVtgXUlAhDQ7QecTBno7bSLW
         v2L11Dt5gcjsg==
Message-ID: <8c7efbb0d8b79bd559795e5a29d18c76937f013b.camel@kernel.org>
Subject: Re: [PATCH v2 66/92] overlayfs: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Date:   Thu, 06 Jul 2023 10:01:38 -0400
In-Reply-To: <20230706135852.l2yu7xzffrhbctbb@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-64-jlayton@kernel.org>
         <20230706135852.l2yu7xzffrhbctbb@quack3>
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

On Thu, 2023-07-06 at 15:58 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:31, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ...
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 21245b00722a..7acd3e3fe790 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> ...
> > @@ -249,10 +250,12 @@ static void ovl_file_accessed(struct file *file)
> >  	if (!upperinode)
> >  		return;
> > =20
> > +	ctime =3D inode_get_ctime(inode);
> > +	uctime =3D inode_get_ctime(upperinode);
> >  	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
> > -	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
> > +	     !timespec64_equal(&ctime, &uctime))) {
> >  		inode->i_mtime =3D upperinode->i_mtime;
> > -		inode->i_ctime =3D upperinode->i_ctime;
> > +		inode_set_ctime_to_ts(inode, inode_get_ctime(upperinode));
>=20
> I think you can use uctime here instead of inode_get_ctime(upperinode)?
> Otherwise the patch looks good. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20

Thanks, fixed in tree.
--=20
Jeff Layton <jlayton@kernel.org>
