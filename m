Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C612DEA2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgLRU0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 15:26:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730516AbgLRU0C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:26:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7CB0AF5D;
        Fri, 18 Dec 2020 20:25:20 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeffrey Layton <jlayton@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Date:   Sat, 19 Dec 2020 07:25:12 +1100
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        willy@infradead.org, jack@suse.cz, neilb@suse.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] overlayfs: Check writeback errors w.r.t upper in
 ->syncfs()
In-Reply-To: <20201218165551.GA1178523@tleilax.poochiereds.net>
References: <20201216233149.39025-1-vgoyal@redhat.com>
 <20201216233149.39025-4-vgoyal@redhat.com>
 <20201217200856.GA707519@tleilax.poochiereds.net>
 <20201218144418.GA3424@redhat.com>
 <20201218150258.GA866424@tleilax.poochiereds.net>
 <20201218162819.GC3424@redhat.com>
 <20201218165551.GA1178523@tleilax.poochiereds.net>
Message-ID: <87sg82n9p3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Dec 18 2020, Jeffrey Layton wrote:
>
> The patch we're discussing here _does_ add a f_op->syncfs, which is why
> I was suggesting to do it that way.

I haven't thought through the issues to decide what I think of adding a
new op, but I already know what I think of adding ->syncfs.  Don't Do
It.  The name is much too easily confused with ->sync_fs.

If you call it ->sync_fs_return_error() it would be MUCH better.

And having said that, the solution becomes obvious.  Add a new flag,
either as another bit in 'int wait', or as a new bool.
The new flag would be "return_error" - or whatever is appropriate.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJBBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/dECgOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbk3ig/4iZJnVRvb8/0pwu2NgBVBzqiie5K8kJNvUzsU
BBTsOxBahvwn2B3zMsI9IP3q77wAdVF8wbl8HihIjuGuFramVoMmkCH+t1vVHa35
cHuB+xZEOEqGgSVWYC02Ci54z+ZxHi71JlbVfT3n7Zrj1VY+k9q/23ZzRPknQjTr
NU1QA2ya8r1P006F5/hJ/3zLTneuMYJsRWT6AlvYabI+rv12TMcirBBQFhcfb3je
Q+/3RPZW1avW+hlIoACeMA0PRxWASwLH04Wx1zrC85G3OSpC+uBFt254jL/R5EPF
GBiGPmEaEALoJrlnSoJLBWysb50lyTUf94R/Gj2wqYA3fJ51YB1eZqm2yudaUPWY
QfYoaO6KdyjbPOJjXXD2lznIyWKvKFtT1XR/yvuKwuNtnuX2001uhXFLCLGTDFO8
ujbSBJkFlMGGvxfZ2FsqRUBNWgPaKHMUCgIeqiTVmSqPoVeaVn74Ru06ilIVbcTF
1ULHPC7arfCNRTbl7siAaGPSiPGbco4asdgrJzGyFaOJhgmZZ16kC1jFqAwwYMrg
1sfjpjkgyPWjYy+hAbkOMsp3O1s3jvzVc8Qu0YLd0HKEI2zL7b52MzkE2KH4i1WN
hYD5QCUc1G1xzEMPwnMCC7Jdthypgzjg6J9TzbmtOlfWQFORuCOTEeHUzcx6Lsf0
e/2rvw==
=hNhL
-----END PGP SIGNATURE-----
--=-=-=--
