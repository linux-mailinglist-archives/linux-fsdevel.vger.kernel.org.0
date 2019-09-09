Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B89AD359
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfIIHAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 03:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfIIHAp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2599C10F1FC3;
        Mon,  9 Sep 2019 07:00:44 +0000 (UTC)
Received: from localhost (ovpn-116-146.ams2.redhat.com [10.36.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F19060923;
        Mon,  9 Sep 2019 07:00:40 +0000 (UTC)
Date:   Mon, 9 Sep 2019 09:00:39 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] init/do_mounts.c: add virtiofs root fs support
Message-ID: <20190909070039.GB13708@stefanha-x1.localdomain>
References: <20190906100324.8492-1-stefanha@redhat.com>
 <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Mon, 09 Sep 2019 07:00:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 09:16:04PM +0200, Richard Weinberger wrote:
> On Fri, Sep 6, 2019 at 1:15 PM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >
> > Make it possible to boot directly from a virtiofs file system with tag
> > 'myfs' using the following kernel parameters:
> >
> >   rootfstype=3Dvirtiofs root=3Dmyfs rw
> >
> > Booting directly from virtiofs makes it possible to use a directory on
> > the host as the root file system.  This is convenient for testing and
> > situations where manipulating disk image files is cumbersome.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > This patch is based on linux-next (next-20190904) but should apply
> > cleanly to other virtiofs trees.
> >
> >  init/do_mounts.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 9634ecf3743d..030be2f1999a 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -554,6 +554,16 @@ void __init mount_root(void)
> >                         change_floppy("root floppy");
> >         }
> >  #endif
> > +#ifdef CONFIG_VIRTIO_FS
> > +       if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> > +               if (!do_mount_root(root_device_name, "virtiofs",
> > +                                  root_mountflags, root_mount_data))
> > +                       return;
> > +
> > +               panic("VFS: Unable to mount root fs \"%s\" from virtiof=
s",
> > +                     root_device_name);
> > +       }
> > +#endif
>=20
> I think you don't need this, you can abuse a hack for mtd/ubi in
> prepare_namespace().
> At least for 9p it works well:
> qemu-system-x86_64 -m 4G -M pc,accel=3Dkvm -nographic -kernel
> arch/x86/boot/bzImage -append "rootfstype=3D9p
> rootflags=3Dtrans=3Dvirtio,version=3D9p2000.L root=3Dmtdfake console=3Dtt=
yS0 ro
> init=3D/bin/sh" -virtfs
> local,id=3Drootfs,path=3D/,security_model=3Dpassthrough,mount_tag=3Dmtdfa=
ke

That is worse because:
1. The file system must be named "mtd*" or "ubi*".
2. When mounting fails you get confusing error messages about block
   devices and partitions.  These do not apply to virtio-fs or
   virtio-9p.

> If this works too for virtiofs I suggest to cleanup the hack and
> generalize it. B-)

Why mtd and ubi block devices even have a special case?  Maybe this code
was added because ROOT_DEV =3D name_to_dev_t(root_device_name) doesn't
work for "mtd:partition" device names so the regular CONFIG_BLOCK code
path doesn't work for these devices.

Given the ordering/fallback logic in prepare_namespace()/mount_root() I
don't feel comfortable changing other code paths.  It's likely to break
something.

If you or others have a concrete suggestion for how to generalize this
I'm happy to try implementing it.

Stefan

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl11+JcACgkQnKSrs4Gr
c8jD+ggAtec2VK6HTVZXWnVz7jhRkR+8bfbgzrlDBG3uGx9qQjlWFeFJyfMW2a5p
wyITms/GEETqo9W3n7oEOIlGhU8O+A1W265yc46JS9jEHai2Kx128I0ZnWp/3ncd
/irYhXPNNDG8dScLruAzltY9XkiMvAUFMbTwx4PRuZZTV60EQtKDoZ2wJar9y4uD
rGVNJqTaF3mLcGZdw/0w3nRKtR6XhX+O29OP4D/o7tt9FWnffh00adB9OQDUyXf5
DkwHtrWdiLxiOAsSCZklA9Ps39U7LfCmnja2IUkYJdDyfmKsYMOj3bTxf79VCBOC
Z0lm/US2an7287f+Y7/ReC6vG2uKbg==
=zPN2
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
