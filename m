Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD83F6B4D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 05:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfGQDDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 23:03:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfGQDDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:03:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnaDa-0008R1-HC; Wed, 17 Jul 2019 03:02:58 +0000
Date:   Wed, 17 Jul 2019 04:02:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rich Felker <dalias@libc.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dhowells@redhat.com, firoz.khan@linaro.org,
        stefan@agner.ch, schwidefsky@de.ibm.com, axboe@kernel.dk,
        christian@brauner.io, hare@suse.com, deepa.kernel@gmail.com,
        tycho@tycho.ws, kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] Add fchmodat4(), a new syscall
Message-ID: <20190717030258.GT17978@ZenIV.linux.org.uk>
References: <20190717012719.5524-1-palmer@sifive.com>
 <20190717012719.5524-3-palmer@sifive.com>
 <20190717024046.GI1506@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717024046.GI1506@brightrain.aerifal.cx>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:40:46PM -0400, Rich Felker wrote:
> On Tue, Jul 16, 2019 at 06:27:17PM -0700, Palmer Dabbelt wrote:
> > man 3p says that fchmodat() takes a flags argument, but the Linux
> > syscall does not.  There doesn't appear to be a good userspace
> > workaround for this issue but the implementation in the kernel is pretty
> > straight-forward.  The specific use case where the missing flags came up
> > was WRT a fuse filesystem implemenation, but the functionality is pretty
> > generic so I'm assuming there would be other use cases.
> 
> Note that we do have a workaround in musl libc with O_PATH and
> /proc/self/fd, but a syscall that allows a proper fix with the ugly
> workaround only in the fallback path for old kernels will be much
> appreciated!
> 
> What about also doing a new SYS_faccessat4 with working AT_EACCESS
> flag? The workaround we have to do for it is far worse.

Umm...  That's doable, but getting into the "don't switch creds unless
needed" territory.  I'll need to play with that a bit and see what
gives a tolerable variant...

What of this part wrt AT_EACCESS?
        if (!issecure(SECURE_NO_SETUID_FIXUP)) {
                /* Clear the capabilities if we switch to a non-root user */
                kuid_t root_uid = make_kuid(override_cred->user_ns, 0);
                if (!uid_eq(override_cred->uid, root_uid))
                        cap_clear(override_cred->cap_effective);
                else
                        override_cred->cap_effective =
                                override_cred->cap_permitted;
        }
