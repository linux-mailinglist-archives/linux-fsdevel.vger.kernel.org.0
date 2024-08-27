Return-Path: <linux-fsdevel+bounces-27307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94C960159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9791C21EA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59EF12FF72;
	Tue, 27 Aug 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Noo+1MQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27A20E6;
	Tue, 27 Aug 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739105; cv=none; b=pouTlUr7K8d5mwSjeT8WAx+HL6BH0/2hZUVDtsFgDUbiKUj4v14UV2OozRSqr/LpQmyVFRdH7/ZA6yLOpCEdVHVj8umrvCoFklPH9i19G5mYdfZJSrgxNHk6NkNEhkoRSKqWtl9DeJ8qkY6r1WQMdbkdkxuNeJtWjfMkj9br8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739105; c=relaxed/simple;
	bh=8ja/d4hVgkWL5VIf717tg90wBtgBjVNrgxgEIUJ2miU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfl9bx02nQC4GSgVbdydvIRbiwTJgd2s1jaKiYOneQqFtWU/CZggSQ5KDsQrpNU0/V5fPtG4RkrpadnWvArHzM2p6Kw5HrSly+F3KODAEJ6CbbjZ3ygjBHGbI8+sqydh8jEgTqjb2wxu+SwpMVv095ooaKvo8j5CRr5tRIT9c/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Noo+1MQI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ydOHnHCRlRXBdmHUv3quLpc+tSab9bHxakBbfIjOVZs=; b=Noo+1MQIrB8RICNQvn0XiIlrfz
	CpRkPqCj4oOEhy0BuBs0WOqUQp4e/epHSpWfrfvcWuGXGnpdMbSL0L6RPOnIzZtaKQiAXa43wI+hk
	Ny57YCri3ncF6eO1LaHWIWjabZeZeoM/278MO6Hb+xlbU3J07KaJC3cueEeGMbbMLEDlLRRgOnRSc
	y/zX2CQJS1gjmGUULRFDXWuSr/vb7PtLx92mG4E2DyzRApItx8nVbFpU3qF+A6WmuN2Ur1Ss4177q
	JXGE6PXzIfHpkTj8a6/uBXrQk0dmSiMgblyg6Bf8Tulo21GzJnAJajNJ1r6uAZZPT0JyY3sycVTzK
	T1ykHoxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sipQc-00000009xyl-3w5y;
	Tue, 27 Aug 2024 06:11:42 +0000
Date: Mon, 26 Aug 2024 23:11:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <Zs1uHoemE7jHQ2bw@infradead.org>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822145910.188974-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 22, 2024 at 10:59:10AM -0400, Brian Foster wrote:
> Note that we also flush for hole mappings because iomap_zero_range()
> is used for partial folio zeroing in some cases. For example, if a
> folio straddles EOF on a sub-page FSB size fs, the post-eof portion
> is hole-backed and dirtied/written via mapped write, and then i_size
> increases before writeback can occur (which otherwise zeroes the
> post-eof portion of the EOF folio), then the folio becomes
> inconsistent with disk until reclaimed.

Eww.  I'm not sure iomap_zero_range is the right way to handle this
even if that's what we have now and it kinda work.

> +	/*
> +	 * We can skip pre-zeroed mappings so long as either the mapping was
> +	 * clean before we started or we've flushed at least once since.
> +	 * Otherwise we don't know whether the current mapping had dirty
> +	 * pagecache, so flush it now, stale the current mapping, and proceed
> +	 * from there.
> +	 */
> +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {

.. at very least the above needs to be documented here as a big fat
reminder, though.

Otherwise the series looks sensible to me.


