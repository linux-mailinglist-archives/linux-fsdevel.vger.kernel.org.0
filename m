Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595EE1599B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgBKTZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:25:14 -0500
Received: from shelob.surriel.com ([96.67.55.147]:58646 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgBKTZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:25:14 -0500
X-Greylist: delayed 1150 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 14:25:13 EST
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j1ar4-0001St-CT; Tue, 11 Feb 2020 14:05:54 -0500
Message-ID: <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
From:   Rik van Riel <riel@surriel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Date:   Tue, 11 Feb 2020 14:05:38 -0500
In-Reply-To: <20200211175507.178100-1-hannes@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-be8J/gfsysm0dy6l7psF"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-be8J/gfsysm0dy6l7psF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-11 at 12:55 -0500, Johannes Weiner wrote:
> The VFS inode shrinker is currently allowed to reclaim inodes with
> populated page cache. As a result it can drop gigabytes of hot and
> active page cache on the floor without consulting the VM (recorded as
> "inodesteal" events in /proc/vmstat).
>=20
> This causes real problems in practice. Consider for example how the
> VM
> would cache a source tree, such as the Linux git tree. As large parts
> of the checked out files and the object database are accessed
> repeatedly, the page cache holding this data gets moved to the active
> list, where it's fully (and indefinitely) insulated from one-off
> cache
> moving through the inactive list.

> This behavior of invalidating page cache from the inode shrinker goes
> back to even before the git import of the kernel tree. It may have
> been less noticeable when the VM itself didn't have real workingset
> protection, and floods of one-off cache would push out any active
> cache over time anyway. But the VM has come a long way since then and
> the inode shrinker is now actively subverting its caching strategy.

Two things come to mind when looking at this:
- highmem
- NUMA

IIRC one of the reasons reclaim is done in this way is
because a page cache page in one area of memory (highmem,
or a NUMA node) can end up pinning inode slab memory in
another memory area (normal zone, other NUMA node).

I do not know how much of a concern that still is nowadays,
but it seemed something worth bringing up.

--=20
All Rights Reversed.

--=-be8J/gfsysm0dy6l7psF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5C+wIACgkQznnekoTE
3oO/IQgAl8ZKBW1n3o9BCqwLSqcu66jPS/q2dziIacDoXS3zW7ME3LAqluQa3Qen
cN2+lPymRfObV9cUMHBd5Q8lZSPu4ABn/Vgp5I37pyA9WOgfC3yLVWvgbWIXn40u
Rnl9TQn6TIsvZTY/3VD3MYrbry3Q87wrOrrUyRzeL7kZQ3s6njARKXrN44yN+ABf
DirTGAH3PeBMd+JZNVT3yAGcp3EW1Oe2Fda99orpAh/kD7dKK1Gat/s2k0AwHvZz
o3zhYqLbIi+4cNGj/g234KsMJpEfRwjZxVcsYaenm3qaWR4arNYV/5+M0lYsRNYK
8YRHaOQR5GDctvip88bDvdThWfDplw==
=XJG5
-----END PGP SIGNATURE-----

--=-be8J/gfsysm0dy6l7psF--

