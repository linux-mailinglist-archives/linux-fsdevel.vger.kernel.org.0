Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D916C3A109A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbhFIJyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 05:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238363AbhFIJyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623232327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eHky5eOBXRrSGwuG8KtlTkGS0BMT9r4MBUoEVxFLmI=;
        b=hg7L14/0mroDHQ8fui0abIWJ8XmiYQsj//dfifb2RiwXEwdi5/IjpCOndTa81r8VrAvOBz
        SxtEol3UnICtircXh/NiskpxMHkrKAjDex61q1LJ5Nku/d2UU+jCA1ELf3cOcT65BLQpnw
        n0ANNssCykJ9xzP5NwdKGu81bXNmlBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-gjTWI12YMVuQu-pq6Q9cIQ-1; Wed, 09 Jun 2021 05:52:05 -0400
X-MC-Unique: gjTWI12YMVuQu-pq6Q9cIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF41CEC1A6;
        Wed,  9 Jun 2021 09:52:03 +0000 (UTC)
Received: from localhost (ovpn-115-220.ams2.redhat.com [10.36.115.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9203B60917;
        Wed,  9 Jun 2021 09:51:59 +0000 (UTC)
Date:   Wed, 9 Jun 2021 10:51:56 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
References: <20210608153524.GB504497@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1gWRfrkqtUD7GC5m"
Content-Disposition: inline
In-Reply-To: <20210608153524.GB504497@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--1gWRfrkqtUD7GC5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 11:35:24AM -0400, Vivek Goyal wrote:
> We want to be able to mount virtiofs as rootfs and pass appropriate
> kernel command line. Right now there does not seem to be a good way
> to do that. If I specify "root=3Dmyfs rootfstype=3Dvirtiofs", system
> panics.
>=20
> virtio-fs: tag </dev/root> not found
> ..
> ..
> [ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown=
-block(0,0) ]
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
> So this patch proposes that we add a new prefix "fstag:" which specifies
> that identifier which follows is filesystem specific tag and its not
> a block device. Just pass this tag to filesystem and filesystem will
> figure out how to mount it.
>=20
> For example, "root=3Dfstag:<tag>".
>=20
> In case of virtiofs, I can specify "root=3Dfstag:myfs rootfstype=3Dvirtio=
fs"
> and it works.
>=20
> I think this should work for 9p as well. "root=3Dfstag:myfs rootfstype=3D=
9p".
> Though I have yet to test it.
>=20
> This kind of syntax should be able to address wide variety of use cases
> where root device is not a block device and is simply some kind of
> tag/label understood by filesystem.

"fstag" is kind of virtio-9p/fs specific. The intended effect is really
to specify the file system source (like in mount(2)) without it being
interpreted as a block device.

In a previous discussion David Gilbert suggested detecting file systems
that do not need a block device:
https://patchwork.kernel.org/project/linux-fsdevel/patch/20190906100324.849=
2-1-stefanha@redhat.com/

I never got around to doing it, but can do_mounts.c just look at struct
file_system_type::fs_flags FS_REQUIRES_DEV to detect non-block device
file systems?

That way it would know to just mount with root=3D as the source instead of
treating it as a block device. No root=3D prefix would be required and it
would handle NFS, virtiofs, virtio-9p, etc without introducing the
concept of a "tag".

  root=3Dmyfs rootfstype=3Dvirtiofs rootflags=3D...

I wrote this up quickly after not thinking about the topic for 2 years,
so the idea may not work at all :).

--1gWRfrkqtUD7GC5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDAjzwACgkQnKSrs4Gr
c8g2rwf+Lbq/l7qNfPeFBCeT7qDKMbAHP2CWZ4cOwtMJlonO6Dizq4JR3Uo5ac6/
Trie8uXKrFnh2h7kr8DD5AVWsljs5+AJ8OlIJkMWltY0S2gxXxtdlTCOpQGKxWJK
Bh8EiKe7pbCQcu57HKkOHaC9LLG0FZy6H5pMe+7kfZmQYwQRR/Uv3pnDw+79+N21
cfNLK54eK1i/3vQQnckIJ72dlQTbWUyF0MgXtSBwL+AAT7LYsex7EBhGZ7m8BLXG
ohOBGCslB/Uifdo5HU2qpKiuaO5cYksQvD5QxTZvz1mq+C7BwXX/Ogom4VjzJMUh
wuxTjfmYn45Rp66p1EzQ31EWtkgqXw==
=5rNC
-----END PGP SIGNATURE-----

--1gWRfrkqtUD7GC5m--

