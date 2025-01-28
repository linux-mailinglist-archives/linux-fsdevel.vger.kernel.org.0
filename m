Return-Path: <linux-fsdevel+bounces-40201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC915A20431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4573B1634A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BB19047F;
	Tue, 28 Jan 2025 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kb4PacBE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B11487F8;
	Tue, 28 Jan 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043888; cv=none; b=XLkz1oHmH/tK7XKQzxZW+nfvGgWZ8ikhtxTJJRbKq22Q8AZy4FEeOnbA3uKI9YAkcs8ypOPGDIptCbg4dRbxH0IIyUExjtVMnOWn1grlkRDTAaRiAyGtVCn8J1QtLdQwCHl7/D2PiiNqqJ5xBm7m0d8OJnRL4jrD0oTgG8bZm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043888; c=relaxed/simple;
	bh=443tAtrVlLikomEJW+bLkAx7edk1X/tJzL8RS/qf27Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEkTSHOR0/pK1cEB7QWc8eYJOdFLRKS7XkfaK5qcGJZMQyOUbnDJfyog8LIESZ/eCD6xJ5mBvCmhXHTyLLQdQa+kNqgqmrjsgzTUaT+GojmZP11cxvsgQkKPpUAJBQajghJWV9W2gcYNZ+/xLzIGbXf3/W4uu0nYrR3zasDdNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kb4PacBE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lhu4zGDd4xcVjurqw3pEZgdUvwfwUI8PbgF5I8pxXXI=; b=Kb4PacBEHapoUCCQu26lxil/n1
	S58HQfGSICL1sGPjpCbdThVmEZT0aaePsta/lLI9RN4j8QtceGCTBOMg5x/heRmSxghef444rMhio
	Oaj5vYAMqrhS6uYUOp+3HXj8Y6LUdk0ll6aC2ZSP1RI54nb89CQqOviI1tiuDEqATu1vD89XzXw7h
	UWkvM3VMGkA1K+XaDRaebzED8OllJevw2agswa36riMUHLOvMrMWtGSVnMQTxCsn4q9oVPXc1Xo1z
	Am4gk/HEunIu7snaDFJp/ihlewz+u/pD/mLPzrssqv0uy9Xq/xpObbTMYD1v4K42hRBGpkLL0kjFa
	mI0qtOag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcebu-00000004BbM-34R2;
	Tue, 28 Jan 2025 05:58:06 +0000
Date: Mon, 27 Jan 2025 21:58:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH] block: Skip the folio lock if the folio is already dirty
Message-ID: <Z5hx7kpk4UyF0NYN@infradead.org>
References: <20250124225104.326613-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124225104.326613-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 24, 2025 at 10:51:02PM +0000, Matthew Wilcox (Oracle) wrote:
>  	bio_for_each_folio_all(fi, bio) {
> +		if (folio_test_dirty(fi.folio))
> +			continue;

Can you add a comment why this is safe (the answer probably is "folio
dirtying through direct I/O is racy as hell anyway and we don't care")
and desirable?

Otherwise this looks great.


