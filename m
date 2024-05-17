Return-Path: <linux-fsdevel+bounces-19681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D88C8737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81721C2155C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04B54BCA;
	Fri, 17 May 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mDZbhB0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7F41213;
	Fri, 17 May 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952660; cv=none; b=una5WSqsouYoAjs/29Hi+3Sm3v6z0Kl/pST+rY5Ki6O7YfMCWx8bnakgK3d0D5pqPu+Xy7sjmxOxdRAjSKRnRaHqURjMqzF868VHUYV8EhOARKemqswypqgNY3/BEtxx4/NrIsrZmGVnCIKP4n6Xfm9Ny0ZheggqLn0xq2Yp/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952660; c=relaxed/simple;
	bh=22I53c26kSfT41B2cb4kNLqZWudw/plo2PbVRr1bu38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltI3zB1hPPSkuQoefrTE9X05Z/zB2simcXc0M5pZBY/SlB7/GUOul3MP1Q4hxoxlKr7aS3CazlzKiU4G9IoXWM7CAQwPmfYZEDqH7uCesDEW4zbSw1eBPB815PRl1AU0iZnEl/ITWxomXahymiDkKTixI8ODfPVKLcJxf26Kcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mDZbhB0B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xp/PqiG39gfb+fpKlsrloVFa0KFhPJTa9GfWfq4DY7g=; b=mDZbhB0Bo4bbgFpo9pkLp89Vj/
	wQhzCtsKtWw/04XAp921BFJxBDJY6bKoMlhnaWs/54a/1u1WvxzalD9IdR96CnYYZulpOTk6HWhEB
	EfnYBHEk4GWrbYshJIU+8S/L+sPZbDV9m7DT0xMEzDeqI3v13dwbYqJHyda0BW5fTVwUAt74I2LRv
	Yw3g7+uck/GtcjPYkivUx3OA2yVDFL584Z+TD7Le/+0jiQU/tJkb4heNIKtfoMqVUX2ZU4XNJUOhV
	PsovbgyNjpACoJlqCKmgn77Dehb5jY1xIvWyHk5cTn+Uy31F5OxzkgAEEEjQwamqrAPHTtSSdZyTr
	vJwYQbqg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7xfW-0000000Czht-1Hei;
	Fri, 17 May 2024 13:30:42 +0000
Date: Fri, 17 May 2024 14:30:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, mcgrof@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, gost.dev@samsung.com,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZkdcAsENj2mBHh91@casper.infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org>
 <ZkQfId5IdKFRigy2@kbusch-mbp>
 <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
 <20240515155943.2uaa23nvddmgtkul@quentin>
 <ZkT46AsZ3WghOArL@casper.infradead.org>
 <20240516150206.d64eezbj3waieef5@quentin>
 <ef22fc06-0227-419c-8f25-38aff7f5e3eb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef22fc06-0227-419c-8f25-38aff7f5e3eb@suse.de>

On Fri, May 17, 2024 at 02:36:29PM +0200, Hannes Reinecke wrote:
> > +#define ZERO_FSB_SIZE (65536)
> > +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
> > +extern struct page *zero_fs_block;
> > +
> >   /*
> >    * char_dev.c
> >    */
> But why?
> We already have a perfectly fine hugepage zero page in huge_memory.c.
> Shouldn't we rather export that one and use it?
> (Actually I have some patches for doing so...)

But we don't necessarily.  We only have it if
do_huge_pmd_anonymous_page() satisfies:

        if (!(vmf->flags & FAULT_FLAG_WRITE) &&
                        !mm_forbids_zeropage(vma->vm_mm) &&
                        transparent_hugepage_use_zero_page()) {

ie we've taken a page fault on a PMD hole in a VMA, that VMA permits
PMD mappings to exist, the page fault was for read, the
forbids-huge-zeropage isn't set for this vma, and using the hugetlb zero
page isn't forbidden.

I'd like to see stats for how much the PMD-zero-page is actually used,
because I suspect it's not really used very much.


