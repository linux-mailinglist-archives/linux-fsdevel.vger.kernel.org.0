Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACA7701F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjHDNir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjHDNin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96049F0;
        Fri,  4 Aug 2023 06:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D6C962023;
        Fri,  4 Aug 2023 13:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D02C433C7;
        Fri,  4 Aug 2023 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691156299;
        bh=wz8HX6muu9LEz/2ek8kzkra/H24iTN93xTauZhv3QGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKWFc+S5JQzJIvia/Cee11Wc7lC17Yfs17ShI7jFKpqMYVJ6USFNAEIyrZROgkamJ
         9eDQFB0x2XjaK/28bV2LKBLOuQ6vuy7TbjLAZtQCwqw4iCfihs9wTmszLFoO9oRbnr
         JJmj8c3cIfcozr6pDH2j5JPmEh0V8jJXlPF9UmlVO3nrB+QoiVGpF1TO/hnkJDzpwq
         QibstZcUH8jSdOliLu6T2qRWJjx6M450vEyW8nWXsWYJ+a/XKVP1CPX/ytlFMIvE0x
         Zp4Xa0yF3k1t51L4SPW6Xv0UIn1kEs5u6H0y43HR4NK7dDMCNb+qVj6fL3E6RMthax
         XYN/sfX3+6sCg==
Date:   Fri, 4 Aug 2023 14:38:10 +0100
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
Message-ID: <9902dd7e-1427-4c7e-b602-c1fbf6512f10@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
 <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
 <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
 <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
 <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
 <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
 <7d03be1277a5f4be23df35ca96f4d6cd77735e2b.camel@intel.com>
 <475f31e1-0f6f-44a9-b93a-540c1d43e1bb@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EaObfDz4CndjI5sX"
Content-Disposition: inline
In-Reply-To: <475f31e1-0f6f-44a9-b93a-540c1d43e1bb@sirena.org.uk>
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


--EaObfDz4CndjI5sX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 05:27:54PM +0100, Mark Brown wrote:
> On Tue, Aug 01, 2023 at 08:57:59PM +0000, Edgecombe, Rick P wrote:

> > To make sure we are on the same page: What I'm saying is say we do
> > something like add another flag SHADOW_STACK_SET_MARKER that means add
> > a marker at the end (making the token off by one frame). Then you can
> > just reject any flags !=3D (SHADOW_STACK_SET_MARKER |
> > SHADOW_STACK_SET_TOKEN) value, and leave the rest of the code as is. So
> > not really implementing anything new.=A0

> > Then x86 could use the same flag meanings if/when it implements end
> > markers. If it doesn't seem worth it, it's not a big deal on my end.
> > Just seemed that they were needlessly diverging.

> Yes, my understanding of the flags is the same.  I'll definitely
> implement omitting the cap since there's an actual use case for that
> (extending an existing stack, it's marginally safer to not have any
> opportunity to pivot into the newly allocated region).

BTW are you planning to repost the series for this release?  We're
almost at -rc5 which is pretty late and I didn't see anything yet.  It
looks like there's a branch in tip that's getting some updates but it's
not getting merged for -next.

--EaObfDz4CndjI5sX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM/0EACgkQJNaLcl1U
h9Dhngf9HaBpp4WdjxabvyUIkHFeitGGLlR98c80xyh19bY1UWx4BOojqe0fcQqc
K1kS+mCmTH9c1RZEdUe+O5upQl099AzBqsJUu8aXBh/Pf6wDXwxinNVPL/WSO00B
9jlg3iozKyd5PQJjJIbbJwHoCTkHLe+Wun/qG9P75FL4w+7REzD+pOpSZBwoPqYR
2h00HfuO1pAX54ubVTARphHAZEIBJHYusx2fJQ8pP4JjLdYU7ot48CfVZa35VPuM
JJFU92h6YEdnqQPfc79hwp/UqvGWAowJ5QMM/3E8s6CDE7n4dTP8wXihArd0rlrk
OzsV73Hx8i3GvjV1DR1vc4vAC7DxRA==
=G9bO
-----END PGP SIGNATURE-----

--EaObfDz4CndjI5sX--
