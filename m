Return-Path: <linux-fsdevel+bounces-44146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F71A635D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 14:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB2016D4C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16351AA7BF;
	Sun, 16 Mar 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyDP/fEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D279A32;
	Sun, 16 Mar 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742132434; cv=none; b=JrfcD2huPMFnRDTsSoOSjmsoWysrWvGCPGBtUd81/lRVya9ZUDJzMH1xUXm+9QEwgoCd8MNDiN6ZlcVWETfE+sg865LmG+gzgdEFbA6DIR+IzdIPyNsdg5PfYKnaMmrSNWVHWutoXjDR3uxQA15k5NlLROEbcDKcALhTmxvbMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742132434; c=relaxed/simple;
	bh=+eP3COHMGSILG+3VCh2zSSWR05FiQeElPNL6B3fjFgg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=tAPVDdA21nHL2kZl6Ci+XbNblsN74Mt2jK+Xa7g4gbq4lY+5wjAV7YvcTDzVvMXdsb6zm8KD73PamfsvdiHk0+ww/g/nZHkYw6Ymwgiiy8oV69tbgsL8KBGXCN83eZSAB9r4LIefAN8Sie50/r0zjoVLX35HR85QdhkoZSnjA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyDP/fEA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224100e9a5cso66786965ad.2;
        Sun, 16 Mar 2025 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742132431; x=1742737231; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VdLYDQ9fmoN/8PBxziQo7P+nVlZR+8JRc9oB0auVypw=;
        b=UyDP/fEAqiicfNLY/OHjqXBIZROZhPkQMJmWQacIyna7CFAVoBwz9UYEAZwfVNCQUC
         zfwjCP4IQq9RUGff8o3eDB3gpjFHm85PRbZjX8ghxBBdHvL/4KqYk6vI9B70wv08TJcu
         LmsTA9X/MS7sCLps/IrD1oWRnmHsBrWxnE/zZUThBGBDxo6vakF5ltwqd1BO3bykkrKX
         CpMhP6kXDLnVqZpMoWlv4XSeCYFvf3dTHPbR3bJlau5wr8Ij5V6Uxacnn1ydwTvJ4OZI
         tNPnaX7xeDBDLYKgtHB2Nh/HeA8Jghhszrx9k0fwnZhjAj1wObzxdBKGkReW4hcrr8pm
         bxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742132431; x=1742737231;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdLYDQ9fmoN/8PBxziQo7P+nVlZR+8JRc9oB0auVypw=;
        b=dF0IJl9kvm+jGKbq8c4Q+nMdWMefaDmEt5xWJgq7yb2HnbD31VDmy/zReH5Nh3zzbv
         tOV02rENvxnwhgTuI0asKVrtrHzOxZdk6V2BB0g+G1RcpQyM2IdwnpGHVdeM4iJsBVkQ
         EyNGM2fRRVL8Ahf3fjQ7cBXUtdUUwGw/Faj2RKUMp2e9LWZMHeSW2PMHHzOJDSSATN91
         EPvNzobIbvyRqZuYyyqWie92aqap2RQxEL+1/+CdsXQwsgcSjzoitiF3ugPBb4xoywDv
         7BtYhioeRcCOD/HKWhrxZ4dv6CGhaNohRuFz0reXMnwzFYzXNm7UVMesgFtwwrLnEEft
         Vc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmBNyPxljPBEHO0+afo4gNA6DBQW1MafVW3NlGxViZQtkAZ9U5pvIwSRByMP5dBViZmAuChgA13gAIOdqM@vger.kernel.org, AJvYcCW8UlRatNyQHPtwdTy+uAzdd7fQN//28TbCjCu1RyETg1V02/bhoa0l3tqcsOrW/ffyavTnDF67lByv@vger.kernel.org, AJvYcCWS/9R2xlgvetBVx3Nbglql38SaZxoV2cc2Xy0dgaxfEDd18UtYkNXHbMyQG/sr18FrqR2HapvLBfU1MLd5lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVuWZReBferxWVjS6OOupuJaNiK9a90mZyIZqnwFdBKSjbJw0y
	O+SFt/vOqvzGVgTZkoB8g5mPtVGliSgz2JN3WmUw0ok7Hd6xR+a9
