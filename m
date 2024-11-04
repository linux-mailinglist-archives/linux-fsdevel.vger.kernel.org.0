Return-Path: <linux-fsdevel+bounces-33600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538029BB649
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18120282113
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8C78685;
	Mon,  4 Nov 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQWS9DP3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D9339A1;
	Mon,  4 Nov 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727296; cv=none; b=Q1oYPrxD7x7GjXs3divNsI+g47mEVjomjWfuxJJDM3r1yOrGe6We9/nyiTQPuOyjyu8NE75wZKUyhwkJtHbctN3gCjOA4vgYQdtbKFACQfQVL/naFhiRtOVyBNKZTva2deyySiROUNf1p7Fy3NdZSPuAymGbiE+5SpgWhZwtBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727296; c=relaxed/simple;
	bh=FoNnWAn1QjGzs0pDtAGsMIggtK/8oE9IVMGWWHwKyuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awHQmcRt0ug/0H+IoZkgK3PCMLkPqtSAgSypDv6EYe/a++YoCCCi+mqZkJ8es8h/WywKwHzDO/33pGevez6C5qRGIWLa5mQfKozrX/VwEMMDn92GgunFOG+ctYr4BGPowcaFusiV42QuwIah2GtUHIEGT3lhUnuIZLBvMh5bYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQWS9DP3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJjl7yGTkjI5YAbdJEam0U1MB6eP4I1Grye8pcpbX14=; b=cQWS9DP3tRpDDTg0jHcwFnRd/n
	ZIWS2mTJ2nfSj8Cx4qPsev8brurXyiPF6A0vJCxjb2gJ8HpzeyjMqV5qJ6eIUroEmZgGm+RqEW6mk
	aQ/ckFmD7+zltGQ/s5qq4pnaNCpraMNNY1oEX6zrqsoCkHF2Uvb4XHVHOoQ3MwcNmpfRB/equSx8I
	IKwksBL2A/4m1hK/X++eMbcuPO/A0rHX7Niqltu9EvZCuorSZzliQMUKweBKfxidXf2Hl5EA3SSEd
	YB6j0UY6NfTpG8r3EjsWR98aa0VgToRWs3LVsRLjX3uZ8/gft/LOjFAmzzrvCzFoZBhkEzh9jlBsS
	/LeNLOog==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xEI-00000001DAT-389A;
	Mon, 04 Nov 2024 13:34:50 +0000
Date: Mon, 4 Nov 2024 13:34:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] Xarray: skip unneeded xas_store() and
 xas_clear_mark() in __xa_alloc()
Message-ID: <ZyjNeq1GJTFFa3-7@casper.infradead.org>
References: <20241101155028.11702-1-shikemeng@huaweicloud.com>
 <20241101155028.11702-5-shikemeng@huaweicloud.com>
 <ZyT7qRhtqGDe_AuO@casper.infradead.org>
 <ad978b0c-b814-02ad-6304-6096d5cacf9a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad978b0c-b814-02ad-6304-6096d5cacf9a@huaweicloud.com>

On Mon, Nov 04, 2024 at 09:55:42AM +0800, Kemeng Shi wrote:
> > No.  The point of the xas interfaces is that they turn into no-ops once
> > an error has occurred.
> Yes, xas interfaces can tolerate error. The question is do we really need to
> call xas_store(...) here if we already know there is no room to store new entry.
> But no insistant on this as it's not a big deal anyway.
> 
> Will drop this on next version if you still disklike this.

I very much dislike this.  The point is to make the callers simpler.


