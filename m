Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579941C5540
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgEEMQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 08:16:01 -0400
Received: from verein.lst.de ([213.95.11.211]:35078 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEMQB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 08:16:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68BE668C4E; Tue,  5 May 2020 14:15:57 +0200 (CEST)
Date:   Tue, 5 May 2020 14:15:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] binfmt_elf_fdpic: Stop using dump_emit() on
 user pointers on !MMU
Message-ID: <20200505121557.GA24052@lst.de>
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-2-jannh@google.com> <20200505104805.GA17400@lst.de> <CAG48ez3F70-UXwdHmO4CnR0bAForn-SBtstW5WAYjcrLFwS_9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3F70-UXwdHmO4CnR0bAForn-SBtstW5WAYjcrLFwS_9A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 01:42:12PM +0200, Jann Horn wrote:
> On Tue, May 5, 2020 at 12:48 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Wed, Apr 29, 2020 at 11:49:50PM +0200, Jann Horn wrote:
> > > dump_emit() is for kernel pointers, and VMAs describe userspace memory.
> > > Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
> > > even if it probably doesn't matter much on !MMU systems - especially given
> > > that it looks like we can just use the same get_dump_page() as on MMU if
> > > we move it out of the CONFIG_MMU block.
> >
> > Looks sensible.  Did you get a chance to test this with a nommu setup?
> 
> Nope. Do you happen to have a recommendation for a convenient
> environment I can use with QEMU, or something like that? I'm guessing
> that just running a standard armel Debian userspace with a !mmu ARM
> kernel wouldn't work so well?

Nommu generally needs special userspace either using uclibc-ng or musl.
When I did the RISC-V nommu work I used buildroot for my root file
systems.  We haven't gotten elffdpic to work on RISC-V yet, so I can't
use that setup for testing, but it should support ARM as well.
