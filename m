Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639774EF55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGKMuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE098;
        Tue, 11 Jul 2023 05:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8FC614C8;
        Tue, 11 Jul 2023 12:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E0C433C8;
        Tue, 11 Jul 2023 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689079809;
        bh=dNf0h22e3NNw5WnIyQMA79RXwcCjXd4yUaNvlYSmEks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNjPPHJCjkBuTo31uxO23EaD7iBmnxEZwpJnZPbX4Xt0szcj8ZgyO+hFXrziDLnmJ
         WJfKsnZYW2NOQL3/ej8bLyiHu3o1cYgHqGtMbPw/xU5DUyrh9wH/uRCTzT6nteqM17
         ih0fj7MI3xs3DsWKDpGWHK/svwtx6ndwsmveTHwe5/53fRS3olzp6tBliGqf9sdGX9
         kN9/UPhMXhRiCAx1fAJd0t7sk9E2Jrj7YEssyG4k1JXRDx+YpYchn3i5vwcM7u3hPP
         uyPhDJtpjTnpxvOXge4E7SaouWn3esU19tKAKmZoLjNyYWqbKP+E5Cdjp80IatCv7m
         LrjabKUWygppA==
Date:   Tue, 11 Jul 2023 14:49:50 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, firoz.khan@linaro.org,
        fweimer@redhat.com, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, paul.burton@mips.com, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org, rth@twiddle.net,
        schwidefsky@de.ibm.com, sparclinux@vger.kernel.org,
        stefan@agner.ch, tglx@linutronix.de, tony.luck@intel.com,
        tycho@tycho.ws, will@kernel.org, x86@kernel.org,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 2/5] fs: Add fchmodat4()
Message-ID: <ZK1P7kkjTvSU8M++@example.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
 <ZK1K1BOf43JOJWMx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK1K1BOf43JOJWMx@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:28:04PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 11, 2023 at 01:25:43PM +0200, Alexey Gladkov wrote:
> > -static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> > +static int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int lookup_flags)
> 
> This function can still be called do_fchmodat(); we don't need to
> version internal functions.

Yes. I tried not to change too much when adopting a patch. In the new
version, I will return the old name. Thanks.

-- 
Rgrds, legion

