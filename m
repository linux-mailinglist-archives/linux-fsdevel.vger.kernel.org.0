Return-Path: <linux-fsdevel+bounces-45845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8EA7D94D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3917A31E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F75237718;
	Mon,  7 Apr 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWQqKVXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CF2309A3;
	Mon,  7 Apr 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017348; cv=none; b=hH5CLq5YwC/iU5KsKyV+/26N5IDp3Cm8m5MPUPoKIYJ00ud9wYFt/7+Fv3mHzZ7CqiUsGYi+I+lD6Vy/p4tstP6oxYf9fynq5kEFOdCl5fOcyssVGGibJX+JDd3VHPEyg68NRzlHr2TTrNj9x6UHnVxovDDFZNpvazT4nf1tSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017348; c=relaxed/simple;
	bh=ND5TFDjwajhpW3p14uRN8gBouffujWQSboBCcOhvDB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTmjpwwDSsl6l1bcfC9ekImkP78PwSZC8DuBja61Ef8mm1EjNtGdZwd0nPsBFZBU3s1+ea3su69hreuTNTYK3gNqxG+J8FjGHBOBm5uoPpk6lyXJVs0iyCwFhVQxgUfq5uoNo9OdgoBqljOLeMPTyjEOAtYKzceaA+3fsxh/Xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWQqKVXA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ofqWwqYhXMMlq9izH/X2Vybg9guxywDxyDKd2Dx3UiE=; b=gWQqKVXAMd8yKk5YBfYHP8zEkI
	vzJHXkuDQWitK/baGDY1h7cbxIaGjM1d+Sn59xfQp2R0n36Z2LKWbjq/QUep+k1dchsKnkA4mqqSk
	MLCiavZQM1PGpkgxshtqMpZqQsxMlM9nkhRM1+AyhpdfaxbiyvumrD3TmhcEuOFp9kIpYx72LmCvt
	l/8JZquo6wT0nZFH5lKmhoY30BtmcaNnnXNOKJJ3leYs+/4cgieFpeG47l3SAYLiqResroUBXDnCX
	x/yCb1VIhwYFYq9ovuhn8NuO6ZOXcUespBWbVPEPhgT8/YXXUznrHpfjRI6hRVvC5r6/q1CUxXC4i
	PuhrNIqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ia2-0000000H9UD-25Dq;
	Mon, 07 Apr 2025 09:15:46 +0000
Date: Mon, 7 Apr 2025 02:15:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Allow file-backed or shared device private pages
Message-ID: <Z_OXwvGS3o70YxpA@infradead.org>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
 <Z9e7Vye7OHSbEEx_@infradead.org>
 <Z-NjI8DO6bvWphO3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-NjI8DO6bvWphO3@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 26, 2025 at 02:14:59AM +0000, Matthew Wilcox wrote:
> So, there's no need to put DEVICE_PRIVATE pages in the page cache.
> Instead the GPU will take a copy of the page(s).  We agreed that there
> will have to be some indication (probably a folio flag?) that the GPU has
> or may have a copy of (some of) the folio so that it can be invalidated
> if the page is removed due to truncation / eviction.

Sounds like layout leases used for pnfs.


