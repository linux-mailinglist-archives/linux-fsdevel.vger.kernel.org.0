Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC27585A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGRTh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRThZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D895A198D;
        Tue, 18 Jul 2023 12:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73F2060B59;
        Tue, 18 Jul 2023 19:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F4AC433C7;
        Tue, 18 Jul 2023 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709043;
        bh=ZxtPv1D0nptmBko9s7OKhZDvD31woHBZFfU7oYY10b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMLY8kCEqG0wMS07BdWto8m0clJr2/78xvRh1w9dZf9yG8l29QftXXKHFF55EFsz3
         rMx0ONDAp3wXEMIlVWX54Q8iMQycKnWpkwPHNUgvAd6rMgpv3P0Yoj8MIFKE/aOJ6F
         LRmzXHn9sUf5TWmvjnegDi3yttbTb0Zz6AagJoP4t5CylB1YdgUOjZPrtgkqdRnacp
         g4lHW0S/qAk6zPJYXKsgsuJglyVgIy3O5bIBW60emia1334fKYVwDNILv497vXIGse
         MTMybqf0Swz27NUZmnrkgdv5Kv9IGHQvU3SGj3GplW2cBlx4sxBs/AzGXS1s65Y7jR
         vKNy338gfsWYg==
Date:   Tue, 18 Jul 2023 20:37:14 +0100
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
Subject: Re: [PATCH 21/35] arm64/gcs: Implement shadow stack prctl() interface
Message-ID: <22a53782-7c8b-409e-92b5-ce89e2a86e2d@sirena.org.uk>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
 <20230716-arm64-gcs-v1-21-bf567f93bba6@kernel.org>
 <2e1c24e343fb920e1f8616e083bba625717c384d.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+LcC9ieUsmFeoYzA"
Content-Disposition: inline
In-Reply-To: <2e1c24e343fb920e1f8616e083bba625717c384d.camel@intel.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--+LcC9ieUsmFeoYzA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 05:51:54PM +0000, Edgecombe, Rick P wrote:
> On Sun, 2023-07-16 at 22:51 +0100, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
cs =3D alloc_gcs(task->thread.gcspr_el0, size,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00, 0);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
f (!gcs)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;

> > +=A0=A0=A0=A0=A0=A0=A0task->thread.gcs_el0_mode =3D arg;
> > +=A0=A0=A0=A0=A0=A0=A0if (task =3D=3D current)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gcs_set_el0_mode(task);
> > +

> Ah! So does this task =3D=3D current part mean this can be called from
> another task via ptrace?

Ugh, right.  So I had been worried about preemption rather than invoking
prctl() via ptrace, though since ptrace can change the syscall invoked
by a task it could cause prctl() to be invoked that way (but that should
look like being run in the target process).

I'm not aware of an interface specifically intended to remotely invoke
prctls via ptrace but that doesn't mean there isn't one that I didn't
find yet.  I can't remember why I'm aware of the task !=3D current case as
a concern which is worrying me.

> If so, then is the alloc_gcs() part on the wrong mm?

Yes, it will be.  I'll add a check in there to reject attempts to enable
GCS when task !=3D current.

--+LcC9ieUsmFeoYzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS26eoACgkQJNaLcl1U
h9CYygf+IDDkv7ACSKD5nM6hnqcKIlhFl4zq3viBlcIX0vXYzPVupOCAbCarTXX9
8ONJZvPpTQjznNjMcmvWut8WU+hWOW/UvsbtftxjLJRyoioHPqwZHy7KVVYYWUwv
FIGO+d+5I7UpABBVNJsdHFSGthvOxBPGzFMNqyi/0wO8rtRAlfdg+cmMkGgpxoel
HEC4D5W7U+X5BEs1wnPKZZuvTvt5hbqeLbY4VSyKqfqjryTxnqebHLo5RzW3PKdH
ZDcn47+rFqdw4kMF7gsLWp++R3fZXCO5PRO6B+Ok6A12Hh3ICV+MbVPdeDrzhfiw
s1AEnkG+S/KEme6d6O1scSv5RQymhg==
=hLC+
-----END PGP SIGNATURE-----

--+LcC9ieUsmFeoYzA--
