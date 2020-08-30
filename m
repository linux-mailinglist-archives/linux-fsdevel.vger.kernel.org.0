Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613EE256F5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH3QhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 12:37:03 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:48214 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgH3QhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:37:00 -0400
Date:   Sun, 30 Aug 2020 12:36:58 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20200830163657.GD3265@brightrain.aerifal.cx>
References: <20200829020002.GC3265@brightrain.aerifal.cx>
 <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 05:05:45PM +0200, Jann Horn wrote:
> On Sat, Aug 29, 2020 at 4:00 AM Rich Felker <dalias@libc.org> wrote:
> > The pwrite function, originally defined by POSIX (thus the "p"), is
> > defined to ignore O_APPEND and write at the offset passed as its
> > argument. However, historically Linux honored O_APPEND if set and
> > ignored the offset. This cannot be changed due to stability policy,
> > but is documented in the man page as a bug.
> >
> > Now that there's a pwritev2 syscall providing a superset of the pwrite
> > functionality that has a flags argument, the conforming behavior can
> > be offered to userspace via a new flag.
> [...]
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> [...]
> > @@ -3411,6 +3413,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> >                 ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> >         if (flags & RWF_APPEND)
> >                 ki->ki_flags |= IOCB_APPEND;
> > +       if (flags & RWF_NOAPPEND)
> > +               ki->ki_flags &= ~IOCB_APPEND;
> >         return 0;
> >  }
> 
> Linux enforces the S_APPEND flag (set by "chattr +a") only at open()
> time, not at write() time:
> 
> # touch testfile
> # exec 100>testfile
> # echo foo > testfile
> # cat testfile
> foo
> # chattr +a testfile
> # echo bar > testfile
> bash: testfile: Operation not permitted
> # echo bar >&100
> # cat testfile
> bar
> #
> 
> At open() time, the kernel enforces that you can't use O_WRONLY/O_RDWR
> without also setting O_APPEND if the file is marked as append-only:
> 
> static int may_open(const struct path *path, int acc_mode, int flag)
> {
> [...]
>   /*
>    * An append-only file must be opened in append mode for writing.
>    */
>   if (IS_APPEND(inode)) {
>     if  ((flag & O_ACCMODE) != O_RDONLY && !(flag & O_APPEND))
>       return -EPERM;
>     if (flag & O_TRUNC)
>       return -EPERM;
>   }
> [...]
> }
> 
> It seems to me like your patch will permit bypassing S_APPEND by
> opening an append-only file with O_WRONLY|O_APPEND, then calling
> pwritev2() with RWF_NOAPPEND? I think you'll have to add an extra
> check for IS_APPEND() somewhere.
> 
> 
> One could also argue that if an O_APPEND file descriptor is handed
> across privilege boundaries, a programmer might reasonably expect that
> the recipient will not be able to use the file descriptor for
> non-append writes; if that is not actually true, that should probably
> be noted in the open.2 manpage, at the end of the description of
> O_APPEND.

fcntl F_SETFL can remove O_APPEND, so it is not a security boundary.
I'm not sure how this interacts with S_APPEND; presumably fcntl
rechecks it. So just checking IS_APPEND in the code paths used by
pwritev2 (and erroring out rather than silently writing output at the
wrong place) should suffice to preserve all existing security
invariants.

Rich
