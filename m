Return-Path: <linux-fsdevel+bounces-42336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95994A40926
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 15:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FD417B606
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDF156653;
	Sat, 22 Feb 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qYT7lIe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477914AD20
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235040; cv=none; b=DEIYV/ojGyACyBvprSZs2lwfwARxY+WqtG95hNhz48VSY2YyzotYwPS4n5kTYDfhQhfz01XIbAy2Zp7n4/h51/CoGXtyvi0rg5PtAr8x8eouJEmquxi8S0KDzyTqDcvBemuIcw8LKAm0VZzqMYOkq4bD9vIrzSDQJooMpJwsezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235040; c=relaxed/simple;
	bh=S8LSxqUUTwWiuPn3a+qfxjZHcpdf2HtJGWhn5NU/Ih4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqGwEeApHIzYcabAMhPLaYeY/EVlb+hhwf2CV6KmEHcV7kVVmxSWcfdW7KM1LlibhnhGOtyrepBCSHFy87odseEWqeYT5BMTWo6kJxDaFTfvMAelUykFxHmK+IrAr1soXdUDNsBSF6Q0vrdlpLGz6V/UEv6wsnwUQimgxk4ISng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qYT7lIe7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 09:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740235029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uaH8O8KfoK/B3DyCyjI1TzhSOYWx8ED7uQ8V9Ti0pZo=;
	b=qYT7lIe7l6jK8nGkaXrqMmoqLflq70a3FECesesN6mHGx4rY59f4SX0Cbn3QWi3NEdQpqZ
	wiViO6LWehJvoy3Pyh0ummLLRTmWDWT44Z8m27g9nDvXiN7J/wNdY1UUBY13mgV99NHujq
	LcmGGDb3pIbZY0WkDsCuGp2XqHODETc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: check for folio order < mapping min order
Message-ID: <wma6tb6spzainc63yrgyc2efvve4vt2smza5yqtbva64a6vfrx@xxswn6whnnxy>
References: <20250220204033.284730-1-kent.overstreet@linux.dev>
 <Z7e5qkGm7Wt0C3Vp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7e5qkGm7Wt0C3Vp@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 11:24:26PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 20, 2025 at 03:40:33PM -0500, Kent Overstreet wrote:
> > accidentally inserting a folio < mapping min order causes the readahead
> > code to go into an infinite loop, which is unpleasant.
> 
> We already have:
> 
>         VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
>                         folio);

WARN_ON() and returning an error is a bit more appropriate here, don't
you think?

> If you're not enabling CONFIG_DEBUG_VM in your testing, I think that's
> an oversight on your part.

Fastpath and expensive asserts should certainly be behind a config
option, but I don't think this one should be.

There's too many subsystem specific debug modes to test the full matrix
of all of them, which means there are things that make it past our
testing and we need to be able to catch them in the wild or on realistic
test configurations. In practice, subsystems need to have a subset of
judiciously chosen asserts that are always on.

