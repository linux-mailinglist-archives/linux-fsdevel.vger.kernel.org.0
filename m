Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C747251424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHYIZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgHYIZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:25:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EBC061574;
        Tue, 25 Aug 2020 01:25:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so2269719iop.13;
        Tue, 25 Aug 2020 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJ/LR4qMx00hGSLfoeaJRDPWjskXNla6H/yFj2rArUM=;
        b=hvQBJRIHHRWicS4maCvOJT+dS0XPa/SgUHCTy5k1iO3EDYu1e3v8eEkLoZIFK0GGrq
         1uBQZL/HTbPW5o97QMkIoz7Ut3nppenZM362H7vJBHHpCwfnR1bR5mRlfWKll8tXjLtD
         N56KBOQHGuPAaJAhmTyJZbhzhJinxi+WMvXafNBh2L0klkuumLHnKGwAXp0xHDZUD+DX
         dhWgt0DO44OlpI3XnQQd4IDJHEpQsmIUHG5vRPSuCNAcjPF51O5C8tO3JPAFJCcrb2Xc
         /HbxN2p/gv7GfaAddoxbI6yLmyiwPDDim0Qxqp4I1V3HDWyfxTMrZtRiHJkjbN4NKnCX
         i5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJ/LR4qMx00hGSLfoeaJRDPWjskXNla6H/yFj2rArUM=;
        b=XI5jfUNdzpn4uA8Flm9BxoBSgn91gzyiYpho1zdUYmvqOQROLLIptu6vW0b8nIycmD
         fSDt3mVQs7q/5F/Am2vw5QlTU+gPCJpt25b+Gtoyof9pYN95iNvvzI9cRDGpTwya1y/T
         5nKWvOLAGVLG/ClW+0kZL1iG7pDg3oSW89QZeqiuc6rfzO7XRD3ZUYNUsXzpGdlOhzWi
         uwBQ2cXLjGhWhdLwty/bD3zEPSBWv6v3+Ez4kMrNn3frXCc/tLGLsottZ1rEn4MPIixy
         8Zb+7wd6bsrWEYwspl8q2z3JOFRNJFHGT7ETcO0+NZH/cRdBME0/RG6jZvYv7K4zmd5L
         +smw==
X-Gm-Message-State: AOAM532YoYQ9WLa/Ona4HwftYR7iaEBmSaQaRtEnXGdjMK4YHIYRReOt
        /agcyfExGbK2knWnGFEKckqzd6NAgCS2GX8G0To=
X-Google-Smtp-Source: ABdhPJzZnWiYV7v06E1+iBPLvYsLAKTDeVRUxo/cuk1EqnX4itnv70NikJmR4Z9vjRNFI+99vwaDOJ/Lvx89TntDuDA=
X-Received: by 2002:a02:3f2d:: with SMTP id d45mr827548jaa.120.1598343916762;
 Tue, 25 Aug 2020 01:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597993855.git.osandov@osandov.com> <9020a583581b644ae86b7c05de6a39fd5204f06d.1597993855.git.osandov@osandov.com>
 <CAOQ4uxi=QcV-Rg=bSpYGid24Qp4zOgjKuOH2E5QA+OMrA-EsLQ@mail.gmail.com> <20200824234903.GA202819@exodia.localdomain>
