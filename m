Return-Path: <linux-fsdevel+bounces-64138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBBBDA039
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D623319A0FD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298DF2D77F1;
	Tue, 14 Oct 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gANwOdXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8552D248C;
	Tue, 14 Oct 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452369; cv=none; b=L5LoAnaWrshWKkD4lNQa3Mv4zHzLmJh3Zaihmyzg51bxiqhIFRt2pNvcTyJhH1KQlC0Dk0X2JzvEmabP9U2duY0kkxWltZzhJTzn5a2z2nkKIBJ6Hf4AJ8UkCiKtl9xrFrJwy1Vo/iHLWjK9qQE0Eo2uSqkl6V/fBttQjlSxTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452369; c=relaxed/simple;
	bh=oHAN/0DxWPNDDT78S8xHGvdeMdd39Ebo18SZ31HvRdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyW+wJs0nNLYXTAQfjd/CtFUVVDlXzkf0J/M4/aQsJLI8XYhWtwDqR2+kCNOxDL2tS+eo2ui6oerJhrHT3kmsaTxV24NF2Op/d9u3wdHZ02zNJff7KeFwIIzBNkAi7gU/+DG1KWGxgwpfkXUEMSt5C4B+9tWwwNpJXMlxFXpy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gANwOdXe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0GqYhA2elC/r2rvCKhRwX+jvXdEIHrho/9mEfMhvs2g=; b=gANwOdXeFS4A8Uk10aaWilWR7d
	ySohtwrkya4BSFA9MNyJwI2SZVkT1JJHEAJ1YXe7UWprbY1XwtET/2V4R4oRn4GF67uKnvqNrQQpm
	yhej7D3Ampn9gV2sdpBOC//k6+7VCRkiUzXc9CAocGziSDmflGDKxlzctCPJMtuj1ame1R/WX62J3
	/q00WWJeO563d2TrDkgqDV3wLGgpDguZTVQJuU95qNOMg6pvwsczOA0E/TTHHdN4VGFQz3RMBH5p7
	s4BBoP6jBFf72/l5Iy/B7dE73hYHCsC/5tBuD4pR9oLkR5r5JzFIJiPt40JHliYisLm0SxqKtLxy/
	LUkZzWEA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8g4v-0000000CSAd-1Vaf;
	Tue, 14 Oct 2025 14:32:41 +0000
Date: Tue, 14 Oct 2025 15:32:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
Message-ID: <aO5fCT62gZZw9-wQ@casper.infradead.org>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
 <20251014122335.dpyk5advbkioojnm@master>
 <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>

On Tue, Oct 14, 2025 at 02:59:30PM +0200, David Hildenbrand wrote:
> > As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
> > folio yet.
> 
> We do support partially mapped PUD-sized folios I think, but not anonymous
> PUD-sized folios.

I don't think so?  The only mechanism I know of to allocate PUD-sized
chunks of memory is hugetlb, and that doesn't permit partial mappings.

