Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F9769EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjGaRKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjGaRKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F735278;
        Mon, 31 Jul 2023 10:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFC56124C;
        Mon, 31 Jul 2023 17:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1000CC433C8;
        Mon, 31 Jul 2023 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690823198;
        bh=FRZSQDS+XeV4uVWI+vRMHfLJQSlvsz3j8APAeSBXyRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjm4JuEER9ekFbVY94POgdKp2Wdg7qWVx6hscEfKciMqwhhw59FWXry9S2NvII1Xq
         W3KuimbOcMaS273TtbohajLtObRWhakR+zWHG4dJMdH+TUI359NBI6kFirlh7ptA8m
         xmis3n4ZlpVhtH/ApHSALFTqS1okKA2N6d41f3tKDzE3C9W2NUXGOrcBYsyTmday6X
         DyOom4vW6QZlu3XiBGJaGSb/r4uoRzm3B5gXFrWVM7A3M5ae9K2U5cyWu8R6soUdQS
         Qb226g+YzUYUbWXgF3ofLisOvmT1M2W2T9+GDWHr/KJVwgtnQU+2t53hf4JgrPKBz0
         pMpifqPOlQcIQ==
Date:   Mon, 31 Jul 2023 18:06:28 +0100
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
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qSNeFAfZluwl23Q1"
Content-Disposition: inline
In-Reply-To: <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qSNeFAfZluwl23Q1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 03:56:50PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2023-07-31 at 14:43 +0100, Mark Brown wrote:

> Any thoughts on the questions at the end of this mail?

> https://lore.kernel.org/lkml/7a4c97f68347d4188286c543cdccaa12577cdb9e.camel@intel.com/

Those are:

> Someday when the x86 side is finally upstream I have a manpage for
> map_shadow_stack. Any differences on the arm side would need to be
> documented, but I'm not sure why there should be any differences. Like,
> why not use the same flags? Or have a new flag for token+end marker
> that x86 can use as well?

Ah, it wasn't clear to me that this was a question rather than just
open decisions about the eventual manpage.  Looking again I think what
you're asking about is that I see that at some point in development I
lost the SHADOW_STACK_SET_TOKEN flag which x86 has.  I suspect that was
a rebasing issue as it wasn't a deliberate decision, there's no reason
we couldn't have that.  Other than that and the fact that we add both a
stack swap token and a top of stack marker I'm not aware of any
differences.

--qSNeFAfZluwl23Q1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTH6hMACgkQJNaLcl1U
h9C+/gf/fsd2+OP2IaWypYsnLbn4+Z1/XZAFZ/PaT8xKzJcuY77+Lo6ndMnLLuOt
lJFPNM7SLDezZnZg8F06EmCFpye2/RpYHqaT1bXNOoYwl4yTF/xA5G5etJ/I3h7G
fjaivE8ywdwUVINFANweDX+K+sCPIrepHdmGTdpGhasbLKOUg632qN9NaEKc5anx
xCI48CteSjjSMr4a1Fwk6PavgzpONlo6DkUl0vlHevKJazDzFCApCQvVAITtCVYm
eX0DriUi0Leu4vALeh7sbw/a1P0YkzRNZ16ydPLPmyGlQHgA6wSJ9+Nb5BdPe4xv
5gXikyjfTIEVFjyHFKfoj74bAtq0SA==
=Wdxm
-----END PGP SIGNATURE-----

--qSNeFAfZluwl23Q1--
