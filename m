Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FB7706CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjHDRK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHDRKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB365254;
        Fri,  4 Aug 2023 10:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 336B6620BD;
        Fri,  4 Aug 2023 17:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC834C433C8;
        Fri,  4 Aug 2023 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691169024;
        bh=LpOa1+W78YUI0pP3gtmRJrUFbY+NCvdbjWtUDqJpXsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odzz0itV4ygxP67SjWWwGwJbZ+soQiIp2Nu9jCWBEfj3D/H4s4Cg42NjQayVI/v/c
         rfl4CMrAL55C4xBuns5HH6CDsDSXjVTmzVGpLcWKAFNdqfZF/+OKsunzRoTDsPEALm
         8zjEvR35b/L0bUGT4PmP21opHbOasTDlAzGoxEVmIZLgks52lxfeHAJ7ifnscRW0f9
         Ep0jlMvgK9OsmEZsX9+EC8AUw9TC16+TinjXMtxRPiZtJ5+y1G5SWMD+tapWERVh5m
         ofBJ+gLeyTi06fNQf2F8DGj1KxkD3yTdRk8Ar/CdNjYmDkxgDMUxWNBfTyXAJd+WUd
         +mrVR0T+A5zYg==
Date:   Fri, 4 Aug 2023 18:10:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <21a7b7ab-acbc-4778-bf2c-f4e7346c3dd9@sirena.org.uk>
References: <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
 <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
 <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
 <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
 <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
 <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
 <7d03be1277a5f4be23df35ca96f4d6cd77735e2b.camel@intel.com>
 <475f31e1-0f6f-44a9-b93a-540c1d43e1bb@sirena.org.uk>
 <9902dd7e-1427-4c7e-b602-c1fbf6512f10@sirena.org.uk>
 <a21ab778704d02b8539e5c459750f8a2f771bede.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pNJflhZYfBsbzGQE"
Content-Disposition: inline
In-Reply-To: <a21ab778704d02b8539e5c459750f8a2f771bede.camel@intel.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--pNJflhZYfBsbzGQE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 04:43:45PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2023-08-04 at 14:38 +0100, Mark Brown wrote:

> > BTW are you planning to repost the series for this release?=A0 We're
> > almost at -rc5 which is pretty late and I didn't see anything yet.=A0

> There were a few patches I posted on top of the last series after your
> comments, but I wasn't planning on reposting the whole thing. Why do
> you ask? Just trying to figure out the best version to base off of?

> > It
> > looks like there's a branch in tip that's getting some updates but
> > it's
> > not getting merged for -next.

> Hmm, not sure why it's not in -next anymore. I'll look into that.
> Thanks for pointing it out.

Mainly it was the inclusion in -next with a view to it getting merged
that prompted me to ask, for the last release cycle had seemed to be
gated on it being posted on the list (which is a standard workflow).

Due to issues in mainline I really need a -rc3, and ideally -rc4, base
but other than occasionally having to pull new bits out of your series
it's not causing me any serious issues and I don't anticipate the arm64
stuff getting in this time round.

--pNJflhZYfBsbzGQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTNMPYACgkQJNaLcl1U
h9Df8wf/TEg2LpbxxUNsAzZ3/r+uWmICEGa9AkGhiRS5KriCkO6ASDIEBMN4m//n
1axQnkGLfUqNjHbkHyhegN5yGxXY7LSsrb6xVyWTRJTQ6zYOlzoDFYmvvhsezc7r
qZrwqduFAB2BNGSDJVO+ni/ceEZ7/bmioIjhTd1anN7C0Ps9JFnZN8AnhW+s/hNd
iceyRHZm/Z9goHQARi1RWwCMum3cOYsJT6YBpTxdVPnIZlb9M3QDLA5IMyVPHZG+
MfibKT1HEeLWqo4w6ZjIluc/yqMrQEBfYq8ghZfa9F1IcB48w+5q6+iPl8LZBmVy
OCOMl1GumMBem4Q8UZ/yo4ImOaRNHw==
=N/z3
-----END PGP SIGNATURE-----

--pNJflhZYfBsbzGQE--
