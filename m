Return-Path: <linux-fsdevel+bounces-64021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA584BD656E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6180E189AFD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E342DAFBF;
	Mon, 13 Oct 2025 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="da7LLSIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601A2D3A8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390183; cv=none; b=kk/QBDQxupMzmX7uMYYx1XZO5ghctSVw48HmZWXAKuFmdjeYzOm/9KbHM3iOiAU5MIiOr//zsJ4UeUyOzBWJAQiXFI1eUcFWjlJyWlh3hpoV0/k5JyxbcJ6w9zgNC9jkuo9oCe/ZiEi3hI2Vn4FVykZF1uxFrx1DsRMvDKL6if0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390183; c=relaxed/simple;
	bh=lxUa4AC4BdWesZtvWToOAjNAgc3/EtV04m4kB7CTD1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP3CUu2e45KeOPzl1xfWgNBIfwqyomWpvA0p+FNPih5l+197LVoy0kfUiseofckirx/kfN5TEYPTcygaOEefJl6UoaR6s7SNjxN2mnEJTeb7sN73n9AP9XZsydANJzR6Nri62cgPiSyPaRyf1esECcWcMgtW454kkCjw6aqT9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=da7LLSIB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f1f29a551so5971561b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760390180; x=1760994980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bGIpbfrOvyd6WWfxe3wkvxR2bRwHs9IuC/zJmaL5A0=;
        b=da7LLSIBFbTtjbd1acLhWdetzRJo1hGbziS/d7xjVQ8NyuwUZAald2DSyxu8MUUfW9
         oizTV1kZoTujcSjdhpL/TCcNdpGJ4x+ynM620/hoaS+7aaVLRAF3X25+f0kSrI+njKZW
         oAit8lFFyouqVENgWlTYJPZ1gZX7AxceI8a65fNeBJWkt9cTLS5+OFbsSGNYWLOcHnG3
         JqayZnBttlUHZ9MdETMD+03ZVBp8m257qo3DiZEKbzjrbQu5wPiS6FUjxDQ/iZmEM9im
         u7fIVyImvgYlezjyRxN8X/h8KuYlFHeOvGNstju5Kn6PDOO7feBOgVkc0w+7t5IGbjiv
         DhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760390180; x=1760994980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bGIpbfrOvyd6WWfxe3wkvxR2bRwHs9IuC/zJmaL5A0=;
        b=QM1g9u/Ei6/U2/1JWQiwJH8G6aJznHfImR8CGW+brQn9hvZo6TO3wE5n6UJPlBC+Qd
         F8noWMPovtOI5JOwRfHMYP4A1a7jp4W4gXz4cfq2GPkA4NLFuk7hiceq4ACLIYAyJk3W
         2ycui3TRbEDCHBOInXJQecjYftBk+ZZoKy6yas0F37lWJ8BLi2YkxUYJsoHiTtRNTc3c
         PCiIOTzwdJKY7oRfVoZCHUxPLj8ZO7Nfg1+O309nIPCh5s4wiAQJZeqCrtGdKSUxu69y
         Q3Y4H4lEjvjfV0Z/Dsz1LnJxVahDmMhi264yMKaZuMcyrhMAtF4fjh6lRiss+m7Tlo2A
         EMgg==
X-Forwarded-Encrypted: i=1; AJvYcCVchBtcfHmH9HyYFvRom/Qlvb56WNYWK96B68rAA3qYHuHYMfz9gcNHiI8os/UjY5PO/MSgAJJ6cRIagXbH@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBEjcH/3qTRdbC75QsXnJqpHdjO/mf2UHNFtgfFc9+nF3tanO
	paKEAzdwOWhgUfww4J52fBZsP64nzviKy/T/eca7TP86wDAR/R3eIyhGDE1ICOWjEJI=
X-Gm-Gg: ASbGncs2fweqS5BlgZ58qk1/2bXYBK86haEinyfkImisF6C4tfPnrds756VEK0wlUg0
	X6mcLew7rayCi2NxZBJXbXkW6Clu4ETkbIP7imKzvBXs57+nvZoNZN+wfSK3BOkyasw5SkmbfnG
	b3krXRUQRVZjVf1asznYvQL7vgsVWgSXI6/lBEbcJzj9GG1Hadd68alEPoGDyvkyzR90F8oJxyX
	qcZaCUnz8gTC3kbodderNwaw6PWPlthQ2YnQ/tGR24rt2+au9CDuLEH6udpxibuuWhSp+daMVxG
	jvCsGAQ0wpGVnixw51+GZnGPDQlTMgXyfpWkhUbYhSHxdZ7mDAfvAw8W0HWlROgQi2aSZJE44NR
	j4Sfjz/YscXXngeSXcfnfOZJ5CjtexNwebfwylYE5aYijbywh/Fe9OIO38Egy01fB7HW3vg9m2c
	B/TeklSzJeYlGOfZUUAQMyJS26XrDu9gboT/L+YA==
