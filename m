Return-Path: <linux-fsdevel+bounces-18396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C787E8B84C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D91F26C26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 04:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF63A1AB;
	Wed,  1 May 2024 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hMyozbQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16022F19;
	Wed,  1 May 2024 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536852; cv=none; b=UOEdeWdk9sOzsoBr+Eh/tE4QlPLrkB/OJOryiCKyuOVXIjbWPh1LNrUnCzmT3ZCs5zapZ7QwW5Nb1o1FAq+dHSd6p7euPtLnX6NIJCEg1s3wabhyVM3jerJmeoBVWv2pghJRkcBQ4J0uXYhxvCt8+h3hINPYSCE/F1BzretU/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536852; c=relaxed/simple;
	bh=h6rKiW0img3etNLEAGqXiIzqSAgz6tYBryIkSyqrYf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F14XTzEd3HLk6UJfZ8qAHz2fbB7WFSOD9CqcK6coEOLSRDzOVVMQxKV9P7fGm42FI6MlqqhveIWUhlaOhCAuydtlPvmScRaffmpwBekC1wQEI93sqLOF6LUncbUmVNAvTefFuiUd5vnOP1RQN96VnVlKDPC45wxVQG1noHg+vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hMyozbQi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HVf+4ZQ4Imh+RkWB6AT2WtZQ623w3oYQq+TISB4ThZM=; b=hMyozbQiEMJ6TFFO2IInPbCVA6
	H1sabx9aEHhdO0qvCKGOlCb9+l6cq1jKHRe/vtYa8J5usz+YcioXOwKtO1YlEaFrOPFUd6zEj4zNE
	3eJxjAoRMzv8e/9YPQdsBxnvH/MXahvY5mvBHgr7+lTCnLLjrVRtilQ/9/8SGJclW2v2v0oYMmef6
	zhNv1S1abnxt0ClpfEAA7IYU5/9gWVPVj/LwKKnSmwUwmONlelDjLKXm9OeuqhFaR4YeBXM9EoWpE
	Ps7a1XRNnuATcSHNvQwz4CZvk90JQUVeprpv7BfQpMa1CtkgDMXbJLjq0Iu6vVzXbnOBkNHqFLYWm
	n1DqebJA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s21Lz-0000000G9qX-2e7R;
	Wed, 01 May 2024 04:13:59 +0000
Date: Wed, 1 May 2024 05:13:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sean Christopherson <seanjc@google.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <ZjHBh7my1X7qYtCV@casper.infradead.org>
References: <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
 <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
 <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
 <202988BE-58D1-4D21-BF7F-9AECDC178D2A@nvidia.com>
 <ZjFGCOYk3FK_zVy3@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjFGCOYk3FK_zVy3@bombadil.infradead.org>

On Tue, Apr 30, 2024 at 12:27:04PM -0700, Luis Chamberlain wrote:
>   2a:*	8b 43 34             	mov    0x34(%rbx),%eax		<-- trapping instruction
> RBX: 0000000000000002 RCX: 0000000000018000

Thanks, got it.  I'll send a patch in the morning, but I know exactly
what the problem is.  You're seeing sibling entries tagged as dirty.
That shouldn't happen; we should only see folios tagged as dirty.
The bug is in node_set_marks() which calls node_mark_all().  This works
fine when splitting to order 0, but we should only mark the first entry
of each order.  eg if we split to order 3, we should tag slots 0, 8,
16, 24, .., 56.

