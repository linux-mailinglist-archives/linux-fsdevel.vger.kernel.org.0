Return-Path: <linux-fsdevel+bounces-26021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6129952917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 07:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07F11C21D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582D176AC5;
	Thu, 15 Aug 2024 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMul+536"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046614373B;
	Thu, 15 Aug 2024 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701557; cv=none; b=Ka/eUcYRgSgPGCGbvI+NO8blXPzjAAZsKaJElklTatLi6fAAMrq4e3sX3Tx9gSSSahlXBcIKVV3Y7dySYZqk06i1c2hcHfZP8+dD/rZiVy/PMfjBMLefO1qfvKtCA0/f65HWzClNyVgRn0sjTU7lTqmnLqcrBKKFJL57HOPEfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701557; c=relaxed/simple;
	bh=nZrX44umNACnJSNfTTA+9S1PzwQ+9fqqaKCap03RRQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVsdjLhOCuqXK7cFuCYpfAl3DCpygb7jrwaGb4ARWERkJlpGTztusXUTo2F/r1YlmP5r21Phb/KxGNOeBn2qT0cp31lUXAtek821cuT7T3UkKUu8dsnhyJU4S3/EcTjdRYAMt7cltmj+ob+ohYbPz4NC6jHWnhDp0dO2g3M7P0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WMul+536; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ru1ApbhwE2IDueiU2tVHH2qGg8YWNB/TaqMyPn2o8Q=; b=WMul+536M5z+dO5jSFNGjfvnwL
	XbkzTDaNfrZNvzv8Zhh9Jmyp9eT+E0DuOpVGdaTvqSyvJsIsJcsP6sbNNAe7CP+bsmbb9RrfWinuZ
	swv+yxWuuBNh3g9aUcqCIGgjqINoklczgEp7Kj7HklVLWhcEvuvr8yRAnmsVOxF8cjE8pP0GrBuHB
	67Y8uxq8jC71O6AuzTe5A1lKQhm0WJfojOqJ2yvc96GdC2sFB552LkRvqNaX8jp/qSCB2vglCzZ/K
	J4GbOH7oSnW00hezuQWMv82l3cGndplMudLaqjdCqTwa6jKRzC2Vo3GZtUAVVGFIn70NDHY/at/Oh
	UE5rEDiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seTVw-0000000982T-12yI;
	Thu, 15 Aug 2024 05:59:12 +0000
Date: Wed, 14 Aug 2024 22:59:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
Message-ID: <Zr2ZMBS_0SC7Sysn@infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
 <ZrxCYbqSHbpKpZjH@infradead.org>
 <7824fcb7-1de9-7435-e9f7-03dd7da6ec0a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7824fcb7-1de9-7435-e9f7-03dd7da6ec0a@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 14, 2024 at 03:49:41PM +0800, Zhang Yi wrote:
> Sorry, this makes me confused. How does this could prevent setting
> redundant dirty bits?
> 
> Suppose we have a 3K regular file on a filesystem with 1K block size.
> In iomap_page_mkwrite(), the iter.len is 3K, if the folio size is 4K,
> folio_mark_dirty() will also mark all 4 bits of ifs dirty. And then,
> if we expand this file size to 4K, and this will still lead to a hole
> with dirty bit set but without any block allocated/reserved. Am I
> missing something?

No, we still need the ifs manipulation in the loop indeed.  But
the filemap_dirty_folio (and the not uptodate warning) can still
move outside the iterator.


