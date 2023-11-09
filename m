Return-Path: <linux-fsdevel+bounces-2520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4CE7E6C25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7771C20AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0210F1E52F;
	Thu,  9 Nov 2023 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lf4Z5alu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A91E528
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:09:19 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E4269A;
	Thu,  9 Nov 2023 06:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g+lNrllJ5lzRMSerkLwsHNxMh6MnqQQj+IsmmSA/ncQ=; b=lf4Z5aluBgo1Dcb3dCZuAvwpHD
	Zky+SybZXcNQwcfBvlSrIX8hIew/jeklvfnsoi51Ervq+JUA9Al1Jg+2zVFIFSG20M97UmJES7Iag
	3kPHWcxKK77aRIZb6BQYzu7eY/eRDZ6aFQR7+ZYcDmSe462ML5dvUIWr16uibYEfZs0O/M7q3qn+T
	0ZBEP7JRmzDPg5Jn4MzWav4Sfxvwhd3w3VZPm/hdX/48EzdMdmHiayPWZ14U0fSGuxcbVk5Xx3VaV
	nsx/4jFYORHA30GIkiCTM9y3ueItzKAHSdyho5OBu/XCUFr9Ovz8PXe/qfvNANSrX8Z6XZIZV+TJ0
	URuaFNUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r15iU-007et8-8S; Thu, 09 Nov 2023 14:09:06 +0000
Date: Thu, 9 Nov 2023 14:09:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	chensong_2000@189.cn, xiehuan09@gmail.com
Subject: Re: [RFC][PATCH 3/4] filemap: implement filemap allocate post
 callback for page_owner
Message-ID: <ZUzoAhpkrCNz9l1k@casper.infradead.org>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-4-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109032521.392217-4-jeff.xie@linux.dev>

On Thu, Nov 09, 2023 at 11:25:20AM +0800, Jeff Xie wrote:
> +static int filemap_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
> +			void *data, char *kbuf, size_t count)
> +{
> +	int ret;
> +	int mapcount;
> +	dev_t s_dev;
> +	struct inode *inode;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	unsigned long virtual_start = 0x0;
> +	unsigned long virtual_end = 0x0;
> +	struct address_space *mapping = data;

This is just folio->mapping.

> +	mapcount = folio_mapcount(folio);
> +	if (mapcount && tsk && tsk->mm) {
> +		mm = tsk->mm;
> +		VMA_ITERATOR(vmi, mm, 0);
> +		mmap_read_lock(mm);
> +		for_each_vma(vmi, vma) {
> +			if (page_mapped_in_vma(&folio->page, vma)) {
> +				virtual_start = vma_address(&folio->page, vma);
> +				virtual_end = virtual_start + folio_nr_pages(folio) * PAGE_SIZE;
> +				break;
> +			}
> +		}
> +		mmap_read_unlock(mm);
> +	}

Why not just walk the rmap directly to find out where it's mapped in
any process instead of the one which allocated it?


