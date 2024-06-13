Return-Path: <linux-fsdevel+bounces-21673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8023907CC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFCB1C20B48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E69C14C5A1;
	Thu, 13 Jun 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gHN1FKo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF4134407;
	Thu, 13 Jun 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307585; cv=none; b=SNXuk1ToW0MRQ36ooHIruuLhMR+2c5wllG5DeINUnBJEmGMB0eS2jzkZ/nvC0xw6k94Y3brbtlfpwi0T3KohrJLOfj/TBhL/tcs2qUwOQXAMzGwrbauR7hF32xV2ZIJ1N+tnmNIY5xk/3xjW6uU7EHGGbauJbMa0bFh2mR8VEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307585; c=relaxed/simple;
	bh=Xr1ZR0w4u2FAgkjvH5Mi9hxZ/0C28Zy328vRfJN5fEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trwiVtIlSETbW0ZB0i1GG12Ghot+K7Zeynwg+JVpOE1lGWIUE0iAvWwzh5QEE1Go2SmghVRImHhPKgyz2js6wkJoh2EoAW4kiju4XXoRJxDeeryvFxCB7RYD+07bWsnzryFiXdoI0edeuv/du+/ieBPcwPzefJVBtGPvghY8DOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gHN1FKo/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zszsi0/aB2A5gS3nj8dtgFtDV/ZCUUoBmBVvRLy5hi4=; b=gHN1FKo/gLkrKUqlWBHqnu5ICW
	tW5aD/4ifvUlVBvAHVylwxXEpvpguH59nQIX5H6WkFRNAcj6aR6TGR85v0cTHzvT2KQLdtR+GK0qP
	fRmgw6YLsUmThl/Kj9O8bJ9c9WkikVf2myaGQ0AC+cbud5Kas7Rt2Zk23eOZRFygikkg32gTOx+QJ
	xDbOzuShVX9VaDl6R7wJcm7vk5BygjkwJ7F5F48D0/KBW0pW3PE4W5wJ0FDsLUXA3MMZrLGY+7OVE
	bOYGVzvlISO1vrDkKgNhrnErMIfjOL9QiGpY9qESwtpkw4aFLKPBBohz8/DBdxlQdUoGyPo7c4OqL
	8iHdTHtg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHqIG-00000000IvW-0Jyf;
	Thu, 13 Jun 2024 19:39:32 +0000
Date: Thu, 13 Jun 2024 12:39:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
	yang@os.amperecomputing.com, linmiaohe@huawei.com,
	muchun.song@linux.dev, osalvador@suse.de,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <ZmtK9NcsITV0aoL8@bombadil.infradead.org>
References: <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
 <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
 <ZmqqIrv4Fms-Vi6E@bombadil.infradead.org>
 <b3fef638-4f4a-4688-8a39-8dfa4ae88836@redhat.com>
 <ZmsP36zmg2-hgtak@bombadil.infradead.org>
 <ZmsRC8YF-JEc_dQ0@casper.infradead.org>
 <ZmsSZzIGCfOXPKjj@bombadil.infradead.org>
 <ZmsS7JipzuBxJm92@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsS7JipzuBxJm92@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jun 13, 2024 at 04:40:28PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 13, 2024 at 08:38:15AM -0700, Luis Chamberlain wrote:
> > On Thu, Jun 13, 2024 at 04:32:27PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jun 13, 2024 at 08:27:27AM -0700, Luis Chamberlain wrote:
> > > > The case I tested that failed the test was tmpfs with huge pages (not
> > > > large folios). So should we then have this:
> > > 
> > > No.
> > 
> > OK so this does have a change for tmpfs with huge pages enabled, do we
> > take the position then this is a fix for that?
> 
> You literally said it was a fix just a few messages up thread?
> 
> Besides, the behaviour changes (currently) depending on whether
> you specify "within_size" or "always".  This patch makes it consistent.

The quoted mmap(2) text made me doubt it, and I was looking for
clarification. It seems clear now based on feedback the text does
not apply to tmpfs with huge pages, and so we'll just annotate it
as a fix for tmpfs with huge pages.

It makes sense to not apply, I mean, why *would* you assume you will
have an extended range zeroed out range to muck around with beyond
PAGE_SIZE just because huge pages were used when the rest of all other
filesystem APIs count on the mmap(2) PAGE_SIZE boundary.

Thanks!

  Luis

