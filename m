Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92676B69A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjHAOCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjHAOCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D9C3;
        Tue,  1 Aug 2023 07:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37363615BF;
        Tue,  1 Aug 2023 14:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64B6C433C7;
        Tue,  1 Aug 2023 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690898528;
        bh=VNvAGs+RJC/wWP8NPciLgTw7gNKF8Q+/ePEXF/moAHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lR/o/rPJ09W+mjAX+ibUzyjhGjZT2i3QTLa7TI+URr1LjPnvTY2iC6GPqYl/n4r/3
         WI/UNzJxW35Q0DDQTuxLw1RSoUoPpdFiCbT65gTE9ERpwX6uJ/Jw1QBGc/dTSkYPJx
         FNA/RjX6qX7wwn/QnanU4oUFJADcz/1x2My8leQsMuZiS57cY8v120f7Yc2vmUiJfX
         vtvf4FafJWxsU0fipTM5jzne4OEw4wkHM0zMUZ0QMFQkRlqHkhB82tojzXjPQ815fU
         iQJjqbsqrrEYQWPmSD+mSbB2ySB0Q0+NzwHtr7edz91j3ub2TQM8/Oy+P0v2YI51MP
         gpWzFmzYQSEUw==
Date:   Tue, 1 Aug 2023 15:01:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
 <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
 <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nwti0jdLm79TUUP+"
Content-Disposition: inline
In-Reply-To: <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
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


--Nwti0jdLm79TUUP+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 11:19:34PM +0000, Edgecombe, Rick P wrote:

> The thing I was trying to get at was, we have this shared syscall that
> means create shadow stack memory and prepopulate it like this flag
> says. On x86 we optionally support SHADOW_STACK_SET_TOKEN which means
> put a token right at the end of size. So maybe arm should have a
> different flag value that includes putting the marker and then the
> token, and x86 could match it someday if we get markers too.

Oh, I see.  My mental model was that this was controlling the whole
thing we put at the top rather than treating the terminator and the cap
separately.

> It could be a different flag, like SHADOW_STACK_SET_TOKEN_MARKER, or it
> could be SHADOW_STACK_SET_MARKER, and callers could pass
> (SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER) to get what you have
> implemented here. What do you think?

For arm64 code this would mean that it would be possible (and fairly
easy) to create stacks which don't have a termination record which would
make life harder for unwinders to rely on.  I don't think this is
insurmountable, creating manually shouldn't be the standard and it'll
already be an issue on x86 anyway.

The other minor issue is that the current arm64 marker is all bits 0
so by itself for arm64 _MARKER would have no perceptible impact, it
would only serve to push the token down a slot in the stack (I'm
guessing that's the intended meaning?).  I'm not sure that's a
particularly big deal though.

--Nwti0jdLm79TUUP+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTJEFYACgkQJNaLcl1U
h9DMNgf+P37hKhxkgQQ2bx5n4uZZFxfRehguU/iRyfY2v786eRp6cHggr3v5zNbn
YpYL5VP9uY+etSRtnZI8rksKaS4bR/OnIchJ1WVCyFEZOV+IiJrKgRpXYTFH4wd6
TJBjdEQtaeU7zIyikLOVb7gstveQddLzsUBDcAOoEwjUnd6alGbDGn262PKDeapK
hu+THENIjRxbrDkn9An5Uuca6c4XeWL/KbLQLP8uGKbz1FiCPUGDAF1i8FkoVxnL
IZW9d2IOzqXh0G/ZXwQhw9+9QNtN7zIDXIs2WS29VU2QoGJAZdNP9rJFhdK4C+/y
ih1/WTOQ+rJxgjVUggW+96FlbhxWZg==
=fLYM
-----END PGP SIGNATURE-----

--Nwti0jdLm79TUUP+--
