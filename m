Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1643DF57F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfJUTAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 15:00:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUTA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:00:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LIxeYu096071;
        Mon, 21 Oct 2019 19:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=aLiHXRQcItDXRCVHbSlmPUfVKk2TZmfCZPXg5F6sKXo=;
 b=Bc0ORmTQhI5BvPzsClesITN5OWVk+bTXB/K4F7CT9KjQUxCS7l+sNyeKv88lx7vGV7xK
 vYVJsHaig5RGUYLWscY30HzXKCnRQOG4g5Nk0lQ7sRQGx8Fag672oVv5Y705xbOeM9Ch
 2ly+gH5qXCfeNfrsar1cfeOoRLjQIGX8lrAGw9N4UqDB7BLPoBUzwVBZEvVcCDe59bNw
 0IH/a0loH/rtHVoxRr0RZOip0GIAYKMSlXVZi3u4gP1TIwPCXHVxmSDECSs3uFXuGm9E
 qg29uP1vGtbVcFBg3VkLTzPuEqMOXUgcLQFKlRCFM3mIcsRcUKvv8BuW1UCD8dKWt98a RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqtephsr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 19:00:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LIwT67193967;
        Mon, 21 Oct 2019 19:00:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vrc0083f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 19:00:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LJ0CXx007517;
        Mon, 21 Oct 2019 19:00:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 12:00:12 -0700
