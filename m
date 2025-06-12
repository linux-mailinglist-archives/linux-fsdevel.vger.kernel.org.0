Return-Path: <linux-fsdevel+bounces-51416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBE7AD68E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5393A33CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9D20E032;
	Thu, 12 Jun 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cJNxZQeg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84D1F4163;
	Thu, 12 Jun 2025 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713028; cv=none; b=IZqGVfbt2JLYE2tGHXfMpT1AWy/eVd1CieokdCWuaoMAu5KglajsaiXUm5M7M/V+Xg/YNSQCAA0LKTiVTrd+XPG92SjUg/vMr4B9uB/EQBtX3emLmR9mVBSRQa1R6a70sC5zS8ENVIsFy6F2zPwKOaIS/k+0aG+/cV2nVJKAdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713028; c=relaxed/simple;
	bh=QMdCLcRXTBb3XVR0EAk4cc7gQR9FM6I/8SQ6CxFjtag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWhRgzKomwnYR6vOJiSCh55RUHs2jT+mAHLUZ9RFNz8KfaQfxlJ26UPCPgxJZ0S8vBMh0xb8L1mFc7OZXu68PERj8DWlAcwy73P59K8X+upAWiZo8CjZwEYH+vx86+FL4EIYvMjP+xGtMYBEKFIp/1dvH/T9KMCQI+xyYa8iW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cJNxZQeg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3gghXkMSEe+mD80L75sRbNjZie9g6/P/g1H9Y5GQDs=; b=cJNxZQegBFHKYv4wyrZ49SKPkf
	xNe6KFXOiWT6sdbLj0jKvMlNWtF25FPJM/ALS6MRem+36vsnX0h2oWPk7wg7odgXIhBV0qPHjW5GW
	bQapqM3i5+ZtgTPsKWKQe53brBNLmnsj4aoL/Z3AMYlXSRA0ZWjZaYvf8Ff5T9XaDEsTSveJB25jq
	jV01Ns0Sm4Bh+Q/mzKsktOv1dE5+elU+r74r1EyhdEp37q7XZ/rvoW3Q4q4OxKO9WuZljZC1VG5dF
	juetKrrutoyFIJ0b6NHSfySUzZRh6AgwO11brNi6dkx/nR6lxksvxAlekNAgXZADsTWJvXNMcEnGQ
	SQy6vy2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcHq-0000000CREt-0kPW;
	Thu, 12 Jun 2025 07:23:46 +0000
Date: Thu, 12 Jun 2025 00:23:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEqAghzJ4q5QNFu9@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <aEkpcmZG4rtAZk-3@infradead.org>
 <aEl1RhqybSCAzv3H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEl1RhqybSCAzv3H@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 08:23:34AM -0400, Mike Snitzer wrote:
> On Wed, Jun 11, 2025 at 12:00:02AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 10, 2025 at 04:57:36PM -0400, Mike Snitzer wrote:
> > > IO must be aligned, otherwise it falls back to using buffered IO.
> > > 
> > > RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> > > nfsd/enable-dontcache=1) because it works against us (due to RMW
> > > needing to read without benefit of cache), whereas buffered IO enables
> > > misaligned IO to be more performant.
> > 
> > This seems to "randomly" mix direct I/O and buffered I/O on a file.
> 
> It isn't random, if the IO is DIO-aligned it uses direct I/O.

Which as an I/O pattern does look pretty random :)

> > But maybe also explain what this is trying to address to start with?
> 
> Ha, I suspect you saw my too-many-words 0th patch header [1] and
> ignored it?  Solid feedback, I need to be more succinct and I'm
> probably too close to this work to see the gaps in introduction and
> justification but will refine, starting now:

Well, I was mostly asking about the description for this patch in
particular.  Given that all the naming and the previous patches seemed
to be about dontcache I/O having optional direct I/O in here looked
really confusing.


