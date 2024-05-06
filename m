Return-Path: <linux-fsdevel+bounces-18804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CE8BC668
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 06:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A958C1F21F42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9B43AD2;
	Mon,  6 May 2024 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gThsixfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370581E4BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968868; cv=none; b=lDBGPkSxY1lWYE33u4sxr/MdZ9OTNDw1ITopQSpoTL81+6vdWx1MP8A9uJlrHHdl80aZiOTm8qRQo/6sKWgwrCbFu2qBiqh3dTM2gbHTA3ZQHq2UlMYR7tybFDVJy1FMK4KDawIf1E7UsOkn5T4Fs8XYGEZRutUuN0cN5nQRAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968868; c=relaxed/simple;
	bh=RvWDP43gMdhnBFeEJxEJH4VZAGD6JZqv2ntuua3WXmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECGnGmfw+UFZPIvT+mF3N5IofwVHvR0VaYetGz6O/Bgqie4UQTgmhOoAlKBpIxMecIKoJObZf6hGoUUD4SKSiO+poVdCPo9+d2fl9m/fKnbRh9yxRETy6c4WrdKcPxKkQH317OArlkkp2dq2OdaIJoCfkhknk2gAeCSc5ltdsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gThsixfF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1vsnKo1+/OoZ/XI5KuqqPTSsXAHeEJpwputSauE5Lx8=; b=gThsixfFFye1L0UQn3d43iMAR9
	RtN4K89EC79mTpNZA/hrTHlSmitg4TMpvPnrb5FOMLJNh3K/y16Y26gH4iijcR+Dtq8LHjQGOo6xv
	WbBh8AITmYXnz7GqbDWrsQPUB0LbYV2XOnxUmj9Uzo+4GhYm8hTkKOetfgf/sqQfADYSkDTWfAgzQ
	PwjuGRobnQD1cJLFvSAlB8oq35gUJ7DWX8PI4JLOPWfokMu1q7w+mtTVhJrLXMzn0ayQ+lxMIJCmp
	F/1JjASHzTXUkhUTG9tZQQ36VVz4tRG1xsJmwAKwEsGOSjJjnm03oSMv/YKdeIWwhPzsfNskSVAkX
	23HV7Q8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pk5-0000000A7VW-0UCr;
	Mon, 06 May 2024 04:14:21 +0000
Date: Mon, 6 May 2024 05:14:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
Message-ID: <ZjhZHQShGq_LDyDe@casper.infradead.org>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjd61vTCQoDN9tUJ@casper.infradead.org>

On Sun, May 05, 2024 at 01:25:58PM +0100, Matthew Wilcox wrote:
> Here's a fun bug that's not obvious:
> 
> hfs_bnode_move:
>                                 dst_ptr = kmap_local_page(*dst_page);
>                                 src_ptr = kmap_local_page(*src_page);
>                                 memmove(dst_ptr, src_ptr, src);

OK, so now we know this is the only place with this problem, how are we
going to fix it?

I think the obvious thing to do is to revert the kmap -> kmap_local
conversion in this function.  The other functions look fine.

Longer term, hfs_bnode_move() makes my eyes bleed.  I really think we
need to do something stupider.  Something like ...

void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
{
	void *data;
	int first, last;

	if (!len || src == dst)
		return;
	if (src < dst && src + len < dst)
		return hfs_bnode_copy(node, dst, node, src, len);
	if (dst < src && dst + len < src)
		return hfs_bnode_copy(node, dst, node, src, len);

	src += node->page_offset;
	dst += node->page_offset;
	first = min(dst, src) / PAGE_SIZE;
	last = max(dst + len, src + len) / PAGE_SIZE;
	data = vmap_folios(bnode->folios + first, last - first + 1);
	src -= first * PAGE_SIZE;
	dst -= first * PAGE_SIZE;
// maybe an off-by-one in above calculations; check it
	memmove(data + dst, data + src, len);
	vunmap(data);
}

