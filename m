Return-Path: <linux-fsdevel+bounces-56345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B2B1626F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4CE1AA30C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51362D97BA;
	Wed, 30 Jul 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G8RNO31V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702C2957AD;
	Wed, 30 Jul 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884861; cv=none; b=pCNkkDWHW4JFrHb8/oiw29hOS20WXM2NtL47466YQtBywMDWSB4BShx5w0mC4myv0/ZucU37bS2in6IqXUcv4+AYMAxnklgvNiNkV9PfLV6T80hNIXsis8h01IuZgygaMvOIm+qtgQrXRIcv5Iv4+D9sUN4jCf0qfa2FAIQUhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884861; c=relaxed/simple;
	bh=gwsGzSAGPEXu4CmFH9bM3rRq7cFN49AEUoHzq0yr63c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZl2N97QwxWMSGV8qFMqalEOm3lNxmtEZNnNXbwr/syYql8aP0vzf86oDEbnftKBVguwoCsbEn/ucyQ2EyAAcNzTvGIB4ndZCl5CEdIo2pAc7vQK6awIsiWcm2gk7xJ+g/B3d8YntACR/jMo86atrygfhDmOANDIWDxxNQgOjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G8RNO31V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7g6iAwZiTiUnLNkvhRAcJnQ/fu6sja7lcOWC+zaEIkg=; b=G8RNO31Vlh/2uRuxwk+HZhw2q+
	UkgVnd263L7FBVZf/fCtCThg6/oSYDZGDvekUf5IZ+ZorvAbHNZRx+KHK0c/5OAaV70i70r+dt3wD
	gZFkvKz7BifOohkj5mZWkGBG+NVDmXJQoU/j08Qyw7jWLkqnehuMkMMUZ9MHKX9jQ0SQ4qAQ7NO4S
	sMrG4h69IuYOdWXM7QQJzmSCsPAehUqPDOcAfKR7gvCUHEEPczMYz1a/HCQlmBN/crNVNQQ1nOqd3
	n++OongKwZd/J1ETggAcJctQ14Tw4Ti5ww1OD+UOgDXJa0r8YmOHrl+o/7pfzONdl3BO4H3kthN4/
	IcLilQIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh7ZS-00000001i0N-1T3s;
	Wed, 30 Jul 2025 14:14:18 +0000
Date: Wed, 30 Jul 2025 07:14:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Message-ID: <aIoouhMhU7VfxYG-@infradead.org>
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 29, 2025 at 12:13:42PM -0400, Tony Battersby wrote:
> Improve writeback performance to RAID-4/5/6 by aligning writes to stripe
> boundaries.  This relies on io_opt being set to the stripe size (or
> a multiple) when BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE is set.

You're not aligning anything.  You are splitting I/O, which is exactly
what we've been trying to avoid by moving to the immutable bio_vec
model that moves the splitting to the place that needs it.

> Benchmark of sequential writing to a large file on XFS using
> io_uring with 8-disk md-raid6:
> Before:      601.0 MB/s
> After:       614.5 MB/s
> Improvement: +2.3%

Looks like you need to do some work on the bio splitting in RAID.
It would help to Cc the maintainers as the driver is actually
pretty actively worked on these days.

