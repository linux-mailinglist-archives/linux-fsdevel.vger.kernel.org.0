Return-Path: <linux-fsdevel+bounces-57304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF88B205CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB75173EB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766F3C465;
	Mon, 11 Aug 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDeDmuQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A732E3706;
	Mon, 11 Aug 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908710; cv=none; b=RjQ+38hC+JAMXWhwrtMtYgfLzCV6f4i5kvukv40MOqGMoawApPEJy4NnVR76VKmeDjVjE9UzYCf7r8aZ8SUtVlc39n0C57FuUOLSWkQz7HOvE7DjUAVaFDvdFtC9lmEr1YEZPYHoEjOFGuxWFMianIAoopnPrX8r3oPqxwY98+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908710; c=relaxed/simple;
	bh=XT2sWOxlbTKT+QPnW9XnWTRN+sHE/dCDzkBJDKrZ2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQiaQ+W3gLLp98y1+XWzyXLIoTZK3XAzY8COmjZehWXdxhnMO/Q3oRSh4KcH70+HKdW9YqH4urflEn7qzZa1nOQpPGFyJ6gSbgogzHis1qiM89wStbuXib/E3RJX1VfRTWVI0kOlDoVAhu1BsJPS2ccCnbtAuDN93ym6QrmIRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GDeDmuQE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OUZ9QvHiTm6LiRxL2YORN5vLL2HMM7pLDxT6NbmKMeY=; b=GDeDmuQEP6ojqOQVXrNVb8L3dW
	mhiEN6g3gKccQ4PBnxYOEgj7YIjiS+z2EAzgLOaGKmebwx3CzvFoGhM9M/5UfAMhe/d6TADsGKLxx
	jXCrDBv0uXzk6NRNAwMuSJtDu1QEhHIZkWlmZwX4UmZPQOylfGGDnXvGDqtLTR6mUaePHZqz4mU6G
	XLOpLS3LiIh5JutjvkTa2iQefEUiwMpNs1kOHymvPBpAcS+nzu4kub/GoyhMxZFWapFK7r4xX+BXk
	cK95Q/R7IlOBq7iadOUmO6TXemwsn28NVgsrux9CG7rN+A47G6P2xw2EV3jchgevIPZBfjSpyZtMf
	0cZIERYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulPuz-00000007Lud-4BS1;
	Mon, 11 Aug 2025 10:38:17 +0000
Date: Mon, 11 Aug 2025 03:38:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2 0/4] iomap: allow partial folio write with
 iomap_folio_state
Message-ID: <aJnIGcIcgjVtZqc3@infradead.org>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810101554.257060-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 10, 2025 at 06:15:50PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> With iomap_folio_state, we can identify uptodate states at the block
> level, and a read_folio reading can correctly handle partially
> uptodate folios.
> 
> Therefore, when a partial write occurs, accept the block-aligned
> partial write instead of rejecting the entire write.

We're not rejecting the entire write, but instead moving on to the
next loop iteration.

> This patchset has been tested by xfstests' generic and xfs group, and
> there's no new failed cases compared to the lastest upstream version kernel.

What is the motivation for this series?  Do you see performance
improvements in a workload you care about?


