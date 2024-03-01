Return-Path: <linux-fsdevel+bounces-13250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80986DB47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 06:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DEF28570E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5851C3B;
	Fri,  1 Mar 2024 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WsS0HcD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991ED3FE23
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709272501; cv=none; b=bJHSXhogLLCOXr+VZ+YQsXiVsOi1AirUirhDX7oZ0RSxbhkt1Dr0XAzGd887r6NZ45WNVOMbu4Z97t/mJtQj7fxVNIAxax04jhD2fqg5D+6lpnferMU/RxPWFT3jR2BU4VjYuTbT0W52OgjIwFGwNJxLw3nlRHse0chl8x4WitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709272501; c=relaxed/simple;
	bh=vo+zPMtEpDGuRnWYJqCUuac2BuzfyLbJaNfYo+JRREs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuKfzX0VS+0NrOIFA45ULErVM3AhNx6MpeKMdB0gi7saf7Cxd8LUZzj5mPkB8dKNGWNIcP9MiXKOUEXqc3+0s1il+HBHApNmbzs/MNdsIHPH9YMk3Gk18cs4oOLJ1qPDS42/z9mXSwSAjQI22+Gz4+iqKFE1YE68SE3ybiojk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WsS0HcD4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e581ba25e1so1384196b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709272499; x=1709877299; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGDn7ZK32B8h9n8KioFlM4UEP+LNgayWnltJM0K/kfk=;
        b=WsS0HcD4bp7Q6z6A3rF3IkdGAtvGksLcTmoLm1f041mKr8GKIdgfKCoRPBy2/xeqeC
         H4ICHB8OF3e23x4Lv4YrHajdQUACV/NJqBfleRpwZ5+GetwsNZUuENkA+9O5o/iqvAtI
         MRHJ4Dg9/cCrfwjRy6oHN39E3itI5ldN9ocQ8JSZbySRPomI/+oUuC0N+uf2ZCDGOwdq
         VVMk1Q+hRR1LdkgvGAI1KdMbJXhxlLgqSq6nyWUuJDZaQD1+14Eyzfc9vWNGYpS80SeP
         dtAFT0RimK/vjhXlUKN7icHHBCRpt0T81xSsHLVSZBAYyoiDDrUPaSknCr07foqkE02w
         J6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709272499; x=1709877299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGDn7ZK32B8h9n8KioFlM4UEP+LNgayWnltJM0K/kfk=;
        b=OrCUzDJvEFoInSxv8eXxzIEGTb5mnrgc44Hr/J9RM6p6arUso1r+BX63oBUFz9JVq4
         CBpkWgta/5IUUZVHZK3/gZ4EhwAUBX71eBS7YpqgG5GgHiO1rxfRn55a+CwTXOLdscvY
         Fhhch9h8+AVI/5+wZYSlAyDBybfU7pEv+o2qvFPZA+jUTbKEVZdQ9i6qPE6fmtpyD3yW
         SqxCgW5o16d2ITi1W1Q1+U3kh3zAxmjyfb3sW7Xn5LVeh75MylluRtHS0lWFmgeyK78A
         nr1/sRk2ydDyKeuvGb3HcOQdm9FedzBZ74ZDV6tEc9doVv5xgq7L0J9lHDlPoo2cq1At
         T6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXnI4q25hCy/8Pz0PyQcObuSs6j7oLa6geTfGpNno1TM8/C1UmsJ6qEcE5yg+3nWVe7GF/rrIZHgemwRVoEBDDKzmJrscqpCHN+5TMwPg==
X-Gm-Message-State: AOJu0YyxeyF+ciYt+pTZY9zIEx1FVwKv2mG5wnNsyYN7FdHWUmUUgIkc
	Hpm5Nue6jwQQ34lNmv6LXGAjERDDXRQYImqu31Qg4DKqsUnd9vlxzBjuyY2ancI=
X-Google-Smtp-Source: AGHT+IGtgbu6rCNd+7STdgjPsKcgbdogJOVZR6qXc8EGJrqH8DYFbgxEUQRJXhe8JQdXD2vD+wv3Sw==
X-Received: by 2002:a05:6a00:9097:b0:6e4:908c:613b with SMTP id jo23-20020a056a00909700b006e4908c613bmr1851056pfb.8.1709272498722;
        Thu, 29 Feb 2024 21:54:58 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id du8-20020a056a002b4800b006e559c41679sm2188675pfb.2.2024.02.29.21.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 21:54:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfvrD-00DQmA-0Z;
	Fri, 01 Mar 2024 16:54:55 +1100
