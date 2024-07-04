Return-Path: <linux-fsdevel+bounces-23090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD9A926E17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 05:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC028261E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D471AAD7;
	Thu,  4 Jul 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LtKILiiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57A1DA32D;
	Thu,  4 Jul 2024 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064266; cv=none; b=HeFlgkmOHEPmpExyG7WwJEf4rOyMQ0pqAzaSnSIAu+X3H59QFIymlYMxErvRkpxcf1KlIAZoXvg6nHIBY22rZQuUq7AapuFriUZNotWwAcaZsxofumZ8XylxgEvhKsKMVKJplQ6IDUXJ7iVerS+ntHd6b0kPZ7fnHCf8nrYkKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064266; c=relaxed/simple;
	bh=kqsy866oZYNM7j6YX6JOf3ZN0QL3YB/Coli7Z9lL3Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjueE+uCYwCaTmmF0WhFa1GB9WRJMyYMJl0oVTgYnsMMTtgJVXCExvblWPC5FkpjdDZcIhr63fm7d4xKaFGB45ZQTJssJPep3YH4kf5G/B2bth3TEkIqp/4gEkMFS3qMAwLzsDry1EtQ4YU4BYL2JRzYi9DCmBJ1rMxrjUbNYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LtKILiiJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gORZIWhR6haTvMb+DZRpC8xcydy5uoNOtr1+9XCCc2U=; b=LtKILiiJICdRaBaZI4iRLZCtHC
	T946GVBVEavpxoDQDV95jyLqqZGCdDAgqTdUsJWfHNsKbMQqT6Mz4uC+5+t/mv21MH2seslYE6ijM
	mOUxJDquYww1pFI1d1yvGP4tkzjX8Cz/dZUGQ/EWzUflR7fbeO5ZcxLTu1chABjkOqoOjGVqcK+BJ
	o/2hKmzcqNY9VMJufk1cv6TUptYwScVlbvq/b25YXz7j71mFmLphOsI7FdBXIZdgLEL4GE5LhMuPj
	gfDjTrau9lqhy51TS1vFgvN59+n1NhuQLpCcJW96lICw9TUykeUEXd5evfMpwGaZ5Var9UZ9quACh
	3pvzAFZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPDHm-00000002Rpx-1Ju6;
	Thu, 04 Jul 2024 03:37:30 +0000
Date: Thu, 4 Jul 2024 04:37:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: muchun.song@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
Message-ID: <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
 <20240704030704.2289667-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704030704.2289667-2-lihongbo22@huawei.com>

On Thu, Jul 04, 2024 at 11:07:03AM +0800, Hongbo Li wrote:
> +	TP_printk("dev = (%d,%d), ino = %lu, dir = %lu, mode = 0%o",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long) __entry->ino,
> +		(unsigned long) __entry->dir, __entry->mode)

erofs and f2fs are the only two places that print devices like this.

	"dev=%d:%d inode=%lx"

Why do we need dir and mode?

Actually, why do we need a tracepoint on alloc_inode at all?  What
does it help us debug, and why does no other filesystem need an
alloc_inode tracepoint?

