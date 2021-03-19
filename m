Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423C43426D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCSU1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 16:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhCSU13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:27:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F70C061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 13:27:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 11so6692195pfn.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V13lk3KZ4iasjlUPDjmaKCyEvLnNohjw758mwN5joyg=;
        b=hkBcidN2JYzeU1iCx0Me7G9Xkc/fJgmvSUbbkjcVucWOm3jai8aUv0/AkkvNbhpZlZ
         i7hENidkGQbn+TdHc8izE11aZ7WLXwVWDiEJx4jPnH4NAVcR8NrC8JVpFTf3PAOVsdUB
         oVOLvFvP92KyzqjRS2B80ihKJ2Jkcfv0Ge7NElOU9NyZwaNrVZ9UfPAH30UyL7Z8ew+1
         QOojjSU3usyBvW/WEHghUcbTKR1xwTXr3CVIyYAqLR81HIcM8DnKWG3LfzU5ha+eR627
         owyOZT2Yh6Be0qKTHCnChIJI/41/piDn+DdfJ3esMveeYcURPAbk0R0GjMFtq+gouNuG
         ftlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V13lk3KZ4iasjlUPDjmaKCyEvLnNohjw758mwN5joyg=;
        b=ueWnUPdnkn3JQZ7UWfjE/t2wkZYoPjs+NLP5k/dU8nxYxHrzcW3r8LGwF0mDt1J4H+
         fmnZkoGt1/O5ytBcRfYANmSh1V8iPboulPLxDcUF6aC54U6UrvQzJU24VANlpD4JtBYc
         HTM2zB87SwtvPZUoV0CFQgxrNGnpR1JSF+poNlxItDbs/1Sbvj37uZOSTnjySfqPYZ8m
         +9HVZwpzHtxfV9R5fCjNy7+zRa1vqaaCZyaZNIdZdg4W+45CARII/ee5Gt70WdMhO6CE
         U9eAWOXx+ml/z7/kLLlbnGLLY9vXV4snPI1NofuGhNPDERvMeO4jFOTPR/8hloYHr4LK
         Uhxw==
X-Gm-Message-State: AOAM5324UUGGX03JxA2nU5JTZeIFyt9HAJYQNikmrGDnIlrgKd9jTKer
        LcBrqr7YBNNrwQkrJFdsluKFog==
X-Google-Smtp-Source: ABdhPJxaGrX6bVUzfAeVenlSr7ZeN6B5IebT9XVBEIOa/9LqM/yvxRWaQhGlF6z1lLMM+x5yELdsUg==
X-Received: by 2002:a62:207:0:b029:1ff:d7e0:482b with SMTP id 7-20020a6202070000b02901ffd7e0482bmr10891807pfc.12.1616185648238;
        Fri, 19 Mar 2021 13:27:28 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9ec6])
        by smtp.gmail.com with ESMTPSA id z22sm6039806pfa.41.2021.03.19.13.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:27:27 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:27:25 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <YFUJLUnXnsv9X/vN@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 01:08:05PM -0700, Linus Torvalds wrote:
> On Fri, Mar 19, 2021 at 11:21 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Can we get some movement on this?  Omar is sort of spinning his wheels here
> > trying to get this stuff merged, no major changes have been done in a few
> > postings.
> 
> I'm not Al, and I absolutely detest the IOCB_ENCODED thing, and want
> more explanations of why this should be done that way, and pollute our
> iov_iter handling EVEN MORE.
> 
> Our iov_iter stuff isn't the most legible, and I don't understand why
> anybody would ever think it's a good idea to spread what is clearly a
> "struct" inside multiple different iov extents.
> 
> Honestly, this sounds way more like an ioctl interface than
> read/write. We've done that before.

As Josef just mentioned, I started with an ioctl, and Dave Chinner
suggested doing it this way:
https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/

The nice thing about it is that it sidesteps all of the issues we had
with the dedupe/reflink ioctls over the years where permissions checks
and the like were slightly different from read/write.

> But if it has to be done with an iov_iter, is there *any* reason to
> not make it be a hard rule that iov[0] should not be the entirely of
> the struct, and the code shouldn't ever need to iterate?

For RWF_ENCODED, iov[0] is always used as the entirety of the struct. I
made the helper more generic to support other use cases, but if that's
the main objection I can easily make it specifically use iov[0].

> Also I see references to the man-page, but honestly, that's not how
> the kernel UAPI should be defined ("just read the man-page"), plus I
> refuse to live in the 70's, and consider troff to be an atrocious
> format.

No disagreement here, troff is horrible to read.

