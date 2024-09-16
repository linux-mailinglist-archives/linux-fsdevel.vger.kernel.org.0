Return-Path: <linux-fsdevel+bounces-29460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7D97A03D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456601C213A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DC015444E;
	Mon, 16 Sep 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFfvFI/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123CA935;
	Mon, 16 Sep 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486095; cv=none; b=t5Z9VuTOQgwElWvEZReqFG6MrXdZ7/QIw71EVCeNANDFIbnN1i42n9/A24cb7OSAxLqvQEIYfZkjN7smUq/5Q2BhpfI+W6b7wjxN0KE+LBJt334BmVl8Rb5xoiFDD54nE7rFl33ywL3/pfu/fU2sBQv0EGbi61jWFXdForBW5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486095; c=relaxed/simple;
	bh=hEBEJKsYNCpkUWlqmAGqQuIzVBt1E+qYZss+7WvNPi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecw5zi7Kutf8pq8i6Z6kmm2V5tvPZcu3hy5wl4JLdBFnvn/V60SNs5Z4SUggFkitxZkyXi4zSKARdxys7QczPHyboDpjycqGpNgS6CEn71TghYLGMaakmhhVWJY1uGHMdGxOCXmNU/N7BOPLwi4iZsJkSrecsPk81Ip1cgxkDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WFfvFI/A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x2t+QTffd8xwVAMyv68RrUydCOmyp2i2VRu15j/HlVY=; b=WFfvFI/A/LYyyDi52N90GjOIwO
	2RBMk9o6ppFqWnUdyZnipUtAd6fMga79Prqc1UhZ7AazCEL6F3TGx48NXCPA8/XFNy6l9EHvF/RYq
	qLCEhlZibK8n91uieTzVHN92foe4UyVCVFv+8EKeWB9M+7x1A5VmbWlQfjyRV68Woe4mT0BxHonbI
	cuzfacDmzR/TMJGEU0Q22KRJUv72oasvpne9ZAjFdduUnb6uRJjmhaoJnIxhC6y5wnIea5AUqLHlf
	hGw78V3AZH35Jddg2FSZQek+8m5946rGrvEZSZwCT/PpaEuLt9TrIRAV0wj9uKuZ8DXW3EGsWNf39
	8bsyWbSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sq9tq-00000000NcZ-3BeT;
	Mon, 16 Sep 2024 11:28:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A4F030049D; Mon, 16 Sep 2024 13:28:10 +0200 (CEST)
Date: Mon, 16 Sep 2024 13:28:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] sched: change wake_up_bit() and related function to
 expect unsigned long *
Message-ID: <20240916112810.GY4723@noisy.programming.kicks-ass.net>
References: <20240826063659.15327-1-neilb@suse.de>
 <20240826063659.15327-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826063659.15327-3-neilb@suse.de>

On Mon, Aug 26, 2024 at 04:30:59PM +1000, NeilBrown wrote:
> wake_up_bit() currently allows a "void *".  While this isn't strictly a
> problem as the address is never dereferenced, it is inconsistent with
> the corresponding wait_var_event() which requires "unsigned long *" and
> does dereference the pointer.

I'm having trouble parsing this. The way I read it, you're contradicting
yourself. Where does wait_var_event() require 'unsigned long *' ?

> And code that needs to wait for a change in something other than an
> unsigned long would be better served by wake_up_var().

This, afaict the whole var thing is size invariant. It only cares about
the address.

