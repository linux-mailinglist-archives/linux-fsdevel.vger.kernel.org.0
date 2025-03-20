Return-Path: <linux-fsdevel+bounces-44638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7906FA6AE8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC536171197
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578E2288EA;
	Thu, 20 Mar 2025 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sok8ZV/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208821E3DD0;
	Thu, 20 Mar 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499116; cv=none; b=OW4CXU+gUpwOvTQEKriR8gF3OznOC4EMMoZwFJ1c2qn/yzJF9pA+8CUPG522fCwDRd2qoY0LEOBPURmtbvib0gQEFmBIPaETSeP8q64bOQJ7icioVDZjFIMowgSJnSdLhtqusMA6Y/GE0p9CTyvAyY89wfj5dFpjynb2WE8iDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499116; c=relaxed/simple;
	bh=pgc28rm9Fcoj3tkL9OCRsTq4u5xLA3dlv8j5jx+g9Ok=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=lLuycH6c/UBOKiri6rT1j0H8YbJTJhUXxRBKlUpYIMLB88k0UuPMBRjOER1kGYyVstP7pv/w+JkSSNRQgKgOw4c2/kTnrTmhQipdWMuhP5rhZTZS3K8MJOZj56EonwfMAVRCUvYoa3O+FSx/LVvi/HhhsrMqA+p8xtwOxaHYUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sok8ZV/S; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22438c356c8so23862495ad.1;
        Thu, 20 Mar 2025 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742499114; x=1743103914; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rzqpj/EVEuP5YOgMQGcNjyK3eiHm30f9WtqRIqo0B4g=;
        b=Sok8ZV/SE72hqyEr6jI0tWy6qRpRof3HSc9QkTnraWHbgmNAtxmjKxou9KHdWAMJ1v
         EOHiIKQ9kbuV7uyY/+mwFJ2TEnx4b1ZdP5Lnf34z61+81utIxwCiD64eeu8gTphjB572
         WMx8UvpJfADBw1RyzfBXPl6VdsAyReo+apaMUZhd65rKjpKoPfIlGreCIy4i7B24M9tz
         UnRvITpbxODtS05EWboNbEV+8AEyFotTwu1+x4iC+loL3ZdEuNZzkDpNzkYhAywuy1Mc
         rzT/jzdLAe2OvaODaB1IdGcI42K11Ocq0WALnbwRy5JfBNkHcNFLtGCyYpIJoq3jsoVc
         LE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499114; x=1743103914;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rzqpj/EVEuP5YOgMQGcNjyK3eiHm30f9WtqRIqo0B4g=;
        b=aI+s7lYSiGsHa+pG/uLTRZ1yb8OcoQs0ypSmT25BbI0zg7j3HHxSy0rC5lm3tvcjfy
         yl7hpZuVUynOrEadooSPbadtusToGGH5JSQtseeXnaof2cmDLQ2HoPuACJZvcyEDpydo
         W8P1N9cPe68XJ6+smIYYVVWJecNJL209GjLyQSvSG7IkXBR5UyVKtc6ZtN7FsBlm0eBQ
         kDY5RtbQeKSTJcnG/p7JwVquBkZUQJmjwwOs9xVI7OAg+Tje5D+eHnO3C780lugeJfS3
         xG3BlOp+1CuRh3KlGSl1ZUMxEui6Bye5tijS5l+Z2epE88scGYxLBKc2/twjZ1wrwy+F
         xDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb3uxqPmMSmZhUC+Q7VtyIm6N3TyjGUbq+EMTPgW3XGZQptad51iPIEBgiHM06WUONxzamx02rHTHPKqJb@vger.kernel.org, AJvYcCXNLVWQh0tGFp6MsikWktEnoKDBTw3IPyfEZ+ASV1Fu6aY4yMha6Y2YpdIjRV29IzBlq6AFNsSNIY8z@vger.kernel.org, AJvYcCXg7gEgMFi3SOpw55ii7cshn3axm+mBqGS8xNEGeygPBQGQhm0g1GKuNqKl0hrYEsyzGK2DtwxSWFK9@vger.kernel.org
X-Gm-Message-State: AOJu0YxBctXPsYR3t08rQqlzjeZf1H/qkGxtWIRKEU7Dff5NP57ih19o
	fRT/tYcDpqHYrSLubPvb5A2vs6r1WUrVHafr/4Qp2OFO0SkDI34v
