Return-Path: <linux-fsdevel+bounces-63898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54644BD14FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093203BC2A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1112274B2B;
	Mon, 13 Oct 2025 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzoL9lfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BF14A8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324903; cv=none; b=JDLM2LTHDTm6Ax4qHG/wAYJpiJpMa3BiJi0faGDO56qRCtCyhjgQFdx9iICs09Y23ajOr6PpfLXQjC7PGudcx9RElUhreod7DFH8ttQLY+VyOmVkICQxo8Ffj1lxzZ28xY5J+aJhJ/4dD9UjQWdGPqHHYEv9vxO3gNo0//Y+FV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324903; c=relaxed/simple;
	bh=i7qqpr/sh/ibTlZ+q1VnL12ngGvJSsFhBDI/9Fyjf7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyRLCNwSpmV9fYWz6xmtvcDPRWNtAwjGMkM71GZ/nmGqJsvEWjPkeqCZCZrpdRYi38EpF+W5t+6iZaf7gkRAXtuGfbbLOetTsjO0RRdcGZx9dyLwGGyuVBlYhh83Z/jx9A2GMHDrlVQgQvkYCkNTQoAtoe+vHVZIO7rqZQPNH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzoL9lfE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=moaEjObYcCpU9nICHpMilFA9GZt9iTYqxtxEWRu11zQ=; b=RzoL9lfEzo5/wsdb/gcoGr+JLi
	dub7CvodCP/fvLOxBGqx71RTNVW5/stlGfAf9RJy8pdF+dVpcyPedIWGbEQBh3uGkfT6MGy2ONv3+
	ByThtp6yNrnn1Ao3YY3pMBqYCNh2ZwHaqmzucNW6KccAjkKdJnM/KqH1KZu0Mo1DkJf3tHiZKpRnk
	5oFh2/gBMi+1deSV9jILb+13dSdqiwWka/6e7NQiy56JbZecMJzZ7qwWZ5ott7QZDMoeuiRr/+rvN
	SdqD1sLubILN0xPSDEbRbUwOycsNVU1VWVHB1CzhakW1ztx7jYIZo5rvYXmtTL+IQDAyxYGqQ93pq
	bcjyoxZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88v7-0000000C9Me-39Wa;
	Mon, 13 Oct 2025 03:08:21 +0000
Date: Sun, 12 Oct 2025 20:08:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 6/9] iomap: optimize reads for non-block-aligned writes
Message-ID: <aOxtJY57keADPfR1@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-7-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-7-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 09, 2025 at 03:56:08PM -0700, Joanne Koong wrote:
> If a write is block-aligned (i.e., write offset and length are both
> block-aligned), no reads should be necessary.
> 
> If the write starts or ends at a non-block-aligned offset, the write
> should only need to read in at most two blocks, the starting block and
> the ending block. Any intermediary blocks should be skipped since they
> will be completely overwritten.
> 
> Currently for non-block-aligned writes, the entire range gets read in
> including intermediary blocks.
> 
> Optimize the logic to read in only the necessary blocks.

At least for block based file systems doing a single read in the typical
block size range is cheaper than two smaller reads.  This is especially
true for hard drivers with seeks, but even for SSDs I doubt the two
reads are more efficient.


