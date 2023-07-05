Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A99749031
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 23:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGEVtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjGEVtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7B1FFF;
        Wed,  5 Jul 2023 14:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1195661751;
        Wed,  5 Jul 2023 21:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E78C433C7;
        Wed,  5 Jul 2023 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688593709;
        bh=h+2Oiqv58gv2R2xrLYaAfuDcnFGFQp3vjxbTRcCD3nk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uYAsWrZnNsKm67NabNfCqqsuoiplt1RFIzeyfmhi0CvjEy6szK1kzcAX+caCXIi8D
         tNphEy2+4+DidH4f/7zTuli+zcD49lSAm/CWpM7DonP9xVehceVSmlMpr5LSmGdc+j
         0j51Y+kCp2oPaBo/nXxuZpw7E5cU7obblDZHnCzybDgS3/1r4RC9VF74bIuGMqqFac
         DVM24/jWLK0Ph/Wb8nr806CrVy7zYksfunXO6TmumEGAY6X2kp9rSvgWeD978JsqvW
         1PIiS0in5CtMZ+FuYP+L7A2HY/4iaFsY98NRfuB18Q4FAyB5f4tIDlHZZNersY7hI4
         tlc2tZtwXWdDQ==
Message-ID: <9711e5f19dd2c040b4105147129a8db0aaf94b53.camel@kernel.org>
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
Date:   Wed, 05 Jul 2023 17:48:24 -0400
In-Reply-To: <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
References: <20230609125023.399942-1-jlayton@kernel.org>
         <20230609125023.399942-8-jlayton@kernel.org>
         <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
         <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
         <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Wed, 2023-07-05 at 22:25 +0200, Andreas Gruenbacher wrote:
> On Mon, Jun 12, 2023 at 12:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> > > Jeff,
> > >=20
> > > On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/gfs2/quota.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > > > index 1ed17226d9ed..6d283e071b90 100644
> > > > --- a/fs/gfs2/quota.c
> > > > +++ b/fs/gfs2/quota.c
> > > > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode =
*ip, loff_t loc,
> > > >                 size =3D loc + sizeof(struct gfs2_quota);
> > > >                 if (size > inode->i_size)
> > > >                         i_size_write(inode, size);
> > > > -               inode->i_mtime =3D inode->i_atime =3D current_time(=
inode);
> > > > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctim=
e =3D current_time(inode);
> > >=20
> > > I don't think we need to worry about the ctime of the quota inode as
> > > that inode is internal to the filesystem only.
> > >=20
> >=20
> > Thanks Andreas.  I'll plan to drop this patch from the series for now.
> >=20
> > Does updating the mtime and atime here serve any purpose, or should
> > those also be removed? If you plan to keep the a/mtime updates then I'd
> > still suggest updating the ctime for consistency's sake. It shouldn't
> > cost anything extra to do so since you're dirtying the inode below
> > anyway.
>=20
> Yes, good point actually, we should keep things consistent for simplicity=
.
>=20
> Would you add this back in if you do another posting?
>=20

I just re-posted the other patches in this as part of the ctime accessor
conversion. If I post again though, I can resurrect the gfs2 patch.=C2=A0If
not, we can do a follow-on fix later.

Since we're discussing it, it may be more correct to remove the atime
update there. gfs2_adjust_quota sounds like a "modify" operation, not a
"read", so I don't see a reason to update the atime.

In general, the only time you only want to set the atime, ctime and
mtime in lockstep is when the inode is brand new.
--=20
Jeff Layton <jlayton@kernel.org>
