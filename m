Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9270972C06B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjFLKwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFLKvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B993FF;
        Mon, 12 Jun 2023 03:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A808C614F0;
        Mon, 12 Jun 2023 10:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C3AC4339C;
        Mon, 12 Jun 2023 10:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566191;
        bh=7lfE8n4wCuge2Ilsu3h1F4ipyzhUj7bSJuflx8EXZtw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DU0ZjjsJO4rS5B/LrOhkcDtfvbBZTjXhclQjcMb8L0SMAJ/Zj8o6cOouP0LPA9kRi
         VqJ/momrCYS9bgBfSwuBqZwMMGlKax5OQGCSRTBF7m/eO1OCct4ECh1Dq3q51n5hhV
         Yhf0l7cjjbGMIJ2UYDeBi6gwKGFHv0g6f2BclJ5kTS9KJF0zsyYQaetziIibzJHykN
         7tP2iy40SDcuxMKwZA7N7Mbn26TeBSys37uMErgDMUpaf6wBIfwFsLid/c78sbMh0z
         WHZh5yV0lSHcOPaWQW6a50hTCYgYFvBa4rOsjTJ1iVF0vlDpRO8qNBXUJAB1ctdV+d
         JMJSCsxLTJnJg==
Message-ID: <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is updated
From:   Jeff Layton <jlayton@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Date:   Mon, 12 Jun 2023 06:36:26 -0400
In-Reply-To: <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
References: <20230609125023.399942-1-jlayton@kernel.org>
         <20230609125023.399942-8-jlayton@kernel.org>
         <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> Jeff,
>=20
> On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/gfs2/quota.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > index 1ed17226d9ed..6d283e071b90 100644
> > --- a/fs/gfs2/quota.c
> > +++ b/fs/gfs2/quota.c
> > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *ip,=
 loff_t loc,
> >                 size =3D loc + sizeof(struct gfs2_quota);
> >                 if (size > inode->i_size)
> >                         i_size_write(inode, size);
> > -               inode->i_mtime =3D inode->i_atime =3D current_time(inod=
e);
> > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =
=3D current_time(inode);
>=20
> I don't think we need to worry about the ctime of the quota inode as
> that inode is internal to the filesystem only.
>=20

Thanks Andreas.  I'll plan to drop this patch from the series for now.

Does updating the mtime and atime here serve any purpose, or should
those also be removed? If you plan to keep the a/mtime updates then I'd
still suggest updating the ctime for consistency's sake. It shouldn't
cost anything extra to do so since you're dirtying the inode below
anyway.

Thanks!

> >                 mark_inode_dirty(inode);
> >                 set_bit(QDF_REFRESH, &qd->qd_flags);
> >         }
> > --
> > 2.40.1
> >=20
>=20
> Thanks,
> Andreas
>=20

--=20
Jeff Layton <jlayton@kernel.org>
