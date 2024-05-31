Return-Path: <linux-fsdevel+bounces-20615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348E8D61EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951D91C23D78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106617CA02;
	Fri, 31 May 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0XkRMDd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B016C680;
	Fri, 31 May 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158939; cv=none; b=In1CuTPNUcfJcH8ES6oF3N2CI4vfTQ2jC6AkA9kX1oB6qvEV5vJYc+SiuAAyIms3w9SHNt6Cm6hOWV6y5ALrfYxyj/V9xCftCpkbMZcjVV/B8S8cTX2dnapHSSm9vAzKB67ypZlqlUjUpErAQEONtM/UfUjMePOYP4PWNdw9eQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158939; c=relaxed/simple;
	bh=yz0H5jPIazi1cJgufbtsx3CWCOgn9qXqHlp9sIKzMAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd7xUaX7W0Df5ehQ5ECp4UkafBCaEgfFasK9ERGwlYI56OXOmByf4XevoD2uZHoj7xQdyaQG2fJhfetZEs6raPkwH50quXyfC85FaaeKJO0Yz36KrnqWyH6JoKKPOxLw/o9OjUSXP8xpn0JNF4IJ0K8+yW/fNqoX7Fl+DJ/wKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0XkRMDd6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hCUBcBU9tMIwZo+oglgi14e5xQXMY22P2t0qolDTyYc=; b=0XkRMDd62JE2zhC9qnAtfp6g2+
	PSz0tgR2r5VjwygMtuBtv4T7eAANbpbxY/6zxEwmlNSUOok5Zy0rpfiPqX1EjicPKJSh3E7JnIwiQ
	pyJBd97tTshKl68lRKVYcYYq+ZSFPMqG9EKLZwQ8XBGzpukaIyZ9UgCzbfEDH2UDDxzAn7FStqShU
	DvxyLG5Pi1amvu2TAY78PKUrps622e6/a9ZX1n8TuCgEEk8Y7cizJdVpMEIC6HUGtA4GurCJsiwzm
	AGTqf4ROBMH/EcQ2R3sJrpiCg9o6YKkyGGUsmst6nJgSJ0mWSVyOaN1/qtuQUMMa5fzDgvxbgY/WM
	wcA8+LTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1Tr-0000000AD65-43gx;
	Fri, 31 May 2024 12:35:35 +0000
Date: Fri, 31 May 2024 05:35:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 2/8] math64: add rem_u64() to just return the
 remainder
Message-ID: <ZlnEF4F5Vih4ygZC@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-3-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#ifndef rem_u64
> +static inline u32 rem_u64(u64 dividend, u32 divisor)
> +{
> +	if (is_power_of_2(divisor))
> +		return dividend & (divisor - 1);
> +	return do_div(dividend, divisor);
> +}
> +#endif

This ifndef seems superflous.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

