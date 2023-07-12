Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD6763DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjGZRa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjGZRaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:30:55 -0400
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF526A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 10:30:52 -0700 (PDT)
Date:   Tue, 11 Jul 2023 22:42:44 -0400
From:   Rich Felker <dalias@libc.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, James.Bottomley@HansenPartnership.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        axboe@kernel.dk, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        bp@alien8.de, catalin.marinas@arm.com, christian@brauner.io,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH v4 0/5] Add a new fchmodat2() syscall
Message-ID: <20230712024243.GX20050@brightrain.aerifal.cx>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689092120.git.legion@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 06:16:02PM +0200, Alexey Gladkov wrote:
> In glibc, the fchmodat(3) function has a flags argument according to the
> POSIX specification [1], but kernel syscalls has no such argument.
> Therefore, libc implementations do workarounds using /proc. However,
> this requires procfs to be mounted and accessible.
> 
> This patch set adds fchmodat2(), a new syscall. The syscall allows to
> pass the AT_SYMLINK_NOFOLLOW flag to disable LOOKUP_FOLLOW. In all other
> respects, this syscall is no different from fchmodat().
> 
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/chmod.html
> 
> Changes since v3 [cover.1689074739.git.legion@kernel.org]:
> 
> * Rebased to master because a new syscall has appeared in master.
> * Increased __NR_compat_syscalls as pointed out by Arnd Bergmann.
> * Syscall renamed fchmodat4 -> fchmodat2 as suggested by Christian Brauner.
> * Returned do_fchmodat4() the original name. We don't need to version
>   internal functions.
> * Fixed warnings found by checkpatch.pl.
> 
> Changes since v2 [20190717012719.5524-1-palmer@sifive.com]:
> 
> * Rebased to master.
> * The lookup_flags passed to sys_fchmodat4 as suggested by Al Viro.
> * Selftest added.
> 
> Changes since v1 [20190531191204.4044-1-palmer@sifive.com]:
> 
> * All architectures are now supported, which support squashed into a
>   single patch.
> * The do_fchmodat() helper function has been removed, in favor of directly
>   calling do_fchmodat4().
> * The patches are based on 5.2 instead of 5.1.

It's good to see this moving forward. I originally proposed this in a
patch submitted in 2020. I suspect implementation details have changed
since then, but it might make sense to look back at that discussion if
nobody has done so yet (apologies if this was already done and I
missed it) to make sure nothing is overlooked -- I remember there were
some subtleties with what fs backends might try to do with chmod on
symlinks. My proposed commit message also documented a lot of the
history of the issue that might be useful to have as context.

https://lore.kernel.org/all/20200910170256.GK3265@brightrain.aerifal.cx/T/

Rich
