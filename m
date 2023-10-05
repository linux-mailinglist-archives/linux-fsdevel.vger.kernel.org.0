Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773187BA7F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJER1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjJER1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:27:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C354359D;
        Thu,  5 Oct 2023 10:23:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E350DC433C8;
        Thu,  5 Oct 2023 17:23:12 +0000 (UTC)
Date:   Thu, 5 Oct 2023 18:23:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <ZR7w/mr0xZbpIPc5@arm.com>
References: <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
 <ZRWw7aa3C0LlMPTH@arm.com>
 <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
 <ZRvUxLgMse8QYlGS@arm.com>
 <a7d2fd66-c06b-4033-bca2-4b14afc4904f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d2fd66-c06b-4033-bca2-4b14afc4904f@sirena.org.uk>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:26:51PM +0100, Mark Brown wrote:
> On Tue, Oct 03, 2023 at 09:45:56AM +0100, Szabolcs Nagy wrote:
> > clone3 seems to have features that are only available in clone3 and
> > not exposed (reasonably) in libc apis so ppl will use clone3 directly
> > and those will be hard to fix for gcs (you have to convince upstream
> > to add future arm64 arch specific changes that they cannot test).
> 
> Ah, I hadn't realised that there were things that weren't available via
> libc - that does change the calculation a bit here.  I would hope that
> anything we do for clone3() would work just as well for x86 so the test
> side should be a bit easier there than if it were a future arm64 thing,
> though obviously it wouldn't be mandatory on x86 in the way that Catalin
> wanted it for arm64.

I haven't checked how many clone() or clone3() uses outside the libc are
(I tried some quick search in Debian but did not dig into the specifics
to see how generic that code is). I agree that having to change valid
cases outside of libc is not ideal. Even if we have the same clone3()
interface for x86 and arm64, we'd have other architectures that need
#ifdef'ing.

So I'm slightly warming up to the idea of having a default shadow stack
size (either RLIMIT_STACK or the clone3() stack size, following x86). A
clone3() extension can be added on top, though I wonder whether anyone
will use it if the kernel allocates a shadow stack by default.

It's not just the default size that I dislike (I think the x86
RLIMIT_STACK or clone3() stack_size is probably good enough) but the
kernel allocating the shadow stack and inserting it into the user
address space. The actual thread stack is managed by the user but the
shadow stack is not (and we don't do this very often). Anyway, I don't
have a better solution for direct uses of clone() or clone3(), other
than running those threads with the shadow stack disabled. Not sure
that's desirable.

-- 
Catalin
