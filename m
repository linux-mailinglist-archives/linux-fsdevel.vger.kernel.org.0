Return-Path: <linux-fsdevel+bounces-34270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F409C4388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E468DB268E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01DA1A707E;
	Mon, 11 Nov 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0WTjtB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36531A7253;
	Mon, 11 Nov 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345907; cv=none; b=LJqd/pJOaHLLUHw5HxWOv1mALPa5wJTcuVcceWPPgJLzR4/qIaF2rRpaxWn81kM7hVy+QC11aaoarzthDEB0SWyK5UhMgFWaxS/iWwx+Gii6V/xhCDxwL1WDxA8IRO0AjCgBMT7AW2moUa+g4YQQKQbQ2AZvAyVpScg8O6cD4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345907; c=relaxed/simple;
	bh=xQJPuTKPFMshEo9Gly010d2kEqMnM5zc2zSmlWXfGds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzJ50mjSr+1n3H8lVOo6W77qAmyop3LDsSqHrYuhXbbuve4x4MS92UrW8UhbfiRSxts2TQ4+8kFh/42sBDr95O8bLuY37u4oR8EcurlyysCgLz5qtLaOMLQz74JO/sS1RJVMbGNi98/oWLa7XQSnm3e1oGMpuwi7lAmO+1oKyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m0WTjtB3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oJUvmaLMls4QyVzgHd/CRZouPmHJ7haStEfbTpiaAew=; b=m0WTjtB3Wzbx5YCUos/R4iC9nd
	RsodqXy5/xaK5T2nSiM70xxtagh1+X9FDg/T0WngMNVYuBCDSNDQwFNS3ylYNvsS/+Rn87wsNNHQC
	zVrF0HIhto6Jpbr6Fr0bywwxtMlftHam8UkVpKnE95siACzcS/duhgakqZAx9kNVqvMscs97IX8Xp
	t3zEvAlCA1feLMpFJX6ElXvbeUWfsW1VSsWsGBpic8Z3jl82OLsdj0O+aMgvFboOyg+3HNFx3yiqm
	0MLERIyBN//COqsniZUidzmAiuyF9VOngXQlivO5BmFneBBd9HwXs+0USuUphA7uYcdBVXV1+oXy+
	0dT3KpVw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAY9t-0000000D4Dx-1vG2;
	Mon, 11 Nov 2024 17:25:01 +0000
Date: Mon, 11 Nov 2024 17:25:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
Message-ID: <ZzI97bky3Rwzw18C@casper.infradead.org>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>

On Sun, Nov 10, 2024 at 08:27:52AM -0700, Jens Axboe wrote:
> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
> to do buffered IO that isn't page cache persistent. The approach back
> then was to have private pages for IO, and then get rid of them once IO
> was done. But that then runs into all the issues that O_DIRECT has, in
> terms of synchronizing with the page cache.

Today's a holiday, and I suspect you're going to do a v3 before I have
a chance to do a proper review of this version of the series.

I think "uncached" isn't quite the right word.  Perhaps 'RWF_STREAMING'
so that userspace is indicating that this is a streaming I/O and the
kernel gets to choose what to do with that information.

Also, do we want to fail I/Os to filesystems which don't support
it?  I suppose really sophisticated userspace might fall back to
madvise(DONTNEED), but isn't most userspace going to just clear the flag
and retry the I/O?

Um.  Now I've looked, we also have posix_fadvise(POSIX_FADV_NOREUSE),
which is currently a noop.  But would we be better off honouring
POSIX_FADV_NOREUSE than introducing RWF_UNCACHED?  I'll think about this
some more while I'm offline.

