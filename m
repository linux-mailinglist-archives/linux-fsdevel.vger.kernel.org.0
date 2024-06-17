Return-Path: <linux-fsdevel+bounces-21832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24190B5D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93D21F20FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23277134A9;
	Mon, 17 Jun 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fqGn95aP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBCE542;
	Mon, 17 Jun 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640628; cv=none; b=LY7lbB8zbbijMEDjf0/wiuh3PQrZbLEPfpbVtBcVGNAiEbNlXCCcNSEIhXrJglwRiwq68QFLjM3lnAEgpoQMQwwPRXIBO6td9nDJk6pbaPpRcw1cpo4BbVJLMeFGs+R80s0NMbgrcyS27A53PMsgzxfRd6A0H9Xp/VMAXEjuj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640628; c=relaxed/simple;
	bh=WGCinyI4bK+TUxH3s7Y1GricZpal7F72PqLCJEowglg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phfV5KOm/cSPaemVaKG7nmq7QOda+QFYXGijG+VQ4GeVzf/NoaVOluKesSbe1uBF8T+aiKuNKBl0ZRxoFvPAXcLjjUTll0XVMhXg0lugGenRDF6qfm+q2ZgVNf1eywF7B0Iu/PjEP5NJB0s4oYVaVzcHyjBtwX0e/iYI5cQTkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fqGn95aP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6No9GIcViYA9Qsa5BjFQUlS6BgSash6AcUNuwZCbz/8=; b=fqGn95aPR/20iH6RT4ae5iOgiY
	dGLQ2RFf23Rw6fkK/zl6TLzEdL3RQ7i4MyJnUI2dJy+ekYCvoThyKbfvqpgn/xBS9TDuwTwHGcOA4
	VudWMrwKmev/AjluV//LxLMe6+1FKcvCu8ZAhSzw/JWrKRDmGohDhkEouuoh7/uSu6pj+5TCc07be
	t/vQhogaI+Pls2cjL+5cuCYOyRVLbCOC7ZxrNavFHfU6cnUMSHm0htceXSz+Dg8920KPnQRR6B0rO
	JeG82MFfZhxMjN0uQ4NNcp2TFVST+i5KY4XQcvYK4JhFaRPFK4D9SYuzzqndMamvLb3T8PiH6Rc+3
	rco86QdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJEvv-00000002Gj8-45VH;
	Mon, 17 Jun 2024 16:10:16 +0000
Date: Mon, 17 Jun 2024 17:10:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <ZnBf5wXMOBWNl52x@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
 <ZnAs6lyMuHyk2wxI@casper.infradead.org>
 <20240617160420.ifwlqsm5yth4g7eo@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617160420.ifwlqsm5yth4g7eo@quentin>

On Mon, Jun 17, 2024 at 04:04:20PM +0000, Pankaj Raghav (Samsung) wrote:
> On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
> So the following can still be there from Hannes patch as we have a 
> stable reference:
> 
>  		ractl->_workingset |= folio_test_workingset(folio);
> -		ractl->_nr_pages++;
> +		ractl->_nr_pages += folio_nr_pages(folio);
> +		i += folio_nr_pages(folio);
>  	}

We _can_, but we just allocated it, so we know what size it is already.
I'm starting to feel that Hannes' patch should be combined with this
one.

