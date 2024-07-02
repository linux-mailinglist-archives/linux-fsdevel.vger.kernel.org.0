Return-Path: <linux-fsdevel+bounces-22948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B4F923F77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5860F1C226BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953731B5811;
	Tue,  2 Jul 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FtzzuTBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FF38F83;
	Tue,  2 Jul 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928165; cv=none; b=m0Yxtf4JCtJaWPvfUykIUWxXK43T2YGGCkU0CNvvyj0qSRGE+D1rqSXW9YtIBkUNJEmv+NE2gl81ZdeTMLM1/9UtaMXAiEpmndzSUKyvHTS2wyUvtEW08vqh/+EHs1ZlG78Np/9IgD+6Gw7qgVRkv6VGNYvXXVURZs7arlIP+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928165; c=relaxed/simple;
	bh=jcu1eHnQGhamY6wVo2Qpj2POiy7zT0qk2jzOZ3HxQg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3y7Iiac9DNuPJKDhbE6JPTEmcxMK+2PNlqJ6q9nGQ7Atx2JPSEfMoTtRgdZo9Y5exWmsovYd0lGyObFo1WKpll9gMKNUgj5pK4174pTtbU9mWAcR42kjExPo4Cv7FFBkP80dYci7VNGOHuHFtSYHtlbEH8efCZ8UwfkhJTjJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FtzzuTBe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dX5/1nrCmtj/7vSG0Hm+XX1H/8yMNBHnIxLwZ0Lk3Vk=; b=FtzzuTBeQAWpHYFr42EsfwUQ6P
	ldVx5PM//U6UVq1UhOktpZ7jFKvEqRb7NsIyp7nJUSlC/H0AE1tc8N7qtnjImnbocNEp1quehLjBn
	7cEfx2ONxGxq96CwxlhSRxtPRT/UFRCLnzhS3V4fzGsGjphULm8DG3U4ufJ8hofj58Yx7t24TLqQu
	hTVqbCiew+N4Pck4VZFgy1vpXqnph8m6kO0/QmXAHKv0wFZrtrCX+647gPPmzEw1MrfV9RVA0lufi
	9JmkYog0SekBwIwRSm+vx8QlVSMkRwMH7mi4MR/pf0B05aSg+pn10ATSgNYOzrtYGSJiWjObUkl6Z
	3LhJXOSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOdsk-00000006v4b-171E;
	Tue, 02 Jul 2024 13:49:18 +0000
Date: Tue, 2 Jul 2024 06:49:18 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
	willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZoQFXlfLMzF9hiLU@bombadil.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
 <20240702101556.jdi5anyr3v5zngnv@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702101556.jdi5anyr3v5zngnv@quentin>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jul 02, 2024 at 10:15:56AM +0000, Pankaj Raghav (Samsung) wrote:
> > > +	set_memory_ro((unsigned long)page_address(zero_page_64k),
> > > +		      1U << ZERO_PAGE_64K_ORDER);
> > 
> > What's the point of the set_memory_ro here?  Yes, we won't write to
> > it, but it's hardly an attack vector and fragments the direct map.
> 
> That is a good point. Darrick suggested why not add a ro tag as we don't
> write to it but I did not know the consequence of direct map
> fragmentation when this is added. So probably there is no value calling
> set_memory_ro here.

Mike Rapoport already did the thankless hard work to evaluate if direct
map fragmentation is something which causes a performance issue and it
is not [0]. Either way, this is a *one* time thing, not something that
happens as often as other things which aggrevate direct map fragmentation
like eBPF, and so from my perspective there is no issue to using, if
we want set_memory_ro().

[0] https://lwn.net/Articles/931406/

  Luis

