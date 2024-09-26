Return-Path: <linux-fsdevel+bounces-30177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EEA98761C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D28282815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5C14A616;
	Thu, 26 Sep 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3aab9ax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8896E56A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362703; cv=none; b=RVYJaWEu9MevmDpi8YzOMtwbepBKr1jcQgDXsmo1CW9BFvATvBJKK0sB8GP46aLn9fQH7KmM5jXg+wiNlHX32xh8VBM/CWt5WpxKEHJ/QV2siSRBMkrhukba8q4c+Y3LyUb6OBUSJjZrd7g2iEWZpuk1Ql0oF/EGl0Sn3qqr1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362703; c=relaxed/simple;
	bh=cg9YCTAZ1Oiz/nHiEawk2Od4xUKfvRrLszaYnTMDGcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxI89klkv7/A/+PpyhLz/HxuPpl+UVV7hI6XCLXKzcvdRz/cl0duQHsxvWnFAirGiDN9o/h4YhNEsavEvUSU8uMYIOZhVlWHd+HYpQCuyMSRtneSiRtdiCISgnW2y0cHKYugu5ePmiuY2/uuof0CNT7uvCxcmAYhCRknZAnBPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R3aab9ax; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ifm+nIfno/WcCSPpO4Pf5285I2KcitoTGt2NJ3FYDZ0=; b=R3aab9ax70t5xQbc/HAFBCVf1x
	vD+Tf2QRdfLpEw3qRdUFi8ySVXASR58bN4Anj1H44RI5MVGmEmMAGWDIpWvWooQU/XGqmYx6cWjqy
	n9PUJuG+pOebXN7g1f5czJoYoNoPYj8x8lR8qfdzkhAsozZzYfOuMHkgyK6pgKpE5cI+MG3l8pN/w
	xok6WtAhWUanTQloY1bkl93u0ZLml5mTxgTJF5YgL4QRZJH8KSxbrjRyjl7X45DL8F+reQ9eLAIXK
	KLLbD/qBZekfTbBGj6Mskvfn5w3qgiUopIp7YZOdA3U85hlowJN7+/Kx1j6defVU5a6hnQHyJCZAZ
	GnjTY5qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stpwS-00000006uCg-44sy;
	Thu, 26 Sep 2024 14:58:05 +0000
Date: Thu, 26 Sep 2024 15:58:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
Message-ID: <ZvV2fAELufMuNdWh@casper.infradead.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
 <ZvVnO777wfXcfjYX@casper.infradead.org>
 <9a420cea-b0c0-4c25-8c31-0eb2e2f33549@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a420cea-b0c0-4c25-8c31-0eb2e2f33549@huawei.com>

On Thu, Sep 26, 2024 at 10:20:54PM +0800, Kefeng Wang wrote:
> On 2024/9/26 21:52, Matthew Wilcox wrote:
> > On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) wrote:
> > > > So this is why I don't use mapping_set_folio_order_range() here, but
> > > > correct me if I am wrong.
> > > 
> > > Yeah, the inode is active here as the max folio size is decided based on
> > > the write size, so probably mapping_set_folio_order_range() will not be
> > > a safe option.
> > 
> > You really are all making too much of this.  Here's the patch I think we
> > need:
> > 
> > -       mapping_set_large_folios(inode->i_mapping);
> > +       if (sbinfo->huge)
> > +               mapping_set_large_folios(inode->i_mapping);
> 
> But it can't solve all issue, eg,
>   mount with huge = SHMEM_HUGE_WITHIN_SIZE, or

The page cache will not create folios which overhang the end of the file
by more than the minimum folio size for that mapping.  So this is wrong.

>   mount with SHMEM_HUGE_ALWAYS  +  runtime SHMEM_HUGE_DENY

That's a tweak to this patch, not a fundamental problem with it.

> and the above change will break
>   mount with SHMEM_HUGE_NEVER + runtime SHMEM_HUGE_FORCE

Likewise.

