Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3732C1F69AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFKOLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 10:11:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:41852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgFKOLc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:11:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 99F98AC4E;
        Thu, 11 Jun 2020 14:11:34 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:11:27 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     darrick.wong@oracle.com, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 0/3] Transient errors in Direct I/O
Message-ID: <20200611141127.ir7b3ohd3c3qtunu@fiona>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
 <3e11c9ae-15c5-c52a-2e8a-14756a5ef967@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5sto64odfm4e5q74"
Content-Disposition: inline
In-Reply-To: <3e11c9ae-15c5-c52a-2e8a-14756a5ef967@gmx.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5sto64odfm4e5q74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13:31 10/06, Qu Wenruo wrote:
>=20
>=20
> On 2020/6/6 =E4=B8=8A=E5=8D=884:48, Goldwyn Rodrigues wrote:
> > In current scenarios, for XFS, it would mean that a page invalidation
> > would end up being a writeback error. So, if iomap returns zero, fall
> > back to biffered I/O. XFS has never supported fallback to buffered I/O.
> > I hope it is not "never will" ;)
> >=20
> > With mixed buffered and direct writes in btrfs, the pages may not be
> > released the extent may be locked in the ordered extents cleanup thread,
>=20
> I'm wondering can we handle this case in a different way.
>=20
> In fact btrfs has its own special handling for invalidating pages.
> Btrfs will first look for any ordered extents covering the page, finish
> the ordered extent manually, then invalidate the page.
>=20
> I'm not sure why invalidate_inode_pages2_range() used in dio iomap code
> does not use the fs specific invalidatepage(), but only do_lander_page()
> then releasepage().
>=20
> Shouldn'y we btrfs implement the lander_page() to handle ordered extents
> properly?
> Or is there any special requirement?
>=20

The problem is aops->launder_page() is called only if PG_Dirty is
set. In this case it is not because we just performed a writeback.

Also, it is not just ordered ordered extent writeback which may lock
the extent, a buffered read can lock as well.

--=20
Goldwyn

--5sto64odfm4e5q74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTvlrIsQO1vhIr1p4dJubB2MCI4bAUCXuI7jgAKCRBJubB2MCI4
bEfPAJ9HfkChoGOyrZyo+gPEM8LqFxx0wACghgxv83hSZSqKilVjluqS68xyFYU=
=5kAN
-----END PGP SIGNATURE-----

--5sto64odfm4e5q74--
