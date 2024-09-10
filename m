Return-Path: <linux-fsdevel+bounces-29039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66970973CDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA152866BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4819EEA6;
	Tue, 10 Sep 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VAI8YcTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7436F2FD;
	Tue, 10 Sep 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984197; cv=none; b=u6nvWC/sR59wmOcz+iIKsAOIJahmWwZgo8SgD8+sCpKY0L/KfpyiZmZlDL2XbLJm4E8jGq3SsZo48v/+/uvnoWa1jGF53tMJu/hg1Id8dDv1UNzxQRjWAI2zqyitsHHx+h67yeXI8unSMcqgUSoDTaL9blzm9seTO97MjQpkCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984197; c=relaxed/simple;
	bh=ieYNhYz0yKPjWMz8M4s8GFWFw6Ub6QVglsTA9qPpy70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxNrUic+cA2fNFpLR+b23+3AuXBie1blUJ2F6iuEu6vshlRa9/PrQtrd/YxnXDWLI/M8ndZMdH4o+fvik2k2J02I7xWhjvQLFIV8XEtpFdoUfjlFEzUGGhp/0ElHkqkJUwgvcSNpgSgMF+aTTRHdTg4zTbv9+lPyK8oaSE6RlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VAI8YcTS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XlwiXBt6Jc3xA5G0PJppWnKE6FFg6I2kRwNbfwdTC7Q=; b=VAI8YcTS4yY1OaiY9mlPUC4hIy
	w7SMCD+pMk8EOW5isDA+3Kx6yTr/dzg6jJEk/NRx9ShzT9VOCfZzUPRGxmEeW/5kI3lEhHQQ+LV4p
	0L0Sn61LQihFA+dlFC4ploV7ZK5Hu8DNKOCfX5e0QQqNRsXPIB3bgNN4U1jsEBie9RX4sUn72J4Yw
	xI3osYzITouFrPo0N+R6qunHYSfiLveOK8sL0/xu+yON8Hx8AB4q7dzbTf6Q5LpcmMhyVc+8WkSuB
	3i27uZD+SXcWGSItYx2vbD+o902M3rTwzQ48ZW5fgqK5aLL5LE49LFSwFM7pvBxtLQpdC2IMGpKs7
	XZB8QKCg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1so3Kf-0000000CcRG-2QyT;
	Tue, 10 Sep 2024 16:03:09 +0000
Date: Tue, 10 Sep 2024 17:03:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: remove redundant if overhead
Message-ID: <ZuBtvW9TWCnHte4V@casper.infradead.org>
References: <20240910143945.1123-1-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910143945.1123-1-justinjiang@vivo.com>

On Tue, Sep 10, 2024 at 10:39:45PM +0800, Zhiguo Jiang wrote:
> Remove redundant if judgment overhead.

It's not redundant; it avoids dirtying the cacheline if the folio
is already marked as dirty.

>  bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
>  {
> -	if (!folio_test_dirty(folio))
> -		return !folio_test_set_dirty(folio);
> -	return false;
> +	return !folio_test_set_dirty(folio);
>  }

