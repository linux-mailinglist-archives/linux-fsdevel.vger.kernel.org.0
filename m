Return-Path: <linux-fsdevel+bounces-44810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D6A6CC9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 22:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350B31889CDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895B23535B;
	Sat, 22 Mar 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0scgQiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553D158D8B;
	Sat, 22 Mar 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678031; cv=none; b=pKLcpVcnEKII9KIOpytOMY3I9B35qETUWumxIm1dJD0SM1BTR2MhwhgwvsEYVCRJAQdt8T4NhiFPqJraY9C5Y4OQ7DhLAH+DbjN2F2Bs0bDaCA6K/pZCowKXied5hSTyCMTLMjDNiqSq/a9o/YICMRL7heVnXAeGhIllzbEUuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678031; c=relaxed/simple;
	bh=z6Kb0zH8nQcvLTFP1HgxUUraOMcBI6i3DEzgydeSca4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmZSBeHit4yE3KGfii1d9Z4T7EyTs1NqwEdqpZWRggjPul0qey45RqYz/QXxUpgPhCWADa2nl3Vl9J+9+QPILoO+LP07qbL2mX3kUmHp/Ug0WmD4yQfVT4EXOBwIgF7cZ7Qq/zMC/HUIKDgOdBePdUA9hzk2uGD2zXRtO/T1NAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m0scgQiN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jw4nRoBv7YvGHs2GxEuwE6E/Q8bCcDDx4GQysHcomdY=; b=m0scgQiNuoD5yPnuFu0bD4acmd
	7Zlo/jvG7RNVmecORw+43mRCw8GjWi0NUBFsEnqzroN4seI1rscu3MRdkxqZnZwMPuUhN6NuL0I9H
	cIESWsscc/n7z0SWwuI3gfTQaBCblcGGy2rKACT90wKqjg+4EvpIKv2r4R5QCUc1/C6OmGlqH6Q8g
	81oSZ0WzNXLHcfqRNVKhkeQCIc0LvBqKthNaE66NFqKOYXvxXn2+1KBMYmC/bV07ve/WrrD145jyu
	OymivnxU8lm2PCxI0dy4KEXPjEEVun3Yw0tTBZk8F4GSpAgdEa8B15pz3vXedxnXKupDrLyant1tF
	u0fAiToA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tw6A6-00000005qST-1h6Y;
	Sat, 22 Mar 2025 21:13:46 +0000
Date: Sat, 22 Mar 2025 21:13:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] XArray: revert (unintentional?) behavior change
Message-ID: <Z98oChgU7Z9wyTw1@casper.infradead.org>
References: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>

On Fri, Mar 21, 2025 at 10:17:08PM -0400, Tamir Duberstein wrote:
> Partially revert commit 6684aba0780d ("XArray: Add extra debugging check
> to xas_lock and friends"), fixing test failures in check_xa_alloc.
> 
> Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and friends")

This doesn't fix anything.  The first failure is:

#6  0x0000555555649979 in XAS_INVALID (xas=xas@entry=0x7ffff4a003a0)
    at ../shared/linux/../../../../include/linux/xarray.h:1434
#7  0x000055555564f545 in check_xas_retry (xa=xa@entry=0x55555591ba00 <array>)
--Type <RET> for more, q to quit, c to continue without paging--
    at ../../../lib/test_xarray.c:131
#8  0x0000555555663869 in xarray_checks () at ../../../lib/test_xarray.c:2221
#9  0x00005555556639ab in xarray_tests () at xarray.c:15

That has nothing to do with xa_destroy().  What on earth are you doing?

Anyway, I'm at LSFMM and it'a Saturday.  I shan't be looking at this
until the 27th.  There's clearly no urgency since you're the first one
to notice in six months.

