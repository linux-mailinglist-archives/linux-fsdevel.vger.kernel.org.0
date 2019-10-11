Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6BD3BD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfJKJCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 05:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfJKJCL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:02:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93B4D18C426C;
        Fri, 11 Oct 2019 09:02:10 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5077196B2;
        Fri, 11 Oct 2019 09:02:09 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:02:08 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtio_fs: Fix file_system_type.name to virtio_fs
Message-ID: <20191011090208.GC2848@stefanha-x1.localdomain>
References: <20191004202921.21590-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20191004202921.21590-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 11 Oct 2019 09:02:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 04:29:21PM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> On 5.4.0-rc1 kernel, following warning happens when virtio_fs is tried
> to mount as "virtio_fs".
>=20
>   ------------[ cut here ]------------
>   request_module fs-virtio_fs succeeded, but still no fs?
>   WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x1=
38
>   Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
>   CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1
>=20
> That's because the file_system_type.name is "virtiofs", but the
> module name is "virtio_fs".
>=20
> Set the file_system_type.name to "virtio_fs".

The mount command-line should be mount -t virtiofs, not mount -t
virtio_fs.  Existing documentation on https://virtio-fs.gitlab.io/ still
says mount -t virtio_fs but this is outdated (sorry!).  I will update
the website and I don't think this patch needs to be merged.

We originally set the file_system_type.name to "virtio_fs" but Miklos
explained that other Linux file systems do not contain underscores in
their names.  The kernel module is called virtio_fs.ko and the code
internally uses "virtio_fs" as the prefix for function names, but from a
user point of the view the mount command-line must use "virtiofs".

Does this sound reasonable?

Stefan

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2gRRAACgkQnKSrs4Gr
c8jrtQf/ajKYZtamdrx9QXnzygHIpScPrO8EZlhHS0/D3ybPCoGQQqdeotXPlidB
NbxBjfsKNzUVCcODwRV6gMf2ZzaPbVPQNILhOwRNkFu7bpOei+PucK4VsAFf8hKG
rIh7uvsO+6qn35ch40Bp7HvnZr2iGsYPZNJ8UnubVbmNQoV52n4fh6+AZ6DpOTTD
FvzD6xjHXD3LmCpeszE0QmmSZHS2yTLEEENb7yOwUhaYgd6lJNkesHQEzlYir/pP
82S08CgZfiYBhPqv5yrY9Bx01hVnUbSIXaTxamKQu2aYc/kYWay9WNdCrMqUB6Lu
wazXXnS7YNxlX05j0xe8TnSpVvDx/Q==
=jn6U
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
