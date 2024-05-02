Return-Path: <linux-fsdevel+bounces-18467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65E68B9329
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 03:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E196B1C2189C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7D1643D;
	Thu,  2 May 2024 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XWZdedso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65F134B2
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614216; cv=none; b=VL7CJlQsIDqvMaUmNtob04Sb9JR9HLBK+WNUOegAMqq96RygVsR7ElIbVLSqyGGj197X9k4KMc4gdn57hAo5Xu3qnYIkRFh22LbQfXGPJRFCNvXfSStZQ0SNqfCOOPq4svVyJtf/KaosJtEumKtXIDl41cEfb6WRl8dnzwWSeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614216; c=relaxed/simple;
	bh=Bl7xaTCifxr7O+80tnD004gRnMC1H8XKmKgcszt6Fz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJlGYYCi+rY6wYII3FXoejhgUYj132DJRSttkqBSPDheVxgegaE4y1Pz+CO0gtf3DnoGaMkbnJTGrhjDbbkwp3Oa3nIrHq+CHKYI1YyaDoAflOBh4o2moKNCQqdAwALEKlp5K8dbiwDyI4tJUugGrJEugyYDviXNdrRiCFu2H3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XWZdedso; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4f341330fso68556555ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714614214; x=1715219014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RD76l1MXA6SInQldy5GmBoit4g9TYS57g8CJpm+KZ4=;
        b=XWZdedsoHnlkJxV4n0lkLQliRBa90kXdazvc/WcX9WR1Ya6vLiso4r/sLDiT4FuQY8
         xmBITfQD7J15ncfBWt3Ve5HRnhzEWwo4jJDaMEQze8TwbPZJkPzIiBP1sQ3mJybywaWt
         ZvjAX49KV4I6LT+v4b7Piuac7RK7/fme6o/utUywF2XaWyRCN96VcSjq7I+By7g0dYUN
         FYqWeqHNsT+itdCXvaa3U0QKdA7KpgCTp48o0d+ZnYqdOHo9g1pMkqsqvGXOQjGWjAqF
         27rblKUrmU46ajuSJgfEaZUJI31lgSBLJQTyTwZntiLqmTqEUkd+YjgISv/Q1G4Ye7qB
         aWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714614214; x=1715219014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RD76l1MXA6SInQldy5GmBoit4g9TYS57g8CJpm+KZ4=;
        b=ASMwTuXt/mtM9uBPwmrYuF5lNwT+292xNOal4BtGpa4sjoEmGX9AwB6OkVTjuaomfI
         tVz83X/EsUhGVPpqyech5nIRyGEpCm8jktG3fG3ueOsPwAEB4chO9A870qFPz4k1fter
         O2hauLqQwo81/5aSlcyxFz/A1cxc53cfs+q8nk7YjjXbbVNCJSj/md3717qqmQp7S7oV
         v8UcMajYr7gWDt8oXhLuVW9bCldx2+TE6qLFkM9Sn68tU8IzDV6ADwCVrq9Sl1w/kA/F
         kfojT2jHHshJylNwalRh0vtfZE7c6sj0iwF/wnxhxPC7GsMBVgZBJZZcQqB7xa9ewblN
         jtrg==
X-Forwarded-Encrypted: i=1; AJvYcCVqvSejHI8dX7Re9cMRKpAC9UCkE3zLpiuZV3Ru4wuQL95nYgGqMnmaNjN+9Yu1S5fph+hx1FIj3ZWEWhADRWhkZaOSP9Q9C6t5xG/qzQ==
X-Gm-Message-State: AOJu0YxfXQg9FKqb8DVF/0zvmFvR6w8BiWwvwAdFSYkthlXg6UpiO73H
	D7GxP5bF05smdydBSts3aCaTz3j5aNvdalmgfZ3CCxcfkqA9CIPvyHldJy8btUI=
X-Google-Smtp-Source: AGHT+IGF6Yr3/AQWnhsY0aR4NlbeEwPWwmPkMtkvwxYyCdykGHR3PyMA0nyTE/BtT7prN/QCnIl6ig==
X-Received: by 2002:a17:903:2444:b0:1eb:3dad:aced with SMTP id l4-20020a170903244400b001eb3dadacedmr4696923pls.11.1714614213756;
        Wed, 01 May 2024 18:43:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001e98f928d0fsm21987plg.10.2024.05.01.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:43:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2LTv-000Oik-0K;
	Thu, 02 May 2024 11:43:31 +1000
Date: Thu, 2 May 2024 11:43:31 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 17/21] iomap: Atomic write support
Message-ID: <ZjLvw3Y5m9AxH71u@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-18-john.g.garry@oracle.com>
 <ZjGfOyJl5y3D49fC@dread.disaster.area>
 <d39c46b7-185c-4175-b909-2ba307c177c9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39c46b7-185c-4175-b909-2ba307c177c9@oracle.com>

On Wed, May 01, 2024 at 12:08:34PM +0100, John Garry wrote:
> On 01/05/2024 02:47, Dave Chinner wrote:
> > On Mon, Apr 29, 2024 at 05:47:42PM +0000, John Garry wrote:
> > > Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.
> > > 
> > > We rely on the FS to guarantee extent alignment, such that an atomic write
> > > should never straddle two or more extents. The FS should also check for
> > > validity of an atomic write length/alignment.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
...
> > > +
> > >   		bio->bi_private = dio;
> > >   		bio->bi_end_io = iomap_dio_bio_end_io;
> > > @@ -403,6 +407,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   		}
> > >   		n = bio->bi_iter.bi_size;
> > > +		if (is_atomic && n != orig_count) {
> > > +			/* This bio should have covered the complete length */
> > > +			ret = -EINVAL;
> > > +			bio_put(bio);
> > > +			goto out;
> > > +		}
> > 
> > What happens now if we've done zeroing IO before this? I suspect we
> > might expose stale data if the partial block zeroing converts the
> > unwritten extent in full...
> 
> We use iomap_dio.ref to ensure that __iomap_dio_rw() does not return until
> any zeroing and actual sub-io block write completes. See iomap_dio_zero() ->
> iomap_dio_submit_bio() -> atomic_inc(&dio->ref) callchain. I meant to add
> such info to the commit message, as you questioned this previously.

Yes, I get that. But my point is that we may have only done -part-
of a block unaligned IO.

This is effectively a failure from a bio_iov_iter_get_pages() call.
What does the bio_iov_iter_get_pages() failure case do that this new
failure case not do? Why does this case have different failure
handling?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

