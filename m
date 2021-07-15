Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B581A3CA12D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhGOPMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhGOPMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:12:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD8C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wzZnBuoeeDi6OrFuUpS9NUQd7UEFEa6FiQe6MiOalzc=; b=C08YkPuzbL6uAOUYAAQNbvTP/A
        /ouw5PO3aTzzRyH5hN3lGXNk69+xozw/XpU3Wq7zQBVKO5/9VhRoAviDVWtgcRGNqE1zxVI0SiwKK
        ERaZ4Q8zjcoOKl1D7pqIOimpGQTNah5YT16+6GWrjU50lElVV3dG4Alrm/U+RfnX0yrA/6SDJRNtn
        FpreTPdjJ5ynTtt1YYTEFL2tZt2GsW/9AeZHf5oHRetkd8mdEZuPJyt75fqkIkZfVc9pG1QPsYuRx
        fd1+vRVnzdrGvij/Z/nXJDzPNIxL6/6VivKvRBwiXOXZPocwMBSaex8VZO6YHVkaIZYQ08YQtk+zJ
        VXujW9sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m42z4-003Sb4-HG; Thu, 15 Jul 2021 15:09:11 +0000
Date:   Thu, 15 Jul 2021 16:09:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
Message-ID: <YPBPkupPDnsCXrLU@casper.infradead.org>
References: <20210715141309.38443-1-nborisov@suse.com>
 <YPBGoDlf9T6kFjk1@casper.infradead.org>
 <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 05:44:15PM +0300, Nikolay Borisov wrote:
> That was my first impression, here's the profile:
> 
>        │    Disassembly of section .text:
>        │
>        │    ffffffff815c6f60 <memcmp>:
>        │    memcmp():
>        │      test   %rdx,%rdx
>        │    ↓ je     22
>        │      xor    %ecx,%ecx
>        │    ↓ jmp    12
>  49.32 │ 9:   add    $0x1,%rcx
>   0.03 │      cmp    %rcx,%rdx
>  11.82 │    ↓ je     21
>   0.01 │12:   movzbl (%rdi,%rcx,1),%eax
>  38.19 │      movzbl (%rsi,%rcx,1),%r8d
>   0.59 │      sub    %r8d,%eax
>   0.04 │    ↑ je     9

That looks like a byte loop to me ...

> It's indeed on x86-64 and according to the sources it's using
> __builtin_memcmp according to arch/x86/boot/string.h

I think the 'boot' part of that path might indicate that it's not what's
actually being used by the kernel.

$ git grep __HAVE_ARCH_MEMCMP
arch/arc/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
arch/arm64/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
arch/csky/abiv2/inc/abi/string.h:#define __HAVE_ARCH_MEMCMP
arch/powerpc/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
arch/s390/include/asm/string.h:#define __HAVE_ARCH_MEMCMP       /* arch function */
arch/s390/lib/string.c:#ifdef __HAVE_ARCH_MEMCMP
arch/s390/purgatory/string.c:#define __HAVE_ARCH_MEMCMP /* arch function */
arch/sparc/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
include/linux/string.h:#ifndef __HAVE_ARCH_MEMCMP
lib/string.c:#ifndef __HAVE_ARCH_MEMCMP

So I think x86-64 is using the stupid one.

> > Can this even happen?  Surely we can only dedup on a block boundary and
> > blocks are required to be a power of two and at least 512 bytes in size?
> 
> I was wondering the same thing, but AFAICS it seems to be possible i.e
> if userspace spaces bad offsets, while all kinds of internal fs
> synchronization ops are going to be performed on aligned offsets, that
> doesn't mean the original ones, passed from userspace are themselves
> aligned explicitly.

Ah, I thought it'd be failed before we got to this point.

But honestly, I think x86-64 needs to be fixed to either use
__builtin_memcmp() or to have a nicely written custom memcmp().  I
tried to find the gcc implementation of __builtin_memcmp() on
x86-64, but I can't.
