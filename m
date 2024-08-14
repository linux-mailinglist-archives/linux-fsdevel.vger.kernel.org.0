Return-Path: <linux-fsdevel+bounces-25873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08C9513C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC0D1C22D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1C55E58;
	Wed, 14 Aug 2024 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fBZtYh34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DBD3D552
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612570; cv=none; b=V0UY0yAJMmdk7aWl5JTs85iBfKUG1OG3935yOjfcexSi7UHfmyjFg86XoPRVxfEMKKjZ1KU5rbHxQPZXP7jCOnbRqbO9F/Gg9P7Wq/nrnJtIJtnwXWvfck9FTMpfOoXSgV3lyQZmoSfPwW/34G5pRtk6iEjU0rZw/2nH8zm7ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612570; c=relaxed/simple;
	bh=n2+/BaQswGnRZEQgWpXHcwvPM5wXfbodQJfqXOeOAyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKe5kR/6dvmD/XdimY4Ko05nVg/72yXiyJa/kVwCAt/Zel0LlnognOtq3m/vNdXD3iLvO+2fumZr8KGUUWdu43ygHdl4xZe/pjAa3zL2sU6rJ4O81IAa7Kwi3AHPJd24G+whX507nLmWU2XZsKEW7m0doyN0nULU60MKpACAsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fBZtYh34; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a10b293432so4368937a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 22:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723612568; x=1724217368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHoqmxG15qyx25r5hZj+PC5OM2AuTwDeiWxOb/IU6mE=;
        b=fBZtYh34cd7w49+yobzlIWmvwo2KCFI5ZL2w+2/xhiLlYHnEo7itO2TazXKR0tyFkI
         YuHmzLqCIqrzgmcE9VjdRZw8KfHMWTCjHJDvc7k0b83lIRwpgwOa95kQc+Y9zYyWGuHh
         aYZenZ+Y9gcr6CN6J+Aut4lhxsiayYxhuOrY55kn1nwoZsnOXfS45aY4WTt5GwvsBMMd
         BXFqvUp6y+N1zAAgaSwZbeP15BIyLgsse2QGIvMWooBnxJqRoHCPEB7SA29ds2tVEZht
         wcouI7FqjAiJhCfuA1Wod9e+Na944OQRE26AksBtAzACpG4e8PI3xZDVjBy0esnhUYNV
         W20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723612568; x=1724217368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHoqmxG15qyx25r5hZj+PC5OM2AuTwDeiWxOb/IU6mE=;
        b=SA4zCtrirJMvrV4IrW7UTVVvhAoTWArW6QbCdnBePBPmV7M0K65SYA7/QynCeeHvxY
         sP1JBgsfkq6Om/Jab7txF/wdVBviKHzQ6mRfUWuyeKe0/KVQPCHF16mm8BJNCHplqat0
         uCWV1LkPCqu2fkp/wTTrBM9z+Iu/meeVgwwHadGtr4pWn+AeM9tYR59mnDMJgPWr1y//
         BlUJzExa79mC3+4f+6BDWYYiviublD4LllVoxyubye0Bv9F81Va/VcAwJcprOgGVBdVX
         r5ODW7Xd5nyAk+XLULMKUhac8wxjjwXXAtxSaTe/O4HTftLK1Ul97z2v2HVQH2shtU2O
         SnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8F3V5hspyx+uxYVYOcWXv0or1Z9792qCsZOOmPJK42BBriW28e7Jt0lTUpEx5D81roFEYcIZaymARoyQzYTXtmVXm0zbBqcT3TJ32/w==
X-Gm-Message-State: AOJu0Yxvo4XQHHaC/wiNYG6FGcqjUhucU+duNUjb+RLzoBT1Q72+0GVW
	YnjjO9BOJV9wq0c124tHXFptzj4wFPiZAlhWs+8AIClGe1x1JGNBiljgmdsXRuw=
X-Google-Smtp-Source: AGHT+IHscKr7/1w29S6mF1in4dwQQXnpaUhOh3hn7AS5f+3jKXbYe+YVHIZUt1DRchOce6qPIs9gyA==
X-Received: by 2002:a17:902:e546:b0:200:abb6:4daf with SMTP id d9443c01a7336-201d645eea1mr20862325ad.39.1723612567753;
        Tue, 13 Aug 2024 22:16:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1aa460sm21600595ad.180.2024.08.13.22.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:16:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se6Me-00GRD8-1x;
	Wed, 14 Aug 2024 15:16:04 +1000
Date: Wed, 14 Aug 2024 15:16:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
Message-ID: <Zrw9lBma/kbKV8Ls@dread.disaster.area>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <ZrwNG9ftNaV4AJDd@dread.disaster.area>
 <feead66e-5b83-7e54-1164-c7c61e78e7be@huaweicloud.com>
 <Zrwap10baOW8XeIv@dread.disaster.area>
 <a08a9491-61d7-b300-55ba-b016dd5aad5a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a08a9491-61d7-b300-55ba-b016dd5aad5a@huaweicloud.com>

On Wed, Aug 14, 2024 at 11:57:03AM +0800, Zhang Yi wrote:
> On 2024/8/14 10:47, Dave Chinner wrote:
> > On Wed, Aug 14, 2024 at 10:14:01AM +0800, Zhang Yi wrote:
> >> On 2024/8/14 9:49, Dave Chinner wrote:
> >>> important to know if the changes made actually provided the benefit
> >>> we expected them to make....
> >>>
> >>> i.e. this is the sort of table of results I'd like to see provided:
> >>>
> >>> platform	base		v1		v2
> >>> x86		524708.0	569218.0	????
> >>> arm64		801965.0	871605.0	????
> >>>
> >>
> >>  platform	base		v1		v2
> >>  x86		524708.0	571315.0 	569218.0
> >>  arm64	801965.0	876077.0	871605.0
> > 
> > So avoiding the lock cycle in iomap_write_begin() (in patch 5) in
> > this partial block write workload made no difference to performance
> > at all, and removing a lock cycle in iomap_write_end provided all
> > that gain?
> 
> Yes.
> 
> > 
> > Is this an overwrite workload or a file extending workload? The
> > result implies that iomap_block_needs_zeroing() is returning false,
> > hence it's an overwrite workload and it's reading partial blocks
> > from disk. i.e. it is doing synchronous RMW cycles from the ramdisk
> > and so still calling the uptodate bitmap update function rather than
> > hitting the zeroing case and skipping it.
> > 
> > Hence I'm just trying to understand what the test is doing because
> > that tells me what the result should be...
> > 
> 
> I forgot to mentioned that I test this on xfs with 1K block size, this
> is a simple case of block size < folio size that I can direct use
> UnixBench.

OK. So it's an even more highly contrived microbenchmark than I
thought. :/

What is the impact on a 4kB block size filesystem running that same
1kB write test? That's going to be a far more common thing to occur
in production machines for such small IO, let's make sure that we
haven't regressed that case in optimising for this one.

> This test first do buffered append write with bs=1K,count=2000 in the
> first round, and then do overwrite from the start position with the same
> parameters repetitively in 30 seconds. All the write operations are
> block size aligned, so iomap_write_begin() just continue after
> iomap_adjust_read_range(), don't call iomap_set_range_uptodate() to set
> range uptodate originally, hence there is no difference whether with or
> without patch 5 in this test case.

Ok, so you really need to come up with an equivalent test that
exercises the paths that patch 5 modifies, because right now we have
no real idea of what the impact of that change will be...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

