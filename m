Return-Path: <linux-fsdevel+bounces-37495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE449F3234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EABC7A242D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF200205E00;
	Mon, 16 Dec 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tp0xCxaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C0F9DA;
	Mon, 16 Dec 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357898; cv=none; b=haNqSQ5tArAGvXNJprvwS7o1csiTtn6bThoDait+nHR/7lhhxjNRvLXejQGyJP/3fvKmW2ROFXpIpS3t4kWJO3S/Did+Ao66e4QfPMH65g6jgMKxfjFY/HU9szpFWKp4qRK1G0EmURZ+4yvecsm+mGBzLslPTvvnOATZcfwk0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357898; c=relaxed/simple;
	bh=5njwGYEjKAui/aYzRtrMYT0KmVqx0TZ8ADoKSBkH7GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVD2qplr4bS3bwhqq8R2A3CDu3kXXUPw36wQk+wKCR2LHZdxSvjmxaSorGzyS/U4KwmY9pbXJ7J2lXfxYDC1uxdaqSSKJndAyJjfOiI02pJt4c7dystcW90W3bVu0F0Ci05qHNzsD+MRvcFnIEL4cyberSFsTe3Q2d+7fsclMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tp0xCxaE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wAzZ+wkc1xlZQ89GOVfWPJCCI3kQ3tXwbzlsKa1cNG8=; b=tp0xCxaElvimni4fldN9PQDGpi
	zkXXOnAGIdlnfUSWOUCDGI+axGvBzOsqElFl9kv8b1xaxQH5bAAQlzSjCUAtoUOlmNp1mSsdBhjgt
	NjSsnnkD6yVKrSDOXkZHWk4H06GDP3atutiIghhtvt7z0k6Jm5H27g5zYEJwUqPl+m6kp+D4vpANu
	TMwFhR7vowT0Y0/7Y27bE74G2GIM1eQY6tyrOjEkywD9mDn/f/fIn4yVQW9n62UtJoUyZscnsMoUY
	iJP6uXNwrhOQTAKz4bvrKpygWVnkdtFkzT2IGSRpmer7o0CxI35Rkd8goIkgZPzQ8T/oAi2OV2Kk8
	9k0/VLwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNBiM-0000000Grr4-3Rmz;
	Mon, 16 Dec 2024 14:04:50 +0000
Date: Mon, 16 Dec 2024 14:04:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 1/5] Xarray: Do not return sibling entries from
 xas_find_marked()
Message-ID: <Z2AzgqT7LCcT-BGr@casper.infradead.org>
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
 <20241213122523.12764-2-shikemeng@huaweicloud.com>
 <1f8b523e-d68f-4382-8b1e-2475eb47ae81@linux.alibaba.com>
 <5d89f26a-8ac9-9768-5fc7-af155473f396@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d89f26a-8ac9-9768-5fc7-af155473f396@huaweicloud.com>

On Mon, Dec 16, 2024 at 03:05:26PM +0800, Kemeng Shi wrote:
> Ahhh, right. Thank you for correcting me. Then I would like to use nfs as low-level
>  filesystem in example and the potential crash could be triggered in the same steps.

Have you actually seen this crash, or do you just think it can happen?

