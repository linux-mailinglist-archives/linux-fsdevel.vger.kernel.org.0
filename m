Return-Path: <linux-fsdevel+bounces-35063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CE9D09CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 07:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB902814E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6B14D2BB;
	Mon, 18 Nov 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NBMWwnSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB413E02A;
	Mon, 18 Nov 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912556; cv=none; b=S2GsuxAhzcDWHXfpX5aNYDbz9jFG2IHwF6CL/aMQPGK5bNOgw4MbzxA70/8BlNU9pgamNTmBqozTkIGzG9gOdnX0+g59zOQL42trd5Rm2/wb0Mr0yvqUJXuFRxR2cPaIySn0rQBQ7MwyAgLPxehZ4YCjlswcXcS6abV56REk+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912556; c=relaxed/simple;
	bh=yAlKL7tLdFlqEx9jAqU45Vxr3I/VG8+qut4fJ+rU68c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctl/CqBqruXYVTL8DUUzQoA7ZEemrQJpSqOKNZH880cucA0itHRvtb/4kGHntFijFghY4j2cJWV8zyifJGr7uoUDRu3WohUrQ1TZeJesyxS0AcwFUy1HihenMYdspQd8SfvWLCDDztTPjEpU7NWLfCS84dqVYAR1Kbh2NsgQB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NBMWwnSa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kOlSN2LA06OzE6644+n7itNYM1OkhAQ52vQl+1dtIKs=; b=NBMWwnSaPc/9xDibTvknY6r0iC
	Hh7I8oTd1dZMPrFyEml6PB6AAOMNeNm0SWS4OaudwOPvvxcwKW29PqOGaqP0UyZJQyLlNLqRcxDP2
	Pzz/1ibDFKeQrNAnU//VVjsfQ6gG6AXU7rZLEl5aJ4FZcOym5IUGTbcGqe+b50FbizTFXfUp9Cqa4
	EqmkJKs7fVlO61ReuTOb7xuZ8i+ryTxh2bcY/qKXxHerJIBsWU6MUqaX0h4SUnsPtkWbZx542lRmD
	QPphpmKYXVAgY4orJZX4F4S6txiPCoeNm75Y1bJiiCsCB4M2stquegy5NHLRZY106VxQm5ZNiS1HL
	CJe7scig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvZL-00000008Ysl-04P5;
	Mon, 18 Nov 2024 06:49:07 +0000
Date: Sun, 17 Nov 2024 22:49:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com,
	schalla@marvell.com, david@redhat.com, willy@infradead.org,
	osalvador@suse.de, usama.anjum@collabora.com, andrii@kernel.org,
	ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com,
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Subject: Re: [RFCv1 2/6] pagewalk: Add a page table walker for init_mm page
 table
Message-ID: <ZzrjYtoC3G0Yl8pM@infradead.org>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175922.3265872-3-pasha.tatashin@soleen.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Nov 16, 2024 at 05:59:18PM +0000, Pasha Tatashin wrote:
>  	} while (start = next, start < end);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(walk_page_range);

Umm, no.  We really should not expose all these page table detail
to modules.

> +EXPORT_SYMBOL_GPL(walk_page_range_kernel);

Even more so here.


