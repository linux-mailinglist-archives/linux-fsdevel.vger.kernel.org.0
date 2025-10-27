Return-Path: <linux-fsdevel+bounces-65661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDEFC0C021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E6A3B99B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC62C21EA;
	Mon, 27 Oct 2025 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H0uxDnnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BE298CDC;
	Mon, 27 Oct 2025 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548093; cv=none; b=HclaoFwVSgKHfAKiU0gootHERY/TvdNHeAR9OdudJuUm0+UnoIkdupUuQ8jAT+7hg1TR76pefb0amk36c6VRt/yX0c5ayX3amqXPmmv0+1uVTwWa3gH9qskTZB+aGF8HjhMYk+qHvvnoe3ZIWdE9xEuJ6Ln/0lYFScxZqCcQzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548093; c=relaxed/simple;
	bh=HZ1cENyC3OKTlLcokwNqr7wXJ9H0uHel37Dp79dnSVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SirGOKTBdU+mzwm44dycwqN+LkAdZl5qMoTO/3jNMg22UbMmegIrqrd9rEjylv4m6oO0cL3WV6TTeJg+IiiE+4FI236sL/1cxcs2HpEwWZYbrxo0Olw7CYPq79bieky6WmFY/OlF14nfICu+4bv2YZRQQ7+aojng7FqO4+N2nUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H0uxDnnF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HZ1cENyC3OKTlLcokwNqr7wXJ9H0uHel37Dp79dnSVo=; b=H0uxDnnFfGSmqhHOC8bIChmg2U
	zqeyhzXYYeltjfd6s4eSCvSF70/LWP568ahKfzgVEL36melttZ6xkUEonRCPOOtUxFfYSBRpetta+
	C7jrPsmafvNgsoxIx7/8DlYPxU5PJY9qXHXCDW0eoWTxVVCPHBWhfdRrqyjlYhSM5niMX66o9vCB8
	J7qRUYdVoIioFx7orkFpT2m/6CPixRMfzocTeUS/eIX9j6/yvQzDPN05SSmiVgbZX6oI1Wv6FVQ0+
	IUxehKy2s3qD05HoxXBvxki94YTFIG+ro6y75bhoL0D6Pr5Wv9t7QOYZcqZ9EfHhKRnHFPTgiQ6gp
	KHi+loWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDH7p-0000000DEPR-06m6;
	Mon, 27 Oct 2025 06:54:41 +0000
Date: Sun, 26 Oct 2025 23:54:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com,
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com,
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, jack@suse.cz,
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, minchan@kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
Message-ID: <aP8XMZ_DfJEvrNxL@infradead.org>
References: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Sure,

jsut as last time please don't build empires with abstractions that
don't have a single user, and instead directly wire up your CMA variant.
Which actually allows to much more easily review both this submission
and any future MM changes touching it.


