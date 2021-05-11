Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFE37A47D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhEKKY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhEKKY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620728601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0adrujpDKweoPEjP1QQ9qf3v1VudDZ63lGTmNiMcrI=;
        b=W91FxV6eU8xmzr97TSh8bE2iRF8FJJd286YTW5VxM58BRAYFrTh8YnliMG/efk8WVCAsN6
        HzwEKnsyvQfofVsC+tpJqVrDqVjzAu79kIpQcdsdfR5fWkJjbJvTB1N4PDWTey1nwgDm0N
        +GYvQvy8w1izqm93x2CRa+9GSFHsr8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Rsk5ItyUN_-KF78s2Vmb2g-1; Tue, 11 May 2021 06:23:17 -0400
X-MC-Unique: Rsk5ItyUN_-KF78s2Vmb2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAB8A1006C84;
        Tue, 11 May 2021 10:23:16 +0000 (UTC)
Received: from localhost (ovpn-112-6.ams2.redhat.com [10.36.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 557D2100164C;
        Tue, 11 May 2021 10:23:13 +0000 (UTC)
Date:   Tue, 11 May 2021 11:23:12 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
Message-ID: <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
References: <20210507221527.699516-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A7V9ozvfxmSnLtjw"
Content-Disposition: inline
In-Reply-To: <20210507221527.699516-1-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--A7V9ozvfxmSnLtjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2021 at 05:15:27PM -0500, Connor Kuehl wrote:
> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>  		 req->in.h.nodeid, req->in.h.len,
>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
> =20
> -	fsvq =3D &fs->vqs[queue_id];
> +	fsvq =3D this_cpu_read(this_cpu_fsvq);

Please check how CPU hotplug affects this patch. If the current CPU
doesn't have a vq because it was hotplugged, then it may be necessary to
pick another vq.

Stefan

--A7V9ozvfxmSnLtjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCaWxAACgkQnKSrs4Gr
c8gaYQf/ZbGTh/PBCw1PB2OJDsg9sJ/qLNSeJAXsrq1soajsgMZNL5qaCxFxca96
7Ct1XtEelrvOEivymGbnjYFnL3kDuTeYhPzlyPBwG9heVxBReVxmKaC18hm5GwKk
Qd481XSuaAF2gVk1B55pgfK4NwX/smvCgHpWvkP8vakZttXFUgMYcXM7Mi7V9XcJ
4f3EWA0m0iaWAkVJY2R+luPJtvc403igrv4QpUrw0kgn7iYw424W9O819g+Na4dO
8QdFtUmFHQsgwNVy6hKMnbhc7V0m3Hdwr2JVNXb2cd+yXqwVX+8xP3KeZOvBb5gX
hUibZHl+yf0GfluxoJUfjT8JXVtBDg==
=VnK4
-----END PGP SIGNATURE-----

--A7V9ozvfxmSnLtjw--

