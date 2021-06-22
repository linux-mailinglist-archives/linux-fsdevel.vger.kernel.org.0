Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D53AFF60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFVIjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 04:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVIi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624351003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMP1HyhxKTyN2FUAhEkRKvFSSH4fVsdxmMyfHGuWDRA=;
        b=MSseycEDyOVfm486P6FpMiUBwn5PPZsgtjfUwK6cJ4B3b2se1YX/LhBve0Ai0RDmWfMh16
        uh1uHZV582R8wST5BnBcldYozX287er0Olr1Iwieeevt+aHKrLDNk56w5UY86mfotZ++hv
        sSEmyxlqmFCWIZzfxkpmJB8QZ0abOl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-dSDbuGJZP86OHu5ynYiK5g-1; Tue, 22 Jun 2021 04:36:39 -0400
X-MC-Unique: dSDbuGJZP86OHu5ynYiK5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA81362FB;
        Tue, 22 Jun 2021 08:36:38 +0000 (UTC)
Received: from localhost (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F18F5C1A3;
        Tue, 22 Jun 2021 08:36:34 +0000 (UTC)
Date:   Tue, 22 Jun 2021 09:36:33 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <YNGhERcnLuzjn8j9@stefanha-x1.localdomain>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210622081217.GA2975@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y+sWrBBljVlHm2Wk"
Content-Disposition: inline
In-Reply-To: <20210622081217.GA2975@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Y+sWrBBljVlHm2Wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 22, 2021 at 10:12:17AM +0200, Christoph Hellwig wrote:
> Just output the '\0' separate list of supported file systems for block
> devices directly rather than going through a pointless round of string
> manipulation.
>=20
> Based on an earlier patch from Al Viro <viro@zeniv.linux.org.uk>.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/filesystems.c   | 24 ++++++++++++++----------
>  include/linux/fs.h |  2 +-
>  init/do_mounts.c   | 20 +-------------------
>  3 files changed, 16 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 90b8d879fbaf..7c136251607a 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -209,21 +209,25 @@ SYSCALL_DEFINE3(sysfs, int, option, unsigned long, =
arg1, unsigned long, arg2)
>  }
>  #endif
> =20
> -int __init get_filesystem_list(char *buf)
> +void __init list_bdev_fs_names(char *buf, size_t size)
>  {
> -	int len =3D 0;
> -	struct file_system_type * tmp;
> +	struct file_system_type *p;
> +	size_t len;
> =20
>  	read_lock(&file_systems_lock);
> -	tmp =3D file_systems;
> -	while (tmp && len < PAGE_SIZE - 80) {
> -		len +=3D sprintf(buf+len, "%s\t%s\n",
> -			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
> -			tmp->name);
> -		tmp =3D tmp->next;
> +	for (p =3D file_systems; p; p =3D p->next) {
> +		if (!(p->fs_flags & FS_REQUIRES_DEV))
> +			continue;
> +		len =3D strlen(p->name) + 1;
> +		if (len > size) {
> +			pr_warn("%s: truncating file system list\n", __func__);
> +			break;
> +		}
> +		memcpy(buf, p->name, len);
> +		buf +=3D len;
> +		size -=3D len;
>  	}
>  	read_unlock(&file_systems_lock);
> -	return len;
>  }

I don't see the extra NUL terminator byte being added that's required by
the loop in mount_block_root()?

--Y+sWrBBljVlHm2Wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDRoREACgkQnKSrs4Gr
c8g8mgf+PDTW/0OS88/JmQ5E27ZXpLlNGUJkTSdpn4jhWZpdPhbG/+yiPRoTpPv8
NmvfbL7yomhRXntd+pA/WUlyF6Eb2SDv8Wfo0/qU+fTIsaHA7mz/d9300ucC1Thw
ZuDl7uadlf2KbJRlhLZHzl9Q2Q9+PsscEql0TSsIJU0X2qO1qxm4tvncbyyXY/lc
nLLkGJVf9205rvJf2TcuBFF1UYUThOB7+VjIzn2CBfKahLyTOGSePy5GyvcdFp2s
0EGWvIFHcsWuHxkDRdGVLt51bsOiEHRBsjZ7LHiIruzo0Y9tqYNJDTvhphtE+fMw
jDjcU52ufud1nFXZcKVeYswxfIp8vg==
=08W1
-----END PGP SIGNATURE-----

--Y+sWrBBljVlHm2Wk--

