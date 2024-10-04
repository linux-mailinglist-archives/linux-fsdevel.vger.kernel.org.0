Return-Path: <linux-fsdevel+bounces-30970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F679902B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921B91C210A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425C15B140;
	Fri,  4 Oct 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ujQQIUQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92CF1494D4;
	Fri,  4 Oct 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043760; cv=none; b=RSFyfate6isR0+UOMu0oPpOyxWLZ9ABdCvIoMbG2b6gu/9BK0sc0vdW7JIfuD1ybVu/n/igBP6+bM+WS5YL3mlXbj0Fa2vuVgVOXHod01wwKEeTbaa0g9xZxIN5CWFP/gTOj0bMipKXP0VJeJGZSDMFg2kgrgun8F58Ei5qgWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043760; c=relaxed/simple;
	bh=N5Dw8hn50XnLe9N5q4coDvvC0H+NcXAmc6FYp6q9bgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhS+AHfvt6ViQsK6kH8+57vZi8ajv1qGH8GMph984JD8tn/ZVUPMpR1LFJjoatBIMsNYpVUIQgR1eQoeJZxQ6WfpGVbhskgjS+RnonPI0jcSH3PclccHiIZVv3a4IVGUBvCcVACBAQdvjzTGCHsoYDfF1+1O3ueZw6upOakfQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ujQQIUQH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qJQRcZQJSM2tQbxOWjZ4fGpXJajdqx3Z6fiOf+bRz4w=; b=ujQQIUQHaXuKlKBG7X6hYoRUd9
	xbbSiGZDpLTFZYHUEa4gLckL9ZLr2aaiYsRtb1oTRcsxmIoAm9VwcgeMQ7TxWwhAm0qRw4a/7j9Wm
	qjvZj9KThUCPrenufjovnW9CzyU8o7qM0meKNsYNART/pRmSzcwrN3cpUFPJFkaysYbSLaccxDIUS
	/NiskBVzf4PZKy+7o/U0ZvRZrZw9IY2i0nq3s6Xk+aX60p1yIvhq2FJP/SY+U58bzpPvqgKbPzEPJ
	nmDdOMLU4WmXZoTd6h2dxiDUrzZjJXDIfsUaLMn4i8LaT4MS33xLQQXJLs/1Oku2jsQEQUvXvzs2J
	/0HpzNBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swh7X-0000000CFQv-1OWO;
	Fri, 04 Oct 2024 12:09:19 +0000
Date: Fri, 4 Oct 2024 05:09:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: willy@infradead.org, brauner@kernel.org, cem@kernel.org,
	ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/4] fsdax: remove zeroing code from dax_unshare_iter
Message-ID: <Zv_a73CjJ6PWfhoY@infradead.org>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
 <172796813311.1131942.16033376284752798632.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172796813311.1131942.16033376284752798632.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 08:09:32AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Remove the code in dax_unshare_iter that zeroes the destination memory
> because it's not necessary.
> 
> If srcmap is unwritten, we don't have to do anything because that
> unwritten extent came from the regular file mapping, and unwritten
> extents cannot be shared.  The same applies to holes.
> 
> Furthermore, zeroing to unshare a mapping is just plain wrong because
> unsharing means copy on write, and we should be copying data.
> 
> This is effectively a revert of commit 13dd4e04625f ("fsdax: unshare:
> zero destination if srcmap is HOLE or UNWRITTEN")

The original commit claims it fixed a bug, so I'm curious how
that happend and got fixed differently now.  But manually zeroing
data on an unshare does seem very wrong to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


