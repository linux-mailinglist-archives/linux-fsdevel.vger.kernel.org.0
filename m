Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE4749E23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjGFNuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGFNuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08AD1BC2;
        Thu,  6 Jul 2023 06:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5666F6196E;
        Thu,  6 Jul 2023 13:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6B3C433C8;
        Thu,  6 Jul 2023 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688651449;
        bh=TAOaKLnxE0W0XbD523O2HsnX/zX+PLy/4e/HxQw6smM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kcFtqZADlynOIzk1IW/v0oiqIQBagXNlVtYifjo1wEX45dYXuuzmfX6+HyuzSWVeq
         0Lz/MF5dMEmrAQUculQF5JJVWIMAT+7cJRa3l5DVz8md0xwiyjRiZZZI2FZPBMi/lE
         5MhLOAtqB6YN52nC9yp7NS+6aLJf/RSSKhihBpt+9nGuTGzoJcqgH3kBn+hk+keZ4U
         Rt96SZpgJkF2WqrZ+HxtGOTmzFfpdMLRWnc5eWsnpH2R1wYgLxN3jPehCpeQaH/nDe
         xAbTPjJ0VViLtDhR9CeHjEoIpX47ZRzqanQtNK6PLGvuKZWtlKWUpUDWsIptQQyvDt
         kRUeKsWGeTQBg==
Message-ID: <e82198b64ab0c0d4a92e16aa16788cf13ece2786.camel@kernel.org>
Subject: Re: [PATCH v2 56/92] kernfs: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 09:50:47 -0400
In-Reply-To: <20230706133236.vwvm4utsgnhty3mk@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-54-jlayton@kernel.org>
         <20230706133236.vwvm4utsgnhty3mk@quack3>
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

On Thu, 2023-07-06 at 15:32 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:21, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> It looks like there are like three commits squashed into this patch -
> kernfs, libfs, minix.
>=20
> kernfs and libfs parts look good to me - feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> to them. For the minix part I have one nit:
>=20
> > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > index e9fbb5303a22..3715a3940bd4 100644
> > --- a/fs/minix/inode.c
> > +++ b/fs/minix/inode.c
> > @@ -501,10 +501,11 @@ static struct inode *V1_minix_iget(struct inode *=
inode)
> >  	i_gid_write(inode, raw_inode->i_gid);
> >  	set_nlink(inode, raw_inode->i_nlinks);
> >  	inode->i_size =3D raw_inode->i_size;
> > -	inode->i_mtime.tv_sec =3D inode->i_atime.tv_sec =3D inode->i_ctime.tv=
_sec =3D raw_inode->i_time;
> > +	inode->i_mtime.tv_sec =3D inode->i_atime.tv_sec =3D inode_set_ctime(i=
node,
> > +									raw_inode->i_time,
> > +									0).tv_sec;
> >  	inode->i_mtime.tv_nsec =3D 0;
> >  	inode->i_atime.tv_nsec =3D 0;
> > -	inode->i_ctime.tv_nsec =3D 0;
>=20
> The usual simplification:
> 	inode->i_mtime =3D inode->i_atime =3D inode_set_ctime(inode,
> 							  raw_inode->i_time, 0);
>=20
> 								Honza


Thanks. I'm not sure what happened with this patch, as some of the
subsystems got squashed together. I'll break that up properly too.
--=20
Jeff Layton <jlayton@kernel.org>
