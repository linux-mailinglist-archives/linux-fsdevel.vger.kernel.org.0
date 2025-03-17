Return-Path: <linux-fsdevel+bounces-44198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789DA65295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75452188A3D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5EC241675;
	Mon, 17 Mar 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRZTcg/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470220322;
	Mon, 17 Mar 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220858; cv=none; b=pnSkEaQ0HmbvQ4+FPUiGVTMev/EXIIERjedS1vcnZnJ6q5EipwA431wxyl+U03YOQg+EeVLOZAJeTDSRyvA3MFJpA+xqJt1xynmwnXVM8Upzko8NydKAEg+uuN248SPGv9tRZoIgXrW09sOf1JxQA3QBMvakp/Qpf0mhNEpVC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220858; c=relaxed/simple;
	bh=FaKXewuiPsteMre9gO10msskbpTrobL3/oyES+8hp/g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=pGCDWEed5UxJmAKVohhTKTsZBEKFzknUzVTRr2lF2kTYcB4eiWfz2KWMJvR5DycFFfRIc5DZtlJekuwEtgiAeqd63H04EF2s2wSaIdmDrUqHPWTmRd97JEVxzcYwQl1zTZAacUEHHMFBHbljBhK3A6yynLvOzPEizKudGY0ap5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRZTcg/J; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c915749so14854365ad.3;
        Mon, 17 Mar 2025 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742220855; x=1742825655; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FWm0/DCZUe0Mhr2IZVtrNDeCytOlPsIxKkTRgrtWi20=;
        b=XRZTcg/JPchPz3Lxx79CdG/GVNqkFXxhhRH8EZ1qtktS3pd7Tap6nuBQlBQFqHgBig
         g8e2Fp42AuN4qnS56kSJ0IdU2GoUbTGY8n4HZJSQHMFoMKFe5zscjH40ORLSaqGFlqFS
         TbgdJqxHzQrKS6fLomZrq6VVRHSMbK+O0G2HK1pMrbc0DWNlIoxp1MAlocr9hVpC5dSN
         yEkoK3LbR9PgLCICE+KpTZYpS3aZ+TOMf0vzFNGCCvEtM8qTAIPt6alJhPnfhFD4kFst
         Or0pkQgXDHoSGgWyDDjTHnnozOiEPO2xyge4jW8tnqi2SR1HibcaCOnuaLGvizjIZIyc
         9pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220855; x=1742825655;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWm0/DCZUe0Mhr2IZVtrNDeCytOlPsIxKkTRgrtWi20=;
        b=TsNU/Zi69aUl6rCcUU4wUkIoElTy72lqCKebiEj5CD5boAUAusBm1RisTnjkia/b3s
         B+1BeykTy9OdiKGgKSl2slNXPPaR9azLMwaTzwPYxwbuiRhcy9iR4mP93Bh1uZ2m4YKF
         Ewi66cf4DEYo6yQIH58Vvk2DlzRMaZ0wAyIiqk6sWxSmV3tL657diFXr8eSPJjh4ODzA
         JkzfYVGEjPerbIcnxX+mWsQ56rYXZnGa/a/boT3GavlMwDdfxapQCvC6IJVdeuXCKLib
         3Q1QqJD9w6jpJaTetXq8mBDcw4/n/fCsN3GS4QJz8PWNG9lmNSX/0C/udIfwSikgjA5v
         m3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNhvOT0b6U9Qlgqznry7nvXKfy/USlJyJ7rKSrhGjHJxWYQEnZh1Aes2X0Q0i2Rot6tmdAIJ6xsGKwSwiaEQ==@vger.kernel.org, AJvYcCW63Etva4ufkSqVKhSgbKfrAmp3jHeucBLIrKp8oiC0bzCrc25QIx6jP5+WEw04j2zS7P1Y/tpYX/qrwEc+@vger.kernel.org, AJvYcCXegqR5uQfhhI9URTo19JnQ7EVWBJTRInJenx3asmAO7alFe4kfwS2Ao1ChfwAa8NOgUF80NyD5YLw9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8o6NsVfWKpCqgB8Rmm/jHhEt+vYpzZMtxrZgax0szxPrqFgzI
	LejeFCn99ItGw04v345nXBMieMKvdwTUgp/nOZMYApj2Gb/Tqr1V
