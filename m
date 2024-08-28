Return-Path: <linux-fsdevel+bounces-27631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1C96306E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 20:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC0F281F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D11AB503;
	Wed, 28 Aug 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V2bzXaw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58C156F5E;
	Wed, 28 Aug 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870935; cv=none; b=axpLxHbKWYRd2fczi+kBPo7xAUnareMJyXyXVbjz5JPFI3uNQ5KvcNdRXFXY8jbQZhOgL7dIUsYJQXtLAjUY1olVg0udS5g0zan1sp4ebpNN447fdkUjBJHepi679jZ6rFSetdg3GayLiQFvkaQUe0X+RdDFxK643x9vdP1mSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870935; c=relaxed/simple;
	bh=I0wmo8wWplZ5jNJCrsewmNoA9X0tGz6u8BcEVEcTm7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paPklYtMkp0kxmWaEnf4+N9eeLzXM5o0j+fiZqCe0W5EoWCUoprKw3Y7RP9aD6gTTKfihnn+BHIch0q7GGAMDVVQaw5mjgQwXYevVxtF6GWl9rcbGme3OVwbgUQR0VMqxs6gbjvegerz/qB9iilc10VbX4eFe5udaQ6jqRoT3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V2bzXaw1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bYmPY0rKFJuPGAn1AckR/tTLn/x55fhHVXd1MAfjtxQ=; b=V2bzXaw1DbwNI/PeKRLEef84yH
	FcQF39DV/xoQw3r3t5vYxSjvXkUpn9Vq/XeCBgo/K9VRDiq1v0bdKlwoWSxW6WwMMEdagO2Bbc2tz
	Wrajfl+ySLju5Du6u5NK9ZYDvPOm0KgJ8mCGxJSla3qg8416DG29czGU2mgY+bP+O5h4mXvz1urn9
	GHtsbESiUizW3+4nkdQcGMaiQM9EO/qsqlmtPBcH1+McyL9pYRGqP4kT7qgb9pM9qm1ol3L19VRjr
	+3fv2CLP4odsJZ1+l7lBqBignUNvp1CKDjA04tkOud3Xqa9vIZgmd7vY/mt+bgbACS0W7URQcyBrN
	YC7ITMhg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjNil-00000000uoY-3xVC;
	Wed, 28 Aug 2024 18:48:43 +0000
Date: Wed, 28 Aug 2024 19:48:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <Zs9xC3OJPbkMy25C@casper.infradead.org>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828140638.3204253-1-kent.overstreet@linux.dev>

On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> unsafe locks is a potential deadlock.

Kent, the approach you've taken with this was NACKed.  You merged it
anyway (!).  Now you're spreading this crap further, presumably in an effort
to make it harder to remove.

Stop it.  Work with us to come up with an acceptable approach.  I
think there is one that will work, but you need to listen to the people
who're giving you feedback because Linux is too big of a code-base for
you to understand everything.


