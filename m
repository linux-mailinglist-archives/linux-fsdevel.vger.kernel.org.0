Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F027372E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhEDRQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhEDRQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 13:16:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF41C061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 May 2021 10:15:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id z16so7841237pga.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 May 2021 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Ml/yIk5DGcF758QfcPDaTZzjgkM4u2jzBi6L+5FstI=;
        b=v8IR5fJT3x2UYJuE1ysgdWNDLq6e6jhdD1dtUfEL0W11yjq6QIDOF3VH3SQ+G/pNlp
         DlgwWizQbfC7H8Vu/ql4/ASBdHrBvRTcmS8Cu+I5BNvNH2G6yrE5nQsPeRoTArCE5KpG
         eMh3aSWP0NPj1D9UggorpGfavN/eBTZNofbH+MjsRo0rgeVSKrGffdSj6uDrvxquIZrj
         R6Rv7u217ckApdqsSlCJvIQ3YqTTaXBju25SCmNAXqEIo8UHxnXjaOPmgjJlS6oWk8z+
         mJfg1sqE/4lWty/TIslfcYRnBXapDY5beFTa62+F5ZbEE7B8x964YPWO0qT5gqBZZou3
         iE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Ml/yIk5DGcF758QfcPDaTZzjgkM4u2jzBi6L+5FstI=;
        b=QnbhvkUKGeil0HFCZlMYjewzLE6pAFjS+fB9IZT2kKeig8cK3sCJrEMC+int7zmgiZ
         ffpWCZoafLqqbp5vzHJKHTJw08UXTZqwzBNh79Fmrlmw3HAw0suKh1Q+avSSl2gMHWb9
         sapuN9dy5bTcnpwlp6GUGJowaUWxZYXojArcsIRJOtzF2oeRRtJiHMNQxMmSUQm1ya/r
         DJ6RqjPNz8M3D7ek1FMsr05K6HFpqS56zwaIUfRFCFbRia7V3r1cOfOKd4oMz+8i54Vy
         0SVS2Bu9zRM6qNw5hYJrehfcmhjKlPad4PgUWzbqWYbPAtrMm/kwFLpKJjL2uSCsfaON
         7vGw==
X-Gm-Message-State: AOAM532eM+Weh8eV8vQIQ6cuR6o9FjdO0RGuPuQCpbU5yjiNqHdObWS7
        XXDNg+iSLrS1+RzG3zLyIx45J4KIrlQKUg==
X-Google-Smtp-Source: ABdhPJx3EwiIEmpecTvlKxbVMrVcDSM00tzrNmWTBs+YV6NKqZBH1ZwJcT+tCFB6I7GyhNjYj70SbQ==
X-Received: by 2002:a63:ff45:: with SMTP id s5mr15607964pgk.274.1620148553592;
        Tue, 04 May 2021 10:15:53 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::e086])
        by smtp.gmail.com with ESMTPSA id v185sm8126135pfb.190.2021.05.04.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:15:52 -0700 (PDT)
Date:   Tue, 4 May 2021 10:15:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH RESEND v9 0/9] fs: interface for directly reading/writing
 compressed data
Message-ID: <YJGBR5SnnQeJdIb1@relinquished.localdomain>
References: <cover.1619463858.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619463858.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:06:03PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series adds an API for reading compressed data on a filesystem
> without decompressing it as well as support for writing compressed data
> directly to the filesystem. I have test cases (including fsstress
> support) and example programs which I'll send up once the dust settles
> [1].
> 
> The main use-case is Btrfs send/receive: currently, when sending data
> from one compressed filesystem to another, the sending side decompresses
> the data and the receiving side recompresses it before writing it out.
> This is wasteful and can be avoided if we can just send and write
> compressed extents. The patches implementing the send/receive support
> were sent with the last submission of this series [2].
> 
> Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> patch 9 adds Btrfs encoded write support.
> 
> These patches are based on Dave Sterba's Btrfs misc-next branch [3],
> which is in turn currently based on v5.12-rc8.
> 
> This is a resend of v9 [4], rebased on the latest kdave/misc-next
> branch.
> 
> Omar Sandoval (9):
>   iov_iter: add copy_struct_from_iter()
>   fs: add O_ALLOW_ENCODED open flag
>   fs: add RWF_ENCODED for reading/writing compressed data
>   btrfs: don't advance offset for compressed bios in
>     btrfs_csum_one_bio()
>   btrfs: add ram_bytes and offset to btrfs_ordered_extent
>   btrfs: support different disk extent size for delalloc
>   btrfs: optionally extend i_size in cow_file_range_inline()
>   btrfs: implement RWF_ENCODED reads
>   btrfs: implement RWF_ENCODED writes
> 
> 1: https://github.com/osandov/xfstests/tree/rwf-encoded
> 2: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
> 3: https://github.com/kdave/btrfs-devel/tree/misc-next
> 4: https://lore.kernel.org/linux-btrfs/cover.1617258892.git.osandov@fb.com/
> 
> Omar Sandoval (9):
>   iov_iter: add copy_struct_from_iter()
>   fs: add O_ALLOW_ENCODED open flag
>   fs: add RWF_ENCODED for reading/writing compressed data
>   btrfs: don't advance offset for compressed bios in
>     btrfs_csum_one_bio()
>   btrfs: add ram_bytes and offset to btrfs_ordered_extent
>   btrfs: support different disk extent size for delalloc
>   btrfs: optionally extend i_size in cow_file_range_inline()
>   btrfs: implement RWF_ENCODED reads
>   btrfs: implement RWF_ENCODED writes
> 
>  Documentation/filesystems/encoded_io.rst | 240 ++++++
>  Documentation/filesystems/index.rst      |   1 +
>  arch/alpha/include/uapi/asm/fcntl.h      |   1 +
>  arch/parisc/include/uapi/asm/fcntl.h     |   1 +
>  arch/sparc/include/uapi/asm/fcntl.h      |   1 +
>  fs/btrfs/compression.c                   |  12 +-
>  fs/btrfs/compression.h                   |   6 +-
>  fs/btrfs/ctree.h                         |   9 +-
>  fs/btrfs/delalloc-space.c                |  18 +-
>  fs/btrfs/file-item.c                     |  35 +-
>  fs/btrfs/file.c                          |  46 +-
>  fs/btrfs/inode.c                         | 929 +++++++++++++++++++++--
>  fs/btrfs/ordered-data.c                  | 124 +--
>  fs/btrfs/ordered-data.h                  |  25 +-
>  fs/btrfs/relocation.c                    |   4 +-
>  fs/fcntl.c                               |  10 +-
>  fs/namei.c                               |   4 +
>  fs/read_write.c                          | 168 +++-
>  include/linux/encoded_io.h               |  17 +
>  include/linux/fcntl.h                    |   2 +-
>  include/linux/fs.h                       |  13 +
>  include/linux/uio.h                      |   1 +
>  include/uapi/asm-generic/fcntl.h         |   4 +
>  include/uapi/linux/encoded_io.h          |  30 +
>  include/uapi/linux/fs.h                  |   5 +-
>  lib/iov_iter.c                           |  91 +++
>  26 files changed, 1563 insertions(+), 234 deletions(-)
>  create mode 100644 Documentation/filesystems/encoded_io.rst
>  create mode 100644 include/linux/encoded_io.h
>  create mode 100644 include/uapi/linux/encoded_io.h

Ping.
