Return-Path: <linux-fsdevel+bounces-27483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B7961B66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB73B22D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DB288D1;
	Wed, 28 Aug 2024 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IiDIPTUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26C17C77
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808171; cv=none; b=oKVa/U3W5UTMdDGpY1jjCWzz9KvCWlpJbIs8uhe+j1Xj74KElhOoOqtU17vb1tSP3NpEJj7A3uftFosxIV+bm/hUWy9IMtxny1EoRx/zGuXUfJ2pk57BjuFCv0+UWMAaRDiULDyb6oOL3VXwlLu9NzXgimd6UmMmB4k6sCnVYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808171; c=relaxed/simple;
	bh=t/8mdTh6gdtbt01wuMO64yJM+L3ypGJ5d06cOzYjrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPcXCVrQReWAj/MQ//oABkZtKeWWFsx3RFR6jIIRLgW9UG5QKleONgM6S6UYQ3p/22kQg4jZFqm66ubAW47HMypAoTD7neCRn3d/dS7pE4Q9hgIGtHjwW88TaT6nMzMLMTEDQc13zAnbL2nccdav2zaaXTfuIfRRSSW90Zth24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IiDIPTUX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201ee6b084bso52924385ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724808168; x=1725412968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vpOrSNCAb7kibKZbP8DZeqVzpgFFh0MSLO6ZCvDwN3Q=;
        b=IiDIPTUXT8CV0k2yW4/Vhm6TbIvdfB8rm0dBtM3LPx3GHsRp7oOWRlIojp7EZe5i1U
         qhnqEqI7Z70BiaX/1enKfjnxfrgygZZaNtMOmZERAIRyGgcWifSjpr0AfBBUKkt5977b
         q76zjivgAe8jSYxfs/uRydcFobldMUd+H69PhEAni9twhQQZ6F36ha8NFDQDRqWW29D5
         YG/eHDbt7aW4myetEvJFlOZiamkuPPJeQcdouW/dnMDWpbIaWMERC2RMVSUFt6/tFz85
         zneWsp/xMQdc+M4KJlW16Gt7RsDtBAAKg2tfxMRjs71sQmi1zWgNZ7UhpGMGlzqSGCK0
         yTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724808168; x=1725412968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpOrSNCAb7kibKZbP8DZeqVzpgFFh0MSLO6ZCvDwN3Q=;
        b=XesgcvCtPFVFMaBNXKrtQwMajmtBBpf8NeaaaNNsmZWbJnxF0IYit2avIY5dTrxXCx
         m1kkGih33SRjfT1Xx72KxR61smPBKlGJGb2FS7GU1tWUNE7OeWnQMeMKhCPKPEo2KcaZ
         dZqwtQEWFWLTWUQ8i0pskneYMzTyP1HJ3j33iINLRxdtcSSmtqfte9Afus+TX6QXvC6h
         eUTN0+lB/DM/GXW+cHde4nRxXezq5HpivcolSvA1wFv8JCfSyfXBFYIqgIq5xRrvDdhK
         8Dj09xuWxkZHKfutQwL2E+pY9mHKpTtDXIy3VYgawlhkxQsQWm+rGtEYjdT8S9LkEXfU
         pjuA==
X-Forwarded-Encrypted: i=1; AJvYcCVsjKh4LAAwqXJa2kpwzjv50BdY0wlrC6/nuuMGkSLF0F1W+PtsdsH9daP33287TzlfNXzlqWn7v9+8HK5+@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLbzW6wIho57O+SK5TxSDcsYjWz+zPtPxyegT6eaVHeFpxjI0
	0oZCBlGjtjV+EeFM8HiJGeJNTCJehn3u86vvOAsTnUaDfPsEs7CZeLnkO8VRT6s=
