Return-Path: <linux-fsdevel+bounces-36500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A89E4762
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 23:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2399CB2F97E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD718E75A;
	Wed,  4 Dec 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="d5FJM+ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EA1531E8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344554; cv=none; b=K6jbfIhixIb15KmszeI1q/KdvN6r8OVB63AALu9V/FEh2LIDxqpP0HVf46lIRxQABns+85/YWbgnSTvW1Frck76WSAljYgT6wOPLH7g+Vh9wQM0HL41A6WoAqbuzVdQPHMz5xASBs59zwwLgilzdT+qBvI989STpxmcbV+lc79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344554; c=relaxed/simple;
	bh=dwsIj7rF/UbLV/atW4hBLLySXtSRMmClsIp+6KLmPr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZgzjIRsyJSUJIaBbzrMU6R8hq6WR9GlFMSCmYomQ73SpzS+/xDJRIHMAoYjCM78yuGxwS488q90Adkx3KWSUgU3KFaS4eyoSZRYDGrVvmUF7PlE92NfObMu9bKaxs2/vDwzhSu1kO20rR30bGZD3Emvclg5efcKRSigFeeY2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=d5FJM+ft; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fcf8406d8bso1126393a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 12:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733344552; x=1733949352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQZ3ixdeegE5/EEa0czgAF/6xs+UOqPhbexb5HMQfZM=;
        b=d5FJM+ft6mEUfFxmCgRrdXo6XqSObj5q/yzraF5A/15PbyFM39ukFlpOSSPb6tV0Qc
         uIFAGYV0phdUVPHvI6U4SmYOJLn1AxJCYyAryAiq55FWR5+8VeYP6Rbpx9FROHbCO3Li
         Tikhb+UM4YdpZiRPiRWz8ff4oo+zvVLTF92Ju4Ob+M8p6c0FhH4Z0Cpj7YDEl7/FFSxU
         84LhvhnTnTq52rR2dhWIc68BXB4eQCP0Iscwti40qA7OWGEEr3a5xA2mDld5N2fSBma3
         ci01Nw+MgyMNDp0+w9bN5R1eL2Xh6c5TCfEUy8H3i7GLJ8ZHiKAa0LmyYO1UmFi4e4vD
         zJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344552; x=1733949352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQZ3ixdeegE5/EEa0czgAF/6xs+UOqPhbexb5HMQfZM=;
        b=lQ5rwex1GMmSQLCcchNLf8nXmsceMtzKdGtFNxfAZasndKkwVsf+ze9MIXvoaoWDWK
         Pszmu2RTDb0gJ0LQT1oXv0mLEcNVXpFLJbNCCB0glYrHpksUclR9wr4bfRMR7Rz/8dcY
         p7wVaXhj1gRVfq5RCryMAaqeTmpeqqhWdOW2pPOkHByHAfC0XPMFy/cbblx8Yf49CHiO
         3J7MYlWtlSAyKmGny5aYT5OMN8VDWwbd4UwYLgi3EN8sg+aK6v9mMXCByqDFwvs7ipMG
         NAXBP7+0Qi2/+2YMLdBn/iMWvt154AVtdxEgA60YV5hQju4igSQiMdIkMWAv36WiKV/k
         EaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDp9A3mWmujFrGkpK/773kW0O97JcIxVvI098AbIu3f0ZEY0m0K5o2njnvGoYSpah0z2o/H1Do12HEG4My@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9KvBvSFbL6WCMxWUok+B4qxny79iDk9gXWbZOWJ0dkj81Upx
	MngIVJXXoPLgwLuJ4sEZ4CTLn5YNrJzVksEEPVWHQAwbZfbM0xGSH8B9sT8tCDI=
X-Gm-Gg: ASbGnct/61FdZ2fuo6JsQOncHZ9R5YVs2AUgqIOOtRvvTAOfnzjhCu9qBI5OFrKAm8W
	g6oL7ghHAKBGKl16UQwj3og/MrwcJULKfRKL74Y05UMBpkopgqEkaOGaqSDSlMguD2ItEKg66+s
	qNNpf4tTJBFavzAq3iBoiu0opunliu2MTBl5wtIhmyIZUhg7rbuMTLw4vTZa+PJ5c6VKomBR+cx
	KFnCWVmKQKK3I0uKBZZoUuy/PR6aiZDNY2/zLcq/4gJucSirSLjWQ1k8iN2+cYgiC9V8Ae6UR/U
	TbtuKe8M6wNdmfj0/1w1Y0yPbg==
X-Google-Smtp-Source: AGHT+IE5TCbJB7PPg4ebeiry/v/Jkmsv2ke29ZWPC9q48qLA0mTR8XrInBdtFsAWOrWi0r9nNIoepg==
X-Received: by 2002:a05:6a20:96c3:b0:1e0:b319:fc05 with SMTP id adf61e73a8af0-1e17d3a3cdfmr926833637.12.1733344551740;
        Wed, 04 Dec 2024 12:35:51 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d5be4sm11941204a12.3.2024.12.04.12.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:35:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tIw65-00000006gBh-2ey1;
	Thu, 05 Dec 2024 07:35:45 +1100
Date: Thu, 5 Dec 2024 07:35:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <Z1C9IfLgB_jDCF18@dread.disaster.area>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204154344.3034362-2-john.g.garry@oracle.com>

On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> Filesystems like ext4 can submit writes in multiples of blocksizes.
> But we still can't allow the writes to be split into multiple BIOs. Hence
> let's check if the iomap_length() is same as iter->len or not.
> 
> It is the responsibility of userspace to ensure that a write does not span
> mixed unwritten and mapped extents (which would lead to multiple BIOs).

How is "userspace" supposed to do this?

No existing utility in userspace is aware of atomic write limits or
rtextsize configs, so how does "userspace" ensure everything is
laid out in a manner compatible with atomic writes?

e.g. restoring a backup (or other disaster recovery procedures) is
going to have to lay the files out correctly for atomic writes.
backup tools often sparsify the data set and so what gets restored
will not have the same layout as the original data set...

Where's the documentation that outlines all the restrictions on
userspace behaviour to prevent this sort of problem being triggered?
Common operations such as truncate, hole punch, buffered writes,
reflinks, etc will trip over this, so application developers, users
and admins really need to know what they should be doing to avoid
stepping on this landmine...

Further to that, what is the correction process for users to get rid
of this error? They'll need some help from an atomic write
constraint aware utility that can resilver the file such that these
failures do not occur again. Can xfs_fsr do this? Or maybe the new
exchangr-range code? Or does none of this infrastructure yet exist?

> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> jpg: tweak commit message
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b521eb15759e..3dd883dd77d2 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if (atomic && length != fs_block_size)
> +	if (atomic && length != iter->len)
>  		return -EINVAL;

Given this is now rejecting IOs that are otherwise well formed from
userspace, this situation needs to have a different errno now. The
userspace application has not provided an invalid set of
IO parameters for this IO - the IO has been rejected because
the previously set up persistent file layout was screwed up by
something in the past.

i.e. This is not an application IO submission error anymore, hence
EINVAL is the wrong error to be returning to userspace here.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

