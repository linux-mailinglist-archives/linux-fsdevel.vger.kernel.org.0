Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9099C20321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfEPKHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKHk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1662190C87;
        Thu, 16 May 2019 10:07:40 +0000 (UTC)
Received: from localhost (ovpn-117-183.ams2.redhat.com [10.36.117.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371376031D;
        Thu, 16 May 2019 10:07:39 +0000 (UTC)
Date:   Thu, 16 May 2019 11:07:37 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 12/30] dax: remove block device dependencies
Message-ID: <20190516100737.GT29507@stefanha-x1.localdomain>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-13-vgoyal@redhat.com>
 <CAPcyv4i_-ri=w0jYJ4WjK4QD9E8pMzkGQNdMbt9H_nawDqYD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="flpRHSNNLnUanxKW"
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_-ri=w0jYJ4WjK4QD9E8pMzkGQNdMbt9H_nawDqYD3A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 16 May 2019 10:07:40 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--flpRHSNNLnUanxKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 05:21:51PM -0700, Dan Williams wrote:
> On Wed, May 15, 2019 at 12:28 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > Although struct dax_device itself is not tied to a block device, some
> > DAX code assumes there is a block device.  Make block devices optional
> > by allowing bdev to be NULL in commonly used DAX APIs.
> >
> > When there is no block device:
> >  * Skip the partition offset calculation in bdev_dax_pgoff()
> >  * Skip the blkdev_issue_zeroout() optimization
> >
> > Note that more block device assumptions remain but I haven't reach those
> > code paths yet.
> >
>=20
> Is there a generic object that non-block-based filesystems reference
> for physical storage as a bdev stand-in? I assume "sector_t" is still
> the common type for addressing filesystem capacity?
>=20
> It just seems to me that we should stop pretending that the
> filesystem-dax facility requires block devices and try to move this
> functionality to generically use a dax device across all interfaces.

virtio-fs uses a PCI BAR called the DAX Window to access data.  This
object is internal to the virtio_fs.ko driver, not really a generic
object that DAX code can reference.

But does the DAX code need to reference any object at all?  It seems
like block device users just want callbacks for the partition offset
calculation and blkdev_issue_zeroout().

--flpRHSNNLnUanxKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzdNmkACgkQnKSrs4Gr
c8hlhwf/ZCSwXpZNQdt/OCUHk7Hmm4JUkkwbqJjArJ+4xdT38FYyvgvQRx48CaHc
j4Nk4DMd4zRI3u8A95ycomu+EEM8lelihD7TZHrPwgfz2lSbIxZoWyimDwwVtV3e
wW1CKnQjdPd0cRLUfj77Ob3JlBLoBXXpX4twezwP4IWKAk8Y1Roe2e3CCSVqbonV
2MKgECxGzqozQBS80h775/sQ3kwGrfR59KP3RyVAtpUgnkW3KQPHBF4psTviVd7j
uqJsUq0NsDX7TaUHVsR0H9o2k1S7RcYHf3yyCBvmCJwYwLrCwQFFBjM+qWRdfx/2
K8WG0G/Hq/TRCkuVc6+0hpyQDsKtDg==
=Y/FU
-----END PGP SIGNATURE-----

--flpRHSNNLnUanxKW--
