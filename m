Return-Path: <linux-fsdevel+bounces-36796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302159E9747
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EEF167149
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819E1A23A5;
	Mon,  9 Dec 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cAcTwbTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F4233135;
	Mon,  9 Dec 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751351; cv=none; b=YX4MXVbWWo6VuH/vmFmEYIwk4qi0W69xHCyutstjpKbAUQTqfM0n5IiPlYD/xAGtANKNEndJZ0XJ8iBP823l4O0so4ianvKt8hD+rtUxaEDpiaK9Xf2rszzuNYOzBIhwrCGLEebXTzGzHnzQ2jWyqEXY3cyjrE+8f5bSs2mmTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751351; c=relaxed/simple;
	bh=Z6NSCUppTuXTcredm9qphs4vQg7EMiPm+QOizuT3m+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlIkevitpH+ETI2wUMcyX6X/upGOKH6FOUajCHJjQgZ9zPL6qkEL7cYaVjFBb5ZpUgRHAQP0YLfYmtjfrHX5SNU/iuCbIMpt+/lq5U3BK94WsMsfDOkIAnv3HENaWcWSknxrY2r1+k9niYovcaAxxn3CAWrNLGtHAI+S/XsPu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cAcTwbTT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gBY5yvbKAw5suqcX3k3+O1C9fceFbg6i89ShHzn6yEo=; b=cAcTwbTTHbdqR6+Nl5YVOyKSPp
	l//uvmEFdTrOrZM3T8nWMdnIEDXR01A7nM/LfyCBrr+2YeYROVthMYhZg7OX7eDRPjYNyZJcWWP16
	ojpsJOtkCw6sWFtgmp+PWSUV0RNBfGB8pdaRtfbc6nzz4WDCeSqStG5qLY8/nFiD51H6w7xPeeP+8
	hoN2oG53wQ+JuJUrjO0jhyAfpQA0uybHaDiNCTkfeC9BQD1bAk5To3fdwUYfA1xlLqL+3QvfMkCbQ
	5Ba724hAK5XMCAgkerB9OMTG4SExHCpdGDdTwxvcbaitAQhtVhNLdWSzUu+4Cpokt5Z1jk2NF3RQE
	WVKJHrpg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdvI-00000002L8G-0pO4;
	Mon, 09 Dec 2024 13:35:40 +0000
Date: Mon, 9 Dec 2024 13:35:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lokeshgidra@google.com, lorenzo.stoakes@oracle.com, rppt@kernel.org,
	aarcange@redhat.com, Jason@zx2c4.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm, rmap: handle anon_vma_fork() NULL check inline
Message-ID: <Z1byK9X59RHFJMHZ@casper.infradead.org>
References: <20241209132549.2878604-1-ruanjinjie@huawei.com>
 <20241209132549.2878604-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209132549.2878604-3-ruanjinjie@huawei.com>

On Mon, Dec 09, 2024 at 09:25:49PM +0800, Jinjie Ruan wrote:
> Check the anon_vma of pvma inline so we can avoid the function call
> overhead if the anon_vma is NULL.

This really gets you 1% perf improvement?  On what hardware?


