Return-Path: <linux-fsdevel+bounces-20851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7A8D86CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD310282025
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB07135A4B;
	Mon,  3 Jun 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/ffXtuA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578A132134
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430353; cv=none; b=DQBqpSXx2/EdDp2A581eeHIJJ/twexFzZWnC/WBpuCxOcDHjtDkZWFV6Xp4HKVZaYWzeAAqFLi8N08RN5Om2nRaaJLSL5JqDAfmzfiUdcnx2c+nzhFRHuY/ZQKFJOmYUGZAfUuKzEE1h83za53pp6cUza1HsccoPb3mHzKdCE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430353; c=relaxed/simple;
	bh=6WTR7FoQZ9rra+asRHWF88p8maWEeY91opgCxDrpQE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekKNgdgEqKLeo2cUA1Ox06do/Wpj02o+xH3uYLHBbVArHkI5QDZfY7rL4Fy9kRRAj78/VlJHt81s9OmaBHkONkYAwRQpR0o278L1N65CL+eZ0ojEb6g1x94BXI1xKgqBwekWwWF9Yj3TdrJIBlNzqSUQAGlHudUjEQhhQB3FqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/ffXtuA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hch@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717430348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MKoGptTMXtcmB2eFFZ/7XY8rNOgdyqaqmNPZWvIzDO0=;
	b=j/ffXtuAchUU9doHCLdXQra117sSslmTmLouztI03iMUCHHhKnCiG7fjtjSCIOZQqc1Ngo
	UIyxgqT0eVHivgaIDNVMmet2YK971dSuV/22x2uIlNtu9otWsKQR5JehH5rxEpMDXB3jfe
	eF57evHOLwmXdO17Lud7ye8kAbckYMQ=
X-Envelope-To: bschubert@ddn.com
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: amir73il@gmail.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
Date: Mon, 3 Jun 2024 11:59:01 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <ZlnW8UFrGmY-kgoV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnW8UFrGmY-kgoV@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 06:56:01AM -0700, Christoph Hellwig wrote:
> >  void *vmalloc_user(unsigned long size)
> >  {
> > -	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> > -				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> > -				    VM_USERMAP, NUMA_NO_NODE,
> > -				    __builtin_return_address(0));
> > +	return _vmalloc_node_user(size, NUMA_NO_NODE);
> 
> But I suspect simply adding a gfp_t argument to vmalloc_node might be
> a much easier to use interface here, even if it would need a sanity
> check to only allow for actually useful to vmalloc flags.

vmalloc doesn't properly support gfp flags due to page table allocation