X-Gm-Gg: ASbGncunJJbWyDbes82ULLzHJMCyqfPhiQPfpOmT2Y8k8G06HLjDr9vzMJUcEQNFPzk
	QoY/1JlAouA50puRSAJjvebzbY3BQwZLOin/2ribd/jpoosb7E9uVmTQjKEIerm01cRmOyCOpB3
	n6mTTAkz3Xs8r05OiP2mZt45Whp6L2rfb3nAFJCqN6UT8fmX0WfQ/RHKl/JDbbIhE//C4H84qvZ
	sJkrPLY/5PZxdfxKL+r46PZpigbz9jCzn+2fDhu0TrY3YmW44f7ruNkNZe0VeyiMR+8FBHrz1DM
	9INMGL92lVUEAkCS9vBTo5EI6bzp5ZzENYWdgA==
X-Google-Smtp-Source: AGHT+IGVhWiXUXLlgBwJrqlpMtNkeAgOI0BV23gIzLp9axR+K2PcVY/OoWewktpbkKvIm0EfbAd1fA==
X-Received: by 2002:a17:902:cf07:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-225e0a6c368mr158926935ad.14.1742220854975;
        Mon, 17 Mar 2025 07:14:14 -0700 (PDT)
Received: from dw-tp ([171.76.81.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6ca3sm75479905ad.134.2025.03.17.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:14:14 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
In-Reply-To: <20250313171310.1886394-4-john.g.garry@oracle.com>
Date: Mon, 17 Mar 2025 19:14:25 +0530
Message-ID: <87tt7rsreu.fsf@gmail.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-4-john.g.garry@oracle.com>
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
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/ext4/inode.c       |  5 ++++-
>  fs/iomap/direct-io.c  |  8 +++-----
>  fs/iomap/trace.h      |  2 +-
>  fs/xfs/xfs_iomap.c    |  3 +++
>  include/linux/iomap.h | 12 +++++-------
>  5 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ba2f1e3db7c7..949d74d34926 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3290,6 +3290,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	if (map->m_flags & EXT4_MAP_NEW)
>  		iomap->flags |= IOMAP_F_NEW;
>  
> +	if (flags & IOMAP_ATOMIC)
> +		iomap->flags |= IOMAP_F_ATOMIC_BIO;
> +
>  	if (flags & IOMAP_DAX)
>  		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
>  	else
> @@ -3467,7 +3470,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>  		return false;
>  
>  	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC_HW)
> +	if (flags & IOMAP_ATOMIC)
>  		return false;
>  

The changes in ext4 is mostly straight forward. Essentially for
an IOMAP_ATOMIC write requests we are always setting IOMAP_F_ATOMIC_BIO in
the ->iomap_begin() routine. This is done to inform the iomap that this
write request needs to issue an atomic bio, so iomap then goes and sets
REQ_ATOMIC flag in the bio.


>  	/* can only try again if we wrote nothing */
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9d72b99cb447..c28685fd3362 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -349,7 +349,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		bio_opf |= REQ_OP_WRITE;
>  
> -		if (iter->flags & IOMAP_ATOMIC_HW) {
> +		if (iomap->flags & IOMAP_F_ATOMIC_BIO) {
>  			/*
>  			* Ensure that the mapping covers the full write length,
>  			* otherwise we will submit multiple BIOs, which is
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
> index 30e257f683bb..9a22ecd794eb 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -831,6 +831,9 @@ xfs_direct_write_iomap_begin(
>  	if (offset + length > i_size_read(inode))
>  		iomap_flags |= IOMAP_F_DIRTY;
>  
> +	if (flags & IOMAP_ATOMIC)
> +		iomap_flags |= IOMAP_F_ATOMIC_BIO;
> +
>  	/*
>  	 * COW writes may allocate delalloc space or convert unwritten COW
>  	 * extents, so we need to make sure to take the lock exclusively here.
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 9cd93530013c..51f4c13bd17a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -60,6 +60,9 @@ struct vm_fault;
>   * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
>   * assigned to it yet and the file system will do that in the bio submission
>   * handler, splitting the I/O as needed.
> + *
> + * IOMAP_F_ATOMIC_BIO indicates that (write) I/O needs to be issued as an
> + * atomic bio, i.e. set REQ_ATOMIC.
>   */


Maybe we can be more explicit here?

IOMAP_F_ATOMIC_BIO flag indicates that write I/O must be issued as an
atomic bio by setting the REQ_ATOMIC flag. Filesystems need to set this
flag to inform iomap that the write I/O operation should be submitted as
an atomic bio.

This definition (or whatever you feel is the better version), should also
go in Documentation/filesystems/iomap/design.rst

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

Now that we are killing separate IOMAP_ATOMIC_** names, we may would
like to update the iomap design document as well. Otherwise it will
carry use of IOMAP_ATOMIC_HW & IOMAP_ATOMIC_SW definitions. Instead we
should only keep IOMAP_ATOMIC and update the design info there.

-ritesh

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

