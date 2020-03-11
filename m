Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40B7181F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgCKRZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:25:59 -0400
Received: from foss.arm.com ([217.140.110.172]:52444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgCKRZ7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:25:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64C8A1FB;
        Wed, 11 Mar 2020 10:25:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB7193F6CF;
        Wed, 11 Mar 2020 10:25:57 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:25:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Message-ID: <20200311172556.GJ5411@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
 <20200309210505.GM4101@sirena.org.uk>
 <20200310124226.GC4106@sirena.org.uk>
 <20200311162858.GK3216816@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline
In-Reply-To: <20200311162858.GK3216816@arrakis.emea.arm.com>
X-Cookie: I'm a Lisp variable -- bind me!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2020 at 04:28:58PM +0000, Catalin Marinas wrote:
> On Tue, Mar 10, 2020 at 12:42:26PM +0000, Mark Brown wrote:

> > Sorry, I realized thanks to Amit's off-list prompting that I was testing
> > that I was verifying with the wrong kernel binary here (user error since
> > it took me a while to sort out uprobes) so this isn't quite right - you
> > can probe the landing pads with or without this series.

> Can we not change aarch64_insn_is_nop() to actually return true only for
> NOP and ignore everything else in the hint space? We tend to re-use the
> hint instructions for new things in the architecture, so I'd rather
> white-list what we know we can safely probe than black-listing only some
> of the hint instructions.

That's literally the patch I am sitting on which made the difference
with the testing on the wrong binary.

> I haven't assessed the effort of doing the above (probably not a lot)
> but as a short-term workaround we could add the BTI and PAC hint
> instructions to the aarch64_insn_is_nop() (though my preferred option is
> the white-list one).

The only thing I've seen in testing with just NOPs whitelisted is an
inability to probe the PAC instructions which isn't the best user
experience, especially since the effect is that the probes get silently
ignored.  This isn't extensive userspace testing though.  Adding
whitelisting of the BTI and PAC hints would definitely be a safer as a
first step though.  I can post either version?

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5pHyMACgkQJNaLcl1U
h9DzqAf+N5eQpuCTzUhAIY7PldVhZpWztsdMphseLhvdpMuxuYytqZg+qcir93sK
xhkpSByIe6/jwCgyGKMTcBSb4B3d0P+0Ag1Xt0MHNvMNmGYqgHbsdAlVcQVY/Aog
cDRqEVNOu1JUpxOJzB7fU8alfxrcw1lv30oJ/35I0tb6KYPOYm5ZjiLy9BA8bfhA
gaCPy6o6J2jAa7Ps0RGWz5hHAWcs66gVPb83kcKf233tIFuUdC3QQm249riue23f
mQnmjz5T7fu8WKI4vC9YwX91jUtHvOr/cJrw3B6UMJlCCzQS+Kl4OtwNm+gK6v55
Q0temUNAKiyce6V2f8Akx5iUtQ3hjQ==
=WXTz
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
