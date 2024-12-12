Return-Path: <linux-fsdevel+bounces-37194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2D9EF3CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E351C28DBA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904A22541B;
	Thu, 12 Dec 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="mBG5Lml7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD92F44;
	Thu, 12 Dec 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022754; cv=none; b=d6I9uF9D94c/Gn5Qg4mCsYPrTGHZsL6Oa2u+ny5An5kWnrGJF4dGAkgWdJyzt2TDEv88AzQjRygYdvBuUdkkOkzKg3f+gQ6uQfK8UcbJoI5xKiqGeP+uBXASmTx8IlDWVP39XuIJzKAV0OM1hMEEP42IAEEVr75mB2EMxj1MAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022754; c=relaxed/simple;
	bh=BL7BBjJaNhrAlT5QrscsxpVfzBSAe+uykL7b6/KyTcY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bqkTx2fmoQxxeNtctMb0R41PJgHVZx6BK9DDNeneRsP62Lk+Wz2O3XOhbXWXHhWa7/TUFuan+SB2pgCdVcVLl/BrlKp862EYex+7wnVqPVhPYv2dESVJrk3WRh4O19eW/z+od9KgfPQmsUGdtOn5sYS9ZO6VmINfelW9H7jN4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=mBG5Lml7; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1734022751;
	bh=BL7BBjJaNhrAlT5QrscsxpVfzBSAe+uykL7b6/KyTcY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mBG5Lml7HJtK4c1BUb2gu7vTEaIx0JsCrKEusawKm2t1dS24KoC/NpaKQc0vDRppD
	 aHJ+T0K95oZeA/VKalqE0SuK74cwmAITkZaLE1v5QAmEL+JFvMo2i49gUaaBKkkIVY
	 AeifUehhDnQ59coArstVsV39QGqnYwjYpZUCsDCQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id C874C401F4; Thu, 12 Dec 2024 08:59:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C5E6D401C4;
	Thu, 12 Dec 2024 08:59:11 -0800 (PST)
Date: Thu, 12 Dec 2024 08:59:11 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@infradead.org>, 
    "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, 
    linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, 
    linux-kernel@vger.kernel.org, willy@infradead.org, kirill@shutemov.name, 
    bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
In-Reply-To: <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
Message-ID: <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
References: <20241203153232.92224-2-axboe@kernel.dk> <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org> <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk> <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org> <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org> <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Dec 2024, Jens Axboe wrote:

> On 12/10/24 4:11 AM, Christoph Hellwig wrote:
> > On Tue, Dec 03, 2024 at 09:52:41PM -0800, Darrick J. Wong wrote:
> >> <shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)
> >>
> >> They sound pretty similar ("load this so I can do something with it,
> >> evict it immediately if possible") though I wouldn't rely on people
> >> outside the kernel being familiar with the existing dontcaches.
> >
> > FYI, another word for dontcache.  uncached just has too many conotations
> > in the kernel context.
>
> Sure, we can go with DONTCACHE instead. Only thing I don't like about
> that is that you can use uncached as a verb and adjective, eg talking
> about uncached IO. Talking about dontcached IO sounds pretty weird.
>
> As I've said previously in this and other threads, I don't feel too
> strongly about the in-kernel naming, I care more about the exposed
> name. And uncached does seem to be the most descriptive and most
> easily understandable by users.

The page is cached while the operation is ongoing. "Transitory" would be
more accurate and it is a new term that was not used with pages before.



