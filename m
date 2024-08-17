Return-Path: <linux-fsdevel+bounces-26171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40B95556D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 06:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B6E1F2360E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7D839EB;
	Sat, 17 Aug 2024 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQabTKKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8A433C8;
	Sat, 17 Aug 2024 04:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723869915; cv=none; b=LLZkKz57ymAXdeb/o35ew9Fm3FJuVTPp+9AEPAnBff7Yq3O0MSULobtGIPC9BZpcfzVIhATreMcBnEmXTFLimH/gXDpLlVcE/bdjjkVd9XKQLIUYAD2grMbyQTIWLQIC4LVMAGeP0Ex/GRjBOsTDU43dxtHnSIkxe9jeo4l6RM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723869915; c=relaxed/simple;
	bh=jyVeDL8jW6L1ZdDspxorki0VO4RFBcT0w7qZ3OA65yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODqvD0IvydpWBw0lOfkLBvghf4MXK+ntSYPlU3ePJrjvy3cKXvNc0AX3dzaUOyE+vOCe/4lkk+Q3YloYhbG3If6fDdfVIA9sWWYm2sAZXo+bpELEB6dv3ZsoXBew+Sf1X8Yg/45ZsRwUDlXjfQ84Q3H3jEx3hzenjIkeFf8TXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YQabTKKo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSqYTSbEMR4/PQDB26D84HKinwkN1T1KphFxqe0XJQc=; b=YQabTKKo8VrZ2FyA1k5cHhWzTB
	suVp720j+gII+4T6rc5tIK7Gt9Ms7RcfoV5DfXHSkE8EDakRR3EzesOvseZprh1HS3wpWqwAwXEyM
	mlUWPUeG5tXTouPN7y4Wpzh/qIkJtqRgXefL6yDn6GhSbqYuoy7/6P8vxPkkeNPrk9XrDWcFA7eO5
	pyvGmTo6lcACgufDiphJvrJl63a1dP+xAIIL4Y/Q7G250RHJIxPFyqTDg/NkYakD/kq04S3TAaICR
	JAxMhQUZKiQb/x5H05AWpht2q3rv1S/Q5NXJ4tC45AyBi1XZS0nkxfn3zKPvDtjMknO8Bfos3/auX
	SZpcb3WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfBJP-00000004RVw-2m4m;
	Sat, 17 Aug 2024 04:45:11 +0000
Date: Sat, 17 Aug 2024 05:45:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
Message-ID: <ZsAq11RKg-dRfPv2@casper.infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-5-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:57PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When doing page mkwrite, iomap_folio_mkwrite_iter() dirty the entire
> folio by folio_mark_dirty() even the map length is shorter than one
> folio. However, on the filesystem with more than one blocks per folio,
> we'd better to only set counterpart block's dirty bit according to
> iomap_length(), so open code folio_mark_dirty() and pass the correct
> length.

We shouldn't waste any time trying to optimise writing to files through
mmap().  People have written papers about what a terrible programming
model this is.  eg https://db.cs.cmu.edu/mmap-cidr2022/

There are some programs that do it, but they are few and far between.

