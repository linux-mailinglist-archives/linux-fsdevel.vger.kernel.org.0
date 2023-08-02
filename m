Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F676D3A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjHBQ2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHBQ17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E79210D;
        Wed,  2 Aug 2023 09:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A52361A3E;
        Wed,  2 Aug 2023 16:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6D2C433C8;
        Wed,  2 Aug 2023 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690993674;
        bh=IypduYRdhJJTtTi/vdjRUEIIDyW7f/veSqGdfghGaM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOEm7306/htJKG4CId0R41FGls9huoRDB8SC5RAspSExEJWc+HyVpGhFGv4Wg+PCF
         DNKER8c6sgtmUjA+ZIyHRtYIYq7s1L8BFIQctpG47gXwN8Vk7wWF9EhSMrNWfwBrKa
         xvHTe4Pf4ZHfn6zJaolp23r8l3t+iwOVtR8qQQwVdEQ3yiLL1IIdDsYkwudrO92YiE
         FYGqNhGsI2AB015N0akL8QNC7MUhH864UCZeGRUpoIjIcQa5QkuuS1mcndY8IYStIr
         JLUyc346bw68jZ6ki7rhKVwxWbLrfo45Bl68nj4Ylkf3MXxPTk91QSuMRGtzpudBB6
         QKxmNsVU4IKRg==
Date:   Wed, 2 Aug 2023 17:27:44 +0100
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
Message-ID: <475f31e1-0f6f-44a9-b93a-540c1d43e1bb@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
 <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
 <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
 <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
 <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
 <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
 <7d03be1277a5f4be23df35ca96f4d6cd77735e2b.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QS3kL7vV2OH5bUkc"
Content-Disposition: inline
In-Reply-To: <7d03be1277a5f4be23df35ca96f4d6cd77735e2b.camel@intel.com>
X-Cookie: Humpty Dumpty was pushed.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--QS3kL7vV2OH5bUkc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 08:57:59PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-08-01 at 18:57 +0100, Mark Brown wrote:

> > Sure, though if we're going to the trouble of checking for the flag
> > we
> > probably may as well implement it.=A0 I guess x86 is locked in at this
> > point by existing userspace.=A0 I guess I'll implement it assuming
> > nobody
> > from userspace complains, it's trivial for a kernel.

> To make sure we are on the same page: What I'm saying is say we do
> something like add another flag SHADOW_STACK_SET_MARKER that means add
> a marker at the end (making the token off by one frame). Then you can
> just reject any flags !=3D (SHADOW_STACK_SET_MARKER |
> SHADOW_STACK_SET_TOKEN) value, and leave the rest of the code as is. So
> not really implementing anything new.=A0

> Then x86 could use the same flag meanings if/when it implements end
> markers. If it doesn't seem worth it, it's not a big deal on my end.
> Just seemed that they were needlessly diverging.

Yes, my understanding of the flags is the same.  I'll definitely
implement omitting the cap since there's an actual use case for that
(extending an existing stack, it's marginally safer to not have any
opportunity to pivot into the newly allocated region).

--QS3kL7vV2OH5bUkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKhAAACgkQJNaLcl1U
h9AuNwf/eOsxbj3CCh77urZ2bbcgtkDnG2gOY0uK7lM+wipr3GCiDM6ySyjpMrSm
8tfpAV/QhsCNxV2mHJIbUdNW1v+94GUDf7fzu9+pHKrjZpAfWfo6X7KOPFiJaGgB
hHeQd7CNvTJNIwSPjgjHEvjsnp39rstVvNFaonSi/9GXlnt3HSqXPr/awnfCoArZ
eC+NqtyAQ3x/cc8oW9e5cvylNTjXAWg+2QNNXnVVsX6KQkbPXMI6VnQocQBHNCRo
V25MLEEvRVtpXVUihvLkRuA5ILxM/k6sDHhRjaqgIHDyDIAKplJXwIjSLoMEroq3
gZY23CL6NCYvjjFyc6XZbpALl9hrUg==
=/CYh
-----END PGP SIGNATURE-----

--QS3kL7vV2OH5bUkc--
