Return-Path: <linux-fsdevel+bounces-12649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E536862293
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 04:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FBFB21CFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 03:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D714017;
	Sat, 24 Feb 2024 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAgUEvxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28151FAA;
	Sat, 24 Feb 2024 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708747173; cv=none; b=Hk5j4FlCMNfoQsqjgU6zZXKr/pQDvBvkI4IZca5XGbfS+tkT7L+PloUcAk5n29SD9Q3sm6+r+YNY/ay4WqRG9ua3N2bjO94hZWpIAJrbCHQwrZYTWGMZbfBF4Lwkhs4fRm+8eW+IMoM7sLlQ/HOjBjze3o/moEgpzldSCVSt7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708747173; c=relaxed/simple;
	bh=rbGyRrzI5Zzax0WXkXpgbEmPCzjOn1B4JAPKpQIVtfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktedcFgk0VtbjuLegQIwVu2ib0IWWeKjZklkMxVqmkXy460Ome588mUaXuMKAbZrI+su5qQJnefWiBj6IqoecDCfd2GrkjqFOTEOJPqscfvwdmgwGR1d4Aqkq8wt56ifkxfDPsfje0uY+wFF9UjFEHxEr2p8OClZxu0lZ4+hcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HAgUEvxj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Q7xjM4y4fPUpaXOwztAM/evw0GuePSPAyYG73fUcOc=; b=HAgUEvxjqGsxmCjPf/mM0BhF3J
	42ZExS+8AcRSrdBjctLVTmhRvuRjDCRO6+DyUW77Dhw7pytNsZ6B3jAFGVr57QkLGA3r9lkA0NcuE
	YWieIiKjPNZTzM0D6in+3cQOClgJEO9LsAFUdvLa9oEPW9xKLza1VKqcIWx087rvP0HxIIOJZf5k6
	+X4xBTVnUlUUSQAawSmdmrNXSUWlcDxLo6/a43B3UnWrQ55JtdWWtPGJUcImhHKpRRaM+9dzUwuFK
	R6shKlaTicH7HYc+FZIAMjpwoMscmRTA0LU9nH+9xVZCjf70bzI7PsG5ee+JSVfdDXG+F6kEzuXjI
	9HSDoSRw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdjBv-00000009SrZ-1ayo;
	Sat, 24 Feb 2024 03:59:11 +0000
Date: Sat, 24 Feb 2024 03:59:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, John Groves <John@groves.net>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
	gregory.price@memverge.com
Subject: Re: [RFC PATCH 16/20] famfs: Add fault counters
Message-ID: <Zdlpj3hW8mUfPv_L@casper.infradead.org>
References: <cover.1708709155.git.john@groves.net>
 <43245b463f00506016b8c39c0252faf62bd73e35.1708709155.git.john@groves.net>
 <05a12c0b-e3e3-4549-b02e-442e4b48a86d@intel.com>
 <l66vdkefx4ut73jis52wvn4j6hzj5omvrtpsoda6gbl27d4uwg@yolm6jx4yitn>
 <65d8fa6736a18_2509b29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ytyzwnrpxrc4pakw763qytiz2uft66qynwbjqhuuxrs376xiik@iazam6xcqbhv>
 <b26fc2d6-207c-4d93-b9a3-1fa81fd89f6c@intel.com>
 <65d92f49ee454_1711029468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d92f49ee454_1711029468@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Feb 23, 2024 at 03:50:33PM -0800, Dan Williams wrote:
> Certainly something like that would have satisified this sanity test use
> case. I will note that mm_account_fault() would need some help to figure
> out the size of the page table entry that got installed. Maybe
> extensions to vm_fault_reason to add VM_FAULT_P*D? That compliments
> VM_FAULT_FALLBACK to indicate whether, for example, the fallback went
> from PUD to PMD, or all the way back to PTE.

ugh, no, it's more complicated than that.  look at the recent changes to
set_ptes().  we can now install PTEs of many different sizes, depending
on the architecture.  someday i look forward to supporting all the page
sizes on parisc (4k, 16k, 64k, 256k, ... 4G)

