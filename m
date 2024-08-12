Return-Path: <linux-fsdevel+bounces-25700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF494F534
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E300280EDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7086186E34;
	Mon, 12 Aug 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrIPGtNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43198187342
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481315; cv=none; b=SPJietmUoUSnfI9K8fIZpPKhQFd1ZCPDMoeuYFXAIC1T8Pd4/ub8tvLOp0w8/L/fYdLTHRUI89wm7X8bm5S9FUeoAecreY4WCuSt5dNN6s0UxzbeSEujfuHqmqN1+inX3ASg0TQXUVMy0LrS/AH5Lu8tVYvprD/njIVPAkJw0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481315; c=relaxed/simple;
	bh=vlxgpT2n5Xps903ECbjYYd6/1bI3E1QPI8KYM/sxDYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG9U5299UU/v1xV2hCuLE7+ZyhqampNnlfHq5V6woQ0wfdyAy1iY4YXJcFveI0FXszIYq70Kx9ro8kSLaTWp9LW8fVHS2+lVupNEPi7GTIqTS/hOhBAA+qZ6j1xas6KeIgG8lRSSx3heb+8haLZBjdOcv/kXqqV5LadzGN6Fca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrIPGtNu; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Aug 2024 12:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723481311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oup5KvnReVwL5g2TjaX2imedpZh9Y3hrP7CG0s2fWjA=;
	b=TrIPGtNutq+lSGGCHWPnv7sShgOyt433IP1UlTymAL6HJfz29xeImVxoISTweeuQfCxsYD
	WFS+UxgiH98HsVJ6Zqfausur9ndo9hlTazukETyvliFbxHSuWxuvY7csx3RA1iQxsuw1A3
	GCPYCwQm4RRbJkXJnZbkbJ3ncWi9pvk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, david@fromorbit.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <5evd6n5ncanmyc2qtjpb44bd76xj7icitdf3g6xeb2eiofh6ht@eqm6r2ch4b3l>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrn0FlBY-kYMftK4@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 12, 2024 at 04:37:58AM GMT, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> > this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> > will be useful in scenarios where we want to avoid waiting for memory
> > reclamation.
> 
> No, forcing nowait on callee contets is just asking for trouble.
> Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
> and thus will lead to kernel crashes.
 
 No different from passing GFP_NOWAIT to mempoool_alloc(), and we're
 trying to get away from passing gfp flags directly for multiple reasons
 so we need it.

