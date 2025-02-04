Return-Path: <linux-fsdevel+bounces-40705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35956A26C7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 08:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C29718872E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82874204C21;
	Tue,  4 Feb 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="G00dciJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A82046B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652942; cv=none; b=fYB/EnBbfX5yPHEv1pw9cWVm/EV3g5eByx4DVPdr6ZlfdKnYNufedTr/gBTPPDxMdZ7+fLf8XtvoVUy37Wnv0KLJKdSrD+XNM6P/++vZNskEJJ35wQtAdESx77rS6kIw6+qPzkGVxYRZdODEmfc23NIklVenh9IA5INOGGJwROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652942; c=relaxed/simple;
	bh=Burf299UW1WTKcTaFP09NCZvm48BPHkT9AINpElAxRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+e/X/s//vFQl9XDZ9KH4i2gUoMo2oB6J0NhOcIcYXfv39RQ4hm7pebe1uKufCCK56wxBI8efcL+lt7m5nMO+gYSv0+pbDyRFXwVdqaFJ9Nu1LGAbdSYuqCPLawU86HqHBO0TKTTS0QSHevEndbMUg76vnWDJBoTO6G+/PC94fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=G00dciJO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so102099155ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 23:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738652940; x=1739257740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBolNMkHUmMBLnhvQ6GkADel2vJXrydlbxJ+560QcYg=;
        b=G00dciJOTAC/3tFfQW2Bcog99Oq+jHvtXKhWcByLJ0J2QDOiwstjsFsnxqXlfxQ2gH
         Aki69TtZR0fNrBItcDTE4/yqCfrS1ztQ+M0MZQMZjsVvqgeN/u8bmWwwTTpH+LaoRlcm
         6yxhhI8wTA3PfgKvaXhzrTStShgyN5DsoCLKEaIVhjwJu1zDqdZUCUS3GnImC61oqaqh
         K0LRZsuZQqvROJ2AZey/jXfozfB1/6dsu4JS8hllZuCv0wcFW4viffeRZ+MK/7WAYREf
         Cw7sbvfr5gppwcogQVQbnpIMhy00A+olkYEoXOdzGrAvJtbek9uQchauEKO754vtmmjq
         zaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738652940; x=1739257740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBolNMkHUmMBLnhvQ6GkADel2vJXrydlbxJ+560QcYg=;
        b=xVRXvlHZiF3wf5MLO+BoCWo6oDuLulgFQsCWaKwMdsqJfn+5s2o/QhVLnipt7o0DaF
         Xhix4b12oUbuHKE+p1yIZAYshFkhU6LLSqNNBhRpF5/K52XbOs3BQ3vP3V3sfSshzezo
         SeO5bw2svZnpZtKtKcsN/s6o3TJlDipjgOgBwtHihKaBwpaCgbwIB+nMZclry3thxxoB
         ePRyABH0RmNgUMBndhQX3AuOaZw/AreJ8pUgMGTYbSZXjmEMqVl55qDs92T0Ih7OjSso
         NV2yCgi33vEijC0L4c8bNBB8FP3JHt1LVKwjV3EZz9GMNLAlmytyNpsARTe0Zz5zYxKP
         4dqA==
X-Forwarded-Encrypted: i=1; AJvYcCWhVNzQQsxdfkg5vlihpWJJ26ovOP1NJVendyjJHT/omMAZ38+532SziTOyEQf2kyRf11xbYDOF8UGCQr+c@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSzLEdRG9qZ1x802BI7osvOEh8ws+CPVqsAs+Vq2A6hFk09hM
	iMwT3n984cNRldNmdg6/z4g7W+iUDjxdH4y/lc6jofon/Tf7JM+qscc90pU53Ek=
