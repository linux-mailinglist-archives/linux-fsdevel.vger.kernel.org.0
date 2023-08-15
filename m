Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63F77D4BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbjHOVCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbjHOVCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98B0F2;
        Tue, 15 Aug 2023 14:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E96A656EB;
        Tue, 15 Aug 2023 21:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC6C433C9;
        Tue, 15 Aug 2023 21:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692133326;
        bh=cyy9dMmZpCKf0kwV7gSnc6iwwZGFtG1+94Uv3PmsMU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqt6Z6qZREPwPFwBqdMZB2kGJkkZypRmE9bwxc/FX8l6pnZwrXqDF3bNuPrbnNof+
         Zbk1pTJchswaB67AS8Nj1Fds9Y0G2RQA9I45EqR3l7nWywG7yppNaZroed7qaeEEAZ
         33mA8BkQ+gc93Br35uBf/91KWeipdjt2HZOsVUK2Ux2Vxd9ZCygGsOHP3hrhNO5jUy
         2VYsEWdiWM2RoeaISTVoMt6DhY/pcivI+RFTbrq8SXdIqqMaMX6HRMevIxKwi4XifW
         48vwEdEv9oFNrQbuyJP6Pq9qrvMreh/m17TY8MRUHS9jLxuBTcpwnJXfg4G673G6/2
         25g2vLFO2qOfA==
Date:   Tue, 15 Aug 2023 22:01:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <496b9d81-c4c8-471d-9be0-3a0c8fbab436@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-21-68cfa37f9069@kernel.org>
 <8a7bb14f808ab9da413c11f281041375d9a54b01.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dU1pnpOPTrUAVGE+"
Content-Disposition: inline
In-Reply-To: <8a7bb14f808ab9da413c11f281041375d9a54b01.camel@intel.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--dU1pnpOPTrUAVGE+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 08:42:52PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2023-08-07 at 23:00 +0100, Mark Brown wrote:
> > +=A0=A0=A0=A0=A0=A0=A0if (flags & ~(SHADOW_STACK_SET_TOKEN |
> > SHADOW_STACK_SET_MARKER))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;

> Thanks for adding SHADOW_STACK_SET_MARKER. I don't see where it is
> defined in these patches though. Might have been left out on accident?

I added it to the dependency patches I've got which pull bits out of the
x86 series prior to you having rebased it, the ABI bits are mixed in
with the x86 architecture changes which I didn't feel like dealing with
the rebasing for so I pulled out the ABI portions.  I'll resolve this
properly when I rebase back onto the x86 series (ideally after the next
merge window it'll be in mainline!).  For these that'll probably boil
down to adding defines to prctl.h for the generic prctl API.

--dU1pnpOPTrUAVGE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTb58UACgkQJNaLcl1U
h9Bc4Af/Xi/XuQ8BuGwUsA64+0G15WTAgvnaEr6smr1t4oyMFuQMUHjd7iBjOThm
PV/FOTfozLwcOPBbBklofnYUDiI04WMQKwGbdr7Zi1+GFR6+EN7hirIWkuuvQlL5
NKBQjm5eyQL/yYYt4BJ6hRDbRNoCsRtT6zZHwZJpMXiv+nVQBOZlasA6cZ0TgBO3
HkA5PardmuhDrB+yavSIm9rV91v8lOpnDP5q3yF8ShV6Il1n6n8cY4FsnTaXQfpk
dYkB1QCKNAiqGdIWRgeV11iWfrslrXztH2Z94tOjqgbLti1lmf9XEIoX4Wk9Juu8
JF1NdrdhL8X0X+5VS1Mt4bHie2rizQ==
=r3Gb
-----END PGP SIGNATURE-----

--dU1pnpOPTrUAVGE+--
