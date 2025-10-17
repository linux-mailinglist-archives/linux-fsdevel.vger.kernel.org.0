Return-Path: <linux-fsdevel+bounces-64509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08309BEB09C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA64E784B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50D2E1F00;
	Fri, 17 Oct 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k7QNxodB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747002FC87B;
	Fri, 17 Oct 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721277; cv=none; b=ozjwhYZ9lIxmVz1FATArly9vecNGM0Jpae/VT0LDishOLiKbUCIfVEGk8zXRW1iaTZGJVcI8ZFifXO3rMUt9qWMInuoyxPzBQP2V3Bt+yoPHuDT240lAbkVUuF0UY8wIhRwMr/7jxNOdIok84VtWOrefyd5kuW916BnxWmYD4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721277; c=relaxed/simple;
	bh=UgMbgWeM3gQDgIvQAVcV3tWWYn4I7W18QTSJrtQtsz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/cos3GswHge/UijEOdJcnBUAE9kI869wv7gNUXXq1bXNEGkKnzUka/6EahI13DuMbuHNxI0CiP1cD5H5oAOr8DReQUvn9DGwFcyu+SIIm/HSygKLB7R5L3xOxQwteGg+DKZMuRBPsthgPP+QLorhHTXdrAytJ9/ju7+uN8/f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k7QNxodB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fydJPMy/8eXN/HfxrYX/ccnK/kRSfy8GG0DyRBEqDRQ=; b=k7QNxodB8nfdc2ZSfMTg0+DVHw
	vG8HF4WN3F3TEFU6DIoc/7u92XhZcqLWj/S2yTLBo/4tLSrjB7sCcN0DpUOtKtYSg7t3Y2ilkIQzb
	mR5HYxeKefygr+/yAR0hO5BGqWCPfZHn3LEoWWDGLmRBRzRipfpanNhc8D0ydeEFP1asHvMmVtw/Q
	e9dFAFz8JmupuvykpqSXSHtPLRS916xRT+6pGZeUCR0UdjDWcl4kbfNNy58NtE7+2AFRL0atJzNHz
	4i6Iz/rGQTnf0rbMH4GbUWW72rL/rs0Mi1f3HyFwBqTizDygCFAR5DuM7vw0jKI0Q4676fzbvyoZl
	1USTEZoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9o26-0000000G9ol-0rW2;
	Fri, 17 Oct 2025 17:14:26 +0000
Date: Fri, 17 Oct 2025 18:14:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, Zorro Lang <zlang@redhat.com>,
	akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <aPJ5cvOlcjB_H_zk@casper.infradead.org>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
 <20251015175726.GC6188@frogsfrogsfrogs>
 <bknltdsmeiapy37jknsdr2gat277a4ytm5dzj3xrcbjdf3quxm@ej2anj5kqspo>
 <aPFyqwdv1prLXw5I@dread.disaster.area>
 <764hf2tqj56revschjgubi2vbqaewjjs5b6ht7v4et4if5irio@arwintd3pfaf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764hf2tqj56revschjgubi2vbqaewjjs5b6ht7v4et4if5irio@arwintd3pfaf>

On Fri, Oct 17, 2025 at 03:28:32PM +0100, Kiryl Shutsemau wrote:
> If we solved problem of zeroing upto PAGE_SIZE border, I don't see
> why zeroing upto folio_size() border any conceptually different.
> Might require some bug squeezing, sure.

I'm travelling right now and don't want to dig my way through the POSIX
spec to lawyer about this.  Last time I looked at this problem, I came
away convinced that it was a POSIX requirement that page faults beyond
the page which contains EOF must signal.

Even if not, it's a QoI issue and we've invested significant effort
keeping this guarantee.  Please just fix the bug.

