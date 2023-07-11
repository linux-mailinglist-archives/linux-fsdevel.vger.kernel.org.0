Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6C74F0F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjGKOBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjGKOBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:01:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DBB0;
        Tue, 11 Jul 2023 07:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554A861504;
        Tue, 11 Jul 2023 14:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD1DC433C7;
        Tue, 11 Jul 2023 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689084078;
        bh=cdE+rFjbrFVLmzVrU6vfdc/Au2vs/4K/KtQWUN2iOVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFC0KFw6/M6i8iNMypafGbl8Cu47AhRfSYX/xpea89PI4ZoMwe92EJqP3skNe1e6r
         wdNiag9bpyADI4zIDbvsfEfC5gi5cG0LiI+uy+iziLVFM+p32F6ViRjBHJmXzejh3K
         hGryvnrWcowWB4v9G6Utb47tLMTtfXf0Jk5KlXTXblJ68+Ehl7NBgEro6SYLZcBbuG
         SEhMMw8zZvhNH953cv8zDMYVJb4nE9cNKmW9VcGjlVykyXZpRuOY205drYPWTtbPxy
         Nee7XyVCXNFnj+xKEgPCEgPFhFOWJaEQgr+bospaDMUJydxlVz0ktUF8W7K96PF8x7
         FoGj2nXcIV0Uw==
Date:   Tue, 11 Jul 2023 16:01:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Palmer Dabbelt <palmer@sifive.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        christian@brauner.io, Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>, fenghua.yu@intel.com,
        firoz.khan@linaro.org, Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, jhogan@kernel.org,
        Kim Phillips <kim.phillips@arm.com>, ldv@altlinux.org,
        linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>, paul.burton@mips.com,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, stefan@agner.ch,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, tycho@tycho.ws,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v3 2/5] fs: Add fchmodat4()
Message-ID: <20230711-verpennen-turnier-717bb9682e19@brauner>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
 <83363cbb-2431-4520-81a9-0d71f420cb36@app.fastmail.com>
 <20230711-demolieren-nilpferd-80ffe47563ad@brauner>
 <ZK1QNRidZuGcfOSd@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZK1QNRidZuGcfOSd@example.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:51:01PM +0200, Alexey Gladkov wrote:
> On Tue, Jul 11, 2023 at 01:52:01PM +0200, Christian Brauner wrote:
> > On Tue, Jul 11, 2023 at 01:42:19PM +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 11, 2023, at 13:25, Alexey Gladkov wrote:
> > > > From: Palmer Dabbelt <palmer@sifive.com>
> > > >
> > > > On the userspace side fchmodat(3) is implemented as a wrapper
> > > > function which implements the POSIX-specified interface. This
> > > > interface differs from the underlying kernel system call, which does not
> > > > have a flags argument. Most implementations require procfs [1][2].
> > > >
> > > > There doesn't appear to be a good userspace workaround for this issue
> > > > but the implementation in the kernel is pretty straight-forward.
> > > >
> > > > The new fchmodat4() syscall allows to pass the AT_SYMLINK_NOFOLLOW flag,
> > > > unlike existing fchmodat.
> > > >
> > > > [1] 
> > > > https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=17eca54051ee28ba1ec3f9aed170a62630959143;hb=a492b1e5ef7ab50c6fdd4e4e9879ea5569ab0a6c#l35
> > > > [2] 
> > > > https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c?id=718f363bc2067b6487900eddc9180c84e7739f80#n28
> > > >
> > > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > 
> > > I don't know the history of why we ended up with the different
> > > interface, or whether this was done intentionally in the kernel
> > > or if we want this syscall.
> > > 
> > > Assuming this is in fact needed, I double-checked that the
> > > implementation looks correct to me and is portable to all the
> > > architectures, without the need for a compat wrapper.
> > > 
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > The system call itself is useful afaict. But please,
> > 
> > s/fchmodat4/fchmodat2/
> 
> Sure. I will.

Thanks. Can you also wire this up for every architecture, please?
I don't see that this has been done in this series.
