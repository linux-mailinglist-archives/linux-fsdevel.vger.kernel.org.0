Return-Path: <linux-fsdevel+bounces-25850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F79511AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 03:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71132B226C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE051C680;
	Wed, 14 Aug 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bvh3SQ7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0218040
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600161; cv=none; b=rjCQsC6m7x5D/4Wfdhu/BuSjZdC0CX0Xxd8X5VAxLPrwgVk83YIi4orgqTedOuCUqKc+6XCWqDkGleRKLbxHay1GGo5bp2/KPPMiE73i7ibCIkGZxvrD8cybDFUaSTuJtVbP6R6pzWSksJiqj2dQc8iLUPqqhZhwfmtBpyoxxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600161; c=relaxed/simple;
	bh=pbuNWprQEBoJyI8KBTUf/yY/joRLqqEHcwtKN3Yy+ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtLw6pACSi5lPMOcYjniMZ2EErl2a74PNwAaBC8rNUP9yceBesdYHwendo14NHwzxIo5tVUUJoJ3f+W7A/G2L7BuQ+1vikvP0zR4wpUdcDhUNaPreZF5CKGCqtnMk9MCQ7qrKVex2ZY9xCP3xEp+6nQMeAzpeLtIN3xUV8xGzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bvh3SQ7J; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc587361b6so51330945ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723600159; x=1724204959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQuPtUQiqDIJaa11XX2bCBMMxTq1jV8ulgi33bMi18Q=;
        b=bvh3SQ7JSSHYF4bKwQt1z6ZTN3VHi7YEwUff1RlWFM6T6hWaOZEWVKd9qWcGOtjDLY
         vMaZAtLWAhh8PsMaaPi0QjzbkwaIr/DaKvnFOOcTYuE/xB2NsIHBpzVM3UiAh1r6z1n8
         JYH4BWO7MweYE0RfIraMwcan7dVFBmslCxVFQS+LHhSgoXrJb6tCA+m1fd+GHZYvoUcp
         1KCPH5B5eebBFSg3PME0n3VpAdusHs2yeJwd+qUD/NT6p00wiMGR3ZacIFO9JhkeR1wo
         Bc1BIZDVe3/hHrNV8DRV/5okjC1RqRvA7AIrm2LEO3E6W+3N4I8CKmrD8B1Yr/jk3DXm
         MLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600159; x=1724204959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQuPtUQiqDIJaa11XX2bCBMMxTq1jV8ulgi33bMi18Q=;
        b=JlZEoRN3ggTgaz0H1DiI515QJTo/vW+ZkTq8faZgxUctufIbsuGjIbzGwE/XJ+oI3U
         DSClhK7icmfQJ6jdaf23QoGMk/eRB8+qo7XQ1xQv84aXNmhlggkv8AmNIw1zp1mwV3le
         YMQreKSgJ5hU9I47qE+vLdipwYE8ISqZClKikSTHoPd2WVTlOEkibMsIq1QWP2uJeQmP
         CNPkKAqx+b1kxk3gM2VVCUkoqC+V1qBubx3uxHHshQ2ygxcubvW3t8KRyhRJzcw4RMAU
         Cst1pRorFBH1JER6bbhyxa071NrRwzlLbZVbIBqJzpnUtjGMDZSBvWsobnq5tjeG0fz4
         1QtA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Wq7FRKE9xnH5PXKpw4tKxi+P0bl6Bvfpa+oyxntDaaHxyFzyajuq3VW+aZu1mj4u9cE6Q6voWvSp4YIYEYKdHWE+LxM2ZLRWBfTIhw==
X-Gm-Message-State: AOJu0YyHXwyT/TNDNxZ8HUIHmH6ZAP0spk9wE1DWUsXY0hsvSH4g2C0z
	TMJegN5GG2YyY6+NCsXFOmGJ8GIJGDPSHAFxFtkEvoXG3r2UCmbdlxoZnhVkQhw=
X-Google-Smtp-Source: AGHT+IEfAFPrWlCTO6wXtIMc3ItUikWnNtj+Pc/IdeokdwRfNhZ15x5Xomn4t0XPqIDvMxyohfjP+g==
X-Received: by 2002:a17:902:f552:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-201d639c93emr18247355ad.5.1723600159010;
        Tue, 13 Aug 2024 18:49:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201d9a78499sm1710655ad.153.2024.08.13.18.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 18:49:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se38V-00GGfh-2C;
	Wed, 14 Aug 2024 11:49:15 +1000
Date: Wed, 14 Aug 2024 11:49:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
Message-ID: <ZrwNG9ftNaV4AJDd@dread.disaster.area>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:53PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Patch 5 fix a stale data exposure problem pointed out by Willy, drop
>    the setting of uptodate bits after zeroing out unaligned range.
>  - As Dave suggested, in order to prevent increasing the complexity of
>    maintain the state_lock, don't just drop all the state_lock in the
>    buffered write path, patch 6 introduce a new helper to set uptodate
>    bit and dirty bits together under the state_lock, reduce one time of
>    locking per write, the benefits of performance optimization do not
>    change too much.

It's helpful to provide a lore link to the previous version so that
reviewers don't have to go looking for it themselves to remind them
of what was discussed last time.

https://lore.kernel.org/linux-xfs/20240731091305.2896873-1-yi.zhang@huaweicloud.com/T/

> This series contains some minor non-critical fixes and performance
> improvements on the filesystem with block size < folio size.
> 
> The first 4 patches fix the handling of setting and clearing folio ifs
> dirty bits when mark the folio dirty and when invalidat the folio.
> Although none of these code mistakes caused a real problem now, it's
> still deserve a fix to correct the behavior.
> 
> The second 2 patches drop the unnecessary state_lock in ifs when setting
> and clearing dirty/uptodate bits in the buffered write path, it could
> improve some (~8% on my machine) buffer write performance. I tested it
> through UnixBench on my x86_64 (Xeon Gold 6151) and arm64 (Kunpeng-920)
> virtual machine with 50GB ramdisk and xfs filesystem, the results shows
> below.
> 
> UnixBench test cmd:
>  ./Run -i 1 -c 1 fstime-w
> 
> Before:
> x86    File Write 1024 bufsize 2000 maxblocks       524708.0 KBps
> arm64  File Write 1024 bufsize 2000 maxblocks       801965.0 KBps
> 
> After:
> x86    File Write 1024 bufsize 2000 maxblocks       569218.0 KBps
> arm64  File Write 1024 bufsize 2000 maxblocks       871605.0 KBps

Those are the same performance numbers as you posted for the
previous version of the patch. How does this new version perform
given that it's a complete rework of the optimisation? It's
important to know if the changes made actually provided the benefit
we expected them to make....

i.e. this is the sort of table of results I'd like to see provided:

platform	base		v1		v2
x86		524708.0	569218.0	????
arm64		801965.0	871605.0	????

-Dave.
-- 
Dave Chinner
david@fromorbit.com

