Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B162DA917E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfIDSQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 14:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbfIDSQl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1812307D971;
        Wed,  4 Sep 2019 18:16:40 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8B505C22F;
        Wed,  4 Sep 2019 18:16:31 +0000 (UTC)
Date:   Wed, 4 Sep 2019 19:16:30 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Message-ID: <20190904181630.GB26826@stefanha-x1.localdomain>
References: <20190903113640.7984-1-mszeredi@redhat.com>
 <20190903114203.8278-10-mszeredi@redhat.com>
 <20190903092222-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20190903092222-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 04 Sep 2019 18:16:40 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 09:55:49AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 03, 2019 at 01:42:02PM +0200, Miklos Szeredi wrote:
> Endian-ness for fuse header also looks wrong.
[...]
> > +struct virtio_fs_forget {
> > +	struct fuse_in_header ih;
> > +	struct fuse_forget_in arg;
>=20
> These structures are all native endian.
>=20
> Passing them to host will make cross-endian setups painful to support,
> and hardware implementations impossible.
>=20
> How about converting everything to LE?

The driver dictates the endianness of the FUSE protocol session.  The
virtio-fs device specification states that the device looks at the first
request's fuse_in_header::opcode field to detect the guest endianness.

If it sees FUSE_INIT in its native endianness then no byte-swapping is
necessary.  If it sees FUSE_INIT in the opposite endianness then
byte-swapping is necessary on the device side.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1v/34ACgkQnKSrs4Gr
c8i/Ngf/avxJID8kUoTNNjfyRoLArYmKGT1yBKp6x5LN822UCgyyHpur20MmX6XI
zFrzqnp+AlNkaQu9P9RKeh2mhdnZNjHx9KSg/UezvIHG055WKJ2WTw2SQDhuAY5q
Yz4+5Se2gV8OeNDIPoqBFXM+yLLJpXATZGrtKSoAQd5x8Q/ll6ctpzcM71rCDVla
2kbcqDNOBo+A45A8cfHLJ8a4ppNOKoFbWPp+DLsyHPiifbdFAxxMbG4SgsnN6i59
1n/+Y6Nz/92n6kL/czYdZ6kwovv9IUdO0DFzn/lQpgRYL3dLO/qS5G7/korqfnyf
JUECay8lk+EPxVOJPt9HFaen8QA2xw==
=sBLJ
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
