Return-Path: <linux-fsdevel+bounces-15613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E139C890C08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5BD2A5B35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B913A885;
	Thu, 28 Mar 2024 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hX6RzYpp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB512F5A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659222; cv=none; b=r9L3TATXbN7OlbGjSaoDFMZJSYJ/yHquHCCcpdyMxF3PJcoxirY+q83ags944OpYUjI/1Da52vt7p/JbCJDNuCy+oRtLhcSZewbGiaXtvgSspTv9n/6QvhFLNZ8cfHuPchIIN1xrfPmYWsX2oyePfXd0NOuMRj9PHL2MOQms4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659222; c=relaxed/simple;
	bh=9WlaDlTvJunr2183NqWDqQUhDJokHhxGdsWaj3WLACg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYgG0sg/Wp0CJGfOkWe4hSS8ZQdpt0PeRY1I7Vk/GPqG0yIFrTn3b1E3GkevEgA2/R19JqmiLXC9ubT3j+Cnwc8xtUJ7O80EgjTRyUCWSivj14jNjNdNrMkh51dsy5UQn25Pwg86KPG5VV9e5W1R1GwRwo35RNXX9O7sSz++818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hX6RzYpp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 16:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711659217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6klecw7FtvxC8xB3iXUbQO5diCiIEi9rWvSQx3Zfc/Y=;
	b=hX6RzYppk/5rFcAO95k+wS73O77cvkcieLokj4EIiIx680P8PQkCxPDBQaA06vXexfbOSo
	uDtGd0bxY2SgIn/gdrQjEjYjbDINExmHUHX4fNdvUzAUgmrFrVRPrU3tdqvfBtUCsJDKTK
	bI90ue5CkfttJt1hRE3x0nj2T9X0lXg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <4vih3tufuhksf5pi5ydaqfynwlq42sdydmdaqzytfmxqgwi6ao@qog7ho2kvz66>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
 <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 28, 2024 at 10:46:33AM -1000, Tejun Heo wrote:
> Hello, Kent.
> 
> On Thu, Mar 28, 2024 at 04:22:13PM -0400, Kent Overstreet wrote:
> > Most users are never going to touch tracing, let alone BPF; that's too
> > much setup. But I can and do regularly tell users "check this, this and
> > this" and debug things on that basis without ever touching their
> > machine.
> 
> I think this is where the disconnect is. It's not difficult to set up at
> all. Nowadays, in most distros, it comes down to something like run "pacman
> -S bcc" and then run "/usr/share/bcc/tools/biolatpcts" with these params or
> run this script I'm attaching. It is a signficant boost when debugging many
> different kernel issues. I strongly suggest giving it a try and getting used
> to it rather than resisting it.

The disconnect is with you, Tejun. I use tracing all the time, and it's
not going to be much of a discussion if you're not going to formulate a
response.

