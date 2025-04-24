Return-Path: <linux-fsdevel+bounces-47292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE062A9B867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97165A5290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31943292935;
	Thu, 24 Apr 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tmzqyhip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36212918CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523725; cv=none; b=Dg2S0yFhDuSdgRc79pGJKqkxin3IuhiMN3DUo7KCliL/qrGzCxtEA5yxAV3U44tGS1pDoQMhRlRV+RPhdnHDUTMSy+WLGoQWqQ/ZQY+gGipVWSblUwbvib613VuB3Uw9J5F9emevsbv7QJixnc/5guEOnOHIo2QQaZDtoZAy5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523725; c=relaxed/simple;
	bh=oFeUC1CZiNf3SABzetVlqz9xP2VpwIpTn66Drtl9gWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx+QMrh98QmsP2XxUwltZ8wppMDTC5QVz1n0UTbkrk++Wy+a8LXeGMjfmXQ93kuv1VI2OEmB2lMzwzL0qEDrgMTUwq8PMNc3F4psCn9bdi5m2aBFeWFqHbA5o7XLyiVjHss3fTsRCF55ljojJLabZ06/BFVgwq17WURIFP5CsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tmzqyhip; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rz7e/5Ervl1fpk82A/cIlpJuDHJpWv9gwT/6zSqHPHM=; b=Tmzqyhipcwr48ipqQrscLCVRFO
	vrXLLwEDJf1kddCVck5JgVOaDh/1cnXpA8ChqnSLaV2mO8lRMhUMGztOJMmNk8LSFyqit5DghmohM
	dZJGsf9zukd8fKnVffAHdQfOR1BTAIcnVEcVC7ifovn5YMpbVU2zDPqzup43UTq85n8eZF4g1d+dQ
	32c3heBZ1lt49DzDdN1jJN224N4r/Kz0GzOdDnPsopsKr2atukw46e0j6+s+NMvs32KbGhVV0KQrS
	b7nag1tW3z7lkDFu8v4OCtKs+zdrLLN8Wdfmlei0qAM7w02qQUqdEGz6WGwqNZt+m8auBUvj6x/qq
	Fiw+OGdw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u82SO-0000000D5lv-1gF8;
	Thu, 24 Apr 2025 19:42:00 +0000
Date: Thu, 24 Apr 2025 20:42:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAqUCK6V1I08cPpj@casper.infradead.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAqCXfPirHqWMlb4@x1.local>

On Thu, Apr 24, 2025 at 02:26:37PM -0400, Peter Xu wrote:
> Secondly, userfaultfd is indeed the only consumer of
> FAULT_FLAG_INTERRUPTIBLE but not necessary always in the future.  While
> this patch resolves it for userfaultfd, it might get caught again later if
> something else in the kernel starts to respects the _INTERRUPTIBLE flag
> request.  For example, __folio_lock_or_retry() ignores that flag so far,
> but logically it should obey too (with a folio_wait_locked_interruptible)..

No.  Hell, no.  We don't want non-fatal signals being able to interrupt
that.  There's a reason we introduced killable as a concept in the first
place.


