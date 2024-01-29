Return-Path: <linux-fsdevel+bounces-9296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6083FD4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29276B22A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2D3CF61;
	Mon, 29 Jan 2024 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eMAiFTjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C03C484
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504198; cv=none; b=KWFDUhAYHo6W9Vc4PohizOrx3eU1SotxD4QrJuquSdVX23LyheJjktTS7O9A0mhHq4fm58trj+oFx/x2uy4TczIVcXtcWy+3SQAGaFuucAL3j7VwznJFvU5iipj2vnjLJhPSfQf+x6qKeL/0qr6yhKcuX4jcUWM4pxZDJ6ncSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504198; c=relaxed/simple;
	bh=JKE/IW5TVkbID/Q/j2NFEsbb8Z3r/k7LT5ELUg8rmMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S20Zv0hBkwhGZlw75nRDCjAVsvUQmCEygF/OJQY0R3srzsmk9jERlvO1Xc2VJz75o0eTudXnnD6Pp129eZn+Wc6nWawagsM8V+cII1N3tZqDWzkrZ4ul6EhtGfw2wHqPQkrtG0IEWIu/MlnnIpUI4zFwfXOKZlFNsM7xg7Ul/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eMAiFTjr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddcfda697cso1890264b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 20:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706504196; x=1707108996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4uVgZZNOGdztcThCjImfEeg1T+w1JfprEYe6mBtACg8=;
        b=eMAiFTjrr/vQjBBlNKqeI5B5NSt9vl4lhaVcImm+hbr1WtchPEmzKuNtWYiqG+pzDm
         24yT59EtQwzDTTEiVfMsero+dKkYqYE7os0l56W34qpBwoVYzQtchAWMRiVUE/MW9je9
         Zcy0HWtCZCLdavxWi0dYlGUFEqzBqXRv6nY11RiIp7jdEI4BGIlTP27RRES0d1tQlj8q
         SI/uKOKLOeRK8Xb0kEvnhu+j8P8r5ntkY24/Ej1MHkQu6LgOutx/7eKLOPMN/bdmjEz7
         TH6mCYZ+dGRAOmdray4AGapQ1aOGd7geuK4PhTClbbb0LdNmnhSQ8tndQUZCM7PNlKPg
         KX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706504196; x=1707108996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uVgZZNOGdztcThCjImfEeg1T+w1JfprEYe6mBtACg8=;
        b=G/CC6eimJVwm6FI/YoMEtlQ4ktZLSILdnraWotKivJP4ke6BHNXjkd57c/U9SNBdBU
         9XgYvFLKhO6lTmidzmyN2/jVqBA6P2stfH36Pf2MP2M75WXDoakuLrzaGSpCu5os6MVA
         zXS3j3z2//LZwXUaL7WlEq+W1zakmahmalMIcH1bgYpAAd7KXzvfD9As7fDkJFsct3bz
         k1CLWx3MJd4cR3bcGSgLWehsy+vb9Q7znutj+Z0/MZzD0LXY+JuLn8nfu0Af7j5BI2qK
         ar1zw2ptKvSjIirhEMxwFbtdyVGwCSHmIthQAYnmnsxriz9/wtkoYAyS4aqy1qomVU+r
         YXFw==
X-Gm-Message-State: AOJu0YxtxufNM2qifF06BwCf6m20+eF3n91Oz+30noaJxfd1du7o10o7
	9fYGom57VP7tflVVdlE0iyR/dmz9BNdumVAJY4Kr183ld670niRefG+TeYDt734=
X-Google-Smtp-Source: AGHT+IFoFcFBxLwYTXGmXANOC97mvFw7PZV9squyfuKtmaABij+gT0sLLCatjYYhzbO+aUmnpRulcA==
X-Received: by 2002:a05:6a00:18a1:b0:6dd:c61e:2026 with SMTP id x33-20020a056a0018a100b006ddc61e2026mr3771217pfh.9.1706504196508;
        Sun, 28 Jan 2024 20:56:36 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78c18000000b006dddd283526sm4893266pfd.53.2024.01.28.20.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 20:56:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUJgw-00Gj5q-2H;
	Mon, 29 Jan 2024 15:56:18 +1100
Date: Mon, 29 Jan 2024 15:56:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <Zbcv8tKISFYRaMye@dread.disaster.area>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <CAH6w=azbfYCbC6m-bh-yUt3HMUe-EnWPV71P+Z=jeNwMU5aHaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH6w=azbfYCbC6m-bh-yUt3HMUe-EnWPV71P+Z=jeNwMU5aHaQ@mail.gmail.com>

