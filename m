Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A225105650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKUQAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:00:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbfKUQAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574352053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fl5jon/Xn0As09tGosG/4/lknhZw/odWV00qKChGNfE=;
        b=L+0WpVpk4/TEUGtTtK2sOxsth9++SaulmVf9svTKe7tJL/iy8FyRHkdEu92HFyl0AJSwmr
        L609XPSuc0DxGTagLPK3AjgeXisfde1I4TGdnFXJpTE01WXBvXi5y/Hrxj+ukdkWIw6kOD
        d1daaCEwCpxtt/paGVIiueQ7JLLyK7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-2dU94oSiO1SQ9yuKpiU7UA-1; Thu, 21 Nov 2019 11:00:50 -0500
X-MC-Unique: 2dU94oSiO1SQ9yuKpiU7UA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1644189DAF9;
        Thu, 21 Nov 2019 16:00:49 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 970611823F;
        Thu, 21 Nov 2019 16:00:46 +0000 (UTC)
Date:   Thu, 21 Nov 2019 16:00:45 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH 2/4] virtiofs: Add an index to keep track of first
 request queue
Message-ID: <20191121160045.GD445244@stefanha-x1.localdomain>
References: <20191115205705.2046-1-vgoyal@redhat.com>
 <20191115205705.2046-3-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205705.2046-3-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:57:03PM -0500, Vivek Goyal wrote:
> @@ -990,7 +994,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq =
*fsvq,
>  static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
>  __releases(fiq->lock)
>  {
> -=09unsigned int queue_id =3D VQ_REQUEST; /* TODO multiqueue */
> +=09unsigned int queue_id;
>  =09struct virtio_fs *fs;
>  =09struct fuse_req *req;
>  =09struct virtio_fs_vq *fsvq;

Sorry, I removed too much context in my reply.  This TODO...

> @@ -1004,6 +1008,7 @@ __releases(fiq->lock)
>  =09spin_unlock(&fiq->lock);
> =20
>  =09fs =3D fiq->priv;
> +=09queue_id =3D fs->first_reqq_idx;

...should be moved here.

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WtK0ACgkQnKSrs4Gr
c8gQ3Af+PW0BnVxXMs0ogKUzltp1vxcPYfq4/js7a6Q7fcsgCdJFpoDIxKkfC1t0
/N8JzkRrlqCdSBJ9Y4dvTl7jE4eSK/gVTBcjPt/BM0UY4vr5uLVD4lEtBI56yman
Nz4nZfZ2llDrIBy1mJy1lih/7bzt/q+qLKwkTKytDpJ9B+cFAJNZzLkFRPni+whc
2rooMFvXYAa7r6fCV0SjtL8RHCK4G2d12GdWsR0/8bJjxCBW6ponacxps7JWn8fi
soqP8w5UNmGKAvYZmIkDLOHM7HhpdBKqInNQ4e6ZJCawPNvsKOcv3b+dqrcfgTDe
iKEo4xRR0AEwcKybfAjhs62bsVLopg==
=UlMv
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--

