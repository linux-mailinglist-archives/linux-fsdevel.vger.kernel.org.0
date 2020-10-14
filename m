Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998CD28DB02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 10:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgJNITf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 04:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgJNITd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B9C04586A;
        Tue, 13 Oct 2020 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zj/mSELh0gkQiJzxNFapB7VTFgX/SPaMVeSie4q6aLI=; b=OMo7hmfNufPo6rVhRGuQHzLQ0b
        1VAPwm7au3dwZhP2U8KCBzhdLGuGCJg4Y6BujKWfQq2J1qHSQizXWY3eydQmN9Z/I4vBdS6zYKs5j
        8G4vo2y4z0B+BuZzAKnFd/zlkgAkwf4/KGUd29HlOFzuWZb9K09Z7harllEIKARBJ+lNl3gcIyJwx
        IgDSWugwC2Wi8bsLi3iEMqOtFQSkJCi/2zicQQg/+6U0CE8rkkSKMimmb2xrSDPfAVVBj7aqg8wnj
        QMZqWCmfY9u5oHJiUeflNjGtB6dSKh1s54zSdXMn8V4HVtnycq0plQXp5B1021lCYA4/A3ZxNhsFb
        Ml0gOVXw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSZgx-0005RW-Py; Wed, 14 Oct 2020 05:51:15 +0000
Date:   Wed, 14 Oct 2020 06:51:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Viro <aviro@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20201014055115.GA19844@infradead.org>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain>
 <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
 <20201009220633.GA1122@sol.localdomain>
 <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
 <20201010011919.GC1122@sol.localdomain>
 <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
 <20201010015524.GB101464@shell-el7.hosts.prod.upshift.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010015524.GB101464@shell-el7.hosts.prod.upshift.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 10, 2020 at 01:55:24AM +0000, Alexander Viro wrote:
> FWIW, I hadn't pushed that branch out (or merged it into #for-next yet);
> for one thing, uml part (mconsole) is simply broken, for another...
> IMO ##5--8 are asking for kernel_pread() and if you look at binfmt_elf.c,
> you'll see elf_read() being pretty much that.  acct.c, keys and usermode
> parts are asking for kernel_pwrite() as well.
> 
> I've got stuck looking through the drivers/target stuff - it would've
> been another kernel_pwrite() candidate, but it smells like its use of
> filp_open() is really asking for trouble, starting with symlink attacks.
> Not sure - I'm not familiar with the area, but...

Can you just pull in the minimal fix so that the branch gets fixed
for this merge window?  All the cleanups can come later.
