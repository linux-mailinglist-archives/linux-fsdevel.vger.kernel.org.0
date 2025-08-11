Return-Path: <linux-fsdevel+bounces-57305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7339CB205D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82C63AD2B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D53239096;
	Mon, 11 Aug 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IbbnZtR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0D238174;
	Mon, 11 Aug 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908754; cv=none; b=VraSsgY3OlJYlA1j1YRDQIhve1+EVllRQDvnEr5I3/p2Uw0h8YcKpX6gfujbbc3kO5/N7xcX1dEfOnH6PSsDz5EFIYF9oN0eJ1YFFQArwVLYlhjUPFl87PRuWKRrQO8u0cHEXYZyT7ubsH6tFA2DZEbM65qiHHqaGgUO1l9u5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908754; c=relaxed/simple;
	bh=m7Aheu6pgnhLXAQPhGyQO7WsK4X9UVP2kSXqgurDskA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iywQOpsB1pbI/LjvoIBuBOFVwfwL6qMj29ol/ujpiwtmq9tKlvTrT6QSSTUn38Aiae+WPwGct5o98JSoZoDfVAh6ivQmxh0wRho9/1tD+AhIUb5jOG1Iyz2FRH+xQtUNy325owaFwpvtsBCGTv3an1VhA+Kbjujeqcnob58VzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IbbnZtR3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KYvrsO7dkI6xj0+a+F4DeknHdrUWUNYIobaAkuwRuqY=; b=IbbnZtR3DIY+y3umj3RgXdDH5t
	pT8qM7PYtro4YV8V8EJtwidKIE5s6wbXLi9cT7wAncSkUIoyfh65Q/U0jzs/lc3IHtjbfUJWSnfq6
	UHYRRsG/RjEsn+2tl48OGhOkZhPJJS2ksRBTJPla9eVFGF2zi1h1JiN8ZnYggN6W/LreKNLu+DYbj
	/XsEVmixsLpDBOhvGT9DrlDDidjPWHydwAUvfVvjzX++RZWCH25L2Ac3kpVL688r4bV4mJg+yMQzj
	Y3IjQ8uvQTo0cX2O8DOj4EPKcJQmoXmI9URW/DyXuSvSTOLJKbnYhZS0hYxVgYW4d/4Y1Imc9JBFK
	Orj2rEAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulPvi-00000007M8Y-2Df4;
	Mon, 11 Aug 2025 10:39:02 +0000
Date: Mon, 11 Aug 2025 03:39:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2 1/4] iomap: make sure iomap_adjust_read_range() are
 aligned with block_size
Message-ID: <aJnIRs-XbL34EmGo@infradead.org>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
 <20250810101554.257060-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810101554.257060-2-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 10, 2025 at 06:15:51PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> iomap_folio_state marks the uptodate state in units of block_size, so
> it is better to check that pos and length are aligned with block_size.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..934458850ddb 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	unsigned first = poff >> block_bits;
>  	unsigned last = (poff + plen - 1) >> block_bits;
>  
> +	BUG_ON(*pos & (block_size - 1));
> +	BUG_ON(length & (block_size - 1));

We should not add BUG_ON calls like this, please turn these into
WARN_ON_ONCE instead.


