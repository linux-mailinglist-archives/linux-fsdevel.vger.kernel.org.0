Return-Path: <linux-fsdevel+bounces-50024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBAAC772E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E211C0328E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFCA246777;
	Thu, 29 May 2025 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LQxYFuOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6ED299
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493396; cv=none; b=Xpj8tmQ5co11crFcw3/h4kCF6yvyUNQKSz8pg+u96MtuQxil7lSDbd43aDaZsDWr2TSw7cJ5i85TliPaO2coXqgScsPP3bFYsckSU4N45YfwctMbPYizkBOIozDkMtBrzseq2UsoQH36StxMzq70qUPe3P4JbLyGQ0S5E8cbgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493396; c=relaxed/simple;
	bh=/aAE8PQ4Eq42jFjznP25L4UOSJMqseibpFa1FKn+2DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVMYCKwnUFJ9HfSKVG43Mv71PeYBTCViABwZYuWbuZh8wNIacWCdmHnBrIac0RCmsLNFUsRQeKwXg+zZXlKhFj7EswOoOhfr/C8HREdhT7vUH5UlfdELkBU4lPDE3CZujqd/DNKx1U9FziA+4QRmyZWtv6I/gayKKvC/z3eWGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LQxYFuOO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231e98e46c0so4837935ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1748493394; x=1749098194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1O4w2je/tYdlFGEn+TC9L2CRnIFOJ94HhRwCNdSpXA=;
        b=LQxYFuOO0XgGNGcYrDOfyZY5HwA8uoF28DELWWYOZo+SjTRqql/zmbpgW3VWRUf/3u
         k9wFWRVGNJFUmHsHEN7RTvzlIYkLADBSrn/uPbFjdreO5/nXjlKBt0h0sS579lK2wpzH
         FUCAdQcIHZVOlNAoEUW/RB0WEr7YqcGZAwK/0j2jvax4rOYT8LwOrBT1aeqOFcIUDwws
         VIId44lbrtnFjTJyxKT4C1SBFcRApAzHhnR0CUHL9B3RuXjriM3A7bqnmCDNBFFmm4Yf
         GEluvCMPDAmpYQoO/TbcQSBNJIr5UqSJrQr3izpAa8cUMcCYGcLIRiIJnrc2zYNttkkM
         8v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493394; x=1749098194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1O4w2je/tYdlFGEn+TC9L2CRnIFOJ94HhRwCNdSpXA=;
        b=F4m8fbscUgIRQGEl3El7144EwGcKP50zgjo5PyVUNeqppV+sz8wzvnPaIYPQ8El6Fe
         LX3VuiV65YEH7N5rRfsUJ5pt6wLGx+FOPhzVtpERUUn5I9jmdWvj7ccW60KEhVST2ys2
         XqL6Y4h8uLQ2KD34+LeqGPiYEdaADALZSGTj7b2k+mH7uYUQ/A3D+NClO13LH8++BZeE
         /TKUVyj9hCkY5x7fNSN/2p+LxzqRZJWgzWRPUkeJEj3++7+KVoKhBXcuj73Zi5sdLYt2
         vu/zLvTeAC+rNL5am9dTnUL+iR6qLOshzZdPPOVB3oCCcYkDZX/iPnzz+cnXG5pODTS+
         fvdA==
X-Forwarded-Encrypted: i=1; AJvYcCWXo82Evv+ABXufMu9v0RcTAeELlPNhO3/u/6bjod1SkbkqERFrXNeab3BA2OoJozMsNVA/IbnCdEBQ6MD0@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAVivlRmaWl/Ln34W5ruVVS9nWAiK9a30D54d07PolwEwkK/s
	c5fxyxTTd6W7e/6a3s6ThtjI0x0kXg6iOTPl9IS8epRciRwqz8gd46ww0nw0oT9/WN8OQjYpcpx
	X3bSt
X-Gm-Gg: ASbGncua1aYH3uLxSIL6mSGH1HOtq6fneDxAoWOL0+B9dAD9f1//dpxVJFCafGBpjIm
	aK4cFuFjr8PWhDmHJeSAuReEw+80XcmmeihjCxCEovdYb1UdPl0M0HZpQ2T9b1Hxl53WQBh6rsU
	Dfo4BxbEA/0MloZPkmaGe5XgyYNaE9btAekKQYAzFGGBDG8QjwdDZyWqRP5tHXCzQq2bbdf8WkX
	maORhvvgpY2z0CggjGpsmSfX2HzHYOqOcRmbqJk+icQvwQocu+X+Vd7eANLrs/Ub2VqrbAd1DOn
	xWMbqMGhf0Jaybk/JR3L2Kc0c3SF6qOPnWOaadfKED1x3fUvCq+LMqt3gF77mnOPLVQhry/ZIIb
	+Ri1TL16wNymKAm1E
