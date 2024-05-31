Return-Path: <linux-fsdevel+bounces-20679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC18D6C58
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 00:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390851F23C17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 22:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FC80032;
	Fri, 31 May 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nmhtMYXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F367640E
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717193696; cv=none; b=pJa1Jj8lJPI1GbyVJEFqICeVnDasej4eyL4b56mu2X0MZdrIlZ2qGnOB6sJEx25VlN25/oqiTCJRZYSMiljdZpMIkYTtlk5FT4aZsRSEYTik08WtQC79BrbGRhhiQH+flcjpDoWyv1eM4ev0CjcSpqS/wDuXvHQaQLkqLtmYI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717193696; c=relaxed/simple;
	bh=ZHRN9syueArg9xXzrZdSYBRQ4bL2kv0rd/aNoehq3U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwKVIwHF7c7paJBRMwywc6Ht2KlhKh3uACx5zxgiOPrr8sXBN7BFvGlu1AwJXP25Ph3bgSqMgP13Qu6x/eHCeZ0TDuaxwj57MUwU6Dl1gWpWvwNQ4OhQDaLfJdiNEm6QMveKdtDkIXXgRELv9Fy3p15bkm6lBOEDReQUfcf8fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nmhtMYXK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+PJuVaispZE9R8UWDHC+/1nzURbrO/ZAmi1aDP4oulY=; b=nmhtMYXK4JHfvX11sPr+TAISge
	PqBwug00t7Czp2ZgdUZSLequRVGrezNYlettfN2oyWuFvonrhgMYa+dYRZueWWoaaeVtDnn4N6LLR
	D8wDO7esjSeBpQTtAdtUXyNC19HbDMRGOEFhBFt6Ox14jKRhHR9Y8c8Z94SJy/MVB5fTxTSwF0hcm
	cvMr+2gBplfd/cYL3V1iTTy4PIVjHeqs1eUdEv0sXx2KpU88KVIwopedibCT3XxVaugLMv30JE6Kj
	0rXBXYUZo/dsFRgejVdoLUpzAhyfT6uXcRvc5TZWMPWNEBx3YSnrdMC5X/mDCbtyfCJ4lo013c/NR
	KTenICZg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDAWP-0000000C50G-1lGW;
	Fri, 31 May 2024 22:14:49 +0000
Date: Fri, 31 May 2024 23:14:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com,
	hch@lst.de, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <ZlpL2ZfIF7d3MR32@casper.infradead.org>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
 <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
 <20240531-ausdiskutiert-wortgefecht-f90dca685f8c@brauner>
 <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <CAOQ4uxhCkK4H32Y8KQTrg0W3y4wpiiDBAfOs4TPLkRprKgKK3A@mail.gmail.com>
 <20240531-weltoffen-drohnen-413f15b646cb@brauner>
 <ZlnxCJ-14kVXxyV9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnxCJ-14kVXxyV9@casper.infradead.org>

On Fri, May 31, 2024 at 04:47:20PM +0100, Matthew Wilcox wrote:
> On Fri, May 31, 2024 at 04:50:16PM +0200, Christian Brauner wrote:
> > So then I propose we just make the deny write stuff during exec
> > conditional on IMA being active. At the end it's small- vs chicken pox.
> > 
> > (I figure it won't be enough for IMA to read the executable after it has
> > been mapped MS_PRIVATE?)
> 
> do you mean MAP_PRIVATE?
> 
> If so, you have a misapprehension.  We can change the contents of the
> pagecache after MAP_PRIVATE and that will not cause COW.  COW only
> occurs if someone writes through a MAP_PRIVATE.

If IMA does want to prevent writes, I suggest it puts a lease on the
file.  That's a mechanism that all writes must honour, rather than
it being an IMA speciality.

