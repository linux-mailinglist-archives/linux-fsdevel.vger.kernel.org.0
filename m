Return-Path: <linux-fsdevel+bounces-27961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D4965312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 00:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43452B219C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C8018E745;
	Thu, 29 Aug 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mz9SVP+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3818E340
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971000; cv=none; b=WysHoE+SJRQ44YU3BjecP1MKK/p7rY2sAzKvhzv8asM4v/5hMTEyurgF+DSxoHa6G6LZPa6D2wX5VDAdpRmlA1Weahl8Wyvmr+/nByICQnIhWWOteXzrSTl2e+L5P3NnettTTRLSgcZIsuymV+I8UWy+sT0PaEybBW5AfCqTXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971000; c=relaxed/simple;
	bh=ociaVD35vSwRGkbwWCfD2uyU09arMskuiNOkbh4amJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6N92wvus15mCFXhoqXIpxP/dSdj/uQ8GxTPYfpbEyKu9NCsBv9sM2aV7YlUZexIqCQFI31SkZsxwFuoa6r7iJFEnyE6UFXfP+ObG5gI4Fi/oIv4xOtZvsuvuHFLmy8eH/VdGfA/3VuRUbS+e0KrDdjAbub+xBMLayrODGvks6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mz9SVP+p; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd76b56e59so447730a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724970998; x=1725575798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOWBznsKRVo1nYJqB/VJ22hNzYibujS7T2yElYKzXrk=;
        b=mz9SVP+pii7cqP0M7R1r1ENhODdTLjJF1fvcIf2X+p50ocvIstHdsxdLhdTE+Dk4DK
         gq6HoIvO31fqjRZW7oJ+fpvV47aQvHcVhYGvkECHNZaAXpjpHZ6PfxXe/dyA9YGpxMAC
         jCbgp2zvSyc5Aehczw8phEAvMf1gzeLET+KO5vx2sJt9MewY+Gr3jdPXG7g/T6sIbY+B
         MGcU5XuyQs/j07wCFLWtDthIfzzlnhVldllCa59Nd9mq+SXSZlkpEFkP3meEI1SKggWR
         qf1rcvgTkECJ1DivnXdQOczILwxOKM9Zwg7zXW0BtA3emBtJ4c14B/7rfU5pEJkCfIsD
         dcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724970998; x=1725575798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOWBznsKRVo1nYJqB/VJ22hNzYibujS7T2yElYKzXrk=;
        b=pX25aIeAmzIjeOab+4U4IYeA7uh4SDnJ1coFHj8iQcWbNrYclc+8CgRaNYqEXmlGCR
         s+2uTsEdXl1q423cXO+G/iy38uzy/38vm0jv+ibIsOlKlllVOke3gSEFs6Fqca1o0+il
         SBbyN14LzrQAfUzzMD/CYhY0vKrn2iCxMRhr0UxNa2ld7h14mzU5EXIic9goSdMHfR+8
         Kw6JbimMhSSQw/9pGSrFegzzn4q7VH97/bb8MMqyDa2Qr7oGXEFgLQ3D39NU5iR2cmiH
         2eOLP+Z1DgJlvlzUoyz+cGPoHdNNcGLOfwJRYotVSO78qsV4cfLQAd2t/wi8bsBswfvN
         7i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVin4V84u87uOqeUIs27185q23tR5XV1NbedFZQd9qmIbqXBxzn/P/6sXxOQPBJAlkpr0JqQzTfUDZGUF2a@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIEdK/AHnnEUJH/aC6ynyPBPGepX/SM0U07Dw+aORditrgIIf
	leig+JHyZ39jHdwdjbHfxdXPDsIW+ktcMFqKGkjTuek2nRl5Ykvc/uqYM5XLbPU=
X-Google-Smtp-Source: AGHT+IFwNMZvI/EHraCMa8WjkfrK7OqQF+EeFF2rN+A+GjYACDYa76UYDmGLtmHKsX36zu38jDQXXw==
X-Received: by 2002:a17:90a:3ea6:b0:2c9:5a87:f17c with SMTP id 98e67ed59e1d1-2d8561a14a1mr4473152a91.15.1724970998094;
        Thu, 29 Aug 2024 15:36:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39d398sm2247849a91.42.2024.08.29.15.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 15:36:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjnko-00HQ2M-16;
	Fri, 30 Aug 2024 08:36:34 +1000
Date: Fri, 30 Aug 2024 08:36:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Darrick Wong <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <ZtD38pOop33OFGUw@dread.disaster.area>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
 <20240829015750.GB6216@frogsfrogsfrogs>
 <20240829040056.GA4142@lst.de>
 <63DF6C8E-FB1A-4F32-BF4A-7D91A2BBA545@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63DF6C8E-FB1A-4F32-BF4A-7D91A2BBA545@oracle.com>

On Thu, Aug 29, 2024 at 01:52:40PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 29, 2024, at 12:00 AM, Christoph Hellwig <hch@lst.de> wrote:
> > 
> >> Wouldn't readplus (and maybe a sparse copy program) rather have
> >> something that is "SEEK_DATA, fill the buffer with data from that file
> >> position, and tell me what pos the data came from"?
> > 
> > Or rather a read operation that returns a length but no data if there
> > is a hole.

Right, it needs to be an iomap level operation - if the map returned
is a hole it records a hole, otherwise it reads the through the page
cache.

But to do this, we need the buffered reads to hit the filesystem
first and get the mapping to determine how to process the incoming
read operation, not go through the page cache first and bypass the
fs entirely because there are cached pages full of zeroes in the
page cache over the hole...

> That is essentially what READ_PLUS does. The "HOLE" array
> members are a length. The receiving client is then free
> to represent that hole in whatever way is most convenient.
> 
> NFSD can certainly implement READ_PLUS so that it returns
> only a single array element -- and that element would be
> either CONTENT or HOLE -- in a possibly short read result.
> (That might be what it is doing already, come to think of
> it).
> 
> The problem with SEEK_DATA AIUI is that READ_PLUS wants
> a snapshot of the file's state. SEEK_DATA is a separate
> operation, so some kind of serialization would be
> necessary to prevent file changes between reads and seeks.

Note that SEEK_DATA also handles unwritten extents correct. It will
report them as a hole if there is no cached data over the range,
otherwise it will be considered data. The only downside of this is
that if the unwritten extent has been read and the page cache
contains clean zeroed folios, SEEK_DATA will always return that
unwritten range as data.

IOWs, unwritten extent mappings for READPLUS would need special
handling to only return data if the page cache folios over the
unwritten range are dirty...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

