Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B65289B99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 00:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbgJIWGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 18:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389431AbgJIWGg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:06:36 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3638622258;
        Fri,  9 Oct 2020 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602281195;
        bh=BSdsYnSsWQ2YK6s+0hwikbexRRTi6RzXd6Oify0LIKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FggwccN5I5AZiuE+Vm843foxykXLgY3+2Ve5JGwMxqNB3E+xShPYydixbERiidVVi
         QW9J0tz5mlsoo600M7a+WgeVErDk1b1VMW5mDMvhyrS14K46mLfNtrpVvaVMMeP9LF
         2DCRbted8w1IYRD5exRfS6+MpJtndCuG5tnmVNDU=
Date:   Fri, 9 Oct 2020 15:06:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20201009220633.GA1122@sol.localdomain>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain>
 <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:27:09AM -0700, Linus Torvalds wrote:
> On Thu, Oct 1, 2020 at 3:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Better
> >         loff_t dummy = 0;
> > ...
> >                 wr = __kernel_write(file, data, bytes, &dummy);
> 
> No, just fix __kernel_write() to work correctly.
> 
> The fact is, NULL _is_ the right pointer for ppos these days.
> 
> That commit by Christoph is buggy: it replaces new_sync_write() with a
> buggy open-coded version.
> 
> Notice how new_sync_write does
> 
>         kiocb.ki_pos = (ppos ? *ppos : 0);
> ,,,
>         if (ret > 0 && ppos)
>                 *ppos = kiocb.ki_pos;
> 
> but the open-coded version doesn't.
> 
> So just fix that in linux-next. The *last* thing we want is to have
> different semantics for the "same" kernel functions.

It's a bit unintuitive that ppos=NULL means "use pos 0", not "use file->f_pos".

Anyway, it works.  The important thing is, this is still broken in linux-next...

- Eric