X-Gm-Gg: ASbGncvj2X0XCLK/knUmTlp9SEcXzrDnNdjc/DYK7ct+VB32unaDuhqJUh0+KWqywd0
	U6s/pu+lNMI7Ky3uXFFnaUC3d1eW5znobkeBHqU5ZRceenrVy9wLwC8+TH+NMFv5JT7hbFOXiOV
	pR/GyBTIkjGfLVo7hx26NlpgpP/kWcPXzr0vcMlZxsIzBhKw9CXzHleg7+a68QwhVzEzpjd3NGU
	c620Kw0K9kivfvHWB+HMrnEqxODXrP4QJrs2lPAkdpQCZGVDeEnt4eeZziJLUgagpAqvB1Yjgey
	fKnm13/Rex1B45dgACnhjGs2/0ANRMaTf4tQjw==
X-Google-Smtp-Source: AGHT+IGhz7Ue+ZLyG8VUmXRsrEHkfX2BRwH78PG4XyOl+NG2xSpQf6wEawvh82ePN1A6+gBd5ewDVg==
X-Received: by 2002:a17:903:41cd:b0:21f:1549:a563 with SMTP id d9443c01a7336-225e0a19b8cmr111256885ad.2.1742132431486;
        Sun, 16 Mar 2025 06:40:31 -0700 (PDT)
