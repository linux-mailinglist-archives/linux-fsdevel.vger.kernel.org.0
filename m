Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA813125727
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 23:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLRWpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 17:45:35 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:44768 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfLRWpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:45:33 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihi4I-0005B3-TV; Wed, 18 Dec 2019 22:45:23 +0000
Message-ID: <53cd123fdcb893df36e0b3bf9dddbfe08f9c545e.camel@codethink.co.uk>
Subject: Re: [PATCH v2 27/27] Documentation: document ioctl interfaces better
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
        corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 18 Dec 2019 22:45:22 +0000
In-Reply-To: <20191217221708.3730997-28-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
         <20191217221708.3730997-28-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-17 at 23:17 +0100, Arnd Bergmann wrote:
[...]
> --- /dev/null
> +++ b/Documentation/core-api/ioctl.rst
> @@ -0,0 +1,248 @@
> +======================
> +ioctl based interfaces
> +======================
> +
> +ioctl() is the most common way for applications to interface
> +with device drivers. It is flexible and easily extended by adding new
> +commands and can be passed through character devices, block devices as
> +well as sockets and other special file descriptors.
> +
> +However, it is also very easy to get ioctl command definitions wrong,
> +and hard to fix them later without breaking existing applications,
> +so this documentation tries to help developers get it right.
> +
> +Command number definitions
> +==========================
> +
> +The command number, or request number, is the second argument passed to
> +the ioctl system call. While this can be any 32-bit number that uniquely
> +identifies an action for a particular driver, there are a number of
> +conventions around defining them.
> +
> +``include/uapi/asm-generic/ioctl.h`` provides four macros for defining
> +ioctl commands that follow modern conventions: ``_IO``, ``_IOR``,
> +``_IOW``, and ``_IORW``. These should be used for all new commands,

Typo: "_IORW" should be "_IOWR".

> +with the correct parameters:
> +
> +_IO/_IOR/_IOW/_IOWR
> +   The macro name determines whether the argument is used for passing
> +   data into kernel (_IOW), from the kernel (_IOR), both (_IOWR) or is
> +   not a pointer (_IO). It is possible but not recommended to pass an
> +   integer value instead of a pointer with _IO.

I feel the explanation of _IO here could be confusing.  I think what
you meant to say was that it is possible, but not recommended, to pass
integers directly (arg is integer) rather than indirectly (arg is
pointer to integer).  I suggest the alternate wording:

The macro name specifies how the argument will be used.  It may be a
pointer to data to be passed into the kernel (_IOW), out of the kernel
(_IOR), or both (_IOWR).  The argument may also be an integer value
instead of a pointer (_IO), but this is not recommended.

> +type
> +   An 8-bit number, often a character literal, specific to a subsystem
> +   or driver, and listed in :doc:`../userspace-api/ioctl/ioctl-number`
> +
> +nr
> +  An 8-bit number identifying the specific command, unique for a give
> +  value of 'type'
> +
> +data_type
> +  The name of the data type pointed to by the argument, the command number
> +  encodes the ``sizeof(data_type)`` value in a 13-bit or 14-bit integer,
> +  leading to a limit of 8191 bytes for the maximum size of the argument.
> +  Note: do not pass sizeof(data_type) type into _IOR/IOW, as that will
> +  lead to encoding sizeof(sizeof(data_type)), i.e. sizeof(size_t).

You left out _IOWR here.  It might also be worth mentioning that _IO
doesn't have this parameter.

[...]
> +Return code
> +===========
> +
> +ioctl commands can return negative error codes as documented in errno(3),
> +these get turned into errno values in user space.

Use a semi-colon instead of a comma, or change "these" to "which".

> On success, the return
> +code should be zero. It is also possible but not recommended to return
> +a positive 'long' value.
> +
> +When the ioctl callback is called with an unknown command number, the
> +handler returns either -ENOTTY or -ENOIOCTLCMD, which also results in
> +-ENOTTY being returned from the system call. Some subsystems return
> +-ENOSYS or -EINVAL here for historic reasons, but this is wrong.
> +
> +Prior to Linux-5.5, compat_ioctl handlers were required to return

Space instead of hyphen.

