Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0543E798687
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbjIHLlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjIHLlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:41:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376D11BE7;
        Fri,  8 Sep 2023 04:41:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DACDC433C8;
        Fri,  8 Sep 2023 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694173307;
        bh=Th07n2ZiEJs6k4933TKSCYY2PxyWJc5qY0ucWzXC3Gk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hvYP+e5t0mw5oeIG5WhIGoBSXGvgHI8rCzYUQYWMpxFm+41b19/o7DzyDXW/K25Am
         f1+gdRDRAZ2Uho2ktUBsnfI5poscWnV1DHgf9JDR0UBbeyGwtK9Qe77djKydKqK7iG
         WxVVsicdJpV3XN9+2Zo+4r9KRKOQlstOgjRzHATa9nEvz3fNtblmYjfAHhUs1s5bdI
         a3svBjEf1oE0NWdEgcAWa/0sr4gFcoS8K5btnIk0RqowjjuT2S/UbvbUZM7p9bork/
         gPxC3M4/xnLuwmGdgzEyEb65ghFAYdd2q3t7HHy9QW6yySFsxQ5L447IMU8fiT8qj7
         5lMhpC9/FfF8A==
Message-ID: <0716e97eadc834ac4be97af5d6bbab82c5dc4ac9.camel@kernel.org>
Subject: Re: [PATCH 1/2] fs: initialize inode->__i_ctime to the epoch
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Date:   Fri, 08 Sep 2023 07:41:45 -0400
In-Reply-To: <20230908104229.5tsr2sn7oyfy53ih@quack3>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
         <20230907-ctime-fixes-v1-1-3b74c970d934@kernel.org>
         <20230908104229.5tsr2sn7oyfy53ih@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-09-08 at 12:42 +0200, Jan Kara wrote:
> On Thu 07-09-23 12:33:47, Jeff Layton wrote:
> > With the advent of multigrain timestamps, we use inode_set_ctime_curren=
t
> > to set the ctime, which can skip updating if the existing ctime appears
> > to be in the future. Because we don't initialize this field at
> > allocation time, that could prevent the ctime from being initialized
> > properly when the inode is instantiated.
> >=20
> > Always initialize the ctime field to the epoch so that the filesystem
> > can set the timestamps properly later.
> >=20
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.san=
g@intel.com
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Looks good but don't you need the same treatment to atime after your patc=
h
> 2/2?
>=20
>=20

I don't think so. Most filesystems are doing something along the lines
of this when allocating a new inode:

    inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);

...and I think they pretty much all have to initialize i_atime properly,
since someone could stat the inode before an atime update occurs.

> > ---
> >  fs/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 35fd688168c5..54237f4242ff 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -168,6 +168,8 @@ int inode_init_always(struct super_block *sb, struc=
t inode *inode)
> >  	inode->i_fop =3D &no_open_fops;
> >  	inode->i_ino =3D 0;
> >  	inode->__i_nlink =3D 1;
> > +	inode->__i_ctime.tv_sec =3D 0;
> > +	inode->__i_ctime.tv_nsec =3D 0;
> >  	inode->i_opflags =3D 0;
> >  	if (sb->s_xattr)
> >  		inode->i_opflags |=3D IOP_XATTR;
> >=20
> > --=20
> > 2.41.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
