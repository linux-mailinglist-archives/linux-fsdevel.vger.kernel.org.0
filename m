Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7C376B24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 22:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhEGUck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhEGUck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 16:32:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7BC061574;
        Fri,  7 May 2021 13:31:40 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lf78G-00CNE3-Em; Fri, 07 May 2021 20:31:32 +0000
Date:   Fri, 7 May 2021 20:31:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
Message-ID: <YJWjpPoJYK6IeF7C@zeniv-ca.linux.org.uk>
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
 <202105071116.638258236E@keescook>
 <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
 <YJWSYDk4gAT1hkf6@zeniv-ca.linux.org.uk>
 <CAHk-=wjhWKp=fQREgQy0uGjo-uvcTg-11gJLoDp4Af8WOKa8ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhWKp=fQREgQy0uGjo-uvcTg-11gJLoDp4Af8WOKa8ig@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 12:29:44PM -0700, Linus Torvalds wrote:
> On Fri, May 7, 2021 at 12:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Umm...  That would do wonders to anything that used to do
> > copy_to_user()/clear_user()/copy_to_user() and got converted
> > to copy_to_iter()/iov_iter_zero()/copy_to_iter()...
> 
> I didn't mean for iov_iter_zero doing this - only splice_read_zero().
> 
> > Are you sure we can shove zero page into pipe, anyway?
> > IIRC, get_page()/put_page() on that is not allowed,
> 
> That's what the
> 
>     buf->ops = &zero_pipe_buf_ops;
> 
> is for. The zero_pipe_buf_ops would have empty get and release
> functions, and a 'steal' function that always returns false.
> 
> That's how the pipe pages are supposed to work: there are people who
> put non-page data (ie things like skbuff allocations etc) into a
> splice pipe buffer. It's why we have those "ops" pointers.

Supposed to - sure, but I'd like to verify that they actually do work
that way before we go there.  Let me RTFS a bit...
