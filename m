Return-Path: <linux-fsdevel+bounces-56923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8CB1CF57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E5916B8C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816726C389;
	Wed,  6 Aug 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URXqgwx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544C26B755
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522401; cv=none; b=TahI/mRtPT1TQMrl/+BHjGej4G8hTNM6S7JGOoIA7tq0k4s1dXmI46KrUYcBXJOdHn6RlDYYK13LDLonGxCNgSx4TSiQKL+O/UzbXgLeXDiac4SoxJVwbeySX27M2T3UVY9VUMtslcRt1TcE+alF+7CIlsOU12oXvy+y8SpyCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522401; c=relaxed/simple;
	bh=D7X6MJ+OgYZoymypsd+2saXCljgSp8/OGEhIZJ/9r/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyGbhFHBAFjy0JBOvmQWmf4gUTOM0iM1X8tEv5wptmkXuEe5LQ7bl8utxhEVHnc5TrnaImW5IWwvnWP0kIC7TnQLQUnVbtfjlZiQsSIDg/ZylQQ8+PnZ94qxNrvgN51uGzB+Qjq6Sa0T+GV/EtB95V8/+HhmxLkrd+zqS+tsv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URXqgwx/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 16:19:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754522386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6QOt2ArdADNBAJU4PEVq2qG6ReKiOxj9ZcPXxOARXY=;
	b=URXqgwx/5/5PY0dFhng1uG+sZJJQasTsnvBd7kueJ4x1mVsoLJBPTHoiHL3CE3QP+2EDNy
	rz6hus8qYRjVDYdE2aK2zOLisVWd5HnP/a2cjtbnBFCtH4g0gWLnA6y8/f3TCJ+Dig1EK8
	zg1s7W+0Yn+gE5paA/pOoP3+jqwrbww=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, 
	hch@infradead.org, wqu@suse.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/3] filemap_add_folio_nocharge()
Message-ID: <mph4trybfnzki4aiq67suf2cki7cf6qpvqlojxs45hywgh2gfb@7qnhfp3y65mh>
References: <cover.1754438418.git.boris@bur.io>
 <aJNgC7f9RVr_rh47@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJNgC7f9RVr_rh47@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

CCing memcg maintainers.

On Wed, Aug 06, 2025 at 03:00:43PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 05, 2025 at 05:11:46PM -0700, Boris Burkov wrote:
> > I would like to revisit Qu's proposal to not charge btrfs extent_buffer
> > allocations to the user's cgroup.
> > 
> > https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> 
> I prefer Qu's suggestion to add a flag to the address_space.  This really
> is a property of the address_space, not a property of the call-site.
> 

I think Michal wanted call-site (explicit interface) for easy
searchability. I don't have a strong opinion either way. However I
wonder if having this information in address_space might be more useful.
At the moment, this series is using !folio_memcg(folio) to detect if the
folio has skipped memcg charging on the free path to decrement the stat.
Having information in address_space would be another way to extract that
information. I need to think more on this.

