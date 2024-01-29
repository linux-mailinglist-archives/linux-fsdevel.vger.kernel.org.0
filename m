Return-Path: <linux-fsdevel+bounces-9421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED338410A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3053F1C23B65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1B15B997;
	Mon, 29 Jan 2024 17:19:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADB15A4AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548747; cv=none; b=hCYBs6X5Bwn+6RGYrh/+cmZcGz1jWrSXsti+wqZ32/yHFmUK87tKlR2fLRWkqPhVM+ztdgzJ5vaOi9bci1p4YLUjI2dpocUBCzdGekojsQic1oGOWgDz+/J74p+hlhYy+i5jJDMqvv4iopMrk4L4e9PJ4y5vZjlGfVVG1+4OMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548747; c=relaxed/simple;
	bh=CrGR3Vd24qjAv2UAMwqM3GvjrbypUhp/gwevW2vvwU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rBhWJX6q9ETyQTERPg7YOX29SMcnCVZnT7KMXll8mm8stn8TGh3pVbQjPBFE7Gco1V9Kbs28Veq9B1VZtNWShL4o5zj5hLvK5gL6ntz8WAa5FTLrd+HYqaIXMIG2Ee+w12uU9tq5uk4JVexCLpAruJGzBnoorOyQ1FlNQP6IplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42ab03a5aeeso2587901cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 09:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706548744; x=1707153544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPbjIgKfD/DwpRuxKLxsFC/VJNggVx+ai46PgiPMXo4=;
        b=IzbEzZYGQESZZZCqnlOt9sa881/waeKx8S/0ReLvjgz8MSMI+0c50299KY7bFdhZbR
         NXo/CAdx2PWBMKi6ToNFGVekhrRfxnxAcbggWgal13Fh3BkIC4kufwbGMDLCb+Ctoxde
         1ixzhVpGJ/6Q8QZ5c8P6pImiCSmI0s0yWQpFLntZo06OzDHHBb/Z35l9e36gsaLtUdTb
         eOOQ3IsYEx45Jmc2jMXajMDVMvqqhKY7ps/GAOF+iJemJDPCDPrZ7+BN+/UnyuWvE8e7
         pPS5IDOJkvlu6kqpMFYSbseEKzK00MVnLc4jbHkFmmwJgNlxsDeoGIWMeNzOgXg23ozK
         n/SA==
X-Gm-Message-State: AOJu0YycXgbCDI7Bg5AzTO90OvSfjRHQgMNTuLnSvaWRuaUhjUyGHntX
	AXiuWIR3pY4t3EAMJNKALWwNSmxYMpNZITI/sNwENSykq7/4B1fzmL/Qku6Mag==
X-Google-Smtp-Source: AGHT+IGMWvJG/c2YxNlYkeOxS82LVRw4JavNfZWOPvBKtSW6N6czT9K5qJL2QYtv2CJ4Y5tR122O5Q==
X-Received: by 2002:a05:622a:589:b0:42a:72fc:d51f with SMTP id c9-20020a05622a058900b0042a72fcd51fmr7031035qtb.137.1706548744157;
        Mon, 29 Jan 2024 09:19:04 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ez12-20020a05622a4c8c00b0042a5c2a81a8sm3689174qtb.60.2024.01.29.09.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:19:03 -0800 (PST)
Date: Mon, 29 Jan 2024 12:19:02 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbfeBrKVMaeSwtYm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbenbtEXY82N6tHt@casper.infradead.org>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <20240128142522.1524741-1-ming.lei@redhat.com>

