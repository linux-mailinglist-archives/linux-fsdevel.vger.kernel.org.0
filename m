Return-Path: <linux-fsdevel+bounces-63899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDE1BD1502
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A54934E4AED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF41274B2B;
	Mon, 13 Oct 2025 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yrTqk0ur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F328E00
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324961; cv=none; b=KgZxG+HTLXGVtzSc97qc2o6G+mh1SD563PQlIJbiS0/3lVL0l5AZEjxHoTRLpcyFR9pam3GMou8C9U/TevelZN/9NEahWn6dE/0IFrGRoAIdNB3oon3+fxXT/jQw01LR6pWTAVfwD/JjQ/s/9mACLWTDIojUpROBoHBzn6zytg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324961; c=relaxed/simple;
	bh=FAEEXEHKKzH5B2qvcxMBMuGTGOeWD/X3u3YcKbAoY2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl5AfPRblsYjqubR2OVkfimU0bg4F89a6/FCrEMkImwH5DvYNWwTBUsaVctSjMv9wSwBa+PkD3Dy9JU2zBeiB/eD6eW8vp5ox6z4YlavSfEKBLC9zGhOJkj+s8+mTYk7C0mc9m7h64YPLnFm3aPQbuirMFWV4nDjyyTNxhfTVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yrTqk0ur; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rczvePUQMUJwRF39MQ09nAOwfhjU2tZFqeqpm7PRTNc=; b=yrTqk0ursg7hUb8IVehmKMnLdu
	owCEHqlAg43n0Dpg9NaXLaFQdTtMRDd3qo9S8LY/f4xwu10Iy4TyApyQo6VqgS+I5NGyKTSMieXHW
	maE8rQgBskbsFytmaEvkhpAA3j0hk/1OUK8jIhHsJAOxOzP2r0UlqUmadSyG3a1pNWk7RE1rdCTQw
	XtyjAVG9qZK1jTVYtDDi7tqXO5qzD+4lFweDg7HmKYYZ95yiNjc2Wocb1vo9fpiQK7rEj08pMr863
	uJGVe6Q41EKeJmKJifvT8lyxGD1xgdCcHmcNge8z9zetxFfOP5k7H/w6AZ2pkx/N0RyHoqduVM8m+
	NIeAPHaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88w3-0000000C9PB-3oDo;
	Mon, 13 Oct 2025 03:09:19 +0000
Date: Sun, 12 Oct 2025 20:09:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
Message-ID: <aOxtXz8fMCTk6C3S@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-8-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 09, 2025 at 03:56:09PM -0700, Joanne Koong wrote:
> Use loff_t instead of u64 for file positions and offsets, consistent
> with kernel VFS conventions.

Which for historical reasons makes this a signed value, but I can't
find anything where that would cause problems.  But maybe mention
that in the commit log?

Otheriwse looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


