Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641F2579CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHaM5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 08:57:12 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:48458 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaM5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:57:09 -0400
Date:   Mon, 31 Aug 2020 08:57:07 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20200831125707.GM3265@brightrain.aerifal.cx>
References: <20200829020002.GC3265@brightrain.aerifal.cx>
 <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
 <20200830163657.GD3265@brightrain.aerifal.cx>
 <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
 <20200830184334.GE3265@brightrain.aerifal.cx>
 <CAG48ez3LvbWLBsJ+Edc9qCjXDYV0TRjVRrANhiR2im1aRUQ6gQ@mail.gmail.com>
 <20200830200029.GF3265@brightrain.aerifal.cx>
 <CAG48ez2tOBAKLaX-siRZPCLiiy-s65w2mFGDGr4q2S7WFxpK1A@mail.gmail.com>
 <20200831014633.GJ3265@brightrain.aerifal.cx>
 <CAG48ez0aKz8wedhNsW0CWk70-tUu8tmnOE4Yi4Cv5=uLghestA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0aKz8wedhNsW0CWk70-tUu8tmnOE4Yi4Cv5=uLghestA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:15:57AM +0200, Jann Horn wrote:
> On Mon, Aug 31, 2020 at 3:46 AM Rich Felker <dalias@libc.org> wrote:
> > On Mon, Aug 31, 2020 at 03:15:04AM +0200, Jann Horn wrote:
> > > On Sun, Aug 30, 2020 at 10:00 PM Rich Felker <dalias@libc.org> wrote:
> > > > On Sun, Aug 30, 2020 at 09:02:31PM +0200, Jann Horn wrote:
> > > > > On Sun, Aug 30, 2020 at 8:43 PM Rich Felker <dalias@libc.org> wrote:
> > > > > > On Sun, Aug 30, 2020 at 08:31:36PM +0200, Jann Horn wrote:
> > > > > > > On Sun, Aug 30, 2020 at 6:36 PM Rich Felker <dalias@libc.org> wrote:
> > > > > > > > So just checking IS_APPEND in the code paths used by
> > > > > > > > pwritev2 (and erroring out rather than silently writing output at the
> > > > > > > > wrong place) should suffice to preserve all existing security
> > > > > > > > invariants.
> > > > > > >
> > > > > > > Makes sense.
> > > > > >
> > > > > > There are 3 places where kiocb_set_rw_flags is called with flags that
> > > > > > seem to be controlled by userspace: aio.c, io_uring.c, and
> > > > > > read_write.c. Presumably each needs to EPERM out on RWF_NOAPPEND if
> > > > > > the underlying inode is S_APPEND. To avoid repeating the same logic in
> > > > > > an error-prone way, should kiocb_set_rw_flags's signature be updated
> > > > > > to take the filp so that it can obtain the inode and check IS_APPEND
> > > > > > before accepting RWF_NOAPPEND? It's inline so this should avoid
> > > > > > actually loading anything except in the codepath where
> > > > > > flags&RWF_NOAPPEND is nonzero.
> > > > >
> > > > > You can get the file pointer from ki->ki_filp. See the RWF_NOWAIT
> > > > > branch of kiocb_set_rw_flags().
> > > >
> > > > Thanks. I should have looked for that. OK, so a fixup like this on top
> > > > of the existing patch?
> > > >
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index 473289bff4c6..674131e8d139 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -3457,8 +3457,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> > > >                 ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> > > >         if (flags & RWF_APPEND)
> > > >                 ki->ki_flags |= IOCB_APPEND;
> > > > -       if (flags & RWF_NOAPPEND)
> > > > +       if (flags & RWF_NOAPPEND) {
> > > > +               if (IS_APPEND(file_inode(ki->ki_filp)))
> > > > +                       return -EPERM;
> > > >                 ki->ki_flags &= ~IOCB_APPEND;
> > > > +       }
> > > >         return 0;
> > > >  }
> > > >
> > > > If this is good I'll submit a v2 as the above squashed with the
> > > > original patch.
> > >
> > > Looks good to me.
> >
> > Actually it's not quite. I think it should be:
> >
> >         if ((flags & RWF_NOAPPEND) & (ki->ki_flags & IOCB_APPEND)) {
> >                 if (IS_APPEND(file_inode(ki->ki_filp)))
> >                         return -EPERM;
> >                 ki->ki_flags &= ~IOCB_APPEND;
> >         }
> >
> > i.e. don't refuse RWF_NOAPPEND on a file that was already successfully
> > opened without O_APPEND that only subsequently got chattr +a. The
> > permission check should only be done if it's overriding the default
> > action for how the file is open.
> >
> > This is actually related to the fcntl corner case mentioned before.
> >
> > Are you ok with this change? If so I'll go ahead and prepare a v2.
> 
> Ah, yeah, I guess that makes sense to keep things more consistent.
> 
> (You'll have to write that as "(flags & RWF_NOAPPEND) && (ki->ki_flags
> & IOCB_APPEND)" though (logical AND, not bitwise AND).)

Thanks, no idea how I made that mistake -- probably typing code in
email.

While reparing this I rebased against Linus's tree, and found
conflicts with 1752f0adea98ef85 which were easy to resolve.
Unfortunately the same improvement made in that commit does not work
for the new RWF_NOAPPEND, since it needs to inspect and mask bits off
the original ki_flags, not the local set of added flags, but the
penalty should be isolated to this branch. I'm not opposed to adding
unlikely() around it if you think that would help codegen for the
common cases.

Alternatively, kiocb_flags could be initialized to ki->ki_flags, with
assignment-back in place of |= at the end of the function. This might
be more elegant but I'm not sure if the emitted code would improve.

Rich
