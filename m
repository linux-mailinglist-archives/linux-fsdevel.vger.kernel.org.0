Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0660C2AFABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 22:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKKVwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 16:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:52:32 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A362C0613D4;
        Wed, 11 Nov 2020 13:52:32 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcy2O-003qBZ-LL; Wed, 11 Nov 2020 21:52:20 +0000
Date:   Wed, 11 Nov 2020 21:52:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201111215220.GA3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:54:12AM -0800, Linus Torvalds wrote:
> On Tue, Nov 10, 2020 at 3:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Any objections to the following?
> 
> Well, I don't _object_, but I find it ugly.
> 
> And I think both the old and the "fixed" code is wrong when an EFAULT
> happens in the middle.
> 
> Yes, we can just return EFAULT. But for read() and write() we really
> try to do the proper partial returns in other places, why not here?
> 
> IOW, why isn't the proper fix just something like this:
> 
>     diff --git a/fs/seq_file.c b/fs/seq_file.c
>     index 3b20e21604e7..ecc6909b71f5 100644
>     --- a/fs/seq_file.c
>     +++ b/fs/seq_file.c
>     @@ -209,7 +209,8 @@ ssize_t seq_read_iter(struct kiocb *iocb,
> struct iov_iter *iter)
>         /* if not empty - flush it first */
>         if (m->count) {
>                 n = min(m->count, size);
>     -           if (copy_to_iter(m->buf + m->from, n, iter) != n)
>     +           n = copy_to_iter(m->buf + m->from, n, iter);
>     +           if (!n)
>                         goto Efault;
>                 m->count -= n;
>                 m->from += n;
> 
> which should get the "efault in the middle" case roughly right (ie the
> usual "exact byte alignment and page crosser" caveats apply).

Look at the loop after that one, specifically the "it doesn't fit,
allocate a bigger one" part:
                kvfree(m->buf);
                m->count = 0;
                m->buf = seq_buf_alloc(m->size <<= 1);
It really depends upon having m->buf empty at the beginning of
the loop.  Your variant will lose the data, unless we copy the
"old" part of buffer (from before the ->show()) into the
larger one.

That can be done, but I would rather go with
		n = copy_to_iter(m->buf + m->from, m->count, iter);
		m->count -= n;
		m->from += n;
                copied += n;
                if (!size)
                        goto Done;
		if (m->count)
			goto Efault;
if we do it that way.  Let me see if I can cook something
reasonable along those lines...
