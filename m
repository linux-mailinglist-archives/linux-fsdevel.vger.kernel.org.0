Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA73BB6B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 07:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGEFUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 01:20:20 -0400
Received: from verein.lst.de ([213.95.11.211]:55576 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhGEFUU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:20:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1314D67373; Mon,  5 Jul 2021 07:17:41 +0200 (CEST)
Date:   Mon, 5 Jul 2021 07:17:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
Message-ID: <20210705051740.GA543@lst.de>
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com> <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com> <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net> <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 04, 2021 at 01:41:51PM -0700, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 1:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Turns out that, at least on m68k/nommu, USER_DS and KERNEL_DS are the same.
> >
> > #define USER_DS         MAKE_MM_SEG(TASK_SIZE)
> > #define KERNEL_DS       MAKE_MM_SEG(0xFFFFFFFF)
> 
> Ahh. So the code is fine, it's just that "uaccess_kernel()" isn't
> something that can be reliably even tested for, and it will always
> return true on those nommu platforms.

Yes, I think m68knommu and armnommu have this problems.  They really
need to be converted to stop implementing set_fs ASAP, as there is no
point for them.

> And we don't have a "uaccess_user()" macro that would test if it
> matches USER_DS (and that also would always return true on those
> configurations), so we can't just change the
> 
>         WARN_ON_ONCE(uaccess_kernel());
> 
> into a
> 
>         WARN_ON_ONCE(!uaccess_user());
> 
> instead.
> 
> Very annoying. Basically, every single use of "uaccess_kernel()" is unreliable.

Yes.

> The other alternative would be to just make nommu platforms that have
> KERNEL_DS==USER_DS simply do
> 
>     #define uaccess_kernel() (false)
> 
> and avoid it that way, since that's closer to what the modern
> non-CONFIG_SET_FS world view is, and is what include/linux/uaccess.h
> does for that case..

Maybe that is the best short-term bandaid.
