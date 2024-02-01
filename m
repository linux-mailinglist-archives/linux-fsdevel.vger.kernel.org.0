Return-Path: <linux-fsdevel+bounces-9918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506F8460EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084BD1C23FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB58527D;
	Thu,  1 Feb 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="scU5HmOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81A84FC8
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815685; cv=none; b=CuYXRwnNXezdbYJSxs+oOhu614yazvOmfO3GJAMmtCVzU95bhFmFWTXay6h/rkSwaIBRx3aKPRsq0F3GpA2kz7lPwDTSAqYTozvz7k93vZWwSPZyrh5d5/DCzlW3fnVsheRKt3TV9qRy668pyaUrSqtKyzOHn0HViehp3DLrcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815685; c=relaxed/simple;
	bh=SrqGiA6BdVUp32jcSAeOK2vO/mAUmOI8EPm631jsF7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8iuuXlG8YjMxpGlKPixwgAZCbZ4oTZVd1sRtiTr7iTE7AEaQFOszvUKsb0DYSnorXgvNjClXQEmn7mvI4gsIMFbVX1vNyf7aDNhYpSzZadBGTN5QW/HH+bXCUSZcWA7xGDqf3JHaeGxHjSZj0DsSyFFDHsUSz5cpREGbIOYgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=scU5HmOE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ADGbXG1wyb/0DBh6Pfwj1Ti/Ouskw0VrsGb11D2Ftm8=; b=scU5HmOEOMoGYz8fzJ9Tos4jyZ
	51+5MbPjnCuB40Mx2v1HoUzB9NWNRcq4vD02VH2mG4NDFP1C3GZ/P+a+YfCi51s4odsl9JZcT1F4E
	WdGVctfRUdnSgeQxJ0Eycv/lwqd/eCCOM0XBqHPucd9hE+z68AhCcgmqOFlYRZBBht0rKC7PyrcqR
	uja1hHT6sU39uoAhCigaIoXTT2MsLDg87eYfWqL0xcRLbF+5tFtqMa5nnQ5rtkHYYm99MYJkJOvTP
	/oTithUW5PCD0FanmEk9Cx897gcpz+pzpZhveTL3qvKvpUMxFDHo2IcgTWMIYUnpZkTmBbXTprDvR
	AKlWwThw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVcj4-0000000GcXF-2Fr0;
	Thu, 01 Feb 2024 19:27:54 +0000
Date: Thu, 1 Feb 2024 19:27:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rfc 2/9] mm: migrate_device: use more folio in
 __migrate_device_pages()
Message-ID: <ZbvwuvqIjnFnaerW@casper.infradead.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129070934.3717659-3-wangkefeng.wang@huawei.com>

On Mon, Jan 29, 2024 at 03:09:27PM +0800, Kefeng Wang wrote:
> Use newfolio/folio for migrate_folio_extra()/migrate_folio() to
> save three compound_head() calls.

I've looked at this function before and I get stuck on the question of
whether a device page truly is a folio or not.  I think for the moment,
we've decided that it is, so ..

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Although ...

> @@ -729,13 +730,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  		}
>  
>  		mapping = page_mapping(page);
> +		folio = page_folio(page);
> +		newfolio = page_folio(newpage);

you should save one more call to compound_head() by changing the
page_mapping() to folio_mapping().


