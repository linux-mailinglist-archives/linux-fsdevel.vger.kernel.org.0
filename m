Return-Path: <linux-fsdevel+bounces-13820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A248741B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FEA1F223E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567341AAD3;
	Wed,  6 Mar 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a5QMrMSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE11A29A
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759693; cv=none; b=ceUzMPI7qdCxZMKJ9QTuKzd3+h+J3RXmXcIsBuhseMPE30s84f89DcKD3fcCJTxRVjmLLuAAtcTReijP4CwbBKcdlt5Pt7X8BnI55/yechb6yCM5zKsCQ/UYdboNmD3GfgfbmW2KcnO3IyqoLwzFJ8KVlkz7smR5ITCDop/5SdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759693; c=relaxed/simple;
	bh=HlvIehcW7DL2ZkTuZYSlHhQXYbpHC0zj0KWYZTviIpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSp5BXpmwaItDvVaXaFZtLgZ1ReL1v2hoFQqL5DDfa9pvYtoRaxXMJqK4dcddA07y8h49RNOg4WdPUB+pCB0+uS3Tm1V7gglomJXxT7IQv4ser5BFv3K/pT/J+r5ziW0dMr5WNpSjJCCbZdzYEsgSv7fyCiFV4bVh3DEOJO7puI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a5QMrMSk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e64c3bb130so146467b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709759691; x=1710364491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqhjGVQ8jE8dziHNEPcBuEnJh6YM6o6ZWh6K+R5yz1M=;
        b=a5QMrMSkCh6CKxSZp1aoMlsWOh1/LdslQA8sbOLyLO3ibrMd6x/h0JqfrHeUOgWa3J
         L2KBWDgR/51+DeX0Bp/LE2FiKIAdtDpbfigFomyfaR48wFJxkh19s7Uz/Cvg6F/lpdLh
         pfY3hnq6G4woDGNTNVlZ+kkcj5qJRCngnVAy+gkb868EWY5EU04VMoO1sIADCHOqt0pb
         0dcvTCDjJerRPi3a5DXq74ZDszeyTNeI58Z29vZ1ArrGPUohsZW1UeNBPoG7+jIry6gX
         hmB5veaCo5PFqElLML5tRN7hI14+AHMRiFkTvu8fBtN2WcUyHORPEkKzNvapQJQmCyad
         L5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759691; x=1710364491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqhjGVQ8jE8dziHNEPcBuEnJh6YM6o6ZWh6K+R5yz1M=;
        b=ImXsHe6IR5vid6LzBJxos2nmMOCKV8Qt8DZO94fauYcd9HibQv4rK+Hf+h45p3aVyN
         CKKevwiENijAjnT8M6ZFVjXTyq5QW7T/OM8Z4GwZeB4JYby0T7/n9id7KcbN8aLLSdW0
         eyd3+QIBpK5wwSAcFXYCu0knmDBj598AfVbZlyA8HF5ET0PeHr0VSe6yN1l6KYyLeL/L
         Y51Aaug7fE5LnzhBY5x5oDObg/Z+VOoPqTot+EHm6y0K2BSLQxU23IUEYfy6hakrrOrL
         g75lMrFkDdj5yV+tf5pTwb9i/HXkcfNy0lK+kZrGC3zuk5IcVOnJImcLhfNh/IIP3tLD
         a9lg==
X-Forwarded-Encrypted: i=1; AJvYcCUxX+BD+20dEDYmZz/1Ozto8CN4FNyf1VC8y3BdSSxf6Hiy8HiL1ABvQxzFprIhrLQdZzH9B4CgDo8DMGTRNz41yPie20v5C6FrHHvB+Q==
X-Gm-Message-State: AOJu0YxpgprbOL9uWaeGIY03C2b12L/8sfz6k9tO3WwkxMr3zM48Tw1d
	ovhqR7jgIB6wd3Bs9+5ldJ9KIF4kC3d5Nwyz5uwCZ89JiqP5cCwQoH2obovMqMomMPE3qlVaZ5B
	N
X-Google-Smtp-Source: AGHT+IH/HqdsN5E4yHe5JC1g3zqWSwIIHXA5eCXfP7jkdLhyjmJz4hhQirNSqS0uE/Icr0g3GgFBXQ==
X-Received: by 2002:aa7:88cd:0:b0:6e5:561b:4670 with SMTP id k13-20020aa788cd000000b006e5561b4670mr18155480pff.30.1709759691277;
        Wed, 06 Mar 2024 13:14:51 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id y133-20020a62ce8b000000b006e45a0101basm12036767pfg.99.2024.03.06.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:14:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhybA-00Fy7Q-1A;
	Thu, 07 Mar 2024 08:14:48 +1100
Date: Thu, 7 Mar 2024 08:14:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 07/14] fs: iomap: Sub-extent zeroing
Message-ID: <ZejcyPPX3bVdvJyV@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-8-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:21PM +0000, John Garry wrote:
> For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
> sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
> unwritten.
> 
> This will be important for atomic writes support, in that atomically
> writing over a partially written extent would mean that we would need to
> do the unwritten extent conversion write separately, and the write could
> no longer be atomic.
> 
> It is the task of the FS to set iomap.extent_shift per iter to indicate
> sub-extent zeroing required.
> 
> Maybe a macro like i_blocksize() should be introduced for extent sizes,
> instead of using extent_shift. It would also eliminate excessive use
> of xfs_get_extss() for XFS in future.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 14 ++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..733f83f839b6 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
> -	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	unsigned int zeroing_size, pad;
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
> @@ -288,6 +288,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> +	zeroing_size = i_blocksize(inode) << iomap->extent_shift;

The iomap interfaces use units of bytes for offsets, sizes, ranges,
etc. Using shifts to define a granularity value seems like a
throwback to decades old XFS code and just a bit weird nowdays.  Can
we just pass this as a byte count? i.e.:

	zeroing_size = i_blocksize(inode);
	if (iomap->extent_size)
		zeroing_size = iomap->extent_size;

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

