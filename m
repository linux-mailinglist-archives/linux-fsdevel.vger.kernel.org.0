Return-Path: <linux-fsdevel+bounces-44245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E4A6684A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8703B0255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152601A8F98;
	Tue, 18 Mar 2025 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QI3FYAhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4E190497
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272074; cv=none; b=LnFshWlLKngU/U91jdLLH9lTMg5WTWGcbkYzye1CoOS9n3HlIh4IzzmxOs0Fz/teXe0Vf9Egmvgj57TC+F2/8Hdv2wUP5iP9QzvdbLe6K5QcLhFqdhUlVhGxk5xIf4Wbq4/WczlNhL35J/b5EQDnN3rgbx9SzBMrHpcAf5T0150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272074; c=relaxed/simple;
	bh=srA+q9MSQgaN6WLXZ6Fi+ogQLhqIIEk23l8zby1Wc7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lykUDy8gCWWNUDtf8HoBKTYDjB2KF8jOUol1gYjVmJtRG2uYm2uaTZTjZd+sOvtUf8njrtp3F9joBhCnxXV6cfyQKyom1xyArir4yR9juytevC+wYF+6ygEXEKxbUYGJRsYx0ATUqfhHisaEH0LymY0Loi1I1dJgnpghCUmgUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QI3FYAhu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225a28a511eso85903085ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 21:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742272072; x=1742876872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Bvbi8MEXLRlCCrJ+n1plPSBWAVgIDFdEH1YSugngWM=;
        b=QI3FYAhuf5rGKmOtlqwv3vraK3Sb603QoSjP30pd2TvjxX9nIetTTCb5SFlo8DBW/V
         KGFLbyGuFRxU4x/WvH7y8R6Z931kacye0GuQ6YfpDmv1qrmD47Eair6vxBXFGmago7Mw
         gaFnE1UcuFH7hRX11yIvxYt+K7ikDv1OoHl9hswyL6T1DJ5u2EYndZJVbwwSiOPU8OIO
         xB2XX/BycxYjK4Gx9gvnmglQGb/05cMCwAcM+wrCH9XPRPKOdkADms4sY7RuX4whc0Mq
         hbiKgsS8uv0BQ1rd+UZGs8SVjQOx3/4+vP5IILqcZR1gV2RyoXt/jQVPs4cAouIFh4nK
         E42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272072; x=1742876872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bvbi8MEXLRlCCrJ+n1plPSBWAVgIDFdEH1YSugngWM=;
        b=Z3uSBHQTL0xTJxBi4zJ1QdLscmSXXE5Y7C6owESH+I8ICdtG/Gnn8wWSP+aNm3cVwK
         C50D0/LWMIpneMwPzAXfycrLZtJIR7tPVvPR6sGIPpCRbJ1yXt7SjDfq04MQ6eRHY/7C
         yGi2LT72NJB8jVyLNOhHeUs5XvWK6od9OsKlFaicjULDV2RrXvwRC7oZUe6Frf22cSQ7
         P7VGHzmzSZQfdygip6skBGeZkb1V9sAqrmeQ1wkE/eSI2bKnQkzIFDwmUD1fWh2tBzIv
         Yhpsf/gMkuXjU1K2ynN/7OzTGXjrdLuczwf5TxXu2+eNBHWnOQHuDpT3Qa4o46DoH65N
         t2LA==
X-Forwarded-Encrypted: i=1; AJvYcCXpkWHwcyTLVlCQw4VLl22XFdfKFCIhq5B/uRuXTh3gfxpYrpSc6vqk5+fSECtGSQk8UcKzNbLOLb+u2ozu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43Pu6hu0947WAFo/ILkzCxpKW4WGo6RpimTk68N+PKyX9odLM
	IRaNnSV/q6wOYZQlOiiZ6TQdpMp8H7+32x3aHhrCwoMinjnPHzSfpoTDf+YmUH0=
X-Gm-Gg: ASbGncu2N6+7Qkml+m39RlezMBIMGK9Lobf2UHStmg7Afk7R24rTkZ7wO87v3iwV31t
	FN1vWJ4lRBy/br7VtDpxUz9aEl+ZuWsBbQbhSCj2RrGsYr3Orx/t1ZAOwOSfkRoUdi5/0SIf/Ik
	p6yeWwlFBHON25txXQ3RYD9Vey5np8CN8u/Z7pEqWgNCM2jYOhKjGXaDiJgAQbj42+/e1t1CRMT
	17+HylFi4z4pzw3ooZSsa30i/rqQOKIZzh2Omcv/IASxVIMV/JzVzHQ4fgE6tgOw0oFY3K2nLQo
	u92eQnoinEYzN5qNDqce1yLU3f1WCfNR2JIUBflCO/Q3r+jWNzGiI0uryZq0ZMLwspPy15KXVbY
	mfhl4Qt3yt2iBzgfUXbd6
