Return-Path: <linux-fsdevel+bounces-57242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D2B1FB51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A133B8805
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA426FDA3;
	Sun, 10 Aug 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5OpqBNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4A1E32B9;
	Sun, 10 Aug 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754846086; cv=none; b=NaBwCF0xdxsOq5wbaBNkRtu6opccrHfs7cQehHRb2x1EZm/23V6oA7hTTe7PE0/ruKWRIFnivlnzTT/rnOAlfMWFZD9R5Q24xqf2vKstjsDeEF5e+AOWatnEfpcWiWKB8uJKENIyLTvE79iRHVa33Fcn/NGlHn3A52Dzhe5vcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754846086; c=relaxed/simple;
	bh=nuaEZLqaF29jbcZjusnG+UIwzzIyCEAkmwA0hD0A+NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOkID+0vNCcoxz816858nTJGGXO4/yuBAqOvfuWPsjHAanCeZVvTAIn1IICK3HKkwc2hyfI5T1z+W+/fnmijl3PWIOFH8aEceBRW4kdybEViwpxbROZTws0S0RRFKer6NOaV76ZPzzf2CVprSijIOvSfOUB4cuEJ2FzUBagRdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5OpqBNY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=734sXD+FLPX9G5Q8Oqch+kt66rWLcQSQY+YqBCv5MGg=; b=O5OpqBNYJSUMetRlR4jEskXQCN
	p0+KJD3k7NUy8opYDwsSzZ1IaZDuMqyQI6En116okXyuW0XET4zbRant55Iks08ShvPzMSNSpMeMM
	lOAdpVJfM04sxRwVr+/d+28BgU3EgOxQtJIxUN2bGbRD9x7d0N+yQU2cMJX5zLxLg/WnKgpIeXvJ3
	2ijHiJ4PiD+eQ/LDNMiilBMgpqIev6sdltpcKDAYLOZOJn7NWM9whFgE41y8tL6iwzDd2ScKTjhjS
	p2RHkMv56Xjnmtt3Lrdf/73jsOiIuoPkQcILi4SysCC0IkZcSV/pBg1IxCJpfmHjoy/XNk+1aD96g
	BpX5Xe5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul9d6-00000005pZm-48Yh;
	Sun, 10 Aug 2025 17:14:44 +0000
Date: Sun, 10 Aug 2025 10:14:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aJjThNwGsrjFtWlg@infradead.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
 <aJiusAtZ-CsnPTOR@infradead.org>
 <aJi9RgOAjXm8Hwlo@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJi9RgOAjXm8Hwlo@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 10, 2025 at 09:39:50AM -0600, Keith Busch wrote:
> > >  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> > > +	if (!bytes)
> > > +		return -EINVAL;
> > 
> > How is this related to the other hunk and the patch description?
> 
> The patchset allows you to submit an io with vectors that are partial
> logical blocks. Misuse could create a bio that exceeds the device max
> vectors or introduces virtual boundary gaps, requiring a split into
> something that is smaller than a block size. This check catches that.
> 
> Quick example: nvme with a 4k logical block size, and the usual 4k
> virtual boundary. Send an io with four vectors iov_len=1k. The total
> size is block sized, but there's no way that could split into a valid
> io. There's a test specifically for this in my reply about xfstests.

Can you turn the above into a comment explaining the check?

