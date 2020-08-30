Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED43256FBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgH3Snj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 14:43:39 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:48244 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgH3Sni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:43:38 -0400
Date:   Sun, 30 Aug 2020 14:43:36 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20200830184334.GE3265@brightrain.aerifal.cx>
References: <20200829020002.GC3265@brightrain.aerifal.cx>
 <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
 <20200830163657.GD3265@brightrain.aerifal.cx>
 <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 08:31:36PM +0200, Jann Horn wrote:
> On Sun, Aug 30, 2020 at 6:36 PM Rich Felker <dalias@libc.org> wrote:
> > On Sun, Aug 30, 2020 at 05:05:45PM +0200, Jann Horn wrote:
> > > On Sat, Aug 29, 2020 at 4:00 AM Rich Felker <dalias@libc.org> wrote:
> > > > The pwrite function, originally defined by POSIX (thus the "p"), is
> > > > defined to ignore O_APPEND and write at the offset passed as its
> > > > argument. However, historically Linux honored O_APPEND if set and
> > > > ignored the offset. This cannot be changed due to stability policy,
> > > > but is documented in the man page as a bug.
> > > >
> > > > Now that there's a pwritev2 syscall providing a superset of the pwrite
> > > > functionality that has a flags argument, the conforming behavior can
> > > > be offered to userspace via a new flag.
> [...]
> > > Linux enforces the S_APPEND flag (set by "chattr +a") only at open()
> > > time, not at write() time:
> [...]
> > > It seems to me like your patch will permit bypassing S_APPEND by
> > > opening an append-only file with O_WRONLY|O_APPEND, then calling
> > > pwritev2() with RWF_NOAPPEND? I think you'll have to add an extra
> > > check for IS_APPEND() somewhere.
> > >
> > >
> > > One could also argue that if an O_APPEND file descriptor is handed
> > > across privilege boundaries, a programmer might reasonably expect that
> > > the recipient will not be able to use the file descriptor for
> > > non-append writes; if that is not actually true, that should probably
> > > be noted in the open.2 manpage, at the end of the description of
> > > O_APPEND.
> >
> > fcntl F_SETFL can remove O_APPEND, so it is not a security boundary.
> > I'm not sure how this interacts with S_APPEND; presumably fcntl
> > rechecks it.
> 
> Ah, good point, you're right. In fs/fcntl.c:
> 
>   35 static int setfl(int fd, struct file * filp, unsigned long arg)
>   36 {
>   37    struct inode * inode = file_inode(filp);
>   38    int error = 0;
>   39
>   40    /*
>   41     * O_APPEND cannot be cleared if the file is marked as append-only
>   42     * and the file is open for write.
>   43     */
>   44    if (((arg ^ filp->f_flags) & O_APPEND) && IS_APPEND(inode))
>   45            return -EPERM;

FWIW I think this check is mildly wrong; it seems to disallow *adding*
O_APPEND if the file became chattr +a after it was opened. It should
probably be changed to only disallow removal.

> > So just checking IS_APPEND in the code paths used by
> > pwritev2 (and erroring out rather than silently writing output at the
> > wrong place) should suffice to preserve all existing security
> > invariants.
> 
> Makes sense.

There are 3 places where kiocb_set_rw_flags is called with flags that
seem to be controlled by userspace: aio.c, io_uring.c, and
read_write.c. Presumably each needs to EPERM out on RWF_NOAPPEND if
the underlying inode is S_APPEND. To avoid repeating the same logic in
an error-prone way, should kiocb_set_rw_flags's signature be updated
to take the filp so that it can obtain the inode and check IS_APPEND
before accepting RWF_NOAPPEND? It's inline so this should avoid
actually loading anything except in the codepath where
flags&RWF_NOAPPEND is nonzero.

Rich
