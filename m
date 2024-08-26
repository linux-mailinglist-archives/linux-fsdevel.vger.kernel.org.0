Return-Path: <linux-fsdevel+bounces-27218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3295F9D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E880E1F22AC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38A199245;
	Mon, 26 Aug 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oThpUoU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BB80034;
	Mon, 26 Aug 2024 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701309; cv=none; b=VR/hGsnr8X3EsEpvtoe1sIqDODAULDxlHHg+uYtK1R0soea2AvYX1JAn+4uQWy1Uos8OgwWdho2/piPy3BK18BPYagYkrTow0f3G5ZFHZi6gsXBJeG4WrIsjmPetx4gnnPANNeRR+q6hjov/aqr0Rk1mDkkBZliPuhIfayelwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701309; c=relaxed/simple;
	bh=rQg+bs4LSYTBr14ItbIkLw2k8hVj9LRq9zs7I9326GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esgKde4vKKBrTStcjkJOUkU8jTx8Z5pHzqpwX/YAYuPQbE5nRy3qOtSYMt7NzHOQUz/Z3VPskiJSCuOXh257zyfLFSf/bTiw0+1fz4YMOHIJjDEUyG/WkRgvuVL6iHXjhDSHjJxnKLby3urpMunw8RInQe/gmw9bGNp4LqrbVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oThpUoU5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4GhdGhSKm/X6M79tv+fW2tzMUeqm3WW+Lfyk9i49dck=; b=oThpUoU5vYTVKD5qeQ01khcag6
	iKPwDcC1WirdPD97QM6WSkOuTlTTSE1wD+paQpI9tCvtzZhoy9453c5qgEt0deqKYTeTGey7YfUwq
	SG/I4AAetAEiE/WRrar65awouCdeW8kThmqOknroHf/zviskvBnfbzaMZeo/iZJvlaqS4d2X1iGvO
	Wu/Rr4XjNT2MRrsyQ3FJP6PMvdoOftPdvgA1Kp2ZLcM9qYV9JahuHKrdhVogufDU6UdmF6uVg3dmS
	tc4e+I5AWpqnNMznPbJ8qI+N9sCl9gk4/heib5YctZCBpEEQRUArbfbIWQen6SEgDq3RKWODqoyyE
	0J85j6DA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sifaw-0000000FvjY-0toK;
	Mon, 26 Aug 2024 19:41:42 +0000
Date: Mon, 26 Aug 2024 20:41:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zszado75SnObVKG5@casper.infradead.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>

On Mon, Aug 26, 2024 at 03:39:47PM -0400, Kent Overstreet wrote:
> Given the amount of plumbing required here, it's clear that passing gfp
> flags is the less safe way of doing it, and this really does belong in
> the allocation context.
> 
> Failure to pass gfp flags correctly (which we know is something that
> happens today, e.g. vmalloc -> pte allocation) means you're introducing
> a deadlock.

The problem with vmalloc is that the page table allocation _doesn't_
take a GFP parameter.

