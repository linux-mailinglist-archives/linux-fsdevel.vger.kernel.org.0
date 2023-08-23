Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C5785889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjHWNL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjHWNL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5474BCEA;
        Wed, 23 Aug 2023 06:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BED644E4;
        Wed, 23 Aug 2023 13:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DAAC433C7;
        Wed, 23 Aug 2023 13:11:10 +0000 (UTC)
Date:   Wed, 23 Aug 2023 14:11:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <ZOYFazB1gYjzDRdA@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOXa98SqwYPwxzNP@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:09:59AM +0100, Szabolcs Nagy wrote:
> The 08/22/2023 18:53, Mark Brown wrote:
> > On Tue, Aug 22, 2023 at 05:49:51PM +0100, Catalin Marinas wrote:
> > > It would be good if someone provided a summary of the x86 decision (I'll
> > > get to those thread but most likely in September). I think we concluded
> > > that we can't deploy GCS entirely transparently, so we need a libc
> > > change (apart from the ELF annotations). Since libc is opting in to GCS,
> > 
> > Right, we need changes for setjmp()/longjmp() for example.
> > 
> > > we could also update the pthread_create() etc. to allocate the shadow
> > > together with the standard stack.
> > > 
> > > Anyway, that's my preference but maybe there were good reasons not to do
> > > this.
> > 
> > Yeah, it'd be good to understand.  I've been through quite a lot of old
> > versions of the x86 series (I've not found them all, there's 30 versions
> > or something of the old series plus the current one is on v9) and the
> > code always appears to have been this way with changelogs that explain
> > the what but not the why.  For example roughly the current behaviour was
> > already in place in v10 of the original series:
> > 
> >    https://lore.kernel.org/lkml/20200429220732.31602-26-yu-cheng.yu@intel.com/
> 
> well the original shstk patches predate clone3 so no surprise there.
> e.g. v6 is from 2018 and clone3 is 2019 linux 5.3
> https://lore.kernel.org/lkml/20181119214809.6086-1-yu-cheng.yu@intel.com/

Good point, I had not realised that.

> > I do worry about the story for users calling the underlying clone3() API
> > (or legacy clone() for that matter) directly, and we would also need to
> > handle the initial GCS enable via prctl() - that's not insurmountable,
> > we could add a size argument there that only gets interpreted during the
> > initial enable for example.
> 
> musl and bionic currently use plain clone for threads.
> 
> and there is user code doing raw clone threads (such threads are
> technically not allowed to call into libc) it's not immediately
> clear to me if having gcs in those threads is better or worse.
> 
> glibc can use clone3 args for gcs, i'd expect the unmap to be more
> annoying than the allocation, but possible (it is certainly more
> work than leaving everything to the kernel).

Unmapping is indeed more complex but I guess something similar needs to
happen for the thread stack to be reclaimed.

The thing I dislike about the kernel automatically mapping it is the
arbitrary fraction of RLIMIT_STACK size. glibc may use RLIMIT_STACK as a
hint for the thread stack size but is this the case for other libraries?
Some quick search (which I may have misinterpreted) shows that musl uses
128KB, bionic 1MB. So at this point the shadow stack size has no
relevance for the actual thread stack.

An alternative would be for the clone3() to provide an address _hint_
and size for GCS and it would still be the kernel doing the mmap (and
munmap on clearing). But at least the user has some control over the
placement of the GCS and its size (and maybe providing the address has
MAP_FIXED semantics).

> > My sense is that they deployment story is going to be smoother with
> > defaults being provided since it avoids dealing with the issue of what
> > to do if userspace creates a thread without a GCS in a GCS enabled
> > process but like I say I'd be totally happy to extend clone3().  I will
> > put some patches together for that (probably once the x86 stuff lands).
> > Given the size of this series it might be better split out for
> > manageability if nothing else.
> 
> i would make thread without gcs to implicitly disable gcs, since
> that's what's bw compat with clones outside of libc (the libc can
> guarantee gcs allocation when gcs is enabled).

Yes, this should work. Any invocation of clone() or clone3() without a
shadow stack would disable GCS. What about the reverse, should GCS be
enabled for a thread even if the clone3() caller has GCS disabled? I
guess we shouldn't since GCS enabling depends on the prctl() state set
previously.

-- 
Catalin