Received: from dw-tp ([171.76.81.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f09sm57950155ad.133.2025.03.16.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 06:40:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v6 01/13] iomap: inline iomap_dio_bio_opflags()
In-Reply-To: <20250313171310.1886394-2-john.g.garry@oracle.com>
Date: Sun, 16 Mar 2025 19:10:06 +0530
Message-ID: <87cyeh5c21.fsf@gmail.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> It is neater to build blk_opf_t fully in one place, so inline
> iomap_dio_bio_opflags() in iomap_dio_bio_iter().
>
> Also tidy up the logic in dealing with IOMAP_DIO_CALLER_COMP, in generally
> separate the logic in dealing with flags associated with reads and writes.
>

Indeed it clean things up and separates the logic required for
IOMAP_DIO_WRITE v/s reads.

The change looks good to me. Please feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Originally-from: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> Should I change author?
>  fs/iomap/direct-io.c | 112 +++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 63 deletions(-)
>
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5299f70428ef..8c1bec473586 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -312,27 +312,20 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  }
>  
>  /*
> - * Figure out the bio's operation flags from the dio request, the
> - * mapping, and whether or not we want FUA.  Note that we can end up
> - * clearing the WRITE_THROUGH flag in the dio request.
> + * Use a FUA write if we need datasync semantics and this is a pure data I/O
> + * that doesn't require any metadata updates (including after I/O completion
> + * such as unwritten extent conversion) and the underlying device either
> + * doesn't have a volatile write cache or supports FUA.
> + * This allows us to avoid cache flushes on I/O completion.
>   */
> -static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua, bool atomic_hw)
> +static inline bool iomap_dio_can_use_fua(const struct iomap *iomap,
> +		struct iomap_dio *dio)
>  {
> -	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
> -
> -	if (!(dio->flags & IOMAP_DIO_WRITE))
> -		return REQ_OP_READ;
> -
> -	opflags |= REQ_OP_WRITE;
> -	if (use_fua)
> -		opflags |= REQ_FUA;
> -	else
> -		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> -	if (atomic_hw)
> -		opflags |= REQ_ATOMIC;
> -
> -	return opflags;
> +	if (iomap->flags & (IOMAP_F_SHARED | IOMAP_F_DIRTY))
> +		return false;
> +	if (!(dio->flags & IOMAP_DIO_WRITE_THROUGH))
> +		return false;
> +	return !bdev_write_cache(iomap->bdev) || bdev_fua(iomap->bdev);
>  }
>  
>  static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> @@ -340,52 +333,59 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> -	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
>  	const loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
> -	blk_opf_t bio_opf;
> +	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  	bool need_zeroout = false;
> -	bool use_fua = false;
>  	int nr_pages, ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
>  
> -	if (atomic_hw && length != iter->len)
> -		return -EINVAL;
> -
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
>  
> -	if (iomap->type == IOMAP_UNWRITTEN) {
> -		dio->flags |= IOMAP_DIO_UNWRITTEN;
> -		need_zeroout = true;
> -	}
> +	if (dio->flags & IOMAP_DIO_WRITE) {
> +		bio_opf |= REQ_OP_WRITE;
> +
> +		if (iter->flags & IOMAP_ATOMIC_HW) {
> +			if (length != iter->len)
> +				return -EINVAL;
> +			bio_opf |= REQ_ATOMIC;
> +		}
> +
> +		if (iomap->type == IOMAP_UNWRITTEN) {
> +			dio->flags |= IOMAP_DIO_UNWRITTEN;
> +			need_zeroout = true;
> +		}
>  
> -	if (iomap->flags & IOMAP_F_SHARED)
> -		dio->flags |= IOMAP_DIO_COW;
> +		if (iomap->flags & IOMAP_F_SHARED)
> +			dio->flags |= IOMAP_DIO_COW;
> +
> +		if (iomap->flags & IOMAP_F_NEW) {
> +			need_zeroout = true;
> +		} else if (iomap->type == IOMAP_MAPPED) {
> +			if (iomap_dio_can_use_fua(iomap, dio))
> +				bio_opf |= REQ_FUA;
> +			else
> +				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> +		}
>  
> -	if (iomap->flags & IOMAP_F_NEW) {
> -		need_zeroout = true;
> -	} else if (iomap->type == IOMAP_MAPPED) {
>  		/*
> -		 * Use a FUA write if we need datasync semantics, this is a pure
> -		 * data IO that doesn't require any metadata updates (including
> -		 * after IO completion such as unwritten extent conversion) and
> -		 * the underlying device either supports FUA or doesn't have
> -		 * a volatile write cache. This allows us to avoid cache flushes
> -		 * on IO completion. If we can't use writethrough and need to
> -		 * sync, disable in-task completions as dio completion will
> -		 * need to call generic_write_sync() which will do a blocking
> -		 * fsync / cache flush call.
> +		 * We can only do deferred completion for pure overwrites that
> +		 * don't require additional I/O at completion time.
> +		 *
> +		 * This rules out writes that need zeroing or extent conversion,
> +		 * extend the file size, or issue metadata I/O or cache flushes
> +		 * during completion processing.
>  		 */
> -		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
> -		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
> -		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
> -			use_fua = true;
> -		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
> +		if (need_zeroout || (pos >= i_size_read(inode)) ||
> +		    ((dio->flags & IOMAP_DIO_NEED_SYNC) &&
> +		     !(bio_opf & REQ_FUA)))
>  			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
> +	} else {
> +		bio_opf |= REQ_OP_READ;
>  	}
>  
>  	/*
> @@ -399,18 +399,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	if (!iov_iter_count(dio->submit.iter))
>  		goto out;
>  
> -	/*
> -	 * We can only do deferred completion for pure overwrites that
> -	 * don't require additional IO at completion. This rules out
> -	 * writes that need zeroing or extent conversion, extend
> -	 * the file size, or issue journal IO or cache flushes
> -	 * during completion processing.
> -	 */
> -	if (need_zeroout ||
> -	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !use_fua) ||
> -	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
> -		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
> -
>  	/*
>  	 * The rules for polled IO completions follow the guidelines as the
>  	 * ones we set for inline and deferred completions. If none of those
> @@ -428,8 +416,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  			goto out;
>  	}
>  
> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
> -
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
>  		size_t n;
> @@ -461,7 +447,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> -		if (WARN_ON_ONCE(atomic_hw && n != length)) {
> +		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
>  			/*
>  			 * This bio should have covered the complete length,
>  			 * which it doesn't, so error. We may need to zero out
> -- 
> 2.31.1

