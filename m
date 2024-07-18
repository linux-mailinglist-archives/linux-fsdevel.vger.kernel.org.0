Return-Path: <linux-fsdevel+bounces-23931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E411934FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D792863CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C77143C4D;
	Thu, 18 Jul 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mGW7teYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DE84DF5;
	Thu, 18 Jul 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315351; cv=none; b=plighJAUg/QOLTMfjJYL0kbRNUa36xEeUevpfCwFEv11y+3gJhI8E6a3NuAaUX766/SWAvWq0Ia9Q1gxXiiulm7w1+wrkgIl2mAwACn5++m21fFZokATsdYYMBTqIbDwoNAqqBGQnNkLbebnmrgnhQaKpVIOsTTxzgvDWAt+t7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315351; c=relaxed/simple;
	bh=3sx6x7fX7gd9fjLp+cNqsgagpMUg1R9aeMNvU+8nLJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqmsGor70WXJORaWA9nG0sL27CdVo6mhTSX3OR9r4iZvCpoFz2xK4f9bEF4Uy/VGl+bi1GGUvAtBYv4vIHtYwOZyq67OAO5lIN4EqhgGvdDMLoClB0mbZPETRtMXG0f1PrjiT0wq4ouELzOQdqviBa9L+8n6+S3/KKUMS/PdAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mGW7teYQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nSlyvMPyg3jS+qwE9Mjq/Dc54Aa0BLrkXgP6ILW+ByM=; b=mGW7teYQ5oX6LPFeDfscRuL1qc
	jE1e1ujecHyB5YGiuO16UxqFWldJYqtwi9vBRoQ9fqv5hw8z3rPChRn2A8Pk1eShBN4N+a5SFAh3H
	czpL6l+6TxbSNaoOdpUX4Niz1vCK2Ts1t+ny1tpvLXcrkgudxLj+NQzc6lm2ear5LBsQ8H/eQ/kI1
	YAtJ2ppXKC6OCJUN+RqxYlkCyY04ua6Fd2dWizVCEGbHUhOXGagJL5kNQZ4t1+1mtLP1E6w03Clu4
	BXXjIiHM15/miX0FtSZoIZD881u8OTVFlSSb8+CJnMCRbFRz+BsI/gh0JxwXjJbwbnuopYLP6tdyA
	iIkR/QiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSkh-000000025ro-2kZC;
	Thu, 18 Jul 2024 15:09:03 +0000
Date: Thu, 18 Jul 2024 16:09:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/4] filemap: return pos of first dirty folio from
 range_has_writeback
Message-ID: <ZpkwD2-q9_XRfX5P@casper.infradead.org>
References: <20240718130212.23905-1-bfoster@redhat.com>
 <20240718130212.23905-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718130212.23905-2-bfoster@redhat.com>

On Thu, Jul 18, 2024 at 09:02:09AM -0400, Brian Foster wrote:
> @@ -655,6 +655,8 @@ bool filemap_range_has_writeback(struct address_space *mapping,
>  				folio_test_writeback(folio))
>  			break;
>  	}
> +	if (folio)
> +		*start_byte = folio_pos(folio);
>  	rcu_read_unlock();
>  	return folio != NULL;
>  }

Distressingly, this is unsafe.

We have no reference on the folio at this point (not one that matters,
anyway).  We have the rcu read lock, yes, but that doesn't protect enough
to make folio_pos() safe.

Since we do't have folio_get() here, the folio can be freed, sent back to
the page allocator, and then reallocated to literally any purpose.  As I'm
reviewing patch 1/4, I have no idea if this is just a hint and you can
survive it being completely wrong, or if this is going to cause problems.

