Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D018376A98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhEGTTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 15:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEGTTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 15:19:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAEDC061574;
        Fri,  7 May 2021 12:18:01 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lf5yy-00CMNR-Ra; Fri, 07 May 2021 19:17:52 +0000
Date:   Fri, 7 May 2021 19:17:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
Message-ID: <YJWSYDk4gAT1hkf6@zeniv-ca.linux.org.uk>
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
 <202105071116.638258236E@keescook>
 <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 12:06:31PM -0700, Linus Torvalds wrote:

> That said - looking at the current 'pipe_zero()', it uses
> 'push_pipe()' to actually allocation regular pages, and then clear
> them.
> 
> Which is basically what a generic_file_splice_read() would do, and it
> feels incredibly pointless and stupid to me.
> 
> I *think* we should be able to just do something like
> 
>     len = size;
>     while (len > 0) {
>         struct pipe_buffer *buf;
>         unsigned int tail = pipe->tail;
>         unsigned int head = pipe->head;
>         unsigned int mask = pipe->ring_size - 1;
> 
>         if (pipe_full(head, tail, pipe->max_usage))
>             break;
>         buf = &pipe->bufs[iter_head & p_mask];
>         buf->ops = &zero_pipe_buf_ops;
>         buf->page = ZERO_PAGE(0);
>         buf->offset = 0;
>         buf->len = min_t(ssize_t, len, PAGE_SIZE);
>         len -= buf->len;
>         pipe->head = head+1;
>     }
>     return size - len;
> 
> but honestly, I haven't thought a lot about it.
> 
> Al? This is another of those "right up your alley" things.

Umm...  That would do wonders to anything that used to do
copy_to_user()/clear_user()/copy_to_user() and got converted
to copy_to_iter()/iov_iter_zero()/copy_to_iter()...

Are you sure we can shove zero page into pipe, anyway?
IIRC, get_page()/put_page() on that is not allowed, and
I'm not at all sure that nothing in e.g. fuse splice-related
logics would go ahead an do just that.  Or am I confused
about the page refcounting for those?
