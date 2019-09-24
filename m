Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B53BD37A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbfIXUWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:22:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39027 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392177AbfIXUWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:22:37 -0400
Received: from lmontsouris-656-1-55-152.w80-15.abo.wanadoo.fr ([80.15.152.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCrKQ-0001E2-Pq; Tue, 24 Sep 2019 20:22:31 +0000
Date:   Tue, 24 Sep 2019 22:22:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190924202229.mjvjigpnrskjtk5n@wittgenstein>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:01:41PM +0200, Jann Horn wrote:
> On Tue, Sep 24, 2019 at 9:35 PM Omar Sandoval <osandov@osandov.com> wrote:
> > On Tue, Sep 24, 2019 at 10:15:13AM -0700, Omar Sandoval wrote:
> > > On Thu, Sep 19, 2019 at 05:44:12PM +0200, Jann Horn wrote:
> > > > On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > > > Btrfs can transparently compress data written by the user. However, we'd
> > > > > like to add an interface to write pre-compressed data directly to the
> > > > > filesystem. This adds support for so-called "encoded writes" via
> > > > > pwritev2().
> > > > >
> > > > > A new RWF_ENCODED flags indicates that a write is "encoded". If this
> > > > > flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > > > contains metadata about the write: namely, the compression algorithm and
> > > > > the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> > > > > must be set to sizeof(struct encoded_iov), which can be used to extend
> > > > > the interface in the future. The remaining iovecs contain the encoded
> > > > > extent.
> > > > >
> > > > > A similar interface for reading encoded data can be added to preadv2()
> > > > > in the future.
> > > > >
> > > > > Filesystems must indicate that they support encoded writes by setting
> > > > > FMODE_ENCODED_IO in ->file_open().
> > > > [...]
> > > > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > > > > +                        struct iov_iter *from)
> > > > > +{
> > > > > +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > > > > +               return -EINVAL;
> > > > > +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > > > > +               return -EFAULT;
> > > > > +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > > > > +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> > > > > +               iocb->ki_flags &= ~IOCB_ENCODED;
> > > > > +               return 0;
> > > > > +       }
> > > > > +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > > > +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > > > +               return -EINVAL;
> > > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > > +               return -EPERM;
> > > >
> > > > How does this capable() check interact with io_uring? Without having
> > > > looked at this in detail, I suspect that when an encoded write is
> > > > requested through io_uring, the capable() check might be executed on
> > > > something like a workqueue worker thread, which is probably running
> > > > with a full capability set.
> > >
> > > I discussed this more with Jens. You're right, per-IO permission checks
> > > aren't going to work. In fully-polled mode, we never get an opportunity
> > > to check capabilities in right context. So, this will probably require a
> > > new open flag.
> >
> > Actually, file_ns_capable() accomplishes the same thing without a new
> > open flag. Changing the capable() check to file_ns_capable() in
> > init_user_ns should be enough.
> 
> +Aleksa for openat2() and open() space
> 
> Mmh... but if the file descriptor has been passed through a privilege
> boundary, it isn't really clear whether the original opener of the
> file intended for this to be possible. For example, if (as a
> hypothetical example) the init process opens a service's logfile with
> root privileges, then passes the file descriptor to that logfile to
> the service on execve(), that doesn't mean that the service should be
> able to perform compressed writes into that file, I think.

I think we should even generalize this: for most new properties a given
file descriptor can carry we would want it to be explicitly enabled such
that passing the fd around amounts to passing that property around. At
least as soon as we consider it to be associated with some privilege
boundary. I don't think we have done this generally. But I would very
much support moving to such a model.

Christian
