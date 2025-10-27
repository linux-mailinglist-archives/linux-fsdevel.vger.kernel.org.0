Return-Path: <linux-fsdevel+bounces-65662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D8C0C070
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688883B001B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EB2DA743;
	Mon, 27 Oct 2025 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DmLfPeX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCF28EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548544; cv=none; b=Cw0C8BXD7i2hlbzH9Hi3SvIHhigdAoUGdLNc23XidOglx1tC/cefHXR+iZRcckH/YHvxxS3myY6E1i9n6suIc9dobw4PmfqbsW1Jg+XzTJJPkkWfbE5hXtH0c59MLf9SlhrLG6ZY0yKTdqhDhSAUyCl0hc7Jqup2FUsg4VUPppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548544; c=relaxed/simple;
	bh=lLGiQXnZuvV/haso6cU6fUkc19eiEThLG31pvwMqYLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqmmsKOIeKPSZ5dmKJg6VZ4X1JAfy3Cm4tnlh824LYsyS0t6Y0oe5zUwjEZrvondvSnJSdwd1ZyIVcNvsMqtq0/HzV5r9KLaUDBBlwOmGKlrov4/ONZ8Nqk23xUnpWKAn1rDRyg4/z5jISZ22fA6JMoA8h0AbMnlNqkPUJMiyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DmLfPeX5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NCV/SIHijOqIDoAiPIZFVuh4eB9bg/tfCPt+H/kiiCc=; b=DmLfPeX5FY6GIyj/KUSspU4PB7
	PsDAy5Tn6AKJa189ub9zbIzPlJQA4khIQJIgjG/fS83yIAEw+rOzHpg0dOTzvIdCTDx2Jxsamulsm
	M8JHsv8MQwepu4awwBEPcuvW9ImPFR/hp5O+1KSZt/XtAA1Fcfgl9WCdP1HZuPkxQJ06+b50sEo34
	e1ZJJ6rBedrT3GXAL73VT+Oq+sLMYTG1Qtre1VyBjK6dOshqaZpKXEcM0ey942RPx3XbQ6DEs8PsG
	zeJA8DQHHNegUGjSYfjN0FH0ZTb+6dQeKqH9lk86la/GmoTBRvdx6Fh97tOuirRbE1LiRlE8QhSUk
	ObmYH94A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHFH-0000000DFBE-0bTd;
	Mon, 27 Oct 2025 07:02:23 +0000
Date: Mon, 27 Oct 2025 00:02:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, bfoster@redhat.com, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix race when reading in all bytes of a folio
Message-ID: <aP8Y_xT94THF-ZeL@infradead.org>
References: <20251024215008.3844068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024215008.3844068-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 02:50:08PM -0700, Joanne Koong wrote:
> There is a race where if all bytes in a folio need to get read in and
> the filesystem finishes reading the bytes in before the call to
> iomap_read_end(), then bytes_accounted in iomap_read_end() will be 0 and
> the following "ifs->read_bytes_pending -= bytes_accounting" will also be
> 0 which will trigger an extra folio_end_read() call. This extra
> folio_end_read() unlocks the folio for the 2nd time, which sets the lock
> bit on the folio, resulting in a permanent lockup.
> 
> Fix this by returning from iomap_read_end() early if all bytes are read
> in by the filesystem.
> 
> Additionally, add some comments to clarify how this accounting logic works.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
> Reported-by: Brian Foster <bfoster@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' branch. It
> would be great if this could get folded up into that original commit, if it's
> not too logistically messy to do so.

Agreed!


