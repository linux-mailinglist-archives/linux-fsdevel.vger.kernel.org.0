Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F39253605
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZReZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 13:34:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726851AbgHZReW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598463259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0k/yTjdPnHC4RVLZ5U9HSNgnDgDnk3LxVO52zNREUk=;
        b=EY8FDUjeyNU+2R7xulAG39GUh7pjq+1OoAbsIUHVZF+JNJ5hN7JKR4wjJtv4j7yTj69Ywo
        tkygQYyRjQaI4qpsWG8fho3vP7/taeozJHPTwMu4pwnk0hiCSamVNWGF/GYxEur9lXENqQ
        cat7sCazn3+5ASNALL5bVaSCXW5NlMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-_j7V4dcjNp-q-mvTaBbx_w-1; Wed, 26 Aug 2020 13:34:15 -0400
X-MC-Unique: _j7V4dcjNp-q-mvTaBbx_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078581009443;
        Wed, 26 Aug 2020 17:34:14 +0000 (UTC)
Received: from localhost (ovpn-114-37.ams2.redhat.com [10.36.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD73572E4F;
        Wed, 26 Aug 2020 17:34:10 +0000 (UTC)
Date:   Wed, 26 Aug 2020 18:34:08 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
Message-ID: <20200826173408.GA11480@stefanha-x1.localdomain>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <20200819221956.845195-12-vgoyal@redhat.com>
 <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
 <20200826155142.GA1043442@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826155142.GA1043442@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:51:42AM -0400, Vivek Goyal wrote:
> On Wed, Aug 26, 2020 at 04:06:35PM +0200, Miklos Szeredi wrote:
> > On Thu, Aug 20, 2020 at 12:21 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
> > > constraints via the FUST_INIT map_alignment field.  Parse this field =
and
> > > ensure our DAX mappings meet the alignment constraints.
> > >
> > > We don't actually align anything differently since our mappings are
> > > already 2MB aligned.  Just check the value when the connection is
> > > established.  If it becomes necessary to honor arbitrary alignments i=
n
> > > the future we'll have to adjust how mappings are sized.
> > >
> > > The upshot of this commit is that we can be confident that mappings w=
ill
> > > work even when emulating x86 on Power and similar combinations where =
the
> > > host page sizes are different.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/fuse/fuse_i.h          |  5 ++++-
> > >  fs/fuse/inode.c           | 18 ++++++++++++++++--
> > >  include/uapi/linux/fuse.h |  4 +++-
> > >  3 files changed, 23 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 478c940b05b4..4a46e35222c7 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -47,7 +47,10 @@
> > >  /** Number of dentries for each connection in the control filesystem=
 */
> > >  #define FUSE_CTL_NUM_DENTRIES 5
> > >
> > > -/* Default memory range size, 2MB */
> > > +/*
> > > + * Default memory range size.  A power of 2 so it agrees with common=
 FUSE_INIT
> > > + * map_alignment values 4KB and 64KB.
> > > + */
> > >  #define FUSE_DAX_SZ    (2*1024*1024)
> > >  #define FUSE_DAX_SHIFT (21)
> > >  #define FUSE_DAX_PAGES (FUSE_DAX_SZ/PAGE_SIZE)
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index b82eb61d63cc..947abdd776ca 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -980,9 +980,10 @@ static void process_init_reply(struct fuse_conn =
*fc, struct fuse_args *args,
> > >  {
> > >         struct fuse_init_args *ia =3D container_of(args, typeof(*ia),=
 args);
> > >         struct fuse_init_out *arg =3D &ia->out;
> > > +       bool ok =3D true;
> > >
> > >         if (error || arg->major !=3D FUSE_KERNEL_VERSION)
> > > -               fc->conn_error =3D 1;
> > > +               ok =3D false;
> > >         else {
> > >                 unsigned long ra_pages;
> > >
> > > @@ -1045,6 +1046,13 @@ static void process_init_reply(struct fuse_con=
n *fc, struct fuse_args *args,
> > >                                         min_t(unsigned int, FUSE_MAX_=
MAX_PAGES,
> > >                                         max_t(unsigned int, arg->max_=
pages, 1));
> > >                         }
> > > +                       if ((arg->flags & FUSE_MAP_ALIGNMENT) &&
> > > +                           (FUSE_DAX_SZ % (1ul << arg->map_alignment=
))) {
> >=20
> > This just obfuscates "arg->map_alignment !=3D FUSE_DAX_SHIFT".
> >=20
> > So the intention was that userspace can ask the kernel for a
> > particular alignment, right?
>=20
> My understanding is that device will specify alignment for
> the foffset/moffset fields in fuse_setupmapping_in/fuse_removemapping_one=
.
> And DAX mapping can be any size meeting that alignment contraint.
>=20
> >=20
> > In that case kernel can definitely succeed if the requested alignment
> > is smaller than the kernel provided one, no?=20
>=20
> Yes. So if map_alignemnt is 64K and DAX mapping size is 2MB, that's just
> fine because it meets 4K alignment contraint. Just that we can't use
> 4K size DAX mapping in that case.
>=20
> > It would also make
> > sense to make this a two way negotiation.  I.e. send the largest
> > alignment (FUSE_DAX_SHIFT in this implementation) that the kernel can
> > provide in fuse_init_in.   In that case the only error would be if
> > userspace ignored the given constraints.
>=20
> We could make it two way negotiation if it helps. So if we support
> multiple mapping sizes in future, say 4K, 64K, 2MB, 1GB. So idea is
> to send alignment of largest mapping size to device/user_space (1GB)
> in this case? And that will allow device to choose an alignment
> which best fits its needs?
>=20
> But problem here is that sending (log2(1GB)) does not mean we support
> all the alignments in that range. For example, if device selects say
> 256MB as minimum alignment, kernel might not support it.
>=20
> So there seem to be two ways to handle this.
>=20
> A.Let device be conservative and always specify the minimum aligment
>   it can work with and let guest kernel automatically choose a mapping
>   size which meets that min_alignment contraint.
>=20
> B.Send all the mapping sizes supported by kernel to device and then
>   device chooses an alignment as it sees fit. We could probably send
>   a 64bit field and set a bit for every size we support as dax mapping.
>   If we were to go down this path, I think in that case client should
>   respond back with exact mapping size we should use (and not with
>   minimum alignment).
>=20
> I thought intent behind this patch was to implement A.
>=20
> Stefan/David, this patch came from you folks. What do you think?

Yes, I agree with Vivek.

The FUSE server is telling the client the minimum alignment for
foffset/moffset. The client can map any size it likes as long as
foffset/moffset meet the alignment constraint. I can't think of a reason
to do two-way negotiation.

Stefan

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9GnRAACgkQnKSrs4Gr
c8i8qQgAi0d6McbpqX16ujzlPv9tVcTCdTlnZwn3MP83wQgiguSqi0L44w+0umqs
348uAC2cqKSpaPptRO6p6ihLmxTmVW9iuaY5HCcYJy2BXJyBUE0J8fvLjVYU+Rpk
KNP8CXlv3lCTEtH+v5PH8rnUxhZ5Wv5r5wDr//wVPIWymA/lYTLLolwqbkGGLtsg
wANNnS7HZNvpbrd9QAF2KWEU7D4H5NGC5c1/hxSx03FtsypGPHjTTQW7INpdr62F
kzCnJkBcUraD4e0Qv5q7DBbiBDnSU3wJ6I7iIVvuIefgy12lAI9K1aEXC1F7CmkB
SP/5kFFn3JgVfrS1HZNuCcOQ9duXxw==
=Bh+Q
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

