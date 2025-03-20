Return-Path: <linux-fsdevel+bounces-44613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E53A6AAAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E065487887
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242B1EB18F;
	Thu, 20 Mar 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrtllNUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B658157A72;
	Thu, 20 Mar 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486818; cv=none; b=q7Wv65osXFEF6j4vgjC2/zsIewG7xB3NnsakjfLgOiYdWfPnKeytMtXfH/0iQn3UYUNoixeI9PUholXBIncY92WfxYitEHaHLbxWkOUnHDYyvlDhNz7LqoPScEX/PA4qi+VK3eRXzNL92GEFr9mtG4ykw0Tnv5VC/DhtVODbfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486818; c=relaxed/simple;
	bh=k53By2G4fhN/RrRmYLLGEMxTq9nwpZA6H7rF4iJao0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KldrWvVUwOM58aKP/PsgKjVSlWlHQyFMw5rr33N598CpxqyP1AYoVkhn1+iIHf/1PdSFde+fioyVgqUjfMJ9S9kVnxlK+YXRADl9DUYuKQpev20XiJNznYJWvZtscvr5TYFh5o8cG++3RRoLIiDn0mOVLFCLOVp/qCo9KxCEs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FrtllNUF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bkh5Qi0j3IptYT2zcVJ/9I1IuCmkvMNnwW87PVND5Ig=; b=FrtllNUFKSQLeT94N0bd1CH5mx
	G9dufg/jOpqiLUgwweDdA6Vi4kJV/0DgDKTtxKnQhBYCQbLEgOXGDpWPKNu4f7PN7gFKCuF6wY6lQ
	pdoRaHszT1+hQZZyTQIwZUdOl5wPHu9TG/y3wOHk/pwiqCLSZM122+eUJ+Qok+HDJMDkdwUeqyDlm
	tJYJ0zan7aNwmXayGIuVrYV6zSNUyfBfe0MmzWEHhmlPXSCzFXiX5ZcsHW4zgKfwYhmC2VI6RAaT+
	cxzEYZGITWAHxiRPu24U2b4QlhspJJHmCIXKkwDc3crjviYylRAgmzjnfKmKJ71BbHLoSZsyxu+Xm
	9oynS01A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvIPt-0000000DaGw-1rwc;
	Thu, 20 Mar 2025 16:06:45 +0000
Date: Thu, 20 Mar 2025 16:06:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
Message-ID: <Z9w9FWG2hKCe7mhR@casper.infradead.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
 <20250320111328.2841690-3-mcgrof@kernel.org>
 <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>

On Thu, Mar 20, 2025 at 09:01:46AM -0700, Bart Van Assche wrote:
> On 3/20/25 4:13 AM, Luis Chamberlain wrote:
> > -/*
> > - * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
> > - * however we constrain this to what we can validate and test.
> > - */
> > -#define BLK_MAX_BLOCK_SIZE      SZ_64K
> > +#define BLK_MAX_BLOCK_SIZE      1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
> >   /* blk_validate_limits() validates bsize, so drivers don't usually need to */
> >   static inline int blk_validate_block_size(unsigned long bsize)
> 
> All logical block sizes above 4 KiB trigger write amplification if there
> are applications that write 4 KiB at a time, isn't it? Isn't that issue
> even worse for logical block sizes above 64 KiB?

I think everybody knows this Bart.  You've raised it before, we've
talked about it, and you're not bringing anything new to the discussion
this time.  Why bring it up again?