X-Gm-Gg: ASbGncvuXpOzh0Mn0RvS7uyKAhRvKUzdRUsqolPZ5FYOAY9vwSJUlRxHCoPRcjoWQX6
	qJLeSHPC6hoe1d2P7N04YecICb0ZxWEFxfWA37pYW/e8Yh6ePTyBrMfXNlvXqPuZHl9k5YJX0Cm
	TOzCyh37g334Ex3DCTGLQCzUe0fZWVhSqA1pA2aVAvcMXcQQWzCqANAntXFtPCBU0kjXsIC6KWQ
	VusXyTFKLZ42RzZXMPVpsNhhOxMH8RZqVN/Rv1snXJpNCs3IsfLQ4iE/Sr/vDmIK6d9xBNaj6zd
	A2tAZU+d478pMysATLowHuAXi9j1LpbNHj2neBLKfxGqPvwi
X-Google-Smtp-Source: AGHT+IHBppvG01BOrV5g8QAjBeAi/dOLo/+t1Ad7dypedZ8adLf7Wqe8oiMFbXgzNf+Ww9DQY0lOTQ==
X-Received: by 2002:a17:902:cf04:b0:224:5b4:b3b9 with SMTP id d9443c01a7336-22780e12a7dmr9595375ad.33.1742499114223;
        Thu, 20 Mar 2025 12:31:54 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2b5sm1804325ad.50.2025.03.20.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:31:53 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 3/3] iomap: rework IOMAP atomic flags
In-Reply-To: <20250320120250.4087011-4-john.g.garry@oracle.com>
Date: Fri, 21 Mar 2025 00:59:51 +0530
Message-ID: <87msdfsdow.fsf@gmail.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com> <20250320120250.4087011-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> Flag IOMAP_ATOMIC_SW is not really required. The idea of having this flag
> is that the FS ->iomap_begin callback could check if this flag is set to
> decide whether to do a SW (FS-based) atomic write. But the FS can set
> which ->iomap_begin callback it wants when deciding to do a FS-based
> atomic write.
>
> Furthermore, it was thought that IOMAP_ATOMIC_HW is not a proper name, as
> the block driver can use SW-methods to emulate an atomic write. So change
> back to IOMAP_ATOMIC.
>
> The ->iomap_begin callback needs though to indicate to iomap core that
> REQ_ATOMIC needs to be set, so add IOMAP_F_ATOMIC_BIO for that.
>
> These changes were suggested by Christoph Hellwig and Dave Chinner.

