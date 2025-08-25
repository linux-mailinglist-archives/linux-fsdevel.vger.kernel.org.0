Return-Path: <linux-fsdevel+bounces-59102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E80B346D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F8D161C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED972FA0CC;
	Mon, 25 Aug 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1SkkMPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FA2F3633;
	Mon, 25 Aug 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138571; cv=none; b=vGYWwH9siByK3AejRAtUD5lHHh8poj1+fYGutXq0K0+AXENqEVo6jLGkurDM+OsE2ABfr/mYPYANYE3Nr2j6pziIpafiwy0vd0qr14/BRN2duo25EOKASrofOIBvj6ap15fsxtzsXje5+SDrl/eTZ6GDllcwkePRC7uoMzX+GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138571; c=relaxed/simple;
	bh=DHhC+2t8TvyWwbuc1U7QM6i/nEtGaL45VksyEy6p3NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzmB/2AJhrObize8DZ1VwM3W4ahf9Lugta7i5RaUfgnql2rS9QhY+/sSXWA2vzJRw5vhRCLGR7bVt6vOzxgs7gNu6lulofoLV0iVQNyxciIR3lcI86u3dO5/WE4FC+pmY0MDJprEDxQh/T+iCDTS8Xq7tuwrh6n09XBx4Pl2wKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m1SkkMPw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ezOPy6YOeaUXwJlIYvyqJG1dN2vstuMGepcFcq7Oj8k=; b=m1SkkMPwv6b31zgukz8QqVS0gQ
	RxHlNbfGnwSKppt0B8IK3RTmGhB0S4pIQ4GJMwXLL1vGzgXM3WVyeTYPoBQw6HQ3xbiFDYmfwdc9Y
	sX2fGGKYMO66hPoNeqIUIrm/viU+BhkgynbTXFHw2vk6NZwDXOigyycqbh2xgn4G41PjMZP9/+8u2
	C56t3vBHdnuCQl5cH3RpPiCUs1bByfXnT6qakdDMG20uAKSEwIBu7N8cpjZ91LVNakArsTk043ThA
	gueq2DK+mzBY4w2ZgZvP13akdQn4FDaif59GcF+yjXZ1YMAlwF5j7A6Uun8O5WtEhoSHvCqYU6ufE
	XxCGwdFw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqZrQ-00000000QCV-2wLV;
	Mon, 25 Aug 2025 16:15:56 +0000
Date: Mon, 25 Aug 2025 17:15:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: wangyufei <wangyufei@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT - MISC" <linux-mm@kvack.org>,
	"open list:PAGE CACHE" <linux-fsdevel@vger.kernel.org>,
	kundan.kumar@samsung.com, anuj20.g@samsung.com, hch@lst.de,
	bernd@bsbernd.com, djwong@kernel.org, jack@suse.cz,
	opensource.kernel@vivo.com
Subject: Re: [RFC 0/1] writeback: add sysfs to config the number of writeback
 contexts
Message-ID: <aKyMPH92SfYZcCM2@casper.infradead.org>
References: <20250825122931.13037-1-wangyufei@vivo.com>
 <9cb4adf8-94c7-4fa0-8bed-2f9274969b48@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb4adf8-94c7-4fa0-8bed-2f9274969b48@redhat.com>

On Mon, Aug 25, 2025 at 04:46:46PM +0200, David Hildenbrand wrote:
> On 25.08.25 14:29, wangyufei wrote:
> > Hi everyone,
> > 
> > We've been interested in this patch about parallelizing writeback [1]
> > and have been following its discussion and development. Our testing in
> > several application scenarios on mobile devices has shown significant
> > performance improvements.
> > 
> > Currently, we're focusing on how the number of writeback contexts impacts
> > the performance on different filesystems and storage workloads. We noticed
> > the previous discussion about making the number of writeback contexts an
> > opt-in configuration to adapt to different filesystems [2]. Currently, it
> > can only be set via a sysfs interface at system initialization. We'd like
> > to discuss the possibility of supporting dynamic runtime configuration of
> > the number of writeback contexts.
> > 
> > We have developed a mechanism that allows the number of writeback contexts
> > to be configured at runtime via a sysfs interface. To configure, use:
> > echo <nr_wb_ctx> > /sys/class/bdi/<dev>/nwritebacks.
> 
> What's the target use case for updating it dynamically?
> 
> If it's mostly for debugging/testing (find out what works, what doesn't), it
> might better go into debugfs or just carried out of tree.
> 
> If it's about setting sane default based on specific filesystems, maybe it
> could be optimized from within the kernel, without the need to expose this
> to an admin?

I was assuming that this patch is for people who are experimenting to
gather data more effectively.  I'd NAK it being included, but it's good
to have it out on the list so other people don't have to reinvent it.