X-Google-Smtp-Source: AGHT+IH7D8Ktnmir4wr3BnYlf5JWxP3XKSCuqAE4RMd6h0PAjv0p8Hq4vlEgPVz6XOAWv5QS6i9H3g==
X-Received: by 2002:a17:902:ec8e:b0:1fd:9e6e:7c1f with SMTP id d9443c01a7336-204f9c4fa77mr6223265ad.56.1724808168314;
        Tue, 27 Aug 2024 18:22:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567912sm88940755ad.33.2024.08.27.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 18:22:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj7OX-00FBJf-0L;
	Wed, 28 Aug 2024 11:22:45 +1000
Date: Wed, 28 Aug 2024 11:22:45 +1000
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] Block: switch bd_prepare_to_claim to use
 ___wait_var_event()
Message-ID: <Zs575QSPazeJRzAy@dread.disaster.area>
References: <>
 <ZsQZHZ0y6qMJGaLQ@dread.disaster.area>
 <172419075958.6062.14405334545688254538@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172419075958.6062.14405334545688254538@noble.neil.brown.name>

On Wed, Aug 21, 2024 at 07:52:39AM +1000, NeilBrown wrote:
> On Tue, 20 Aug 2024, Dave Chinner wrote:
> > On Mon, Aug 19, 2024 at 03:20:39PM +1000, NeilBrown wrote:
> > > bd_prepare_to_claim() current uses a bit waitqueue with a matching
> > > wake_up_bit() in bd_clear_claiming().  However it is really waiting on a
> > > "var", not a "bit".
> > > 
> > > So change to wake_up_var(), and use ___wait_var_event() for the waiting.
> > > Using the triple-underscore version allows us to drop the mutex across
> > > the schedule() call.
> > ....
> > > @@ -535,33 +535,23 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
> > >  		const struct blk_holder_ops *hops)
> > >  {
> > >  	struct block_device *whole = bdev_whole(bdev);
> > > +	int err = 0;
> > >  
> > >  	if (WARN_ON_ONCE(!holder))
> > >  		return -EINVAL;
> > > -retry:
> > > -	mutex_lock(&bdev_lock);
> > > -	/* if someone else claimed, fail */
> > > -	if (!bd_may_claim(bdev, holder, hops)) {
> > > -		mutex_unlock(&bdev_lock);
> > > -		return -EBUSY;
> > > -	}
> > > -
> > > -	/* if claiming is already in progress, wait for it to finish */
> > > -	if (whole->bd_claiming) {
> > > -		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
> > > -		DEFINE_WAIT(wait);
> > >  
> > > -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> > > -		mutex_unlock(&bdev_lock);
> > > -		schedule();
> > > -		finish_wait(wq, &wait);
> > > -		goto retry;
> > > -	}
> > > +	mutex_lock(&bdev_lock);
> > > +	___wait_var_event(&whole->bd_claiming,
> > > +			  (err = bd_may_claim(bdev, holder, hops)) != 0 || !whole->bd_claiming,
> > > +			  TASK_UNINTERRUPTIBLE, 0, 0,
> > > +			  mutex_unlock(&bdev_lock); schedule(); mutex_lock(&bdev_lock));
> > 
> > That's not an improvement. Instead of nice, obvious, readable code,
> > I now have to go look at a macro and manually substitute the
> > parameters to work out what this abomination actually does.
> 
> Interesting - I thought the function as a whole was more readable this
> way.
> I agree that the ___wait_var_event macro isn't the best part.
> Is your dislike simply that it isn't a macro that you are familar with,
> or is there something specific that you don't like?

It's the encoding of non-trivial logic and code into the macro
parameters that is the problem....

> Suppose we could add a new macro so that it read:
> 
>      wait_var_event_mutex(&whole->bd_claiming,
> 			  (err = bd_may_claim(bdev, holder, hops)) != 0 || !whole->bd_claiming,
> 			  &bdev_lock);

.... and this still does it. 

In fact, it's worse, because now I have -zero idea- of what locking
is being performed in this case, and so now I definitely have to go
pull that macro apart to understand what this is actually doing.

Complex macros don't make understanding the code easier - they may
make writing the code faster, but that comes at the expense of
clarity and obviousness of the logic flow of the code...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