On Sun, Jan 28, 2024 at 09:12:12PM -0500, Mike Snitzer wrote:
> On Sun, Jan 28, 2024 at 8:48 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > On Sun, Jan 28, 2024 at 7:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > > Understood.  But ... the application is asking for as much readahead as
> > > > possible, and the sysadmin has said "Don't readahead more than 64kB at
> > > > a time".  So why will we not get a bug report in 1-15 years time saying
> > > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > > typically we allow the sysadmin to override application requests,
> > > > don't we?
> > >
> > > The application isn't knowingly asking for readahead.  It is asking to
> > > mmap the file (and reporter wants it done as quickly as possible..
> > > like occurred before).
> >
> > .. which we do within the constraints of the given configuration.
> >
> > > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > > request size based on read-ahead setting") -- same logic, just applied
> > > to callchain that ends up using madvise(MADV_WILLNEED).
> >
> > Not really. There is a difference between performing a synchronous
> > read IO here that we must complete, compared to optimistic
> > asynchronous read-ahead which we can fail or toss away without the
> > user ever seeing the data the IO returned.
> >
> > We want required IO to be done in as few, larger IOs as possible,
> > and not be limited by constraints placed on background optimistic
> > IOs.
> >
> > madvise(WILLNEED) is optimistic IO - there is no requirement that it
> > complete the data reads successfully. If the data is actually
> > required, we'll guarantee completion when the user accesses it, not
> > when madvise() is called.  IOWs, madvise is async readahead, and so
> > really should be constrained by readahead bounds and not user IO
> > bounds.
> >
> > We could change this behaviour for madvise of large ranges that we
> > force into the page cache by ignoring device readahead bounds, but
> > I'm not sure we want to do this in general.
> >
> > Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> > value in this situation to override the device limit for large
> > ranges (for some definition of large - say 10x bdi->ra_pages) and
> > restore it once the readahead operation is done. This would make it
> > behave less like readahead and more like a user read from an IO
> > perspective...
> 
> I'm not going to pretend like I'm an expert in this code or all the
> distinctions that are in play.  BUT, if you look at the high-level
> java reproducer: it is requesting mmap of a finite size, starting from
> the beginning of the file:
> FileChannel fc = new RandomAccessFile(new File(args[0]), "rw").getChannel();
> MappedByteBuffer mem = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());

Mapping an entire file does not mean "we are going to access the
entire file". Lots of code will do this, especially those that do
random accesses within the file.

> Yet you're talking about the application like it is stabbingly
> triggering unbounded async reads that can get dropped, etc, etc.  I

I don't know what the application actually does. All I see is a
microbenchmark that mmaps() a file and walks it sequentially. On a
system where readahead has been tuned to de-prioritise sequential IO
performance.

> just want to make sure the subtlety of (ab)using madvise(WILLNEED)
> like this app does isn't incorrectly attributed to something it isn't.
> The app really is effectively requesting a user read of a particular
> extent in terms of mmap, right?

madvise() is an -advisory- interface that does not guarantee any
specific behaviour. the man page says:

MADV_WILLNEED
       Expect access in the near future.  (Hence, it might be a good
       idea to read some pages ahead.)

It says nothing about guaranteeing that all the data is brought into
memory, or that if it does get brought into memory that it will
remain there until the application accesses it. It doesn't even
imply that IO will even be done immediately. Any application
relying on madvise() to fully populate the page cache range before
returning is expecting behaviour that is not documented nor
guaranteed.

Similarly, the fadvise64() man page does not say that WILLNEED will
bring the entire file into cache:

POSIX_FADV_WILLNEED
        The specified data will be accessed in the near future.

	POSIX_FADV_WILLNEED  initiates a nonblocking read of the
	specified region into the page cache.  The amount of data
	read may be de‐ creased by the kernel depending on virtual
	memory load.  (A few megabytes will usually be fully
	satisfied, and more is rarely use‐ ful.)

> BTW, your suggestion to have this app fiddle with ra_pages and then

No, I did not suggest that the app fiddle with anything. I was
talking about the in-kernel FADV_WILLNEED implementation changing
file->f_ra.ra_pages similar to how FADV_RANDOM and FADV_SEQUENTIAL
do to change readahead IO behaviour. That then allows subsequent
readahead on that vma->file to use a larger value than the default
value pulled in off the device.

Largely, I think the problem is that the application has set a
readahead limit too low for optimal sequential performance.
Complaining that readahead is slow when it has been explicitly tuned
to be slow doesn't really seem like a problem we can fix with code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