Date: Fri, 1 Mar 2024 16:54:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZeFtrzN34cLhjjHK@dread.disaster.area>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170925937840.24797.2167230750547152404@noble.neil.brown.name>

On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> On Thu, 29 Feb 2024, Matthew Wilcox wrote:
> > On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > Recent discussions [1] suggest that greater mutual understanding between
> > > > memory reclaim on the one hand and RCU on the other might be in order.
> > > >
> > > > One possibility would be an open discussion.  If it would help, I would
> > > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > > some ways that RCU's reactions and responses could be enhanced if needed.
> > > >
> > > 
> > > Adding fsdevel as this should probably be a cross track session.
> > 
> > Perhaps broaden this slightly.  On the THP Cabal call we just had a
> > conversation about the requirements on filesystems in the writeback
> > path.  We currently tell filesystem authors that the entire writeback
> > path must avoid allocating memory in order to prevent deadlock (or use
> > GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
> > writing pagecache back will not allocate memory in, eg, the network stack,
> > the device driver, and any other layers the write must traverse.
> > 
> > With the removal of ->writepage from vmscan, perhaps we can make
> > filesystem authors lives easier by relaxing this requirement as pagecache
> > should be cleaned long before we get to reclaiming it.
> > 
> > I don't think there's anything to be done about swapping anon memory.
> > We probably don't want to proactively write anon memory to swap, so by
> > the time we're in ->swap_rw we really are low on memory.
> > 
> > 
> 
> While we are considering revising mm rules, I would really like to
> revised the rule that GFP_KERNEL allocations are allowed to fail.
> I'm not at all sure that they ever do (except for large allocations - so
> maybe we could leave that exception in - or warn if large allocations
> are tried without a MAY_FAIL flag).
> 
> Given that GFP_KERNEL can wait, and that the mm can kill off processes
> and clear cache to free memory, there should be no case where failure is
> needed or when simply waiting will eventually result in success.  And if
> there is, the machine is a gonner anyway.

Yes, please!

XFS was designed and implemented on an OS that gave this exact
guarantee for kernel allocations back in the early 1990s.  Memory
allocation simply blocked until it succeeded unless the caller
indicated they could handle failure. That's what __GFP_NOFAIL does
and XFS is still heavily dependent on this behaviour.

And before people scream "but that was 30 years ago, Unix OS code
was much simpler", consider that Irix supported machines with
hundreds of NUMA nodes, thousands of CPUs, terabytes of memory and
petabytes of storage. It had variable size high order pages in the
page cache (something we've only just got with folios!), page
migration, page compaction, memory and process locality control,
filesystem block sizes larger than page size (which we don't have
yet!), memory shrinkers for subsystem cache reclaim, page cache
dirty throttling to sustained writeback IO rates, etc.

Lots of the mm technology from that OS has been re-implemented in
Linux in the past two decades, but in several important ways Linux
still falls shy of the bar that Irix set a couple of decades ago.
One of those is the kernel memory allocation guarantee.

> Once upon a time user-space pages could not be ripped out of a process
> by the oom killer until the process actually exited, and that meant that
> GFP_KERNEL allocations of a process being oom killed should not block
> indefinitely in the allocator.  I *think* that isn't the case any more.
> 
> Insisting that GFP_KERNEL allocations never returned NULL would allow us
> to remove a lot of untested error handling code....

This is the sort of thing I was thinking of in the "remove
GFP_NOFS" discussion thread when I said this to Kent:

	"We need to start designing our code in a way that doesn't require
	extensive testing to validate it as correct. If the only way to
	validate new code is correct is via stochastic coverage via error
	injection, then that is a clear sign we've made poor design choices
	along the way."

https://lore.kernel.org/linux-fsdevel/ZcqWh3OyMGjEsdPz@dread.disaster.area/

If memory allocation doesn't fail by default, then we can remove the
vast majority of allocation error handling from the kernel. Make the
common case just work - remove the need for all that code to handle
failures that is hard to exercise reliably and so are rarely tested.

A simple change to make long standing behaviour an actual policy we
can rely on means we can remove both code and test matrix overhead -
it's a win-win IMO.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