> So make the UAPI explanation for this horror be in a legible format
> that is actually part of the kernel so that I can read what the intent
> is, instead of having to decode hieroglypics.

I didn't want to document the UAPI in two places that would need to be
kept in sync, but this is fair enough. I'll add UAPI documentation to
the kernel. In the meantime, for anyone else following along, here's the
formatted man page:

ENCODED_IO(7)          Linux Programmer's Manual         ENCODED_IO(7)

NAME
       encoded_io - overview of encoded I/O

DESCRIPTION
       Several  filesystems (e.g., Btrfs) support transparent encoding
       (e.g., compression, encryption) of data on disk:  written  data
       is encoded by the kernel before it is written to disk, and read
       data is decoded before being returned to  the  user.   In  some
       cases,  it  is useful to skip this encoding step.  For example,
       the user may want to read the compressed contents of a file  or
       write pre-compressed data directly to a file.  This is referred
       to as "encoded I/O".

   Encoded I/O API
       Encoded  I/O  is  specified  with  the  RWF_ENCODED   flag   to
       preadv2(2)  and pwritev2(2).  If RWF_ENCODED is specified, then
       iov[0].iov_base points to an encoded_iov structure, defined  in
       <linux/fs.h> as:

           struct encoded_iov {
               __aligned_u64 len;
               __aligned_u64 unencoded_len;
               __aligned_u64 unencoded_offset;
               __u32 compression;
               __u32 encryption;
           };

       This  may  be extended in the future, so iov[0].iov_len must be
       set to sizeof(struct encoded_iov) for forward/backward compati‐
       bility.  The remaining buffers contain the encoded data.

       compression  and  encryption are the encoding fields.  compres‐
       sion is ENCODED_IOV_COMPRESSION_NONE (zero)  or  a  filesystem-
       specific  ENCODED_IOV_COMPRESSION_*  constant;  see  Filesystem
       support below.  encryption is currently always  ENCODED_IOV_EN‐
       CRYPTION_NONE (zero).

       unencoded_len  is  the length of the unencoded (i.e., decrypted
       and decompressed) data.  unencoded_offset is  the  offset  from
       the first byte of the unencoded data to the first byte of logi‐
       cal data in the file (less than  or  equal  to  unencoded_len).
       len  is  the length of the data in the file (less than or equal
       to unencoded_len - unencoded_offset).  See Extent layout  below
       for some examples.

       If  the  unencoded  data is actually longer than unencoded_len,
       then it is truncated; if it is shorter,  then  it  is  extended
       with zeroes.

       pwritev2(2)  uses  the metadata specified in iov[0], writes the
       encoded data from the remaining buffers, and returns the number
       of  encoded  bytes  written (that is, the sum of iov[n].iov_len
       for 1 <= n < iovcnt; partial writes will not occur).  At  least
       one  encoding  field  must  be non-zero.  Note that the encoded
       data is not validated when it is written; if it  is  not  valid
       (e.g.,  it  cannot be decompressed), then a subsequent read may
       return an error.  If the offset argument to pwritev2(2) is  -1,
       then  the file offset is incremented by len.  If iov[0].iov_len
       is less than sizeof(struct encoded_iov) in the kernel, then any
       fields  unknown to user space are treated as if they were zero;
       if it is greater and any fields unknown to the kernel are  non-
       zero, then this returns -1 and sets errno to E2BIG.

       preadv2(2)  populates  the metadata in iov[0], the encoded data
       in the remaining buffers, and returns  the  number  of  encoded
       bytes  read.   This will only return one extent per call.  This
       can also read data which is not encoded;  all  encoding  fields
       will  be  zero  in  that  case.   If  the  offset  argument  to
       preadv2(2) is -1, then the file offset is incremented  by  len.
       If  iov[0].iov_len  is  less than sizeof(struct encoded_iov) in
       the kernel and any fields unknown to user space  are  non-zero,
       then  preadv2(2)  returns  -1 and sets errno to E2BIG; if it is
       greater, then any fields unknown to the kernel are returned  as
       zero.   If  the provided buffers are not large enough to return
       an entire encoded extent, then preadv2(2) returns -1  and  sets
       errno to ENOBUFS.

       As  the  filesystem page cache typically contains decoded data,
       encoded I/O bypasses the page cache.

   Extent layout
       By using len, unencoded_len, and unencoded_offset, it is possi‐
       ble to refer to a subset of an unencoded extent.

       In  the  simplest case, len is equal to unencoded_len and unen‐
       coded_offset is zero.  This means that the entire unencoded ex‐
       tent is used.

       However,  suppose we read 50 bytes into a file which contains a
       single compressed extent.  The filesystem must still return the
       entire compressed extent for us to be able to decompress it, so
       unencoded_len would be the length of  the  entire  decompressed
       extent.   However, because the read was at offset 50, the first
       50 bytes should be ignored.  Therefore, unencoded_offset  would
       be 50, and len would accordingly be unencoded_len - 50.

       Additionally,  suppose we want to create an encrypted file with
       length 500, but the file is encrypted with a block cipher using
       a  block  size of 4096.  The unencoded data would therefore in‐
       clude the appropriate padding, and unencoded_len would be 4096.
       However,  to  represent the logical size of the file, len would
       be 500 (and unencoded_offset would be 0).

       Similar situations can arise in other cases:

       *  If the filesystem pads data to the filesystem block size be‐
          fore  compressing,  then  compressed  files  with a size un‐
          aligned to the filesystem block size will end with an extent
          with len < unencoded_len.

       *  Extents  cloned  from  the middle of a larger encoded extent
          with  FICLONERANGE  may  have  a  non-zero  unencoded_offset
          and/or len < unencoded_len.

       *  If  the  middle  of  an  encoded  extent is overwritten, the
          filesystem may create extents with a non-zero unencoded_off‐
          set  and/or  len < unencoded_len for the parts that were not
          overwritten.

   Security
       Encoded I/O creates the potential for some security issues:

       *  Encoded writes allow writing arbitrary data which the kernel
          will  decode on a subsequent read.  Decompression algorithms
          are complex and may have bugs which can be exploited by  ma‐
          liciously crafted data.

       *  Encoded reads may return data which is not logically present
          in the file (see the  discussion  of  len  vs  unencoded_len
          above).   It  may  not be intended for this data to be read‐
          able.

       Therefore, encoded I/O requires privilege.  Namely, the RWF_EN‐
       CODED  flag  may  only  be used if the file description has the
       O_ALLOW_ENCODED file status flag set, and  the  O_ALLOW_ENCODED
       flag  may  only be set by a thread with the CAP_SYS_ADMIN capa‐
       bility.  The O_ALLOW_ENCODED flag can be set by open(2) or  fc‐
       ntl(2).   It  can also be cleared by fcntl(2); clearing it does
       not require CAP_SYS_ADMIN.  Note that  it  is  not  cleared  on
       fork(2) or execve(2).  One may wish to use O_CLOEXEC with O_AL‐
       LOW_ENCODED.

   Filesystem support
       Encoded I/O is supported on the following filesystems:

       Btrfs (since Linux 5.13)

              Btrfs supports encoded reads and  writes  of  compressed
              data.  The data is encoded as follows:

              *  If compression is ENCODED_IOV_COMPRESSION_BTRFS_ZLIB,
                 then the encoded data is a single zlib stream.

              *  If compression is ENCODED_IOV_COMPRESSION_BTRFS_ZSTD,
                 then  the  encoded  data  is a single zstd frame com‐
                 pressed with the windowLog compression parameter  set
                 to no more than 17.

              *  If   compression   is   one  of  ENCODED_IOV_COMPRES‐
                 SION_BTRFS_LZO_4K,               ENCODED_IOV_COMPRES‐
                 SION_BTRFS_LZO_8K,               ENCODED_IOV_COMPRES‐
                 SION_BTRFS_LZO_16K,              ENCODED_IOV_COMPRES‐
                 SION_BTRFS_LZO_32K,      or      ENCODED_IOV_COMPRES‐
                 SION_BTRFS_LZO_64K, then the  encoded  data  is  com‐
                 pressed  page  by page (using the page size indicated
                 by the name of the constant) with LZO1X  and  wrapped
                 in  the  format documented in the Linux kernel source
                 file fs/btrfs/lzo.c.

              Additionally,   there   are   some    restrictions    on
              pwritev2(2):

              *  offset  (or  the current file offset if offset is -1)
                 must be aligned to the sector size of the filesystem.

              *  len must  be  aligned  to  the  sector  size  of  the
                 filesystem unless the data ends at or beyond the cur‐
                 rent end of the file.

              *  unencoded_len and the length of the encoded data must
                 each  be  no  more  than 128 KiB.  This limit may in‐
                 crease in the future.

              *  The length of the encoded data must be less  than  or
                 equal to unencoded_len.

              *  If  using  LZO, the filesystem's page size must match
                 the compression page size.

SEE ALSO
       open(2), preadv2(2)

Linux                         2020-11-11                 ENCODED_IO(7)
