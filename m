Return-Path: <linux-fsdevel+bounces-2846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2EF7EB4C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E485E1F25482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563C41A97;
	Tue, 14 Nov 2023 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d1gPUEX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF02AF1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 16:30:56 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAC811B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 08:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jzAvsuanQaBUz5wPAICLWh1DYVHn95ZYhRfrq3ol09k=; b=d1gPUEX3pq6yX9fi3hvaLve7H8
	ZEtozIqC/bIDWmECea+bn3EL133oT17bFeubsrp9hEhNVLkcU3IB2OwfziYEc5OC5uzHID+hqjGdu
	xOxFBc8WCXvZHM4Mb+AzyMOz4vxsCUEkWYkzzgsUo3TwuVf0fb7nK7u4eBISiPGFK+SAGzAp1Vl7s
	XV1JEUv4+MUeO9sfEZb3fTwWnKE2XuKL+46l6Kmh374h3CWLlbDZ1Q8nwibDbsYyAonb7+t9CS7PY
	eql5bg6btm3EqJhO1b/Xis89fdiJN+hAmFIzQRlDFW+8CeKX/A6uuqlCmM+4K83V22EkMr7v0jmr5
	q29Yy/vQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r2wJN-008yeS-Vo; Tue, 14 Nov 2023 16:30:50 +0000
Date: Tue, 14 Nov 2023 16:30:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: More ptep_get() conversion
Message-ID: <ZVOguexQ2rGhnwN7@casper.infradead.org>
References: <20231114154945.490401-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114154945.490401-1-ryan.roberts@arm.com>

On Tue, Nov 14, 2023 at 03:49:45PM +0000, Ryan Roberts wrote:
> Commit c33c794828f2 ("mm: ptep_get() conversion") converted all
> (non-arch) call sites to use ptep_get() instead of doing a direct
> dereference of the pte. Full rationale can be found in that commit's
> log.
> 
> Since then, three new call sites have snuck in, which directly
> dereference the pte, so let's fix those up.
> 
> Unfortunately there is no reliable automated mechanism to catch these;
> I'm relying on a combination of Coccinelle (which throws up a lot of
> false positives) and some compiler magic to force a compiler error on
> dereference (While this approach finds dereferences, it also yields a
> non-booting kernel so can't be committed).

Well ... let's see what we can come up with.

struct raw_pte {
	pte_t pte;
};

static inline pte_t ptep_get(struct raw_pte *rpte)
{
	return rpte.pte;
}

Probably quite a lot of churn to put that into place, but better than
a never-ending treadmill of fixing the places that people overlooked?

