Return-Path: <linux-fsdevel+bounces-20930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E188FAEB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1AD28368D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09605143898;
	Tue,  4 Jun 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/iyTqJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF4142E63
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493208; cv=none; b=Z7Pmo2QpGVQ01CzhXoal9Gb0u3ZOj0Y+xEI59nustlhi4lzPBU3Tinrp/QenVqyDG6j7+tc8v4E1+h9ej3EMpdOkZ4As57Y4FlOHnXV/CzFs9KzHrXPKcOOI8SUmY6fo27JIdiW8OkQTEruygu+IRtw4ftZljjOIU7pZAUWkJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493208; c=relaxed/simple;
	bh=aVQnIPm1ZMTJ9RbIhPF6MnGMusADLtPLarvam/Gs+Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnfh7ulxF1US3vVX8T1F7GVlIsxWeT0EM2oAtbUzAdwtWOG0rus+RSbjJpMnKZ+vVMEF2SqmFRcev2mtWG/z4jNHsLV4kBxQU3CjlJ+urP5gu9I35n8c6COWF5e8Jf3SkyTSyAfXwaPYC7BXA+Yli7pvkO2WUFWVLlzCTK6iyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M/iyTqJH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L/kzu0HD4XWFceqdw27/Z8VfxVxA7swpYnMTjuuLn/M=; b=M/iyTqJHE2OlKfN+zUXDfOH2t9
	fXYgrLVaBI8pKVD6qIpPK0XNELFzqfJAsMJIDjY1arMoMPSs42h60I74hMdjAfq8F31N0RpvrmK2O
	4Xk5FdD2/fBRGt7e95bqMfPN2I9w8GBT2A24dDaCJNLknPNX2muzh4uInGa8uosJhJg4oRQvt/Itb
	gSGvmt881elLYoo9rL+gC8YXUK4ERezuv5xHKNCZTwW0mpTsGXoTR0bNGo+aQGxX61vA9fwiWNrZT
	1UgJwv+0StSzARaaI6Em3HTaWJ+pWvlkLqpTJe6QH+0kSZEV+XXwl2/3/JIsTdU7n8yUFDXoTJkeO
	kOF2pK4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQRB-0000000FW6s-0LI4;
	Tue, 04 Jun 2024 09:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9C4C730068B; Tue,  4 Jun 2024 11:26:35 +0200 (CEST)
Date: Tue, 4 Jun 2024 11:26:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, Ingo Molnar <mingo@redhat.com>,
	Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Message-ID: <20240604092635.GN26599@noisy.programming.kicks-ass.net>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
 <20240530203729.GG2210558@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530203729.GG2210558@perftesting>

On Thu, May 30, 2024 at 04:37:29PM -0400, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:50PM +0200, Bernd Schubert wrote:
> > This is needed by fuse-over-io-uring to wake up the waiting
> > application thread on the core it was submitted from.
> > Avoiding core switching is actually a major factor for
> > fuse performance improvements of fuse-over-io-uring.
> > 
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrei Vagin <avagin@google.com>
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Probably best to submit this as a one-off so the sched guys can take it and it's
> not in the middle of a fuse patchset they may be ignoring.  Thanks,

On its own its going to not be applied. Never merge an EXPORT without a
user.

As is, I don't have enough of the series to even see the user, so yeah,
not happy :/

And as hch said, this very much needs to be a GPL export.

