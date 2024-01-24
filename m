Return-Path: <linux-fsdevel+bounces-8788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F285E83B095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312FC1C22ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4812AAC6;
	Wed, 24 Jan 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4Gbu+QO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE781ABA;
	Wed, 24 Jan 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118953; cv=none; b=XiQnz4ZymEXawUI48HVOZC7vUDzJX/LvT4zzTNOmHz15lClmilYHZuS+fOuNvahs+uP2j11dIpSiNE6euuR+kdrz8tqe/GJoBb/VmPGkRW6GYxzhAsz9NOvBus+q2WKdW/YuM2JfF//G961QFX6mmbAz4nH9sSLTfxxGY3FQ2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118953; c=relaxed/simple;
	bh=8nHJpxze9i3uCOhGTrGvmXB+FRPyyXp/F8Bkilw7L18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/txCAkE/Rb+Qk9jTKJAMGZVCsVY/W5S2/d54ZGeAyxfhtwY6TNvaVa3aS0ososQeC9QnZDT+8jQsnRVWwFrgdJqvPf4NYBxPwlLXuHlQZ+Gfi+GMdy552Mw3PkdW17grYkBfAhggsTSvYbWLDPspwCkQYncJTEyuMOrbaH4Z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g4Gbu+QO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8nHJpxze9i3uCOhGTrGvmXB+FRPyyXp/F8Bkilw7L18=; b=g4Gbu+QOZjcYDq1GX/CDd67xHQ
	1MS2y9fFaTAAJ6vO8sFRAVyk/JnxX4hhNK3I6E7t0IGS/3oGdUQQc2wVXu7jLTM4KIf7Akg27WWex
	+izhhj1Ds/mX2I0vTtpSsOIaG4EU1c/T4eGoZGcZaJSaP1cPW6I/bESRrkHVZ17kK1sstMEANhNzm
	JgFmlZgjGUTRWuNS4HllcmC5yUs5YnmBV0Om9LJjAN2fS2+9dknKqY7yhnIN0B8JnY3J1RRmw4f2B
	OBae5YKcDNoYlXZs7ihRQgOiTff75Oww/7n+OnE/AGJZFp+JwmhmUCoUwdieCrHNXh8DIuXVWOadO
	VcW8VyQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rShTW-00000007Lpb-2ECT;
	Wed, 24 Jan 2024 17:55:46 +0000
Date: Wed, 24 Jan 2024 17:55:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Sourav Panda <souravpanda@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZbFPIidl6dK5cR0W@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org>
 <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com>

On Wed, Jan 24, 2024 at 09:51:02AM -0800, Christoph Lameter (Ampere) wrote:
> Can we come up with a design that uses a huge page (or some arbitrary page
> size) and the breaks out portions of the large page? That way potentially
> TLB use can be reduced (multiple sections of a large page use the same TLB)
> and defragmentation occurs because allocs and frees focus on a selection of
> large memory sections.

Could I trouble you to reply in this thread:
https://lore.kernel.org/linux-mm/Za6RXtSE_TSdrRm_@casper.infradead.org/
where I actually outline what I think we should do next.

