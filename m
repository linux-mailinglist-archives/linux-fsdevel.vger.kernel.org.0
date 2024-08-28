Return-Path: <linux-fsdevel+bounces-27529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B5961FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E201F25DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AC156863;
	Wed, 28 Aug 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHopuoSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9514B956;
	Wed, 28 Aug 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826532; cv=none; b=dBqfdnPZwM6JoKph7EAERRr/ydayA2wY8hH945oOZyjnT0lygBwixpDVH8nobYRxZtkKPX5ddFUUBf1F4acM+VAhe44+PTFUJ80vpADgayzZoeKHXIgiRY2yKuV2FjusmuWLugZFywMl+JXi40AXgOnLV7e+denukkKl0i4ust8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826532; c=relaxed/simple;
	bh=EL38cIFA/ASX/u7eiGfnPA4xEMfqknQlRNuO0s4T6eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbiagvMB7d8a+IfZIk0FUJ2hXOjZIoW/lqnA+qlGK/fKrLHvCSNGZjLdVssLrvlocWL18AVtm2JlI61rdz15hrqIWA1LgHPyWGS1pueNa34WXA7ogi5tkV+fAcypuNP3x1fMhHUQtq9BfyNfqhHnGdz+RoSaTlECaVFIXEhB8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bHopuoSo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XoviFBJy2bDohvpMLxa9vAmlCgQALpkBgjrnLzy2Sc0=; b=bHopuoSodVUOAM87DKr5XeZF9j
	FLclZ3/hEdawwYlmvMvqk8IwE8wcUJ1mjh5Y2GKq4onqEwAiDr7FknHeD0xlUBSk+o7qCKxO1LPmI
	bHEdACXDFPLXISGdkVyxtipe3TjWLVXob1D/KIso+DCvlAWlOi/EK/Pr4aVd/W+gnvvyy5kyOwleQ
	uIcJTP2O0/JX4FLlMgMzuhf4ANdnkk5Ddb1UshhrVIZeJG+aQt1FVEdyHfHNzneo4uyaNPEL9m4mE
	8zazoKlzARmmfbnlfOkx8jSdrSJYCONPZublL8BQzGzypY3drry3xR1TgxvzUg7H/YZtV1LfnH58f
	l4De8JLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjCAi-0000000E67y-0wIJ;
	Wed, 28 Aug 2024 06:28:48 +0000
Date: Tue, 27 Aug 2024 23:28:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] xfs: move the tagged perag lookup helpers to
 xfs_icache.c
Message-ID: <Zs7DoMzcyh7QbfUb@infradead.org>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-3-hch@lst.de>
 <20240821163407.GH865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821163407.GH865349@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 21, 2024 at 09:34:07AM -0700, Darrick J. Wong wrote:
> I don't particularly like moving these functions to another file, but I
> suppose the icache is the only user of these tags.  How hard is it to
> make userspace stubs that assert if anyone ever tries to use it?

I looked into not moving them, but the annoying thing is that we then
need to make the ici_tag_to_mark helper added later and the marks
global.  Unless this is a blocker for you I'd much prefer to just
keep all the tag/mark logic contained in icache.c for now.  Things
might change a bit if/when we do the generic xfs_group and also use
tags for garbage collection of zoned rtgs, but I'd rather build the
right abstraction when we get to that.  That will probably also
include sorting out the current mess with the ICI vs IWALK flags.


