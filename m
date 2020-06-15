Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1A1F9A94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgFOOnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 10:43:14 -0400
Received: from verein.lst.de ([213.95.11.211]:33796 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgFOOnO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:43:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8AE268AFE; Mon, 15 Jun 2020 16:43:10 +0200 (CEST)
Date:   Mon, 15 Jun 2020 16:43:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Message-ID: <20200615144310.GA15101@lst.de>
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de> <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de> <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:40:28PM +0200, Arnd Bergmann wrote:
> > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> > `__x32_sys_execve'
> > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> > `__x32_sys_execveat'
> > make: *** [Makefile:1139: vmlinux] Error 1
> 
> Ah, I see: it's marked x32-only, so arch/x86/entry/syscall_x32.c
> uses the __x32 prefix instead of the __x64 one. Marking it 'common'
> instead would make it work, but also create an extra entry point
> for native processes, something that commit
> 6365b842aae4 ("x86/syscalls: Split the x32 syscalls into their own table")
> was trying to avoid.

Marking it common also doesn't compile at all because __NR_execve
and __NR_execveat get redefined in unistd_64.h.  I then tried to rename
the x32 versions, which failed in yet another way.  At that point I gave
up instead of digging myself into a deeper hole..
