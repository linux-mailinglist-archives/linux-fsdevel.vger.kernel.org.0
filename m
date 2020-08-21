Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22F24D0BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHUIsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUIsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:48:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF85C061385;
        Fri, 21 Aug 2020 01:48:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so973461iod.12;
        Fri, 21 Aug 2020 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wj6tNb8MQ+uzd2xcElvqANcy2YGwYQy9Y2WV55I0uYo=;
        b=qVAK6qY1jf7p/9TYvT2qpp3U6sBiDfZ6nbXQaIQKRnqpk8uYSBeuytlf4OnPvzIwik
         4JS/MK3xnCq6TmKCp8nRSx9NDI2FKjqh7DuenpM6GHtTGQLVwSFE/zlphwYiCGRKqJlT
         71DtJD7g0MIETL2l5ZfxJOGO+1IpHN9YHUD7W3aAqIUNQ4iPUqBJF1xEx0/H9UUrkNyu
         bzqEDp2ZFW8WgtFd1DBLU0QdY1n5on4nuTAKxc7wkXcAnSh5AZDtXqWNLDMzdohlvROy
         hP0QuHBr36OatbeYMvjHZ5a2whAYOSFdRzl7Jkf4tAiHM/As/EuYffepy+VK4/NwCMqL
         5LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wj6tNb8MQ+uzd2xcElvqANcy2YGwYQy9Y2WV55I0uYo=;
        b=L69OG1olOZ0wTJOvi2ehXNXM2WmOVaStjwZnBQIZegjO9aNge++9y5nsvNbxjBrc5u
         NnPJuRGvYcfD1PQAsWZvgTtmjz3ln7gZdWj4uAReAXeUiBbd5qOFRe5LY8ZPAYH15YJ4
         oI/um3vFF34tvr/GZv5o0pmTyqdHd1M4H/vs0xQT4AucgUW84ylFLHCvbar87A3oyLyf
         oVb4/2MjKvc9INMAKgsU3xdedlmO+hKV8H7Vn2gg33UnhEatPhPD/zBIfoiQEPtFm8K8
         PXdmfAjZa6aiWzURHwn8l8bm6STlQ/zOIMAAyOsDeEUJS9qUcXE6OE95FHUWlR8Z5XgK
         uJDQ==
X-Gm-Message-State: AOAM530YzHRiSBPmQKqJriAy/Wi7zwv5wkUqK8cqZ0yxyjTOjwEF3D3L
        KeMh4hryh8GkB2pzmXYlN6fM2Z3vZ7cdsjinRZI=
X-Google-Smtp-Source: ABdhPJxHUqhMsZxtSDrWWscVGlYtVkca+kgAtqvi6tmLtrLoNOYtsApmRmHHtZrm2Uj2wTLwnuVfogBmE/JlQtkcYpI=
X-Received: by 2002:a05:6602:1405:: with SMTP id t5mr1627205iov.72.1597999685260;
 Fri, 21 Aug 2020 01:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597993855.git.osandov@osandov.com> <9020a583581b644ae86b7c05de6a39fd5204f06d.1597993855.git.osandov@osandov.com>