X-Google-Smtp-Source: AGHT+IGuPS/85NrpQt8btSHtyMtZAkheFRYc33E0JjNt4LL7IUHtXrIkFRrVpgza2afcE9/ZUrV47Q==
X-Received: by 2002:a05:6a00:2443:b0:781:4f6:a409 with SMTP id d2e1a72fcca58-793858fb715mr25502723b3a.11.1760390180328;
        Mon, 13 Oct 2025 14:16:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm12471310b3a.54.2025.10.13.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:16:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8Ptw-0000000ERfm-3Uzg;
	Tue, 14 Oct 2025 08:16:16 +1100
Date: Tue, 14 Oct 2025 08:16:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, willy@infradead.org,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, dlemoal@kernel.org, linux-xfs@vger.kernel.org,
	hans.holmberg@wdc.com
Subject: Re: [PATCH, RFC] limit per-inode writeback size considered harmful
Message-ID: <aO1sIICzGcKReH5w@dread.disaster.area>
References: <20251013072738.4125498-1-hch@lst.de>
 <j55u2ol6bconzpeaxdldqjimyrmnuafx5jarzhvic3r2ljbdus@tkmjzu4ka7eh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j55u2ol6bconzpeaxdldqjimyrmnuafx5jarzhvic3r2ljbdus@tkmjzu4ka7eh>

On Mon, Oct 13, 2025 at 01:01:49PM +0200, Jan Kara wrote:
> Hello!
> 
> On Mon 13-10-25 16:21:42, Christoph Hellwig wrote:
> > we have a customer workload where the current core writeback behavior
> > causes severe fragmentation on zoned XFS despite a friendly write pattern
> > from the application.  We tracked this down to writeback_chunk_size only
> > giving about 30-40MBs to each inode before switching to a new inode,
> > which will cause files that are aligned to the zone size (256MB on HDD)
> > to be fragmented into usually 5-7 extents spread over different zones.
> > Using the hack below makes this problem go away entirely by always
> > writing an inode fully up to the zone size.  Damien came up with a
> > heuristic here:
> > 
> >   https://lore.kernel.org/linux-xfs/20251013070945.GA2446@lst.de/T/#t
> > 
> > that also papers over this, but it falls apart on larger memory
> > systems where we can cache more of these files in the page cache
> > than we open zones.
> > 
> > Does anyone remember the reason for this limit writeback size?  I
> > looked at git history and the code touched comes from a refactoring in
> > 2011, and before that it's really hard to figure out where the original
> > even worse behavior came from.   At least for zoned devices based
> > on a flag or something similar we'd love to avoid switching between
> > inodes during writeback, as that would drastically reduce the
> > potential for self-induced fragmentation.
> 
> That has been a long time ago but as far as I remember the idea of the
> logic in writeback_chunk_size() is that for background writeback we want
> to:
> 
> a) Reasonably often bail out to the main writeback loop to recheck whether
> more writeback is still needed (we are still over background threshold,
> there isn't other higher priority writeback work such as sync etc.).

*nod*

> b) Alternate between inodes needing writeback so that continuously dirtying
> one inode doesn't starve writeback on other inodes.

Yes, this was a big concern at the time - I remember semi-regular
bug reports from users with large machines (think hundreds of GB of
RAM back in pre-2010 era) where significant amounts of user data was
lost because the system crashed hours after the data was written.
The suspect was always writeback starving an inode of writeback for
long periods of time, and those problems largely went away when this
mechanism was introduced.

> c) Write enough so that writeback can be efficient.
> 
> Currently we have MIN_WRITEBACK_PAGES which is hardwired to 4MB and which
> defines granularity of write chunk.

Historically speaking, this writeback clustering granulairty was
needed w/ XFS to minimise fragmentation during delayed allocation
when there were lots of medium sized dirty files (e.g.  untarring a
tarball with lots of multi-megabyte files) and incoming write
throttling triggered writeback.

In situations where writeback does lots of small writes across
multiple inodes, XFS will pack allocation for then tightly,
optimising the write IO patterns to be sequential across multi-inode
writeback. However, having a minimum writeback chunk too small would
lead to excessive fragmentation and very poor sequential read IO
patterns (and hence performance issues). This was especially in
times before the IO-less write throttling was introduced because of
the random single page IO that the old write throttling algorithm
did.

Hence for a long time before the writeback code had
MIN_WRITEBACK_PAGES, XFS had a hard-coded minmum writeback cluster
size that overrode the VFS "nr_to_write" value to ensure this
(mimimum of 1024 pages, IIRC) to avoid this problem.

> Now your problem sounds like you'd like to configure
> MIN_WRITEBACK_PAGES on per BDI basis and I think that makes sense.
> Do I understand you right?

Yeah, given the above XFS history and using a minimum writeback
chunk size to mitigate the issue, this seems like the right approach
to take to me.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

