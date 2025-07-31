Return-Path: <linux-fsdevel+bounces-56417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09AB1732A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073C15875BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E119D082;
	Thu, 31 Jul 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zhaud7Jm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438652F24;
	Thu, 31 Jul 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971730; cv=none; b=XjL4M+YBOKEfV6+wmi0FmFZRw6fxIe3AXbDwnft7Kmr5rxLj6j0qiB/YVxGpVfO7Q8uolzSLVBaaK8WAuSfHSX6JGfsNDpaD9nk2XBSZfH5A+DRtFQj5JXv/9FVDFp/NbDxsvS0D2gMnqSIR+EpiT2ZgKde7TFojDiM8FScyoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971730; c=relaxed/simple;
	bh=e2difl6vzFqecv2qxgNItecx2uHXEvk9IGvUJgOXecw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vClxQqpbad7e714NESDJCNhLi298QWGjfzRv8SFjZ9hR9EOZB7g1Uuq1uOs0P72AfFOxpbdF98nTOn9nPVW3twpvLNYicUB+AHubDPIyA63lqeU/v5DkiAWjl5p7wfQvayRPGMY8Zx2lq7bE93l26oApBqgJX+ZyMHnXGOZwJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zhaud7Jm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4X8YJAk0Tmj/zgXqN05h0gfl9Kl2lXsAeXD+8Kujjo4=; b=Zhaud7JmNU4arTe0S5vL3vgvqR
	2FM0+526KBcascPIuxAiqqF+N8Xq4xYJpDpIUMzASPqYD27U99lnzKFM1+B9VKaI79W0SbZPDPjl9
	89p7sbS21dnUnYoOUhZIj6BFKkC6siQjwV5E5qGT4S3PJDg9FE+LqDF2US7ZQzygG9gxgmVulkW4u
	OXbJxC4b6PIgBzvJGxlN/kEK2MbIm43EVz0xtW17T8ICKJ8rKUwIeZBfLoIeIP2naGIn1UTs1yKqe
	fjwCP6lmMiNsD91f0TLAnZ7kGIojKByZPMMCgNfDMi1A+SSQ5vmiFl4AmVtmgTYZTNzGf3A/ljHGI
	tlYI8xYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUAP-00000003ojV-2lnm;
	Thu, 31 Jul 2025 14:21:57 +0000
Date: Thu, 31 Jul 2025 07:21:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, willy@infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2] iomap: move prefaulting out of hot write path
Message-ID: <aIt8BYa6Ti6SRh8C@infradead.org>
References: <20250730164408.4187624-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730164408.4187624-2-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 31, 2025 at 12:44:09AM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> Prefaulting the write source buffer incurs an extra userspace access
> in the common fast path. Make iomap_write_iter() consistent with
> generic_perform_write(): only touch userspace an extra time when
> copy_folio_from_iter_atomic() has failed to make progress.

This is probably a good thing to have, but I'm curous if you did see
it making a different for workloads?

> +		/*
> +		 * Faults here on mmap()s can recurse into arbitrary
> +		 * filesystem code. Lots of locks are held that can
> +		 * deadlock. Use an atomic copy to avoid deadlocking
> +		 * in page fault handling.

We can and should use all 80 characters in a line for comments.

> +			/*
> +			 * 'folio' is now unlocked and faults on it can be
> +			 * handled. Ensure forward progress by trying to
> +			 * fault it in now.
> +			 */

Same here.

I really wish we could find a way to share the core write loop between
at least iomap and generic_perform_write and maybe also the other copy
and pasters.  But that's for another time..

