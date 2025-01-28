Return-Path: <linux-fsdevel+bounces-40196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A5A20408
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C9E1887F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED74188A3A;
	Tue, 28 Jan 2025 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s4gt+LYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C518BC3F;
	Tue, 28 Jan 2025 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042457; cv=none; b=HLVXCBGGpWz/jqUJLo2ZDFr7fSkILJaQt0YVhV8dZlKPZiOGCRIt94pnZ1ZG5qOChoguWverNunM0i79l3tWFawuMznWiHODsAaRRViHpV8QAjZMnU4SRTvJks+YRU08l9E7fx0JHyCIPpgAA+SehkNYhvIjFS3Pj8MBdRZOQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042457; c=relaxed/simple;
	bh=8Bd9Zbv9Dh5gdUTCdDlu8Bjt7zrJ311x3LZ219wkBNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCNbE4lE/5g006VRPuk1jm1rcjbzrKdIlfFZqKiKOiQkew9i7X1DCqlYHIUkeADHZLNP7N2h8tNCpdu1LQdSRI8pO4oONP3hJybev2W9Y2tc2kuw57Xd2iaC+PQqXtLxw2EsT8E9j9hiKZ9H0HDioKEI735sHTHHMbfRY+W5IrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s4gt+LYE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6WK3bv+2WuvpFmoxDahpusJUYC3eWSwsoIFFpOA1QUQ=; b=s4gt+LYEBw7fRyOEkQ9iIax24l
	WFd4wnLAECezLFujNwdGeZxrR9KXSYFgT4oCrPMjKeMG+2InT1kkRmU43kQyPFH8VN6LG9XH/z67D
	Sxapl47FInWUc7zwULSPtdHE8fSv8Wz5P3UvWJwIOgGd32iJG7mDVubw5Fa0AEEgMM9AvrY5oiF4W
	BkoXxUkRESZZbn1l3NQCS/kqzuKR/cDGVej5k/JjCjypVdUACcov7llKnPzMEZAZTPdJr8+lsAJNA
	tIeFigYwUGL6gEj37VQz+/R2jtrBMZBRa1eCeKGnBJvwIUq3vXMBurYFg/hyyF3oS4JXaUELqQoxD
	ai56EZNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceEp-00000004Abe-26M7;
	Tue, 28 Jan 2025 05:34:15 +0000
Date: Mon, 27 Jan 2025 21:34:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iomap: refactor iter and advance continuation
 logic
Message-ID: <Z5hsV876-PW46WsA@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133434.535192-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 22, 2025 at 08:34:30AM -0500, Brian Foster wrote:
> +	s64 ret;
> +	bool stale = iter->iomap.flags & IOMAP_F_STALE;

Nit: I find code more redable if variables that initialized at
declaration time (especially when derived from arguments) are
before plain variable declarations.  Not a big thing here with just
two of them, but variable counts keep growing over time.

>  
> -	if (iter->iomap.length && ops->iomap_end) {
> +	if (!iter->iomap.length) {
> +		trace_iomap_iter(iter, ops, _RET_IP_);
> +		goto begin;
> +	}

This might be a chance to split trace_iomap_iter into two trace points
for the initial and following iterations?  Or maybe we shouldn't bother.

Otherwise this looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>


