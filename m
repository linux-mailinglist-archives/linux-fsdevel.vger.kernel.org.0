Return-Path: <linux-fsdevel+bounces-17830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35AD8B2977
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB59283245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED011534E6;
	Thu, 25 Apr 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cDuRE8Ic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C421101;
	Thu, 25 Apr 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075825; cv=none; b=m49LfSXMf21jDn3pDtltAq75epxCW3eq5ua2u+Y9D6gJFYDEl7amWfZIQTdzYuEbNi9hWABlECTEp8II4CZ172pF33UQBh8Mwsqw3wh1e75Vtutf+MAGAqUmtHZY9b9QycJBaqK5szpe/AVbA1DVXZgnAJqVYIcyVtYlfng5e58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075825; c=relaxed/simple;
	bh=dxbRTDBmGEBaFMzpv+zZKraLyNkVJK+Q3FXKOs5i1fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyYvlBxyd419KqNfvcrjsTjqf/OKgbsharWGI0TiknrEuBqAWsn9V5z/egTo2xJyA2Iw87gq+WZdTgVH8GFwOfgQfnGkIaTUkYCwFwFrMiJ0gIbV+Rxur1vrUuU/acckqCysncW9k8i1h5J3JwTQ88GHgykep20KaM+MIyYwarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cDuRE8Ic; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ut2lFHkwpmb+K3EVBzWHNHhXkqQsbBQiLvTVM0eN3X0=; b=cDuRE8IcWqDQDDIRZPUpK027nB
	xwfg9QuplaZFv+VpFFWIvtWT73JCqK/a1vhPkOIzHuMZ+X3hUT38iIn8NGjdTDbskzo3PQXcJo0nB
	EehnMcTq+mZrfAuV7jQybmKBkzGjPpO1wBFLZAjRJ+qgjdz+aV9W+2WYADSpf+APwM3HVzEDp17wx
	JmZf7Y2MLLlqPIbRMUw8RXfY/2KP/i4IwLFEibc9z9h4NIsxupSc5ZLNG1BpBMS7oZQxNNea8UUEo
	po85wU7raeUp1Dn5YinkeiZIYukVdn4vDpYDPR/vhwkBsDcgl3umYUQFhG/i4oA03nTt8G2FHEWy8
	yUWvwvOg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s05Q9-00000003hkb-01z4;
	Thu, 25 Apr 2024 20:10:17 +0000
Date: Thu, 25 Apr 2024 21:10:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-6-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Splitting a larger folio with a base order is supported using
> split_huge_page_to_list_to_order() API. However, using that API for LBS
> is resulting in an NULL ptr dereference error in the writeback path [1].
> 
> Refuse to split a folio if it has minimum folio order requirement until
> we can start using split_huge_page_to_list_to_order() API. Splitting the
> folio can be added as a later optimization.
> 
> [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df

Obviously this has to be tracked down and fixed before this patchset can
be merged ... I think I have some ideas.  Let me look a bit.  How
would I go about reproducing this?