X-Google-Smtp-Source: AGHT+IEIoB7CIEagexG9dSh2PwOOPrD7z9rjV7q8EIOGmEEOrLTSZBzMWQfJ3dAVwm8AVI/GgNiNmQ==
X-Received: by 2002:a17:902:f602:b0:224:e33:889b with SMTP id d9443c01a7336-225e0a3a5cbmr228469435ad.12.1742272072130;
        Mon, 17 Mar 2025 21:27:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a84besm84363465ad.79.2025.03.17.21.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 21:27:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tuOYO-0000000EZ8R-3bIs;
	Tue, 18 Mar 2025 15:27:48 +1100
Date: Tue, 18 Mar 2025 15:27:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z9j2RJBark15LQQ1@dread.disaster.area>
References: <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
 <Z8eURG4AMbhornMf@dread.disaster.area>
 <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com>
 <Z8zbYOkwSaOJKD1z@fedora>
 <a8e5c76a-231f-07d1-a394-847de930f638@redhat.com>
 <Z8-ReyFRoTN4G7UU@dread.disaster.area>
 <Z9ATyhq6PzOh7onx@fedora>
 <Z9DymjGRW3mTPJTt@dread.disaster.area>
 <Z9FFTiuMC8WD6qMH@fedora>
 <7b8b8a24-f36b-d213-cca1-d8857b6aca02@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8b8a24-f36b-d213-cca1-d8857b6aca02@redhat.com>

On Thu, Mar 13, 2025 at 05:36:53PM +0100, Mikulas Patocka wrote:
> On Wed, 12 Mar 2025, Ming Lei wrote:
> 
> > > > It isn't perfect, sometime it may be slower than running on io-wq
> > > > directly.
> > > > 
> > > > But is there any better way for covering everything?
> > > 
> > > Yes - fix the loop queue workers.
> > 
> > What you suggested is threaded aio by submitting IO concurrently from
> > different task context, this way is not the most efficient one, otherwise
> > modern language won't invent async/.await.
> > 
> > In my test VM, by running Mikulas's fio script on loop/nvme by the attached
> > threaded_aio patch:
> > 
> > NOWAIT with MQ 4		:   70K iops(read), 70K iops(write), cpu util: 40%
> > threaded_aio with MQ 4	:	64k iops(read), 64K iops(write), cpu util: 52% 
> > in tree loop(SQ)		:   58K	iops(read), 58K iops(write)	
> > 
> > Mikulas, please feel free to run your tests with threaded_aio:
> > 
> > 	modprobe loop nr_hw_queues=4 threaded_aio=1
> > 
> > by applying the attached the patch over the loop patchset.
> > 
> > The performance gap could be more obvious in fast hardware.
> 
> With "threaded_aio=1":
> 
> Sync io
> fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> xfs/loop/xfs
>    READ: bw=300MiB/s (315MB/s), 300MiB/s-300MiB/s (315MB/s-315MB/s), io=3001MiB (3147MB), run=10001-10001msec
>   WRITE: bw=300MiB/s (315MB/s), 300MiB/s-300MiB/s (315MB/s-315MB/s), io=3004MiB (3149MB), run=10001-10001msec
> 
> Async io
> fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=libaio --iodepth=16 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> xfs/loop/xfs
>    READ: bw=869MiB/s (911MB/s), 869MiB/s-869MiB/s (911MB/s-911MB/s), io=8694MiB (9116MB), run=10002-10002msec
>   WRITE: bw=870MiB/s (913MB/s), 870MiB/s-870MiB/s (913MB/s-913MB/s), io=8706MiB (9129MB), run=10002-10002msec

The original numbers for the xfs/loop/xfs performance were 220MiB/s
(sync) and 276MiB/s (async), so this is actually a very big step
forward compared to the existing code.

Yes, it's not quite as fast as the NOWAIT case for pure overwrites -
348MB/s (sync) and 1186MB/s (async), but we predicted (and expected)
that this would be the case.

However, this is still testing the static file, pure overwrite case
only, so there is never any IO that blocks during submission. When
IO will block (because there are allocating writes in progress)
performance in the NOWAIT case will trend back towards the original
performance levels because the single loop queue blocking submission
will still be the limiting factor for all IO that needs to block.

IOWs, these results show that to get decent, consistent performance
out of the loop device we need threaded blocking submission so users
do not have to care about optimising individual loop device
instances for the layout of their image files.

Yes, NOWAIT may then add an incremental performance improvement on
top for optimal layout cases, but I'm still not yet convinced that
it is a generally applicable loop device optimisation that everyone
wants to always enable due to the potential for 100% NOWAIT
submission failure on any given loop device.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

