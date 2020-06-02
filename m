Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA41EB885
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgFBJ32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 05:29:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20591 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgFBJ32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591090167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaAnC1bu8czWhxdtW2udCqceu2QK2ffQrzn9j3bkG8Q=;
        b=UoHVxX62YWpOrJi6Mh6oaYaxriR+cUgYwgO2ZcgD4fj0quWAoaGnAjOUZzEesFF/UihWvn
        WxtyX/QVCRyOH1gG2jFRWtCpJGAKQm676fn4Sz+wGw9JuJCIEqQe0nJt2R+4ihB6iYebZM
        bZTB9pyX292Y3HTuo3KQkWjAeAJsT7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-kN1EWEaFMuaHDH2AGVvYHw-1; Tue, 02 Jun 2020 05:29:25 -0400
X-MC-Unique: kN1EWEaFMuaHDH2AGVvYHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFA64100CCC1;
        Tue,  2 Jun 2020 09:29:23 +0000 (UTC)
Received: from localhost (ovpn-115-9.ams2.redhat.com [10.36.115.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E449111A9DC;
        Tue,  2 Jun 2020 09:29:17 +0000 (UTC)
Date:   Tue, 2 Jun 2020 10:29:16 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>, slp@redhat.com
Subject: Re: [PATCH 2/2] fuse: virtiofs: Add basic multiqueue support
Message-ID: <20200602092916.GC9852@stefanha-x1.localdomain>
References: <20200424062540.23679-1-chirantan@chromium.org>
 <20200424062540.23679-2-chirantan@chromium.org>
 <20200427151934.GB1042399@stefanha-x1.localdomain>
 <CAJFHJrr2DAgQC9ZWx78OudX1x6A57_vpLf4rJu80ceR6bnpbaQ@mail.gmail.com>
 <20200501154752.GA222606@stefanha-x1.localdomain>
 <CAJFHJrpdbVKWyGuJJCBATVaYZsPLeg6JzpZmGFDsUcF_a4gcMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJrpdbVKWyGuJJCBATVaYZsPLeg6JzpZmGFDsUcF_a4gcMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 05:10:15PM +0900, Chirantan Ekbote wrote:
> On Sat, May 2, 2020 at 12:48 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Fri, May 01, 2020 at 04:14:38PM +0900, Chirantan Ekbote wrote:
> > > On Tue, Apr 28, 2020 at 12:20 AM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> > io_uring's vocabulary is expanding.  It can now do openat2(2), close(2)=
,
> > statx(2), but not mkdir(2), unlink(2), rename(2), etc.
> >
> > I guess there are two options:
> > 1. Fall back to threads for FUSE operations that cannot yet be done via
> >    io_uring.
> > 2. Process FUSE operations that cannot be done via io_uring
> >    synchronously.
> >
>=20
> I'm hoping that using io_uring for just the reads and writes should
> give us a big enough improvement that we can do the rest of the
> operations synchronously.

Sounds like a good idea.

Stefan

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7WG+wACgkQnKSrs4Gr
c8itMggArze0SlGMV0FObjiOGh2x91wC4w83cdukHjDRXnx8LUROTBFIWVUDTxYz
YRq46Fr1LAx38jacfEQVrTbBVDgK5FQzobPKrJycw4X2z5b3OvfH3iO+Xx9KcL4M
4MXBvL+Z4EBpXQmdWeR25jAztg75rqapof0x4o+ZESbu7h4oItjYjmBHszbx+t+s
63anVjgk/0zoi66ifHzupCJSuxfAVuyFMUU6zNQBWPtWPzhjE87rPH/ZKDtQAylB
H5UxNF5nidSN7qTPm9sFxEa7SPuXUw+tdfKXZZVN3PbOBITQSgE7NHdAjEpDzgRs
MOS5GYYlk740tAAMpTFDFydpJuGQdQ==
=FKk/
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

