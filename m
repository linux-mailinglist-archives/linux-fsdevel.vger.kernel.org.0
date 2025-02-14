Return-Path: <linux-fsdevel+bounces-41764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C7A3691D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 00:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B73AD4DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7B1FDA66;
	Fri, 14 Feb 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y7Lhfzlu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2771C84D9;
	Fri, 14 Feb 2025 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576260; cv=none; b=B2i4DSFhQiSFuT1kEW3M8pcsH4MmgP5Z6F4sXxz+FZPaMEnn8y6WB4k7NXkqgx2R+fopp6uLUIN9gtpvn1+ZJ7jgoo3hXACKfr3rlbOY9IveBOvIydWhpt6n0QDPZd4OTaoDjIPivyS/hcweWI0YS3XHU17zLNMXF0YJ9TuZ9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576260; c=relaxed/simple;
	bh=r0PNd1x2MlwrDxYhFCyXBzRBMGAnrkQjE1QlYWQCxMc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qC7RHFDarQVwctl9u4LjsuyelcYebwfIprxQELM+AR6WjFgvqF7/PYyHemAAAA7xs2ikHxG9DLbhfZyiFBgAU2pwWIsOGWN7qO0FP0UieKdzGpp7H+8ChzNRNV3SLLP2RmpsS9RW72hlI3PM3Es/u9wTA/albkbmuUhflKGZ6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y7Lhfzlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F14C4CED1;
	Fri, 14 Feb 2025 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739576259;
	bh=r0PNd1x2MlwrDxYhFCyXBzRBMGAnrkQjE1QlYWQCxMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y7LhfzluPL03AlbQ+tNHPtJGO06fXuEjGx9aURj4t94MlXT3+rQA7sxokzTjxg6wr
	 4qUtFS+UKLuZQTHoh1qUQfvve0qOgl1tfnNncHz/vQ8AL796SLOF8X6EJxUNq9/0b1
	 2KQipMIFui6GcMO1T07m082f9E/045TpiSqM2GD8=
Date: Fri, 14 Feb 2025 15:37:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] dax: Remove access to page->index
Message-Id: <20250214153738.4248664ec71581d31d4f9115@linux-foundation.org>
In-Reply-To: <ivwl5yqx7bfa6hw233gaicmdb3tvqmy6tqsrfbiyghzwlrghxk@yifmg7leosa7>
References: <20241216155408.8102-1-willy@infradead.org>
	<677c78a121044_f58f29458@dwillia2-xfh.jf.intel.com.notmuch>
	<ivwl5yqx7bfa6hw233gaicmdb3tvqmy6tqsrfbiyghzwlrghxk@yifmg7leosa7>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 10:24:00 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> > Question is whether to move ahead with this now and have Alistair
> > rebase, or push ahead with getting Alistair's series into -next? I am
> > hoping that Alistair's series can move ahead this cycle, but still
> > catching up on the latest after the holiday break.
> 
> The rebase probably isn't that hard, but if we push ahead with my series it's
> largely unnecessary as it moves this over to the folio anyway. I've just posted
> a respin on top of next-20241216 -
> https://lore.kernel.org/linux-mm/cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com/

I'll drop your v7 series from mm-unstable and shall add these two
patches from Matthew.

