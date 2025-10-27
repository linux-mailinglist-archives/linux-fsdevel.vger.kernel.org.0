Return-Path: <linux-fsdevel+bounces-65665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031FC0C330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F91D3A643A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB332E540C;
	Mon, 27 Oct 2025 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJUpwNf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CD2571DA;
	Mon, 27 Oct 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551590; cv=none; b=BcUA7+1ZfEx2d2mZIUQKRsrng+CEzfU5FW9WeIodZ0KHzLaoBnEhAak7tUzqlMkoFWYXY3tn8b4vyHGNwwR0GzEGmoihZBzrGcr+jsEsOUks+rInJzUwTkXgSKPgh869zp6iVUa1zqbxgZS9ZNSTiB8V5f6Ao244z8k2+PsrrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551590; c=relaxed/simple;
	bh=9GnjeSsHnLjkxWo+2Gac2ImmRjomeF/H86D/bFkYed4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4BPoe0/QgjfI+YFHYk04L7t2c0nSg8M5ampEWD7KCsYkdfdBwfNKxdJmFCp04DHbTRmPrQRL4GuAI9Hn0LWvZ78u5h78G0ZLB+4RghhLYhl5BjSTqHII1dSVco9wrQ3dd4POGN0nMb/rOk173aWbi7Xiokd7/0DBzwTdZl/MyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AJUpwNf9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eQOYjhgXpstbmG2nrGPOvbyrXr1clj6Xm04OxT6dSz4=; b=AJUpwNf9IavuUpXVZ0Rh4S+HLt
	tdAYJI8GRFwxDPq01to+ANjmSmsRQ7d5NgiQRRRntxpgg9zsoUcErXaBPKRNRDtI6wxuGPDqB/qtc
	irC58skXOg0UE2+KQAHecdk9QYIHJP6uHPY5R/yUnFIkWV6ppXdtt0YYzGqQyTZXYPFlwy/U5JGoB
	/pPptw0ZK2oRreUsOTnqHHwD1XAkY72kYfJXp7cWjZXWsLi0mSdG1tBWOzh3Hlbkn82zcXXyRlRV9
	fWRwTze94SEDo6CsP6T2cCacZC1kBJqRw5YCvfjCE+89Ycay26BzGhmXQZVSj7SwimqA96PXF+LRu
	5XH6XBNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI2M-0000000DJ3r-2aoI;
	Mon, 27 Oct 2025 07:53:06 +0000
Date: Mon, 27 Oct 2025 00:53:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/10] iomap: Use folio_next_pos()
Message-ID: <aP8k4he6WeFdCnW3@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 06:08:15PM +0100, Matthew Wilcox (Oracle) wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