In-Reply-To: <9020a583581b644ae86b7c05de6a39fd5204f06d.1597993855.git.osandov@osandov.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Aug 2020 11:47:54 +0300
Message-ID: <CAOQ4uxi=QcV-Rg=bSpYGid24Qp4zOgjKuOH2E5QA+OMrA-EsLQ@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 10:38 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Btrfs supports transparent compression: data written by the user can be
> compressed when written to disk and decompressed when read back.
> However, we'd like to add an interface to write pre-compressed data
> directly to the filesystem, and the matching interface to read
> compressed data without decompressing it. This adds support for
> so-called "encoded I/O" via preadv2() and pwritev2().
>
> A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> this flag is set, iov[0].iov_base points to a struct encoded_iov which
> is used for metadata: namely, the compression algorithm, unencoded
> (i.e., decompressed) length, and what subrange of the unencoded data
> should be used (needed for truncated or hole-punched extents and when
> reading in the middle of an extent). For reads, the filesystem returns
> this information; for writes, the caller provides it to the filesystem.
> iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> used to extend the interface in the future a la copy_struct_from_user().
> The remaining iovecs contain the encoded extent.
>
> This adds the VFS helpers for supporting encoded I/O and documentation
> for filesystem support.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  Documentation/filesystems/encoded_io.rst |  74 ++++++++++
>  Documentation/filesystems/index.rst      |   1 +
>  include/linux/fs.h                       |  16 +++
>  include/uapi/linux/fs.h                  |  33 ++++-
>  mm/filemap.c                             | 166 +++++++++++++++++++++--
>  5 files changed, 276 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/filesystems/encoded_io.rst
>
> diff --git a/Documentation/filesystems/encoded_io.rst b/Documentation/filesystems/encoded_io.rst
> new file mode 100644
> index 000000000000..50405276d866
> --- /dev/null
> +++ b/Documentation/filesystems/encoded_io.rst
> @@ -0,0 +1,74 @@
> +===========
> +Encoded I/O
> +===========
> +
> +Encoded I/O is a mechanism for reading and writing encoded (e.g., compressed
> +and/or encrypted) data directly from/to the filesystem. The userspace interface
> +is thoroughly described in the :manpage:`encoded_io(7)` man page; this document
> +describes the requirements for filesystem support.
> +
> +First of all, a filesystem supporting encoded I/O must indicate this by setting
> +the ``FMODE_ENCODED_IO`` flag in its ``file_open`` file operation::
> +
> +    static int foo_file_open(struct inode *inode, struct file *filp)
> +    {
> +            ...
> +            filep->f_mode |= FMODE_ENCODED_IO;
> +            ...
> +    }
> +
> +Encoded I/O goes through ``read_iter`` and ``write_iter``, designated by the
> +``IOCB_ENCODED`` flag in ``kiocb->ki_flags``.
> +
> +Reads
> +=====
> +
> +Encoded ``read_iter`` should:
> +
> +1. Call ``generic_encoded_read_checks()`` to validate the file and buffers
> +   provided by userspace.
> +2. Initialize the ``encoded_iov`` appropriately.
> +3. Copy it to the user with ``copy_encoded_iov_to_iter()``.
> +4. Copy the encoded data to the user.
> +5. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> +6. Return the size of the encoded data read, not including the ``encoded_iov``.
> +
> +There are a few details to be aware of:
> +
> +* Encoded ``read_iter`` should support reading unencoded data if the extent is
> +  not encoded.
> +* If the buffers provided by the user are not large enough to contain an entire
> +  encoded extent, then ``read_iter`` should return ``-ENOBUFS``. This is to
> +  avoid confusing userspace with truncated data that cannot be properly
> +  decoded.
> +* Reads in the middle of an encoded extent can be returned by setting
> +  ``encoded_iov->unencoded_offset`` to non-zero.
> +* Truncated unencoded data (e.g., because the file does not end on a block
> +  boundary) may be returned by setting ``encoded_iov->len`` to a value smaller
> +  value than ``encoded_iov->unencoded_len - encoded_iov->unencoded_offset``.
> +
> +Writes
> +======
> +
> +Encoded ``write_iter`` should (in addition to the usual accounting/checks done
> +by ``write_iter``):
> +
> +1. Call ``copy_encoded_iov_from_iter()`` to get and validate the
> +   ``encoded_iov``.
> +2. Call ``generic_encoded_write_checks()`` instead of
> +   ``generic_write_checks()``.
> +3. Check that the provided encoding in ``encoded_iov`` is supported.
> +4. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> +5. Return the size of the encoded data written.
> +
> +Again, there are a few details:
> +
> +* Encoded ``write_iter`` doesn't need to support writing unencoded data.
> +* ``write_iter`` should either write all of the encoded data or none of it; it
> +  must not do partial writes.
> +* ``write_iter`` doesn't need to validate the encoded data; a subsequent read
> +  may return, e.g., ``-EIO`` if the data is not valid.
> +* The user may lie about the unencoded size of the data; a subsequent read
> +  should truncate or zero-extend the unencoded data rather than returning an
> +  error.
> +* Be careful of page cache coherency.

Haha that rings in my head like the "Smoking kills!" warnings...

I find it a bit odd that you mix page cache at all when reading
unencoded extents.
Feels like a file with FMODE_ENCODED_IO should stick to direct IO in all cases.
I don't know how btrfs deals with mixing direct IO and page cache IO normally,
but surely the rules could be made even stricter for an inode accessed with this
new API?

Is there something I am misunderstanding?

Thanks,
Amir.
