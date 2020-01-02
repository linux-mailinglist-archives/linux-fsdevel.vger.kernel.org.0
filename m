Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAB12E8B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgABQdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 11:33:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728800AbgABQdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577982812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlchMaIvasLMm30BcrAzvO65BEfeYNv4RmHmgwKHDHM=;
        b=AV/Uk42ASCaTxh4rK+oyrgmCjHXNj5r5vyKYmcFGQaE/LI7TkqXVpjNIFauWL7cLKtiVvt
        jppTczM+bTWeaA3kX5RyJnAtw08xP7Tuh9HxgWKJMQbrr8Jnm6QNdP5WTBYqoySUjeCjRE
        Xz1POlZV+IOeRW15jC8+pqm81xBjSVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-f6RSfu66O-SgKyoHEVPNVg-1; Thu, 02 Jan 2020 11:33:31 -0500
X-MC-Unique: f6RSfu66O-SgKyoHEVPNVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E6F800D55;
        Thu,  2 Jan 2020 16:33:27 +0000 (UTC)
Received: from localhost (ovpn-117-73.ams2.redhat.com [10.36.117.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 654815D9C9;
        Thu,  2 Jan 2020 16:33:23 +0000 (UTC)
Date:   Thu, 2 Jan 2020 16:33:21 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Martin Wilck <mwilck@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ira Weiny <ira.weiny@intel.com>, Iustin Pop <iustin@k1024.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20200102163321.GA129642@stefanha-x1.localdomain>
References: <20200102145552.1853992-1-arnd@arndb.de>
 <20200102145552.1853992-14-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20200102145552.1853992-14-arnd@arndb.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 03:55:31PM +0100, Arnd Bergmann wrote:
> Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
> handler that implements the same commands by calling scsi_compat_ioctl().
>=20
> The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
> at this point, so any driver that calls those can do so for both native
> and compat mode, with the argument passed through compat_ptr().
>=20
> With this, we can remove the entries from fs/compat_ioctl.c.  The new
> code is larger, but should be easier to maintain and keep updated with
> newly added commands.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/virtio_blk.c |   3 +
>  drivers/scsi/ch.c          |   9 ++-
>  drivers/scsi/sd.c          |  50 ++++++--------
>  drivers/scsi/sg.c          |  44 ++++++++-----
>  drivers/scsi/sr.c          |  57 ++++++++++++++--
>  drivers/scsi/st.c          |  51 ++++++++------
>  fs/compat_ioctl.c          | 132 +------------------------------------
>  7 files changed, 142 insertions(+), 204 deletions(-)

virtio_blk.c changes:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OG1AACgkQnKSrs4Gr
c8gMMQf/cVfSKOJIWw9oQSb1Jtb5IIqXpqhGWNQXQPYbbsemSZJf8GuCcr81Y/O8
thKinuXXPDyxp2YiInq3zMfIn72igNBLu6R7+vlLftbmMGpcrz6NNeZHGqCrYYpH
tAbiYVKixufdkX3Z7zYKF17i1dNJNpfUojqhkjgV6v0/T/p6kaf1B7wzJa1Jxwol
Et0imw7jvfyzjcKb285/9aX+zWpzupOPtjuBwZdqxW/UU6RtNq4zw0aqT3HtxKRH
pU/1PuaHsZPWdag7TssEimmaRlgOkAlGr5zxjQXEeVV+Cx9rVJEr+Alnl/NB2qrY
AOe6O0GvhUnX+3rYXUwaVHnsPPkEPw==
=C/4U
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

