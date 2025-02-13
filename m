Return-Path: <linux-fsdevel+bounces-41633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860EDA3385E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC5F188AD7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EF207DF7;
	Thu, 13 Feb 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3FCRadLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539020766E;
	Thu, 13 Feb 2025 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429824; cv=none; b=cQzk5vYXrqLvEc9YPEt7Qw1m1BDQLP57ilF+v4Y2iSprN4LR5nBloDEaIyK43388tnYCDCcVQ7guPb29LGUQuibOK+oJkFV9qmN+Oh+HDpn3e2DfcHNaO4gKW6quViVXADd5o0mqX7nQrx0LFAj8DwODEV6GS6Zh8ZHCmyDsUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429824; c=relaxed/simple;
	bh=ZQxI6qH6Kc2cWcqyEEmenn5Tr7JAfSKKYJFD5tqLfGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhRK8VdoltwKzFeMuWPUUslPrI/FYwPtYTk7AXSFjlqZhDShb/xnOj/G7yIeuSjybM65PpfNIVHnV/JmOh96qetXB48iP4Ms4u6HIi5CeJb9zePbkvUlwlGbjP7b4CbAzqB8bU/q0jvCNQvkFWE3xUq3bf1ttZFJ7pzdsgBr2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3FCRadLs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sv5a/GRflPJY0PRgbIf6lcGFlqfdaXAAIwFAskHYVOA=; b=3FCRadLsyJ71jy7aRxh7qyBI6W
	wRR7o/K0bHjkZ0UQhRtDLEr4E+dmscy2wlMjDAnja/Z/svzOrONwRXGuQjBzqVyrZQxxSy58Wql0D
	G+bd3Rvconb2RibxK2fPRjsCUAfcU6UEm4g5/gfj62Ga8MOMG3lA7myB1wD3qy4557WuYsZ7MZCyf
	l9fHeWNoseBATmIcUVAB/Q1fLUXvSDjf0MhnERbQtx73uOhLChzTM3vJ+mMKNlMAw0oXlyxv+yTt9
	VBU79IwK4/1v1yCyyF7VlaQn+iUDpcHWpCwjRoCrWpvt5kMt3n4SdAaO/CDBt4mMKve60XlphRdk2
	QPAfrnNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT9i-0000000A1SI-3OYl;
	Thu, 13 Feb 2025 06:57:02 +0000
Date: Wed, 12 Feb 2025 22:57:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 05/10] dax: advance the iomap_iter on zero range
Message-ID: <Z62XvvwsadBSXAaQ@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-6-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 12, 2025 at 08:57:07AM -0500, Brian Foster wrote:
> @@ -1372,33 +1371,35 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	 */
>  	if (iomap->flags & IOMAP_F_SHARED)
>  		invalidate_inode_pages2_range(iter->inode->i_mapping,
> -					      pos >> PAGE_SHIFT,
> -					      (pos + length - 1) >> PAGE_SHIFT);
> +					      iter->pos >> PAGE_SHIFT,
> +					      (iter->pos + length - 1) >> PAGE_SHIFT);

Relaly long line here.  I think this would benefit from normal two
tab argument continuation indentation (and a less stupid calling
convention for invalidate_inode_pages2_range, but that's a different
story).


