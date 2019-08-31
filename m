Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12061A45AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfHaSDY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 14:03:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbfHaSDY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 14:03:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11A4BAFCF;
        Sat, 31 Aug 2019 18:03:22 +0000 (UTC)
Date:   Sat, 31 Aug 2019 20:03:18 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 0/6] Disable compat cruft on ppc64le v7
Message-ID: <20190831200318.74c32b57@naga>
In-Reply-To: <c6e61aee-7ffb-60db-ccf8-e805d2707eb5@c-s.fr>
References: <cover.1567198491.git.msuchanek@suse.de>
        <c6e61aee-7ffb-60db-ccf8-e805d2707eb5@c-s.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 31 Aug 2019 08:41:58 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Le 30/08/2019 à 23:03, Michal Suchanek a écrit :
> > Less code means less bugs so add a knob to skip the compat stuff.  
> 
> I guess on PPC64 you have Gigabytes of memory and thousands of bogomips, 
> hence you focus on bugs.
> 
> My main focus usually is kernel size and performance, which makes this 
> series interesting as well.
> 
> Anyway, I was wondering, would it make sense (in a following series, not 
> in this one) to make it buildable as a module, just like some of binfmt ?

I think not.

You have the case when 32bit support is not optional because you are
32bit and when it is optional because you are 64bit. These cases either
diverge or the 32bit case suffers the penalty of some indirection that
makes the functionality loadable.

The indirection requires some synchronization so the 32bit code cannot
be unloaded while you are trying to call it, and possibly counting
32bit tasks so you will know when you can unload the 32bit code again.

This would add more code which benefits neither performance nor size
nor reliability.

Also you can presumably run 32bit code with binfmt-misc already but
don't get stuff like perf counters handled in the kernel because it is
not native code anymore.

Thanks

Michal

> 
> Christophe
> 
> > 
> > This is tested on ppc64le top of
> > 
> > https://patchwork.ozlabs.org/cover/1153556/
> > 
> > Changes in v2: saner CONFIG_COMPAT ifdefs
> > Changes in v3:
> >   - change llseek to 32bit instead of builing it unconditionally in fs
> >   - clanup the makefile conditionals
> >   - remove some ifdefs or convert to IS_DEFINED where possible
> > Changes in v4:
> >   - cleanup is_32bit_task and current_is_64bit
> >   - more makefile cleanup
> > Changes in v5:
> >   - more current_is_64bit cleanup
> >   - split off callchain.c 32bit and 64bit parts
> > Changes in v6:
> >   - cleanup makefile after split
> >   - consolidate read_user_stack_32
> >   - fix some checkpatch warnings
> > Changes in v7:
> >   - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
> >   - remove leftover hunk
> >   - add review tags
> > 
> > Michal Suchanek (6):
> >    powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
> >    powerpc: move common register copy functions from signal_32.c to
> >      signal.c
> >    powerpc/perf: consolidate read_user_stack_32
> >    powerpc/64: make buildable without CONFIG_COMPAT
> >    powerpc/64: Make COMPAT user-selectable disabled on littleendian by
> >      default.
> >    powerpc/perf: split callchain.c by bitness
> > 
> >   arch/powerpc/Kconfig                   |   5 +-
> >   arch/powerpc/include/asm/thread_info.h |   4 +-
> >   arch/powerpc/include/asm/unistd.h      |   1 +
> >   arch/powerpc/kernel/Makefile           |   7 +-
> >   arch/powerpc/kernel/entry_64.S         |   2 +
> >   arch/powerpc/kernel/signal.c           | 144 +++++++++-
> >   arch/powerpc/kernel/signal_32.c        | 140 ---------
> >   arch/powerpc/kernel/syscall_64.c       |   6 +-
> >   arch/powerpc/kernel/vdso.c             |   5 +-
> >   arch/powerpc/perf/Makefile             |   5 +-
> >   arch/powerpc/perf/callchain.c          | 377 +------------------------
> >   arch/powerpc/perf/callchain.h          |  11 +
> >   arch/powerpc/perf/callchain_32.c       | 204 +++++++++++++
> >   arch/powerpc/perf/callchain_64.c       | 185 ++++++++++++
> >   fs/read_write.c                        |   3 +-
> >   15 files changed, 566 insertions(+), 533 deletions(-)
> >   create mode 100644 arch/powerpc/perf/callchain.h
> >   create mode 100644 arch/powerpc/perf/callchain_32.c
> >   create mode 100644 arch/powerpc/perf/callchain_64.c
> >   

