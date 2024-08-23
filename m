Return-Path: <linux-fsdevel+bounces-26997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F35895D7A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40861F22FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D71A08C2;
	Fri, 23 Aug 2024 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2cL3/nI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B58193406;
	Fri, 23 Aug 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443979; cv=none; b=IzBHqMFhvMAov+x50gPba8tWJSFxJOpvdA0UGunBKyRWKVCRGb3ZQUhSR2q1Nq712cyBEeQR7gtZPOGe1vBKTcwEgj9Qgo9viSOc4sfcGM6xTEOy6EtXmmHa3FslG80OApKF1uz5JF0e5IH3jC2d5cDuynHTZsaHQfpG466dghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443979; c=relaxed/simple;
	bh=e5lS3vPzKsBpQRZEa76gnk065x/jmm7jG3irunJlXX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3662/dCUBjUkHqDAfNkZ/EtTEl7vJ9vPVZ8OkpyND7IRQQAt7Y1k3wDUqjC4h8a3c1bZJTkRttXOHle0ZhgLzC5Yp7OnrQORiQHIF4XFt8Bkh8/UgyZzVJXmZpD0z4C8k3FVfR3zGWydrmqXN380ONz1dwpUtVxpHOgHn/37zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c2cL3/nI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JsVlpGeKYbg4pM/Q7waOkd0NZPoyLhoXi4BOdIXNLpY=; b=c2cL3/nIR787l++dJM5LnaWXeW
	5dJMUyI901WBryZBvo6lRG2cxhxydHjFy3QTpizCQwEC/54YFz67jxnF/I5qszT9dqo0dsCCv4bhA
	dEMDmoaTGmh5pW4lvMOjCT91apPyQE4b24ZkMYKZ/FNipFwrhETEx8OgNkQFTi5jLsCgTVFQ3QDbd
	FM2OqcrPBsmNW/FsNsoGQn3qZNhtl0oRKzR3YOuY8XFJb2NKoje+ZfRlO+UrdlPKSiBRRywGoWFES
	NA0RleWtfD87vB2hp7AObXu6t74Rjpsc6agZ6/B/bIYAzbDXZ0pQnzK28mFgU+JbZqvvFGoQCjhP0
	r9Y6Rv8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaeH-0000000C8f0-18u9;
	Fri, 23 Aug 2024 20:12:41 +0000
Date: Fri, 23 Aug 2024 21:12:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH 1/9] mm: Fix missing folio invalidation calls during
 truncation
Message-ID: <ZsjtOVMD2dxRw68H@casper.infradead.org>
References: <20240823200819.532106-1-dhowells@redhat.com>
 <20240823200819.532106-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823200819.532106-2-dhowells@redhat.com>

On Fri, Aug 23, 2024 at 09:08:09PM +0100, David Howells wrote:
> When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
> ->invalidate_folio() calls should be invoked even if PG_private and
> PG_private_2 aren't set.  This is used by netfslib to keep track of the
> point above which reads can be skipped in favour of just zeroing pagecache
> locally.
> 
> There are a couple of places in truncation in which invalidation is only
> called when folio_has_private() is true.  Fix these to check
> folio_needs_release() instead.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I think we also want to change the folio_has_private() call in
mapping_evict_folio() to folio_test_private().  Same for the one
in migrate_vma_check_page().

