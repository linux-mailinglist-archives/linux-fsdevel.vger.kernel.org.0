Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475703A2664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFJISq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 04:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhFJISp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623313009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KO/y7zNyP8u6j6o2iIpPZOM2m28kJTCsOByjKWb4kSI=;
        b=XUHwqzaaWoPB8lh9YasCgk9tz1vQacJADqcgnOL30mnA8VrVMDlSSE/OV4xCt7E84c7erZ
        sFtXq+ZljSLzSIVgi7TlM7drIuCchO4llqtUqLFhXt3cXhJqkW3P8iDFfFVLveU82//51H
        tEsd1iM0eP3GXJ0Hrt58nxFuu1uk/l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-eU-5oco3MRGOKsq0mmm4_w-1; Thu, 10 Jun 2021 04:16:45 -0400
X-MC-Unique: eU-5oco3MRGOKsq0mmm4_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8170980DDE2;
        Thu, 10 Jun 2021 08:16:43 +0000 (UTC)
Received: from localhost (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E66C197F9;
        Thu, 10 Jun 2021 08:16:38 +0000 (UTC)
Date:   Thu, 10 Jun 2021 09:16:38 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <YMHKZhfT0CUgeLno@stefanha-x1.localdomain>
References: <20210608153524.GB504497@redhat.com>
 <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
 <20210609154543.GA579806@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O6p7GxVMoApyVHjK"
Content-Disposition: inline
In-Reply-To: <20210609154543.GA579806@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--O6p7GxVMoApyVHjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 11:45:43AM -0400, Vivek Goyal wrote:
> On Wed, Jun 09, 2021 at 10:51:56AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jun 08, 2021 at 11:35:24AM -0400, Vivek Goyal wrote:
> > > We want to be able to mount virtiofs as rootfs and pass appropriate
> > > kernel command line. Right now there does not seem to be a good way
> > > to do that. If I specify "root=3Dmyfs rootfstype=3Dvirtiofs", system
> > > panics.
> > >=20
> > > virtio-fs: tag </dev/root> not found
> > > ..
> > > ..
> > > [ end Kernel panic - not syncing: VFS: Unable to mount root fs on unk=
nown-block(0,0) ]
> > >=20
> > > Basic problem here is that kernel assumes that device identifier
> > > passed in "root=3D" is a block device. But there are few execptions
> > > to this rule to take care of the needs of mtd, ubi, NFS and CIFS.
> > >=20
> > > For example, mtd and ubi prefix "mtd:" or "ubi:" respectively.
> > >=20
> > > "root=3Dmtd:<identifier>" or "root=3Dubi:<identifier>"
> > >=20
> > > NFS and CIFS use "root=3D/dev/nfs" and CIFS passes "root=3D/dev/cifs"=
 and
> > > actual root device details come from filesystem specific kernel
> > > command line options.
> > >=20
> > > virtiofs does not seem to fit in any of the above categories. In fact
> > > we have 9pfs which can be used to boot from but it also does not
> > > have a proper syntax to specify rootfs and does not fit into any of
> > > the existing syntax. They both expect a device "tag" to be passed
> > > in a device to be mounted. And filesystem knows how to parse and
> > > use "tag".
> > >=20
> > > So this patch proposes that we add a new prefix "fstag:" which specif=
ies
> > > that identifier which follows is filesystem specific tag and its not
> > > a block device. Just pass this tag to filesystem and filesystem will
> > > figure out how to mount it.
> > >=20
> > > For example, "root=3Dfstag:<tag>".
> > >=20
> > > In case of virtiofs, I can specify "root=3Dfstag:myfs rootfstype=3Dvi=
rtiofs"
> > > and it works.
> > >=20
> > > I think this should work for 9p as well. "root=3Dfstag:myfs rootfstyp=
e=3D9p".
> > > Though I have yet to test it.
> > >=20
> > > This kind of syntax should be able to address wide variety of use cas=
es
> > > where root device is not a block device and is simply some kind of
> > > tag/label understood by filesystem.
> >=20
> > "fstag" is kind of virtio-9p/fs specific. The intended effect is really
> > to specify the file system source (like in mount(2)) without it being
> > interpreted as a block device.
>=20
> [ CC christoph ]
>=20
> I think mount(2) has little different requirements. It more or less
> passes the source to filesystem. But during early boot, we do so
> much more with source, that is parse it and determine device major
> and minor and create blockdevice and then call into filesystem.
>=20
> >=20
> > In a previous discussion David Gilbert suggested detecting file systems
> > that do not need a block device:
> > https://patchwork.kernel.org/project/linux-fsdevel/patch/20190906100324=
=2E8492-1-stefanha@redhat.com/
> >=20
> > I never got around to doing it, but can do_mounts.c just look at struct
> > file_system_type::fs_flags FS_REQUIRES_DEV to detect non-block device
> > file systems?
>=20
> I guess we can use FS_REQUIRES_DEV. We probably will need to add a helper
> to determine if filesystem passed in "rootfstype=3D" has FS_REQUIRES_DEV
> set or not.
>=20
> For now, I have written a patch which does not rely on FS_REQUIRES_DEV.
> Instead I have created an array of filesystems which do not want
> root=3D<source> to be treated as block device and expect that "source"
> will be directly passed to filesytem to be mounted.
>=20
> Reason I am not parsing FS_REQUIRES_DEV yet is that I am afraid that
> this can change behavior and introduce regression. Some filesystem
> which does not have FS_REQUIRES_DEV set but still somehow is going
> through block device path (or some path which I can't see yet).
>=20
> So for now I am playing safe and explicitly creating a list of
> filesystems which will opt-in into this behavior. But if folks think
> that my fears of regression are misplaced and I should parse
> FS_REQUIRES_DEV and that way any filesystem which does not have
> FS_REQUIRES_DEV set automatically gets opted in, I can do that.
>=20
> >=20
> > That way it would know to just mount with root=3D as the source instead=
 of
> > treating it as a block device. No root=3D prefix would be required and =
it
> > would handle NFS, virtiofs, virtio-9p, etc without introducing the
> > concept of a "tag".
> >=20
> >   root=3Dmyfs rootfstype=3Dvirtiofs rootflags=3D...
> >=20
> > I wrote this up quickly after not thinking about the topic for 2 years,
> > so the idea may not work at all :).
>=20
> Now with this patch "root=3Dmyfs, rootfstype=3Dvirtiofs, rootflags=3D..."=
 syntax
> works for virtiofs.
>=20
> Please have a look.

Looks good from a user perspective.

> Subject: [PATCH] init/do_mounts.c: Add a path to boot from non blockdev f=
ilesystems
>=20
> We want to be able to mount virtiofs as rootfs and pass appropriate
> kernel command line. Right now there does not seem to be a good way
> to do that. If I specify "root=3Dmyfs rootfstype=3Dvirtiofs", system
> panics.
>=20
> virtio-fs: tag </dev/root> not found
> ..
> ..
> [ end Kernel panic - not syncing: VFS: Unable to mount root fs on
> +unknown-block(0,0) ]
>=20
> Basic problem here is that kernel assumes that device identifier
> passed in "root=3D" is a block device. But there are few execptions
> to this rule to take care of the needs of mtd, ubi, NFS and CIFS.
>=20
> For example, mtd and ubi prefix "mtd:" or "ubi:" respectively.
>=20
> "root=3Dmtd:<identifier>" or "root=3Dubi:<identifier>"
>=20
> NFS and CIFS use "root=3D/dev/nfs" and CIFS passes "root=3D/dev/cifs" and
> actual root device details come from filesystem specific kernel
> command line options.
>=20
> virtiofs does not seem to fit in any of the above categories. In fact
> we have 9pfs which can be used to boot from but it also does not
> have a proper syntax to specify rootfs and does not fit into any of
> the existing syntax. They both expect a device "tag" to be passed
> in a device to be mounted. And filesystem knows how to parse and
> use "tag".
>=20
> So this patch proposes that we internally create a list of filesystems
> which don't expect a block device and whatever "source" has been
> passed in "root=3D<source>" option, should be passed to filesystem and
> filesystem should be able to figure out how to use "source" to
> mount filesystem.
>=20
> As of now I have only added "virtiofs" in the list of such filesystems.
> To enable it on 9p, it should be a simple change. Just add "9p" to
> the nobdev_filesystems[] array.

virtio-9p should be simple. I'm not sure how much additional setup the
other 9p transports require. TCP and RDMA seem doable if there are
kernel parameters to configure things before the root file system is
mounted.

--O6p7GxVMoApyVHjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDBymUACgkQnKSrs4Gr
c8id6wf/TbGvf38QDqOv/N1pdoZjKJPsUHSPKx7lZaw+DYZdZ8G4smREHi/OyOQy
63iBc3TOLWD2VghQPbnPL8aS2cWlu3vVk7LxOmF9ejN7rUePgaetKg7LSdRpNp6V
aVVRpaG006D+XS7r8+cmnEbOG1hYgLBbLiGGdHKn3Ml86/OhzEM/dTgSjr3DXDf4
53NHvG6fp1YYhlPO9SttzPDhfZzW33WNdqdA7d4toakxPzKG/Dbsx3DuGT4WewEP
AMkOsiWRHr/X5vLDffxMYrhgSnfP6dUf6Tk45YZdhBEB7YX2FovRFrzKmIVnANx/
FWpEyaBADv2+5osY2A4hBCr9RXyXuA==
=1fWD
-----END PGP SIGNATURE-----

--O6p7GxVMoApyVHjK--

