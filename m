Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933FBADCC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfIIQK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 12:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfIIQK4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:10:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2841C31752A7;
        Mon,  9 Sep 2019 16:10:56 +0000 (UTC)
Received: from localhost (ovpn-117-107.ams2.redhat.com [10.36.117.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F76C60BF4;
        Mon,  9 Sep 2019 16:10:50 +0000 (UTC)
Date:   Mon, 9 Sep 2019 18:10:45 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
 ->remove time
Message-ID: <20190909161045.GD20875@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-9-vgoyal@redhat.com>
 <20190906105210.GP5900@stefanha-x1.localdomain>
 <20190906141705.GF22083@redhat.com>
 <20190906101819-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <20190906101819-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 09 Sep 2019 16:10:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 10:18:49AM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 06, 2019 at 10:17:05AM -0400, Vivek Goyal wrote:
> > On Fri, Sep 06, 2019 at 11:52:10AM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> > > > +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> > > > +{
> > > > +	WARN_ON(fsvq->in_flight < 0);
> > > > +
> > > > +	/* Wait for in flight requests to finish.*/
> > > > +	while (1) {
> > > > +		spin_lock(&fsvq->lock);
> > > > +		if (!fsvq->in_flight) {
> > > > +			spin_unlock(&fsvq->lock);
> > > > +			break;
> > > > +		}
> > > > +		spin_unlock(&fsvq->lock);
> > > > +		usleep_range(1000, 2000);
> > > > +	}
> > >=20
> > > I think all contexts that call this allow sleeping so we could avoid
> > > usleep here.
> >=20
> > usleep_range() is supposed to be used from non-atomic context.
> >=20
> > https://github.com/torvalds/linux/blob/master/Documentation/timers/time=
rs-howto.rst
> >=20
> > What construct you are thinking of?
> >=20
> > Vivek
>=20
> completion + signal on vq callback?

Yes.  Time-based sleep() is sub-optimal because we could wake up exactly
when in_flight is decremented from the vq callback.  This avoids
unnecessary sleep wakeups and the extra time spent sleeping after
in_flight has been decremented.

Stefan

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl12eYUACgkQnKSrs4Gr
c8gSKQgAnEAvX9YIhk4yOMGl/UMlOnxBybw15xYg29qYtIPTCBl5Px/k0kPkDeK/
iHnhS/2epJz36c5DV0GEfGGX1HCzcKt9zLHZ5RI7NKV5HV5pBKsftliW6gY0yo/p
z0+lghQwP7izbE1EpPGWHichCu+hctoBnwlckg6TFmJxs+xWeSwdsDJ8Vya28tQl
IXvedRgLh0fOX8F7ZkH0pRrmAkzcERWoXjf17QeOEsntwzWWZ9/1LYOwzMo/1imn
exUSUMA7NFgVr4esi8G1LM3kHJRoaQcwCmSN9GGAc2dpUblNzwW04kmD6wAMpOXA
DvrZS9U0BxnNqVjpKlNjyH7fRY7epA==
=8+oH
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