X-Google-Smtp-Source: AGHT+IHIgAO2lsClFdwJkF17Bm7HKwxTZ8x+hNA5gd6TNfZdL6Y3/KIDmW7/6Xy7Y8KRZoEajill7g==
X-Received: by 2002:a17:903:41cc:b0:232:202e:ab18 with SMTP id d9443c01a7336-23414f6f7femr234658245ad.26.1748493393680;
        Wed, 28 May 2025 21:36:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3558sm3979585ad.122.2025.05.28.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 21:36:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uKV0I-00000009UZb-1kfn;
	Thu, 29 May 2025 14:36:30 +1000
Date: Thu, 29 May 2025 14:36:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aDfkTiTNH1UPKvC7@dread.disaster.area>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>

On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> Hello,
> 
> Recently, we encountered data loss when using XFS on an HDD with bad
> blocks. After investigation, we determined that the issue was related
> to writeback errors. The details are as follows:
> 
> 1. Process-A writes data to a file using buffered I/O and completes
> without errors.
> 2. However, during the writeback of the dirtied pagecache pages, an
> I/O error occurs, causing the data to fail to reach the disk.
> 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> since they are already clean pages.
> 4. When Process-B reads the same file, it retrieves zeroed data from
> the bad blocks, as the original data was never successfully written
> (IOMAP_UNWRITTEN).
> 
> We reviewed the related discussion [0] and confirmed that this is a
> known writeback error issue. While using fsync() after buffered
> write() could mitigate the problem, this approach is impractical for
> our services.

Really, that's terrible application design.  If you aren't checking
that data has been written successfully, then you get to keep all
the broken and/or missing data bits to yourself.

However, with that said, some history.

XFS used to keep pages that had IO errors on writeback dirty so they
would be retried at a later time and couldn't be reclaimed from
memory until they were written. This was historical behaviour from
Irix and designed to handle SAN environments where multipath
fail-over could take several minutes.

In these situations writeback could fail for several attempts before
the storage timed out and came back online. Then the next write
retry would succeed, and everything would be good. Linux never gave
us a specific IO error for this case, so we just had to retry on EIO
and hope that the storage came back eventually.

This is different to traditional Linux writeback behaviour, which is
what is implemented now via iomap. There are good reasons for this
model:

- a filesystem with a dirty page that can't be written and cleaned
  cannot be unmounted.

- having large chunks of memory that cannot be cleaned and
  reclaimed has adverse impact on system performance

- the system can potentially hang if the page cache is dirtied
  beyond write throttling thresholds and then the device is yanked.
  Now none of the dirty memory can be cleaned, and all new writes
  are throttled....

> Instead, we propose introducing configurable options to notify users
> of writeback errors immediately and prevent further operations on
> affected files or disks. Possible solutions include:
> 
> - Option A: Immediately shut down the filesystem upon writeback errors.
> - Option B: Mark the affected file as inaccessible if a writeback error occurs.

Go look at /sys/fs/xfs/<dev>/error/metadata/... and configurable
error handling behaviour implemented through this interface.

Essential, XFS metadata behaves as "retry writes forever and hang on
unmount until write succeeds" by default. i.e. similar to the old
data IO error behaviour. The "hang on unmount" behaviour can be
turned off by /sys/fs/xfs/<dev>/error/fail_at_unmount, and we can
configured different failure handling policies for different types
of IO error. e.g. fail-fast on -ENODEV (e.g. device was unplugged
and is never coming back so shut the filesystem down),
retry-for-while on -ENOSPC (e.g. dm-thinp pool has run out of space,
so give some time for the pool to be expanded before shutting down)
and retry-once on -EIO (to avoid random spurious hardware failures
from shutting down the fs) and everything else uses the configured
default behaviour....

There's also good reason the sysfs error heirarchy is structured the
way it is - it leaves open the option for expanding the error
handling policies to different IO types (i.e. data and metadata). It
even allows different policies for different types of data devices
(e.g. RT vs data device policies).

So, got look at how the error configuration code in XFS is handled,
consider extending that to /sys/fs/xfs/<dev>/error/data/.... to
allow different error handling policies for different types of
data writeback IO errors.

Then you'll need to implement those policies through the XFS and
iomap IO paths...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

