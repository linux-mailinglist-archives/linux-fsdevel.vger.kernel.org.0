Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABB39F4EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhFHL3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhFHL3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:29:45 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6336C061574;
        Tue,  8 Jun 2021 04:27:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqZtb-005pZ8-0X; Tue, 08 Jun 2021 11:27:47 +0000
Date:   Tue, 8 Jun 2021 11:27:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YL9UMk9SppN7Pk06@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org>
 <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
 <YL5CTiR94f5DYPFK@infradead.org>
 <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk>
 <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
 <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:35:46PM -0700, Linus Torvalds wrote:
> On Mon, Jun 7, 2021 at 3:01 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >  (b) on all the common non-SET_FS architectures, kernel threads using
> > iov_iter_init() wouldn't work anyway, because on those architectures
> > it would always fill the thing in with an iov, not a kvec.
> 
> Thinking more about this thing, I think it means that what we *should*
> do is simply just
> 
>   void iov_iter_init(struct iov_iter *i, unsigned int direction,
>                         const struct iovec *iov, unsigned long nr_segs,
>                         size_t count)
>   {
>         WARN_ON_ONCE(direction & ~(READ | WRITE));
>         iWARN_ON_ONCE(uaccess_kernel());
>         *i = (struct iov_iter) {
>                 .iter_type = ITER_IOVEC,
>                 .data_source = direction,
>                 .iov = iov,
>                 .nr_segs = nr_segs,
>                 .iov_offset = 0,
>                 .count = count
>         };
>   }
> 
> because filling it with a kvec is simply wrong. It's wrong exactly due
> to the fact that *if* we have a kernel thread, all the modern
> non-SET_FS architectures will just ignore that entirely, and always
> use the iov meaning.

Updated and pushed out...
