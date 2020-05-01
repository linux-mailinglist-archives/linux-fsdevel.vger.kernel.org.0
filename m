Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7141C194A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgEAPX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:23:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728839AbgEAPX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588346605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rc411N4SAXY5qhpedf1WCTFSc6a6Qy1N6E4oUExpPQw=;
        b=Z8dGCsQ7sJJ/ithZOblQlBzosCRZshV6XahEgdiqCV+I3e7yO46jrbqq/83VZkXLwrZ9D6
        VYkm5H5vWXZEy/IXoF9z4HrJj7C9vf6B9cowQw6nA2LypJlWgI8R47qvWNu0YlJ7Bi1yuX
        YijVRFqYW6GFDjVRMACgp6QwsrfJxHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-dC2DbCpEN8WsLDvO8C9gOA-1; Fri, 01 May 2020 11:23:04 -0400
X-MC-Unique: dC2DbCpEN8WsLDvO8C9gOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3D94100CCD1;
        Fri,  1 May 2020 15:23:02 +0000 (UTC)
Received: from localhost (ovpn-112-36.ams2.redhat.com [10.36.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEC8D196AE;
        Fri,  1 May 2020 15:22:59 +0000 (UTC)
Date:   Fri, 1 May 2020 16:22:58 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        Chirantan Ekbote <chirantan@chromium.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH][v2] fuse, virtiofs: Do not alloc/install fuse device in
 fuse_fill_super_common()
Message-ID: <20200501152258.GB221440@stefanha-x1.localdomain>
References: <20200430171814.GA275398@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430171814.GA275398@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 01:18:14PM -0400, Vivek Goyal wrote:
> As of now fuse_fill_super_common() allocates and installs one fuse device=
.
> Filesystems like virtiofs can have more than one filesystem queues and
> can have one fuse device per queue. Give, fuse_fill_super_common() only
> handles one device, virtiofs allocates and installes fuse devices for
> all queues except one.
>=20
> This makes logic little twisted and hard to understand. It probably
> is better to not do any device allocation/installation in
> fuse_fill_super_common() and let caller take care of it instead.
>=20
> v2: Removed fuse_dev_alloc_install() call from fuse_fill_super_common().
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/fuse_i.h    |  3 ---
>  fs/fuse/inode.c     | 30 ++++++++++++++----------------
>  fs/fuse/virtio_fs.c |  9 +--------
>  3 files changed, 15 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6sPtIACgkQnKSrs4Gr
c8hliQgAot+qe3sDadrMM/5bgjSPMJ98MqyVdtboP5q7pS53Uw52QJyEZpWm4o2/
G3ACgq4R5RXhWfD4MZjHDRM2Co3RlINGaGCT6VqEdozxdZ+iNjkSvo62mdVjNRjC
T7xqJYZlm7rDOqXqV3KG3jAEUmnPVikG4wsm+nJAlpUhH52ygQdhRWT8H0/tlSgV
RE2Y8PZaafSHvJf8SnCNz4SQskUj77kSHjN4JpmS0iKRyQCyVlz64ZJ3VW92HJWM
P13604JeZ95E0g0L4fRSSnw5ZsA1QuCrVpsKto+GgLEiqTmH5wuLiTMNKg8XdL/F
qEQAGGrtIgt/27/FLmF4uYQkDFAEJA==
=3pgI
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

