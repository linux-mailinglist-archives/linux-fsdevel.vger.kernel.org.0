Return-Path: <linux-fsdevel+bounces-57584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1CEB23A76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66E5622D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448DD2D738B;
	Tue, 12 Aug 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rjmk1hcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FE20C469;
	Tue, 12 Aug 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033239; cv=none; b=H/ZAf82y7U48Cdf/9cO+OZoMUIFRFh5CVW58QIuFQrbC86dS6wBt0NLeKBS8FRFQ5JnOV0NB7UuxZL9tRDP0nWPEg6h0lMUjLrz0Ez4X22gtx0iFf6Ql9xHSd6zWqVL7Oamm6Txp6K0dNAkyNAWEYv9RoFGanoOu0B4/4tGCQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033239; c=relaxed/simple;
	bh=JNu3fq2i05e3xoWR4mijUk+DXGjiS713oczepK0Ut7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGN4QsKKTZXWQsTD8SWElutlfF7SBS+e+U58cVRP0zbH1zi6PfrFPPOARTTpq3ve08FPv3wCq3NtQHOKVxazJ71XWxbbEgmKeuT8l4bVcIXkpRI0D3hCb//EZFSUyke9COVM8+gvnAlp1MBoiRCBcFKT/WOAq0rjoDb26WB1Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rjmk1hcG; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D2C8814C2D3;
	Tue, 12 Aug 2025 23:13:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755033227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7VgV8GRNyIyaEcTOqPVBDWztfCX/1VXfxFaCGnsthU=;
	b=rjmk1hcGLaLckCU53YbczHK8umSF0GUgVQTk+VmjeFdHTZRaiLcCYMJQGk2SPrAVcI1DXE
	dO3QJU48U+23jurGpM3DBAB2DGSoFZg5zx9qk6b5fgrOm66LqDJstPeV063OBHWC4rdVRX
	BmbYRjL7cTDWaC84AmwAy8LL80aefu+tQZ3kLPSIiUUPEFQmSc0clGCaUG2Q2k4K6XQWiC
	YLkrdewp5dcpssj6bxNrUbKf/upzYtd5j/CqcAcpfGySzSYKDxb68G8OCbaOyYPn7c+RSU
	5CT6uR0pgFVU02AaO2ClVdeMlR2ss/knHWoqbWZfFlV+dE46uqNFyk6URQ7tNg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c50da482;
	Tue, 12 Aug 2025 21:13:42 +0000 (UTC)
Date: Wed, 13 Aug 2025 06:13:27 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <aJuudyp8VUPvIbjF@codewreck.org>
References: <aJpipiVk0zneTxXl@codewreck.org>
 <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
 <385673.1754923063@warthog.procyon.org.uk>
 <650269.1754991257@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650269.1754991257@warthog.procyon.org.uk>

David Howells wrote on Tue, Aug 12, 2025 at 10:34:17AM +0100:
> asmadeus@codewreck.org wrote:
> 
> > There should be a `if (slot == folioq_nr_slots(folioq)) break` check
> > somewhere as well? Or is the iov_iter guaranteed to always 1/ have some
> > data and 2/ either be big enough or have remaining data in a step?
> 
> We should handle both cases.  I think the other iteration functions
> will. iov_iter_extractg_folioq_pages(), for example, wraps it in a
> conditional:
> 
> 		if (offset < fsize) {
> 			part = umin(part, umin(maxsize - extracted, fsize - offset));
> 			i->count -= part;
> 			i->iov_offset += part;
> 			extracted += part;
> 
> 			p[nr++] = folio_page(folio, offset / PAGE_SIZE);
> 		}

That's not what I pointed out just now; it doesn't check either if there
is no slot left
For example, an iov_iter with nr_slots = 4, slot = 4, folioq->next =
NULL will happily trod on folioq->vec.folios[4] (folioq_folio(folioq,
slot)) which is invalid

-- 
Dominique Martinet | Asmadeus