X-Gm-Gg: ASbGncvgtSIy2D76B2eAbtSjnKdxk4/FYm6YY7eHUgcgH9vYjyP3rCSHpMZ+9R03QID
	7Vrpg31Z2C1LliOvF/5P5BB0UkxIsKeNBZJeffjqCHDnoDME6Cn3CHLRDT3O+Gon4yfrWOxAG04
	hg3+mCRhfGEkjYe7rBMIf8kH9r6KvzMneHNx3/L/PAv6vRAFroNgWrDCNn2qcZD7d0PL18hp/Ae
	RhZR56ztFH1iFEvMhvpLZuoxaXj71kcFcVmo3RXppvkhj/miHPHVHHgyfUnOZvkuh0N22be7ByQ
	jau+bEWmcD4LQT7JjokSPV0nvNieMhxhA5YebmfiHoYtfDjYBx/Dvfd0Co/GvknK8GM=
X-Google-Smtp-Source: AGHT+IFFYXnS8qo3OmYs0OzJXl/Z6Qo4CqIIVNv9a5alMR80GRQsXFwlSeplQvVkOKD/SFjDMpqFhg==
X-Received: by 2002:a17:902:ea06:b0:215:352c:af73 with SMTP id d9443c01a7336-21dd7c57eb0mr332656035ad.18.1738652940069;
        Mon, 03 Feb 2025 23:09:00 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3324b65sm87105915ad.252.2025.02.03.23.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 23:08:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfD3I-0000000EQ5P-3mVG;
	Tue, 04 Feb 2025 18:08:56 +1100
Date: Tue, 4 Feb 2025 18:08:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z6G9CN0cYS7iRgFK@dread.disaster.area>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204050642.GF28103@lst.de>

On Tue, Feb 04, 2025 at 06:06:42AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 04, 2025 at 01:50:08PM +1100, Dave Chinner wrote:
> > I doubt that will create enough concurrency for a typical small
> > server or desktop machine that only has a single NUMA node but has a
> > couple of fast nvme SSDs in it.
> > 
> > > 2) Fixed number of writeback contexts, say min(10, numcpu).
> > > 3) NUMCPU/N number of writeback contexts.
> > 
> > These don't take into account the concurrency available from
> > the underlying filesystem or storage.
> > 
> > That's the point I was making - CPU count has -zero- relationship to
> > the concurrency the filesystem and/or storage provide the system. It
> > is fundamentally incorrect to base decisions about IO concurrency on
> > the number of CPU cores in the system.
> 
> Yes.  But as mention in my initial reply there is a use case for more
> WB threads than fs writeback contexts, which is when the writeback

I understand that - there's more that one reason we may want
multiple IO dispatch threads per writeback context.

> threads do CPU intensive work like compression.  Being able to do that
> from normal writeback threads vs forking out out to fs level threads
> would really simply the btrfs code a lot.  Not really interesting for
> XFS right now of course.
> 
> Or in other words: fs / device geometry really should be the main
> driver, but if a file systems supports compression (or really expensive
> data checksums) being able to scale up the numbes of threads per
> context might still make sense.  But that's really the advanced part,
> we'll need to get the fs geometry aligned to work first.
> 
> > > > XFS largely stem from the per-IO cpu overhead of block allocation in
> > > > the filesystems (i.e. delayed allocation).
> > > 
> > > This is a good idea, but it means we will not be able to paralellize within
> > > an AG.
> > 
> > The XFS allocation concurrency model scales out across AGs, not
> > within AGs. If we need writeback concurrency within an AG (e.g. for
> > pure overwrite concurrency) then we want async dispatch worker
> > threads per writeback queue, not multiple writeback queues per
> > AG....
> 
> Unless the computational work mentioned above is involved there would be
> something really wrong if we're saturating a CPU per AG.

... and the common case I'm thinking of here is stalling writeback
on the AGF lock. i.e. another non-writeback task holding the AGF
lock - inode cluster allocation, directory block allocation, freeing
space in that AG, etc - will stall any writeback that requires
allocation in that AG if we don't have multiple dispatch threads per
writeback context available.

That, IMO, is future optimisation; just moving to a writeback
context per AG would solve a lot of the current "single thread CPU
bound" writeback throughput limitations we have right now,
especially when it comes to writing lots of small files across
many directories in a very short period of time (i.e. opening
tarballs, rsync, recursive dir copies, etc).

-Dave.
-- 
Dave Chinner
david@fromorbit.com

