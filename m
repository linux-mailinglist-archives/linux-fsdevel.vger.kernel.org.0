Return-Path: <linux-fsdevel+bounces-18431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF88B8BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FE01C20FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054A12F5BC;
	Wed,  1 May 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iphh46RM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FA12F367;
	Wed,  1 May 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573718; cv=none; b=OgQEAlcQmG9tI2mL4Ux/96zOqDa+qqViEK77h2PO88x3DkMR6jh4nY+mlOG7ZKIOX4DXxzN5RNA+akPDsD9L5VoGiGY6Fjlf53lIO4FSc9NRnJTCBlDIRX5Zbohguh4XX74hJBoxfnjDIDWBxmgp/AuXliHyMiFoO36w5u6nVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573718; c=relaxed/simple;
	bh=jEmQ4txAq3/S4EgZfg1vd1tqSRsNWdIJJEIUUU1j5Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpNXTQDtKNotthKs5PxYd/XXGf7fyxVtlGvbY7eG+g8Cfq1bJIeh17y3uyyGfcoMmYuOxLm2loLMgbkFR35YgSGsTpzxa9OkqLLx8C6qMEcf8q2jKLFiW5uP9z7tzEe5KPKQUP/fkaR8vBi+Sh+6ljJn6Rzcsm+5xJk9dM+1YVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iphh46RM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JoTrIvL17+SwrKhlHwdvALrB368mhDrkTh87Dex2qHk=; b=iphh46RMtc1VisceeYQYEMTctQ
	7IE0zuIqLkGjqVjpiZfl58A5H4WMuhjTQ+ueoeV9fEuIGP8/n8/LFo1Pa5rDaehZxOSVtKBrzRm57
	w1KlcUk0alQep3MeSVvdWMYxNb+G+R3BTVIyibyvvECw+qaZUnsGq4dj7rHrv+PArJ5iJydn0nqAb
	jcLK+2FUWHyAFfKn+l7TuFYTj0C2OWatOAsHQS4WFcftGvlvdNTp/4lF+wkknhR8WB1nY/3vqilpa
	Bo3fpi+IHJnzgSZKnAKItzcIxUXwk9sRkAor1lTVvmtlGj42OkW4K3EIASQRKBggHx9Flzaqm+ySv
	Aq/lS4jA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Awc-0000000H4FY-3319;
	Wed, 01 May 2024 14:28:26 +0000
Date: Wed, 1 May 2024 15:28:26 +0100
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
Message-ID: <ZjJRimEszNRvvGdJ@casper.infradead.org>
References: <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
 <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
 <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
 <202988BE-58D1-4D21-BF7F-9AECDC178D2A@nvidia.com>
 <ZjFGCOYk3FK_zVy3@bombadil.infradead.org>
 <ZjHBh7my1X7qYtCV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHBh7my1X7qYtCV@casper.infradead.org>

On Wed, May 01, 2024 at 05:13:59AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 30, 2024 at 12:27:04PM -0700, Luis Chamberlain wrote:
> >   2a:*	8b 43 34             	mov    0x34(%rbx),%eax		<-- trapping instruction
> > RBX: 0000000000000002 RCX: 0000000000018000
> 
> Thanks, got it.  I'll send a patch in the morning, but I know exactly
> what the problem is.  You're seeing sibling entries tagged as dirty.
> That shouldn't happen; we should only see folios tagged as dirty.
> The bug is in node_set_marks() which calls node_mark_all().  This works
> fine when splitting to order 0, but we should only mark the first entry
> of each order.  eg if we split to order 3, we should tag slots 0, 8,
> 16, 24, .., 56.

Confirmed:

+++ b/lib/test_xarray.c
@@ -1789,8 +1789,10 @@ static void check_split_1(struct xarray *xa, unsigned lon
g index,
 {
        XA_STATE_ORDER(xas, xa, index, new_order);
        unsigned int i;
+       void *entry;

        xa_store_order(xa, index, order, xa, GFP_KERNEL);
+       xa_set_mark(xa, index, XA_MARK_1);

        xas_split_alloc(&xas, xa, order, GFP_KERNEL);
        xas_lock(&xas);
@@ -1807,6 +1809,12 @@ static void check_split_1(struct xarray *xa, unsigned long index,
        xa_set_mark(xa, index, XA_MARK_0);
        XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));

+       xas_set_order(&xas, index, 0);
+       rcu_read_lock();
+       xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1)
+               XA_BUG_ON(xa, xa_is_internal(entry));
+       rcu_read_unlock();
+
        xa_destroy(xa);
 }


spits out:

$ ./tools/testing/radix-tree/xarray
BUG at check_split_1:1815
xarray: 0x562b4043e580x head 0x50c0095cc082x flags 3000000 marks 1 1 0
0-63: node 0x50c0095cc080x max 0 parent (nil)x shift 3 count 1 values 0 array 0x562b4043e580x list 0x50c0095cc098x 0x50c0095cc098x marks 1 1 0
0-7: node 0x50c0095cc140x offset 0 parent 0x50c0095cc080x shift 0 count 8 values 4 array 0x562b4043e580x list 0x50c0095cc158x 0x50c0095cc158x marks 1 ff 0
0: value 0 (0x0) [0x1x]
1: sibling (slot 0)
2: value 2 (0x2) [0x5x]
3: sibling (slot 2)
4: value 4 (0x4) [0x9x]
5: sibling (slot 4)
6: value 6 (0x6) [0xdx]
7: sibling (slot 6)
xarray: ../../../lib/test_xarray.c:1815: check_split_1: Assertion `0' failed.
Aborted



