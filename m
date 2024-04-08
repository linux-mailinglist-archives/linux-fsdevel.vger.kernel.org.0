Return-Path: <linux-fsdevel+bounces-16371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F9089C89B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA44B288264
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545D1420B6;
	Mon,  8 Apr 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j4lpso5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D01411FF
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590963; cv=none; b=fbG4Tf2xSOhcKNMja4rgkLXdHkxb4lfeb7SoVR/McV/qKkSYqLzeKDIslrFL0cJFcj7Tl0GgbhHfxgr9H1V9psLikhTOkn0LdNEEi2un+W2snobs7YeH5WcpKP2e6N5mHELlKCmE7fjG/MrjC/mV5Kjp7etiEnOfMen+Y6JHfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590963; c=relaxed/simple;
	bh=rtoppUsgmouvyEZz9/0yi0KlLgArG3xBjNl6G4Nx0LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqOFOvnpTqoqfc89UW/Hk5KYvQv2k8lZn2GyZUsJG9mTWe/P65cPVlQoB0N0VgX4GGIc6P20vDZ2xGJMQuqjtCL/3SOfWbAB71TKqSRFII1oDGKXhSjX3eOwwH5V5el0cS4gwUBIGa9aVZSFrBvaf+lOxsUg+diGJQNcng8fd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j4lpso5H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SIE1Nhk2DgGcl3MjoUMFhvgK40e8bxwOceHpBIGGAqc=; b=j4lpso5Hc3M40p+O1VlRcCM9hL
	yAkg3IhDJoYnR6CvyiqiMkq8838NOzkkkgJpwfd/J3ywurCokw8iZG30sDNJMCHrPhNhHN4TZTRBB
	vxbjLKoK1uyDhgXsurN9eJb/KoBJpU8OjoIKoibfI4dedDvGoimwt+yX5otplKIbFVer1Sc5+JGAv
	AuYW1XvgObynS406X8FV08MDffY5k/udia3zexsu0nwyAnKxwitBpiGpdG58hcK8gII46oBYtzAf5
	8w6t4vezgfeWKAT72PG1z2y0FR+j89MnB02YZhDOWhEppo0AMA9u1PRR4B6zg0VKsQdg3XuC/Pg7z
	VEYFwWWA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtr8j-000000007pl-2cuv;
	Mon, 08 Apr 2024 15:42:33 +0000
Date: Mon, 8 Apr 2024 16:42:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Add FOP_HUGE_PAGES
Message-ID: <ZhQQaSMBMrJtb8Iz@casper.infradead.org>
References: <20240407201122.3783877-1-willy@infradead.org>
 <20240408150217.GN538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408150217.GN538574@ZenIV>

On Mon, Apr 08, 2024 at 04:02:17PM +0100, Al Viro wrote:
> On Sun, Apr 07, 2024 at 09:11:20PM +0100, Matthew Wilcox (Oracle) wrote:
> > -static inline bool is_file_hugepages(struct file *file)
> > +static inline bool is_file_hugepages(const struct file *file)
> >  {
> > -	if (file->f_op == &hugetlbfs_file_operations)
> > -		return true;
> > -
> > -	return is_file_shm_hugepages(file);
> > +	return file->f_op->fop_flags & FOP_HUGE_PAGES;
> >  }
> 
> Extra cacheline to pull can be costly on a sufficiently hot path...

Sure, but so can a function call, particularly with the $%^&@#
CPU mitigations.  Yes, is_file_hugepages() is inline, but
is_file_shm_hugepages() is not.  The cacheline in question should be
shared since it's part of fops, which is const.

I'm not seeing is_file_hugepages() called on any partcularly hot paths.
Most of the callers are in mmap() equivalent paths.

