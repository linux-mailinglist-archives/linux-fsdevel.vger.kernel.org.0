Return-Path: <linux-fsdevel+bounces-50967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F446AD1826
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE0218882AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6E27FD63;
	Mon,  9 Jun 2025 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JlQxugIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA127F4ED;
	Mon,  9 Jun 2025 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749444716; cv=none; b=FuHlZNsfBdE3sbHuYXkwMKwUFvmaEIgkYUix5RzXQN059/PW8vvjBED1iAnPoTvYCsvBzFJ4KqFz9mH6oIIgXnSuBzw7IeiyE9WMJAOEB6gB80ia0JOUjb6KoIEA4ATQxOsRLL6FreJSgfgAHH8zXBb3ZCje30lbNY8mrtATIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749444716; c=relaxed/simple;
	bh=nd7gL/AK9CXjb+SxD5/Y86374Mpt4yrZ9sCKF1qR720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka7Fg32r8RKn+wu5RZHp6HZ1hQTkbw2/POo+bq//1s1LGR34/SQqxjsMYPY/uPlJZU7IbyoF+4dfTtDkr3lkeNBE52qUk5dYn3l+BIkdCX71DOzE7/8Gi+/cW7b/3kvjJpnHwvoJ5kUZKEwsTZBvc3ywQSp2WWtXP6WTLz9zjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JlQxugIf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WunfaXb4eDFq8H/XgfQSkkZrXci5yXQiAIg4oj0gqrE=; b=JlQxugIfzoBueLBP9fvcRbbjqc
	MtL+uhCHXrxRsUFCzTVG5ImJNDinpKliocG8CTpJgLnaHiKYn9Plo0G5gCFgpfl6ZxdUK0MMvRWO1
	wOX8QE8pkcw87/Uqt+U6zPrcawsHWmCJs3C6QJ7sic16tp6SCgvSPzeGytZvGvB/9EuDGKzU4ao6i
	fViRJ5hlXq2+gLT0qp3xc3ZCO0tRwLc2bmQ8aWdW7w+p3E3QoogB8KJOnv85It0AAIQ9XjcYKrbwd
	GtWCpiPz8MHw9/Gkq+Egu9EwJGVckdHHA2SIVLb1AabEpeyWpx6Z35ENZPhlItMZ6LTOu7UvreGHT
	308ZUHJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOUUE-00000003RKN-3b3p;
	Mon, 09 Jun 2025 04:51:54 +0000
Date: Sun, 8 Jun 2025 21:51:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <aEZoau3AuwoeqQgu@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-6-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 06, 2025 at 04:38:00PM -0700, Joanne Koong wrote:
> Add iomap_writeback_dirty_folio() for writing back a dirty folio.
> One use case of this is for folio laundering.

Where "folio laundering" means calling ->launder_folio, right?

> @@ -1675,7 +1677,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * already at this point.  In that case we need to clear the writeback
>  	 * bit ourselves right after unlocking the page.
>  	 */
> -	folio_unlock(folio);
> +	if (unlock_folio)
> +		folio_unlock(folio);
>  	if (ifs) {
>  		if (atomic_dec_and_test(&ifs->write_bytes_pending))
>  			folio_end_writeback(folio);

When writing this code I was under the impression that
folio_end_writeback needs to be called after unlocking the page.

If that is not actually the case we can just move the unlocking into the
caller and make things a lot cleaner than the conditional locking
argument.

> +int iomap_writeback_dirty_folio(struct folio *folio, struct writeback_control *wbc,
> +				struct iomap_writepage_ctx *wpc,
> +				const struct iomap_writeback_ops *ops)

Please stick to the usual iomap coding style:  80 character lines,
two-tab indent for multiline function declarations.  (Also in a few
other places).


