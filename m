Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45B7DF5A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJUTHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 15:07:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32834 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUTHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:07:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so9024105pfl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xr2V3uPLDBgP2U5wUE/gYBjr7Sf5LBUfrf2Bn/NaMjo=;
        b=dsiNdpRAElMpIKaS1rLTLJNPeEFHfvzVpK8kK9/YfTc5lT3e1ImwVmp9tyx2P4NDax
         It8dvSpFcf27UBTjlaIpwX6dJyZ5guF4CA9PbZ7TkQkXxz9BXX/LFbr+ByCrVBT9E05W
         WrNzBkpNJuQtu7OA9tScdbeUaRcd/oKpPD8WDs1BM6RPnbxlfrQVch4k7OZ1FR6IlKBf
         Aie5Tnw9i3+7pYcN+Z7befE3SKhVO8Rv/SUvowJlI3GMnG37kBErzkyTmCbXSb2b9eaK
         QHmWp/JM7UMUtJErRdqgH97zwX49/TAzBCcdabiiV9nfTrWjFilKQYiBs1BO7/FONuKD
         oFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xr2V3uPLDBgP2U5wUE/gYBjr7Sf5LBUfrf2Bn/NaMjo=;
        b=hJh0w5IR3rhJaOcvDz6sHKrJzii+McqhPK8oHn7jyboj+4oA+udd9+TFAqrK08nM2U
         peJdY7d3EmnY8ZtjlJ6TX2YYgarmIMimqUsiHR8pnxouEBRzyCJIgsnYi+lFFqlmT3qq
         pF1/EBbAj4ZyIEivI/VLM0IQut+MjqolAC9y8v9+ce8lWRyNCm2D3RQzuWS6uG6hif63
         IEUArPX+Gc/Hg+24KKoxIRzgrseg04lRj3arMIyktmsUGr54eqBaki5q483vPrDDEtPI
         KZ3nljM6dmz3/13J3gUbkhosbJ+pjGZqOMeUmslx2LSIwbFqkRvALOsE4/o7zfI2fyS/
         VSvw==
X-Gm-Message-State: APjAAAU7AGGnRuK2XWA1seHPvu0EEvFBOiztybaWlr9p+FGBlf3aU/5e
        4/5C7ayVFRJESdKcXDsaaFd/Hg==
X-Google-Smtp-Source: APXvYqwYoRx9woMwa5wxi8hk4jPhMuIKimZ/Lk6+GyPrVtcL+R/DoXZiuxubqhv8k7HQcJvYSyvRWw==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr31750740pje.113.1571684831090;
        Mon, 21 Oct 2019 12:07:11 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4637])
        by smtp.gmail.com with ESMTPSA id v68sm16864545pfv.47.2019.10.21.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:07:10 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:07:09 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191021190709.GD81648@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
 <20191021182806.GA6706@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021182806.GA6706@magnolia>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:28:06AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 15, 2019 at 11:42:40AM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Btrfs supports transparent compression: data written by the user can be
> > compressed when written to disk and decompressed when read back.
> > However, we'd like to add an interface to write pre-compressed data
> > directly to the filesystem, and the matching interface to read
> > compressed data without decompressing it. This adds support for
> > so-called "encoded I/O" via preadv2() and pwritev2().
> > 
> > A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> > this flag is set, iov[0].iov_base points to a struct encoded_iov which
> > is used for metadata: namely, the compression algorithm, unencoded
> > (i.e., decompressed) length, and what subrange of the unencoded data
> > should be used (needed for truncated or hole-punched extents and when
> > reading in the middle of an extent). For reads, the filesystem returns
> > this information; for writes, the caller provides it to the filesystem.
> > iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> > used to extend the interface in the future. The remaining iovecs contain
> > the encoded extent.
> > 
> > Filesystems must indicate that they support encoded writes by setting
> > FMODE_ENCODED_IO in ->file_open().
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  include/linux/fs.h      | 14 +++++++
> >  include/uapi/linux/fs.h | 26 ++++++++++++-
> >  mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 108 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e0d909d35763..54681f21e05e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> >  /* File does not contribute to nr_files count */
> >  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
> >  
> > +/* File supports encoded IO */
> > +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> > +
> >  /*
> >   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
> >   * that indicates that they should check the contents of the iovec are
> > @@ -314,6 +317,7 @@ enum rw_hint {
> >  #define IOCB_SYNC		(1 << 5)
> >  #define IOCB_WRITE		(1 << 6)
> >  #define IOCB_NOWAIT		(1 << 7)
> > +#define IOCB_ENCODED		(1 << 8)
> >  
> >  struct kiocb {
> >  	struct file		*ki_filp;
> > @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_block *, int);
> >  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
> >  extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
> >  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> > +struct encoded_iov;
> > +extern int generic_encoded_write_checks(struct kiocb *, struct encoded_iov *);
> > +extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter *);
> > +extern int import_encoded_write(struct kiocb *, struct encoded_iov *,
> > +				struct iov_iter *);
> >  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> >  				struct file *file_out, loff_t pos_out,
> >  				loff_t *count, unsigned int remap_flags);
> > @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> >  			return -EOPNOTSUPP;
> >  		ki->ki_flags |= IOCB_NOWAIT;
> >  	}
> > +	if (flags & RWF_ENCODED) {
> > +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> > +			return -EOPNOTSUPP;
> > +		ki->ki_flags |= IOCB_ENCODED;
> > +	}
> >  	if (flags & RWF_HIPRI)
> >  		ki->ki_flags |= IOCB_HIPRI;
> >  	if (flags & RWF_DSYNC)
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 379a612f8f1d..ed92a8a257cb 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -284,6 +284,27 @@ struct fsxattr {
> >  
> >  typedef int __bitwise __kernel_rwf_t;
> >  
> > +enum {
> > +	ENCODED_IOV_COMPRESSION_NONE,
> > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > +	ENCODED_IOV_COMPRESSION_LZO,
> > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> > +};
> > +
> > +enum {
> > +	ENCODED_IOV_ENCRYPTION_NONE,
> > +	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
> > +};
> > +
> > +struct encoded_iov {
> > +	__u64 len;
> > +	__u64 unencoded_len;
> > +	__u64 unencoded_offset;
> > +	__u32 compression;
> > +	__u32 encryption;
> 
> Can we add some must-be-zero padding space at the end here for whomever
> comes along next wanting to add more encoding info?

From the commit message:

iov_len must be set to sizeof(struct encoded_iov), which can be used to
extend the interface in the future.

> (And maybe a manpage and some basic testing, to reiterate Dave...)

I sent a man page as part of this thread:

https://lore.kernel.org/linux-btrfs/c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com/

See my reply to Dave, I have tests in my xfstests repo that I haven't
sent yet.

> --D
