Return-Path: <linux-fsdevel+bounces-30852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7698ED42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B4E2821C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E173153BE8;
	Thu,  3 Oct 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="L4yUiyjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4761531E1
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952342; cv=none; b=FzgoZ4/ZSAan6V9jChGfnXGw6WUBDjHdN7frpdnJNX0EHx7ibt10KB4h+i+FVObXXumcdOSTqSbOjVOJkpBwj4HcVhqDhhMrj7ixyUhu9pZlhrg2pi/fcL001Zp7Nd8wSrP3CoKv80rEKh8kKG8Y09OCQqqUAnb9CpE1F8apZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952342; c=relaxed/simple;
	bh=JnDst/N3EU8yXgVsCAnf0R6OPYnWSUN7cuQxkqSLUqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9ePOsN556zvIy5omVWyrjIQriq+ETs+mooj+MGuFCVZQxwhjOYgJ5vLGPAOi+OJt3KidrHW1T1sa4NB1yAL2JQMDbKQyEhnXEYMZBSxrayQYNfG0fb6GogTDFHMG1KVvSpGtDJ/5SKKnSrZ1HpM+17kP8KQkjrLUbpE0U7LaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=L4yUiyjl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so669186a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727952340; x=1728557140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6UEGl17TzSnxTVIe1qUXkNcfbf0xAa9jJkDuFXexI0=;
        b=L4yUiyjlYspY5GbjjV57mDjnDtLz4boQhMHNQW2JnEwIB6/kKcut3f8DI7c0ajPyV7
         pQ44zRRYaFyZU7P2lqq6ttuT6VBqXekagyHx1dZ5uxTyAfNik+9KEmNippBnL5LU0pu3
         e0SalqI1K4HxavWYuaugt3EDDkM0dbJn0xN1FBFVXN+m/R3yanIKb4Rxet7qnkryKqcg
         OQs2T4j3BTZDFORppiD1iQjpNCNCUN+zPJSLjR0sdgDUzmEmygwRWOXnX0JS3yrk/Nsl
         QzF6v4k0HSt+QYzTw692WR4/5NA7gNnp566Fjtxrndtz5ttTh88zP8aoaknx/yH/99rf
         3jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727952340; x=1728557140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6UEGl17TzSnxTVIe1qUXkNcfbf0xAa9jJkDuFXexI0=;
        b=DpDZXUIf8s25gspUDlVMLphgDJ1KQ/B7ymd0mDOGRg3g/9/LjJA92679bXkVdgK5Tv
         hxE/qCCPxsfCXzpOCe6Lxr3xee/tpOmc4SkQv8woI0FQnwGNhp7XxQZqOdnt0ZCUokMh
         j0rjjaLYuVcRL75scW1Tz6g/RBvZY3f33sB/bVXoCdA7OITk4Bnu0lKurmOCTcdlvumB
         iMdvbyue4V4wtjFZgFfoJolAuxBO0dO1Phc+Z0jwpXtNZTYAix8bx+qvzyKBc+Ez/ZFO
         x4PbZbJQHptNe/gUV9Ep7h/flDn86KA5OnDyMrX3kitzG20sBE9uLAQF5OBrQJQpG9yb
         2PVA==
X-Gm-Message-State: AOJu0YwZ8UdO2HMb5EMWRkRPHCKqAsu9lcAnutd3POdnv/fq0Rl41WgY
	An8Q5xqVD8NElTGyBLPS0msoOZ32sy8pRZRCfxcssHbrnMv728H8flQOG1YgnkDt/DKYVPKYkbj
	E
X-Google-Smtp-Source: AGHT+IGoytEofKifwHVbCQpUDi4tPiiN7+0yohLIMmp0p3RrLmvhOU0hAQk1EofdGGJ9Nht5ooiEog==
X-Received: by 2002:a17:90a:c713:b0:2da:802d:1f95 with SMTP id 98e67ed59e1d1-2e18456b4e8mr7835223a91.5.1727952339868;
        Thu, 03 Oct 2024 03:45:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfad5d15sm1232890a91.7.2024.10.03.03.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:45:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swJKy-00DLpH-1h;
	Thu, 03 Oct 2024 20:45:36 +1000
Date: Thu, 3 Oct 2024 20:45:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3/7] vfs: convert vfs inode iterators to
 super_iter_inodes_unsafe()
Message-ID: <Zv510LDnAtmJFuTA@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-4-david@fromorbit.com>
 <Zv5EcaWsFYHhlMaI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv5EcaWsFYHhlMaI@infradead.org>

On Thu, Oct 03, 2024 at 12:14:57AM -0700, Christoph Hellwig wrote:
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 33f9c4605e3a..b5a362156ca1 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -472,16 +472,28 @@ void bdev_drop(struct block_device *bdev)
> >  	iput(BD_INODE(bdev));
> >  }
> >  
> > +static int bdev_pages_count(struct inode *inode, void *data)
> 
> This are guaranteed to operate on the bdev superblock, so just
> hardcoding the s_inodes list seems fine here as it keeps the code
> much simpler.

Maybe, but right now I want to remove all external accesses to
sb->s_inodes. This isn't performance critical, and we can revisit
how the bdev sb tracks inodes when we move to per-sb inode
caches....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