Looks good to me. Thanks for updating the iomap design document as well.
Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  .../filesystems/iomap/operations.rst          | 35 ++++++++++---------
>  fs/ext4/inode.c                               |  6 +++-
>  fs/iomap/direct-io.c                          |  8 ++---
>  fs/iomap/trace.h                              |  2 +-
>  fs/xfs/xfs_iomap.c                            |  4 +++
>  include/linux/iomap.h                         | 12 +++----
>  6 files changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index b08a79d11d9f..3b628e370d88 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -514,29 +514,32 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>     if the mapping is unwritten and the filesystem cannot handle zeroing
>     the unaligned regions without exposing stale contents.
>  
> - * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
> -   protection based on HW-offload support.
> -   Only a single bio can be created for the write, and the write must
> -   not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
> -   set.
> + * ``IOMAP_ATOMIC``: This write is being issued with torn-write
> +   protection.
> +   Torn-write protection may be provided based on HW-offload or by a
> +   software mechanism provided by the filesystem.
> +
> +   For HW-offload based support, only a single bio can be created for the
> +   write, and the write must not be split into multiple I/O requests, i.e.
> +   flag REQ_ATOMIC must be set.
>     The file range to write must be aligned to satisfy the requirements
>     of both the filesystem and the underlying block device's atomic
>     commit capabilities.
>     If filesystem metadata updates are required (e.g. unwritten extent
> -   conversion or copy on write), all updates for the entire file range
> +   conversion or copy-on-write), all updates for the entire file range
>     must be committed atomically as well.
> -   Only one space mapping is allowed per untorn write.
> -   Untorn writes may be longer than a single file block. In all cases,
> +   Untorn-writes may be longer than a single file block. In all cases,
>     the mapping start disk block must have at least the same alignment as
>     the write offset.
> -
> - * ``IOMAP_ATOMIC_SW``: This write is being issued with torn-write
> -   protection via a software mechanism provided by the filesystem.
> -   All the disk block alignment and single bio restrictions which apply
> -   to IOMAP_ATOMIC_HW do not apply here.
> -   SW-based untorn writes would typically be used as a fallback when
> -   HW-based untorn writes may not be issued, e.g. the range of the write
> -   covers multiple extents, meaning that it is not possible to issue
> +   The filesystems must set IOMAP_F_ATOMIC_BIO to inform iomap core of an
> +   untorn-write based on HW-offload.
> +
> +   For untorn-writes based on a software mechanism provided by the
> +   filesystem, all the disk block alignment and single bio restrictions
> +   which apply for HW-offload based untorn-writes do not apply.
> +   The mechanism would typically be used as a fallback for when
> +   HW-offload based untorn-writes may not be issued, e.g. the range of the
> +   write covers multiple extents, meaning that it is not possible to issue
>     a single bio.
>     All filesystem metadata updates for the entire file range must be
>     committed atomically as well.
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ba2f1e3db7c7..d04d8a7f12e7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3290,6 +3290,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	if (map->m_flags & EXT4_MAP_NEW)
>  		iomap->flags |= IOMAP_F_NEW;
>  
> +	/* HW-offload atomics are always used */
> +	if (flags & IOMAP_ATOMIC)
> +		iomap->flags |= IOMAP_F_ATOMIC_BIO;
> +
>  	if (flags & IOMAP_DAX)
>  		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
>  	else
> @@ -3467,7 +3471,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>  		return false;
>  
>  	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC_HW)
> +	if (flags & IOMAP_ATOMIC)
>  		return false;
>  
>  	/* can only try again if we wrote nothing */
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b9f59ca43c15..6ac7a1534f7c 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -349,7 +349,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		bio_opf |= REQ_OP_WRITE;
>  
> -		if (iter->flags & IOMAP_ATOMIC_HW) {
> +		if (iomap->flags & IOMAP_F_ATOMIC_BIO) {
>  			/*
>  			 * Ensure that the mapping covers the full write
>  			 * length, otherwise it won't be submitted as a single
> @@ -677,10 +677,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iomi.flags |= IOMAP_OVERWRITE_ONLY;
>  		}
>  
> -		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
> -			iomi.flags |= IOMAP_ATOMIC_SW;
> -		else if (iocb->ki_flags & IOCB_ATOMIC)
> -			iomi.flags |= IOMAP_ATOMIC_HW;
> +		if (iocb->ki_flags & IOCB_ATOMIC)
> +			iomi.flags |= IOMAP_ATOMIC;
>  
>  		/* for data sync or sync, we need sync completion processing */
>  		if (iocb_is_dsync(iocb)) {
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 69af89044ebd..9eab2c8ac3c5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
>  	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> -	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>  
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 5dd0922fe2d1..ee40dc509413 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -828,6 +828,10 @@ xfs_direct_write_iomap_begin(
>  	if (offset + length > i_size_read(inode))
>  		iomap_flags |= IOMAP_F_DIRTY;
>  
> +	/* HW-offload atomics are always used in this path */
> +	if (flags & IOMAP_ATOMIC)
> +		iomap_flags |= IOMAP_F_ATOMIC_BIO;
> +
>  	/*
>  	 * COW writes may allocate delalloc space or convert unwritten COW
>  	 * extents, so we need to make sure to take the lock exclusively here.
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 9cd93530013c..02fe001feebb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -60,6 +60,9 @@ struct vm_fault;
>   * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
>   * assigned to it yet and the file system will do that in the bio submission
>   * handler, splitting the I/O as needed.
> + *
> + * IOMAP_F_ATOMIC_BIO indicates that (write) I/O will be issued as an atomic
> + * bio, i.e. set REQ_ATOMIC.
>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -73,6 +76,7 @@ struct vm_fault;
>  #define IOMAP_F_XATTR		(1U << 5)
>  #define IOMAP_F_BOUNDARY	(1U << 6)
>  #define IOMAP_F_ANON_WRITE	(1U << 7)
> +#define IOMAP_F_ATOMIC_BIO	(1U << 8)
>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -189,9 +193,8 @@ struct iomap_folio_ops {
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> -#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
> +#define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
>  #define IOMAP_DONTCACHE		(1 << 10)
> -#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
>  
>  struct iomap_ops {
>  	/*
> @@ -503,11 +506,6 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> -/*
> - * Use software-based torn-write protection.
> - */
> -#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
> -
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.31.1

