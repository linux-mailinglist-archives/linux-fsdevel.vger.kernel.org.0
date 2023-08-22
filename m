Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC67848D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjHVRzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHVRzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013891FC8;
        Tue, 22 Aug 2023 10:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879A162094;
        Tue, 22 Aug 2023 17:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02761C433C7;
        Tue, 22 Aug 2023 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726934;
        bh=nRhOqPrA5BuPwRcvI7MlHlUwPN6wyHo9eKiXJKZmvt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myEcl1WQzsR8pyBO5c97oqf72AeVeGXqJVloLwBX8iLiTVv8X7Ia5vxoJdiPn9i+Y
         VjQOYYmvKvjZbfOh6E8xc61ay9ODF00wOGJfXl/c1vGl0Y6OYChvzjcdwufld/IScF
         1UGlm7KFs7gyhSRfsTyEylIum6Z+RkaBDfABGffR9V76JaIS9JY5hMmlmS0q/9LklM
         ePT2X4GvVlJEVV0h+Oer2GtY4Hxhd4pfL+5zEq8l0XyzfybeFF7tgxUXVLmquGqvQ1
         TZIES52DEgXIUwTk2PsKGVvUBdwYPMTgBnyG4aO6gC+pZlhQLIK4t/O11L17SOC7Vu
         mGZAJ84Zodf5Q==
Date:   Tue, 22 Aug 2023 18:55:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 11/37] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Message-ID: <c9d0881d-e26b-4680-8f8e-0d5e1c82655c@sirena.org.uk>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
 <20230822-arm64-gcs-v5-11-9ef181dd6324@kernel.org>
 <8f2cf5af-cad7-a69c-e8ec-39f48deae1cb@redhat.com>
 <54b2c1e5-a99d-42c0-b686-1b5cbb849581@sirena.org.uk>
 <e10e729392c5fa421baf08b4ea7aaac6ffada0f5.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/5Lioh+7qcaKBw4"
Content-Disposition: inline
In-Reply-To: <e10e729392c5fa421baf08b4ea7aaac6ffada0f5.camel@intel.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--M/5Lioh+7qcaKBw4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 04:47:26PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-08-22 at 16:41 +0100, Mark Brown wrote:

> > I can certainly update it to do that, I was just trying to fit in
> > with
> > how the code was written on the basis that there was probably a good
> > reason for it that had been discussed somewhere.=A0 I can send an
> > incremental patch for this on top of the x86 patches assuming they go
> > in
> > during the merge window.

> There was something like that on the x86 series way back, but it was
> dropped[0]. IIRC risc-v was going to try to do something other than
> VM_SHADOW_STACK, so they may conflict some day. But in the meantime,
> adding a CONFIG_HAVE_ARCH_SHADOW_STACK here in the arm series makes
> sense to me.

OK, I'll do that.

--M/5Lioh+7qcaKBw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTk9owACgkQJNaLcl1U
h9BzkQf/R6al2pexuFT7yjh/QmDQ605ZLN9i97Je0LSd5PuT5nU6GF3W5a54fMib
6W/3nsCaMStJXsvd+VW79higHGjkzwpJF2gPeI94UCLBgKYqU8qB4MR/adY9Ff1r
1sA4RWSjuxtC8NBEoIYomxAXMpW05vpD0eruSLYjUnEnTf0NrXtxZmwZQjcVHeeS
f47zzzB9vzZ1wei7YyAcO+oju9JjWVkD2jTdQJjddCKNIuR+qB98g/qO4BvHp86+
OPVeSsY4Ko7Kqh4JKdTddAYte0KvQ0SaRh59Zmo6tcorDOv6yVJOfTOEQ8v2SdFD
daJaRcq070YEVByUMToJ3C0wq/P7+w==
=2kJA
-----END PGP SIGNATURE-----

--M/5Lioh+7qcaKBw4--
