Return-Path: <linux-fsdevel+bounces-23211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE76D928B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDCF1C23AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4A16C6BF;
	Fri,  5 Jul 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="POm0BqI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA716A395;
	Fri,  5 Jul 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192481; cv=none; b=dpE+pXj0MD8BHe+67/sfMKmyyY5r1f9EtNQQH8Wf7B2VnnMfWnFX+8CQ6aI03KgO3x8f2xk5jmVrcwskGw28hsMjC9MYDRtk8HRqaSKQf2c0+WXD3WcwZUIbBt/HxP144dgiC2OEbzSs4Iu64eMsKZykTTsLUzu6akh0OzerG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192481; c=relaxed/simple;
	bh=77jQYWRkdPyIAguqiUhFKAg6SeVYc+ae/Tlbnst00+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFagVGF9YS+ZYVNDLgESZIEsKbsE9hzktEKqVt9C9CupRg4uiiZbJCVlgxWZIPeogu7VqeH5CTi9iNeZEpQypelZzK1DjxifS5o34cp9ccyLFUyO6KtUHnR3aLhxw1uKP6ixqcNpxF8HYLJJmi6Ss6+gPR8Of8iKI44q//ynlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=POm0BqI1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/klrsak7bdOJsnowA+bkfGzSTeN6JHHUv7EpT897ZQM=; b=POm0BqI12mmvf/Q6jvj3XlXXE4
	cuMlBZn5hlrRtjeP/d+td4tfxWFm3loc/LerlCAuahyuHhvLcLEz+ngznT+X79Dwx2FlviIpwz/4X
	3VgOhnBJpvNrJJgpG3cHJjMS4wXl+Xtm6aGb4+UDA4QyCPuRol4XwnFQpjzjtyzjfTHlln5IIGaGr
	0dZhTO/NABLjsyhjsVxPUwOtRSQGg+9yylwej3UFbr8K6M3dyQP/TS/cji9sVSnI+DCh3HAuDFaOu
	HZH5+LDm52nSAOtMlOyxgecZNNlV+4PNRu4+lPiPHC1pi6l2Xc1aIBdrKUJVDdfXFo1oeiYYaIQrC
	/RUGwuOg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPkdr-000000045MA-2UQ1;
	Fri, 05 Jul 2024 15:14:31 +0000
Date: Fri, 5 Jul 2024 16:14:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <ZogN12rTqp7qfLVY@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zod3ZQizBL7MyWEA@dread.disaster.area>

On Fri, Jul 05, 2024 at 02:32:37PM +1000, Dave Chinner wrote:
> > If the device is
> > asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
> > not set, you should also decline to mount the filesystem.
> 
> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
> being able to use large folios?

You can't have large folios without CONFIG_TRANSPARENT_HUGEPAGE.
There's a bunch of infrastructure that's gated behind that.  I used to say
"somebody should fix that up", but honestly the amount of work I'm willing
to do to support hobbyist architectures has decreased dramatically.
Any useful system has THP support.

