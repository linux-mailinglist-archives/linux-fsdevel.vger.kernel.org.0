Return-Path: <linux-fsdevel+bounces-6174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93FD8145F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B151F23F9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DE1BDDC;
	Fri, 15 Dec 2023 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="17Lw8jJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B81A71C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1lNV0ZPRYDZzpmzlMlwMcCaqwG71TVAv0dgelN3Idcg=; b=17Lw8jJ75hfwTk5cAp/vUNHCq7
	9JEBSVvz2lyoFS+OeEE04qiWB+Q+mzrz+HWwAgqoj53d2L49G0gujvbvMj6XnH6AuIhqngtlPwWMf
	YMgAt0w9Vl5Is1E7ATVJjjKUAoAKqaaFV4ApgIeNbyGc/yqxPI9nvi1X/zIWeKIROp64u3th1nMpz
	IPMmYRH549xx3cF/p9o3vNGzenYUmCdYFULi1pdZF5Hb7JB+FdNNoyeKaxdPFMN5HZB3lp44tG5s2
	T/M1oxrZdtmodFIHy6QBgzS+nshDWstXq+moRp5Or+9hS/YfH46Lzcd6H5hKx0dK9PMHmURddntU2
	yDCIDv4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rE5lT-002pb9-2n;
	Fri, 15 Dec 2023 10:49:55 +0000
Date: Fri, 15 Dec 2023 02:49:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: Why does mpage_writepage() not handle locked buffers?
Message-ID: <ZXwvU2CXEeqxSDgA@infradead.org>
References: <ZXvnmfXG4xN8BQxI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXvnmfXG4xN8BQxI@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 15, 2023 at 05:43:53AM +0000, Matthew Wilcox wrote:
> block_write_full_page() handles this fine, so why isn't this
> 
> 	if (buffer_locked(bh))
> 		goto confused;
> 
> Is the thought that we hold the folio locked, therefore no buffers
> should be locked at this time?  I don't know the rules.

That would be my guess.  For writeback on the fs mapping no one
else should ever have locked the buffer.  For the bdev mapping
buffer locking isn't completely controlled by the bdevfs, but also
by any mounted fs using the buffer cache.  So from my POV your
above change should be ok, but it'll need a big fat comment so
that the next person seeing it in 20 years isn't as confused as
you are now :)