> +-ENOIOCTLCMD in order to use the fallback conversion into native
> +commands. As all subsystems are now responsible for handling compat
> +mode themselves, this is no longer needed, but it may be important to
> +consider when backporting bug fixes to older kernels.
> +
> +Timestamps
> +==========
> +
> +Traditionally, timestamps and timeout values are passed as ``struct
> +timespec`` or ``struct timeval``, but these are problematic because of
> +incompatible definitions of these structures in user space after the
> +move to 64-bit time_t.
> +
> +The __kernel_timespec type can be used instead to be embedded in other

It's not a typedef, so ``struct __kernel_timespec``.

[...]
> +32-bit compat mode
> +==================
> +
> +In order to support 32-bit user space running on a 64-bit machine, each
> +subsystem or driver that implements an ioctl callback handler must also
> +implement the corresponding compat_ioctl handler.
> +
> +As long as all the rules for data structures are followed, this is as
> +easy as setting the .compat_ioctl pointer to a helper function such as
> +compat_ptr_ioctl() or blkdev_compat_ptr_ioctl().
> +
> +compat_ptr()
> +------------
> +
> +On the s/390 architecture, 31-bit user space has ambiguous representations

IBM never used the name "S/390" for the 64-bit mainframe architecture,
but they have rebranded it several times.  Rather than trying to follow
what it's called this year, maybe just write "s390" to match what we
usually call it?

[...]
> +Structure layout
> +----------------
> +
> +Compatible data structures have the same layout on all architectures,
> +avoiding all problematic members:
> +
> +* ``long`` and ``unsigned long`` are the size of a register, so
> +  they can be either 32-bit or 64-bit wide and cannot be used in portable
> +  data structures. Fixed-length replacements are ``__s32``, ``__u32``,
> +  ``__s64`` and ``__u64``.
> +
> +* Pointers have the same problem, in addition to requiring the
> +  use of compat_ptr(). The best workaround is to use ``__u64``
> +  in place of pointers, which requires a cast to ``uintptr_t`` in user
> +  space, and the use of u64_to_user_ptr() in the kernel to convert
> +  it back into a user pointer.
> +
> +* On the x86-32 (i386) architecture, the alignment of 64-bit variables
> +  is only 32-bit, but they are naturally aligned on most other
> +  architectures including x86-64. This means a structure like::
> +
> +    struct foo {
> +        __u32 a;
> +        __u64 b;
> +        __u32 c;
> +    };
> +
> +  has four bytes of padding between a and b on x86-64, plus another four
> +  bytes of padding at the end, but no padding on i386, and it needs a
> +  compat_ioctl conversion handler to translate between the two formats.
> +
> +  To avoid this problem, all structures should have their members
> +  naturally aligned, or explicit reserved fields added in place of the
> +  implicit padding.

This should explain how to check that - presumably by running pahole on
some sensible architecture.

> +* On ARM OABI user space, 16-bit member variables have 32-bit
> +  alignment, making them incompatible with modern EABI kernels.

I thought that OABI required structures as a whole to have alignment of
4, not individual members?  Which obviously does affect small
structures as members of other structures.

[...]
> +Information leaks
> +=================
> +
> +Uninitialized data must not be copied back to user space, as this can
> +cause an information leak, which can be used to defeat kernel address
> +space layout randomization (KASLR), helping in an attack.
> +
> +As explained for the compat mode, it is best to not avoid any implicit

Delete "not".

> +padding in data structures, but if there is already padding in existing
> +structures, the kernel driver must be careful to zero out the padding
> +using memset() or similar before copying it to user space.

This sentence is rather too long.  Also it can be read as suggesting
that one should somehow identify and memset() the padding just before
copying to user-space.  I suggest an alternate wording:

For this reason (and for compat support) it is best to avoid any
implicit padding in data structures.  Where there is implicit padding
in an existing structure, kernel drivers must be careful to fully
initialize an instance of the structure before copying it to user
space.  This is usually done by calling memset() before assigning to
individual members.

[...]
> +Alternatives to ioctl
> +=====================
[...]
> +* A custom file system can provide extra flexibility with a simple
> +  user interface but add a lot of complexity to the implementation.

Typo: "add" should be "adds".

Anyway, it's great to have documentation for this all in one place.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

