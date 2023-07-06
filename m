Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513A0749D24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGFNLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGFNL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B71FC7;
        Thu,  6 Jul 2023 06:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE4061927;
        Thu,  6 Jul 2023 13:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8230C433C7;
        Thu,  6 Jul 2023 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688649087;
        bh=KT6OtSe5qqgwlM7iD1ug7XuMlRonS5BuSWRzxO3GYj0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JpydbltskcqWeoC5Ftlgc5bcW+vsqiuQyQfkt/vOC5RwFkuvJFGZhZZKBYv67bnD0
         r1Bs01aq4d/pRzmZwQm/SFzFEHAeKFKlPVZh9d5u5RnTk8SEjK2EPvjZNPXXCad2K5
         MkM8lRfRVn4PkvbK3Meu81nP7zcvMAE4IWglWt4HxVmaSHs1GO61+vmg7L2pOLOTDy
         pLhtjJFFiX5juRMwEFNlq8cctwDZdwnKtPvvel8rfeXo9EmS2qRzglfdLGEuxUBgsS
         Elcvj+MnZdL6Avid6WNqUBLvY9K7ZMPMYJVZu8y4XHkcNT5HryKrj4YIXUltlIUwKW
         IPgZaaNxr4JqA==
Message-ID: <f3005cad61ff0f2de38150d50584c85017df0c57.camel@kernel.org>
Subject: Re: [PATCH v2 53/92] isofs: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 09:11:25 -0400
In-Reply-To: <20230706123921.z4ckgxviewefzvqq@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-51-jlayton@kernel.org>
         <20230706123921.z4ckgxviewefzvqq@quack3>
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

On Thu, 2023-07-06 at 14:39 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:18, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/isofs/inode.c |  8 ++++----
> >  fs/isofs/rock.c  | 16 +++++++---------
> >  2 files changed, 11 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> > index df9d70588b60..98a78200cff1 100644
> > --- a/fs/isofs/inode.c
> > +++ b/fs/isofs/inode.c
> > @@ -1424,11 +1424,11 @@ static int isofs_read_inode(struct inode *inode=
, int relocated)
> >  #endif
> > =20
> >  	inode->i_mtime.tv_sec =3D
> > -	inode->i_atime.tv_sec =3D
> > -	inode->i_ctime.tv_sec =3D iso_date(de->date, high_sierra);
> > +	inode->i_atime.tv_sec =3D inode_set_ctime(inode,
> > +						iso_date(de->date, high_sierra),
> > +						0).tv_sec;
> >  	inode->i_mtime.tv_nsec =3D
> > -	inode->i_atime.tv_nsec =3D
> > -	inode->i_ctime.tv_nsec =3D 0;
> > +	inode->i_atime.tv_nsec =3D 0;
>=20
> This would be IMHO more readable as:
>=20
> 	inode->i_mtime =3D inode->i_atime =3D
> 		inode_set_ctime(inode, iso_date(de->date, high_sierra), 0);
>=20
>=20
> Otherwise the patch looks good.
>=20

Thanks. Fixed in my tree.
--=20
Jeff Layton <jlayton@kernel.org>
