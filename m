Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626FE3DD18C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 09:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhHBHvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 03:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232654AbhHBHvC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:51:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9590160FC1;
        Mon,  2 Aug 2021 07:50:51 +0000 (UTC)
Date:   Mon, 2 Aug 2021 09:50:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] mount_setattr.2: New manual page documenting the
 mount_setattr() system call
Message-ID: <20210802075046.frh2deqjmgkjrm4r@wittgenstein>
References: <20210731101527.423200-1-brauner@kernel.org>
 <828acf6c-dd06-e153-f7c8-9e1de7342b5f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <828acf6c-dd06-e153-f7c8-9e1de7342b5f@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 01, 2021 at 03:47:53PM +0200, Alejandro Colomar (man-pages) wrote:
> Hi Christian,
> 
> This time I'm going to point out issues about the contents only, not groff
> fixes nor even punctuation fixes.  I'll fix those myself and CC you when I

It's fine, I'm happy to do them if you point them out especially if
there need to be content changes because then I have rework anyway. I
just don't want to wade through other emails. :)

> do that.
> 
> However, if you render the page yourself (man ./mount_setattr.2), you will
> probably notice some formatting issues.

I'll obviously fix them if I see them. :)

> 
> Please see some comments below.
> 
> Thanks,
> 
> Alex
> 
> On 7/31/21 12:15 PM, Christian Brauner wrote:
> > 
> > +.SH ERRORS
> > +.TP
> > +.B EBADF
> > +.I dfd
> > +is not a valid file descriptor.
> > +.TP
> > +.B EBADF
> > +An invalid file descriptor value was specified in
> > +.I userns_fd.
> 
> Why a different wording compared to the above?  Aren't they the same?
> 
> userns_fd is not a valid descriptor.
> 
> That would be consistent with the first EBADF, and would keep the meaning,
> right?

Sounds good.

> 
> > +.TP
> > +.B EBUSY
> > +The caller tried to change the mount to
> > +.BR MOUNT_ATTR_RDONLY
> > +but the mount had writers.
> 
> This is not so clear.  I think I understood it, but maybe using language
> similar to that of mount(2) is clearer:
> 
> EBUSY  source cannot be remounted read‐only, because it still holds files
> open for writing.
> 
> Something like?:
> 
> The caller tried to change the mount to MOUNT_ATTR_ONLY but the mount still
> has files open for writing

Sounds good.

> 
> 
> > 
> > +static const struct option longopts[] = {
> > +    {"map-mount",       required_argument,  0,  'a'},
> > +    {"recursive",       no_argument,        0,  'b'},
> > +    {"read-only",       no_argument,        0,  'c'},
> > +    {"block-setid",     no_argument,        0,  'd'},
> > +    {"block-devices",   no_argument,        0,  'e'},
> > +    {"block-exec",      no_argument,        0,  'f'},
> > +    {"no-access-time",  no_argument,        0,  'g'},
> > +    { NULL,             0,                  0,   0 },
> > +};
> 
> The third field is an 'int *' (https://www.gnu.org/software/libc/manual/html_node/Getopt-Long-Options.html).
> Please, use NULL instead of 0.

ok

> 
> 
> > 
> > +    struct mount_attr *attr = &(struct mount_attr){};
> 
> Wow!  Interesting usage of compound literals.
> I had to check that this has automatic storage duration (I would have said
> that it has static s.d., but no).
> 
> I'm curious: why use that instead of just?:
> 
> struct mount_attr attr = {0};

I like the ability to directly pass "attr" as pointer and I also like
that I can use "attr->" instead of "attr.". It's entirely convenience. :)

> 
> > 
> > +    if (ret < 0)
> > +        exit_log("%m - Failed to change mount attributes\en");
> 
> 
> Although I typically use myself that same < 0 check,
> manual pages typically use == -1 when a function returns -1 on error (which
> most syscalls do), and Michael prefers that.

Sure, will change for mount_setattr() and move_mount() calls. I'd leave
the open_tree() and open().

Thanks!
Christian
