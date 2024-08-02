Return-Path: <linux-fsdevel+bounces-24841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474ED94551D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 02:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D54284E67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 00:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417D3D6A;
	Fri,  2 Aug 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KnYaLdmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543210F4
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557160; cv=none; b=TiIMFpz/iJrD1IUdDoeZ5p9wn/H5dEc56L51I0AzXFLu6/uwKRESWMdhq48HgralYSaAOKCRAyp1F/SFlPkewdR9jJvDV5AqhwUCsC8Kjkhuohc0GTHwbcGVnVj+rTtw21LzWpOGVGcqzKxz20fWDx2d1mwRQkyuhvt6IwAJfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557160; c=relaxed/simple;
	bh=kPg6hNpv0fyQQ4C8xugRnahcyI2M1VfEIoO8Iylc6mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9X8J5a0OHJUEg1ksyaEMVI7+1b04lUm13FqBzvwjvCi9dADHuj8xdy1fUXsd0XzWHNsgqnvPrRNXeJwYZRSdhstxqWjND4E06jsQhSwGLBfrjunLhSEkKriHYLuS3Fqhl7G/3SrF2U5Wh4YxwWm9QmpFJC44rXP0dkSZxbVT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KnYaLdmd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fed72d23a7so58457995ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2024 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722557158; x=1723161958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtsQ+3NXr7Z0grTXgI4VJ8mpDigb9614hgPF8/mg2ek=;
        b=KnYaLdmdx2kIS5cRhTBo9gtYC5Cuu9GWeGnR5/z9WkUTP3MTuLgzH26Y+un7cTRsYv
         yJjicBTWTBNCawOIBZTDcWdv4BWNIc/mkZRKIddb9YMD+TLu1uBop98FeKxls5Qk1yzE
         TUReUZcKvWJOhfKmskXQMXSij7vO1d0bHmEYOmecSuIOfcEg4fwKVWZOePvrJpHdJV9b
         QytxvDv0VDbTl82WF/WQ9T9I3wSGFHPXgDV/7/BFZ2kSWDEJCRa/EOtwi/17BOn8IWM/
         aqSPG/PcPAThwVhNVGLDusX1cBPb/4SrRJQgnEVPAiCBqnFDleu3VtqIr40a2GMAs7/v
         HK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722557158; x=1723161958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtsQ+3NXr7Z0grTXgI4VJ8mpDigb9614hgPF8/mg2ek=;
        b=RDSJPqTEck3eYfYYv7C7DdgcHxuPHxghkDECdJDld3CvIffCe9rZWLRw3VzMFZtO1Y
         JRfut9r0CF60v2UrRm7kIYsztHiQHKcbeWgO1htOeun4HgWKgPadmvzvz9V+bcSjiw38
         r8LMS/GaRG7YsqPNSkT/SDMhd3qQbvRLPIxPnubZIvufmDbWj0a1XfdkjORxiM+1dfU3
         alBDoDNFS0UOEmZg5dqUUwEaq/RU1HqDXbhg9M5bqT5acf8aL/dO5DufW1ZCXMXXrS7o
         FW2yR6KTVybbsZgwAXgb8I7ZBlKvzPgKQu+jjnN4XKTGnTNuEyuGWqexbUl/dNgZU6B9
         GMKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUWglYGsd9Ce00zA8goM2Dv9FqXuzykCG8HywVsKFeApfPOjs2A/jqfgyJAChJf4bfj89HAjLMz886lxzv/FJmf368pS3qMDNgjibrAA==
X-Gm-Message-State: AOJu0Yziy7OEMwxQmB4sAhek/ApozxKFBYAE9DI6B/qwj1zS3R/XtKJS
	XflCSVgT39NXX2iKbmdYRr8vrt13pmpeHkbpcQZV5+JHzPreSbvMqoh82DUP7+Y=
X-Google-Smtp-Source: AGHT+IHAi8u2E0Zyx8AqxUHQRqLu9oFcTolJxIePwk6jnTPCdufSt8G3TT6DihMhy1lfh6fr5NcjNA==
X-Received: by 2002:a17:902:f686:b0:1fb:6294:2e35 with SMTP id d9443c01a7336-1ff5743b563mr26795165ad.50.1722557158429;
        Thu, 01 Aug 2024 17:05:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592acd2fsm4645375ad.286.2024.08.01.17.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:05:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sZfnv-0023B7-1T;
	Fri, 02 Aug 2024 10:05:55 +1000
Date: Fri, 2 Aug 2024 10:05:55 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
Message-ID: <Zqwi48H74g2EX56c@dread.disaster.area>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731091305.2896873-6-yi.zhang@huaweicloud.com>

On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
> race issue when submitting multiple read bios for a page spans more than
> one file system block by adding a spinlock(which names state_lock now)
> to make the page uptodate synchronous. However, the race condition only
> happened between the read I/O submitting and completeing threads,

when we do writeback on a folio that has multiple blocks on it we
can submit multiple bios for that, too. Hence the write completions
can race with each other and write submission, too.

Yes, write bio submission and completion only need to update ifs
accounting using an atomic operation, but the same race condition
exists even though the folio is fully locked at the point of bio
submission.


> it's
> sufficient to use page lock to protect other paths, e.g. buffered write
                    ^^^^ folio
> path.
>
> After large folio is supported, the spinlock could affect more
> about the buffered write performance, so drop it could reduce some
> unnecessary locking overhead.

From the point of view of simple to understand and maintain code, I
think this is a bad idea. The data structure is currently protected
by the state lock in all situations, but this change now makes it
protected by the state lock in one case and the folio lock in a
different case.

Making this change also misses the elephant in the room: the
buffered write path still needs the ifs->state_lock to update the
dirty bitmap. Hence we're effectively changing the serialisation
mechanism for only one of the two ifs state bitmaps that the
buffered write path has to update.

Indeed, we can't get rid of the ifs->state_lock from the dirty range
updates because iomap_dirty_folio() can be called without the folio
being locked through folio_mark_dirty() calling the ->dirty_folio()
aop.

IOWs, getting rid of the state lock out of the uptodate range
changes does not actually get rid of it from the buffered IO patch.
we still have to take it to update the dirty range, and so there's
an obvious way to optimise the state lock usage without changing any
of the bitmap access serialisation behaviour. i.e.  We combine the
uptodate and dirty range updates in __iomap_write_end() into a
single lock context such as:

iomap_set_range_dirty_uptodate()
{
	struct iomap_folio_state *ifs = folio->private;
	struct inode *inode:
        unsigned int blks_per_folio;
        unsigned int first_blk;
        unsigned int last_blk;
        unsigned int nr_blks;
	unsigned long flags;

	if (!ifs)
		return;

	inode = folio->mapping->host;
	blks_per_folio = i_blocks_per_folio(inode, folio);
	first_blk = (off >> inode->i_blkbits);
	last_blk = (off + len - 1) >> inode->i_blkbits;
	nr_blks = last_blk - first_blk + 1;

	spin_lock_irqsave(&ifs->state_lock, flags);
	bitmap_set(ifs->state, first_blk, nr_blks);
	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
	spin_unlock_irqrestore(&ifs->state_lock, flags);
}

This means we calculate the bitmap offsets only once, we take the
state lock only once, and we don't do anything if there is no
sub-folio state.

If we then fix the __iomap_write_begin() code as Willy pointed out
to elide the erroneous uptodate range update, then we end up only
taking the state lock once per buffered write instead of 3 times per
write.

This patch only reduces it to twice per buffered write, so doing the
above should provide even better performance without needing to
change the underlying serialisation mechanism at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

