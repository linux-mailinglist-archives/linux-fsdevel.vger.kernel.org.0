Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D076BBC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjHAR5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHAR5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D11FCB;
        Tue,  1 Aug 2023 10:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD526165F;
        Tue,  1 Aug 2023 17:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A047AC433C8;
        Tue,  1 Aug 2023 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912639;
        bh=F8CAARuNUeaGEa3yA1waQoVFs2zc6rvh3zubyIWd+RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZJMaAT42SQFAM85RnUbpnm4my8uLLOgrzrpv9ey5F7iOsTiCZBEwwsQMLRUS80/H
         gICFBbZERF2JfuNbCyCasY1N2jUMSPr8iIihwDf950iYsquKfhXkKiL5b+msCXfHuc
         B0hu58CMAQA41AZ35HEN4GzCtnJS9SRnAzeUVfmqmxuG8PriXB+8iNnYQ9IBFlhh0g
         5LHahWPZHyPVmmgOLHdeR6Ip9wxGlCVC4KZ6u6/MqfCxXMrpYZItw3hBiaTqg1xfTN
         tUOKRiTjydZGF6wuuwu94EdSvPU1tYZYsAoggPLjahr6Dr1QtlFVqW2D4lr8QT0Spn
         skZg6nLYjJM5w==
Date:   Tue, 1 Aug 2023 18:57:08 +0100
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
 <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
 <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
 <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
 <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYhsHyqynSPadbUB"
Content-Disposition: inline
In-Reply-To: <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
X-Cookie: I thought YOU silenced the guard!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--WYhsHyqynSPadbUB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 05:07:00PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-08-01 at 15:01 +0100, Mark Brown wrote:

> > > It could be a different flag, like SHADOW_STACK_SET_TOKEN_MARKER,
> > > or it
> > > could be SHADOW_STACK_SET_MARKER, and callers could pass
> > > (SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER) to get what you
> > > have
> > > implemented here. What do you think?

> > For arm64 code this would mean that it would be possible (and fairly
> > easy) to create stacks which don't have a termination record which
> > would
> > make life harder for unwinders to rely on.=A0 I don't think this is
> > insurmountable, creating manually shouldn't be the standard and it'll
> > already be an issue on x86 anyway.

> If you are going to support optionally writing to shadow stacks (which
> x86 needed for CRIU, and also seems like a nice thing for several other
> reasons), you are already at that point. Can't you also do a bunch of
> gcspopm's to the top of the GCS stack, and have no marker to hit before
> the end of the stack? (maybe not in GCS, I don't know...)

It's definitely possible to use writes or pops to achive the same
effect, it's just that it's less likely to be something that happens
through simple oversight than missing a flag off the initial map call
would be.

> > The other minor issue is that the current arm64 marker is all bits 0
> > so by itself for arm64 _MARKER would have no perceptible impact, it
> > would only serve to push the token down a slot in the stack (I'm
> > guessing that's the intended meaning?).

> Pushing the token down a frame is what flags=3D=3D0 does in this patch,
> right?

Yes, exactly - if we make the top of stack record optional then if that
flag is omitted we'd not do that.

> You don't have to support all the flags actually, you could just
> support the one mode you already have and reject all other
> combinations... Then it matches between arch's, and you still have the
> guaranteed-ish end marker.

Sure, though if we're going to the trouble of checking for the flag we
probably may as well implement it.  I guess x86 is locked in at this
point by existing userspace.  I guess I'll implement it assuming nobody
=66rom userspace complains, it's trivial for a kernel.

> So the question is not what mode should arm support, but should we have
> the flags match between x86 and ARM?

The flags should definitely match, no disagreement there.

--WYhsHyqynSPadbUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTJR3QACgkQJNaLcl1U
h9D+HQf/dMO4oPMfSYgpJfSkqjyeMhvngNszJ/vg3XKaq4EJAEMgOh+p9YWNYPyv
uBQnGou+Mr2N+ymg2pLC4+WNybCoXsyaVeF/84elK+awSuCxD9GhjtrjqnteBAWg
Cjy3FqvlmXwV2AHcXeYANCjGN6BJhmbUKcJp+jwyEU+PNxMrGY4Fyos1o7DlgcDo
udN5QQnR8fZ4Xjyv5ZcHWeUX0e5TsB+1e9MK8AOIRkpI52cfHU8u/HSNfOHs5an7
Ugb2wl/4tUWdslzaD4LLg+znjSCYjZ2c0uuIuigxAeFfSDhsFG9C2CiIEaa13iCj
rrMq656MkRtw4gwfJ7HGsycFpraatg==
=HHRV
-----END PGP SIGNATURE-----

--WYhsHyqynSPadbUB--
