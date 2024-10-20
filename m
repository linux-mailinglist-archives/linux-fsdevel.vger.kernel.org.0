Return-Path: <linux-fsdevel+bounces-32439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE359A532B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8B283292
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC582866;
	Sun, 20 Oct 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA223NV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7463E49E;
	Sun, 20 Oct 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729413765; cv=none; b=NJmL5b0w6p7zyKrd9kAvx378hLx3+J7TtcJIvfwShyChOPOjL4NH6GpxQeE1+5hFivyfOTADxU4hw/1o/Kmr8Aj0EyPqZWslibg/WDSARfw5ubfqMnLybXAoMcZDkPKzlBio1LyOESK9zdyRash+jOVj9hqK2OK3mDW6ezyLh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729413765; c=relaxed/simple;
	bh=vNWd26yYL7mDXS1sgc8y1wS2DTBrq5bkosW7IMvvkZY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qbB0VLgsH3sRhKp/Xm1dyAp4a/xW/4FliP+y+3j0GgabfV4TnJ2yWEgbZjNjZ++CHlBawOqlZMhZpvNTTIvUqvAp51oc+0SwStxpwEhBr9nA+BFU7pomktKK27v0rHfYHWuz6MJfi1ItnumZcwdeX6qtyoTlcJ/SdJYSt/yUL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA223NV7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbca51687so36074215ad.1;
        Sun, 20 Oct 2024 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729413762; x=1730018562; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3BsjchRbolRCeUrwqYNfuaPB9wUJioV3DERXJycmNZE=;
        b=aA223NV7zeXnvuqGNfmiibc1FLsyAD7JGyEd1/KD5tmCOjr/aKJoUzYUdRwW1Ga316
         /nKNmXr6kF3mumELXDhMDTEDavWvY4nVOTuQF2ygahfz92P1M7CBMQ3+2JooB47CE+QV
         g1kqyt5ME3MPMXiA8Ft/FUdQzwRq4IcNEFcidrcrBgMi/3WB6faIdnx8dsrZumoe5z9+
         quQxNTalBz4dsN8fMEBAkaySkdDRNgFSQsBfNqWjiI7HrKIWKYsUFHZ04BzR+al7+rfp
         v+FGl2y4cWTKU28ZzuXWTo9w5AR6Sav4Bw44svDRoPBf50dioImfyBw80jQi4XLHSaND
         HqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729413762; x=1730018562;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BsjchRbolRCeUrwqYNfuaPB9wUJioV3DERXJycmNZE=;
        b=DGtQYb9vXko8k4cGbsnuXHxhD4IIAUybEXQ2f66Qxs+4mR75cGV0Rv985t2yml4FTe
         gqWaTjj/R40Xn4KJoKi3Z/U5OOHIqRpExgqUjmQKUU0FoNOp/3pixQs+uLCdCngvwYH5
         36eAwO8yJTpVYDjNecSD7fwnsAOfLtMDRk5YBM8zXwVlEZbGwlhqueL2Qhno/Hl1rhxP
         R7YRwIBCMgHDOWoKVAxovjtOJvCnA0bgn7+GEJegsm8rIcH2wVIHgidWlpQbu0Zc9ZDZ
         vTPthNHBeNVHEQDKUTSRjjYPtR5jK7YGAr6RCyaT0fxrAkx86Jr9r8htVU9q5eIWDaxl
         ft8g==
X-Forwarded-Encrypted: i=1; AJvYcCVXGE6o/O5PSZrdmsIEFbCeQRqr/62iU0eHeBjBWE7VJGlc6eWhnXUTzGeOAez75Q9WoDJYuO30TmL+@vger.kernel.org, AJvYcCWZ74+d7snE1xUPE75ped6KiJcnCCXPliCf184la8LHZ49O/p04Qctw9dtPSkVwF23K1sjDsGi/QcufLxNt@vger.kernel.org, AJvYcCXUAixytvu4LW5n+6iUv7R9gWpOOq3wBFIshiAGImEDQEvlfqgJhznc2tmAU+fIocyqx3e/1sbLixYcqCWx@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8KVcNLqFRXcRTP3gXXg8dm6Did8T36Z9O+rUglnJnTMrME5i
	AwSGgQsouvq513U1B3KZQXorAb73yPERZIgyEJALbAv8xHjIMrFZ
X-Google-Smtp-Source: AGHT+IH2vgQRFWfX/nHs5u1VRrLwo0Tbkm3qpuUq21ijO0NPK7XCTEF17dVcZ5ZgjIfJYcdQGOHCuA==
X-Received: by 2002:a17:903:2311:b0:20c:e262:2568 with SMTP id d9443c01a7336-20e5a70d7bfmr110782945ad.5.1729413762247;
        Sun, 20 Oct 2024 01:42:42 -0700 (PDT)
Received: from dw-tp ([171.76.81.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f32e5sm7052325ad.248.2024.10.20.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 01:42:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de, martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org, ojaswin@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v10 5/8] fs: iomap: Atomic write support
In-Reply-To: <20241019125113.369994-6-john.g.garry@oracle.com>
Date: Sun, 20 Oct 2024 13:51:48 +0530
Message-ID: <87sesrgp5v.fsf@gmail.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com> <20241019125113.369994-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
> flag set.
>
> Initially FSes (XFS) should only support writing a single FS block
> atomically.
>
> As with any atomic write, we should produce a single bio which covers the
> complete write length.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  .../filesystems/iomap/operations.rst          | 12 ++++++
>  fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
>  fs/iomap/trace.h                              |  3 +-
>  include/linux/iomap.h                         |  1 +
>  4 files changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index b93115ab8748..529f81dd3d2c 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -513,6 +513,18 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>     if the mapping is unwritten and the filesystem cannot handle zeroing
>     the unaligned regions without exposing stale contents.
>  
> + * ``IOMAP_ATOMIC``: This write is being issued with torn-write
> +   protection.
> +   Only a single bio can be created for the write, and the write must
> +   not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
> +   set.
> +   The file range to write must be aligned to satisfy the requirements
> +   of both the filesystem and the underlying block device's atomic
> +   commit capabilities.
> +   If filesystem metadata updates are required (e.g. unwritten extent
> +   conversion or copy on write), all updates for the entire file range
> +   must be committed atomically as well.
> +
>  Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
>  calling this function.
>  
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f637aa0706a3..ed4764e3b8f0 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   * clearing the WRITE_THROUGH flag in the dio request.
>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua)
> +		const struct iomap *iomap, bool use_fua, bool atomic)
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> @@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  		opflags |= REQ_FUA;
>  	else
>  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> +	if (atomic)
> +		opflags |= REQ_ATOMIC;
>  
>  	return opflags;
>  }
> @@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> -	loff_t length = iomap_length(iter);
> +	const loff_t length = iomap_length(iter);
> +	bool atomic = iter->flags & IOMAP_ATOMIC;
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
> @@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> +	if (atomic && length != fs_block_size)
> +		return -EINVAL;

We anyway mandate iov_iter_count() write should be same as sb_blocksize
in xfs_file_write_iter() for atomic writes.
This comparison here is not required. I believe we do plan to lift this
restriction maybe when we are going to add forcealign support right? 

And similarly this needs to be lifted when ext4 adds support for atomic
write even with bigalloc. I hope we can do so when we add such support, right?

(I guess, that is also the reason we haven't mentioned this restriction
in description of "IOMAP_ATOMIC" in Documentation.)

-ritesh


