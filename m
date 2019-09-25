Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC507BD8CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442524AbfIYHLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 03:11:39 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50015 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442450AbfIYHLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:11:38 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0F58E43E145;
        Wed, 25 Sep 2019 17:11:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iD1ST-0000d6-DP; Wed, 25 Sep 2019 17:11:29 +1000
Date:   Wed, 25 Sep 2019 17:11:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jann Horn <jannh@google.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190925071129.GB804@dread.disaster.area>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=-uoBkjAQAAAA:8 a=7-415B0cAAAA:8 a=4zo7HAFyputdoMmBiIYA:9
        a=CjuIK1q_8ugA:10 a=y0wLjPFBLyexm0soFTcm:22 a=biEYGPWJfzWAr4FL6Ov7:22
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

Where's the privilege boundary that is being crossed?

We're talking about user data read/write access here, not some
special security capability. Access to the data has already been
permission checked, so why should the format that the data is
supplied to the kernel in suddenly require new privilege checks?

i.e. writing encoded data to a file requires exactly the same
access permissions as writing cleartext data to the file. The only
extra information here is whether the _filesystem_ supports encoded
data, and that doesn't change regardless of what the open file gets
passed to. Hence the capability is either there or it isn't, it
doesn't transform not matter what privilege boundary the file is
passed across. Similarly, we have permission to access the data
or we don't through the struct file, it doesn't transform either.

Hence I don't see why CAP_SYS_ADMIN or any special permissions are
needed for an application with access permissions to file data to
use these RWF_ENCODED IO interfaces. I am inclined to think the
permission check here is wrong and should be dropped, and then all
these issues go away.

Yes, the app that is going to use this needs root perms because it
accesses all data in the fs (it's a backup app!), but that doesn't
mean you can only use RWF_ENCODED if you have root perms.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
