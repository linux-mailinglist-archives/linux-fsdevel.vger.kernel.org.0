Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEC7741A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjHHRZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHHRZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0038F20278;
        Tue,  8 Aug 2023 09:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38CA5624EE;
        Tue,  8 Aug 2023 13:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716DC433C8;
        Tue,  8 Aug 2023 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691501946;
        bh=RnXjxseYsnFe6Wnck1M4XbqKJfcYUVsYZpbGiHCNKCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOsRv8DPnz3szlVVqAIekC0oAa1YWjq756EOBKQHNrWkdjOHTpZrdXFvoiy0dPstL
         zHVpr1V7MDywHBGGU4vstj24/ddQ2YUijhLOHhv21OptJRcyHiqH4PCaeITgRuOsQP
         xhcNw4WURUix63jdw9L0KUAaoaYuVRg6y2L3/+0DCRQV91VgQjhNmhSn7gmTUld4CN
         PukbIQT3kIDYfuJo8nq7Ezq5aseMpKv9N4/sMDanxbzcf38L9HyofcxB5+sD0FXxB4
         LdhMsPJhZIcf39N6w/S5fgwPEA8bYg9AZCO455XBxu4iag2rRXSA1EHP7TfDTdQEgX
         lr0A4nNsxMLIQ==
Date:   Tue, 8 Aug 2023 14:38:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/36] arm64/gcs: Provide support for GCS in userspace
Message-ID: <20230808133857.GC2369@willie-the-truck>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230801141319.GC26253@willie-the-truck>
 <09b7a94d-cc88-4372-85de-52db26bc2daf@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b7a94d-cc88-4372-85de-52db26bc2daf@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 04:09:58PM +0100, Mark Brown wrote:
> On Tue, Aug 01, 2023 at 03:13:20PM +0100, Will Deacon wrote:
> > On Mon, Jul 31, 2023 at 02:43:09PM +0100, Mark Brown wrote:
> 
> > > The arm64 Guarded Control Stack (GCS) feature provides support for
> > > hardware protected stacks of return addresses, intended to provide
> > > hardening against return oriented programming (ROP) attacks and to make
> > > it easier to gather call stacks for applications such as profiling.
> 
> > Why is this better than Clang's software shadow stack implementation? It
> > would be nice to see some justification behind adding all this, rather
> > than it being an architectural tick-box exercise.
> 
> Mainly that it's hardware enforced (as the quoted paragraph says).  This
> makes it harder to attack, and hopefully it's also a bit faster (how
> measurable that might be will be an open question, but even NOPs in
> function entry/exit tend to get noticed).

I dunno, "hardware enforced" can also mean worse security nowadays ;)

But seriously, I think the question is more about what this brings us
*on top of* SCS, since for the forseeable future folks that care about
this stuff (like Android) will be using SCS. GCS on its own doesn't make
sense to me, given the recompilation effort to remove SCS and the lack
of hardware, so then you have to look at what it brings in addition to
GCS and balance that against the performance cost.

Given that, is anybody planning to ship a distribution with this enabled?
If not, why are we bothering? If so, how much of that distribution has
been brought up and how does the "dynamic linker or other startup code"
decide what to do?

After the mess we had with BTI and mprotect(), I'm hesitant to merge
features like this without knowing that the ABI can stand real code.

Will
