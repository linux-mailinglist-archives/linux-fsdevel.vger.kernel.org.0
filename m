Return-Path: <linux-fsdevel+bounces-14942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD231881B91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C67B217AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FEBB645;
	Thu, 21 Mar 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QV51zt6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5817494
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992127; cv=none; b=HUVuM1kmOw/VPHOdBHNVD5vnJftQ/rXKmSzunuoQX7Nbr9Zjen7hQKr45lzN5xQEYA2wPVltHlm0C8JMPXANJkoCB7+wgWLngMarz6JIoEx8iTCqc2N4HRlEGvxu0rXqPFIzQBYn4IXw7vaKgxh5WSYWEh3e8e/Pzcbv+x/gGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992127; c=relaxed/simple;
	bh=twrniehHJDU1jwW5qLMuRv8Ax6HfQ4zNshA06UFzsKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzMi/Lb01VmnYTaMQS8brr0UHhUZpvF6ITlI9ZuxIMtOK6DvvCWXigwPi5b4b4YH7N4ZJTYb5AyFV2f1Z3di6sky/Q6nM61V84ss3uxk6mL2c4aIdQmR9RDQZ1sBzt79PB0khgaO5EsMXhl4TV7YfGoEWJ8jowx1LGJ354Od8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QV51zt6B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x06kTZu2ohJ92bb9dbh/vRRAY4NzCQZ3OSLPkpWG0KI=; b=QV51zt6B/WhJwt2at7W0x5CIX1
	4lfXEuOWa0uOYx8DmrLR0qh7QEGFN6PXOBCc7g/QVyexDl0ncFLXktyz7FjetZm5NMjX5/ZXv0xMY
	BHbrJBPOS5q4NI8guAdEB57/F0hwaerPSo6mqYMZTO0JIRvKtyEi1MEdWxphoA2cgO9oFZOZibyY+
	3dXOpUN2lm5hkz2UAqrVT0I1mXNddFuT0jyepYOGDsmWPivrZU1iBPH/w44xn5t9wP+CZW3woBQyx
	HuMng+3UjUVi1fcb7hRh7lhHk0L+XUdmevEIa0QOv6H78buhdI397Onq1KyqUMp7Fq2OYHAAozYrO
	Mkew50kA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn9Ct-00000005p84-0K4Y;
	Thu, 21 Mar 2024 03:35:07 +0000
Date: Thu, 21 Mar 2024 03:35:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 11/11] fs: aio: add explicit check for large folio in
 aio_migrate_folio()
Message-ID: <Zfuq6thrgFB8Ty_c@casper.infradead.org>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-12-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321032747.87694-12-wangkefeng.wang@huawei.com>

On Thu, Mar 21, 2024 at 11:27:47AM +0800, Kefeng Wang wrote:
> Since large folio copy could spend lots of time and it is involved with
> a cond_resched(), the aio couldn't support migrate large folio as it takes
> a spin lock when folio copy, add explicit check for large folio and return
> err directly.

This is unnecessary.  aio only allocates order-0 folios (it uses
find_or_create_page() to do it).

If you want to take on converting aio to use folios instead of pages,
that'd be a worthwhile project.

