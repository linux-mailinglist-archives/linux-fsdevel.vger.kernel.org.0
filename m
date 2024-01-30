Return-Path: <linux-fsdevel+bounces-9500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC0841D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C20B25775
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7B54FA9;
	Tue, 30 Jan 2024 08:12:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80957867;
	Tue, 30 Jan 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602377; cv=none; b=eRYJcyEbSnJ4zH+TwT0kyJZFyLEgOAHTmlcweiRkdCtOp+IpDBBsLla3Ms+ey3HeR22lgMOEIT22YgUWwRN+tYI4rQugjNyzJOXAveK5CzSk6xT5qDjz5dAW6pA2qWJb1z5rGHC6zLOtuS/n7whsiBqMhyJrRXhbNIjHzoobvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602377; c=relaxed/simple;
	bh=jls7YOQ72GLvgQHm/mAzjhvRVz1wnpo0H1H1andnvhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaFTCZlKXJzlm1foyZPoOQnRSekVa2ZcgVSvXUJIyK+DSOTIV4DZFNMxeC4AubSFsadsG4fqlmS6henuQDyRgH6LJP2MNEA95u2C57nZaRBi9qyM2ZH1OcgW1qQQpvsrs32EzgLXRPzehgbDOHMJiZQhm5GLyh+KIkQ4QMFqkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F53968C4E; Tue, 30 Jan 2024 09:12:52 +0100 (CET)
Date: Tue, 30 Jan 2024 09:12:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: Introduce buffered_write_operations
Message-ID: <20240130081252.GC22621@lst.de>
References: <20240130055414.2143959-1-willy@infradead.org> <20240130055414.2143959-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130055414.2143959-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +struct buffered_write_operations {
> +	int (*write_begin)(struct file *, struct address_space *mapping,
> +			loff_t pos, size_t len, struct folio **foliop,
> +			void **fsdata);
> +	int (*write_end)(struct file *, struct address_space *mapping,
> +			loff_t pos, size_t len, size_t copied,
> +			struct folio *folio, void **fsdata);
> +};

Should write_begin simply return the folio or an ERR_PTR instead of
the return by reference?

I also wonder if the fsdata paramter should go away - if a fs needs
to pass forth and back fsdata, generic/filemap_perform_write is
probably the wrong abstraction for it.

Otherwise this looks sane to me.