On Mon, Jan 29 2024 at  8:26P -0500, Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jan 29, 2024 at 04:25:41PM +0800, Ming Lei wrote:
> > Here the single .ra_pages may not work, that is why this patch stores
> > the willneed range in maple tree, please see the following words from
> > the original RH report:
> > 
> > "
> > Increasing read ahead is not an option as it has a mixed I/O workload of
> > random I/O and sequential I/O, so that a large read ahead is very counterproductive
> > to the random I/O and is unacceptable.
> > "
> 
> It is really frustrating having to drag this important information out of
> you. Please send the full bug report (stripping identifying information
> if that's what the customer needs).  We seem to be covering the same
> ground again in public that apparently you've already done in private.
> This is no way to work with upstream.

We are all upstream developers here. And Ming is among the best of us,
so please try to stay constructive.

You now have the full bug report (I provided the reproducer and
additonal context, and now Ming shared the "Increasing read ahead is
not an option..." detail from the original report).

BUT Ming did mention the potential for mixed workload in his original
RFC patch header:

On Sun, Jan 28 2024 at  9:25P -0500, Ming Lei <ming.lei@redhat.com> wrote:

> Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> only tries to readahead 512 pages, and the remained part in the advised
> range fallback on normal readahead.
> 
> If bdi->ra_pages is set as small, readahead will perform not efficient
> enough. Increasing read ahead may not be an option since workload may
> have mixed random and sequential I/O.

And while both you and Dave rightly seized on the seemingly "Doctor it
hurts when I clamp readahead to be small but then issue larger
sequential reads and want it to use larger readahead" aspect of this
report...

Dave was helpful with his reasoned follow-up responses, culminating
with this one (where the discussion evolved to clearly consider the
fact that an integral part of addressing the reported issue is the
need to allow for mixed workloads not stomping on each other when
issuing IO to the same backing block device):

On Mon, Jan 29 2024 at 12:15P -0500,
Dave Chinner <david@fromorbit.com> wrote:

> On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> > On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > > On Sun, Jan 28, 2024 at 7:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > > > Understood.  But ... the application is asking for as much readahead as
> > > > > possible, and the sysadmin has said "Don't readahead more than 64kB at
> > > > > a time".  So why will we not get a bug report in 1-15 years time saying
> > > > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > > > typically we allow the sysadmin to override application requests,
> > > > > don't we?
> > > > 
> > > > The application isn't knowingly asking for readahead.  It is asking to
> > > > mmap the file (and reporter wants it done as quickly as possible..
> > > > like occurred before).
> > > 
> > > ... which we do within the constraints of the given configuration.
> > > 
> > > > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > > > request size based on read-ahead setting") -- same logic, just applied
> > > > to callchain that ends up using madvise(MADV_WILLNEED).
> > > 
> > > Not really. There is a difference between performing a synchronous
> > > read IO here that we must complete, compared to optimistic
> > > asynchronous read-ahead which we can fail or toss away without the
> > > user ever seeing the data the IO returned.
> > 
> > Yeah, the big readahead in this patch happens when user starts to read
> > over mmaped buffer instead of madvise().
> 
> Yes, that's how it is intended to work :/
> 
> > > We want required IO to be done in as few, larger IOs as possible,
> > > and not be limited by constraints placed on background optimistic
> > > IOs.
> > > 
> > > madvise(WILLNEED) is optimistic IO - there is no requirement that it
> > > complete the data reads successfully. If the data is actually
> > > required, we'll guarantee completion when the user accesses it, not
> > > when madvise() is called.  IOWs, madvise is async readahead, and so
> > > really should be constrained by readahead bounds and not user IO
> > > bounds.
> > > 
> > > We could change this behaviour for madvise of large ranges that we
> > > force into the page cache by ignoring device readahead bounds, but
> > > I'm not sure we want to do this in general.
> > > 
> > > Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> > > value in this situation to override the device limit for large
> > > ranges (for some definition of large - say 10x bdi->ra_pages) and
> > > restore it once the readahead operation is done. This would make it
> > > behave less like readahead and more like a user read from an IO
> > > perspective...
> > 
> > ->ra_pages is just one hint, which is 128KB at default, and either
> > device or userspace can override it.
> > 
> > fadvise/madvise(willneed) already readahead bytes from bdi->io_pages which
> > is the max device sector size(often 10X of ->ra_pages), please see
> > force_page_cache_ra().
> 
> Yes, but if we also change vma->file->f_ra->ra_pages during the
> WILLNEED operation (as we do for FADV_SEQUENTIAL) then we get a
> larger readahead window for the demand-paged access portion of the
> WILLNEED access...
> 
> > 
> > Follows the current report:
> > 
> > 1) usersapce call madvise(willneed, 1G)
> > 
> > 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> > readahead in madvise(willneed, 1G) since commit 6d2be915e589
> > 
> > 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> > set as 64KB by userspace when userspace reads the mmaped buffer, then
> > the whole application becomes slower.
> 
> It gets limited by file->f_ra->ra_pages being initialised to
> bdi->ra_pages and then never changed as the advice for access
> methods to the file are changed.
> 
> But the problem here is *not the readahead code*. The problem is
> that the user has configured the device readahead window to be far
> smaller than is optimal for the storage. Hence readahead is slow.
> The fix for that is to either increase the device readahead windows,
> or to change the specific readahead window for the file that has
> sequential access patterns.
> 
> Indeed, we already have that - FADV_SEQUENTIAL will set
> file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
> larger IOs for that access.
> 
> That's what should happen here - MADV_WILLNEED does not imply a
> specific access pattern so the application should be running
> MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
> to start the readahead, and then the rest of the on-demand readahead
> will get the higher readahead limits.
> 
> > This patch changes 3) to use bdi->io_pages as readahead unit.
> 
> I think it really should be changing MADV/FADV_SEQUENTIAL to set
> file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
> mem.load() implementation in the application converted to use
> MADV_SEQUENTIAL to properly indicate it's access pattern to the
> readahead algorithm.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

Anyway, if we could all keep cool and just finish the discussion about
how to address the reported issue in a long-term supported way that'd
be _awesome_.

While I'm sure this legacy application would love to not have to
change its code at all, I think we can all agree that we need to just
focus on how best to advise applications that have mixed workloads
accomplish efficient mmap+read of both sequential and random.

To that end, I heard Dave clearly suggest 2 things:

1) update MADV/FADV_SEQUENTIAL to set file->f_ra.ra_pages to
   bdi->io_pages, not bdi->ra_pages * 2

2) Have the application first issue MADV_SEQUENTIAL to convey that for
   the following MADV_WILLNEED is for sequential file load (so it is
   desirable to use larger ra_pages)

This overrides the default of bdi->io_pages and _should_ provide the
required per-file duality of control for readahead, correct?

Thanks,
Mike

