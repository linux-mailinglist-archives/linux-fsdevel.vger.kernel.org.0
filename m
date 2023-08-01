Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A376BB37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjHAR3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjHAR3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70CE0;
        Tue,  1 Aug 2023 10:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5F66164C;
        Tue,  1 Aug 2023 17:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24956C433C8;
        Tue,  1 Aug 2023 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690910944;
        bh=ZsqAQZoA0AwoghZtsiou8KjavxZCx4Uc9yT9Cen9PwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2/wNB2JDb34xXNtBAjWvhO/GaBvzGr/zJJtBjZuERqzx5hCgYqVR2Z+yMEi1nB1g
         LB0Yo3/DClX0+w88XYSsol0eaOaXOk1/B5cZ1YEJEPd1m/pD4h07rixux7YzOnGQfn
         73lzCbJsnMCFwfmL8CoCvaegc6szz51GwgMxu1wRjLDWAyBJkdQYbjYlQRUX/3IA9X
         fbdCmHDjJqIWvELjOL85wJ3Z1UgOHv2a0U/U66LVBpppf9WoEry95VllY3hGwZDVyM
         RFQCf2Nsp2layhGAkoAPp2zUoFiP/K4PCZefA0ZwfrOBsL0g1dIAaZskC1zvxq7AnR
         DqO70EKfKhTiQ==
Date:   Tue, 1 Aug 2023 20:28:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
Message-ID: <20230801172814.GD2607694@kernel.org>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
 <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
 <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
 <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
 <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:07:00PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-08-01 at 15:01 +0100, Mark Brown wrote:
> > On Mon, Jul 31, 2023 at 11:19:34PM +0000, Edgecombe, Rick P wrote:
> > 
> > > The thing I was trying to get at was, we have this shared syscall
> > > that
> > > means create shadow stack memory and prepopulate it like this flag
> > > says. On x86 we optionally support SHADOW_STACK_SET_TOKEN which
> > > means
> > > put a token right at the end of size. So maybe arm should have a
> > > different flag value that includes putting the marker and then the
> > > token, and x86 could match it someday if we get markers too.
> > 
> > Oh, I see.  My mental model was that this was controlling the whole
> > thing we put at the top rather than treating the terminator and the
> > cap
> > separately.
> > 
> > > It could be a different flag, like SHADOW_STACK_SET_TOKEN_MARKER,
> > > or it
> > > could be SHADOW_STACK_SET_MARKER, and callers could pass
> > > (SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER) to get what you
> > > have
> > > implemented here. What do you think?
> > 
> > For arm64 code this would mean that it would be possible (and fairly
> > easy) to create stacks which don't have a termination record which
> > would
> > make life harder for unwinders to rely on.  I don't think this is
> > insurmountable, creating manually shouldn't be the standard and it'll
> > already be an issue on x86 anyway.
> 
> If you are going to support optionally writing to shadow stacks (which
> x86 needed for CRIU, and also seems like a nice thing for several other
> reasons), you are already at that point. Can't you also do a bunch of
> gcspopm's to the top of the GCS stack, and have no marker to hit before
> the end of the stack? (maybe not in GCS, I don't know...)
> 
> > 
> > The other minor issue is that the current arm64 marker is all bits 0
> > so by itself for arm64 _MARKER would have no perceptible impact, it
> > would only serve to push the token down a slot in the stack (I'm
> > guessing that's the intended meaning?).
> 
> Pushing the token down a frame is what flags==0 does in this patch,
> right?
> 
> You don't have to support all the flags actually, you could just
> support the one mode you already have and reject all other
> combinations... Then it matches between arch's, and you still have the
> guaranteed-ish end marker.
> 
> So the question is not what mode should arm support, but should we have
> the flags match between x86 and ARM?

What if the flag will be called, say, SHADOW_STACK_DEFAULT_INIT?
Then each arch can push whatever it likes to and from the userspace
perspective the shadow stack will have some basic init state, no matter
what architecture it is.
 
> >   I'm not sure that's a
> > particularly big deal though.
> 
> Yea, it's not a big problem either way.

-- 
Sincerely yours,
Mike.