In-Reply-To: <20200824234903.GA202819@exodia.localdomain>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 25 Aug 2020 11:25:05 +0300
Message-ID: <CAOQ4uxgXUvDSV_4V8R6ivbbSOdh8J4GhvrHqys77E_PgHtAoWg@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] fs: add RWF_ENCODED for reading/writing compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 2:49 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Fri, Aug 21, 2020 at 11:47:54AM +0300, Amir Goldstein wrote:
> > On Fri, Aug 21, 2020 at 10:38 AM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > Btrfs supports transparent compression: data written by the user can be
> > > compressed when written to disk and decompressed when read back.
> > > However, we'd like to add an interface to write pre-compressed data
> > > directly to the filesystem, and the matching interface to read
> > > compressed data without decompressing it. This adds support for
> > > so-called "encoded I/O" via preadv2() and pwritev2().
> > >
> > > A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> > > this flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > is used for metadata: namely, the compression algorithm, unencoded
> > > (i.e., decompressed) length, and what subrange of the unencoded data
> > > should be used (needed for truncated or hole-punched extents and when
> > > reading in the middle of an extent). For reads, the filesystem returns
> > > this information; for writes, the caller provides it to the filesystem.
> > > iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> > > used to extend the interface in the future a la copy_struct_from_user().
> > > The remaining iovecs contain the encoded extent.
> > >
> > > This adds the VFS helpers for supporting encoded I/O and documentation
> > > for filesystem support.
> > >
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  Documentation/filesystems/encoded_io.rst |  74 ++++++++++
> > >  Documentation/filesystems/index.rst      |   1 +
> > >  include/linux/fs.h                       |  16 +++
> > >  include/uapi/linux/fs.h                  |  33 ++++-
> > >  mm/filemap.c                             | 166 +++++++++++++++++++++--
> > >  5 files changed, 276 insertions(+), 14 deletions(-)
> > >  create mode 100644 Documentation/filesystems/encoded_io.rst
> > >
> > > diff --git a/Documentation/filesystems/encoded_io.rst b/Documentation/filesystems/encoded_io.rst
> > > new file mode 100644
> > > index 000000000000..50405276d866
> > > --- /dev/null
> > > +++ b/Documentation/filesystems/encoded_io.rst
> > > @@ -0,0 +1,74 @@
> > > +===========
> > > +Encoded I/O
> > > +===========
> > > +
> > > +Encoded I/O is a mechanism for reading and writing encoded (e.g., compressed
> > > +and/or encrypted) data directly from/to the filesystem. The userspace interface
> > > +is thoroughly described in the :manpage:`encoded_io(7)` man page; this document
> > > +describes the requirements for filesystem support.
> > > +
> > > +First of all, a filesystem supporting encoded I/O must indicate this by setting
> > > +the ``FMODE_ENCODED_IO`` flag in its ``file_open`` file operation::
> > > +
> > > +    static int foo_file_open(struct inode *inode, struct file *filp)
> > > +    {
> > > +            ...
> > > +            filep->f_mode |= FMODE_ENCODED_IO;
> > > +            ...
> > > +    }
> > > +
> > > +Encoded I/O goes through ``read_iter`` and ``write_iter``, designated by the
> > > +``IOCB_ENCODED`` flag in ``kiocb->ki_flags``.
> > > +
> > > +Reads
> > > +=====
> > > +
> > > +Encoded ``read_iter`` should:
> > > +
> > > +1. Call ``generic_encoded_read_checks()`` to validate the file and buffers
> > > +   provided by userspace.
> > > +2. Initialize the ``encoded_iov`` appropriately.
> > > +3. Copy it to the user with ``copy_encoded_iov_to_iter()``.
> > > +4. Copy the encoded data to the user.
> > > +5. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> > > +6. Return the size of the encoded data read, not including the ``encoded_iov``.
> > > +
> > > +There are a few details to be aware of:
> > > +
> > > +* Encoded ``read_iter`` should support reading unencoded data if the extent is
> > > +  not encoded.
> > > +* If the buffers provided by the user are not large enough to contain an entire
> > > +  encoded extent, then ``read_iter`` should return ``-ENOBUFS``. This is to
> > > +  avoid confusing userspace with truncated data that cannot be properly
> > > +  decoded.
> > > +* Reads in the middle of an encoded extent can be returned by setting
> > > +  ``encoded_iov->unencoded_offset`` to non-zero.
> > > +* Truncated unencoded data (e.g., because the file does not end on a block
> > > +  boundary) may be returned by setting ``encoded_iov->len`` to a value smaller
> > > +  value than ``encoded_iov->unencoded_len - encoded_iov->unencoded_offset``.
> > > +
> > > +Writes
> > > +======
> > > +
> > > +Encoded ``write_iter`` should (in addition to the usual accounting/checks done
> > > +by ``write_iter``):
> > > +
> > > +1. Call ``copy_encoded_iov_from_iter()`` to get and validate the
> > > +   ``encoded_iov``.
> > > +2. Call ``generic_encoded_write_checks()`` instead of
> > > +   ``generic_write_checks()``.
> > > +3. Check that the provided encoding in ``encoded_iov`` is supported.
> > > +4. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> > > +5. Return the size of the encoded data written.
> > > +
> > > +Again, there are a few details:
> > > +
> > > +* Encoded ``write_iter`` doesn't need to support writing unencoded data.
> > > +* ``write_iter`` should either write all of the encoded data or none of it; it
> > > +  must not do partial writes.
> > > +* ``write_iter`` doesn't need to validate the encoded data; a subsequent read
> > > +  may return, e.g., ``-EIO`` if the data is not valid.
> > > +* The user may lie about the unencoded size of the data; a subsequent read
> > > +  should truncate or zero-extend the unencoded data rather than returning an
> > > +  error.
> > > +* Be careful of page cache coherency.
> >
> > Haha that rings in my head like the "Smoking kills!" warnings...
> >
> > I find it a bit odd that you mix page cache at all when reading
> > unencoded extents.
> > Feels like a file with FMODE_ENCODED_IO should stick to direct IO in all cases.
> > I don't know how btrfs deals with mixing direct IO and page cache IO normally,
> > but surely the rules could be made even stricter for an inode accessed with this
> > new API?
> >
> > Is there something I am misunderstanding?
> >
> > Thanks,
> > Amir.
>
> I'm not completely following here, are you suggesting that if a file is
> open with O_ALLOW_ENCODED, buffered I/O to that file should return an
> error?

No. I don't.

> Btrfs at least does the necessary range locking and page cache
> invalidation to ensure that direct I/O gets along with buffered I/O (and
> now encoded I/O).

That's a good start :-)

I saw btrfs_encoded_read_regular_fill_pages() and concluded that even
in FMODE_ENCODED_IO, when reading an unencoded extent, you fill
page cache with the unencoded data.

Is that correct? or did I miss read the code?
If correct, does it serve any purpose?
Seems more sensible to me to read/write FMODE_ENCODED_IO only in direct io
regardless if the extent is encoded or not (for simpler code if nothing else).

Thanks,
Amir.