Date:   Mon, 21 Oct 2019 12:00:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191021190010.GC6726@magnolia>
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
 <20191021182806.GA6706@magnolia>
 <20191021183831.mbe4q2beqo76fqxm@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021183831.mbe4q2beqo76fqxm@yavin.dot.cyphar.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210183
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:38:31AM +1100, Aleksa Sarai wrote:
> On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Tue, Oct 15, 2019 at 11:42:40AM -0700, Omar Sandoval wrote:
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
> > > used to extend the interface in the future. The remaining iovecs contain
> > > the encoded extent.
> > > 
> > > Filesystems must indicate that they support encoded writes by setting
> > > FMODE_ENCODED_IO in ->file_open().
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  include/linux/fs.h      | 14 +++++++
> > >  include/uapi/linux/fs.h | 26 ++++++++++++-
> > >  mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++-------
> > >  3 files changed, 108 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index e0d909d35763..54681f21e05e 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> > >  /* File does not contribute to nr_files count */
> > >  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
> > >  
> > > +/* File supports encoded IO */
> > > +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> > > +
> > >  /*
> > >   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
> > >   * that indicates that they should check the contents of the iovec are
> > > @@ -314,6 +317,7 @@ enum rw_hint {
> > >  #define IOCB_SYNC		(1 << 5)
> > >  #define IOCB_WRITE		(1 << 6)
> > >  #define IOCB_NOWAIT		(1 << 7)
> > > +#define IOCB_ENCODED		(1 << 8)
> > >  
> > >  struct kiocb {
> > >  	struct file		*ki_filp;
> > > @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_block *, int);
> > >  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
> > >  extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
> > >  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> > > +struct encoded_iov;
> > > +extern int generic_encoded_write_checks(struct kiocb *, struct encoded_iov *);
> > > +extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter *);
> > > +extern int import_encoded_write(struct kiocb *, struct encoded_iov *,
> > > +				struct iov_iter *);
> > >  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> > >  				struct file *file_out, loff_t pos_out,
> > >  				loff_t *count, unsigned int remap_flags);
> > > @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> > >  			return -EOPNOTSUPP;
> > >  		ki->ki_flags |= IOCB_NOWAIT;
> > >  	}
> > > +	if (flags & RWF_ENCODED) {
> > > +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> > > +			return -EOPNOTSUPP;
> > > +		ki->ki_flags |= IOCB_ENCODED;
> > > +	}
> > >  	if (flags & RWF_HIPRI)
> > >  		ki->ki_flags |= IOCB_HIPRI;
> > >  	if (flags & RWF_DSYNC)
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index 379a612f8f1d..ed92a8a257cb 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -284,6 +284,27 @@ struct fsxattr {
> > >  
> > >  typedef int __bitwise __kernel_rwf_t;
> > >  
> > > +enum {
> > > +	ENCODED_IOV_COMPRESSION_NONE,
> > > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > > +	ENCODED_IOV_COMPRESSION_LZO,
> > > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > > +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> > > +};
> > > +
> > > +enum {
> > > +	ENCODED_IOV_ENCRYPTION_NONE,
> > > +	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
> > > +};
> > > +
> > > +struct encoded_iov {
> > > +	__u64 len;
> > > +	__u64 unencoded_len;
> > > +	__u64 unencoded_offset;
> > > +	__u32 compression;
> > > +	__u32 encryption;
> > 
> > Can we add some must-be-zero padding space at the end here for whomever
> > comes along next wanting to add more encoding info?
> 
> I would suggest to copy the extension design of copy_struct_from_user().
> Adding must-be-zero padding is a less-ideal solution to the extension
> problem than length-based extension.

Come to think of it, you /do/ have to specify iov_len so... yeah, do
that instead; we can always extend the structure later.

> Also (I might be wrong) but shouldn't the __u64s be __aligned_u64 (as
> with syscall structure arguments)?

<shrug> No idea, that's the first I've heard of that type and it doesn't
seem to be used by the fs code.  Why would we care about alignment for
an incore structure?

--D

> 
> > (And maybe a manpage and some basic testing, to reiterate Dave...)
> > 
> > --D
> > 
> > > +};
> > > +
> > >  /* high priority request, poll if possible */
> > >  #define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
> > >  
> > > @@ -299,8 +320,11 @@ typedef int __bitwise __kernel_rwf_t;
> > >  /* per-IO O_APPEND */
> > >  #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
> > >  
> > > +/* encoded (e.g., compressed or encrypted) IO */
> > > +#define RWF_ENCODED	((__force __kernel_rwf_t)0x00000020)
> > > +
> > >  /* mask of flags supported by the kernel */
> > >  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> > > -			 RWF_APPEND)
> > > +			 RWF_APPEND | RWF_ENCODED)
> > >  
> > >  #endif /* _UAPI_LINUX_FS_H */
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 1146fcfa3215..d2e6d9caf353 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -2948,24 +2948,15 @@ static int generic_write_check_limits(struct file *file, loff_t pos,
> > >  	return 0;
> > >  }
> > >  
> > > -/*
> > > - * Performs necessary checks before doing a write
> > > - *
> > > - * Can adjust writing position or amount of bytes to write.
> > > - * Returns appropriate error code that caller should return or
> > > - * zero in case that write should be allowed.
> > > - */
> > > -inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> > > +static int generic_write_checks_common(struct kiocb *iocb, loff_t *count)
> > >  {
> > >  	struct file *file = iocb->ki_filp;
> > >  	struct inode *inode = file->f_mapping->host;
> > > -	loff_t count;
> > > -	int ret;
> > >  
> > >  	if (IS_SWAPFILE(inode))
> > >  		return -ETXTBSY;
> > >  
> > > -	if (!iov_iter_count(from))
> > > +	if (!*count)
> > >  		return 0;
> > >  
> > >  	/* FIXME: this is for backwards compatibility with 2.4 */
> > > @@ -2975,8 +2966,21 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> > >  	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
> > >  		return -EINVAL;
> > >  
> > > -	count = iov_iter_count(from);
> > > -	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
> > > +	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
> > > +}
> > > +
> > > +/*
> > > + * Performs necessary checks before doing a write
> > > + *
> > > + * Can adjust writing position or amount of bytes to write.
> > > + * Returns a negative errno or the new number of bytes to write.
> > > + */
> > > +inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> > > +{
> > > +	loff_t count = iov_iter_count(from);
> > > +	int ret;
> > > +
> > > +	ret = generic_write_checks_common(iocb, &count);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -2985,6 +2989,58 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> > >  }
> > >  EXPORT_SYMBOL(generic_write_checks);
> > >  
> > > +int generic_encoded_write_checks(struct kiocb *iocb,
> > > +				 struct encoded_iov *encoded)
> > > +{
> > > +	loff_t count = encoded->unencoded_len;
> > > +	int ret;
> > > +
> > > +	ret = generic_write_checks_common(iocb, &count);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (count != encoded->unencoded_len) {
> > > +		/*
> > > +		 * The write got truncated by generic_write_checks_common(). We
> > > +		 * can't do a partial encoded write.
> > > +		 */
> > > +		return -EFBIG;
> > > +	}
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(generic_encoded_write_checks);
> > > +
> > > +ssize_t check_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
> > > +{
> > > +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> > > +		return -EPERM;
> > > +	if (iov_iter_single_seg_count(iter) != sizeof(struct encoded_iov))
> > > +		return -EINVAL;
> > > +	return iov_iter_count(iter) - sizeof(struct encoded_iov);
> > > +}
> > > +EXPORT_SYMBOL(check_encoded_read);
> > > +
> > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > > +			 struct iov_iter *from)
> > > +{
> > > +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> > > +		return -EPERM;
> > > +	if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > > +		return -EINVAL;
> > > +	if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > > +		return -EFAULT;
> > > +	if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > > +	    encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE)
> > > +		return -EINVAL;
> > > +	if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > +	    encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > +		return -EINVAL;
> > > +	if (encoded->unencoded_offset >= encoded->unencoded_len)
> > > +		return -EINVAL;
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(import_encoded_write);
> > > +
> > >  /*
> > >   * Performs necessary checks before doing a clone.
> > >   *
> > > -- 
> > > 2.23.0
> > > 
> 
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>


