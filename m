Return-Path: <linux-fsdevel+bounces-51749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A74ADB097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F8171609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D42DBF52;
	Mon, 16 Jun 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMT6a21J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DC2DBF4E;
	Mon, 16 Jun 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078199; cv=none; b=gp8uOjEvJkgPhWq2RX6kpsy4XScH19cXWRF/YX5eTFckYu5l66HyvdxsPXHt2TEeHPu1ZOjQcp5jOIKHP7QnT0BoE+SUj0Ydg3KUsbrE+d3jJHtFconvelnReAPmGQPfUv1koJ4XPl415DySzYqhzWdENj8HWJBvVzZ73zjaEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078199; c=relaxed/simple;
	bh=e1VVMuy9bECdHPJLedYi+UfLKcsKZt3zb8CEzQHU4RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrb548hnzviuJTFzxCWhkYkc/X/q9GHbSDyI/BsM3BIpy8CW2VpX+my35Ck25bYM1HePYL0YOpwrYNPUi7uhQ0S6YxrF1eHvuPCOa/U+FP/8dRPnS3ePoZFg35/S8CH+Q+cJGP72WdQls1UGaAWv8JcOYAdAQSIq3ePjPbEBJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qMT6a21J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8fFS460Gsw35FDyZ9BeX+wJHJ20lDIAMCxMqlgBvK8Y=; b=qMT6a21JMZt5ut+8qULNEn/BgG
	s00qE6rKSrPyXnioZSlZ7sd/3eRpBv+6CjqIudqbrnziyO2Dvdh4UOZyIFOSaIfx4XxUnZuiPYu3x
	+VM/lq8Fo3PHbx5kymlCnnNGcb8CLgKU0+mbIfL4gaU6grLdYNqXs8MwjiATyT8OOdTqpugRw0SOJ
	Hpu1tVNX39iAeLWKas8K9tT8Rjrp1fqtYuGk46ML18o6YSG5Fdbr2b2xC3LeeZMAhs3oXCFrjR/WS
	HNX8HdNg0/S67Y/9yo8I4WLgdleWrAnfybIv9q3/ihObUzhJq+AHgCXjro8F0Lz7BhrghWnVRd+qH
	wt3EYRcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Hh-00000004QUA-3iN4;
	Mon, 16 Jun 2025 12:49:57 +0000
Date: Mon, 16 Jun 2025 05:49:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, djwong@kernel.org,
	anuj1072538@gmail.com, miklos@szeredi.hu, brauner@kernel.org,
	linux-xfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
Message-ID: <aFAS9SMi1GkqFVg2@infradead.org>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214642.2903225-5-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 02:46:29PM -0700, Joanne Koong wrote:
> Add a wrapper function, iomap_bio_readpage(), around the bio readpage
> logic so that callers that do not have CONFIG_BLOCK set may also use
> iomap for buffered io.

As far as I can tell nothing in this series actually uses the non-block
read path, and I also don't really understand how the current split
would facilitate that.  Can you explain a bit more where this is going?


