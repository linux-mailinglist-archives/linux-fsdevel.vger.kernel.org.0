Return-Path: <linux-fsdevel+bounces-27632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7BA9630C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5021F244AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418F1ABEAD;
	Wed, 28 Aug 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3LfUWA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05B1AAE0D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872287; cv=none; b=nkF+TMVzzfSDVk9ObuW4LlZKK+An9pDHnENyG5Q6nA1HDsCTKrCWwrv8wAws7HrovD5ExE9bEF3jGNTcdhlUdRvBkT22JSahvA1uzXxFJDeiwnWrFY02PQJQa9rCTUrZWXaKhv5uUypv6M4YwbtX2SjNuTk4NcUqty0eyModXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872287; c=relaxed/simple;
	bh=xwUHcngPIMMwNkAT0pu+KDN1EFPtCTrM6SVkoQoFFAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIOvARedH64CUqOwlNB5b6jBl4m8msosb0lgrY4UsaIA5CXu7GdCiO4JKUndLfvNqRSmNZRtl2V7B0/7ATmn5qp4FirRiGuJST93womb+u5Sq2j2Nfj1H6MDbhoJQnJjnmth4+Jb1ZvorrzXo7Lk+od9A79Qig8BmQKvMOf5jyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3LfUWA8; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 15:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724872283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GJ0kQNrYXX9msho8J4AhvERHyhJZ0duOS+e8oU72YE=;
	b=B3LfUWA8l8mmjSaFE6ClHPtuaOFidM2PzSFwePSZfiEQifAAVqUkYhY10DynXMQw3ODDYY
	QIIZoSt1z0wfqLJjUt0+eDfyko6JI/8MBw4Ua5La8XdmAHWRV6QgjkssZBcW9o8SG9Ppma
	KeyI1odcm9BVsEUCU0PgAQIPhHNFed4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9xC3OJPbkMy25C@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 07:48:43PM GMT, Matthew Wilcox wrote:
> On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> > vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> > pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> > unsafe locks is a potential deadlock.
> 
> Kent, the approach you've taken with this was NACKed.  You merged it
> anyway (!).  Now you're spreading this crap further, presumably in an effort
> to make it harder to remove.

Excuse me? This is fixing a real issue which has been known for years.

It was decided _years_ ago that PF_MEMALLOC flags were how this was
going to be addressed.

> Stop it.  Work with us to come up with an acceptable approach.  I
> think there is one that will work, but you need to listen to the people
> who're giving you feedback because Linux is too big of a code-base for
> you to understand everything.

No, you guys need to stop pushing broken shit.

