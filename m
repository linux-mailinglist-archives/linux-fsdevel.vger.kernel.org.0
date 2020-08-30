Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A37256FF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgH3TDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgH3TDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:03:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0BDC061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 12:02:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so4301177ljn.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZKdmJoSrqH9H4OC01i8QEPZEiSSbw2/cpeusSfExI8=;
        b=ZebtGy+hRVgFT9b5YzuE6Bu4vNXZ9JfVwfXq203IY1zz6YVYlMvMexxdlXaFkSBZv6
         KwQJSI+DidyJLBQMT5X9+ZQQk2lN+hMsvJqMrix+kSpHpT84YlSNzU0XpkarIOTIDH3o
         +UbAAP6DgYuU9jbkhTeoKhVrlGx3TGZVmG69DEtI6fBvRfEbdzq5AnU8iNJz7mjXYmXk
         9anfz367rI51xOzKFAY9QV0NIoNUQ8p1l5BvDtrDCYp2Sz4cMmu+WQzpLQ8rIQLLQyqg
         tN2MWlFuWqye8xMtiRTjgsE6EsKO962SaCc2CplTaIXTGM7mdPFfJb+siLon+vig9e3+
         xCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZKdmJoSrqH9H4OC01i8QEPZEiSSbw2/cpeusSfExI8=;
        b=H1QdNgozmmbYp+bGog9mvwb4Sg2a/+K/RD1uwiy9jNerEjHHZFVpVzhriEb3dQ+9nq
         OjZ5BWRBZjSpVk5P31Xba1O1xAR5rX830B9Cw/adLw57R0SELvbQ1CH7TWRKz4NzfykL
         n8DODL75kHn5KtsB6tW5x4B5NHJ9T2VDFbmdWCOa0UmBI48F8ZTj7pjwygPKgx9x3OU0
         VFnfm6wlGrPbQaFIes8zY4md9bNclFwVHD/NLiegKB1f9kv9ajlg9rmQLmJ1PwDXjs0n
         mm0p0gmYwPf58lm3d484bQVksc7u0P5gMLxguDStOZ+8yxRLxhActpYiS5ESHdItxFb2
         4G0A==
X-Gm-Message-State: AOAM533JyecgjOyImSjG02c9ACX7vYF4o1c2qG6aNkRXYbTsKcKjQ1jr
        d9PuIOrEpL35W/vem/BB6d3mEwH2mPziv5ndzk8ANg==
X-Google-Smtp-Source: ABdhPJxDwSG51eX0XQLPAOc9poRQi71Xfhex04WZKJ57hw2DOl/bfc2xDE0ocUmauxuhFgUpiBBF1qmzXcAyRfmW0cI=
X-Received: by 2002:a05:651c:543:: with SMTP id q3mr3599894ljp.145.1598814177899;
 Sun, 30 Aug 2020 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200829020002.GC3265@brightrain.aerifal.cx> <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
 <20200830163657.GD3265@brightrain.aerifal.cx> <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
 <20200830184334.GE3265@brightrain.aerifal.cx>
In-Reply-To: <20200830184334.GE3265@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 30 Aug 2020 21:02:31 +0200
Message-ID: <CAG48ez3LvbWLBsJ+Edc9qCjXDYV0TRjVRrANhiR2im1aRUQ6gQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
To:     Rich Felker <dalias@libc.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 8:43 PM Rich Felker <dalias@libc.org> wrote:
> On Sun, Aug 30, 2020 at 08:31:36PM +0200, Jann Horn wrote:
> > On Sun, Aug 30, 2020 at 6:36 PM Rich Felker <dalias@libc.org> wrote:
> > > On Sun, Aug 30, 2020 at 05:05:45PM +0200, Jann Horn wrote:
> > > > On Sat, Aug 29, 2020 at 4:00 AM Rich Felker <dalias@libc.org> wrote:
> > > > > The pwrite function, originally defined by POSIX (thus the "p"), is
> > > > > defined to ignore O_APPEND and write at the offset passed as its
> > > > > argument. However, historically Linux honored O_APPEND if set and
> > > > > ignored the offset. This cannot be changed due to stability policy,
> > > > > but is documented in the man page as a bug.
> > > > >
> > > > > Now that there's a pwritev2 syscall providing a superset of the pwrite
> > > > > functionality that has a flags argument, the conforming behavior can
> > > > > be offered to userspace via a new flag.
> > [...]
> > > > Linux enforces the S_APPEND flag (set by "chattr +a") only at open()
> > > > time, not at write() time:
> > [...]
> > > > It seems to me like your patch will permit bypassing S_APPEND by
> > > > opening an append-only file with O_WRONLY|O_APPEND, then calling
> > > > pwritev2() with RWF_NOAPPEND? I think you'll have to add an extra
> > > > check for IS_APPEND() somewhere.
> > > >
> > > >
> > > > One could also argue that if an O_APPEND file descriptor is handed
> > > > across privilege boundaries, a programmer might reasonably expect that
> > > > the recipient will not be able to use the file descriptor for
> > > > non-append writes; if that is not actually true, that should probably
> > > > be noted in the open.2 manpage, at the end of the description of
> > > > O_APPEND.
> > >
> > > fcntl F_SETFL can remove O_APPEND, so it is not a security boundary.
> > > I'm not sure how this interacts with S_APPEND; presumably fcntl
> > > rechecks it.
> >
> > Ah, good point, you're right. In fs/fcntl.c:
> >
> >   35 static int setfl(int fd, struct file * filp, unsigned long arg)
> >   36 {
> >   37    struct inode * inode = file_inode(filp);
> >   38    int error = 0;
> >   39
> >   40    /*
> >   41     * O_APPEND cannot be cleared if the file is marked as append-only
> >   42     * and the file is open for write.
> >   43     */
> >   44    if (((arg ^ filp->f_flags) & O_APPEND) && IS_APPEND(inode))
> >   45            return -EPERM;
>
> FWIW I think this check is mildly wrong; it seems to disallow *adding*
> O_APPEND if the file became chattr +a after it was opened. It should
> probably be changed to only disallow removal.

Yeah...

> > > So just checking IS_APPEND in the code paths used by
> > > pwritev2 (and erroring out rather than silently writing output at the
> > > wrong place) should suffice to preserve all existing security
> > > invariants.
> >
> > Makes sense.
>
> There are 3 places where kiocb_set_rw_flags is called with flags that
> seem to be controlled by userspace: aio.c, io_uring.c, and
> read_write.c. Presumably each needs to EPERM out on RWF_NOAPPEND if
> the underlying inode is S_APPEND. To avoid repeating the same logic in
> an error-prone way, should kiocb_set_rw_flags's signature be updated
> to take the filp so that it can obtain the inode and check IS_APPEND
> before accepting RWF_NOAPPEND? It's inline so this should avoid
> actually loading anything except in the codepath where
> flags&RWF_NOAPPEND is nonzero.

You can get the file pointer from ki->ki_filp. See the RWF_NOWAIT
branch of kiocb_set_rw_flags().
